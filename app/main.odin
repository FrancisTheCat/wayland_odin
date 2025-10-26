package wayland_app

import "core:sys/linux"
import "core:fmt"
import "core:os"

import wl ".."

main :: proc() {
	socket := linux.socket(.UNIX, .STREAM, { .CLOEXEC, }, {}) or_else panic("")
	addr: linux.Sock_Addr_Un = {
		sun_family = .UNIX,
	}
	fmt.bprintf(addr.sun_path[:], "%v/%v", os.get_env("XDG_RUNTIME_DIR", context.temp_allocator), os.get_env("WAYLAND_DISPLAY", context.temp_allocator))

	errno := linux.connect(socket, &addr)
	assert(errno == {})

	connection, display       := wl.display_connect(socket)
	connection.object_types    = make([dynamic]wl.Object_Type, 2)
	connection.object_types[1] = .Display

	registry := wl.display_get_registry(&connection, display)
	wl.display_sync(&connection, display)

	buffer := make([]byte, 1 << 16)

	shm:                  wl.Shm
	seat:                 wl.Seat
	data_device_manager:  wl.Data_Device_Manager
	data_source:          wl.Data_Source
	pool:                 wl.Shm_Pool
	wl_buffer:            wl.Buffer
	wl_surface:           wl.Surface
	compositor:           wl.Compositor

	wm_base:              wl.Xdg_Wm_Base
	xdg_surface:          wl.Xdg_Surface
	xdg_toplevel:         wl.Xdg_Toplevel

	cursor_shape_manager: wl.Wp_Cursor_Shape_Manager_V1

	WIDTH  :: 512
	HEIGHT :: 512
	STRIDE :: WIDTH * 4

	framebuffer_fd := cast(linux.Fd)linux.syscall(linux.SYS_memfd_create, transmute(^u8)(cstring("/znarf_wayland_framebuffer_fd")), 1)
	linux.ftruncate(framebuffer_fd, WIDTH * STRIDE)
	framebuffer := ([^]byte)(linux.mmap(0, WIDTH * STRIDE, { .READ, .WRITE, }, { .SHARED, }, framebuffer_fd) or_else panic(""))[:WIDTH * STRIDE]
	for y in 0 ..< HEIGHT {
		for x in 0 ..< WIDTH {
			framebuffer[x * 4 + y * STRIDE + 0] = 0xEF
			framebuffer[x * 4 + y * STRIDE + 1] = 0xAE
			framebuffer[x * 4 + y * STRIDE + 2] = 0x62
			framebuffer[x * 4 + y * STRIDE + 3] = 0xFF
		}
	}

	for {
		wl.connection_flush(&connection)
		wl.connection_poll(&connection, buffer)
		
		for {
			object, event := wl.peek_event(&connection) or_break

			#partial switch e in event {
			case wl.Event_Registry_Global:
				switch e.interface {
				case "wl_shm":
					shm       = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Shm)
					pool      = wl.shm_create_pool(&connection, shm, wl.Fd(framebuffer_fd), STRIDE * HEIGHT)
					wl_buffer = wl.shm_pool_create_buffer(&connection, pool, 0, WIDTH, HEIGHT, STRIDE, .Argb8888)
					fmt.println("shm:", shm)
					fmt.println("pool:", pool)
					fmt.println("wl_buffer:", wl_buffer)
				case "xdg_wm_base":
					wm_base = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Xdg_Wm_Base)
					fmt.println("wm_base:", wm_base)
				case "wp_cursor_shape_manager_v1":
					cursor_shape_manager = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Wp_Cursor_Shape_Manager_V1)
					fmt.println("cursor_shape_manager:", cursor_shape_manager)
				case "wl_seat":
					seat = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Seat)
					fmt.println("seat:", seat)
				case "wl_compositor":
					compositor = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Compositor)
					fmt.println("compositor:", compositor)
				case "wl_data_device_manager":
					// data_device_manager = wl_registry_bind(&connection, registry, e.name, e.interface, e.version, Wl_Data_Device_Manager)
					// fmt.println("data_device_manager:", data_device_manager)
				case:
					// fmt.println(object, event)
				}
			case wl.Event_Data_Source_Target:
				fmt.println(object, event)
			case wl.Event_Data_Source_Send:
				fmt.println(object, event)
			case wl.Event_Data_Source_Action:
				fmt.println(object, event)
			case wl.Event_Xdg_Wm_Base_Ping:
				wl.xdg_wm_base_pong(&connection, wl.Xdg_Wm_Base(object), e.serial)
			case wl.Event_Xdg_Toplevel_Configure_Bounds:
				fmt.println(e.width, e.height)
			case wl.Event_Xdg_Toplevel_Configure:
				fmt.println(e.width, e.height)
			case wl.Event_Xdg_Toplevel_Close:
				return
			case wl.Event_Xdg_Surface_Configure:
				wl.xdg_surface_ack_configure(&connection, wl.Xdg_Surface(object), e.serial);
			case:
				fmt.println(object, event)
			}

			if data_device_manager != 0 && data_source == 0 {
				data_source = wl.data_device_manager_create_data_source(&connection, data_device_manager)
				wl.data_source_offer(&connection, data_source, "text/plain")
				fmt.println("data_source:", data_source)
			}

			if compositor != 0 && shm != 0 && wm_base != 0 && wl_surface == 0 {
				wl_surface   = wl.compositor_create_surface(&connection, compositor);
				xdg_surface  = wl.xdg_wm_base_get_xdg_surface(&connection,  wm_base, wl_surface);
				xdg_toplevel = wl.xdg_surface_get_toplevel(&connection,     xdg_surface);

				wl.surface_attach(&connection, wl_surface, wl_buffer, 0, 0)
				wl.surface_commit(&connection, wl_surface)
				wl.surface_damage_buffer(&connection, wl_surface, 0, 0, WIDTH, HEIGHT)

				wl.surface_commit(&connection, wl_surface);
			}
		}

		assert(connection.data_cursor == len(connection.data))
	}
}

