local path = (...):gsub("[^/.\\]+$", "")
---@type Item
local Item = require(path .. "item")
---@type Source
local Source = require(path .. "source")

local parent_path = (...):gsub("[^/.\\]+.[^/.\\]+$", "")
---@type util
local Util = require(parent_path .. "modules.util")
local Type = require(parent_path .. "type")

---@class Scene : Source
---@field private super Source
---@overload fun(data: table): Scene
local Scene = Source:extend()

function Scene:__tostring()
    return "Scene"
end

---Constructor.
---@param data table
function Scene:new(data)
    Scene.super.new(self, data)
end

local function build_item(scene, source, item, order)
    local source_id = obs.obs_source_get_uuid(source)
    local typ = obs.obs_source_get_unversioned_id(source)
    local item_id = obs.obs_sceneitem_get_id(item)
    local name = obs.obs_source_get_name(source)
    return Item({
        scene = scene,
        itemID = item_id,
        name = name,
        order = order,
        sourceID = source_id,
        type = typ
    })
end

local function get_items(sourceID)
    local scene_source = obs.obs_get_source_by_uuid(sourceID)
    if not scene_source then
        return nil
    end

    local scene = obs.obs_scene_from_source(scene_source)
    if not scene then
        obs.obs_source_release(scene_source)
        return nil
    end

    local items = obs.obs_scene_enum_items(scene)
    return items, scene_source
end

local source_types = Type.source_types

---Create a new Source added as an Item to the current Scene.
---@param name string The name of the Source.
---@param sourceType SourceType The type of the Source.
---@param properties table? Optional. The properties of the Source.
---@param order integer? Optional. The order position of the Item. If not provided, the Item will be added to the top of the item list.
---@return Item? item The Item if the Source was added, nil otherwise.
function Scene:newSource(name, sourceType, properties, order)
    Util.checkString("name", name)
    Util.checkEnum("sourceType", sourceType, source_types)
    Util.checkTable("properties", properties, true)
    Util.checkInt("order", order, true)

    local scene_source = obs.obs_get_source_by_uuid(self.sourceID)
    if not scene_source then
        return nil
    end

    local scene = obs.obs_scene_from_source(scene_source)
    if not scene then
        obs.obs_source_release(scene_source)
        return nil
    end

    local settings

    if properties then
        settings = obs.obs_data_create()
        for k, v in pairs(properties) do
            obs["obs_data_set_" .. Util.getType(v)](settings, k, v)
        end
    end

    local source_obs = obs.obs_source_create_private(sourceType, name, settings)

    if settings then
        obs.obs_data_release(settings)
    end

    local item_obs = obs.obs_scene_add(scene, source_obs)

    if not item_obs then
        obs.obs_source_release(scene_source)
        obs.obs_scene_release(scene)
        obs.obs_source_release(source_obs)
        return nil
    end

    if not order then
        order = obs.obs_sceneitem_get_order_position(item_obs)
    else
        obs.obs_sceneitem_set_order_position(item_obs, order)
        order = obs.obs_sceneitem_get_order_position(item_obs)
    end

    local source_id = obs.obs_source_get_uuid(source_obs)
    local item_id = obs.obs_sceneitem_get_id(item_obs)
    local item_instance = Item({
        scene = scene,
        itemID = item_id,
        name = name,
        order = order,
        sourceID = source_id,
        type = sourceType
    })

    obs.obs_source_release(scene_source)
    obs.obs_scene_release(scene)
    obs.obs_source_release(source_obs)

    return item_instance
end

