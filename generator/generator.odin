package generator

import "core:encoding/xml"
import "core:fmt"
import "core:slice"
import "core:strings"
import "core:strconv"
import "core:io"
import "core:os"

import "base:intrinsics"

main :: proc() {
	Context :: struct {
		document:             ^xml.Document,
		requests_builder:     strings.Builder,
		event_union_builder: ^strings.Builder,
		event_types_builder:  strings.Builder,
		event_parser_builder: strings.Builder,
		parser_builder:      ^strings.Builder,
		enums_builder:        strings.Builder,
		objects_builder:      strings.Builder,
		interfaces_builder:   strings.Builder,
		object_enum_builder: ^strings.Builder,
		resolution_builder:  ^strings.Builder,
		object_name:          string,
		raw_object_name:      string,
		object_type_name:     string,
		namespace:            string,
		imports:              map[string]struct{},
	}

	generate_interface :: proc(ctx: ^Context, element: xml.Element) -> (ok: bool) {
		fmt.sbprintfln(&ctx.objects_builder, "%v :: distinct u32", ctx.object_type_name)

		fmt.sbprintfln(ctx.object_enum_builder,  "\t%v,", strings.to_ada_case(ctx.raw_object_name))

		fmt.sbprintfln(ctx.resolution_builder, "\tcase %v.%v:", ctx.namespace, ctx.object_type_name)
		fmt.sbprintfln(ctx.resolution_builder, "\t\tassert(interface == \"%v\")", ctx.raw_object_name)
		fmt.sbprintfln(ctx.resolution_builder, "\t\treturn .%v", strings.to_ada_case(ctx.raw_object_name))

		parse_field :: proc(ctx: ^Context, element: u32) -> (name, type, type_name: string, new_id, ok: bool) {
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

			@(require_results)
			apply_namespace :: proc(ctx: ^Context, type: string) -> string {
				type := type

				namespace := strings.to_lower(strings.split_iterator(&type, "_") or_else panic("No namespace in type"))
				type       = strings.to_ada_case(type)
				if namespace != ctx.namespace {
					type                   = fmt.aprintf("%v.%v", namespace, type)
					ctx.imports[namespace] = {}
				}

				return type
			}

			if type == "new_id" {
				ok     = true
				new_id = true

				found: bool
				type, found = xml.find_attribute_val_by_key(ctx.document, element, "interface")
				if !found {
					type = "new_id"
					return
				}

				type_name = strings.to_ada_case(type)
				type      = apply_namespace(ctx, type)
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
					type = fmt.tprintf("%v_%v", ctx.object_type_name, strings.to_ada_case(e))
				}

				if dot_index != -1 {
					type = apply_namespace(ctx, type)
				}
			}

			if interface, ok := xml.find_attribute_val_by_key(ctx.document, element, "interface"); ok {
				type = apply_namespace(ctx, interface)
			}

			ok = true
			return
		}

		generate_request :: proc(ctx: ^Context, element: xml.Element, request_name: string, opcode: int) -> (ok: bool) {
			fmt.sbprintf(&ctx.requests_builder, "%v_%v :: proc(connection: ^Connection, %v: %v", ctx.object_name, request_name, ctx.object_name, ctx.object_type_name)
			body:          strings.Builder
			sizes:         strings.Builder
			return_values: strings.Builder
			debug_log:     strings.Builder

			has_new_id := false

			fmt.sbprint(&sizes, "\t_size: u16 = 8")
			
			fmt.sbprintfln(&body, "\t%v := %v", ctx.object_name, ctx.object_name)
			fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer_out, &%v, size_of(%v))", ctx.object_name, ctx.object_name)
			fmt.sbprintfln(&body, "\topcode: u16 = %d", opcode)
			fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer_out, &opcode, size_of(opcode))")
			fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer_out, &_size, size_of(_size))")

			fmt.sbprintf(&debug_log, `	if connection.log_fn != nil do _debug_log(connection, "-> %s@", %s, ".%s:"`, ctx.raw_object_name, ctx.object_name, request_name)

			for child_id in element.value {
				child := ctx.document.elements[child_id.(u32) or_continue]
				if child.ident != "arg" {
					continue
				}

				name, type, type_name, new_id := parse_field(ctx, child_id.(u32)) or_return

				fmt.sbprintf(&debug_log, `, " %s=", %s`, name, name)

				generate_write_string :: proc(body, sizes: ^strings.Builder, name: string) {
					fmt.sbprintf(sizes, " + 4 + u16((len(%v) + 1 + 3) & -4)", name)
					fmt.sbprintfln(body, "\t_buffer_write_string(&connection.buffer_out, %v)", name)
				}

				switch type {
				case "Fd":
					fmt.sbprintfln(&body, "\tappend(&connection.fds_out, %v)", name)
				case "new_id":
					has_new_id = true
					generate_write_string(&body, &sizes, "interface")

					fmt.sbprintfln(&body, "\tversion := version")
					fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer_out, &version, size_of(version))")
					fmt.sbprintf(&sizes, " + size_of(version)")

					fmt.sbprintfln(&body, "\t_type := resolve_type(T, interface, _location)")
					fmt.sbprintfln(&body, "\t%v = auto_cast _generate_id(connection, _type)", name)
					fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer_out, &%v, size_of(%v))", name, name)
					fmt.sbprintf(&sizes, " + size_of(%v)", name)
				case "string":
					generate_write_string(&body, &sizes, name)
				case "array":
					fmt.sbprintfln(&sizes, " + 4 + u16((len(%v) + 3) & -4)", name)
					fmt.sbprintfln(&body, "\t_buffer_write(&connection.buffer_out, %v)", name)
					fmt.sbprintfln(&body, "\tunimplemented()")
				case:
					if new_id {
						fmt.sbprintfln(&body, "\t%v = auto_cast _generate_id(connection, .%v)", name, type_name)
					} else {
						fmt.sbprintfln(&body, "\t%v := %v", name, name)
					}
					fmt.sbprintfln(&body, "\t_buffer_write_ptr(&connection.buffer_out, &%v, size_of(%v))", name, name)
					fmt.sbprintf(&sizes, " + size_of(%v)", name)
				}

				if new_id {
					if len(return_values.buf) != 0 {
						fmt.sbprint(&return_values, ", ")
					}
					if type == "new_id" {
						fmt.sbprint(&ctx.requests_builder, ", interface: string, version: u32, $T: typeid")
						fmt.sbprintf(&return_values, "%v: T", name)
						continue
					}
					fmt.sbprintf(&return_values, "%v: %v", name, type)
				} else {
					fmt.sbprintf(&ctx.requests_builder, ", %v: %v", name, type)
				}
			}
			if has_new_id {
				fmt.sbprint(&ctx.requests_builder, ", _location := #caller_location")
			}
			fmt.sbprint(&ctx.requests_builder, ")")
			if len(return_values.buf) != 0 {
				fmt.sbprintf(&ctx.requests_builder, " -> (%v)", strings.to_string(return_values))
			}
			if has_new_id {
				fmt.sbprint(&ctx.requests_builder, " where intrinsics.type_is_named(T), intrinsics.type_base_type(T) == u32")
			}
			fmt.sbprint(&ctx.requests_builder, " {\n")
			fmt.sbprintln(&ctx.requests_builder, strings.to_string(sizes))
			fmt.sbprint(&ctx.requests_builder, strings.to_string(body))
			fmt.sbprintfln(&debug_log, ")")
			fmt.sbprint(&ctx.requests_builder, strings.to_string(debug_log))
			fmt.sbprint(&ctx.requests_builder, "\treturn\n}\n")
			return true
		}

		generate_event :: proc(
			ctx:        ^Context,
			element:    xml.Element,
			event_name: string,
			opcode:     int,
		) -> (ok: bool) {
			type_name := fmt.tprintf("%v_%v", ctx.object_type_name, strings.to_ada_case(event_name))
			fmt.sbprintfln(ctx.event_union_builder, "\t%v.%v_Event,", ctx.namespace, type_name)

			fmt.sbprintf(&ctx.event_parser_builder, "parse_%v_%v :: proc(connection: ^Connection, object: u32)", ctx.object_name, event_name)
			fmt.sbprintfln(&ctx.event_parser_builder, " -> (event: %v_Event, ok: bool) {{", type_name)

			fmt.sbprintf(&ctx.event_types_builder, "%v_Event :: struct {{\n", type_name)
			fmt.sbprintf(&ctx.event_types_builder, "\tobject: %s,\n", ctx.object_type_name)

			fmt.sbprintfln(ctx.parser_builder, "\t\tcase %d:", opcode)
			fmt.sbprintfln(ctx.parser_builder, "\t\t\treturn %v.parse_%v_%v(connection, object)", ctx.namespace, ctx.object_name, event_name)

			body: strings.Builder
			fmt.sbprintfln(&body, "\tevent.object = %v(object)", ctx.object_type_name)

			debug_log: strings.Builder
			fmt.sbprintf(&debug_log, `	if connection.log_fn != nil do _debug_log(connection, "<- %s@", object, ".%s:"`, ctx.raw_object_name, event_name)

			for child_id in element.value {
				child := ctx.document.elements[child_id.(u32) or_continue]
				if child.ident != "arg" {
					continue
				}

				name, type, type_name, new_id := parse_field(ctx, child_id.(u32)) or_return
				fmt.sbprintf(&ctx.event_types_builder, "\t%v: %v,\n", name, type)

				fmt.sbprintf(&debug_log, `, " %s=", event.%s`, name, name)

				if type == "Fd" {
					fmt.sbprintfln(&body, "\tread_fd(connection, &event.%v) or_return", name)
				} else {
					fmt.sbprintfln(&body, "\tread(connection, &event.%v) or_return", name)
				}

				if new_id {
					fmt.sbprintfln(&body, "\tresize(&connection.server_object_types, max(len(connection.server_object_types), int(event.%v) - SERVER_ID_START + 1))", name)
					fmt.sbprintfln(&body, "\tconnection.server_object_types[u32(event.%v) - SERVER_ID_START] = .%v", name, type_name)
				}
			}
			fmt.sbprint(&ctx.event_types_builder, "}\n")

			fmt.sbprint(&ctx.event_parser_builder, strings.to_string(body))
			fmt.sbprintfln(&debug_log, ")")
			fmt.sbprint(&ctx.event_parser_builder, strings.to_string(debug_log))
			fmt.sbprintln(&ctx.event_parser_builder, "\tok = true\n\treturn\n}")

			return true
		}

		generate_enum :: proc(ctx: ^Context, element: xml.Element, type_name: string, bitfield: bool) -> (ok: bool) {
			type_name := fmt.tprintf("%v_%v", ctx.object_type_name, strings.to_ada_case(type_name))

			if bitfield {
				fmt.sbprintfln(&ctx.enums_builder, "%v_Bits :: enum {{", type_name)
			} else {
				fmt.sbprintfln(&ctx.enums_builder, "%v :: enum u32 {{", type_name)
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
						fmt.sbprintf(&ctx.enums_builder, "\t// %v\n", summary)
					}

					fmt.sbprintf(&ctx.enums_builder, "\t%v%v = %v,\n", prefix, strings.to_ada_case(name), value_int)
				} else {
					if summary, ok := xml.find_attribute_val_by_key(ctx.document, child_id.(u32), "summary"); ok {
						fmt.sbprintf(&ctx.enums_builder, "\t// %v\n", summary)
					}

					fmt.sbprintf(&ctx.enums_builder, "\t%v%v = %v,\n", prefix, strings.to_ada_case(name), value)
				}
			}
			fmt.sbprintln(&ctx.enums_builder, "}")
			if bitfield {
				fmt.sbprintfln(&ctx.enums_builder, "%v :: distinct bit_set[%v_Bits; u32]", type_name, type_name)
			}

			return true
		}

		fmt.sbprintfln(ctx.parser_builder, "\tcase .%v:", strings.to_ada_case(ctx.raw_object_name))
		fmt.sbprintfln(ctx.parser_builder, "\t\tswitch opcode {{")

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

		fmt.sbprintfln(ctx.parser_builder, "\t\tcase:")
		fmt.sbprintfln(ctx.parser_builder, "\t\t\treturn")
		fmt.sbprintfln(ctx.parser_builder, "\t\t}")

		return true
	}

	@(static)
	ctx_map: map[string]Context
	@(static)
	object_enum_builder, event_union_builder, parser_builder, resolution_builder: strings.Builder

	get_ctx :: proc(namespace: string) -> ^Context {
		if namespace in ctx_map {
			return &ctx_map[namespace]
		}

		ctx: Context
		ctx.namespace           = namespace
		ctx.object_enum_builder = &object_enum_builder
		ctx.event_union_builder = &event_union_builder
		ctx.parser_builder      = &parser_builder
		ctx.resolution_builder  = &resolution_builder

		ctx_map[namespace] = ctx
		return &ctx_map[namespace]
	}

	for arg in os.args[1:] {
		document, err := xml.load_from_file(arg)
		if err != nil {
			fmt.eprintln(err)
			return
		}

		root := document.elements[0]
		for child_id in root.value {
			child := document.elements[child_id.(u32) or_continue]
			if child.ident == "interface" {
				name      := xml.find_attribute_val_by_key(document, child_id.(u32), "name") or_continue
				raw_name  := name
				namespace := strings.split_iterator(&name, "_") or_else panic("interface without namespace")

				ctx: ^Context
				if namespace in ctx_map {
					ctx = &ctx_map[namespace]
				} else {
					ctx_map[namespace] = {
						namespace           = namespace,
						object_enum_builder = &object_enum_builder,
						event_union_builder = &event_union_builder,
						parser_builder      = &parser_builder,
						resolution_builder  = &resolution_builder,
					}
					ctx = &ctx_map[namespace]
				}

				fmt.sbprintfln(&ctx.interfaces_builder, `%v_INTERFACE :: "%v"`, strings.to_upper(name), raw_name)

				ctx.raw_object_name  = raw_name
				ctx.object_name      = strings.trim_prefix(name, ctx.namespace)
				ctx.object_type_name = strings.to_ada_case(name)
				ctx.document         = document

				ok := generate_interface(ctx, child)
				if !ok {
					fmt.eprintfln("Failed to generate interface: %v", name)
					return
				}
			}
		}
	}

	for namespace, &ctx in ctx_map {
		os.make_directory(namespace)
		output_writer := os.to_stream(
			os.open(
				fmt.aprintf("%v/generated.odin", namespace),
				{ .Read, .Write, .Create, .Trunc, },
				{ .Read_User, .Write_User, .Read_Group, .Read_Other, },
			) or_else panic(""),
		)

		fmt.wprintfln(output_writer,
`package wayland_%v

import "base:intrinsics"

import "../common"
`, namespace)

		imports, _ := slice.map_keys(ctx.imports)
		slice.sort(imports)
		for import_ in imports {
			fmt.wprintfln(output_writer, "import \"../%v\"", import_)
		}

		fmt.wprintln(output_writer, `
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

`)

		fmt.wprintln(output_writer, strings.to_string(ctx.interfaces_builder))
		fmt.wprintln(output_writer, strings.to_string(ctx.enums_builder))
		fmt.wprintln(output_writer, strings.to_string(ctx.requests_builder))
		fmt.wprintln(output_writer, strings.to_string(ctx.event_types_builder))
		fmt.wprintln(output_writer, strings.to_string(ctx.event_parser_builder))
		fmt.wprintln(output_writer, strings.to_string(ctx.objects_builder))
	}

	output_writer := os.to_stream(
		os.open(
			"common/generated.odin",
			{ .Read, .Write, .Create, .Trunc, },
			{ .Read_User, .Write_User, .Read_Group, .Read_Other, },
		) or_else panic(""),
	)

	fmt.wprintln(output_writer, "package wayland_common\n")
	fmt.wprintln(output_writer, "Object_Type :: enum {")
	fmt.wprint(output_writer, strings.to_string(object_enum_builder))
	fmt.wprintln(output_writer,  "}")

	output_writer = os.to_stream(
		os.open(
			"generated.odin",
			{ .Read, .Write, .Create, .Trunc, },
			{ .Read_User, .Write_User, .Read_Group, .Read_Other, },
		) or_else panic(""),
	)

	fmt.wprintln(output_writer, "package wayland\n")

	namespaces, _ := slice.map_keys(ctx_map)
	slice.sort(namespaces)
	for namespace in namespaces {
		fmt.wprintfln(output_writer, "import \"%v\"", namespace)
	}
	fmt.wprintln(output_writer, "\nEvent :: union {")

	fmt.wprint(output_writer, strings.to_string(event_union_builder))
	fmt.wprintln(output_writer,  "}")

	fmt.wprintln(output_writer, "parse_event :: proc(connection: ^Connection, object: u32, object_type: Object_Type, opcode: u32) -> (event: Event, ok: bool) {")
	fmt.wprintln(output_writer, "\tswitch object_type {")
	fmt.wprintln(output_writer, strings.to_string(parser_builder))
	fmt.wprintln(output_writer, "\tcase:")
	fmt.wprintln(output_writer, "\t\treturn")
	fmt.wprintln(output_writer, "\t}")
	fmt.wprintln(output_writer, "}\n")

	fmt.wprintln(output_writer, "resolve_type :: proc(t: typeid, interface: string, location := #caller_location) -> (type: Object_Type) {")
	fmt.wprintln(output_writer, "\tswitch t {")
	fmt.wprintln(output_writer, strings.to_string(resolution_builder))
	fmt.wprintln(output_writer, "\tcase:")
	fmt.wprintln(output_writer, "\t\tpanic(\"Invalid type\", location)")
	fmt.wprintln(output_writer, "\t}")
	fmt.wprintln(output_writer, "}")
}
