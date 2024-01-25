# lobs.hotkey

## lobs.hotkey.isDown


```lua
function hotkey.isDown(...string)
  -> is_down: boolean
```

Check if a hotkey is being held down.

@*param* `...` — The names of the hotkeys to check.

@*return* `is_down` — True if the hotkey is being held down, false otherwise.

## lobs.hotkey.on


```lua
fun(name: string, pressed: boolean)
```

A callback that is called when a hotkey is pressed or released.

@*param* `name` — The name of the hotkey that was pressed or released.

@*param* `pressed` — Whether the hotkey was pressed, otherwise it was released.


## lobs.hotkey.register


```lua
function hotkey.register(name: string, description: string, callback?: function)
```

Register a hotkey.

@*param* `name` — The name of the hotkey to refer to.

@*param* `description` — The description of the hotkey, shown to the user.

@*param* `callback` — Optional. The callback to call when the hotkey is pressed.