# Item

Represents an item in OBS. Inherits from [Source](Source.md).

## detach


```lua
(method) Item:detach()
  -> removed: boolean
```

Detach the Item from its Scene.

@*return* `removed` — True if the Item was detached successfully, false if it wasn't on a Scene or if it doesn't exist.

## draw


```lua
(method) Item:draw(x: number, y: number, r: number, sx: number, sy: number, alignment: AlignmentType)
  -> success: boolean
```

Set the transform of the Item using individual parameters.

@*param* `x` — The horizontal position.

@*param* `y` — The vertical position.

@*param* `r` — The rotation.

@*param* `sx` — The horizontal scale factor.

@*param* `sy` — The vertical scale factor.

@*param* [`alignment`](Enums.md#alignmenttype) — The alignment.

@*return* `success` — True if the transform was set successfully, false otherwise.


## exists


```lua
(method) Item:exists()
  -> exists: boolean
```

Check if the item still exists in OBS and on a scene.

@*return* `exists` — True if the item exists, false otherwise.

## getAlignment


```lua
(method) Item:getAlignment()
  -> alignment: AlignmentType?
```

Get the alignment of the Item.

@*return* [`alignment`](../types/Enums.md#alignmenttype) — The alignment of the Item if found, nil otherwise.

## getItemID


```lua
(method) Item:getItemID()
  -> ID: integer
```

Get the ID of the Item.

@*return* `ID` — The ID of the Item.

## getOBSItem


```lua
(method) Item:getOBSItem()
  -> item: userdata?
  2. scene_source: userdata?
```

Get this Item's OBS item. Only use this if you know what you're doing.<br>
WARNING: Make sure to release the scene_source after use in case it is passed.

@*return* `item` — The OBS item, or nil if it doesn't exist.

@*return* `scene_source` — The OBS scene source of the scene the item is on, or nil if the item doesn't exist.

## getOrderPosition


```lua
(method) Item:getOrderPosition(cache?: boolean)
  -> order: integer
```

Get the order position of the Item, referring to the Sources list in OBS.

@*param* `cache` — Optional. Whether to cache the result. Defaults to true.

@*return* `order` — The order position of the Item.

## getPosition


```lua
(method) Item:getPosition()
  -> position: vec2?
```

Get the position of the Item.

@*return* `position` — The position of the Item of found, nil otherwise.

## getRotation


```lua
(method) Item:getRotation(degrees?: boolean)
  -> rotation: number?
```

Get the rotation of the Item.

@*param* `degrees` — Optional. Whether to return the rotation in degrees. Defaults to false.

@*return* `rotation` — The rotation of the Item if found, nil otherwise.

## getScale


```lua
(method) Item:getScale()
  -> scale: vec2?
```

Get the scale of the Item.

@*return* `scale` — The scale of the Item if found, nil otherwise.

## getSize


```lua
(method) Item:getSize(cache?: boolean)
  -> size: vec2?
```

Get the size of the Item, the dimensions multiplied by the scale.

@*param* `cache` — Optional. Whether to cache the result. Defaults to true.

@*return* `size` — The size of the Item if found, nil otherwise.

## getTransform


```lua
(method) Item:getTransform()
  -> transform: transform?
```

Get the transform of the Item.

@*return* `transform` — The transform of the Item if found, nil otherwise.


## isLocked


```lua
(method) Item:isLocked()
  -> locked: boolean
```

Get the locked state of the Item.

@*return* `locked` — True if the Item is locked, false otherwise.

## isVisible


```lua
(method) Item:isVisible()
  -> visible: boolean
```

Get the visibility of the Item.

@*return* `visible` — The visibility of the Item.

## scene


```lua
Scene
```

## setAlignment


```lua
(method) Item:setAlignment(alignment: AlignmentType)
  -> success: boolean
```

Set the alignment of the Item.

@*param* [`alignment`](../types/Enums.md#alignmenttype) — The alignment.

@*return* `success` — True if the alignment was set successfully, false otherwise.


## setLocked


```lua
(method) Item:setLocked(locked: boolean)
  -> success: boolean
```

Set the locked state of the Item.

@*param* `locked` — The locked state of the Item.

@*return* `success` — True if the locked state was set successfully, false otherwise.

## setOrderPosition


```lua
(method) Item:setOrderPosition(order: number)
  -> success: boolean
```

Set the order position of the Item, referring to the Sources list in OBS.

@*param* `order` — The order position of the Item.

@*return* `success` — True if the order position was set successfully, false otherwise.

## setPosition


```lua
(method) Item:setPosition(position: vec2)
  -> success: boolean
```

Set the position of the Item.

@*param* `position` — The position.

@*return* `success` — True if the position was set successfully, false otherwise.

## setRotation


```lua
(method) Item:setRotation(r: number, degrees?: boolean)
  -> success: boolean
```

Set the rotation of the Item.

@*param* `r` — The rotation.

@*param* `degrees` — Optional. Whether the rotation is in degrees. Defaults to false.

@*return* `success` — True if the rotation was set successfully, false otherwise.

## setScale


```lua
(method) Item:setScale(scale: vec2)
  -> success: boolean
```

Set the scale of the Item.

@*param* `scale` — The scale.

@*return* `success` — True if the scale was set successfully, false otherwise.

## setTransform


```lua
(method) Item:setTransform(transform: transform)
  -> success: boolean
```

Set the transform of the Item.

@*param* `transform` — The transform.

@*return* `success` — True if the transform was set successfully, false otherwise.

## setVisible


```lua
(method) Item:setVisible(visible: boolean)
  -> success: boolean
```

Set the visibility of the Item.

@*param* `visible` — The visibility of the Item.

@*return* `success` — True if the visibility was set successfully, false otherwise.


## useItem


```lua
(method) Item:useItem(callback: function)
  -> success: boolean
```

Use the Item in a callback to fetch the Item only once, optimizing performance.

@*param* `callback` — The callback to use the Item in.

@*return* `success` — True if the Item was used successfully, false otherwise.

___
___


## addFilter


```lua
(method) Source:addFilter(filter: Filter, max: any)
  -> success: boolean
```

Add a filter to the source.

@*param* `filter` — The filter to add.

@*return* `success` — True if the filter was added successfully, false otherwise.

## createOBSSource


```lua
(method) Source:createOBSSource()
  -> source: userdata|nil
  2. release: boolean
```

Creates an OBS source for this Source. Only use this if you know what you're doing.<br>
WARNING: Make sure to release the source after use in case `release` is true.

@*return* `source` — The OBS source, or nil if it couldn't be created.

@*return* `release` — Whether to release the OBS source after use.

## destroy


```lua
(method) Source:destroy()
  -> success: boolean
```

Destroy the source, removing it from OBS.

@*return* `success` — True if the source was destroyed successfully, false if it already was destroyed or if the source doesn't exist.

## getDimensions


```lua
(method) Source:getDimensions(cache?: boolean)
  -> width: number
  2. height: number
```

Get the width and height of the source.

@*param* `cache` — Optional. Whether to use the cached width and height or fetch it from OBS.

@*return* `width` — The width of the source.

@*return* `height` — The height of the source.

## getHeight


```lua
(method) Source:getHeight(cache?: boolean)
  -> height: number
```

Get the height of the source.

@*param* `cache` — Optional. Whether to use the cached height or fetch it from OBS.

@*return* `height` — The height of the source.


## getName


```lua
(method) Source:getName(cache?: boolean)
  -> name: boolean
```

Get the name of the Source.

@*param* `cache` — Optional. Whether to use the cached name or fetch it from OBS.

@*return* `name` — The name of the Source.

## getOBSSource


```lua
(method) Source:getOBSSource(make?: boolean)
  -> source: userdata|nil
  2. release: boolean
```

Get this Source's OBS source. Only use this if you know what you're doing.<br>
WARNING: Make sure to release the source after use in case `release` is true.

@*param* `make` — Optional. Whether to create a new source if it doesn't exist. Defaults to false.

@*return* `source` — The OBS source, or nil if it doesn't exist.

@*return* `release` — Whether to release the OBS source after use.


## getProperties


```lua
(method) Source:getProperties()
  -> properties: table?
```

Get all the properties of the Source.

@*return* `properties` — The properties of the Source if found, nil otherwise.

## getProperty


```lua
(method) Source:getProperty(name: string)
  -> value: any
```

Get a property of the Source.

@*param* `name` — The name of the property.

@*return* `value` — The value of the property if found, nil otherwise.


## getSourceID


```lua
(method) Source:getSourceID()
  -> ID: string
```

Get the ID of the source.

@*return* `ID` — The ID of the source, or an empty string if the source doesn't exist.


## getType


```lua
(method) Source:getType()
  -> sourceType: SourceType
```

Get the type of the source.

@*return* [`sourceType`](../types/Enums.md#sourcetype) — The type of the source


## getWidth


```lua
(method) Source:getWidth(cache?: boolean)
  -> width: number
```

Get the width of the source.

@*param* `cache` — Optional. Whether to use the cached width or fetch it from OBS.

@*return* `width` — The width of the source.

## hasFilter


```lua
(method) Source:hasFilter(filter: Filter)
  -> has_filter: boolean
```

Check if the source has a filter.

@*return* `has_filter` — True if the source has the filter, false otherwise.


## isScene


```lua
(method) Source:isScene()
  -> is_scene: boolean
```

Check if the source is a scene.

@*return* `is_scene` — Ture if the source is a scene, false otherwise.


## removeFilter


```lua
(method) Source:removeFilter(filter: Filter)
  -> success: boolean
```

Remove a filter from the source.

@*param* `filter` — The filter to remove.

@*return* `success` — True if the filter was removed successfully, false otherwise.


## setName


```lua
(method) Source:setName(name: string)
  -> success: boolean
```

Set the name of the Source. If there already is an OBS source with the same name, the name will be changed to something else.

@*return* `success` — True if the name was changed successfully, false if changed to something else or if the source doesn't exist.


## setProperties


```lua
(method) Source:setProperties(properties: table)
  -> success: boolean
```

Set all properties of the Source.

@*param* `properties` — The properties to set.

@*return* `success` — True if the properties were set successfully, false otherwise.

## setProperty


```lua
(method) Source:setProperty(name: string, value: any)
  -> success: boolean
```

Set a property of the Source.

@*param* `name` — The name of the property.

@*param* `value` — The value of the property.

@*return* `success` — True if the property was set successfully, false otherwise.


## useSource


```lua
(method) Source:useSource(callback: function)
  -> success: boolean
```

Use the source in a callback to fetch the source only once, optimizing performance.

@*param* `callback` — The callback to use the source in.

@*return* `success` — True if the source was used successfully, false otherwise.
