package wayland_common

import "base:intrinsics"

import "core:sys/linux"

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
_generate_id :: proc(connection: ^Connection, type: Object_Type) -> u32 {
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
		decimal: i32 | 8,
		integer: i32 | 24,
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
