local Type = {}

Type.events = {
    "streaming_starting",
    "streaming_started",
    "streaming_stopping",
    "streaming_stopped",
    "recording_starting",
    "recording_started",
    "recording_stopping",
    "recording_stopped",
    "recording_paused",
    "recording_unpaused",
    "scene_changed",
    "scene_list_changed",
    "transition_changed",
    "transition_stopped",
    "transition_list_changed",
    "transition_duration_changed",
    "tbar_value_changed",
    "scene_collection_changing",
    "scene_collection_changed",
    "scene_collection_list_changed",
    "scene_collection_renamed",
    "profile_changing",
    "profile_changed",
    "profile_list_changed",
    "profile_renamed",
    "finished_loading",
    "scripting_shutdown",
    "exit",
    "replay_buffer_starting",
    "replay_buffer_started",
    "replay_buffer_stopping",
    "replay_buffer_stopped",
    "replay_buffer_saved",
    "studio_mode_enabled",
    "studio_mode_disabled",
    "preview_scene_changed",
    "scene_collection_cleanup",
    "virtualcam_started",
    "virtualcam_stopped",
    "theme_changed",
    "screenshot_taken",
}

---@alias EventType
---| "streaming_starting",
---| "streaming_started",
---| "streaming_stopping",
---| "streaming_stopped",
---| "recording_starting",
---| "recording_started",
---| "recording_stopping",
---| "recording_stopped",
---| "recording_paused",
---| "recording_unpaused",
---| "scene_changed",
---| "scene_list_changed",
---| "transition_changed",
---| "transition_stopped",
---| "transition_list_changed",
---| "transition_duration_changed",
---| "tbar_value_changed",
---| "scene_collection_changing",
---| "scene_collection_changed",
---| "scene_collection_list_changed",
---| "scene_collection_renamed",
---| "profile_changing",
---| "profile_changed",
---| "profile_list_changed",
---| "profile_renamed",
---| "finished_loading",
---| "scripting_shutdown",
---| "exit",
---| "replay_buffer_starting",
---| "replay_buffer_started",
---| "replay_buffer_stopping",
---| "replay_buffer_stopped",
---| "replay_buffer_saved",
---| "studio_mode_enabled",
---| "studio_mode_disabled",
---| "preview_scene_changed",
---| "scene_collection_cleanup",
---| "virtualcam_started",
---| "virtualcam_stopped",
---| "theme_changed",
---| "screenshot_taken",

local source_arg = { name = "source", type = "source" }
local sceneitem_arg = { name = "item", type = "sceneitem" }
local scene_arg = { name = "scene", type = "scene" }

Type.signal_types = {
    -- Core signals
    source_create = { source_arg },
    source_destroy = { source_arg },
    source_remove = { source_arg },
    source_update = { source_arg },
    source_save = { source_arg },
    source_load = { source_arg },
    source_activate = { source_arg },
    source_deactivate = { source_arg },
    source_show = { source_arg },
    source_hide = { source_arg },
    source_transition_start = { source_arg },
    source_transition_video_stop = { source_arg },
    source_transition_stop = { source_arg },
    source_rename = { source_arg, { name = "new_name", type = "string" }, { name = "prev_name", type = "string" } },
    source_volume = { source_arg, { name = "volume", type = "float" } },
    channel_change = { { name = "channel", type = "int" }, source_arg, { name = "prev_source", type = "source" } },
    hotkey_layout_change = {},
    hotkey_register = { { name = "hotkey", type = "string" } },
    hotkey_unregister = { { name = "hotkey", type = "string" } },
    hotkey_bindings_changed = { { name = "hotkey", type = "string" } },

    -- Scene signals
    item_add = { scene_arg, sceneitem_arg },
    item_remove = { scene_arg, sceneitem_arg },
    reorder = { scene_arg },
    refresh = { scene_arg },
    item_visible = { scene_arg, sceneitem_arg, { name = "visible", type = "bool", } },
    item_locked = { scene_arg, sceneitem_arg, { name = "locked", type = "bool" } },
    item_select = { scene_arg, sceneitem_arg },
    item_deselect = { scene_arg, sceneitem_arg },
    item_transform = { scene_arg, sceneitem_arg },

    -- Source signals
    destroy = { source_arg },
    remove = { source_arg },
    update = { source_arg },
    save = { source_arg },
    load = { source_arg },
    activate = { source_arg },
    deactivate = { source_arg },
    show = { source_arg },
    hide = { source_arg },
    update_properties = { source_arg },
    reorder_filters = { source_arg },
    transition_start = { source_arg },
    transition_video_stop = { source_arg },
    transition_stop = { source_arg },
    media_started = { source_arg },
    media_ended = { source_arg },
    media_pause = { source_arg },
    media_play = { source_arg },
    media_restart = { source_arg },
    media_stopped = { source_arg },
    media_next = { source_arg },
    media_previous = { source_arg },
    mute = { source_arg, { name = "muted", type = "bool" } },
    push_to_mute_changed = { source_arg, { name = "enabled", type = "bool" } },
    push_to_mute_delay = { source_arg, { name = "delay", type = "int" } },
    push_to_talk_changed = { source_arg, { name = "enabled", type = "bool" } },
    push_to_talk_delay = { source_arg, { name = "delay", type = "int" } },
    enable = { source_arg, { name = "enabled", type = "bool" } },
    rename = { source_arg, { name = "new_name", type = "string" }, { name = "prev_name", type = "string" } },
    volume = { source_arg, { name = "volume", type = "float" } },
    update_flags = { source_arg, { name = "flags", type = "int" } },
    audio_sync = { source_arg, { name = "offset", type = "int" } },
    audio_balance = { source_arg, { name = "balance", type = "float" } },
    audio_mixers = { source_arg, { name = "mixers", type = "int" } },
    filter_add = { source_arg, { name = "filter", type = "source" } },
    filter_remove = { source_arg, { name = "filter", type = "source" } },
}

