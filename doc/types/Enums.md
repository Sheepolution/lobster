# Enums

## AlignmentType

```lua
AlignmentType:
    | "topleft"
    | "topcenter"
    | "topright"
    | "centerleft"
    | "center"
    | "centerright"
    | "bottomleft"
    | "bottomcenter"
    | "bottomright"
```

## ComboFormat

```lua
ComboFormat:
    | "int"
    | "float"
    | "string"
    | "bool"
```

## ComboType

```lua
ComboType:
    | "editable"
    | "list"
    | "radio"
```

## EditableListType

```lua
EditableListType:
    | "file"
    | "file_save"
    | "directory"
```

## EventType

```lua
EventType:
    | "streaming_starting"
    | "streaming_started"
    | "streaming_stopping"
    | "streaming_stopped"
    | "recording_starting"
    | "recording_started"
    | "recording_stopping"
    | "recording_stopped"
    | "recording_paused"
    | "recording_unpaused"
    | "scene_changed"
    | "scene_list_changed"
    | "transition_changed"
    | "transition_stopped"
    | "transition_list_changed"
    | "transition_duration_changed"
    | "tbar_value_changed"
    | "scene_collection_changing"
    | "scene_collection_changed"
    | "scene_collection_list_changed"
    | "scene_collection_renamed"
    | "profile_changing"
    | "profile_changed"
    | "profile_list_changed"
    | "profile_renamed"
    | "finished_loading"
    | "scripting_shutdown"
    | "exit"
    | "replay_buffer_starting"
    | "replay_buffer_started"
    | "replay_buffer_stopping"
    | "replay_buffer_stopped"
    | "replay_buffer_saved"
    | "studio_mode_enabled"
    | "studio_mode_disabled"
    | "preview_scene_changed"
    | "scene_collection_cleanup"
    | "virtualcam_started"
    | "virtualcam_stopped"
    | "theme_changed"
    | "screenshot_taken"
```

## FilterType

```lua
FilterType:
    | "mask_filter"
    | "mask_filter_v2"
    | "crop_filter"
    | "gain_filter"
    | "eq_filter"
    | "hdr_tonemap_filter"
    | "color_filter"
    | "color_filter_v2"
    | "scale_filter"
    | "scroll_filter"
    | "gpu_delay_filter"
    | "color_key_filter"
    | "color_key_filter_v2"
    | "color_grade_filter"
    | "sharpness_filter"
    | "sharpness_filter_v2"
    | "chroma_key_filter"
    | "chroma_key_filter_v2"
    | "async_delay_filter"
    | "noise_suppress_filter"
    | "noise_suppress_filter_v2"
    | "invert_polarity_filter"
    | "noise_gate_filter"
    | "compressor_filter"
    | "limiter_filter"
    | "expander_filter"
    | "upward_compressor_filter"
    | "luma_key_filter"
    | "luma_key_filter_v2"
    | "nvidia_greenscreen_filter_info"
```

## GroupType

```lua
GroupType:
    | "normal"
    | "checkable"
```

## PathType

```lua
PathType:
    | "file"
    | "file_save"
    | "directory"
```

## SourceType

```lua
SourceType:
    | "browser_source"
    | "wasapi_input_capture"
    | "wasapi_output_capture"
    | "coreaudio_input_capture"
    | "coreaudio_output_capture"
    | "pulse_input_capture"
    | "pulse_output_capture"
    | "alsa_input_capture"
    | "wasapi_process_output_capture"
    | "window_capture"
    | "xcomposite_input"
    | "monitor_capture"
    | "display_capture"
    | "xshm_input"
    | "dshow_input"
    | "game_capture"
    | "image_source"
    | "color_source"
    | "text_ft2_source"
    | "text_gdiplus"
    | "scene"
```

# SignalType

```lua
SignalType:
    | "source_create"
    | "source_destroy"
    | "source_remove"
    | "source_update"
    | "source_save"
    | "source_load"
    | "source_activate"
    | "source_deactivate"
    | "source_show"
    | "source_hide"
    | "source_transition_start"
    | "source_transition_video_stop"
    | "source_transition_stop"
    | "source_rename"
    | "source_volume"
    | "channel_change"
    | "hotkey_layout_change"
    | "hotkey_register"
    | "hotkey_unregister"
    | "hotkey_bindings_changed"
    | "item_add"
    | "item_remove"
    | "reorder"
    | "refresh"
    | "item_visible"
    | "item_locked"
    | "item_select"
    | "item_deselect"
    | "item_transform"
    | "destroy"
    | "remove"
    | "update"
    | "save"
    | "load"
    | "activate"
    | "deactivate"
    | "show"
    | "hide"
    | "update_properties"
    | "reorder_filters"
    | "transition_start"
    | "transition_video_stop"
    | "transition_stop"
    | "media_started"
    | "media_ended"
    | "media_pause"
    | "media_play"
    | "media_restart"
    | "media_stopped"
    | "media_next"
    | "media_previous"
    | "mute"
    | "push_to_mute_changed"
    | "push_to_mute_delay"
    | "push_to_talk_changed"
    | "push_to_talk_delay"
    | "enable"
    | "rename"
    | "volume"
    | "update_flags"
    | "audio_sync"
    | "audio_balance"
    | "audio_mixers"
    | "filter_add"
    | "filter_remove"
```


## TextType

```lua
TextType:
    | "default"
    | "password"
    | "multiline"
    | "info"
```