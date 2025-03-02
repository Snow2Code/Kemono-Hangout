-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local HTTP = game:GetService("HttpService")
local CollectionSerivce = game.CollectionService
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client.Events
local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage:WaitForChild("Server")
local Assets = Server.Assets
local Varibles = Server.Varibles
-- local Values = Server.Values
local Sounds = Server.Game.Sounds--script:WaitForChild("Sounds")w
local Base64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local Anims = Server.Assets.Animations
local Tranfurs = Server.Assets.Tranfurs

local _Engine = script
local Engine2 = require(script.Parent.Engine2)
local Engine = {}

local _PowerOutageMusic_ = {
	"rbxassetid://15968226430",
	"rbxassetid://16477319266",
	"rbxassetid://15968224871"
}

function Engine.Notify(player, message, color)
	if not color then color = Color3.fromRGB(212, 168, 231) end
	Events.Notify:FireClient(player, message, color)
end

function Engine.NotifyAll(message, color)
	if not color then color = Color3.fromRGB(212, 168, 231) end
	Events.Notify:FireAllClients(message, color)
end

function TriggerLights(whatTrigger)
	if whatTrigger == "On" then
		for _, folder in pairs(CollectionSerivce:GetTagged("lights")) do
			for _, Light in ipairs(folder:GetChildren()) do
				if Light:IsA("Part") then
					Light.Transparency = 0.3
					Light.SpotLight.Enabled = true
					Light.Parts.Light = Light:GetAttribute("Light_Default_Transparency")
					for _, _Light in ipairs(Light["Real Light"]:GetChildren()) do
						_Light.SpotLight.Enabled = true
					end
				elseif Light:IsA("Model") then
					if Light:GetAttribute("Light_Type") == "ElevatorLight" or Light:GetAttribute("Light_Type") == "WallLight" then
						Light.Parts.Light = Light:GetAttribute("Light_Default_Transparency")
						for _, _Light in ipairs(Light["Real Light"]:GetChildren()) do
							_Light.SpotLight.Enabled = true
						end
					elseif Light:GetAttribute("Light_Type") == "CafeCelingLight" then
						for _, _Light_ in ipairs(Light:GetChildren()) do
							if _Light_:IsA("Part") then
								_Light_.SpotLight.Enabled = true
							elseif _Light_:IsA("Model") then
								for _, LightChild in ipairs(_Light_:GetChildren()) do
									LightChild.Transparency = 0.3
								end
							end
						end
					end
				end
			end
		end
	elseif whatTrigger == "Off" then
		print("baby turn da lights down lowwww")
		for _, folder in pairs(CollectionSerivce:GetTagged("lights")) do
			for _, Light in ipairs(folder:GetChildren()) do
				if Light:IsA("Part") then
					Light.Transparency = 0.8
					Light.SpotLight.Enabled = false
				elseif Light:IsA("Model") then
					if Light:GetAttribute("Light_Type") == "ElevatorLight" or Light:GetAttribute("Light_Type") == "WallLight" then
						Light.Parts.Light.Transparency = 0.3
						for _, _Light in ipairs(Light["Real Light"]:GetChildren()) do
							_Light.SpotLight.Enabled = false
						end
					elseif Light:GetAttribute("Light_Type") == "CafeCelingLight" then
						for _, _Light_ in ipairs(Light:GetChildren()) do
							if _Light_:IsA("Part") then
								_Light_.SpotLight.Enabled = false
							elseif _Light_:IsA("Model") then
								for _, LightChild in ipairs(_Light_:GetChildren()) do
									LightChild.Transparency = 0.3
								end
							end
						end
					end
				end
			end
		end
	end
end

