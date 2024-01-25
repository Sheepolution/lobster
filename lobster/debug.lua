for name, module in pairs(lobs) do
    if type(module) == "table" and name ~= "obs" then
        for k, v in pairs(module) do
            if type(v) == "function" and k ~= "util" then
                module[k] = function(...)
                    print("DEBUG: " .. name .. "." .. k)
                    return v(...)
                end
            end
        end
    end
end

local oldobs = obs

obs = {}

for k, v in pairs(oldobs) do
    if type(v) == "function" then
        obs[k] = function(...)
            print("DEBUG: " .. k)
            return oldobs[k](...)
        end
    else
        obs[k] = v
    end
end
