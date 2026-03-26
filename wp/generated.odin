package wayland_wp

import "base:intrinsics"

import "../common"

import "../wl"
import "../zwp"

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


PRESENTATION_INTERFACE :: "wp_presentation"
PRESENTATION_FEEDBACK_INTERFACE :: "wp_presentation_feedback"
VIEWPORTER_INTERFACE :: "wp_viewporter"
VIEWPORT_INTERFACE :: "wp_viewport"
ALPHA_MODIFIER_V1_INTERFACE :: "wp_alpha_modifier_v1"
ALPHA_MODIFIER_SURFACE_V1_INTERFACE :: "wp_alpha_modifier_surface_v1"
COLOR_MANAGER_V1_INTERFACE :: "wp_color_manager_v1"
COLOR_MANAGEMENT_OUTPUT_V1_INTERFACE :: "wp_color_management_output_v1"
COLOR_MANAGEMENT_SURFACE_V1_INTERFACE :: "wp_color_management_surface_v1"
COLOR_MANAGEMENT_SURFACE_FEEDBACK_V1_INTERFACE :: "wp_color_management_surface_feedback_v1"
IMAGE_DESCRIPTION_CREATOR_ICC_V1_INTERFACE :: "wp_image_description_creator_icc_v1"
IMAGE_DESCRIPTION_CREATOR_PARAMS_V1_INTERFACE :: "wp_image_description_creator_params_v1"
IMAGE_DESCRIPTION_V1_INTERFACE :: "wp_image_description_v1"
IMAGE_DESCRIPTION_INFO_V1_INTERFACE :: "wp_image_description_info_v1"
IMAGE_DESCRIPTION_REFERENCE_V1_INTERFACE :: "wp_image_description_reference_v1"
COLOR_REPRESENTATION_MANAGER_V1_INTERFACE :: "wp_color_representation_manager_v1"
COLOR_REPRESENTATION_SURFACE_V1_INTERFACE :: "wp_color_representation_surface_v1"
COMMIT_TIMING_MANAGER_V1_INTERFACE :: "wp_commit_timing_manager_v1"
COMMIT_TIMER_V1_INTERFACE :: "wp_commit_timer_v1"
CONTENT_TYPE_MANAGER_V1_INTERFACE :: "wp_content_type_manager_v1"
CONTENT_TYPE_V1_INTERFACE :: "wp_content_type_v1"
CURSOR_SHAPE_MANAGER_V1_INTERFACE :: "wp_cursor_shape_manager_v1"
CURSOR_SHAPE_DEVICE_V1_INTERFACE :: "wp_cursor_shape_device_v1"
DRM_LEASE_DEVICE_V1_INTERFACE :: "wp_drm_lease_device_v1"
DRM_LEASE_CONNECTOR_V1_INTERFACE :: "wp_drm_lease_connector_v1"
DRM_LEASE_REQUEST_V1_INTERFACE :: "wp_drm_lease_request_v1"
DRM_LEASE_V1_INTERFACE :: "wp_drm_lease_v1"
FIFO_MANAGER_V1_INTERFACE :: "wp_fifo_manager_v1"
FIFO_V1_INTERFACE :: "wp_fifo_v1"
FRACTIONAL_SCALE_MANAGER_V1_INTERFACE :: "wp_fractional_scale_manager_v1"
FRACTIONAL_SCALE_V1_INTERFACE :: "wp_fractional_scale_v1"
LINUX_DRM_SYNCOBJ_MANAGER_V1_INTERFACE :: "wp_linux_drm_syncobj_manager_v1"
LINUX_DRM_SYNCOBJ_TIMELINE_V1_INTERFACE :: "wp_linux_drm_syncobj_timeline_v1"
LINUX_DRM_SYNCOBJ_SURFACE_V1_INTERFACE :: "wp_linux_drm_syncobj_surface_v1"
POINTER_WARP_V1_INTERFACE :: "wp_pointer_warp_v1"
SECURITY_CONTEXT_MANAGER_V1_INTERFACE :: "wp_security_context_manager_v1"
SECURITY_CONTEXT_V1_INTERFACE :: "wp_security_context_v1"
SINGLE_PIXEL_BUFFER_MANAGER_V1_INTERFACE :: "wp_single_pixel_buffer_manager_v1"
TEARING_CONTROL_MANAGER_V1_INTERFACE :: "wp_tearing_control_manager_v1"
TEARING_CONTROL_V1_INTERFACE :: "wp_tearing_control_v1"

Presentation_Error :: enum u32 {
	// invalid value in tv_nsec
	Invalid_Timestamp = 0,
	// invalid flag
	Invalid_Flag = 1,
}
Presentation_Feedback_Kind_Bits :: enum {
	Vsync = 0,
	Hw_Clock = 1,
	Hw_Completion = 2,
	Zero_Copy = 3,
}
Presentation_Feedback_Kind :: distinct bit_set[Presentation_Feedback_Kind_Bits; u32]
Viewporter_Error :: enum u32 {
	// the surface already has a viewport object associated
	Viewport_Exists = 0,
}
Viewport_Error :: enum u32 {
	// negative or zero values in width or height
	Bad_Value = 0,
	// destination size is not integer
	Bad_Size = 1,
	// source rectangle extends outside of the content area
	Out_Of_Buffer = 2,
	// the wl_surface was destroyed
	No_Surface = 3,
}
Alpha_Modifier_V1_Error :: enum u32 {
	// wl_surface already has a alpha modifier object
	Already_Constructed = 0,
}
Alpha_Modifier_Surface_V1_Error :: enum u32 {
	// wl_surface was destroyed
	No_Surface = 0,
}
Color_Manager_V1_Error :: enum u32 {
	// request not supported
	Unsupported_Feature = 0,
	// color management surface exists already
	Surface_Exists = 1,
}
Color_Manager_V1_Render_Intent :: enum u32 {
	// perceptual
	Perceptual = 0,
	// media-relative colorimetric
	Relative = 1,
	// saturation
	Saturation = 2,
	// ICC-absolute colorimetric
	Absolute = 3,
	// media-relative colorimetric + black point compensation
	Relative_Bpc = 4,
	Absolute_No_Adaptation = 5,
}
Color_Manager_V1_Feature :: enum u32 {
	// create_icc_creator request
	Icc_V2_V4 = 0,
	// create_parametric_creator request
	Parametric = 1,
	// parametric set_primaries request
	Set_Primaries = 2,
	// parametric set_tf_power request
	Set_Tf_Power = 3,
	// parametric set_luminances request
	Set_Luminances = 4,
	Set_Mastering_Display_Primaries = 5,
	Extended_Target_Volume = 6,
	// create_windows_scrgb request
	Windows_Scrgb = 7,
}
Color_Manager_V1_Primaries :: enum u32 {
	Srgb = 1,
	Pal_M = 2,
	Pal = 3,
	Ntsc = 4,
	Generic_Film = 5,
	Bt2020 = 6,
	Cie1931_Xyz = 7,
	Dci_P3 = 8,
	Display_P3 = 9,
	Adobe_Rgb = 10,
}
Color_Manager_V1_Transfer_Function :: enum u32 {
	Bt1886 = 1,
	Gamma22 = 2,
	Gamma28 = 3,
	St240 = 4,
	Ext_Linear = 5,
	Log_100 = 6,
	Log_316 = 7,
	Xvycc = 8,
	Srgb = 9,
	Ext_Srgb = 10,
	St2084_Pq = 11,
	St428 = 12,
	Hlg = 13,
	Compound_Power_2_4 = 14,
}
Color_Management_Surface_V1_Error :: enum u32 {
	// unsupported rendering intent
	Render_Intent = 0,
	// invalid image description
	Image_Description = 1,
	// forbidden request on inert object
	Inert = 2,
}
Color_Management_Surface_Feedback_V1_Error :: enum u32 {
	// forbidden request on inert object
	Inert = 0,
	// attempted to use an unsupported feature
	Unsupported_Feature = 1,
}
Image_Description_Creator_Icc_V1_Error :: enum u32 {
	// incomplete parameter set
	Incomplete_Set = 0,
	// property already set
	Already_Set = 1,
	// fd not seekable and readable
	Bad_Fd = 2,
	// no or too much data
	Bad_Size = 3,
	// offset + length exceeds file size
	Out_Of_File = 4,
}
Image_Description_Creator_Params_V1_Error :: enum u32 {
	// incomplete parameter set
	Incomplete_Set = 0,
	// property already set
	Already_Set = 1,
	// request not supported
	Unsupported_Feature = 2,
	// invalid transfer characteristic
	Invalid_Tf = 3,
	// invalid primaries named
	Invalid_Primaries_Named = 4,
	// invalid luminance value or range
	Invalid_Luminance = 5,
}
Image_Description_V1_Error :: enum u32 {
	// attempted to use an object which is not ready
	Not_Ready = 0,
	// get_information not allowed
	No_Information = 1,
}
Image_Description_V1_Cause :: enum u32 {
	// interface version too low
	Low_Version = 0,
	// unsupported image description data
	Unsupported = 1,
	// error independent of the client
	Operating_System = 2,
	// the relevant output no longer exists
	No_Output = 3,
}
Color_Representation_Manager_V1_Error :: enum u32 {
	// color representation surface exists already
	Surface_Exists = 1,
}
Color_Representation_Surface_V1_Error :: enum u32 {
	// unsupported alpha mode
	Alpha_Mode = 1,
	// unsupported coefficients
	Coefficients = 2,
	// the pixel format and a set value are incompatible
	Pixel_Format = 3,
	// forbidden request on inert object
	Inert = 4,
	// invalid chroma location
	Chroma_Location = 5,
}
Color_Representation_Surface_V1_Alpha_Mode :: enum u32 {
	Premultiplied_Electrical = 0,
	Premultiplied_Optical = 1,
	Straight = 2,
}
Color_Representation_Surface_V1_Coefficients :: enum u32 {
	Identity = 1,
	Bt709 = 2,
	Fcc = 3,
	Bt601 = 4,
	Smpte240 = 5,
	Bt2020 = 6,
	Bt2020_Cl = 7,
	Ictcp = 8,
}
Color_Representation_Surface_V1_Range :: enum u32 {
	// Full color range
	Full = 1,
	// Limited color range
	Limited = 2,
}
Color_Representation_Surface_V1_Chroma_Location :: enum u32 {
	Type_0 = 1,
	Type_1 = 2,
	Type_2 = 3,
	Type_3 = 4,
	Type_4 = 5,
	Type_5 = 6,
}
Commit_Timing_Manager_V1_Error :: enum u32 {
	// commit timer already exists for surface
	Commit_Timer_Exists = 0,
}
Commit_Timer_V1_Error :: enum u32 {
	// timestamp contains an invalid value
	Invalid_Timestamp = 0,
	// timestamp exists
	Timestamp_Exists = 1,
	// the associated surface no longer exists
	Surface_Destroyed = 2,
}
Content_Type_Manager_V1_Error :: enum u32 {
	// wl_surface already has a content type object
	Already_Constructed = 0,
}
Content_Type_V1_Type :: enum u32 {
	None = 0,
	Photo = 1,
	Video = 2,
	Game = 3,
}
Cursor_Shape_Device_V1_Shape :: enum u32 {
	// default cursor
	Default = 1,
	// a context menu is available for the object under the cursor
	Context_Menu = 2,
	// help is available for the object under the cursor
	Help = 3,
	// pointer that indicates a link or another interactive element
	Pointer = 4,
	// progress indicator
	Progress = 5,
	// program is busy, user should wait
	Wait = 6,
	// a cell or set of cells may be selected
	Cell = 7,
	// simple crosshair
	Crosshair = 8,
	// text may be selected
	Text = 9,
	// vertical text may be selected
	Vertical_Text = 10,
	// drag-and-drop: alias of/shortcut to something is to be created
	Alias = 11,
	// drag-and-drop: something is to be copied
	Copy = 12,
	// drag-and-drop: something is to be moved
	Move = 13,
	// drag-and-drop: the dragged item cannot be dropped at the current cursor location
	No_Drop = 14,
	// drag-and-drop: the requested action will not be carried out
	Not_Allowed = 15,
	// drag-and-drop: something can be grabbed
	Grab = 16,
	// drag-and-drop: something is being grabbed
	Grabbing = 17,
	// resizing: the east border is to be moved
	E_Resize = 18,
	// resizing: the north border is to be moved
	N_Resize = 19,
	// resizing: the north-east corner is to be moved
	Ne_Resize = 20,
	// resizing: the north-west corner is to be moved
	Nw_Resize = 21,
	// resizing: the south border is to be moved
	S_Resize = 22,
	// resizing: the south-east corner is to be moved
	Se_Resize = 23,
	// resizing: the south-west corner is to be moved
	Sw_Resize = 24,
	// resizing: the west border is to be moved
	W_Resize = 25,
	// resizing: the east and west borders are to be moved
	Ew_Resize = 26,
	// resizing: the north and south borders are to be moved
	Ns_Resize = 27,
	// resizing: the north-east and south-west corners are to be moved
	Nesw_Resize = 28,
	// resizing: the north-west and south-east corners are to be moved
	Nwse_Resize = 29,
	// resizing: that the item/column can be resized horizontally
	Col_Resize = 30,
	// resizing: that the item/row can be resized vertically
	Row_Resize = 31,
	// something can be scrolled in any direction
	All_Scroll = 32,
	// something can be zoomed in
	Zoom_In = 33,
	// something can be zoomed out
	Zoom_Out = 34,
	// drag-and-drop: the user will select which action will be carried out (non-css value)
	Dnd_Ask = 35,
	// resizing: something can be moved or resized in any direction (non-css value)
	All_Resize = 36,
}
Cursor_Shape_Device_V1_Error :: enum u32 {
	// the specified shape value is invalid
	Invalid_Shape = 1,
}
Drm_Lease_Request_V1_Error :: enum u32 {
	// requested a connector from a different lease device
	Wrong_Device = 0,
	// requested a connector twice
	Duplicate_Connector = 1,
	// requested a lease without requesting a connector
	Empty_Lease = 2,
}
Fifo_Manager_V1_Error :: enum u32 {
	// fifo manager already exists for surface
	Already_Exists = 0,
}
Fifo_V1_Error :: enum u32 {
	// the associated surface no longer exists
	Surface_Destroyed = 0,
}
Fractional_Scale_Manager_V1_Error :: enum u32 {
	// the surface already has a fractional_scale object associated
	Fractional_Scale_Exists = 0,
}
Linux_Drm_Syncobj_Manager_V1_Error :: enum u32 {
	// the surface already has a synchronization object associated
	Surface_Exists = 0,
	// the timeline object could not be imported
	Invalid_Timeline = 1,
}
Linux_Drm_Syncobj_Surface_V1_Error :: enum u32 {
	// the associated wl_surface was destroyed
	No_Surface = 1,
	// the buffer does not support explicit synchronization
	Unsupported_Buffer = 2,
	// no buffer was attached
	No_Buffer = 3,
	// no acquire timeline point was set
	No_Acquire_Point = 4,
	// no release timeline point was set
	No_Release_Point = 5,
	// acquire and release timeline points are in conflict
	Conflicting_Points = 6,
}
Security_Context_Manager_V1_Error :: enum u32 {
	// listening socket FD is invalid
	Invalid_Listen_Fd = 1,
	// nested security contexts are forbidden
	Nested = 2,
}
Security_Context_V1_Error :: enum u32 {
	// security context has already been committed
	Already_Used = 1,
	// metadata has already been set
	Already_Set = 2,
	// metadata is invalid
	Invalid_Metadata = 3,
}
Tearing_Control_Manager_V1_Error :: enum u32 {
	// the surface already has a tearing object associated
	Tearing_Control_Exists = 0,
}
Tearing_Control_V1_Presentation_Hint :: enum u32 {
	Vsync = 0,
	Async = 1,
}

