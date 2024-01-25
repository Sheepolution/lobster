# lobs.event

## lobs.event.addSignal

```lua
function event.addSignal(signal: SignalType, callback?: function)
```

Add a signal listener.

@*param* `signal` — The [SignalType](../types/Enums.md#signaltype) to listen for.

@*param* `callback` — The function to call when the signal is received.


## lobs.event.on


```lua
fun(event: EventType)?
```

A callback that is called when an event is received.

@*param* `event` — The incoming [EventType](../types/Enums.md#eventtype).


## lobs.event.signal


```lua
fun(signal: SignalType, ...any)?
```

A callback that is called when a signal is received.

@*param* `signal` — The  incoming [SignalType](../types/Enums.md#eventtype).
