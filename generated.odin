package wayland

import "ext"
import "wl"
import "wp"
import "zwp"
import "xdg"
import "xwayland"

Event :: union {
	wl.Display_Error_Event,
	wl.Display_Delete_Id_Event,
	wl.Registry_Global_Event,
	wl.Registry_Global_Remove_Event,
	wl.Callback_Done_Event,
	wl.Shm_Format_Event,
	wl.Buffer_Release_Event,
	wl.Data_Offer_Offer_Event,
	wl.Data_Offer_Source_Actions_Event,
	wl.Data_Offer_Action_Event,
	wl.Data_Source_Target_Event,
	wl.Data_Source_Send_Event,
	wl.Data_Source_Cancelled_Event,
	wl.Data_Source_Dnd_Drop_Performed_Event,
	wl.Data_Source_Dnd_Finished_Event,
	wl.Data_Source_Action_Event,
	wl.Data_Device_Data_Offer_Event,
	wl.Data_Device_Enter_Event,
	wl.Data_Device_Leave_Event,
	wl.Data_Device_Motion_Event,
	wl.Data_Device_Drop_Event,
	wl.Data_Device_Selection_Event,
	wl.Shell_Surface_Ping_Event,
	wl.Shell_Surface_Configure_Event,
	wl.Shell_Surface_Popup_Done_Event,
	wl.Surface_Enter_Event,
	wl.Surface_Leave_Event,
	wl.Surface_Preferred_Buffer_Scale_Event,
	wl.Surface_Preferred_Buffer_Transform_Event,
	wl.Seat_Capabilities_Event,
	wl.Seat_Name_Event,
	wl.Pointer_Enter_Event,
	wl.Pointer_Leave_Event,
	wl.Pointer_Motion_Event,
	wl.Pointer_Button_Event,
	wl.Pointer_Axis_Event,
	wl.Pointer_Frame_Event,
	wl.Pointer_Axis_Source_Event,
	wl.Pointer_Axis_Stop_Event,
	wl.Pointer_Axis_Discrete_Event,
	wl.Pointer_Axis_Value120_Event,
	wl.Pointer_Axis_Relative_Direction_Event,
	wl.Keyboard_Keymap_Event,
	wl.Keyboard_Enter_Event,
	wl.Keyboard_Leave_Event,
	wl.Keyboard_Key_Event,
	wl.Keyboard_Modifiers_Event,
	wl.Keyboard_Repeat_Info_Event,
	wl.Touch_Down_Event,
	wl.Touch_Up_Event,
	wl.Touch_Motion_Event,
	wl.Touch_Frame_Event,
	wl.Touch_Cancel_Event,
	wl.Touch_Shape_Event,
	wl.Touch_Orientation_Event,
	wl.Output_Geometry_Event,
	wl.Output_Mode_Event,
	wl.Output_Done_Event,
	wl.Output_Scale_Event,
	wl.Output_Name_Event,
	wl.Output_Description_Event,
	zwp.Linux_Dmabuf_V1_Format_Event,
	zwp.Linux_Dmabuf_V1_Modifier_Event,
	zwp.Linux_Buffer_Params_V1_Created_Event,
	zwp.Linux_Buffer_Params_V1_Failed_Event,
	zwp.Linux_Dmabuf_Feedback_V1_Done_Event,
	zwp.Linux_Dmabuf_Feedback_V1_Format_Table_Event,
	zwp.Linux_Dmabuf_Feedback_V1_Main_Device_Event,
	zwp.Linux_Dmabuf_Feedback_V1_Tranche_Done_Event,
	zwp.Linux_Dmabuf_Feedback_V1_Tranche_Target_Device_Event,
	zwp.Linux_Dmabuf_Feedback_V1_Tranche_Formats_Event,
	zwp.Linux_Dmabuf_Feedback_V1_Tranche_Flags_Event,
	wp.Presentation_Clock_Id_Event,
	wp.Presentation_Feedback_Sync_Output_Event,
	wp.Presentation_Feedback_Presented_Event,
	wp.Presentation_Feedback_Discarded_Event,
	zwp.Tablet_Seat_V2_Tablet_Added_Event,
	zwp.Tablet_Seat_V2_Tool_Added_Event,
	zwp.Tablet_Seat_V2_Pad_Added_Event,
	zwp.Tablet_Tool_V2_Type_Event,
	zwp.Tablet_Tool_V2_Hardware_Serial_Event,
	zwp.Tablet_Tool_V2_Hardware_Id_Wacom_Event,
	zwp.Tablet_Tool_V2_Capability_Event,
	zwp.Tablet_Tool_V2_Done_Event,
	zwp.Tablet_Tool_V2_Removed_Event,
	zwp.Tablet_Tool_V2_Proximity_In_Event,
	zwp.Tablet_Tool_V2_Proximity_Out_Event,
	zwp.Tablet_Tool_V2_Down_Event,
	zwp.Tablet_Tool_V2_Up_Event,
	zwp.Tablet_Tool_V2_Motion_Event,
	zwp.Tablet_Tool_V2_Pressure_Event,
	zwp.Tablet_Tool_V2_Distance_Event,
	zwp.Tablet_Tool_V2_Tilt_Event,
	zwp.Tablet_Tool_V2_Rotation_Event,
	zwp.Tablet_Tool_V2_Slider_Event,
	zwp.Tablet_Tool_V2_Wheel_Event,
	zwp.Tablet_Tool_V2_Button_Event,
	zwp.Tablet_Tool_V2_Frame_Event,
	zwp.Tablet_V2_Name_Event,
	zwp.Tablet_V2_Id_Event,
	zwp.Tablet_V2_Path_Event,
	zwp.Tablet_V2_Done_Event,
	zwp.Tablet_V2_Removed_Event,
	zwp.Tablet_V2_Bustype_Event,
	zwp.Tablet_Pad_Ring_V2_Source_Event,
	zwp.Tablet_Pad_Ring_V2_Angle_Event,
	zwp.Tablet_Pad_Ring_V2_Stop_Event,
	zwp.Tablet_Pad_Ring_V2_Frame_Event,
	zwp.Tablet_Pad_Strip_V2_Source_Event,
	zwp.Tablet_Pad_Strip_V2_Position_Event,
	zwp.Tablet_Pad_Strip_V2_Stop_Event,
	zwp.Tablet_Pad_Strip_V2_Frame_Event,
	zwp.Tablet_Pad_Group_V2_Buttons_Event,
	zwp.Tablet_Pad_Group_V2_Ring_Event,
	zwp.Tablet_Pad_Group_V2_Strip_Event,
	zwp.Tablet_Pad_Group_V2_Modes_Event,
	zwp.Tablet_Pad_Group_V2_Done_Event,
	zwp.Tablet_Pad_Group_V2_Mode_Switch_Event,
	zwp.Tablet_Pad_Group_V2_Dial_Event,
	zwp.Tablet_Pad_V2_Group_Event,
	zwp.Tablet_Pad_V2_Path_Event,
	zwp.Tablet_Pad_V2_Buttons_Event,
	zwp.Tablet_Pad_V2_Done_Event,
	zwp.Tablet_Pad_V2_Button_Event,
	zwp.Tablet_Pad_V2_Enter_Event,
	zwp.Tablet_Pad_V2_Leave_Event,
	zwp.Tablet_Pad_V2_Removed_Event,
	zwp.Tablet_Pad_Dial_V2_Delta_Event,
	zwp.Tablet_Pad_Dial_V2_Frame_Event,
	xdg.Wm_Base_Ping_Event,
	xdg.Surface_Configure_Event,
	xdg.Toplevel_Configure_Event,
	xdg.Toplevel_Close_Event,
	xdg.Toplevel_Configure_Bounds_Event,
	xdg.Toplevel_Wm_Capabilities_Event,
	xdg.Popup_Configure_Event,
	xdg.Popup_Popup_Done_Event,
	xdg.Popup_Repositioned_Event,
	wp.Color_Manager_V1_Supported_Intent_Event,
	wp.Color_Manager_V1_Supported_Feature_Event,
	wp.Color_Manager_V1_Supported_Tf_Named_Event,
	wp.Color_Manager_V1_Supported_Primaries_Named_Event,
	wp.Color_Manager_V1_Done_Event,
	wp.Color_Management_Output_V1_Image_Description_Changed_Event,
	wp.Color_Management_Surface_Feedback_V1_Preferred_Changed_Event,
	wp.Color_Management_Surface_Feedback_V1_Preferred_Changed2_Event,
	wp.Image_Description_V1_Failed_Event,
	wp.Image_Description_V1_Ready_Event,
	wp.Image_Description_V1_Ready2_Event,
	wp.Image_Description_Info_V1_Done_Event,
	wp.Image_Description_Info_V1_Icc_File_Event,
	wp.Image_Description_Info_V1_Primaries_Event,
	wp.Image_Description_Info_V1_Primaries_Named_Event,
	wp.Image_Description_Info_V1_Tf_Power_Event,
	wp.Image_Description_Info_V1_Tf_Named_Event,
	wp.Image_Description_Info_V1_Luminances_Event,
	wp.Image_Description_Info_V1_Target_Primaries_Event,
	wp.Image_Description_Info_V1_Target_Luminance_Event,
	wp.Image_Description_Info_V1_Target_Max_Cll_Event,
	wp.Image_Description_Info_V1_Target_Max_Fall_Event,
	wp.Color_Representation_Manager_V1_Supported_Alpha_Mode_Event,
	wp.Color_Representation_Manager_V1_Supported_Coefficients_And_Ranges_Event,
	wp.Color_Representation_Manager_V1_Done_Event,
	wp.Drm_Lease_Device_V1_Drm_Fd_Event,
	wp.Drm_Lease_Device_V1_Connector_Event,
	wp.Drm_Lease_Device_V1_Done_Event,
	wp.Drm_Lease_Device_V1_Released_Event,
	wp.Drm_Lease_Connector_V1_Name_Event,
	wp.Drm_Lease_Connector_V1_Description_Event,
	wp.Drm_Lease_Connector_V1_Connector_Id_Event,
	wp.Drm_Lease_Connector_V1_Done_Event,
	wp.Drm_Lease_Connector_V1_Withdrawn_Event,
	wp.Drm_Lease_V1_Lease_Fd_Event,
	wp.Drm_Lease_V1_Finished_Event,
	ext.Background_Effect_Manager_V1_Capabilities_Event,
	ext.Data_Control_Device_V1_Data_Offer_Event,
	ext.Data_Control_Device_V1_Selection_Event,
	ext.Data_Control_Device_V1_Finished_Event,
	ext.Data_Control_Device_V1_Primary_Selection_Event,
	ext.Data_Control_Source_V1_Send_Event,
	ext.Data_Control_Source_V1_Cancelled_Event,
	ext.Data_Control_Offer_V1_Offer_Event,
	ext.Foreign_Toplevel_List_V1_Toplevel_Event,
	ext.Foreign_Toplevel_List_V1_Finished_Event,
	ext.Foreign_Toplevel_Handle_V1_Closed_Event,
	ext.Foreign_Toplevel_Handle_V1_Done_Event,
	ext.Foreign_Toplevel_Handle_V1_Title_Event,
	ext.Foreign_Toplevel_Handle_V1_App_Id_Event,
	ext.Foreign_Toplevel_Handle_V1_Identifier_Event,
	ext.Idle_Notification_V1_Idled_Event,
	ext.Idle_Notification_V1_Resumed_Event,
	ext.Image_Copy_Capture_Session_V1_Buffer_Size_Event,
	ext.Image_Copy_Capture_Session_V1_Shm_Format_Event,
	ext.Image_Copy_Capture_Session_V1_Dmabuf_Device_Event,
	ext.Image_Copy_Capture_Session_V1_Dmabuf_Format_Event,
	ext.Image_Copy_Capture_Session_V1_Done_Event,
	ext.Image_Copy_Capture_Session_V1_Stopped_Event,
	ext.Image_Copy_Capture_Frame_V1_Transform_Event,
	ext.Image_Copy_Capture_Frame_V1_Damage_Event,
	ext.Image_Copy_Capture_Frame_V1_Presentation_Time_Event,
	ext.Image_Copy_Capture_Frame_V1_Ready_Event,
	ext.Image_Copy_Capture_Frame_V1_Failed_Event,
	ext.Image_Copy_Capture_Cursor_Session_V1_Enter_Event,
	ext.Image_Copy_Capture_Cursor_Session_V1_Leave_Event,
	ext.Image_Copy_Capture_Cursor_Session_V1_Position_Event,
	ext.Image_Copy_Capture_Cursor_Session_V1_Hotspot_Event,
	ext.Session_Lock_V1_Locked_Event,
	ext.Session_Lock_V1_Finished_Event,
	ext.Session_Lock_Surface_V1_Configure_Event,
	ext.Transient_Seat_V1_Ready_Event,
	ext.Transient_Seat_V1_Denied_Event,
	ext.Workspace_Manager_V1_Workspace_Group_Event,
	ext.Workspace_Manager_V1_Workspace_Event,
	ext.Workspace_Manager_V1_Done_Event,
	ext.Workspace_Manager_V1_Finished_Event,
	ext.Workspace_Group_Handle_V1_Capabilities_Event,
	ext.Workspace_Group_Handle_V1_Output_Enter_Event,
	ext.Workspace_Group_Handle_V1_Output_Leave_Event,
	ext.Workspace_Group_Handle_V1_Workspace_Enter_Event,
	ext.Workspace_Group_Handle_V1_Workspace_Leave_Event,
	ext.Workspace_Group_Handle_V1_Removed_Event,
	ext.Workspace_Handle_V1_Id_Event,
	ext.Workspace_Handle_V1_Name_Event,
	ext.Workspace_Handle_V1_Coordinates_Event,
	ext.Workspace_Handle_V1_State_Event,
	ext.Workspace_Handle_V1_Capabilities_Event,
	ext.Workspace_Handle_V1_Removed_Event,
	wp.Fractional_Scale_V1_Preferred_Scale_Event,
	xdg.Activation_Token_V1_Done_Event,
	xdg.Toplevel_Icon_Manager_V1_Icon_Size_Event,
	xdg.Toplevel_Icon_Manager_V1_Done_Event,
}
parse_event :: proc(connection: ^Connection, object: u32, object_type: Object_Type, opcode: u32) -> (event: Event, ok: bool) {
	switch object_type {
	case .Wl_Display:
		switch opcode {
		case 0:
			return wl.parse_display_error(connection, object)
		case 1:
			return wl.parse_display_delete_id(connection, object)
		case:
			return
		}
	case .Wl_Registry:
		switch opcode {
		case 0:
			return wl.parse_registry_global(connection, object)
		case 1:
			return wl.parse_registry_global_remove(connection, object)
		case:
			return
		}
	case .Wl_Callback:
		switch opcode {
		case 0:
			return wl.parse_callback_done(connection, object)
		case:
			return
		}
	case .Wl_Compositor:
		switch opcode {
		case:
			return
		}
	case .Wl_Shm_Pool:
		switch opcode {
		case:
			return
		}
	case .Wl_Shm:
		switch opcode {
		case 0:
			return wl.parse_shm_format(connection, object)
		case:
			return
		}
	case .Wl_Buffer:
		switch opcode {
		case 0:
			return wl.parse_buffer_release(connection, object)
		case:
			return
		}
	case .Wl_Data_Offer:
		switch opcode {
		case 0:
			return wl.parse_data_offer_offer(connection, object)
		case 1:
			return wl.parse_data_offer_source_actions(connection, object)
		case 2:
			return wl.parse_data_offer_action(connection, object)
		case:
			return
		}
	case .Wl_Data_Source:
		switch opcode {
		case 0:
			return wl.parse_data_source_target(connection, object)
		case 1:
			return wl.parse_data_source_send(connection, object)
		case 2:
			return wl.parse_data_source_cancelled(connection, object)
		case 3:
			return wl.parse_data_source_dnd_drop_performed(connection, object)
		case 4:
			return wl.parse_data_source_dnd_finished(connection, object)
		case 5:
			return wl.parse_data_source_action(connection, object)
		case:
			return
		}
	case .Wl_Data_Device:
		switch opcode {
		case 0:
			return wl.parse_data_device_data_offer(connection, object)
		case 1:
			return wl.parse_data_device_enter(connection, object)
		case 2:
			return wl.parse_data_device_leave(connection, object)
		case 3:
			return wl.parse_data_device_motion(connection, object)
		case 4:
			return wl.parse_data_device_drop(connection, object)
		case 5:
			return wl.parse_data_device_selection(connection, object)
		case:
			return
		}
	case .Wl_Data_Device_Manager:
		switch opcode {
		case:
			return
		}
	case .Wl_Shell:
		switch opcode {
		case:
			return
		}
	case .Wl_Shell_Surface:
		switch opcode {
		case 0:
			return wl.parse_shell_surface_ping(connection, object)
		case 1:
			return wl.parse_shell_surface_configure(connection, object)
		case 2:
			return wl.parse_shell_surface_popup_done(connection, object)
		case:
			return
		}
	case .Wl_Surface:
		switch opcode {
		case 0:
			return wl.parse_surface_enter(connection, object)
		case 1:
			return wl.parse_surface_leave(connection, object)
		case 2:
			return wl.parse_surface_preferred_buffer_scale(connection, object)
		case 3:
			return wl.parse_surface_preferred_buffer_transform(connection, object)
		case:
			return
		}
	case .Wl_Seat:
		switch opcode {
		case 0:
			return wl.parse_seat_capabilities(connection, object)
		case 1:
			return wl.parse_seat_name(connection, object)
		case:
			return
		}
	case .Wl_Pointer:
		switch opcode {
		case 0:
			return wl.parse_pointer_enter(connection, object)
		case 1:
			return wl.parse_pointer_leave(connection, object)
		case 2:
			return wl.parse_pointer_motion(connection, object)
		case 3:
			return wl.parse_pointer_button(connection, object)
		case 4:
			return wl.parse_pointer_axis(connection, object)
		case 5:
			return wl.parse_pointer_frame(connection, object)
		case 6:
			return wl.parse_pointer_axis_source(connection, object)
		case 7:
			return wl.parse_pointer_axis_stop(connection, object)
		case 8:
			return wl.parse_pointer_axis_discrete(connection, object)
		case 9:
			return wl.parse_pointer_axis_value120(connection, object)
		case 10:
			return wl.parse_pointer_axis_relative_direction(connection, object)
		case:
			return
		}
	case .Wl_Keyboard:
		switch opcode {
		case 0:
			return wl.parse_keyboard_keymap(connection, object)
		case 1:
			return wl.parse_keyboard_enter(connection, object)
		case 2:
			return wl.parse_keyboard_leave(connection, object)
		case 3:
			return wl.parse_keyboard_key(connection, object)
		case 4:
			return wl.parse_keyboard_modifiers(connection, object)
		case 5:
			return wl.parse_keyboard_repeat_info(connection, object)
		case:
			return
		}
	case .Wl_Touch:
		switch opcode {
		case 0:
			return wl.parse_touch_down(connection, object)
		case 1:
			return wl.parse_touch_up(connection, object)
		case 2:
			return wl.parse_touch_motion(connection, object)
		case 3:
			return wl.parse_touch_frame(connection, object)
		case 4:
			return wl.parse_touch_cancel(connection, object)
		case 5:
			return wl.parse_touch_shape(connection, object)
		case 6:
			return wl.parse_touch_orientation(connection, object)
		case:
			return
		}
	case .Wl_Output:
		switch opcode {
		case 0:
			return wl.parse_output_geometry(connection, object)
		case 1:
			return wl.parse_output_mode(connection, object)
		case 2:
			return wl.parse_output_done(connection, object)
		case 3:
			return wl.parse_output_scale(connection, object)
		case 4:
			return wl.parse_output_name(connection, object)
		case 5:
			return wl.parse_output_description(connection, object)
		case:
			return
		}
	case .Wl_Region:
		switch opcode {
		case:
			return
		}
	case .Wl_Subcompositor:
		switch opcode {
		case:
			return
		}
	case .Wl_Subsurface:
		switch opcode {
		case:
			return
		}
	case .Wl_Fixes:
		switch opcode {
		case:
			return
		}
	case .Zwp_Linux_Dmabuf_V1:
		switch opcode {
		case 0:
			return zwp.parse_linux_dmabuf_v1_format(connection, object)
		case 1:
			return zwp.parse_linux_dmabuf_v1_modifier(connection, object)
		case:
			return
		}
	case .Zwp_Linux_Buffer_Params_V1:
		switch opcode {
		case 0:
			return zwp.parse_linux_buffer_params_v1_created(connection, object)
		case 1:
			return zwp.parse_linux_buffer_params_v1_failed(connection, object)
		case:
			return
		}
	case .Zwp_Linux_Dmabuf_Feedback_V1:
		switch opcode {
		case 0:
			return zwp.parse_linux_dmabuf_feedback_v1_done(connection, object)
		case 1:
			return zwp.parse_linux_dmabuf_feedback_v1_format_table(connection, object)
		case 2:
			return zwp.parse_linux_dmabuf_feedback_v1_main_device(connection, object)
		case 3:
			return zwp.parse_linux_dmabuf_feedback_v1_tranche_done(connection, object)
		case 4:
			return zwp.parse_linux_dmabuf_feedback_v1_tranche_target_device(connection, object)
		case 5:
			return zwp.parse_linux_dmabuf_feedback_v1_tranche_formats(connection, object)
		case 6:
			return zwp.parse_linux_dmabuf_feedback_v1_tranche_flags(connection, object)
		case:
			return
		}
	case .Wp_Presentation:
		switch opcode {
		case 0:
			return wp.parse_presentation_clock_id(connection, object)
		case:
			return
		}
	case .Wp_Presentation_Feedback:
		switch opcode {
		case 0:
			return wp.parse_presentation_feedback_sync_output(connection, object)
		case 1:
			return wp.parse_presentation_feedback_presented(connection, object)
		case 2:
			return wp.parse_presentation_feedback_discarded(connection, object)
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
			return zwp.parse_tablet_seat_v2_tablet_added(connection, object)
		case 1:
			return zwp.parse_tablet_seat_v2_tool_added(connection, object)
		case 2:
			return zwp.parse_tablet_seat_v2_pad_added(connection, object)
		case:
			return
		}
	case .Zwp_Tablet_Tool_V2:
		switch opcode {
		case 0:
			return zwp.parse_tablet_tool_v2_type(connection, object)
		case 1:
			return zwp.parse_tablet_tool_v2_hardware_serial(connection, object)
		case 2:
			return zwp.parse_tablet_tool_v2_hardware_id_wacom(connection, object)
		case 3:
			return zwp.parse_tablet_tool_v2_capability(connection, object)
		case 4:
			return zwp.parse_tablet_tool_v2_done(connection, object)
		case 5:
			return zwp.parse_tablet_tool_v2_removed(connection, object)
		case 6:
			return zwp.parse_tablet_tool_v2_proximity_in(connection, object)
		case 7:
			return zwp.parse_tablet_tool_v2_proximity_out(connection, object)
		case 8:
			return zwp.parse_tablet_tool_v2_down(connection, object)
		case 9:
			return zwp.parse_tablet_tool_v2_up(connection, object)
		case 10:
			return zwp.parse_tablet_tool_v2_motion(connection, object)
		case 11:
			return zwp.parse_tablet_tool_v2_pressure(connection, object)
		case 12:
			return zwp.parse_tablet_tool_v2_distance(connection, object)
		case 13:
			return zwp.parse_tablet_tool_v2_tilt(connection, object)
		case 14:
			return zwp.parse_tablet_tool_v2_rotation(connection, object)
		case 15:
			return zwp.parse_tablet_tool_v2_slider(connection, object)
		case 16:
			return zwp.parse_tablet_tool_v2_wheel(connection, object)
		case 17:
			return zwp.parse_tablet_tool_v2_button(connection, object)
		case 18:
			return zwp.parse_tablet_tool_v2_frame(connection, object)
		case:
			return
		}
	case .Zwp_Tablet_V2:
		switch opcode {
		case 0:
			return zwp.parse_tablet_v2_name(connection, object)
		case 1:
			return zwp.parse_tablet_v2_id(connection, object)
		case 2:
			return zwp.parse_tablet_v2_path(connection, object)
		case 3:
			return zwp.parse_tablet_v2_done(connection, object)
		case 4:
			return zwp.parse_tablet_v2_removed(connection, object)
		case 5:
			return zwp.parse_tablet_v2_bustype(connection, object)
		case:
			return
		}
	case .Zwp_Tablet_Pad_Ring_V2:
		switch opcode {
		case 0:
			return zwp.parse_tablet_pad_ring_v2_source(connection, object)
		case 1:
			return zwp.parse_tablet_pad_ring_v2_angle(connection, object)
		case 2:
			return zwp.parse_tablet_pad_ring_v2_stop(connection, object)
		case 3:
			return zwp.parse_tablet_pad_ring_v2_frame(connection, object)
		case:
			return
		}
	case .Zwp_Tablet_Pad_Strip_V2:
		switch opcode {
		case 0:
			return zwp.parse_tablet_pad_strip_v2_source(connection, object)
		case 1:
			return zwp.parse_tablet_pad_strip_v2_position(connection, object)
		case 2:
			return zwp.parse_tablet_pad_strip_v2_stop(connection, object)
		case 3:
			return zwp.parse_tablet_pad_strip_v2_frame(connection, object)
		case:
			return
		}
	case .Zwp_Tablet_Pad_Group_V2:
		switch opcode {
		case 0:
			return zwp.parse_tablet_pad_group_v2_buttons(connection, object)
		case 1:
			return zwp.parse_tablet_pad_group_v2_ring(connection, object)
		case 2:
			return zwp.parse_tablet_pad_group_v2_strip(connection, object)
		case 3:
			return zwp.parse_tablet_pad_group_v2_modes(connection, object)
		case 4:
			return zwp.parse_tablet_pad_group_v2_done(connection, object)
		case 5:
			return zwp.parse_tablet_pad_group_v2_mode_switch(connection, object)
		case 6:
			return zwp.parse_tablet_pad_group_v2_dial(connection, object)
		case:
			return
		}
	case .Zwp_Tablet_Pad_V2:
		switch opcode {
		case 0:
			return zwp.parse_tablet_pad_v2_group(connection, object)
		case 1:
			return zwp.parse_tablet_pad_v2_path(connection, object)
		case 2:
			return zwp.parse_tablet_pad_v2_buttons(connection, object)
		case 3:
			return zwp.parse_tablet_pad_v2_done(connection, object)
		case 4:
			return zwp.parse_tablet_pad_v2_button(connection, object)
		case 5:
			return zwp.parse_tablet_pad_v2_enter(connection, object)
		case 6:
			return zwp.parse_tablet_pad_v2_leave(connection, object)
		case 7:
			return zwp.parse_tablet_pad_v2_removed(connection, object)
		case:
			return
		}
	case .Zwp_Tablet_Pad_Dial_V2:
		switch opcode {
		case 0:
			return zwp.parse_tablet_pad_dial_v2_delta(connection, object)
		case 1:
			return zwp.parse_tablet_pad_dial_v2_frame(connection, object)
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
			return xdg.parse_wm_base_ping(connection, object)
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
			return xdg.parse_surface_configure(connection, object)
		case:
			return
		}
	case .Xdg_Toplevel:
		switch opcode {
		case 0:
			return xdg.parse_toplevel_configure(connection, object)
		case 1:
			return xdg.parse_toplevel_close(connection, object)
		case 2:
			return xdg.parse_toplevel_configure_bounds(connection, object)
		case 3:
			return xdg.parse_toplevel_wm_capabilities(connection, object)
		case:
			return
		}
	case .Xdg_Popup:
		switch opcode {
		case 0:
			return xdg.parse_popup_configure(connection, object)
		case 1:
			return xdg.parse_popup_popup_done(connection, object)
		case 2:
			return xdg.parse_popup_repositioned(connection, object)
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
			return wp.parse_color_manager_v1_supported_intent(connection, object)
		case 1:
			return wp.parse_color_manager_v1_supported_feature(connection, object)
		case 2:
			return wp.parse_color_manager_v1_supported_tf_named(connection, object)
		case 3:
			return wp.parse_color_manager_v1_supported_primaries_named(connection, object)
		case 4:
			return wp.parse_color_manager_v1_done(connection, object)
		case:
			return
		}
	case .Wp_Color_Management_Output_V1:
		switch opcode {
		case 0:
			return wp.parse_color_management_output_v1_image_description_changed(connection, object)
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
			return wp.parse_color_management_surface_feedback_v1_preferred_changed(connection, object)
		case 1:
			return wp.parse_color_management_surface_feedback_v1_preferred_changed2(connection, object)
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
			return wp.parse_image_description_v1_failed(connection, object)
		case 1:
			return wp.parse_image_description_v1_ready(connection, object)
		case 2:
			return wp.parse_image_description_v1_ready2(connection, object)
		case:
			return
		}
	case .Wp_Image_Description_Info_V1:
		switch opcode {
		case 0:
			return wp.parse_image_description_info_v1_done(connection, object)
		case 1:
			return wp.parse_image_description_info_v1_icc_file(connection, object)
		case 2:
			return wp.parse_image_description_info_v1_primaries(connection, object)
		case 3:
			return wp.parse_image_description_info_v1_primaries_named(connection, object)
		case 4:
			return wp.parse_image_description_info_v1_tf_power(connection, object)
		case 5:
			return wp.parse_image_description_info_v1_tf_named(connection, object)
		case 6:
			return wp.parse_image_description_info_v1_luminances(connection, object)
		case 7:
			return wp.parse_image_description_info_v1_target_primaries(connection, object)
		case 8:
			return wp.parse_image_description_info_v1_target_luminance(connection, object)
		case 9:
			return wp.parse_image_description_info_v1_target_max_cll(connection, object)
		case 10:
			return wp.parse_image_description_info_v1_target_max_fall(connection, object)
		case:
			return
		}
	case .Wp_Image_Description_Reference_V1:
		switch opcode {
		case:
			return
		}
	case .Wp_Color_Representation_Manager_V1:
		switch opcode {
		case 0:
			return wp.parse_color_representation_manager_v1_supported_alpha_mode(connection, object)
		case 1:
			return wp.parse_color_representation_manager_v1_supported_coefficients_and_ranges(connection, object)
		case 2:
			return wp.parse_color_representation_manager_v1_done(connection, object)
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
			return wp.parse_drm_lease_device_v1_drm_fd(connection, object)
		case 1:
			return wp.parse_drm_lease_device_v1_connector(connection, object)
		case 2:
			return wp.parse_drm_lease_device_v1_done(connection, object)
		case 3:
			return wp.parse_drm_lease_device_v1_released(connection, object)
		case:
			return
		}
	case .Wp_Drm_Lease_Connector_V1:
		switch opcode {
		case 0:
			return wp.parse_drm_lease_connector_v1_name(connection, object)
		case 1:
			return wp.parse_drm_lease_connector_v1_description(connection, object)
		case 2:
			return wp.parse_drm_lease_connector_v1_connector_id(connection, object)
		case 3:
			return wp.parse_drm_lease_connector_v1_done(connection, object)
		case 4:
			return wp.parse_drm_lease_connector_v1_withdrawn(connection, object)
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
			return wp.parse_drm_lease_v1_lease_fd(connection, object)
		case 1:
			return wp.parse_drm_lease_v1_finished(connection, object)
		case:
			return
		}
	case .Ext_Background_Effect_Manager_V1:
		switch opcode {
		case 0:
			return ext.parse_background_effect_manager_v1_capabilities(connection, object)
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
			return ext.parse_data_control_device_v1_data_offer(connection, object)
		case 1:
			return ext.parse_data_control_device_v1_selection(connection, object)
		case 2:
			return ext.parse_data_control_device_v1_finished(connection, object)
		case 3:
			return ext.parse_data_control_device_v1_primary_selection(connection, object)
		case:
			return
		}
	case .Ext_Data_Control_Source_V1:
		switch opcode {
		case 0:
			return ext.parse_data_control_source_v1_send(connection, object)
		case 1:
			return ext.parse_data_control_source_v1_cancelled(connection, object)
		case:
			return
		}
	case .Ext_Data_Control_Offer_V1:
		switch opcode {
		case 0:
			return ext.parse_data_control_offer_v1_offer(connection, object)
		case:
			return
		}
	case .Ext_Foreign_Toplevel_List_V1:
		switch opcode {
		case 0:
			return ext.parse_foreign_toplevel_list_v1_toplevel(connection, object)
		case 1:
			return ext.parse_foreign_toplevel_list_v1_finished(connection, object)
		case:
			return
		}
	case .Ext_Foreign_Toplevel_Handle_V1:
		switch opcode {
		case 0:
			return ext.parse_foreign_toplevel_handle_v1_closed(connection, object)
		case 1:
			return ext.parse_foreign_toplevel_handle_v1_done(connection, object)
		case 2:
			return ext.parse_foreign_toplevel_handle_v1_title(connection, object)
		case 3:
			return ext.parse_foreign_toplevel_handle_v1_app_id(connection, object)
		case 4:
			return ext.parse_foreign_toplevel_handle_v1_identifier(connection, object)
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
			return ext.parse_idle_notification_v1_idled(connection, object)
		case 1:
			return ext.parse_idle_notification_v1_resumed(connection, object)
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
			return ext.parse_image_copy_capture_session_v1_buffer_size(connection, object)
		case 1:
			return ext.parse_image_copy_capture_session_v1_shm_format(connection, object)
		case 2:
			return ext.parse_image_copy_capture_session_v1_dmabuf_device(connection, object)
		case 3:
			return ext.parse_image_copy_capture_session_v1_dmabuf_format(connection, object)
		case 4:
			return ext.parse_image_copy_capture_session_v1_done(connection, object)
		case 5:
			return ext.parse_image_copy_capture_session_v1_stopped(connection, object)
		case:
			return
		}
	case .Ext_Image_Copy_Capture_Frame_V1:
		switch opcode {
		case 0:
			return ext.parse_image_copy_capture_frame_v1_transform(connection, object)
		case 1:
			return ext.parse_image_copy_capture_frame_v1_damage(connection, object)
		case 2:
			return ext.parse_image_copy_capture_frame_v1_presentation_time(connection, object)
		case 3:
			return ext.parse_image_copy_capture_frame_v1_ready(connection, object)
		case 4:
			return ext.parse_image_copy_capture_frame_v1_failed(connection, object)
		case:
			return
		}
	case .Ext_Image_Copy_Capture_Cursor_Session_V1:
		switch opcode {
		case 0:
			return ext.parse_image_copy_capture_cursor_session_v1_enter(connection, object)
		case 1:
			return ext.parse_image_copy_capture_cursor_session_v1_leave(connection, object)
		case 2:
			return ext.parse_image_copy_capture_cursor_session_v1_position(connection, object)
		case 3:
			return ext.parse_image_copy_capture_cursor_session_v1_hotspot(connection, object)
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
			return ext.parse_session_lock_v1_locked(connection, object)
		case 1:
			return ext.parse_session_lock_v1_finished(connection, object)
		case:
			return
		}
	case .Ext_Session_Lock_Surface_V1:
		switch opcode {
		case 0:
			return ext.parse_session_lock_surface_v1_configure(connection, object)
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
			return ext.parse_transient_seat_v1_ready(connection, object)
		case 1:
			return ext.parse_transient_seat_v1_denied(connection, object)
		case:
			return
		}
	case .Ext_Workspace_Manager_V1:
		switch opcode {
		case 0:
			return ext.parse_workspace_manager_v1_workspace_group(connection, object)
		case 1:
			return ext.parse_workspace_manager_v1_workspace(connection, object)
		case 2:
			return ext.parse_workspace_manager_v1_done(connection, object)
		case 3:
			return ext.parse_workspace_manager_v1_finished(connection, object)
		case:
			return
		}
	case .Ext_Workspace_Group_Handle_V1:
		switch opcode {
		case 0:
			return ext.parse_workspace_group_handle_v1_capabilities(connection, object)
		case 1:
			return ext.parse_workspace_group_handle_v1_output_enter(connection, object)
		case 2:
			return ext.parse_workspace_group_handle_v1_output_leave(connection, object)
		case 3:
			return ext.parse_workspace_group_handle_v1_workspace_enter(connection, object)
		case 4:
			return ext.parse_workspace_group_handle_v1_workspace_leave(connection, object)
		case 5:
			return ext.parse_workspace_group_handle_v1_removed(connection, object)
		case:
			return
		}
	case .Ext_Workspace_Handle_V1:
		switch opcode {
		case 0:
			return ext.parse_workspace_handle_v1_id(connection, object)
		case 1:
			return ext.parse_workspace_handle_v1_name(connection, object)
		case 2:
			return ext.parse_workspace_handle_v1_coordinates(connection, object)
		case 3:
			return ext.parse_workspace_handle_v1_state(connection, object)
		case 4:
			return ext.parse_workspace_handle_v1_capabilities(connection, object)
		case 5:
			return ext.parse_workspace_handle_v1_removed(connection, object)
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
			return wp.parse_fractional_scale_v1_preferred_scale(connection, object)
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
			return xdg.parse_activation_token_v1_done(connection, object)
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
			return xdg.parse_toplevel_icon_manager_v1_icon_size(connection, object)
		case 1:
			return xdg.parse_toplevel_icon_manager_v1_done(connection, object)
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

resolve_type :: proc(t: typeid, interface: string, location := #caller_location) -> (type: Object_Type) {
	switch t {
	case wl.Display:
		assert(interface == "wl_display")
		return .Wl_Display
	case wl.Registry:
		assert(interface == "wl_registry")
		return .Wl_Registry
	case wl.Callback:
		assert(interface == "wl_callback")
		return .Wl_Callback
	case wl.Compositor:
		assert(interface == "wl_compositor")
		return .Wl_Compositor
	case wl.Shm_Pool:
		assert(interface == "wl_shm_pool")
		return .Wl_Shm_Pool
	case wl.Shm:
		assert(interface == "wl_shm")
		return .Wl_Shm
	case wl.Buffer:
		assert(interface == "wl_buffer")
		return .Wl_Buffer
	case wl.Data_Offer:
		assert(interface == "wl_data_offer")
		return .Wl_Data_Offer
	case wl.Data_Source:
		assert(interface == "wl_data_source")
		return .Wl_Data_Source
	case wl.Data_Device:
		assert(interface == "wl_data_device")
		return .Wl_Data_Device
	case wl.Data_Device_Manager:
		assert(interface == "wl_data_device_manager")
		return .Wl_Data_Device_Manager
	case wl.Shell:
		assert(interface == "wl_shell")
		return .Wl_Shell
	case wl.Shell_Surface:
		assert(interface == "wl_shell_surface")
		return .Wl_Shell_Surface
	case wl.Surface:
		assert(interface == "wl_surface")
		return .Wl_Surface
	case wl.Seat:
		assert(interface == "wl_seat")
		return .Wl_Seat
	case wl.Pointer:
		assert(interface == "wl_pointer")
		return .Wl_Pointer
	case wl.Keyboard:
		assert(interface == "wl_keyboard")
		return .Wl_Keyboard
	case wl.Touch:
		assert(interface == "wl_touch")
		return .Wl_Touch
	case wl.Output:
		assert(interface == "wl_output")
		return .Wl_Output
	case wl.Region:
		assert(interface == "wl_region")
		return .Wl_Region
	case wl.Subcompositor:
		assert(interface == "wl_subcompositor")
		return .Wl_Subcompositor
	case wl.Subsurface:
		assert(interface == "wl_subsurface")
		return .Wl_Subsurface
	case wl.Fixes:
		assert(interface == "wl_fixes")
		return .Wl_Fixes
	case zwp.Linux_Dmabuf_V1:
		assert(interface == "zwp_linux_dmabuf_v1")
		return .Zwp_Linux_Dmabuf_V1
	case zwp.Linux_Buffer_Params_V1:
		assert(interface == "zwp_linux_buffer_params_v1")
		return .Zwp_Linux_Buffer_Params_V1
	case zwp.Linux_Dmabuf_Feedback_V1:
		assert(interface == "zwp_linux_dmabuf_feedback_v1")
		return .Zwp_Linux_Dmabuf_Feedback_V1
	case wp.Presentation:
		assert(interface == "wp_presentation")
		return .Wp_Presentation
	case wp.Presentation_Feedback:
		assert(interface == "wp_presentation_feedback")
		return .Wp_Presentation_Feedback
	case zwp.Tablet_Manager_V2:
		assert(interface == "zwp_tablet_manager_v2")
		return .Zwp_Tablet_Manager_V2
	case zwp.Tablet_Seat_V2:
		assert(interface == "zwp_tablet_seat_v2")
		return .Zwp_Tablet_Seat_V2
	case zwp.Tablet_Tool_V2:
		assert(interface == "zwp_tablet_tool_v2")
		return .Zwp_Tablet_Tool_V2
	case zwp.Tablet_V2:
		assert(interface == "zwp_tablet_v2")
		return .Zwp_Tablet_V2
	case zwp.Tablet_Pad_Ring_V2:
		assert(interface == "zwp_tablet_pad_ring_v2")
		return .Zwp_Tablet_Pad_Ring_V2
	case zwp.Tablet_Pad_Strip_V2:
		assert(interface == "zwp_tablet_pad_strip_v2")
		return .Zwp_Tablet_Pad_Strip_V2
	case zwp.Tablet_Pad_Group_V2:
		assert(interface == "zwp_tablet_pad_group_v2")
		return .Zwp_Tablet_Pad_Group_V2
	case zwp.Tablet_Pad_V2:
		assert(interface == "zwp_tablet_pad_v2")
		return .Zwp_Tablet_Pad_V2
	case zwp.Tablet_Pad_Dial_V2:
		assert(interface == "zwp_tablet_pad_dial_v2")
		return .Zwp_Tablet_Pad_Dial_V2
	case wp.Viewporter:
		assert(interface == "wp_viewporter")
		return .Wp_Viewporter
	case wp.Viewport:
		assert(interface == "wp_viewport")
		return .Wp_Viewport
	case xdg.Wm_Base:
		assert(interface == "xdg_wm_base")
		return .Xdg_Wm_Base
	case xdg.Positioner:
		assert(interface == "xdg_positioner")
		return .Xdg_Positioner
	case xdg.Surface:
		assert(interface == "xdg_surface")
		return .Xdg_Surface
	case xdg.Toplevel:
		assert(interface == "xdg_toplevel")
		return .Xdg_Toplevel
	case xdg.Popup:
		assert(interface == "xdg_popup")
		return .Xdg_Popup
	case wp.Alpha_Modifier_V1:
		assert(interface == "wp_alpha_modifier_v1")
		return .Wp_Alpha_Modifier_V1
	case wp.Alpha_Modifier_Surface_V1:
		assert(interface == "wp_alpha_modifier_surface_v1")
		return .Wp_Alpha_Modifier_Surface_V1
	case wp.Color_Manager_V1:
		assert(interface == "wp_color_manager_v1")
		return .Wp_Color_Manager_V1
	case wp.Color_Management_Output_V1:
		assert(interface == "wp_color_management_output_v1")
		return .Wp_Color_Management_Output_V1
	case wp.Color_Management_Surface_V1:
		assert(interface == "wp_color_management_surface_v1")
		return .Wp_Color_Management_Surface_V1
	case wp.Color_Management_Surface_Feedback_V1:
		assert(interface == "wp_color_management_surface_feedback_v1")
		return .Wp_Color_Management_Surface_Feedback_V1
	case wp.Image_Description_Creator_Icc_V1:
		assert(interface == "wp_image_description_creator_icc_v1")
		return .Wp_Image_Description_Creator_Icc_V1
	case wp.Image_Description_Creator_Params_V1:
		assert(interface == "wp_image_description_creator_params_v1")
		return .Wp_Image_Description_Creator_Params_V1
	case wp.Image_Description_V1:
		assert(interface == "wp_image_description_v1")
		return .Wp_Image_Description_V1
	case wp.Image_Description_Info_V1:
		assert(interface == "wp_image_description_info_v1")
		return .Wp_Image_Description_Info_V1
	case wp.Image_Description_Reference_V1:
		assert(interface == "wp_image_description_reference_v1")
		return .Wp_Image_Description_Reference_V1
	case wp.Color_Representation_Manager_V1:
		assert(interface == "wp_color_representation_manager_v1")
		return .Wp_Color_Representation_Manager_V1
	case wp.Color_Representation_Surface_V1:
		assert(interface == "wp_color_representation_surface_v1")
		return .Wp_Color_Representation_Surface_V1
	case wp.Commit_Timing_Manager_V1:
		assert(interface == "wp_commit_timing_manager_v1")
		return .Wp_Commit_Timing_Manager_V1
	case wp.Commit_Timer_V1:
		assert(interface == "wp_commit_timer_v1")
		return .Wp_Commit_Timer_V1
	case wp.Content_Type_Manager_V1:
		assert(interface == "wp_content_type_manager_v1")
		return .Wp_Content_Type_Manager_V1
	case wp.Content_Type_V1:
		assert(interface == "wp_content_type_v1")
		return .Wp_Content_Type_V1
	case wp.Cursor_Shape_Manager_V1:
		assert(interface == "wp_cursor_shape_manager_v1")
		return .Wp_Cursor_Shape_Manager_V1
	case wp.Cursor_Shape_Device_V1:
		assert(interface == "wp_cursor_shape_device_v1")
		return .Wp_Cursor_Shape_Device_V1
	case wp.Drm_Lease_Device_V1:
		assert(interface == "wp_drm_lease_device_v1")
		return .Wp_Drm_Lease_Device_V1
	case wp.Drm_Lease_Connector_V1:
		assert(interface == "wp_drm_lease_connector_v1")
		return .Wp_Drm_Lease_Connector_V1
	case wp.Drm_Lease_Request_V1:
		assert(interface == "wp_drm_lease_request_v1")
		return .Wp_Drm_Lease_Request_V1
	case wp.Drm_Lease_V1:
		assert(interface == "wp_drm_lease_v1")
		return .Wp_Drm_Lease_V1
	case ext.Background_Effect_Manager_V1:
		assert(interface == "ext_background_effect_manager_v1")
		return .Ext_Background_Effect_Manager_V1
	case ext.Background_Effect_Surface_V1:
		assert(interface == "ext_background_effect_surface_v1")
		return .Ext_Background_Effect_Surface_V1
	case ext.Data_Control_Manager_V1:
		assert(interface == "ext_data_control_manager_v1")
		return .Ext_Data_Control_Manager_V1
	case ext.Data_Control_Device_V1:
		assert(interface == "ext_data_control_device_v1")
		return .Ext_Data_Control_Device_V1
	case ext.Data_Control_Source_V1:
		assert(interface == "ext_data_control_source_v1")
		return .Ext_Data_Control_Source_V1
	case ext.Data_Control_Offer_V1:
		assert(interface == "ext_data_control_offer_v1")
		return .Ext_Data_Control_Offer_V1
	case ext.Foreign_Toplevel_List_V1:
		assert(interface == "ext_foreign_toplevel_list_v1")
		return .Ext_Foreign_Toplevel_List_V1
	case ext.Foreign_Toplevel_Handle_V1:
		assert(interface == "ext_foreign_toplevel_handle_v1")
		return .Ext_Foreign_Toplevel_Handle_V1
	case ext.Idle_Notifier_V1:
		assert(interface == "ext_idle_notifier_v1")
		return .Ext_Idle_Notifier_V1
	case ext.Idle_Notification_V1:
		assert(interface == "ext_idle_notification_v1")
		return .Ext_Idle_Notification_V1
	case ext.Image_Capture_Source_V1:
		assert(interface == "ext_image_capture_source_v1")
		return .Ext_Image_Capture_Source_V1
	case ext.Output_Image_Capture_Source_Manager_V1:
		assert(interface == "ext_output_image_capture_source_manager_v1")
		return .Ext_Output_Image_Capture_Source_Manager_V1
	case ext.Foreign_Toplevel_Image_Capture_Source_Manager_V1:
		assert(interface == "ext_foreign_toplevel_image_capture_source_manager_v1")
		return .Ext_Foreign_Toplevel_Image_Capture_Source_Manager_V1
	case ext.Image_Copy_Capture_Manager_V1:
		assert(interface == "ext_image_copy_capture_manager_v1")
		return .Ext_Image_Copy_Capture_Manager_V1
	case ext.Image_Copy_Capture_Session_V1:
		assert(interface == "ext_image_copy_capture_session_v1")
		return .Ext_Image_Copy_Capture_Session_V1
	case ext.Image_Copy_Capture_Frame_V1:
		assert(interface == "ext_image_copy_capture_frame_v1")
		return .Ext_Image_Copy_Capture_Frame_V1
	case ext.Image_Copy_Capture_Cursor_Session_V1:
		assert(interface == "ext_image_copy_capture_cursor_session_v1")
		return .Ext_Image_Copy_Capture_Cursor_Session_V1
	case ext.Session_Lock_Manager_V1:
		assert(interface == "ext_session_lock_manager_v1")
		return .Ext_Session_Lock_Manager_V1
	case ext.Session_Lock_V1:
		assert(interface == "ext_session_lock_v1")
		return .Ext_Session_Lock_V1
	case ext.Session_Lock_Surface_V1:
		assert(interface == "ext_session_lock_surface_v1")
		return .Ext_Session_Lock_Surface_V1
	case ext.Transient_Seat_Manager_V1:
		assert(interface == "ext_transient_seat_manager_v1")
		return .Ext_Transient_Seat_Manager_V1
	case ext.Transient_Seat_V1:
		assert(interface == "ext_transient_seat_v1")
		return .Ext_Transient_Seat_V1
	case ext.Workspace_Manager_V1:
		assert(interface == "ext_workspace_manager_v1")
		return .Ext_Workspace_Manager_V1
	case ext.Workspace_Group_Handle_V1:
		assert(interface == "ext_workspace_group_handle_v1")
		return .Ext_Workspace_Group_Handle_V1
	case ext.Workspace_Handle_V1:
		assert(interface == "ext_workspace_handle_v1")
		return .Ext_Workspace_Handle_V1
	case wp.Fifo_Manager_V1:
		assert(interface == "wp_fifo_manager_v1")
		return .Wp_Fifo_Manager_V1
	case wp.Fifo_V1:
		assert(interface == "wp_fifo_v1")
		return .Wp_Fifo_V1
	case wp.Fractional_Scale_Manager_V1:
		assert(interface == "wp_fractional_scale_manager_v1")
		return .Wp_Fractional_Scale_Manager_V1
	case wp.Fractional_Scale_V1:
		assert(interface == "wp_fractional_scale_v1")
		return .Wp_Fractional_Scale_V1
	case wp.Linux_Drm_Syncobj_Manager_V1:
		assert(interface == "wp_linux_drm_syncobj_manager_v1")
		return .Wp_Linux_Drm_Syncobj_Manager_V1
	case wp.Linux_Drm_Syncobj_Timeline_V1:
		assert(interface == "wp_linux_drm_syncobj_timeline_v1")
		return .Wp_Linux_Drm_Syncobj_Timeline_V1
	case wp.Linux_Drm_Syncobj_Surface_V1:
		assert(interface == "wp_linux_drm_syncobj_surface_v1")
		return .Wp_Linux_Drm_Syncobj_Surface_V1
	case wp.Pointer_Warp_V1:
		assert(interface == "wp_pointer_warp_v1")
		return .Wp_Pointer_Warp_V1
	case wp.Security_Context_Manager_V1:
		assert(interface == "wp_security_context_manager_v1")
		return .Wp_Security_Context_Manager_V1
	case wp.Security_Context_V1:
		assert(interface == "wp_security_context_v1")
		return .Wp_Security_Context_V1
	case wp.Single_Pixel_Buffer_Manager_V1:
		assert(interface == "wp_single_pixel_buffer_manager_v1")
		return .Wp_Single_Pixel_Buffer_Manager_V1
	case wp.Tearing_Control_Manager_V1:
		assert(interface == "wp_tearing_control_manager_v1")
		return .Wp_Tearing_Control_Manager_V1
	case wp.Tearing_Control_V1:
		assert(interface == "wp_tearing_control_v1")
		return .Wp_Tearing_Control_V1
	case xdg.Activation_V1:
		assert(interface == "xdg_activation_v1")
		return .Xdg_Activation_V1
	case xdg.Activation_Token_V1:
		assert(interface == "xdg_activation_token_v1")
		return .Xdg_Activation_Token_V1
	case xdg.Wm_Dialog_V1:
		assert(interface == "xdg_wm_dialog_v1")
		return .Xdg_Wm_Dialog_V1
	case xdg.Dialog_V1:
		assert(interface == "xdg_dialog_v1")
		return .Xdg_Dialog_V1
	case xdg.System_Bell_V1:
		assert(interface == "xdg_system_bell_v1")
		return .Xdg_System_Bell_V1
	case xdg.Toplevel_Drag_Manager_V1:
		assert(interface == "xdg_toplevel_drag_manager_v1")
		return .Xdg_Toplevel_Drag_Manager_V1
	case xdg.Toplevel_Drag_V1:
		assert(interface == "xdg_toplevel_drag_v1")
		return .Xdg_Toplevel_Drag_V1
	case xdg.Toplevel_Icon_Manager_V1:
		assert(interface == "xdg_toplevel_icon_manager_v1")
		return .Xdg_Toplevel_Icon_Manager_V1
	case xdg.Toplevel_Icon_V1:
		assert(interface == "xdg_toplevel_icon_v1")
		return .Xdg_Toplevel_Icon_V1
	case xdg.Toplevel_Tag_Manager_V1:
		assert(interface == "xdg_toplevel_tag_manager_v1")
		return .Xdg_Toplevel_Tag_Manager_V1
	case xwayland.Shell_V1:
		assert(interface == "xwayland_shell_v1")
		return .Xwayland_Shell_V1
	case xwayland.Surface_V1:
		assert(interface == "xwayland_surface_v1")
		return .Xwayland_Surface_V1

	case:
		panic("Invalid type", location)
	}
}
