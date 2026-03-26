package wayland_wl

import "base:intrinsics"

import "../common"


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


DISPLAY_INTERFACE :: "wl_display"
REGISTRY_INTERFACE :: "wl_registry"
CALLBACK_INTERFACE :: "wl_callback"
COMPOSITOR_INTERFACE :: "wl_compositor"
SHM_POOL_INTERFACE :: "wl_shm_pool"
SHM_INTERFACE :: "wl_shm"
BUFFER_INTERFACE :: "wl_buffer"
DATA_OFFER_INTERFACE :: "wl_data_offer"
DATA_SOURCE_INTERFACE :: "wl_data_source"
DATA_DEVICE_INTERFACE :: "wl_data_device"
DATA_DEVICE_MANAGER_INTERFACE :: "wl_data_device_manager"
SHELL_INTERFACE :: "wl_shell"
SHELL_SURFACE_INTERFACE :: "wl_shell_surface"
SURFACE_INTERFACE :: "wl_surface"
SEAT_INTERFACE :: "wl_seat"
POINTER_INTERFACE :: "wl_pointer"
KEYBOARD_INTERFACE :: "wl_keyboard"
TOUCH_INTERFACE :: "wl_touch"
OUTPUT_INTERFACE :: "wl_output"
REGION_INTERFACE :: "wl_region"
SUBCOMPOSITOR_INTERFACE :: "wl_subcompositor"
SUBSURFACE_INTERFACE :: "wl_subsurface"
FIXES_INTERFACE :: "wl_fixes"

