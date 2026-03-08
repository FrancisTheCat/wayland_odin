package wayland_xdg

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


Wm_Base_Error :: enum u32 {
	// given wl_surface has another role
	Role = 0,
	// xdg_wm_base was destroyed before children
	Defunct_Surfaces = 1,
	// the client tried to map or destroy a non-topmost popup
	Not_The_Topmost_Popup = 2,
	// the client specified an invalid popup parent surface
	Invalid_Popup_Parent = 3,
	// the client provided an invalid surface state
	Invalid_Surface_State = 4,
	// the client provided an invalid positioner
	Invalid_Positioner = 5,
	// the client didn’t respond to a ping event in time
	Unresponsive = 6,
}
Positioner_Error :: enum u32 {
	// invalid input provided
	Invalid_Input = 0,
}
Positioner_Anchor :: enum u32 {
	None = 0,
	Top = 1,
	Bottom = 2,
	Left = 3,
	Right = 4,
	Top_Left = 5,
	Bottom_Left = 6,
	Top_Right = 7,
	Bottom_Right = 8,
}
Positioner_Gravity :: enum u32 {
	None = 0,
	Top = 1,
	Bottom = 2,
	Left = 3,
	Right = 4,
	Top_Left = 5,
	Bottom_Left = 6,
	Top_Right = 7,
	Bottom_Right = 8,
}
Positioner_Constraint_Adjustment_Bits :: enum {
	Slide_X = 0,
	Slide_Y = 1,
	Flip_X = 2,
	Flip_Y = 3,
	Resize_X = 4,
	Resize_Y = 5,
}
Positioner_Constraint_Adjustment :: distinct bit_set[Positioner_Constraint_Adjustment_Bits; u32]
Surface_Error :: enum u32 {
	// Surface was not fully constructed
	Not_Constructed = 1,
	// Surface was already constructed
	Already_Constructed = 2,
	// Attaching a buffer to an unconfigured surface
	Unconfigured_Buffer = 3,
	// Invalid serial number when acking a configure event
	Invalid_Serial = 4,
	// Width or height was zero or negative
	Invalid_Size = 5,
	// Surface was destroyed before its role object
	Defunct_Role_Object = 6,
}
Toplevel_Error :: enum u32 {
	// provided value is not a valid variant of the resize_edge enum
	Invalid_Resize_Edge = 0,
	// invalid parent toplevel
	Invalid_Parent = 1,
	// client provided an invalid min or max size
	Invalid_Size = 2,
}
Toplevel_Resize_Edge :: enum u32 {
	None = 0,
	Top = 1,
	Bottom = 2,
	Left = 4,
	Top_Left = 5,
	Bottom_Left = 6,
	Right = 8,
	Top_Right = 9,
	Bottom_Right = 10,
}
Toplevel_State :: enum u32 {
	// the surface is maximized
	Maximized = 1,
	// the surface is fullscreen
	Fullscreen = 2,
	// the surface is being resized
	Resizing = 3,
	// the surface is now activated
	Activated = 4,
	Tiled_Left = 5,
	Tiled_Right = 6,
	Tiled_Top = 7,
	Tiled_Bottom = 8,
	Suspended = 9,
	Constrained_Left = 10,
	Constrained_Right = 11,
	Constrained_Top = 12,
	Constrained_Bottom = 13,
}
Toplevel_Wm_Capabilities :: enum u32 {
	// show_window_menu is available
	Window_Menu = 1,
	// set_maximized and unset_maximized are available
	Maximize = 2,
	// set_fullscreen and unset_fullscreen are available
	Fullscreen = 3,
	// set_minimized is available
	Minimize = 4,
}
Popup_Error :: enum u32 {
	// tried to grab after being mapped
	Invalid_Grab = 0,
}
Activation_Token_V1_Error :: enum u32 {
	// The token has already been used previously
	Already_Used = 0,
}
Wm_Dialog_V1_Error :: enum u32 {
	// the xdg_toplevel object has already been used to create a xdg_dialog_v1
	Already_Used = 0,
}
Toplevel_Drag_Manager_V1_Error :: enum u32 {
	// data_source already used for toplevel drag
	Invalid_Source = 0,
}
Toplevel_Drag_V1_Error :: enum u32 {
	// valid toplevel already attached
	Toplevel_Attached = 0,
	// drag has not ended
	Ongoing_Drag = 1,
}
Toplevel_Icon_V1_Error :: enum u32 {
	// the provided buffer does not satisfy requirements
	Invalid_Buffer = 1,
	// the icon has already been assigned to a toplevel and must not be changed
	Immutable = 2,
	// the provided buffer has been destroyed before the toplevel icon
	No_Buffer = 3,
}

