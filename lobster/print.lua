local oldprint = print

function print(...)
    local str = ""

    for i, v in ipairs({ ... }) do
        str = str .. tostring(v) .. "\t"
    end

    -- Remove last \t
    str = str:sub(1, -2)

    oldprint(str)
end
