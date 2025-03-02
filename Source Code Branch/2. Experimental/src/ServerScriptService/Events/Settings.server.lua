-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client:WaitForChild("Events")

Events.Player.UpdateSetting.OnServerInvoke = function(Player, Setting, Value)
	if Player.ClientSettings:FindFirstChild(Setting) then
		Player.ClientSettings:WaitForChild(Setting).Value = Value
	end
end