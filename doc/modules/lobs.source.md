# lobs.source

## lobs.source.doesSourceExistWithID


```lua
function source.doesSourceExistWithID(id: string)
  -> exists: boolean
```

Check if a source exists with a certain ID.

@*param* `id` — The ID of the source.

@*return* `exists` — True if the source exists, false otherwise.

## lobs.source.doesSourceExistWithName


```lua
function source.doesSourceExistWithName(name: string)
  -> exists: boolean
```

Check if a source exists with a certain name.

@*param* `name` — The name of the source.

@*return* `exists` — True if the source exists, false otherwise.

## lobs.source.getSourceById


```lua
function source.getSourceById(id: string)
  -> source: Source?
```

Get a [Source](../objects/Source.md) by ID.

@*param* `id` — The ID of the Source.

@*return* `source` — The Source if found, nil otherwise.

## lobs.source.getSourceByName


```lua
function source.getSourceByName(name: string)
  -> source: Source?
```

Get a [Source](../objects/Source.md) by name.

@*param* `name` — The name of the Source.

@*return* `source` — The Source if found, nil otherwise.

## lobs.source.newFilter


```lua
function source.newFilter(name: string, filterType: FilterType, properties?: table)
  -> filter: Filter
```

Create a new [Filter](../objects/Filter.md).

@*param* `name` — The name of the filter.

@*param* [`filterType`](../types/Enums.md#filtertype) — The type of the filter.

@*param* `properties` — Optional. The settings of the filter.

@*return* `filter` — The new Filter.


## lobs.source.newSource


```lua
function source.newSource(name: string, sourceType: SourceType, properties?: table, callback?: function)
  -> source: Source
```

Create a new [Source](../objects/Source.md).

@*param* `name` — The name of the Source.

@*param* [`sourceType`](../types/Enums.md#sourcetype) — The type of the Source.

@*param* `properties` — Optional. The properties of the Source.

@*param* `callback` — Optional. The callback to use the Source in.

@*return* `source` — The new Source.


## lobs.source.useSourceByID


```lua
function source.useSourceByID(id: any, callback: function)
  -> success: boolean
```

Use a [Source](../objects/Source.md) found by ID in a callback to fetch the Source only once, optimizing performance.

@*param* `callback` — The callback to use the Source in.

@*return* `success` — True if the Source was used successfully, false otherwise.

## lobs.source.useSourceByName


```lua
function source.useSourceByName(name: any, callback: function)
  -> success: boolean
```

Use a [Source](../objects/Source.md) found by name in a callback to fetch the Source only once, optimizing performance.

@*param* `callback` — The callback to use the Source in.

@*return* `success` — True if the Source was used successfully, false otherwise.