Display_Error :: enum u32 {
	// server couldn't find object
	Invalid_Object = 0,
	// method doesn't exist on the specified interface or malformed request
	Invalid_Method = 1,
	// server is out of memory
	No_Memory = 2,
	// implementation error in compositor
	Implementation = 3,
}
Shm_Error :: enum u32 {
	// buffer format is not known
	Invalid_Format = 0,
	// invalid size or stride during pool or buffer creation
	Invalid_Stride = 1,
	// mmapping the file descriptor failed
	Invalid_Fd = 2,
}
Shm_Format :: enum u32 {
	// 32-bit ARGB format, [31:0] A:R:G:B 8:8:8:8 little endian
	Argb8888 = 0,
	// 32-bit RGB format, [31:0] x:R:G:B 8:8:8:8 little endian
	Xrgb8888 = 1,
	// 8-bit color index format, [7:0] C
	C8 = 0x20203843,
	// 8-bit RGB format, [7:0] R:G:B 3:3:2
	Rgb332 = 0x38424752,
	// 8-bit BGR format, [7:0] B:G:R 2:3:3
	Bgr233 = 0x38524742,
	// 16-bit xRGB format, [15:0] x:R:G:B 4:4:4:4 little endian
	Xrgb4444 = 0x32315258,
	// 16-bit xBGR format, [15:0] x:B:G:R 4:4:4:4 little endian
	Xbgr4444 = 0x32314258,
	// 16-bit RGBx format, [15:0] R:G:B:x 4:4:4:4 little endian
	Rgbx4444 = 0x32315852,
	// 16-bit BGRx format, [15:0] B:G:R:x 4:4:4:4 little endian
	Bgrx4444 = 0x32315842,
	// 16-bit ARGB format, [15:0] A:R:G:B 4:4:4:4 little endian
	Argb4444 = 0x32315241,
	// 16-bit ABGR format, [15:0] A:B:G:R 4:4:4:4 little endian
	Abgr4444 = 0x32314241,
	// 16-bit RBGA format, [15:0] R:G:B:A 4:4:4:4 little endian
	Rgba4444 = 0x32314152,
	// 16-bit BGRA format, [15:0] B:G:R:A 4:4:4:4 little endian
	Bgra4444 = 0x32314142,
	// 16-bit xRGB format, [15:0] x:R:G:B 1:5:5:5 little endian
	Xrgb1555 = 0x35315258,
	// 16-bit xBGR 1555 format, [15:0] x:B:G:R 1:5:5:5 little endian
	Xbgr1555 = 0x35314258,
	// 16-bit RGBx 5551 format, [15:0] R:G:B:x 5:5:5:1 little endian
	Rgbx5551 = 0x35315852,
	// 16-bit BGRx 5551 format, [15:0] B:G:R:x 5:5:5:1 little endian
	Bgrx5551 = 0x35315842,
	// 16-bit ARGB 1555 format, [15:0] A:R:G:B 1:5:5:5 little endian
	Argb1555 = 0x35315241,
	// 16-bit ABGR 1555 format, [15:0] A:B:G:R 1:5:5:5 little endian
	Abgr1555 = 0x35314241,
	// 16-bit RGBA 5551 format, [15:0] R:G:B:A 5:5:5:1 little endian
	Rgba5551 = 0x35314152,
	// 16-bit BGRA 5551 format, [15:0] B:G:R:A 5:5:5:1 little endian
	Bgra5551 = 0x35314142,
	// 16-bit RGB 565 format, [15:0] R:G:B 5:6:5 little endian
	Rgb565 = 0x36314752,
	// 16-bit BGR 565 format, [15:0] B:G:R 5:6:5 little endian
	Bgr565 = 0x36314742,
	// 24-bit RGB format, [23:0] R:G:B little endian
	Rgb888 = 0x34324752,
	// 24-bit BGR format, [23:0] B:G:R little endian
	Bgr888 = 0x34324742,
	// 32-bit xBGR format, [31:0] x:B:G:R 8:8:8:8 little endian
	Xbgr8888 = 0x34324258,
	// 32-bit RGBx format, [31:0] R:G:B:x 8:8:8:8 little endian
	Rgbx8888 = 0x34325852,
	// 32-bit BGRx format, [31:0] B:G:R:x 8:8:8:8 little endian
	Bgrx8888 = 0x34325842,
	// 32-bit ABGR format, [31:0] A:B:G:R 8:8:8:8 little endian
	Abgr8888 = 0x34324241,
	// 32-bit RGBA format, [31:0] R:G:B:A 8:8:8:8 little endian
	Rgba8888 = 0x34324152,
	// 32-bit BGRA format, [31:0] B:G:R:A 8:8:8:8 little endian
	Bgra8888 = 0x34324142,
	// 32-bit xRGB format, [31:0] x:R:G:B 2:10:10:10 little endian
	Xrgb2101010 = 0x30335258,
	// 32-bit xBGR format, [31:0] x:B:G:R 2:10:10:10 little endian
	Xbgr2101010 = 0x30334258,
	// 32-bit RGBx format, [31:0] R:G:B:x 10:10:10:2 little endian
	Rgbx1010102 = 0x30335852,
	// 32-bit BGRx format, [31:0] B:G:R:x 10:10:10:2 little endian
	Bgrx1010102 = 0x30335842,
	// 32-bit ARGB format, [31:0] A:R:G:B 2:10:10:10 little endian
	Argb2101010 = 0x30335241,
	// 32-bit ABGR format, [31:0] A:B:G:R 2:10:10:10 little endian
	Abgr2101010 = 0x30334241,
	// 32-bit RGBA format, [31:0] R:G:B:A 10:10:10:2 little endian
	Rgba1010102 = 0x30334152,
	// 32-bit BGRA format, [31:0] B:G:R:A 10:10:10:2 little endian
	Bgra1010102 = 0x30334142,
	// packed YCbCr format, [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian
	Yuyv = 0x56595559,
	// packed YCbCr format, [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian
	Yvyu = 0x55595659,
	// packed YCbCr format, [31:0] Y1:Cr0:Y0:Cb0 8:8:8:8 little endian
	Uyvy = 0x59565955,
	// packed YCbCr format, [31:0] Y1:Cb0:Y0:Cr0 8:8:8:8 little endian
	Vyuy = 0x59555956,
	// packed AYCbCr format, [31:0] A:Y:Cb:Cr 8:8:8:8 little endian
	Ayuv = 0x56555941,
	// 2 plane YCbCr Cr:Cb format, 2x2 subsampled Cr:Cb plane
	Nv12 = 0x3231564e,
	// 2 plane YCbCr Cb:Cr format, 2x2 subsampled Cb:Cr plane
	Nv21 = 0x3132564e,
	// 2 plane YCbCr Cr:Cb format, 2x1 subsampled Cr:Cb plane
	Nv16 = 0x3631564e,
	// 2 plane YCbCr Cb:Cr format, 2x1 subsampled Cb:Cr plane
	Nv61 = 0x3136564e,
	// 3 plane YCbCr format, 4x4 subsampled Cb (1) and Cr (2) planes
	Yuv410 = 0x39565559,
	// 3 plane YCbCr format, 4x4 subsampled Cr (1) and Cb (2) planes
	Yvu410 = 0x39555659,
	// 3 plane YCbCr format, 4x1 subsampled Cb (1) and Cr (2) planes
	Yuv411 = 0x31315559,
	// 3 plane YCbCr format, 4x1 subsampled Cr (1) and Cb (2) planes
	Yvu411 = 0x31315659,
	// 3 plane YCbCr format, 2x2 subsampled Cb (1) and Cr (2) planes
	Yuv420 = 0x32315559,
	// 3 plane YCbCr format, 2x2 subsampled Cr (1) and Cb (2) planes
	Yvu420 = 0x32315659,
	// 3 plane YCbCr format, 2x1 subsampled Cb (1) and Cr (2) planes
	Yuv422 = 0x36315559,
	// 3 plane YCbCr format, 2x1 subsampled Cr (1) and Cb (2) planes
	Yvu422 = 0x36315659,
	// 3 plane YCbCr format, non-subsampled Cb (1) and Cr (2) planes
	Yuv444 = 0x34325559,
	// 3 plane YCbCr format, non-subsampled Cr (1) and Cb (2) planes
	Yvu444 = 0x34325659,
	// [7:0] R
	R8 = 0x20203852,
	// [15:0] R little endian
	R16 = 0x20363152,
	// [15:0] R:G 8:8 little endian
	Rg88 = 0x38384752,
	// [15:0] G:R 8:8 little endian
	Gr88 = 0x38385247,
	// [31:0] R:G 16:16 little endian
	Rg1616 = 0x32334752,
	// [31:0] G:R 16:16 little endian
	Gr1616 = 0x32335247,
	// [63:0] x:R:G:B 16:16:16:16 little endian
	Xrgb16161616f = 0x48345258,
	// [63:0] x:B:G:R 16:16:16:16 little endian
	Xbgr16161616f = 0x48344258,
	// [63:0] A:R:G:B 16:16:16:16 little endian
	Argb16161616f = 0x48345241,
	// [63:0] A:B:G:R 16:16:16:16 little endian
	Abgr16161616f = 0x48344241,
	// [31:0] X:Y:Cb:Cr 8:8:8:8 little endian
	Xyuv8888 = 0x56555958,
	// [23:0] Cr:Cb:Y 8:8:8 little endian
	Vuy888 = 0x34325556,
	// Y followed by U then V, 10:10:10. Non-linear modifier only
	Vuy101010 = 0x30335556,
	// [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 10:6:10:6:10:6:10:6 little endian per 2 Y pixels
	Y210 = 0x30313259,
	// [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 12:4:12:4:12:4:12:4 little endian per 2 Y pixels
	Y212 = 0x32313259,
	// [63:0] Cr0:Y1:Cb0:Y0 16:16:16:16 little endian per 2 Y pixels
	Y216 = 0x36313259,
	// [31:0] A:Cr:Y:Cb 2:10:10:10 little endian
	Y410 = 0x30313459,
	// [63:0] A:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian
	Y412 = 0x32313459,
	// [63:0] A:Cr:Y:Cb 16:16:16:16 little endian
	Y416 = 0x36313459,
	// [31:0] X:Cr:Y:Cb 2:10:10:10 little endian
	Xvyu2101010 = 0x30335658,
	// [63:0] X:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian
	Xvyu12_16161616 = 0x36335658,
	// [63:0] X:Cr:Y:Cb 16:16:16:16 little endian
	Xvyu16161616 = 0x38345658,
	// [63:0] A3:A2:Y3:0:Cr0:0:Y2:0:A1:A0:Y1:0:Cb0:0:Y0:0 1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian
	Y0l0 = 0x304c3059,
	// [63:0] X3:X2:Y3:0:Cr0:0:Y2:0:X1:X0:Y1:0:Cb0:0:Y0:0 1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian
	X0l0 = 0x304c3058,
	// [63:0] A3:A2:Y3:Cr0:Y2:A1:A0:Y1:Cb0:Y0 1:1:10:10:10:1:1:10:10:10 little endian
	Y0l2 = 0x324c3059,
	// [63:0] X3:X2:Y3:Cr0:Y2:X1:X0:Y1:Cb0:Y0 1:1:10:10:10:1:1:10:10:10 little endian
	X0l2 = 0x324c3058,
	Yuv420_8bit = 0x38305559,
	Yuv420_10bit = 0x30315559,
	Xrgb8888_A8 = 0x38415258,
	Xbgr8888_A8 = 0x38414258,
	Rgbx8888_A8 = 0x38415852,
	Bgrx8888_A8 = 0x38415842,
	Rgb888_A8 = 0x38413852,
	Bgr888_A8 = 0x38413842,
	Rgb565_A8 = 0x38413552,
	Bgr565_A8 = 0x38413542,
	// non-subsampled Cr:Cb plane
	Nv24 = 0x3432564e,
	// non-subsampled Cb:Cr plane
	Nv42 = 0x3234564e,
	// 2x1 subsampled Cr:Cb plane, 10 bit per channel
	P210 = 0x30313250,
	// 2x2 subsampled Cr:Cb plane 10 bits per channel
	P010 = 0x30313050,
	// 2x2 subsampled Cr:Cb plane 12 bits per channel
	P012 = 0x32313050,
	// 2x2 subsampled Cr:Cb plane 16 bits per channel
	P016 = 0x36313050,
	// [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian
	Axbxgxrx106106106106 = 0x30314241,
	// 2x2 subsampled Cr:Cb plane
	Nv15 = 0x3531564e,
	Q410 = 0x30313451,
	Q401 = 0x31303451,
	// [63:0] x:R:G:B 16:16:16:16 little endian
	Xrgb16161616 = 0x38345258,
	// [63:0] x:B:G:R 16:16:16:16 little endian
	Xbgr16161616 = 0x38344258,
	// [63:0] A:R:G:B 16:16:16:16 little endian
	Argb16161616 = 0x38345241,
	// [63:0] A:B:G:R 16:16:16:16 little endian
	Abgr16161616 = 0x38344241,
	// [7:0] C0:C1:C2:C3:C4:C5:C6:C7 1:1:1:1:1:1:1:1 eight pixels/byte
	C1 = 0x20203143,
	// [7:0] C0:C1:C2:C3 2:2:2:2 four pixels/byte
	C2 = 0x20203243,
	// [7:0] C0:C1 4:4 two pixels/byte
	C4 = 0x20203443,
	// [7:0] D0:D1:D2:D3:D4:D5:D6:D7 1:1:1:1:1:1:1:1 eight pixels/byte
	D1 = 0x20203144,
	// [7:0] D0:D1:D2:D3 2:2:2:2 four pixels/byte
	D2 = 0x20203244,
	// [7:0] D0:D1 4:4 two pixels/byte
	D4 = 0x20203444,
	// [7:0] D
	D8 = 0x20203844,
	// [7:0] R0:R1:R2:R3:R4:R5:R6:R7 1:1:1:1:1:1:1:1 eight pixels/byte
	R1 = 0x20203152,
	// [7:0] R0:R1:R2:R3 2:2:2:2 four pixels/byte
	R2 = 0x20203252,
	// [7:0] R0:R1 4:4 two pixels/byte
	R4 = 0x20203452,
	// [15:0] x:R 6:10 little endian
	R10 = 0x20303152,
	// [15:0] x:R 4:12 little endian
	R12 = 0x20323152,
	// [31:0] A:Cr:Cb:Y 8:8:8:8 little endian
	Avuy8888 = 0x59555641,
	// [31:0] X:Cr:Cb:Y 8:8:8:8 little endian
	Xvuy8888 = 0x59555658,
	// 2x2 subsampled Cr:Cb plane 10 bits per channel packed
	P030 = 0x30333050,
	// [47:0] R:G:B 16:16:16 little endian
	Rgb161616 = 0x38344752,
	// [47:0] B:G:R 16:16:16 little endian
	Bgr161616 = 0x38344742,
	// [15:0] R 16 little endian
	R16f = 0x48202052,
	// [31:0] G:R 16:16 little endian
	Gr1616f = 0x48205247,
	// [47:0] B:G:R 16:16:16 little endian
	Bgr161616f = 0x48524742,
	// [31:0] R 32 little endian
	R32f = 0x46202052,
	// [63:0] R:G 32:32 little endian
	Gr3232f = 0x46205247,
	// [95:0] R:G:B 32:32:32 little endian
	Bgr323232f = 0x46524742,
	// [127:0] R:G:B:A 32:32:32:32 little endian
	Abgr32323232f = 0x46384241,
	// 2x1 subsampled Cr:Cb plane
	Nv20 = 0x3032564e,
	// non-subsampled Cr:Cb plane
	Nv30 = 0x3033564e,
	// 2x2 subsampled Cb (1) and Cr (2) planes 10 bits per channel
	S010 = 0x30313053,
	// 2x1 subsampled Cb (1) and Cr (2) planes 10 bits per channel
	S210 = 0x30313253,
	// non-subsampled Cb (1) and Cr (2) planes 10 bits per channel
	S410 = 0x30313453,
	// 2x2 subsampled Cb (1) and Cr (2) planes 12 bits per channel
	S012 = 0x32313053,
	// 2x1 subsampled Cb (1) and Cr (2) planes 12 bits per channel
	S212 = 0x32313253,
	// non-subsampled Cb (1) and Cr (2) planes 12 bits per channel
	S412 = 0x32313453,
	// 2x2 subsampled Cb (1) and Cr (2) planes 16 bits per channel
	S016 = 0x36313053,
	// 2x1 subsampled Cb (1) and Cr (2) planes 16 bits per channel
	S216 = 0x36313253,
	// non-subsampled Cb (1) and Cr (2) planes 16 bits per channel
	S416 = 0x36313453,
}
Data_Offer_Error :: enum u32 {
	// finish request was called untimely
	Invalid_Finish = 0,
	// action mask contains invalid values
	Invalid_Action_Mask = 1,
	// action argument has an invalid value
	Invalid_Action = 2,
	// offer doesn't accept this request
	Invalid_Offer = 3,
}
Data_Source_Error :: enum u32 {
	// action mask contains invalid values
	Invalid_Action_Mask = 0,
	// source doesn't accept this request
	Invalid_Source = 1,
}
Data_Device_Error :: enum u32 {
	// given wl_surface has another role
	Role = 0,
	// source has already been used
	Used_Source = 1,
}
Data_Device_Manager_Dnd_Action_Bits :: enum {
	// copy action
	Copy = 0,
	// move action
	Move = 1,
	// ask action
	Ask = 2,
}
Data_Device_Manager_Dnd_Action :: distinct bit_set[Data_Device_Manager_Dnd_Action_Bits; u32]
Shell_Error :: enum u32 {
	// given wl_surface has another role
	Role = 0,
}
Shell_Surface_Resize_Bits :: enum {
	// top edge
	Top = 0,
	// bottom edge
	Bottom = 1,
	// left edge
	Left = 2,
	// right edge
	Right = 3,
}
Shell_Surface_Resize :: distinct bit_set[Shell_Surface_Resize_Bits; u32]
Shell_Surface_Transient_Bits :: enum {
	// do not set keyboard focus
	Inactive = 0,
}
Shell_Surface_Transient :: distinct bit_set[Shell_Surface_Transient_Bits; u32]
Shell_Surface_Fullscreen_Method :: enum u32 {
	// no preference, apply default policy
	Default = 0,
	// scale, preserve the surface's aspect ratio and center on output
	Scale = 1,
	// switch output mode to the smallest mode that can fit the surface, add black borders to compensate size mismatch
	Driver = 2,
	// no upscaling, center on output and add black borders to compensate size mismatch
	Fill = 3,
}
Surface_Error :: enum u32 {
	// buffer scale value is invalid
	Invalid_Scale = 0,
	// buffer transform value is invalid
	Invalid_Transform = 1,
	// buffer size is invalid
	Invalid_Size = 2,
	// buffer offset is invalid
	Invalid_Offset = 3,
	// surface was destroyed before its role object
	Defunct_Role_Object = 4,
}
Seat_Capability_Bits :: enum {
	// the seat has pointer devices
	Pointer = 0,
	// the seat has one or more keyboards
	Keyboard = 1,
	// the seat has touch devices
	Touch = 2,
}
Seat_Capability :: distinct bit_set[Seat_Capability_Bits; u32]
Seat_Error :: enum u32 {
	// get_pointer, get_keyboard or get_touch called on seat without the matching capability
	Missing_Capability = 0,
}
Pointer_Error :: enum u32 {
	// given wl_surface has another role
	Role = 0,
}
Pointer_Button_State :: enum u32 {
	// the button is not pressed
	Released = 0,
	// the button is pressed
	Pressed = 1,
}
Pointer_Axis :: enum u32 {
	// vertical axis
	Vertical_Scroll = 0,
	// horizontal axis
	Horizontal_Scroll = 1,
}
Pointer_Axis_Source :: enum u32 {
	// a physical wheel rotation
	Wheel = 0,
	// finger on a touch surface
	Finger = 1,
	// continuous coordinate space
	Continuous = 2,
	// a physical wheel tilt
	Wheel_Tilt = 3,
}
Pointer_Axis_Relative_Direction :: enum u32 {
	// physical motion matches axis direction
	Identical = 0,
	// physical motion is the inverse of the axis direction
	Inverted = 1,
}
Keyboard_Keymap_Format :: enum u32 {
	// no keymap; client must understand how to interpret the raw keycode
	No_Keymap = 0,
	// libxkbcommon compatible, null-terminated string; to determine the xkb keycode, clients must add 8 to the key event keycode
	Xkb_V1 = 1,
}
Keyboard_Key_State :: enum u32 {
	// key is not pressed
	Released = 0,
	// key is pressed
	Pressed = 1,
	// key was repeated
	Repeated = 2,
}
Output_Subpixel :: enum u32 {
	// unknown geometry
	Unknown = 0,
	// no geometry
	None = 1,
	// horizontal RGB
	Horizontal_Rgb = 2,
	// horizontal BGR
	Horizontal_Bgr = 3,
	// vertical RGB
	Vertical_Rgb = 4,
	// vertical BGR
	Vertical_Bgr = 5,
}
Output_Transform :: enum u32 {
	// no transform
	Normal = 0,
	// 90 degrees counter-clockwise
	_90 = 1,
	// 180 degrees counter-clockwise
	_180 = 2,
	// 270 degrees counter-clockwise
	_270 = 3,
	// 180 degree flip around a vertical axis
	Flipped = 4,
	// flip and rotate 90 degrees counter-clockwise
	Flipped_90 = 5,
	// flip and rotate 180 degrees counter-clockwise
	Flipped_180 = 6,
	// flip and rotate 270 degrees counter-clockwise
	Flipped_270 = 7,
}
Output_Mode_Bits :: enum {
	// indicates this is the current mode
	Current = 0,
	// indicates this is the preferred mode
	Preferred = 1,
}
Output_Mode :: distinct bit_set[Output_Mode_Bits; u32]
Subcompositor_Error :: enum u32 {
	// the to-be sub-surface is invalid
	Bad_Surface = 0,
	// the to-be sub-surface parent is invalid
	Bad_Parent = 1,
}
Subsurface_Error :: enum u32 {
	// wl_surface is not a sibling or the parent
	Bad_Surface = 0,
}

