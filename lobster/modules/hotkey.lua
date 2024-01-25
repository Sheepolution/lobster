local path = (...):gsub("[^/.\\]+$", "")
---@type util
local Util = require(path .. "util")
---@type settings
local Settings = require(path .. "settings")

---@class hotkey
---@field on fun(name: string, pressed: boolean) A callback that is called when a hotkey is pressed or released.
local Hotkey = {}

local keys = {}
local keys_down = {}

---Register a hotkey.
---@param name string The name of the hotkey to refer to.
---@param description string The description of the hotkey, shown to the user.
---@param callback function? Optional. The callback to call when the hotkey is pressed.
function Hotkey.register(name, description, callback)
    Util.checkString("name", name)
    Util.checkString("description", description)
    Util.checkFunction("callback", callback, true)

    if keys[name] then
        error("Hotkey '" .. name .. "' already registered")
    end

    local settings = Settings.getLoadSettings()
    if not settings then
        error("lobs.hotkey.register must be used inside lobs.load")
    end

    local hotkey = obs.obs_hotkey_register_frontend(name, description, function()
        local pressed = not keys_down[name]
        if pressed then
            keys_down[name] = true
        else
            keys_down[name] = nil
        end

        if Hotkey.on then
            Hotkey.on(name, pressed)
        end

        if callback then
            callback(pressed)
        end
    end)

    if hotkey == nil then
        hotkey = obs.OBS_INVALID_HOTKEY_ID
    end

    keys[name] = hotkey

    local hotkey_save_array = obs.obs_data_get_array(settings, name)
    obs.obs_hotkey_load(hotkey, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)
end

---Save the hotkeys. For internal use only. Must be called from script_save.
---@param settings userdata The OBS settings to save the hotkeys to.
function Hotkey.save(settings)
    for k, v in pairs(keys) do
        local hotkey_save_array = obs.obs_hotkey_save(v)
        obs.obs_data_set_array(settings, k, hotkey_save_array)
        obs.obs_data_array_release(hotkey_save_array)
    end
end

---Check if a hotkey is being held down.
---@param ... string The names of the hotkeys to check.
---@return boolean is_down True if the hotkey is being held down, false otherwise.
function Hotkey.isDown(...)
    local t = { ... }
    Util.checkString("key", t[1])
    for i, v in ipairs(t) do
        if keys_down[v] then
            return true
        end
    end

    return false
end

return Hotkey
