package wayland_zwp

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


LINUX_DMABUF_V1_INTERFACE :: "zwp_linux_dmabuf_v1"
LINUX_BUFFER_PARAMS_V1_INTERFACE :: "zwp_linux_buffer_params_v1"
LINUX_DMABUF_FEEDBACK_V1_INTERFACE :: "zwp_linux_dmabuf_feedback_v1"
TABLET_MANAGER_V2_INTERFACE :: "zwp_tablet_manager_v2"
TABLET_SEAT_V2_INTERFACE :: "zwp_tablet_seat_v2"
TABLET_TOOL_V2_INTERFACE :: "zwp_tablet_tool_v2"
TABLET_V2_INTERFACE :: "zwp_tablet_v2"
TABLET_PAD_RING_V2_INTERFACE :: "zwp_tablet_pad_ring_v2"
TABLET_PAD_STRIP_V2_INTERFACE :: "zwp_tablet_pad_strip_v2"
TABLET_PAD_GROUP_V2_INTERFACE :: "zwp_tablet_pad_group_v2"
TABLET_PAD_V2_INTERFACE :: "zwp_tablet_pad_v2"
TABLET_PAD_DIAL_V2_INTERFACE :: "zwp_tablet_pad_dial_v2"

Linux_Buffer_Params_V1_Error :: enum u32 {
	// the dmabuf_batch object has already been used to create a wl_buffer
	Already_Used = 0,
	// plane index out of bounds
	Plane_Idx = 1,
	// the plane index was already set
	Plane_Set = 2,
	// missing or too many planes to create a buffer
	Incomplete = 3,
	// format not supported
	Invalid_Format = 4,
	// invalid width or height
	Invalid_Dimensions = 5,
	// offset + stride * height goes out of dmabuf bounds
	Out_Of_Bounds = 6,
	// invalid wl_buffer resulted from importing dmabufs via the create_immed request on given buffer_params
	Invalid_Wl_Buffer = 7,
}
Linux_Buffer_Params_V1_Flags_Bits :: enum {
	// contents are y-inverted
	Y_Invert = 0,
	// content is interlaced
	Interlaced = 1,
	// bottom field first
	Bottom_First = 2,
}
Linux_Buffer_Params_V1_Flags :: distinct bit_set[Linux_Buffer_Params_V1_Flags_Bits; u32]
Linux_Dmabuf_Feedback_V1_Tranche_Flags_Bits :: enum {
	// direct scan-out tranche
	Scanout = 0,
}
Linux_Dmabuf_Feedback_V1_Tranche_Flags :: distinct bit_set[Linux_Dmabuf_Feedback_V1_Tranche_Flags_Bits; u32]
Tablet_Tool_V2_Type :: enum u32 {
	// Pen
	Pen = 0x140,
	// Eraser
	Eraser = 0x141,
	// Brush
	Brush = 0x142,
	// Pencil
	Pencil = 0x143,
	// Airbrush
	Airbrush = 0x144,
	// Finger
	Finger = 0x145,
	// Mouse
	Mouse = 0x146,
	// Lens
	Lens = 0x147,
}
Tablet_Tool_V2_Capability :: enum u32 {
	// Tilt axes
	Tilt = 1,
	// Pressure axis
	Pressure = 2,
	// Distance axis
	Distance = 3,
	// Z-rotation axis
	Rotation = 4,
	// Slider axis
	Slider = 5,
	// Wheel axis
	Wheel = 6,
}
Tablet_Tool_V2_Button_State :: enum u32 {
	// button is not pressed
	Released = 0,
	// button is pressed
	Pressed = 1,
}
Tablet_Tool_V2_Error :: enum u32 {
	// given wl_surface has another role
	Role = 0,
}
Tablet_V2_Bustype :: enum u32 {
	// USB
	Usb = 3,
	// Bluetooth
	Bluetooth = 5,
	// Virtual
	Virtual = 6,
	// Serial
	Serial = 17,
	// I2C
	I2c = 24,
}
Tablet_Pad_Ring_V2_Source :: enum u32 {
	// finger
	Finger = 1,
}
Tablet_Pad_Strip_V2_Source :: enum u32 {
	// finger
	Finger = 1,
}
Tablet_Pad_V2_Button_State :: enum u32 {
	// the button is not pressed
	Released = 0,
	// the button is pressed
	Pressed = 1,
}