display_sync :: proc(connection: ^Connection, display: Display) -> (callback: Callback) {
	_size: u16 = 8 + size_of(callback)
	display := display
	_buffer_write_ptr(&connection.buffer_out, &display, size_of(display))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	callback = auto_cast _generate_id(connection, .Wl_Callback)
	_buffer_write_ptr(&connection.buffer_out, &callback, size_of(callback))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_display@", display, ".sync:", " callback=", callback)
	return
}
display_get_registry :: proc(connection: ^Connection, display: Display) -> (registry: Registry) {
	_size: u16 = 8 + size_of(registry)
	display := display
	_buffer_write_ptr(&connection.buffer_out, &display, size_of(display))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	registry = auto_cast _generate_id(connection, .Wl_Registry)
	_buffer_write_ptr(&connection.buffer_out, &registry, size_of(registry))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_display@", display, ".get_registry:", " registry=", registry)
	return
}
registry_bind :: proc(connection: ^Connection, registry: Registry, name: u32, interface: string, version: u32, $T: typeid, _location := #caller_location) -> (id: T) where intrinsics.type_is_named(T), intrinsics.type_base_type(T) == u32 {
	_size: u16 = 8 + size_of(name) + 4 + u16((len(interface) + 1 + 3) & -4) + size_of(version) + size_of(id)
	registry := registry
	_buffer_write_ptr(&connection.buffer_out, &registry, size_of(registry))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	name := name
	_buffer_write_ptr(&connection.buffer_out, &name, size_of(name))
	_buffer_write_string(&connection.buffer_out, interface)
	version := version
	_buffer_write_ptr(&connection.buffer_out, &version, size_of(version))
	_type := resolve_type(T, interface, _location)
	id = auto_cast _generate_id(connection, _type)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_registry@", registry, ".bind:", " name=", name, " id=", id)
	return
}
compositor_create_surface :: proc(connection: ^Connection, compositor: Compositor) -> (id: Surface) {
	_size: u16 = 8 + size_of(id)
	compositor := compositor
	_buffer_write_ptr(&connection.buffer_out, &compositor, size_of(compositor))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Surface)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_compositor@", compositor, ".create_surface:", " id=", id)
	return
}
compositor_create_region :: proc(connection: ^Connection, compositor: Compositor) -> (id: Region) {
	_size: u16 = 8 + size_of(id)
	compositor := compositor
	_buffer_write_ptr(&connection.buffer_out, &compositor, size_of(compositor))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Region)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_compositor@", compositor, ".create_region:", " id=", id)
	return
}
shm_pool_create_buffer :: proc(connection: ^Connection, shm_pool: Shm_Pool, offset: i32, width: i32, height: i32, stride: i32, format: Shm_Format) -> (id: Buffer) {
	_size: u16 = 8 + size_of(id) + size_of(offset) + size_of(width) + size_of(height) + size_of(stride) + size_of(format)
	shm_pool := shm_pool
	_buffer_write_ptr(&connection.buffer_out, &shm_pool, size_of(shm_pool))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Buffer)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	offset := offset
	_buffer_write_ptr(&connection.buffer_out, &offset, size_of(offset))
	width := width
	_buffer_write_ptr(&connection.buffer_out, &width, size_of(width))
	height := height
	_buffer_write_ptr(&connection.buffer_out, &height, size_of(height))
	stride := stride
	_buffer_write_ptr(&connection.buffer_out, &stride, size_of(stride))
	format := format
	_buffer_write_ptr(&connection.buffer_out, &format, size_of(format))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shm_pool@", shm_pool, ".create_buffer:", " id=", id, " offset=", offset, " width=", width, " height=", height, " stride=", stride, " format=", format)
	return
}
shm_pool_destroy :: proc(connection: ^Connection, shm_pool: Shm_Pool) {
	_size: u16 = 8
	shm_pool := shm_pool
	_buffer_write_ptr(&connection.buffer_out, &shm_pool, size_of(shm_pool))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shm_pool@", shm_pool, ".destroy:")
	return
}
shm_pool_resize :: proc(connection: ^Connection, shm_pool: Shm_Pool, size: i32) {
	_size: u16 = 8 + size_of(size)
	shm_pool := shm_pool
	_buffer_write_ptr(&connection.buffer_out, &shm_pool, size_of(shm_pool))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	size := size
	_buffer_write_ptr(&connection.buffer_out, &size, size_of(size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shm_pool@", shm_pool, ".resize:", " size=", size)
	return
}
shm_create_pool :: proc(connection: ^Connection, shm: Shm, fd: Fd, size: i32) -> (id: Shm_Pool) {
	_size: u16 = 8 + size_of(id) + size_of(size)
	shm := shm
	_buffer_write_ptr(&connection.buffer_out, &shm, size_of(shm))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Shm_Pool)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	append(&connection.fds_out, fd)
	size := size
	_buffer_write_ptr(&connection.buffer_out, &size, size_of(size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shm@", shm, ".create_pool:", " id=", id, " fd=", fd, " size=", size)
	return
}
shm_release :: proc(connection: ^Connection, shm: Shm) {
	_size: u16 = 8
	shm := shm
	_buffer_write_ptr(&connection.buffer_out, &shm, size_of(shm))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shm@", shm, ".release:")
	return
}
buffer_destroy :: proc(connection: ^Connection, buffer: Buffer) {
	_size: u16 = 8
	buffer := buffer
	_buffer_write_ptr(&connection.buffer_out, &buffer, size_of(buffer))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_buffer@", buffer, ".destroy:")
	return
}
data_offer_accept :: proc(connection: ^Connection, data_offer: Data_Offer, serial: u32, mime_type: string) {
	_size: u16 = 8 + size_of(serial) + 4 + u16((len(mime_type) + 1 + 3) & -4)
	data_offer := data_offer
	_buffer_write_ptr(&connection.buffer_out, &data_offer, size_of(data_offer))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	_buffer_write_string(&connection.buffer_out, mime_type)
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_offer@", data_offer, ".accept:", " serial=", serial, " mime_type=", mime_type)
	return
}
data_offer_receive :: proc(connection: ^Connection, data_offer: Data_Offer, mime_type: string, fd: Fd) {
	_size: u16 = 8 + 4 + u16((len(mime_type) + 1 + 3) & -4)
	data_offer := data_offer
	_buffer_write_ptr(&connection.buffer_out, &data_offer, size_of(data_offer))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, mime_type)
	append(&connection.fds_out, fd)
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_offer@", data_offer, ".receive:", " mime_type=", mime_type, " fd=", fd)
	return
}
data_offer_destroy :: proc(connection: ^Connection, data_offer: Data_Offer) {
	_size: u16 = 8
	data_offer := data_offer
	_buffer_write_ptr(&connection.buffer_out, &data_offer, size_of(data_offer))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_offer@", data_offer, ".destroy:")
	return
}
data_offer_finish :: proc(connection: ^Connection, data_offer: Data_Offer) {
	_size: u16 = 8
	data_offer := data_offer
	_buffer_write_ptr(&connection.buffer_out, &data_offer, size_of(data_offer))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_offer@", data_offer, ".finish:")
	return
}
data_offer_set_actions :: proc(connection: ^Connection, data_offer: Data_Offer, dnd_actions: Data_Device_Manager_Dnd_Action, preferred_action: Data_Device_Manager_Dnd_Action) {
	_size: u16 = 8 + size_of(dnd_actions) + size_of(preferred_action)
	data_offer := data_offer
	_buffer_write_ptr(&connection.buffer_out, &data_offer, size_of(data_offer))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	dnd_actions := dnd_actions
	_buffer_write_ptr(&connection.buffer_out, &dnd_actions, size_of(dnd_actions))
	preferred_action := preferred_action
	_buffer_write_ptr(&connection.buffer_out, &preferred_action, size_of(preferred_action))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_offer@", data_offer, ".set_actions:", " dnd_actions=", dnd_actions, " preferred_action=", preferred_action)
	return
}
data_source_offer :: proc(connection: ^Connection, data_source: Data_Source, mime_type: string) {
	_size: u16 = 8 + 4 + u16((len(mime_type) + 1 + 3) & -4)
	data_source := data_source
	_buffer_write_ptr(&connection.buffer_out, &data_source, size_of(data_source))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, mime_type)
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_source@", data_source, ".offer:", " mime_type=", mime_type)
	return
}
data_source_destroy :: proc(connection: ^Connection, data_source: Data_Source) {
	_size: u16 = 8
	data_source := data_source
	_buffer_write_ptr(&connection.buffer_out, &data_source, size_of(data_source))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_source@", data_source, ".destroy:")
	return
}
data_source_set_actions :: proc(connection: ^Connection, data_source: Data_Source, dnd_actions: Data_Device_Manager_Dnd_Action) {
	_size: u16 = 8 + size_of(dnd_actions)
	data_source := data_source
	_buffer_write_ptr(&connection.buffer_out, &data_source, size_of(data_source))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	dnd_actions := dnd_actions
	_buffer_write_ptr(&connection.buffer_out, &dnd_actions, size_of(dnd_actions))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_source@", data_source, ".set_actions:", " dnd_actions=", dnd_actions)
	return
}
data_device_start_drag :: proc(connection: ^Connection, data_device: Data_Device, source: Data_Source, origin: Surface, icon: Surface, serial: u32) {
	_size: u16 = 8 + size_of(source) + size_of(origin) + size_of(icon) + size_of(serial)
	data_device := data_device
	_buffer_write_ptr(&connection.buffer_out, &data_device, size_of(data_device))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	source := source
	_buffer_write_ptr(&connection.buffer_out, &source, size_of(source))
	origin := origin
	_buffer_write_ptr(&connection.buffer_out, &origin, size_of(origin))
	icon := icon
	_buffer_write_ptr(&connection.buffer_out, &icon, size_of(icon))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_device@", data_device, ".start_drag:", " source=", source, " origin=", origin, " icon=", icon, " serial=", serial)
	return
}
data_device_set_selection :: proc(connection: ^Connection, data_device: Data_Device, source: Data_Source, serial: u32) {
	_size: u16 = 8 + size_of(source) + size_of(serial)
	data_device := data_device
	_buffer_write_ptr(&connection.buffer_out, &data_device, size_of(data_device))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	source := source
	_buffer_write_ptr(&connection.buffer_out, &source, size_of(source))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_device@", data_device, ".set_selection:", " source=", source, " serial=", serial)
	return
}
data_device_release :: proc(connection: ^Connection, data_device: Data_Device) {
	_size: u16 = 8
	data_device := data_device
	_buffer_write_ptr(&connection.buffer_out, &data_device, size_of(data_device))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_device@", data_device, ".release:")
	return
}
data_device_manager_create_data_source :: proc(connection: ^Connection, data_device_manager: Data_Device_Manager) -> (id: Data_Source) {
	_size: u16 = 8 + size_of(id)
	data_device_manager := data_device_manager
	_buffer_write_ptr(&connection.buffer_out, &data_device_manager, size_of(data_device_manager))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Data_Source)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_device_manager@", data_device_manager, ".create_data_source:", " id=", id)
	return
}
data_device_manager_get_data_device :: proc(connection: ^Connection, data_device_manager: Data_Device_Manager, seat: Seat) -> (id: Data_Device) {
	_size: u16 = 8 + size_of(id) + size_of(seat)
	data_device_manager := data_device_manager
	_buffer_write_ptr(&connection.buffer_out, &data_device_manager, size_of(data_device_manager))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Data_Device)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_data_device_manager@", data_device_manager, ".get_data_device:", " id=", id, " seat=", seat)
	return
}
shell_get_shell_surface :: proc(connection: ^Connection, shell: Shell, surface: Surface) -> (id: Shell_Surface) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	shell := shell
	_buffer_write_ptr(&connection.buffer_out, &shell, size_of(shell))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Shell_Surface)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell@", shell, ".get_shell_surface:", " id=", id, " surface=", surface)
	return
}
shell_surface_pong :: proc(connection: ^Connection, shell_surface: Shell_Surface, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".pong:", " serial=", serial)
	return
}
shell_surface_move :: proc(connection: ^Connection, shell_surface: Shell_Surface, seat: Seat, serial: u32) {
	_size: u16 = 8 + size_of(seat) + size_of(serial)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".move:", " seat=", seat, " serial=", serial)
	return
}
shell_surface_resize :: proc(connection: ^Connection, shell_surface: Shell_Surface, seat: Seat, serial: u32, edges: Shell_Surface_Resize) {
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(edges)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	edges := edges
	_buffer_write_ptr(&connection.buffer_out, &edges, size_of(edges))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".resize:", " seat=", seat, " serial=", serial, " edges=", edges)
	return
}
shell_surface_set_toplevel :: proc(connection: ^Connection, shell_surface: Shell_Surface) {
	_size: u16 = 8
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".set_toplevel:")
	return
}
shell_surface_set_transient :: proc(connection: ^Connection, shell_surface: Shell_Surface, parent: Surface, x: i32, y: i32, flags: Shell_Surface_Transient) {
	_size: u16 = 8 + size_of(parent) + size_of(x) + size_of(y) + size_of(flags)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	parent := parent
	_buffer_write_ptr(&connection.buffer_out, &parent, size_of(parent))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	flags := flags
	_buffer_write_ptr(&connection.buffer_out, &flags, size_of(flags))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".set_transient:", " parent=", parent, " x=", x, " y=", y, " flags=", flags)
	return
}
shell_surface_set_fullscreen :: proc(connection: ^Connection, shell_surface: Shell_Surface, method: Shell_Surface_Fullscreen_Method, framerate: u32, output: Output) {
	_size: u16 = 8 + size_of(method) + size_of(framerate) + size_of(output)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 5
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	method := method
	_buffer_write_ptr(&connection.buffer_out, &method, size_of(method))
	framerate := framerate
	_buffer_write_ptr(&connection.buffer_out, &framerate, size_of(framerate))
	output := output
	_buffer_write_ptr(&connection.buffer_out, &output, size_of(output))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".set_fullscreen:", " method=", method, " framerate=", framerate, " output=", output)
	return
}
shell_surface_set_popup :: proc(connection: ^Connection, shell_surface: Shell_Surface, seat: Seat, serial: u32, parent: Surface, x: i32, y: i32, flags: Shell_Surface_Transient) {
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(parent) + size_of(x) + size_of(y) + size_of(flags)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 6
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	serial := serial
	_buffer_write_ptr(&connection.buffer_out, &serial, size_of(serial))
	parent := parent
	_buffer_write_ptr(&connection.buffer_out, &parent, size_of(parent))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	flags := flags
	_buffer_write_ptr(&connection.buffer_out, &flags, size_of(flags))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".set_popup:", " seat=", seat, " serial=", serial, " parent=", parent, " x=", x, " y=", y, " flags=", flags)
	return
}
shell_surface_set_maximized :: proc(connection: ^Connection, shell_surface: Shell_Surface, output: Output) {
	_size: u16 = 8 + size_of(output)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 7
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	output := output
	_buffer_write_ptr(&connection.buffer_out, &output, size_of(output))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".set_maximized:", " output=", output)
	return
}
shell_surface_set_title :: proc(connection: ^Connection, shell_surface: Shell_Surface, title: string) {
	_size: u16 = 8 + 4 + u16((len(title) + 1 + 3) & -4)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 8
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, title)
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".set_title:", " title=", title)
	return
}
shell_surface_set_class :: proc(connection: ^Connection, shell_surface: Shell_Surface, class_: string) {
	_size: u16 = 8 + 4 + u16((len(class_) + 1 + 3) & -4)
	shell_surface := shell_surface
	_buffer_write_ptr(&connection.buffer_out, &shell_surface, size_of(shell_surface))
	opcode: u16 = 9
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	_buffer_write_string(&connection.buffer_out, class_)
	if connection.log_fn != nil do _debug_log(connection, "-> wl_shell_surface@", shell_surface, ".set_class:", " class_=", class_)
	return
}
surface_destroy :: proc(connection: ^Connection, surface: Surface) {
	_size: u16 = 8
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".destroy:")
	return
}
surface_attach :: proc(connection: ^Connection, surface: Surface, buffer: Buffer, x: i32, y: i32) {
	_size: u16 = 8 + size_of(buffer) + size_of(x) + size_of(y)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	buffer := buffer
	_buffer_write_ptr(&connection.buffer_out, &buffer, size_of(buffer))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".attach:", " buffer=", buffer, " x=", x, " y=", y)
	return
}
surface_damage :: proc(connection: ^Connection, surface: Surface, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
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
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".damage:", " x=", x, " y=", y, " width=", width, " height=", height)
	return
}
surface_frame :: proc(connection: ^Connection, surface: Surface) -> (callback: Callback) {
	_size: u16 = 8 + size_of(callback)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	callback = auto_cast _generate_id(connection, .Wl_Callback)
	_buffer_write_ptr(&connection.buffer_out, &callback, size_of(callback))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".frame:", " callback=", callback)
	return
}
surface_set_opaque_region :: proc(connection: ^Connection, surface: Surface, region: Region) {
	_size: u16 = 8 + size_of(region)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	region := region
	_buffer_write_ptr(&connection.buffer_out, &region, size_of(region))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".set_opaque_region:", " region=", region)
	return
}
surface_set_input_region :: proc(connection: ^Connection, surface: Surface, region: Region) {
	_size: u16 = 8 + size_of(region)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 5
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	region := region
	_buffer_write_ptr(&connection.buffer_out, &region, size_of(region))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".set_input_region:", " region=", region)
	return
}
surface_commit :: proc(connection: ^Connection, surface: Surface) {
	_size: u16 = 8
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 6
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".commit:")
	return
}
surface_set_buffer_transform :: proc(connection: ^Connection, surface: Surface, transform: Output_Transform) {
	_size: u16 = 8 + size_of(transform)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 7
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	transform := transform
	_buffer_write_ptr(&connection.buffer_out, &transform, size_of(transform))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".set_buffer_transform:", " transform=", transform)
	return
}
surface_set_buffer_scale :: proc(connection: ^Connection, surface: Surface, scale: i32) {
	_size: u16 = 8 + size_of(scale)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 8
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	scale := scale
	_buffer_write_ptr(&connection.buffer_out, &scale, size_of(scale))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".set_buffer_scale:", " scale=", scale)
	return
}
surface_damage_buffer :: proc(connection: ^Connection, surface: Surface, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 9
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
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".damage_buffer:", " x=", x, " y=", y, " width=", width, " height=", height)
	return
}
surface_offset :: proc(connection: ^Connection, surface: Surface, x: i32, y: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y)
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	opcode: u16 = 10
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_surface@", surface, ".offset:", " x=", x, " y=", y)
	return
}
seat_get_pointer :: proc(connection: ^Connection, seat: Seat) -> (id: Pointer) {
	_size: u16 = 8 + size_of(id)
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Pointer)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_seat@", seat, ".get_pointer:", " id=", id)
	return
}
seat_get_keyboard :: proc(connection: ^Connection, seat: Seat) -> (id: Keyboard) {
	_size: u16 = 8 + size_of(id)
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Keyboard)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_seat@", seat, ".get_keyboard:", " id=", id)
	return
}
seat_get_touch :: proc(connection: ^Connection, seat: Seat) -> (id: Touch) {
	_size: u16 = 8 + size_of(id)
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Touch)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_seat@", seat, ".get_touch:", " id=", id)
	return
}
seat_release :: proc(connection: ^Connection, seat: Seat) {
	_size: u16 = 8
	seat := seat
	_buffer_write_ptr(&connection.buffer_out, &seat, size_of(seat))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_seat@", seat, ".release:")
	return
}
pointer_set_cursor :: proc(connection: ^Connection, pointer: Pointer, serial: u32, surface: Surface, hotspot_x: i32, hotspot_y: i32) {
	_size: u16 = 8 + size_of(serial) + size_of(surface) + size_of(hotspot_x) + size_of(hotspot_y)
	pointer := pointer
	_buffer_write_ptr(&connection.buffer_out, &pointer, size_of(pointer))
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
	if connection.log_fn != nil do _debug_log(connection, "-> wl_pointer@", pointer, ".set_cursor:", " serial=", serial, " surface=", surface, " hotspot_x=", hotspot_x, " hotspot_y=", hotspot_y)
	return
}
pointer_release :: proc(connection: ^Connection, pointer: Pointer) {
	_size: u16 = 8
	pointer := pointer
	_buffer_write_ptr(&connection.buffer_out, &pointer, size_of(pointer))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_pointer@", pointer, ".release:")
	return
}
keyboard_release :: proc(connection: ^Connection, keyboard: Keyboard) {
	_size: u16 = 8
	keyboard := keyboard
	_buffer_write_ptr(&connection.buffer_out, &keyboard, size_of(keyboard))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_keyboard@", keyboard, ".release:")
	return
}
touch_release :: proc(connection: ^Connection, touch: Touch) {
	_size: u16 = 8
	touch := touch
	_buffer_write_ptr(&connection.buffer_out, &touch, size_of(touch))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_touch@", touch, ".release:")
	return
}
output_release :: proc(connection: ^Connection, output: Output) {
	_size: u16 = 8
	output := output
	_buffer_write_ptr(&connection.buffer_out, &output, size_of(output))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_output@", output, ".release:")
	return
}
region_destroy :: proc(connection: ^Connection, region: Region) {
	_size: u16 = 8
	region := region
	_buffer_write_ptr(&connection.buffer_out, &region, size_of(region))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_region@", region, ".destroy:")
	return
}
region_add :: proc(connection: ^Connection, region: Region, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	region := region
	_buffer_write_ptr(&connection.buffer_out, &region, size_of(region))
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
	if connection.log_fn != nil do _debug_log(connection, "-> wl_region@", region, ".add:", " x=", x, " y=", y, " width=", width, " height=", height)
	return
}
region_subtract :: proc(connection: ^Connection, region: Region, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	region := region
	_buffer_write_ptr(&connection.buffer_out, &region, size_of(region))
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
	if connection.log_fn != nil do _debug_log(connection, "-> wl_region@", region, ".subtract:", " x=", x, " y=", y, " width=", width, " height=", height)
	return
}
subcompositor_destroy :: proc(connection: ^Connection, subcompositor: Subcompositor) {
	_size: u16 = 8
	subcompositor := subcompositor
	_buffer_write_ptr(&connection.buffer_out, &subcompositor, size_of(subcompositor))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_subcompositor@", subcompositor, ".destroy:")
	return
}
subcompositor_get_subsurface :: proc(connection: ^Connection, subcompositor: Subcompositor, surface: Surface, parent: Surface) -> (id: Subsurface) {
	_size: u16 = 8 + size_of(id) + size_of(surface) + size_of(parent)
	subcompositor := subcompositor
	_buffer_write_ptr(&connection.buffer_out, &subcompositor, size_of(subcompositor))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	id = auto_cast _generate_id(connection, .Wl_Subsurface)
	_buffer_write_ptr(&connection.buffer_out, &id, size_of(id))
	surface := surface
	_buffer_write_ptr(&connection.buffer_out, &surface, size_of(surface))
	parent := parent
	_buffer_write_ptr(&connection.buffer_out, &parent, size_of(parent))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_subcompositor@", subcompositor, ".get_subsurface:", " id=", id, " surface=", surface, " parent=", parent)
	return
}
subsurface_destroy :: proc(connection: ^Connection, subsurface: Subsurface) {
	_size: u16 = 8
	subsurface := subsurface
	_buffer_write_ptr(&connection.buffer_out, &subsurface, size_of(subsurface))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_subsurface@", subsurface, ".destroy:")
	return
}
subsurface_set_position :: proc(connection: ^Connection, subsurface: Subsurface, x: i32, y: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y)
	subsurface := subsurface
	_buffer_write_ptr(&connection.buffer_out, &subsurface, size_of(subsurface))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	x := x
	_buffer_write_ptr(&connection.buffer_out, &x, size_of(x))
	y := y
	_buffer_write_ptr(&connection.buffer_out, &y, size_of(y))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_subsurface@", subsurface, ".set_position:", " x=", x, " y=", y)
	return
}
subsurface_place_above :: proc(connection: ^Connection, subsurface: Subsurface, sibling: Surface) {
	_size: u16 = 8 + size_of(sibling)
	subsurface := subsurface
	_buffer_write_ptr(&connection.buffer_out, &subsurface, size_of(subsurface))
	opcode: u16 = 2
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	sibling := sibling
	_buffer_write_ptr(&connection.buffer_out, &sibling, size_of(sibling))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_subsurface@", subsurface, ".place_above:", " sibling=", sibling)
	return
}
subsurface_place_below :: proc(connection: ^Connection, subsurface: Subsurface, sibling: Surface) {
	_size: u16 = 8 + size_of(sibling)
	subsurface := subsurface
	_buffer_write_ptr(&connection.buffer_out, &subsurface, size_of(subsurface))
	opcode: u16 = 3
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	sibling := sibling
	_buffer_write_ptr(&connection.buffer_out, &sibling, size_of(sibling))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_subsurface@", subsurface, ".place_below:", " sibling=", sibling)
	return
}
subsurface_set_sync :: proc(connection: ^Connection, subsurface: Subsurface) {
	_size: u16 = 8
	subsurface := subsurface
	_buffer_write_ptr(&connection.buffer_out, &subsurface, size_of(subsurface))
	opcode: u16 = 4
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_subsurface@", subsurface, ".set_sync:")
	return
}
subsurface_set_desync :: proc(connection: ^Connection, subsurface: Subsurface) {
	_size: u16 = 8
	subsurface := subsurface
	_buffer_write_ptr(&connection.buffer_out, &subsurface, size_of(subsurface))
	opcode: u16 = 5
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_subsurface@", subsurface, ".set_desync:")
	return
}
fixes_destroy :: proc(connection: ^Connection, fixes: Fixes) {
	_size: u16 = 8
	fixes := fixes
	_buffer_write_ptr(&connection.buffer_out, &fixes, size_of(fixes))
	opcode: u16 = 0
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_fixes@", fixes, ".destroy:")
	return
}
fixes_destroy_registry :: proc(connection: ^Connection, fixes: Fixes, registry: Registry) {
	_size: u16 = 8 + size_of(registry)
	fixes := fixes
	_buffer_write_ptr(&connection.buffer_out, &fixes, size_of(fixes))
	opcode: u16 = 1
	_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))
	_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))
	registry := registry
	_buffer_write_ptr(&connection.buffer_out, &registry, size_of(registry))
	if connection.log_fn != nil do _debug_log(connection, "-> wl_fixes@", fixes, ".destroy_registry:", " registry=", registry)
	return
}