---@alias SignalType
---| "source_create"
---| "source_destroy"
---| "source_remove"
---| "source_update"
---| "source_save"
---| "source_load"
---| "source_activate"
---| "source_deactivate"
---| "source_show"
---| "source_hide"
---| "source_transition_start"
---| "source_transition_video_stop"
---| "source_transition_stop"
---| "source_rename"
---| "source_volume"
---| "channel_change"
---| "hotkey_layout_change"
---| "hotkey_register"
---| "hotkey_unregister"
---| "hotkey_bindings_changed"
---| "item_add"
---| "item_remove"
---| "reorder"
---| "refresh"
---| "item_visible"
---| "item_locked"
---| "item_select"
---| "item_deselect"
---| "item_transform"
---| "destroy"
---| "remove"
---| "update"
---| "save"
---| "load"
---| "activate"
---| "deactivate"
---| "show"
---| "hide"
---| "update_properties"
---| "reorder_filters"
---| "transition_start"
---| "transition_video_stop"
---| "transition_stop"
---| "media_started"
---| "media_ended"
---| "media_pause"
---| "media_play"
---| "media_restart"
---| "media_stopped"
---| "media_next"
---| "media_previous"
---| "mute"
---| "push_to_mute_changed"
---| "push_to_mute_delay"
---| "push_to_talk_changed"
---| "push_to_talk_delay"
---| "enable"
---| "rename"
---| "volume"
---| "update_flags"
---| "audio_sync"
---| "audio_balance"
---| "audio_mixers"
---| "filter_add"
---| "filter_remove"

---@alias TextType "default" | "password" | "multiline" | "info"
---@alias PathType "file" | "file_save" | "directory"
---@alias EditableListType "file" | "file_save" | "directory"
---@alias GroupType "normal" | "checkable"
---@alias ComboType "editable" | "list" | "radio"
---@alias ComboFormat "int" | "float" | "string" | "bool"
---@alias SourceType "browser_source" | "wasapi_input_capture" | "wasapi_output_capture" | "coreaudio_input_capture" | "coreaudio_output_capture" | "pulse_input_capture" | "pulse_output_capture" | "alsa_input_capture" | "wasapi_process_output_capture" | "window_capture" | "xcomposite_input" | "monitor_capture" | "display_capture" | "xshm_input" | "dshow_input" | "game_capture" | "image_source" | "color_source" | "text_ft2_source" | "text_gdiplus" | "scene"

Type.source_types = {
    "browser_source",
    "wasapi_input_capture",
    "wasapi_output_capture",
    "coreaudio_input_capture",
    "coreaudio_output_capture",
    "pulse_input_capture",
    "pulse_output_capture",
    "alsa_input_capture",
    "wasapi_process_output_capture",
    "window_capture",
    "xcomposite_input",
    "monitor_capture",
    "display_capture",
    "xshm_input",
    "dshow_input",
    "game_capture",
    "image_source",
    "color_source",
    "text_ft2_source",
    "text_gdiplus",
    "scene",
}

---@class (exact) properties_base
---@field type any The type of the property.
---@field id string The id of the property.
---@field name string The name of the property.
---@field description string? Optional. The description of the property.
---@field default any? Optional. The default value of the property.

