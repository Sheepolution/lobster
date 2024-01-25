local parent_path = (...):gsub("[^/.\\]+.[^/.\\]+$", "")

---@class util
local Util = {}

local lua_to_obs_types = {
    number = "int",
    boolean = "bool",
    string = "string",
    ["nil"] = "string",
    table = "obj",
    array = "array",
    double = "double"
}

---Converts a value to an OBS type.
---@param value any The value to convert.
---@return string type The OBS type.
function Util.getType(value)
    local t = tostring(type(value))

    if t == "table" and value[1] then
        t = "array"
    elseif t == "number" and value % 1 ~= 0 then
        t = "double"
    end

    return lua_to_obs_types[t] or t
end

local obs_to_lua_types = {
    int = "number",
    float = "number",
    bool = "boolean",
    string = "string",
    object = "table",
    enum = "string",
}

---Check if a value is one of multiple types.
---@param name string The name of the value to refer to.
---@param value any The value to check.
---@param types string[] The list of valid types.
---@param args any[] The additional arguments to check for with each type.
---@param optional boolean? Optional. Whether the value may be nil or not.
function Util.checkMulti(name, value, types, args, optional)
    local t = type(value)

    local success = false

    for i, w in ipairs(types) do
        if t == obs_to_lua_types[w] then
            success = true
            local f = Util["check" .. w:sub(1, 1):upper() .. w:sub(2)]

            if w == "enum" or w == "object" then
                f(name, value, unpack(args[i]))
            else
                f(name, value, optional, unpack(args[i]))
            end

            break
        end
    end

    if not success and not optional then
        local concat = table.concat(types, ", ")
        assert(success, "Expected " .. name .. " to be one of " .. concat, 3)
    end
end

---Check if a value is an integer.
---@param name string The name of the value to refer to.
---@param value any The value to check.
---@param optional boolean? Optional. Whether the value may be nil or not.
---@param min integer? Optional. The minimum value of the integer, inclusive.
---@param max integer? Optional. The maximum value of the integer, inclusive.
function Util.checkInt(name, value, optional, min, max)
    if not value and optional then return end
    local t = type(value)
    assert(t == "number", "Expected number for " .. name .. ", got " .. t, 3)
    assert(value % 1 == 0, "Expected integer for " .. name .. ", got float " .. value, 3)

    if min then
        assert(value >= min, "Expected integer for " .. name .. " to be greater than or equal to " .. min, 3)
    end

    if max then
        assert(value <= max, "Expected integer for " .. name .. " to be smaller than or equal to " .. max, 3)
    end
end

---Check if a value is a float.
---@param name string The name of the value to refer to.
---@param value any The value to check.
---@param optional boolean? Optional. Whether the value may be nil or not.
---@param min number? Optional. The minimum value of the float, inclusive.
---@param max number? Optional. The maximum value of the float, inclusive.
function Util.checkFloat(name, value, optional, min, max)
    if not value and optional then return end
    local t = type(value)
    assert(t == "number", "Expected number for " .. name .. ", got " .. t, 3)

    if min then
        assert(value >= min, "Expected float for " .. name .. " to be greater than or equal to " .. min, 3)
    end

    if max then
        assert(value <= max, "Expected float for " .. name .. " to be smaller than or equal to " .. max, 3)
    end
end

---Check if a value is a string.
---@param name string The name of the value to refer to.
---@param value any The value to check.
---@param optional boolean? Optional. Whether the value may be nil or not.
---@param min integer? Optional. The minimum length of the string, inclusive.
---@param max integer? Optional. The maximum length of the string, inclusive.
function Util.checkString(name, value, optional, min, max)
    if not value and optional then return end
    local t = type(value)
    assert(t == "string", "Expected string for " .. name .. ", got " .. t, 3)

    if min then
        assert(#value >= min, "Expected string for " .. name .. " to be longer than or equal to " .. min, 3)
    end

    if max then
        assert(#value <= max, "Expected string for " .. name .. " to be shorter than or equal to " .. max, 3)
    end
end

---Check if a value is a boolean.
---@param name string The name of the value to refer to.
---@param value any The value to check.
---@param optional boolean? Optional. Whether the value may be nil or not.
function Util.checkBool(name, value, optional)
    if not value and optional then return end
    local t = type(value)
    assert(t == "boolean", "Expected boolean for " .. name .. ", got " .. t, 3)
end

function Util.checkTable(name, value, optional)
    if not value and optional then return end
    local t = type(value)
    assert(t == "table", "Expected table for " .. name .. ", got " .. t, 3)
end

function Util.checkFunction(name, value, optional)
    if not value and optional then return end
    local t = type(value)
    assert(t == "function", "Expected function for " .. name .. ", got " .. t, 3)
end

local objects = {}

---Check if a value is an instance of a class.
---@param name string The name of the value to refer to.
---@param value any The value to check.
---@param target Object|string The target class to check against, or the name of the class.
---@param optional boolean? Optional. Whether the value may be nil or not.
function Util.checkObject(name, value, target, optional)
    if not value and optional then return end
    local t = type(value)
    assert(t == "table", "Expected " .. target .. " for " .. name .. ", got " .. t, 3)

    local object = type(target) == "table" and target or
        (objects[target] or require(parent_path .. "objects." .. target --[[@as string]]:lower()))
    objects[target] = object

    assert(value.is and value:is(object), "Expected " .. target .. " for " .. name .. ", got " .. tostring(value), 3)
end

---Check if a value is a valid enum value.
---@param name string The name of the value to refer to.
---@param value any The value to check.
---@param enum_list string[] The list of valid enum values.
---@param optional boolean? Optional. Whether the value may be nil or not.
function Util.checkEnum(name, value, enum_list, optional)
    if not value and optional then return end
    local t = type(value)
    assert(t == "string", "Expected string for " .. name .. ", got " .. t, 3)

    local found = enum_list[value] ~= nil
    local list
    if not found then
        for i, enum in ipairs(enum_list) do
            list = enum_list
            if enum == value then
                found = true
                break
            end
        end
    end

    if not found then
        local concat

        if not list then
            list = {}
            for k, enum in pairs(enum_list) do
                table.insert(list, k)
            end
        end

        concat = table.concat(list, ", ")

        if #concat > 100 then
            concat = concat:sub(1, 100) .. "..."
        end

        assert(found, "Expected " .. name .. " to be one of " .. concat, 3)
    end
end

---Disables type checks.
function Util.disableTypeChecks()
    local noop = function() end
    Util.checkMulti = noop
    Util.checkInt = noop
    Util.checkFloat = noop
    Util.checkString = noop
    Util.checkBool = noop
    Util.checkTable = noop
    Util.checkFunction = noop
    Util.checkObject = noop
    Util.checkEnum = noop
end

return Util
