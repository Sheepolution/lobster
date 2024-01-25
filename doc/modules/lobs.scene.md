# lobs.scene

## lobs.scene.getItemById


```lua
function scene.getItemById(id: integer)
  -> item: Item?
```

Get an Item in the current Scene by ID.

@*param* `id` — The ID of the Item.

@*return* `item` — The Item if found, nil otherwise.

## lobs.scene.getItemByName


```lua
function scene.getItemByName(name: string, n?: integer)
  -> item: Item?
```

Get an Item in the current Scene by name.

@*param* `name` — The name of the Item.

@*param* `n` — Optional. The number of the Item to get. If not provided, the first Item found will be returned.

@*return* `item` — The Item if found, nil otherwise.

## lobs.scene.getItemByType


```lua
function scene.getItemByType(sourceType: SourceType, n?: integer)
  -> item: Item?
```

Get an Item in the current Scene by type.

@*param* [`sourceType`](../types/Enums.md#sourcetype) — The type of the Item.

@*param* `n` — Optional. The number of the Item to get. If not provided, the first Item found will be returned.

@*return* `item` — The Item if found, nil otherwise.


## lobs.scene.getItems


```lua
function scene.getItems()
  -> items: Item[]?
```

Get all Items in the current Scene.

@*return* `items` — The Items in the current Scene if found, nil otherwise.

## lobs.scene.getName


```lua
function scene.getName()
  -> name: string
```

Get the name of the current Scene.

@*return* `name` — The name of the current Scene.

## lobs.scene.getScene


```lua
function scene.getScene(name?: string)
  -> scene: Scene?
```

Get a Scene.

@*param* `name` — Optional. The name of the Scene to get. If not provided, the current Scene will be used.

@*return* `scene` — The Scene if found, nil otherwise.

## lobs.scene.newSource


```lua
function scene.newSource(name: string, sourceType: SourceType, properties?: table, order?: integer)
  -> item: Item?
```

Create a new Source added as an Item to the current Scene.

@*param* `name` — The name of the Source.

@*param* [`sourceType`](../types/Enums.md#sourcetype) — The type of the Source.

@*param* `properties` — Optional. The properties of the Source.

@*param* `order` — Optional. The order of the Item. If not provided, the Item will be added to the top of the item list.

@*return* `item` — The Item if the Source was added, nil otherwise.


## lobs.scene.toScene


```lua
function scene.toScene(name_or_instance: string|Scene)
  -> scene: Scene?
```

Go to a Scene.

@*param* `name_or_instance` — A Scene, or the name of the Scene, to go to.

@*return* `scene` — The Scene switched to if succeeded, nil otherwise.