local player = game.Players.LocalPlayer
local char = player.Character
local backpack = player.Backpack

local function getf3x()
    for _, v in ipairs(backpack:GetChildren()) do
        if v:FindFirstChild("SyncAPI") then
            return v
        end
    end
    for _, v in ipairs(char:GetChildren()) do
        if v:FindFirstChild("SyncAPI") then
            return v
        end
    end
    return nil
end

local f3x = getf3x()
if not f3x then
    warn("you dont have f3x skid")
end

local syncapi = f3x.SyncAPI
local serverendpoint = syncapi.ServerEndpoint

local function delete(part)
    local args = {
        [1] = "Remove",
        [2] = { [1] = part }
    }
    serverendpoint:InvokeServer(unpack(args))
end

local function killall()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Parent:FindFirstChildOfClass("Humanoid") then
            if v ~= char.Head then
                spawn(function()
                    delete(v.Parent.Head)
                end)
            end
        end
    end
end

killall()
