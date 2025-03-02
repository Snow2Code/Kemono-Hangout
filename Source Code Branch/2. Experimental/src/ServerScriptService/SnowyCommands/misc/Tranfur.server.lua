-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local _engine = Server.Modules.Engine
local Engine = require(_engine)

Players.PlayerRemoving:Connect(function(player)
	local character = player.Character or player.CharacterAdded:Wait()
	local Pup_Color = character:GetAttribute("Pup_Color")
	if Pup_Color == "gold" or Pup_Color == "diamond" or Pup_Color == "emerald" or Pup_Color == "rainbow" then
		Engine.PlaySound_Global(_engine.Parent.Sounds.mystery_disappeared)
	end
end)