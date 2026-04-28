--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]

local player = game.Players.LocalPlayer
local char = player.Character
local tool

for i,v in player:GetDescendants() do
	if v.Name == "Sky" then
		-- do nothing, just skip naming conflict if any
	end
	if v.Name == "SyncAPI" then
		tool = v.Parent
	end
end

for i,v in game.ReplicatedStorage:GetDescendants() do
	if v.Name == "SyncAPI" then
		tool = v.Parent
	end
end

remote = tool.SyncAPI.ServerEndpoint
function _(args)
	remote:InvokeServer(unpack(args))
end

function SetLocked(part,boolean)
	local args = {
		[1] = "SetLocked",
		[2] = {
			[1] = part
		},
		[3] = boolean
	}
	_(args)
end

function SpawnDecal(part,side)
	local args = {
		[1] = "CreateTextures",
		[2] = {
			[1] = {
				["Part"] = part,
				["Face"] = side,
				["TextureType"] = "Decal"
			}
		}
	}

	_(args)
end

function AddDecal(part,asset,side)
	local args = {
		[1] = "SyncTexture",
		[2] = {
			[1] = {
				["Part"] = part,
				["Face"] = side,
				["TextureType"] = "Decal",
				["Texture"] = "rbxassetid://".. asset
			}
		}
	}
	_(args)
end

function spam(id)
	for i,v in game.workspace:GetDescendants() do
		if v:IsA("BasePart") then
			-- Skip Sky part so no decals go on it
			if v.Name == "Sky" then
				continue
			end
			
			spawn(function()
				SetLocked(v,false)
				
				SpawnDecal(v,Enum.NormalId.Front)
				AddDecal(v,id,Enum.NormalId.Front)

				SpawnDecal(v,Enum.NormalId.Back)
				AddDecal(v,id,Enum.NormalId.Back)

				SpawnDecal(v,Enum.NormalId.Right)
				AddDecal(v,id,Enum.NormalId.Right)

				SpawnDecal(v,Enum.NormalId.Left)
				AddDecal(v,id,Enum.NormalId.Left)

				SpawnDecal(v,Enum.NormalId.Bottom)
				AddDecal(v,id,Enum.NormalId.Bottom)

				SpawnDecal(v,Enum.NormalId.Top)
				AddDecal(v,id,Enum.NormalId.Top)
			end)
		end
	end 
end

spam("130264260591536")
