local path = (...):gsub("[^/.\\]+$", "")
---@type util
local Util = require(path .. "util")

local parent_path = (...):gsub("[^/.\\]+.[^/.\\]+$", "")
local json = require(parent_path .. "libs.json")
local Type = require(parent_path .. "type")
---@type Source
local SourceObject = require(parent_path .. "objects.source")
---@type Filter
local Filter = require(parent_path .. "objects.filter")

---@class source
local Source = {}

local function build_source(source)
    local source_name = obs.obs_source_get_name(source)
    local id = obs.obs_source_get_uuid(source)
    local typ = obs.obs_source_get_unversioned_id(source)

    local settings = obs.obs_source_get_settings(source)
    local properties = json.decode(obs.obs_data_get_json(settings))
    obs.obs_data_release(settings)

    local source_instance = SourceObject({ sourceID = id, name = source_name, type = typ, properties = properties })
    return source_instance
end

local source_types = Type.source_types

---Create a new Source.
---@param name string The name of the Source.
---@param sourceType SourceType The type of the Source.
---@param properties table? Optional. The properties of the Source.
---@param callback function? Optional. The callback to use the Source in.
---@return Source source The new Source.
function Source.newSource(name, sourceType, properties, callback)
    Util.checkString("name", name)
    Util.checkEnum("sourceType", sourceType, source_types)
    Util.checkTable("properties", properties, true)
    Util.checkFunction("callback", callback, true)

    local settings = obs.obs_data_create()

    if properties then
        for k, v in pairs(properties) do
            obs["obs_data_set_" .. Util.getType(v)](settings, k, v)
        end
    end

    local source_instance, source_obs

    if callback then
        source_obs = obs.obs_source_create_private(sourceType, name, settings)

        obs.obs_data_release(settings)

        source_instance = build_source(source_obs)

        if properties then
            source_instance:setProperties(properties)
        end

        source_instance:useSource(callback)

        obs.obs_source_release(source_obs)
    else
        source_instance = SourceObject({ name = name, type = sourceType, properties = properties })
    end

    return source_instance
end

---Get a Source by name.
---@param name string The name of the Source.
---@return Source? source The Source if found, nil otherwise.
function Source.getSourceByName(name)
    Util.checkString("name", name)

    local source_obs = obs.obs_get_source_by_name(name)

    if not source_obs then
        return nil
    end

    local source_instance = build_source(source_obs)

    source_instance:getProperties()

    obs.obs_source_release(source_obs)

    return source_instance
end

---Get a Source by ID.
---@param id string The ID of the Source.
---@return Source? source The Source if found, nil otherwise.
function Source.getSourceById(id)
    Util.checkString("id", id)

    local source_obs = obs.obs_get_source_by_uuid(id)

    if not source_obs then
        return nil
    end

    local source_instance = build_source(source_obs)

    obs.obs_source_release(source_obs)

    return source_instance
end

---Use a Source found by name in a callback to fetch the Source only once, optimizing performance.
---@param callback function The callback to use the Source in.
---@return boolean success True if the Source was used successfully, false otherwise.
function Source.useSourceByName(name, callback)
    Util.checkString("name", name)
    Util.checkFunction("callback", callback)

    local source_obs = Source.getSourceByName(name)

    if not source_obs then
        return false
    end

    return source_obs:useSource(callback)
end

---Use a Source found by ID in a callback to fetch the Source only once, optimizing performance.
---@param callback function The callback to use the Source in.
---@return boolean success True if the Source was used successfully, false otherwise.
function Source.useSourceByID(id, callback)
    Util.checkString("id", id)
    Util.checkFunction("callback", callback)

    local source_obs = Source.getSourceById(id)

    if not source_obs then
        return false
    end

    return source_obs:useSource(callback)
end

---Check if a source exists with a certain name.
---@param name string The name of the source.
---@return boolean exists True if the source exists, false otherwise.
function Source.doesSourceExistWithName(name)
    Util.checkString("name", name)

    local source_obs = obs.obs_get_source_by_name(name)

    if not source_obs then
        return false
    end

    obs.obs_source_release(source_obs)

    return true
end

---Check if a source exists with a certain ID.
---@param id string The ID of the source.
---@return boolean exists True if the source exists, false otherwise.
function Source.doesSourceExistWithID(id)
    Util.checkString("id", id)

    local source_obs = obs.obs_get_source_by_uuid(id)

    if not source_obs then
        return false
    end

    obs.obs_source_release(source_obs)

    return true
end

---Create a new Filter.
---@param name string The name of the filter.
---@param filterType FilterType The type of the filter.
---@param properties? table Optional. The settings of the filter.
---@return Filter filter The new Filter.
function Source.newFilter(name, filterType, properties)
    Util.checkString("name", name)
    Util.checkEnum("filterType", filterType, Type.filter_types)
    Util.checkTable("settings", properties, true)

    return Filter({ name = name, type = filterType, properties = properties })
end

return Source
