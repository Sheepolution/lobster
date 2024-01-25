---@type util
local Util = require((...):gsub("[^/.\\]+.[^/.\\]+$", "modules.util"))

---@class settings
---@field on_update? fun(settings:table) Callback for when the settings are updated. `settings` is a key-value table with the settings.
local Settings = {}

local script_props, obs_settings
local descr = "Script"

---Configure the description and properties for this script.
---@param properties (properties_int_type | properties_float_type | properties_number_type | properties_text_type | properties_bool_type | properties_font_type | properties_path_type | properties_button_type | properties_editable_list_type | properties_list_type )[]
function Settings.setProperties(properties)
    Util.checkTable("table", properties)
    script_props = properties
end

---Returns the script description.
---@return string description The script description.
function Settings.getDescription()
    return descr
end

---Set the script description.
---@param description string The script description.
function Settings.setDescription(description)
    descr = description
end

---Get the settings from the load event. Intendend for internal use only.
---@return userdata load_settings? The load settings, or nil if not available.
function Settings.getLoadSettings()
    return obs_settings
end

local common_types = {
    bool = true,
    color = true,
    font = true,
    frame_rate = true,
}

local number_types = {
    int = true,
    float = true,
    int_slider = true,
    float_slider = true,
}

local property_type_map = {
    bool = "bool",
    color = "int",
    font = "obj",
    frame_rate = "int",
    int = "int",
    float = "double",
    double = "double",
    int_slider = "int",
    float_slider = "double",
    text = "string",
    string = "string",
    path = "string",
}

---Handles the properties. Intendend for internal use only.
---@return userdata props The properties.
---@private
function Settings.handleProperties()
    local props = obs.obs_properties_create()

    if not props then
        return props
    end

    if not script_props then
        return props
    end

    for i, v in ipairs(script_props) do
        local p
        if common_types[v.type] then
            p = obs["obs_properties_add_" .. v.type](props, v.id, v.name)
        elseif number_types[v.type] then
            p = obs["obs_properties_add_" .. v.type](props, v.id, v.name, v.min or 0, v.max or math.huge,
                v.step or 1)
        elseif v.type == "text" then
            local text_type = v.text_type or "default"
            p = obs.obs_properties_add_text(props, v.id, v.name, obs["OBS_TEXT_" .. text_type:upper()])
        elseif v.type == "path" then
            local path_type = v.path_type or "file"
            p = obs.obs_properties_add_path(props, v.id, v.name, obs["OBS_PATH_" .. path_type:upper()],
                v.filter,
                v.default)
        elseif v.type == "button" then
            p = obs.obs_properties_add_button(props, v.id, v.name, v.callback)
        elseif v.type == "editable_list" then
            local editable_list_type = v.editable_list_type or "strings"
            p = obs.obs_properties_add_editable_list(props, v.id, v.name,
                obs["OBS_TEXT_" .. editable_list_type:upper()], v.filter,
                v.default)
        elseif v.type == "list" then
            local combo_type = v.combo_type or "editable"
            local combo_format = v.combo_format or "string"
            p = obs.obs_properties_add_list(props, v.id, v.name,
                obs["OBS_COMBO_TYPE_" .. combo_type:upper()],
                obs["OBS_COMBO_FORMAT_" .. combo_format:upper()])

            if v.options then
                for j, option in ipairs(v.options) do
                    obs["obs_property_list_add_" .. Util.getType(option)](p, option.name, option.description)
                end
            end

            if v.source_options then
                local sources = obs.obs_enum_sources()
                if sources ~= nil then
                    for j, source in ipairs(sources) do
                        local source_id = obs.obs_source_get_unversioned_id(source)
                        if v.source_options.all or v.source_options[source_id] then
                            local name = obs.obs_source_get_name(source)
                            obs.obs_property_list_add_string(p, name, name)
                        end
                    end
                end
                obs.source_list_release(sources)
            end
        end

        if v.description then
            obs.obs_property_set_long_description(p, v.description)
        end
    end

    return props
end

---Handles the script_update event. Calls Settings.on_update if available. Intendend for internal use only.
---@private
function Settings.handleUpdate(settings)
    if not Settings.on_update then
        return
    end

    local t = {}

    if script_props then
        for i, v in ipairs(script_props) do
            local typ = property_type_map[v.format or v.type]
            if typ then
                t[v.id] = obs["obs_data_get_" .. typ](settings, v.id)
            end
        end
    end

    Settings.on_update(t)
end

---Handles the script_defaults event. Intendend for internal use only.
---@private
function Settings.handleDefaults(settings)
    if script_props then
        for i, v in ipairs(script_props) do
            if v.default then
                local typ = property_type_map[v.format or v.type]
                if typ then
                    obs["obs_data_set_default_" .. typ](settings, v.name, v.default)
                end
            end
        end
    end
end

---Stores the obs settings or clears them. Intendend for internal use only.
---@private
function Settings.setOBSSettings(settings)
    obs_settings = settings
end

return Settings
