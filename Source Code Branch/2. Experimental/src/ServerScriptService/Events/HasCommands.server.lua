-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client:WaitForChild("Events")
local Engine = require(game.ServerStorage.Server.Modules.Engine)

Events.Player.HasCommands.OnServerInvoke = function(player)
	local Rank = player:GetRankInGroup(32066692)
	if Rank > 2 then
		return true
	end
	return false
end