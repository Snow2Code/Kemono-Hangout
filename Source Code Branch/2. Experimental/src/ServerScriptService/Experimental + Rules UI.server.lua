-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: Handles Experimental game stuff + Rule UI stuff.
-- \\
-- \\\	///

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage:WaitForChild("Server")
local Engine = require(Server.Modules.Engine)
local IsExperimentalGame = Engine.IsExperimental()

local ExperimentalText_REAL = Server.ExperimentalText

-- Experimental Game Chat Message
if IsExperimentalGame then
	task.spawn(function()
		wait(200)
		local ran, failmsg = pcall(function()
			Client.Events.Message:FireAllClients("You are on the Experimental game of Kemono Hangout\n\nRemeber. Data like Pawprints will not be transmitted to the main game!")
		end)

		if not ran then
			print("Chat Error:\n"..failmsg)
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	if IsExperimentalGame then
        local ExperimentalText = ExperimentalText_REAL:Clone()
		local Text = Engine.RandomExperimentalText()
		ExperimentalText.Text = Text
		ExperimentalText.Parent = player.PlayerGui:WaitForChild("MainUI", 120)
		Client.Events.UI.Rules:FireClient(player, "Experimental")
		
		-- If place is Developments game, set their attribute CanPlay to false so they will be kicked
		if game.PlaceId == 109070408926798 then
			local Rank = player:GetRankInGroup(32066692)
			if Rank > 4 then
				player:SetAttribute("CanPlay", true)
			else 
				player:SetAttribute("CanPlay", false)
				player:Kick("Kicked by Server.\nYou cannot play, as this is a private testing game.\n")
			end
		end
	else
		Client.Events.UI.Rules:FireClient(player, nil)
	end
end)