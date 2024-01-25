# Source

Represents a source in OBS.

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

## exists


```lua
(method) Source:exists()
  -> exists: boolean
```

Check if the source still exists in OBS.

@*return* `exists` — True if the source exists, false otherwise.

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
  -> type: SourceType
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