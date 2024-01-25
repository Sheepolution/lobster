---@type Class
local Class = require((...):gsub("[^/.\\]+.[^/.\\]+$", "libs.classic"))

---@class Object : Class
---@field super Class
---@overload fun(data: table): Object
local Object = Class:extend()

--- Constructor.
---@param data table The data to initialize the object with.
function Object:new(data)
    for k, v in pairs(data) do
        self[k] = v
    end
end

return Object