linux_dmabuf_v1_destroy :: proc(connection: ^Connection, linux_dmabuf_v1: Linux_Dmabuf_V1) {
	_size: u16 = 8
	linux_dmabuf_v1 := linux_dmabuf_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_dmabuf_v1, size_of(linux_dmabuf_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_dmabuf_v1@", linux_dmabuf_v1, ".destroy:")
	return
}
linux_dmabuf_v1_create_params :: proc(connection: ^Connection, linux_dmabuf_v1: Linux_Dmabuf_V1) -> (params_id: Linux_Buffer_Params_V1) {
	_size: u16 = 8 + size_of(params_id)
	linux_dmabuf_v1 := linux_dmabuf_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_dmabuf_v1, size_of(linux_dmabuf_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	params_id = auto_cast _generate_id(connection, .Zwp_Linux_Buffer_Params_V1)
	_buffer_write_ptr(&connection.buffer_out, &params_id, size_of(params_id))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_dmabuf_v1@", linux_dmabuf_v1, ".create_params:", " params_id=", params_id)
	return
}
linux_dmabuf_v1_get_default_feedback :: proc(connection: ^Connection, linux_dmabuf_v1: Linux_Dmabuf_V1) -> (id: Linux_Dmabuf_Feedback_V1) {
	_size: u16 = 8 + size_of(id)
	linux_dmabuf_v1 := linux_dmabuf_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_dmabuf_v1, size_of(linux_dmabuf_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Zwp_Linux_Dmabuf_Feedback_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_dmabuf_v1@", linux_dmabuf_v1, ".get_default_feedback:", " id=", id)
	return
}
linux_dmabuf_v1_get_surface_feedback :: proc(connection: ^Connection, linux_dmabuf_v1: Linux_Dmabuf_V1, surface: wl.Surface) -> (id: Linux_Dmabuf_Feedback_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	linux_dmabuf_v1 := linux_dmabuf_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_dmabuf_v1, size_of(linux_dmabuf_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Zwp_Linux_Dmabuf_Feedback_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_dmabuf_v1@", linux_dmabuf_v1, ".get_surface_feedback:", " id=", id, " surface=", surface)
	return
}
linux_buffer_params_v1_destroy :: proc(connection: ^Connection, linux_buffer_params_v1: Linux_Buffer_Params_V1) {
	_size: u16 = 8
	linux_buffer_params_v1 := linux_buffer_params_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_buffer_params_v1, size_of(linux_buffer_params_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_buffer_params_v1@", linux_buffer_params_v1, ".destroy:")
	return
}
linux_buffer_params_v1_add :: proc(connection: ^Connection, linux_buffer_params_v1: Linux_Buffer_Params_V1, fd: Fd, plane_idx: u32, offset: u32, stride: u32, modifier_hi: u32, modifier_lo: u32) {
	_size: u16 = 8 + size_of(plane_idx) + size_of(offset) + size_of(stride) + size_of(modifier_hi) + size_of(modifier_lo)
	linux_buffer_params_v1 := linux_buffer_params_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_buffer_params_v1, size_of(linux_buffer_params_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	append(&connection.fds_out, fd)
	plane_idx := plane_idx
	_buffer_write_ptr(&connection.buffer_out, &plane_idx, size_of(plane_idx))
	offset := offset
	_buffer_write_ptr(&connection.buffer_out, &offset, size_of(offset))
	stride := stride
	_buffer_write_ptr(&connection.buffer_out, &stride, size_of(stride))
	modifier_hi := modifier_hi
	_buffer_write_ptr(&connection.buffer_out, &modifier_hi, size_of(modifier_hi))
	modifier_lo := modifier_lo
	_buffer_write_ptr(&connection.buffer_out, &modifier_lo, size_of(modifier_lo))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_buffer_params_v1@", linux_buffer_params_v1, ".add:", " fd=", fd, " plane_idx=", plane_idx, " offset=", offset, " stride=", stride, " modifier_hi=", modifier_hi, " modifier_lo=", modifier_lo)
	return
}
linux_buffer_params_v1_create :: proc(connection: ^Connection, linux_buffer_params_v1: Linux_Buffer_Params_V1, width: i32, height: i32, format: u32, flags: Linux_Buffer_Params_V1_Flags) {
	_size: u16 = 8 + size_of(width) + size_of(height) + size_of(format) + size_of(flags)
	linux_buffer_params_v1 := linux_buffer_params_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_buffer_params_v1, size_of(linux_buffer_params_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	format := format
	_buffer_write_ptr(&connection.buffer_out, &format, size_of(format))
	flags := flags
	_buffer_write_ptr(&connection.buffer_out, &flags, size_of(flags))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_buffer_params_v1@", linux_buffer_params_v1, ".create:", " width=", width, " height=", height, " format=", format, " flags=", flags)
	return
}
linux_buffer_params_v1_create_immed :: proc(connection: ^Connection, linux_buffer_params_v1: Linux_Buffer_Params_V1, width: i32, height: i32, format: u32, flags: Linux_Buffer_Params_V1_Flags) -> (buffer_id: wl.Buffer) {
	_size: u16 = 8 + size_of(buffer_id) + size_of(width) + size_of(height) + size_of(format) + size_of(flags)
	linux_buffer_params_v1 := linux_buffer_params_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_buffer_params_v1, size_of(linux_buffer_params_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	buffer_id = auto_cast _generate_id(connection, .Wl_Buffer)
	_buffer_write_ptr(&connection.buffer_out, &buffer_id, size_of(buffer_id))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	format := format
	_buffer_write_ptr(&connection.buffer_out, &format, size_of(format))
	flags := flags
	_buffer_write_ptr(&connection.buffer_out, &flags, size_of(flags))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_buffer_params_v1@", linux_buffer_params_v1, ".create_immed:", " buffer_id=", buffer_id, " width=", width, " height=", height, " format=", format, " flags=", flags)
	return
}
linux_dmabuf_feedback_v1_destroy :: proc(connection: ^Connection, linux_dmabuf_feedback_v1: Linux_Dmabuf_Feedback_V1) {
	_size: u16 = 8
	linux_dmabuf_feedback_v1 := linux_dmabuf_feedback_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_dmabuf_feedback_v1, size_of(linux_dmabuf_feedback_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_linux_dmabuf_feedback_v1@", linux_dmabuf_feedback_v1, ".destroy:")
	return
}
tablet_manager_v2_get_tablet_seat :: proc(connection: ^Connection, tablet_manager_v2: Tablet_Manager_V2, seat: wl.Seat) -> (tablet_seat: Tablet_Seat_V2) {
	_size: u16 = 8 + size_of(tablet_seat) + size_of(seat)
	tablet_manager_v2 := tablet_manager_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_manager_v2, size_of(tablet_manager_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	tablet_seat = auto_cast _generate_id(connection, .Zwp_Tablet_Seat_V2)
	_buffer_write_ptr(&connection.buffer_out, &tablet_seat, size_of(tablet_seat))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_manager_v2@", tablet_manager_v2, ".get_tablet_seat:", " tablet_seat=", tablet_seat, " seat=", seat)
	return
}
tablet_manager_v2_destroy :: proc(connection: ^Connection, tablet_manager_v2: Tablet_Manager_V2) {
	_size: u16 = 8
	tablet_manager_v2 := tablet_manager_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_manager_v2, size_of(tablet_manager_v2))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_manager_v2@", tablet_manager_v2, ".destroy:")
	return
}
tablet_seat_v2_destroy :: proc(connection: ^Connection, tablet_seat_v2: Tablet_Seat_V2) {
	_size: u16 = 8
	tablet_seat_v2 := tablet_seat_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_seat_v2, size_of(tablet_seat_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_seat_v2@", tablet_seat_v2, ".destroy:")
	return
}
tablet_tool_v2_set_cursor :: proc(connection: ^Connection, tablet_tool_v2: Tablet_Tool_V2, serial: u32, surface: wl.Surface, hotspot_x: i32, hotspot_y: i32) {
	_size: u16 = 8 + size_of(serial) + size_of(surface) + size_of(hotspot_x) + size_of(hotspot_y)
	tablet_tool_v2 := tablet_tool_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_tool_v2, size_of(tablet_tool_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	hotspot_x := hotspot_x
	_buffer_write_ptr(&connection.buffer_out, &hotspot_x, size_of(hotspot_x))
	hotspot_y := hotspot_y
	_buffer_write_ptr(&connection.buffer_out, &hotspot_y, size_of(hotspot_y))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_tool_v2@", tablet_tool_v2, ".set_cursor:", " serial=", serial, " surface=", surface, " hotspot_x=", hotspot_x, " hotspot_y=", hotspot_y)
	return
}
tablet_tool_v2_destroy :: proc(connection: ^Connection, tablet_tool_v2: Tablet_Tool_V2) {
	_size: u16 = 8
	tablet_tool_v2 := tablet_tool_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_tool_v2, size_of(tablet_tool_v2))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_tool_v2@", tablet_tool_v2, ".destroy:")
	return
}
tablet_v2_destroy :: proc(connection: ^Connection, tablet_v2: Tablet_V2) {
	_size: u16 = 8
	tablet_v2 := tablet_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_v2, size_of(tablet_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_v2@", tablet_v2, ".destroy:")
	return
}
tablet_pad_ring_v2_set_feedback :: proc(connection: ^Connection, tablet_pad_ring_v2: Tablet_Pad_Ring_V2, description: string, serial: u32) {
	_size: u16 = 8 + 4 + u16((len(description) + 1 + 3) & -4) + size_of(serial)
	tablet_pad_ring_v2 := tablet_pad_ring_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_ring_v2, size_of(tablet_pad_ring_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, description)
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_ring_v2@", tablet_pad_ring_v2, ".set_feedback:", " description=", description, " serial=", serial)
	return
}
tablet_pad_ring_v2_destroy :: proc(connection: ^Connection, tablet_pad_ring_v2: Tablet_Pad_Ring_V2) {
	_size: u16 = 8
	tablet_pad_ring_v2 := tablet_pad_ring_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_ring_v2, size_of(tablet_pad_ring_v2))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_ring_v2@", tablet_pad_ring_v2, ".destroy:")
	return
}
tablet_pad_strip_v2_set_feedback :: proc(connection: ^Connection, tablet_pad_strip_v2: Tablet_Pad_Strip_V2, description: string, serial: u32) {
	_size: u16 = 8 + 4 + u16((len(description) + 1 + 3) & -4) + size_of(serial)
	tablet_pad_strip_v2 := tablet_pad_strip_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_strip_v2, size_of(tablet_pad_strip_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, description)
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_strip_v2@", tablet_pad_strip_v2, ".set_feedback:", " description=", description, " serial=", serial)
	return
}
tablet_pad_strip_v2_destroy :: proc(connection: ^Connection, tablet_pad_strip_v2: Tablet_Pad_Strip_V2) {
	_size: u16 = 8
	tablet_pad_strip_v2 := tablet_pad_strip_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_strip_v2, size_of(tablet_pad_strip_v2))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_strip_v2@", tablet_pad_strip_v2, ".destroy:")
	return
}
tablet_pad_group_v2_destroy :: proc(connection: ^Connection, tablet_pad_group_v2: Tablet_Pad_Group_V2) {
	_size: u16 = 8
	tablet_pad_group_v2 := tablet_pad_group_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_group_v2, size_of(tablet_pad_group_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_group_v2@", tablet_pad_group_v2, ".destroy:")
	return
}
tablet_pad_v2_set_feedback :: proc(connection: ^Connection, tablet_pad_v2: Tablet_Pad_V2, button: u32, description: string, serial: u32) {
	_size: u16 = 8 + size_of(button) + 4 + u16((len(description) + 1 + 3) & -4) + size_of(serial)
	tablet_pad_v2 := tablet_pad_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_v2, size_of(tablet_pad_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	button := button
	_buffer_write_ptr(&connection.buffer_out, &button, size_of(button))
	_buffer_write_string(&connection.buffer_out, description)
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_v2@", tablet_pad_v2, ".set_feedback:", " button=", button, " description=", description, " serial=", serial)
	return
}
tablet_pad_v2_destroy :: proc(connection: ^Connection, tablet_pad_v2: Tablet_Pad_V2) {
	_size: u16 = 8
	tablet_pad_v2 := tablet_pad_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_v2, size_of(tablet_pad_v2))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_v2@", tablet_pad_v2, ".destroy:")
	return
}
tablet_pad_dial_v2_set_feedback :: proc(connection: ^Connection, tablet_pad_dial_v2: Tablet_Pad_Dial_V2, description: string, serial: u32) {
	_size: u16 = 8 + 4 + u16((len(description) + 1 + 3) & -4) + size_of(serial)
	tablet_pad_dial_v2 := tablet_pad_dial_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_dial_v2, size_of(tablet_pad_dial_v2))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, description)
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_dial_v2@", tablet_pad_dial_v2, ".set_feedback:", " description=", description, " serial=", serial)
	return
}
tablet_pad_dial_v2_destroy :: proc(connection: ^Connection, tablet_pad_dial_v2: Tablet_Pad_Dial_V2) {
	_size: u16 = 8
	tablet_pad_dial_v2 := tablet_pad_dial_v2
	_buffer_write_ptr(&connection.buffer_out, &tablet_pad_dial_v2, size_of(tablet_pad_dial_v2))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> zwp_tablet_pad_dial_v2@", tablet_pad_dial_v2, ".destroy:")
	return
}

Linux_Dmabuf_V1_Format_Event :: struct {
	object: Linux_Dmabuf_V1,
	format: u32,
}
Linux_Dmabuf_V1_Modifier_Event :: struct {
	object: Linux_Dmabuf_V1,
	format: u32,
	modifier_hi: u32,
	modifier_lo: u32,
}
Linux_Buffer_Params_V1_Created_Event :: struct {
	object: Linux_Buffer_Params_V1,
	buffer: wl.Buffer,
}
Linux_Buffer_Params_V1_Failed_Event :: struct {
	object: Linux_Buffer_Params_V1,
}
Linux_Dmabuf_Feedback_V1_Done_Event :: struct {
	object: Linux_Dmabuf_Feedback_V1,
}
Linux_Dmabuf_Feedback_V1_Format_Table_Event :: struct {
	object: Linux_Dmabuf_Feedback_V1,
	fd: Fd,
	size: u32,
}
Linux_Dmabuf_Feedback_V1_Main_Device_Event :: struct {
	object: Linux_Dmabuf_Feedback_V1,
	device: []byte,
}
Linux_Dmabuf_Feedback_V1_Tranche_Done_Event :: struct {
	object: Linux_Dmabuf_Feedback_V1,
}
Linux_Dmabuf_Feedback_V1_Tranche_Target_Device_Event :: struct {
	object: Linux_Dmabuf_Feedback_V1,
	device: []byte,
}
Linux_Dmabuf_Feedback_V1_Tranche_Formats_Event :: struct {
	object: Linux_Dmabuf_Feedback_V1,
	indices: []byte,
}
Linux_Dmabuf_Feedback_V1_Tranche_Flags_Event :: struct {
	object: Linux_Dmabuf_Feedback_V1,
	flags: Linux_Dmabuf_Feedback_V1_Tranche_Flags,
}
Tablet_Seat_V2_Tablet_Added_Event :: struct {
	object: Tablet_Seat_V2,
	id: Tablet_V2,
}
Tablet_Seat_V2_Tool_Added_Event :: struct {
	object: Tablet_Seat_V2,
	id: Tablet_Tool_V2,
}
Tablet_Seat_V2_Pad_Added_Event :: struct {
	object: Tablet_Seat_V2,
	id: Tablet_Pad_V2,
}
Tablet_Tool_V2_Type_Event :: struct {
	object: Tablet_Tool_V2,
	tool_type: Tablet_Tool_V2_Type,
}
Tablet_Tool_V2_Hardware_Serial_Event :: struct {
	object: Tablet_Tool_V2,
	hardware_serial_hi: u32,
	hardware_serial_lo: u32,
}
Tablet_Tool_V2_Hardware_Id_Wacom_Event :: struct {
	object: Tablet_Tool_V2,
	hardware_id_hi: u32,
	hardware_id_lo: u32,
}
Tablet_Tool_V2_Capability_Event :: struct {
	object: Tablet_Tool_V2,
	capability: Tablet_Tool_V2_Capability,
}
Tablet_Tool_V2_Done_Event :: struct {
	object: Tablet_Tool_V2,
}
Tablet_Tool_V2_Removed_Event :: struct {
	object: Tablet_Tool_V2,
}
Tablet_Tool_V2_Proximity_In_Event :: struct {
	object: Tablet_Tool_V2,
	serial: u32,
	tablet: Tablet_V2,
	surface: wl.Surface,
}
Tablet_Tool_V2_Proximity_Out_Event :: struct {
	object: Tablet_Tool_V2,
}
Tablet_Tool_V2_Down_Event :: struct {
	object: Tablet_Tool_V2,
	serial: u32,
}
Tablet_Tool_V2_Up_Event :: struct {
	object: Tablet_Tool_V2,
}
Tablet_Tool_V2_Motion_Event :: struct {
	object: Tablet_Tool_V2,
	x: f64,
	y: f64,
}
Tablet_Tool_V2_Pressure_Event :: struct {
	object: Tablet_Tool_V2,
	pressure: u32,
}
Tablet_Tool_V2_Distance_Event :: struct {
	object: Tablet_Tool_V2,
	distance: u32,
}
Tablet_Tool_V2_Tilt_Event :: struct {
	object: Tablet_Tool_V2,
	tilt_x: f64,
	tilt_y: f64,
}
Tablet_Tool_V2_Rotation_Event :: struct {
	object: Tablet_Tool_V2,
	degrees: f64,
}
Tablet_Tool_V2_Slider_Event :: struct {
	object: Tablet_Tool_V2,
	position: i32,
}
Tablet_Tool_V2_Wheel_Event :: struct {
	object: Tablet_Tool_V2,
	degrees: f64,
	clicks: i32,
}
Tablet_Tool_V2_Button_Event :: struct {
	object: Tablet_Tool_V2,
	serial: u32,
	button: u32,
	state: Tablet_Tool_V2_Button_State,
}
Tablet_Tool_V2_Frame_Event :: struct {
	object: Tablet_Tool_V2,
	time: u32,
}
Tablet_V2_Name_Event :: struct {
	object: Tablet_V2,
	name: string,
}
Tablet_V2_Id_Event :: struct {
	object: Tablet_V2,
	vid: u32,
	pid: u32,
}
Tablet_V2_Path_Event :: struct {
	object: Tablet_V2,
	path: string,
}
Tablet_V2_Done_Event :: struct {
	object: Tablet_V2,
}
Tablet_V2_Removed_Event :: struct {
	object: Tablet_V2,
}
Tablet_V2_Bustype_Event :: struct {
	object: Tablet_V2,
	bustype: Tablet_V2_Bustype,
}
Tablet_Pad_Ring_V2_Source_Event :: struct {
	object: Tablet_Pad_Ring_V2,
	source: Tablet_Pad_Ring_V2_Source,
}
Tablet_Pad_Ring_V2_Angle_Event :: struct {
	object: Tablet_Pad_Ring_V2,
	degrees: f64,
}
Tablet_Pad_Ring_V2_Stop_Event :: struct {
	object: Tablet_Pad_Ring_V2,
}
Tablet_Pad_Ring_V2_Frame_Event :: struct {
	object: Tablet_Pad_Ring_V2,
	time: u32,
}
Tablet_Pad_Strip_V2_Source_Event :: struct {
	object: Tablet_Pad_Strip_V2,
	source: Tablet_Pad_Strip_V2_Source,
}
Tablet_Pad_Strip_V2_Position_Event :: struct {
	object: Tablet_Pad_Strip_V2,
	position: u32,
}
Tablet_Pad_Strip_V2_Stop_Event :: struct {
	object: Tablet_Pad_Strip_V2,
}
Tablet_Pad_Strip_V2_Frame_Event :: struct {
	object: Tablet_Pad_Strip_V2,
	time: u32,
}
Tablet_Pad_Group_V2_Buttons_Event :: struct {
	object: Tablet_Pad_Group_V2,
	buttons: []byte,
}
Tablet_Pad_Group_V2_Ring_Event :: struct {
	object: Tablet_Pad_Group_V2,
	ring: Tablet_Pad_Ring_V2,
}
Tablet_Pad_Group_V2_Strip_Event :: struct {
	object: Tablet_Pad_Group_V2,
	strip: Tablet_Pad_Strip_V2,
}
Tablet_Pad_Group_V2_Modes_Event :: struct {
	object: Tablet_Pad_Group_V2,
	modes: u32,
}
Tablet_Pad_Group_V2_Done_Event :: struct {
	object: Tablet_Pad_Group_V2,
}
Tablet_Pad_Group_V2_Mode_Switch_Event :: struct {
	object: Tablet_Pad_Group_V2,
	time: u32,
	serial: u32,
	mode: u32,
}
Tablet_Pad_Group_V2_Dial_Event :: struct {
	object: Tablet_Pad_Group_V2,
	dial: Tablet_Pad_Dial_V2,
}
Tablet_Pad_V2_Group_Event :: struct {
	object: Tablet_Pad_V2,
	pad_group: Tablet_Pad_Group_V2,
}
Tablet_Pad_V2_Path_Event :: struct {
	object: Tablet_Pad_V2,
	path: string,
}
Tablet_Pad_V2_Buttons_Event :: struct {
	object: Tablet_Pad_V2,
	buttons: u32,
}
Tablet_Pad_V2_Done_Event :: struct {
	object: Tablet_Pad_V2,
}
Tablet_Pad_V2_Button_Event :: struct {
	object: Tablet_Pad_V2,
	time: u32,
	button: u32,
	state: Tablet_Pad_V2_Button_State,
}
Tablet_Pad_V2_Enter_Event :: struct {
	object: Tablet_Pad_V2,
	serial: u32,
	tablet: Tablet_V2,
	surface: wl.Surface,
}
Tablet_Pad_V2_Leave_Event :: struct {
	object: Tablet_Pad_V2,
	serial: u32,
	surface: wl.Surface,
}
Tablet_Pad_V2_Removed_Event :: struct {
	object: Tablet_Pad_V2,
}
Tablet_Pad_Dial_V2_Delta_Event :: struct {
	object: Tablet_Pad_Dial_V2,
	value120: i32,
}
Tablet_Pad_Dial_V2_Frame_Event :: struct {
	object: Tablet_Pad_Dial_V2,
	time: u32,
}

parse_linux_dmabuf_v1_format :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_V1_Format_Event, ok: bool) {
	event.object = Linux_Dmabuf_V1(object)
	read(connection, &event.format) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_v1@", object, ".format:", " format=", event.format)
	ok = true
	return
}
parse_linux_dmabuf_v1_modifier :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_V1_Modifier_Event, ok: bool) {
	event.object = Linux_Dmabuf_V1(object)
	read(connection, &event.format) or_return
	read(connection, &event.modifier_hi) or_return
	read(connection, &event.modifier_lo) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_v1@", object, ".modifier:", " format=", event.format, " modifier_hi=", event.modifier_hi, " modifier_lo=", event.modifier_lo)
	ok = true
	return
}
parse_linux_buffer_params_v1_created :: proc(connection: ^Connection, object: u32) -> (event: Linux_Buffer_Params_V1_Created_Event, ok: bool) {
	event.object = Linux_Buffer_Params_V1(object)
	read(connection, &event.buffer) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.buffer) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.buffer) - SERVER_ID_START] = .Wl_Buffer
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_buffer_params_v1@", object, ".created:", " buffer=", event.buffer)
	ok = true
	return
}
parse_linux_buffer_params_v1_failed :: proc(connection: ^Connection, object: u32) -> (event: Linux_Buffer_Params_V1_Failed_Event, ok: bool) {
	event.object = Linux_Buffer_Params_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_buffer_params_v1@", object, ".failed:")
	ok = true
	return
}
parse_linux_dmabuf_feedback_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_Feedback_V1_Done_Event, ok: bool) {
	event.object = Linux_Dmabuf_Feedback_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_feedback_v1@", object, ".done:")
	ok = true
	return
}
parse_linux_dmabuf_feedback_v1_format_table :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_Feedback_V1_Format_Table_Event, ok: bool) {
	event.object = Linux_Dmabuf_Feedback_V1(object)
	read_fd(connection, &event.fd) or_return
	read(connection, &event.size) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_feedback_v1@", object, ".format_table:", " fd=", event.fd, " size=", event.size)
	ok = true
	return
}
parse_linux_dmabuf_feedback_v1_main_device :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_Feedback_V1_Main_Device_Event, ok: bool) {
	event.object = Linux_Dmabuf_Feedback_V1(object)
	read(connection, &event.device) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_feedback_v1@", object, ".main_device:", " device=", event.device)
	ok = true
	return
}
parse_linux_dmabuf_feedback_v1_tranche_done :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_Feedback_V1_Tranche_Done_Event, ok: bool) {
	event.object = Linux_Dmabuf_Feedback_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_feedback_v1@", object, ".tranche_done:")
	ok = true
	return
}
parse_linux_dmabuf_feedback_v1_tranche_target_device :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_Feedback_V1_Tranche_Target_Device_Event, ok: bool) {
	event.object = Linux_Dmabuf_Feedback_V1(object)
	read(connection, &event.device) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_feedback_v1@", object, ".tranche_target_device:", " device=", event.device)
	ok = true
	return
}
parse_linux_dmabuf_feedback_v1_tranche_formats :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_Feedback_V1_Tranche_Formats_Event, ok: bool) {
	event.object = Linux_Dmabuf_Feedback_V1(object)
	read(connection, &event.indices) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_feedback_v1@", object, ".tranche_formats:", " indices=", event.indices)
	ok = true
	return
}
parse_linux_dmabuf_feedback_v1_tranche_flags :: proc(connection: ^Connection, object: u32) -> (event: Linux_Dmabuf_Feedback_V1_Tranche_Flags_Event, ok: bool) {
	event.object = Linux_Dmabuf_Feedback_V1(object)
	read(connection, &event.flags) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_linux_dmabuf_feedback_v1@", object, ".tranche_flags:", " flags=", event.flags)
	ok = true
	return
}
parse_tablet_seat_v2_tablet_added :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Seat_V2_Tablet_Added_Event, ok: bool) {
	event.object = Tablet_Seat_V2(object)
	read(connection, &event.id) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.id) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.id) - SERVER_ID_START] = .Zwp_Tablet_V2
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_seat_v2@", object, ".tablet_added:", " id=", event.id)
	ok = true
	return
}
parse_tablet_seat_v2_tool_added :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Seat_V2_Tool_Added_Event, ok: bool) {
	event.object = Tablet_Seat_V2(object)
	read(connection, &event.id) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.id) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.id) - SERVER_ID_START] = .Zwp_Tablet_Tool_V2
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_seat_v2@", object, ".tool_added:", " id=", event.id)
	ok = true
	return
}
parse_tablet_seat_v2_pad_added :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Seat_V2_Pad_Added_Event, ok: bool) {
	event.object = Tablet_Seat_V2(object)
	read(connection, &event.id) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.id) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.id) - SERVER_ID_START] = .Zwp_Tablet_Pad_V2
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_seat_v2@", object, ".pad_added:", " id=", event.id)
	ok = true
	return
}
parse_tablet_tool_v2_type :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Type_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.tool_type) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".type:", " tool_type=", event.tool_type)
	ok = true
	return
}
parse_tablet_tool_v2_hardware_serial :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Hardware_Serial_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.hardware_serial_hi) or_return
	read(connection, &event.hardware_serial_lo) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".hardware_serial:", " hardware_serial_hi=", event.hardware_serial_hi, " hardware_serial_lo=", event.hardware_serial_lo)
	ok = true
	return
}
parse_tablet_tool_v2_hardware_id_wacom :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Hardware_Id_Wacom_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.hardware_id_hi) or_return
	read(connection, &event.hardware_id_lo) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".hardware_id_wacom:", " hardware_id_hi=", event.hardware_id_hi, " hardware_id_lo=", event.hardware_id_lo)
	ok = true
	return
}
parse_tablet_tool_v2_capability :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Capability_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.capability) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".capability:", " capability=", event.capability)
	ok = true
	return
}
parse_tablet_tool_v2_done :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Done_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".done:")
	ok = true
	return
}
parse_tablet_tool_v2_removed :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Removed_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".removed:")
	ok = true
	return
}
parse_tablet_tool_v2_proximity_in :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Proximity_In_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.serial) or_return
	read(connection, &event.tablet) or_return
	read(connection, &event.surface) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".proximity_in:", " serial=", event.serial, " tablet=", event.tablet, " surface=", event.surface)
	ok = true
	return
}
parse_tablet_tool_v2_proximity_out :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Proximity_Out_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".proximity_out:")
	ok = true
	return
}
parse_tablet_tool_v2_down :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Down_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.serial) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".down:", " serial=", event.serial)
	ok = true
	return
}
parse_tablet_tool_v2_up :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Up_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".up:")
	ok = true
	return
}
parse_tablet_tool_v2_motion :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Motion_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".motion:", " x=", event.x, " y=", event.y)
	ok = true
	return
}
parse_tablet_tool_v2_pressure :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Pressure_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.pressure) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".pressure:", " pressure=", event.pressure)
	ok = true
	return
}
parse_tablet_tool_v2_distance :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Distance_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.distance) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".distance:", " distance=", event.distance)
	ok = true
	return
}
parse_tablet_tool_v2_tilt :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Tilt_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.tilt_x) or_return
	read(connection, &event.tilt_y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".tilt:", " tilt_x=", event.tilt_x, " tilt_y=", event.tilt_y)
	ok = true
	return
}
parse_tablet_tool_v2_rotation :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Rotation_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.degrees) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".rotation:", " degrees=", event.degrees)
	ok = true
	return
}
parse_tablet_tool_v2_slider :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Slider_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.position) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".slider:", " position=", event.position)
	ok = true
	return
}
parse_tablet_tool_v2_wheel :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Wheel_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.degrees) or_return
	read(connection, &event.clicks) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".wheel:", " degrees=", event.degrees, " clicks=", event.clicks)
	ok = true
	return
}
parse_tablet_tool_v2_button :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Button_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.serial) or_return
	read(connection, &event.button) or_return
	read(connection, &event.state) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".button:", " serial=", event.serial, " button=", event.button, " state=", event.state)
	ok = true
	return
}
parse_tablet_tool_v2_frame :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Tool_V2_Frame_Event, ok: bool) {
	event.object = Tablet_Tool_V2(object)
	read(connection, &event.time) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_tool_v2@", object, ".frame:", " time=", event.time)
	ok = true
	return
}
parse_tablet_v2_name :: proc(connection: ^Connection, object: u32) -> (event: Tablet_V2_Name_Event, ok: bool) {
	event.object = Tablet_V2(object)
	read(connection, &event.name) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_v2@", object, ".name:", " name=", event.name)
	ok = true
	return
}
parse_tablet_v2_id :: proc(connection: ^Connection, object: u32) -> (event: Tablet_V2_Id_Event, ok: bool) {
	event.object = Tablet_V2(object)
	read(connection, &event.vid) or_return
	read(connection, &event.pid) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_v2@", object, ".id:", " vid=", event.vid, " pid=", event.pid)
	ok = true
	return
}
parse_tablet_v2_path :: proc(connection: ^Connection, object: u32) -> (event: Tablet_V2_Path_Event, ok: bool) {
	event.object = Tablet_V2(object)
	read(connection, &event.path) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_v2@", object, ".path:", " path=", event.path)
	ok = true
	return
}
parse_tablet_v2_done :: proc(connection: ^Connection, object: u32) -> (event: Tablet_V2_Done_Event, ok: bool) {
	event.object = Tablet_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_v2@", object, ".done:")
	ok = true
	return
}
parse_tablet_v2_removed :: proc(connection: ^Connection, object: u32) -> (event: Tablet_V2_Removed_Event, ok: bool) {
	event.object = Tablet_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_v2@", object, ".removed:")
	ok = true
	return
}
parse_tablet_v2_bustype :: proc(connection: ^Connection, object: u32) -> (event: Tablet_V2_Bustype_Event, ok: bool) {
	event.object = Tablet_V2(object)
	read(connection, &event.bustype) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_v2@", object, ".bustype:", " bustype=", event.bustype)
	ok = true
	return
}
parse_tablet_pad_ring_v2_source :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Ring_V2_Source_Event, ok: bool) {
	event.object = Tablet_Pad_Ring_V2(object)
	read(connection, &event.source) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_ring_v2@", object, ".source:", " source=", event.source)
	ok = true
	return
}
parse_tablet_pad_ring_v2_angle :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Ring_V2_Angle_Event, ok: bool) {
	event.object = Tablet_Pad_Ring_V2(object)
	read(connection, &event.degrees) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_ring_v2@", object, ".angle:", " degrees=", event.degrees)
	ok = true
	return
}
parse_tablet_pad_ring_v2_stop :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Ring_V2_Stop_Event, ok: bool) {
	event.object = Tablet_Pad_Ring_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_ring_v2@", object, ".stop:")
	ok = true
	return
}
parse_tablet_pad_ring_v2_frame :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Ring_V2_Frame_Event, ok: bool) {
	event.object = Tablet_Pad_Ring_V2(object)
	read(connection, &event.time) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_ring_v2@", object, ".frame:", " time=", event.time)
	ok = true
	return
}
parse_tablet_pad_strip_v2_source :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Strip_V2_Source_Event, ok: bool) {
	event.object = Tablet_Pad_Strip_V2(object)
	read(connection, &event.source) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_strip_v2@", object, ".source:", " source=", event.source)
	ok = true
	return
}
parse_tablet_pad_strip_v2_position :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Strip_V2_Position_Event, ok: bool) {
	event.object = Tablet_Pad_Strip_V2(object)
	read(connection, &event.position) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_strip_v2@", object, ".position:", " position=", event.position)
	ok = true
	return
}
parse_tablet_pad_strip_v2_stop :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Strip_V2_Stop_Event, ok: bool) {
	event.object = Tablet_Pad_Strip_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_strip_v2@", object, ".stop:")
	ok = true
	return
}
parse_tablet_pad_strip_v2_frame :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Strip_V2_Frame_Event, ok: bool) {
	event.object = Tablet_Pad_Strip_V2(object)
	read(connection, &event.time) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_strip_v2@", object, ".frame:", " time=", event.time)
	ok = true
	return
}
parse_tablet_pad_group_v2_buttons :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Group_V2_Buttons_Event, ok: bool) {
	event.object = Tablet_Pad_Group_V2(object)
	read(connection, &event.buttons) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_group_v2@", object, ".buttons:", " buttons=", event.buttons)
	ok = true
	return
}
parse_tablet_pad_group_v2_ring :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Group_V2_Ring_Event, ok: bool) {
	event.object = Tablet_Pad_Group_V2(object)
	read(connection, &event.ring) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.ring) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.ring) - SERVER_ID_START] = .Zwp_Tablet_Pad_Ring_V2
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_group_v2@", object, ".ring:", " ring=", event.ring)
	ok = true
	return
}
parse_tablet_pad_group_v2_strip :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Group_V2_Strip_Event, ok: bool) {
	event.object = Tablet_Pad_Group_V2(object)
	read(connection, &event.strip) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.strip) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.strip) - SERVER_ID_START] = .Zwp_Tablet_Pad_Strip_V2
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_group_v2@", object, ".strip:", " strip=", event.strip)
	ok = true
	return
}
parse_tablet_pad_group_v2_modes :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Group_V2_Modes_Event, ok: bool) {
	event.object = Tablet_Pad_Group_V2(object)
	read(connection, &event.modes) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_group_v2@", object, ".modes:", " modes=", event.modes)
	ok = true
	return
}
parse_tablet_pad_group_v2_done :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Group_V2_Done_Event, ok: bool) {
	event.object = Tablet_Pad_Group_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_group_v2@", object, ".done:")
	ok = true
	return
}
parse_tablet_pad_group_v2_mode_switch :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Group_V2_Mode_Switch_Event, ok: bool) {
	event.object = Tablet_Pad_Group_V2(object)
	read(connection, &event.time) or_return
	read(connection, &event.serial) or_return
	read(connection, &event.mode) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_group_v2@", object, ".mode_switch:", " time=", event.time, " serial=", event.serial, " mode=", event.mode)
	ok = true
	return
}
parse_tablet_pad_group_v2_dial :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Group_V2_Dial_Event, ok: bool) {
	event.object = Tablet_Pad_Group_V2(object)
	read(connection, &event.dial) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.dial) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.dial) - SERVER_ID_START] = .Zwp_Tablet_Pad_Dial_V2
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_group_v2@", object, ".dial:", " dial=", event.dial)
	ok = true
	return
}
parse_tablet_pad_v2_group :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_V2_Group_Event, ok: bool) {
	event.object = Tablet_Pad_V2(object)
	read(connection, &event.pad_group) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.pad_group) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.pad_group) - SERVER_ID_START] = .Zwp_Tablet_Pad_Group_V2
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_v2@", object, ".group:", " pad_group=", event.pad_group)
	ok = true
	return
}
parse_tablet_pad_v2_path :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_V2_Path_Event, ok: bool) {
	event.object = Tablet_Pad_V2(object)
	read(connection, &event.path) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_v2@", object, ".path:", " path=", event.path)
	ok = true
	return
}
parse_tablet_pad_v2_buttons :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_V2_Buttons_Event, ok: bool) {
	event.object = Tablet_Pad_V2(object)
	read(connection, &event.buttons) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_v2@", object, ".buttons:", " buttons=", event.buttons)
	ok = true
	return
}
parse_tablet_pad_v2_done :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_V2_Done_Event, ok: bool) {
	event.object = Tablet_Pad_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_v2@", object, ".done:")
	ok = true
	return
}
parse_tablet_pad_v2_button :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_V2_Button_Event, ok: bool) {
	event.object = Tablet_Pad_V2(object)
	read(connection, &event.time) or_return
	read(connection, &event.button) or_return
	read(connection, &event.state) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_v2@", object, ".button:", " time=", event.time, " button=", event.button, " state=", event.state)
	ok = true
	return
}
parse_tablet_pad_v2_enter :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_V2_Enter_Event, ok: bool) {
	event.object = Tablet_Pad_V2(object)
	read(connection, &event.serial) or_return
	read(connection, &event.tablet) or_return
	read(connection, &event.surface) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_v2@", object, ".enter:", " serial=", event.serial, " tablet=", event.tablet, " surface=", event.surface)
	ok = true
	return
}
parse_tablet_pad_v2_leave :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_V2_Leave_Event, ok: bool) {
	event.object = Tablet_Pad_V2(object)
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_v2@", object, ".leave:", " serial=", event.serial, " surface=", event.surface)
	ok = true
	return
}
parse_tablet_pad_v2_removed :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_V2_Removed_Event, ok: bool) {
	event.object = Tablet_Pad_V2(object)
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_v2@", object, ".removed:")
	ok = true
	return
}
parse_tablet_pad_dial_v2_delta :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Dial_V2_Delta_Event, ok: bool) {
	event.object = Tablet_Pad_Dial_V2(object)
	read(connection, &event.value120) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_dial_v2@", object, ".delta:", " value120=", event.value120)
	ok = true
	return
}
parse_tablet_pad_dial_v2_frame :: proc(connection: ^Connection, object: u32) -> (event: Tablet_Pad_Dial_V2_Frame_Event, ok: bool) {
	event.object = Tablet_Pad_Dial_V2(object)
	read(connection, &event.time) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- zwp_tablet_pad_dial_v2@", object, ".frame:", " time=", event.time)
	ok = true
	return
}

Linux_Dmabuf_V1 :: distinct u32
Linux_Buffer_Params_V1 :: distinct u32
Linux_Dmabuf_Feedback_V1 :: distinct u32
Tablet_Manager_V2 :: distinct u32
Tablet_Seat_V2 :: distinct u32
Tablet_Tool_V2 :: distinct u32
Tablet_V2 :: distinct u32
Tablet_Pad_Ring_V2 :: distinct u32
Tablet_Pad_Strip_V2 :: distinct u32
Tablet_Pad_Group_V2 :: distinct u32
Tablet_Pad_V2 :: distinct u32
Tablet_Pad_Dial_V2 :: distinct u32

