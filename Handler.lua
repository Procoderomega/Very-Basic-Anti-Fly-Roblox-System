-- Anti Fly System
-- V2.1
-- Note from me: This doesnt have copyright and that, its free to use and claim and sell and whatever :3
-- Added 2 module scripts that handle configs and the main logic of the Anti cheat

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Antifly = require(game.ServerScriptService.Modules["AntiFly Module"])
local Config = require(game.ServerScriptService.Modules.Config)

local PlayerData = {}


-- Function that rounds the speed in case of debugging, you get 16.00 instead of 16.Alot of numbers
local function round(num, decimals)
	local mult = 10 ^ (decimals or 0)  -- 10 elevado a la cantidad de decimales que quieres
	return math.floor(num * mult + 0.5) / mult
end

Players.PlayerAdded:Connect(function(player)
	PlayerData[player] = {
		Flags = 0,
		LastValidPosition = Vector3.zero
	}
end)

Players.PlayerRemoving:Connect(function(player)
	PlayerData[player] = nil
end)

RunService.Heartbeat:Connect(function()
	
	for player, data in pairs(PlayerData) do
		
		local character = player.Character
		if not character then continue end
		
		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then continue end
		
		Antifly.Check(player, hrp, data, Config)
		
		print("Flags:", data.Flags)
		print("Looping:", player.Name)
	end
end)



