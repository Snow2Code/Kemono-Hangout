-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = Client.Events
local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local ServerAssets = Server.Assets

local _engine = Server:WaitForChild("Modules").Engine
local Engine = require(_engine)
local Engine2 = require(_engine.Parent.Engine2)
local Items = ServerAssets.Items
local SpecialItems = ServerAssets.Items.Special
local Hats = ServerAssets.Hats
local _TweenInfo = {
	["Alarm"] = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
	["Alarm_Misc"] = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
}
local commands = {}

--Soon. Hats.
--[[
commands.hat = {
	Name = "";
	Aliases	= {"accessory"};
	Tags = {"accessory"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local player = Engine.FindPlayer(arguments[1])
		local character = player.Character
		local humanoid = character:FindFirstChild("Humanoid")
		table.remove(arguments, 1)
		local item = table.concat(arguments, " ")

		if player and item then
			for _, _hat in ipairs(Hats:GetChildren()) do
				if string.lower(_hat.Name) == item then
					local ClonedHat = _hat:Clone()
					ClonedHat.Parent = character
					
					if ClonedHat.Name == "Cone" or ClonedHat.Name == "Bucket" then
						local TranfurName = character:GetAttribute("Tranfur_Name")
						local Message = ""
						if TranfurName ~= nil then
							if string.match(TranfurName, "slimepup_") then
								humanoid.MaxHealth = humanoid.MaxHealth + 15
								humanoid.Health = humanoid.Health + 15
								Message = `You suddenly feel cozy and safe.`
							else
								Message = "You suddenly feel cozy."
							end
						end
						
						Events.Notify:FireClient(
							player,
							Message,
							Color3.fromRGB(255, 223, 83)
						)
					end
				end
			end
		end
	end
}
]]

-- move command was here but moved to bottom!

commands.alarms = {
    Name = "alarms";
    Aliases = {"alarms"}; 
    Tags = {"map", "fun?"};
    Description = "";
    Contributors = {"Snowy"};
    Function = function(commandUser, arguments)
        local success, e = pcall(function()
            local Toggle = arguments[1]
            if not Toggle or (Toggle ~= "on" and Toggle ~= "off") then
                Engine2.Message(commandUser, "Commands", "Invalid arguments. Use 'on' or 'off'. Try the command again.")
                return
            end
            
            local AlarmsActive = Server.Varibles["Alarms Active"]
            if AlarmsActive.Value == nil then return end
            
            local function AlarmRotate(Primary, speed)
                if AlarmsActive.Value then
                    local rotationGoal = {CFrame = Primary.CFrame * CFrame.Angles(0, math.rad(speed), 0)}
                    local Rotate = TweenService:Create(Primary, _TweenInfo.Alarm, rotationGoal)
                    Rotate:Play()
                    Rotate.Completed:Wait()
					AlarmRotate(Primary, speed)
				else
					local rotationGoal = {CFrame = Primary.CFrame * CFrame.Angles(0, math.rad(speed), 0)}
					local Rotate = TweenService:Create(Primary, _TweenInfo.Alarm, rotationGoal)
					Rotate:Play()
					Rotate.Completed:Wait()
                end
            end

            if Toggle == "on" then
				if AlarmsActive.Value ~= true then
					AlarmsActive.Value = true
					for _, alarm in pairs(workspace.Coded.Alarms:GetChildren()) do
						task.spawn(function()
							local Primary = alarm.PrimaryPart
							local color = TweenService:Create(Primary, _TweenInfo.Alarm_Misc, {Color = Primary:GetAttribute("oncolor")})
							local transparency = TweenService:Create(Primary, _TweenInfo.Alarm_Misc, {Transparency = 0})
							local beam1 = TweenService:Create(Primary.LeftBeam, _TweenInfo.Alarm_Misc, {Width1 = 8})
							local beam2 = TweenService:Create(Primary.LeftBeam, _TweenInfo.Alarm_Misc, {Width0 = 0.25})
							local beam3 = TweenService:Create(Primary.RightBeam, _TweenInfo.Alarm_Misc, {Width1 = 8})
							local beam4 = TweenService:Create(Primary.RightBeam, _TweenInfo.Alarm_Misc, {Width0 = 0.25})

							alarm.PrimaryPart.Left.Enabled = true
							alarm.PrimaryPart.Right.Enabled = true
							alarm.PrimaryPart.LeftBeam.Enabled = true
							alarm.PrimaryPart.RightBeam.Enabled = true

							color:Play()
							transparency:Play()
							beam1:Play()
							beam2:Play()
							beam3:Play()
							beam4:Play()

							Primary.Material = Enum.Material.Neon
							task.spawn(function() AlarmRotate(Primary, 25) end)

							local alarmSound = Primary["V2.2 Alarm"]
							alarmSound:Play()
							repeat
								task.wait(0.05)
								alarmSound.PlaybackSpeed = math.min(alarmSound.PlaybackSpeed + 0.1, 1)
							until alarmSound.PlaybackSpeed == 1
						end)
					end
				end
            elseif Toggle == "off" then
				if AlarmsActive.Value ~= false then
					for _, alarm in pairs(workspace.Coded.Alarms:GetChildren()) do
						task.spawn(function()
							local Primary = alarm.PrimaryPart

							local color = TweenService:Create(Primary, _TweenInfo.Alarm_Misc, {Color = Color3.fromRGB(17, 17, 17)})
							local transparency = TweenService:Create(Primary, _TweenInfo.Alarm_Misc, {Transparency = 0.7})
							local beam1 = TweenService:Create(Primary.LeftBeam, _TweenInfo.Alarm_Misc, {Width1 = 0.1})
							local beam2 = TweenService:Create(Primary.LeftBeam, _TweenInfo.Alarm_Misc, {Width0 = 0.1})
							local beam3 = TweenService:Create(Primary.RightBeam, _TweenInfo.Alarm_Misc, {Width1 = 0.1})
							local beam4 = TweenService:Create(Primary.RightBeam, _TweenInfo.Alarm_Misc, {Width0 = 0.1})

							alarm.PrimaryPart.Left.Enabled = false
							alarm.PrimaryPart.Right.Enabled = false

							color:Play()
							transparency:Play()
							beam1:Play()
							beam2:Play()
							beam3:Play()
							beam4:Play()

							beam4.Completed:Connect(function()
								alarm.PrimaryPart.LeftBeam.Enabled = false
								alarm.PrimaryPart.RightBeam.Enabled = false
							end)

							-- Slow down and stop alarm sound
							local alarmSound = Primary["V2.2 Alarm"]
							while alarmSound.PlaybackSpeed > 0 do
								alarmSound.PlaybackSpeed = math.max(alarmSound.PlaybackSpeed - 0.05, 0)
								task.wait(0.1)
							end
							alarmSound:Stop()

						end)
					end
					wait(1)
					AlarmsActive.Value = false
				end
            end
        end)

        if not success then
            Engine2.Message(commandUser, "Commands", `Failed to execute command. Info: {e}`)
            Engine.LogToServer(`Failed to execute command 'alarms'. Info: {e}`)
        end
    end
}

commands.morph = {
	Name = "morph";
	Aliases	= {"mrph"};
	Tags = {"testtag"};
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser, arguments)
		local success, e = pcall(function()
			local player = Engine.FindPlayer(arguments[1])
			local morph = arguments[2]

			local _MORPH_

			if player and morph then
				local Character = player.Character
				for _, _morph in ipairs(ServerAssets.Morphs:GetChildren()) do
					if string.lower(_morph.Name) == morph then
						_MORPH_ = _morph:Clone()
						local Humanoid = Character.Humanoid
						local LastPosition = Character.Head.CFrame

						_MORPH_.Humanoid.DisplayName = player.DisplayName
						_MORPH_.Name = player.Name
						_MORPH_.Head.CFrame = LastPosition
						workspace[player.Name]:Destroy()
						player.Character = _MORPH_
						_MORPH_.Parent = workspace
						
						if _MORPH_:GetAttribute("Morph_Type") == "Protogen" then
							Engine.PlayLoopSound_CertainPlayer(player, _engine.Parent.__Sounds.ProtoSong)
						end
					end
				end
			else
				if player == nil then
					Engine2.Message(commandUser, `Commands`, `Couldn't find that player. Check it and try again.`)
				else
					Engine2.Message(commandUser, `Commands`, `Usage - :morph [player] ~morph~`)
				end
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'morph'. Info: {e}`)
		end
	end
}

commands.maxwell = {
	Name = "maxwell";
	Aliases	= {"maxwell"};
	Tags = {"player", "fun", "silly"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			Events.Message:FireClient(commandUser, "Test Command", Color3.new(255,255,255))
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'maxwell'. Info: {e}`)
		end
	end
}

