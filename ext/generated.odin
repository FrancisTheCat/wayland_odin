package wayland_ext

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


Background_Effect_Manager_V1_Error :: enum u32 {
	// the surface already has a background effect object
	Background_Effect_Exists = 0,
}
Background_Effect_Manager_V1_Capability_Bits :: enum {
	// the compositor supports applying blur
	Blur = 0,
}
Background_Effect_Manager_V1_Capability :: distinct bit_set[Background_Effect_Manager_V1_Capability_Bits; u32]
Background_Effect_Surface_V1_Error :: enum u32 {
	// the associated surface has been destroyed
	Surface_Destroyed = 0,
}
Data_Control_Device_V1_Error :: enum u32 {
	// source given to set_selection or set_primary_selection was already used before
	Used_Source = 1,
}
Data_Control_Source_V1_Error :: enum u32 {
	// offer sent after ext_data_control_device.set_selection
	Invalid_Offer = 1,
}
Image_Copy_Capture_Manager_V1_Error :: enum u32 {
	// invalid option flag
	Invalid_Option = 1,
}
Image_Copy_Capture_Manager_V1_Options_Bits :: enum {
	// paint cursors onto captured frames
	Paint_Cursors = 0,
}
Image_Copy_Capture_Manager_V1_Options :: distinct bit_set[Image_Copy_Capture_Manager_V1_Options_Bits; u32]
Image_Copy_Capture_Session_V1_Error :: enum u32 {
	// create_frame sent before destroying previous frame
	Duplicate_Frame = 1,
}
Image_Copy_Capture_Frame_V1_Error :: enum u32 {
	// capture sent without attach_buffer
	No_Buffer = 1,
	// invalid buffer damage
	Invalid_Buffer_Damage = 2,
	// capture request has been sent
	Already_Captured = 3,
}
Image_Copy_Capture_Frame_V1_Failure_Reason :: enum u32 {
	Unknown = 0,
	Buffer_Constraints = 1,
	Stopped = 2,
}
Image_Copy_Capture_Cursor_Session_V1_Error :: enum u32 {
	// get_capture_session sent twice
	Duplicate_Session = 1,
}
Session_Lock_V1_Error :: enum u32 {
	// attempted to destroy session lock while locked
	Invalid_Destroy = 0,
	// unlock requested but locked event was never sent
	Invalid_Unlock = 1,
	// given wl_surface already has a role
	Role = 2,
	// given output already has a lock surface
	Duplicate_Output = 3,
	// given wl_surface has a buffer attached or committed
	Already_Constructed = 4,
}
Session_Lock_Surface_V1_Error :: enum u32 {
	// surface committed before first ack_configure request
	Commit_Before_First_Ack = 0,
	// surface committed with a null buffer
	Null_Buffer = 1,
	// failed to match ack'd width/height
	Dimensions_Mismatch = 2,
	// serial provided in ack_configure is invalid
	Invalid_Serial = 3,
}
Workspace_Group_Handle_V1_Group_Capabilities_Bits :: enum {
	// create_workspace request is available
	Create_Workspace = 0,
}
Workspace_Group_Handle_V1_Group_Capabilities :: distinct bit_set[Workspace_Group_Handle_V1_Group_Capabilities_Bits; u32]
Workspace_Handle_V1_State_Bits :: enum {
	// the workspace is active
	Active = 0,
	// the workspace requests attention
	Urgent = 1,
	Hidden = 2,
}
Workspace_Handle_V1_State :: distinct bit_set[Workspace_Handle_V1_State_Bits; u32]
Workspace_Handle_V1_Workspace_Capabilities_Bits :: enum {
	// activate request is available
	Activate = 0,
	// deactivate request is available
	Deactivate = 1,
	// remove request is available
	Remove = 2,
	// assign request is available
	Assign = 3,
}
Workspace_Handle_V1_Workspace_Capabilities :: distinct bit_set[Workspace_Handle_V1_Workspace_Capabilities_Bits; u32]

