-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = Client.Events
local SoundService = game:GetService("SoundService")
local _Engine = game.ServerStorage.Server:WaitForChild("Modules").Engine
local Engine = require(_Engine)
local Engine2 = require(_Engine.Parent.Engine2)
local commands = {}

commands.disguise = {
	Name = "disguise";
	Aliases	= {};
	Tags = {"name", "tags"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local Player = Engine.FindPlayer(arguments[1])
			table.remove(arguments, 1)
			
			local Disguise = table.concat(arguments, " ")
			
			if Disguise then
				if Player:GetAttribute("disguised") == nil then
					Player:SetAttribute("disguised", false)
				end
				Player:SetAttribute("disguised", true)
				Player:SetAttribute("disguise", Disguise)
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :disguise [player] ~disguise~`)
			end
			--Player:SetAttribute("disguised", not Player:GetAttribute("disguised"))
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'disguise'. Info: {e}`)
		end
	end
}

commands.undisguise = {
	Name = "undisguise";
	Aliases	= {"und", "ud"};
	Tags = {""},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local Player = Engine.FindPlayer(arguments[1])
			
			if Player then
				Player:SetAttribute("disguised", false)
				Player:SetAttribute("disguise", "")
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :undisguise ~player~`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'undisguise'. Info: {e}`)
		end
	end
}

commands.tranfur = {
	Name = "tranfur";
	Aliases	= {"tf"};
	Tags = {"character", "furry"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local Player = Engine.FindPlayer(arguments[1])
			local Tranfur = arguments[2]
			
			if arguments[1] == "help" then
				Engine:Tranfur(commandUser, "help")
				Engine2.Message(commandUser, `Commands`, `Tranfurs have been outputted to the developer command. View it with /console command or F9 key.`)
			end
			
			if Player and Tranfur then
				task.spawn(function()
					Engine:Tranfur(Player, Tranfur)
				end)
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :tranfur [player] ~tranfur~</font>\n<font color='#ffffff'>Hint: Use :tranfur help to learn current tranfurs</font>`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info {e}`)
			Engine.LogToServer(`Failed to execute command 'tranfur'. Info: {e}`)
		end
	end
}

commands.play = {
	Name = "play";
	Aliases	= {"p"};
	Tags = {"audio", "sound"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local function Play(sound)
				if SoundService:FindFirstChild("PlaySound_CMD") then
					SoundService:FindFirstChild("PlaySound_CMD"):Stop()
					if sound.Name == "The Wretched Wolf" then
						local WretchedWolf = math.random(1, 2)
						if WretchedWolf == 1 then
							SoundService:FindFirstChild("PlaySound_CMD").SoundId = sound.SoundId
						else
							SoundService:FindFirstChild("PlaySound_CMD").SoundId = "rbxassetid://99031693326731"
						end
					end
					SoundService:FindFirstChild("PlaySound_CMD"):Play()
				else
					local PlaySound_CMD = Instance.new("Sound", SoundService)
					PlaySound_CMD.Name = "PlaySound_CMD"

					if sound.Name == "The Wretched Wolf" then
						local WretchedWolf = math.random(1, 2)
						if WretchedWolf == 2 then
							PlaySound_CMD.SoundId = "rbxassetid://99031693326731"
							PlaySound_CMD.Volume = 0.3
						end
					else
						PlaySound_CMD.SoundId = sound.SoundId
						PlaySound_CMD.Volume = sound.Volume
					end
					SoundService:FindFirstChild("PlaySound_CMD"):Play()
				end
			end
			local sound = table.concat(arguments, " ")
			print(sound)
			print(arguments)
			if sound == "help" then
				Engine.LogToCertainClient(commandUser, `\nPlayable Sounds:`)
				for _, _sound in ipairs(_Engine.Parent.__Sounds.Play:GetChildren()) do
					Engine.LogToCertainClient(commandUser, `{_sound.Name}\n`)
				end
				Engine2.Message(commandUser, `Commands`, `Sounds have been outputted to the developer console. View it with /console command or the F9 key.`)
			end
			if sound then
				if sound == "stop sign" then
					Play(_Engine.Parent.__Sounds.Expurgation)
				end
				
				for _, _sound in ipairs(_Engine.Parent.__Sounds.Play:GetChildren()) do
					if string.lower(_sound.Name) == sound then
						Play(_sound)
					--else
					--	Engine2.Message(commandUser, `Commands`, `{sound} isn't a sound you can play or it doesn't exist. Check it and try again.`)
					end
				end
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :play ~sound~</font>\n<font color='#ffffff'>Hint: Learn current sounds you can play with :play help`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'play'. Info: {e}`)
		end
	end
}

commands.stop = {
	Name = "stop";
	Aliases	= {"s"};
	Tags = {""},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			if SoundService:FindFirstChild("PlaySound_CMD") then
				SoundService:FindFirstChild("PlaySound_CMD"):Stop()
				SoundService:FindFirstChild("PlaySound_CMD"):Destroy()
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'stop'. Info: {e}`)
		end
	end
}

commands.airhorn = {
	Name = "airhorn";
	Aliases	= {"ah"};
	Tags = {"tool", "item setting"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local Player = Engine.FindPlayer(arguments[1])
			
			if Player then
				if Player.Backpack:FindFirstChild("Airhorn") then
					local Airhorn = Player.Backpack:WaitForChild("Airhorn")
					Airhorn:SetAttribute("DebounceDisabled", not Airhorn:GetAttribute("DebounceDisabled"))
				else
					local Airhorn = workspace:WaitForChild(Player.Name):WaitForChild("Airhorn")
					if Airhorn then
						Airhorn:SetAttribute("DebounceDisabled", not Airhorn:GetAttribute("DebounceDisabled"))
					else
						Engine2.Message(commandUser, `Commands`, `{Player.Name} doest't have a airhorn in their inventory. Give them one and try this command again.`)
					end
				end
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :airhorn ~player~`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'airhorn'. Info: {e}`)
		end
	end
}

