-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server

local Engine = require(Server.Modules.Engine)

Players.PlayerAdded:Connect(function(player)
	Engine.CallWebhook(
		"Join_Leave", script, {["Player"] = player, ["HasTheyLeftOrJoined"] = "Joined"}
	)
end)

Players.PlayerRemoving:Connect(function(player)
	Engine.CallWebhook(
		"Join_Leave", script, {["Player"] = player, ["HasTheyLeftOrJoined"] = "Left"}
	)
end)

Players.PlayerMembershipChanged:Connect(function(player)
	Engine.CallWebhook(
		"Misc", script, {["Title"] = "Member Ship Updated", ["Description"] = `{player.DisplayName} has updated their Membership.`}
	)
end)