-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local BaseHealth = 3000

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		if character:GetAttribute("Is_HHH") == true then
			-- For each player in the game that is not HHH
			for _, _player_ in ipairs(game.Players:GetPlayers()) do
				local _character_ = _player_.Character or _player_.CharacterAdded:Wait()
				if _character_ then
					-- Check if the player is HHH, if not. Add 200 to current health
					if workspace:WaitForChild(_player_.Name):GetAttribute("Is_HHH") ~= true then
						if character.Humanoid.MaxHealth > 9400 then
							character.Humanoid.MaxHealth = 9400
							character.Humanoid.Health = character.Humanoid.MaxHealth
						else
							character.Humanoid.MaxHealth = character.Humanoid.MaxHealth + 200
							character.Humanoid.Health = character.Humanoid.MaxHealth
						end
					end
				end
			end
		end
	end)
end)