background_effect_manager_v1_destroy :: proc(connection: ^Connection, background_effect_manager_v1: Background_Effect_Manager_V1) {
	_size: u16 = 8
	background_effect_manager_v1 := background_effect_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &background_effect_manager_v1, size_of(background_effect_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_background_effect_manager_v1@", background_effect_manager_v1, ".destroy:")
	return
}
background_effect_manager_v1_get_background_effect :: proc(connection: ^Connection, background_effect_manager_v1: Background_Effect_Manager_V1, surface: wl.Surface) -> (id: Background_Effect_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	background_effect_manager_v1 := background_effect_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &background_effect_manager_v1, size_of(background_effect_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Ext_Background_Effect_Surface_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_background_effect_manager_v1@", background_effect_manager_v1, ".get_background_effect:", " id=", id, " surface=", surface)
	return
}
background_effect_surface_v1_destroy :: proc(connection: ^Connection, background_effect_surface_v1: Background_Effect_Surface_V1) {
	_size: u16 = 8
	background_effect_surface_v1 := background_effect_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &background_effect_surface_v1, size_of(background_effect_surface_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_background_effect_surface_v1@", background_effect_surface_v1, ".destroy:")
	return
}
background_effect_surface_v1_set_blur_region :: proc(connection: ^Connection, background_effect_surface_v1: Background_Effect_Surface_V1, region: wl.Region) {
	_size: u16 = 8 + size_of(region)
	background_effect_surface_v1 := background_effect_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &background_effect_surface_v1, size_of(background_effect_surface_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	region := region
	_buffer_write_ptr(&connection.buffer_out, &region, size_of(region))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_background_effect_surface_v1@", background_effect_surface_v1, ".set_blur_region:", " region=", region)
	return
}
data_control_manager_v1_create_data_source :: proc(connection: ^Connection, data_control_manager_v1: Data_Control_Manager_V1) -> (id: Data_Control_Source_V1) {
	_size: u16 = 8 + size_of(id)
	data_control_manager_v1 := data_control_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_manager_v1, size_of(data_control_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Ext_Data_Control_Source_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_manager_v1@", data_control_manager_v1, ".create_data_source:", " id=", id)
	return
}
data_control_manager_v1_get_data_device :: proc(connection: ^Connection, data_control_manager_v1: Data_Control_Manager_V1, seat: wl.Seat) -> (id: Data_Control_Device_V1) {
	_size: u16 = 8 + size_of(id) + size_of(seat)
	data_control_manager_v1 := data_control_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_manager_v1, size_of(data_control_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Ext_Data_Control_Device_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_manager_v1@", data_control_manager_v1, ".get_data_device:", " id=", id, " seat=", seat)
	return
}
data_control_manager_v1_destroy :: proc(connection: ^Connection, data_control_manager_v1: Data_Control_Manager_V1) {
	_size: u16 = 8
	data_control_manager_v1 := data_control_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_manager_v1, size_of(data_control_manager_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_manager_v1@", data_control_manager_v1, ".destroy:")
	return
}
data_control_device_v1_set_selection :: proc(connection: ^Connection, data_control_device_v1: Data_Control_Device_V1, source: Data_Control_Source_V1) {
	_size: u16 = 8 + size_of(source)
	data_control_device_v1 := data_control_device_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_device_v1, size_of(data_control_device_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	source := source
	_buffer_write_ptr(&connection.buffer_out, &source, size_of(source))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_device_v1@", data_control_device_v1, ".set_selection:", " source=", source)
	return
}
data_control_device_v1_destroy :: proc(connection: ^Connection, data_control_device_v1: Data_Control_Device_V1) {
	_size: u16 = 8
	data_control_device_v1 := data_control_device_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_device_v1, size_of(data_control_device_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_device_v1@", data_control_device_v1, ".destroy:")
	return
}
data_control_device_v1_set_primary_selection :: proc(connection: ^Connection, data_control_device_v1: Data_Control_Device_V1, source: Data_Control_Source_V1) {
	_size: u16 = 8 + size_of(source)
	data_control_device_v1 := data_control_device_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_device_v1, size_of(data_control_device_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	source := source
	_buffer_write_ptr(&connection.buffer_out, &source, size_of(source))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_device_v1@", data_control_device_v1, ".set_primary_selection:", " source=", source)
	return
}
data_control_source_v1_offer :: proc(connection: ^Connection, data_control_source_v1: Data_Control_Source_V1, mime_type: string) {
	_size: u16 = 8 + 4 + u16((len(mime_type) + 1 + 3) & -4)
	data_control_source_v1 := data_control_source_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_source_v1, size_of(data_control_source_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, mime_type)
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_source_v1@", data_control_source_v1, ".offer:", " mime_type=", mime_type)
	return
}
data_control_source_v1_destroy :: proc(connection: ^Connection, data_control_source_v1: Data_Control_Source_V1) {
	_size: u16 = 8
	data_control_source_v1 := data_control_source_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_source_v1, size_of(data_control_source_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_source_v1@", data_control_source_v1, ".destroy:")
	return
}
data_control_offer_v1_receive :: proc(connection: ^Connection, data_control_offer_v1: Data_Control_Offer_V1, mime_type: string, fd: Fd) {
	_size: u16 = 8 + 4 + u16((len(mime_type) + 1 + 3) & -4)
	data_control_offer_v1 := data_control_offer_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_offer_v1, size_of(data_control_offer_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, mime_type)
	append(&connection.fds_out, fd)
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_offer_v1@", data_control_offer_v1, ".receive:", " mime_type=", mime_type, " fd=", fd)
	return
}
data_control_offer_v1_destroy :: proc(connection: ^Connection, data_control_offer_v1: Data_Control_Offer_V1) {
	_size: u16 = 8
	data_control_offer_v1 := data_control_offer_v1
	_buffer_write_ptr(&connection.buffer_out, &data_control_offer_v1, size_of(data_control_offer_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_data_control_offer_v1@", data_control_offer_v1, ".destroy:")
	return
}
foreign_toplevel_list_v1_stop :: proc(connection: ^Connection, foreign_toplevel_list_v1: Foreign_Toplevel_List_V1) {
	_size: u16 = 8
	foreign_toplevel_list_v1 := foreign_toplevel_list_v1
	_buffer_write_ptr(&connection.buffer_out, &foreign_toplevel_list_v1, size_of(foreign_toplevel_list_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_foreign_toplevel_list_v1@", foreign_toplevel_list_v1, ".stop:")
	return
}
foreign_toplevel_list_v1_destroy :: proc(connection: ^Connection, foreign_toplevel_list_v1: Foreign_Toplevel_List_V1) {
	_size: u16 = 8
	foreign_toplevel_list_v1 := foreign_toplevel_list_v1
	_buffer_write_ptr(&connection.buffer_out, &foreign_toplevel_list_v1, size_of(foreign_toplevel_list_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_foreign_toplevel_list_v1@", foreign_toplevel_list_v1, ".destroy:")
	return
}
foreign_toplevel_handle_v1_destroy :: proc(connection: ^Connection, foreign_toplevel_handle_v1: Foreign_Toplevel_Handle_V1) {
	_size: u16 = 8
	foreign_toplevel_handle_v1 := foreign_toplevel_handle_v1
	_buffer_write_ptr(&connection.buffer_out, &foreign_toplevel_handle_v1, size_of(foreign_toplevel_handle_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_foreign_toplevel_handle_v1@", foreign_toplevel_handle_v1, ".destroy:")
	return
}
idle_notifier_v1_destroy :: proc(connection: ^Connection, idle_notifier_v1: Idle_Notifier_V1) {
	_size: u16 = 8
	idle_notifier_v1 := idle_notifier_v1
	_buffer_write_ptr(&connection.buffer_out, &idle_notifier_v1, size_of(idle_notifier_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_idle_notifier_v1@", idle_notifier_v1, ".destroy:")
	return
}
idle_notifier_v1_get_idle_notification :: proc(connection: ^Connection, idle_notifier_v1: Idle_Notifier_V1, timeout: u32, seat: wl.Seat) -> (id: Idle_Notification_V1) {
	_size: u16 = 8 + size_of(id) + size_of(timeout) + size_of(seat)
	idle_notifier_v1 := idle_notifier_v1
	_buffer_write_ptr(&connection.buffer_out, &idle_notifier_v1, size_of(idle_notifier_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Ext_Idle_Notification_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	timeout := timeout
	_buffer_write_ptr(&connection.buffer_out, &timeout, size_of(timeout))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_idle_notifier_v1@", idle_notifier_v1, ".get_idle_notification:", " id=", id, " timeout=", timeout, " seat=", seat)
	return
}
idle_notifier_v1_get_input_idle_notification :: proc(connection: ^Connection, idle_notifier_v1: Idle_Notifier_V1, timeout: u32, seat: wl.Seat) -> (id: Idle_Notification_V1) {
	_size: u16 = 8 + size_of(id) + size_of(timeout) + size_of(seat)
	idle_notifier_v1 := idle_notifier_v1
	_buffer_write_ptr(&connection.buffer_out, &idle_notifier_v1, size_of(idle_notifier_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Ext_Idle_Notification_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	timeout := timeout
	_buffer_write_ptr(&connection.buffer_out, &timeout, size_of(timeout))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_idle_notifier_v1@", idle_notifier_v1, ".get_input_idle_notification:", " id=", id, " timeout=", timeout, " seat=", seat)
	return
}
idle_notification_v1_destroy :: proc(connection: ^Connection, idle_notification_v1: Idle_Notification_V1) {
	_size: u16 = 8
	idle_notification_v1 := idle_notification_v1
	_buffer_write_ptr(&connection.buffer_out, &idle_notification_v1, size_of(idle_notification_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_idle_notification_v1@", idle_notification_v1, ".destroy:")
	return
}
image_capture_source_v1_destroy :: proc(connection: ^Connection, image_capture_source_v1: Image_Capture_Source_V1) {
	_size: u16 = 8
	image_capture_source_v1 := image_capture_source_v1
	_buffer_write_ptr(&connection.buffer_out, &image_capture_source_v1, size_of(image_capture_source_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_capture_source_v1@", image_capture_source_v1, ".destroy:")
	return
}
output_image_capture_source_manager_v1_create_source :: proc(connection: ^Connection, output_image_capture_source_manager_v1: Output_Image_Capture_Source_Manager_V1, output: wl.Output) -> (source: Image_Capture_Source_V1) {
	_size: u16 = 8 + size_of(source) + size_of(output)
	output_image_capture_source_manager_v1 := output_image_capture_source_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &output_image_capture_source_manager_v1, size_of(output_image_capture_source_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	source = auto_cast _generate_id(connection, .Ext_Image_Capture_Source_V1)
	_buffer_write_ptr(&connection.buffer_out, &source, size_of(source))
	output := output
	_buffer_write_ptr(&connection.buffer_out, &output, size_of(output))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_output_image_capture_source_manager_v1@", output_image_capture_source_manager_v1, ".create_source:", " source=", source, " output=", output)
	return
}
output_image_capture_source_manager_v1_destroy :: proc(connection: ^Connection, output_image_capture_source_manager_v1: Output_Image_Capture_Source_Manager_V1) {
	_size: u16 = 8
	output_image_capture_source_manager_v1 := output_image_capture_source_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &output_image_capture_source_manager_v1, size_of(output_image_capture_source_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_output_image_capture_source_manager_v1@", output_image_capture_source_manager_v1, ".destroy:")
	return
}
foreign_toplevel_image_capture_source_manager_v1_create_source :: proc(connection: ^Connection, foreign_toplevel_image_capture_source_manager_v1: Foreign_Toplevel_Image_Capture_Source_Manager_V1, toplevel_handle: Foreign_Toplevel_Handle_V1) -> (source: Image_Capture_Source_V1) {
	_size: u16 = 8 + size_of(source) + size_of(toplevel_handle)
	foreign_toplevel_image_capture_source_manager_v1 := foreign_toplevel_image_capture_source_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &foreign_toplevel_image_capture_source_manager_v1, size_of(foreign_toplevel_image_capture_source_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	source = auto_cast _generate_id(connection, .Ext_Image_Capture_Source_V1)
	_buffer_write_ptr(&connection.buffer_out, &source, size_of(source))
	toplevel_handle := toplevel_handle
	_buffer_write_ptr(&connection.buffer_out, &toplevel_handle, size_of(toplevel_handle))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_foreign_toplevel_image_capture_source_manager_v1@", foreign_toplevel_image_capture_source_manager_v1, ".create_source:", " source=", source, " toplevel_handle=", toplevel_handle)
	return
}
foreign_toplevel_image_capture_source_manager_v1_destroy :: proc(connection: ^Connection, foreign_toplevel_image_capture_source_manager_v1: Foreign_Toplevel_Image_Capture_Source_Manager_V1) {
	_size: u16 = 8
	foreign_toplevel_image_capture_source_manager_v1 := foreign_toplevel_image_capture_source_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &foreign_toplevel_image_capture_source_manager_v1, size_of(foreign_toplevel_image_capture_source_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_foreign_toplevel_image_capture_source_manager_v1@", foreign_toplevel_image_capture_source_manager_v1, ".destroy:")
	return
}
image_copy_capture_manager_v1_create_session :: proc(connection: ^Connection, image_copy_capture_manager_v1: Image_Copy_Capture_Manager_V1, source: Image_Capture_Source_V1, options: Image_Copy_Capture_Manager_V1_Options) -> (session: Image_Copy_Capture_Session_V1) {
	_size: u16 = 8 + size_of(session) + size_of(source) + size_of(options)
	image_copy_capture_manager_v1 := image_copy_capture_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_manager_v1, size_of(image_copy_capture_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	session = auto_cast _generate_id(connection, .Ext_Image_Copy_Capture_Session_V1)
	_buffer_write_ptr(&connection.buffer_out, &session, size_of(session))
	source := source
	_buffer_write_ptr(&connection.buffer_out, &source, size_of(source))
	options := options
	_buffer_write_ptr(&connection.buffer_out, &options, size_of(options))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_manager_v1@", image_copy_capture_manager_v1, ".create_session:", " session=", session, " source=", source, " options=", options)
	return
}
image_copy_capture_manager_v1_create_pointer_cursor_session :: proc(connection: ^Connection, image_copy_capture_manager_v1: Image_Copy_Capture_Manager_V1, source: Image_Capture_Source_V1, pointer: wl.Pointer) -> (session: Image_Copy_Capture_Cursor_Session_V1) {
	_size: u16 = 8 + size_of(session) + size_of(source) + size_of(pointer)
	image_copy_capture_manager_v1 := image_copy_capture_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_manager_v1, size_of(image_copy_capture_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	session = auto_cast _generate_id(connection, .Ext_Image_Copy_Capture_Cursor_Session_V1)
	_buffer_write_ptr(&connection.buffer_out, &session, size_of(session))
	source := source
	_buffer_write_ptr(&connection.buffer_out, &source, size_of(source))
	pointer := pointer
	_buffer_write_ptr(&connection.buffer_out, &pointer, size_of(pointer))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_manager_v1@", image_copy_capture_manager_v1, ".create_pointer_cursor_session:", " session=", session, " source=", source, " pointer=", pointer)
	return
}
image_copy_capture_manager_v1_destroy :: proc(connection: ^Connection, image_copy_capture_manager_v1: Image_Copy_Capture_Manager_V1) {
	_size: u16 = 8
	image_copy_capture_manager_v1 := image_copy_capture_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_manager_v1, size_of(image_copy_capture_manager_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_manager_v1@", image_copy_capture_manager_v1, ".destroy:")
	return
}
image_copy_capture_session_v1_create_frame :: proc(connection: ^Connection, image_copy_capture_session_v1: Image_Copy_Capture_Session_V1) -> (frame: Image_Copy_Capture_Frame_V1) {
	_size: u16 = 8 + size_of(frame)
	image_copy_capture_session_v1 := image_copy_capture_session_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_session_v1, size_of(image_copy_capture_session_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	frame = auto_cast _generate_id(connection, .Ext_Image_Copy_Capture_Frame_V1)
	_buffer_write_ptr(&connection.buffer_out, &frame, size_of(frame))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_session_v1@", image_copy_capture_session_v1, ".create_frame:", " frame=", frame)
	return
}
image_copy_capture_session_v1_destroy :: proc(connection: ^Connection, image_copy_capture_session_v1: Image_Copy_Capture_Session_V1) {
	_size: u16 = 8
	image_copy_capture_session_v1 := image_copy_capture_session_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_session_v1, size_of(image_copy_capture_session_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_session_v1@", image_copy_capture_session_v1, ".destroy:")
	return
}
image_copy_capture_frame_v1_destroy :: proc(connection: ^Connection, image_copy_capture_frame_v1: Image_Copy_Capture_Frame_V1) {
	_size: u16 = 8
	image_copy_capture_frame_v1 := image_copy_capture_frame_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_frame_v1, size_of(image_copy_capture_frame_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_frame_v1@", image_copy_capture_frame_v1, ".destroy:")
	return
}
image_copy_capture_frame_v1_attach_buffer :: proc(connection: ^Connection, image_copy_capture_frame_v1: Image_Copy_Capture_Frame_V1, buffer: wl.Buffer) {
	_size: u16 = 8 + size_of(buffer)
	image_copy_capture_frame_v1 := image_copy_capture_frame_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_frame_v1, size_of(image_copy_capture_frame_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	buffer := buffer
	_buffer_write_ptr(&connection.buffer_out, &buffer, size_of(buffer))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_frame_v1@", image_copy_capture_frame_v1, ".attach_buffer:", " buffer=", buffer)
	return
}
image_copy_capture_frame_v1_damage_buffer :: proc(connection: ^Connection, image_copy_capture_frame_v1: Image_Copy_Capture_Frame_V1, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	image_copy_capture_frame_v1 := image_copy_capture_frame_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_frame_v1, size_of(image_copy_capture_frame_v1))
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
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_frame_v1@", image_copy_capture_frame_v1, ".damage_buffer:", " x=", x, " y=", y, " width=", width, " height=", height)
	return
}
image_copy_capture_frame_v1_capture :: proc(connection: ^Connection, image_copy_capture_frame_v1: Image_Copy_Capture_Frame_V1) {
	_size: u16 = 8
	image_copy_capture_frame_v1 := image_copy_capture_frame_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_frame_v1, size_of(image_copy_capture_frame_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_frame_v1@", image_copy_capture_frame_v1, ".capture:")
	return
}
image_copy_capture_cursor_session_v1_destroy :: proc(connection: ^Connection, image_copy_capture_cursor_session_v1: Image_Copy_Capture_Cursor_Session_V1) {
	_size: u16 = 8
	image_copy_capture_cursor_session_v1 := image_copy_capture_cursor_session_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_cursor_session_v1, size_of(image_copy_capture_cursor_session_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_cursor_session_v1@", image_copy_capture_cursor_session_v1, ".destroy:")
	return
}
image_copy_capture_cursor_session_v1_get_capture_session :: proc(connection: ^Connection, image_copy_capture_cursor_session_v1: Image_Copy_Capture_Cursor_Session_V1) -> (session: Image_Copy_Capture_Session_V1) {
	_size: u16 = 8 + size_of(session)
	image_copy_capture_cursor_session_v1 := image_copy_capture_cursor_session_v1
	_buffer_write_ptr(&connection.buffer_out, &image_copy_capture_cursor_session_v1, size_of(image_copy_capture_cursor_session_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	session = auto_cast _generate_id(connection, .Ext_Image_Copy_Capture_Session_V1)
	_buffer_write_ptr(&connection.buffer_out, &session, size_of(session))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_image_copy_capture_cursor_session_v1@", image_copy_capture_cursor_session_v1, ".get_capture_session:", " session=", session)
	return
}
session_lock_manager_v1_destroy :: proc(connection: ^Connection, session_lock_manager_v1: Session_Lock_Manager_V1) {
	_size: u16 = 8
	session_lock_manager_v1 := session_lock_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &session_lock_manager_v1, size_of(session_lock_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_session_lock_manager_v1@", session_lock_manager_v1, ".destroy:")
	return
}
session_lock_manager_v1_lock :: proc(connection: ^Connection, session_lock_manager_v1: Session_Lock_Manager_V1) -> (id: Session_Lock_V1) {
	_size: u16 = 8 + size_of(id)
	session_lock_manager_v1 := session_lock_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &session_lock_manager_v1, size_of(session_lock_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Ext_Session_Lock_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_session_lock_manager_v1@", session_lock_manager_v1, ".lock:", " id=", id)
	return
}
session_lock_v1_destroy :: proc(connection: ^Connection, session_lock_v1: Session_Lock_V1) {
	_size: u16 = 8
	session_lock_v1 := session_lock_v1
	_buffer_write_ptr(&connection.buffer_out, &session_lock_v1, size_of(session_lock_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_session_lock_v1@", session_lock_v1, ".destroy:")
	return
}
session_lock_v1_get_lock_surface :: proc(connection: ^Connection, session_lock_v1: Session_Lock_V1, surface: wl.Surface, output: wl.Output) -> (id: Session_Lock_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface) + size_of(output)
	session_lock_v1 := session_lock_v1
	_buffer_write_ptr(&connection.buffer_out, &session_lock_v1, size_of(session_lock_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Ext_Session_Lock_Surface_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	output := output
	_buffer_write_ptr(&connection.buffer_out, &output, size_of(output))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_session_lock_v1@", session_lock_v1, ".get_lock_surface:", " id=", id, " surface=", surface, " output=", output)
	return
}
session_lock_v1_unlock_and_destroy :: proc(connection: ^Connection, session_lock_v1: Session_Lock_V1) {
	_size: u16 = 8
	session_lock_v1 := session_lock_v1
	_buffer_write_ptr(&connection.buffer_out, &session_lock_v1, size_of(session_lock_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_session_lock_v1@", session_lock_v1, ".unlock_and_destroy:")
	return
}
session_lock_surface_v1_destroy :: proc(connection: ^Connection, session_lock_surface_v1: Session_Lock_Surface_V1) {
	_size: u16 = 8
	session_lock_surface_v1 := session_lock_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &session_lock_surface_v1, size_of(session_lock_surface_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_session_lock_surface_v1@", session_lock_surface_v1, ".destroy:")
	return
}
session_lock_surface_v1_ack_configure :: proc(connection: ^Connection, session_lock_surface_v1: Session_Lock_Surface_V1, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	session_lock_surface_v1 := session_lock_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &session_lock_surface_v1, size_of(session_lock_surface_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_session_lock_surface_v1@", session_lock_surface_v1, ".ack_configure:", " serial=", serial)
	return
}
transient_seat_manager_v1_create :: proc(connection: ^Connection, transient_seat_manager_v1: Transient_Seat_Manager_V1) -> (seat: Transient_Seat_V1) {
	_size: u16 = 8 + size_of(seat)
	transient_seat_manager_v1 := transient_seat_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &transient_seat_manager_v1, size_of(transient_seat_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	seat = auto_cast _generate_id(connection, .Ext_Transient_Seat_V1)
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_transient_seat_manager_v1@", transient_seat_manager_v1, ".create:", " seat=", seat)
	return
}
transient_seat_manager_v1_destroy :: proc(connection: ^Connection, transient_seat_manager_v1: Transient_Seat_Manager_V1) {
	_size: u16 = 8
	transient_seat_manager_v1 := transient_seat_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &transient_seat_manager_v1, size_of(transient_seat_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_transient_seat_manager_v1@", transient_seat_manager_v1, ".destroy:")
	return
}
transient_seat_v1_destroy :: proc(connection: ^Connection, transient_seat_v1: Transient_Seat_V1) {
	_size: u16 = 8
	transient_seat_v1 := transient_seat_v1
	_buffer_write_ptr(&connection.buffer_out, &transient_seat_v1, size_of(transient_seat_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_transient_seat_v1@", transient_seat_v1, ".destroy:")
	return
}
workspace_manager_v1_commit :: proc(connection: ^Connection, workspace_manager_v1: Workspace_Manager_V1) {
	_size: u16 = 8
	workspace_manager_v1 := workspace_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_manager_v1, size_of(workspace_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_manager_v1@", workspace_manager_v1, ".commit:")
	return
}
workspace_manager_v1_stop :: proc(connection: ^Connection, workspace_manager_v1: Workspace_Manager_V1) {
	_size: u16 = 8
	workspace_manager_v1 := workspace_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_manager_v1, size_of(workspace_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_manager_v1@", workspace_manager_v1, ".stop:")
	return
}
workspace_group_handle_v1_create_workspace :: proc(connection: ^Connection, workspace_group_handle_v1: Workspace_Group_Handle_V1, workspace: string) {
	_size: u16 = 8 + 4 + u16((len(workspace) + 1 + 3) & -4)
	workspace_group_handle_v1 := workspace_group_handle_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_group_handle_v1, size_of(workspace_group_handle_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, workspace)
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_group_handle_v1@", workspace_group_handle_v1, ".create_workspace:", " workspace=", workspace)
	return
}
workspace_group_handle_v1_destroy :: proc(connection: ^Connection, workspace_group_handle_v1: Workspace_Group_Handle_V1) {
	_size: u16 = 8
	workspace_group_handle_v1 := workspace_group_handle_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_group_handle_v1, size_of(workspace_group_handle_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_group_handle_v1@", workspace_group_handle_v1, ".destroy:")
	return
}
workspace_handle_v1_destroy :: proc(connection: ^Connection, workspace_handle_v1: Workspace_Handle_V1) {
	_size: u16 = 8
	workspace_handle_v1 := workspace_handle_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_handle_v1, size_of(workspace_handle_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_handle_v1@", workspace_handle_v1, ".destroy:")
	return
}
workspace_handle_v1_activate :: proc(connection: ^Connection, workspace_handle_v1: Workspace_Handle_V1) {
	_size: u16 = 8
	workspace_handle_v1 := workspace_handle_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_handle_v1, size_of(workspace_handle_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_handle_v1@", workspace_handle_v1, ".activate:")
	return
}
workspace_handle_v1_deactivate :: proc(connection: ^Connection, workspace_handle_v1: Workspace_Handle_V1) {
	_size: u16 = 8
	workspace_handle_v1 := workspace_handle_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_handle_v1, size_of(workspace_handle_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_handle_v1@", workspace_handle_v1, ".deactivate:")
	return
}
workspace_handle_v1_assign :: proc(connection: ^Connection, workspace_handle_v1: Workspace_Handle_V1, workspace_group: Workspace_Group_Handle_V1) {
	_size: u16 = 8 + size_of(workspace_group)
	workspace_handle_v1 := workspace_handle_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_handle_v1, size_of(workspace_handle_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	workspace_group := workspace_group
	_buffer_write_ptr(&connection.buffer_out, &workspace_group, size_of(workspace_group))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_handle_v1@", workspace_handle_v1, ".assign:", " workspace_group=", workspace_group)
	return
}
workspace_handle_v1_remove :: proc(connection: ^Connection, workspace_handle_v1: Workspace_Handle_V1) {
	_size: u16 = 8
	workspace_handle_v1 := workspace_handle_v1
	_buffer_write_ptr(&connection.buffer_out, &workspace_handle_v1, size_of(workspace_handle_v1))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> ext_workspace_handle_v1@", workspace_handle_v1, ".remove:")
	return
}

Background_Effect_Manager_V1_Capabilities_Event :: struct {
	object: Background_Effect_Manager_V1,
	flags: Background_Effect_Manager_V1_Capability,
}
Data_Control_Device_V1_Data_Offer_Event :: struct {
	object: Data_Control_Device_V1,
	id: Data_Control_Offer_V1,
}
Data_Control_Device_V1_Selection_Event :: struct {
	object: Data_Control_Device_V1,
	id: Data_Control_Offer_V1,
}
Data_Control_Device_V1_Finished_Event :: struct {
	object: Data_Control_Device_V1,
}
Data_Control_Device_V1_Primary_Selection_Event :: struct {
	object: Data_Control_Device_V1,
	id: Data_Control_Offer_V1,
}
Data_Control_Source_V1_Send_Event :: struct {
	object: Data_Control_Source_V1,
	mime_type: string,
	fd: Fd,
}
Data_Control_Source_V1_Cancelled_Event :: struct {
	object: Data_Control_Source_V1,
}
Data_Control_Offer_V1_Offer_Event :: struct {
	object: Data_Control_Offer_V1,
	mime_type: string,
}
Foreign_Toplevel_List_V1_Toplevel_Event :: struct {
	object: Foreign_Toplevel_List_V1,
	toplevel: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_List_V1_Finished_Event :: struct {
	object: Foreign_Toplevel_List_V1,
}
Foreign_Toplevel_Handle_V1_Closed_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_Handle_V1_Done_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_Handle_V1_Title_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	title: string,
}
Foreign_Toplevel_Handle_V1_App_Id_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	app_id: string,
}
Foreign_Toplevel_Handle_V1_Identifier_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	identifier: string,
}
Idle_Notification_V1_Idled_Event :: struct {
	object: Idle_Notification_V1,
}
Idle_Notification_V1_Resumed_Event :: struct {
	object: Idle_Notification_V1,
}
Image_Copy_Capture_Session_V1_Buffer_Size_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
	width: u32,
	height: u32,
}
Image_Copy_Capture_Session_V1_Shm_Format_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
	format: wl.Shm_Format,
}
Image_Copy_Capture_Session_V1_Dmabuf_Device_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
	device: []byte,
}
Image_Copy_Capture_Session_V1_Dmabuf_Format_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
	format: u32,
	modifiers: []byte,
}
Image_Copy_Capture_Session_V1_Done_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
}
Image_Copy_Capture_Session_V1_Stopped_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
}
Image_Copy_Capture_Frame_V1_Transform_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
	transform: wl.Output_Transform,
}
Image_Copy_Capture_Frame_V1_Damage_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
	x: i32,
	y: i32,
	width: i32,
	height: i32,
}
Image_Copy_Capture_Frame_V1_Presentation_Time_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
	tv_sec_hi: u32,
	tv_sec_lo: u32,
	tv_nsec: u32,
}
Image_Copy_Capture_Frame_V1_Ready_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
}
Image_Copy_Capture_Frame_V1_Failed_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
	reason: Image_Copy_Capture_Frame_V1_Failure_Reason,
}
Image_Copy_Capture_Cursor_Session_V1_Enter_Event :: struct {
	object: Image_Copy_Capture_Cursor_Session_V1,
}
Image_Copy_Capture_Cursor_Session_V1_Leave_Event :: struct {
	object: Image_Copy_Capture_Cursor_Session_V1,
}
Image_Copy_Capture_Cursor_Session_V1_Position_Event :: struct {
	object: Image_Copy_Capture_Cursor_Session_V1,
	x: i32,
	y: i32,
}
Image_Copy_Capture_Cursor_Session_V1_Hotspot_Event :: struct {
	object: Image_Copy_Capture_Cursor_Session_V1,
	x: i32,
	y: i32,
}
Session_Lock_V1_Locked_Event :: struct {
	object: Session_Lock_V1,
}
Session_Lock_V1_Finished_Event :: struct {
	object: Session_Lock_V1,
}
Session_Lock_Surface_V1_Configure_Event :: struct {
	object: Session_Lock_Surface_V1,
	serial: u32,
	width: u32,
	height: u32,
}
Transient_Seat_V1_Ready_Event :: struct {
	object: Transient_Seat_V1,
	global_name: u32,
}
Transient_Seat_V1_Denied_Event :: struct {
	object: Transient_Seat_V1,
}
Workspace_Manager_V1_Workspace_Group_Event :: struct {
	object: Workspace_Manager_V1,
	workspace_group: Workspace_Group_Handle_V1,
}
Workspace_Manager_V1_Workspace_Event :: struct {
	object: Workspace_Manager_V1,
	workspace: Workspace_Handle_V1,
}
Workspace_Manager_V1_Done_Event :: struct {
	object: Workspace_Manager_V1,
}
Workspace_Manager_V1_Finished_Event :: struct {
	object: Workspace_Manager_V1,
}
Workspace_Group_Handle_V1_Capabilities_Event :: struct {
	object: Workspace_Group_Handle_V1,
	capabilities: Workspace_Group_Handle_V1_Group_Capabilities,
}
Workspace_Group_Handle_V1_Output_Enter_Event :: struct {
	object: Workspace_Group_Handle_V1,
	output: wl.Output,
}
Workspace_Group_Handle_V1_Output_Leave_Event :: struct {
	object: Workspace_Group_Handle_V1,
	output: wl.Output,
}
Workspace_Group_Handle_V1_Workspace_Enter_Event :: struct {
	object: Workspace_Group_Handle_V1,
	workspace: Workspace_Handle_V1,
}
Workspace_Group_Handle_V1_Workspace_Leave_Event :: struct {
	object: Workspace_Group_Handle_V1,
	workspace: Workspace_Handle_V1,
}
Workspace_Group_Handle_V1_Removed_Event :: struct {
	object: Workspace_Group_Handle_V1,
}
Workspace_Handle_V1_Id_Event :: struct {
	object: Workspace_Handle_V1,
	id: string,
}
Workspace_Handle_V1_Name_Event :: struct {
	object: Workspace_Handle_V1,
	name: string,
}
Workspace_Handle_V1_Coordinates_Event :: struct {
	object: Workspace_Handle_V1,
	coordinates: []byte,
}
Workspace_Handle_V1_State_Event :: struct {
	object: Workspace_Handle_V1,
	state: Workspace_Handle_V1_State,
}
Workspace_Handle_V1_Capabilities_Event :: struct {
	object: Workspace_Handle_V1,
	capabilities: Workspace_Handle_V1_Workspace_Capabilities,
}
Workspace_Handle_V1_Removed_Event :: struct {
	object: Workspace_Handle_V1,
}

parse_background_effect_manager_v1_capabilities :: proc(connection: ^Connection, object: u32) -> (event: Background_Effect_Manager_V1_Capabilities_Event, ok: bool) {
	event.object = Background_Effect_Manager_V1(object)
	read(connection, &event.flags) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_background_effect_manager_v1@", object, ".capabilities:", " flags=", event.flags)
	ok = true
	return
}
parse_data_control_device_v1_data_offer :: proc(connection: ^Connection, object: u32) -> (event: Data_Control_Device_V1_Data_Offer_Event, ok: bool) {
	event.object = Data_Control_Device_V1(object)
	read(connection, &event.id) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.id) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.id) - SERVER_ID_START] = .Ext_Data_Control_Offer_V1
	if connection.log_fn != nil do _debug_log(connection, "<- ext_data_control_device_v1@", object, ".data_offer:", " id=", event.id)
	ok = true
	return
}
parse_data_control_device_v1_selection :: proc(connection: ^Connection, object: u32) -> (event: Data_Control_Device_V1_Selection_Event, ok: bool) {
	event.object = Data_Control_Device_V1(object)
	read(connection, &event.id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_data_control_device_v1@", object, ".selection:", " id=", event.id)
	ok = true
	return
}
parse_data_control_device_v1_finished :: proc(connection: ^Connection, object: u32) -> (event: Data_Control_Device_V1_Finished_Event, ok: bool) {
	event.object = Data_Control_Device_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_data_control_device_v1@", object, ".finished:")
	ok = true
	return
}
parse_data_control_device_v1_primary_selection :: proc(connection: ^Connection, object: u32) -> (event: Data_Control_Device_V1_Primary_Selection_Event, ok: bool) {
	event.object = Data_Control_Device_V1(object)
	read(connection, &event.id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_data_control_device_v1@", object, ".primary_selection:", " id=", event.id)
	ok = true
	return
}
parse_data_control_source_v1_send :: proc(connection: ^Connection, object: u32) -> (event: Data_Control_Source_V1_Send_Event, ok: bool) {
	event.object = Data_Control_Source_V1(object)
	read(connection, &event.mime_type) or_return
	read_fd(connection, &event.fd) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_data_control_source_v1@", object, ".send:", " mime_type=", event.mime_type, " fd=", event.fd)
	ok = true
	return
}
parse_data_control_source_v1_cancelled :: proc(connection: ^Connection, object: u32) -> (event: Data_Control_Source_V1_Cancelled_Event, ok: bool) {
	event.object = Data_Control_Source_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_data_control_source_v1@", object, ".cancelled:")
	ok = true
	return
}
parse_data_control_offer_v1_offer :: proc(connection: ^Connection, object: u32) -> (event: Data_Control_Offer_V1_Offer_Event, ok: bool) {
	event.object = Data_Control_Offer_V1(object)
	read(connection, &event.mime_type) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_data_control_offer_v1@", object, ".offer:", " mime_type=", event.mime_type)
	ok = true
	return
}
parse_foreign_toplevel_list_v1_toplevel :: proc(connection: ^Connection, object: u32) -> (event: Foreign_Toplevel_List_V1_Toplevel_Event, ok: bool) {
	event.object = Foreign_Toplevel_List_V1(object)
	read(connection, &event.toplevel) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.toplevel) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.toplevel) - SERVER_ID_START] = .Ext_Foreign_Toplevel_Handle_V1
	if connection.log_fn != nil do _debug_log(connection, "<- ext_foreign_toplevel_list_v1@", object, ".toplevel:", " toplevel=", event.toplevel)
	ok = true
	return
}
parse_foreign_toplevel_list_v1_finished :: proc(connection: ^Connection, object: u32) -> (event: Foreign_Toplevel_List_V1_Finished_Event, ok: bool) {
	event.object = Foreign_Toplevel_List_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_foreign_toplevel_list_v1@", object, ".finished:")
	ok = true
	return
}
parse_foreign_toplevel_handle_v1_closed :: proc(connection: ^Connection, object: u32) -> (event: Foreign_Toplevel_Handle_V1_Closed_Event, ok: bool) {
	event.object = Foreign_Toplevel_Handle_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_foreign_toplevel_handle_v1@", object, ".closed:")
	ok = true
	return
}
parse_foreign_toplevel_handle_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Foreign_Toplevel_Handle_V1_Done_Event, ok: bool) {
	event.object = Foreign_Toplevel_Handle_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_foreign_toplevel_handle_v1@", object, ".done:")
	ok = true
	return
}
parse_foreign_toplevel_handle_v1_title :: proc(connection: ^Connection, object: u32) -> (event: Foreign_Toplevel_Handle_V1_Title_Event, ok: bool) {
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(connection, &event.title) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_foreign_toplevel_handle_v1@", object, ".title:", " title=", event.title)
	ok = true
	return
}
parse_foreign_toplevel_handle_v1_app_id :: proc(connection: ^Connection, object: u32) -> (event: Foreign_Toplevel_Handle_V1_App_Id_Event, ok: bool) {
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(connection, &event.app_id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_foreign_toplevel_handle_v1@", object, ".app_id:", " app_id=", event.app_id)
	ok = true
	return
}
parse_foreign_toplevel_handle_v1_identifier :: proc(connection: ^Connection, object: u32) -> (event: Foreign_Toplevel_Handle_V1_Identifier_Event, ok: bool) {
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(connection, &event.identifier) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_foreign_toplevel_handle_v1@", object, ".identifier:", " identifier=", event.identifier)
	ok = true
	return
}
parse_idle_notification_v1_idled :: proc(connection: ^Connection, object: u32) -> (event: Idle_Notification_V1_Idled_Event, ok: bool) {
	event.object = Idle_Notification_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_idle_notification_v1@", object, ".idled:")
	ok = true
	return
}
parse_idle_notification_v1_resumed :: proc(connection: ^Connection, object: u32) -> (event: Idle_Notification_V1_Resumed_Event, ok: bool) {
	event.object = Idle_Notification_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_idle_notification_v1@", object, ".resumed:")
	ok = true
	return
}
parse_image_copy_capture_session_v1_buffer_size :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Session_V1_Buffer_Size_Event, ok: bool) {
	event.object = Image_Copy_Capture_Session_V1(object)
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_session_v1@", object, ".buffer_size:", " width=", event.width, " height=", event.height)
	ok = true
	return
}
parse_image_copy_capture_session_v1_shm_format :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Session_V1_Shm_Format_Event, ok: bool) {
	event.object = Image_Copy_Capture_Session_V1(object)
	read(connection, &event.format) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_session_v1@", object, ".shm_format:", " format=", event.format)
	ok = true
	return
}
parse_image_copy_capture_session_v1_dmabuf_device :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Session_V1_Dmabuf_Device_Event, ok: bool) {
	event.object = Image_Copy_Capture_Session_V1(object)
	read(connection, &event.device) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_session_v1@", object, ".dmabuf_device:", " device=", event.device)
	ok = true
	return
}
parse_image_copy_capture_session_v1_dmabuf_format :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Session_V1_Dmabuf_Format_Event, ok: bool) {
	event.object = Image_Copy_Capture_Session_V1(object)
	read(connection, &event.format) or_return
	read(connection, &event.modifiers) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_session_v1@", object, ".dmabuf_format:", " format=", event.format, " modifiers=", event.modifiers)
	ok = true
	return
}
parse_image_copy_capture_session_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Session_V1_Done_Event, ok: bool) {
	event.object = Image_Copy_Capture_Session_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_session_v1@", object, ".done:")
	ok = true
	return
}
parse_image_copy_capture_session_v1_stopped :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Session_V1_Stopped_Event, ok: bool) {
	event.object = Image_Copy_Capture_Session_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_session_v1@", object, ".stopped:")
	ok = true
	return
}
parse_image_copy_capture_frame_v1_transform :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Frame_V1_Transform_Event, ok: bool) {
	event.object = Image_Copy_Capture_Frame_V1(object)
	read(connection, &event.transform) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_frame_v1@", object, ".transform:", " transform=", event.transform)
	ok = true
	return
}
parse_image_copy_capture_frame_v1_damage :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Frame_V1_Damage_Event, ok: bool) {
	event.object = Image_Copy_Capture_Frame_V1(object)
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_frame_v1@", object, ".damage:", " x=", event.x, " y=", event.y, " width=", event.width, " height=", event.height)
	ok = true
	return
}
parse_image_copy_capture_frame_v1_presentation_time :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Frame_V1_Presentation_Time_Event, ok: bool) {
	event.object = Image_Copy_Capture_Frame_V1(object)
	read(connection, &event.tv_sec_hi) or_return
	read(connection, &event.tv_sec_lo) or_return
	read(connection, &event.tv_nsec) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_frame_v1@", object, ".presentation_time:", " tv_sec_hi=", event.tv_sec_hi, " tv_sec_lo=", event.tv_sec_lo, " tv_nsec=", event.tv_nsec)
	ok = true
	return
}
parse_image_copy_capture_frame_v1_ready :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Frame_V1_Ready_Event, ok: bool) {
	event.object = Image_Copy_Capture_Frame_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_frame_v1@", object, ".ready:")
	ok = true
	return
}
parse_image_copy_capture_frame_v1_failed :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Frame_V1_Failed_Event, ok: bool) {
	event.object = Image_Copy_Capture_Frame_V1(object)
	read(connection, &event.reason) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_frame_v1@", object, ".failed:", " reason=", event.reason)
	ok = true
	return
}
parse_image_copy_capture_cursor_session_v1_enter :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Cursor_Session_V1_Enter_Event, ok: bool) {
	event.object = Image_Copy_Capture_Cursor_Session_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_cursor_session_v1@", object, ".enter:")
	ok = true
	return
}
parse_image_copy_capture_cursor_session_v1_leave :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Cursor_Session_V1_Leave_Event, ok: bool) {
	event.object = Image_Copy_Capture_Cursor_Session_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_cursor_session_v1@", object, ".leave:")
	ok = true
	return
}
parse_image_copy_capture_cursor_session_v1_position :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Cursor_Session_V1_Position_Event, ok: bool) {
	event.object = Image_Copy_Capture_Cursor_Session_V1(object)
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_cursor_session_v1@", object, ".position:", " x=", event.x, " y=", event.y)
	ok = true
	return
}
parse_image_copy_capture_cursor_session_v1_hotspot :: proc(connection: ^Connection, object: u32) -> (event: Image_Copy_Capture_Cursor_Session_V1_Hotspot_Event, ok: bool) {
	event.object = Image_Copy_Capture_Cursor_Session_V1(object)
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_image_copy_capture_cursor_session_v1@", object, ".hotspot:", " x=", event.x, " y=", event.y)
	ok = true
	return
}
parse_session_lock_v1_locked :: proc(connection: ^Connection, object: u32) -> (event: Session_Lock_V1_Locked_Event, ok: bool) {
	event.object = Session_Lock_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_session_lock_v1@", object, ".locked:")
	ok = true
	return
}
parse_session_lock_v1_finished :: proc(connection: ^Connection, object: u32) -> (event: Session_Lock_V1_Finished_Event, ok: bool) {
	event.object = Session_Lock_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_session_lock_v1@", object, ".finished:")
	ok = true
	return
}
parse_session_lock_surface_v1_configure :: proc(connection: ^Connection, object: u32) -> (event: Session_Lock_Surface_V1_Configure_Event, ok: bool) {
	event.object = Session_Lock_Surface_V1(object)
	read(connection, &event.serial) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_session_lock_surface_v1@", object, ".configure:", " serial=", event.serial, " width=", event.width, " height=", event.height)
	ok = true
	return
}
parse_transient_seat_v1_ready :: proc(connection: ^Connection, object: u32) -> (event: Transient_Seat_V1_Ready_Event, ok: bool) {
	event.object = Transient_Seat_V1(object)
	read(connection, &event.global_name) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_transient_seat_v1@", object, ".ready:", " global_name=", event.global_name)
	ok = true
	return
}
parse_transient_seat_v1_denied :: proc(connection: ^Connection, object: u32) -> (event: Transient_Seat_V1_Denied_Event, ok: bool) {
	event.object = Transient_Seat_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_transient_seat_v1@", object, ".denied:")
	ok = true
	return
}
parse_workspace_manager_v1_workspace_group :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Manager_V1_Workspace_Group_Event, ok: bool) {
	event.object = Workspace_Manager_V1(object)
	read(connection, &event.workspace_group) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.workspace_group) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.workspace_group) - SERVER_ID_START] = .Ext_Workspace_Group_Handle_V1
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_manager_v1@", object, ".workspace_group:", " workspace_group=", event.workspace_group)
	ok = true
	return
}
parse_workspace_manager_v1_workspace :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Manager_V1_Workspace_Event, ok: bool) {
	event.object = Workspace_Manager_V1(object)
	read(connection, &event.workspace) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.workspace) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.workspace) - SERVER_ID_START] = .Ext_Workspace_Handle_V1
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_manager_v1@", object, ".workspace:", " workspace=", event.workspace)
	ok = true
	return
}
parse_workspace_manager_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Manager_V1_Done_Event, ok: bool) {
	event.object = Workspace_Manager_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_manager_v1@", object, ".done:")
	ok = true
	return
}
parse_workspace_manager_v1_finished :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Manager_V1_Finished_Event, ok: bool) {
	event.object = Workspace_Manager_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_manager_v1@", object, ".finished:")
	ok = true
	return
}
parse_workspace_group_handle_v1_capabilities :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Group_Handle_V1_Capabilities_Event, ok: bool) {
	event.object = Workspace_Group_Handle_V1(object)
	read(connection, &event.capabilities) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_group_handle_v1@", object, ".capabilities:", " capabilities=", event.capabilities)
	ok = true
	return
}
parse_workspace_group_handle_v1_output_enter :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Group_Handle_V1_Output_Enter_Event, ok: bool) {
	event.object = Workspace_Group_Handle_V1(object)
	read(connection, &event.output) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_group_handle_v1@", object, ".output_enter:", " output=", event.output)
	ok = true
	return
}
parse_workspace_group_handle_v1_output_leave :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Group_Handle_V1_Output_Leave_Event, ok: bool) {
	event.object = Workspace_Group_Handle_V1(object)
	read(connection, &event.output) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_group_handle_v1@", object, ".output_leave:", " output=", event.output)
	ok = true
	return
}
parse_workspace_group_handle_v1_workspace_enter :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Group_Handle_V1_Workspace_Enter_Event, ok: bool) {
	event.object = Workspace_Group_Handle_V1(object)
	read(connection, &event.workspace) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_group_handle_v1@", object, ".workspace_enter:", " workspace=", event.workspace)
	ok = true
	return
}
parse_workspace_group_handle_v1_workspace_leave :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Group_Handle_V1_Workspace_Leave_Event, ok: bool) {
	event.object = Workspace_Group_Handle_V1(object)
	read(connection, &event.workspace) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_group_handle_v1@", object, ".workspace_leave:", " workspace=", event.workspace)
	ok = true
	return
}
parse_workspace_group_handle_v1_removed :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Group_Handle_V1_Removed_Event, ok: bool) {
	event.object = Workspace_Group_Handle_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_group_handle_v1@", object, ".removed:")
	ok = true
	return
}
parse_workspace_handle_v1_id :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Handle_V1_Id_Event, ok: bool) {
	event.object = Workspace_Handle_V1(object)
	read(connection, &event.id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_handle_v1@", object, ".id:", " id=", event.id)
	ok = true
	return
}
parse_workspace_handle_v1_name :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Handle_V1_Name_Event, ok: bool) {
	event.object = Workspace_Handle_V1(object)
	read(connection, &event.name) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_handle_v1@", object, ".name:", " name=", event.name)
	ok = true
	return
}
parse_workspace_handle_v1_coordinates :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Handle_V1_Coordinates_Event, ok: bool) {
	event.object = Workspace_Handle_V1(object)
	read(connection, &event.coordinates) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_handle_v1@", object, ".coordinates:", " coordinates=", event.coordinates)
	ok = true
	return
}
parse_workspace_handle_v1_state :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Handle_V1_State_Event, ok: bool) {
	event.object = Workspace_Handle_V1(object)
	read(connection, &event.state) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_handle_v1@", object, ".state:", " state=", event.state)
	ok = true
	return
}
parse_workspace_handle_v1_capabilities :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Handle_V1_Capabilities_Event, ok: bool) {
	event.object = Workspace_Handle_V1(object)
	read(connection, &event.capabilities) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_handle_v1@", object, ".capabilities:", " capabilities=", event.capabilities)
	ok = true
	return
}
parse_workspace_handle_v1_removed :: proc(connection: ^Connection, object: u32) -> (event: Workspace_Handle_V1_Removed_Event, ok: bool) {
	event.object = Workspace_Handle_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- ext_workspace_handle_v1@", object, ".removed:")
	ok = true
	return
}

Background_Effect_Manager_V1 :: distinct u32
Background_Effect_Surface_V1 :: distinct u32
Data_Control_Manager_V1 :: distinct u32
Data_Control_Device_V1 :: distinct u32
Data_Control_Source_V1 :: distinct u32
Data_Control_Offer_V1 :: distinct u32
Foreign_Toplevel_List_V1 :: distinct u32
Foreign_Toplevel_Handle_V1 :: distinct u32
Idle_Notifier_V1 :: distinct u32
Idle_Notification_V1 :: distinct u32
Image_Capture_Source_V1 :: distinct u32
Output_Image_Capture_Source_Manager_V1 :: distinct u32
Foreign_Toplevel_Image_Capture_Source_Manager_V1 :: distinct u32
Image_Copy_Capture_Manager_V1 :: distinct u32
Image_Copy_Capture_Session_V1 :: distinct u32
Image_Copy_Capture_Frame_V1 :: distinct u32
Image_Copy_Capture_Cursor_Session_V1 :: distinct u32
Session_Lock_Manager_V1 :: distinct u32
Session_Lock_V1 :: distinct u32
Session_Lock_Surface_V1 :: distinct u32
Transient_Seat_Manager_V1 :: distinct u32
Transient_Seat_V1 :: distinct u32
Workspace_Manager_V1 :: distinct u32
Workspace_Group_Handle_V1 :: distinct u32
Workspace_Handle_V1 :: distinct u32