--commands.test = {
--	Name = "test";
--	Aliases	= {"t", "testali"};
--	Tags = {"testtag"},
--	Description = "";
--	Contributors = {"Snowy"};
--	Function = function(commandUser:Player, arguments)
--		local success, e = pcall(function()
--			Events.Message:FireClient(commandUser, "Test Command", Color3.new(255,255,255))
--		end)

--		if not success then
--			Events.Message:FireClient(commandUser, "Failed to execute a command. Info: " ..e, Color3.new(255,255,255))
--			Engine.LogToServer("Failed to execute a command. " ..e)
--		end
--	end
--}








commands.summonhhh = {
	Name = "summonhhh";
	Aliases	= {"hhh"};
	Tags = {"testtag"};
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser, arguments)
		local success, e = pcall(function()
			local player = Engine.FindPlayer(arguments[1])

			if player then
				local Character = player.Character
				local Humanoid = Character.Humanoid
				local LastPosition = Character.Head.CFrame
				local HHH = ServerAssets.HHH:Clone()

				HHH.Animate.Disabled = true

				HHH.Humanoid.DisplayName = player.DisplayName
				HHH.Name = player.Name
				Character.HumanoidRootPart.Anchored = true
				workspace[player.Name]:Destroy()
				player.Character = HHH
				HHH.Parent = workspace
				HHH.Head.CFrame = LastPosition + Vector3.new(0, 3, 0)
				HHH.HumanoidRootPart.Anchored = true

				task.spawn(function()
					HHH.Chainsaw.Transparency = 1
					local Anim = ServerAssets.Animations.HHH.Spawn:Clone()
					Anim.Parent = HHH

					local _Anim = HHH.Humanoid:LoadAnimation(Anim)
					_Anim:Play()
					HHH.HumanoidRootPart.summon:Play()
					_Anim.Ended:Wait()

					HHH.HumanoidRootPart.Anchored = false
					HHH.Animate.Disabled = false
					HHH.Chainsaw.Transparency = 0

					HHH.HumanoidRootPart.chainsaw_start:Play()
					task.spawn(function()
						wait(3)
						for _, effect in ipairs(HHH.HumanoidRootPart.Effects:GetChildren()) do
							if effect:IsA("ParticleEmitter") then
								effect.Enabled = false
							end
						end
						for _, effect in ipairs(HHH.HumanoidRootPart.Effect_Floor:GetChildren()) do
							if effect:IsA("ParticleEmitter") then
								effect.Enabled = false
							end
						end
						wait(6)
						HHH.HumanoidRootPart.Light_Floor:Destroy()
						HHH.HumanoidRootPart.Effects:Destroy()
						HHH.HumanoidRootPart.Effect_Floor:Destroy()
					end)
					HHH.HumanoidRootPart.chainsaw_start.Ended:Wait()
					HHH.HumanoidRootPart.chainsaw_idle:Play()
					wait(0.2)
					HHH.HHH.CanAttack.Value = true
					HHH.HHH.HHHServer.Disabled = false
					HHH.HHH.HHHClient.Disabled = false
				end)
			else
				Engine2.Message(commandUser, `Commands`, `Usage - :summonhhh [player]`)
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'summonhhh'. Info: {e}`)
		end
	end
}


commands.give =  {
	Name = "give";
	Aliases	= {"tool"};
	Tags = {"items"},
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser:Player, arguments)
		local success, e = pcall(function()
			local groupId = 32066692
			local commandUserRank = commandUser:GetRankInGroup(groupId)

			if not arguments[1] then
				Engine2.Message(commandUser, "Commands", "Usage - [player] ~item~")
				return
			end

			-- Handle "all" players case
			local targetPlayers = {}
			if string.lower(arguments[1]) == "all" then
				for _, p in ipairs(game.Players:GetPlayers()) do
					if p ~= commandUser then
						table.insert(targetPlayers, p)
					end
				end
			else
				local player = Engine.FindPlayer(arguments[1])
				if not player then
					Engine2.Message(commandUser, "Commands", "Couldn't find that player. Check it and try again.")
					return
				end
				table.insert(targetPlayers, player)
			end

			-- Remove player argument and reconstruct item name
			table.remove(arguments, 1)
			local itemName = string.lower(table.concat(arguments, " "))

			-- Determine if item is "golden"
			local isGolden = string.match(itemName, "golden ")
			if isGolden then
				itemName = string.gsub(itemName, "golden ", "")
			end

			-- Search for the item in appropriate folders
			local foundItem

			if itemName == "all" then
				for _, item in ipairs(Items:GetDescendants()) do
					if item:IsA("Tool") then
						-- Check attributes and enforce restrictions
						for _, targetPlayer in ipairs(targetPlayers) do
							task.spawn(function()
								local canContinue = true
								if item:GetAttribute("isTest") then
									if commandUserRank <= 100 then
										if item:GetAttribute("isSpecial") then
											Engine2.Message(commandUser, "Commands", `{item.Name} is a test and special item, so it cannot be given.`)
										else
											Engine2.Message(commandUser, "Commands", `{item.Name} is a test item, so it cannot be given.`)
										end
										if item:GetAttribute("isPurchasable") then
											Engine2.Message(commandUser, "Commands", `{item.Name} is a test and purchasable item and cannot be given.`)
										end
										canContinue = false
									else
										canContinue = true
									end
								end

								if item:GetAttribute("isSpecial") and canContinue ~= false then
									if commandUserRank <= 100 then
										if item:GetAttribute("isTest") then
											Engine2.Message(commandUser, "Commands", `{item.Name} is a special and test item and cannot be given.`)
										else
											Engine2.Message(commandUser, "Commands", `{item.Name} is a special item and cannot be given.`)
										end
										if item:GetAttribute("isPurchasable") then
											Engine2.Message(commandUser, "Commands", `{item.Name} is a special and purchasable item and cannot be given.`)
										end
										canContinue = false
									else
										canContinue = true
									end
								end

								if item:GetAttribute("isPurchasable") and canContinue ~= false then
									if commandUserRank <= 100 then
										Engine2.Message(commandUser, "Commands", `Cannot give purchasable items.`)
										canContinue = false
									else
										canContinue = true
									end
								end

								if canContinue then
									-- Clone and give the item
									local clonedItem = item:Clone()
									clonedItem.Parent = targetPlayer.Backpack
								end
							end)
						end
					end
				end
			else
				for _, item in ipairs(Items:GetDescendants()) do
					if string.lower(item.Name) == itemName and item:IsA("Tool") then
						if isGolden and item.Parent.Name == "Golden" then
							foundItem = item
							break
						elseif not isGolden and item.Parent.Name ~= "Golden" then
							foundItem = item
							break
						end
					end
				end

				-- If item doesn't exist, return error
				if not foundItem then
					Engine2.Message(commandUser, "Commands", `{itemName} isn't an item in the game. Check it and try again.`)
					return
				end

				-- Check attributes and enforce restrictions
				if foundItem:GetAttribute("isTest") and commandUserRank <= 100 then
					Engine2.Message(commandUser, "Commands", `{foundItem.Name} is a test item and cannot be given.`)
					return
				end

				if foundItem:GetAttribute("isSpecial") and commandUserRank <= 100 then
					Engine2.Message(commandUser, "Commands", `{foundItem.Name} is a special item and cannot be given.`)
					return
				end

				if foundItem.Parent.Name == "Purchasables" or foundItem:GetAttribute("isPurchasable") then
					Engine2.Message(commandUser, "Commands", `No cheat! They must buy the item {foundItem.Name}!`)
					return
				end

				-- Give the item to all target players
				for _, targetPlayer in ipairs(targetPlayers) do
					local char = targetPlayer.Character
					local humanoid = char and char:FindFirstChild("Humanoid")

					-- Handle rig type check for melee weapons
					--Legacy and will not be used as per the new weapon system.
					--if foundItem:GetAttribute("type") == "Melee Weapon" then
					--	if humanoid and humanoid.RigType == Enum.HumanoidRigType.R15 and foundItem:GetAttribute("rigTypeRequired") == "R6" then
					--		if #targetPlayers == 1 then
					--			Engine2.Message(commandUser, "Commands", `{foundItem.Name} requires R6. Switch rigs and try again.`)
					--		end
					--		return
					--	end
					--end

					-- Clone and give the item
					local clonedItem = foundItem:Clone()
					clonedItem.Parent = targetPlayer.Backpack
				end
			end
		end)

		-- Error handling
		if not success then
			Engine2.Message(commandUser, "Commands", `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'give'. Info: {e}`)
		end
	end
}






