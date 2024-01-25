local parent_path = (...):gsub("[^/.\\]+.[^/.\\]+$", "")

local Type = require(parent_path .. "type")
---@type util
local Util = require(parent_path .. "modules.util")
local Source = require((...):gsub("[^/.\\]+$", "source"))

---@alias vec2 { x: number, y: number }
---@alias transform { pos: vec2, rot: number, scale: vec2, alignment: AlignmentType }

---@class Item : Source
---@field private super Source
---@field private itemID integer
---@field private scene Scene
---@overload fun(data: table): Item
---@private
local Item = Source:extend()

function Item:__tostring()
    return "Item"
end

---Constructor.
---@param data table
function Item:new(data)
    Item.super.new(self, data)
end

---Get the ID of the Item.
---@return integer ID The ID of the Item.
function Item:getItemID()
    return self.itemID or ''
end

---Check if the item still exists in OBS and on a scene.
---@return boolean exists True if the item exists, false otherwise.
function Item:exists()
    local used = self.item_obs
    self.item_obs = nil
    local item_obs, scene_source = self:getOBSItem()
    if not item_obs then
        self.item_obs = used
        return false
    end

    obs.obs_source_release(scene_source)

    self.item_obs = used

    return true
end

---Detach the Item from its Scene.
---@return boolean removed True if the Item was detached successfully, false if it wasn't on a Scene or if it doesn't exist.
function Item:detach()
    local item_obs, scene_source = self:getOBSItem()
    if not item_obs then
        return false
    end

    obs.obs_sceneitem_remove(item_obs)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return true
end

---Get the order position of the Item, referring to the Sources list in OBS.
---@param cache boolean? Optional. Whether to cache the result. Defaults to true.
---@return integer order The order position of the Item.
function Item:getOrderPosition(cache)
    Util.checkBool("cache", cache, true)

    if not self.order or cache == false then
        local item_obs, scene_source = self:getOBSItem()
        if item_obs then
            self.order = obs.obs_sceneitem_get_order_position(item_obs)
        end

        if not self.item_obs then
            obs.obs_source_release(scene_source)
        end
    end

    return self.order
end

---Set the order position of the Item, referring to the Sources list in OBS.
---@param order number The order position of the Item.
---@return boolean success True if the order position was set successfully, false otherwise.
function Item:setOrderPosition(order)
    Util.checkInt("order", order, true)

    local item, scene_source = self:getOBSItem()
    if not item then
        return false
    end

    obs.obs_sceneitem_set_order_position(item, order)
    self.order = obs.obs_sceneitem_get_order_position(item)

    if not self.source_obs then
        obs.obs_source_release(scene_source)
    end

    return order == self.order
end

---Use the Item in a callback to fetch the Item only once, optimizing performance.
---@param callback function The callback to use the Item in.
---@return boolean success True if the Item was used successfully, false otherwise.
function Item:useItem(callback)
    if self.item_obs then
        error("Nested Item:use call")
    end

    local item_obs, scene_source = self:getOBSItem()
    if not item_obs then
        return false
    end

    self.item_obs = item_obs

    callback(self)

    self.item_obs = nil
    obs.obs_source_release(scene_source)

    return true
end

---Get the visibility of the Item.
---@return boolean visible The visibility of the Item.
function Item:isVisible()
    local item, scene_source = self:getOBSItem()

    local visible = obs.obs_sceneitem_visible(item)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return visible
end

---Set the visibility of the Item.
---@param visible boolean The visibility of the Item.
---@return boolean success True if the visibility was set successfully, false otherwise.
function Item:setVisible(visible)
    Util.checkBool("visible", visible, true)

    local item, scene_source = self:getOBSItem()
    if not item then
        return false
    end

    obs.obs_sceneitem_set_visible(item, visible or false)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return true
end

---Get the locked state of the Item.
---@return boolean locked True if the Item is locked, false otherwise.
function Item:isLocked()
    local item, scene_source = self:getOBSItem()

    local locked = obs.obs_sceneitem_locked(item)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return locked