wm_base_destroy :: proc(connection: ^Connection, wm_base: Wm_Base) {
	_size: u16 = 8
	wm_base := wm_base
	_buffer_write_ptr(&connection.buffer_out, &wm_base, size_of(wm_base))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_wm_base@", wm_base, ".destroy:")
	return
}
wm_base_create_positioner :: proc(connection: ^Connection, wm_base: Wm_Base) -> (id: Positioner) {
	_size: u16 = 8 + size_of(id)
	wm_base := wm_base
	_buffer_write_ptr(&connection.buffer_out, &wm_base, size_of(wm_base))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xdg_Positioner)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_wm_base@", wm_base, ".create_positioner:", " id=", id)
	return
}
wm_base_get_xdg_surface :: proc(connection: ^Connection, wm_base: Wm_Base, surface: wl.Surface) -> (id: Surface) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wm_base := wm_base
	_buffer_write_ptr(&connection.buffer_out, &wm_base, size_of(wm_base))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xdg_Surface)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_wm_base@", wm_base, ".get_xdg_surface:", " id=", id, " surface=", surface)
	return
}
wm_base_pong :: proc(connection: ^Connection, wm_base: Wm_Base, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	wm_base := wm_base
	_buffer_write_ptr(&connection.buffer_out, &wm_base, size_of(wm_base))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_wm_base@", wm_base, ".pong:", " serial=", serial)
	return
}
positioner_destroy :: proc(connection: ^Connection, positioner: Positioner) {
	_size: u16 = 8
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".destroy:")
	return
}
positioner_set_size :: proc(connection: ^Connection, positioner: Positioner, width: i32, height: i32) {
	_size: u16 = 8 + size_of(width) + size_of(height)
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_size:", " width=", width, " height=", height)
	return
}
positioner_set_anchor_rect :: proc(connection: ^Connection, positioner: Positioner, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_anchor_rect:", " x=", x, " y=", y, " width=", width, " height=", height)
	return
}
positioner_set_anchor :: proc(connection: ^Connection, positioner: Positioner, anchor: Positioner_Anchor) {
	_size: u16 = 8 + size_of(anchor)
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	anchor := anchor
	_buffer_write_ptr(&connection.buffer_out, &anchor, size_of(anchor))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_anchor:", " anchor=", anchor)
	return
}
positioner_set_gravity :: proc(connection: ^Connection, positioner: Positioner, gravity: Positioner_Gravity) {
	_size: u16 = 8 + size_of(gravity)
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	gravity := gravity
	_buffer_write_ptr(&connection.buffer_out, &gravity, size_of(gravity))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_gravity:", " gravity=", gravity)
	return
}
positioner_set_constraint_adjustment :: proc(connection: ^Connection, positioner: Positioner, constraint_adjustment: Positioner_Constraint_Adjustment) {
	_size: u16 = 8 + size_of(constraint_adjustment)
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 5
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	constraint_adjustment := constraint_adjustment
	_buffer_write_ptr(&connection.buffer_out, &constraint_adjustment, size_of(constraint_adjustment))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_constraint_adjustment:", " constraint_adjustment=", constraint_adjustment)
	return
}
positioner_set_offset :: proc(connection: ^Connection, positioner: Positioner, x: i32, y: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y)
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 6
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_offset:", " x=", x, " y=", y)
	return
}
positioner_set_reactive :: proc(connection: ^Connection, positioner: Positioner) {
	_size: u16 = 8
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 7
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_reactive:")
	return
}
positioner_set_parent_size :: proc(connection: ^Connection, positioner: Positioner, parent_width: i32, parent_height: i32) {
	_size: u16 = 8 + size_of(parent_width) + size_of(parent_height)
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 8
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	parent_width := parent_width
	_buffer_write_ptr(&connection.buffer_out, &parent_width, size_of(parent_width))
	parent_height := parent_height
	_buffer_write_ptr(&connection.buffer_out, &parent_height, size_of(parent_height))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_parent_size:", " parent_width=", parent_width, " parent_height=", parent_height)
	return
}
positioner_set_parent_configure :: proc(connection: ^Connection, positioner: Positioner, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	opcode: u16 = 9
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_positioner@", positioner, ".set_parent_configure:", " serial=", serial)
	return
}
surface_destroy :: proc(connection: ^Connection, surface: Surface) {
	_size: u16 = 8
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_surface@", surface, ".destroy:")
	return
}
surface_get_toplevel :: proc(connection: ^Connection, surface: Surface) -> (id: Toplevel) {
	_size: u16 = 8 + size_of(id)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xdg_Toplevel)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_surface@", surface, ".get_toplevel:", " id=", id)
	return
}
surface_get_popup :: proc(connection: ^Connection, surface: Surface, parent: Surface, positioner: Positioner) -> (id: Popup) {
	_size: u16 = 8 + size_of(id) + size_of(parent) + size_of(positioner)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xdg_Popup)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	parent := parent
	_buffer_write_ptr(&connection.buffer_out, &parent, size_of(parent))
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_surface@", surface, ".get_popup:", " id=", id, " parent=", parent, " positioner=", positioner)
	return
}
surface_set_window_geometry :: proc(connection: ^Connection, surface: Surface, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_surface@", surface, ".set_window_geometry:", " x=", x, " y=", y, " width=", width, " height=", height)
	return
}
surface_ack_configure :: proc(connection: ^Connection, surface: Surface, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_surface@", surface, ".ack_configure:", " serial=", serial)
	return
}
toplevel_destroy :: proc(connection: ^Connection, toplevel: Toplevel) {
	_size: u16 = 8
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".destroy:")
	return
}
toplevel_set_parent :: proc(connection: ^Connection, toplevel: Toplevel, parent: Toplevel) {
	_size: u16 = 8 + size_of(parent)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	parent := parent
	_buffer_write_ptr(&connection.buffer_out, &parent, size_of(parent))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".set_parent:", " parent=", parent)
	return
}
toplevel_set_title :: proc(connection: ^Connection, toplevel: Toplevel, title: string) {
	_size: u16 = 8 + 4 + u16((len(title) + 1 + 3) & -4)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, title)
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".set_title:", " title=", title)
	return
}
toplevel_set_app_id :: proc(connection: ^Connection, toplevel: Toplevel, app_id: string) {
	_size: u16 = 8 + 4 + u16((len(app_id) + 1 + 3) & -4)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, app_id)
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".set_app_id:", " app_id=", app_id)
	return
}
toplevel_show_window_menu :: proc(connection: ^Connection, toplevel: Toplevel, seat: wl.Seat, serial: u32, x: i32, y: i32) {
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(x) + size_of(y)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".show_window_menu:", " seat=", seat, " serial=", serial, " x=", x, " y=", y)
	return
}
toplevel_move :: proc(connection: ^Connection, toplevel: Toplevel, seat: wl.Seat, serial: u32) {
	_size: u16 = 8 + size_of(seat) + size_of(serial)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 5
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".move:", " seat=", seat, " serial=", serial)
	return
}
toplevel_resize :: proc(connection: ^Connection, toplevel: Toplevel, seat: wl.Seat, serial: u32, edges: Toplevel_Resize_Edge) {
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(edges)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 6
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	edges := edges
	_buffer_write_ptr(&connection.buffer_out, &edges, size_of(edges))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".resize:", " seat=", seat, " serial=", serial, " edges=", edges)
	return
}
toplevel_set_max_size :: proc(connection: ^Connection, toplevel: Toplevel, width: i32, height: i32) {
	_size: u16 = 8 + size_of(width) + size_of(height)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 7
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".set_max_size:", " width=", width, " height=", height)
	return
}
toplevel_set_min_size :: proc(connection: ^Connection, toplevel: Toplevel, width: i32, height: i32) {
	_size: u16 = 8 + size_of(width) + size_of(height)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 8
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".set_min_size:", " width=", width, " height=", height)
	return
}
toplevel_set_maximized :: proc(connection: ^Connection, toplevel: Toplevel) {
	_size: u16 = 8
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 9
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".set_maximized:")
	return
}
toplevel_unset_maximized :: proc(connection: ^Connection, toplevel: Toplevel) {
	_size: u16 = 8
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 10
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".unset_maximized:")
	return
}
toplevel_set_fullscreen :: proc(connection: ^Connection, toplevel: Toplevel, output: wl.Output) {
	_size: u16 = 8 + size_of(output)
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 11
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	output := output
	_buffer_write_ptr(&connection.buffer_out, &output, size_of(output))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".set_fullscreen:", " output=", output)
	return
}
toplevel_unset_fullscreen :: proc(connection: ^Connection, toplevel: Toplevel) {
	_size: u16 = 8
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 12
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".unset_fullscreen:")
	return
}
toplevel_set_minimized :: proc(connection: ^Connection, toplevel: Toplevel) {
	_size: u16 = 8
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	opcode: u16 = 13
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel@", toplevel, ".set_minimized:")
	return
}
popup_destroy :: proc(connection: ^Connection, popup: Popup) {
	_size: u16 = 8
	popup := popup
	_buffer_write_ptr(&connection.buffer_out, &popup, size_of(popup))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_popup@", popup, ".destroy:")
	return
}
popup_grab :: proc(connection: ^Connection, popup: Popup, seat: wl.Seat, serial: u32) {
	_size: u16 = 8 + size_of(seat) + size_of(serial)
	popup := popup
	_buffer_write_ptr(&connection.buffer_out, &popup, size_of(popup))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_popup@", popup, ".grab:", " seat=", seat, " serial=", serial)
	return
}
popup_reposition :: proc(connection: ^Connection, popup: Popup, positioner: Positioner, token: u32) {
	_size: u16 = 8 + size_of(positioner) + size_of(token)
	popup := popup
	_buffer_write_ptr(&connection.buffer_out, &popup, size_of(popup))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	positioner := positioner
	_buffer_write_ptr(&connection.buffer_out, &positioner, size_of(positioner))
	token := token
	_buffer_write_ptr(&connection.buffer_out, &token, size_of(token))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_popup@", popup, ".reposition:", " positioner=", positioner, " token=", token)
	return
}
activation_v1_destroy :: proc(connection: ^Connection, activation_v1: Activation_V1) {
	_size: u16 = 8
	activation_v1 := activation_v1
	_buffer_write_ptr(&connection.buffer_out, &activation_v1, size_of(activation_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_activation_v1@", activation_v1, ".destroy:")
	return
}
activation_v1_get_activation_token :: proc(connection: ^Connection, activation_v1: Activation_V1) -> (id: Activation_Token_V1) {
	_size: u16 = 8 + size_of(id)
	activation_v1 := activation_v1
	_buffer_write_ptr(&connection.buffer_out, &activation_v1, size_of(activation_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xdg_Activation_Token_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_activation_v1@", activation_v1, ".get_activation_token:", " id=", id)
	return
}
activation_v1_activate :: proc(connection: ^Connection, activation_v1: Activation_V1, token: string, surface: wl.Surface) {
	_size: u16 = 8 + 4 + u16((len(token) + 1 + 3) & -4) + size_of(surface)
	activation_v1 := activation_v1
	_buffer_write_ptr(&connection.buffer_out, &activation_v1, size_of(activation_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, token)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_activation_v1@", activation_v1, ".activate:", " token=", token, " surface=", surface)
	return
}
activation_token_v1_set_serial :: proc(connection: ^Connection, activation_token_v1: Activation_Token_V1, serial: u32, seat: wl.Seat) {
	_size: u16 = 8 + size_of(serial) + size_of(seat)
	activation_token_v1 := activation_token_v1
	_buffer_write_ptr(&connection.buffer_out, &activation_token_v1, size_of(activation_token_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_activation_token_v1@", activation_token_v1, ".set_serial:", " serial=", serial, " seat=", seat)
	return
}
activation_token_v1_set_app_id :: proc(connection: ^Connection, activation_token_v1: Activation_Token_V1, app_id: string) {
	_size: u16 = 8 + 4 + u16((len(app_id) + 1 + 3) & -4)
	activation_token_v1 := activation_token_v1
	_buffer_write_ptr(&connection.buffer_out, &activation_token_v1, size_of(activation_token_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, app_id)
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_activation_token_v1@", activation_token_v1, ".set_app_id:", " app_id=", app_id)
	return
}
activation_token_v1_set_surface :: proc(connection: ^Connection, activation_token_v1: Activation_Token_V1, surface: wl.Surface) {
	_size: u16 = 8 + size_of(surface)
	activation_token_v1 := activation_token_v1
	_buffer_write_ptr(&connection.buffer_out, &activation_token_v1, size_of(activation_token_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_activation_token_v1@", activation_token_v1, ".set_surface:", " surface=", surface)
	return
}
activation_token_v1_commit :: proc(connection: ^Connection, activation_token_v1: Activation_Token_V1) {
	_size: u16 = 8
	activation_token_v1 := activation_token_v1
	_buffer_write_ptr(&connection.buffer_out, &activation_token_v1, size_of(activation_token_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_activation_token_v1@", activation_token_v1, ".commit:")
	return
}
activation_token_v1_destroy :: proc(connection: ^Connection, activation_token_v1: Activation_Token_V1) {
	_size: u16 = 8
	activation_token_v1 := activation_token_v1
	_buffer_write_ptr(&connection.buffer_out, &activation_token_v1, size_of(activation_token_v1))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_activation_token_v1@", activation_token_v1, ".destroy:")
	return
}
wm_dialog_v1_destroy :: proc(connection: ^Connection, wm_dialog_v1: Wm_Dialog_V1) {
	_size: u16 = 8
	wm_dialog_v1 := wm_dialog_v1
	_buffer_write_ptr(&connection.buffer_out, &wm_dialog_v1, size_of(wm_dialog_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_wm_dialog_v1@", wm_dialog_v1, ".destroy:")
	return
}
wm_dialog_v1_get_xdg_dialog :: proc(connection: ^Connection, wm_dialog_v1: Wm_Dialog_V1, toplevel: Toplevel) -> (id: Dialog_V1) {
	_size: u16 = 8 + size_of(id) + size_of(toplevel)
	wm_dialog_v1 := wm_dialog_v1
	_buffer_write_ptr(&connection.buffer_out, &wm_dialog_v1, size_of(wm_dialog_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xdg_Dialog_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_wm_dialog_v1@", wm_dialog_v1, ".get_xdg_dialog:", " id=", id, " toplevel=", toplevel)
	return
}
dialog_v1_destroy :: proc(connection: ^Connection, dialog_v1: Dialog_V1) {
	_size: u16 = 8
	dialog_v1 := dialog_v1
	_buffer_write_ptr(&connection.buffer_out, &dialog_v1, size_of(dialog_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_dialog_v1@", dialog_v1, ".destroy:")
	return
}
dialog_v1_set_modal :: proc(connection: ^Connection, dialog_v1: Dialog_V1) {
	_size: u16 = 8
	dialog_v1 := dialog_v1
	_buffer_write_ptr(&connection.buffer_out, &dialog_v1, size_of(dialog_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_dialog_v1@", dialog_v1, ".set_modal:")
	return
}
dialog_v1_unset_modal :: proc(connection: ^Connection, dialog_v1: Dialog_V1) {
	_size: u16 = 8
	dialog_v1 := dialog_v1
	_buffer_write_ptr(&connection.buffer_out, &dialog_v1, size_of(dialog_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_dialog_v1@", dialog_v1, ".unset_modal:")
	return
}
system_bell_v1_destroy :: proc(connection: ^Connection, system_bell_v1: System_Bell_V1) {
	_size: u16 = 8
	system_bell_v1 := system_bell_v1
	_buffer_write_ptr(&connection.buffer_out, &system_bell_v1, size_of(system_bell_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_system_bell_v1@", system_bell_v1, ".destroy:")
	return
}
system_bell_v1_ring :: proc(connection: ^Connection, system_bell_v1: System_Bell_V1, surface: wl.Surface) {
	_size: u16 = 8 + size_of(surface)
	system_bell_v1 := system_bell_v1
	_buffer_write_ptr(&connection.buffer_out, &system_bell_v1, size_of(system_bell_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_system_bell_v1@", system_bell_v1, ".ring:", " surface=", surface)
	return
}
toplevel_drag_manager_v1_destroy :: proc(connection: ^Connection, toplevel_drag_manager_v1: Toplevel_Drag_Manager_V1) {
	_size: u16 = 8
	toplevel_drag_manager_v1 := toplevel_drag_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_drag_manager_v1, size_of(toplevel_drag_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_drag_manager_v1@", toplevel_drag_manager_v1, ".destroy:")
	return
}
toplevel_drag_manager_v1_get_xdg_toplevel_drag :: proc(connection: ^Connection, toplevel_drag_manager_v1: Toplevel_Drag_Manager_V1, data_source: wl.Data_Source) -> (id: Toplevel_Drag_V1) {
	_size: u16 = 8 + size_of(id) + size_of(data_source)
	toplevel_drag_manager_v1 := toplevel_drag_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_drag_manager_v1, size_of(toplevel_drag_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xdg_Toplevel_Drag_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	data_source := data_source
	_buffer_write_ptr(&connection.buffer_out, &data_source, size_of(data_source))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_drag_manager_v1@", toplevel_drag_manager_v1, ".get_xdg_toplevel_drag:", " id=", id, " data_source=", data_source)
	return
}
toplevel_drag_v1_destroy :: proc(connection: ^Connection, toplevel_drag_v1: Toplevel_Drag_V1) {
	_size: u16 = 8
	toplevel_drag_v1 := toplevel_drag_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_drag_v1, size_of(toplevel_drag_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_drag_v1@", toplevel_drag_v1, ".destroy:")
	return
}
toplevel_drag_v1_attach :: proc(connection: ^Connection, toplevel_drag_v1: Toplevel_Drag_V1, toplevel: Toplevel, x_offset: i32, y_offset: i32) {
	_size: u16 = 8 + size_of(toplevel) + size_of(x_offset) + size_of(y_offset)
	toplevel_drag_v1 := toplevel_drag_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_drag_v1, size_of(toplevel_drag_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	x_offset := x_offset
	_buffer_write_ptr(&connection.buffer_out, &x_offset, size_of(x_offset))
	y_offset := y_offset
	_buffer_write_ptr(&connection.buffer_out, &y_offset, size_of(y_offset))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_drag_v1@", toplevel_drag_v1, ".attach:", " toplevel=", toplevel, " x_offset=", x_offset, " y_offset=", y_offset)
	return
}
toplevel_icon_manager_v1_destroy :: proc(connection: ^Connection, toplevel_icon_manager_v1: Toplevel_Icon_Manager_V1) {
	_size: u16 = 8
	toplevel_icon_manager_v1 := toplevel_icon_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_icon_manager_v1, size_of(toplevel_icon_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_icon_manager_v1@", toplevel_icon_manager_v1, ".destroy:")
	return
}
toplevel_icon_manager_v1_create_icon :: proc(connection: ^Connection, toplevel_icon_manager_v1: Toplevel_Icon_Manager_V1) -> (id: Toplevel_Icon_V1) {
	_size: u16 = 8 + size_of(id)
	toplevel_icon_manager_v1 := toplevel_icon_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_icon_manager_v1, size_of(toplevel_icon_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Xdg_Toplevel_Icon_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_icon_manager_v1@", toplevel_icon_manager_v1, ".create_icon:", " id=", id)
	return
}
toplevel_icon_manager_v1_set_icon :: proc(connection: ^Connection, toplevel_icon_manager_v1: Toplevel_Icon_Manager_V1, toplevel: Toplevel, icon: Toplevel_Icon_V1) {
	_size: u16 = 8 + size_of(toplevel) + size_of(icon)
	toplevel_icon_manager_v1 := toplevel_icon_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_icon_manager_v1, size_of(toplevel_icon_manager_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	icon := icon
	_buffer_write_ptr(&connection.buffer_out, &icon, size_of(icon))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_icon_manager_v1@", toplevel_icon_manager_v1, ".set_icon:", " toplevel=", toplevel, " icon=", icon)
	return
}
toplevel_icon_v1_destroy :: proc(connection: ^Connection, toplevel_icon_v1: Toplevel_Icon_V1) {
	_size: u16 = 8
	toplevel_icon_v1 := toplevel_icon_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_icon_v1, size_of(toplevel_icon_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_icon_v1@", toplevel_icon_v1, ".destroy:")
	return
}
toplevel_icon_v1_set_name :: proc(connection: ^Connection, toplevel_icon_v1: Toplevel_Icon_V1, icon_name: string) {
	_size: u16 = 8 + 4 + u16((len(icon_name) + 1 + 3) & -4)
	toplevel_icon_v1 := toplevel_icon_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_icon_v1, size_of(toplevel_icon_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, icon_name)
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_icon_v1@", toplevel_icon_v1, ".set_name:", " icon_name=", icon_name)
	return
}
toplevel_icon_v1_add_buffer :: proc(connection: ^Connection, toplevel_icon_v1: Toplevel_Icon_V1, buffer: wl.Buffer, scale: i32) {
	_size: u16 = 8 + size_of(buffer) + size_of(scale)
	toplevel_icon_v1 := toplevel_icon_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_icon_v1, size_of(toplevel_icon_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	buffer := buffer
	_buffer_write_ptr(&connection.buffer_out, &buffer, size_of(buffer))
	scale := scale
	_buffer_write_ptr(&connection.buffer_out, &scale, size_of(scale))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_icon_v1@", toplevel_icon_v1, ".add_buffer:", " buffer=", buffer, " scale=", scale)
	return
}
toplevel_tag_manager_v1_destroy :: proc(connection: ^Connection, toplevel_tag_manager_v1: Toplevel_Tag_Manager_V1) {
	_size: u16 = 8
	toplevel_tag_manager_v1 := toplevel_tag_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_tag_manager_v1, size_of(toplevel_tag_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_tag_manager_v1@", toplevel_tag_manager_v1, ".destroy:")
	return
}
toplevel_tag_manager_v1_set_toplevel_tag :: proc(connection: ^Connection, toplevel_tag_manager_v1: Toplevel_Tag_Manager_V1, toplevel: Toplevel, tag: string) {
	_size: u16 = 8 + size_of(toplevel) + 4 + u16((len(tag) + 1 + 3) & -4)
	toplevel_tag_manager_v1 := toplevel_tag_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_tag_manager_v1, size_of(toplevel_tag_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	_buffer_write_string(&connection.buffer_out, tag)
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_tag_manager_v1@", toplevel_tag_manager_v1, ".set_toplevel_tag:", " toplevel=", toplevel, " tag=", tag)
	return
}
toplevel_tag_manager_v1_set_toplevel_description :: proc(connection: ^Connection, toplevel_tag_manager_v1: Toplevel_Tag_Manager_V1, toplevel: Toplevel, description: string) {
	_size: u16 = 8 + size_of(toplevel) + 4 + u16((len(description) + 1 + 3) & -4)
	toplevel_tag_manager_v1 := toplevel_tag_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &toplevel_tag_manager_v1, size_of(toplevel_tag_manager_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	toplevel := toplevel
	_buffer_write_ptr(&connection.buffer_out, &toplevel, size_of(toplevel))
	_buffer_write_string(&connection.buffer_out, description)
	if connection.log_fn != nil do _debug_log(connection, "-> xdg_toplevel_tag_manager_v1@", toplevel_tag_manager_v1, ".set_toplevel_description:", " toplevel=", toplevel, " description=", description)
	return
}

Wm_Base_Ping_Event :: struct {
	object: Wm_Base,
	serial: u32,
}
Surface_Configure_Event :: struct {
	object: Surface,
	serial: u32,
}
Toplevel_Configure_Event :: struct {
	object: Toplevel,
	width: i32,
	height: i32,
	states: []byte,
}
Toplevel_Close_Event :: struct {
	object: Toplevel,
}
Toplevel_Configure_Bounds_Event :: struct {
	object: Toplevel,
	width: i32,
	height: i32,
}
Toplevel_Wm_Capabilities_Event :: struct {
	object: Toplevel,
	capabilities: []byte,
}
Popup_Configure_Event :: struct {
	object: Popup,
	x: i32,
	y: i32,
	width: i32,
	height: i32,
}
Popup_Popup_Done_Event :: struct {
	object: Popup,
}
Popup_Repositioned_Event :: struct {
	object: Popup,
	token: u32,
}
Activation_Token_V1_Done_Event :: struct {
	object: Activation_Token_V1,
	token: string,
}
Toplevel_Icon_Manager_V1_Icon_Size_Event :: struct {
	object: Toplevel_Icon_Manager_V1,
	size: i32,
}
Toplevel_Icon_Manager_V1_Done_Event :: struct {
	object: Toplevel_Icon_Manager_V1,
}

parse_wm_base_ping :: proc(connection: ^Connection, object: u32) -> (event: Wm_Base_Ping_Event, ok: bool) {
	event.object = Wm_Base(object)
	read(connection, &event.serial) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_wm_base@", object, ".ping:", " serial=", event.serial)
	ok = true
	return
}
parse_surface_configure :: proc(connection: ^Connection, object: u32) -> (event: Surface_Configure_Event, ok: bool) {
	event.object = Surface(object)
	read(connection, &event.serial) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_surface@", object, ".configure:", " serial=", event.serial)
	ok = true
	return
}
parse_toplevel_configure :: proc(connection: ^Connection, object: u32) -> (event: Toplevel_Configure_Event, ok: bool) {
	event.object = Toplevel(object)
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	read(connection, &event.states) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_toplevel@", object, ".configure:", " width=", event.width, " height=", event.height, " states=", event.states)
	ok = true
	return
}
parse_toplevel_close :: proc(connection: ^Connection, object: u32) -> (event: Toplevel_Close_Event, ok: bool) {
	event.object = Toplevel(object)
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_toplevel@", object, ".close:")
	ok = true
	return
}
parse_toplevel_configure_bounds :: proc(connection: ^Connection, object: u32) -> (event: Toplevel_Configure_Bounds_Event, ok: bool) {
	event.object = Toplevel(object)
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_toplevel@", object, ".configure_bounds:", " width=", event.width, " height=", event.height)
	ok = true
	return
}
parse_toplevel_wm_capabilities :: proc(connection: ^Connection, object: u32) -> (event: Toplevel_Wm_Capabilities_Event, ok: bool) {
	event.object = Toplevel(object)
	read(connection, &event.capabilities) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_toplevel@", object, ".wm_capabilities:", " capabilities=", event.capabilities)
	ok = true
	return
}
parse_popup_configure :: proc(connection: ^Connection, object: u32) -> (event: Popup_Configure_Event, ok: bool) {
	event.object = Popup(object)
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_popup@", object, ".configure:", " x=", event.x, " y=", event.y, " width=", event.width, " height=", event.height)
	ok = true
	return
}
parse_popup_popup_done :: proc(connection: ^Connection, object: u32) -> (event: Popup_Popup_Done_Event, ok: bool) {
	event.object = Popup(object)
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_popup@", object, ".popup_done:")
	ok = true
	return
}
parse_popup_repositioned :: proc(connection: ^Connection, object: u32) -> (event: Popup_Repositioned_Event, ok: bool) {
	event.object = Popup(object)
	read(connection, &event.token) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_popup@", object, ".repositioned:", " token=", event.token)
	ok = true
	return
}
parse_activation_token_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Activation_Token_V1_Done_Event, ok: bool) {
	event.object = Activation_Token_V1(object)
	read(connection, &event.token) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_activation_token_v1@", object, ".done:", " token=", event.token)
	ok = true
	return
}
parse_toplevel_icon_manager_v1_icon_size :: proc(connection: ^Connection, object: u32) -> (event: Toplevel_Icon_Manager_V1_Icon_Size_Event, ok: bool) {
	event.object = Toplevel_Icon_Manager_V1(object)
	read(connection, &event.size) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_toplevel_icon_manager_v1@", object, ".icon_size:", " size=", event.size)
	ok = true
	return
}
parse_toplevel_icon_manager_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Toplevel_Icon_Manager_V1_Done_Event, ok: bool) {
	event.object = Toplevel_Icon_Manager_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- xdg_toplevel_icon_manager_v1@", object, ".done:")
	ok = true
	return
}

Wm_Base :: distinct u32
Positioner :: distinct u32
Surface :: distinct u32
Toplevel :: distinct u32
Popup :: distinct u32
Activation_V1 :: distinct u32
Activation_Token_V1 :: distinct u32
Wm_Dialog_V1 :: distinct u32
Dialog_V1 :: distinct u32
System_Bell_V1 :: distinct u32
Toplevel_Drag_Manager_V1 :: distinct u32
Toplevel_Drag_V1 :: distinct u32
Toplevel_Icon_Manager_V1 :: distinct u32
Toplevel_Icon_V1 :: distinct u32
Toplevel_Tag_Manager_V1 :: distinct u32

