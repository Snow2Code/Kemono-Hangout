-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local prefix = ":"
local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Engine = require(Server:WaitForChild("Modules"):WaitForChild("Engine", 120))
local Engine2 = require(Server:WaitForChild("Modules"):WaitForChild("Engine2", 120))
--local CommandLogs = {}

local Client = ReplicatedStorage.Client
local commands = {
	["VIF"] = require(Server:WaitForChild("Modules").ChatCommands.VIF),
	["Staff"] = require(Server:WaitForChild("Modules").ChatCommands.Staff),
	["Snowy+Others"] = require(Server:WaitForChild("Modules").ChatCommands["Snowy+Others"])
}

function doCommand(WhatCommandModule, CommadName, Player, Arguments)
	--if not CommandLogs[Player.Name] then
	--	table.insert(CommandLogs, Player.Name)
	--end
	print("Running " .. WhatCommandModule .. ", command is " .. CommadName)
	commands[WhatCommandModule][CommadName].Function(Player, Arguments)
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:GetAttribute("Tranfurring", false)
	end)
	player.Chatted:Connect(function(message, recipient)
		local Rank = player:GetRankInGroup(15517946)
		local WhichCommands = Engine.CanUseCommands(player)

		if WhichCommands ~= nil then			
			local splitString = message:split(" ")
			local cmd = splitString[1]:split(prefix)
			local cmdName = string.lower(cmd[2])
			local arguments = {}
			
			--if string.match(message, ":" .. cmdName) then
			--	print("Has the thing")
			--else
			--	print "Doesn't have the thing"
			--end

			for i = 2, #splitString, 1 do
				table.insert(arguments, string.lower(splitString[i]))
			end

			if arguments[1] == "me" then
				arguments[1] = player.Name
			end
			
			if cmdName == "help" or cmdName == "cmds" then
				Client.Events.Commands.OpenUI:FireClient(player)
			end
			
			print(WhichCommands)
			print(cmdName)
			if WhichCommands == "VIF" or WhichCommands == "All" or WhichCommands == "VIF, Staff" then
				for _, Command in pairs(commands["VIF"]) do
					for _, Aliase in pairs(Command.Aliases) do
						if Aliase ~= nil then
							print(Command.Name)
							if cmdName == Aliase or cmdName == Command.Name then
								print("да")
								doCommand("VIF", Command.Name, player, arguments)
							end
						end
					end
				end
			end
			if WhichCommands == "Staff" or WhichCommands == "All" then
				for _, Command in pairs(commands["Staff"]) do
					for _, Aliase in pairs(Command.Aliases) do
						if Aliase ~= nil then
							print(Command.Name)
							if cmdName == Aliase or cmdName == Command.Name then
								print("да")
								doCommand("Staff", Command.Name, player, arguments)
							end
						end
					end
				end
			end
			if WhichCommands == "Snowy" or WhichCommands == "All" then
				for _, Command in pairs(commands["Snowy+Others"]) do
					for _, Aliase in pairs(Command.Aliases) do
						if Aliase ~= nil then
							print(Command.Name)
							if cmdName == Aliase or cmdName == Command.Name then
								print("да")
								doCommand("Snowy+Others", Command.Name, player, arguments)
							end
						end
					end
				end
			end
		end
		
		
		--Cannot use
		if WhichCommands == "No Access" or WhichCommands == nil then
			Client.Events.Message:FireClient(player, `[Commands] You are not allowed to run this command.`, "#FF5B35")
		end
	end)
end)

--local config: BanConfigType = {
--	UserIds = {3643895594},
--	Duration = -1,
--	DisplayReason = "test",
--	PrivateReason = "testing",
--	ExcludeAltAccounts = false,
--	ApplyToUniverse = true
--}

--local success, err = pcall(function()
--	return Players:BanAsync(config)
--end)
--print(success, err)
----- Warn Kick Msg "[Warning from {staff}] Reason: {reason}"
----- Ban Msg "Banned | Reason: {reason} | banned by {staff}"