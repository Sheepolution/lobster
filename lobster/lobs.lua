---@diagnostic disable: lowercase-global, undefined-global
obs = obslua

---@class lobs
---@field obs table
---@field scene scene
---@field source source
---@field timer timer
---@field hotkey hotkey
---@field util util
---@field event event
---@field settings settings
---@field load fun()? Called when the script is loaded.
---@field ready fun(scene: Scene)? Called when a scene has been found.
---@field update fun(dt: number)? Called every frame.
lobs = {}

---The obslua object provided by OBS.
lobs.obs = obs

local path = (...):gsub("[^/.\\]+$", "")

local reset_print = require(path .. ".print")

lobs.scene = require(path .. ".modules.scene")
lobs.source = require(path .. ".modules.source")
lobs.timer = require(path .. "modules.timer")
lobs.hotkey = require(path .. "modules.hotkey")
lobs.util = require(path .. "modules.util")
lobs.event = require(path .. "modules.event")
lobs.settings = require(path .. "modules.settings")

---Enable printing out each lobster and obs function call.<br>
---WARNING: Do not use in combination with lobs.update. Doing so will cause OBS to crash.
function lobs.debug()
    require(path .. ".debug")
end

---Disable printing and type checks
function lobs.release()
    lobs.util.disableTypeChecks()
    print = function() end
end

function script_load(settings)
    ---@diagnostic disable-next-line: invisible
    lobs.settings.setOBSSettings(settings)
    ---@diagnostic disable-next-line: invisible
    obs.obs_frontend_add_event_callback(lobs.event.handleEvent)

    if lobs.load then
        lobs.load()
    end

    ---@diagnostic disable-next-line: invisible
    lobs.settings.setOBSSettings()
end

function script_properties()
    ---@diagnostic disable-next-line: invisible
    return lobs.settings.handleProperties()
end

function script_description()
    return lobs.settings.getDescription() or "Script"
end

function script_defaults(settings)
    ---@diagnostic disable-next-line: invisible
    lobs.settings.handleDefaults(settings)
end

function script_save(settings)
    lobs.hotkey.save(settings)
end

function script_update(settings)
    ---@diagnostic disable-next-line: invisible
    lobs.settings.handleUpdate(settings)
end

local ready = false
local reset_print_time = 0

function script_tick(dt)
    if not ready and lobs.ready then
        local scene_source = obs.obs_frontend_get_current_scene()
        if scene_source then
            ready = true
            obs.obs_source_release(scene_source)
            if lobs.ready then
                local scene = lobs.scene.getScene()
                if scene then
                    lobs.ready(scene)
                end
            end
        else
            return
        end
    end

    if lobs.update then
        reset_print_time = reset_print_time + dt
        if reset_print_time > .1 then
            reset_print_time = 0
            reset_print()
        end

        lobs.update(dt)
    end
end
