-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local Engine = require(game.ServerStorage.Server.Modules.Engine)
local placeholder = ""

game.Players.PlayerAdded:Connect(function(_player)
	_player.Chatted:Connect(function(message, recipient)
		-- game:GetService("AnalyticsService"):LogOnboardingFunnelStepEvent(
		-- 	_player,
		-- 	1,
		-- 	"Test"
		-- )
		if Engine.IsExperimental() then
			if Engine.IsSpecial then
                if string.lower(message) == "engine.getinfos()" then
                    local Message = ""
                    Message = Message .. `Game Version: {Engine.GetVersion()} |\n`
                    Message = Message .. `Place Version: {Engine.GetPlaceVersion()} |\n`
                    Message = Message .. `Player Count: {tostring(#game.Players:GetPlayers())} |\n `
                    Message = Message .. `Server Uptime: {tostring(workspace.DistributedGameTime)} |\n `
                    Message = Message .. `Game Type: {Engine.GetGameType()} |\n`
                    
                    for _, player in ipairs(game.Players:GetChildren()) do
                        Message = Message .. `{player.Name} Is Snowy: {Engine.IsSnowy(player)} |\n`
                        Message = Message .. `Commands that {player.Name} can use:  {Engine.CanUseCommands(player)} |\n`
                        Message = Message .. `{player.Name} has VIF: {Engine.DoesUserHaveVIF(player)} |\n`
                        Message = Message .. `{player.Name} is special: {Engine.IsSpecial(player)} |\n`
                    end
                    
                    Engine.LogToBoth(Message)
                end
            end
		end
	end)
end)