---@class (exact) properties_int_type : properties_base
---@field type "int" | "int_slider"
---@field min integer The minimum value of the property.
---@field max integer The maximum value of the property.
---@field step integer With which step the property can be changed.
---@field default integer?

---@class (exact) properties_float_type : properties_base
---@field type "float" | "float_slider"
---@field min integer The minimum value of the property.
---@field max integer The maximum value of the property.
---@field step integer With which step the property can be changed.
---@field default number?

---@class (exact) properties_bool_type : properties_base
---@field type "bool"
---@field default boolean?

---@class (exact) properties_number_type : properties_base
---@field type "color" | "framerate"
---@field default integer?

---@class (exact) properties_font_type : properties_base
---@field type "font"
---@field default integer?

---@class (exact) properties_text_type : properties_base
---@field type "text"
---@field text_type TextType? The type of the text. Defaults to "default".
---@field default string?

---@class (exact) properties_path_type : properties_base
---@field type "path"
---@field path_type PathType? The type of the path. Defaults to "file".
---@field filter string? The filter for the path.
---@field default string?

---@class (exact) properties_button_type : properties_base
---@field type "button"
---@field callback function The function called when the button is pressed.

---@class (exact) properties_editable_list_type : properties_base
---@field type "editable_list"
---@field editable_list_type EditableListType? The type of the editable list. Defaults to "strings".
---@field filter string? The filter for the list.

---@class (exact) properties_list_type : properties_base
---@field type "list"
---@field options any? The options that the list has.
---@field source_options table<SourceType, boolean>? Add existing sources to the list. Filter for a specific source type using `true` and `falls`. Use `all` to add all sources.
---@field combo_type ComboType? The type of the combo. Defaults to "editable".
---@field combo_format ComboFormat? The format of the combo. Defaults to "string".
---@field default any?

Type.filter_types = {
    "mask_filter",
    "mask_filter_v2",
    "crop_filter",
    "gain_filter",
    "eq_filter",
    "hdr_tonemap_filter",
    "color_filter",
    "color_filter_v2",
    "scale_filter",
    "scroll_filter",
    "gpu_delay_filter",
    "color_key_filter",
    "color_key_filter_v2",
    "color_grade_filter",
    "sharpness_filter",
    "sharpness_filter_v2",
    "chroma_key_filter",
    "chroma_key_filter_v2",
    "async_delay_filter",
    "noise_suppress_filter",
    "noise_suppress_filter_v2",
    "invert_polarity_filter",
    "noise_gate_filter",
    "compressor_filter",
    "limiter_filter",
    "expander_filter",
    "upward_compressor_filter",
    "luma_key_filter",
    "luma_key_filter_v2",
    "nvidia_greenscreen_filter_info",
}

---@alias FilterType
---| "mask_filter",
---| "mask_filter_v2",
---| "crop_filter",
---| "gain_filter",
---| "eq_filter",
---| "hdr_tonemap_filter",
---| "color_filter",
---| "color_filter_v2",
---| "scale_filter",
---| "scroll_filter",
---| "gpu_delay_filter",
---| "color_key_filter",
---| "color_key_filter_v2",
---| "color_grade_filter",
---| "sharpness_filter",
---| "sharpness_filter_v2",
---| "chroma_key_filter",
---| "chroma_key_filter_v2",
---| "async_delay_filter",
---| "noise_suppress_filter",
---| "noise_suppress_filter_v2",
---| "invert_polarity_filter",
---| "noise_gate_filter",
---| "compressor_filter",
---| "limiter_filter",
---| "expander_filter",
---| "upward_compressor_filter",
---| "luma_key_filter",
---| "luma_key_filter_v2",
---| "nvidia_greenscreen_filter_info",

Type.alignments_string_to_bit = {
    topleft = 5,
    centerleft = 1,
    bottomleft = 9,
    topcenter = 4,
    center = 0,
    bottomcenter = 8,
    topright = 6,
    centerright = 2,
    bottomright = 10,
}

Type.alignments_bit_to_string = {
    [5] = "topleft",
    [1] = "centerleft",
    [9] = "bottomleft",
    [4] = "topcenter",
    [0] = "center",
    [8] = "bottomcenter",
    [6] = "topright",
    [2] = "centerright",
    [10] = "bottomright",
}

---@alias AlignmentType
--- | "topleft"
--- | "topcenter"
--- | "topright"
--- | "centerleft"
--- | "center"
--- | "centerright"
--- | "bottomleft"
--- | "bottomcenter"
--- | "bottomright"

return Type
