local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getf3x()
    for _, v in ipairs(player.Backpack:GetChildren()) do
        if v:FindFirstChild("SyncAPI") then
            return v
        end
    end
    for _, v in ipairs(player.Character:GetChildren()) do
        if v:FindFirstChild("SyncAPI") then
            return v
        end
    end
end

-- Instant Decal Restore for ID 85000072615292
local function instantDecalRestore()
    local f3x = getf3x()
    if not f3x then 
        warn("F3X not found - Decal restore skipped")
        return 
    end

    local endpoint = f3x.SyncAPI.ServerEndpoint
    local targetId = "85000072615292"

    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Decal") and string.find(v.Texture or "", targetId) then
            task.spawn(function()
                pcall(function()
                    endpoint:InvokeServer("Remove", {v})
                end)
            end)
        end
    end
    
    print("Instant Decal Restore completed for ID: " .. targetId)
end

-- Run instantly when script executes
instantDecalRestore()
