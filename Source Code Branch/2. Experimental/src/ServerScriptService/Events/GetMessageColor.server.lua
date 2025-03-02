-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local PlayerSettings = require(game.ServerStorage.PlayerSettings)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client:WaitForChild("Events")

Events.Chat.GetMessageColor.OnServerInvoke = function(player)
	return PlayerSettings.GetSetting(player, "ChatMessageColor")
end