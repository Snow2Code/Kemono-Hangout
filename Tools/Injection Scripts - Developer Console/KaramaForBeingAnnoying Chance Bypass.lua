-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: Bypasses the Airhorn thingy.
-- \\
-- \\\	///

local ExploitName = "Karama For Being Annoying Mod"
local Player = "All" --game.Players:FindFirstChild("fuzzy_james") -- REPLACE ME!

-- Purpose: Outputs.
function out(message)
	warn(`\n{ExploitName}\n{message}\n`)
end

function CallEvents(Player, Tool, Type)
    -- Check the Type for what to fire.
    if Type == "Client" then
        Tool.Events.BindableEvent_Bypass:Fire()
        -- Tool.Events.RemoteEvent_Bypass:FireServer()
        -- Tool.Events.RemoteFunction_Bypass:InvokeServer()
        -- Tool.Events.BindableFunction_Bypass:Invoke()
    elseif Type == "Server" then
        Tool.Events.BindableEvent_Bypass:Fire()
        -- Tool.Events.RemoteEvent_Bypass:FireClient(Player)
        -- Tool.Events.RemoteFunction_Bypass:InvokeClient()
        -- Tool.Events.BindableFunction_Bypass:Invoke()
    else
        out(`Invalid CallEvent type.`)
    end
end

warn(
[[
{ExplotName} - Chance Bypass
Orignal Karama mod by Chrigi for Lethal Company.

Lethal Company Airhorn Recreation in Roblox by Snowy (code also. same with this file)
]])

-- Checks if the Player is valid
if Player then
    -- Checking if Player is a string.
	if typeof(Player) == "string" then
		if Player == "All" then
			for _, ActualPlayer in ipairs(game.Players:GetPlayers()) do
				if ActualPlayer.Character:FindFirstChild("Airhorn") then
					CallEvents(ActualPlayer, ActualPlayer.Character:WaitForChild("Airhorn"), "Server")
					out(`Giving {ActualPlayer.DisplayName} "karama" >:3`)
				else
					out(`Cannot find a Airhorn in {ActualPlayer.DisplayName}'s Character. Checking Backpack.`)
				end
	
				-- Checking backpack now.
				if ActualPlayer.Backpack:FindFirstChild("Airhorn") then
					CallEvents(ActualPlayer, ActualPlayer.Backpack:WaitForChild("Airhorn"), "Server")
					out(`Giving {ActualPlayer.DisplayName} "karama" >:3`)
				else
					out(`Cannot find a Airhorn in {ActualPlayer.DisplayName}'s Backpack. So we cannot give them "karama".`)
				end
			end
		end
    else
        -- Look for a Airhorn in the Player's Character, equipped.
        if Player.Character:FindFirstChild("Airhorn") then
            CallEvents(Player, Player.Character:WaitForChild("Airhorn"), "Server")
            out(`Giving {Player.DisplayName} "karama" >:3`)
        else
            out(`Cannot find a Airhorn in {Player.DisplayName}'s Character. Checking Backpack.`)
        end
        
        -- Checking backpack now.
        if Player.Backpack:FindFirstChild("Airhorn") then
            CallEvents(Player, Player.Backpack:WaitForChild("Airhorn"), "Server")
            out(`Giving {Player.DisplayName} "karama" >:3`)
        else
            out(`Cannot find a Airhorn in {Player.DisplayName}'s Backpack. So we cannot give them "karama".`)
        end
    end
else
	out(`Failed to run. Info: Player is not vaild.`) -- We failed to run the script, so output that.
end