# lobs.util

This module is used internally for type checking and converting, but might be useful to you.

## lobs.util.checkBool


```lua
function util.checkBool(name: string, value: any, optional?: boolean)
```

Check if a value is a boolean.

@*param* `name` — The name of the value to refer to.

@*param* `value` — The value to check.

@*param* `optional` — Optional. Whether the value may be nil or not.

## lobs.util.checkEnum


```lua
function util.checkEnum(name: string, value: any, enum_list: string[], optional?: boolean)
```

Check if a value is a valid enum value.

@*param* `name` — The name of the value to refer to.

@*param* `value` — The value to check.

@*param* `enum_list` — The list of valid enum values.

@*param* `optional` — Optional. Whether the value may be nil or not.

## lobs.util.checkFloat


```lua
function util.checkFloat(name: string, value: any, optional?: boolean, min?: number, max?: number)
```

Check if a value is a float.

@*param* `name` — The name of the value to refer to.

@*param* `value` — The value to check.

@*param* `optional` — Optional. Whether the value may be nil or not.

@*param* `min` — Optional. The minimum value of the float, inclusive.

@*param* `max` — Optional. The maximum value of the float, inclusive.

## lobs.util.checkFunction


```lua
function util.checkFunction(name: any, value: any, optional: any)
```

## lobs.util.checkInt


```lua
function util.checkInt(name: string, value: any, optional?: boolean, min?: integer, max?: integer)
```

Check if a value is an integer.

@*param* `name` — The name of the value to refer to.

@*param* `value` — The value to check.

@*param* `optional` — Optional. Whether the value may be nil or not.

@*param* `min` — Optional. The minimum value of the integer, inclusive.

@*param* `max` — Optional. The maximum value of the integer, inclusive.

## lobs.util.checkMulti


```lua
function util.checkMulti(name: string, value: any, types: string[], args: any[], optional?: boolean)
```

Check if a value is one of multiple types.

@*param* `name` — The name of the value to refer to.

@*param* `value` — The value to check.

@*param* `types` — The list of valid types.

@*param* `args` — The additional arguments to check for with each type.

@*param* `optional` — Optional. Whether the value may be nil or not.

## lobs.util.checkObject


```lua
function util.checkObject(name: string, value: any, target: string|Object, optional?: boolean)
```

Check if a value is an instance of a class.

@*param* `name` — The name of the value to refer to.

@*param* `value` — The value to check.

@*param* `target` — The target class to check against, or the name of the class.

@*param* `optional` — Optional. Whether the value may be nil or not.

## lobs.util.checkString


```lua
function util.checkString(name: string, value: any, optional?: boolean, min?: integer, max?: integer)
```

Check if a value is a string.

@*param* `name` — The name of the value to refer to.

@*param* `value` — The value to check.

@*param* `optional` — Optional. Whether the value may be nil or not.

@*param* `min` — Optional. The minimum length of the string, inclusive.

@*param* `max` — Optional. The maximum length of the string, inclusive.

## lobs.util.checkTable


```lua
function util.checkTable(name: any, value: any, optional: any)
```

## lobs.util.disableTypeChecks


```lua
function util.disableTypeChecks()
```

Disables type checks.

## lobs.util.getType


```lua
function util.getType(value: any)
  -> type: string
```

Converts a value to an OBS type.

@*param* `value` — The value to convert.

@*return* `type` — The OBS type.