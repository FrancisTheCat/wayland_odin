package wayland

import "core:bytes"

import "base:intrinsics"

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
Zwp_Linux_Buffer_Params_V1_Error :: enum u32 {
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
Zwp_Linux_Buffer_Params_V1_Flags_Bits :: enum {
	// contents are y-inverted
	Y_Invert = 0,
	// content is interlaced
	Interlaced = 1,
	// bottom field first
	Bottom_First = 2,
}
Zwp_Linux_Buffer_Params_V1_Flags :: distinct bit_set[Zwp_Linux_Buffer_Params_V1_Flags_Bits; u32]
Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Flags_Bits :: enum {
	// direct scan-out tranche
	Scanout = 0,
}
Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Flags :: distinct bit_set[Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Flags_Bits; u32]
Wp_Presentation_Error :: enum u32 {
	// invalid value in tv_nsec
	Invalid_Timestamp = 0,
	// invalid flag
	Invalid_Flag = 1,
}
Wp_Presentation_Feedback_Kind_Bits :: enum {
	Vsync = 0,
	Hw_Clock = 1,
	Hw_Completion = 2,
	Zero_Copy = 3,
}
Wp_Presentation_Feedback_Kind :: distinct bit_set[Wp_Presentation_Feedback_Kind_Bits; u32]
Zwp_Tablet_Tool_V2_Type :: enum u32 {
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
Zwp_Tablet_Tool_V2_Capability :: enum u32 {
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
Zwp_Tablet_Tool_V2_Button_State :: enum u32 {
	// button is not pressed
	Released = 0,
	// button is pressed
	Pressed = 1,
}
Zwp_Tablet_Tool_V2_Error :: enum u32 {
	// given wl_surface has another role
	Role = 0,
}
Zwp_Tablet_V2_Bustype :: enum u32 {
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
Zwp_Tablet_Pad_Ring_V2_Source :: enum u32 {
	// finger
	Finger = 1,
}
Zwp_Tablet_Pad_Strip_V2_Source :: enum u32 {
	// finger
	Finger = 1,
}
Zwp_Tablet_Pad_V2_Button_State :: enum u32 {
	// the button is not pressed
	Released = 0,
	// the button is pressed
	Pressed = 1,
}
Wp_Viewporter_Error :: enum u32 {
	// the surface already has a viewport object associated
	Viewport_Exists = 0,
}
Wp_Viewport_Error :: enum u32 {
	// negative or zero values in width or height
	Bad_Value = 0,
	// destination size is not integer
	Bad_Size = 1,
	// source rectangle extends outside of the content area
	Out_Of_Buffer = 2,
	// the wl_surface was destroyed
	No_Surface = 3,
}
Xdg_Wm_Base_Error :: enum u32 {
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
Xdg_Positioner_Error :: enum u32 {
	// invalid input provided
	Invalid_Input = 0,
}
Xdg_Positioner_Anchor :: enum u32 {
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
Xdg_Positioner_Gravity :: enum u32 {
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
Xdg_Positioner_Constraint_Adjustment_Bits :: enum {
	Slide_X = 0,
	Slide_Y = 1,
	Flip_X = 2,
	Flip_Y = 3,
	Resize_X = 4,
	Resize_Y = 5,
}
Xdg_Positioner_Constraint_Adjustment :: distinct bit_set[Xdg_Positioner_Constraint_Adjustment_Bits; u32]
Xdg_Surface_Error :: enum u32 {
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
Xdg_Toplevel_Error :: enum u32 {
	// provided value is not a valid variant of the resize_edge enum
	Invalid_Resize_Edge = 0,
	// invalid parent toplevel
	Invalid_Parent = 1,
	// client provided an invalid min or max size
	Invalid_Size = 2,
}
Xdg_Toplevel_Resize_Edge :: enum u32 {
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
Xdg_Toplevel_State :: enum u32 {
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
Xdg_Toplevel_Wm_Capabilities :: enum u32 {
	// show_window_menu is available
	Window_Menu = 1,
	// set_maximized and unset_maximized are available
	Maximize = 2,
	// set_fullscreen and unset_fullscreen are available
	Fullscreen = 3,
	// set_minimized is available
	Minimize = 4,
}
Xdg_Popup_Error :: enum u32 {
	// tried to grab after being mapped
	Invalid_Grab = 0,
}
Wp_Alpha_Modifier_V1_Error :: enum u32 {
	// wl_surface already has a alpha modifier object
	Already_Constructed = 0,
}
Wp_Alpha_Modifier_Surface_V1_Error :: enum u32 {
	// wl_surface was destroyed
	No_Surface = 0,
}
Wp_Color_Manager_V1_Error :: enum u32 {
	// request not supported
	Unsupported_Feature = 0,
	// color management surface exists already
	Surface_Exists = 1,
}
Wp_Color_Manager_V1_Render_Intent :: enum u32 {
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
}
Wp_Color_Manager_V1_Feature :: enum u32 {
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
Wp_Color_Manager_V1_Primaries :: enum u32 {
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
Wp_Color_Manager_V1_Transfer_Function :: enum u32 {
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
}
Wp_Color_Management_Surface_V1_Error :: enum u32 {
	// unsupported rendering intent
	Render_Intent = 0,
	// invalid image description
	Image_Description = 1,
	// forbidden request on inert object
	Inert = 2,
}
Wp_Color_Management_Surface_Feedback_V1_Error :: enum u32 {
	// forbidden request on inert object
	Inert = 0,
	// attempted to use an unsupported feature
	Unsupported_Feature = 1,
}
Wp_Image_Description_Creator_Icc_V1_Error :: enum u32 {
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
Wp_Image_Description_Creator_Params_V1_Error :: enum u32 {
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
Wp_Image_Description_V1_Error :: enum u32 {
	// attempted to use an object which is not ready
	Not_Ready = 0,
	// get_information not allowed
	No_Information = 1,
}
Wp_Image_Description_V1_Cause :: enum u32 {
	// interface version too low
	Low_Version = 0,
	// unsupported image description data
	Unsupported = 1,
	// error independent of the client
	Operating_System = 2,
	// the relevant output no longer exists
	No_Output = 3,
}
Wp_Color_Representation_Manager_V1_Error :: enum u32 {
	// color representation surface exists already
	Surface_Exists = 1,
}
Wp_Color_Representation_Surface_V1_Error :: enum u32 {
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
Wp_Color_Representation_Surface_V1_Alpha_Mode :: enum u32 {
	Premultiplied_Electrical = 0,
	Premultiplied_Optical = 1,
	Straight = 2,
}
Wp_Color_Representation_Surface_V1_Coefficients :: enum u32 {
	Identity = 1,
	Bt709 = 2,
	Fcc = 3,
	Bt601 = 4,
	Smpte240 = 5,
	Bt2020 = 6,
	Bt2020_Cl = 7,
	Ictcp = 8,
}
Wp_Color_Representation_Surface_V1_Range :: enum u32 {
	// Full color range
	Full = 1,
	// Limited color range
	Limited = 2,
}
Wp_Color_Representation_Surface_V1_Chroma_Location :: enum u32 {
	Type_0 = 1,
	Type_1 = 2,
	Type_2 = 3,
	Type_3 = 4,
	Type_4 = 5,
	Type_5 = 6,
}
Wp_Commit_Timing_Manager_V1_Error :: enum u32 {
	// commit timer already exists for surface
	Commit_Timer_Exists = 0,
}
Wp_Commit_Timer_V1_Error :: enum u32 {
	// timestamp contains an invalid value
	Invalid_Timestamp = 0,
	// timestamp exists
	Timestamp_Exists = 1,
	// the associated surface no longer exists
	Surface_Destroyed = 2,
}
Wp_Content_Type_Manager_V1_Error :: enum u32 {
	// wl_surface already has a content type object
	Already_Constructed = 0,
}
Wp_Content_Type_V1_Type :: enum u32 {
	None = 0,
	Photo = 1,
	Video = 2,
	Game = 3,
}
Wp_Cursor_Shape_Device_V1_Shape :: enum u32 {
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
Wp_Cursor_Shape_Device_V1_Error :: enum u32 {
	// the specified shape value is invalid
	Invalid_Shape = 1,
}
Wp_Drm_Lease_Request_V1_Error :: enum u32 {
	// requested a connector from a different lease device
	Wrong_Device = 0,
	// requested a connector twice
	Duplicate_Connector = 1,
	// requested a lease without requesting a connector
	Empty_Lease = 2,
}
Ext_Background_Effect_Manager_V1_Error :: enum u32 {
	// the surface already has a background effect object
	Background_Effect_Exists = 0,
}
Ext_Background_Effect_Manager_V1_Capability_Bits :: enum {
	// the compositor supports applying blur
	Blur = 0,
}
Ext_Background_Effect_Manager_V1_Capability :: distinct bit_set[Ext_Background_Effect_Manager_V1_Capability_Bits; u32]
Ext_Background_Effect_Surface_V1_Error :: enum u32 {
	// the associated surface has been destroyed
	Surface_Destroyed = 0,
}
Ext_Data_Control_Device_V1_Error :: enum u32 {
	// source given to set_selection or set_primary_selection was already used before
	Used_Source = 1,
}
Ext_Data_Control_Source_V1_Error :: enum u32 {
	// offer sent after ext_data_control_device.set_selection
	Invalid_Offer = 1,
}
Ext_Image_Copy_Capture_Manager_V1_Error :: enum u32 {
	// invalid option flag
	Invalid_Option = 1,
}
Ext_Image_Copy_Capture_Manager_V1_Options_Bits :: enum {
	// paint cursors onto captured frames
	Paint_Cursors = 0,
}
Ext_Image_Copy_Capture_Manager_V1_Options :: distinct bit_set[Ext_Image_Copy_Capture_Manager_V1_Options_Bits; u32]
Ext_Image_Copy_Capture_Session_V1_Error :: enum u32 {
	// create_frame sent before destroying previous frame
	Duplicate_Frame = 1,
}
Ext_Image_Copy_Capture_Frame_V1_Error :: enum u32 {
	// capture sent without attach_buffer
	No_Buffer = 1,
	// invalid buffer damage
	Invalid_Buffer_Damage = 2,
	// capture request has been sent
	Already_Captured = 3,
}
Ext_Image_Copy_Capture_Frame_V1_Failure_Reason :: enum u32 {
	Unknown = 0,
	Buffer_Constraints = 1,
	Stopped = 2,
}
Ext_Image_Copy_Capture_Cursor_Session_V1_Error :: enum u32 {
	// get_capture_session sent twice
	Duplicate_Session = 1,
}
Ext_Session_Lock_V1_Error :: enum u32 {
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
Ext_Session_Lock_Surface_V1_Error :: enum u32 {
	// surface committed before first ack_configure request
	Commit_Before_First_Ack = 0,
	// surface committed with a null buffer
	Null_Buffer = 1,
	// failed to match ack'd width/height
	Dimensions_Mismatch = 2,
	// serial provided in ack_configure is invalid
	Invalid_Serial = 3,
}
Ext_Workspace_Group_Handle_V1_Group_Capabilities_Bits :: enum {
	// create_workspace request is available
	Create_Workspace = 0,
}
Ext_Workspace_Group_Handle_V1_Group_Capabilities :: distinct bit_set[Ext_Workspace_Group_Handle_V1_Group_Capabilities_Bits; u32]
Ext_Workspace_Handle_V1_State_Bits :: enum {
	// the workspace is active
	Active = 0,
	// the workspace requests attention
	Urgent = 1,
	Hidden = 2,
}
Ext_Workspace_Handle_V1_State :: distinct bit_set[Ext_Workspace_Handle_V1_State_Bits; u32]
Ext_Workspace_Handle_V1_Workspace_Capabilities_Bits :: enum {
	// activate request is available
	Activate = 0,
	// deactivate request is available
	Deactivate = 1,
	// remove request is available
	Remove = 2,
	// assign request is available
	Assign = 3,
}
Ext_Workspace_Handle_V1_Workspace_Capabilities :: distinct bit_set[Ext_Workspace_Handle_V1_Workspace_Capabilities_Bits; u32]
Wp_Fifo_Manager_V1_Error :: enum u32 {
	// fifo manager already exists for surface
	Already_Exists = 0,
}
Wp_Fifo_V1_Error :: enum u32 {
	// the associated surface no longer exists
	Surface_Destroyed = 0,
}
Wp_Fractional_Scale_Manager_V1_Error :: enum u32 {
	// the surface already has a fractional_scale object associated
	Fractional_Scale_Exists = 0,
}
Wp_Linux_Drm_Syncobj_Manager_V1_Error :: enum u32 {
	// the surface already has a synchronization object associated
	Surface_Exists = 0,
	// the timeline object could not be imported
	Invalid_Timeline = 1,
}
Wp_Linux_Drm_Syncobj_Surface_V1_Error :: enum u32 {
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
Wp_Security_Context_Manager_V1_Error :: enum u32 {
	// listening socket FD is invalid
	Invalid_Listen_Fd = 1,
	// nested security contexts are forbidden
	Nested = 2,
}
Wp_Security_Context_V1_Error :: enum u32 {
	// security context has already been committed
	Already_Used = 1,
	// metadata has already been set
	Already_Set = 2,
	// metadata is invalid
	Invalid_Metadata = 3,
}
Wp_Tearing_Control_Manager_V1_Error :: enum u32 {
	// the surface already has a tearing object associated
	Tearing_Control_Exists = 0,
}
Wp_Tearing_Control_V1_Presentation_Hint :: enum u32 {
	Vsync = 0,
	Async = 1,
}
Xdg_Activation_Token_V1_Error :: enum u32 {
	// The token has already been used previously
	Already_Used = 0,
}
Xdg_Wm_Dialog_V1_Error :: enum u32 {
	// the xdg_toplevel object has already been used to create a xdg_dialog_v1
	Already_Used = 0,
}
Xdg_Toplevel_Drag_Manager_V1_Error :: enum u32 {
	// data_source already used for toplevel drag
	Invalid_Source = 0,
}
Xdg_Toplevel_Drag_V1_Error :: enum u32 {
	// valid toplevel already attached
	Toplevel_Attached = 0,
	// drag has not ended
	Ongoing_Drag = 1,
}
Xdg_Toplevel_Icon_V1_Error :: enum u32 {
	// the provided buffer does not satisfy requirements
	Invalid_Buffer = 1,
	// the icon has already been assigned to a toplevel and must not be changed
	Immutable = 2,
	// the provided buffer has been destroyed before the toplevel icon
	No_Buffer = 3,
}
Xwayland_Shell_V1_Error :: enum u32 {
	// given wl_surface has another role
	Role = 0,
}
Xwayland_Surface_V1_Error :: enum u32 {
	// given wl_surface is already associated with an X11 window
	Already_Associated = 0,
	// serial was not valid
	Invalid_Serial = 1,
}

display_sync :: proc(connection: ^Connection, wl_display: Display) -> (callback: Callback) {
	_size: u16 = 8 + size_of(callback)
	wl_display := wl_display
	bytes.buffer_write_ptr(&connection.buffer, &wl_display, size_of(wl_display))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	callback = auto_cast generate_id(connection, .Callback)
	bytes.buffer_write_ptr(&connection.buffer, &callback, size_of(callback))
	return
}
display_get_registry :: proc(connection: ^Connection, wl_display: Display) -> (registry: Registry) {
	_size: u16 = 8 + size_of(registry)
	wl_display := wl_display
	bytes.buffer_write_ptr(&connection.buffer, &wl_display, size_of(wl_display))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	registry = auto_cast generate_id(connection, .Registry)
	bytes.buffer_write_ptr(&connection.buffer, &registry, size_of(registry))
	return
}
registry_bind :: proc(connection: ^Connection, wl_registry: Registry, name: u32, interface: string, version: u32, $T: typeid, _location := #caller_location) -> (id: T) where intrinsics.type_is_named(T), intrinsics.type_base_type(T) == u32 {
	_size: u16 = 8 + size_of(name) + 4 + u16((len(interface) + 1 + 3) & -4) + size_of(version) + size_of(id)
	wl_registry := wl_registry
	bytes.buffer_write_ptr(&connection.buffer, &wl_registry, size_of(wl_registry))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	name := name
	bytes.buffer_write_ptr(&connection.buffer, &name, size_of(name))
	_interface_len := u32(len(interface)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_interface_len, 4)
	bytes.buffer_write_string(&connection.buffer, interface)
	for _ in len(interface) ..< (len(interface) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	version := version
	bytes.buffer_write_ptr(&connection.buffer, &version, size_of(version))
	_type := resolve_type(T, interface, _location)
	id = auto_cast generate_id(connection, _type)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
compositor_create_surface :: proc(connection: ^Connection, wl_compositor: Compositor) -> (id: Surface) {
	_size: u16 = 8 + size_of(id)
	wl_compositor := wl_compositor
	bytes.buffer_write_ptr(&connection.buffer, &wl_compositor, size_of(wl_compositor))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Surface)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
compositor_create_region :: proc(connection: ^Connection, wl_compositor: Compositor) -> (id: Region) {
	_size: u16 = 8 + size_of(id)
	wl_compositor := wl_compositor
	bytes.buffer_write_ptr(&connection.buffer, &wl_compositor, size_of(wl_compositor))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Region)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
shm_pool_create_buffer :: proc(connection: ^Connection, wl_shm_pool: Shm_Pool, offset: i32, width: i32, height: i32, stride: i32, format: Shm_Format) -> (id: Buffer) {
	_size: u16 = 8 + size_of(id) + size_of(offset) + size_of(width) + size_of(height) + size_of(stride) + size_of(format)
	wl_shm_pool := wl_shm_pool
	bytes.buffer_write_ptr(&connection.buffer, &wl_shm_pool, size_of(wl_shm_pool))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Buffer)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	offset := offset
	bytes.buffer_write_ptr(&connection.buffer, &offset, size_of(offset))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	stride := stride
	bytes.buffer_write_ptr(&connection.buffer, &stride, size_of(stride))
	format := format
	bytes.buffer_write_ptr(&connection.buffer, &format, size_of(format))
	return
}
shm_pool_destroy :: proc(connection: ^Connection, wl_shm_pool: Shm_Pool) {
	_size: u16 = 8
	wl_shm_pool := wl_shm_pool
	bytes.buffer_write_ptr(&connection.buffer, &wl_shm_pool, size_of(wl_shm_pool))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
shm_pool_resize :: proc(connection: ^Connection, wl_shm_pool: Shm_Pool, size: i32) {
	_size: u16 = 8 + size_of(size)
	wl_shm_pool := wl_shm_pool
	bytes.buffer_write_ptr(&connection.buffer, &wl_shm_pool, size_of(wl_shm_pool))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	size := size
	bytes.buffer_write_ptr(&connection.buffer, &size, size_of(size))
	return
}
shm_create_pool :: proc(connection: ^Connection, wl_shm: Shm, fd: Fd, size: i32) -> (id: Shm_Pool) {
	_size: u16 = 8 + size_of(id) + size_of(size)
	wl_shm := wl_shm
	bytes.buffer_write_ptr(&connection.buffer, &wl_shm, size_of(wl_shm))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Shm_Pool)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	append(&connection.fds_out, fd)
	size := size
	bytes.buffer_write_ptr(&connection.buffer, &size, size_of(size))
	return
}
shm_release :: proc(connection: ^Connection, wl_shm: Shm) {
	_size: u16 = 8
	wl_shm := wl_shm
	bytes.buffer_write_ptr(&connection.buffer, &wl_shm, size_of(wl_shm))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
buffer_destroy :: proc(connection: ^Connection, wl_buffer: Buffer) {
	_size: u16 = 8
	wl_buffer := wl_buffer
	bytes.buffer_write_ptr(&connection.buffer, &wl_buffer, size_of(wl_buffer))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
data_offer_accept :: proc(connection: ^Connection, wl_data_offer: Data_Offer, serial: u32, mime_type: string) {
	_size: u16 = 8 + size_of(serial) + 4 + u16((len(mime_type) + 1 + 3) & -4)
	wl_data_offer := wl_data_offer
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_offer, size_of(wl_data_offer))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	_mime_type_len := u32(len(mime_type)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_mime_type_len, 4)
	bytes.buffer_write_string(&connection.buffer, mime_type)
	for _ in len(mime_type) ..< (len(mime_type) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
data_offer_receive :: proc(connection: ^Connection, wl_data_offer: Data_Offer, mime_type: string, fd: Fd) {
	_size: u16 = 8 + 4 + u16((len(mime_type) + 1 + 3) & -4)
	wl_data_offer := wl_data_offer
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_offer, size_of(wl_data_offer))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_mime_type_len := u32(len(mime_type)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_mime_type_len, 4)
	bytes.buffer_write_string(&connection.buffer, mime_type)
	for _ in len(mime_type) ..< (len(mime_type) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	append(&connection.fds_out, fd)
	return
}
data_offer_destroy :: proc(connection: ^Connection, wl_data_offer: Data_Offer) {
	_size: u16 = 8
	wl_data_offer := wl_data_offer
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_offer, size_of(wl_data_offer))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
data_offer_finish :: proc(connection: ^Connection, wl_data_offer: Data_Offer) {
	_size: u16 = 8
	wl_data_offer := wl_data_offer
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_offer, size_of(wl_data_offer))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
data_offer_set_actions :: proc(connection: ^Connection, wl_data_offer: Data_Offer, dnd_actions: Data_Device_Manager_Dnd_Action, preferred_action: Data_Device_Manager_Dnd_Action) {
	_size: u16 = 8 + size_of(dnd_actions) + size_of(preferred_action)
	wl_data_offer := wl_data_offer
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_offer, size_of(wl_data_offer))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	dnd_actions := dnd_actions
	bytes.buffer_write_ptr(&connection.buffer, &dnd_actions, size_of(dnd_actions))
	preferred_action := preferred_action
	bytes.buffer_write_ptr(&connection.buffer, &preferred_action, size_of(preferred_action))
	return
}
data_source_offer :: proc(connection: ^Connection, wl_data_source: Data_Source, mime_type: string) {
	_size: u16 = 8 + 4 + u16((len(mime_type) + 1 + 3) & -4)
	wl_data_source := wl_data_source
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_source, size_of(wl_data_source))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_mime_type_len := u32(len(mime_type)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_mime_type_len, 4)
	bytes.buffer_write_string(&connection.buffer, mime_type)
	for _ in len(mime_type) ..< (len(mime_type) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
data_source_destroy :: proc(connection: ^Connection, wl_data_source: Data_Source) {
	_size: u16 = 8
	wl_data_source := wl_data_source
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_source, size_of(wl_data_source))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
data_source_set_actions :: proc(connection: ^Connection, wl_data_source: Data_Source, dnd_actions: Data_Device_Manager_Dnd_Action) {
	_size: u16 = 8 + size_of(dnd_actions)
	wl_data_source := wl_data_source
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_source, size_of(wl_data_source))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	dnd_actions := dnd_actions
	bytes.buffer_write_ptr(&connection.buffer, &dnd_actions, size_of(dnd_actions))
	return
}
data_device_start_drag :: proc(connection: ^Connection, wl_data_device: Data_Device, source: Data_Source, origin: Surface, icon: Surface, serial: u32) {
	_size: u16 = 8 + size_of(source) + size_of(origin) + size_of(icon) + size_of(serial)
	wl_data_device := wl_data_device
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_device, size_of(wl_data_device))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	source := source
	bytes.buffer_write_ptr(&connection.buffer, &source, size_of(source))
	origin := origin
	bytes.buffer_write_ptr(&connection.buffer, &origin, size_of(origin))
	icon := icon
	bytes.buffer_write_ptr(&connection.buffer, &icon, size_of(icon))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
data_device_set_selection :: proc(connection: ^Connection, wl_data_device: Data_Device, source: Data_Source, serial: u32) {
	_size: u16 = 8 + size_of(source) + size_of(serial)
	wl_data_device := wl_data_device
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_device, size_of(wl_data_device))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	source := source
	bytes.buffer_write_ptr(&connection.buffer, &source, size_of(source))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
data_device_release :: proc(connection: ^Connection, wl_data_device: Data_Device) {
	_size: u16 = 8
	wl_data_device := wl_data_device
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_device, size_of(wl_data_device))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
data_device_manager_create_data_source :: proc(connection: ^Connection, wl_data_device_manager: Data_Device_Manager) -> (id: Data_Source) {
	_size: u16 = 8 + size_of(id)
	wl_data_device_manager := wl_data_device_manager
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_device_manager, size_of(wl_data_device_manager))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Data_Source)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
data_device_manager_get_data_device :: proc(connection: ^Connection, wl_data_device_manager: Data_Device_Manager, seat: Seat) -> (id: Data_Device) {
	_size: u16 = 8 + size_of(id) + size_of(seat)
	wl_data_device_manager := wl_data_device_manager
	bytes.buffer_write_ptr(&connection.buffer, &wl_data_device_manager, size_of(wl_data_device_manager))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Data_Device)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	return
}
shell_get_shell_surface :: proc(connection: ^Connection, wl_shell: Shell, surface: Surface) -> (id: Shell_Surface) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wl_shell := wl_shell
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell, size_of(wl_shell))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Shell_Surface)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
shell_surface_pong :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
shell_surface_move :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, seat: Seat, serial: u32) {
	_size: u16 = 8 + size_of(seat) + size_of(serial)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
shell_surface_resize :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, seat: Seat, serial: u32, edges: Shell_Surface_Resize) {
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(edges)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	edges := edges
	bytes.buffer_write_ptr(&connection.buffer, &edges, size_of(edges))
	return
}
shell_surface_set_toplevel :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface) {
	_size: u16 = 8
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
shell_surface_set_transient :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, parent: Surface, x: i32, y: i32, flags: Shell_Surface_Transient) {
	_size: u16 = 8 + size_of(parent) + size_of(x) + size_of(y) + size_of(flags)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	parent := parent
	bytes.buffer_write_ptr(&connection.buffer, &parent, size_of(parent))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	flags := flags
	bytes.buffer_write_ptr(&connection.buffer, &flags, size_of(flags))
	return
}
shell_surface_set_fullscreen :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, method: Shell_Surface_Fullscreen_Method, framerate: u32, output: Output) {
	_size: u16 = 8 + size_of(method) + size_of(framerate) + size_of(output)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 5
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	method := method
	bytes.buffer_write_ptr(&connection.buffer, &method, size_of(method))
	framerate := framerate
	bytes.buffer_write_ptr(&connection.buffer, &framerate, size_of(framerate))
	output := output
	bytes.buffer_write_ptr(&connection.buffer, &output, size_of(output))
	return
}
shell_surface_set_popup :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, seat: Seat, serial: u32, parent: Surface, x: i32, y: i32, flags: Shell_Surface_Transient) {
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(parent) + size_of(x) + size_of(y) + size_of(flags)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 6
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	parent := parent
	bytes.buffer_write_ptr(&connection.buffer, &parent, size_of(parent))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	flags := flags
	bytes.buffer_write_ptr(&connection.buffer, &flags, size_of(flags))
	return
}
shell_surface_set_maximized :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, output: Output) {
	_size: u16 = 8 + size_of(output)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 7
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	output := output
	bytes.buffer_write_ptr(&connection.buffer, &output, size_of(output))
	return
}
shell_surface_set_title :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, title: string) {
	_size: u16 = 8 + 4 + u16((len(title) + 1 + 3) & -4)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 8
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_title_len := u32(len(title)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_title_len, 4)
	bytes.buffer_write_string(&connection.buffer, title)
	for _ in len(title) ..< (len(title) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
shell_surface_set_class :: proc(connection: ^Connection, wl_shell_surface: Shell_Surface, class_: string) {
	_size: u16 = 8 + 4 + u16((len(class_) + 1 + 3) & -4)
	wl_shell_surface := wl_shell_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_shell_surface, size_of(wl_shell_surface))
	opcode: u16 = 9
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_class__len := u32(len(class_)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_class__len, 4)
	bytes.buffer_write_string(&connection.buffer, class_)
	for _ in len(class_) ..< (len(class_) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
surface_destroy :: proc(connection: ^Connection, wl_surface: Surface) {
	_size: u16 = 8
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
surface_attach :: proc(connection: ^Connection, wl_surface: Surface, buffer: Buffer, x: i32, y: i32) {
	_size: u16 = 8 + size_of(buffer) + size_of(x) + size_of(y)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	buffer := buffer
	bytes.buffer_write_ptr(&connection.buffer, &buffer, size_of(buffer))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	return
}
surface_damage :: proc(connection: ^Connection, wl_surface: Surface, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
surface_frame :: proc(connection: ^Connection, wl_surface: Surface) -> (callback: Callback) {
	_size: u16 = 8 + size_of(callback)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	callback = auto_cast generate_id(connection, .Callback)
	bytes.buffer_write_ptr(&connection.buffer, &callback, size_of(callback))
	return
}
surface_set_opaque_region :: proc(connection: ^Connection, wl_surface: Surface, region: Region) {
	_size: u16 = 8 + size_of(region)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	region := region
	bytes.buffer_write_ptr(&connection.buffer, &region, size_of(region))
	return
}
surface_set_input_region :: proc(connection: ^Connection, wl_surface: Surface, region: Region) {
	_size: u16 = 8 + size_of(region)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 5
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	region := region
	bytes.buffer_write_ptr(&connection.buffer, &region, size_of(region))
	return
}
surface_commit :: proc(connection: ^Connection, wl_surface: Surface) {
	_size: u16 = 8
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 6
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
surface_set_buffer_transform :: proc(connection: ^Connection, wl_surface: Surface, transform: Output_Transform) {
	_size: u16 = 8 + size_of(transform)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 7
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	transform := transform
	bytes.buffer_write_ptr(&connection.buffer, &transform, size_of(transform))
	return
}
surface_set_buffer_scale :: proc(connection: ^Connection, wl_surface: Surface, scale: i32) {
	_size: u16 = 8 + size_of(scale)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 8
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	scale := scale
	bytes.buffer_write_ptr(&connection.buffer, &scale, size_of(scale))
	return
}
surface_damage_buffer :: proc(connection: ^Connection, wl_surface: Surface, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 9
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
surface_offset :: proc(connection: ^Connection, wl_surface: Surface, x: i32, y: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y)
	wl_surface := wl_surface
	bytes.buffer_write_ptr(&connection.buffer, &wl_surface, size_of(wl_surface))
	opcode: u16 = 10
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	return
}
seat_get_pointer :: proc(connection: ^Connection, wl_seat: Seat) -> (id: Pointer) {
	_size: u16 = 8 + size_of(id)
	wl_seat := wl_seat
	bytes.buffer_write_ptr(&connection.buffer, &wl_seat, size_of(wl_seat))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Pointer)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
seat_get_keyboard :: proc(connection: ^Connection, wl_seat: Seat) -> (id: Keyboard) {
	_size: u16 = 8 + size_of(id)
	wl_seat := wl_seat
	bytes.buffer_write_ptr(&connection.buffer, &wl_seat, size_of(wl_seat))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Keyboard)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
seat_get_touch :: proc(connection: ^Connection, wl_seat: Seat) -> (id: Touch) {
	_size: u16 = 8 + size_of(id)
	wl_seat := wl_seat
	bytes.buffer_write_ptr(&connection.buffer, &wl_seat, size_of(wl_seat))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Touch)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
seat_release :: proc(connection: ^Connection, wl_seat: Seat) {
	_size: u16 = 8
	wl_seat := wl_seat
	bytes.buffer_write_ptr(&connection.buffer, &wl_seat, size_of(wl_seat))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
pointer_set_cursor :: proc(connection: ^Connection, wl_pointer: Pointer, serial: u32, surface: Surface, hotspot_x: i32, hotspot_y: i32) {
	_size: u16 = 8 + size_of(serial) + size_of(surface) + size_of(hotspot_x) + size_of(hotspot_y)
	wl_pointer := wl_pointer
	bytes.buffer_write_ptr(&connection.buffer, &wl_pointer, size_of(wl_pointer))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	hotspot_x := hotspot_x
	bytes.buffer_write_ptr(&connection.buffer, &hotspot_x, size_of(hotspot_x))
	hotspot_y := hotspot_y
	bytes.buffer_write_ptr(&connection.buffer, &hotspot_y, size_of(hotspot_y))
	return
}
pointer_release :: proc(connection: ^Connection, wl_pointer: Pointer) {
	_size: u16 = 8
	wl_pointer := wl_pointer
	bytes.buffer_write_ptr(&connection.buffer, &wl_pointer, size_of(wl_pointer))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
keyboard_release :: proc(connection: ^Connection, wl_keyboard: Keyboard) {
	_size: u16 = 8
	wl_keyboard := wl_keyboard
	bytes.buffer_write_ptr(&connection.buffer, &wl_keyboard, size_of(wl_keyboard))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
touch_release :: proc(connection: ^Connection, wl_touch: Touch) {
	_size: u16 = 8
	wl_touch := wl_touch
	bytes.buffer_write_ptr(&connection.buffer, &wl_touch, size_of(wl_touch))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
output_release :: proc(connection: ^Connection, wl_output: Output) {
	_size: u16 = 8
	wl_output := wl_output
	bytes.buffer_write_ptr(&connection.buffer, &wl_output, size_of(wl_output))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
region_destroy :: proc(connection: ^Connection, wl_region: Region) {
	_size: u16 = 8
	wl_region := wl_region
	bytes.buffer_write_ptr(&connection.buffer, &wl_region, size_of(wl_region))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
region_add :: proc(connection: ^Connection, wl_region: Region, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	wl_region := wl_region
	bytes.buffer_write_ptr(&connection.buffer, &wl_region, size_of(wl_region))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
region_subtract :: proc(connection: ^Connection, wl_region: Region, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	wl_region := wl_region
	bytes.buffer_write_ptr(&connection.buffer, &wl_region, size_of(wl_region))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
subcompositor_destroy :: proc(connection: ^Connection, wl_subcompositor: Subcompositor) {
	_size: u16 = 8
	wl_subcompositor := wl_subcompositor
	bytes.buffer_write_ptr(&connection.buffer, &wl_subcompositor, size_of(wl_subcompositor))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
subcompositor_get_subsurface :: proc(connection: ^Connection, wl_subcompositor: Subcompositor, surface: Surface, parent: Surface) -> (id: Subsurface) {
	_size: u16 = 8 + size_of(id) + size_of(surface) + size_of(parent)
	wl_subcompositor := wl_subcompositor
	bytes.buffer_write_ptr(&connection.buffer, &wl_subcompositor, size_of(wl_subcompositor))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Subsurface)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	parent := parent
	bytes.buffer_write_ptr(&connection.buffer, &parent, size_of(parent))
	return
}
subsurface_destroy :: proc(connection: ^Connection, wl_subsurface: Subsurface) {
	_size: u16 = 8
	wl_subsurface := wl_subsurface
	bytes.buffer_write_ptr(&connection.buffer, &wl_subsurface, size_of(wl_subsurface))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
subsurface_set_position :: proc(connection: ^Connection, wl_subsurface: Subsurface, x: i32, y: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y)
	wl_subsurface := wl_subsurface
	bytes.buffer_write_ptr(&connection.buffer, &wl_subsurface, size_of(wl_subsurface))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	return
}
subsurface_place_above :: proc(connection: ^Connection, wl_subsurface: Subsurface, sibling: Surface) {
	_size: u16 = 8 + size_of(sibling)
	wl_subsurface := wl_subsurface
	bytes.buffer_write_ptr(&connection.buffer, &wl_subsurface, size_of(wl_subsurface))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	sibling := sibling
	bytes.buffer_write_ptr(&connection.buffer, &sibling, size_of(sibling))
	return
}
subsurface_place_below :: proc(connection: ^Connection, wl_subsurface: Subsurface, sibling: Surface) {
	_size: u16 = 8 + size_of(sibling)
	wl_subsurface := wl_subsurface
	bytes.buffer_write_ptr(&connection.buffer, &wl_subsurface, size_of(wl_subsurface))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	sibling := sibling
	bytes.buffer_write_ptr(&connection.buffer, &sibling, size_of(sibling))
	return
}
subsurface_set_sync :: proc(connection: ^Connection, wl_subsurface: Subsurface) {
	_size: u16 = 8
	wl_subsurface := wl_subsurface
	bytes.buffer_write_ptr(&connection.buffer, &wl_subsurface, size_of(wl_subsurface))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
subsurface_set_desync :: proc(connection: ^Connection, wl_subsurface: Subsurface) {
	_size: u16 = 8
	wl_subsurface := wl_subsurface
	bytes.buffer_write_ptr(&connection.buffer, &wl_subsurface, size_of(wl_subsurface))
	opcode: u16 = 5
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
fixes_destroy :: proc(connection: ^Connection, wl_fixes: Fixes) {
	_size: u16 = 8
	wl_fixes := wl_fixes
	bytes.buffer_write_ptr(&connection.buffer, &wl_fixes, size_of(wl_fixes))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
fixes_destroy_registry :: proc(connection: ^Connection, wl_fixes: Fixes, registry: Registry) {
	_size: u16 = 8 + size_of(registry)
	wl_fixes := wl_fixes
	bytes.buffer_write_ptr(&connection.buffer, &wl_fixes, size_of(wl_fixes))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	registry := registry
	bytes.buffer_write_ptr(&connection.buffer, &registry, size_of(registry))
	return
}
zwp_linux_dmabuf_v1_destroy :: proc(connection: ^Connection, zwp_linux_dmabuf_v1: Zwp_Linux_Dmabuf_V1) {
	_size: u16 = 8
	zwp_linux_dmabuf_v1 := zwp_linux_dmabuf_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_dmabuf_v1, size_of(zwp_linux_dmabuf_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_linux_dmabuf_v1_create_params :: proc(connection: ^Connection, zwp_linux_dmabuf_v1: Zwp_Linux_Dmabuf_V1) -> (params_id: Zwp_Linux_Buffer_Params_V1) {
	_size: u16 = 8 + size_of(params_id)
	zwp_linux_dmabuf_v1 := zwp_linux_dmabuf_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_dmabuf_v1, size_of(zwp_linux_dmabuf_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	params_id = auto_cast generate_id(connection, .Zwp_Linux_Buffer_Params_V1)
	bytes.buffer_write_ptr(&connection.buffer, &params_id, size_of(params_id))
	return
}
zwp_linux_dmabuf_v1_get_default_feedback :: proc(connection: ^Connection, zwp_linux_dmabuf_v1: Zwp_Linux_Dmabuf_V1) -> (id: Zwp_Linux_Dmabuf_Feedback_V1) {
	_size: u16 = 8 + size_of(id)
	zwp_linux_dmabuf_v1 := zwp_linux_dmabuf_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_dmabuf_v1, size_of(zwp_linux_dmabuf_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Zwp_Linux_Dmabuf_Feedback_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
zwp_linux_dmabuf_v1_get_surface_feedback :: proc(connection: ^Connection, zwp_linux_dmabuf_v1: Zwp_Linux_Dmabuf_V1, surface: Surface) -> (id: Zwp_Linux_Dmabuf_Feedback_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	zwp_linux_dmabuf_v1 := zwp_linux_dmabuf_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_dmabuf_v1, size_of(zwp_linux_dmabuf_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Zwp_Linux_Dmabuf_Feedback_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
zwp_linux_buffer_params_v1_destroy :: proc(connection: ^Connection, zwp_linux_buffer_params_v1: Zwp_Linux_Buffer_Params_V1) {
	_size: u16 = 8
	zwp_linux_buffer_params_v1 := zwp_linux_buffer_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_buffer_params_v1, size_of(zwp_linux_buffer_params_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_linux_buffer_params_v1_add :: proc(connection: ^Connection, zwp_linux_buffer_params_v1: Zwp_Linux_Buffer_Params_V1, fd: Fd, plane_idx: u32, offset: u32, stride: u32, modifier_hi: u32, modifier_lo: u32) {
	_size: u16 = 8 + size_of(plane_idx) + size_of(offset) + size_of(stride) + size_of(modifier_hi) + size_of(modifier_lo)
	zwp_linux_buffer_params_v1 := zwp_linux_buffer_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_buffer_params_v1, size_of(zwp_linux_buffer_params_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	append(&connection.fds_out, fd)
	plane_idx := plane_idx
	bytes.buffer_write_ptr(&connection.buffer, &plane_idx, size_of(plane_idx))
	offset := offset
	bytes.buffer_write_ptr(&connection.buffer, &offset, size_of(offset))
	stride := stride
	bytes.buffer_write_ptr(&connection.buffer, &stride, size_of(stride))
	modifier_hi := modifier_hi
	bytes.buffer_write_ptr(&connection.buffer, &modifier_hi, size_of(modifier_hi))
	modifier_lo := modifier_lo
	bytes.buffer_write_ptr(&connection.buffer, &modifier_lo, size_of(modifier_lo))
	return
}
zwp_linux_buffer_params_v1_create :: proc(connection: ^Connection, zwp_linux_buffer_params_v1: Zwp_Linux_Buffer_Params_V1, width: i32, height: i32, format: u32, flags: Zwp_Linux_Buffer_Params_V1_Flags) {
	_size: u16 = 8 + size_of(width) + size_of(height) + size_of(format) + size_of(flags)
	zwp_linux_buffer_params_v1 := zwp_linux_buffer_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_buffer_params_v1, size_of(zwp_linux_buffer_params_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	format := format
	bytes.buffer_write_ptr(&connection.buffer, &format, size_of(format))
	flags := flags
	bytes.buffer_write_ptr(&connection.buffer, &flags, size_of(flags))
	return
}
zwp_linux_buffer_params_v1_create_immed :: proc(connection: ^Connection, zwp_linux_buffer_params_v1: Zwp_Linux_Buffer_Params_V1, width: i32, height: i32, format: u32, flags: Zwp_Linux_Buffer_Params_V1_Flags) -> (buffer_id: Buffer) {
	_size: u16 = 8 + size_of(buffer_id) + size_of(width) + size_of(height) + size_of(format) + size_of(flags)
	zwp_linux_buffer_params_v1 := zwp_linux_buffer_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_buffer_params_v1, size_of(zwp_linux_buffer_params_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	buffer_id = auto_cast generate_id(connection, .Buffer)
	bytes.buffer_write_ptr(&connection.buffer, &buffer_id, size_of(buffer_id))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	format := format
	bytes.buffer_write_ptr(&connection.buffer, &format, size_of(format))
	flags := flags
	bytes.buffer_write_ptr(&connection.buffer, &flags, size_of(flags))
	return
}
zwp_linux_dmabuf_feedback_v1_destroy :: proc(connection: ^Connection, zwp_linux_dmabuf_feedback_v1: Zwp_Linux_Dmabuf_Feedback_V1) {
	_size: u16 = 8
	zwp_linux_dmabuf_feedback_v1 := zwp_linux_dmabuf_feedback_v1
	bytes.buffer_write_ptr(&connection.buffer, &zwp_linux_dmabuf_feedback_v1, size_of(zwp_linux_dmabuf_feedback_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_presentation_destroy :: proc(connection: ^Connection, wp_presentation: Wp_Presentation) {
	_size: u16 = 8
	wp_presentation := wp_presentation
	bytes.buffer_write_ptr(&connection.buffer, &wp_presentation, size_of(wp_presentation))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_presentation_feedback :: proc(connection: ^Connection, wp_presentation: Wp_Presentation, surface: Surface) -> (callback: Wp_Presentation_Feedback) {
	_size: u16 = 8 + size_of(surface) + size_of(callback)
	wp_presentation := wp_presentation
	bytes.buffer_write_ptr(&connection.buffer, &wp_presentation, size_of(wp_presentation))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	callback = auto_cast generate_id(connection, .Wp_Presentation_Feedback)
	bytes.buffer_write_ptr(&connection.buffer, &callback, size_of(callback))
	return
}
zwp_tablet_manager_v2_get_tablet_seat :: proc(connection: ^Connection, zwp_tablet_manager_v2: Zwp_Tablet_Manager_V2, seat: Seat) -> (tablet_seat: Zwp_Tablet_Seat_V2) {
	_size: u16 = 8 + size_of(tablet_seat) + size_of(seat)
	zwp_tablet_manager_v2 := zwp_tablet_manager_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_manager_v2, size_of(zwp_tablet_manager_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	tablet_seat = auto_cast generate_id(connection, .Zwp_Tablet_Seat_V2)
	bytes.buffer_write_ptr(&connection.buffer, &tablet_seat, size_of(tablet_seat))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	return
}
zwp_tablet_manager_v2_destroy :: proc(connection: ^Connection, zwp_tablet_manager_v2: Zwp_Tablet_Manager_V2) {
	_size: u16 = 8
	zwp_tablet_manager_v2 := zwp_tablet_manager_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_manager_v2, size_of(zwp_tablet_manager_v2))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_tablet_seat_v2_destroy :: proc(connection: ^Connection, zwp_tablet_seat_v2: Zwp_Tablet_Seat_V2) {
	_size: u16 = 8
	zwp_tablet_seat_v2 := zwp_tablet_seat_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_seat_v2, size_of(zwp_tablet_seat_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_tablet_tool_v2_set_cursor :: proc(connection: ^Connection, zwp_tablet_tool_v2: Zwp_Tablet_Tool_V2, serial: u32, surface: Surface, hotspot_x: i32, hotspot_y: i32) {
	_size: u16 = 8 + size_of(serial) + size_of(surface) + size_of(hotspot_x) + size_of(hotspot_y)
	zwp_tablet_tool_v2 := zwp_tablet_tool_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_tool_v2, size_of(zwp_tablet_tool_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	hotspot_x := hotspot_x
	bytes.buffer_write_ptr(&connection.buffer, &hotspot_x, size_of(hotspot_x))
	hotspot_y := hotspot_y
	bytes.buffer_write_ptr(&connection.buffer, &hotspot_y, size_of(hotspot_y))
	return
}
zwp_tablet_tool_v2_destroy :: proc(connection: ^Connection, zwp_tablet_tool_v2: Zwp_Tablet_Tool_V2) {
	_size: u16 = 8
	zwp_tablet_tool_v2 := zwp_tablet_tool_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_tool_v2, size_of(zwp_tablet_tool_v2))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_tablet_v2_destroy :: proc(connection: ^Connection, zwp_tablet_v2: Zwp_Tablet_V2) {
	_size: u16 = 8
	zwp_tablet_v2 := zwp_tablet_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_v2, size_of(zwp_tablet_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_tablet_pad_ring_v2_set_feedback :: proc(connection: ^Connection, zwp_tablet_pad_ring_v2: Zwp_Tablet_Pad_Ring_V2, description: string, serial: u32) {
	_size: u16 = 8 + 4 + u16((len(description) + 1 + 3) & -4) + size_of(serial)
	zwp_tablet_pad_ring_v2 := zwp_tablet_pad_ring_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_ring_v2, size_of(zwp_tablet_pad_ring_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_description_len := u32(len(description)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_description_len, 4)
	bytes.buffer_write_string(&connection.buffer, description)
	for _ in len(description) ..< (len(description) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
zwp_tablet_pad_ring_v2_destroy :: proc(connection: ^Connection, zwp_tablet_pad_ring_v2: Zwp_Tablet_Pad_Ring_V2) {
	_size: u16 = 8
	zwp_tablet_pad_ring_v2 := zwp_tablet_pad_ring_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_ring_v2, size_of(zwp_tablet_pad_ring_v2))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_tablet_pad_strip_v2_set_feedback :: proc(connection: ^Connection, zwp_tablet_pad_strip_v2: Zwp_Tablet_Pad_Strip_V2, description: string, serial: u32) {
	_size: u16 = 8 + 4 + u16((len(description) + 1 + 3) & -4) + size_of(serial)
	zwp_tablet_pad_strip_v2 := zwp_tablet_pad_strip_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_strip_v2, size_of(zwp_tablet_pad_strip_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_description_len := u32(len(description)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_description_len, 4)
	bytes.buffer_write_string(&connection.buffer, description)
	for _ in len(description) ..< (len(description) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
zwp_tablet_pad_strip_v2_destroy :: proc(connection: ^Connection, zwp_tablet_pad_strip_v2: Zwp_Tablet_Pad_Strip_V2) {
	_size: u16 = 8
	zwp_tablet_pad_strip_v2 := zwp_tablet_pad_strip_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_strip_v2, size_of(zwp_tablet_pad_strip_v2))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_tablet_pad_group_v2_destroy :: proc(connection: ^Connection, zwp_tablet_pad_group_v2: Zwp_Tablet_Pad_Group_V2) {
	_size: u16 = 8
	zwp_tablet_pad_group_v2 := zwp_tablet_pad_group_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_group_v2, size_of(zwp_tablet_pad_group_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_tablet_pad_v2_set_feedback :: proc(connection: ^Connection, zwp_tablet_pad_v2: Zwp_Tablet_Pad_V2, button: u32, description: string, serial: u32) {
	_size: u16 = 8 + size_of(button) + 4 + u16((len(description) + 1 + 3) & -4) + size_of(serial)
	zwp_tablet_pad_v2 := zwp_tablet_pad_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_v2, size_of(zwp_tablet_pad_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	button := button
	bytes.buffer_write_ptr(&connection.buffer, &button, size_of(button))
	_description_len := u32(len(description)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_description_len, 4)
	bytes.buffer_write_string(&connection.buffer, description)
	for _ in len(description) ..< (len(description) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
zwp_tablet_pad_v2_destroy :: proc(connection: ^Connection, zwp_tablet_pad_v2: Zwp_Tablet_Pad_V2) {
	_size: u16 = 8
	zwp_tablet_pad_v2 := zwp_tablet_pad_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_v2, size_of(zwp_tablet_pad_v2))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
zwp_tablet_pad_dial_v2_set_feedback :: proc(connection: ^Connection, zwp_tablet_pad_dial_v2: Zwp_Tablet_Pad_Dial_V2, description: string, serial: u32) {
	_size: u16 = 8 + 4 + u16((len(description) + 1 + 3) & -4) + size_of(serial)
	zwp_tablet_pad_dial_v2 := zwp_tablet_pad_dial_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_dial_v2, size_of(zwp_tablet_pad_dial_v2))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_description_len := u32(len(description)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_description_len, 4)
	bytes.buffer_write_string(&connection.buffer, description)
	for _ in len(description) ..< (len(description) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
zwp_tablet_pad_dial_v2_destroy :: proc(connection: ^Connection, zwp_tablet_pad_dial_v2: Zwp_Tablet_Pad_Dial_V2) {
	_size: u16 = 8
	zwp_tablet_pad_dial_v2 := zwp_tablet_pad_dial_v2
	bytes.buffer_write_ptr(&connection.buffer, &zwp_tablet_pad_dial_v2, size_of(zwp_tablet_pad_dial_v2))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_viewporter_destroy :: proc(connection: ^Connection, wp_viewporter: Wp_Viewporter) {
	_size: u16 = 8
	wp_viewporter := wp_viewporter
	bytes.buffer_write_ptr(&connection.buffer, &wp_viewporter, size_of(wp_viewporter))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_viewporter_get_viewport :: proc(connection: ^Connection, wp_viewporter: Wp_Viewporter, surface: Surface) -> (id: Wp_Viewport) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_viewporter := wp_viewporter
	bytes.buffer_write_ptr(&connection.buffer, &wp_viewporter, size_of(wp_viewporter))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Viewport)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_viewport_destroy :: proc(connection: ^Connection, wp_viewport: Wp_Viewport) {
	_size: u16 = 8
	wp_viewport := wp_viewport
	bytes.buffer_write_ptr(&connection.buffer, &wp_viewport, size_of(wp_viewport))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_viewport_set_source :: proc(connection: ^Connection, wp_viewport: Wp_Viewport, x: f64, y: f64, width: f64, height: f64) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	wp_viewport := wp_viewport
	bytes.buffer_write_ptr(&connection.buffer, &wp_viewport, size_of(wp_viewport))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
wp_viewport_set_destination :: proc(connection: ^Connection, wp_viewport: Wp_Viewport, width: i32, height: i32) {
	_size: u16 = 8 + size_of(width) + size_of(height)
	wp_viewport := wp_viewport
	bytes.buffer_write_ptr(&connection.buffer, &wp_viewport, size_of(wp_viewport))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
xdg_wm_base_destroy :: proc(connection: ^Connection, xdg_wm_base: Xdg_Wm_Base) {
	_size: u16 = 8
	xdg_wm_base := xdg_wm_base
	bytes.buffer_write_ptr(&connection.buffer, &xdg_wm_base, size_of(xdg_wm_base))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_wm_base_create_positioner :: proc(connection: ^Connection, xdg_wm_base: Xdg_Wm_Base) -> (id: Xdg_Positioner) {
	_size: u16 = 8 + size_of(id)
	xdg_wm_base := xdg_wm_base
	bytes.buffer_write_ptr(&connection.buffer, &xdg_wm_base, size_of(xdg_wm_base))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xdg_Positioner)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
xdg_wm_base_get_xdg_surface :: proc(connection: ^Connection, xdg_wm_base: Xdg_Wm_Base, surface: Surface) -> (id: Xdg_Surface) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	xdg_wm_base := xdg_wm_base
	bytes.buffer_write_ptr(&connection.buffer, &xdg_wm_base, size_of(xdg_wm_base))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xdg_Surface)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
xdg_wm_base_pong :: proc(connection: ^Connection, xdg_wm_base: Xdg_Wm_Base, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	xdg_wm_base := xdg_wm_base
	bytes.buffer_write_ptr(&connection.buffer, &xdg_wm_base, size_of(xdg_wm_base))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
xdg_positioner_destroy :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner) {
	_size: u16 = 8
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_positioner_set_size :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner, width: i32, height: i32) {
	_size: u16 = 8 + size_of(width) + size_of(height)
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
xdg_positioner_set_anchor_rect :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
xdg_positioner_set_anchor :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner, anchor: Xdg_Positioner_Anchor) {
	_size: u16 = 8 + size_of(anchor)
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	anchor := anchor
	bytes.buffer_write_ptr(&connection.buffer, &anchor, size_of(anchor))
	return
}
xdg_positioner_set_gravity :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner, gravity: Xdg_Positioner_Gravity) {
	_size: u16 = 8 + size_of(gravity)
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	gravity := gravity
	bytes.buffer_write_ptr(&connection.buffer, &gravity, size_of(gravity))
	return
}
xdg_positioner_set_constraint_adjustment :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner, constraint_adjustment: Xdg_Positioner_Constraint_Adjustment) {
	_size: u16 = 8 + size_of(constraint_adjustment)
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 5
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	constraint_adjustment := constraint_adjustment
	bytes.buffer_write_ptr(&connection.buffer, &constraint_adjustment, size_of(constraint_adjustment))
	return
}
xdg_positioner_set_offset :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner, x: i32, y: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y)
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 6
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	return
}
xdg_positioner_set_reactive :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner) {
	_size: u16 = 8
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 7
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_positioner_set_parent_size :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner, parent_width: i32, parent_height: i32) {
	_size: u16 = 8 + size_of(parent_width) + size_of(parent_height)
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 8
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	parent_width := parent_width
	bytes.buffer_write_ptr(&connection.buffer, &parent_width, size_of(parent_width))
	parent_height := parent_height
	bytes.buffer_write_ptr(&connection.buffer, &parent_height, size_of(parent_height))
	return
}
xdg_positioner_set_parent_configure :: proc(connection: ^Connection, xdg_positioner: Xdg_Positioner, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	xdg_positioner := xdg_positioner
	bytes.buffer_write_ptr(&connection.buffer, &xdg_positioner, size_of(xdg_positioner))
	opcode: u16 = 9
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
xdg_surface_destroy :: proc(connection: ^Connection, xdg_surface: Xdg_Surface) {
	_size: u16 = 8
	xdg_surface := xdg_surface
	bytes.buffer_write_ptr(&connection.buffer, &xdg_surface, size_of(xdg_surface))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_surface_get_toplevel :: proc(connection: ^Connection, xdg_surface: Xdg_Surface) -> (id: Xdg_Toplevel) {
	_size: u16 = 8 + size_of(id)
	xdg_surface := xdg_surface
	bytes.buffer_write_ptr(&connection.buffer, &xdg_surface, size_of(xdg_surface))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xdg_Toplevel)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
xdg_surface_get_popup :: proc(connection: ^Connection, xdg_surface: Xdg_Surface, parent: Xdg_Surface, positioner: Xdg_Positioner) -> (id: Xdg_Popup) {
	_size: u16 = 8 + size_of(id) + size_of(parent) + size_of(positioner)
	xdg_surface := xdg_surface
	bytes.buffer_write_ptr(&connection.buffer, &xdg_surface, size_of(xdg_surface))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xdg_Popup)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	parent := parent
	bytes.buffer_write_ptr(&connection.buffer, &parent, size_of(parent))
	positioner := positioner
	bytes.buffer_write_ptr(&connection.buffer, &positioner, size_of(positioner))
	return
}
xdg_surface_set_window_geometry :: proc(connection: ^Connection, xdg_surface: Xdg_Surface, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	xdg_surface := xdg_surface
	bytes.buffer_write_ptr(&connection.buffer, &xdg_surface, size_of(xdg_surface))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
xdg_surface_ack_configure :: proc(connection: ^Connection, xdg_surface: Xdg_Surface, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	xdg_surface := xdg_surface
	bytes.buffer_write_ptr(&connection.buffer, &xdg_surface, size_of(xdg_surface))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
xdg_toplevel_destroy :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel) {
	_size: u16 = 8
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_set_parent :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, parent: Xdg_Toplevel) {
	_size: u16 = 8 + size_of(parent)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	parent := parent
	bytes.buffer_write_ptr(&connection.buffer, &parent, size_of(parent))
	return
}
xdg_toplevel_set_title :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, title: string) {
	_size: u16 = 8 + 4 + u16((len(title) + 1 + 3) & -4)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_title_len := u32(len(title)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_title_len, 4)
	bytes.buffer_write_string(&connection.buffer, title)
	for _ in len(title) ..< (len(title) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
xdg_toplevel_set_app_id :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, app_id: string) {
	_size: u16 = 8 + 4 + u16((len(app_id) + 1 + 3) & -4)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_app_id_len := u32(len(app_id)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_app_id_len, 4)
	bytes.buffer_write_string(&connection.buffer, app_id)
	for _ in len(app_id) ..< (len(app_id) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
xdg_toplevel_show_window_menu :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, seat: Seat, serial: u32, x: i32, y: i32) {
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(x) + size_of(y)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	return
}
xdg_toplevel_move :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, seat: Seat, serial: u32) {
	_size: u16 = 8 + size_of(seat) + size_of(serial)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 5
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
xdg_toplevel_resize :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, seat: Seat, serial: u32, edges: Xdg_Toplevel_Resize_Edge) {
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(edges)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 6
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	edges := edges
	bytes.buffer_write_ptr(&connection.buffer, &edges, size_of(edges))
	return
}
xdg_toplevel_set_max_size :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, width: i32, height: i32) {
	_size: u16 = 8 + size_of(width) + size_of(height)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 7
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
xdg_toplevel_set_min_size :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, width: i32, height: i32) {
	_size: u16 = 8 + size_of(width) + size_of(height)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 8
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
xdg_toplevel_set_maximized :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel) {
	_size: u16 = 8
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 9
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_unset_maximized :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel) {
	_size: u16 = 8
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 10
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_set_fullscreen :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel, output: Output) {
	_size: u16 = 8 + size_of(output)
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 11
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	output := output
	bytes.buffer_write_ptr(&connection.buffer, &output, size_of(output))
	return
}
xdg_toplevel_unset_fullscreen :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel) {
	_size: u16 = 8
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 12
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_set_minimized :: proc(connection: ^Connection, xdg_toplevel: Xdg_Toplevel) {
	_size: u16 = 8
	xdg_toplevel := xdg_toplevel
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel, size_of(xdg_toplevel))
	opcode: u16 = 13
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_popup_destroy :: proc(connection: ^Connection, xdg_popup: Xdg_Popup) {
	_size: u16 = 8
	xdg_popup := xdg_popup
	bytes.buffer_write_ptr(&connection.buffer, &xdg_popup, size_of(xdg_popup))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_popup_grab :: proc(connection: ^Connection, xdg_popup: Xdg_Popup, seat: Seat, serial: u32) {
	_size: u16 = 8 + size_of(seat) + size_of(serial)
	xdg_popup := xdg_popup
	bytes.buffer_write_ptr(&connection.buffer, &xdg_popup, size_of(xdg_popup))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
xdg_popup_reposition :: proc(connection: ^Connection, xdg_popup: Xdg_Popup, positioner: Xdg_Positioner, token: u32) {
	_size: u16 = 8 + size_of(positioner) + size_of(token)
	xdg_popup := xdg_popup
	bytes.buffer_write_ptr(&connection.buffer, &xdg_popup, size_of(xdg_popup))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	positioner := positioner
	bytes.buffer_write_ptr(&connection.buffer, &positioner, size_of(positioner))
	token := token
	bytes.buffer_write_ptr(&connection.buffer, &token, size_of(token))
	return
}
wp_alpha_modifier_v1_destroy :: proc(connection: ^Connection, wp_alpha_modifier_v1: Wp_Alpha_Modifier_V1) {
	_size: u16 = 8
	wp_alpha_modifier_v1 := wp_alpha_modifier_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_alpha_modifier_v1, size_of(wp_alpha_modifier_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_alpha_modifier_v1_get_surface :: proc(connection: ^Connection, wp_alpha_modifier_v1: Wp_Alpha_Modifier_V1, surface: Surface) -> (id: Wp_Alpha_Modifier_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_alpha_modifier_v1 := wp_alpha_modifier_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_alpha_modifier_v1, size_of(wp_alpha_modifier_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Alpha_Modifier_Surface_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_alpha_modifier_surface_v1_destroy :: proc(connection: ^Connection, wp_alpha_modifier_surface_v1: Wp_Alpha_Modifier_Surface_V1) {
	_size: u16 = 8
	wp_alpha_modifier_surface_v1 := wp_alpha_modifier_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_alpha_modifier_surface_v1, size_of(wp_alpha_modifier_surface_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_alpha_modifier_surface_v1_set_multiplier :: proc(connection: ^Connection, wp_alpha_modifier_surface_v1: Wp_Alpha_Modifier_Surface_V1, factor: u32) {
	_size: u16 = 8 + size_of(factor)
	wp_alpha_modifier_surface_v1 := wp_alpha_modifier_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_alpha_modifier_surface_v1, size_of(wp_alpha_modifier_surface_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	factor := factor
	bytes.buffer_write_ptr(&connection.buffer, &factor, size_of(factor))
	return
}
wp_color_manager_v1_destroy :: proc(connection: ^Connection, wp_color_manager_v1: Wp_Color_Manager_V1) {
	_size: u16 = 8
	wp_color_manager_v1 := wp_color_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_manager_v1, size_of(wp_color_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_color_manager_v1_get_output :: proc(connection: ^Connection, wp_color_manager_v1: Wp_Color_Manager_V1, output: Output) -> (id: Wp_Color_Management_Output_V1) {
	_size: u16 = 8 + size_of(id) + size_of(output)
	wp_color_manager_v1 := wp_color_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_manager_v1, size_of(wp_color_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Color_Management_Output_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	output := output
	bytes.buffer_write_ptr(&connection.buffer, &output, size_of(output))
	return
}
wp_color_manager_v1_get_surface :: proc(connection: ^Connection, wp_color_manager_v1: Wp_Color_Manager_V1, surface: Surface) -> (id: Wp_Color_Management_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_color_manager_v1 := wp_color_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_manager_v1, size_of(wp_color_manager_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Color_Management_Surface_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_color_manager_v1_get_surface_feedback :: proc(connection: ^Connection, wp_color_manager_v1: Wp_Color_Manager_V1, surface: Surface) -> (id: Wp_Color_Management_Surface_Feedback_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_color_manager_v1 := wp_color_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_manager_v1, size_of(wp_color_manager_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Color_Management_Surface_Feedback_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_color_manager_v1_create_icc_creator :: proc(connection: ^Connection, wp_color_manager_v1: Wp_Color_Manager_V1) -> (obj: Wp_Image_Description_Creator_Icc_V1) {
	_size: u16 = 8 + size_of(obj)
	wp_color_manager_v1 := wp_color_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_manager_v1, size_of(wp_color_manager_v1))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	obj = auto_cast generate_id(connection, .Wp_Image_Description_Creator_Icc_V1)
	bytes.buffer_write_ptr(&connection.buffer, &obj, size_of(obj))
	return
}
wp_color_manager_v1_create_parametric_creator :: proc(connection: ^Connection, wp_color_manager_v1: Wp_Color_Manager_V1) -> (obj: Wp_Image_Description_Creator_Params_V1) {
	_size: u16 = 8 + size_of(obj)
	wp_color_manager_v1 := wp_color_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_manager_v1, size_of(wp_color_manager_v1))
	opcode: u16 = 5
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	obj = auto_cast generate_id(connection, .Wp_Image_Description_Creator_Params_V1)
	bytes.buffer_write_ptr(&connection.buffer, &obj, size_of(obj))
	return
}
wp_color_manager_v1_create_windows_scrgb :: proc(connection: ^Connection, wp_color_manager_v1: Wp_Color_Manager_V1) -> (image_description: Wp_Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	wp_color_manager_v1 := wp_color_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_manager_v1, size_of(wp_color_manager_v1))
	opcode: u16 = 6
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	image_description = auto_cast generate_id(connection, .Wp_Image_Description_V1)
	bytes.buffer_write_ptr(&connection.buffer, &image_description, size_of(image_description))
	return
}
wp_color_management_output_v1_destroy :: proc(connection: ^Connection, wp_color_management_output_v1: Wp_Color_Management_Output_V1) {
	_size: u16 = 8
	wp_color_management_output_v1 := wp_color_management_output_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_management_output_v1, size_of(wp_color_management_output_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_color_management_output_v1_get_image_description :: proc(connection: ^Connection, wp_color_management_output_v1: Wp_Color_Management_Output_V1) -> (image_description: Wp_Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	wp_color_management_output_v1 := wp_color_management_output_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_management_output_v1, size_of(wp_color_management_output_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	image_description = auto_cast generate_id(connection, .Wp_Image_Description_V1)
	bytes.buffer_write_ptr(&connection.buffer, &image_description, size_of(image_description))
	return
}
wp_color_management_surface_v1_destroy :: proc(connection: ^Connection, wp_color_management_surface_v1: Wp_Color_Management_Surface_V1) {
	_size: u16 = 8
	wp_color_management_surface_v1 := wp_color_management_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_management_surface_v1, size_of(wp_color_management_surface_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_color_management_surface_v1_set_image_description :: proc(connection: ^Connection, wp_color_management_surface_v1: Wp_Color_Management_Surface_V1, image_description: Wp_Image_Description_V1, render_intent: Wp_Color_Manager_V1_Render_Intent) {
	_size: u16 = 8 + size_of(image_description) + size_of(render_intent)
	wp_color_management_surface_v1 := wp_color_management_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_management_surface_v1, size_of(wp_color_management_surface_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	image_description := image_description
	bytes.buffer_write_ptr(&connection.buffer, &image_description, size_of(image_description))
	render_intent := render_intent
	bytes.buffer_write_ptr(&connection.buffer, &render_intent, size_of(render_intent))
	return
}
wp_color_management_surface_v1_unset_image_description :: proc(connection: ^Connection, wp_color_management_surface_v1: Wp_Color_Management_Surface_V1) {
	_size: u16 = 8
	wp_color_management_surface_v1 := wp_color_management_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_management_surface_v1, size_of(wp_color_management_surface_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_color_management_surface_feedback_v1_destroy :: proc(connection: ^Connection, wp_color_management_surface_feedback_v1: Wp_Color_Management_Surface_Feedback_V1) {
	_size: u16 = 8
	wp_color_management_surface_feedback_v1 := wp_color_management_surface_feedback_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_management_surface_feedback_v1, size_of(wp_color_management_surface_feedback_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_color_management_surface_feedback_v1_get_preferred :: proc(connection: ^Connection, wp_color_management_surface_feedback_v1: Wp_Color_Management_Surface_Feedback_V1) -> (image_description: Wp_Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	wp_color_management_surface_feedback_v1 := wp_color_management_surface_feedback_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_management_surface_feedback_v1, size_of(wp_color_management_surface_feedback_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	image_description = auto_cast generate_id(connection, .Wp_Image_Description_V1)
	bytes.buffer_write_ptr(&connection.buffer, &image_description, size_of(image_description))
	return
}
wp_color_management_surface_feedback_v1_get_preferred_parametric :: proc(connection: ^Connection, wp_color_management_surface_feedback_v1: Wp_Color_Management_Surface_Feedback_V1) -> (image_description: Wp_Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	wp_color_management_surface_feedback_v1 := wp_color_management_surface_feedback_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_management_surface_feedback_v1, size_of(wp_color_management_surface_feedback_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	image_description = auto_cast generate_id(connection, .Wp_Image_Description_V1)
	bytes.buffer_write_ptr(&connection.buffer, &image_description, size_of(image_description))
	return
}
wp_image_description_creator_icc_v1_create :: proc(connection: ^Connection, wp_image_description_creator_icc_v1: Wp_Image_Description_Creator_Icc_V1) -> (image_description: Wp_Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	wp_image_description_creator_icc_v1 := wp_image_description_creator_icc_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_icc_v1, size_of(wp_image_description_creator_icc_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	image_description = auto_cast generate_id(connection, .Wp_Image_Description_V1)
	bytes.buffer_write_ptr(&connection.buffer, &image_description, size_of(image_description))
	return
}
wp_image_description_creator_icc_v1_set_icc_file :: proc(connection: ^Connection, wp_image_description_creator_icc_v1: Wp_Image_Description_Creator_Icc_V1, icc_profile: Fd, offset: u32, length: u32) {
	_size: u16 = 8 + size_of(offset) + size_of(length)
	wp_image_description_creator_icc_v1 := wp_image_description_creator_icc_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_icc_v1, size_of(wp_image_description_creator_icc_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	append(&connection.fds_out, icc_profile)
	offset := offset
	bytes.buffer_write_ptr(&connection.buffer, &offset, size_of(offset))
	length := length
	bytes.buffer_write_ptr(&connection.buffer, &length, size_of(length))
	return
}
wp_image_description_creator_params_v1_create :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1) -> (image_description: Wp_Image_Description_V1) {
	_size: u16 = 8 + size_of(image_description)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	image_description = auto_cast generate_id(connection, .Wp_Image_Description_V1)
	bytes.buffer_write_ptr(&connection.buffer, &image_description, size_of(image_description))
	return
}
wp_image_description_creator_params_v1_set_tf_named :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, tf: Wp_Color_Manager_V1_Transfer_Function) {
	_size: u16 = 8 + size_of(tf)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	tf := tf
	bytes.buffer_write_ptr(&connection.buffer, &tf, size_of(tf))
	return
}
wp_image_description_creator_params_v1_set_tf_power :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, eexp: u32) {
	_size: u16 = 8 + size_of(eexp)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	eexp := eexp
	bytes.buffer_write_ptr(&connection.buffer, &eexp, size_of(eexp))
	return
}
wp_image_description_creator_params_v1_set_primaries_named :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, primaries: Wp_Color_Manager_V1_Primaries) {
	_size: u16 = 8 + size_of(primaries)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	primaries := primaries
	bytes.buffer_write_ptr(&connection.buffer, &primaries, size_of(primaries))
	return
}
wp_image_description_creator_params_v1_set_primaries :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, r_x: i32, r_y: i32, g_x: i32, g_y: i32, b_x: i32, b_y: i32, w_x: i32, w_y: i32) {
	_size: u16 = 8 + size_of(r_x) + size_of(r_y) + size_of(g_x) + size_of(g_y) + size_of(b_x) + size_of(b_y) + size_of(w_x) + size_of(w_y)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	r_x := r_x
	bytes.buffer_write_ptr(&connection.buffer, &r_x, size_of(r_x))
	r_y := r_y
	bytes.buffer_write_ptr(&connection.buffer, &r_y, size_of(r_y))
	g_x := g_x
	bytes.buffer_write_ptr(&connection.buffer, &g_x, size_of(g_x))
	g_y := g_y
	bytes.buffer_write_ptr(&connection.buffer, &g_y, size_of(g_y))
	b_x := b_x
	bytes.buffer_write_ptr(&connection.buffer, &b_x, size_of(b_x))
	b_y := b_y
	bytes.buffer_write_ptr(&connection.buffer, &b_y, size_of(b_y))
	w_x := w_x
	bytes.buffer_write_ptr(&connection.buffer, &w_x, size_of(w_x))
	w_y := w_y
	bytes.buffer_write_ptr(&connection.buffer, &w_y, size_of(w_y))
	return
}
wp_image_description_creator_params_v1_set_luminances :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, min_lum: u32, max_lum: u32, reference_lum: u32) {
	_size: u16 = 8 + size_of(min_lum) + size_of(max_lum) + size_of(reference_lum)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 5
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	min_lum := min_lum
	bytes.buffer_write_ptr(&connection.buffer, &min_lum, size_of(min_lum))
	max_lum := max_lum
	bytes.buffer_write_ptr(&connection.buffer, &max_lum, size_of(max_lum))
	reference_lum := reference_lum
	bytes.buffer_write_ptr(&connection.buffer, &reference_lum, size_of(reference_lum))
	return
}
wp_image_description_creator_params_v1_set_mastering_display_primaries :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, r_x: i32, r_y: i32, g_x: i32, g_y: i32, b_x: i32, b_y: i32, w_x: i32, w_y: i32) {
	_size: u16 = 8 + size_of(r_x) + size_of(r_y) + size_of(g_x) + size_of(g_y) + size_of(b_x) + size_of(b_y) + size_of(w_x) + size_of(w_y)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 6
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	r_x := r_x
	bytes.buffer_write_ptr(&connection.buffer, &r_x, size_of(r_x))
	r_y := r_y
	bytes.buffer_write_ptr(&connection.buffer, &r_y, size_of(r_y))
	g_x := g_x
	bytes.buffer_write_ptr(&connection.buffer, &g_x, size_of(g_x))
	g_y := g_y
	bytes.buffer_write_ptr(&connection.buffer, &g_y, size_of(g_y))
	b_x := b_x
	bytes.buffer_write_ptr(&connection.buffer, &b_x, size_of(b_x))
	b_y := b_y
	bytes.buffer_write_ptr(&connection.buffer, &b_y, size_of(b_y))
	w_x := w_x
	bytes.buffer_write_ptr(&connection.buffer, &w_x, size_of(w_x))
	w_y := w_y
	bytes.buffer_write_ptr(&connection.buffer, &w_y, size_of(w_y))
	return
}
wp_image_description_creator_params_v1_set_mastering_luminance :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, min_lum: u32, max_lum: u32) {
	_size: u16 = 8 + size_of(min_lum) + size_of(max_lum)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 7
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	min_lum := min_lum
	bytes.buffer_write_ptr(&connection.buffer, &min_lum, size_of(min_lum))
	max_lum := max_lum
	bytes.buffer_write_ptr(&connection.buffer, &max_lum, size_of(max_lum))
	return
}
wp_image_description_creator_params_v1_set_max_cll :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, max_cll: u32) {
	_size: u16 = 8 + size_of(max_cll)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 8
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	max_cll := max_cll
	bytes.buffer_write_ptr(&connection.buffer, &max_cll, size_of(max_cll))
	return
}
wp_image_description_creator_params_v1_set_max_fall :: proc(connection: ^Connection, wp_image_description_creator_params_v1: Wp_Image_Description_Creator_Params_V1, max_fall: u32) {
	_size: u16 = 8 + size_of(max_fall)
	wp_image_description_creator_params_v1 := wp_image_description_creator_params_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_creator_params_v1, size_of(wp_image_description_creator_params_v1))
	opcode: u16 = 9
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	max_fall := max_fall
	bytes.buffer_write_ptr(&connection.buffer, &max_fall, size_of(max_fall))
	return
}
wp_image_description_v1_destroy :: proc(connection: ^Connection, wp_image_description_v1: Wp_Image_Description_V1) {
	_size: u16 = 8
	wp_image_description_v1 := wp_image_description_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_v1, size_of(wp_image_description_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_image_description_v1_get_information :: proc(connection: ^Connection, wp_image_description_v1: Wp_Image_Description_V1) -> (information: Wp_Image_Description_Info_V1) {
	_size: u16 = 8 + size_of(information)
	wp_image_description_v1 := wp_image_description_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_image_description_v1, size_of(wp_image_description_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	information = auto_cast generate_id(connection, .Wp_Image_Description_Info_V1)
	bytes.buffer_write_ptr(&connection.buffer, &information, size_of(information))
	return
}
wp_color_representation_manager_v1_destroy :: proc(connection: ^Connection, wp_color_representation_manager_v1: Wp_Color_Representation_Manager_V1) {
	_size: u16 = 8
	wp_color_representation_manager_v1 := wp_color_representation_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_representation_manager_v1, size_of(wp_color_representation_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_color_representation_manager_v1_get_surface :: proc(connection: ^Connection, wp_color_representation_manager_v1: Wp_Color_Representation_Manager_V1, surface: Surface) -> (id: Wp_Color_Representation_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_color_representation_manager_v1 := wp_color_representation_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_representation_manager_v1, size_of(wp_color_representation_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Color_Representation_Surface_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_color_representation_surface_v1_destroy :: proc(connection: ^Connection, wp_color_representation_surface_v1: Wp_Color_Representation_Surface_V1) {
	_size: u16 = 8
	wp_color_representation_surface_v1 := wp_color_representation_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_representation_surface_v1, size_of(wp_color_representation_surface_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_color_representation_surface_v1_set_alpha_mode :: proc(connection: ^Connection, wp_color_representation_surface_v1: Wp_Color_Representation_Surface_V1, alpha_mode: Wp_Color_Representation_Surface_V1_Alpha_Mode) {
	_size: u16 = 8 + size_of(alpha_mode)
	wp_color_representation_surface_v1 := wp_color_representation_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_representation_surface_v1, size_of(wp_color_representation_surface_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	alpha_mode := alpha_mode
	bytes.buffer_write_ptr(&connection.buffer, &alpha_mode, size_of(alpha_mode))
	return
}
wp_color_representation_surface_v1_set_coefficients_and_range :: proc(connection: ^Connection, wp_color_representation_surface_v1: Wp_Color_Representation_Surface_V1, coefficients: Wp_Color_Representation_Surface_V1_Coefficients, range: Wp_Color_Representation_Surface_V1_Range) {
	_size: u16 = 8 + size_of(coefficients) + size_of(range)
	wp_color_representation_surface_v1 := wp_color_representation_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_representation_surface_v1, size_of(wp_color_representation_surface_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	coefficients := coefficients
	bytes.buffer_write_ptr(&connection.buffer, &coefficients, size_of(coefficients))
	range := range
	bytes.buffer_write_ptr(&connection.buffer, &range, size_of(range))
	return
}
wp_color_representation_surface_v1_set_chroma_location :: proc(connection: ^Connection, wp_color_representation_surface_v1: Wp_Color_Representation_Surface_V1, chroma_location: Wp_Color_Representation_Surface_V1_Chroma_Location) {
	_size: u16 = 8 + size_of(chroma_location)
	wp_color_representation_surface_v1 := wp_color_representation_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_color_representation_surface_v1, size_of(wp_color_representation_surface_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	chroma_location := chroma_location
	bytes.buffer_write_ptr(&connection.buffer, &chroma_location, size_of(chroma_location))
	return
}
wp_commit_timing_manager_v1_destroy :: proc(connection: ^Connection, wp_commit_timing_manager_v1: Wp_Commit_Timing_Manager_V1) {
	_size: u16 = 8
	wp_commit_timing_manager_v1 := wp_commit_timing_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_commit_timing_manager_v1, size_of(wp_commit_timing_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_commit_timing_manager_v1_get_timer :: proc(connection: ^Connection, wp_commit_timing_manager_v1: Wp_Commit_Timing_Manager_V1, surface: Surface) -> (id: Wp_Commit_Timer_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_commit_timing_manager_v1 := wp_commit_timing_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_commit_timing_manager_v1, size_of(wp_commit_timing_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Commit_Timer_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_commit_timer_v1_set_timestamp :: proc(connection: ^Connection, wp_commit_timer_v1: Wp_Commit_Timer_V1, tv_sec_hi: u32, tv_sec_lo: u32, tv_nsec: u32) {
	_size: u16 = 8 + size_of(tv_sec_hi) + size_of(tv_sec_lo) + size_of(tv_nsec)
	wp_commit_timer_v1 := wp_commit_timer_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_commit_timer_v1, size_of(wp_commit_timer_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	tv_sec_hi := tv_sec_hi
	bytes.buffer_write_ptr(&connection.buffer, &tv_sec_hi, size_of(tv_sec_hi))
	tv_sec_lo := tv_sec_lo
	bytes.buffer_write_ptr(&connection.buffer, &tv_sec_lo, size_of(tv_sec_lo))
	tv_nsec := tv_nsec
	bytes.buffer_write_ptr(&connection.buffer, &tv_nsec, size_of(tv_nsec))
	return
}
wp_commit_timer_v1_destroy :: proc(connection: ^Connection, wp_commit_timer_v1: Wp_Commit_Timer_V1) {
	_size: u16 = 8
	wp_commit_timer_v1 := wp_commit_timer_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_commit_timer_v1, size_of(wp_commit_timer_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_content_type_manager_v1_destroy :: proc(connection: ^Connection, wp_content_type_manager_v1: Wp_Content_Type_Manager_V1) {
	_size: u16 = 8
	wp_content_type_manager_v1 := wp_content_type_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_content_type_manager_v1, size_of(wp_content_type_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_content_type_manager_v1_get_surface_content_type :: proc(connection: ^Connection, wp_content_type_manager_v1: Wp_Content_Type_Manager_V1, surface: Surface) -> (id: Wp_Content_Type_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_content_type_manager_v1 := wp_content_type_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_content_type_manager_v1, size_of(wp_content_type_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Content_Type_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_content_type_v1_destroy :: proc(connection: ^Connection, wp_content_type_v1: Wp_Content_Type_V1) {
	_size: u16 = 8
	wp_content_type_v1 := wp_content_type_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_content_type_v1, size_of(wp_content_type_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_content_type_v1_set_content_type :: proc(connection: ^Connection, wp_content_type_v1: Wp_Content_Type_V1, content_type: Wp_Content_Type_V1_Type) {
	_size: u16 = 8 + size_of(content_type)
	wp_content_type_v1 := wp_content_type_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_content_type_v1, size_of(wp_content_type_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	content_type := content_type
	bytes.buffer_write_ptr(&connection.buffer, &content_type, size_of(content_type))
	return
}
wp_cursor_shape_manager_v1_destroy :: proc(connection: ^Connection, wp_cursor_shape_manager_v1: Wp_Cursor_Shape_Manager_V1) {
	_size: u16 = 8
	wp_cursor_shape_manager_v1 := wp_cursor_shape_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_cursor_shape_manager_v1, size_of(wp_cursor_shape_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_cursor_shape_manager_v1_get_pointer :: proc(connection: ^Connection, wp_cursor_shape_manager_v1: Wp_Cursor_Shape_Manager_V1, pointer: Pointer) -> (cursor_shape_device: Wp_Cursor_Shape_Device_V1) {
	_size: u16 = 8 + size_of(cursor_shape_device) + size_of(pointer)
	wp_cursor_shape_manager_v1 := wp_cursor_shape_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_cursor_shape_manager_v1, size_of(wp_cursor_shape_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	cursor_shape_device = auto_cast generate_id(connection, .Wp_Cursor_Shape_Device_V1)
	bytes.buffer_write_ptr(&connection.buffer, &cursor_shape_device, size_of(cursor_shape_device))
	pointer := pointer
	bytes.buffer_write_ptr(&connection.buffer, &pointer, size_of(pointer))
	return
}
wp_cursor_shape_manager_v1_get_tablet_tool_v2 :: proc(connection: ^Connection, wp_cursor_shape_manager_v1: Wp_Cursor_Shape_Manager_V1, tablet_tool: Zwp_Tablet_Tool_V2) -> (cursor_shape_device: Wp_Cursor_Shape_Device_V1) {
	_size: u16 = 8 + size_of(cursor_shape_device) + size_of(tablet_tool)
	wp_cursor_shape_manager_v1 := wp_cursor_shape_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_cursor_shape_manager_v1, size_of(wp_cursor_shape_manager_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	cursor_shape_device = auto_cast generate_id(connection, .Wp_Cursor_Shape_Device_V1)
	bytes.buffer_write_ptr(&connection.buffer, &cursor_shape_device, size_of(cursor_shape_device))
	tablet_tool := tablet_tool
	bytes.buffer_write_ptr(&connection.buffer, &tablet_tool, size_of(tablet_tool))
	return
}
wp_cursor_shape_device_v1_destroy :: proc(connection: ^Connection, wp_cursor_shape_device_v1: Wp_Cursor_Shape_Device_V1) {
	_size: u16 = 8
	wp_cursor_shape_device_v1 := wp_cursor_shape_device_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_cursor_shape_device_v1, size_of(wp_cursor_shape_device_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_cursor_shape_device_v1_set_shape :: proc(connection: ^Connection, wp_cursor_shape_device_v1: Wp_Cursor_Shape_Device_V1, serial: u32, shape: Wp_Cursor_Shape_Device_V1_Shape) {
	_size: u16 = 8 + size_of(serial) + size_of(shape)
	wp_cursor_shape_device_v1 := wp_cursor_shape_device_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_cursor_shape_device_v1, size_of(wp_cursor_shape_device_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	shape := shape
	bytes.buffer_write_ptr(&connection.buffer, &shape, size_of(shape))
	return
}
wp_drm_lease_device_v1_create_lease_request :: proc(connection: ^Connection, wp_drm_lease_device_v1: Wp_Drm_Lease_Device_V1) -> (id: Wp_Drm_Lease_Request_V1) {
	_size: u16 = 8 + size_of(id)
	wp_drm_lease_device_v1 := wp_drm_lease_device_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_drm_lease_device_v1, size_of(wp_drm_lease_device_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Drm_Lease_Request_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
wp_drm_lease_device_v1_release :: proc(connection: ^Connection, wp_drm_lease_device_v1: Wp_Drm_Lease_Device_V1) {
	_size: u16 = 8
	wp_drm_lease_device_v1 := wp_drm_lease_device_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_drm_lease_device_v1, size_of(wp_drm_lease_device_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_drm_lease_connector_v1_destroy :: proc(connection: ^Connection, wp_drm_lease_connector_v1: Wp_Drm_Lease_Connector_V1) {
	_size: u16 = 8
	wp_drm_lease_connector_v1 := wp_drm_lease_connector_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_drm_lease_connector_v1, size_of(wp_drm_lease_connector_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_drm_lease_request_v1_request_connector :: proc(connection: ^Connection, wp_drm_lease_request_v1: Wp_Drm_Lease_Request_V1, connector: Wp_Drm_Lease_Connector_V1) {
	_size: u16 = 8 + size_of(connector)
	wp_drm_lease_request_v1 := wp_drm_lease_request_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_drm_lease_request_v1, size_of(wp_drm_lease_request_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	connector := connector
	bytes.buffer_write_ptr(&connection.buffer, &connector, size_of(connector))
	return
}
wp_drm_lease_request_v1_submit :: proc(connection: ^Connection, wp_drm_lease_request_v1: Wp_Drm_Lease_Request_V1) -> (id: Wp_Drm_Lease_V1) {
	_size: u16 = 8 + size_of(id)
	wp_drm_lease_request_v1 := wp_drm_lease_request_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_drm_lease_request_v1, size_of(wp_drm_lease_request_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Drm_Lease_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
wp_drm_lease_v1_destroy :: proc(connection: ^Connection, wp_drm_lease_v1: Wp_Drm_Lease_V1) {
	_size: u16 = 8
	wp_drm_lease_v1 := wp_drm_lease_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_drm_lease_v1, size_of(wp_drm_lease_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_background_effect_manager_v1_destroy :: proc(connection: ^Connection, ext_background_effect_manager_v1: Ext_Background_Effect_Manager_V1) {
	_size: u16 = 8
	ext_background_effect_manager_v1 := ext_background_effect_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_background_effect_manager_v1, size_of(ext_background_effect_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_background_effect_manager_v1_get_background_effect :: proc(connection: ^Connection, ext_background_effect_manager_v1: Ext_Background_Effect_Manager_V1, surface: Surface) -> (id: Ext_Background_Effect_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	ext_background_effect_manager_v1 := ext_background_effect_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_background_effect_manager_v1, size_of(ext_background_effect_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Ext_Background_Effect_Surface_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
ext_background_effect_surface_v1_destroy :: proc(connection: ^Connection, ext_background_effect_surface_v1: Ext_Background_Effect_Surface_V1) {
	_size: u16 = 8
	ext_background_effect_surface_v1 := ext_background_effect_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_background_effect_surface_v1, size_of(ext_background_effect_surface_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_background_effect_surface_v1_set_blur_region :: proc(connection: ^Connection, ext_background_effect_surface_v1: Ext_Background_Effect_Surface_V1, region: Region) {
	_size: u16 = 8 + size_of(region)
	ext_background_effect_surface_v1 := ext_background_effect_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_background_effect_surface_v1, size_of(ext_background_effect_surface_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	region := region
	bytes.buffer_write_ptr(&connection.buffer, &region, size_of(region))
	return
}
ext_data_control_manager_v1_create_data_source :: proc(connection: ^Connection, ext_data_control_manager_v1: Ext_Data_Control_Manager_V1) -> (id: Ext_Data_Control_Source_V1) {
	_size: u16 = 8 + size_of(id)
	ext_data_control_manager_v1 := ext_data_control_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_manager_v1, size_of(ext_data_control_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Ext_Data_Control_Source_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
ext_data_control_manager_v1_get_data_device :: proc(connection: ^Connection, ext_data_control_manager_v1: Ext_Data_Control_Manager_V1, seat: Seat) -> (id: Ext_Data_Control_Device_V1) {
	_size: u16 = 8 + size_of(id) + size_of(seat)
	ext_data_control_manager_v1 := ext_data_control_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_manager_v1, size_of(ext_data_control_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Ext_Data_Control_Device_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	return
}
ext_data_control_manager_v1_destroy :: proc(connection: ^Connection, ext_data_control_manager_v1: Ext_Data_Control_Manager_V1) {
	_size: u16 = 8
	ext_data_control_manager_v1 := ext_data_control_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_manager_v1, size_of(ext_data_control_manager_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_data_control_device_v1_set_selection :: proc(connection: ^Connection, ext_data_control_device_v1: Ext_Data_Control_Device_V1, source: Ext_Data_Control_Source_V1) {
	_size: u16 = 8 + size_of(source)
	ext_data_control_device_v1 := ext_data_control_device_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_device_v1, size_of(ext_data_control_device_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	source := source
	bytes.buffer_write_ptr(&connection.buffer, &source, size_of(source))
	return
}
ext_data_control_device_v1_destroy :: proc(connection: ^Connection, ext_data_control_device_v1: Ext_Data_Control_Device_V1) {
	_size: u16 = 8
	ext_data_control_device_v1 := ext_data_control_device_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_device_v1, size_of(ext_data_control_device_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_data_control_device_v1_set_primary_selection :: proc(connection: ^Connection, ext_data_control_device_v1: Ext_Data_Control_Device_V1, source: Ext_Data_Control_Source_V1) {
	_size: u16 = 8 + size_of(source)
	ext_data_control_device_v1 := ext_data_control_device_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_device_v1, size_of(ext_data_control_device_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	source := source
	bytes.buffer_write_ptr(&connection.buffer, &source, size_of(source))
	return
}
ext_data_control_source_v1_offer :: proc(connection: ^Connection, ext_data_control_source_v1: Ext_Data_Control_Source_V1, mime_type: string) {
	_size: u16 = 8 + 4 + u16((len(mime_type) + 1 + 3) & -4)
	ext_data_control_source_v1 := ext_data_control_source_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_source_v1, size_of(ext_data_control_source_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_mime_type_len := u32(len(mime_type)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_mime_type_len, 4)
	bytes.buffer_write_string(&connection.buffer, mime_type)
	for _ in len(mime_type) ..< (len(mime_type) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
ext_data_control_source_v1_destroy :: proc(connection: ^Connection, ext_data_control_source_v1: Ext_Data_Control_Source_V1) {
	_size: u16 = 8
	ext_data_control_source_v1 := ext_data_control_source_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_source_v1, size_of(ext_data_control_source_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_data_control_offer_v1_receive :: proc(connection: ^Connection, ext_data_control_offer_v1: Ext_Data_Control_Offer_V1, mime_type: string, fd: Fd) {
	_size: u16 = 8 + 4 + u16((len(mime_type) + 1 + 3) & -4)
	ext_data_control_offer_v1 := ext_data_control_offer_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_offer_v1, size_of(ext_data_control_offer_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_mime_type_len := u32(len(mime_type)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_mime_type_len, 4)
	bytes.buffer_write_string(&connection.buffer, mime_type)
	for _ in len(mime_type) ..< (len(mime_type) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	append(&connection.fds_out, fd)
	return
}
ext_data_control_offer_v1_destroy :: proc(connection: ^Connection, ext_data_control_offer_v1: Ext_Data_Control_Offer_V1) {
	_size: u16 = 8
	ext_data_control_offer_v1 := ext_data_control_offer_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_data_control_offer_v1, size_of(ext_data_control_offer_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_foreign_toplevel_list_v1_stop :: proc(connection: ^Connection, ext_foreign_toplevel_list_v1: Ext_Foreign_Toplevel_List_V1) {
	_size: u16 = 8
	ext_foreign_toplevel_list_v1 := ext_foreign_toplevel_list_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_foreign_toplevel_list_v1, size_of(ext_foreign_toplevel_list_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_foreign_toplevel_list_v1_destroy :: proc(connection: ^Connection, ext_foreign_toplevel_list_v1: Ext_Foreign_Toplevel_List_V1) {
	_size: u16 = 8
	ext_foreign_toplevel_list_v1 := ext_foreign_toplevel_list_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_foreign_toplevel_list_v1, size_of(ext_foreign_toplevel_list_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_foreign_toplevel_handle_v1_destroy :: proc(connection: ^Connection, ext_foreign_toplevel_handle_v1: Ext_Foreign_Toplevel_Handle_V1) {
	_size: u16 = 8
	ext_foreign_toplevel_handle_v1 := ext_foreign_toplevel_handle_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_foreign_toplevel_handle_v1, size_of(ext_foreign_toplevel_handle_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_idle_notifier_v1_destroy :: proc(connection: ^Connection, ext_idle_notifier_v1: Ext_Idle_Notifier_V1) {
	_size: u16 = 8
	ext_idle_notifier_v1 := ext_idle_notifier_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_idle_notifier_v1, size_of(ext_idle_notifier_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_idle_notifier_v1_get_idle_notification :: proc(connection: ^Connection, ext_idle_notifier_v1: Ext_Idle_Notifier_V1, timeout: u32, seat: Seat) -> (id: Ext_Idle_Notification_V1) {
	_size: u16 = 8 + size_of(id) + size_of(timeout) + size_of(seat)
	ext_idle_notifier_v1 := ext_idle_notifier_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_idle_notifier_v1, size_of(ext_idle_notifier_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Ext_Idle_Notification_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	timeout := timeout
	bytes.buffer_write_ptr(&connection.buffer, &timeout, size_of(timeout))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	return
}
ext_idle_notifier_v1_get_input_idle_notification :: proc(connection: ^Connection, ext_idle_notifier_v1: Ext_Idle_Notifier_V1, timeout: u32, seat: Seat) -> (id: Ext_Idle_Notification_V1) {
	_size: u16 = 8 + size_of(id) + size_of(timeout) + size_of(seat)
	ext_idle_notifier_v1 := ext_idle_notifier_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_idle_notifier_v1, size_of(ext_idle_notifier_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Ext_Idle_Notification_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	timeout := timeout
	bytes.buffer_write_ptr(&connection.buffer, &timeout, size_of(timeout))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	return
}
ext_idle_notification_v1_destroy :: proc(connection: ^Connection, ext_idle_notification_v1: Ext_Idle_Notification_V1) {
	_size: u16 = 8
	ext_idle_notification_v1 := ext_idle_notification_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_idle_notification_v1, size_of(ext_idle_notification_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_image_capture_source_v1_destroy :: proc(connection: ^Connection, ext_image_capture_source_v1: Ext_Image_Capture_Source_V1) {
	_size: u16 = 8
	ext_image_capture_source_v1 := ext_image_capture_source_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_capture_source_v1, size_of(ext_image_capture_source_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_output_image_capture_source_manager_v1_create_source :: proc(connection: ^Connection, ext_output_image_capture_source_manager_v1: Ext_Output_Image_Capture_Source_Manager_V1, output: Output) -> (source: Ext_Image_Capture_Source_V1) {
	_size: u16 = 8 + size_of(source) + size_of(output)
	ext_output_image_capture_source_manager_v1 := ext_output_image_capture_source_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_output_image_capture_source_manager_v1, size_of(ext_output_image_capture_source_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	source = auto_cast generate_id(connection, .Ext_Image_Capture_Source_V1)
	bytes.buffer_write_ptr(&connection.buffer, &source, size_of(source))
	output := output
	bytes.buffer_write_ptr(&connection.buffer, &output, size_of(output))
	return
}
ext_output_image_capture_source_manager_v1_destroy :: proc(connection: ^Connection, ext_output_image_capture_source_manager_v1: Ext_Output_Image_Capture_Source_Manager_V1) {
	_size: u16 = 8
	ext_output_image_capture_source_manager_v1 := ext_output_image_capture_source_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_output_image_capture_source_manager_v1, size_of(ext_output_image_capture_source_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_foreign_toplevel_image_capture_source_manager_v1_create_source :: proc(connection: ^Connection, ext_foreign_toplevel_image_capture_source_manager_v1: Ext_Foreign_Toplevel_Image_Capture_Source_Manager_V1, toplevel_handle: Ext_Foreign_Toplevel_Handle_V1) -> (source: Ext_Image_Capture_Source_V1) {
	_size: u16 = 8 + size_of(source) + size_of(toplevel_handle)
	ext_foreign_toplevel_image_capture_source_manager_v1 := ext_foreign_toplevel_image_capture_source_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_foreign_toplevel_image_capture_source_manager_v1, size_of(ext_foreign_toplevel_image_capture_source_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	source = auto_cast generate_id(connection, .Ext_Image_Capture_Source_V1)
	bytes.buffer_write_ptr(&connection.buffer, &source, size_of(source))
	toplevel_handle := toplevel_handle
	bytes.buffer_write_ptr(&connection.buffer, &toplevel_handle, size_of(toplevel_handle))
	return
}
ext_foreign_toplevel_image_capture_source_manager_v1_destroy :: proc(connection: ^Connection, ext_foreign_toplevel_image_capture_source_manager_v1: Ext_Foreign_Toplevel_Image_Capture_Source_Manager_V1) {
	_size: u16 = 8
	ext_foreign_toplevel_image_capture_source_manager_v1 := ext_foreign_toplevel_image_capture_source_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_foreign_toplevel_image_capture_source_manager_v1, size_of(ext_foreign_toplevel_image_capture_source_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_image_copy_capture_manager_v1_create_session :: proc(connection: ^Connection, ext_image_copy_capture_manager_v1: Ext_Image_Copy_Capture_Manager_V1, source: Ext_Image_Capture_Source_V1, options: Ext_Image_Copy_Capture_Manager_V1_Options) -> (session: Ext_Image_Copy_Capture_Session_V1) {
	_size: u16 = 8 + size_of(session) + size_of(source) + size_of(options)
	ext_image_copy_capture_manager_v1 := ext_image_copy_capture_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_manager_v1, size_of(ext_image_copy_capture_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	session = auto_cast generate_id(connection, .Ext_Image_Copy_Capture_Session_V1)
	bytes.buffer_write_ptr(&connection.buffer, &session, size_of(session))
	source := source
	bytes.buffer_write_ptr(&connection.buffer, &source, size_of(source))
	options := options
	bytes.buffer_write_ptr(&connection.buffer, &options, size_of(options))
	return
}
ext_image_copy_capture_manager_v1_create_pointer_cursor_session :: proc(connection: ^Connection, ext_image_copy_capture_manager_v1: Ext_Image_Copy_Capture_Manager_V1, source: Ext_Image_Capture_Source_V1, pointer: Pointer) -> (session: Ext_Image_Copy_Capture_Cursor_Session_V1) {
	_size: u16 = 8 + size_of(session) + size_of(source) + size_of(pointer)
	ext_image_copy_capture_manager_v1 := ext_image_copy_capture_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_manager_v1, size_of(ext_image_copy_capture_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	session = auto_cast generate_id(connection, .Ext_Image_Copy_Capture_Cursor_Session_V1)
	bytes.buffer_write_ptr(&connection.buffer, &session, size_of(session))
	source := source
	bytes.buffer_write_ptr(&connection.buffer, &source, size_of(source))
	pointer := pointer
	bytes.buffer_write_ptr(&connection.buffer, &pointer, size_of(pointer))
	return
}
ext_image_copy_capture_manager_v1_destroy :: proc(connection: ^Connection, ext_image_copy_capture_manager_v1: Ext_Image_Copy_Capture_Manager_V1) {
	_size: u16 = 8
	ext_image_copy_capture_manager_v1 := ext_image_copy_capture_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_manager_v1, size_of(ext_image_copy_capture_manager_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_image_copy_capture_session_v1_create_frame :: proc(connection: ^Connection, ext_image_copy_capture_session_v1: Ext_Image_Copy_Capture_Session_V1) -> (frame: Ext_Image_Copy_Capture_Frame_V1) {
	_size: u16 = 8 + size_of(frame)
	ext_image_copy_capture_session_v1 := ext_image_copy_capture_session_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_session_v1, size_of(ext_image_copy_capture_session_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	frame = auto_cast generate_id(connection, .Ext_Image_Copy_Capture_Frame_V1)
	bytes.buffer_write_ptr(&connection.buffer, &frame, size_of(frame))
	return
}
ext_image_copy_capture_session_v1_destroy :: proc(connection: ^Connection, ext_image_copy_capture_session_v1: Ext_Image_Copy_Capture_Session_V1) {
	_size: u16 = 8
	ext_image_copy_capture_session_v1 := ext_image_copy_capture_session_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_session_v1, size_of(ext_image_copy_capture_session_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_image_copy_capture_frame_v1_destroy :: proc(connection: ^Connection, ext_image_copy_capture_frame_v1: Ext_Image_Copy_Capture_Frame_V1) {
	_size: u16 = 8
	ext_image_copy_capture_frame_v1 := ext_image_copy_capture_frame_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_frame_v1, size_of(ext_image_copy_capture_frame_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_image_copy_capture_frame_v1_attach_buffer :: proc(connection: ^Connection, ext_image_copy_capture_frame_v1: Ext_Image_Copy_Capture_Frame_V1, buffer: Buffer) {
	_size: u16 = 8 + size_of(buffer)
	ext_image_copy_capture_frame_v1 := ext_image_copy_capture_frame_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_frame_v1, size_of(ext_image_copy_capture_frame_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	buffer := buffer
	bytes.buffer_write_ptr(&connection.buffer, &buffer, size_of(buffer))
	return
}
ext_image_copy_capture_frame_v1_damage_buffer :: proc(connection: ^Connection, ext_image_copy_capture_frame_v1: Ext_Image_Copy_Capture_Frame_V1, x: i32, y: i32, width: i32, height: i32) {
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	ext_image_copy_capture_frame_v1 := ext_image_copy_capture_frame_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_frame_v1, size_of(ext_image_copy_capture_frame_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	width := width
	bytes.buffer_write_ptr(&connection.buffer, &width, size_of(width))
	height := height
	bytes.buffer_write_ptr(&connection.buffer, &height, size_of(height))
	return
}
ext_image_copy_capture_frame_v1_capture :: proc(connection: ^Connection, ext_image_copy_capture_frame_v1: Ext_Image_Copy_Capture_Frame_V1) {
	_size: u16 = 8
	ext_image_copy_capture_frame_v1 := ext_image_copy_capture_frame_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_frame_v1, size_of(ext_image_copy_capture_frame_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_image_copy_capture_cursor_session_v1_destroy :: proc(connection: ^Connection, ext_image_copy_capture_cursor_session_v1: Ext_Image_Copy_Capture_Cursor_Session_V1) {
	_size: u16 = 8
	ext_image_copy_capture_cursor_session_v1 := ext_image_copy_capture_cursor_session_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_cursor_session_v1, size_of(ext_image_copy_capture_cursor_session_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_image_copy_capture_cursor_session_v1_get_capture_session :: proc(connection: ^Connection, ext_image_copy_capture_cursor_session_v1: Ext_Image_Copy_Capture_Cursor_Session_V1) -> (session: Ext_Image_Copy_Capture_Session_V1) {
	_size: u16 = 8 + size_of(session)
	ext_image_copy_capture_cursor_session_v1 := ext_image_copy_capture_cursor_session_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_image_copy_capture_cursor_session_v1, size_of(ext_image_copy_capture_cursor_session_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	session = auto_cast generate_id(connection, .Ext_Image_Copy_Capture_Session_V1)
	bytes.buffer_write_ptr(&connection.buffer, &session, size_of(session))
	return
}
ext_session_lock_manager_v1_destroy :: proc(connection: ^Connection, ext_session_lock_manager_v1: Ext_Session_Lock_Manager_V1) {
	_size: u16 = 8
	ext_session_lock_manager_v1 := ext_session_lock_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_session_lock_manager_v1, size_of(ext_session_lock_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_session_lock_manager_v1_lock :: proc(connection: ^Connection, ext_session_lock_manager_v1: Ext_Session_Lock_Manager_V1) -> (id: Ext_Session_Lock_V1) {
	_size: u16 = 8 + size_of(id)
	ext_session_lock_manager_v1 := ext_session_lock_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_session_lock_manager_v1, size_of(ext_session_lock_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Ext_Session_Lock_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
ext_session_lock_v1_destroy :: proc(connection: ^Connection, ext_session_lock_v1: Ext_Session_Lock_V1) {
	_size: u16 = 8
	ext_session_lock_v1 := ext_session_lock_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_session_lock_v1, size_of(ext_session_lock_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_session_lock_v1_get_lock_surface :: proc(connection: ^Connection, ext_session_lock_v1: Ext_Session_Lock_V1, surface: Surface, output: Output) -> (id: Ext_Session_Lock_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface) + size_of(output)
	ext_session_lock_v1 := ext_session_lock_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_session_lock_v1, size_of(ext_session_lock_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Ext_Session_Lock_Surface_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	output := output
	bytes.buffer_write_ptr(&connection.buffer, &output, size_of(output))
	return
}
ext_session_lock_v1_unlock_and_destroy :: proc(connection: ^Connection, ext_session_lock_v1: Ext_Session_Lock_V1) {
	_size: u16 = 8
	ext_session_lock_v1 := ext_session_lock_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_session_lock_v1, size_of(ext_session_lock_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_session_lock_surface_v1_destroy :: proc(connection: ^Connection, ext_session_lock_surface_v1: Ext_Session_Lock_Surface_V1) {
	_size: u16 = 8
	ext_session_lock_surface_v1 := ext_session_lock_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_session_lock_surface_v1, size_of(ext_session_lock_surface_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_session_lock_surface_v1_ack_configure :: proc(connection: ^Connection, ext_session_lock_surface_v1: Ext_Session_Lock_Surface_V1, serial: u32) {
	_size: u16 = 8 + size_of(serial)
	ext_session_lock_surface_v1 := ext_session_lock_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_session_lock_surface_v1, size_of(ext_session_lock_surface_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
ext_transient_seat_manager_v1_create :: proc(connection: ^Connection, ext_transient_seat_manager_v1: Ext_Transient_Seat_Manager_V1) -> (seat: Ext_Transient_Seat_V1) {
	_size: u16 = 8 + size_of(seat)
	ext_transient_seat_manager_v1 := ext_transient_seat_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_transient_seat_manager_v1, size_of(ext_transient_seat_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	seat = auto_cast generate_id(connection, .Ext_Transient_Seat_V1)
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	return
}
ext_transient_seat_manager_v1_destroy :: proc(connection: ^Connection, ext_transient_seat_manager_v1: Ext_Transient_Seat_Manager_V1) {
	_size: u16 = 8
	ext_transient_seat_manager_v1 := ext_transient_seat_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_transient_seat_manager_v1, size_of(ext_transient_seat_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_transient_seat_v1_destroy :: proc(connection: ^Connection, ext_transient_seat_v1: Ext_Transient_Seat_V1) {
	_size: u16 = 8
	ext_transient_seat_v1 := ext_transient_seat_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_transient_seat_v1, size_of(ext_transient_seat_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_workspace_manager_v1_commit :: proc(connection: ^Connection, ext_workspace_manager_v1: Ext_Workspace_Manager_V1) {
	_size: u16 = 8
	ext_workspace_manager_v1 := ext_workspace_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_manager_v1, size_of(ext_workspace_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_workspace_manager_v1_stop :: proc(connection: ^Connection, ext_workspace_manager_v1: Ext_Workspace_Manager_V1) {
	_size: u16 = 8
	ext_workspace_manager_v1 := ext_workspace_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_manager_v1, size_of(ext_workspace_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_workspace_group_handle_v1_create_workspace :: proc(connection: ^Connection, ext_workspace_group_handle_v1: Ext_Workspace_Group_Handle_V1, workspace: string) {
	_size: u16 = 8 + 4 + u16((len(workspace) + 1 + 3) & -4)
	ext_workspace_group_handle_v1 := ext_workspace_group_handle_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_group_handle_v1, size_of(ext_workspace_group_handle_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_workspace_len := u32(len(workspace)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_workspace_len, 4)
	bytes.buffer_write_string(&connection.buffer, workspace)
	for _ in len(workspace) ..< (len(workspace) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
ext_workspace_group_handle_v1_destroy :: proc(connection: ^Connection, ext_workspace_group_handle_v1: Ext_Workspace_Group_Handle_V1) {
	_size: u16 = 8
	ext_workspace_group_handle_v1 := ext_workspace_group_handle_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_group_handle_v1, size_of(ext_workspace_group_handle_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_workspace_handle_v1_destroy :: proc(connection: ^Connection, ext_workspace_handle_v1: Ext_Workspace_Handle_V1) {
	_size: u16 = 8
	ext_workspace_handle_v1 := ext_workspace_handle_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_handle_v1, size_of(ext_workspace_handle_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_workspace_handle_v1_activate :: proc(connection: ^Connection, ext_workspace_handle_v1: Ext_Workspace_Handle_V1) {
	_size: u16 = 8
	ext_workspace_handle_v1 := ext_workspace_handle_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_handle_v1, size_of(ext_workspace_handle_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_workspace_handle_v1_deactivate :: proc(connection: ^Connection, ext_workspace_handle_v1: Ext_Workspace_Handle_V1) {
	_size: u16 = 8
	ext_workspace_handle_v1 := ext_workspace_handle_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_handle_v1, size_of(ext_workspace_handle_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
ext_workspace_handle_v1_assign :: proc(connection: ^Connection, ext_workspace_handle_v1: Ext_Workspace_Handle_V1, workspace_group: Ext_Workspace_Group_Handle_V1) {
	_size: u16 = 8 + size_of(workspace_group)
	ext_workspace_handle_v1 := ext_workspace_handle_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_handle_v1, size_of(ext_workspace_handle_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	workspace_group := workspace_group
	bytes.buffer_write_ptr(&connection.buffer, &workspace_group, size_of(workspace_group))
	return
}
ext_workspace_handle_v1_remove :: proc(connection: ^Connection, ext_workspace_handle_v1: Ext_Workspace_Handle_V1) {
	_size: u16 = 8
	ext_workspace_handle_v1 := ext_workspace_handle_v1
	bytes.buffer_write_ptr(&connection.buffer, &ext_workspace_handle_v1, size_of(ext_workspace_handle_v1))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_fifo_manager_v1_destroy :: proc(connection: ^Connection, wp_fifo_manager_v1: Wp_Fifo_Manager_V1) {
	_size: u16 = 8
	wp_fifo_manager_v1 := wp_fifo_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_fifo_manager_v1, size_of(wp_fifo_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_fifo_manager_v1_get_fifo :: proc(connection: ^Connection, wp_fifo_manager_v1: Wp_Fifo_Manager_V1, surface: Surface) -> (id: Wp_Fifo_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_fifo_manager_v1 := wp_fifo_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_fifo_manager_v1, size_of(wp_fifo_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Fifo_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_fifo_v1_set_barrier :: proc(connection: ^Connection, wp_fifo_v1: Wp_Fifo_V1) {
	_size: u16 = 8
	wp_fifo_v1 := wp_fifo_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_fifo_v1, size_of(wp_fifo_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_fifo_v1_wait_barrier :: proc(connection: ^Connection, wp_fifo_v1: Wp_Fifo_V1) {
	_size: u16 = 8
	wp_fifo_v1 := wp_fifo_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_fifo_v1, size_of(wp_fifo_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_fifo_v1_destroy :: proc(connection: ^Connection, wp_fifo_v1: Wp_Fifo_V1) {
	_size: u16 = 8
	wp_fifo_v1 := wp_fifo_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_fifo_v1, size_of(wp_fifo_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_fractional_scale_manager_v1_destroy :: proc(connection: ^Connection, wp_fractional_scale_manager_v1: Wp_Fractional_Scale_Manager_V1) {
	_size: u16 = 8
	wp_fractional_scale_manager_v1 := wp_fractional_scale_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_fractional_scale_manager_v1, size_of(wp_fractional_scale_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_fractional_scale_manager_v1_get_fractional_scale :: proc(connection: ^Connection, wp_fractional_scale_manager_v1: Wp_Fractional_Scale_Manager_V1, surface: Surface) -> (id: Wp_Fractional_Scale_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_fractional_scale_manager_v1 := wp_fractional_scale_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_fractional_scale_manager_v1, size_of(wp_fractional_scale_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Fractional_Scale_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_fractional_scale_v1_destroy :: proc(connection: ^Connection, wp_fractional_scale_v1: Wp_Fractional_Scale_V1) {
	_size: u16 = 8
	wp_fractional_scale_v1 := wp_fractional_scale_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_fractional_scale_v1, size_of(wp_fractional_scale_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_linux_drm_syncobj_manager_v1_destroy :: proc(connection: ^Connection, wp_linux_drm_syncobj_manager_v1: Wp_Linux_Drm_Syncobj_Manager_V1) {
	_size: u16 = 8
	wp_linux_drm_syncobj_manager_v1 := wp_linux_drm_syncobj_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_linux_drm_syncobj_manager_v1, size_of(wp_linux_drm_syncobj_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_linux_drm_syncobj_manager_v1_get_surface :: proc(connection: ^Connection, wp_linux_drm_syncobj_manager_v1: Wp_Linux_Drm_Syncobj_Manager_V1, surface: Surface) -> (id: Wp_Linux_Drm_Syncobj_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_linux_drm_syncobj_manager_v1 := wp_linux_drm_syncobj_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_linux_drm_syncobj_manager_v1, size_of(wp_linux_drm_syncobj_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Linux_Drm_Syncobj_Surface_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_linux_drm_syncobj_manager_v1_import_timeline :: proc(connection: ^Connection, wp_linux_drm_syncobj_manager_v1: Wp_Linux_Drm_Syncobj_Manager_V1, fd: Fd) -> (id: Wp_Linux_Drm_Syncobj_Timeline_V1) {
	_size: u16 = 8 + size_of(id)
	wp_linux_drm_syncobj_manager_v1 := wp_linux_drm_syncobj_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_linux_drm_syncobj_manager_v1, size_of(wp_linux_drm_syncobj_manager_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Linux_Drm_Syncobj_Timeline_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	append(&connection.fds_out, fd)
	return
}
wp_linux_drm_syncobj_timeline_v1_destroy :: proc(connection: ^Connection, wp_linux_drm_syncobj_timeline_v1: Wp_Linux_Drm_Syncobj_Timeline_V1) {
	_size: u16 = 8
	wp_linux_drm_syncobj_timeline_v1 := wp_linux_drm_syncobj_timeline_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_linux_drm_syncobj_timeline_v1, size_of(wp_linux_drm_syncobj_timeline_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_linux_drm_syncobj_surface_v1_destroy :: proc(connection: ^Connection, wp_linux_drm_syncobj_surface_v1: Wp_Linux_Drm_Syncobj_Surface_V1) {
	_size: u16 = 8
	wp_linux_drm_syncobj_surface_v1 := wp_linux_drm_syncobj_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_linux_drm_syncobj_surface_v1, size_of(wp_linux_drm_syncobj_surface_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_linux_drm_syncobj_surface_v1_set_acquire_point :: proc(connection: ^Connection, wp_linux_drm_syncobj_surface_v1: Wp_Linux_Drm_Syncobj_Surface_V1, timeline: Wp_Linux_Drm_Syncobj_Timeline_V1, point_hi: u32, point_lo: u32) {
	_size: u16 = 8 + size_of(timeline) + size_of(point_hi) + size_of(point_lo)
	wp_linux_drm_syncobj_surface_v1 := wp_linux_drm_syncobj_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_linux_drm_syncobj_surface_v1, size_of(wp_linux_drm_syncobj_surface_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	timeline := timeline
	bytes.buffer_write_ptr(&connection.buffer, &timeline, size_of(timeline))
	point_hi := point_hi
	bytes.buffer_write_ptr(&connection.buffer, &point_hi, size_of(point_hi))
	point_lo := point_lo
	bytes.buffer_write_ptr(&connection.buffer, &point_lo, size_of(point_lo))
	return
}
wp_linux_drm_syncobj_surface_v1_set_release_point :: proc(connection: ^Connection, wp_linux_drm_syncobj_surface_v1: Wp_Linux_Drm_Syncobj_Surface_V1, timeline: Wp_Linux_Drm_Syncobj_Timeline_V1, point_hi: u32, point_lo: u32) {
	_size: u16 = 8 + size_of(timeline) + size_of(point_hi) + size_of(point_lo)
	wp_linux_drm_syncobj_surface_v1 := wp_linux_drm_syncobj_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_linux_drm_syncobj_surface_v1, size_of(wp_linux_drm_syncobj_surface_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	timeline := timeline
	bytes.buffer_write_ptr(&connection.buffer, &timeline, size_of(timeline))
	point_hi := point_hi
	bytes.buffer_write_ptr(&connection.buffer, &point_hi, size_of(point_hi))
	point_lo := point_lo
	bytes.buffer_write_ptr(&connection.buffer, &point_lo, size_of(point_lo))
	return
}
wp_pointer_warp_v1_destroy :: proc(connection: ^Connection, wp_pointer_warp_v1: Wp_Pointer_Warp_V1) {
	_size: u16 = 8
	wp_pointer_warp_v1 := wp_pointer_warp_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_pointer_warp_v1, size_of(wp_pointer_warp_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_pointer_warp_v1_warp_pointer :: proc(connection: ^Connection, wp_pointer_warp_v1: Wp_Pointer_Warp_V1, surface: Surface, pointer: Pointer, x: f64, y: f64, serial: u32) {
	_size: u16 = 8 + size_of(surface) + size_of(pointer) + size_of(x) + size_of(y) + size_of(serial)
	wp_pointer_warp_v1 := wp_pointer_warp_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_pointer_warp_v1, size_of(wp_pointer_warp_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	pointer := pointer
	bytes.buffer_write_ptr(&connection.buffer, &pointer, size_of(pointer))
	x := x
	bytes.buffer_write_ptr(&connection.buffer, &x, size_of(x))
	y := y
	bytes.buffer_write_ptr(&connection.buffer, &y, size_of(y))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	return
}
wp_security_context_manager_v1_destroy :: proc(connection: ^Connection, wp_security_context_manager_v1: Wp_Security_Context_Manager_V1) {
	_size: u16 = 8
	wp_security_context_manager_v1 := wp_security_context_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_security_context_manager_v1, size_of(wp_security_context_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_security_context_manager_v1_create_listener :: proc(connection: ^Connection, wp_security_context_manager_v1: Wp_Security_Context_Manager_V1, listen_fd: Fd, close_fd: Fd) -> (id: Wp_Security_Context_V1) {
	_size: u16 = 8 + size_of(id)
	wp_security_context_manager_v1 := wp_security_context_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_security_context_manager_v1, size_of(wp_security_context_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Security_Context_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	append(&connection.fds_out, listen_fd)
	append(&connection.fds_out, close_fd)
	return
}
wp_security_context_v1_destroy :: proc(connection: ^Connection, wp_security_context_v1: Wp_Security_Context_V1) {
	_size: u16 = 8
	wp_security_context_v1 := wp_security_context_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_security_context_v1, size_of(wp_security_context_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_security_context_v1_set_sandbox_engine :: proc(connection: ^Connection, wp_security_context_v1: Wp_Security_Context_V1, name: string) {
	_size: u16 = 8 + 4 + u16((len(name) + 1 + 3) & -4)
	wp_security_context_v1 := wp_security_context_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_security_context_v1, size_of(wp_security_context_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_name_len := u32(len(name)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_name_len, 4)
	bytes.buffer_write_string(&connection.buffer, name)
	for _ in len(name) ..< (len(name) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
wp_security_context_v1_set_app_id :: proc(connection: ^Connection, wp_security_context_v1: Wp_Security_Context_V1, app_id: string) {
	_size: u16 = 8 + 4 + u16((len(app_id) + 1 + 3) & -4)
	wp_security_context_v1 := wp_security_context_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_security_context_v1, size_of(wp_security_context_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_app_id_len := u32(len(app_id)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_app_id_len, 4)
	bytes.buffer_write_string(&connection.buffer, app_id)
	for _ in len(app_id) ..< (len(app_id) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
wp_security_context_v1_set_instance_id :: proc(connection: ^Connection, wp_security_context_v1: Wp_Security_Context_V1, instance_id: string) {
	_size: u16 = 8 + 4 + u16((len(instance_id) + 1 + 3) & -4)
	wp_security_context_v1 := wp_security_context_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_security_context_v1, size_of(wp_security_context_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_instance_id_len := u32(len(instance_id)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_instance_id_len, 4)
	bytes.buffer_write_string(&connection.buffer, instance_id)
	for _ in len(instance_id) ..< (len(instance_id) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
wp_security_context_v1_commit :: proc(connection: ^Connection, wp_security_context_v1: Wp_Security_Context_V1) {
	_size: u16 = 8
	wp_security_context_v1 := wp_security_context_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_security_context_v1, size_of(wp_security_context_v1))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_single_pixel_buffer_manager_v1_destroy :: proc(connection: ^Connection, wp_single_pixel_buffer_manager_v1: Wp_Single_Pixel_Buffer_Manager_V1) {
	_size: u16 = 8
	wp_single_pixel_buffer_manager_v1 := wp_single_pixel_buffer_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_single_pixel_buffer_manager_v1, size_of(wp_single_pixel_buffer_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_single_pixel_buffer_manager_v1_create_u32_rgba_buffer :: proc(connection: ^Connection, wp_single_pixel_buffer_manager_v1: Wp_Single_Pixel_Buffer_Manager_V1, r: u32, g: u32, b: u32, a: u32) -> (id: Buffer) {
	_size: u16 = 8 + size_of(id) + size_of(r) + size_of(g) + size_of(b) + size_of(a)
	wp_single_pixel_buffer_manager_v1 := wp_single_pixel_buffer_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_single_pixel_buffer_manager_v1, size_of(wp_single_pixel_buffer_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Buffer)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	r := r
	bytes.buffer_write_ptr(&connection.buffer, &r, size_of(r))
	g := g
	bytes.buffer_write_ptr(&connection.buffer, &g, size_of(g))
	b := b
	bytes.buffer_write_ptr(&connection.buffer, &b, size_of(b))
	a := a
	bytes.buffer_write_ptr(&connection.buffer, &a, size_of(a))
	return
}
wp_tearing_control_manager_v1_destroy :: proc(connection: ^Connection, wp_tearing_control_manager_v1: Wp_Tearing_Control_Manager_V1) {
	_size: u16 = 8
	wp_tearing_control_manager_v1 := wp_tearing_control_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_tearing_control_manager_v1, size_of(wp_tearing_control_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
wp_tearing_control_manager_v1_get_tearing_control :: proc(connection: ^Connection, wp_tearing_control_manager_v1: Wp_Tearing_Control_Manager_V1, surface: Surface) -> (id: Wp_Tearing_Control_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	wp_tearing_control_manager_v1 := wp_tearing_control_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_tearing_control_manager_v1, size_of(wp_tearing_control_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Wp_Tearing_Control_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
wp_tearing_control_v1_set_presentation_hint :: proc(connection: ^Connection, wp_tearing_control_v1: Wp_Tearing_Control_V1, hint: Wp_Tearing_Control_V1_Presentation_Hint) {
	_size: u16 = 8 + size_of(hint)
	wp_tearing_control_v1 := wp_tearing_control_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_tearing_control_v1, size_of(wp_tearing_control_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	hint := hint
	bytes.buffer_write_ptr(&connection.buffer, &hint, size_of(hint))
	return
}
wp_tearing_control_v1_destroy :: proc(connection: ^Connection, wp_tearing_control_v1: Wp_Tearing_Control_V1) {
	_size: u16 = 8
	wp_tearing_control_v1 := wp_tearing_control_v1
	bytes.buffer_write_ptr(&connection.buffer, &wp_tearing_control_v1, size_of(wp_tearing_control_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_activation_v1_destroy :: proc(connection: ^Connection, xdg_activation_v1: Xdg_Activation_V1) {
	_size: u16 = 8
	xdg_activation_v1 := xdg_activation_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_activation_v1, size_of(xdg_activation_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_activation_v1_get_activation_token :: proc(connection: ^Connection, xdg_activation_v1: Xdg_Activation_V1) -> (id: Xdg_Activation_Token_V1) {
	_size: u16 = 8 + size_of(id)
	xdg_activation_v1 := xdg_activation_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_activation_v1, size_of(xdg_activation_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xdg_Activation_Token_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
xdg_activation_v1_activate :: proc(connection: ^Connection, xdg_activation_v1: Xdg_Activation_V1, token: string, surface: Surface) {
	_size: u16 = 8 + 4 + u16((len(token) + 1 + 3) & -4) + size_of(surface)
	xdg_activation_v1 := xdg_activation_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_activation_v1, size_of(xdg_activation_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_token_len := u32(len(token)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_token_len, 4)
	bytes.buffer_write_string(&connection.buffer, token)
	for _ in len(token) ..< (len(token) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
xdg_activation_token_v1_set_serial :: proc(connection: ^Connection, xdg_activation_token_v1: Xdg_Activation_Token_V1, serial: u32, seat: Seat) {
	_size: u16 = 8 + size_of(serial) + size_of(seat)
	xdg_activation_token_v1 := xdg_activation_token_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_activation_token_v1, size_of(xdg_activation_token_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial := serial
	bytes.buffer_write_ptr(&connection.buffer, &serial, size_of(serial))
	seat := seat
	bytes.buffer_write_ptr(&connection.buffer, &seat, size_of(seat))
	return
}
xdg_activation_token_v1_set_app_id :: proc(connection: ^Connection, xdg_activation_token_v1: Xdg_Activation_Token_V1, app_id: string) {
	_size: u16 = 8 + 4 + u16((len(app_id) + 1 + 3) & -4)
	xdg_activation_token_v1 := xdg_activation_token_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_activation_token_v1, size_of(xdg_activation_token_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_app_id_len := u32(len(app_id)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_app_id_len, 4)
	bytes.buffer_write_string(&connection.buffer, app_id)
	for _ in len(app_id) ..< (len(app_id) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
xdg_activation_token_v1_set_surface :: proc(connection: ^Connection, xdg_activation_token_v1: Xdg_Activation_Token_V1, surface: Surface) {
	_size: u16 = 8 + size_of(surface)
	xdg_activation_token_v1 := xdg_activation_token_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_activation_token_v1, size_of(xdg_activation_token_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
xdg_activation_token_v1_commit :: proc(connection: ^Connection, xdg_activation_token_v1: Xdg_Activation_Token_V1) {
	_size: u16 = 8
	xdg_activation_token_v1 := xdg_activation_token_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_activation_token_v1, size_of(xdg_activation_token_v1))
	opcode: u16 = 3
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_activation_token_v1_destroy :: proc(connection: ^Connection, xdg_activation_token_v1: Xdg_Activation_Token_V1) {
	_size: u16 = 8
	xdg_activation_token_v1 := xdg_activation_token_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_activation_token_v1, size_of(xdg_activation_token_v1))
	opcode: u16 = 4
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_wm_dialog_v1_destroy :: proc(connection: ^Connection, xdg_wm_dialog_v1: Xdg_Wm_Dialog_V1) {
	_size: u16 = 8
	xdg_wm_dialog_v1 := xdg_wm_dialog_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_wm_dialog_v1, size_of(xdg_wm_dialog_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_wm_dialog_v1_get_xdg_dialog :: proc(connection: ^Connection, xdg_wm_dialog_v1: Xdg_Wm_Dialog_V1, toplevel: Xdg_Toplevel) -> (id: Xdg_Dialog_V1) {
	_size: u16 = 8 + size_of(id) + size_of(toplevel)
	xdg_wm_dialog_v1 := xdg_wm_dialog_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_wm_dialog_v1, size_of(xdg_wm_dialog_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xdg_Dialog_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	toplevel := toplevel
	bytes.buffer_write_ptr(&connection.buffer, &toplevel, size_of(toplevel))
	return
}
xdg_dialog_v1_destroy :: proc(connection: ^Connection, xdg_dialog_v1: Xdg_Dialog_V1) {
	_size: u16 = 8
	xdg_dialog_v1 := xdg_dialog_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_dialog_v1, size_of(xdg_dialog_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_dialog_v1_set_modal :: proc(connection: ^Connection, xdg_dialog_v1: Xdg_Dialog_V1) {
	_size: u16 = 8
	xdg_dialog_v1 := xdg_dialog_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_dialog_v1, size_of(xdg_dialog_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_dialog_v1_unset_modal :: proc(connection: ^Connection, xdg_dialog_v1: Xdg_Dialog_V1) {
	_size: u16 = 8
	xdg_dialog_v1 := xdg_dialog_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_dialog_v1, size_of(xdg_dialog_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_system_bell_v1_destroy :: proc(connection: ^Connection, xdg_system_bell_v1: Xdg_System_Bell_V1) {
	_size: u16 = 8
	xdg_system_bell_v1 := xdg_system_bell_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_system_bell_v1, size_of(xdg_system_bell_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_system_bell_v1_ring :: proc(connection: ^Connection, xdg_system_bell_v1: Xdg_System_Bell_V1, surface: Surface) {
	_size: u16 = 8 + size_of(surface)
	xdg_system_bell_v1 := xdg_system_bell_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_system_bell_v1, size_of(xdg_system_bell_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
xdg_toplevel_drag_manager_v1_destroy :: proc(connection: ^Connection, xdg_toplevel_drag_manager_v1: Xdg_Toplevel_Drag_Manager_V1) {
	_size: u16 = 8
	xdg_toplevel_drag_manager_v1 := xdg_toplevel_drag_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_drag_manager_v1, size_of(xdg_toplevel_drag_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_drag_manager_v1_get_xdg_toplevel_drag :: proc(connection: ^Connection, xdg_toplevel_drag_manager_v1: Xdg_Toplevel_Drag_Manager_V1, data_source: Data_Source) -> (id: Xdg_Toplevel_Drag_V1) {
	_size: u16 = 8 + size_of(id) + size_of(data_source)
	xdg_toplevel_drag_manager_v1 := xdg_toplevel_drag_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_drag_manager_v1, size_of(xdg_toplevel_drag_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xdg_Toplevel_Drag_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	data_source := data_source
	bytes.buffer_write_ptr(&connection.buffer, &data_source, size_of(data_source))
	return
}
xdg_toplevel_drag_v1_destroy :: proc(connection: ^Connection, xdg_toplevel_drag_v1: Xdg_Toplevel_Drag_V1) {
	_size: u16 = 8
	xdg_toplevel_drag_v1 := xdg_toplevel_drag_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_drag_v1, size_of(xdg_toplevel_drag_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_drag_v1_attach :: proc(connection: ^Connection, xdg_toplevel_drag_v1: Xdg_Toplevel_Drag_V1, toplevel: Xdg_Toplevel, x_offset: i32, y_offset: i32) {
	_size: u16 = 8 + size_of(toplevel) + size_of(x_offset) + size_of(y_offset)
	xdg_toplevel_drag_v1 := xdg_toplevel_drag_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_drag_v1, size_of(xdg_toplevel_drag_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	toplevel := toplevel
	bytes.buffer_write_ptr(&connection.buffer, &toplevel, size_of(toplevel))
	x_offset := x_offset
	bytes.buffer_write_ptr(&connection.buffer, &x_offset, size_of(x_offset))
	y_offset := y_offset
	bytes.buffer_write_ptr(&connection.buffer, &y_offset, size_of(y_offset))
	return
}
xdg_toplevel_icon_manager_v1_destroy :: proc(connection: ^Connection, xdg_toplevel_icon_manager_v1: Xdg_Toplevel_Icon_Manager_V1) {
	_size: u16 = 8
	xdg_toplevel_icon_manager_v1 := xdg_toplevel_icon_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_icon_manager_v1, size_of(xdg_toplevel_icon_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_icon_manager_v1_create_icon :: proc(connection: ^Connection, xdg_toplevel_icon_manager_v1: Xdg_Toplevel_Icon_Manager_V1) -> (id: Xdg_Toplevel_Icon_V1) {
	_size: u16 = 8 + size_of(id)
	xdg_toplevel_icon_manager_v1 := xdg_toplevel_icon_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_icon_manager_v1, size_of(xdg_toplevel_icon_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xdg_Toplevel_Icon_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	return
}
xdg_toplevel_icon_manager_v1_set_icon :: proc(connection: ^Connection, xdg_toplevel_icon_manager_v1: Xdg_Toplevel_Icon_Manager_V1, toplevel: Xdg_Toplevel, icon: Xdg_Toplevel_Icon_V1) {
	_size: u16 = 8 + size_of(toplevel) + size_of(icon)
	xdg_toplevel_icon_manager_v1 := xdg_toplevel_icon_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_icon_manager_v1, size_of(xdg_toplevel_icon_manager_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	toplevel := toplevel
	bytes.buffer_write_ptr(&connection.buffer, &toplevel, size_of(toplevel))
	icon := icon
	bytes.buffer_write_ptr(&connection.buffer, &icon, size_of(icon))
	return
}
xdg_toplevel_icon_v1_destroy :: proc(connection: ^Connection, xdg_toplevel_icon_v1: Xdg_Toplevel_Icon_V1) {
	_size: u16 = 8
	xdg_toplevel_icon_v1 := xdg_toplevel_icon_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_icon_v1, size_of(xdg_toplevel_icon_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_icon_v1_set_name :: proc(connection: ^Connection, xdg_toplevel_icon_v1: Xdg_Toplevel_Icon_V1, icon_name: string) {
	_size: u16 = 8 + 4 + u16((len(icon_name) + 1 + 3) & -4)
	xdg_toplevel_icon_v1 := xdg_toplevel_icon_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_icon_v1, size_of(xdg_toplevel_icon_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	_icon_name_len := u32(len(icon_name)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_icon_name_len, 4)
	bytes.buffer_write_string(&connection.buffer, icon_name)
	for _ in len(icon_name) ..< (len(icon_name) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
xdg_toplevel_icon_v1_add_buffer :: proc(connection: ^Connection, xdg_toplevel_icon_v1: Xdg_Toplevel_Icon_V1, buffer: Buffer, scale: i32) {
	_size: u16 = 8 + size_of(buffer) + size_of(scale)
	xdg_toplevel_icon_v1 := xdg_toplevel_icon_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_icon_v1, size_of(xdg_toplevel_icon_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	buffer := buffer
	bytes.buffer_write_ptr(&connection.buffer, &buffer, size_of(buffer))
	scale := scale
	bytes.buffer_write_ptr(&connection.buffer, &scale, size_of(scale))
	return
}
xdg_toplevel_tag_manager_v1_destroy :: proc(connection: ^Connection, xdg_toplevel_tag_manager_v1: Xdg_Toplevel_Tag_Manager_V1) {
	_size: u16 = 8
	xdg_toplevel_tag_manager_v1 := xdg_toplevel_tag_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_tag_manager_v1, size_of(xdg_toplevel_tag_manager_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xdg_toplevel_tag_manager_v1_set_toplevel_tag :: proc(connection: ^Connection, xdg_toplevel_tag_manager_v1: Xdg_Toplevel_Tag_Manager_V1, toplevel: Xdg_Toplevel, tag: string) {
	_size: u16 = 8 + size_of(toplevel) + 4 + u16((len(tag) + 1 + 3) & -4)
	xdg_toplevel_tag_manager_v1 := xdg_toplevel_tag_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_tag_manager_v1, size_of(xdg_toplevel_tag_manager_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	toplevel := toplevel
	bytes.buffer_write_ptr(&connection.buffer, &toplevel, size_of(toplevel))
	_tag_len := u32(len(tag)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_tag_len, 4)
	bytes.buffer_write_string(&connection.buffer, tag)
	for _ in len(tag) ..< (len(tag) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
xdg_toplevel_tag_manager_v1_set_toplevel_description :: proc(connection: ^Connection, xdg_toplevel_tag_manager_v1: Xdg_Toplevel_Tag_Manager_V1, toplevel: Xdg_Toplevel, description: string) {
	_size: u16 = 8 + size_of(toplevel) + 4 + u16((len(description) + 1 + 3) & -4)
	xdg_toplevel_tag_manager_v1 := xdg_toplevel_tag_manager_v1
	bytes.buffer_write_ptr(&connection.buffer, &xdg_toplevel_tag_manager_v1, size_of(xdg_toplevel_tag_manager_v1))
	opcode: u16 = 2
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	toplevel := toplevel
	bytes.buffer_write_ptr(&connection.buffer, &toplevel, size_of(toplevel))
	_description_len := u32(len(description)) + 1
	bytes.buffer_write_ptr(&connection.buffer, &_description_len, 4)
	bytes.buffer_write_string(&connection.buffer, description)
	for _ in len(description) ..< (len(description) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)
	assert(bytes.buffer_length(&connection.buffer) % 4 == 0)
	return
}
xwayland_shell_v1_destroy :: proc(connection: ^Connection, xwayland_shell_v1: Xwayland_Shell_V1) {
	_size: u16 = 8
	xwayland_shell_v1 := xwayland_shell_v1
	bytes.buffer_write_ptr(&connection.buffer, &xwayland_shell_v1, size_of(xwayland_shell_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}
xwayland_shell_v1_get_xwayland_surface :: proc(connection: ^Connection, xwayland_shell_v1: Xwayland_Shell_V1, surface: Surface) -> (id: Xwayland_Surface_V1) {
	_size: u16 = 8 + size_of(id) + size_of(surface)
	xwayland_shell_v1 := xwayland_shell_v1
	bytes.buffer_write_ptr(&connection.buffer, &xwayland_shell_v1, size_of(xwayland_shell_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	id = auto_cast generate_id(connection, .Xwayland_Surface_V1)
	bytes.buffer_write_ptr(&connection.buffer, &id, size_of(id))
	surface := surface
	bytes.buffer_write_ptr(&connection.buffer, &surface, size_of(surface))
	return
}
xwayland_surface_v1_set_serial :: proc(connection: ^Connection, xwayland_surface_v1: Xwayland_Surface_V1, serial_lo: u32, serial_hi: u32) {
	_size: u16 = 8 + size_of(serial_lo) + size_of(serial_hi)
	xwayland_surface_v1 := xwayland_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &xwayland_surface_v1, size_of(xwayland_surface_v1))
	opcode: u16 = 0
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	serial_lo := serial_lo
	bytes.buffer_write_ptr(&connection.buffer, &serial_lo, size_of(serial_lo))
	serial_hi := serial_hi
	bytes.buffer_write_ptr(&connection.buffer, &serial_hi, size_of(serial_hi))
	return
}
xwayland_surface_v1_destroy :: proc(connection: ^Connection, xwayland_surface_v1: Xwayland_Surface_V1) {
	_size: u16 = 8
	xwayland_surface_v1 := xwayland_surface_v1
	bytes.buffer_write_ptr(&connection.buffer, &xwayland_surface_v1, size_of(xwayland_surface_v1))
	opcode: u16 = 1
	bytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))
	bytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))
	return
}

Event :: union {
	Event_Display_Error,
	Event_Display_Delete_Id,
	Event_Registry_Global,
	Event_Registry_Global_Remove,
	Event_Callback_Done,
	Event_Shm_Format,
	Event_Buffer_Release,
	Event_Data_Offer_Offer,
	Event_Data_Offer_Source_Actions,
	Event_Data_Offer_Action,
	Event_Data_Source_Target,
	Event_Data_Source_Send,
	Event_Data_Source_Cancelled,
	Event_Data_Source_Dnd_Drop_Performed,
	Event_Data_Source_Dnd_Finished,
	Event_Data_Source_Action,
	Event_Data_Device_Data_Offer,
	Event_Data_Device_Enter,
	Event_Data_Device_Leave,
	Event_Data_Device_Motion,
	Event_Data_Device_Drop,
	Event_Data_Device_Selection,
	Event_Shell_Surface_Ping,
	Event_Shell_Surface_Configure,
	Event_Shell_Surface_Popup_Done,
	Event_Surface_Enter,
	Event_Surface_Leave,
	Event_Surface_Preferred_Buffer_Scale,
	Event_Surface_Preferred_Buffer_Transform,
	Event_Seat_Capabilities,
	Event_Seat_Name,
	Event_Pointer_Enter,
	Event_Pointer_Leave,
	Event_Pointer_Motion,
	Event_Pointer_Button,
	Event_Pointer_Axis,
	Event_Pointer_Frame,
	Event_Pointer_Axis_Source,
	Event_Pointer_Axis_Stop,
	Event_Pointer_Axis_Discrete,
	Event_Pointer_Axis_Value120,
	Event_Pointer_Axis_Relative_Direction,
	Event_Keyboard_Keymap,
	Event_Keyboard_Enter,
	Event_Keyboard_Leave,
	Event_Keyboard_Key,
	Event_Keyboard_Modifiers,
	Event_Keyboard_Repeat_Info,
	Event_Touch_Down,
	Event_Touch_Up,
	Event_Touch_Motion,
	Event_Touch_Frame,
	Event_Touch_Cancel,
	Event_Touch_Shape,
	Event_Touch_Orientation,
	Event_Output_Geometry,
	Event_Output_Mode,
	Event_Output_Done,
	Event_Output_Scale,
	Event_Output_Name,
	Event_Output_Description,
	Event_Zwp_Linux_Dmabuf_V1_Format,
	Event_Zwp_Linux_Dmabuf_V1_Modifier,
	Event_Zwp_Linux_Buffer_Params_V1_Created,
	Event_Zwp_Linux_Buffer_Params_V1_Failed,
	Event_Zwp_Linux_Dmabuf_Feedback_V1_Done,
	Event_Zwp_Linux_Dmabuf_Feedback_V1_Format_Table,
	Event_Zwp_Linux_Dmabuf_Feedback_V1_Main_Device,
	Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Done,
	Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Target_Device,
	Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Formats,
	Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Flags,
	Event_Wp_Presentation_Clock_Id,
	Event_Wp_Presentation_Feedback_Sync_Output,
	Event_Wp_Presentation_Feedback_Presented,
	Event_Wp_Presentation_Feedback_Discarded,
	Event_Zwp_Tablet_Seat_V2_Tablet_Added,
	Event_Zwp_Tablet_Seat_V2_Tool_Added,
	Event_Zwp_Tablet_Seat_V2_Pad_Added,
	Event_Zwp_Tablet_Tool_V2_Type,
	Event_Zwp_Tablet_Tool_V2_Hardware_Serial,
	Event_Zwp_Tablet_Tool_V2_Hardware_Id_Wacom,
	Event_Zwp_Tablet_Tool_V2_Capability,
	Event_Zwp_Tablet_Tool_V2_Done,
	Event_Zwp_Tablet_Tool_V2_Removed,
	Event_Zwp_Tablet_Tool_V2_Proximity_In,
	Event_Zwp_Tablet_Tool_V2_Proximity_Out,
	Event_Zwp_Tablet_Tool_V2_Down,
	Event_Zwp_Tablet_Tool_V2_Up,
	Event_Zwp_Tablet_Tool_V2_Motion,
	Event_Zwp_Tablet_Tool_V2_Pressure,
	Event_Zwp_Tablet_Tool_V2_Distance,
	Event_Zwp_Tablet_Tool_V2_Tilt,
	Event_Zwp_Tablet_Tool_V2_Rotation,
	Event_Zwp_Tablet_Tool_V2_Slider,
	Event_Zwp_Tablet_Tool_V2_Wheel,
	Event_Zwp_Tablet_Tool_V2_Button,
	Event_Zwp_Tablet_Tool_V2_Frame,
	Event_Zwp_Tablet_V2_Name,
	Event_Zwp_Tablet_V2_Id,
	Event_Zwp_Tablet_V2_Path,
	Event_Zwp_Tablet_V2_Done,
	Event_Zwp_Tablet_V2_Removed,
	Event_Zwp_Tablet_V2_Bustype,
	Event_Zwp_Tablet_Pad_Ring_V2_Source,
	Event_Zwp_Tablet_Pad_Ring_V2_Angle,
	Event_Zwp_Tablet_Pad_Ring_V2_Stop,
	Event_Zwp_Tablet_Pad_Ring_V2_Frame,
	Event_Zwp_Tablet_Pad_Strip_V2_Source,
	Event_Zwp_Tablet_Pad_Strip_V2_Position,
	Event_Zwp_Tablet_Pad_Strip_V2_Stop,
	Event_Zwp_Tablet_Pad_Strip_V2_Frame,
	Event_Zwp_Tablet_Pad_Group_V2_Buttons,
	Event_Zwp_Tablet_Pad_Group_V2_Ring,
	Event_Zwp_Tablet_Pad_Group_V2_Strip,
	Event_Zwp_Tablet_Pad_Group_V2_Modes,
	Event_Zwp_Tablet_Pad_Group_V2_Done,
	Event_Zwp_Tablet_Pad_Group_V2_Mode_Switch,
	Event_Zwp_Tablet_Pad_Group_V2_Dial,
	Event_Zwp_Tablet_Pad_V2_Group,
	Event_Zwp_Tablet_Pad_V2_Path,
	Event_Zwp_Tablet_Pad_V2_Buttons,
	Event_Zwp_Tablet_Pad_V2_Done,
	Event_Zwp_Tablet_Pad_V2_Button,
	Event_Zwp_Tablet_Pad_V2_Enter,
	Event_Zwp_Tablet_Pad_V2_Leave,
	Event_Zwp_Tablet_Pad_V2_Removed,
	Event_Zwp_Tablet_Pad_Dial_V2_Delta,
	Event_Zwp_Tablet_Pad_Dial_V2_Frame,
	Event_Xdg_Wm_Base_Ping,
	Event_Xdg_Surface_Configure,
	Event_Xdg_Toplevel_Configure,
	Event_Xdg_Toplevel_Close,
	Event_Xdg_Toplevel_Configure_Bounds,
	Event_Xdg_Toplevel_Wm_Capabilities,
	Event_Xdg_Popup_Configure,
	Event_Xdg_Popup_Popup_Done,
	Event_Xdg_Popup_Repositioned,
	Event_Wp_Color_Manager_V1_Supported_Intent,
	Event_Wp_Color_Manager_V1_Supported_Feature,
	Event_Wp_Color_Manager_V1_Supported_Tf_Named,
	Event_Wp_Color_Manager_V1_Supported_Primaries_Named,
	Event_Wp_Color_Manager_V1_Done,
	Event_Wp_Color_Management_Output_V1_Image_Description_Changed,
	Event_Wp_Color_Management_Surface_Feedback_V1_Preferred_Changed,
	Event_Wp_Image_Description_V1_Failed,
	Event_Wp_Image_Description_V1_Ready,
	Event_Wp_Image_Description_Info_V1_Done,
	Event_Wp_Image_Description_Info_V1_Icc_File,
	Event_Wp_Image_Description_Info_V1_Primaries,
	Event_Wp_Image_Description_Info_V1_Primaries_Named,
	Event_Wp_Image_Description_Info_V1_Tf_Power,
	Event_Wp_Image_Description_Info_V1_Tf_Named,
	Event_Wp_Image_Description_Info_V1_Luminances,
	Event_Wp_Image_Description_Info_V1_Target_Primaries,
	Event_Wp_Image_Description_Info_V1_Target_Luminance,
	Event_Wp_Image_Description_Info_V1_Target_Max_Cll,
	Event_Wp_Image_Description_Info_V1_Target_Max_Fall,
	Event_Wp_Color_Representation_Manager_V1_Supported_Alpha_Mode,
	Event_Wp_Color_Representation_Manager_V1_Supported_Coefficients_And_Ranges,
	Event_Wp_Color_Representation_Manager_V1_Done,
	Event_Wp_Drm_Lease_Device_V1_Drm_Fd,
	Event_Wp_Drm_Lease_Device_V1_Connector,
	Event_Wp_Drm_Lease_Device_V1_Done,
	Event_Wp_Drm_Lease_Device_V1_Released,
	Event_Wp_Drm_Lease_Connector_V1_Name,
	Event_Wp_Drm_Lease_Connector_V1_Description,
	Event_Wp_Drm_Lease_Connector_V1_Connector_Id,
	Event_Wp_Drm_Lease_Connector_V1_Done,
	Event_Wp_Drm_Lease_Connector_V1_Withdrawn,
	Event_Wp_Drm_Lease_V1_Lease_Fd,
	Event_Wp_Drm_Lease_V1_Finished,
	Event_Ext_Background_Effect_Manager_V1_Capabilities,
	Event_Ext_Data_Control_Device_V1_Data_Offer,
	Event_Ext_Data_Control_Device_V1_Selection,
	Event_Ext_Data_Control_Device_V1_Finished,
	Event_Ext_Data_Control_Device_V1_Primary_Selection,
	Event_Ext_Data_Control_Source_V1_Send,
	Event_Ext_Data_Control_Source_V1_Cancelled,
	Event_Ext_Data_Control_Offer_V1_Offer,
	Event_Ext_Foreign_Toplevel_List_V1_Toplevel,
	Event_Ext_Foreign_Toplevel_List_V1_Finished,
	Event_Ext_Foreign_Toplevel_Handle_V1_Closed,
	Event_Ext_Foreign_Toplevel_Handle_V1_Done,
	Event_Ext_Foreign_Toplevel_Handle_V1_Title,
	Event_Ext_Foreign_Toplevel_Handle_V1_App_Id,
	Event_Ext_Foreign_Toplevel_Handle_V1_Identifier,
	Event_Ext_Idle_Notification_V1_Idled,
	Event_Ext_Idle_Notification_V1_Resumed,
	Event_Ext_Image_Copy_Capture_Session_V1_Buffer_Size,
	Event_Ext_Image_Copy_Capture_Session_V1_Shm_Format,
	Event_Ext_Image_Copy_Capture_Session_V1_Dmabuf_Device,
	Event_Ext_Image_Copy_Capture_Session_V1_Dmabuf_Format,
	Event_Ext_Image_Copy_Capture_Session_V1_Done,
	Event_Ext_Image_Copy_Capture_Session_V1_Stopped,
	Event_Ext_Image_Copy_Capture_Frame_V1_Transform,
	Event_Ext_Image_Copy_Capture_Frame_V1_Damage,
	Event_Ext_Image_Copy_Capture_Frame_V1_Presentation_Time,
	Event_Ext_Image_Copy_Capture_Frame_V1_Ready,
	Event_Ext_Image_Copy_Capture_Frame_V1_Failed,
	Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Enter,
	Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Leave,
	Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Position,
	Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Hotspot,
	Event_Ext_Session_Lock_V1_Locked,
	Event_Ext_Session_Lock_V1_Finished,
	Event_Ext_Session_Lock_Surface_V1_Configure,
	Event_Ext_Transient_Seat_V1_Ready,
	Event_Ext_Transient_Seat_V1_Denied,
	Event_Ext_Workspace_Manager_V1_Workspace_Group,
	Event_Ext_Workspace_Manager_V1_Workspace,
	Event_Ext_Workspace_Manager_V1_Done,
	Event_Ext_Workspace_Manager_V1_Finished,
	Event_Ext_Workspace_Group_Handle_V1_Capabilities,
	Event_Ext_Workspace_Group_Handle_V1_Output_Enter,
	Event_Ext_Workspace_Group_Handle_V1_Output_Leave,
	Event_Ext_Workspace_Group_Handle_V1_Workspace_Enter,
	Event_Ext_Workspace_Group_Handle_V1_Workspace_Leave,
	Event_Ext_Workspace_Group_Handle_V1_Removed,
	Event_Ext_Workspace_Handle_V1_Id,
	Event_Ext_Workspace_Handle_V1_Name,
	Event_Ext_Workspace_Handle_V1_Coordinates,
	Event_Ext_Workspace_Handle_V1_State,
	Event_Ext_Workspace_Handle_V1_Capabilities,
	Event_Ext_Workspace_Handle_V1_Removed,
	Event_Wp_Fractional_Scale_V1_Preferred_Scale,
	Event_Xdg_Activation_Token_V1_Done,
	Event_Xdg_Toplevel_Icon_Manager_V1_Icon_Size,
	Event_Xdg_Toplevel_Icon_Manager_V1_Done,
}

Event_Display_Error :: struct {
	object_id: Object,
	code: u32,
	message: string,
}
Event_Display_Delete_Id :: struct {
	id: u32,
}
Event_Registry_Global :: struct {
	name: u32,
	interface: string,
	version: u32,
}
Event_Registry_Global_Remove :: struct {
	name: u32,
}
Event_Callback_Done :: struct {
	callback_data: u32,
}
Event_Shm_Format :: struct {
	format: Shm_Format,
}
Event_Buffer_Release :: struct {
}
Event_Data_Offer_Offer :: struct {
	mime_type: string,
}
Event_Data_Offer_Source_Actions :: struct {
	source_actions: Data_Device_Manager_Dnd_Action,
}
Event_Data_Offer_Action :: struct {
	dnd_action: Data_Device_Manager_Dnd_Action,
}
Event_Data_Source_Target :: struct {
	mime_type: string,
}
Event_Data_Source_Send :: struct {
	mime_type: string,
	fd: Fd,
}
Event_Data_Source_Cancelled :: struct {
}
Event_Data_Source_Dnd_Drop_Performed :: struct {
}
Event_Data_Source_Dnd_Finished :: struct {
}
Event_Data_Source_Action :: struct {
	dnd_action: Data_Device_Manager_Dnd_Action,
}
Event_Data_Device_Data_Offer :: struct {
	id: Data_Offer,
}
Event_Data_Device_Enter :: struct {
	serial: u32,
	surface: Surface,
	x: f64,
	y: f64,
	id: Data_Offer,
}
Event_Data_Device_Leave :: struct {
}
Event_Data_Device_Motion :: struct {
	time: u32,
	x: f64,
	y: f64,
}
Event_Data_Device_Drop :: struct {
}
Event_Data_Device_Selection :: struct {
	id: Data_Offer,
}
Event_Shell_Surface_Ping :: struct {
	serial: u32,
}
Event_Shell_Surface_Configure :: struct {
	edges: Shell_Surface_Resize,
	width: i32,
	height: i32,
}
Event_Shell_Surface_Popup_Done :: struct {
}
Event_Surface_Enter :: struct {
	output: Output,
}
Event_Surface_Leave :: struct {
	output: Output,
}
Event_Surface_Preferred_Buffer_Scale :: struct {
	factor: i32,
}
Event_Surface_Preferred_Buffer_Transform :: struct {
	transform: Output_Transform,
}
Event_Seat_Capabilities :: struct {
	capabilities: Seat_Capability,
}
Event_Seat_Name :: struct {
	name: string,
}
Event_Pointer_Enter :: struct {
	serial: u32,
	surface: Surface,
	surface_x: f64,
	surface_y: f64,
}
Event_Pointer_Leave :: struct {
	serial: u32,
	surface: Surface,
}
Event_Pointer_Motion :: struct {
	time: u32,
	surface_x: f64,
	surface_y: f64,
}
Event_Pointer_Button :: struct {
	serial: u32,
	time: u32,
	button: u32,
	state: Pointer_Button_State,
}
Event_Pointer_Axis :: struct {
	time: u32,
	axis: Pointer_Axis,
	value: f64,
}
Event_Pointer_Frame :: struct {
}
Event_Pointer_Axis_Source :: struct {
	axis_source: Pointer_Axis_Source,
}
Event_Pointer_Axis_Stop :: struct {
	time: u32,
	axis: Pointer_Axis,
}
Event_Pointer_Axis_Discrete :: struct {
	axis: Pointer_Axis,
	discrete: i32,
}
Event_Pointer_Axis_Value120 :: struct {
	axis: Pointer_Axis,
	value120: i32,
}
Event_Pointer_Axis_Relative_Direction :: struct {
	axis: Pointer_Axis,
	direction: Pointer_Axis_Relative_Direction,
}
Event_Keyboard_Keymap :: struct {
	format: Keyboard_Keymap_Format,
	fd: Fd,
	size: u32,
}
Event_Keyboard_Enter :: struct {
	serial: u32,
	surface: Surface,
	keys: []byte,
}
Event_Keyboard_Leave :: struct {
	serial: u32,
	surface: Surface,
}
Event_Keyboard_Key :: struct {
	serial: u32,
	time: u32,
	key: u32,
	state: Keyboard_Key_State,
}
Event_Keyboard_Modifiers :: struct {
	serial: u32,
	mods_depressed: u32,
	mods_latched: u32,
	mods_locked: u32,
	group: u32,
}
Event_Keyboard_Repeat_Info :: struct {
	rate: i32,
	delay: i32,
}
Event_Touch_Down :: struct {
	serial: u32,
	time: u32,
	surface: Surface,
	id: i32,
	x: f64,
	y: f64,
}
Event_Touch_Up :: struct {
	serial: u32,
	time: u32,
	id: i32,
}
Event_Touch_Motion :: struct {
	time: u32,
	id: i32,
	x: f64,
	y: f64,
}
Event_Touch_Frame :: struct {
}
Event_Touch_Cancel :: struct {
}
Event_Touch_Shape :: struct {
	id: i32,
	major: f64,
	minor: f64,
}
Event_Touch_Orientation :: struct {
	id: i32,
	orientation: f64,
}
Event_Output_Geometry :: struct {
	x: i32,
	y: i32,
	physical_width: i32,
	physical_height: i32,
	subpixel: Output_Subpixel,
	make: string,
	model: string,
	transform: Output_Transform,
}
Event_Output_Mode :: struct {
	flags: Output_Mode,
	width: i32,
	height: i32,
	refresh: i32,
}
Event_Output_Done :: struct {
}
Event_Output_Scale :: struct {
	factor: i32,
}
Event_Output_Name :: struct {
	name: string,
}
Event_Output_Description :: struct {
	description: string,
}
Event_Zwp_Linux_Dmabuf_V1_Format :: struct {
	format: u32,
}
Event_Zwp_Linux_Dmabuf_V1_Modifier :: struct {
	format: u32,
	modifier_hi: u32,
	modifier_lo: u32,
}
Event_Zwp_Linux_Buffer_Params_V1_Created :: struct {
	buffer: Buffer,
}
Event_Zwp_Linux_Buffer_Params_V1_Failed :: struct {
}
Event_Zwp_Linux_Dmabuf_Feedback_V1_Done :: struct {
}
Event_Zwp_Linux_Dmabuf_Feedback_V1_Format_Table :: struct {
	fd: Fd,
	size: u32,
}
Event_Zwp_Linux_Dmabuf_Feedback_V1_Main_Device :: struct {
	device: []byte,
}
Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Done :: struct {
}
Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Target_Device :: struct {
	device: []byte,
}
Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Formats :: struct {
	indices: []byte,
}
Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Flags :: struct {
	flags: Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Flags,
}
Event_Wp_Presentation_Clock_Id :: struct {
	clk_id: u32,
}
Event_Wp_Presentation_Feedback_Sync_Output :: struct {
	output: Output,
}
Event_Wp_Presentation_Feedback_Presented :: struct {
	tv_sec_hi: u32,
	tv_sec_lo: u32,
	tv_nsec: u32,
	refresh: u32,
	seq_hi: u32,
	seq_lo: u32,
	flags: Wp_Presentation_Feedback_Kind,
}
Event_Wp_Presentation_Feedback_Discarded :: struct {
}
Event_Zwp_Tablet_Seat_V2_Tablet_Added :: struct {
	id: Zwp_Tablet_V2,
}
Event_Zwp_Tablet_Seat_V2_Tool_Added :: struct {
	id: Zwp_Tablet_Tool_V2,
}
Event_Zwp_Tablet_Seat_V2_Pad_Added :: struct {
	id: Zwp_Tablet_Pad_V2,
}
Event_Zwp_Tablet_Tool_V2_Type :: struct {
	tool_type: Zwp_Tablet_Tool_V2_Type,
}
Event_Zwp_Tablet_Tool_V2_Hardware_Serial :: struct {
	hardware_serial_hi: u32,
	hardware_serial_lo: u32,
}
Event_Zwp_Tablet_Tool_V2_Hardware_Id_Wacom :: struct {
	hardware_id_hi: u32,
	hardware_id_lo: u32,
}
Event_Zwp_Tablet_Tool_V2_Capability :: struct {
	capability: Zwp_Tablet_Tool_V2_Capability,
}
Event_Zwp_Tablet_Tool_V2_Done :: struct {
}
Event_Zwp_Tablet_Tool_V2_Removed :: struct {
}
Event_Zwp_Tablet_Tool_V2_Proximity_In :: struct {
	serial: u32,
	tablet: Zwp_Tablet_V2,
	surface: Surface,
}
Event_Zwp_Tablet_Tool_V2_Proximity_Out :: struct {
}
Event_Zwp_Tablet_Tool_V2_Down :: struct {
	serial: u32,
}
Event_Zwp_Tablet_Tool_V2_Up :: struct {
}
Event_Zwp_Tablet_Tool_V2_Motion :: struct {
	x: f64,
	y: f64,
}
Event_Zwp_Tablet_Tool_V2_Pressure :: struct {
	pressure: u32,
}
Event_Zwp_Tablet_Tool_V2_Distance :: struct {
	distance: u32,
}
Event_Zwp_Tablet_Tool_V2_Tilt :: struct {
	tilt_x: f64,
	tilt_y: f64,
}
Event_Zwp_Tablet_Tool_V2_Rotation :: struct {
	degrees: f64,
}
Event_Zwp_Tablet_Tool_V2_Slider :: struct {
	position: i32,
}
Event_Zwp_Tablet_Tool_V2_Wheel :: struct {
	degrees: f64,
	clicks: i32,
}
Event_Zwp_Tablet_Tool_V2_Button :: struct {
	serial: u32,
	button: u32,
	state: Zwp_Tablet_Tool_V2_Button_State,
}
Event_Zwp_Tablet_Tool_V2_Frame :: struct {
	time: u32,
}
Event_Zwp_Tablet_V2_Name :: struct {
	name: string,
}
Event_Zwp_Tablet_V2_Id :: struct {
	vid: u32,
	pid: u32,
}
Event_Zwp_Tablet_V2_Path :: struct {
	path: string,
}
Event_Zwp_Tablet_V2_Done :: struct {
}
Event_Zwp_Tablet_V2_Removed :: struct {
}
Event_Zwp_Tablet_V2_Bustype :: struct {
	bustype: Zwp_Tablet_V2_Bustype,
}
Event_Zwp_Tablet_Pad_Ring_V2_Source :: struct {
	source: Zwp_Tablet_Pad_Ring_V2_Source,
}
Event_Zwp_Tablet_Pad_Ring_V2_Angle :: struct {
	degrees: f64,
}
Event_Zwp_Tablet_Pad_Ring_V2_Stop :: struct {
}
Event_Zwp_Tablet_Pad_Ring_V2_Frame :: struct {
	time: u32,
}
Event_Zwp_Tablet_Pad_Strip_V2_Source :: struct {
	source: Zwp_Tablet_Pad_Strip_V2_Source,
}
Event_Zwp_Tablet_Pad_Strip_V2_Position :: struct {
	position: u32,
}
Event_Zwp_Tablet_Pad_Strip_V2_Stop :: struct {
}
Event_Zwp_Tablet_Pad_Strip_V2_Frame :: struct {
	time: u32,
}
Event_Zwp_Tablet_Pad_Group_V2_Buttons :: struct {
	buttons: []byte,
}
Event_Zwp_Tablet_Pad_Group_V2_Ring :: struct {
	ring: Zwp_Tablet_Pad_Ring_V2,
}
Event_Zwp_Tablet_Pad_Group_V2_Strip :: struct {
	strip: Zwp_Tablet_Pad_Strip_V2,
}
Event_Zwp_Tablet_Pad_Group_V2_Modes :: struct {
	modes: u32,
}
Event_Zwp_Tablet_Pad_Group_V2_Done :: struct {
}
Event_Zwp_Tablet_Pad_Group_V2_Mode_Switch :: struct {
	time: u32,
	serial: u32,
	mode: u32,
}
Event_Zwp_Tablet_Pad_Group_V2_Dial :: struct {
	dial: Zwp_Tablet_Pad_Dial_V2,
}
Event_Zwp_Tablet_Pad_V2_Group :: struct {
	pad_group: Zwp_Tablet_Pad_Group_V2,
}
Event_Zwp_Tablet_Pad_V2_Path :: struct {
	path: string,
}
Event_Zwp_Tablet_Pad_V2_Buttons :: struct {
	buttons: u32,
}
Event_Zwp_Tablet_Pad_V2_Done :: struct {
}
Event_Zwp_Tablet_Pad_V2_Button :: struct {
	time: u32,
	button: u32,
	state: Zwp_Tablet_Pad_V2_Button_State,
}
Event_Zwp_Tablet_Pad_V2_Enter :: struct {
	serial: u32,
	tablet: Zwp_Tablet_V2,
	surface: Surface,
}
Event_Zwp_Tablet_Pad_V2_Leave :: struct {
	serial: u32,
	surface: Surface,
}
Event_Zwp_Tablet_Pad_V2_Removed :: struct {
}
Event_Zwp_Tablet_Pad_Dial_V2_Delta :: struct {
	value120: i32,
}
Event_Zwp_Tablet_Pad_Dial_V2_Frame :: struct {
	time: u32,
}
Event_Xdg_Wm_Base_Ping :: struct {
	serial: u32,
}
Event_Xdg_Surface_Configure :: struct {
	serial: u32,
}
Event_Xdg_Toplevel_Configure :: struct {
	width: i32,
	height: i32,
	states: []byte,
}
Event_Xdg_Toplevel_Close :: struct {
}
Event_Xdg_Toplevel_Configure_Bounds :: struct {
	width: i32,
	height: i32,
}
Event_Xdg_Toplevel_Wm_Capabilities :: struct {
	capabilities: []byte,
}
Event_Xdg_Popup_Configure :: struct {
	x: i32,
	y: i32,
	width: i32,
	height: i32,
}
Event_Xdg_Popup_Popup_Done :: struct {
}
Event_Xdg_Popup_Repositioned :: struct {
	token: u32,
}
Event_Wp_Color_Manager_V1_Supported_Intent :: struct {
	render_intent: Wp_Color_Manager_V1_Render_Intent,
}
Event_Wp_Color_Manager_V1_Supported_Feature :: struct {
	feature: Wp_Color_Manager_V1_Feature,
}
Event_Wp_Color_Manager_V1_Supported_Tf_Named :: struct {
	tf: Wp_Color_Manager_V1_Transfer_Function,
}
Event_Wp_Color_Manager_V1_Supported_Primaries_Named :: struct {
	primaries: Wp_Color_Manager_V1_Primaries,
}
Event_Wp_Color_Manager_V1_Done :: struct {
}
Event_Wp_Color_Management_Output_V1_Image_Description_Changed :: struct {
}
Event_Wp_Color_Management_Surface_Feedback_V1_Preferred_Changed :: struct {
	identity: u32,
}
Event_Wp_Image_Description_V1_Failed :: struct {
	cause: Wp_Image_Description_V1_Cause,
	msg: string,
}
Event_Wp_Image_Description_V1_Ready :: struct {
	identity: u32,
}
Event_Wp_Image_Description_Info_V1_Done :: struct {
}
Event_Wp_Image_Description_Info_V1_Icc_File :: struct {
	icc: Fd,
	icc_size: u32,
}
Event_Wp_Image_Description_Info_V1_Primaries :: struct {
	r_x: i32,
	r_y: i32,
	g_x: i32,
	g_y: i32,
	b_x: i32,
	b_y: i32,
	w_x: i32,
	w_y: i32,
}
Event_Wp_Image_Description_Info_V1_Primaries_Named :: struct {
	primaries: Wp_Color_Manager_V1_Primaries,
}
Event_Wp_Image_Description_Info_V1_Tf_Power :: struct {
	eexp: u32,
}
Event_Wp_Image_Description_Info_V1_Tf_Named :: struct {
	tf: Wp_Color_Manager_V1_Transfer_Function,
}
Event_Wp_Image_Description_Info_V1_Luminances :: struct {
	min_lum: u32,
	max_lum: u32,
	reference_lum: u32,
}
Event_Wp_Image_Description_Info_V1_Target_Primaries :: struct {
	r_x: i32,
	r_y: i32,
	g_x: i32,
	g_y: i32,
	b_x: i32,
	b_y: i32,
	w_x: i32,
	w_y: i32,
}
Event_Wp_Image_Description_Info_V1_Target_Luminance :: struct {
	min_lum: u32,
	max_lum: u32,
}
Event_Wp_Image_Description_Info_V1_Target_Max_Cll :: struct {
	max_cll: u32,
}
Event_Wp_Image_Description_Info_V1_Target_Max_Fall :: struct {
	max_fall: u32,
}
Event_Wp_Color_Representation_Manager_V1_Supported_Alpha_Mode :: struct {
	alpha_mode: Wp_Color_Representation_Surface_V1_Alpha_Mode,
}
Event_Wp_Color_Representation_Manager_V1_Supported_Coefficients_And_Ranges :: struct {
	coefficients: Wp_Color_Representation_Surface_V1_Coefficients,
	range: Wp_Color_Representation_Surface_V1_Range,
}
Event_Wp_Color_Representation_Manager_V1_Done :: struct {
}
Event_Wp_Drm_Lease_Device_V1_Drm_Fd :: struct {
	fd: Fd,
}
Event_Wp_Drm_Lease_Device_V1_Connector :: struct {
	id: Wp_Drm_Lease_Connector_V1,
}
Event_Wp_Drm_Lease_Device_V1_Done :: struct {
}
Event_Wp_Drm_Lease_Device_V1_Released :: struct {
}
Event_Wp_Drm_Lease_Connector_V1_Name :: struct {
	name: string,
}
Event_Wp_Drm_Lease_Connector_V1_Description :: struct {
	description: string,
}
Event_Wp_Drm_Lease_Connector_V1_Connector_Id :: struct {
	connector_id: u32,
}
Event_Wp_Drm_Lease_Connector_V1_Done :: struct {
}
Event_Wp_Drm_Lease_Connector_V1_Withdrawn :: struct {
}
Event_Wp_Drm_Lease_V1_Lease_Fd :: struct {
	leased_fd: Fd,
}
Event_Wp_Drm_Lease_V1_Finished :: struct {
}
Event_Ext_Background_Effect_Manager_V1_Capabilities :: struct {
	flags: Ext_Background_Effect_Manager_V1_Capability,
}
Event_Ext_Data_Control_Device_V1_Data_Offer :: struct {
	id: Ext_Data_Control_Offer_V1,
}
Event_Ext_Data_Control_Device_V1_Selection :: struct {
	id: Ext_Data_Control_Offer_V1,
}
Event_Ext_Data_Control_Device_V1_Finished :: struct {
}
Event_Ext_Data_Control_Device_V1_Primary_Selection :: struct {
	id: Ext_Data_Control_Offer_V1,
}
Event_Ext_Data_Control_Source_V1_Send :: struct {
	mime_type: string,
	fd: Fd,
}
Event_Ext_Data_Control_Source_V1_Cancelled :: struct {
}
Event_Ext_Data_Control_Offer_V1_Offer :: struct {
	mime_type: string,
}
Event_Ext_Foreign_Toplevel_List_V1_Toplevel :: struct {
	toplevel: Ext_Foreign_Toplevel_Handle_V1,
}
Event_Ext_Foreign_Toplevel_List_V1_Finished :: struct {
}
Event_Ext_Foreign_Toplevel_Handle_V1_Closed :: struct {
}
Event_Ext_Foreign_Toplevel_Handle_V1_Done :: struct {
}
Event_Ext_Foreign_Toplevel_Handle_V1_Title :: struct {
	title: string,
}
Event_Ext_Foreign_Toplevel_Handle_V1_App_Id :: struct {
	app_id: string,
}
Event_Ext_Foreign_Toplevel_Handle_V1_Identifier :: struct {
	identifier: string,
}
Event_Ext_Idle_Notification_V1_Idled :: struct {
}
Event_Ext_Idle_Notification_V1_Resumed :: struct {
}
Event_Ext_Image_Copy_Capture_Session_V1_Buffer_Size :: struct {
	width: u32,
	height: u32,
}
Event_Ext_Image_Copy_Capture_Session_V1_Shm_Format :: struct {
	format: Shm_Format,
}
Event_Ext_Image_Copy_Capture_Session_V1_Dmabuf_Device :: struct {
	device: []byte,
}
Event_Ext_Image_Copy_Capture_Session_V1_Dmabuf_Format :: struct {
	format: u32,
	modifiers: []byte,
}
Event_Ext_Image_Copy_Capture_Session_V1_Done :: struct {
}
Event_Ext_Image_Copy_Capture_Session_V1_Stopped :: struct {
}
Event_Ext_Image_Copy_Capture_Frame_V1_Transform :: struct {
	transform: Output_Transform,
}
Event_Ext_Image_Copy_Capture_Frame_V1_Damage :: struct {
	x: i32,
	y: i32,
	width: i32,
	height: i32,
}
Event_Ext_Image_Copy_Capture_Frame_V1_Presentation_Time :: struct {
	tv_sec_hi: u32,
	tv_sec_lo: u32,
	tv_nsec: u32,
}
Event_Ext_Image_Copy_Capture_Frame_V1_Ready :: struct {
}
Event_Ext_Image_Copy_Capture_Frame_V1_Failed :: struct {
	reason: Ext_Image_Copy_Capture_Frame_V1_Failure_Reason,
}
Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Enter :: struct {
}
Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Leave :: struct {
}
Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Position :: struct {
	x: i32,
	y: i32,
}
Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Hotspot :: struct {
	x: i32,
	y: i32,
}
Event_Ext_Session_Lock_V1_Locked :: struct {
}
Event_Ext_Session_Lock_V1_Finished :: struct {
}
Event_Ext_Session_Lock_Surface_V1_Configure :: struct {
	serial: u32,
	width: u32,
	height: u32,
}
Event_Ext_Transient_Seat_V1_Ready :: struct {
	global_name: u32,
}
Event_Ext_Transient_Seat_V1_Denied :: struct {
}
Event_Ext_Workspace_Manager_V1_Workspace_Group :: struct {
	workspace_group: Ext_Workspace_Group_Handle_V1,
}
Event_Ext_Workspace_Manager_V1_Workspace :: struct {
	workspace: Ext_Workspace_Handle_V1,
}
Event_Ext_Workspace_Manager_V1_Done :: struct {
}
Event_Ext_Workspace_Manager_V1_Finished :: struct {
}
Event_Ext_Workspace_Group_Handle_V1_Capabilities :: struct {
	capabilities: Ext_Workspace_Group_Handle_V1_Group_Capabilities,
}
Event_Ext_Workspace_Group_Handle_V1_Output_Enter :: struct {
	output: Output,
}
Event_Ext_Workspace_Group_Handle_V1_Output_Leave :: struct {
	output: Output,
}
Event_Ext_Workspace_Group_Handle_V1_Workspace_Enter :: struct {
	workspace: Ext_Workspace_Handle_V1,
}
Event_Ext_Workspace_Group_Handle_V1_Workspace_Leave :: struct {
	workspace: Ext_Workspace_Handle_V1,
}
Event_Ext_Workspace_Group_Handle_V1_Removed :: struct {
}
Event_Ext_Workspace_Handle_V1_Id :: struct {
	id: string,
}
Event_Ext_Workspace_Handle_V1_Name :: struct {
	name: string,
}
Event_Ext_Workspace_Handle_V1_Coordinates :: struct {
	coordinates: []byte,
}
Event_Ext_Workspace_Handle_V1_State :: struct {
	state: Ext_Workspace_Handle_V1_State,
}
Event_Ext_Workspace_Handle_V1_Capabilities :: struct {
	capabilities: Ext_Workspace_Handle_V1_Workspace_Capabilities,
}
Event_Ext_Workspace_Handle_V1_Removed :: struct {
}
Event_Wp_Fractional_Scale_V1_Preferred_Scale :: struct {
	scale: u32,
}
Event_Xdg_Activation_Token_V1_Done :: struct {
	token: string,
}
Event_Xdg_Toplevel_Icon_Manager_V1_Icon_Size :: struct {
	size: i32,
}
Event_Xdg_Toplevel_Icon_Manager_V1_Done :: struct {
}

parse_wl_display_error :: proc(connection: ^Connection) -> (event: Event_Display_Error, ok: bool) {
	read(connection, &event.object_id) or_return
	read(connection, &event.code) or_return
	read(connection, &event.message) or_return
	ok = true
	return
}
parse_wl_display_delete_id :: proc(connection: ^Connection) -> (event: Event_Display_Delete_Id, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_wl_registry_global :: proc(connection: ^Connection) -> (event: Event_Registry_Global, ok: bool) {
	read(connection, &event.name) or_return
	read(connection, &event.interface) or_return
	read(connection, &event.version) or_return
	ok = true
	return
}
parse_wl_registry_global_remove :: proc(connection: ^Connection) -> (event: Event_Registry_Global_Remove, ok: bool) {
	read(connection, &event.name) or_return
	ok = true
	return
}
parse_wl_callback_done :: proc(connection: ^Connection) -> (event: Event_Callback_Done, ok: bool) {
	read(connection, &event.callback_data) or_return
	ok = true
	return
}
parse_wl_shm_format :: proc(connection: ^Connection) -> (event: Event_Shm_Format, ok: bool) {
	read(connection, &event.format) or_return
	ok = true
	return
}
parse_wl_buffer_release :: proc(connection: ^Connection) -> (event: Event_Buffer_Release, ok: bool) {
	ok = true
	return
}
parse_wl_data_offer_offer :: proc(connection: ^Connection) -> (event: Event_Data_Offer_Offer, ok: bool) {
	read(connection, &event.mime_type) or_return
	ok = true
	return
}
parse_wl_data_offer_source_actions :: proc(connection: ^Connection) -> (event: Event_Data_Offer_Source_Actions, ok: bool) {
	read(connection, &event.source_actions) or_return
	ok = true
	return
}
parse_wl_data_offer_action :: proc(connection: ^Connection) -> (event: Event_Data_Offer_Action, ok: bool) {
	read(connection, &event.dnd_action) or_return
	ok = true
	return
}
parse_wl_data_source_target :: proc(connection: ^Connection) -> (event: Event_Data_Source_Target, ok: bool) {
	read(connection, &event.mime_type) or_return
	ok = true
	return
}
parse_wl_data_source_send :: proc(connection: ^Connection) -> (event: Event_Data_Source_Send, ok: bool) {
	read(connection, &event.mime_type) or_return
	read(connection, &event.fd) or_return
	ok = true
	return
}
parse_wl_data_source_cancelled :: proc(connection: ^Connection) -> (event: Event_Data_Source_Cancelled, ok: bool) {
	ok = true
	return
}
parse_wl_data_source_dnd_drop_performed :: proc(connection: ^Connection) -> (event: Event_Data_Source_Dnd_Drop_Performed, ok: bool) {
	ok = true
	return
}
parse_wl_data_source_dnd_finished :: proc(connection: ^Connection) -> (event: Event_Data_Source_Dnd_Finished, ok: bool) {
	ok = true
	return
}
parse_wl_data_source_action :: proc(connection: ^Connection) -> (event: Event_Data_Source_Action, ok: bool) {
	read(connection, &event.dnd_action) or_return
	ok = true
	return
}
parse_wl_data_device_data_offer :: proc(connection: ^Connection) -> (event: Event_Data_Device_Data_Offer, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_wl_data_device_enter :: proc(connection: ^Connection) -> (event: Event_Data_Device_Enter, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_wl_data_device_leave :: proc(connection: ^Connection) -> (event: Event_Data_Device_Leave, ok: bool) {
	ok = true
	return
}
parse_wl_data_device_motion :: proc(connection: ^Connection) -> (event: Event_Data_Device_Motion, ok: bool) {
	read(connection, &event.time) or_return
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	ok = true
	return
}
parse_wl_data_device_drop :: proc(connection: ^Connection) -> (event: Event_Data_Device_Drop, ok: bool) {
	ok = true
	return
}
parse_wl_data_device_selection :: proc(connection: ^Connection) -> (event: Event_Data_Device_Selection, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_wl_shell_surface_ping :: proc(connection: ^Connection) -> (event: Event_Shell_Surface_Ping, ok: bool) {
	read(connection, &event.serial) or_return
	ok = true
	return
}
parse_wl_shell_surface_configure :: proc(connection: ^Connection) -> (event: Event_Shell_Surface_Configure, ok: bool) {
	read(connection, &event.edges) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	ok = true
	return
}
parse_wl_shell_surface_popup_done :: proc(connection: ^Connection) -> (event: Event_Shell_Surface_Popup_Done, ok: bool) {
	ok = true
	return
}
parse_wl_surface_enter :: proc(connection: ^Connection) -> (event: Event_Surface_Enter, ok: bool) {
	read(connection, &event.output) or_return
	ok = true
	return
}
parse_wl_surface_leave :: proc(connection: ^Connection) -> (event: Event_Surface_Leave, ok: bool) {
	read(connection, &event.output) or_return
	ok = true
	return
}
parse_wl_surface_preferred_buffer_scale :: proc(connection: ^Connection) -> (event: Event_Surface_Preferred_Buffer_Scale, ok: bool) {
	read(connection, &event.factor) or_return
	ok = true
	return
}
parse_wl_surface_preferred_buffer_transform :: proc(connection: ^Connection) -> (event: Event_Surface_Preferred_Buffer_Transform, ok: bool) {
	read(connection, &event.transform) or_return
	ok = true
	return
}
parse_wl_seat_capabilities :: proc(connection: ^Connection) -> (event: Event_Seat_Capabilities, ok: bool) {
	read(connection, &event.capabilities) or_return
	ok = true
	return
}
parse_wl_seat_name :: proc(connection: ^Connection) -> (event: Event_Seat_Name, ok: bool) {
	read(connection, &event.name) or_return
	ok = true
	return
}
parse_wl_pointer_enter :: proc(connection: ^Connection) -> (event: Event_Pointer_Enter, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	read(connection, &event.surface_x) or_return
	read(connection, &event.surface_y) or_return
	ok = true
	return
}
parse_wl_pointer_leave :: proc(connection: ^Connection) -> (event: Event_Pointer_Leave, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	ok = true
	return
}
parse_wl_pointer_motion :: proc(connection: ^Connection) -> (event: Event_Pointer_Motion, ok: bool) {
	read(connection, &event.time) or_return
	read(connection, &event.surface_x) or_return
	read(connection, &event.surface_y) or_return
	ok = true
	return
}
parse_wl_pointer_button :: proc(connection: ^Connection) -> (event: Event_Pointer_Button, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.time) or_return
	read(connection, &event.button) or_return
	read(connection, &event.state) or_return
	ok = true
	return
}
parse_wl_pointer_axis :: proc(connection: ^Connection) -> (event: Event_Pointer_Axis, ok: bool) {
	read(connection, &event.time) or_return
	read(connection, &event.axis) or_return
	read(connection, &event.value) or_return
	ok = true
	return
}
parse_wl_pointer_frame :: proc(connection: ^Connection) -> (event: Event_Pointer_Frame, ok: bool) {
	ok = true
	return
}
parse_wl_pointer_axis_source :: proc(connection: ^Connection) -> (event: Event_Pointer_Axis_Source, ok: bool) {
	read(connection, &event.axis_source) or_return
	ok = true
	return
}
parse_wl_pointer_axis_stop :: proc(connection: ^Connection) -> (event: Event_Pointer_Axis_Stop, ok: bool) {
	read(connection, &event.time) or_return
	read(connection, &event.axis) or_return
	ok = true
	return
}
parse_wl_pointer_axis_discrete :: proc(connection: ^Connection) -> (event: Event_Pointer_Axis_Discrete, ok: bool) {
	read(connection, &event.axis) or_return
	read(connection, &event.discrete) or_return
	ok = true
	return
}
parse_wl_pointer_axis_value120 :: proc(connection: ^Connection) -> (event: Event_Pointer_Axis_Value120, ok: bool) {
	read(connection, &event.axis) or_return
	read(connection, &event.value120) or_return
	ok = true
	return
}
parse_wl_pointer_axis_relative_direction :: proc(connection: ^Connection) -> (event: Event_Pointer_Axis_Relative_Direction, ok: bool) {
	read(connection, &event.axis) or_return
	read(connection, &event.direction) or_return
	ok = true
	return
}
parse_wl_keyboard_keymap :: proc(connection: ^Connection) -> (event: Event_Keyboard_Keymap, ok: bool) {
	read(connection, &event.format) or_return
	read(connection, &event.fd) or_return
	read(connection, &event.size) or_return
	ok = true
	return
}
parse_wl_keyboard_enter :: proc(connection: ^Connection) -> (event: Event_Keyboard_Enter, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	read(connection, &event.keys) or_return
	ok = true
	return
}
parse_wl_keyboard_leave :: proc(connection: ^Connection) -> (event: Event_Keyboard_Leave, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	ok = true
	return
}
parse_wl_keyboard_key :: proc(connection: ^Connection) -> (event: Event_Keyboard_Key, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.time) or_return
	read(connection, &event.key) or_return
	read(connection, &event.state) or_return
	ok = true
	return
}
parse_wl_keyboard_modifiers :: proc(connection: ^Connection) -> (event: Event_Keyboard_Modifiers, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.mods_depressed) or_return
	read(connection, &event.mods_latched) or_return
	read(connection, &event.mods_locked) or_return
	read(connection, &event.group) or_return
	ok = true
	return
}
parse_wl_keyboard_repeat_info :: proc(connection: ^Connection) -> (event: Event_Keyboard_Repeat_Info, ok: bool) {
	read(connection, &event.rate) or_return
	read(connection, &event.delay) or_return
	ok = true
	return
}
parse_wl_touch_down :: proc(connection: ^Connection) -> (event: Event_Touch_Down, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.time) or_return
	read(connection, &event.surface) or_return
	read(connection, &event.id) or_return
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	ok = true
	return
}
parse_wl_touch_up :: proc(connection: ^Connection) -> (event: Event_Touch_Up, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.time) or_return
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_wl_touch_motion :: proc(connection: ^Connection) -> (event: Event_Touch_Motion, ok: bool) {
	read(connection, &event.time) or_return
	read(connection, &event.id) or_return
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	ok = true
	return
}
parse_wl_touch_frame :: proc(connection: ^Connection) -> (event: Event_Touch_Frame, ok: bool) {
	ok = true
	return
}
parse_wl_touch_cancel :: proc(connection: ^Connection) -> (event: Event_Touch_Cancel, ok: bool) {
	ok = true
	return
}
parse_wl_touch_shape :: proc(connection: ^Connection) -> (event: Event_Touch_Shape, ok: bool) {
	read(connection, &event.id) or_return
	read(connection, &event.major) or_return
	read(connection, &event.minor) or_return
	ok = true
	return
}
parse_wl_touch_orientation :: proc(connection: ^Connection) -> (event: Event_Touch_Orientation, ok: bool) {
	read(connection, &event.id) or_return
	read(connection, &event.orientation) or_return
	ok = true
	return
}
parse_wl_output_geometry :: proc(connection: ^Connection) -> (event: Event_Output_Geometry, ok: bool) {
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	read(connection, &event.physical_width) or_return
	read(connection, &event.physical_height) or_return
	read(connection, &event.subpixel) or_return
	read(connection, &event.make) or_return
	read(connection, &event.model) or_return
	read(connection, &event.transform) or_return
	ok = true
	return
}
parse_wl_output_mode :: proc(connection: ^Connection) -> (event: Event_Output_Mode, ok: bool) {
	read(connection, &event.flags) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	read(connection, &event.refresh) or_return
	ok = true
	return
}
parse_wl_output_done :: proc(connection: ^Connection) -> (event: Event_Output_Done, ok: bool) {
	ok = true
	return
}
parse_wl_output_scale :: proc(connection: ^Connection) -> (event: Event_Output_Scale, ok: bool) {
	read(connection, &event.factor) or_return
	ok = true
	return
}
parse_wl_output_name :: proc(connection: ^Connection) -> (event: Event_Output_Name, ok: bool) {
	read(connection, &event.name) or_return
	ok = true
	return
}
parse_wl_output_description :: proc(connection: ^Connection) -> (event: Event_Output_Description, ok: bool) {
	read(connection, &event.description) or_return
	ok = true
	return
}
parse_zwp_linux_dmabuf_v1_format :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_V1_Format, ok: bool) {
	read(connection, &event.format) or_return
	ok = true
	return
}
parse_zwp_linux_dmabuf_v1_modifier :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_V1_Modifier, ok: bool) {
	read(connection, &event.format) or_return
	read(connection, &event.modifier_hi) or_return
	read(connection, &event.modifier_lo) or_return
	ok = true
	return
}
parse_zwp_linux_buffer_params_v1_created :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Buffer_Params_V1_Created, ok: bool) {
	read(connection, &event.buffer) or_return
	ok = true
	return
}
parse_zwp_linux_buffer_params_v1_failed :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Buffer_Params_V1_Failed, ok: bool) {
	ok = true
	return
}
parse_zwp_linux_dmabuf_feedback_v1_done :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_Feedback_V1_Done, ok: bool) {
	ok = true
	return
}
parse_zwp_linux_dmabuf_feedback_v1_format_table :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_Feedback_V1_Format_Table, ok: bool) {
	read(connection, &event.fd) or_return
	read(connection, &event.size) or_return
	ok = true
	return
}
parse_zwp_linux_dmabuf_feedback_v1_main_device :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_Feedback_V1_Main_Device, ok: bool) {
	read(connection, &event.device) or_return
	ok = true
	return
}
parse_zwp_linux_dmabuf_feedback_v1_tranche_done :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Done, ok: bool) {
	ok = true
	return
}
parse_zwp_linux_dmabuf_feedback_v1_tranche_target_device :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Target_Device, ok: bool) {
	read(connection, &event.device) or_return
	ok = true
	return
}
parse_zwp_linux_dmabuf_feedback_v1_tranche_formats :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Formats, ok: bool) {
	read(connection, &event.indices) or_return
	ok = true
	return
}
parse_zwp_linux_dmabuf_feedback_v1_tranche_flags :: proc(connection: ^Connection) -> (event: Event_Zwp_Linux_Dmabuf_Feedback_V1_Tranche_Flags, ok: bool) {
	read(connection, &event.flags) or_return
	ok = true
	return
}
parse_wp_presentation_clock_id :: proc(connection: ^Connection) -> (event: Event_Wp_Presentation_Clock_Id, ok: bool) {
	read(connection, &event.clk_id) or_return
	ok = true
	return
}
parse_wp_presentation_feedback_sync_output :: proc(connection: ^Connection) -> (event: Event_Wp_Presentation_Feedback_Sync_Output, ok: bool) {
	read(connection, &event.output) or_return
	ok = true
	return
}
parse_wp_presentation_feedback_presented :: proc(connection: ^Connection) -> (event: Event_Wp_Presentation_Feedback_Presented, ok: bool) {
	read(connection, &event.tv_sec_hi) or_return
	read(connection, &event.tv_sec_lo) or_return
	read(connection, &event.tv_nsec) or_return
	read(connection, &event.refresh) or_return
	read(connection, &event.seq_hi) or_return
	read(connection, &event.seq_lo) or_return
	read(connection, &event.flags) or_return
	ok = true
	return
}
parse_wp_presentation_feedback_discarded :: proc(connection: ^Connection) -> (event: Event_Wp_Presentation_Feedback_Discarded, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_seat_v2_tablet_added :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Seat_V2_Tablet_Added, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_zwp_tablet_seat_v2_tool_added :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Seat_V2_Tool_Added, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_zwp_tablet_seat_v2_pad_added :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Seat_V2_Pad_Added, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_type :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Type, ok: bool) {
	read(connection, &event.tool_type) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_hardware_serial :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Hardware_Serial, ok: bool) {
	read(connection, &event.hardware_serial_hi) or_return
	read(connection, &event.hardware_serial_lo) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_hardware_id_wacom :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Hardware_Id_Wacom, ok: bool) {
	read(connection, &event.hardware_id_hi) or_return
	read(connection, &event.hardware_id_lo) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_capability :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Capability, ok: bool) {
	read(connection, &event.capability) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_done :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Done, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_tool_v2_removed :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Removed, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_tool_v2_proximity_in :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Proximity_In, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.tablet) or_return
	read(connection, &event.surface) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_proximity_out :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Proximity_Out, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_tool_v2_down :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Down, ok: bool) {
	read(connection, &event.serial) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_up :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Up, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_tool_v2_motion :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Motion, ok: bool) {
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_pressure :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Pressure, ok: bool) {
	read(connection, &event.pressure) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_distance :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Distance, ok: bool) {
	read(connection, &event.distance) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_tilt :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Tilt, ok: bool) {
	read(connection, &event.tilt_x) or_return
	read(connection, &event.tilt_y) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_rotation :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Rotation, ok: bool) {
	read(connection, &event.degrees) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_slider :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Slider, ok: bool) {
	read(connection, &event.position) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_wheel :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Wheel, ok: bool) {
	read(connection, &event.degrees) or_return
	read(connection, &event.clicks) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_button :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Button, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.button) or_return
	read(connection, &event.state) or_return
	ok = true
	return
}
parse_zwp_tablet_tool_v2_frame :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Tool_V2_Frame, ok: bool) {
	read(connection, &event.time) or_return
	ok = true
	return
}
parse_zwp_tablet_v2_name :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_V2_Name, ok: bool) {
	read(connection, &event.name) or_return
	ok = true
	return
}
parse_zwp_tablet_v2_id :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_V2_Id, ok: bool) {
	read(connection, &event.vid) or_return
	read(connection, &event.pid) or_return
	ok = true
	return
}
parse_zwp_tablet_v2_path :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_V2_Path, ok: bool) {
	read(connection, &event.path) or_return
	ok = true
	return
}
parse_zwp_tablet_v2_done :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_V2_Done, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_v2_removed :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_V2_Removed, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_v2_bustype :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_V2_Bustype, ok: bool) {
	read(connection, &event.bustype) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_ring_v2_source :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Ring_V2_Source, ok: bool) {
	read(connection, &event.source) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_ring_v2_angle :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Ring_V2_Angle, ok: bool) {
	read(connection, &event.degrees) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_ring_v2_stop :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Ring_V2_Stop, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_pad_ring_v2_frame :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Ring_V2_Frame, ok: bool) {
	read(connection, &event.time) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_strip_v2_source :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Strip_V2_Source, ok: bool) {
	read(connection, &event.source) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_strip_v2_position :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Strip_V2_Position, ok: bool) {
	read(connection, &event.position) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_strip_v2_stop :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Strip_V2_Stop, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_pad_strip_v2_frame :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Strip_V2_Frame, ok: bool) {
	read(connection, &event.time) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_group_v2_buttons :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Group_V2_Buttons, ok: bool) {
	read(connection, &event.buttons) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_group_v2_ring :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Group_V2_Ring, ok: bool) {
	read(connection, &event.ring) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_group_v2_strip :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Group_V2_Strip, ok: bool) {
	read(connection, &event.strip) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_group_v2_modes :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Group_V2_Modes, ok: bool) {
	read(connection, &event.modes) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_group_v2_done :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Group_V2_Done, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_pad_group_v2_mode_switch :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Group_V2_Mode_Switch, ok: bool) {
	read(connection, &event.time) or_return
	read(connection, &event.serial) or_return
	read(connection, &event.mode) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_group_v2_dial :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Group_V2_Dial, ok: bool) {
	read(connection, &event.dial) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_v2_group :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_V2_Group, ok: bool) {
	read(connection, &event.pad_group) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_v2_path :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_V2_Path, ok: bool) {
	read(connection, &event.path) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_v2_buttons :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_V2_Buttons, ok: bool) {
	read(connection, &event.buttons) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_v2_done :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_V2_Done, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_pad_v2_button :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_V2_Button, ok: bool) {
	read(connection, &event.time) or_return
	read(connection, &event.button) or_return
	read(connection, &event.state) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_v2_enter :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_V2_Enter, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.tablet) or_return
	read(connection, &event.surface) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_v2_leave :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_V2_Leave, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.surface) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_v2_removed :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_V2_Removed, ok: bool) {
	ok = true
	return
}
parse_zwp_tablet_pad_dial_v2_delta :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Dial_V2_Delta, ok: bool) {
	read(connection, &event.value120) or_return
	ok = true
	return
}
parse_zwp_tablet_pad_dial_v2_frame :: proc(connection: ^Connection) -> (event: Event_Zwp_Tablet_Pad_Dial_V2_Frame, ok: bool) {
	read(connection, &event.time) or_return
	ok = true
	return
}
parse_xdg_wm_base_ping :: proc(connection: ^Connection) -> (event: Event_Xdg_Wm_Base_Ping, ok: bool) {
	read(connection, &event.serial) or_return
	ok = true
	return
}
parse_xdg_surface_configure :: proc(connection: ^Connection) -> (event: Event_Xdg_Surface_Configure, ok: bool) {
	read(connection, &event.serial) or_return
	ok = true
	return
}
parse_xdg_toplevel_configure :: proc(connection: ^Connection) -> (event: Event_Xdg_Toplevel_Configure, ok: bool) {
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	read(connection, &event.states) or_return
	ok = true
	return
}
parse_xdg_toplevel_close :: proc(connection: ^Connection) -> (event: Event_Xdg_Toplevel_Close, ok: bool) {
	ok = true
	return
}
parse_xdg_toplevel_configure_bounds :: proc(connection: ^Connection) -> (event: Event_Xdg_Toplevel_Configure_Bounds, ok: bool) {
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	ok = true
	return
}
parse_xdg_toplevel_wm_capabilities :: proc(connection: ^Connection) -> (event: Event_Xdg_Toplevel_Wm_Capabilities, ok: bool) {
	read(connection, &event.capabilities) or_return
	ok = true
	return
}
parse_xdg_popup_configure :: proc(connection: ^Connection) -> (event: Event_Xdg_Popup_Configure, ok: bool) {
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	ok = true
	return
}
parse_xdg_popup_popup_done :: proc(connection: ^Connection) -> (event: Event_Xdg_Popup_Popup_Done, ok: bool) {
	ok = true
	return
}
parse_xdg_popup_repositioned :: proc(connection: ^Connection) -> (event: Event_Xdg_Popup_Repositioned, ok: bool) {
	read(connection, &event.token) or_return
	ok = true
	return
}
parse_wp_color_manager_v1_supported_intent :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Manager_V1_Supported_Intent, ok: bool) {
	read(connection, &event.render_intent) or_return
	ok = true
	return
}
parse_wp_color_manager_v1_supported_feature :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Manager_V1_Supported_Feature, ok: bool) {
	read(connection, &event.feature) or_return
	ok = true
	return
}
parse_wp_color_manager_v1_supported_tf_named :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Manager_V1_Supported_Tf_Named, ok: bool) {
	read(connection, &event.tf) or_return
	ok = true
	return
}
parse_wp_color_manager_v1_supported_primaries_named :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Manager_V1_Supported_Primaries_Named, ok: bool) {
	read(connection, &event.primaries) or_return
	ok = true
	return
}
parse_wp_color_manager_v1_done :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Manager_V1_Done, ok: bool) {
	ok = true
	return
}
parse_wp_color_management_output_v1_image_description_changed :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Management_Output_V1_Image_Description_Changed, ok: bool) {
	ok = true
	return
}
parse_wp_color_management_surface_feedback_v1_preferred_changed :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Management_Surface_Feedback_V1_Preferred_Changed, ok: bool) {
	read(connection, &event.identity) or_return
	ok = true
	return
}
parse_wp_image_description_v1_failed :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_V1_Failed, ok: bool) {
	read(connection, &event.cause) or_return
	read(connection, &event.msg) or_return
	ok = true
	return
}
parse_wp_image_description_v1_ready :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_V1_Ready, ok: bool) {
	read(connection, &event.identity) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_done :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Done, ok: bool) {
	ok = true
	return
}
parse_wp_image_description_info_v1_icc_file :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Icc_File, ok: bool) {
	read(connection, &event.icc) or_return
	read(connection, &event.icc_size) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_primaries :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Primaries, ok: bool) {
	read(connection, &event.r_x) or_return
	read(connection, &event.r_y) or_return
	read(connection, &event.g_x) or_return
	read(connection, &event.g_y) or_return
	read(connection, &event.b_x) or_return
	read(connection, &event.b_y) or_return
	read(connection, &event.w_x) or_return
	read(connection, &event.w_y) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_primaries_named :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Primaries_Named, ok: bool) {
	read(connection, &event.primaries) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_tf_power :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Tf_Power, ok: bool) {
	read(connection, &event.eexp) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_tf_named :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Tf_Named, ok: bool) {
	read(connection, &event.tf) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_luminances :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Luminances, ok: bool) {
	read(connection, &event.min_lum) or_return
	read(connection, &event.max_lum) or_return
	read(connection, &event.reference_lum) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_target_primaries :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Target_Primaries, ok: bool) {
	read(connection, &event.r_x) or_return
	read(connection, &event.r_y) or_return
	read(connection, &event.g_x) or_return
	read(connection, &event.g_y) or_return
	read(connection, &event.b_x) or_return
	read(connection, &event.b_y) or_return
	read(connection, &event.w_x) or_return
	read(connection, &event.w_y) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_target_luminance :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Target_Luminance, ok: bool) {
	read(connection, &event.min_lum) or_return
	read(connection, &event.max_lum) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_target_max_cll :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Target_Max_Cll, ok: bool) {
	read(connection, &event.max_cll) or_return
	ok = true
	return
}
parse_wp_image_description_info_v1_target_max_fall :: proc(connection: ^Connection) -> (event: Event_Wp_Image_Description_Info_V1_Target_Max_Fall, ok: bool) {
	read(connection, &event.max_fall) or_return
	ok = true
	return
}
parse_wp_color_representation_manager_v1_supported_alpha_mode :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Representation_Manager_V1_Supported_Alpha_Mode, ok: bool) {
	read(connection, &event.alpha_mode) or_return
	ok = true
	return
}
parse_wp_color_representation_manager_v1_supported_coefficients_and_ranges :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Representation_Manager_V1_Supported_Coefficients_And_Ranges, ok: bool) {
	read(connection, &event.coefficients) or_return
	read(connection, &event.range) or_return
	ok = true
	return
}
parse_wp_color_representation_manager_v1_done :: proc(connection: ^Connection) -> (event: Event_Wp_Color_Representation_Manager_V1_Done, ok: bool) {
	ok = true
	return
}
parse_wp_drm_lease_device_v1_drm_fd :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Device_V1_Drm_Fd, ok: bool) {
	read(connection, &event.fd) or_return
	ok = true
	return
}
parse_wp_drm_lease_device_v1_connector :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Device_V1_Connector, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_wp_drm_lease_device_v1_done :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Device_V1_Done, ok: bool) {
	ok = true
	return
}
parse_wp_drm_lease_device_v1_released :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Device_V1_Released, ok: bool) {
	ok = true
	return
}
parse_wp_drm_lease_connector_v1_name :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Connector_V1_Name, ok: bool) {
	read(connection, &event.name) or_return
	ok = true
	return
}
parse_wp_drm_lease_connector_v1_description :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Connector_V1_Description, ok: bool) {
	read(connection, &event.description) or_return
	ok = true
	return
}
parse_wp_drm_lease_connector_v1_connector_id :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Connector_V1_Connector_Id, ok: bool) {
	read(connection, &event.connector_id) or_return
	ok = true
	return
}
parse_wp_drm_lease_connector_v1_done :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Connector_V1_Done, ok: bool) {
	ok = true
	return
}
parse_wp_drm_lease_connector_v1_withdrawn :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_Connector_V1_Withdrawn, ok: bool) {
	ok = true
	return
}
parse_wp_drm_lease_v1_lease_fd :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_V1_Lease_Fd, ok: bool) {
	read(connection, &event.leased_fd) or_return
	ok = true
	return
}
parse_wp_drm_lease_v1_finished :: proc(connection: ^Connection) -> (event: Event_Wp_Drm_Lease_V1_Finished, ok: bool) {
	ok = true
	return
}
parse_ext_background_effect_manager_v1_capabilities :: proc(connection: ^Connection) -> (event: Event_Ext_Background_Effect_Manager_V1_Capabilities, ok: bool) {
	read(connection, &event.flags) or_return
	ok = true
	return
}
parse_ext_data_control_device_v1_data_offer :: proc(connection: ^Connection) -> (event: Event_Ext_Data_Control_Device_V1_Data_Offer, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_ext_data_control_device_v1_selection :: proc(connection: ^Connection) -> (event: Event_Ext_Data_Control_Device_V1_Selection, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_ext_data_control_device_v1_finished :: proc(connection: ^Connection) -> (event: Event_Ext_Data_Control_Device_V1_Finished, ok: bool) {
	ok = true
	return
}
parse_ext_data_control_device_v1_primary_selection :: proc(connection: ^Connection) -> (event: Event_Ext_Data_Control_Device_V1_Primary_Selection, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_ext_data_control_source_v1_send :: proc(connection: ^Connection) -> (event: Event_Ext_Data_Control_Source_V1_Send, ok: bool) {
	read(connection, &event.mime_type) or_return
	read(connection, &event.fd) or_return
	ok = true
	return
}
parse_ext_data_control_source_v1_cancelled :: proc(connection: ^Connection) -> (event: Event_Ext_Data_Control_Source_V1_Cancelled, ok: bool) {
	ok = true
	return
}
parse_ext_data_control_offer_v1_offer :: proc(connection: ^Connection) -> (event: Event_Ext_Data_Control_Offer_V1_Offer, ok: bool) {
	read(connection, &event.mime_type) or_return
	ok = true
	return
}
parse_ext_foreign_toplevel_list_v1_toplevel :: proc(connection: ^Connection) -> (event: Event_Ext_Foreign_Toplevel_List_V1_Toplevel, ok: bool) {
	read(connection, &event.toplevel) or_return
	ok = true
	return
}
parse_ext_foreign_toplevel_list_v1_finished :: proc(connection: ^Connection) -> (event: Event_Ext_Foreign_Toplevel_List_V1_Finished, ok: bool) {
	ok = true
	return
}
parse_ext_foreign_toplevel_handle_v1_closed :: proc(connection: ^Connection) -> (event: Event_Ext_Foreign_Toplevel_Handle_V1_Closed, ok: bool) {
	ok = true
	return
}
parse_ext_foreign_toplevel_handle_v1_done :: proc(connection: ^Connection) -> (event: Event_Ext_Foreign_Toplevel_Handle_V1_Done, ok: bool) {
	ok = true
	return
}
parse_ext_foreign_toplevel_handle_v1_title :: proc(connection: ^Connection) -> (event: Event_Ext_Foreign_Toplevel_Handle_V1_Title, ok: bool) {
	read(connection, &event.title) or_return
	ok = true
	return
}
parse_ext_foreign_toplevel_handle_v1_app_id :: proc(connection: ^Connection) -> (event: Event_Ext_Foreign_Toplevel_Handle_V1_App_Id, ok: bool) {
	read(connection, &event.app_id) or_return
	ok = true
	return
}
parse_ext_foreign_toplevel_handle_v1_identifier :: proc(connection: ^Connection) -> (event: Event_Ext_Foreign_Toplevel_Handle_V1_Identifier, ok: bool) {
	read(connection, &event.identifier) or_return
	ok = true
	return
}
parse_ext_idle_notification_v1_idled :: proc(connection: ^Connection) -> (event: Event_Ext_Idle_Notification_V1_Idled, ok: bool) {
	ok = true
	return
}
parse_ext_idle_notification_v1_resumed :: proc(connection: ^Connection) -> (event: Event_Ext_Idle_Notification_V1_Resumed, ok: bool) {
	ok = true
	return
}
parse_ext_image_copy_capture_session_v1_buffer_size :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Session_V1_Buffer_Size, ok: bool) {
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_session_v1_shm_format :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Session_V1_Shm_Format, ok: bool) {
	read(connection, &event.format) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_session_v1_dmabuf_device :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Session_V1_Dmabuf_Device, ok: bool) {
	read(connection, &event.device) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_session_v1_dmabuf_format :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Session_V1_Dmabuf_Format, ok: bool) {
	read(connection, &event.format) or_return
	read(connection, &event.modifiers) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_session_v1_done :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Session_V1_Done, ok: bool) {
	ok = true
	return
}
parse_ext_image_copy_capture_session_v1_stopped :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Session_V1_Stopped, ok: bool) {
	ok = true
	return
}
parse_ext_image_copy_capture_frame_v1_transform :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Frame_V1_Transform, ok: bool) {
	read(connection, &event.transform) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_frame_v1_damage :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Frame_V1_Damage, ok: bool) {
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_frame_v1_presentation_time :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Frame_V1_Presentation_Time, ok: bool) {
	read(connection, &event.tv_sec_hi) or_return
	read(connection, &event.tv_sec_lo) or_return
	read(connection, &event.tv_nsec) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_frame_v1_ready :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Frame_V1_Ready, ok: bool) {
	ok = true
	return
}
parse_ext_image_copy_capture_frame_v1_failed :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Frame_V1_Failed, ok: bool) {
	read(connection, &event.reason) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_cursor_session_v1_enter :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Enter, ok: bool) {
	ok = true
	return
}
parse_ext_image_copy_capture_cursor_session_v1_leave :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Leave, ok: bool) {
	ok = true
	return
}
parse_ext_image_copy_capture_cursor_session_v1_position :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Position, ok: bool) {
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	ok = true
	return
}
parse_ext_image_copy_capture_cursor_session_v1_hotspot :: proc(connection: ^Connection) -> (event: Event_Ext_Image_Copy_Capture_Cursor_Session_V1_Hotspot, ok: bool) {
	read(connection, &event.x) or_return
	read(connection, &event.y) or_return
	ok = true
	return
}
parse_ext_session_lock_v1_locked :: proc(connection: ^Connection) -> (event: Event_Ext_Session_Lock_V1_Locked, ok: bool) {
	ok = true
	return
}
parse_ext_session_lock_v1_finished :: proc(connection: ^Connection) -> (event: Event_Ext_Session_Lock_V1_Finished, ok: bool) {
	ok = true
	return
}
parse_ext_session_lock_surface_v1_configure :: proc(connection: ^Connection) -> (event: Event_Ext_Session_Lock_Surface_V1_Configure, ok: bool) {
	read(connection, &event.serial) or_return
	read(connection, &event.width) or_return
	read(connection, &event.height) or_return
	ok = true
	return
}
parse_ext_transient_seat_v1_ready :: proc(connection: ^Connection) -> (event: Event_Ext_Transient_Seat_V1_Ready, ok: bool) {
	read(connection, &event.global_name) or_return
	ok = true
	return
}
parse_ext_transient_seat_v1_denied :: proc(connection: ^Connection) -> (event: Event_Ext_Transient_Seat_V1_Denied, ok: bool) {
	ok = true
	return
}
parse_ext_workspace_manager_v1_workspace_group :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Manager_V1_Workspace_Group, ok: bool) {
	read(connection, &event.workspace_group) or_return
	ok = true
	return
}
parse_ext_workspace_manager_v1_workspace :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Manager_V1_Workspace, ok: bool) {
	read(connection, &event.workspace) or_return
	ok = true
	return
}
parse_ext_workspace_manager_v1_done :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Manager_V1_Done, ok: bool) {
	ok = true
	return
}
parse_ext_workspace_manager_v1_finished :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Manager_V1_Finished, ok: bool) {
	ok = true
	return
}
parse_ext_workspace_group_handle_v1_capabilities :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Group_Handle_V1_Capabilities, ok: bool) {
	read(connection, &event.capabilities) or_return
	ok = true
	return
}
parse_ext_workspace_group_handle_v1_output_enter :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Group_Handle_V1_Output_Enter, ok: bool) {
	read(connection, &event.output) or_return
	ok = true
	return
}
parse_ext_workspace_group_handle_v1_output_leave :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Group_Handle_V1_Output_Leave, ok: bool) {
	read(connection, &event.output) or_return
	ok = true
	return
}
parse_ext_workspace_group_handle_v1_workspace_enter :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Group_Handle_V1_Workspace_Enter, ok: bool) {
	read(connection, &event.workspace) or_return
	ok = true
	return
}
parse_ext_workspace_group_handle_v1_workspace_leave :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Group_Handle_V1_Workspace_Leave, ok: bool) {
	read(connection, &event.workspace) or_return
	ok = true
	return
}
parse_ext_workspace_group_handle_v1_removed :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Group_Handle_V1_Removed, ok: bool) {
	ok = true
	return
}
parse_ext_workspace_handle_v1_id :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Handle_V1_Id, ok: bool) {
	read(connection, &event.id) or_return
	ok = true
	return
}
parse_ext_workspace_handle_v1_name :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Handle_V1_Name, ok: bool) {
	read(connection, &event.name) or_return
	ok = true
	return
}
parse_ext_workspace_handle_v1_coordinates :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Handle_V1_Coordinates, ok: bool) {
	read(connection, &event.coordinates) or_return
	ok = true
	return
}
parse_ext_workspace_handle_v1_state :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Handle_V1_State, ok: bool) {
	read(connection, &event.state) or_return
	ok = true
	return
}
parse_ext_workspace_handle_v1_capabilities :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Handle_V1_Capabilities, ok: bool) {
	read(connection, &event.capabilities) or_return
	ok = true
	return
}
parse_ext_workspace_handle_v1_removed :: proc(connection: ^Connection) -> (event: Event_Ext_Workspace_Handle_V1_Removed, ok: bool) {
	ok = true
	return
}
parse_wp_fractional_scale_v1_preferred_scale :: proc(connection: ^Connection) -> (event: Event_Wp_Fractional_Scale_V1_Preferred_Scale, ok: bool) {
	read(connection, &event.scale) or_return
	ok = true
	return
}
parse_xdg_activation_token_v1_done :: proc(connection: ^Connection) -> (event: Event_Xdg_Activation_Token_V1_Done, ok: bool) {
	read(connection, &event.token) or_return
	ok = true
	return
}
parse_xdg_toplevel_icon_manager_v1_icon_size :: proc(connection: ^Connection) -> (event: Event_Xdg_Toplevel_Icon_Manager_V1_Icon_Size, ok: bool) {
	read(connection, &event.size) or_return
	ok = true
	return
}
parse_xdg_toplevel_icon_manager_v1_done :: proc(connection: ^Connection) -> (event: Event_Xdg_Toplevel_Icon_Manager_V1_Done, ok: bool) {
	ok = true
	return
}

parse_event :: proc(connection: ^Connection, object_type: Object_Type, opcode: u32) -> (event: Event, ok: bool) {
	switch (object_type) {
	case .Display:
		switch opcode {
		case 0:
			return parse_wl_display_error(connection)
		case 1:
			return parse_wl_display_delete_id(connection)
		case:
			return
		}
	case .Registry:
		switch opcode {
		case 0:
			return parse_wl_registry_global(connection)
		case 1:
			return parse_wl_registry_global_remove(connection)
		case:
			return
		}
	case .Callback:
		switch opcode {
		case 0:
			return parse_wl_callback_done(connection)
		case:
			return
		}
	case .Compositor:
		switch opcode {
		case:
			return
		}
	case .Shm_Pool:
		switch opcode {
		case:
			return
		}
	case .Shm:
		switch opcode {
		case 0:
			return parse_wl_shm_format(connection)
		case:
			return
		}
	case .Buffer:
		switch opcode {
		case 0:
			return parse_wl_buffer_release(connection)
		case:
			return
		}
	case .Data_Offer:
		switch opcode {
		case 0:
			return parse_wl_data_offer_offer(connection)
		case 1:
			return parse_wl_data_offer_source_actions(connection)
		case 2:
			return parse_wl_data_offer_action(connection)
		case:
			return
		}
	case .Data_Source:
		switch opcode {
		case 0:
			return parse_wl_data_source_target(connection)
		case 1:
			return parse_wl_data_source_send(connection)
		case 2:
			return parse_wl_data_source_cancelled(connection)
		case 3:
			return parse_wl_data_source_dnd_drop_performed(connection)
		case 4:
			return parse_wl_data_source_dnd_finished(connection)
		case 5:
			return parse_wl_data_source_action(connection)
		case:
			return
		}
	case .Data_Device:
		switch opcode {
		case 0:
			return parse_wl_data_device_data_offer(connection)
		case 1:
			return parse_wl_data_device_enter(connection)
		case 2:
			return parse_wl_data_device_leave(connection)
		case 3:
			return parse_wl_data_device_motion(connection)
		case 4:
			return parse_wl_data_device_drop(connection)
		case 5:
			return parse_wl_data_device_selection(connection)
		case:
			return
		}
	case .Data_Device_Manager:
		switch opcode {
		case:
			return
		}
	case .Shell:
		switch opcode {
		case:
			return
		}
	case .Shell_Surface:
		switch opcode {
		case 0:
			return parse_wl_shell_surface_ping(connection)
		case 1:
			return parse_wl_shell_surface_configure(connection)
		case 2:
			return parse_wl_shell_surface_popup_done(connection)
		case:
			return
		}
	case .Surface:
		switch opcode {
		case 0:
			return parse_wl_surface_enter(connection)
		case 1:
			return parse_wl_surface_leave(connection)
		case 2:
			return parse_wl_surface_preferred_buffer_scale(connection)
		case 3:
			return parse_wl_surface_preferred_buffer_transform(connection)
		case:
			return
		}
	case .Seat:
		switch opcode {
		case 0:
			return parse_wl_seat_capabilities(connection)
		case 1:
			return parse_wl_seat_name(connection)
		case:
			return
		}
	case .Pointer:
		switch opcode {
		case 0:
			return parse_wl_pointer_enter(connection)
		case 1:
			return parse_wl_pointer_leave(connection)
		case 2:
			return parse_wl_pointer_motion(connection)
		case 3:
			return parse_wl_pointer_button(connection)
		case 4:
			return parse_wl_pointer_axis(connection)
		case 5:
			return parse_wl_pointer_frame(connection)
		case 6:
			return parse_wl_pointer_axis_source(connection)
		case 7:
			return parse_wl_pointer_axis_stop(connection)
		case 8:
			return parse_wl_pointer_axis_discrete(connection)
		case 9:
			return parse_wl_pointer_axis_value120(connection)
		case 10:
			return parse_wl_pointer_axis_relative_direction(connection)
		case:
			return
		}
	case .Keyboard:
		switch opcode {
		case 0:
			return parse_wl_keyboard_keymap(connection)
		case 1:
			return parse_wl_keyboard_enter(connection)
		case 2:
			return parse_wl_keyboard_leave(connection)
		case 3:
			return parse_wl_keyboard_key(connection)
		case 4:
			return parse_wl_keyboard_modifiers(connection)
		case 5:
			return parse_wl_keyboard_repeat_info(connection)
		case:
			return
		}
	case .Touch:
		switch opcode {
		case 0:
			return parse_wl_touch_down(connection)
		case 1:
			return parse_wl_touch_up(connection)
		case 2:
			return parse_wl_touch_motion(connection)
		case 3:
			return parse_wl_touch_frame(connection)
		case 4:
			return parse_wl_touch_cancel(connection)
		case 5:
			return parse_wl_touch_shape(connection)
		case 6:
			return parse_wl_touch_orientation(connection)
		case:
			return
		}
	case .Output:
		switch opcode {
		case 0:
			return parse_wl_output_geometry(connection)
		case 1:
			return parse_wl_output_mode(connection)
		case 2:
			return parse_wl_output_done(connection)
		case 3:
			return parse_wl_output_scale(connection)
		case 4:
			return parse_wl_output_name(connection)
		case 5:
			return parse_wl_output_description(connection)
		case:
			return
		}
	case .Region:
		switch opcode {
		case:
			return
		}
	case .Subcompositor:
		switch opcode {
		case:
			return
		}
	case .Subsurface:
		switch opcode {
		case:
			return
		}
	case .Fixes:
		switch opcode {
		case:
			return
		}
	case .Zwp_Linux_Dmabuf_V1:
		switch opcode {
		case 0:
			return parse_zwp_linux_dmabuf_v1_format(connection)
		case 1:
			return parse_zwp_linux_dmabuf_v1_modifier(connection)
		case:
			return
		}
	case .Zwp_Linux_Buffer_Params_V1:
		switch opcode {
		case 0:
			return parse_zwp_linux_buffer_params_v1_created(connection)
		case 1:
			return parse_zwp_linux_buffer_params_v1_failed(connection)
		case:
			return
		}
	case .Zwp_Linux_Dmabuf_Feedback_V1:
		switch opcode {
		case 0:
			return parse_zwp_linux_dmabuf_feedback_v1_done(connection)
		case 1:
			return parse_zwp_linux_dmabuf_feedback_v1_format_table(connection)
		case 2:
			return parse_zwp_linux_dmabuf_feedback_v1_main_device(connection)
		case 3:
			return parse_zwp_linux_dmabuf_feedback_v1_tranche_done(connection)
		case 4:
			return parse_zwp_linux_dmabuf_feedback_v1_tranche_target_device(connection)
		case 5:
			return parse_zwp_linux_dmabuf_feedback_v1_tranche_formats(connection)
		case 6:
			return parse_zwp_linux_dmabuf_feedback_v1_tranche_flags(connection)
		case:
			return
		}
	case .Wp_Presentation:
		switch opcode {
		case 0:
			return parse_wp_presentation_clock_id(connection)
		case:
			return
		}
	case .Wp_Presentation_Feedback:
		switch opcode {
		case 0:
			return parse_wp_presentation_feedback_sync_output(connection)
		case 1:
			return parse_wp_presentation_feedback_presented(connection)
		case 2:
			return parse_wp_presentation_feedback_discarded(connection)
		case:
			return
		}
	case .Zwp_Tablet_Manager_V2:
		switch opcode {
		case:
			return
		}
	case .Zwp_Tablet_Seat_V2:
		switch opcode {
		case 0:
			return parse_zwp_tablet_seat_v2_tablet_added(connection)
		case 1:
			return parse_zwp_tablet_seat_v2_tool_added(connection)
		case 2:
			return parse_zwp_tablet_seat_v2_pad_added(connection)
		case:
			return
		}
	case .Zwp_Tablet_Tool_V2:
		switch opcode {
		case 0:
			return parse_zwp_tablet_tool_v2_type(connection)
		case 1:
			return parse_zwp_tablet_tool_v2_hardware_serial(connection)
		case 2:
			return parse_zwp_tablet_tool_v2_hardware_id_wacom(connection)
		case 3:
			return parse_zwp_tablet_tool_v2_capability(connection)
		case 4:
			return parse_zwp_tablet_tool_v2_done(connection)
		case 5:
			return parse_zwp_tablet_tool_v2_removed(connection)
		case 6:
			return parse_zwp_tablet_tool_v2_proximity_in(connection)
		case 7:
			return parse_zwp_tablet_tool_v2_proximity_out(connection)
		case 8:
			return parse_zwp_tablet_tool_v2_down(connection)
		case 9:
			return parse_zwp_tablet_tool_v2_up(connection)
		case 10:
			return parse_zwp_tablet_tool_v2_motion(connection)
		case 11:
			return parse_zwp_tablet_tool_v2_pressure(connection)
		case 12:
			return parse_zwp_tablet_tool_v2_distance(connection)
		case 13:
			return parse_zwp_tablet_tool_v2_tilt(connection)
		case 14:
			return parse_zwp_tablet_tool_v2_rotation(connection)
		case 15:
			return parse_zwp_tablet_tool_v2_slider(connection)
		case 16:
			return parse_zwp_tablet_tool_v2_wheel(connection)
		case 17:
			return parse_zwp_tablet_tool_v2_button(connection)
		case 18:
			return parse_zwp_tablet_tool_v2_frame(connection)
		case:
			return
		}
	case .Zwp_Tablet_V2:
		switch opcode {
		case 0:
			return parse_zwp_tablet_v2_name(connection)
		case 1:
			return parse_zwp_tablet_v2_id(connection)
		case 2:
			return parse_zwp_tablet_v2_path(connection)
		case 3:
			return parse_zwp_tablet_v2_done(connection)
		case 4:
			return parse_zwp_tablet_v2_removed(connection)
		case 5:
			return parse_zwp_tablet_v2_bustype(connection)
		case:
			return
		}
	case .Zwp_Tablet_Pad_Ring_V2:
		switch opcode {
		case 0:
			return parse_zwp_tablet_pad_ring_v2_source(connection)
		case 1:
			return parse_zwp_tablet_pad_ring_v2_angle(connection)
		case 2:
			return parse_zwp_tablet_pad_ring_v2_stop(connection)
		case 3:
			return parse_zwp_tablet_pad_ring_v2_frame(connection)
		case:
			return
		}
	case .Zwp_Tablet_Pad_Strip_V2:
		switch opcode {
		case 0:
			return parse_zwp_tablet_pad_strip_v2_source(connection)
		case 1:
			return parse_zwp_tablet_pad_strip_v2_position(connection)
		case 2:
			return parse_zwp_tablet_pad_strip_v2_stop(connection)
		case 3:
			return parse_zwp_tablet_pad_strip_v2_frame(connection)
		case:
			return
		}
	case .Zwp_Tablet_Pad_Group_V2:
		switch opcode {
		case 0:
			return parse_zwp_tablet_pad_group_v2_buttons(connection)
		case 1:
			return parse_zwp_tablet_pad_group_v2_ring(connection)
		case 2:
			return parse_zwp_tablet_pad_group_v2_strip(connection)
		case 3:
			return parse_zwp_tablet_pad_group_v2_modes(connection)
		case 4:
			return parse_zwp_tablet_pad_group_v2_done(connection)
		case 5:
			return parse_zwp_tablet_pad_group_v2_mode_switch(connection)
		case 6:
			return parse_zwp_tablet_pad_group_v2_dial(connection)
		case:
			return
		}
	case .Zwp_Tablet_Pad_V2:
		switch opcode {
		case 0:
			return parse_zwp_tablet_pad_v2_group(connection)
		case 1:
			return parse_zwp_tablet_pad_v2_path(connection)
		case 2:
			return parse_zwp_tablet_pad_v2_buttons(connection)
		case 3:
			return parse_zwp_tablet_pad_v2_done(connection)
		case 4:
			return parse_zwp_tablet_pad_v2_button(connection)
		case 5:
			return parse_zwp_tablet_pad_v2_enter(connection)
		case 6:
			return parse_zwp_tablet_pad_v2_leave(connection)
		case 7:
			return parse_zwp_tablet_pad_v2_removed(connection)
		case:
			return
		}
	case .Zwp_Tablet_Pad_Dial_V2:
		switch opcode {
		case 0:
			return parse_zwp_tablet_pad_dial_v2_delta(connection)
		case 1:
			return parse_zwp_tablet_pad_dial_v2_frame(connection)
		case:
			return
		}
	case .Wp_Viewporter:
		switch opcode {
		case:
			return
		}
	case .Wp_Viewport:
		switch opcode {
		case:
			return
		}
	case .Xdg_Wm_Base:
		switch opcode {
		case 0:
			return parse_xdg_wm_base_ping(connection)
		case:
			return
		}
	case .Xdg_Positioner:
		switch opcode {
		case:
			return
		}
	case .Xdg_Surface:
		switch opcode {
		case 0:
			return parse_xdg_surface_configure(connection)
		case:
			return
		}
	case .Xdg_Toplevel:
		switch opcode {
		case 0:
			return parse_xdg_toplevel_configure(connection)
		case 1:
			return parse_xdg_toplevel_close(connection)
		case 2:
			return parse_xdg_toplevel_configure_bounds(connection)
		case 3:
			return parse_xdg_toplevel_wm_capabilities(connection)
		case:
			return
		}
	case .Xdg_Popup:
		switch opcode {
		case 0:
			return parse_xdg_popup_configure(connection)
		case 1:
			return parse_xdg_popup_popup_done(connection)
		case 2:
			return parse_xdg_popup_repositioned(connection)
		case:
			return
		}
	case .Wp_Alpha_Modifier_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Alpha_Modifier_Surface_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Color_Manager_V1:
		switch opcode {
		case 0:
			return parse_wp_color_manager_v1_supported_intent(connection)
		case 1:
			return parse_wp_color_manager_v1_supported_feature(connection)
		case 2:
			return parse_wp_color_manager_v1_supported_tf_named(connection)
		case 3:
			return parse_wp_color_manager_v1_supported_primaries_named(connection)
		case 4:
			return parse_wp_color_manager_v1_done(connection)
		case:
			return
		}
	case .Wp_Color_Management_Output_V1:
		switch opcode {
		case 0:
			return parse_wp_color_management_output_v1_image_description_changed(connection)
		case:
			return
		}
	case .Wp_Color_Management_Surface_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Color_Management_Surface_Feedback_V1:
		switch opcode {
		case 0:
			return parse_wp_color_management_surface_feedback_v1_preferred_changed(connection)
		case:
			return
		}
	case .Wp_Image_Description_Creator_Icc_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Image_Description_Creator_Params_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Image_Description_V1:
		switch opcode {
		case 0:
			return parse_wp_image_description_v1_failed(connection)
		case 1:
			return parse_wp_image_description_v1_ready(connection)
		case:
			return
		}
	case .Wp_Image_Description_Info_V1:
		switch opcode {
		case 0:
			return parse_wp_image_description_info_v1_done(connection)
		case 1:
			return parse_wp_image_description_info_v1_icc_file(connection)
		case 2:
			return parse_wp_image_description_info_v1_primaries(connection)
		case 3:
			return parse_wp_image_description_info_v1_primaries_named(connection)
		case 4:
			return parse_wp_image_description_info_v1_tf_power(connection)
		case 5:
			return parse_wp_image_description_info_v1_tf_named(connection)
		case 6:
			return parse_wp_image_description_info_v1_luminances(connection)
		case 7:
			return parse_wp_image_description_info_v1_target_primaries(connection)
		case 8:
			return parse_wp_image_description_info_v1_target_luminance(connection)
		case 9:
			return parse_wp_image_description_info_v1_target_max_cll(connection)
		case 10:
			return parse_wp_image_description_info_v1_target_max_fall(connection)
		case:
			return
		}
	case .Wp_Color_Representation_Manager_V1:
		switch opcode {
		case 0:
			return parse_wp_color_representation_manager_v1_supported_alpha_mode(connection)
		case 1:
			return parse_wp_color_representation_manager_v1_supported_coefficients_and_ranges(connection)
		case 2:
			return parse_wp_color_representation_manager_v1_done(connection)
		case:
			return
		}
	case .Wp_Color_Representation_Surface_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Commit_Timing_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Commit_Timer_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Content_Type_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Content_Type_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Cursor_Shape_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Cursor_Shape_Device_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Drm_Lease_Device_V1:
		switch opcode {
		case 0:
			return parse_wp_drm_lease_device_v1_drm_fd(connection)
		case 1:
			return parse_wp_drm_lease_device_v1_connector(connection)
		case 2:
			return parse_wp_drm_lease_device_v1_done(connection)
		case 3:
			return parse_wp_drm_lease_device_v1_released(connection)
		case:
			return
		}
	case .Wp_Drm_Lease_Connector_V1:
		switch opcode {
		case 0:
			return parse_wp_drm_lease_connector_v1_name(connection)
		case 1:
			return parse_wp_drm_lease_connector_v1_description(connection)
		case 2:
			return parse_wp_drm_lease_connector_v1_connector_id(connection)
		case 3:
			return parse_wp_drm_lease_connector_v1_done(connection)
		case 4:
			return parse_wp_drm_lease_connector_v1_withdrawn(connection)
		case:
			return
		}
	case .Wp_Drm_Lease_Request_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Drm_Lease_V1:
		switch opcode {
		case 0:
			return parse_wp_drm_lease_v1_lease_fd(connection)
		case 1:
			return parse_wp_drm_lease_v1_finished(connection)
		case:
			return
		}
	case .Ext_Background_Effect_Manager_V1:
		switch opcode {
		case 0:
			return parse_ext_background_effect_manager_v1_capabilities(connection)
		case:
			return
		}
	case .Ext_Background_Effect_Surface_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Data_Control_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Data_Control_Device_V1:
		switch opcode {
		case 0:
			return parse_ext_data_control_device_v1_data_offer(connection)
		case 1:
			return parse_ext_data_control_device_v1_selection(connection)
		case 2:
			return parse_ext_data_control_device_v1_finished(connection)
		case 3:
			return parse_ext_data_control_device_v1_primary_selection(connection)
		case:
			return
		}
	case .Ext_Data_Control_Source_V1:
		switch opcode {
		case 0:
			return parse_ext_data_control_source_v1_send(connection)
		case 1:
			return parse_ext_data_control_source_v1_cancelled(connection)
		case:
			return
		}
	case .Ext_Data_Control_Offer_V1:
		switch opcode {
		case 0:
			return parse_ext_data_control_offer_v1_offer(connection)
		case:
			return
		}
	case .Ext_Foreign_Toplevel_List_V1:
		switch opcode {
		case 0:
			return parse_ext_foreign_toplevel_list_v1_toplevel(connection)
		case 1:
			return parse_ext_foreign_toplevel_list_v1_finished(connection)
		case:
			return
		}
	case .Ext_Foreign_Toplevel_Handle_V1:
		switch opcode {
		case 0:
			return parse_ext_foreign_toplevel_handle_v1_closed(connection)
		case 1:
			return parse_ext_foreign_toplevel_handle_v1_done(connection)
		case 2:
			return parse_ext_foreign_toplevel_handle_v1_title(connection)
		case 3:
			return parse_ext_foreign_toplevel_handle_v1_app_id(connection)
		case 4:
			return parse_ext_foreign_toplevel_handle_v1_identifier(connection)
		case:
			return
		}
	case .Ext_Idle_Notifier_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Idle_Notification_V1:
		switch opcode {
		case 0:
			return parse_ext_idle_notification_v1_idled(connection)
		case 1:
			return parse_ext_idle_notification_v1_resumed(connection)
		case:
			return
		}
	case .Ext_Image_Capture_Source_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Output_Image_Capture_Source_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Foreign_Toplevel_Image_Capture_Source_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Image_Copy_Capture_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Image_Copy_Capture_Session_V1:
		switch opcode {
		case 0:
			return parse_ext_image_copy_capture_session_v1_buffer_size(connection)
		case 1:
			return parse_ext_image_copy_capture_session_v1_shm_format(connection)
		case 2:
			return parse_ext_image_copy_capture_session_v1_dmabuf_device(connection)
		case 3:
			return parse_ext_image_copy_capture_session_v1_dmabuf_format(connection)
		case 4:
			return parse_ext_image_copy_capture_session_v1_done(connection)
		case 5:
			return parse_ext_image_copy_capture_session_v1_stopped(connection)
		case:
			return
		}
	case .Ext_Image_Copy_Capture_Frame_V1:
		switch opcode {
		case 0:
			return parse_ext_image_copy_capture_frame_v1_transform(connection)
		case 1:
			return parse_ext_image_copy_capture_frame_v1_damage(connection)
		case 2:
			return parse_ext_image_copy_capture_frame_v1_presentation_time(connection)
		case 3:
			return parse_ext_image_copy_capture_frame_v1_ready(connection)
		case 4:
			return parse_ext_image_copy_capture_frame_v1_failed(connection)
		case:
			return
		}
	case .Ext_Image_Copy_Capture_Cursor_Session_V1:
		switch opcode {
		case 0:
			return parse_ext_image_copy_capture_cursor_session_v1_enter(connection)
		case 1:
			return parse_ext_image_copy_capture_cursor_session_v1_leave(connection)
		case 2:
			return parse_ext_image_copy_capture_cursor_session_v1_position(connection)
		case 3:
			return parse_ext_image_copy_capture_cursor_session_v1_hotspot(connection)
		case:
			return
		}
	case .Ext_Session_Lock_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Session_Lock_V1:
		switch opcode {
		case 0:
			return parse_ext_session_lock_v1_locked(connection)
		case 1:
			return parse_ext_session_lock_v1_finished(connection)
		case:
			return
		}
	case .Ext_Session_Lock_Surface_V1:
		switch opcode {
		case 0:
			return parse_ext_session_lock_surface_v1_configure(connection)
		case:
			return
		}
	case .Ext_Transient_Seat_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Ext_Transient_Seat_V1:
		switch opcode {
		case 0:
			return parse_ext_transient_seat_v1_ready(connection)
		case 1:
			return parse_ext_transient_seat_v1_denied(connection)
		case:
			return
		}
	case .Ext_Workspace_Manager_V1:
		switch opcode {
		case 0:
			return parse_ext_workspace_manager_v1_workspace_group(connection)
		case 1:
			return parse_ext_workspace_manager_v1_workspace(connection)
		case 2:
			return parse_ext_workspace_manager_v1_done(connection)
		case 3:
			return parse_ext_workspace_manager_v1_finished(connection)
		case:
			return
		}
	case .Ext_Workspace_Group_Handle_V1:
		switch opcode {
		case 0:
			return parse_ext_workspace_group_handle_v1_capabilities(connection)
		case 1:
			return parse_ext_workspace_group_handle_v1_output_enter(connection)
		case 2:
			return parse_ext_workspace_group_handle_v1_output_leave(connection)
		case 3:
			return parse_ext_workspace_group_handle_v1_workspace_enter(connection)
		case 4:
			return parse_ext_workspace_group_handle_v1_workspace_leave(connection)
		case 5:
			return parse_ext_workspace_group_handle_v1_removed(connection)
		case:
			return
		}
	case .Ext_Workspace_Handle_V1:
		switch opcode {
		case 0:
			return parse_ext_workspace_handle_v1_id(connection)
		case 1:
			return parse_ext_workspace_handle_v1_name(connection)
		case 2:
			return parse_ext_workspace_handle_v1_coordinates(connection)
		case 3:
			return parse_ext_workspace_handle_v1_state(connection)
		case 4:
			return parse_ext_workspace_handle_v1_capabilities(connection)
		case 5:
			return parse_ext_workspace_handle_v1_removed(connection)
		case:
			return
		}
	case .Wp_Fifo_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Fifo_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Fractional_Scale_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Fractional_Scale_V1:
		switch opcode {
		case 0:
			return parse_wp_fractional_scale_v1_preferred_scale(connection)
		case:
			return
		}
	case .Wp_Linux_Drm_Syncobj_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Linux_Drm_Syncobj_Timeline_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Linux_Drm_Syncobj_Surface_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Pointer_Warp_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Security_Context_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Security_Context_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Single_Pixel_Buffer_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Tearing_Control_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Tearing_Control_V1:
		switch opcode {
		case:
			return
		}
	case .Xdg_Activation_V1:
		switch opcode {
		case:
			return
		}
	case .Xdg_Activation_Token_V1:
		switch opcode {
		case 0:
			return parse_xdg_activation_token_v1_done(connection)
		case:
			return
		}
	case .Xdg_Wm_Dialog_V1:
		switch opcode {
		case:
			return
		}
	case .Xdg_Dialog_V1:
		switch opcode {
		case:
			return
		}
	case .Xdg_System_Bell_V1:
		switch opcode {
		case:
			return
		}
	case .Xdg_Toplevel_Drag_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Xdg_Toplevel_Drag_V1:
		switch opcode {
		case:
			return
		}
	case .Xdg_Toplevel_Icon_Manager_V1:
		switch opcode {
		case 0:
			return parse_xdg_toplevel_icon_manager_v1_icon_size(connection)
		case 1:
			return parse_xdg_toplevel_icon_manager_v1_done(connection)
		case:
			return
		}
	case .Xdg_Toplevel_Icon_V1:
		switch opcode {
		case:
			return
		}
	case .Xdg_Toplevel_Tag_Manager_V1:
		switch opcode {
		case:
			return
		}
	case .Xwayland_Shell_V1:
		switch opcode {
		case:
			return
		}
	case .Xwayland_Surface_V1:
		switch opcode {
		case:
			return
		}
	case:
		return
	}
}

Object_Type :: enum {
	Display,
	Registry,
	Callback,
	Compositor,
	Shm_Pool,
	Shm,
	Buffer,
	Data_Offer,
	Data_Source,
	Data_Device,
	Data_Device_Manager,
	Shell,
	Shell_Surface,
	Surface,
	Seat,
	Pointer,
	Keyboard,
	Touch,
	Output,
	Region,
	Subcompositor,
	Subsurface,
	Fixes,
	Zwp_Linux_Dmabuf_V1,
	Zwp_Linux_Buffer_Params_V1,
	Zwp_Linux_Dmabuf_Feedback_V1,
	Wp_Presentation,
	Wp_Presentation_Feedback,
	Zwp_Tablet_Manager_V2,
	Zwp_Tablet_Seat_V2,
	Zwp_Tablet_Tool_V2,
	Zwp_Tablet_V2,
	Zwp_Tablet_Pad_Ring_V2,
	Zwp_Tablet_Pad_Strip_V2,
	Zwp_Tablet_Pad_Group_V2,
	Zwp_Tablet_Pad_V2,
	Zwp_Tablet_Pad_Dial_V2,
	Wp_Viewporter,
	Wp_Viewport,
	Xdg_Wm_Base,
	Xdg_Positioner,
	Xdg_Surface,
	Xdg_Toplevel,
	Xdg_Popup,
	Wp_Alpha_Modifier_V1,
	Wp_Alpha_Modifier_Surface_V1,
	Wp_Color_Manager_V1,
	Wp_Color_Management_Output_V1,
	Wp_Color_Management_Surface_V1,
	Wp_Color_Management_Surface_Feedback_V1,
	Wp_Image_Description_Creator_Icc_V1,
	Wp_Image_Description_Creator_Params_V1,
	Wp_Image_Description_V1,
	Wp_Image_Description_Info_V1,
	Wp_Color_Representation_Manager_V1,
	Wp_Color_Representation_Surface_V1,
	Wp_Commit_Timing_Manager_V1,
	Wp_Commit_Timer_V1,
	Wp_Content_Type_Manager_V1,
	Wp_Content_Type_V1,
	Wp_Cursor_Shape_Manager_V1,
	Wp_Cursor_Shape_Device_V1,
	Wp_Drm_Lease_Device_V1,
	Wp_Drm_Lease_Connector_V1,
	Wp_Drm_Lease_Request_V1,
	Wp_Drm_Lease_V1,
	Ext_Background_Effect_Manager_V1,
	Ext_Background_Effect_Surface_V1,
	Ext_Data_Control_Manager_V1,
	Ext_Data_Control_Device_V1,
	Ext_Data_Control_Source_V1,
	Ext_Data_Control_Offer_V1,
	Ext_Foreign_Toplevel_List_V1,
	Ext_Foreign_Toplevel_Handle_V1,
	Ext_Idle_Notifier_V1,
	Ext_Idle_Notification_V1,
	Ext_Image_Capture_Source_V1,
	Ext_Output_Image_Capture_Source_Manager_V1,
	Ext_Foreign_Toplevel_Image_Capture_Source_Manager_V1,
	Ext_Image_Copy_Capture_Manager_V1,
	Ext_Image_Copy_Capture_Session_V1,
	Ext_Image_Copy_Capture_Frame_V1,
	Ext_Image_Copy_Capture_Cursor_Session_V1,
	Ext_Session_Lock_Manager_V1,
	Ext_Session_Lock_V1,
	Ext_Session_Lock_Surface_V1,
	Ext_Transient_Seat_Manager_V1,
	Ext_Transient_Seat_V1,
	Ext_Workspace_Manager_V1,
	Ext_Workspace_Group_Handle_V1,
	Ext_Workspace_Handle_V1,
	Wp_Fifo_Manager_V1,
	Wp_Fifo_V1,
	Wp_Fractional_Scale_Manager_V1,
	Wp_Fractional_Scale_V1,
	Wp_Linux_Drm_Syncobj_Manager_V1,
	Wp_Linux_Drm_Syncobj_Timeline_V1,
	Wp_Linux_Drm_Syncobj_Surface_V1,
	Wp_Pointer_Warp_V1,
	Wp_Security_Context_Manager_V1,
	Wp_Security_Context_V1,
	Wp_Single_Pixel_Buffer_Manager_V1,
	Wp_Tearing_Control_Manager_V1,
	Wp_Tearing_Control_V1,
	Xdg_Activation_V1,
	Xdg_Activation_Token_V1,
	Xdg_Wm_Dialog_V1,
	Xdg_Dialog_V1,
	Xdg_System_Bell_V1,
	Xdg_Toplevel_Drag_Manager_V1,
	Xdg_Toplevel_Drag_V1,
	Xdg_Toplevel_Icon_Manager_V1,
	Xdg_Toplevel_Icon_V1,
	Xdg_Toplevel_Tag_Manager_V1,
	Xwayland_Shell_V1,
	Xwayland_Surface_V1,
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
Zwp_Linux_Dmabuf_V1 :: distinct u32
Zwp_Linux_Buffer_Params_V1 :: distinct u32
Zwp_Linux_Dmabuf_Feedback_V1 :: distinct u32
Wp_Presentation :: distinct u32
Wp_Presentation_Feedback :: distinct u32
Zwp_Tablet_Manager_V2 :: distinct u32
Zwp_Tablet_Seat_V2 :: distinct u32
Zwp_Tablet_Tool_V2 :: distinct u32
Zwp_Tablet_V2 :: distinct u32
Zwp_Tablet_Pad_Ring_V2 :: distinct u32
Zwp_Tablet_Pad_Strip_V2 :: distinct u32
Zwp_Tablet_Pad_Group_V2 :: distinct u32
Zwp_Tablet_Pad_V2 :: distinct u32
Zwp_Tablet_Pad_Dial_V2 :: distinct u32
Wp_Viewporter :: distinct u32
Wp_Viewport :: distinct u32
Xdg_Wm_Base :: distinct u32
Xdg_Positioner :: distinct u32
Xdg_Surface :: distinct u32
Xdg_Toplevel :: distinct u32
Xdg_Popup :: distinct u32
Wp_Alpha_Modifier_V1 :: distinct u32
Wp_Alpha_Modifier_Surface_V1 :: distinct u32
Wp_Color_Manager_V1 :: distinct u32
Wp_Color_Management_Output_V1 :: distinct u32
Wp_Color_Management_Surface_V1 :: distinct u32
Wp_Color_Management_Surface_Feedback_V1 :: distinct u32
Wp_Image_Description_Creator_Icc_V1 :: distinct u32
Wp_Image_Description_Creator_Params_V1 :: distinct u32
Wp_Image_Description_V1 :: distinct u32
Wp_Image_Description_Info_V1 :: distinct u32
Wp_Color_Representation_Manager_V1 :: distinct u32
Wp_Color_Representation_Surface_V1 :: distinct u32
Wp_Commit_Timing_Manager_V1 :: distinct u32
Wp_Commit_Timer_V1 :: distinct u32
Wp_Content_Type_Manager_V1 :: distinct u32
Wp_Content_Type_V1 :: distinct u32
Wp_Cursor_Shape_Manager_V1 :: distinct u32
Wp_Cursor_Shape_Device_V1 :: distinct u32
Wp_Drm_Lease_Device_V1 :: distinct u32
Wp_Drm_Lease_Connector_V1 :: distinct u32
Wp_Drm_Lease_Request_V1 :: distinct u32
Wp_Drm_Lease_V1 :: distinct u32
Ext_Background_Effect_Manager_V1 :: distinct u32
Ext_Background_Effect_Surface_V1 :: distinct u32
Ext_Data_Control_Manager_V1 :: distinct u32
Ext_Data_Control_Device_V1 :: distinct u32
Ext_Data_Control_Source_V1 :: distinct u32
Ext_Data_Control_Offer_V1 :: distinct u32
Ext_Foreign_Toplevel_List_V1 :: distinct u32
Ext_Foreign_Toplevel_Handle_V1 :: distinct u32
Ext_Idle_Notifier_V1 :: distinct u32
Ext_Idle_Notification_V1 :: distinct u32
Ext_Image_Capture_Source_V1 :: distinct u32
Ext_Output_Image_Capture_Source_Manager_V1 :: distinct u32
Ext_Foreign_Toplevel_Image_Capture_Source_Manager_V1 :: distinct u32
Ext_Image_Copy_Capture_Manager_V1 :: distinct u32
Ext_Image_Copy_Capture_Session_V1 :: distinct u32
Ext_Image_Copy_Capture_Frame_V1 :: distinct u32
Ext_Image_Copy_Capture_Cursor_Session_V1 :: distinct u32
Ext_Session_Lock_Manager_V1 :: distinct u32
Ext_Session_Lock_V1 :: distinct u32
Ext_Session_Lock_Surface_V1 :: distinct u32
Ext_Transient_Seat_Manager_V1 :: distinct u32
Ext_Transient_Seat_V1 :: distinct u32
Ext_Workspace_Manager_V1 :: distinct u32
Ext_Workspace_Group_Handle_V1 :: distinct u32
Ext_Workspace_Handle_V1 :: distinct u32
Wp_Fifo_Manager_V1 :: distinct u32
Wp_Fifo_V1 :: distinct u32
Wp_Fractional_Scale_Manager_V1 :: distinct u32
Wp_Fractional_Scale_V1 :: distinct u32
Wp_Linux_Drm_Syncobj_Manager_V1 :: distinct u32
Wp_Linux_Drm_Syncobj_Timeline_V1 :: distinct u32
Wp_Linux_Drm_Syncobj_Surface_V1 :: distinct u32
Wp_Pointer_Warp_V1 :: distinct u32
Wp_Security_Context_Manager_V1 :: distinct u32
Wp_Security_Context_V1 :: distinct u32
Wp_Single_Pixel_Buffer_Manager_V1 :: distinct u32
Wp_Tearing_Control_Manager_V1 :: distinct u32
Wp_Tearing_Control_V1 :: distinct u32
Xdg_Activation_V1 :: distinct u32
Xdg_Activation_Token_V1 :: distinct u32
Xdg_Wm_Dialog_V1 :: distinct u32
Xdg_Dialog_V1 :: distinct u32
Xdg_System_Bell_V1 :: distinct u32
Xdg_Toplevel_Drag_Manager_V1 :: distinct u32
Xdg_Toplevel_Drag_V1 :: distinct u32
Xdg_Toplevel_Icon_Manager_V1 :: distinct u32
Xdg_Toplevel_Icon_V1 :: distinct u32
Xdg_Toplevel_Tag_Manager_V1 :: distinct u32
Xwayland_Shell_V1 :: distinct u32
Xwayland_Surface_V1 :: distinct u32

resolve_type :: proc($T: typeid, interface: string, location := #caller_location) -> (type: Object_Type) {
	switch typeid_of(T) {
	case Display:
		assert(interface == "wl_display")
		return .Display
	case Registry:
		assert(interface == "wl_registry")
		return .Registry
	case Callback:
		assert(interface == "wl_callback")
		return .Callback
	case Compositor:
		assert(interface == "wl_compositor")
		return .Compositor
	case Shm_Pool:
		assert(interface == "wl_shm_pool")
		return .Shm_Pool
	case Shm:
		assert(interface == "wl_shm")
		return .Shm
	case Buffer:
		assert(interface == "wl_buffer")
		return .Buffer
	case Data_Offer:
		assert(interface == "wl_data_offer")
		return .Data_Offer
	case Data_Source:
		assert(interface == "wl_data_source")
		return .Data_Source
	case Data_Device:
		assert(interface == "wl_data_device")
		return .Data_Device
	case Data_Device_Manager:
		assert(interface == "wl_data_device_manager")
		return .Data_Device_Manager
	case Shell:
		assert(interface == "wl_shell")
		return .Shell
	case Shell_Surface:
		assert(interface == "wl_shell_surface")
		return .Shell_Surface
	case Surface:
		assert(interface == "wl_surface")
		return .Surface
	case Seat:
		assert(interface == "wl_seat")
		return .Seat
	case Pointer:
		assert(interface == "wl_pointer")
		return .Pointer
	case Keyboard:
		assert(interface == "wl_keyboard")
		return .Keyboard
	case Touch:
		assert(interface == "wl_touch")
		return .Touch
	case Output:
		assert(interface == "wl_output")
		return .Output
	case Region:
		assert(interface == "wl_region")
		return .Region
	case Subcompositor:
		assert(interface == "wl_subcompositor")
		return .Subcompositor
	case Subsurface:
		assert(interface == "wl_subsurface")
		return .Subsurface
	case Fixes:
		assert(interface == "wl_fixes")
		return .Fixes
	case Zwp_Linux_Dmabuf_V1:
		assert(interface == "zwp_linux_dmabuf_v1")
		return .Zwp_Linux_Dmabuf_V1
	case Zwp_Linux_Buffer_Params_V1:
		assert(interface == "zwp_linux_buffer_params_v1")
		return .Zwp_Linux_Buffer_Params_V1
	case Zwp_Linux_Dmabuf_Feedback_V1:
		assert(interface == "zwp_linux_dmabuf_feedback_v1")
		return .Zwp_Linux_Dmabuf_Feedback_V1
	case Wp_Presentation:
		assert(interface == "wp_presentation")
		return .Wp_Presentation
	case Wp_Presentation_Feedback:
		assert(interface == "wp_presentation_feedback")
		return .Wp_Presentation_Feedback
	case Zwp_Tablet_Manager_V2:
		assert(interface == "zwp_tablet_manager_v2")
		return .Zwp_Tablet_Manager_V2
	case Zwp_Tablet_Seat_V2:
		assert(interface == "zwp_tablet_seat_v2")
		return .Zwp_Tablet_Seat_V2
	case Zwp_Tablet_Tool_V2:
		assert(interface == "zwp_tablet_tool_v2")
		return .Zwp_Tablet_Tool_V2
	case Zwp_Tablet_V2:
		assert(interface == "zwp_tablet_v2")
		return .Zwp_Tablet_V2
	case Zwp_Tablet_Pad_Ring_V2:
		assert(interface == "zwp_tablet_pad_ring_v2")
		return .Zwp_Tablet_Pad_Ring_V2
	case Zwp_Tablet_Pad_Strip_V2:
		assert(interface == "zwp_tablet_pad_strip_v2")
		return .Zwp_Tablet_Pad_Strip_V2
	case Zwp_Tablet_Pad_Group_V2:
		assert(interface == "zwp_tablet_pad_group_v2")
		return .Zwp_Tablet_Pad_Group_V2
	case Zwp_Tablet_Pad_V2:
		assert(interface == "zwp_tablet_pad_v2")
		return .Zwp_Tablet_Pad_V2
	case Zwp_Tablet_Pad_Dial_V2:
		assert(interface == "zwp_tablet_pad_dial_v2")
		return .Zwp_Tablet_Pad_Dial_V2
	case Wp_Viewporter:
		assert(interface == "wp_viewporter")
		return .Wp_Viewporter
	case Wp_Viewport:
		assert(interface == "wp_viewport")
		return .Wp_Viewport
	case Xdg_Wm_Base:
		assert(interface == "xdg_wm_base")
		return .Xdg_Wm_Base
	case Xdg_Positioner:
		assert(interface == "xdg_positioner")
		return .Xdg_Positioner
	case Xdg_Surface:
		assert(interface == "xdg_surface")
		return .Xdg_Surface
	case Xdg_Toplevel:
		assert(interface == "xdg_toplevel")
		return .Xdg_Toplevel
	case Xdg_Popup:
		assert(interface == "xdg_popup")
		return .Xdg_Popup
	case Wp_Alpha_Modifier_V1:
		assert(interface == "wp_alpha_modifier_v1")
		return .Wp_Alpha_Modifier_V1
	case Wp_Alpha_Modifier_Surface_V1:
		assert(interface == "wp_alpha_modifier_surface_v1")
		return .Wp_Alpha_Modifier_Surface_V1
	case Wp_Color_Manager_V1:
		assert(interface == "wp_color_manager_v1")
		return .Wp_Color_Manager_V1
	case Wp_Color_Management_Output_V1:
		assert(interface == "wp_color_management_output_v1")
		return .Wp_Color_Management_Output_V1
	case Wp_Color_Management_Surface_V1:
		assert(interface == "wp_color_management_surface_v1")
		return .Wp_Color_Management_Surface_V1
	case Wp_Color_Management_Surface_Feedback_V1:
		assert(interface == "wp_color_management_surface_feedback_v1")
		return .Wp_Color_Management_Surface_Feedback_V1
	case Wp_Image_Description_Creator_Icc_V1:
		assert(interface == "wp_image_description_creator_icc_v1")
		return .Wp_Image_Description_Creator_Icc_V1
	case Wp_Image_Description_Creator_Params_V1:
		assert(interface == "wp_image_description_creator_params_v1")
		return .Wp_Image_Description_Creator_Params_V1
	case Wp_Image_Description_V1:
		assert(interface == "wp_image_description_v1")
		return .Wp_Image_Description_V1
	case Wp_Image_Description_Info_V1:
		assert(interface == "wp_image_description_info_v1")
		return .Wp_Image_Description_Info_V1
	case Wp_Color_Representation_Manager_V1:
		assert(interface == "wp_color_representation_manager_v1")
		return .Wp_Color_Representation_Manager_V1
	case Wp_Color_Representation_Surface_V1:
		assert(interface == "wp_color_representation_surface_v1")
		return .Wp_Color_Representation_Surface_V1
	case Wp_Commit_Timing_Manager_V1:
		assert(interface == "wp_commit_timing_manager_v1")
		return .Wp_Commit_Timing_Manager_V1
	case Wp_Commit_Timer_V1:
		assert(interface == "wp_commit_timer_v1")
		return .Wp_Commit_Timer_V1
	case Wp_Content_Type_Manager_V1:
		assert(interface == "wp_content_type_manager_v1")
		return .Wp_Content_Type_Manager_V1
	case Wp_Content_Type_V1:
		assert(interface == "wp_content_type_v1")
		return .Wp_Content_Type_V1
	case Wp_Cursor_Shape_Manager_V1:
		assert(interface == "wp_cursor_shape_manager_v1")
		return .Wp_Cursor_Shape_Manager_V1
	case Wp_Cursor_Shape_Device_V1:
		assert(interface == "wp_cursor_shape_device_v1")
		return .Wp_Cursor_Shape_Device_V1
	case Wp_Drm_Lease_Device_V1:
		assert(interface == "wp_drm_lease_device_v1")
		return .Wp_Drm_Lease_Device_V1
	case Wp_Drm_Lease_Connector_V1:
		assert(interface == "wp_drm_lease_connector_v1")
		return .Wp_Drm_Lease_Connector_V1
	case Wp_Drm_Lease_Request_V1:
		assert(interface == "wp_drm_lease_request_v1")
		return .Wp_Drm_Lease_Request_V1
	case Wp_Drm_Lease_V1:
		assert(interface == "wp_drm_lease_v1")
		return .Wp_Drm_Lease_V1
	case Ext_Background_Effect_Manager_V1:
		assert(interface == "ext_background_effect_manager_v1")
		return .Ext_Background_Effect_Manager_V1
	case Ext_Background_Effect_Surface_V1:
		assert(interface == "ext_background_effect_surface_v1")
		return .Ext_Background_Effect_Surface_V1
	case Ext_Data_Control_Manager_V1:
		assert(interface == "ext_data_control_manager_v1")
		return .Ext_Data_Control_Manager_V1
	case Ext_Data_Control_Device_V1:
		assert(interface == "ext_data_control_device_v1")
		return .Ext_Data_Control_Device_V1
	case Ext_Data_Control_Source_V1:
		assert(interface == "ext_data_control_source_v1")
		return .Ext_Data_Control_Source_V1
	case Ext_Data_Control_Offer_V1:
		assert(interface == "ext_data_control_offer_v1")
		return .Ext_Data_Control_Offer_V1
	case Ext_Foreign_Toplevel_List_V1:
		assert(interface == "ext_foreign_toplevel_list_v1")
		return .Ext_Foreign_Toplevel_List_V1
	case Ext_Foreign_Toplevel_Handle_V1:
		assert(interface == "ext_foreign_toplevel_handle_v1")
		return .Ext_Foreign_Toplevel_Handle_V1
	case Ext_Idle_Notifier_V1:
		assert(interface == "ext_idle_notifier_v1")
		return .Ext_Idle_Notifier_V1
	case Ext_Idle_Notification_V1:
		assert(interface == "ext_idle_notification_v1")
		return .Ext_Idle_Notification_V1
	case Ext_Image_Capture_Source_V1:
		assert(interface == "ext_image_capture_source_v1")
		return .Ext_Image_Capture_Source_V1
	case Ext_Output_Image_Capture_Source_Manager_V1:
		assert(interface == "ext_output_image_capture_source_manager_v1")
		return .Ext_Output_Image_Capture_Source_Manager_V1
	case Ext_Foreign_Toplevel_Image_Capture_Source_Manager_V1:
		assert(interface == "ext_foreign_toplevel_image_capture_source_manager_v1")
		return .Ext_Foreign_Toplevel_Image_Capture_Source_Manager_V1
	case Ext_Image_Copy_Capture_Manager_V1:
		assert(interface == "ext_image_copy_capture_manager_v1")
		return .Ext_Image_Copy_Capture_Manager_V1
	case Ext_Image_Copy_Capture_Session_V1:
		assert(interface == "ext_image_copy_capture_session_v1")
		return .Ext_Image_Copy_Capture_Session_V1
	case Ext_Image_Copy_Capture_Frame_V1:
		assert(interface == "ext_image_copy_capture_frame_v1")
		return .Ext_Image_Copy_Capture_Frame_V1
	case Ext_Image_Copy_Capture_Cursor_Session_V1:
		assert(interface == "ext_image_copy_capture_cursor_session_v1")
		return .Ext_Image_Copy_Capture_Cursor_Session_V1
	case Ext_Session_Lock_Manager_V1:
		assert(interface == "ext_session_lock_manager_v1")
		return .Ext_Session_Lock_Manager_V1
	case Ext_Session_Lock_V1:
		assert(interface == "ext_session_lock_v1")
		return .Ext_Session_Lock_V1
	case Ext_Session_Lock_Surface_V1:
		assert(interface == "ext_session_lock_surface_v1")
		return .Ext_Session_Lock_Surface_V1
	case Ext_Transient_Seat_Manager_V1:
		assert(interface == "ext_transient_seat_manager_v1")
		return .Ext_Transient_Seat_Manager_V1
	case Ext_Transient_Seat_V1:
		assert(interface == "ext_transient_seat_v1")
		return .Ext_Transient_Seat_V1
	case Ext_Workspace_Manager_V1:
		assert(interface == "ext_workspace_manager_v1")
		return .Ext_Workspace_Manager_V1
	case Ext_Workspace_Group_Handle_V1:
		assert(interface == "ext_workspace_group_handle_v1")
		return .Ext_Workspace_Group_Handle_V1
	case Ext_Workspace_Handle_V1:
		assert(interface == "ext_workspace_handle_v1")
		return .Ext_Workspace_Handle_V1
	case Wp_Fifo_Manager_V1:
		assert(interface == "wp_fifo_manager_v1")
		return .Wp_Fifo_Manager_V1
	case Wp_Fifo_V1:
		assert(interface == "wp_fifo_v1")
		return .Wp_Fifo_V1
	case Wp_Fractional_Scale_Manager_V1:
		assert(interface == "wp_fractional_scale_manager_v1")
		return .Wp_Fractional_Scale_Manager_V1
	case Wp_Fractional_Scale_V1:
		assert(interface == "wp_fractional_scale_v1")
		return .Wp_Fractional_Scale_V1
	case Wp_Linux_Drm_Syncobj_Manager_V1:
		assert(interface == "wp_linux_drm_syncobj_manager_v1")
		return .Wp_Linux_Drm_Syncobj_Manager_V1
	case Wp_Linux_Drm_Syncobj_Timeline_V1:
		assert(interface == "wp_linux_drm_syncobj_timeline_v1")
		return .Wp_Linux_Drm_Syncobj_Timeline_V1
	case Wp_Linux_Drm_Syncobj_Surface_V1:
		assert(interface == "wp_linux_drm_syncobj_surface_v1")
		return .Wp_Linux_Drm_Syncobj_Surface_V1
	case Wp_Pointer_Warp_V1:
		assert(interface == "wp_pointer_warp_v1")
		return .Wp_Pointer_Warp_V1
	case Wp_Security_Context_Manager_V1:
		assert(interface == "wp_security_context_manager_v1")
		return .Wp_Security_Context_Manager_V1
	case Wp_Security_Context_V1:
		assert(interface == "wp_security_context_v1")
		return .Wp_Security_Context_V1
	case Wp_Single_Pixel_Buffer_Manager_V1:
		assert(interface == "wp_single_pixel_buffer_manager_v1")
		return .Wp_Single_Pixel_Buffer_Manager_V1
	case Wp_Tearing_Control_Manager_V1:
		assert(interface == "wp_tearing_control_manager_v1")
		return .Wp_Tearing_Control_Manager_V1
	case Wp_Tearing_Control_V1:
		assert(interface == "wp_tearing_control_v1")
		return .Wp_Tearing_Control_V1
	case Xdg_Activation_V1:
		assert(interface == "xdg_activation_v1")
		return .Xdg_Activation_V1
	case Xdg_Activation_Token_V1:
		assert(interface == "xdg_activation_token_v1")
		return .Xdg_Activation_Token_V1
	case Xdg_Wm_Dialog_V1:
		assert(interface == "xdg_wm_dialog_v1")
		return .Xdg_Wm_Dialog_V1
	case Xdg_Dialog_V1:
		assert(interface == "xdg_dialog_v1")
		return .Xdg_Dialog_V1
	case Xdg_System_Bell_V1:
		assert(interface == "xdg_system_bell_v1")
		return .Xdg_System_Bell_V1
	case Xdg_Toplevel_Drag_Manager_V1:
		assert(interface == "xdg_toplevel_drag_manager_v1")
		return .Xdg_Toplevel_Drag_Manager_V1
	case Xdg_Toplevel_Drag_V1:
		assert(interface == "xdg_toplevel_drag_v1")
		return .Xdg_Toplevel_Drag_V1
	case Xdg_Toplevel_Icon_Manager_V1:
		assert(interface == "xdg_toplevel_icon_manager_v1")
		return .Xdg_Toplevel_Icon_Manager_V1
	case Xdg_Toplevel_Icon_V1:
		assert(interface == "xdg_toplevel_icon_v1")
		return .Xdg_Toplevel_Icon_V1
	case Xdg_Toplevel_Tag_Manager_V1:
		assert(interface == "xdg_toplevel_tag_manager_v1")
		return .Xdg_Toplevel_Tag_Manager_V1
	case Xwayland_Shell_V1:
		assert(interface == "xwayland_shell_v1")
		return .Xwayland_Shell_V1
	case Xwayland_Surface_V1:
		assert(interface == "xwayland_surface_v1")
		return .Xwayland_Surface_V1
	case:
		panic("Invalid type", location)
	}
}