end

---Set the locked state of the Item.
---@param locked boolean The locked state of the Item.
---@return boolean success True if the locked state was set successfully, false otherwise.
function Item:setLocked(locked)
    Util.checkBool("locked", locked, true)

    local item, scene_source = self:getOBSItem()
    if not item then
        return false
    end

    obs.obs_sceneitem_set_locked(item, locked or false)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return true
end

---Get the position of the Item.
---@return vec2? position The position of the Item of found, nil otherwise.
function Item:getPosition()
    local item, scene_source = self:getOBSItem()
    if not item then
        return nil
    end

    local pos = obs.vec2()
    obs.obs_sceneitem_get_pos(item, pos)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return { x = pos.x, y = pos.y }
end

---Set the position of the Item.
---@param position vec2 The position.
---@return boolean success True if the position was set successfully, false otherwise.
function Item:setPosition(position)
    Util.checkTable("position", position)

    local item, scene_source = self:getOBSItem()
    if not item then
        return false
    end

    local position_current = obs.vec2()
    obs.obs_sceneitem_get_pos(item, position_current)

    position_current.x = position.x or position_current.x
    position_current.y = position.y or position_current.y

    obs.obs_sceneitem_set_pos(item, position_current)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return true
end

---Get the rotation of the Item.
---@param degrees boolean? Optional. Whether to return the rotation in degrees. Defaults to false.
---@return number? rotation The rotation of the Item if found, nil otherwise.
function Item:getRotation(degrees)
    local item, scene_source = self:getOBSItem()
    if not item then
        return nil
    end

    local r = obs.obs_sceneitem_get_rot(item)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return degrees and r or math.rad(r)
end

---Set the rotation of the Item.
---@param r number The rotation.
---@param degrees boolean? Optional. Whether the rotation is in degrees. Defaults to false.
---@return boolean success True if the rotation was set successfully, false otherwise.
function Item:setRotation(r, degrees)
    Util.checkFloat("r", r)
    Util.checkBool("degrees", degrees, true)
    local item, scene_source = self:getOBSItem()
    if not item then
        return false
    end

    r = degrees and r or math.deg(r)
    obs.obs_sceneitem_set_rot(item, r)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return true
end

---Get the scale of the Item.
---@return vec2? scale The scale of the Item if found, nil otherwise.
function Item:getScale()
    local item, scene_source = self:getOBSItem()
    if not item then
        return nil
    end

    local scale = obs.vec2()
    obs.obs_sceneitem_get_scale(item, scale)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return { x = scale.x, y = scale.y }
end

---Set the scale of the Item.
---@param scale vec2 The scale.
---@return boolean success True if the scale was set successfully, false otherwise.
function Item:setScale(scale)
    Util.checkTable("scale", scale)

    local item, scene_source = self:getOBSItem()
    if not item then
        return false
    end

    local scale_current = obs.vec2()
    obs.obs_sceneitem_get_scale(item, scale)

    scale.x = scale.x or scale_current.x
    scale.y = scale.y or scale_current.y

    obs.obs_sceneitem_set_scale(item, scale)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return true
end

---Get the size of the Item, the dimensions multiplied by the scale.
---@param cache boolean? Optional. Whether to cache the result. Defaults to true.
---@return vec2? size The size of the Item if found, nil otherwise.
function Item:getSize(cache)
    local item, scene_source = self:getOBSItem()
    if not item then
        return nil
    end

    local scale = obs.vec2()
    obs.obs_sceneitem_get_scale(item, scale)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    local width = self:getWidth(cache)
    local height = self:getHeight(cache)

    scale.x = scale.x * width
    scale.y = scale.y * height

    return scale
end

local alignments_bit_to_string = Type.alignments_bit_to_string
local alignments_string_to_bit = Type.alignments_string_to_bit

---Get the alignment of the Item.
---@return AlignmentType? alignment The alignment of the Item if found, nil otherwise.
function Item:getAlignment()
    local item, scene_source = self:getOBSItem()
    if not item then
        return nil
    end

    local alignment_bitwise = obs.obs_sceneitem_get_alignment(item)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return alignments_bit_to_string[alignment_bitwise]
