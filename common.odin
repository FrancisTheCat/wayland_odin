package wayland

import "base:intrinsics"

import "core:sys/linux"

import "core:bytes"
import "core:os"
import "core:slice"

Fd     :: os.Handle
Object :: distinct u32

Connection :: struct {
	buffer:       bytes.Buffer,
	data:         []byte,
	data_cursor:  int,
	object_types: map[u32]Object_Type,
	fds_in:       [dynamic]Fd,
	fds_out:      [dynamic]Fd,
	free_ids:     [dynamic]u32,
	next_id:      u32,
	socket:       linux.Fd,
}

@(require_results)
generate_id :: proc(connection: ^Connection, type: Object_Type) -> (id: u32) {
	if len(connection.free_ids) > 0 {
		id = pop(&connection.free_ids)
		connection.object_types[id] = type
	} else {
		id = connection.next_id
		connection.object_types[id] = type
		connection.next_id += 1
	}
	return
}

connection_flush :: proc(connection: ^Connection) {
	msg := linux.Msg_Hdr {
		iov = {
			{
				base = raw_data(connection.buffer.buf),
				len  = len(connection.buffer.buf),
			},
		},
		control = make([]byte, 16 + ((len(connection.fds_out) + 7) & -8) * 4, context.temp_allocator),
	}

	hdr      := cast(^struct { len: u64, level, type: i32 })raw_data(msg.control)
	hdr.len   = u64(len(msg.control))
	hdr.level = i32(linux.SOL_SOCKET)
	hdr.type  = 1

	copy(msg.control[16:], slice.to_bytes(connection.fds_out[:]))

	n, errno := linux.sendmsg(connection.socket, &msg, { .CMSG_CLOEXEC, .NOSIGNAL, })
	assert(errno == .NONE)

	bytes.buffer_reset(&connection.buffer)
	connection.data_cursor = 0
}

@(require_results)
display_connect :: proc(socket: linux.Fd, allocator := context.allocator) -> (connection: Connection, display: Display) {
	connection.socket                 = socket
	connection.fds_in.allocator       = allocator
	connection.fds_out.allocator      = allocator
	connection.free_ids.allocator     = allocator

	connection.object_types.allocator = allocator
	connection.object_types[1]        = .Display
	connection.next_id                = 2
	display                           = 1

	return
}

connection_poll :: proc(connection: ^Connection, buffer: []byte) {
	msg: linux.Msg_Hdr = {
		iov = { transmute(linux.IO_Vec)buffer, },
	}
	n, errno := linux.recvmsg(connection.socket, &msg, { .CMSG_CLOEXEC, .NOSIGNAL, })
	connection.data = buffer[:n]
	assert(errno == .NONE || errno == .EAGAIN)
}

@(require_results)
peek_event :: proc(connection: ^Connection) -> (object: u32, event: Event, ok: bool) {
	for {
		object, event, ok = _peek_event(connection)
		if !ok {
			return
		}
		if deleted, ok := event.(Event_Display_Delete_Id); ok {
			delete_key(&connection.object_types, deleted.id)
			append(&connection.free_ids, deleted.id)
		} else {
			return
		}
	}
}

@(require_results)
_peek_event :: proc(connection: ^Connection) -> (object: u32, event: Event, ok: bool) {
	if len(connection.data) - connection.data_cursor < 8 {
		return
	}
	intrinsics.mem_copy(&object, &connection.data[connection.data_cursor], 4)
	opcode, size: u16
	intrinsics.mem_copy(&opcode, &connection.data[connection.data_cursor + 4], 2)
	intrinsics.mem_copy(&size,   &connection.data[connection.data_cursor + 6], 2)
	if len(connection.data) - connection.data_cursor < int(size) {
		return
	}
	connection.data_cursor += 8
	return object, parse_event(connection, connection.object_types[object], u32(opcode))
}

read :: proc {
	read_fd,
	read_int,
	read_f64,
	read_array,
	read_string,
}

read_fd :: proc(connection: ^Connection, data: ^Fd) -> bool {
	data^ = pop_front_safe(&connection.fds_in) or_return
	return true
}

read_int :: proc(connection: ^Connection, data: ^$T) -> bool where intrinsics.type_is_integer(T) || intrinsics.type_is_enum(T) || intrinsics.type_is_bit_set(T) {
	value: u32
	intrinsics.mem_copy(&value, &connection.data[connection.data_cursor], size_of(value))
	connection.data_cursor += 4
	data^ = transmute(T)value
	return true
}

read_f64 :: proc(connection: ^Connection, data: ^f64) -> bool {
	value: bit_field u32 {
		integer: i32 | 24,
		decimal: i32 | 8,
	}
	intrinsics.mem_copy(&value, &connection.data[connection.data_cursor], size_of(value))
	connection.data_cursor += 4
	data^ = f64(value.integer) + f64(value.decimal) / 256.0
	return true
}

read_array :: proc(connection: ^Connection, data: ^[]byte) -> bool {
	length: i32
	intrinsics.mem_copy(&length, &connection.data[connection.data_cursor], size_of(length))
	connection.data_cursor += 4
	data^ = connection.data[connection.data_cursor:][:length]
	connection.data_cursor = (connection.data_cursor + int(length) + 3) & -4
	return true
}

read_string :: proc(connection: ^Connection, data: ^string) -> bool {
	length: i32
	intrinsics.mem_copy(&length, &connection.data[connection.data_cursor], size_of(length))
	connection.data_cursor += 4
	data^ = string(connection.data[connection.data_cursor:][:length - 1])
	connection.data_cursor = (connection.data_cursor + int(length) + 3) & -4
	return true
}
