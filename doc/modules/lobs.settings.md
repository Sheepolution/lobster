# lobs.settings

## lobs.settings.setProperties


```lua
function settings.setProperties(properties: table[])
```

Configure the description and properties for this script.

@*param* [`properties`](../types/Property.md) — The properties to configure.

**Example**
```lua
lobs.settings.configure(
    {
        {
            type = "text",
            id = "change_text",
            name = "New text",
            text_type = "default",
            default = "I have changed!",
        },
        {
            type = "list",
            id = "source",
            name = "Text source",
            description = "The text source to change",
            list_type = "editable",
            format = "string",
            -- Fill the list with Text GDI+ sources
            source_options = { ["text_gdiplus"] = true }
        },
        {
            type = "button",
            id = "change_text_button",
            name = "Change the text",
            callback = function()
                print("Button pressed!")
            end
        },
    }
)
```

## lobs.settings.getDescription


```lua
function settings.getDescription()
  -> description: string
```

Get the script description.

@*return* `description` — The script description.

## lobs.settings.setDescription


```lua
function settings.setDescription(description: string)
```

Set the script description.

@*param* `description` — The script description.


## lobs.settings.on_update


```lua
fun(settings: table)
```

Callback for when the settings are updated. `settings` is a key-value table with the settings.
