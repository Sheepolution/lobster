local oldprint = print

local locked = false

function print(...)
    if locked and lobs.update then
        return
    end

    local str = ""

    for i, v in ipairs({ ... }) do
        str = str .. tostring(v) .. "\t"
    end

    -- Remove last \t
    str = str:sub(1, -2)

    oldprint(str)
    locked = true
end

return function()
    locked = false
end
