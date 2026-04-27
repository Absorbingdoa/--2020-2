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

-- Instant Skybox Restore
local function instantSkyboxRestore()
    local f3x = getf3x()
    if not f3x then 
        warn("F3X not found - Skybox restore skipped")
        return 
    end

    local endpoint = f3x.SyncAPI.ServerEndpoint

    -- Remove custom skybox parts (if any)
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "Sky" then
            pcall(function()
                endpoint:InvokeServer("Remove", {v})
            end)
        end
    end

    -- Restore default skybox
    local skyObject = workspace:FindFirstChildOfClass("Sky")
    if skyObject then
        pcall(function()
            endpoint:InvokeServer("SetProperty", {skyObject, "SkyboxBk", "rbxasset://textures/sky/sky512_bk.png"})
            endpoint:InvokeServer("SetProperty", {skyObject, "SkyboxDn", "rbxasset://textures/sky/sky512_dn.png"})
            endpoint:InvokeServer("SetProperty", {skyObject, "SkyboxFt", "rbxasset://textures/sky/sky512_ft.png"})
            endpoint:InvokeServer("SetProperty", {skyObject, "SkyboxLf", "rbxasset://textures/sky/sky512_lf.png"})
            endpoint:InvokeServer("SetProperty", {skyObject, "SkyboxRt", "rbxasset://textures/sky/sky512_rt.png"})
            endpoint:InvokeServer("SetProperty", {skyObject, "SkyboxUp", "rbxasset://textures/sky/sky512_up.png"})
        end)
    else
        -- Create new default sky if none exists
        local newSky = endpoint:InvokeServer("CreateObject", "Sky", workspace)
        if newSky then
            pcall(function()
                endpoint:InvokeServer("SetProperty", {newSky, "SkyboxBk", "rbxasset://textures/sky/sky512_bk.png"})
                endpoint:InvokeServer("SetProperty", {newSky, "SkyboxDn", "rbxasset://textures/sky/sky512_dn.png"})
                endpoint:InvokeServer("SetProperty", {newSky, "SkyboxFt", "rbxasset://textures/sky/sky512_ft.png"})
                endpoint:InvokeServer("SetProperty", {newSky, "SkyboxLf", "rbxasset://textures/sky/sky512_lf.png"})
                endpoint:InvokeServer("SetProperty", {newSky, "SkyboxRt", "rbxasset://textures/sky/sky512_rt.png"})
                endpoint:InvokeServer("SetProperty", {newSky, "SkyboxUp", "rbxasset://textures/sky/sky512_up.png"})
            end)
        end
    end

    print("Instant Skybox Restore completed")
end

-- Run instantly when script executes
instantSkyboxRestore()
