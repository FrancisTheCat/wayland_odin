package wayland_xwayland

import "base:intrinsics"

import "../common"

import "../wl"

Connection           :: common.Connection
Fd                   :: common.Fd
Object               :: common.Object
Object_Type          :: common.Object_Type

SERVER_ID_START      :: common.SERVER_ID_START

_buffer_write_ptr    :: common._buffer_write_ptr
_buffer_write_string :: common._buffer_write_string
_generate_id         :: common._generate_id
_debug_log           :: common._debug_log
read                 :: common.read
read_fd              :: common.read_fd

resolve_type: proc(t: typeid, interface: string, location := #caller_location) -> (type: Object_Type)


SHELL_V1_INTERFACE :: "xwayland_shell_v1"
SURFACE_V1_INTERFACE :: "xwayland_surface_v1"

Shell_V1_Error :: enum u32 {
	// given wl_surface has another role
	Role = 0,
}
Surface_V1_Error :: enum u32 {
	// given wl_surface is already associated with an X11 window
	Already_Associated = 0,
	// serial was not valid
	Invalid_Serial = 1,
}

shell_v1_destroy :: proc(connection: ^Connection, shell_v1: Shell_V1) {
	_size: u16 = 8
	shell_v1 := shell_v1
	_buffer_write_ptr(&connection.buffer_out, &shell_v1, size_of(shell_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xwayland_shell_v1@", shell_v1, ".destroy:")
	return
}
shell_v1_get_xwayland_surface :: proc(connection: ^Connection, shell_v1: Shell_V1, surface: wl.Surface) -> (id: Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	shell_v1 := shell_v1
	_buffer_write_ptr(&connection.buffer_out, &shell_v1, size_of(shell_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xwayland_Surface_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> xwayland_shell_v1@", shell_v1, ".get_xwayland_surface:", " id=", id, " surface=", surface)
	return
}
surface_v1_set_serial :: proc(connection: ^Connection, surface_v1: Surface_V1, serial_lo: u32, serial_hi: u32) {
	_size: u16 = 8 + size_of(serial_lo) + size_of(serial_hi)
	surface_v1 := surface_v1
	_buffer_write_ptr(&connection.buffer_out, &surface_v1, size_of(surface_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial_lo := serial_lo
	_buffer_write_ptr(&connection.buffer_out, &serial_lo, size_of(serial_lo))
	serial_hi := serial_hi
	_buffer_write_ptr(&connection.buffer_out, &serial_hi, size_of(serial_hi))
	if connection.log_fn != nil do _debug_log(connection, "-> xwayland_surface_v1@", surface_v1, ".set_serial:", " serial_lo=", serial_lo, " serial_hi=", serial_hi)
	return
}
surface_v1_destroy :: proc(connection: ^Connection, surface_v1: Surface_V1) {
	_size: u16 = 8
	surface_v1 := surface_v1
	_buffer_write_ptr(&connection.buffer_out, &surface_v1, size_of(surface_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xwayland_surface_v1@", surface_v1, ".destroy:")
	return
}



Shell_V1 :: distinct u32
Surface_V1 :: distinct u32

