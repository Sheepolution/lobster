---@type util
local Util = require((...):gsub("[^/.\\]+$", "util"))

local parent_path = (...):gsub("[^/.\\]+.[^/.\\]+$", "")
local Source = require(parent_path .. "objects.source")
local Type = require(parent_path .. "type")

---@class event
---@field on fun(event:EventType)? A callback that is called when an event is received.
---@field signal fun(signal:SignalType, ...:any)? A callback that is called when a signal is received.
local Event = {}

local events = Type.events

---Function for handling events. Intended for internal use only.
---@param event EventType The incoming event.
---@private
function Event.handleEvent(event)
    for i, v in ipairs(events) do
        if event == obs["OBS_FRONTEND_EVENT_" .. v:upper()] then
            if Event.on then
                Event.on(v --[[@as EventType]])
            end

            local f = v:lower()
            if Event[f] then
                Event[f]()
            end
        end
    end
end

local signal_types = Type.signal_types

local function on_signal(name, cd, callback)
    local args = {}

    for i, arg in ipairs(signal_types[name]) do
        local value = obs["calldata_" .. arg.type](cd, arg.name)
        if arg.type == "source" then
            local source_name = obs.obs_source_get_name(value)
            local id = obs.obs_source_get_uuid(value)
            local typ = obs.obs_source_get_unversioned_id(value)
            local source_instance = Source({ sourceID = id, name = source_name, type = typ })
            table.insert(args, source_instance)
        else
            table.insert(args, value)
        end
    end

    if Event.signal then
        Event.signal(name, unpack(args))
    end

    if callback then
        callback(name, unpack(args))
    end

    if Event[name] then
        Event[name](unpack(args))
    end
end

---Add a signal listener.
---@param signal SignalType The signal to listen for.
---@param callback function? The function to call when the signal is received.
function Event.addSignal(signal, callback)
    Util.checkEnum("name", signal, signal_types)
    Util.checkFunction("callback", callback)

    local sh = obs.obs_get_signal_handler()
    obs.signal_handler_connect(sh, signal, function(cd)
        on_signal(signal, cd, callback)
    end)
end

return Event
