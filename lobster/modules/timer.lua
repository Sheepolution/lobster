local path = (...):gsub("[^/.\\]+$", "")
---@type util
local Util = require(path .. "util")

---@class timer
local Timer = {}

---Add a timer.
---@param callback function The function to call on each interval.
---@param ms number The interval in milliseconds.
function Timer.addTimer(callback, ms)
    Util.checkFunction("callback", callback)
    Util.checkFloat("ms", ms)

    obs.timer_add(callback, ms)
end

---Remove a timer.
---@param callback function The function that was used in the timer.
function Timer.removeTimer(callback)
    Util.checkFunction("callback", callback)

    obs.timer_remove(callback)
end

return Timer
