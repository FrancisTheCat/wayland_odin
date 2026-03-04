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
		object_name:         string,
		raw_object_name:     string,
		object_type_name:    string,
	}

	generate_interface :: proc(ctx: ^Context, element: xml.Element) -> (ok: bool) {
		fmt.wprintfln(ctx.objects_writer, "%v :: distinct u32", ctx.object_type_name)

		fmt.wprintfln(ctx.object_enum_writer,  "\t%v,", ctx.object_type_name)

		fmt.wprintfln(ctx.resolution_writer, "\tcase %v:", ctx.object_type_name)
		fmt.wprintfln(ctx.resolution_writer, "\t\tassert(interface == \"%v\")", ctx.raw_object_name)
		fmt.wprintfln(ctx.resolution_writer, "\t\treturn .%v", ctx.object_type_name)

		parse_field :: proc(ctx: ^Context, element: u32) -> (name, type: string, new_id, ok: bool) {
			name = xml.find_attribute_val_by_key(ctx.document, element, "name") or_return
			type = xml.find_attribute_val_by_key(ctx.document, element, "type") or_return

			switch name {
			case "import":      name = "import_"
			case "foreign":     name = "foreign_"
			case "package":     name = "package_"
			case "typeid":      name = "typeid_"
			case "when":        name = "when_"
			case "where":       name = "where_"
			case "if":          name = "if_"
			case "else":        name = "else_"
			case "for":         name = "for_"
			case "switch":      name = "switch_"
			case "in":          name = "in_"
			case "not_in":      name = "not_in_"
			case "do":          name = "do_"
			case "case":        name = "case_"
			case "break":       name = "break_"
			case "continue":    name = "continue_"
			case "fallthrough": name = "fallthrough_"
			case "defer":       name = "defer_"
			case "return":      name = "return_"
			case "proc":        name = "proc_"
			case "struct":      name = "struct_"
			case "union":       name = "union_"
			case "enum":        name = "enum_"
			case "bit_set":     name = "bit_set_"
			case "bit_field":   name = "bit_field_"
			case "map":         name = "map_"
			case "dynamic":     name = "dynamic_"
			case "auto_cast":   name = "auto_cast_"
			case "cast":        name = "cast_"
			case "transmute":   name = "transmute_"
			case "distinct":    name = "distinct_"
			case "using":       name = "using_"
			case "context":     name = "context_"
			case "or_else":     name = "or_else_"
			case "or_return":   name = "or_return_"
			case "or_break":    name = "or_break_"
			case "or_continue": name = "or_continue_"
			case "asm":         name = "asm_"
			case "matrix":      name = "matrix_"
			}

			if type == "new_id" {
				type   = object_type_name(xml.find_attribute_val_by_key(ctx.document, element, "interface") or_else "new_id")
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
					type = fmt.tprintf("%v_%v", object_type_name(e[:dot_index]), strings.to_ada_case(e[dot_index + 1:]))
				} else {
					type = fmt.tprintf("%v_%v", ctx.object_type_name, strings.to_ada_case(e))
				}
			}

			if i, ok := xml.find_attribute_val_by_key(ctx.document, element, "interface"); ok {
				type = object_type_name(i)
			}

			ok = true
			return
		}
		
		generate_request :: proc(ctx: ^Context, element: xml.Element, request_name: string, opcode: int) -> (ok: bool) {
			fmt.wprintf(ctx.requests_writer, "%v_%v :: proc(connection: ^Connection, %v: %v", ctx.object_name, request_name, ctx.object_name, ctx.object_type_name)
			body:          strings.Builder
			sizes:         strings.Builder
			return_values: strings.Builder
			debug_log:     strings.Builder

			has_new_id := false

			fmt.sbprint(&sizes, "\t_size: u16 = 8")
			
			fmt.sbprintfln(&body, "\t%v := %v", ctx.object_name, ctx.object_name)
			fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer, &%v, size_of(%v))", ctx.object_name, ctx.object_name)
			fmt.sbprintfln(&body, "\topcode: u16 = %d", opcode)
			fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer, &opcode, size_of(opcode))")
			fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer, &_size, size_of(_size))")

			fmt.sbprintf(&debug_log, `	if connection.log_fn != nil do _debug_log(connection, "-> %s@", %s, ".%s:"`, ctx.raw_object_name, ctx.object_name, request_name)

			for child_id in element.value {
				child := ctx.document.elements[child_id.(u32) or_continue]
				if child.ident != "arg" {
					continue
				}

				name, type, new_id := parse_field(ctx, child_id.(u32)) or_return
				type = strings.trim_prefix(type, "Wl_")

				fmt.sbprintf(&debug_log, `, " %s=", %s`, name, name)

				generate_write_string :: proc(body, sizes: ^strings.Builder, name: string) {
					fmt.sbprintf(sizes, " + 4 + u16((len(%v) + 1 + 3) & -4)", name)
					fmt.sbprintfln(body, "\t_buffer_write_string(&connection.buffer, %v)", name)
				}

				switch type {
				case "Fd":
					fmt.sbprintfln(&body, "\tappend(&connection.fds_out, %v)", name)
				case "New_Id":
					has_new_id = true
					generate_write_string(&body, &sizes, "interface")

					fmt.sbprintfln(&body, "\tversion := version")
					fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer, &version, size_of(version))")
					fmt.sbprintf(&sizes, " + size_of(version)")

					fmt.sbprintfln(&body, "\t_type := resolve_type(T, interface, _location)")
					fmt.sbprintfln(&body, "\t%v = auto_cast generate_id(connection, _type)", name)
					fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer, &%v, size_of(%v))", name, name)
					fmt.sbprintf(&sizes, " + size_of(%v)", name)
				case "string":
					generate_write_string(&body, &sizes, name)
				case "array":
					fmt.sbprintfln(&sizes, " + 4 + u16((len(%v) + 3) & -4)", name)
					fmt.sbprintfln(&body, "\t_buffer_write(&connection.buffer, %v)", name)
					fmt.sbprintfln(&body, "\tunimplemented()")
				case:
					if new_id {
						fmt.sbprintfln(&body, "\t%v = auto_cast generate_id(connection, .%v)", name, type)
					} else {
						fmt.sbprintfln(&body, "\t%v := %v", name, name)
					}
					fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer, &%v, size_of(%v))", name, name)
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
			fmt.sbprintfln(&debug_log, ")")
			fmt.wprint(ctx.requests_writer, strings.to_string(debug_log))
			fmt.wprint(ctx.requests_writer, "\treturn\n}\n")
			return true
		}

		generate_event :: proc(
			ctx:             ^Context,
			element:         xml.Element,
			event_name:      string,
			opcode:          int,
		) -> (ok: bool) {
			type_name := fmt.tprintf("%v_%v", ctx.object_type_name, strings.to_ada_case(event_name))
			fmt.wprintfln(ctx.event_union_writer, "\tEvent_%v,", type_name)

			fmt.wprintf(ctx.event_parser_writer, "parse_%v_%v :: proc(connection: ^Connection, object: u32)", ctx.object_name, event_name)
			fmt.wprintfln(ctx.event_parser_writer, " -> (event: Event_%v, ok: bool) {{", type_name)

			fmt.wprintf(ctx.event_types_writer, "Event_%v :: struct {{\n", type_name)
			fmt.wprintf(ctx.event_types_writer, "\tobject: %s,\n", ctx.object_type_name)

			fmt.wprintfln(ctx.parser_writer, "\t\tcase %d:", opcode)
			fmt.wprintfln(ctx.parser_writer, "\t\t\treturn parse_%v_%v(connection, object)", ctx.object_name, event_name)

			body: strings.Builder
			fmt.sbprintfln(&body, "\tevent.object = %v(object)", ctx.object_type_name)

			debug_log: strings.Builder
			fmt.sbprintf(&debug_log, `	if connection.log_fn != nil do _debug_log(connection, "<- %s@", object, ".%s:"`, ctx.raw_object_name, event_name)

			for child_id in element.value {
				child := ctx.document.elements[child_id.(u32) or_continue]
				if child.ident != "arg" {
					continue
				}

				name, type, new_id := parse_field(ctx, child_id.(u32)) or_return
				type = strings.trim_prefix(type, "Wl_")
				fmt.wprintf(ctx.event_types_writer, "\t%v: %v,\n", name, type)

				fmt.sbprintf(&debug_log, `, " %s=", event.%s`, name, name)

				fmt.sbprintfln(&body, "\tread(connection, &event.%v) or_return", name)

				if new_id {
					fmt.sbprintfln(&body, "\tresize(&connection.server_object_types, max(len(connection.server_object_types), int(event.%v) - SERVER_ID_START + 1))", name)
					fmt.sbprintfln(&body, "\tconnection.server_object_types[u32(event.%v) - SERVER_ID_START] = .%v", name, type)
				}
			}
			fmt.wprint(ctx.event_types_writer, "}\n")

			fmt.wprint(ctx.event_parser_writer, strings.to_string(body))
			fmt.sbprintfln(&debug_log, ")")
			fmt.wprint(ctx.event_parser_writer, strings.to_string(debug_log))
			fmt.wprintln(ctx.event_parser_writer, "\tok = true\n\treturn\n}")

			return true
		}

		generate_enum :: proc(ctx: ^Context, element: xml.Element, type_name: string, bitfield: bool) -> (ok: bool) {
			type_name := fmt.tprintf("%v_%v", ctx.object_type_name, strings.to_ada_case(type_name))

			if bitfield {
				fmt.wprintfln(ctx.enums_writer, "%v_Bits :: enum {{", type_name)
			} else {
				fmt.wprintfln(ctx.enums_writer, "%v :: enum u32 {{", type_name)
			}
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
				fmt.wprintfln(ctx.enums_writer, "%v :: distinct bit_set[%v_Bits; u32]", type_name, type_name)
			}

			return true
		}

		fmt.wprintfln(ctx.parser_writer, "\tcase .%v:", ctx.object_type_name)
		fmt.wprintfln(ctx.parser_writer, "\t\tswitch opcode {{")

		event_opcode   := 0
		request_opcode := 0
		for child_id in element.value {
			child := ctx.document.elements[child_id.(u32) or_continue]
			name  := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "name") or_continue
			switch child.ident {
			case "request":
				generate_request(ctx, child, name, request_opcode) or_return
				request_opcode += 1
			case "event":
				generate_event(ctx, child, name, event_opcode) or_return
				event_opcode += 1
			case "enum":
				bitfield := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "bitfield") or_else "false"
				generate_enum(ctx, child, name, bitfield == "true") or_return
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
	fmt.wprintln(ctx.parser_writer,       "parse_event :: proc(connection: ^Connection, object: u32, object_type: Object_Type, opcode: u32) -> (event: Event, ok: bool) {")
	fmt.wprintln(ctx.parser_writer,       "\tswitch (object_type) {")
	fmt.wprintln(ctx.resolution_writer,   "resolve_type :: proc($T: typeid, interface: string, location := #caller_location) -> (type: Object_Type) {")
	fmt.wprintln(ctx.resolution_writer,   "\tswitch typeid_of(T) {")

	object_type_name :: proc(object: string) -> string {
		return strings.trim_prefix(strings.to_ada_case(object), "Wl_")
	}

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
				ctx.raw_object_name  = name
				ctx.object_name      = strings.trim_prefix(name, "wl_")
				ctx.object_type_name = object_type_name(name)
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

	output_writer := os.to_stream(os.open("generated.odin", os.O_RDWR | os.O_CREATE | os.O_TRUNC, {.Read_User, .Write_User, .Read_Group, .Read_Other}) or_else panic(""))

	fmt.wprintln(output_writer,
`package wayland

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

