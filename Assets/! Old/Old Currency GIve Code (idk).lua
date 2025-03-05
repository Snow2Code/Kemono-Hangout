--Old prob, goes unused.
--//==== Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ====//
--//
--// Purpose: 
--// Date Created: 
--// Date Edited: 11/26/2023
--//
--//================================================================================//

local gamepassId = 739169490

game:GetService("RunService").Heartbeat:Connect(function() -- Pawprints
	for _, player in ipairs(game.Players:GetPlayers()) do
		if game:GetService("GamePassService"):PlayerHasPass(player, gamepassId) then
			--print("player has badge")
			if tick() % 120 == 0 then
				local Pawprints = player:WaitForChild("leaderstats", 120):WaitForChild("Pawprints", 120)
				Pawprints.Value = Pawprints.Value + math.random(10, 20)
			end
		else
			if tick() % 180 == 0 then
				local Pawprints = player:WaitForChild("leaderstats", 120):WaitForChild("Pawprints", 120)
				Pawprints.Value = Pawprints.Value + math.random(50, 70)
			end
		end
	end
end)

game:GetService("RunService").Heartbeat:Connect(function() -- Fluff Tokens
	for _, player in ipairs(game.Players:GetPlayers()) do
		if game:GetService("GamePassService"):PlayerHasPass(player, gamepassId) then
			--print("player has badge")
			if tick() % 85 == 0 then
				local FluffTokens = player:WaitForChild("leaderstats", 120):WaitForChild("FluffTokens")
				FluffTokens.Value = FluffTokens.Value + 4
			end
		else
			if tick() % 300 == 0 then
				local FluffTokens = player:WaitForChild("leaderstats", 120):WaitForChild("FluffTokens")
				FluffTokens.Value = FluffTokens.Value + 2
			end
		end
	end
end)
