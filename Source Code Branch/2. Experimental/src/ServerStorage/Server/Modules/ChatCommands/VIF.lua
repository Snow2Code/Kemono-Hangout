-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = Client.Events
local CustomizeText = game:GetService("DataStoreService"):GetDataStore("Customize VIF Text")
local Engine = require(game.ServerStorage.Server:WaitForChild("Modules").Engine)
local Engine2 = require(game.ServerStorage.Server:WaitForChild("Modules").Engine2)
local commands = {}

function ConvertCharacterToRig(plr, rigType)
	--
	local Character = plr.Character or plr.CharacterAdded:Wait()
	local humanoid = Character:FindFirstChild("Humanoid")
	local head = Character:FindFirstChild("Head")
	if humanoid and head then
		local newRig = script["Rig"..rigType]:Clone()
		local newHumanoid = newRig.Humanoid
		local originalCFrame = head.CFrame
		newRig.Name = plr.Name
		for a,b in pairs(plr.Character:GetChildren()) do
			if b:IsA("Accessory") or b:IsA("Pants") or b:IsA("Shirt") or b:IsA("ShirtGraphic") or b:IsA("BodyColors") then
				b.Parent = newRig
			elseif b.Name == "Head" and b:FindFirstChild("face") then
				newRig.Head.face.Texture = b.face.Texture
			end
		end
		plr.Character = newRig
		newRig.Parent = workspace
		newRig.Head.CFrame = originalCFrame
	end
	--
end

commands.name =  {
	Name = "name";
	Aliases	= {};
	Tags = {"player"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser, arguments)
		local success, e = pcall(function()
			local player = commandUser
			local name = ""

			if Engine.IsSnowy(commandUser) then
				if Engine.FindPlayer(arguments[1]) ~= nil then
					player = Engine.FindPlayer(arguments[1])
				end
			end
			table.remove(arguments, 1)
			name = table.concat(arguments, " ")

			if name then
				if workspace:FindFirstChild(player.Name) then
					Engine.LogToServer(`{player.Name} Changed their NameTag Name to {name}`)
					CustomizeText:SetAsync(player.UserId, name)
					if workspace:WaitForChild(player.Name):FindFirstChild("Head") then
						if workspace:WaitForChild(player.Name):WaitForChild("Head"):FindFirstChild("NameTag") then
							workspace[player.Name].Head.NameTag.Display.Text = name
						else
							Engine.LogToBoth(`{player.Name}'s character doesn't have a NameTag??? what the heck bro! what did you do!`)
						end
					else
						Engine.LogToBoth(`{player.Name}'s character doesn't have a head??? what the heck bro! what did you do!`)
					end
				else
					Engine.LogToBoth(`{player.Name} doesn't have their character in Workspace.`)
				end
			else
				Engine2.Message(commandUser, "Commands", "Usage - :name [player (Staff and above)] ~new name~")
			end
		end)

		if not success then
			Engine2.Message(commandUser, "Commands", `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'name'. Info: {e}`)
		end
		--Engine.LogToServer("Name changed to: '".. name)
	end
}

commands.refresh =  {
	Name = "refresh";
	Aliases	= {"reset", "re"};
	Tags = {"testtag"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser, arguments)
		local success, e = pcall(function()
			local originalCFrame = workspace[commandUser.Name].Head.CFrame
			commandUser:LoadCharacter()
			workspace[commandUser.Name].Head.CFrame = originalCFrame
		end)
		
		if not success then
			Engine2.Message(commandUser, "Commands", `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'refresh'. Info: {e}`)
		end
	end
}

commands.r6 =  {
	Name = "r6";
	Aliases = {};
	Tags = {"character"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser)
		local success, e = pcall(function()
			ConvertCharacterToRig(commandUser, "R6")
		end)
		
		if not success then
			Engine2.Message(commandUser, "Commands", `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'r6'. Info: {e}`)
		end
	end
}

commands.size = {
	Name = "size";
	Aliases = {"charsize", "scale"};
	Tags = {"character"};
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser, arguments)
		local Player = Engine.FindPlayer(arguments[1])
		local Size = arguments[2]
		
		if Player and Size then
			local success, e = pcall(function()
				Size = tonumber(Size)
				print("Size", Size, typeof(Size))
				if typeof(Size) == "number" then
					local Player = game.Workspace[Player.Name]
					if Size < 0.3 then
						Size = 0.3
						Engine2.Message(commandUser, "Commands", `That size is lower than the minimum Changing it to 0.3`)
					else
						if Size > 2 then
							Size = 2
							Engine2.Message(commandUser, "Commands", `That size is lower than the maximum Changing it to 2`)
						end
					end
					Player:ScaleTo(Size)
					Player.Humanoid.WalkSpeed = 17
					Player.Humanoid.JumpHeight = 7.2
				end
			end)
			if not success then
				Engine2.Message(commandUser, "Commands", `Failed to execute command. Info: {e}`)
				Engine.LogToServer(`Failed to execute command 'size'. Info: {e}`)
			end
		else
			if Player == nil then
				Engine2.Message(commandUser, "Commands", "Could not find player")
				return
			end
			Engine2.Message(commandUser, "Commands", "Usage - :size [player] ~size (min is 0.3, max is 2.)~")
		end
	end
}

return commands
