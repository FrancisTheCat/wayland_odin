package wayland

import "base:intrinsics"

import "core:sys/linux"

import "core:slice"
import "core:fmt"

WAYLAND_DEBUG_LOG   :: #config(WAYLAND_DEBUG_LOG, ODIN_DEBUG)
WAYLAND_BUFFER_SIZE :: #config(WAYLAND_BUFFER_SIZE, 1 << 12)

Fd     :: linux.Fd
Object :: distinct u32

SERVER_ID_START :: 0xFF000000

Connection :: struct {
	buffer_out:          [dynamic]byte,
	buffer_in:           []byte,
	start_in, end_in:    int,
	client_object_types: [dynamic]Object_Type,
	server_object_types: [dynamic]Object_Type,
	fds_in:              [dynamic]Fd,
	fds_out:             [dynamic]Fd,
	free_ids:            [dynamic]u32,
	socket:              linux.Fd,
	log_fn:              proc(message: string, user_data: rawptr),
	user_data:           rawptr,
}

@(require_results)
generate_id :: proc(connection: ^Connection, type: Object_Type) -> u32 {
	id: u32
	if len(connection.free_ids) != 0 {
		id = pop(&connection.free_ids)
		connection.client_object_types[id] = type
	} else {
		id = u32(len(connection.client_object_types))
		append(&connection.client_object_types, type)
	}
	return id
}

connection_flush :: proc(connection: ^Connection) {
	msg := linux.Msg_Hdr {
		iov = {
			{
				base = raw_data(connection.buffer_out),
				len  = len(connection.buffer_out),
			},
		},
		control = make([]byte, 16 + ((len(connection.fds_out) + 7) & -8) * 4, context.temp_allocator),
	}

	hdr      := cast(^struct { len: u64, level, type: i32 })raw_data(msg.control)
	hdr.len   = u64(len(msg.control))
	hdr.level = i32(linux.SOL_SOCKET)
	hdr.type  = 1

	copy(msg.control[16:], slice.to_bytes(connection.fds_out[:]))

	_, errno := linux.sendmsg(connection.socket, &msg, { .CMSG_CLOEXEC, .NOSIGNAL, })
	if errno == .EAGAIN {
		return
	}
	assert(errno == .NONE)

	clear(&connection.buffer_out)
	clear(&connection.fds_out)
}

@(require_results)
display_connect :: proc(
	socket: linux.Fd,
	allocator := context.allocator,
	log_fn: proc(message: string, user_data: rawptr) = nil,
	user_data: rawptr = nil,
) -> (connection: Connection, display: Display) {
	connection.socket                 = socket
	connection.buffer_in              = make([]byte, WAYLAND_BUFFER_SIZE, allocator)
	connection.fds_in                 = make([dynamic]linux.Fd,           allocator)
	connection.fds_out                = make([dynamic]linux.Fd,           allocator)
	connection.free_ids               = make([dynamic]u32,                allocator)
	connection.server_object_types    = make([dynamic]Object_Type,        allocator)
	connection.client_object_types    = make([dynamic]Object_Type, 2,     allocator)
	connection.client_object_types[1] = .Display
	connection.log_fn                 = log_fn
	connection.user_data              = user_data
	display                           = 1
	return
}

connection_destroy :: proc(connection: Connection) {
	delete(connection.buffer_in, connection.buffer_out.allocator)
	delete(connection.buffer_out)
	delete(connection.client_object_types)
	delete(connection.server_object_types)
	delete(connection.fds_in)
	delete(connection.fds_out)
	delete(connection.free_ids)
}

connection_poll :: proc(connection: ^Connection) {
	copy(connection.buffer_in, connection.buffer_in[connection.start_in:connection.end_in])
	connection.end_in   = connection.end_in - connection.start_in
	connection.start_in = 0

	msg: linux.Msg_Hdr = {
		iov     = { transmute(linux.IO_Vec)connection.buffer_in[connection.end_in:], },
		control = make([]byte, 16 + 8 * 4, context.temp_allocator),
	}
	hdr      := cast(^struct { len: u64, level, type: i32 })raw_data(msg.control)
	hdr.len   = u64(len(msg.control))
	hdr.level = i32(linux.SOL_SOCKET)
	hdr.type  = 1
	n, errno := linux.recvmsg(connection.socket, &msg, { .CMSG_CLOEXEC, .NOSIGNAL, })
	if errno != nil {
		return
	}
	connection.end_in += n
	if len(msg.control) != 0 {
		append(&connection.fds_in, ..slice.reinterpret([]Fd, msg.control[size_of(hdr^):]))
	}
	assert(errno == .NONE || errno == .EAGAIN)
}