presentation_destroy :: proc(connection: ^Connection, presentation: Presentation) {
	_size: u16 = 8
	presentation := presentation
	_buffer_write_ptr(&connection.buffer_out, &presentation, size_of(presentation))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_presentation@", presentation, ".destroy:")
	return
}
presentation_feedback :: proc(connection: ^Connection, presentation: Presentation, surface: wl.Surface) -> (callback: Presentation_Feedback) {
	_size: u16 = 8 + size_of(surface) + size_of(callback)
	presentation := presentation
	_buffer_write_ptr(&connection.buffer_out, &presentation, size_of(presentation))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	callback = auto_cast _generate_id(connection, .Wp_Presentation_Feedback)
	_buffer_write_ptr(&connection.buffer_out, &callback, size_of(callback))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_presentation@", presentation, ".feedback:", " surface=", surface, " callback=", callback)
	return
}
viewporter_destroy :: proc(connection: ^Connection, viewporter: Viewporter) {
	_size: u16 = 8
	viewporter := viewporter
	_buffer_write_ptr(&connection.buffer_out, &viewporter, size_of(viewporter))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_viewporter@", viewporter, ".destroy:")
	return
}
viewporter_get_viewport :: proc(connection: ^Connection, viewporter: Viewporter, surface: wl.Surface) -> (id: Viewport) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	viewporter := viewporter
	_buffer_write_ptr(&connection.buffer_out, &viewporter, size_of(viewporter))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Viewport)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_viewporter@", viewporter, ".get_viewport:", " id=", id, " surface=", surface)
	return
}
viewport_destroy :: proc(connection: ^Connection, viewport: Viewport) {
	_size: u16 = 8
	viewport := viewport
	_buffer_write_ptr(&connection.buffer_out, &viewport, size_of(viewport))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_viewport@", viewport, ".destroy:")
	return
}
viewport_set_source :: proc(connection: ^Connection, viewport: Viewport, x: f64, y: f64, width: f64, height: f64) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	viewport := viewport
	_buffer_write_ptr(&connection.buffer_out, &viewport, size_of(viewport))
	opcode: u16 = 1
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
	if connection.log_fn != nil do _debug_log(connection, "-> wp_viewport@", viewport, ".set_source:", " x=", x, " y=", y, " width=", width, " height=", height)
	return
}
viewport_set_destination :: proc(connection: ^Connection, viewport: Viewport, width: i32, height: i32) {
	_size: u16 = 8 + size_of(width) + size_of(height)
	viewport := viewport
	_buffer_write_ptr(&connection.buffer_out, &viewport, size_of(viewport))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_viewport@", viewport, ".set_destination:", " width=", width, " height=", height)
	return
}
alpha_modifier_v1_destroy :: proc(connection: ^Connection, alpha_modifier_v1: Alpha_Modifier_V1) {
	_size: u16 = 8
	alpha_modifier_v1 := alpha_modifier_v1
	_buffer_write_ptr(&connection.buffer_out, &alpha_modifier_v1, size_of(alpha_modifier_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_alpha_modifier_v1@", alpha_modifier_v1, ".destroy:")
	return
}
alpha_modifier_v1_get_surface :: proc(connection: ^Connection, alpha_modifier_v1: Alpha_Modifier_V1, surface: wl.Surface) -> (id: Alpha_Modifier_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	alpha_modifier_v1 := alpha_modifier_v1
	_buffer_write_ptr(&connection.buffer_out, &alpha_modifier_v1, size_of(alpha_modifier_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Alpha_Modifier_Surface_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_alpha_modifier_v1@", alpha_modifier_v1, ".get_surface:", " id=", id, " surface=", surface)
	return
}
alpha_modifier_surface_v1_destroy :: proc(connection: ^Connection, alpha_modifier_surface_v1: Alpha_Modifier_Surface_V1) {
	_size: u16 = 8
	alpha_modifier_surface_v1 := alpha_modifier_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &alpha_modifier_surface_v1, size_of(alpha_modifier_surface_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_alpha_modifier_surface_v1@", alpha_modifier_surface_v1, ".destroy:")
	return
}
alpha_modifier_surface_v1_set_multiplier :: proc(connection: ^Connection, alpha_modifier_surface_v1: Alpha_Modifier_Surface_V1, factor: u32) {
	_size: u16 = 8 + size_of(factor)
	alpha_modifier_surface_v1 := alpha_modifier_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &alpha_modifier_surface_v1, size_of(alpha_modifier_surface_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	factor := factor
	_buffer_write_ptr(&connection.buffer_out, &factor, size_of(factor))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_alpha_modifier_surface_v1@", alpha_modifier_surface_v1, ".set_multiplier:", " factor=", factor)
	return
}
color_manager_v1_destroy :: proc(connection: ^Connection, color_manager_v1: Color_Manager_V1) {
	_size: u16 = 8
	color_manager_v1 := color_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_manager_v1, size_of(color_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_manager_v1@", color_manager_v1, ".destroy:")
	return
}
color_manager_v1_get_output :: proc(connection: ^Connection, color_manager_v1: Color_Manager_V1, output: wl.Output) -> (id: Color_Management_Output_V1) {
	_size: u16 = 8 + size_of(id) + size_of(output)
	color_manager_v1 := color_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_manager_v1, size_of(color_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Color_Management_Output_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	output := output
	_buffer_write_ptr(&connection.buffer_out, &output, size_of(output))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_manager_v1@", color_manager_v1, ".get_output:", " id=", id, " output=", output)
	return
}
color_manager_v1_get_surface :: proc(connection: ^Connection, color_manager_v1: Color_Manager_V1, surface: wl.Surface) -> (id: Color_Management_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	color_manager_v1 := color_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_manager_v1, size_of(color_manager_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Color_Management_Surface_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_manager_v1@", color_manager_v1, ".get_surface:", " id=", id, " surface=", surface)
	return
}
color_manager_v1_get_surface_feedback :: proc(connection: ^Connection, color_manager_v1: Color_Manager_V1, surface: wl.Surface) -> (id: Color_Management_Surface_Feedback_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	color_manager_v1 := color_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_manager_v1, size_of(color_manager_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Color_Management_Surface_Feedback_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_manager_v1@", color_manager_v1, ".get_surface_feedback:", " id=", id, " surface=", surface)
	return
}
color_manager_v1_create_icc_creator :: proc(connection: ^Connection, color_manager_v1: Color_Manager_V1) -> (obj: Image_Description_Creator_Icc_V1) {
	_size: u16 = 8 + size_of(obj)
	color_manager_v1 := color_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_manager_v1, size_of(color_manager_v1))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	obj = auto_cast _generate_id(connection, .Wp_Image_Description_Creator_Icc_V1)
	_buffer_write_ptr(&connection.buffer_out, &obj, size_of(obj))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_manager_v1@", color_manager_v1, ".create_icc_creator:", " obj=", obj)
	return
}
color_manager_v1_create_parametric_creator :: proc(connection: ^Connection, color_manager_v1: Color_Manager_V1) -> (obj: Image_Description_Creator_Params_V1) {
	_size: u16 = 8 + size_of(obj)
	color_manager_v1 := color_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_manager_v1, size_of(color_manager_v1))
	opcode: u16 = 5
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	obj = auto_cast _generate_id(connection, .Wp_Image_Description_Creator_Params_V1)
	_buffer_write_ptr(&connection.buffer_out, &obj, size_of(obj))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_manager_v1@", color_manager_v1, ".create_parametric_creator:", " obj=", obj)
	return
}
color_manager_v1_create_windows_scrgb :: proc(connection: ^Connection, color_manager_v1: Color_Manager_V1) -> (image_description: Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	color_manager_v1 := color_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_manager_v1, size_of(color_manager_v1))
	opcode: u16 = 6
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	image_description = auto_cast _generate_id(connection, .Wp_Image_Description_V1)
	_buffer_write_ptr(&connection.buffer_out, &image_description, size_of(image_description))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_manager_v1@", color_manager_v1, ".create_windows_scrgb:", " image_description=", image_description)
	return
}
color_manager_v1_get_image_description :: proc(connection: ^Connection, color_manager_v1: Color_Manager_V1, reference: Image_Description_Reference_V1) -> (image_description: Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description) + size_of(reference)
	color_manager_v1 := color_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_manager_v1, size_of(color_manager_v1))
	opcode: u16 = 7
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	image_description = auto_cast _generate_id(connection, .Wp_Image_Description_V1)
	_buffer_write_ptr(&connection.buffer_out, &image_description, size_of(image_description))
	reference := reference
	_buffer_write_ptr(&connection.buffer_out, &reference, size_of(reference))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_manager_v1@", color_manager_v1, ".get_image_description:", " image_description=", image_description, " reference=", reference)
	return
}
color_management_output_v1_destroy :: proc(connection: ^Connection, color_management_output_v1: Color_Management_Output_V1) {
	_size: u16 = 8
	color_management_output_v1 := color_management_output_v1
	_buffer_write_ptr(&connection.buffer_out, &color_management_output_v1, size_of(color_management_output_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_management_output_v1@", color_management_output_v1, ".destroy:")
	return
}
color_management_output_v1_get_image_description :: proc(connection: ^Connection, color_management_output_v1: Color_Management_Output_V1) -> (image_description: Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	color_management_output_v1 := color_management_output_v1
	_buffer_write_ptr(&connection.buffer_out, &color_management_output_v1, size_of(color_management_output_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	image_description = auto_cast _generate_id(connection, .Wp_Image_Description_V1)
	_buffer_write_ptr(&connection.buffer_out, &image_description, size_of(image_description))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_management_output_v1@", color_management_output_v1, ".get_image_description:", " image_description=", image_description)
	return
}
color_management_surface_v1_destroy :: proc(connection: ^Connection, color_management_surface_v1: Color_Management_Surface_V1) {
	_size: u16 = 8
	color_management_surface_v1 := color_management_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &color_management_surface_v1, size_of(color_management_surface_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_management_surface_v1@", color_management_surface_v1, ".destroy:")
	return
}
color_management_surface_v1_set_image_description :: proc(connection: ^Connection, color_management_surface_v1: Color_Management_Surface_V1, image_description: Image_Description_V1, render_intent: Color_Manager_V1_Render_Intent) {
	_size: u16 = 8 + size_of(image_description) + size_of(render_intent)
	color_management_surface_v1 := color_management_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &color_management_surface_v1, size_of(color_management_surface_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	image_description := image_description
	_buffer_write_ptr(&connection.buffer_out, &image_description, size_of(image_description))
	render_intent := render_intent
	_buffer_write_ptr(&connection.buffer_out, &render_intent, size_of(render_intent))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_management_surface_v1@", color_management_surface_v1, ".set_image_description:", " image_description=", image_description, " render_intent=", render_intent)
	return
}
color_management_surface_v1_unset_image_description :: proc(connection: ^Connection, color_management_surface_v1: Color_Management_Surface_V1) {
	_size: u16 = 8
	color_management_surface_v1 := color_management_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &color_management_surface_v1, size_of(color_management_surface_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_management_surface_v1@", color_management_surface_v1, ".unset_image_description:")
	return
}
color_management_surface_feedback_v1_destroy :: proc(connection: ^Connection, color_management_surface_feedback_v1: Color_Management_Surface_Feedback_V1) {
	_size: u16 = 8
	color_management_surface_feedback_v1 := color_management_surface_feedback_v1
	_buffer_write_ptr(&connection.buffer_out, &color_management_surface_feedback_v1, size_of(color_management_surface_feedback_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_management_surface_feedback_v1@", color_management_surface_feedback_v1, ".destroy:")
	return
}
color_management_surface_feedback_v1_get_preferred :: proc(connection: ^Connection, color_management_surface_feedback_v1: Color_Management_Surface_Feedback_V1) -> (image_description: Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	color_management_surface_feedback_v1 := color_management_surface_feedback_v1
	_buffer_write_ptr(&connection.buffer_out, &color_management_surface_feedback_v1, size_of(color_management_surface_feedback_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	image_description = auto_cast _generate_id(connection, .Wp_Image_Description_V1)
	_buffer_write_ptr(&connection.buffer_out, &image_description, size_of(image_description))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_management_surface_feedback_v1@", color_management_surface_feedback_v1, ".get_preferred:", " image_description=", image_description)
	return
}
color_management_surface_feedback_v1_get_preferred_parametric :: proc(connection: ^Connection, color_management_surface_feedback_v1: Color_Management_Surface_Feedback_V1) -> (image_description: Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	color_management_surface_feedback_v1 := color_management_surface_feedback_v1
	_buffer_write_ptr(&connection.buffer_out, &color_management_surface_feedback_v1, size_of(color_management_surface_feedback_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	image_description = auto_cast _generate_id(connection, .Wp_Image_Description_V1)
	_buffer_write_ptr(&connection.buffer_out, &image_description, size_of(image_description))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_management_surface_feedback_v1@", color_management_surface_feedback_v1, ".get_preferred_parametric:", " image_description=", image_description)
	return
}
image_description_creator_icc_v1_create :: proc(connection: ^Connection, image_description_creator_icc_v1: Image_Description_Creator_Icc_V1) -> (image_description: Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	image_description_creator_icc_v1 := image_description_creator_icc_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_icc_v1, size_of(image_description_creator_icc_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	image_description = auto_cast _generate_id(connection, .Wp_Image_Description_V1)
	_buffer_write_ptr(&connection.buffer_out, &image_description, size_of(image_description))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_icc_v1@", image_description_creator_icc_v1, ".create:", " image_description=", image_description)
	return
}
image_description_creator_icc_v1_set_icc_file :: proc(connection: ^Connection, image_description_creator_icc_v1: Image_Description_Creator_Icc_V1, icc_profile: Fd, offset: u32, length: u32) {
	_size: u16 = 8 + size_of(offset) + size_of(length)
	image_description_creator_icc_v1 := image_description_creator_icc_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_icc_v1, size_of(image_description_creator_icc_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	append(&connection.fds_out, icc_profile)
	offset := offset
	_buffer_write_ptr(&connection.buffer_out, &offset, size_of(offset))
	length := length
	_buffer_write_ptr(&connection.buffer_out, &length, size_of(length))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_icc_v1@", image_description_creator_icc_v1, ".set_icc_file:", " icc_profile=", icc_profile, " offset=", offset, " length=", length)
	return
}
image_description_creator_params_v1_create :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1) -> (image_description: Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	image_description = auto_cast _generate_id(connection, .Wp_Image_Description_V1)
	_buffer_write_ptr(&connection.buffer_out, &image_description, size_of(image_description))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".create:", " image_description=", image_description)
	return
}
image_description_creator_params_v1_set_tf_named :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, tf: Color_Manager_V1_Transfer_Function) {
	_size: u16 = 8 + size_of(tf)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	tf := tf
	_buffer_write_ptr(&connection.buffer_out, &tf, size_of(tf))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_tf_named:", " tf=", tf)
	return
}
image_description_creator_params_v1_set_tf_power :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, eexp: u32) {
	_size: u16 = 8 + size_of(eexp)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	eexp := eexp
	_buffer_write_ptr(&connection.buffer_out, &eexp, size_of(eexp))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_tf_power:", " eexp=", eexp)
	return
}
image_description_creator_params_v1_set_primaries_named :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, primaries: Color_Manager_V1_Primaries) {
	_size: u16 = 8 + size_of(primaries)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	primaries := primaries
	_buffer_write_ptr(&connection.buffer_out, &primaries, size_of(primaries))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_primaries_named:", " primaries=", primaries)
	return
}
image_description_creator_params_v1_set_primaries :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, r_x: i32, r_y: i32, g_x: i32, g_y: i32, b_x: i32, b_y: i32, w_x: i32, w_y: i32) {
	_size: u16 = 8 + size_of(r_x) + size_of(r_y) + size_of(g_x) + size_of(g_y) + size_of(b_x) + size_of(b_y) + size_of(w_x) + size_of(w_y)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	r_x := r_x
	_buffer_write_ptr(&connection.buffer_out, &r_x, size_of(r_x))
	r_y := r_y
	_buffer_write_ptr(&connection.buffer_out, &r_y, size_of(r_y))
	g_x := g_x
	_buffer_write_ptr(&connection.buffer_out, &g_x, size_of(g_x))
	g_y := g_y
	_buffer_write_ptr(&connection.buffer_out, &g_y, size_of(g_y))
	b_x := b_x
	_buffer_write_ptr(&connection.buffer_out, &b_x, size_of(b_x))
	b_y := b_y
	_buffer_write_ptr(&connection.buffer_out, &b_y, size_of(b_y))
	w_x := w_x
	_buffer_write_ptr(&connection.buffer_out, &w_x, size_of(w_x))
	w_y := w_y
	_buffer_write_ptr(&connection.buffer_out, &w_y, size_of(w_y))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_primaries:", " r_x=", r_x, " r_y=", r_y, " g_x=", g_x, " g_y=", g_y, " b_x=", b_x, " b_y=", b_y, " w_x=", w_x, " w_y=", w_y)
	return
}
image_description_creator_params_v1_set_luminances :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, min_lum: u32, max_lum: u32, reference_lum: u32) {
	_size: u16 = 8 + size_of(min_lum) + size_of(max_lum) + size_of(reference_lum)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 5
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	min_lum := min_lum
	_buffer_write_ptr(&connection.buffer_out, &min_lum, size_of(min_lum))
	max_lum := max_lum
	_buffer_write_ptr(&connection.buffer_out, &max_lum, size_of(max_lum))
	reference_lum := reference_lum
	_buffer_write_ptr(&connection.buffer_out, &reference_lum, size_of(reference_lum))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_luminances:", " min_lum=", min_lum, " max_lum=", max_lum, " reference_lum=", reference_lum)
	return
}
image_description_creator_params_v1_set_mastering_display_primaries :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, r_x: i32, r_y: i32, g_x: i32, g_y: i32, b_x: i32, b_y: i32, w_x: i32, w_y: i32) {
	_size: u16 = 8 + size_of(r_x) + size_of(r_y) + size_of(g_x) + size_of(g_y) + size_of(b_x) + size_of(b_y) + size_of(w_x) + size_of(w_y)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 6
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	r_x := r_x
	_buffer_write_ptr(&connection.buffer_out, &r_x, size_of(r_x))
	r_y := r_y
	_buffer_write_ptr(&connection.buffer_out, &r_y, size_of(r_y))
	g_x := g_x
	_buffer_write_ptr(&connection.buffer_out, &g_x, size_of(g_x))
	g_y := g_y
	_buffer_write_ptr(&connection.buffer_out, &g_y, size_of(g_y))
	b_x := b_x
	_buffer_write_ptr(&connection.buffer_out, &b_x, size_of(b_x))
	b_y := b_y
	_buffer_write_ptr(&connection.buffer_out, &b_y, size_of(b_y))
	w_x := w_x
	_buffer_write_ptr(&connection.buffer_out, &w_x, size_of(w_x))
	w_y := w_y
	_buffer_write_ptr(&connection.buffer_out, &w_y, size_of(w_y))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_mastering_display_primaries:", " r_x=", r_x, " r_y=", r_y, " g_x=", g_x, " g_y=", g_y, " b_x=", b_x, " b_y=", b_y, " w_x=", w_x, " w_y=", w_y)
	return
}
image_description_creator_params_v1_set_mastering_luminance :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, min_lum: u32, max_lum: u32) {
	_size: u16 = 8 + size_of(min_lum) + size_of(max_lum)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 7
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	min_lum := min_lum
	_buffer_write_ptr(&connection.buffer_out, &min_lum, size_of(min_lum))
	max_lum := max_lum
	_buffer_write_ptr(&connection.buffer_out, &max_lum, size_of(max_lum))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_mastering_luminance:", " min_lum=", min_lum, " max_lum=", max_lum)
	return
}
image_description_creator_params_v1_set_max_cll :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, max_cll: u32) {
	_size: u16 = 8 + size_of(max_cll)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 8
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	max_cll := max_cll
	_buffer_write_ptr(&connection.buffer_out, &max_cll, size_of(max_cll))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_max_cll:", " max_cll=", max_cll)
	return
}
image_description_creator_params_v1_set_max_fall :: proc(connection: ^Connection, image_description_creator_params_v1: Image_Description_Creator_Params_V1, max_fall: u32) {
	_size: u16 = 8 + size_of(max_fall)
	image_description_creator_params_v1 := image_description_creator_params_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_creator_params_v1, size_of(image_description_creator_params_v1))
	opcode: u16 = 9
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	max_fall := max_fall
	_buffer_write_ptr(&connection.buffer_out, &max_fall, size_of(max_fall))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_creator_params_v1@", image_description_creator_params_v1, ".set_max_fall:", " max_fall=", max_fall)
	return
}
image_description_v1_destroy :: proc(connection: ^Connection, image_description_v1: Image_Description_V1) {
	_size: u16 = 8
	image_description_v1 := image_description_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_v1, size_of(image_description_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_v1@", image_description_v1, ".destroy:")
	return
}
image_description_v1_get_information :: proc(connection: ^Connection, image_description_v1: Image_Description_V1) -> (information: Image_Description_Info_V1) {
	_size: u16 = 8 + size_of(information)
	image_description_v1 := image_description_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_v1, size_of(image_description_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	information = auto_cast _generate_id(connection, .Wp_Image_Description_Info_V1)
	_buffer_write_ptr(&connection.buffer_out, &information, size_of(information))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_v1@", image_description_v1, ".get_information:", " information=", information)
	return
}
image_description_reference_v1_destroy :: proc(connection: ^Connection, image_description_reference_v1: Image_Description_Reference_V1) {
	_size: u16 = 8
	image_description_reference_v1 := image_description_reference_v1
	_buffer_write_ptr(&connection.buffer_out, &image_description_reference_v1, size_of(image_description_reference_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_image_description_reference_v1@", image_description_reference_v1, ".destroy:")
	return
}
color_representation_manager_v1_destroy :: proc(connection: ^Connection, color_representation_manager_v1: Color_Representation_Manager_V1) {
	_size: u16 = 8
	color_representation_manager_v1 := color_representation_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_representation_manager_v1, size_of(color_representation_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_representation_manager_v1@", color_representation_manager_v1, ".destroy:")
	return
}
color_representation_manager_v1_get_surface :: proc(connection: ^Connection, color_representation_manager_v1: Color_Representation_Manager_V1, surface: wl.Surface) -> (id: Color_Representation_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	color_representation_manager_v1 := color_representation_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &color_representation_manager_v1, size_of(color_representation_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Color_Representation_Surface_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_representation_manager_v1@", color_representation_manager_v1, ".get_surface:", " id=", id, " surface=", surface)
	return
}
color_representation_surface_v1_destroy :: proc(connection: ^Connection, color_representation_surface_v1: Color_Representation_Surface_V1) {
	_size: u16 = 8
	color_representation_surface_v1 := color_representation_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &color_representation_surface_v1, size_of(color_representation_surface_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_representation_surface_v1@", color_representation_surface_v1, ".destroy:")
	return
}
color_representation_surface_v1_set_alpha_mode :: proc(connection: ^Connection, color_representation_surface_v1: Color_Representation_Surface_V1, alpha_mode: Color_Representation_Surface_V1_Alpha_Mode) {
	_size: u16 = 8 + size_of(alpha_mode)
	color_representation_surface_v1 := color_representation_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &color_representation_surface_v1, size_of(color_representation_surface_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	alpha_mode := alpha_mode
	_buffer_write_ptr(&connection.buffer_out, &alpha_mode, size_of(alpha_mode))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_representation_surface_v1@", color_representation_surface_v1, ".set_alpha_mode:", " alpha_mode=", alpha_mode)
	return
}
color_representation_surface_v1_set_coefficients_and_range :: proc(connection: ^Connection, color_representation_surface_v1: Color_Representation_Surface_V1, coefficients: Color_Representation_Surface_V1_Coefficients, range: Color_Representation_Surface_V1_Range) {
	_size: u16 = 8 + size_of(coefficients) + size_of(range)
	color_representation_surface_v1 := color_representation_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &color_representation_surface_v1, size_of(color_representation_surface_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	coefficients := coefficients
	_buffer_write_ptr(&connection.buffer_out, &coefficients, size_of(coefficients))
	range := range
	_buffer_write_ptr(&connection.buffer_out, &range, size_of(range))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_representation_surface_v1@", color_representation_surface_v1, ".set_coefficients_and_range:", " coefficients=", coefficients, " range=", range)
	return
}
color_representation_surface_v1_set_chroma_location :: proc(connection: ^Connection, color_representation_surface_v1: Color_Representation_Surface_V1, chroma_location: Color_Representation_Surface_V1_Chroma_Location) {
	_size: u16 = 8 + size_of(chroma_location)
	color_representation_surface_v1 := color_representation_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &color_representation_surface_v1, size_of(color_representation_surface_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	chroma_location := chroma_location
	_buffer_write_ptr(&connection.buffer_out, &chroma_location, size_of(chroma_location))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_color_representation_surface_v1@", color_representation_surface_v1, ".set_chroma_location:", " chroma_location=", chroma_location)
	return
}
commit_timing_manager_v1_destroy :: proc(connection: ^Connection, commit_timing_manager_v1: Commit_Timing_Manager_V1) {
	_size: u16 = 8
	commit_timing_manager_v1 := commit_timing_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &commit_timing_manager_v1, size_of(commit_timing_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_commit_timing_manager_v1@", commit_timing_manager_v1, ".destroy:")
	return
}
commit_timing_manager_v1_get_timer :: proc(connection: ^Connection, commit_timing_manager_v1: Commit_Timing_Manager_V1, surface: wl.Surface) -> (id: Commit_Timer_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	commit_timing_manager_v1 := commit_timing_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &commit_timing_manager_v1, size_of(commit_timing_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Commit_Timer_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_commit_timing_manager_v1@", commit_timing_manager_v1, ".get_timer:", " id=", id, " surface=", surface)
	return
}
commit_timer_v1_set_timestamp :: proc(connection: ^Connection, commit_timer_v1: Commit_Timer_V1, tv_sec_hi: u32, tv_sec_lo: u32, tv_nsec: u32) {
	_size: u16 = 8 + size_of(tv_sec_hi) + size_of(tv_sec_lo) + size_of(tv_nsec)
	commit_timer_v1 := commit_timer_v1
	_buffer_write_ptr(&connection.buffer_out, &commit_timer_v1, size_of(commit_timer_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	tv_sec_hi := tv_sec_hi
	_buffer_write_ptr(&connection.buffer_out, &tv_sec_hi, size_of(tv_sec_hi))
	tv_sec_lo := tv_sec_lo
	_buffer_write_ptr(&connection.buffer_out, &tv_sec_lo, size_of(tv_sec_lo))
	tv_nsec := tv_nsec
	_buffer_write_ptr(&connection.buffer_out, &tv_nsec, size_of(tv_nsec))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_commit_timer_v1@", commit_timer_v1, ".set_timestamp:", " tv_sec_hi=", tv_sec_hi, " tv_sec_lo=", tv_sec_lo, " tv_nsec=", tv_nsec)
	return
}
commit_timer_v1_destroy :: proc(connection: ^Connection, commit_timer_v1: Commit_Timer_V1) {
	_size: u16 = 8
	commit_timer_v1 := commit_timer_v1
	_buffer_write_ptr(&connection.buffer_out, &commit_timer_v1, size_of(commit_timer_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_commit_timer_v1@", commit_timer_v1, ".destroy:")
	return
}
content_type_manager_v1_destroy :: proc(connection: ^Connection, content_type_manager_v1: Content_Type_Manager_V1) {
	_size: u16 = 8
	content_type_manager_v1 := content_type_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &content_type_manager_v1, size_of(content_type_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_content_type_manager_v1@", content_type_manager_v1, ".destroy:")
	return
}
content_type_manager_v1_get_surface_content_type :: proc(connection: ^Connection, content_type_manager_v1: Content_Type_Manager_V1, surface: wl.Surface) -> (id: Content_Type_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	content_type_manager_v1 := content_type_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &content_type_manager_v1, size_of(content_type_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Content_Type_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_content_type_manager_v1@", content_type_manager_v1, ".get_surface_content_type:", " id=", id, " surface=", surface)
	return
}
content_type_v1_destroy :: proc(connection: ^Connection, content_type_v1: Content_Type_V1) {
	_size: u16 = 8
	content_type_v1 := content_type_v1
	_buffer_write_ptr(&connection.buffer_out, &content_type_v1, size_of(content_type_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_content_type_v1@", content_type_v1, ".destroy:")
	return
}
content_type_v1_set_content_type :: proc(connection: ^Connection, content_type_v1: Content_Type_V1, content_type: Content_Type_V1_Type) {
	_size: u16 = 8 + size_of(content_type)
	content_type_v1 := content_type_v1
	_buffer_write_ptr(&connection.buffer_out, &content_type_v1, size_of(content_type_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	content_type := content_type
	_buffer_write_ptr(&connection.buffer_out, &content_type, size_of(content_type))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_content_type_v1@", content_type_v1, ".set_content_type:", " content_type=", content_type)
	return
}
cursor_shape_manager_v1_destroy :: proc(connection: ^Connection, cursor_shape_manager_v1: Cursor_Shape_Manager_V1) {
	_size: u16 = 8
	cursor_shape_manager_v1 := cursor_shape_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &cursor_shape_manager_v1, size_of(cursor_shape_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_cursor_shape_manager_v1@", cursor_shape_manager_v1, ".destroy:")
	return
}
cursor_shape_manager_v1_get_pointer :: proc(connection: ^Connection, cursor_shape_manager_v1: Cursor_Shape_Manager_V1, pointer: wl.Pointer) -> (cursor_shape_device: Cursor_Shape_Device_V1) {
	_size: u16 = 8 + size_of(cursor_shape_device) + size_of(pointer)
	cursor_shape_manager_v1 := cursor_shape_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &cursor_shape_manager_v1, size_of(cursor_shape_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	cursor_shape_device = auto_cast _generate_id(connection, .Wp_Cursor_Shape_Device_V1)
	_buffer_write_ptr(&connection.buffer_out, &cursor_shape_device, size_of(cursor_shape_device))
	pointer := pointer
	_buffer_write_ptr(&connection.buffer_out, &pointer, size_of(pointer))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_cursor_shape_manager_v1@", cursor_shape_manager_v1, ".get_pointer:", " cursor_shape_device=", cursor_shape_device, " pointer=", pointer)
	return
}
cursor_shape_manager_v1_get_tablet_tool_v2 :: proc(connection: ^Connection, cursor_shape_manager_v1: Cursor_Shape_Manager_V1, tablet_tool: zwp.Tablet_Tool_V2) -> (cursor_shape_device: Cursor_Shape_Device_V1) {
	_size: u16 = 8 + size_of(cursor_shape_device) + size_of(tablet_tool)
	cursor_shape_manager_v1 := cursor_shape_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &cursor_shape_manager_v1, size_of(cursor_shape_manager_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	cursor_shape_device = auto_cast _generate_id(connection, .Wp_Cursor_Shape_Device_V1)
	_buffer_write_ptr(&connection.buffer_out, &cursor_shape_device, size_of(cursor_shape_device))
	tablet_tool := tablet_tool
	_buffer_write_ptr(&connection.buffer_out, &tablet_tool, size_of(tablet_tool))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_cursor_shape_manager_v1@", cursor_shape_manager_v1, ".get_tablet_tool_v2:", " cursor_shape_device=", cursor_shape_device, " tablet_tool=", tablet_tool)
	return
}
cursor_shape_device_v1_destroy :: proc(connection: ^Connection, cursor_shape_device_v1: Cursor_Shape_Device_V1) {
	_size: u16 = 8
	cursor_shape_device_v1 := cursor_shape_device_v1
	_buffer_write_ptr(&connection.buffer_out, &cursor_shape_device_v1, size_of(cursor_shape_device_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_cursor_shape_device_v1@", cursor_shape_device_v1, ".destroy:")
	return
}
cursor_shape_device_v1_set_shape :: proc(connection: ^Connection, cursor_shape_device_v1: Cursor_Shape_Device_V1, serial: u32, shape: Cursor_Shape_Device_V1_Shape) {
	_size: u16 = 8 + size_of(serial) + size_of(shape)
	cursor_shape_device_v1 := cursor_shape_device_v1
	_buffer_write_ptr(&connection.buffer_out, &cursor_shape_device_v1, size_of(cursor_shape_device_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	shape := shape
	_buffer_write_ptr(&connection.buffer_out, &shape, size_of(shape))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_cursor_shape_device_v1@", cursor_shape_device_v1, ".set_shape:", " serial=", serial, " shape=", shape)
	return
}
drm_lease_device_v1_create_lease_request :: proc(connection: ^Connection, drm_lease_device_v1: Drm_Lease_Device_V1) -> (id: Drm_Lease_Request_V1) {
	_size: u16 = 8 + size_of(id)
	drm_lease_device_v1 := drm_lease_device_v1
	_buffer_write_ptr(&connection.buffer_out, &drm_lease_device_v1, size_of(drm_lease_device_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Drm_Lease_Request_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_drm_lease_device_v1@", drm_lease_device_v1, ".create_lease_request:", " id=", id)
	return
}
drm_lease_device_v1_release :: proc(connection: ^Connection, drm_lease_device_v1: Drm_Lease_Device_V1) {
	_size: u16 = 8
	drm_lease_device_v1 := drm_lease_device_v1
	_buffer_write_ptr(&connection.buffer_out, &drm_lease_device_v1, size_of(drm_lease_device_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_drm_lease_device_v1@", drm_lease_device_v1, ".release:")
	return
}
drm_lease_connector_v1_destroy :: proc(connection: ^Connection, drm_lease_connector_v1: Drm_Lease_Connector_V1) {
	_size: u16 = 8
	drm_lease_connector_v1 := drm_lease_connector_v1
	_buffer_write_ptr(&connection.buffer_out, &drm_lease_connector_v1, size_of(drm_lease_connector_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_drm_lease_connector_v1@", drm_lease_connector_v1, ".destroy:")
	return
}
drm_lease_request_v1_request_connector :: proc(connection: ^Connection, drm_lease_request_v1: Drm_Lease_Request_V1, connector: Drm_Lease_Connector_V1) {
	_size: u16 = 8 + size_of(connector)
	drm_lease_request_v1 := drm_lease_request_v1
	_buffer_write_ptr(&connection.buffer_out, &drm_lease_request_v1, size_of(drm_lease_request_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	connector := connector
	_buffer_write_ptr(&connection.buffer_out, &connector, size_of(connector))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_drm_lease_request_v1@", drm_lease_request_v1, ".request_connector:", " connector=", connector)
	return
}
drm_lease_request_v1_submit :: proc(connection: ^Connection, drm_lease_request_v1: Drm_Lease_Request_V1) -> (id: Drm_Lease_V1) {
	_size: u16 = 8 + size_of(id)
	drm_lease_request_v1 := drm_lease_request_v1
	_buffer_write_ptr(&connection.buffer_out, &drm_lease_request_v1, size_of(drm_lease_request_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Drm_Lease_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_drm_lease_request_v1@", drm_lease_request_v1, ".submit:", " id=", id)
	return
}
drm_lease_v1_destroy :: proc(connection: ^Connection, drm_lease_v1: Drm_Lease_V1) {
	_size: u16 = 8
	drm_lease_v1 := drm_lease_v1
	_buffer_write_ptr(&connection.buffer_out, &drm_lease_v1, size_of(drm_lease_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_drm_lease_v1@", drm_lease_v1, ".destroy:")
	return
}
fifo_manager_v1_destroy :: proc(connection: ^Connection, fifo_manager_v1: Fifo_Manager_V1) {
	_size: u16 = 8
	fifo_manager_v1 := fifo_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &fifo_manager_v1, size_of(fifo_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_fifo_manager_v1@", fifo_manager_v1, ".destroy:")
	return
}
fifo_manager_v1_get_fifo :: proc(connection: ^Connection, fifo_manager_v1: Fifo_Manager_V1, surface: wl.Surface) -> (id: Fifo_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	fifo_manager_v1 := fifo_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &fifo_manager_v1, size_of(fifo_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Fifo_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_fifo_manager_v1@", fifo_manager_v1, ".get_fifo:", " id=", id, " surface=", surface)
	return
}
fifo_v1_set_barrier :: proc(connection: ^Connection, fifo_v1: Fifo_V1) {
	_size: u16 = 8
	fifo_v1 := fifo_v1
	_buffer_write_ptr(&connection.buffer_out, &fifo_v1, size_of(fifo_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_fifo_v1@", fifo_v1, ".set_barrier:")
	return
}
fifo_v1_wait_barrier :: proc(connection: ^Connection, fifo_v1: Fifo_V1) {
	_size: u16 = 8
	fifo_v1 := fifo_v1
	_buffer_write_ptr(&connection.buffer_out, &fifo_v1, size_of(fifo_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_fifo_v1@", fifo_v1, ".wait_barrier:")
	return
}
fifo_v1_destroy :: proc(connection: ^Connection, fifo_v1: Fifo_V1) {
	_size: u16 = 8
	fifo_v1 := fifo_v1
	_buffer_write_ptr(&connection.buffer_out, &fifo_v1, size_of(fifo_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_fifo_v1@", fifo_v1, ".destroy:")
	return
}
fractional_scale_manager_v1_destroy :: proc(connection: ^Connection, fractional_scale_manager_v1: Fractional_Scale_Manager_V1) {
	_size: u16 = 8
	fractional_scale_manager_v1 := fractional_scale_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &fractional_scale_manager_v1, size_of(fractional_scale_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_fractional_scale_manager_v1@", fractional_scale_manager_v1, ".destroy:")
	return
}
fractional_scale_manager_v1_get_fractional_scale :: proc(connection: ^Connection, fractional_scale_manager_v1: Fractional_Scale_Manager_V1, surface: wl.Surface) -> (id: Fractional_Scale_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	fractional_scale_manager_v1 := fractional_scale_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &fractional_scale_manager_v1, size_of(fractional_scale_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Fractional_Scale_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_fractional_scale_manager_v1@", fractional_scale_manager_v1, ".get_fractional_scale:", " id=", id, " surface=", surface)
	return
}
fractional_scale_v1_destroy :: proc(connection: ^Connection, fractional_scale_v1: Fractional_Scale_V1) {
	_size: u16 = 8
	fractional_scale_v1 := fractional_scale_v1
	_buffer_write_ptr(&connection.buffer_out, &fractional_scale_v1, size_of(fractional_scale_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_fractional_scale_v1@", fractional_scale_v1, ".destroy:")
	return
}
linux_drm_syncobj_manager_v1_destroy :: proc(connection: ^Connection, linux_drm_syncobj_manager_v1: Linux_Drm_Syncobj_Manager_V1) {
	_size: u16 = 8
	linux_drm_syncobj_manager_v1 := linux_drm_syncobj_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_drm_syncobj_manager_v1, size_of(linux_drm_syncobj_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_linux_drm_syncobj_manager_v1@", linux_drm_syncobj_manager_v1, ".destroy:")
	return
}
linux_drm_syncobj_manager_v1_get_surface :: proc(connection: ^Connection, linux_drm_syncobj_manager_v1: Linux_Drm_Syncobj_Manager_V1, surface: wl.Surface) -> (id: Linux_Drm_Syncobj_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	linux_drm_syncobj_manager_v1 := linux_drm_syncobj_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_drm_syncobj_manager_v1, size_of(linux_drm_syncobj_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Linux_Drm_Syncobj_Surface_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_linux_drm_syncobj_manager_v1@", linux_drm_syncobj_manager_v1, ".get_surface:", " id=", id, " surface=", surface)
	return
}
linux_drm_syncobj_manager_v1_import_timeline :: proc(connection: ^Connection, linux_drm_syncobj_manager_v1: Linux_Drm_Syncobj_Manager_V1, fd: Fd) -> (id: Linux_Drm_Syncobj_Timeline_V1) {
	_size: u16 = 8 + size_of(id)
	linux_drm_syncobj_manager_v1 := linux_drm_syncobj_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_drm_syncobj_manager_v1, size_of(linux_drm_syncobj_manager_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Linux_Drm_Syncobj_Timeline_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	append(&connection.fds_out, fd)
	if connection.log_fn != nil do _debug_log(connection, "-> wp_linux_drm_syncobj_manager_v1@", linux_drm_syncobj_manager_v1, ".import_timeline:", " id=", id, " fd=", fd)
	return
}
linux_drm_syncobj_timeline_v1_destroy :: proc(connection: ^Connection, linux_drm_syncobj_timeline_v1: Linux_Drm_Syncobj_Timeline_V1) {
	_size: u16 = 8
	linux_drm_syncobj_timeline_v1 := linux_drm_syncobj_timeline_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_drm_syncobj_timeline_v1, size_of(linux_drm_syncobj_timeline_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_linux_drm_syncobj_timeline_v1@", linux_drm_syncobj_timeline_v1, ".destroy:")
	return
}
linux_drm_syncobj_surface_v1_destroy :: proc(connection: ^Connection, linux_drm_syncobj_surface_v1: Linux_Drm_Syncobj_Surface_V1) {
	_size: u16 = 8
	linux_drm_syncobj_surface_v1 := linux_drm_syncobj_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_drm_syncobj_surface_v1, size_of(linux_drm_syncobj_surface_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_linux_drm_syncobj_surface_v1@", linux_drm_syncobj_surface_v1, ".destroy:")
	return
}
linux_drm_syncobj_surface_v1_set_acquire_point :: proc(connection: ^Connection, linux_drm_syncobj_surface_v1: Linux_Drm_Syncobj_Surface_V1, timeline: Linux_Drm_Syncobj_Timeline_V1, point_hi: u32, point_lo: u32) {
	_size: u16 = 8 + size_of(timeline) + size_of(point_hi) + size_of(point_lo)
	linux_drm_syncobj_surface_v1 := linux_drm_syncobj_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_drm_syncobj_surface_v1, size_of(linux_drm_syncobj_surface_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	timeline := timeline
	_buffer_write_ptr(&connection.buffer_out, &timeline, size_of(timeline))
	point_hi := point_hi
	_buffer_write_ptr(&connection.buffer_out, &point_hi, size_of(point_hi))
	point_lo := point_lo
	_buffer_write_ptr(&connection.buffer_out, &point_lo, size_of(point_lo))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_linux_drm_syncobj_surface_v1@", linux_drm_syncobj_surface_v1, ".set_acquire_point:", " timeline=", timeline, " point_hi=", point_hi, " point_lo=", point_lo)
	return
}
linux_drm_syncobj_surface_v1_set_release_point :: proc(connection: ^Connection, linux_drm_syncobj_surface_v1: Linux_Drm_Syncobj_Surface_V1, timeline: Linux_Drm_Syncobj_Timeline_V1, point_hi: u32, point_lo: u32) {
	_size: u16 = 8 + size_of(timeline) + size_of(point_hi) + size_of(point_lo)
	linux_drm_syncobj_surface_v1 := linux_drm_syncobj_surface_v1
	_buffer_write_ptr(&connection.buffer_out, &linux_drm_syncobj_surface_v1, size_of(linux_drm_syncobj_surface_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	timeline := timeline
	_buffer_write_ptr(&connection.buffer_out, &timeline, size_of(timeline))
	point_hi := point_hi
	_buffer_write_ptr(&connection.buffer_out, &point_hi, size_of(point_hi))
	point_lo := point_lo
	_buffer_write_ptr(&connection.buffer_out, &point_lo, size_of(point_lo))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_linux_drm_syncobj_surface_v1@", linux_drm_syncobj_surface_v1, ".set_release_point:", " timeline=", timeline, " point_hi=", point_hi, " point_lo=", point_lo)
	return
}
pointer_warp_v1_destroy :: proc(connection: ^Connection, pointer_warp_v1: Pointer_Warp_V1) {
	_size: u16 = 8
	pointer_warp_v1 := pointer_warp_v1
	_buffer_write_ptr(&connection.buffer_out, &pointer_warp_v1, size_of(pointer_warp_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_pointer_warp_v1@", pointer_warp_v1, ".destroy:")
	return
}
pointer_warp_v1_warp_pointer :: proc(connection: ^Connection, pointer_warp_v1: Pointer_Warp_V1, surface: wl.Surface, pointer: wl.Pointer, x: f64, y: f64, serial: u32) {
	_size: u16 = 8 + size_of(surface) + size_of(pointer) + size_of(x) + size_of(y) + size_of(serial)
	pointer_warp_v1 := pointer_warp_v1
	_buffer_write_ptr(&connection.buffer_out, &pointer_warp_v1, size_of(pointer_warp_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	pointer := pointer
	_buffer_write_ptr(&connection.buffer_out, &pointer, size_of(pointer))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_pointer_warp_v1@", pointer_warp_v1, ".warp_pointer:", " surface=", surface, " pointer=", pointer, " x=", x, " y=", y, " serial=", serial)
	return
}
security_context_manager_v1_destroy :: proc(connection: ^Connection, security_context_manager_v1: Security_Context_Manager_V1) {
	_size: u16 = 8
	security_context_manager_v1 := security_context_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &security_context_manager_v1, size_of(security_context_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_security_context_manager_v1@", security_context_manager_v1, ".destroy:")
	return
}
security_context_manager_v1_create_listener :: proc(connection: ^Connection, security_context_manager_v1: Security_Context_Manager_V1, listen_fd: Fd, close_fd: Fd) -> (id: Security_Context_V1) {
	_size: u16 = 8 + size_of(id)
	security_context_manager_v1 := security_context_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &security_context_manager_v1, size_of(security_context_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Security_Context_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	append(&connection.fds_out, listen_fd)
	append(&connection.fds_out, close_fd)
	if connection.log_fn != nil do _debug_log(connection, "-> wp_security_context_manager_v1@", security_context_manager_v1, ".create_listener:", " id=", id, " listen_fd=", listen_fd, " close_fd=", close_fd)
	return
}
security_context_v1_destroy :: proc(connection: ^Connection, security_context_v1: Security_Context_V1) {
	_size: u16 = 8
	security_context_v1 := security_context_v1
	_buffer_write_ptr(&connection.buffer_out, &security_context_v1, size_of(security_context_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_security_context_v1@", security_context_v1, ".destroy:")
	return
}
security_context_v1_set_sandbox_engine :: proc(connection: ^Connection, security_context_v1: Security_Context_V1, name: string) {
	_size: u16 = 8 + 4 + u16((len(name) + 1 + 3) & -4)
	security_context_v1 := security_context_v1
	_buffer_write_ptr(&connection.buffer_out, &security_context_v1, size_of(security_context_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, name)
	if connection.log_fn != nil do _debug_log(connection, "-> wp_security_context_v1@", security_context_v1, ".set_sandbox_engine:", " name=", name)
	return
}
security_context_v1_set_app_id :: proc(connection: ^Connection, security_context_v1: Security_Context_V1, app_id: string) {
	_size: u16 = 8 + 4 + u16((len(app_id) + 1 + 3) & -4)
	security_context_v1 := security_context_v1
	_buffer_write_ptr(&connection.buffer_out, &security_context_v1, size_of(security_context_v1))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, app_id)
	if connection.log_fn != nil do _debug_log(connection, "-> wp_security_context_v1@", security_context_v1, ".set_app_id:", " app_id=", app_id)
	return
}
security_context_v1_set_instance_id :: proc(connection: ^Connection, security_context_v1: Security_Context_V1, instance_id: string) {
	_size: u16 = 8 + 4 + u16((len(instance_id) + 1 + 3) & -4)
	security_context_v1 := security_context_v1
	_buffer_write_ptr(&connection.buffer_out, &security_context_v1, size_of(security_context_v1))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, instance_id)
	if connection.log_fn != nil do _debug_log(connection, "-> wp_security_context_v1@", security_context_v1, ".set_instance_id:", " instance_id=", instance_id)
	return
}
security_context_v1_commit :: proc(connection: ^Connection, security_context_v1: Security_Context_V1) {
	_size: u16 = 8
	security_context_v1 := security_context_v1
	_buffer_write_ptr(&connection.buffer_out, &security_context_v1, size_of(security_context_v1))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_security_context_v1@", security_context_v1, ".commit:")
	return
}
single_pixel_buffer_manager_v1_destroy :: proc(connection: ^Connection, single_pixel_buffer_manager_v1: Single_Pixel_Buffer_Manager_V1) {
	_size: u16 = 8
	single_pixel_buffer_manager_v1 := single_pixel_buffer_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &single_pixel_buffer_manager_v1, size_of(single_pixel_buffer_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_single_pixel_buffer_manager_v1@", single_pixel_buffer_manager_v1, ".destroy:")
	return
}
single_pixel_buffer_manager_v1_create_u32_rgba_buffer :: proc(connection: ^Connection, single_pixel_buffer_manager_v1: Single_Pixel_Buffer_Manager_V1, r: u32, g: u32, b: u32, a: u32) -> (id: wl.Buffer) {
	_size: u16 = 8 + size_of(id) + size_of(r) + size_of(g) + size_of(b) + size_of(a)
	single_pixel_buffer_manager_v1 := single_pixel_buffer_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &single_pixel_buffer_manager_v1, size_of(single_pixel_buffer_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Buffer)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	r := r
	_buffer_write_ptr(&connection.buffer_out, &r, size_of(r))
	g := g
	_buffer_write_ptr(&connection.buffer_out, &g, size_of(g))
	b := b
	_buffer_write_ptr(&connection.buffer_out, &b, size_of(b))
	a := a
	_buffer_write_ptr(&connection.buffer_out, &a, size_of(a))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_single_pixel_buffer_manager_v1@", single_pixel_buffer_manager_v1, ".create_u32_rgba_buffer:", " id=", id, " r=", r, " g=", g, " b=", b, " a=", a)
	return
}
tearing_control_manager_v1_destroy :: proc(connection: ^Connection, tearing_control_manager_v1: Tearing_Control_Manager_V1) {
	_size: u16 = 8
	tearing_control_manager_v1 := tearing_control_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &tearing_control_manager_v1, size_of(tearing_control_manager_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_tearing_control_manager_v1@", tearing_control_manager_v1, ".destroy:")
	return
}
tearing_control_manager_v1_get_tearing_control :: proc(connection: ^Connection, tearing_control_manager_v1: Tearing_Control_Manager_V1, surface: wl.Surface) -> (id: Tearing_Control_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	tearing_control_manager_v1 := tearing_control_manager_v1
	_buffer_write_ptr(&connection.buffer_out, &tearing_control_manager_v1, size_of(tearing_control_manager_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wp_Tearing_Control_V1)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_tearing_control_manager_v1@", tearing_control_manager_v1, ".get_tearing_control:", " id=", id, " surface=", surface)
	return
}
tearing_control_v1_set_presentation_hint :: proc(connection: ^Connection, tearing_control_v1: Tearing_Control_V1, hint: Tearing_Control_V1_Presentation_Hint) {
	_size: u16 = 8 + size_of(hint)
	tearing_control_v1 := tearing_control_v1
	_buffer_write_ptr(&connection.buffer_out, &tearing_control_v1, size_of(tearing_control_v1))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	hint := hint
	_buffer_write_ptr(&connection.buffer_out, &hint, size_of(hint))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_tearing_control_v1@", tearing_control_v1, ".set_presentation_hint:", " hint=", hint)
	return
}
tearing_control_v1_destroy :: proc(connection: ^Connection, tearing_control_v1: Tearing_Control_V1) {
	_size: u16 = 8
	tearing_control_v1 := tearing_control_v1
	_buffer_write_ptr(&connection.buffer_out, &tearing_control_v1, size_of(tearing_control_v1))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wp_tearing_control_v1@", tearing_control_v1, ".destroy:")
	return
}

Presentation_Clock_Id_Event :: struct {
	object: Presentation,
	clk_id: u32,
}
Presentation_Feedback_Sync_Output_Event :: struct {
	object: Presentation_Feedback,
	output: wl.Output,
}
Presentation_Feedback_Presented_Event :: struct {
	object: Presentation_Feedback,
	tv_sec_hi: u32,
	tv_sec_lo: u32,
	tv_nsec: u32,
	refresh: u32,
	seq_hi: u32,
	seq_lo: u32,
	flags: Presentation_Feedback_Kind,
}
Presentation_Feedback_Discarded_Event :: struct {
	object: Presentation_Feedback,
}
Color_Manager_V1_Supported_Intent_Event :: struct {
	object: Color_Manager_V1,
	render_intent: Color_Manager_V1_Render_Intent,
}
Color_Manager_V1_Supported_Feature_Event :: struct {
	object: Color_Manager_V1,
	feature: Color_Manager_V1_Feature,
}
Color_Manager_V1_Supported_Tf_Named_Event :: struct {
	object: Color_Manager_V1,
	tf: Color_Manager_V1_Transfer_Function,
}
Color_Manager_V1_Supported_Primaries_Named_Event :: struct {
	object: Color_Manager_V1,
	primaries: Color_Manager_V1_Primaries,
}
Color_Manager_V1_Done_Event :: struct {
	object: Color_Manager_V1,
}
Color_Management_Output_V1_Image_Description_Changed_Event :: struct {
	object: Color_Management_Output_V1,
}
Color_Management_Surface_Feedback_V1_Preferred_Changed_Event :: struct {
	object: Color_Management_Surface_Feedback_V1,
	identity: u32,
}
Color_Management_Surface_Feedback_V1_Preferred_Changed2_Event :: struct {
	object: Color_Management_Surface_Feedback_V1,
	identity_hi: u32,
	identity_lo: u32,
}
Image_Description_V1_Failed_Event :: struct {
	object: Image_Description_V1,
	cause: Image_Description_V1_Cause,
	msg: string,
}
Image_Description_V1_Ready_Event :: struct {
	object: Image_Description_V1,
	identity: u32,
}
Image_Description_V1_Ready2_Event :: struct {
	object: Image_Description_V1,
	identity_hi: u32,
	identity_lo: u32,
}
Image_Description_Info_V1_Done_Event :: struct {
	object: Image_Description_Info_V1,
}
Image_Description_Info_V1_Icc_File_Event :: struct {
	object: Image_Description_Info_V1,
	icc: Fd,
	icc_size: u32,
}
Image_Description_Info_V1_Primaries_Event :: struct {
	object: Image_Description_Info_V1,
	r_x: i32,
	r_y: i32,
	g_x: i32,
	g_y: i32,
	b_x: i32,
	b_y: i32,
	w_x: i32,
	w_y: i32,
}
Image_Description_Info_V1_Primaries_Named_Event :: struct {
	object: Image_Description_Info_V1,
	primaries: Color_Manager_V1_Primaries,
}
Image_Description_Info_V1_Tf_Power_Event :: struct {
	object: Image_Description_Info_V1,
	eexp: u32,
}
Image_Description_Info_V1_Tf_Named_Event :: struct {
	object: Image_Description_Info_V1,
	tf: Color_Manager_V1_Transfer_Function,
}
Image_Description_Info_V1_Luminances_Event :: struct {
	object: Image_Description_Info_V1,
	min_lum: u32,
	max_lum: u32,
	reference_lum: u32,
}
Image_Description_Info_V1_Target_Primaries_Event :: struct {
	object: Image_Description_Info_V1,
	r_x: i32,
	r_y: i32,
	g_x: i32,
	g_y: i32,
	b_x: i32,
	b_y: i32,
	w_x: i32,
	w_y: i32,
}
Image_Description_Info_V1_Target_Luminance_Event :: struct {
	object: Image_Description_Info_V1,
	min_lum: u32,
	max_lum: u32,
}
Image_Description_Info_V1_Target_Max_Cll_Event :: struct {
	object: Image_Description_Info_V1,
	max_cll: u32,
}
Image_Description_Info_V1_Target_Max_Fall_Event :: struct {
	object: Image_Description_Info_V1,
	max_fall: u32,
}
Color_Representation_Manager_V1_Supported_Alpha_Mode_Event :: struct {
	object: Color_Representation_Manager_V1,
	alpha_mode: Color_Representation_Surface_V1_Alpha_Mode,
}
Color_Representation_Manager_V1_Supported_Coefficients_And_Ranges_Event :: struct {
	object: Color_Representation_Manager_V1,
	coefficients: Color_Representation_Surface_V1_Coefficients,
	range: Color_Representation_Surface_V1_Range,
}
Color_Representation_Manager_V1_Done_Event :: struct {
	object: Color_Representation_Manager_V1,
}
Drm_Lease_Device_V1_Drm_Fd_Event :: struct {
	object: Drm_Lease_Device_V1,
	fd: Fd,
}
Drm_Lease_Device_V1_Connector_Event :: struct {
	object: Drm_Lease_Device_V1,
	id: Drm_Lease_Connector_V1,
}
Drm_Lease_Device_V1_Done_Event :: struct {
	object: Drm_Lease_Device_V1,
}
Drm_Lease_Device_V1_Released_Event :: struct {
	object: Drm_Lease_Device_V1,
}
Drm_Lease_Connector_V1_Name_Event :: struct {
	object: Drm_Lease_Connector_V1,
	name: string,
}
Drm_Lease_Connector_V1_Description_Event :: struct {
	object: Drm_Lease_Connector_V1,
	description: string,
}
Drm_Lease_Connector_V1_Connector_Id_Event :: struct {
	object: Drm_Lease_Connector_V1,
	connector_id: u32,
}
Drm_Lease_Connector_V1_Done_Event :: struct {
	object: Drm_Lease_Connector_V1,
}
Drm_Lease_Connector_V1_Withdrawn_Event :: struct {
	object: Drm_Lease_Connector_V1,
}
Drm_Lease_V1_Lease_Fd_Event :: struct {
	object: Drm_Lease_V1,
	leased_fd: Fd,
}
Drm_Lease_V1_Finished_Event :: struct {
	object: Drm_Lease_V1,
}
Fractional_Scale_V1_Preferred_Scale_Event :: struct {
	object: Fractional_Scale_V1,
	scale: u32,
}

parse_presentation_clock_id :: proc(connection: ^Connection, object: u32) -> (event: Presentation_Clock_Id_Event, ok: bool) {
	event.object = Presentation(object)
	read(connection, &event.clk_id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_presentation@", object, ".clock_id:", " clk_id=", event.clk_id)
	ok = true
	return
}
parse_presentation_feedback_sync_output :: proc(connection: ^Connection, object: u32) -> (event: Presentation_Feedback_Sync_Output_Event, ok: bool) {
	event.object = Presentation_Feedback(object)
	read(connection, &event.output) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_presentation_feedback@", object, ".sync_output:", " output=", event.output)
	ok = true
	return
}
parse_presentation_feedback_presented :: proc(connection: ^Connection, object: u32) -> (event: Presentation_Feedback_Presented_Event, ok: bool) {
	event.object = Presentation_Feedback(object)
	read(connection, &event.tv_sec_hi) or_return
	read(connection, &event.tv_sec_lo) or_return
	read(connection, &event.tv_nsec) or_return
	read(connection, &event.refresh) or_return
	read(connection, &event.seq_hi) or_return
	read(connection, &event.seq_lo) or_return
	read(connection, &event.flags) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_presentation_feedback@", object, ".presented:", " tv_sec_hi=", event.tv_sec_hi, " tv_sec_lo=", event.tv_sec_lo, " tv_nsec=", event.tv_nsec, " refresh=", event.refresh, " seq_hi=", event.seq_hi, " seq_lo=", event.seq_lo, " flags=", event.flags)
	ok = true
	return
}
parse_presentation_feedback_discarded :: proc(connection: ^Connection, object: u32) -> (event: Presentation_Feedback_Discarded_Event, ok: bool) {
	event.object = Presentation_Feedback(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_presentation_feedback@", object, ".discarded:")
	ok = true
	return
}
parse_color_manager_v1_supported_intent :: proc(connection: ^Connection, object: u32) -> (event: Color_Manager_V1_Supported_Intent_Event, ok: bool) {
	event.object = Color_Manager_V1(object)
	read(connection, &event.render_intent) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_manager_v1@", object, ".supported_intent:", " render_intent=", event.render_intent)
	ok = true
	return
}
parse_color_manager_v1_supported_feature :: proc(connection: ^Connection, object: u32) -> (event: Color_Manager_V1_Supported_Feature_Event, ok: bool) {
	event.object = Color_Manager_V1(object)
	read(connection, &event.feature) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_manager_v1@", object, ".supported_feature:", " feature=", event.feature)
	ok = true
	return
}
parse_color_manager_v1_supported_tf_named :: proc(connection: ^Connection, object: u32) -> (event: Color_Manager_V1_Supported_Tf_Named_Event, ok: bool) {
	event.object = Color_Manager_V1(object)
	read(connection, &event.tf) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_manager_v1@", object, ".supported_tf_named:", " tf=", event.tf)
	ok = true
	return
}
parse_color_manager_v1_supported_primaries_named :: proc(connection: ^Connection, object: u32) -> (event: Color_Manager_V1_Supported_Primaries_Named_Event, ok: bool) {
	event.object = Color_Manager_V1(object)
	read(connection, &event.primaries) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_manager_v1@", object, ".supported_primaries_named:", " primaries=", event.primaries)
	ok = true
	return
}
parse_color_manager_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Color_Manager_V1_Done_Event, ok: bool) {
	event.object = Color_Manager_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_manager_v1@", object, ".done:")
	ok = true
	return
}
parse_color_management_output_v1_image_description_changed :: proc(connection: ^Connection, object: u32) -> (event: Color_Management_Output_V1_Image_Description_Changed_Event, ok: bool) {
	event.object = Color_Management_Output_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_management_output_v1@", object, ".image_description_changed:")
	ok = true
	return
}
parse_color_management_surface_feedback_v1_preferred_changed :: proc(connection: ^Connection, object: u32) -> (event: Color_Management_Surface_Feedback_V1_Preferred_Changed_Event, ok: bool) {
	event.object = Color_Management_Surface_Feedback_V1(object)
	read(connection, &event.identity) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_management_surface_feedback_v1@", object, ".preferred_changed:", " identity=", event.identity)
	ok = true
	return
}
parse_color_management_surface_feedback_v1_preferred_changed2 :: proc(connection: ^Connection, object: u32) -> (event: Color_Management_Surface_Feedback_V1_Preferred_Changed2_Event, ok: bool) {
	event.object = Color_Management_Surface_Feedback_V1(object)
	read(connection, &event.identity_hi) or_return
	read(connection, &event.identity_lo) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_management_surface_feedback_v1@", object, ".preferred_changed2:", " identity_hi=", event.identity_hi, " identity_lo=", event.identity_lo)
	ok = true
	return
}
parse_image_description_v1_failed :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_V1_Failed_Event, ok: bool) {
	event.object = Image_Description_V1(object)
	read(connection, &event.cause) or_return
	read(connection, &event.msg) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_v1@", object, ".failed:", " cause=", event.cause, " msg=", event.msg)
	ok = true
	return
}
parse_image_description_v1_ready :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_V1_Ready_Event, ok: bool) {
	event.object = Image_Description_V1(object)
	read(connection, &event.identity) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_v1@", object, ".ready:", " identity=", event.identity)
	ok = true
	return
}
parse_image_description_v1_ready2 :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_V1_Ready2_Event, ok: bool) {
	event.object = Image_Description_V1(object)
	read(connection, &event.identity_hi) or_return
	read(connection, &event.identity_lo) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_v1@", object, ".ready2:", " identity_hi=", event.identity_hi, " identity_lo=", event.identity_lo)
	ok = true
	return
}
parse_image_description_info_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Done_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".done:")
	ok = true
	return
}
parse_image_description_info_v1_icc_file :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Icc_File_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read_fd(connection, &event.icc) or_return
	read(connection, &event.icc_size) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".icc_file:", " icc=", event.icc, " icc_size=", event.icc_size)
	ok = true
	return
}
parse_image_description_info_v1_primaries :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Primaries_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.r_x) or_return
	read(connection, &event.r_y) or_return
	read(connection, &event.g_x) or_return
	read(connection, &event.g_y) or_return
	read(connection, &event.b_x) or_return
	read(connection, &event.b_y) or_return
	read(connection, &event.w_x) or_return
	read(connection, &event.w_y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".primaries:", " r_x=", event.r_x, " r_y=", event.r_y, " g_x=", event.g_x, " g_y=", event.g_y, " b_x=", event.b_x, " b_y=", event.b_y, " w_x=", event.w_x, " w_y=", event.w_y)
	ok = true
	return
}
parse_image_description_info_v1_primaries_named :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Primaries_Named_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.primaries) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".primaries_named:", " primaries=", event.primaries)
	ok = true
	return
}
parse_image_description_info_v1_tf_power :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Tf_Power_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.eexp) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".tf_power:", " eexp=", event.eexp)
	ok = true
	return
}
parse_image_description_info_v1_tf_named :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Tf_Named_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.tf) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".tf_named:", " tf=", event.tf)
	ok = true
	return
}
parse_image_description_info_v1_luminances :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Luminances_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.min_lum) or_return
	read(connection, &event.max_lum) or_return
	read(connection, &event.reference_lum) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".luminances:", " min_lum=", event.min_lum, " max_lum=", event.max_lum, " reference_lum=", event.reference_lum)
	ok = true
	return
}
parse_image_description_info_v1_target_primaries :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Target_Primaries_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.r_x) or_return
	read(connection, &event.r_y) or_return
	read(connection, &event.g_x) or_return
	read(connection, &event.g_y) or_return
	read(connection, &event.b_x) or_return
	read(connection, &event.b_y) or_return
	read(connection, &event.w_x) or_return
	read(connection, &event.w_y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".target_primaries:", " r_x=", event.r_x, " r_y=", event.r_y, " g_x=", event.g_x, " g_y=", event.g_y, " b_x=", event.b_x, " b_y=", event.b_y, " w_x=", event.w_x, " w_y=", event.w_y)
	ok = true
	return
}
parse_image_description_info_v1_target_luminance :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Target_Luminance_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.min_lum) or_return
	read(connection, &event.max_lum) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".target_luminance:", " min_lum=", event.min_lum, " max_lum=", event.max_lum)
	ok = true
	return
}
parse_image_description_info_v1_target_max_cll :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Target_Max_Cll_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.max_cll) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".target_max_cll:", " max_cll=", event.max_cll)
	ok = true
	return
}
parse_image_description_info_v1_target_max_fall :: proc(connection: ^Connection, object: u32) -> (event: Image_Description_Info_V1_Target_Max_Fall_Event, ok: bool) {
	event.object = Image_Description_Info_V1(object)
	read(connection, &event.max_fall) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_image_description_info_v1@", object, ".target_max_fall:", " max_fall=", event.max_fall)
	ok = true
	return
}
parse_color_representation_manager_v1_supported_alpha_mode :: proc(connection: ^Connection, object: u32) -> (event: Color_Representation_Manager_V1_Supported_Alpha_Mode_Event, ok: bool) {
	event.object = Color_Representation_Manager_V1(object)
	read(connection, &event.alpha_mode) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_representation_manager_v1@", object, ".supported_alpha_mode:", " alpha_mode=", event.alpha_mode)
	ok = true
	return
}
parse_color_representation_manager_v1_supported_coefficients_and_ranges :: proc(connection: ^Connection, object: u32) -> (event: Color_Representation_Manager_V1_Supported_Coefficients_And_Ranges_Event, ok: bool) {
	event.object = Color_Representation_Manager_V1(object)
	read(connection, &event.coefficients) or_return
	read(connection, &event.range) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_representation_manager_v1@", object, ".supported_coefficients_and_ranges:", " coefficients=", event.coefficients, " range=", event.range)
	ok = true
	return
}
parse_color_representation_manager_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Color_Representation_Manager_V1_Done_Event, ok: bool) {
	event.object = Color_Representation_Manager_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_color_representation_manager_v1@", object, ".done:")
	ok = true
	return
}
parse_drm_lease_device_v1_drm_fd :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Device_V1_Drm_Fd_Event, ok: bool) {
	event.object = Drm_Lease_Device_V1(object)
	read_fd(connection, &event.fd) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_device_v1@", object, ".drm_fd:", " fd=", event.fd)
	ok = true
	return
}
parse_drm_lease_device_v1_connector :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Device_V1_Connector_Event, ok: bool) {
	event.object = Drm_Lease_Device_V1(object)
	read(connection, &event.id) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.id) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.id) - SERVER_ID_START] = .Wp_Drm_Lease_Connector_V1
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_device_v1@", object, ".connector:", " id=", event.id)
	ok = true
	return
}
parse_drm_lease_device_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Device_V1_Done_Event, ok: bool) {
	event.object = Drm_Lease_Device_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_device_v1@", object, ".done:")
	ok = true
	return
}
parse_drm_lease_device_v1_released :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Device_V1_Released_Event, ok: bool) {
	event.object = Drm_Lease_Device_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_device_v1@", object, ".released:")
	ok = true
	return
}
parse_drm_lease_connector_v1_name :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Connector_V1_Name_Event, ok: bool) {
	event.object = Drm_Lease_Connector_V1(object)
	read(connection, &event.name) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_connector_v1@", object, ".name:", " name=", event.name)
	ok = true
	return
}
parse_drm_lease_connector_v1_description :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Connector_V1_Description_Event, ok: bool) {
	event.object = Drm_Lease_Connector_V1(object)
	read(connection, &event.description) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_connector_v1@", object, ".description:", " description=", event.description)
	ok = true
	return
}
parse_drm_lease_connector_v1_connector_id :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Connector_V1_Connector_Id_Event, ok: bool) {
	event.object = Drm_Lease_Connector_V1(object)
	read(connection, &event.connector_id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_connector_v1@", object, ".connector_id:", " connector_id=", event.connector_id)
	ok = true
	return
}
parse_drm_lease_connector_v1_done :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Connector_V1_Done_Event, ok: bool) {
	event.object = Drm_Lease_Connector_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_connector_v1@", object, ".done:")
	ok = true
	return
}
parse_drm_lease_connector_v1_withdrawn :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_Connector_V1_Withdrawn_Event, ok: bool) {
	event.object = Drm_Lease_Connector_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_connector_v1@", object, ".withdrawn:")
	ok = true
	return
}
parse_drm_lease_v1_lease_fd :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_V1_Lease_Fd_Event, ok: bool) {
	event.object = Drm_Lease_V1(object)
	read_fd(connection, &event.leased_fd) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_v1@", object, ".lease_fd:", " leased_fd=", event.leased_fd)
	ok = true
	return
}
parse_drm_lease_v1_finished :: proc(connection: ^Connection, object: u32) -> (event: Drm_Lease_V1_Finished_Event, ok: bool) {
	event.object = Drm_Lease_V1(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wp_drm_lease_v1@", object, ".finished:")
	ok = true
	return
}
parse_fractional_scale_v1_preferred_scale :: proc(connection: ^Connection, object: u32) -> (event: Fractional_Scale_V1_Preferred_Scale_Event, ok: bool) {
	event.object = Fractional_Scale_V1(object)
	read(connection, &event.scale) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wp_fractional_scale_v1@", object, ".preferred_scale:", " scale=", event.scale)
	ok = true
	return
}

Presentation :: distinct u32
Presentation_Feedback :: distinct u32
Viewporter :: distinct u32
Viewport :: distinct u32
Alpha_Modifier_V1 :: distinct u32
Alpha_Modifier_Surface_V1 :: distinct u32
Color_Manager_V1 :: distinct u32
Color_Management_Output_V1 :: distinct u32
Color_Management_Surface_V1 :: distinct u32
Color_Management_Surface_Feedback_V1 :: distinct u32
Image_Description_Creator_Icc_V1 :: distinct u32
Image_Description_Creator_Params_V1 :: distinct u32
Image_Description_V1 :: distinct u32
Image_Description_Info_V1 :: distinct u32
Image_Description_Reference_V1 :: distinct u32
Color_Representation_Manager_V1 :: distinct u32
Color_Representation_Surface_V1 :: distinct u32
Commit_Timing_Manager_V1 :: distinct u32
Commit_Timer_V1 :: distinct u32
Content_Type_Manager_V1 :: distinct u32
Content_Type_V1 :: distinct u32
Cursor_Shape_Manager_V1 :: distinct u32
Cursor_Shape_Device_V1 :: distinct u32
Drm_Lease_Device_V1 :: distinct u32
Drm_Lease_Connector_V1 :: distinct u32
Drm_Lease_Request_V1 :: distinct u32
Drm_Lease_V1 :: distinct u32
Fifo_Manager_V1 :: distinct u32
Fifo_V1 :: distinct u32
Fractional_Scale_Manager_V1 :: distinct u32
Fractional_Scale_V1 :: distinct u32
Linux_Drm_Syncobj_Manager_V1 :: distinct u32
Linux_Drm_Syncobj_Timeline_V1 :: distinct u32
Linux_Drm_Syncobj_Surface_V1 :: distinct u32
Pointer_Warp_V1 :: distinct u32
Security_Context_Manager_V1 :: distinct u32
Security_Context_V1 :: distinct u32
Single_Pixel_Buffer_Manager_V1 :: distinct u32
Tearing_Control_Manager_V1 :: distinct u32
Tearing_Control_V1 :: distinct u32

