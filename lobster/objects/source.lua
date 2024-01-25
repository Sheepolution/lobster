local Object = require((...):gsub("[^/.\\]+$", "object"))

local parent_path = (...):gsub("[^/.\\]+.[^/.\\]+$", "")
---@type util
local Util = require(parent_path .. "modules.util")
local json = require(parent_path .. "libs.json")


---@class Source : Object
---@field private super Object
---@field protected sourceID string
---@field private type string
---@field protected properties table
---@field protected source_obs userdata
---@overload fun(data: table): Source
local Source = Object:extend()

function Source:__tostring()
    return "Source"
end

---Constructor.
---@param data table The data to initialize the Source with.
function Source:new(data)
    Source.super.new(self, data)
    self.width = 0
    self.height = 0
    self.properties = self.properties or {}
end

---Get the ID of the source.
---@return string ID The ID of the source, or an empty string if the source doesn't exist.
function Source:getSourceID()
    return self.sourceID or ''
end

---Get the type of the source.
---@return SourceType sourceType The type of the source
function Source:getType()
    return self.type
end

---Check if the source is a scene.
---@return boolean is_scene Ture if the source is a scene, false otherwise.
function Source:isScene()
    return self.type == "scene"
end

---Check if the source still exists in OBS.
---@return boolean exists True if the source exists, false otherwise.
function Source:exists()
    local used = self.source_obs
    self.source_obs = nil
    local source_obs, release = self:getOBSSource(false)
    if not source_obs then
        self.source_obs = used
        self.sourceID = nil
        return false
    end

    if release then
        obs.obs_source_release(source_obs)
    end

    self.source_obs = used

    return true
end

---Destroy the source, removing it from OBS.
---@return boolean success True if the source was destroyed successfully, false if it already was destroyed or if the source doesn't exist.
function Source:destroy()
    local source_obs = self:getOBSSource()

    if not source_obs then
        return false
    end

    obs.obs_source_remove(source_obs)
    obs.obs_source_release(source_obs)

    return true
end

---Use the source in a callback to fetch the source only once, optimizing performance.
---@param callback function The callback to use the source in.
---@return boolean success True if the source was used successfully, false otherwise.
function Source:useSource(callback)
    Util.checkFunction("callback", callback)

    if self.source_obs then
        error("Nested Source:useSource() call")
    end

    local source_obs = self:getOBSSource()

    if not source_obs then
        return false
    end

    self.source_obs = source_obs

    callback(self)

    self.source_obs = nil
    obs.obs_source_release(source_obs)

    return true
end

---Get the name of the Source.
---@param cache boolean? Optional. Whether to use the cached name or fetch it from OBS.
---@return boolean name The name of the Source.
function Source:getName(cache)
    Util.checkBool("cache", cache, true)

    if not self.name or cache == false then
        local source, release = self:getOBSSource()
        if source then
            self.name = obs.obs_source_get_name(source)
        end

        if release then
            obs.obs_source_release(source)
        end
    end

    return self.name
end

---Set the name of the Source. If there already is an OBS source with the same name, the name will be changed to something else.
---@param name string
---@return boolean success True if the name was changed successfully, false if changed to something else or if the source doesn't exist.
function Source:setName(name)
    Util.checkString("name", name)

    local source, release = self:getOBSSource()
    if not source then
        return false
    end

    obs.obs_source_set_name(source, name)
    self.name = obs.obs_source_get_name(source)

    if release then
        obs.obs_source_release(source)
    end

    return name == self.name
end

---Get the width of the source.
---@param cache boolean? Optional. Whether to use the cached width or fetch it from OBS.
---@return number width The width of the source.
function Source:getWidth(cache)
    Util.checkBool("cache", cache, true)

    if not self.width or cache == false then
        local source, release = self:getOBSSource()
        if source then
            self.width = obs.obs_source_get_width(source)
        end

        if release then
            obs.obs_source_release(source)
        end
    end

    return self.width
end

---Get the height of the source.
---@param cache boolean? Optional. Whether to use the cached height or fetch it from OBS.
---@return number height The height of the source.
function Source:getHeight(cache)
    Util.checkBool("cache", cache, true)

    if not self.height or cache == false then
        local source, release = self:getOBSSource()
        if source then
            self.height = obs.obs_source_get_height(source)
        end

        if release then
            obs.obs_source_release(source)
        end
    end

    return self.height
end

