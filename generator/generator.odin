package generator

import "core:encoding/xml"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:io"
import "core:os"

import "base:intrinsics"

main :: proc() {
	Context :: struct {
		document:            ^xml.Document,
		requests_writer:     io.Writer,
		event_union_writer:  io.Writer,
		event_types_writer:  io.Writer,
		event_parser_writer: io.Writer,
		parser_writer:       io.Writer,
		enums_writer:        io.Writer,
		objects_writer:      io.Writer,
		object_enum_writer:  io.Writer,
		resolution_writer:   io.Writer,
		request_prefix:      string,
		event_prefix:        string,
	}

	generate_interface :: proc(ctx: ^Context, element: xml.Element) -> (ok: bool) {
		fmt.wprintfln(ctx.objects_writer, "%v :: distinct u32", ctx.event_prefix)

		fmt.wprintfln(ctx.object_enum_writer,  "\t%v,", ctx.event_prefix)

		fmt.wprintfln(ctx.resolution_writer, "\tcase %v:", ctx.event_prefix)
		fmt.wprintfln(ctx.resolution_writer, "\t\tassert(interface == \"%v\")", ctx.request_prefix)
		fmt.wprintfln(ctx.resolution_writer, "\t\treturn .%v", ctx.event_prefix)

		parse_field :: proc(ctx: ^Context, element: u32) -> (name, type: string, new_id, ok: bool) {
			name = xml.find_attribute_val_by_key(ctx.document, element, "name") or_return
			type = xml.find_attribute_val_by_key(ctx.document, element, "type") or_return

			switch name {
			case "map":
				name = "map_"
			case "context":
				name = "context_"
			}

			if type == "new_id" {
				type   = strings.to_ada_case(xml.find_attribute_val_by_key(ctx.document, element, "interface") or_else "new_id")
				ok     = true
				new_id = true
				return
			}

			convert_type :: proc(type: string) -> string {
				switch type {
				case "uint":
					return "u32"
				case "int":
					return "i32"
				case "fixed":
					return "f64"
				case "string":
					return "string"
				case "object":
					return "Object"
				case "array":
					return "[]byte"
				case "fd":
					return "Fd"
				}
				unreachable()
			}

			type = convert_type(type)

			if e, ok := xml.find_attribute_val_by_key(ctx.document, element, "enum"); ok {
				dot_index := strings.index_byte(e, '.')
				if dot_index != -1 {
					type = fmt.tprintf("%v_%v", strings.to_ada_case(e[:dot_index]), strings.to_ada_case(e[dot_index + 1:]))
				} else {
					type = fmt.tprintf("%v_%v", ctx.event_prefix, strings.to_ada_case(e))
				}
			}

			if i, ok := xml.find_attribute_val_by_key(ctx.document, element, "interface"); ok {
				type = strings.to_ada_case(i)
			}

			ok = true
			return
		}
		
		generate_request :: proc(ctx: ^Context, element: xml.Element, request_name: string, opcode: int) -> (ok: bool) {
			request_name := strings.trim_prefix(request_name, "wl_")
			fmt.wprintf(ctx.requests_writer, "%v :: proc(connection: ^Connection, %v: %v", request_name, ctx.request_prefix, ctx.event_prefix)
			body: strings.Builder
			sizes: strings.Builder
			return_values: strings.Builder

			has_new_id := false

			fmt.sbprint(&sizes, "\t_size: u16 = 8")
			
			fmt.sbprintfln(&body, "\t%v := %v", ctx.request_prefix, ctx.request_prefix)
			fmt.sbprintfln(&body, "\tbytes.buffer_write_ptr(&connection.buffer, &%v, size_of(%v))", ctx.request_prefix, ctx.request_prefix)
			fmt.sbprintfln(&body, "\topcode: u16 = %d", opcode)
			fmt.sbprintfln(&body, "\tbytes.buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))")
			fmt.sbprintfln(&body, "\tbytes.buffer_write_ptr(&connection.buffer, &_size, size_of(_size))")

			for child_id in element.value {
				child := ctx.document.elements[child_id.(u32) or_continue]
				if child.ident != "arg" {
					continue
				}

				name, type, new_id := parse_field(ctx, child_id.(u32)) or_return
				type = strings.trim_prefix(type, "Wl_")

				generate_write_string :: proc(body, sizes: ^strings.Builder, name: string) {
					fmt.sbprintf(sizes, " + 4 + u16((len(%v) + 1 + 3) & -4)", name)
					fmt.sbprintfln(body, "\t_%v_len := u32(len(%v)) + 1", name, name)
					fmt.sbprintfln(body, "\tbytes.buffer_write_ptr(&connection.buffer, &_%v_len, 4)", name)
					fmt.sbprintfln(body, "\tbytes.buffer_write_string(&connection.buffer, %v)", name)
					fmt.sbprintfln(body, "\tfor _ in len(%v) ..< (len(%v) + 1 + 3) & -4 do bytes.buffer_write_byte(&connection.buffer, 0)", name, name)
				}

				// TODO: handle strings
				switch type {
				case "Fd":
					fmt.sbprintfln(&body, "\tappend(&connection.fds_out, %v)", name)
				case "New_Id":
					has_new_id = true
					generate_write_string(&body, &sizes, "interface")

					fmt.sbprintfln(&body, "\tversion := version")
					fmt.sbprintfln(&body, "\tbytes.buffer_write_ptr(&connection.buffer, &version, size_of(version))")
					fmt.sbprintf(&sizes, " + size_of(version)")

					fmt.sbprintfln(&body, "\t_type := resolve_type(T, interface, _location)")
					fmt.sbprintfln(&body, "\t%v = auto_cast generate_id(connection, _type)", name)
					fmt.sbprintfln(&body, "\tbytes.buffer_write_ptr(&connection.buffer, &%v, size_of(%v))", name, name)
					fmt.sbprintf(&sizes, " + size_of(%v)", name)
				case "string":
					generate_write_string(&body, &sizes, name)
					fmt.sbprintfln(&body, "\tassert(bytes.buffer_length(&connection.buffer) %% 4 == 0)")
				case "array":
					fmt.sbprintfln(&sizes, " + 4 + u16((len(%v) + 3) & -4)", name)
					fmt.sbprintfln(&body, "\tbytes.buffer_write(&connection.buffer, %v)", name)
					fmt.sbprintfln(&body, "\tunimplemented()")
				case:
					if new_id {
						fmt.sbprintfln(&body, "\t%v = auto_cast generate_id(connection, .%v)", name, type)
					} else {
						fmt.sbprintfln(&body, "\t%v := %v", name, name)
					}
					fmt.sbprintfln(&body, "\tbytes.buffer_write_ptr(&connection.buffer, &%v, size_of(%v))", name, name)
					fmt.sbprintf(&sizes, " + size_of(%v)", name)
				}

				if new_id {
					if len(return_values.buf) != 0 {
						fmt.sbprint(&return_values, ", ")
					}
					if type == "New_Id" {
						fmt.wprint(ctx.requests_writer, ", interface: string, version: u32, $T: typeid")
						fmt.sbprintf(&return_values, "%v: T", name)
						continue
					}
					fmt.sbprintf(&return_values, "%v: %v", name, type)
				} else {
					fmt.wprintf(ctx.requests_writer, ", %v: %v", name, type)
				}
			}
			if has_new_id {
				fmt.wprint(ctx.requests_writer, ", _location := #caller_location")
			}
			fmt.wprint(ctx.requests_writer, ")")
			if len(return_values.buf) != 0 {
				fmt.wprintf(ctx.requests_writer, " -> (%v)", strings.to_string(return_values))
			}
			if has_new_id {
				fmt.wprint(ctx.requests_writer, " where intrinsics.type_is_named(T), intrinsics.type_base_type(T) == u32")
			}
			fmt.wprint(ctx.requests_writer, " {\n")
			fmt.wprintln(ctx.requests_writer, strings.to_string(sizes))
			fmt.wprint(ctx.requests_writer, strings.to_string(body))
			fmt.wprint(ctx.requests_writer, "\treturn\n}\n")
			return true
		}

		generate_event :: proc(ctx: ^Context, element: xml.Element, event_name, event_type_name: string, opcode: int) -> (ok: bool) {
			fmt.wprintf(ctx.event_parser_writer, "parse_%v :: proc(connection: ^Connection", event_name)
			fmt.wprintf(ctx.event_types_writer, "Event_%v :: struct {{\n", event_type_name)

			fmt.wprintfln(ctx.parser_writer, "\t\tcase %d:", opcode)
			fmt.wprintfln(ctx.parser_writer, "\t\t\treturn parse_%v(connection)", event_name)

			body: strings.Builder

			for child_id in element.value {
				child := ctx.document.elements[child_id.(u32) or_continue]
				if child.ident != "arg" {
					continue
				}

				name, type, _ := parse_field(ctx, child_id.(u32)) or_return
				type = strings.trim_prefix(type, "Wl_")
				fmt.wprintf(ctx.event_types_writer, "\t%v: %v,\n", name, type)

				fmt.sbprintfln(&body, "\tread(connection, &event.%v) or_return", name)
			}
			fmt.wprint(ctx.event_types_writer, "}\n")

			fmt.wprint(ctx.event_parser_writer, ")")
			fmt.wprintfln(ctx.event_parser_writer, " -> (event: Event_%v, ok: bool) {{", event_type_name)
			fmt.wprint(ctx.event_parser_writer, strings.to_string(body))
			fmt.wprintln(ctx.event_parser_writer, "\tok = true\n\treturn\n}")
			return true
		}

		generate_enum :: proc(ctx: ^Context, element: xml.Element, type_name: string, bitfield: bool) -> (ok: bool) {
			fmt.wprintfln(ctx.enums_writer, "%v :: enum {{", type_name)
			for child_id in element.value {
				child := ctx.document.elements[child_id.(u32) or_continue]
				if child.ident != "entry" {
					continue
				}

				name   := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "name" ) or_return
				value  := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "value") or_return
				prefix := ""
				if '0' <= name[0] && name[0] <= '9' {
					prefix = "_"
				}

				if bitfield {
					value_int := strconv.parse_int(value) or_return
					if value_int == 0 || (value_int - 1) & value_int != 0 {
						continue
					}
					value_int = intrinsics.count_trailing_zeros(value_int)

					if summary, ok := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "summary"); ok {
						fmt.wprintf(ctx.enums_writer, "\t// %v\n", summary)
					}

					fmt.wprintf(ctx.enums_writer, "\t%v%v = %v,\n", prefix, strings.to_ada_case(name), value_int)
				} else {
					if summary, ok := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "summary"); ok {
						fmt.wprintf(ctx.enums_writer, "\t// %v\n", summary)
					}

					fmt.wprintf(ctx.enums_writer, "\t%v%v = %v,\n", prefix, strings.to_ada_case(name), value)
				}
			}
			fmt.wprintln(ctx.enums_writer, "}")
			if bitfield {
				fmt.wprintfln(ctx.enums_writer, "%vs :: bit_set[%v]", type_name, type_name)
			}

			return true
		}

		fmt.wprintfln(ctx.parser_writer, "\tcase .%v:", ctx.event_prefix)
		fmt.wprintfln(ctx.parser_writer, "\t\tswitch opcode {{")

		event_opcode   := 0
		request_opcode := 0
		for child_id in element.value {
			child := ctx.document.elements[child_id.(u32) or_continue]
			name  := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "name") or_continue
			switch child.ident {
			case "request":
				generate_request(ctx, child, fmt.tprintf("%v_%v", ctx.request_prefix, name), request_opcode) or_return
				request_opcode += 1
			case "event":
				type_name := fmt.tprintf("%v_%v", ctx.event_prefix, strings.to_ada_case(name, context.temp_allocator))
				generate_event(ctx, child, fmt.tprintf("%v_%v", ctx.request_prefix, name), type_name, event_opcode) or_return
				fmt.wprintfln(ctx.event_union_writer, "\tEvent_%v,", type_name)
				event_opcode += 1
			case "enum":
				type_name := fmt.tprintf("%v_%v", ctx.event_prefix, strings.to_ada_case(name, context.temp_allocator))
				bitfield  := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "bitfield") or_else "false"
				generate_enum(ctx, child, type_name, bitfield == "true") or_return
			}
		}

		fmt.wprintfln(ctx.parser_writer, "\t\tcase:")
		fmt.wprintfln(ctx.parser_writer, "\t\t\treturn")
		fmt.wprintfln(ctx.parser_writer, "\t\t}")

		return true
	}

	requests_builder:     strings.Builder
	event_union_builder:  strings.Builder
	event_types_builder:  strings.Builder
	event_parser_builder: strings.Builder
	parser_builder:       strings.Builder
	enums_builder:        strings.Builder
	objects_builder:      strings.Builder
	object_enum_builder:  strings.Builder
	resolution_builder:   strings.Builder

	ctx: Context = {
		requests_writer     = strings.to_writer(&requests_builder),
		event_union_writer  = strings.to_writer(&event_union_builder),
		event_types_writer  = strings.to_writer(&event_types_builder),
		event_parser_writer = strings.to_writer(&event_parser_builder),
		parser_writer       = strings.to_writer(&parser_builder),
		enums_writer        = strings.to_writer(&enums_builder),
		objects_writer      = strings.to_writer(&objects_builder),
		object_enum_writer  = strings.to_writer(&object_enum_builder),
		resolution_writer   = strings.to_writer(&resolution_builder),
	}

	fmt.wprintln(ctx.event_union_writer,  "Event :: union {")
	fmt.wprintln(ctx.object_enum_writer,  "Object_Type :: enum {")
	fmt.wprintln(ctx.parser_writer,       "parse_event :: proc(connection: ^Connection, object_type: Object_Type, opcode: u32) -> (event: Event, ok: bool) {")
	fmt.wprintln(ctx.parser_writer,       "\tswitch (object_type) {")
	fmt.wprintln(ctx.resolution_writer,   "resolve_type :: proc($T: typeid, interface: string, location := #caller_location) -> (type: Object_Type) {")
	fmt.wprintln(ctx.resolution_writer,   "\tswitch typeid_of(T) {")

	for arg in os.args[1:] {
		document, err := xml.load_from_file(arg)
		if err != nil {
			fmt.eprintln(err)
			return
		}
		defer xml.destroy(document)

		ctx.document = document

		root := document.elements[0]
		for child_id in root.value {
			child := document.elements[child_id.(u32) or_continue]
			if child.ident == "interface" {
				name := xml.find_attribute_val_by_key(document, child_id.(u32), "name") or_continue
				ctx.request_prefix = name
				ctx.event_prefix   = strings.to_ada_case(name, context.temp_allocator)
				ctx.event_prefix   = strings.trim_prefix(ctx.event_prefix, "Wl_")
				ok := generate_interface(&ctx, child)
				if !ok {
					fmt.eprintfln("Failed to generate interface: %v", name)
					return
				}
			}
		}
	}

	fmt.wprintln(ctx.event_union_writer,  "}")
	fmt.wprintln(ctx.object_enum_writer,  "}")

	fmt.wprintln(ctx.parser_writer,      "\tcase:")
	fmt.wprintln(ctx.parser_writer,      "\t\treturn")
	fmt.wprintln(ctx.parser_writer,      "\t}")
	fmt.wprintln(ctx.parser_writer,      "}")

	fmt.wprintln(ctx.resolution_writer,  "\tcase:")
	fmt.wprintln(ctx.resolution_writer,  "\t\tpanic(\"Invalid type\", location)")
	fmt.wprintln(ctx.resolution_writer,  "\t}")
	fmt.wprintln(ctx.resolution_writer,  "}")

	output_writer := os.stream_from_handle(os.open("generated.odin", os.O_RDWR | os.O_CREATE | os.O_TRUNC, 0o666) or_else panic(""))

	fmt.wprintln(output_writer,
`package wayland

import "core:bytes"

import "base:intrinsics"
`)
	fmt.wprintln(output_writer, strings.to_string(enums_builder))
	fmt.wprintln(output_writer, strings.to_string(requests_builder))
	fmt.wprintln(output_writer, strings.to_string(event_union_builder))
	fmt.wprintln(output_writer, strings.to_string(event_types_builder))
	fmt.wprintln(output_writer, strings.to_string(event_parser_builder))
	fmt.wprintln(output_writer, strings.to_string(parser_builder))
	fmt.wprintln(output_writer, strings.to_string(object_enum_builder))
	fmt.wprintln(output_writer, strings.to_string(objects_builder))
	fmt.wprintln(output_writer, strings.to_string(resolution_builder))
}