end

---Set the alignment of the Item.
---@param alignment AlignmentType The alignment.
---@return boolean success True if the alignment was set successfully, false otherwise.
function Item:setAlignment(alignment)
    Util.checkEnum("alignment", alignment, alignments_string_to_bit)

    local item, scene_source = self:getOBSItem()
    if not item then
        return false
    end

    local alignment_bitwise = alignments_string_to_bit[alignment]
    local current = obs.obs_sceneitem_get_alignment(item)
    if current ~= alignment_bitwise then
        obs.obs_sceneitem_set_alignment(item, alignment_bitwise)
    end

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return true
end

---Get the transform of the Item.
---@return transform? transform The transform of the Item if found, nil otherwise.
function Item:getTransform()
    local item, scene_source = self:getOBSItem()
    if not item then
        return nil
    end

    local transform_info = obs.obs_transform_info()
    local transform = {
        pos = transform_info.pos,
        rot = transform_info.rot,
        scale = transform_info.scale,
        alignment = alignments_bit_to_string[transform_info.alignment]
    }

    obs.obs_sceneitem_get_info(item, transform)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return transform
end

---Set the transform of the Item.
---@param transform transform The transform.
---@return boolean success True if the transform was set successfully, false otherwise.
function Item:setTransform(transform)
    local item, scene_source = self:getOBSItem()
    if not item then
        return false
    end

    local pos_current = obs.vec2()
    local scale_current = obs.vec2()

    local transform_info = obs.obs_transform_info()

    pos_current.x = transform.pos.x or transform_info.pos.x
    pos_current.y = transform.pos.y or transform_info.pos.y

    scale_current.x = transform.scale.x or transform_info.scale.x
    scale_current.y = transform.scale.y or transform_info.scale.y

    transform_info.pos = pos_current
    transform_info.rot = transform.rot or transform_info.rot
    transform_info.scale = scale_current
    transform_info.alignment = alignments_string_to_bit[transform.alignment] or transform_info.alignment

    obs.obs_sceneitem_get_info(item, transform)

    if not self.item_obs then
        obs.obs_source_release(scene_source)
    end

    return true
end

---Set the transform of the Item using individual parameters.
---@param x number The horizontal position.
---@param y number The vertical position.
---@param r number The rotation.
---@param sx number The horizontal scale factor.
---@param sy number The vertical scale factor.
---@param alignment AlignmentType The alignment.
---@return boolean success True if the transform was set successfully, false otherwise.
function Item:draw(x, y, r, sx, sy, alignment)
    local callback = function()
        if x or y then
            self:setPosition({ x = x, y = y })
        end

        if r then
            self:setRotation(r)
        end

        if sx or sy then
            self:setScale({ sx = sx, sy = sy })
        end

        if alignment then
            self:setAlignment(alignment)
        end
    end

    if not self.item_obs then
        return self:useItem(callback)
    end

    callback()
    return true
end

---Get this Item's OBS item. Only use this if you know what you're doing.<br>
---WARNING: Make sure to release the scene_source after use in case it is passed.
---@return userdata? item The OBS item, or nil if it doesn't exist.
---@return userdata? scene_source The OBS scene source of the scene the item is on, or nil if the item doesn't exist.
function Item:getOBSItem()
    if self.item_obs then
        return self.item_obs
    end

    local scene_id, item_id = self.scene:getSourceID(), self:getItemID()
    local scene_source = obs.obs_get_source_by_uuid(scene_id)
    if not scene_source then
        return nil
    end

    local scene = obs.obs_scene_from_source(scene_source)
    if not scene then
        obs.obs_source_release(scene_source)
        return nil
    end

    local item_obs = obs.obs_scene_find_sceneitem_by_id(scene, item_id)
    if not item_obs then
        obs.obs_source_release(scene_source)
        return nil
    end

    return item_obs, scene_source
end

return Item
