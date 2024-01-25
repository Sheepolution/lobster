# lobs.timer

## lobs.timer.addTimer


```lua
function timer.addTimer(callback: function, ms: number)
```

Add a timer.

@*param* `callback` — The function to call on each interval.

@*param* `ms` — The interval in milliseconds.

## lobs.timer.removeTimer


```lua
function timer.removeTimer(callback: function)
```

Remove a timer.

@*param* `callback` — The function that was used in the timer.