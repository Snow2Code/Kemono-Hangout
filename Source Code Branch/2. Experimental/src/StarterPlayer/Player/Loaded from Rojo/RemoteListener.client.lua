-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\ Date Created:
-- \\ Date Format: dd/mm/yyyy, eg 29/01/2025 (29 January 2025)
-- \\
-- \\\	///

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client.Events

Events.Message.OnClientEvent:Connect(function(Message, Color)
	local SendMessage = ""
	if typeof(Color) == "string" then
		if not string.match(Color, "#") then
			--print("[Client Messaging] Wrong color format. Using default color.")
			Color = "#5e5e5e"
			SendMessage = `<font color='{Color}'>{Message}</font>`
		else
			if not string.match(Message, "<font color") then
				--print("[Client Messaging] Message already has a color, not changing.")
				SendMessage = Message
			end
		end
	elseif typeof(Color) == "Color3" then
		--print("[Client Messaging] Color3 given, formatting...")
		Color = Color:ToHex()
		SendMessage = `<font color='#{Color}'>{Message}</font>`
	else
		--print("[Client Messaging] Color argument isn't a string.")
		--print("[Client Messaging] Using default color.")
		Color = "#5e5e5e"
		SendMessage = `<font color='{Color}'>{Message}</font>`
	end
	TextChatService:WaitForChild("TextChannels").RBXGeneral:DisplaySystemMessage(SendMessage)
end)

Events.Notify.OnClientEvent:Connect(function(Message, Color)
	if Color == nil then
		Color = Color3.new(255, 255, 255)
	end
	game.Players.LocalPlayer.Events:FindFirstChild("NotifyFunctionEvent"):Invoke(
		Message,
		Color
	)
end)

-- Server to Client
Events.ServerLog.OnClientEvent:Connect(function(Message)
	print(`\n <<< From Server >>>\n{Message}\n`)
end)

Events.ServerWarn.OnClientEvent:Connect(function(Message)
	warn(`\n <<< From Server >>>\n{Message}\n`)
end)