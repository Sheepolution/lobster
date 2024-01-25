---@type util
local Util = require((...):gsub("[^/.\\]+.[^/.\\]+$", "modules.util"))
---@type Object
local Source = require((...):gsub("[^/.\\]+$", "source"))

---@class Filter : Source
---@field private super Source
---@field sources table
---@overload fun(data: table): Filter
local Filter = Source:extend()

function Filter:__tostring()
    return "Filter"
end

---Constructor.
---@param data table The data to initialize the Filter with.
function Filter:new(data)
    Filter.super.new(self, data)
end

---Add the Filter to a Source.
---@param source Source The Source to add the Filter to.
---@return boolean success Whether the Filter was added successfully.
function Filter:addToSource(source)
    Util.checkObject("source", source, "source")

    local source_obs, release = source:getOBSSource(false)
    if not source_obs then
        return false
    end

    local filter, release_filter = self:getOBSSource(true)
    if not filter then
        return false
    end

    obs.obs_source_filter_add(source_obs, filter)

    if release then
        obs.obs_source_release(source_obs)
    end

    if release_filter then
        obs.obs_source_release(filter)
    end

    return true
end

---Check if the Filter is added to a Source.
---@param source Source The Source to check if the Filter is added to.
---@return boolean is_added Whether the Filter is added to the Source.
function Filter:isAddedToSource(source)
    Util.checkObject("source", source, "source")

    local source_obs, release = source:getOBSSource()
    if not source_obs then
        return false
    end

    local filter = obs.obs_source_get_filter_by_name(source_obs, self.name)
    if not filter then
        return false
    end

    if release then
        obs.obs_source_release(filter)
    end

    return true
end

---Remove this Filter from a Source.
---@param source Source The Source to remove the Filter from.
---@return boolean success Whether the Filter was removed successfully, false otherwise.
function Filter:removeFromSource(source)
    Util.checkObject("source", source, "source")

    local source_obs, release = source:getOBSSource()
    if not source_obs then
        return false
    end

    local filter = obs.obs_source_get_filter_by_name(source_obs, self.name)
    obs.obs_source_filter_remove(source_obs, filter)
    obs.obs_source_release(filter)

    if release then
        obs.obs_source_release(source_obs)
    end

    return true
end

return Filter
