--
-- classic
--
-- Copyright (c) 2014, rxi
--
-- This module is free software; you can redistribute it and/or modify it under
-- the terms of the MIT license. See LICENSE for details.
--

---@class Class
---@field protected super any
local Object = {}
Object.__index = Object

---@param ... any?
function Object:new(...)
end

--- Extends the class
function Object:extend()
    local cls = {}
    for k, v in pairs(self) do
        if k:find("__") == 1 then
            cls[k] = v
        end
    end
    cls.__index = cls
    cls.super = self
    setmetatable(cls, self)
    return cls
end

--- Implements methods from other classes
---@param ... Class
function Object:implement(...)
    for _, cls in pairs({ ... }) do
        for k, v in pairs(cls) do
            if self[k] == nil and type(v) == "function" then
                self[k] = v
            end
        end
    end
end

--- Checks if the instance is of a given type
---@param T Class The class to check against
---@return boolean is Whether the instance is of the given type
function Object:is(T)
    local mt = getmetatable(self)
    while mt do
        if mt == T then
            return true
        end
        mt = getmetatable(mt)
    end
    return false
end

function Object:__tostring()
    return "Object"
end

--- Allows creating new instances of the class
---@param ... any
---@return Class
function Object:__call(...)
    local obj = setmetatable({}, self)
    obj:new(...)
    return obj
end

return Object