---Create a new Source added as an Item to the current Scene.
---@param source Source The Source to add.
---@param order integer? Optional. The order position of the Item. If not provided, the Item will be added to the top of the item list.
---@return Item? item The Item if the Source was added, nil otherwise.
function Scene:addSource(source, order)
    Util.checkObject("name", source, "source")
    Util.checkInt("order", order, true)

    local scene_source = obs.obs_get_source_by_uuid(self.sourceID)
    if not scene_source then
        return nil
    end

    local scene = obs.obs_scene_from_source(scene_source)
    if not scene then
        obs.obs_source_release(scene_source)
        return nil
    end

    local source_obs, release = source:getOBSSource(true)

    if not source_obs then
        return nil
    end

    local item_obs = obs.obs_scene_add(scene, source_obs)

    if not item_obs then
        obs.obs_source_release(scene_source)
        obs.obs_scene_release(scene)
        if release then
            obs.obs_source_release(source_obs)
        end
        return nil
    end

    if not order then
        order = obs.obs_sceneitem_get_order_position(item_obs)
    else
        obs.obs_sceneitem_set_order_position(item_obs, order)
        order = obs.obs_sceneitem_get_order_position(item_obs)
    end

    local source_id = obs.obs_source_get_uuid(source_obs)
    local item_id = obs.obs_sceneitem_get_id(item_obs)
    local source_type = obs.obs_source_get_unversioned_id(source_obs)
    local item_instance = Item({
        scene = scene,
        itemID = item_id,
        name = source:getName(),
        order = order,
        sourceID = source_id,
        type = source_type
    })

    obs.obs_source_release(scene_source)
    obs.obs_scene_release(scene)
    if release then
        obs.obs_source_release(source_obs)
    end

    return item_instance
end

---Get all Items in the Scene.
---@return Item[]? items The Items in the Scene if found, nil otherwise.
function Scene:getItems()
    local item_instances = {}

    local items, scene_source = get_items(self.sourceID)
    if not items then
        return nil
    end

    for i, item in ipairs(items) do
        local source_obs = obs.obs_sceneitem_get_source(item)
        table.insert(item_instances, build_item(self, source_obs, item, i))
    end

    obs.sceneitem_list_release(items)
    obs.obs_source_release(scene_source)

    return item_instances
end

---Get an Item in the Scene by name.
---@param name string The name of the Item.
---@param n integer? Optional. The number of the Item to get. If not provided, the first Item found will be returned.
---@return Item? item The Item if found, nil otherwise.
function Scene:getItemByName(name, n)
    Util.checkString("name", name)
    Util.checkInt("n", n, true, 1)

    local items, scene_source = get_items(self.sourceID)
    if not items then
        return nil
    end

    local item_instance

    local c = 0
    for i, item in ipairs(items) do
        local source_obs = obs.obs_sceneitem_get_source(item)
        local source_name = obs.obs_source_get_name(source_obs)
        if source_name == name then
            c = c + 1
            if not n or c == n then
                item_instance = build_item(self, source_obs, item, i)
                break
            end
        end
    end

    obs.sceneitem_list_release(items)
    obs.obs_source_release(scene_source)

    return item_instance
end

---Get an Item in the Scene by type.
---@param sourceType SourceType The type of the Item.
---@param n integer? Optional. The number of the Item to get. If not provided, the first Item found will be returned.
---@return Item? item The Item if found, nil otherwise.
function Scene:getItemByType(sourceType, n)
    Util.checkString("name", type)
    Util.checkInt("n", n, true, 1)

    local items, scene_source = get_items(self.sourceID)
    if not items then
        return nil
    end

    local item_instance

    local c = 0
    for i, item in ipairs(items) do
        local source_obs = obs.obs_sceneitem_get_source(item)
        local source_type = obs.obs_source_get_unversioned_id(source_obs)
        if source_type == sourceType then
            c = c + 1
            if not n or c == n then
                item_instance = build_item(self, source_obs, item, i)
                break
            end
        end
    end

    obs.sceneitem_list_release(items)
    obs.obs_source_release(scene_source)

    return item_instance
end

---Get an Item in the Scene by ID.
---@param id integer The ID of the Item.
---@return Item? item The Item if found, nil otherwise.
function Scene:getItemById(id)
    Util.checkInt("id", id)

    local items, scene_source = get_items(self.sourceID)
    if not items then
        return nil
    end

    local item_instance

    for i, item in ipairs(items) do
        local source_obs = obs.obs_sceneitem_get_source(item)
        local item_id = obs.obs_sceneitem_get_id(source_obs)
        if item_id == id then
            item_instance = build_item(self, source_obs, item, i)
            break
        end
    end

    obs.sceneitem_list_release(items)
    obs.obs_source_release(scene_source)

    return item_instance
end

return Scene
