-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local _Engine = Server.Modules.Engine
local Engine = require(_Engine)
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = Client.Events

local Teams = game:GetService("Teams")

MessagingService:SubscribeAsync("GLOBAL MESSAGE_CHAT", function(callback)
	Engine.LogToServer("Got Global Message for Chat.\n"..callback["Data"])
	
	local Message = callback["Data"]
	
	if callback ~= nil and Message ~= nil then
		Events.Message:FireAllClients(Message, nil)
	end
end)

for _, Team in pairs(Teams:GetChildren()) do
	MessagingService:SubscribeAsync("GLOBAL MESSAGE_NOTIFICATION-"..Team.Name, function(callback)
		Engine.LogToServer("Got Global Message for Notifications.\n"..callback["Data"])

		local Message = callback["Data"]

		if callback ~= nil and Message ~= nil then
			Events.Notify:FireAllClients(Message, Team.TeamColor.Color)
		end
	end)
end