commands.message = {
	Name = "message";
	Aliases	= {"m"};
	Tags = {""},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			-- TODO: Make this work to only send a chat message to a certain player?
			local Message, FinalMessage, Color = table.concat(arguments, " "), nil, commandUser.Team.TeamColor.Color
			
			if Message then
				FinalMessage = `<font color='#{Color:ToHex()}'>{Message}</font>`
				Events.Message:FireAllClients(FinalMessage)
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :message ~message~`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info {e}`)
			Engine.LogToServer(`Failed to execute command 'message'. Info: {e}`)
		end
	end
}

commands.notify = {
	Name = "notify";
	Aliases	= {"n"};
	Tags = {""},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			--TODO: Let you use this with certain players?
			local Message, Color = table.concat(arguments, " "), commandUser.Team.TeamColor.Color
			
			if Message then
				Events.Notify:FireAllClients(Message, Color)
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :notify ~message~`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'notify'. Info: {e}`)
		end
	end
}

commands.globalchatmessage = {
	Name = "globalchatmessage";
	Aliases	= {"gcm", "globalmessage"};
	Tags = {"server", "global"},
	Description = "Sends a chat message to all active servers.";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local DisplayName = commandUser.DisplayName
			local Message, Color = table.concat(arguments, " "), commandUser.Team.TeamColor.Color

			if Message then
				game:GetService("MessagingService"):PublishAsync(
					"GLOBAL MESSAGE_CHAT",
					"<font color='#" .. Color:ToHex() .. "'>["..DisplayName.." - Global] " .. Message .. "</font>"
				)
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :globalchatmessage ~message~`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'globalchatmessage'. Info: {e}`)
		end	
	end
}

commands.globalnotification = {
	Name = "globalnotification";
	Aliases	= {"gn", "globalnotif"};
	Tags = {""},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local DisplayName = commandUser.DisplayName
			local Message, Color:Color3 = table.concat(arguments, " "), commandUser.Team.TeamColor.Color
			
			if arguments[1] ~= nil or not arguments[1] == "" then
				game:GetService("MessagingService"):PublishAsync(
					"GLOBAL MESSAGE_NOTIFICATION-"..commandUser.Team.Name,
					"["..DisplayName.." - Global] " .. Message
				)
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :globalnotification ~message~`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'globalnotification'. Info: {e}`)
		end
	end
}

commands.poweroutage = {
	Name = "poweroutage";
	Aliases	= {"po", "powerinterruption", "pl"};
	Tags = {""},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			Engine.TriggerEvent("Power Outage")
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'poweroutage]. Info: {e}`)
		end
	end
}

commands.change_value = {
	Name = "change_value";
	Aliases	= {"cvar", "var", "change_variable"};
	Tags = {"server"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local VAR = table.concat(arguments, " ", 1, #arguments - 1)
			local VAL = arguments[#arguments] 
			
			if VAR and VAL then
				print("var " .. VAR)
				print("val " .. VAL)
				
				if VAR == "help" then
					Engine.LogToCertainClient(commandUser, "\nVaribles:")
					for _, varible in ipairs(game.ServerStorage.Server.Varibles:GetChildren()) do
						if varible:GetAttribute("CanBeAccessedByChangeCommand") then
							Engine.LogToCertainClient(commandUser, varible.Name)
						end
					end
					Engine2.Message(commandUser, `Commands`, `Varibles have been outputted to the developer command. View it with /console command or the F9 key.`)
					return
				end
				
				if VAL == "true" or VAL == "1" or VAL == "on" then
					VAL = true
				else
					VAL = false
				end

				for _, Varible:BoolValue in ipairs(game.ServerStorage.Server.Varibles:GetChildren()) do
					if Varible:GetAttribute("CanBeAccessedByChangeCommand") ~= true then
						Engine2.Message(commandUser, `Commands`, `{Varible.Name} cannot be changed by this command.`)
						return
					end
					if string.lower(Varible.Name) == string.lower(VAR) then
						if VAR == string.lower(Varible.Name) then
							VAR.Value = VAL
						end
					end
				end
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :change_value [varible] ~value~</font>\n<font color='#ffffff'>Hint: Use :change_value help to learn all varibles you can change.`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'change_value'. Info: {e}`)
		end
	end
}

--commands.test = {
--	Name = "";
--	Aliases	= {};
--	Tags = {""},
--	Description = "";
--	Contributors = {"Snowy"};
--	Function = function(commandUser:Player, arguments)
--		local success, e = pcall(function()
			
--		end)

--		if not success then
--			Events.Message:FireClient(commandUser, "Failed to execute a command. Info: " ..e, Color3.new(255,255,255))
--			Engine.LogToServer("Failed to execute a command. Info: " ..e)
--		end
--	end
--}

return commands
