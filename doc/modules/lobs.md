# Lobs

## lobs.debug


```lua
function lobs.debug()
```

Enable printing out each lobster and obs function call.<br>
**WARNING:** Do not use in combination with lobs.update. Doing so will cause OBS to crash.


## lobs.load


```lua
fun()?
```

A callback for when the script is loaded. Hotkeys must be set inside this callback.

Accessing sources in this callback might cause OBS to crash.

## lobs.ready


```lua
fun(scene: Scene)?
```

A callback for when a scene has been found, which can take a few moments when OBS is starting up.

Use this callback for loading sources to be safe.

@[`scene`](../objects/Scene.md) - The scene that was found.


## lobs.release


```lua
function lobs.release()
```

Disable printing and type checks.

## lobs.update


```lua
fun(dt: number)?
```

Called every frame.

@`dt` - The time since the last frame in seconds.