-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: Handles badge system.
-- \\
-- \\\	///

local BadgeService = game:GetService("BadgeService")
local ServerStorage = game:GetService("ServerStorage")
local Engine = require(ServerStorage.Server.Modules.Engine)
local ServerType = Engine.GetGameType()
local OllieInGame = false
local LynInGame = false

local BadgesIDs = {
	["Newcomer"] = 2915413896154440,
	["Met the Owner"] = 1177280594694936,
	["Silly Seeker"] = 4183746405357874,
	["Cake Hunter"] = 3013531753200470,
}

function awardBadge(player, badgeid, badgename)
	if not BadgeService:UserHasBadgeAsync(player.UserId, badgeid) then
		BadgeService:AwardBadge(player.UserId, badgeid)
		Engine.LogToServerAndCertainClient(player, `[Badges] The badge '{badgename}' was awarded to {tostring(player.Name)}.`)
	else
		Engine.LogToServerAndCertainClient(player, "[Badges] " .. tostring(player.Name) .. " already has the badge '" .. badgename .. "'.")
	end
end


game.Players.PlayerAdded:Connect(function(player)
	if ServerType == "Standard Server" then
		awardBadge(player, BadgesIDs.Newcomer, "Newcomer")

		if player.UserId == 3643895594 then
			LynInGame = true
		elseif player.UserId == 546537609 then
			OllieInGame = true
		end
		if LynInGame ~= false then
			--Checks if lyn or ollie is in game. If yes. we give user(s) badge
			for _, aplayer in ipairs(game.Players:GetChildren()) do
				awardBadge(aplayer, BadgesIDs["Met the Owner"], "Met the Owner")
			end
		end
		if OllieInGame ~= false then
			for _, aplayer in ipairs(game.Players:GetChildren()) do
				awardBadge(aplayer, BadgesIDs["Silly Seeker"], "Silly Seeker")
			end
		end
	end
end)

task.spawn(function()
	while true do
		wait(0.1)
		if ServerType[1] == "Standard Server" then
			if LynInGame ~= false then
				--Checks if lyn or ollie is in game. If yes. we give user(s) badge
				for _, aplayer in ipairs(game.Players:GetChildren()) do
					awardBadge(aplayer, BadgesIDs["Met the Owner"], "Met the Owner")
				end
			end
			if OllieInGame ~= false then
				for _, aplayer in ipairs(game.Players:GetChildren()) do
					awardBadge(aplayer, BadgesIDs["Silly Seeker"], "Silly Seeker")
				end
			end
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	if player.UserId == 3643895594 then
		LynInGame = false
	elseif player.UserId == 546537609 then
		OllieInGame = false
	end
end)

--workspace.Coded["The cake is a lie."].Hit.Touched:Connect(function(hit)
--	local success, fail = pcall(function()
--		if not hit.Parent:IsA("Accessory") then
--			local success, failmsg = pcall(function()
--				local Player = game.Players:WaitForChild(hit.Parent.Name)
--				Engine:Tranfur(Player, "thecakerandom")
--				awardBadge(Player, BadgesIDs["Cake Hunter"], "Cake Hunter")
--			end)

--			if not success then
--				Core.WarnMessage("THELIE", failmsg)
--			end
--		end
--	end)

--	if not success then
--		Core.WarnMessage("THELIE", fail)
--	end
--end)