@(require_results)
peek_event :: proc(connection: ^Connection) -> (event: Event, ok: bool) {
	for {
		event, ok = _peek_event(connection)
		if !ok {
			return
		}
		if deleted, ok := event.(Event_Display_Delete_Id); ok {
			append(&connection.free_ids, deleted.id)
		} else {
			return
		}
	}
}

@(require_results)
_peek_event :: proc(connection: ^Connection) -> (event: Event, ok: bool) {
	if connection.end_in - connection.start_in < 8 {
		return
	}

	object: u32
	intrinsics.mem_copy(&object, &connection.buffer_in[connection.start_in], 4)
	opcode, size: u16
	intrinsics.mem_copy(&opcode, &connection.buffer_in[connection.start_in + 4], 2)
	intrinsics.mem_copy(&size,   &connection.buffer_in[connection.start_in + 6], 2)

	assert(int(size) <= len(connection.buffer_in))
	assert(size % 4 == 0)
	assert(size >= 8)

	if connection.end_in - connection.start_in < int(size) {
		return
	}

	object_type: Object_Type
	if int(object) >= SERVER_ID_START {
		object := object - SERVER_ID_START
		if int(object) >= len(connection.server_object_types) {
			return
		}
		object_type = connection.server_object_types[object]
	} else {
		if int(object) >= len(connection.client_object_types) {
			return
		}
		object_type = connection.client_object_types[object]
	}

	prev_start := connection.start_in
	defer if !ok {
		connection.start_in = prev_start
	}

	connection.start_in += 8
	return parse_event(connection, object, object_type, u32(opcode))
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
	intrinsics.mem_copy(&value, &connection.buffer_in[connection.start_in], size_of(value))
	connection.start_in += 4
	data^ = transmute(T)value
	return true
}

read_f64 :: proc(connection: ^Connection, data: ^f64) -> bool {
	value: bit_field u32 {
		integer: i32 | 24,
		decimal: i32 | 8,
	}
	intrinsics.mem_copy(&value, &connection.buffer_in[connection.start_in], size_of(value))
	connection.start_in += 4
	data^ = f64(value.integer) + f64(value.decimal) / 256.0
	return true
}

read_array :: proc(connection: ^Connection, data: ^[]byte) -> bool {
	length: i32
	intrinsics.mem_copy(&length, &connection.buffer_in[connection.start_in], size_of(length))
	connection.start_in += 4
	data^ = connection.buffer_in[connection.start_in:][:length]
	connection.start_in = (connection.start_in + int(length) + 3) & -4
	return true
}

read_string :: proc(connection: ^Connection, data: ^string) -> bool {
	length: i32
	intrinsics.mem_copy(&length, &connection.buffer_in[connection.start_in], size_of(length))
	connection.start_in += 4
	data^ = string(connection.buffer_in[connection.start_in:][:length - 1])
	connection.start_in = (connection.start_in + int(length) + 3) & -4
	return true
}

@(disabled = !WAYLAND_DEBUG_LOG)
_debug_log :: proc(connection: ^Connection, args: ..any) {
	connection.log_fn(fmt.tprint(..args, sep = ""), connection.user_data)
}

_buffer_write_ptr :: proc(buffer: ^[dynamic]byte, pointer: rawptr, size: int) {
	append(buffer, ..([^]byte)(pointer)[:size])
}

_buffer_write_string :: proc(buffer: ^[dynamic]byte, str: string) {
	l := u32(len(str)) + 1
	_buffer_write_ptr(buffer, &l, size_of(l))
	append(buffer, ..transmute([]byte)(str))
	for _ in len(str) ..< (len(str) + 1 + 3) & -4 do append(buffer, 0)
	assert(len(buffer) % 4 == 0)
}
