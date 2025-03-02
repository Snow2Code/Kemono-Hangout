-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local NoGoodNames = {
	"Apartment",
	"Coded",
	"CurrentZones",
	"Temp",
	"playerPlaced"
}

game.Players.PlayerAdded:Connect(function(player)
	for _, Name in pairs(NoGoodNames) do
		if string.lower(player.Name) == string.lower(Name) then
			player:Kick("\nYou have a username that our game uses in its code. Please change your username or use a different account and try again.")
		end
	end
end)