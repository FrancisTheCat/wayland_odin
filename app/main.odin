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

	connection, display := wl.display_connect(socket)

	registry := wl.display_get_registry(&connection, display)
	wl.display_sync(&connection, display)

	buffer := make([]byte, 1 << 16)

	shm:                  wl.Shm
	seat:                 wl.Seat
	pool:                 wl.Shm_Pool
	wl_buffer:            wl.Buffer
	wl_surface:           wl.Surface
	compositor:           wl.Compositor
	pointer:              wl.Pointer

	xdg_wm_base:          wl.Xdg_Wm_Base
	xdg_surface:          wl.Xdg_Surface
	xdg_toplevel:         wl.Xdg_Toplevel

	cursor_shape_manager: wl.Wp_Cursor_Shape_Manager_V1
	cursor_shape_device:  wl.Wp_Cursor_Shape_Device_V1

	enter_serial: u32
	cursor_set:   bool

	WIDTH  :: 512
	HEIGHT :: 512

	// there is no `memfd_create` in `core:sys/linux` currently
	when false {
		framebuffer_fd, err := linux.memfd_create("/znarf_wayland_framebuffer_fd", { .CLOEXEC, })
		if err != nil {
			fmt.eprintln("Failed to create memfd:", err)
			os.exit(1)
		}
	} else {
		framebuffer_fd := cast(linux.Fd)linux.syscall(linux.SYS_memfd_create, transmute(^u8)(cstring("/znarf_wayland_framebuffer_fd")), 1)
	}
	linux.ftruncate(framebuffer_fd, WIDTH * HEIGHT * size_of([4]byte))
	framebuffer := ([^][4]byte)(linux.mmap(0, WIDTH * HEIGHT * size_of([4]byte), { .READ, .WRITE, }, { .SHARED, }, framebuffer_fd) or_else panic(""))[:WIDTH * HEIGHT]
	for &pixel in framebuffer {
		pixel = { 0xEF, 0xAE, 0x62, 0xFF, }
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
					pool      = wl.shm_create_pool(&connection, shm, wl.Fd(framebuffer_fd), WIDTH * HEIGHT * size_of([4]byte))
					wl_buffer = wl.shm_pool_create_buffer(&connection, pool, 0, WIDTH, HEIGHT, WIDTH * size_of([4]byte), .Argb8888)
					fmt.println("shm:", shm)
					fmt.println("pool:", pool)
					fmt.println("wl_buffer:", wl_buffer)
				case "xdg_wm_base":
					xdg_wm_base = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Xdg_Wm_Base)
					fmt.println("xdg_wm_base:", xdg_wm_base)
				case "wp_cursor_shape_manager_v1":
					cursor_shape_manager = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Wp_Cursor_Shape_Manager_V1)
					fmt.println("cursor_shape_manager:", cursor_shape_manager)
				case "wl_seat":
					seat = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Seat)
					fmt.println("seat:", seat)
					pointer = wl.seat_get_pointer(&connection, seat)
					fmt.println("pointer:", pointer)
				case "wl_compositor":
					compositor = wl.registry_bind(&connection, registry, e.name, e.interface, e.version, wl.Compositor)
					fmt.println("compositor:", compositor)
				case:
					fmt.println(event)
				}
			case wl.Event_Xdg_Wm_Base_Ping:
				wl.xdg_wm_base_pong(&connection, wl.Xdg_Wm_Base(object), e.serial)
			case wl.Event_Xdg_Toplevel_Close:
				return
			case wl.Event_Xdg_Surface_Configure:
				wl.xdg_surface_ack_configure(&connection, wl.Xdg_Surface(object), e.serial)
			case wl.Event_Pointer_Enter:
				enter_serial = e.serial
			case:
				fmt.println(event)
			}

			if cursor_shape_device == 0 && pointer != 0 && cursor_shape_manager != 0 {
				cursor_shape_device = wl.wp_cursor_shape_manager_v1_get_pointer(&connection, cursor_shape_manager, pointer)
				fmt.println("cursor_shape_device:", cursor_shape_device)
			}

			if cursor_shape_device != 0 && !cursor_set && enter_serial != 0 {
				wl.wp_cursor_shape_device_v1_set_shape(&connection, cursor_shape_device, enter_serial, .Crosshair)
				cursor_set = true
			}

			if compositor != 0 && shm != 0 && xdg_wm_base != 0 && wl_surface == 0 {
				wl_surface   = wl.compositor_create_surface(&connection, compositor)
				xdg_surface  = wl.xdg_wm_base_get_xdg_surface(&connection, xdg_wm_base, wl_surface)
				xdg_toplevel = wl.xdg_surface_get_toplevel(&connection, xdg_surface)

				wl.surface_attach(&connection, wl_surface, wl_buffer, 0, 0)
				wl.surface_commit(&connection, wl_surface)
				wl.surface_damage_buffer(&connection, wl_surface, 0, 0, WIDTH, HEIGHT)

				wl.surface_commit(&connection, wl_surface)
			}
		}

		assert(connection.data_cursor == len(connection.data))
	}
}