Display_Error_Event :: struct {
	object: Display,
	object_id: Object,
	code: u32,
	message: string,
}
Display_Delete_Id_Event :: struct {
	object: Display,
	id: u32,
}
Registry_Global_Event :: struct {
	object: Registry,
	name: u32,
	interface: string,
	version: u32,
}
Registry_Global_Remove_Event :: struct {
	object: Registry,
	name: u32,
}
Callback_Done_Event :: struct {
	object: Callback,
	callback_data: u32,
}
Shm_Format_Event :: struct {
	object: Shm,
	format: Shm_Format,
}
Buffer_Release_Event :: struct {
	object: Buffer,
}
Data_Offer_Offer_Event :: struct {
	object: Data_Offer,
	mime_type: string,
}
Data_Offer_Source_Actions_Event :: struct {
	object: Data_Offer,
	source_actions: Data_Device_Manager_Dnd_Action,
}
Data_Offer_Action_Event :: struct {
	object: Data_Offer,
	dnd_action: Data_Device_Manager_Dnd_Action,
}
Data_Source_Target_Event :: struct {
	object: Data_Source,
	mime_type: string,
}
Data_Source_Send_Event :: struct {
	object: Data_Source,
	mime_type: string,
	fd: Fd,
}
Data_Source_Cancelled_Event :: struct {
	object: Data_Source,
}
Data_Source_Dnd_Drop_Performed_Event :: struct {
	object: Data_Source,
}
Data_Source_Dnd_Finished_Event :: struct {
	object: Data_Source,
}
Data_Source_Action_Event :: struct {
	object: Data_Source,
	dnd_action: Data_Device_Manager_Dnd_Action,
}
Data_Device_Data_Offer_Event :: struct {
	object: Data_Device,
	id: Data_Offer,
}
Data_Device_Enter_Event :: struct {
	object: Data_Device,
	serial: u32,
	surface: Surface,
	x: f64,
	y: f64,
	id: Data_Offer,
}
Data_Device_Leave_Event :: struct {
	object: Data_Device,
}
Data_Device_Motion_Event :: struct {
	object: Data_Device,
	time: u32,
	x: f64,
	y: f64,
}
Data_Device_Drop_Event :: struct {
	object: Data_Device,
}
Data_Device_Selection_Event :: struct {
	object: Data_Device,
	id: Data_Offer,
}
Shell_Surface_Ping_Event :: struct {
	object: Shell_Surface,
	serial: u32,
}
Shell_Surface_Configure_Event :: struct {
	object: Shell_Surface,
	edges: Shell_Surface_Resize,
	width: i32,
	height: i32,
}
Shell_Surface_Popup_Done_Event :: struct {
	object: Shell_Surface,
}
Surface_Enter_Event :: struct {
	object: Surface,
	output: Output,
}
Surface_Leave_Event :: struct {
	object: Surface,
	output: Output,
}
Surface_Preferred_Buffer_Scale_Event :: struct {
	object: Surface,
	factor: i32,
}
Surface_Preferred_Buffer_Transform_Event :: struct {
	object: Surface,
	transform: Output_Transform,
}
Seat_Capabilities_Event :: struct {
	object: Seat,
	capabilities: Seat_Capability,
}
Seat_Name_Event :: struct {
	object: Seat,
	name: string,
}
Pointer_Enter_Event :: struct {
	object: Pointer,
	serial: u32,
	surface: Surface,
	surface_x: f64,
	surface_y: f64,
}
Pointer_Leave_Event :: struct {
	object: Pointer,
	serial: u32,
	surface: Surface,
}
Pointer_Motion_Event :: struct {
	object: Pointer,
	time: u32,
	surface_x: f64,
	surface_y: f64,
}
Pointer_Button_Event :: struct {
	object: Pointer,
	serial: u32,
	time: u32,
	button: u32,
	state: Pointer_Button_State,
}
Pointer_Axis_Event :: struct {
	object: Pointer,
	time: u32,
	axis: Pointer_Axis,
	value: f64,
}
Pointer_Frame_Event :: struct {
	object: Pointer,
}
Pointer_Axis_Source_Event :: struct {
	object: Pointer,
	axis_source: Pointer_Axis_Source,
}
Pointer_Axis_Stop_Event :: struct {
	object: Pointer,
	time: u32,
	axis: Pointer_Axis,
}
Pointer_Axis_Discrete_Event :: struct {
	object: Pointer,
	axis: Pointer_Axis,
	discrete: i32,
}
Pointer_Axis_Value120_Event :: struct {
	object: Pointer,
	axis: Pointer_Axis,
	value120: i32,
}
Pointer_Axis_Relative_Direction_Event :: struct {
	object: Pointer,
	axis: Pointer_Axis,
	direction: Pointer_Axis_Relative_Direction,
}
Keyboard_Keymap_Event :: struct {
	object: Keyboard,
	format: Keyboard_Keymap_Format,
	fd: Fd,
	size: u32,
}
Keyboard_Enter_Event :: struct {
	object: Keyboard,
	serial: u32,
	surface: Surface,
	keys: []byte,
}
Keyboard_Leave_Event :: struct {
	object: Keyboard,
	serial: u32,
	surface: Surface,
}
Keyboard_Key_Event :: struct {
	object: Keyboard,
	serial: u32,
	time: u32,
	key: u32,
	state: Keyboard_Key_State,
}
Keyboard_Modifiers_Event :: struct {
	object: Keyboard,
	serial: u32,
	mods_depressed: u32,
	mods_latched: u32,
	mods_locked: u32,
	group: u32,
}
Keyboard_Repeat_Info_Event :: struct {
	object: Keyboard,
	rate: i32,
	delay: i32,
}
Touch_Down_Event :: struct {
	object: Touch,
	serial: u32,
	time: u32,
	surface: Surface,
	id: i32,
	x: f64,
	y: f64,
}
Touch_Up_Event :: struct {
	object: Touch,
	serial: u32,
	time: u32,
	id: i32,
}
Touch_Motion_Event :: struct {
	object: Touch,
	time: u32,
	id: i32,
	x: f64,
	y: f64,
}
Touch_Frame_Event :: struct {
	object: Touch,
}
Touch_Cancel_Event :: struct {
	object: Touch,
}
Touch_Shape_Event :: struct {
	object: Touch,
	id: i32,
	major: f64,
	minor: f64,
}
Touch_Orientation_Event :: struct {
	object: Touch,
	id: i32,
	orientation: f64,
}
Output_Geometry_Event :: struct {
	object: Output,
	x: i32,
	y: i32,
	physical_width: i32,
	physical_height: i32,
	subpixel: Output_Subpixel,
	make: string,
	model: string,
	transform: Output_Transform,
}
Output_Mode_Event :: struct {
	object: Output,
	flags: Output_Mode,
	width: i32,
	height: i32,
	refresh: i32,
}
Output_Done_Event :: struct {
	object: Output,
}
Output_Scale_Event :: struct {
	object: Output,
	factor: i32,
}
Output_Name_Event :: struct {
	object: Output,
	name: string,
}
Output_Description_Event :: struct {
	object: Output,
	description: string,
}