function Engine.TriggerEvent(event)
	event = string.lower(event)
	if event == "power outage" then
		if Varibles["Power Outage"].Value == true then -- If it's active
			if Varibles["Power Outage_Can Be Called"].Value == true then
				Varibles["Power Outage_Can Be Called"].Value = false
				task.spawn(function() TriggerLights("On") end)
				task.spawn(function()
					Engine.PlaySound_Global(Sounds["Power Outage - Lights On"])
				end)
				if game:GetService("Workspace").Temp.Commands["__ENGINE"]:FindFirstChild("Music_PO") then
					game:GetService("Workspace").Temp.Commands["__ENGINE"]:FindFirstChild("Music_PO"):Destroy()
				end
				Varibles["Power Outage"].Value = false -- Using false instead of = not value to be safe. It's better to be more safe than sorry ^^
				for _, player in ipairs(game.Players:GetChildren()) do
					Engine.Notify(player, "Power gird has been initiated.")
				end
				wait(2)
				Varibles["Power Outage_Can Be Called"].Value = true
			end
		else -- If it's not active.
			Varibles["Power Outage"].Value = true
			Varibles["Power Outage_Can Be Called"].Value = false
			
			local PowerOutageMusic = Instance.new("Sound")
			if Engine.GetDate() == "01 April" then
				PowerOutageMusic.SoundId = "rbxassetid://1846080689"
			else
				PowerOutageMusic.SoundId = _PowerOutageMusic_[math.random(1, #_PowerOutageMusic_)]
			end
			PowerOutageMusic.Name = "Music_PO"
			PowerOutageMusic.Parent = workspace.Temp.Commands["__ENGINE"]
			
			PowerOutageMusic.Volume = 0.3
			PowerOutageMusic.Looped = true
			task.spawn(function() TriggerLights("Off") end)
			task.spawn(function()
				Engine.PlaySound_Global(Sounds["Power Outage - Start"])
			end)
			
			Engine.NotifyAll("Sudden disturbance power grid detected.") wait(3)
			Engine.NotifyAll("Unable to initiate Emergency Power grid.") wait(3)
			Engine.NotifyAll("Please stand by...")
			wait(1.5)
			PowerOutageMusic:Play()
			
			wait(2)
			Varibles["Power Outage_Can Be Called"].Value = true
			--wait(750)
			--InterruptLights("TurnOn")
		end
	end
end


function Engine:EncodeBase64(data)
	local encoded = ((data:gsub('.', function(x)
		local r, b = '', x:byte()
		for i = 8, 1, -1 do
			r = r .. (b % 2^i - b % 2^(i - 1) > 0 and '1' or '0')
		end
		return r
	end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c = 0
		for i = 1, 6 do
			c = c + (x:sub(i, i) == '1' and 2^(6 - i) or 0)
		end
		return Base64:sub(c + 1, c + 1)
	end) .. ({ '', '==', '=' })[#data % 3 + 1])
	return encoded
end

function Engine:DecodeBase64(data)
	data = string.gsub(data, '[^' .. Base64 .. '=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r, f = '', (Base64:find(x) - 1)
		for i = 6, 1, -1 do
			r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
		end
		return r
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c = 0
		for i = 1, 8 do
			c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0)
		end
		return string.char(c)
	end))
end

function Engine:RemoveAccessorys(Player)
	task.spawn(function()
		for _,Inst in next, Player.Character.Humanoid:GetAccessories() do
			if Inst.Handle:FindFirstChild("HairAttachment") then continue end
			if Inst.AccessoryType == Enum.AccessoryType.Hair then continue end
			
			if not Inst.Handle:FindFirstChild("AccessoryWeld") then
				Inst:Destroy()
			else
				task.spawn(function()
					local Handle = Inst.Handle
					Handle.AccessoryWeld:Destroy()
					Handle.CanCollide = false
					Handle.Anchored = true

					local TweenEnded = false

					task.spawn(function()
						local rotationVel = Vector3.new(Random.new():NextNumber(-10, 10), Random.new():NextNumber(-10, 10), Random.new():NextNumber(-10, 10))
						while task.wait() and not TweenEnded and Handle and Handle:IsDescendantOf(workspace) and 1 > Handle.Transparency do
							Events:WaitForChild("ClientTween"):Invoke(Handle, {.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut}, {
								Orientation = Handle.Orientation + rotationVel
							}, true)
						end
					end)
					Events:WaitForChild("ClientTween"):Invoke(Handle, {3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {
						Transparency = 1,
						Position = Handle.Position + Vector3.new(Random.new():NextNumber(-10, 10), Random.new():NextNumber(-10, 10), Random.new():NextNumber(-10, 10))
					}, true)
					TweenEnded = true
					Inst:Destroy()
				end)
			end
		end
	end)
end

function Engine.IsSpecial(player)
	local Rank = player:GetRankInGroup(32066692)
	
	if Rank > 100 then
		return true
	end
	return false
end

local function cover(part, color,type,where)
	local weld = Instance.new("Weld",part)
	local Goo = Assets.Goo:Clone()
	Goo.Color = color
	Goo.Parent = part.Parent
	Goo.Size = part.Size
	--Goo.Color = Color3.new(255, 255, 255)
	weld.Part0 = part
	weld.Part1 = Goo

	if where == "top" then
		Goo.Mesh.Offset = Vector3.new(0,1,0)
	end
	if type == "head" then
		Goo.Mesh.MeshType = Enum.MeshType.Head
		Goo.Mesh.Scale = Vector3.new(1.25,0,1.25)
		game:GetService("TweenService"):Create(Goo.Mesh, TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {Scale = Vector3.new(1.26,1.26,1.26),Offset = Vector3.new(0,0,0)}):Play()
	else
		Goo.Mesh.MeshType = Enum.MeshType.FileMesh
		Goo.Mesh.MeshId = "rbxassetid://430080282"
		if type == "torso" then
			Goo.Mesh.Scale = Vector3.new(2.05,0,1.05)
			Goo.Noise.PlaybackSpeed = 0.85
			game:GetService("TweenService"):Create(Goo.Mesh, TweenInfo.new(0.75,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {Scale = Vector3.new(2.05,1.05,1.05),Offset = Vector3.new(0,0,0)}):Play()
		else
			game:GetService("TweenService"):Create(Goo.Mesh, TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {Scale = Vector3.new(1.05,1.05,1.05),Offset = Vector3.new(0,0,0)}):Play()
		end
	end
	Goo.Noise:Play()
end

function TranfurGoo(Player, LastPosition, Tranfur, rig)
	local Character = Player.Character
	if rig == "R15" then
		cover(Character["LeftLowerArm"], Tranfur["Body Colors"].LeftArmColor3,"limb","bottom")
		cover(Character["RightLowerArm"], Tranfur["Body Colors"].RightArmColor3,"limb","bottom")
		wait(0.5)
		cover(Character["LeftUpperArm"], Tranfur["Body Colors"].LeftArmColor3,"limb","bottom")
		cover(Character["RightUpperArm"], Tranfur["Body Colors"].RightArmColor3,"limb","bottom")
		wait(0.3)
		Engine:RemoveAccessorys(Player)
		wait(0.5)
		cover(Character["UpperTorso"], Tranfur["Body Colors"].TorsoColor3, "torso", "top")
		wait(0.5)
		wait(0.7)
		cover(Character["LeftLowerLeg"], Tranfur["Body Colors"].LeftLegColor3,"limb","bottom")
		wait(0.2)
		cover(Character["RightLowerLeg"], Tranfur["Body Colors"].RightLegColor3, "limb", "bottom")
		wait(0.5)
		cover(Character["LeftUpperLeg"], Tranfur["Body Colors"].LeftLegColor3,"limb","bottom")
		wait(0.2)
		cover(Character["RightUpperLeg"], Tranfur["Body Colors"].LeftLegColor3,"limb","bottom")
		wait(0.6)
		cover(Character["Head"], Tranfur["Body Colors"].HeadColor3, "head", "bottom")
		wait(0.7)
	elseif rig == "R6" then
		cover(Character["Left Arm"], Tranfur["Body Colors"].LeftArmColor3,"limb","bottom")
		cover(Character["Right Arm"], Tranfur["Body Colors"].RightArmColor3,"limb","bottom")
		wait(0.8)
		cover(Character["Torso"], Tranfur["Body Colors"].TorsoColor3, "torso", "top")
		wait(0.5)
		Engine:RemoveAccessorys(Player)
		wait(0.7)
		cover(Character["Left Leg"], Tranfur["Body Colors"].LeftLegColor3,"limb","bottom")
		wait(0.7)
		cover(Character["Right Leg"], Tranfur["Body Colors"].RightLegColor3, "limb", "bottom")
		wait(1)
		cover(Character["Head"], Tranfur["Body Colors"].HeadColor3, "head", "bottom")
		wait(0.7)
	end
end

function StarterScripts(TranfurModel)
	for _, childScript in pairs(game.StarterPlayer.StarterCharacterScripts:GetChildren()) do
		if childScript.Name == "Animate" then
			TranfurModel.Animate:Destroy()
			local Script = childScript:Clone()
			Script.Parent = TranfurModel
		else
			local Script = childScript:Clone()
			Script.Parent = TranfurModel
		end
	end
end

function Engine.PlayLoopSound_CertainPlayer(player, _sound:Sound)
	local Character = player.Character
	local Sound = _sound:Clone()
	Sound.Parent = Character.HumanoidRootPart
	Sound:Play()
end

function Engine.PlayTempSound_CertainPart(part, _sound:Sound)
	local Sound = _sound:Clone()
	Sound.Parent = part
	task.spawn(function()
		Sound:Play()
		Sound.Ended:Wait()
		Sound:Destroy()
	end)
end

function Engine.PlaySound_Global(sound)
	local Sound = sound:Clone()
	Sound.Parent = game.Workspace.Temp
	Sound.RollOffMaxDistance = "inf"
	Sound.RollOffMinDistance = "inf"
	Sound:Play()
	Sound.Ended:Wait()
	Sound:Destroy()
end

function TranfurSounds(Player, Tranfur, TranfurModel)
	-- Tranfur Sounds and Other
	if Engine.IsSpecial(Player) then
		local _SOUND = nil
		local TransfurModelNameLower = string.lower(TranfurModel:GetAttribute("Tranfur_Name"))
		if Tranfur == "thecakeisalie;owner" or TransfurModelNameLower == "thecakeisalie;owner" then
			_SOUND = Sounds.Transfur["Targeted!"]
		elseif Tranfur == "slimepup;color=gold" or TransfurModelNameLower == "slimepup;color=gold" then
			Engine.PlaySound_Global(script.Sounds.mystrey_appeared)
			_SOUND = Sounds.Transfur["Rare."]
		elseif string.match(Tranfur, "slimepup;color=dia") then
			Engine.PlaySound_Global(script.Sounds.mystrey_appeared)
			_SOUND = Sounds.Transfur["DIA!"]
		elseif Tranfur == "slimepup;color=rb" or TransfurModelNameLower == "slimepup;color=rb"
			or Tranfur == "slimepup;color=rainbow" or TransfurModelNameLower == "slimepup;color=rainbow" then
			Engine.PlaySound_Global(script.Sounds.mystrey_appeared)
		--elseif Tranfur == "" or TransfurModelNameLower == "" then
			--elseif TheTranfur == "" or TransfurModelNameLower == "" then
			--elseif TheTranfur == "" or TransfurModelNameLower == "" then
			--elseif TheTranfur == "" or TransfurModelNameLower == "" then
			--elseif TheTranfur == "" or TransfurModelNameLower == "" then
			--elseif TheTranfur == "" or TransfurModelNameLower == "" then

		end
		if _SOUND ~= nil then
			Engine.PlayTempSound_CertainPart(TranfurModel.HumanoidRootPart, _SOUND)
		end
	end
end

local function ActualMainFur(RigType, Character, TheTranfur, TranfurModel, Player, DisplayName)
	local Humanoid = Character.Humanoid
	local LastPosition
	local Anim = nil
	local AnimAfter = nil
	local _rigType = ""
	
	if RigType == Enum.HumanoidRigType.R15 then
		_rigType = "R15"
		Anim = Humanoid:LoadAnimation(Anims.Tranfurring.R15.Tranfur)
		AnimAfter = Humanoid:LoadAnimation(Anims.Tranfurring.R15.TranfurAfter)
	else
		_rigType = "R6"
		Anim = Humanoid:LoadAnimation(Anims.Tranfurring.R6.Tranfur)
		AnimAfter = Humanoid:LoadAnimation(Anims.Tranfurring.R6.TranfurAfter)
	end
	
	if Anim ~= nil then
		Anim:Play()
	end
	
	Character.HumanoidRootPart.Anchored = true
	LastPosition = Character.HumanoidRootPart.CFrame

	task.spawn(function()
		TranfurGoo(Player, LastPosition, TranfurModel, _rigType)
	end)

	if Anim ~= nil and AnimAfter ~= nil then
		Anim:GetMarkerReachedSignal("Tranfur"):Connect(function()
			TranfurModel.HumanoidRootPart.Anchored = true
			TranfurModel.Humanoid.DisplayName = DisplayName
			TranfurModel.Name = Player.Name
			TranfurModel.Animate.Enabled = false
			Player.Character = TranfurModel
			TranfurModel.HumanoidRootPart.CFrame = LastPosition

			TranfurModel.Parent = workspace
			Anim:Stop()

			Anim = TranfurModel.Humanoid:LoadAnimation(Anims.Tranfurring.R6.Tranfur)
			AnimAfter = TranfurModel.Humanoid:LoadAnimation(Anims.Tranfurring.R6.TranfurAfter)
			
			task.spawn(function() TranfurSounds(Player, TheTranfur, TranfurModel) end)
			AnimAfter:Play()
			wait(2.5) --AnimAfter:GetMarkerReachedSignal("End"):Wait()
			AnimAfter:Stop()
			TranfurModel.HumanoidRootPart.Anchored = false
			TranfurModel.Animate.Enabled = true
			--Character.Humanoid.WalkSpeed = 18
			--Character.Humanoid.JumpPower = 40
			--Character.Humanoid.AutoRotate = true

			Player:SetAttribute("IsTranfur", true)
		end)
	end	
end

function Engine:Tranfur(Player:Player, TheTranfur)
	--[[
	Moved/Removed "Tranfurs:"
	 - Lethal Company Stuff (morphs)
	 - Gnarpy (Morphs)
	 - SmallAbble (Morphs)
	 - Abble (Morphs)
	 - Terabyte (Morphs)
	 - Petabyte (Morphs)
	 - Gibibyte (Morphs)
	]]	
	if TheTranfur == "help" then
		local _furs = "thecakeisalie;random\nthecakeisalie;owner\nslimepup;color=gold\nslimepup;color=dia slimepup;color=diamond"
		_furs = _furs + "\nslimepup;color=rainbow\nslimepup;color=rb\nslimepup"
		Engine.LogToCertainClient(Player, `\nTranfurs:\n{_furs}`)
		return
	end
	
	local DisplayName = tostring(Player.DisplayName)

	local Character = Player.Character
	local Tranfurs, TranfurModel = Assets.Tranfurs, "None"
	
	if Character:GetAttribute("Tranfurring") ~= true then
		Character:SetAttribute("Tranfurring", true)
		
		if TheTranfur == "thecakeisalie;random" or TheTranfur == "thecakeisalie;kemono"
			or TheTranfur == "thecakeisalie;owner"
			or TheTranfur == "slimepup;color=gold"
			or TheTranfur == "slimepup;color=dia"
			or TheTranfur == "slimepup;color=diamond"
			or TheTranfur == "slimepup;color=rainbow" or TheTranfur == "slimepup;color=rb"
			or TheTranfur == "slimepup" then
			
			-- A check to randomly set the Tranfur for each certain Tranfur.
			if TheTranfur == "thecakeisalie;random" then
				local m = math.random(1, 100)
				if m >= 1 and m <= 70 then
					TranfurModel = Tranfurs.TheCakeIsLieKemono:Clone()
				elseif m > 70 and m <= 95 then
					TranfurModel = Tranfurs.TheCakeIsLieOwner:Clone()
				elseif m > 95 then
					TranfurModel = Tranfurs.Test:Clone()
				end
			elseif TheTranfur == "thecakeisalie;kemono" then
				TranfurModel = Tranfurs.TheCakeIsLieKemono:Clone()
			elseif TheTranfur == "thecakeisalie;owner" then
				TranfurModel = Tranfurs.TheCakeIsLieOwner:Clone()
			elseif TheTranfur == "slimepup;color=gold" then
				TranfurModel = Tranfurs.Pups.Rare["Slimepup_Gold"]:Clone()
			elseif TheTranfur == "slimepup;color=dia" or TheTranfur == "slimepup;color=diamond" then
				TranfurModel = Tranfurs.Pups.Rare["Slimepup_Diamond"]:Clone()
			elseif TheTranfur == "slimepup;color=rainbow" or TheTranfur == "slimepup;color=rb" then
				TranfurModel = Tranfurs.Pups.Rare["Slimepup_Rainbow"]:Clone()
			elseif TheTranfur == "slimepup" then
				local Chance = math.random() * 100

				if Chance <= 4.98 then
					TranfurModel = Tranfurs.Pups.Rare["Slimepup_Gold"]:Clone()
				elseif Chance <= 4.98 + 1.5 then
					TranfurModel = Tranfurs.Pups.Rare["Slimepup_Diamond"]:Clone()
				elseif Chance <= 4.98 + 1.5 + 0.3 then
					TranfurModel = Tranfurs.Pups.Rare["Slimepup_Emerald"]:Clone()
				else
					if Varibles["Power Outage"].Value ~= true then
						local Pups = Tranfurs.Pups.Normal:GetChildren()
						local random = math.random(#Pups)
						local randomPup = Pups[random]
						
						if Tranfurs.Pups.Normal:FindFirstChild(randomPup.Name) then
							TranfurModel = Tranfurs.Pups.Normal[randomPup.Name]:Clone()
						else
							TranfurModel = Tranfurs.Pups.Normal["Slimepup_Aqua"]:Clone()
						end
					else
						--PO Pups: Red, Ghost and Lean.
						TranfurModel = Tranfurs.Pups.PowerOutage[math.random(#Tranfurs.Pups.PowerOutage:GetChildren())]:Clone()
					end
				end
			elseif TheTranfur == "test" then
				TranfurModel = Tranfurs.Test:Clone()
			end

			-- Main Tranfur Code
			task.spawn(function()
				ActualMainFur(Character.Humanoid.RigType, Character, TheTranfur, TranfurModel, Player, DisplayName)
			end)
			StarterScripts(TranfurModel)

			if string.match(TranfurModel:GetAttribute("Tranfur_Name"), "slimepup") then
				TranfurModel.Head.NameTag.DisplayName.Text.Text = "< "..Player.Name.." >" 
				TranfurModel.Head.NameTag.PlayerName.Text.Text = TranfurModel.Humanoid.DisplayName
			end
		end
		
		--[[
		Old
		
		for _, tranfur in ipairs(Tranfurs:GetChildren()) do
		]]
	end
end

function Engine.WarnToServer(Message)
	warn(`\n <<< Server >>>\n{Message}\n`)
end

function Engine.WarnToClient(Message)
	warn(`\n <<< Server >>>\n{Message}\n`)
end

function Engine.WarnToCertainClient(Player, Message)
	Client.Events.ServerWarn:FireClient(Player, Message)
end

function Engine.WarnToServerAndCertainClient(Player, Message)
	Engine.WarnToCertainClient(Player, Message)
	Engine.WarnToServer(Message)
end

function Engine.WarnToBoth(Message)
	Engine.WarnToClient(Message)
	Engine.WarnToServer(Message)
end


function Engine.LogToServer(Message)
	print(`\n <<< Server >>>\n{Message}\n`)
end

function Engine.LogToClient(Message)
	Client.Events.ServerLog:FireAllClients(Message)
end

function Engine.LogToCertainClient(Player, Message)
	Client.Events.ServerLog:FireClient(Player, Message)
end

function Engine.LogToServerAndCertainClient(Player, Message)
	Engine.LogToCertainClient(Player, Message)
	Engine.LogToServer(Message)
end

function Engine.LogToBoth(Message)
	Engine.LogToClient(Message)
	Engine.LogToServer(Message)
end

function Engine.GetGameType()
	if game.PrivateServerId ~= "" then
		if game.PrivateServerId ~= 0 then
			return "Private Server"
		else
			return "Reserved Server"
		end
	else
		return "Standard Server"
	end
end

function Engine.IsExperimental()
	local ExperimentalGameIDs = {
		17140857182, -- New Experimental Game!
		109070408926798, -- New Recode Test
		
		18598157376, -- Recode Game, Scrapped probably
		16664046481, -- Old Experimental
		16697568416, -- Old Experimental Testing
		16883015218, -- Old Experimental Forbidden Zone
		16909081729, -- Old Experimental Updating Game
		121220883482350, -- Upcoming KH Game
		19006043265 -- Scrapped Experimental/New game
	}
	
	for _, ID in ipairs(ExperimentalGameIDs) do
		if ID == game.PlaceId then
			return true
		end
	end
	return false
end

function Engine.RandomExperimentalText()
	local RandomText = math.random(1, 2)
	if RandomText < 2 then
		return `{Engine.GetVersion()}. not everything seen is final.`
	else
		return "Not everything seen is final."
	end
end

function Engine.GetVersion()
	local GameType, IsExperimental = Engine.GetGameType(), Engine.IsExperimental()
	local _Version_ = `{Server.Version.Value}`

	if IsExperimental then _Version_ = `{_Version_}-ExperimentalBuild` end

	return _Version_
end

function Engine.GetPlaceVersion()
	local PlaceVersion = game.PlaceVersion
	local GameType, IsExperimental = Engine.GetGameType(), Engine.IsExperimental()
	local _Version_ = `{Server.Version.Value}_{PlaceVersion}`
	
	if IsExperimental then _Version_ = `{_Version_}-ExperimentalBuild` end
	
	return _Version_
end

function Engine.EmoteMusic(Emote)
	if Emote == "Smug" then
		return Sounds.Emotes.Transit
	--elseif Emote == "Spooky" then -- Spooky doesn't have music
	--	return Sounds.Emotes.Spooky
	elseif Emote == "Distraction" then
		return Sounds.Emotes.Distraction
	elseif Emote == "California" then
		return Sounds.Emotes.California
	elseif Emote == "Lethal" then
		local Lethal = Sounds.Emotes.Lethal:GetChildren()
		return Sounds.Emotes.Lethal[math.random(1, #Lethal)]
	elseif Emote == "Kazotsky" then
		return Sounds.Emotes.Kazotsky
	elseif Emote == "Mannrobics" then
		return Sounds.Emotes.Mannrobics
	--elseif Emote == "Sadcatdance" then
	--	return Sounds.Emotes
	end
end

function Engine.DoesUserHaveVIF(player)
	local GamePassService = game:GetService("GamePassService")
	local VIF = GamePassService:PlayerHasPass(player, 730933732)
	if VIF then
		return true
	end
	return false
end

function Engine.CanUseCommands(player)
	local Rank = player:GetRankInGroup(32066692)
	if Rank > 2 and Rank < 100 then
		return "VIF"
	elseif Rank > 100 and Rank < 200 then
		return "VIF, Staff" -- Our staff should be able to use vif commands.
	elseif Rank > 200 then
		return "All"
	else
		if Engine.DoesUserHaveVIF(player) then
			return "VIF"
		end
		return "No Access"
	end
	--if Rank > 15 then
	--	return "All"
	--elseif Rank > 12 and Rank < 15 then
	--	return "VIF, Staff"
	--elseif Rank > 9 and Rank < 12 then
	--	return "Snowy"
	--elseif Rank > 4 and Rank < 10 then
	--	return "VIF"
	----elseif Rank < 4 and Rank > 2 then
	--else
	--	if Engine.DoesUserHaveVIF(player) then
	--		return "VIF"
	--	end
	--end
	return nil
end

function Engine.IsSnowy(player:Player)
	if player.UserId == 3643895594 then
		return true
	end
	return false
end

function Engine.FindPlayer(name)
	for _, player in pairs(game:GetService("Players"):GetPlayers()) do
		if string.lower(player.Name) == name or string.lower(player.DisplayName) == name then
			return player
		end
	end
	return nil
end

function Engine.GetDate()
	return os.date("%d %B")
end

function Engine.GoldenKill(hitCharacter)
	local sound = Instance.new("Sound", script.Parent.Handle)
	sound.RollOffMode = Enum.RollOffMode.Linear
	sound.RollOffMaxDistance = 100
	sound.Volume = 2

	sound.SoundId = "rbxassetid://14424344663"

	for _, part in ipairs(hitCharacter:GetChildren()) do
		if part:IsA("Accessory") then
			for i, mesh in ipairs(part) do
				if mesh:IsA("MeshPart") or mesh:IsA("SpecialMesh") then
					mesh.TextureId = " "
					mesh.BrickColor = BrickColor.new("Gold")
					mesh.Reflectance = 0.15
				end
			end
		elseif part:IsA("Pants") or part:IsA("Shirt") or part:IsA("Clothing") then
			part:Destroy()	
		elseif part:IsA("BodyColors") then
			part:Destroy()
		else
			part.BrickColor = BrickColor.new("Gold")
			part.Reflectance = 0.15
		end
		--this is dumb. stupid code.
	end

	sound:Play()
	sound.Ended:Wait()
	sound:Destroy()
end

local Interactions = {
	["Misc"] = {
		["Webhook"] = "https://discord.com/api/webhooks/1340768294466224138/YkeoxnQGFkUV6BODVG1KZjUXkZalgXUZHDzzUiYfIv6cPXdLUxy0pgiT437rb-qJjdry",
		["Title"] = "Unknown Log",
		["Description"] = ""
	},
	["Join_Leave"] = {
		["Webhook"] = "https://discord.com/api/webhooks/1298925591252176976/H7wOmX_eSBnhHobEVYErceWSYHA2VgGB8ZUSMZSBM6cyu5BKdyxslMiPJ1tokkrdR6Tp",
		["Title"] = "[Server Log] Joining and Leaving",
		["Description"] = "player.DisplayName has Joined or Left"
	}
}

function Engine.CallWebhook(InteractionHook, ScriptFile, Misc)

	local Webhook_TEMP

	if Interactions[InteractionHook] == nil then
		Webhook_TEMP = Interactions.Misc
		if Misc ~= nil and typeof(Misc) == "table" then
			Webhook_TEMP.Title = `{ScriptFile.Name} - {Misc.Title}`
			Webhook_TEMP.Description = Misc.Description
		end
	else
		Webhook_TEMP = Interactions[InteractionHook]
		if InteractionHook == "Join_Leave" then
			Webhook_TEMP.Description = `{Misc.Player.DisplayName} has {Misc.HasTheyLeftOrJoined}.`
		elseif InteractionHook == "Misc" then
			Webhook_TEMP.Title = `{ScriptFile.Name} - {Misc.Title}`
			Webhook_TEMP.Description = Misc.Description
		end
	end

	local data = {
		embeds = {
			{
				title = `[Server Log] {ScriptFile.Name} - {Webhook_TEMP.Title}`,
				description = Webhook_TEMP.Description,
				color = 0x00FF00 -- Green color
			}
		}
	}
	HTTP:PostAsync(Webhook_TEMP.Webhook, HTTP:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
end

Engine.GetGameCodes = function()
	return {
		{["Name"] = "tailwag", 					["Currency"] = "Pawprints",			["Value"] = 500}, -- TailWag
		{["Name"] = "snugglebucks", 			["Currency"] = "Pawprints", 		["Value"] = 150}, -- SnuggleBucks
		{["Name"] = "purrpower", 				["Currency"] = "Pawprints", 		["Value"] = 200}, -- PurrPower
		{["Name"] = "cozycrate", 				["Currency"] = "Pawprints", 		["Value"] = 467}, -- CozyCrate
		{["Name"] = "meowmunchies", 			["Currency"] = "Pawprints", 		["Value"] = 445}, -- MeowMunchies
		{["Name"] = "furflair",  				["Currency"] = "Pawprints", 		["Value"] = 440}, -- FurFlair
		{["Name"] = "fuzzyfeathers",  			["Currency"] = "Pawprints",  		["Value"] = 430}, -- FuzzyFeathers
		{["Name"] = "whiskerwishes",  			["Currency"] = "Pawprints",  		["Value"] = 450}, -- WhiskerWishes
		{["Name"] = "pawpatrol",  				["Currency"] = "Pawprints", 		["Value"] = 400}, -- PawPatrol
		{["Name"] = "furbucks", 				["Currency"] = "Pawprints", 		["Value"] = 170}, -- FurBucks
		{["Name"] = "fluffyfriends2024", 		["Currency"] = "Pawprints", 		["Value"] = 200}, -- FluffyFriends2024
		{["Name"] = "tailwaggift", 				["Currency"] = "Pawprints", 		["Value"] = 190}, -- TailWagGift
		{["Name"] = "purrfecthangout", 			["Currency"] = "Pawprints", 		["Value"] = 160}, -- PurrfectHangout
		{["Name"] = "meowmix", 					["Currency"] = "Pawprints", 		["Value"] = 50}, -- Meowmix
		{["Name"] = "fuzzyfiesta",				["Currency"] = "Pawprints", 		["Value"] = 100}, -- FuzzyFiesta
		{["Name"] = "whiskerwonder", 			["Currency"] = "Pawprints", 		["Value"] = 150}, -- WhiskerWonder
		{["Name"] = "furryfun", 				["Currency"] = "FluffTokens", 		["Value"] = 10}, -- FurryFun
		{["Name"] = "pawpower", 				["Currency"] = "Pawprints", 		["Value"] = 100}, -- PawPower
		{["Name"] = "fluffygift", 				["Currency"] = "FluffTokens", 		["Value"] = 25}, -- FluffyGift
		{["Name"] = "pawprints", 				["Currency"] = "Pawprints", 		["Value"] = 50}, -- PawPrints/Pawprints
		{["Name"] = "furfavor",					["Currency"] = "FluffTokens",		["Value"] = 20}, -- FurFavor
		{["Name"] = "pawsomeperks",				["Currency"] = "Pawprints",			["Value"] = 150}, -- PawsomePerks
		{["Name"] = "fluffboost",				["Currency"] = "FluffTokens",		["Value"] = 20}, -- FluffBoost
		{["Name"] = "pawprintpayout",			["Currency"] = "Pawprints",			["Value"] = 50}, -- PawprintPayout
		{["Name"] = "furryfunds",				["Currency"] = "FluffTokens",		["Value"] = 10}, -- FurryFunds
		{["Name"] = "pawpoints",				["Currency"] = "Pawprints",			["Value"] = 75}, -- PawPoints
		{["Name"] = "fluffbump",				["Currency"] = "FluffTokens",		["Value"] = 50}, -- FluffBump
		{["Name"] = "flufffavor",				["Currency"] = "FluffTokens",		["Value"] = 75}, -- FluffFavor
		{["Name"] = "fluffperks",				["Currency"] = "FluffTokens",		["Value"] = 125}, -- FluffPerks
		{["Name"] = "fluffplus",				["Currency"] = "FluffTokens",		["Value"] = 50}, -- FluffPlus
		{["Name"] = "fluffpoints",				["Currency"] = "FluffTokens",		["Value"] = 175}, -- FluffPoints
		{["Name"] = "fluffpower",				["Currency"] = "FluffTokens",		["Value"] = 200}, -- FluffPower
		{["Name"] = "flufffunds",				["Currency"] = "FluffTokens",		["Value"] = 300}, -- FluffFunds
		{["Name"] = "furryfavor",				["Currency"] = "Pawprints",			["Value"] = 120}, -- FurryFavor
		{["Name"] = "pawprintgift",				["Currency"] = "Pawprints",			["Value"] = 100}, -- PawPrintGift
		{["Name"] = "furryperks",				["Currency"] = "Pawprints",			["Value"] = 25}, -- FurryPerks
		{["Name"] = "pawplus",					["Currency"] = "Pawprints",			["Value"] = 150}, -- PawPlus
		{["Name"] = "fuzzypoints",				["Currency"] = "FluffTokens",		["Value"] = 50}, -- FuzzyPoints
		{["Name"] = "furryboost",				["Currency"] = "Pawprints",			["Value"] = 150}, -- FurryBoost
		{["Name"] = "pawprintperks",			["Currency"] = "Pawprints",			["Value"] = 100} -- PawprintPerks
	  --{["Name"] = "smolgoober123",			["Currency"] = "Pawprints", 		["Value"] = 0} -- SmolGoober123
	}
end

return Engine