commands.weaponcooldown = {
	Name = "weaponcooldown";
	Aliases	= {"cooldown"};
	Tags = {"weapons", "tools"};
	Description = "";
	Contributors = {"Snowy"};
	Function = function(commandUser, arguments)
		local success, e = pcall(function()
			local arg1 = arguments[1]
			
			if arg1 then
				if arg1 == "all" then
					local cooldown = arguments[2]
					
					for _, Player in ipairs(game.Players:GetPlayers()) do
						for _, Tool in ipairs(Player.Backpack:GetChildren()) do
							if Tool:IsA("Tool") then
								if Tool:GetAttribute("system") == "New Wep Sys" then

									Player.Events.NotifyEvent:FireClient(
										Player,
										`{commandUser.Name} changed the cooldown for your weapon {Tool.Name} from {Tool.Config.Cooldown.Value} to {cooldown}`,
										Color3.new(255, 255, 255)
									)
									if type(tonumber(cooldown)) == "number" then
										Tool.Config.Cooldown.Value = tonumber(cooldown)
									else
										Engine2.Message(commandUser, `Commands`, "Couldn't convert " .. cooldown .. " to a number, using 3.")
										Tool.Config.Cooldown.Value = 3
									end
								end
							end
						end
						for _, Tool in ipairs(Player.Character:GetChildren()) do
							if Tool:IsA("Tool") then
								if Tool:GetAttribute("system") == "New Wep Sys" then
									Player.Events.NotifyEvent:FireClient(
										Player,
										`{commandUser.Name} changed the cooldown for your weapon {Tool.Name} from {Tool.Config.Cooldown.Value} to {cooldown}`,
										Color3.new(255, 255, 255)
									)
									if type(tonumber(cooldown)) == "number" then
										Tool.Config.Cooldown.Value = tonumber(cooldown)
									else
										Engine2.Message(commandUser, `Commands`, "Couldn't convert " .. cooldown .. " to a number, using 3.")
										Tool.Config.Cooldown.Value = 3
									end
								end
							end
						end
					end
					return
				else
					--table.remove(arguments, 1)
					--local arg2 = arguments[2]
					--table.remove(arguments, 2)
					--local item = table.concat(arguments, " ")
					arg1 = Engine.FindPlayer(arg1)
				end
				
				if arg1 ~= nil then
					
				end
			else
				print("a")
			end
		end)

		if not success then
			Engine2.Message(commandUser, `Commands`, `Failed to execute command. Info: {e}`)
			Engine.LogToServer(`Failed to execute command 'weaponcooldown'. Info: {e}`)
		end
	end,
}

return commands
