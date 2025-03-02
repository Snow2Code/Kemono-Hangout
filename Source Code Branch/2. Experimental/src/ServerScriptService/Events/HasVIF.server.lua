-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client:WaitForChild("Events")
local Engine = require(game.ServerStorage.Server.Modules.Engine)

Events.Player.HasVIF.OnServerInvoke = function(player)
	local VIF = nil
	local s, e = pcall(function()
		VIF = game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 730933732)
	end)
	
	if not s then
		Engine.LogToServerAndCertainClient(player, "[VIF Check] Failed to check if the play has VIF. Info: " .. e)
	end
	
	return VIF
end