---Get the width and height of the source.
---@param cache boolean? Optional. Whether to use the cached width and height or fetch it from OBS.
---@return number width The width of the source.
---@return number height The height of the source.
function Source:getDimensions(cache)
    Util.checkBool("cache", cache, true)

    if not self.width or not self.height or cache == false then
        local source, release = self:getOBSSource()
        if source then
            self.width = obs.obs_source_get_width(source)
            self.height = obs.obs_source_get_height(source)
        end

        if release then
            obs.obs_source_release(source)
        end
    end

    return self.width, self.height
end

---Get a property of the Source.
---@param name string The name of the property.
---@return any value The value of the property if found, nil otherwise.
function Source:getProperty(name)
    Util.checkString("name", name)

    return (self:getProperties() or {})[name]
end

---Set a property of the Source.
---@param name string The name of the property.
---@param value any The value of the property.
---@return boolean success True if the property was set successfully, false otherwise.
function Source:setProperty(name, value)
    Util.checkString("name", name)

    return self:setProperties({ [name] = value })
end

---Get all the properties of the Source.
---@return table? properties The properties of the Source if found, nil otherwise.
function Source:getProperties()
    local source, release = self:getOBSSource()
    if not source then
        return nil
    end

    local settings = obs.obs_source_get_settings(source)
    local properties = json.decode(obs.obs_data_get_json(settings))
    obs.obs_data_release(settings)

    if release then
        obs.obs_source_release(source)
    end

    return properties
end

---Set all properties of the Source.
---@param properties table The properties to set.
---@return boolean success True if the properties were set successfully, false otherwise.
function Source:setProperties(properties)
    Util.checkTable("properties", properties)

    local source, release = self:getOBSSource()
    if not source then
        return false
    end

    local settings = obs.obs_source_get_settings(source)

    for k, v in pairs(properties) do
        obs["obs_data_set_" .. Util.getType(v)](settings, k, v)
    end

    self.properties = json.decode(obs.obs_data_get_json(settings))

    obs.obs_source_update(source, settings)
    obs.obs_data_release(settings)

    if release then
        obs.obs_source_release(source)
    end

    return true
end

---Add a filter to the source.
---@param filter Filter The filter to add.
---@return boolean success True if the filter was added successfully, false otherwise.
function Source:addFilter(filter)
    Util.checkObject("filter", filter, "filter")

    return filter:addToSource(self)
end

---Remove a filter from the source.
---@param filter Filter The filter to remove.
---@return boolean success True if the filter was removed successfully, false otherwise.
function Source:removeFilter(filter)
    Util.checkObject("filter", filter, "filter")

    return filter:removeFromSource(self)
end

---Check if the source has a filter.
---@param filter Filter
---@return boolean has_filter True if the source has the filter, false otherwise.
function Source:hasFilter(filter)
    Util.checkObject("filter", filter, "filter")

    return filter:isAddedToSource(self)
end

---Creates an OBS source for this Source. Only use this if you know what you're doing.<br>
---WARNING: Make sure to release the source after use in case `release` is true.
---@return userdata|nil source The OBS source, or nil if it couldn't be created.
---@return boolean release Whether to release the OBS source after use.
---@private
function Source:createOBSSource()
    if self.sourceID then
        return self:getOBSSource()
    end

    local settings = obs.obs_data_create()

    for k, v in pairs(self.properties) do
        obs["obs_data_set_" .. Util.getType(v)](settings, k, v)
    end

    local source_obs = obs.obs_source_create_private(self.type, self.name, settings)

    obs.obs_data_release(settings)

    if not source_obs then
        return nil, false
    end

    self.sourceID = obs.obs_source_get_uuid(source_obs)

    return source_obs, true
end

---Get this Source's OBS source. Only use this if you know what you're doing.<br>
---WARNING: Make sure to release the source after use in case `release` is true.
---@param make boolean? Optional. Whether to create a new source if it doesn't exist. Defaults to false.
---@return userdata|nil source The OBS source, or nil if it doesn't exist.
---@return boolean release Whether to release the OBS source after use.
---@protected
function Source:getOBSSource(make)
    if self.source_obs then
        return self.source_obs, false
    end

    if not self.sourceID then
        return make and self:createOBSSource() or nil, not not make
    end

    local source_obs = obs.obs_get_source_by_uuid(self.sourceID)
    if not source_obs then
        self.sourceID = nil
        return make and self:createOBSSource() or nil, not not make
    end

    return source_obs, true
end

return Source
