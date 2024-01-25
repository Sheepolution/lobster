# Getting started

## Install

Clone or download the repository, and place the `lobs` folder in the same directory as your script. In your script require `lobster.lobs`:

```lua
require "lobster.lobs"
```

This exposes the `lobs` global variable, which contains all Lobster functionality. Additionally, it improves the `print` function to allow for multiple arguments, and adds `obs` as an alias for `obslua`.

Lobster is documented using [Lua Language Server](https://github.com/LuaLS/lua-language-server/) annotations. Install it for a linter and autocompletion in your editor.

## Scenes, sources and items

Using Lobster does not omit the need to understand the basics of OBS and its API. The following is a quick overview of the most important concepts.

### Sources

You probably already know that a source can be a webcam, microphone, window capture, image, etc. But scenes, filters and transitions are also sources. ["Sources are the meat of OBS Studio."](https://obsproject.com/kb/sources-guide)

### Scenes

A scene can be seen as a collection of sources that are shown together, but a scene is also a source itself. This means that scenes can be nested, and that scenes can be added to other scenes.

### Filters

Filters are sources that can be applied to other sources to give them an effect. For example, a Color Correction filter can be applied to a webcam source to make it brighter.

### Items

An item represents a source in a scene. It is <u>important</u> to understand the difference between a source and an item. A source on its own does not have position. It is the item that has a position in a scene. There can be multiple distinct items in a scene, each with their own position and more, that all refer to the same source.

## References

Lobster respects the principle of the original API where data should be released as soon as it is no longer needed. All Lobster functions will increment and release the relevant data in the same call. Objects like `Source` also don't hold a reference. Instead, the objects contain the information to fetch or otherwise create the data it needs.

**If nothing refers to the data, it doesn't exist**

The code below shows what to <u>avoid</u>.

```lua
function lobs.ready(scene)
    local dog_image = lobs.source.newSource("dog", "image_source", { file = "D:/images/dog.png" })

    -- The source, meaning the image in OBS, DOES NOT exist at this point.
    -- dog_image, meaning the object in Lua, DOES exist.

    if not dog_image then
        return
    end

    local filter = lobs.source.newFilter("Brightness", "color_filter", {brightness = 0.5})

    -- We add a filter to the source. Except the source doesn't exist
    -- There is also no point for the function to make a new source.
    -- Because at the end of the function the source would be released and thus destroyed.
    dog_image:addFilter(filter)

    -- In this function we do make ths source, as it will be added to the scene.
    -- The source has no filters, because that information was never added.
    local item = scene:addSource(dog_image)

    -- The source has been added to the scene, so now it still exists.
end
```

There are multiple ways to do it right:

* Add the filter after adding it to a scene.
* Use [`dog_image:useSource(callback)`](objects/Source.md#usesource).
* Use [`scene:newSource()`](objects/Scene.md#newSource) instead.

If you want a reference to a source, and you know what you are doing, you can use `local source_obs, release = source:getOBSSource`. The `release` boolean will tell you whether you should release the source after you're done with it.

## Debugging

By calling [`lobs.debug()`](api.md#lobsdebug) you can enable debug logging. This will print all the calls to lobster and the OBS API, which is very helpful for debugging. Do not use this in combination with [`lobs.update()`](api.md#lobsupdate), as it can cause OBS to crash.


## Properties

Properties can be set using [`lobs.settings.setProperties`](modules/settings.md#setproperties). All [property types](types/Property.md) except groups are currently supported.

Here is an example. Note that we don't call the function in a callback. This way we set the properties before OBS has requested the data.

```lua

require "lobster.lobs"

local target_name
local change_text

function lobs.settings.on_update(properties)
    target_name = properties.source
    change_text = properties.change_text
end


lobs.settings.setProperties(
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
                if not target_name then
                    return
                end

                local source = lobs.source.getSourceByName(target_name)

                if source then
                    source:setProperty("text", change_text)
                end
            end
        },
    }
)
```

![](../images/change_text.gif)