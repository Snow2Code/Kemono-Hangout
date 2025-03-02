-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local Engine = require(game.ServerStorage.Server.Modules.Engine)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client:WaitForChild("Events")

Events.Chat.GetTeam.OnServerInvoke = function(player)
	return player.Team --.Name
end