parse_display_error :: proc(connection: ^Connection, object: u32) -> (event: Display_Error_Event, ok: bool) {
	event.object = Display(object)
	read(connection, &event.object_id) or_return
	read(connection, &event.code) or_return
	read(connection, &event.message) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_display@", object, ".error:", " object_id=", event.object_id, " code=", event.code, " message=", event.message)
	ok = true
	return
}
parse_display_delete_id :: proc(connection: ^Connection, object: u32) -> (event: Display_Delete_Id_Event, ok: bool) {
	event.object = Display(object)
	read(connection, &event.id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_display@", object, ".delete_id:", " id=", event.id)
	ok = true
	return
}
parse_registry_global :: proc(connection: ^Connection, object: u32) -> (event: Registry_Global_Event, ok: bool) {
	event.object = Registry(object)
	read(connection, &event.name) or_return
	read(connection, &event.interface) or_return
	read(connection, &event.version) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_registry@", object, ".global:", " name=", event.name, " interface=", event.interface, " version=", event.version)
	ok = true
	return
}
parse_registry_global_remove :: proc(connection: ^Connection, object: u32) -> (event: Registry_Global_Remove_Event, ok: bool) {
	event.object = Registry(object)
	read(connection, &event.name) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_registry@", object, ".global_remove:", " name=", event.name)
	ok = true
	return
}
parse_callback_done :: proc(connection: ^Connection, object: u32) -> (event: Callback_Done_Event, ok: bool) {
	event.object = Callback(object)
	read(connection, &event.callback_data) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_callback@", object, ".done:", " callback_data=", event.callback_data)
	ok = true
	return
}
parse_shm_format :: proc(connection: ^Connection, object: u32) -> (event: Shm_Format_Event, ok: bool) {
	event.object = Shm(object)
	read(connection, &event.format) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_shm@", object, ".format:", " format=", event.format)
	ok = true
	return
}
parse_buffer_release :: proc(connection: ^Connection, object: u32) -> (event: Buffer_Release_Event, ok: bool) {
	event.object = Buffer(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_buffer@", object, ".release:")
	ok = true
	return
}
parse_data_offer_offer :: proc(connection: ^Connection, object: u32) -> (event: Data_Offer_Offer_Event, ok: bool) {
	event.object = Data_Offer(object)
	read(connection, &event.mime_type) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_offer@", object, ".offer:", " mime_type=", event.mime_type)
	ok = true
	return
}
parse_data_offer_source_actions :: proc(connection: ^Connection, object: u32) -> (event: Data_Offer_Source_Actions_Event, ok: bool) {
	event.object = Data_Offer(object)
	read(connection, &event.source_actions) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_offer@", object, ".source_actions:", " source_actions=", event.source_actions)
	ok = true
	return
}
parse_data_offer_action :: proc(connection: ^Connection, object: u32) -> (event: Data_Offer_Action_Event, ok: bool) {
	event.object = Data_Offer(object)
	read(connection, &event.dnd_action) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_offer@", object, ".action:", " dnd_action=", event.dnd_action)
	ok = true
	return
}
parse_data_source_target :: proc(connection: ^Connection, object: u32) -> (event: Data_Source_Target_Event, ok: bool) {
	event.object = Data_Source(object)
	read(connection, &event.mime_type) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_source@", object, ".target:", " mime_type=", event.mime_type)
	ok = true
	return
}
parse_data_source_send :: proc(connection: ^Connection, object: u32) -> (event: Data_Source_Send_Event, ok: bool) {
	event.object = Data_Source(object)
	read(connection, &event.mime_type) or_return
	read_fd(connection, &event.fd) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_source@", object, ".send:", " mime_type=", event.mime_type, " fd=", event.fd)
	ok = true
	return
}
parse_data_source_cancelled :: proc(connection: ^Connection, object: u32) -> (event: Data_Source_Cancelled_Event, ok: bool) {
	event.object = Data_Source(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_source@", object, ".cancelled:")
	ok = true
	return
}
parse_data_source_dnd_drop_performed :: proc(connection: ^Connection, object: u32) -> (event: Data_Source_Dnd_Drop_Performed_Event, ok: bool) {
	event.object = Data_Source(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_source@", object, ".dnd_drop_performed:")
	ok = true
	return
}
parse_data_source_dnd_finished :: proc(connection: ^Connection, object: u32) -> (event: Data_Source_Dnd_Finished_Event, ok: bool) {
	event.object = Data_Source(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_source@", object, ".dnd_finished:")
	ok = true
	return
}
parse_data_source_action :: proc(connection: ^Connection, object: u32) -> (event: Data_Source_Action_Event, ok: bool) {
	event.object = Data_Source(object)
	read(connection, &event.dnd_action) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_source@", object, ".action:", " dnd_action=", event.dnd_action)
	ok = true
	return
}
parse_data_device_data_offer :: proc(connection: ^Connection, object: u32) -> (event: Data_Device_Data_Offer_Event, ok: bool) {
	event.object = Data_Device(object)
	read(connection, &event.id) or_return
	resize(&connection.server_object_types, max(len(connection.server_object_types), int(event.id) - SERVER_ID_START + 1))
	connection.server_object_types[u32(event.id) - SERVER_ID_START] = .Wl_Data_Offer
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_device@", object, ".data_offer:", " id=", event.id)
	ok = true
	return
}
parse_data_device_enter :: proc(connection: ^Connection, object: u32) -> (event: Data_Device_Enter_Event, ok: bool) {
	event.object = Data_Device(object)
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	read(connection, &event.id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_device@", object, ".enter:", " serial=", event.serial, " surface=", event.surface, " x=", event.x, " y=", event.y, " id=", event.id)
	ok = true
	return
}
parse_data_device_leave :: proc(connection: ^Connection, object: u32) -> (event: Data_Device_Leave_Event, ok: bool) {
	event.object = Data_Device(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_device@", object, ".leave:")
	ok = true
	return
}
parse_data_device_motion :: proc(connection: ^Connection, object: u32) -> (event: Data_Device_Motion_Event, ok: bool) {
	event.object = Data_Device(object)
	read(connection, &event.time) or_return
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_device@", object, ".motion:", " time=", event.time, " x=", event.x, " y=", event.y)
	ok = true
	return
}
parse_data_device_drop :: proc(connection: ^Connection, object: u32) -> (event: Data_Device_Drop_Event, ok: bool) {
	event.object = Data_Device(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_device@", object, ".drop:")
	ok = true
	return
}
parse_data_device_selection :: proc(connection: ^Connection, object: u32) -> (event: Data_Device_Selection_Event, ok: bool) {
	event.object = Data_Device(object)
	read(connection, &event.id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_data_device@", object, ".selection:", " id=", event.id)
	ok = true
	return
}
parse_shell_surface_ping :: proc(connection: ^Connection, object: u32) -> (event: Shell_Surface_Ping_Event, ok: bool) {
	event.object = Shell_Surface(object)
	read(connection, &event.serial) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_shell_surface@", object, ".ping:", " serial=", event.serial)
	ok = true
	return
}
parse_shell_surface_configure :: proc(connection: ^Connection, object: u32) -> (event: Shell_Surface_Configure_Event, ok: bool) {
	event.object = Shell_Surface(object)
	read(connection, &event.edges) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_shell_surface@", object, ".configure:", " edges=", event.edges, " width=", event.width, " height=", event.height)
	ok = true
	return
}
parse_shell_surface_popup_done :: proc(connection: ^Connection, object: u32) -> (event: Shell_Surface_Popup_Done_Event, ok: bool) {
	event.object = Shell_Surface(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_shell_surface@", object, ".popup_done:")
	ok = true
	return
}
parse_surface_enter :: proc(connection: ^Connection, object: u32) -> (event: Surface_Enter_Event, ok: bool) {
	event.object = Surface(object)
	read(connection, &event.output) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_surface@", object, ".enter:", " output=", event.output)
	ok = true
	return
}
parse_surface_leave :: proc(connection: ^Connection, object: u32) -> (event: Surface_Leave_Event, ok: bool) {
	event.object = Surface(object)
	read(connection, &event.output) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_surface@", object, ".leave:", " output=", event.output)
	ok = true
	return
}
parse_surface_preferred_buffer_scale :: proc(connection: ^Connection, object: u32) -> (event: Surface_Preferred_Buffer_Scale_Event, ok: bool) {
	event.object = Surface(object)
	read(connection, &event.factor) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_surface@", object, ".preferred_buffer_scale:", " factor=", event.factor)
	ok = true
	return
}
parse_surface_preferred_buffer_transform :: proc(connection: ^Connection, object: u32) -> (event: Surface_Preferred_Buffer_Transform_Event, ok: bool) {
	event.object = Surface(object)
	read(connection, &event.transform) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_surface@", object, ".preferred_buffer_transform:", " transform=", event.transform)
	ok = true
	return
}
parse_seat_capabilities :: proc(connection: ^Connection, object: u32) -> (event: Seat_Capabilities_Event, ok: bool) {
	event.object = Seat(object)
	read(connection, &event.capabilities) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_seat@", object, ".capabilities:", " capabilities=", event.capabilities)
	ok = true
	return
}
parse_seat_name :: proc(connection: ^Connection, object: u32) -> (event: Seat_Name_Event, ok: bool) {
	event.object = Seat(object)
	read(connection, &event.name) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_seat@", object, ".name:", " name=", event.name)
	ok = true
	return
}
parse_pointer_enter :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Enter_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	read(connection, &event.surface_x) or_return
	read(connection, &event.surface_y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".enter:", " serial=", event.serial, " surface=", event.surface, " surface_x=", event.surface_x, " surface_y=", event.surface_y)
	ok = true
	return
}
parse_pointer_leave :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Leave_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".leave:", " serial=", event.serial, " surface=", event.surface)
	ok = true
	return
}
parse_pointer_motion :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Motion_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.time) or_return
	read(connection, &event.surface_x) or_return
	read(connection, &event.surface_y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".motion:", " time=", event.time, " surface_x=", event.surface_x, " surface_y=", event.surface_y)
	ok = true
	return
}
parse_pointer_button :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Button_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.serial) or_return
	read(connection, &event.time) or_return
	read(connection, &event.button) or_return
	read(connection, &event.state) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".button:", " serial=", event.serial, " time=", event.time, " button=", event.button, " state=", event.state)
	ok = true
	return
}
parse_pointer_axis :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Axis_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.time) or_return
	read(connection, &event.axis) or_return
	read(connection, &event.value) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".axis:", " time=", event.time, " axis=", event.axis, " value=", event.value)
	ok = true
	return
}
parse_pointer_frame :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Frame_Event, ok: bool) {
	event.object = Pointer(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".frame:")
	ok = true
	return
}
parse_pointer_axis_source :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Axis_Source_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.axis_source) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".axis_source:", " axis_source=", event.axis_source)
	ok = true
	return
}
parse_pointer_axis_stop :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Axis_Stop_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.time) or_return
	read(connection, &event.axis) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".axis_stop:", " time=", event.time, " axis=", event.axis)
	ok = true
	return
}
parse_pointer_axis_discrete :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Axis_Discrete_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.axis) or_return
	read(connection, &event.discrete) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".axis_discrete:", " axis=", event.axis, " discrete=", event.discrete)
	ok = true
	return
}
parse_pointer_axis_value120 :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Axis_Value120_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.axis) or_return
	read(connection, &event.value120) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".axis_value120:", " axis=", event.axis, " value120=", event.value120)
	ok = true
	return
}
parse_pointer_axis_relative_direction :: proc(connection: ^Connection, object: u32) -> (event: Pointer_Axis_Relative_Direction_Event, ok: bool) {
	event.object = Pointer(object)
	read(connection, &event.axis) or_return
	read(connection, &event.direction) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_pointer@", object, ".axis_relative_direction:", " axis=", event.axis, " direction=", event.direction)
	ok = true
	return
}
parse_keyboard_keymap :: proc(connection: ^Connection, object: u32) -> (event: Keyboard_Keymap_Event, ok: bool) {
	event.object = Keyboard(object)
	read(connection, &event.format) or_return
	read_fd(connection, &event.fd) or_return
	read(connection, &event.size) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_keyboard@", object, ".keymap:", " format=", event.format, " fd=", event.fd, " size=", event.size)
	ok = true
	return
}
parse_keyboard_enter :: proc(connection: ^Connection, object: u32) -> (event: Keyboard_Enter_Event, ok: bool) {
	event.object = Keyboard(object)
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	read(connection, &event.keys) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_keyboard@", object, ".enter:", " serial=", event.serial, " surface=", event.surface, " keys=", event.keys)
	ok = true
	return
}
parse_keyboard_leave :: proc(connection: ^Connection, object: u32) -> (event: Keyboard_Leave_Event, ok: bool) {
	event.object = Keyboard(object)
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_keyboard@", object, ".leave:", " serial=", event.serial, " surface=", event.surface)
	ok = true
	return
}
parse_keyboard_key :: proc(connection: ^Connection, object: u32) -> (event: Keyboard_Key_Event, ok: bool) {
	event.object = Keyboard(object)
	read(connection, &event.serial) or_return
	read(connection, &event.time) or_return
	read(connection, &event.key) or_return
	read(connection, &event.state) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_keyboard@", object, ".key:", " serial=", event.serial, " time=", event.time, " key=", event.key, " state=", event.state)
	ok = true
	return
}
parse_keyboard_modifiers :: proc(connection: ^Connection, object: u32) -> (event: Keyboard_Modifiers_Event, ok: bool) {
	event.object = Keyboard(object)
	read(connection, &event.serial) or_return
	read(connection, &event.mods_depressed) or_return
	read(connection, &event.mods_latched) or_return
	read(connection, &event.mods_locked) or_return
	read(connection, &event.group) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_keyboard@", object, ".modifiers:", " serial=", event.serial, " mods_depressed=", event.mods_depressed, " mods_latched=", event.mods_latched, " mods_locked=", event.mods_locked, " group=", event.group)
	ok = true
	return
}
parse_keyboard_repeat_info :: proc(connection: ^Connection, object: u32) -> (event: Keyboard_Repeat_Info_Event, ok: bool) {
	event.object = Keyboard(object)
	read(connection, &event.rate) or_return
	read(connection, &event.delay) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_keyboard@", object, ".repeat_info:", " rate=", event.rate, " delay=", event.delay)
	ok = true
	return
}
parse_touch_down :: proc(connection: ^Connection, object: u32) -> (event: Touch_Down_Event, ok: bool) {
	event.object = Touch(object)
	read(connection, &event.serial) or_return
	read(connection, &event.time) or_return
	read(connection, &event.surface) or_return
	read(connection, &event.id) or_return
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_touch@", object, ".down:", " serial=", event.serial, " time=", event.time, " surface=", event.surface, " id=", event.id, " x=", event.x, " y=", event.y)
	ok = true
	return
}
parse_touch_up :: proc(connection: ^Connection, object: u32) -> (event: Touch_Up_Event, ok: bool) {
	event.object = Touch(object)
	read(connection, &event.serial) or_return
	read(connection, &event.time) or_return
	read(connection, &event.id) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_touch@", object, ".up:", " serial=", event.serial, " time=", event.time, " id=", event.id)
	ok = true
	return
}
parse_touch_motion :: proc(connection: ^Connection, object: u32) -> (event: Touch_Motion_Event, ok: bool) {
	event.object = Touch(object)
	read(connection, &event.time) or_return
	read(connection, &event.id) or_return
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_touch@", object, ".motion:", " time=", event.time, " id=", event.id, " x=", event.x, " y=", event.y)
	ok = true
	return
}
parse_touch_frame :: proc(connection: ^Connection, object: u32) -> (event: Touch_Frame_Event, ok: bool) {
	event.object = Touch(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_touch@", object, ".frame:")
	ok = true
	return
}
parse_touch_cancel :: proc(connection: ^Connection, object: u32) -> (event: Touch_Cancel_Event, ok: bool) {
	event.object = Touch(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_touch@", object, ".cancel:")
	ok = true
	return
}
parse_touch_shape :: proc(connection: ^Connection, object: u32) -> (event: Touch_Shape_Event, ok: bool) {
	event.object = Touch(object)
	read(connection, &event.id) or_return
	read(connection, &event.major) or_return
	read(connection, &event.minor) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_touch@", object, ".shape:", " id=", event.id, " major=", event.major, " minor=", event.minor)
	ok = true
	return
}
parse_touch_orientation :: proc(connection: ^Connection, object: u32) -> (event: Touch_Orientation_Event, ok: bool) {
	event.object = Touch(object)
	read(connection, &event.id) or_return
	read(connection, &event.orientation) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_touch@", object, ".orientation:", " id=", event.id, " orientation=", event.orientation)
	ok = true
	return
}
parse_output_geometry :: proc(connection: ^Connection, object: u32) -> (event: Output_Geometry_Event, ok: bool) {
	event.object = Output(object)
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	read(connection, &event.physical_width) or_return
	read(connection, &event.physical_height) or_return
	read(connection, &event.subpixel) or_return
	read(connection, &event.make) or_return
	read(connection, &event.model) or_return
	read(connection, &event.transform) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_output@", object, ".geometry:", " x=", event.x, " y=", event.y, " physical_width=", event.physical_width, " physical_height=", event.physical_height, " subpixel=", event.subpixel, " make=", event.make, " model=", event.model, " transform=", event.transform)
	ok = true
	return
}
parse_output_mode :: proc(connection: ^Connection, object: u32) -> (event: Output_Mode_Event, ok: bool) {
	event.object = Output(object)
	read(connection, &event.flags) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	read(connection, &event.refresh) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_output@", object, ".mode:", " flags=", event.flags, " width=", event.width, " height=", event.height, " refresh=", event.refresh)
	ok = true
	return
}
parse_output_done :: proc(connection: ^Connection, object: u32) -> (event: Output_Done_Event, ok: bool) {
	event.object = Output(object)
	if connection.log_fn != nil do _debug_log(connection, "<- wl_output@", object, ".done:")
	ok = true
	return
}
parse_output_scale :: proc(connection: ^Connection, object: u32) -> (event: Output_Scale_Event, ok: bool) {
	event.object = Output(object)
	read(connection, &event.factor) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_output@", object, ".scale:", " factor=", event.factor)
	ok = true
	return
}
parse_output_name :: proc(connection: ^Connection, object: u32) -> (event: Output_Name_Event, ok: bool) {
	event.object = Output(object)
	read(connection, &event.name) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_output@", object, ".name:", " name=", event.name)
	ok = true
	return
}
parse_output_description :: proc(connection: ^Connection, object: u32) -> (event: Output_Description_Event, ok: bool) {
	event.object = Output(object)
	read(connection, &event.description) or_return
	if connection.log_fn != nil do _debug_log(connection, "<- wl_output@", object, ".description:", " description=", event.description)
	ok = true
	return
}

Display :: distinct u32
Registry :: distinct u32
Callback :: distinct u32
Compositor :: distinct u32
Shm_Pool :: distinct u32
Shm :: distinct u32
Buffer :: distinct u32
Data_Offer :: distinct u32
Data_Source :: distinct u32
Data_Device :: distinct u32
Data_Device_Manager :: distinct u32
Shell :: distinct u32
Shell_Surface :: distinct u32
Surface :: distinct u32
Seat :: distinct u32
Pointer :: distinct u32
Keyboard :: distinct u32
Touch :: distinct u32
Output :: distinct u32
Region :: distinct u32
Subcompositor :: distinct u32
Subsurface :: distinct u32
Fixes :: distinct u32

