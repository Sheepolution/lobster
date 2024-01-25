local path = (...):gsub("[^/.\\]+$", "")
---@type source
local Source = require(path .. "source")
---@type event
local Event = require(path .. "event")
---@type util
local Util = require(path .. "util")

local parent_path = (...):gsub("[^/.\\]+.[^/.\\]+$", "")
---@type Scene
local SceneObject = require(parent_path .. "objects.scene")

---@class scene
local Scene = {}

---Get a Scene.
---@param name string? Optional. The name of the Scene to get. If not provided, the current Scene will be used.
---@return Scene? scene The Scene if found, nil otherwise.
function Scene.getScene(name)
    Util.checkString("name", name, true)

    local scene_source

    if name then
        scene_source = obs.obs_get_source_by_name(name)
    else
        scene_source = obs.obs_frontend_get_current_scene()

        if not scene_source then
            return nil
        end

        name = obs.obs_source_get_name(scene_source)
    end

    if not scene_source then
        return nil
    end

    local scene = obs.obs_scene_from_source(scene_source)

    if not scene then
        obs.obs_source_release(scene_source)
        return nil
    end

    obs.obs_source_release(scene_source)

    local source_instance = Source.getSourceByName(name)

    if not source_instance then
        return nil
    end

    return SceneObject({
        sourceID = source_instance:getSourceID(),
        name = source_instance:getName(),
        type = source_instance:getType()
    })
end

---Go to a Scene.
---@param name_or_instance string|Scene A Scene, or the name of the Scene, to go to.
---@return Scene? scene The Scene switched to if succeeded, nil otherwise.
function Scene.toScene(name_or_instance)
    Util.checkMulti("name_or_instance", name_or_instance, { "string", "instance" }, { {}, { "scene" } })

    local scene_source
    local release = true
    local typ = type(name_or_instance)
    if typ == "string" then
        scene_source = obs.obs_get_source_by_name(name_or_instance)
    else
        ---@diagnostic disable-next-line: invisible
        local instance_source, release_source = name_or_instance:getOBSSource(false)
        if instance_source then
            release = release_source
        end
    end

    if not scene_source or not obs.obs_source_is_scene(scene_source) then
        if release then
            obs.obs_source_release(scene_source)
        end
        return nil
    end

    ---@diagnostic disable-next-line: invisible
    obs.obs_frontend_remove_event_callback(Event.handleEvent)
    obs.obs_frontend_set_current_scene(scene_source)
    ---@diagnostic disable-next-line: invisible
    obs.obs_frontend_add_event_callback(Event.handleEvent)

    if release then
        obs.obs_source_release(scene_source)
    end

    ---@type Scene?
    return typ == "string" and Scene.getScene(name_or_instance) or name_or_instance
end

---Get the name of the current Scene.
---@return string name The name of the current Scene.
function Scene.getName()
    local scene_source = obs.obs_frontend_get_current_scene()
    local name = obs.obs_source_get_name(scene_source)
    obs.obs_source_release(scene_source)
    return name
end

---Get all Items in the current Scene.
---@return Item[]? items The Items in the current Scene if found, nil otherwise.
function Scene.getItems()
    local scene = Scene.getScene()

    if not scene then
        return nil
    end

    return scene:getItems()
end

---Get an Item in the current Scene by name.
---@param name string The name of the Item.
---@param n integer? Optional. The number of the Item to get. If not provided, the first Item found will be returned.
---@return Item? item The Item if found, nil otherwise.
function Scene.getItemByName(name, n)
    local scene = Scene.getScene()

    if not scene then
        return nil
    end

    return scene:getItemByName(name, n)
end

---Get an Item in the current Scene by type.
---@param sourceType SourceType The type of the Item.
---@param n integer? Optional. The number of the Item to get. If not provided, the first Item found will be returned.
---@return Item? item The Item if found, nil otherwise.
function Scene.getItemByType(sourceType, n)
    local scene = Scene.getScene()

    if not scene then
        return nil
    end

    return scene:getItemByName(sourceType, n)
end

---Get an Item in the current Scene by ID.
---@param id integer The ID of the Item.
---@return Item? item The Item if found, nil otherwise.
function Scene.getItemById(id)
    local scene = Scene.getScene()

    if not scene then
        return nil
    end

    return scene:getItemById(id)
end

---Create a new Source added as an Item to the current Scene.
---@param name string The name of the Source.
---@param sourceType SourceType The type of the Source.
---@param properties table? Optional. The properties of the Source.
---@param order integer? Optional. The order of the Item. If not provided, the Item will be added to the top of the item list.
---@return Item? item The Item if the Source was added, nil otherwise.
function Scene.newSource(name, sourceType, properties, order)
    local scene = Scene.getScene()

    if not scene then
        return nil
    end

    return scene:newSource(name, sourceType, properties, order)
end

return Scene
