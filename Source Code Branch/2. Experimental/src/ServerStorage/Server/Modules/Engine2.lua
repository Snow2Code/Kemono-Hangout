-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Client = ReplicatedStorage.Client
local Animations = Client.Assets.Animations
local Events = Client.Events
local Engine = {
	["WeaponSystem"] = {}
}
local _Engine = script

Engine.moderateText = function(client, text)
	local filteredText = game.TextService:FilterStringAsync(text, client.UserId)
	return filteredText:GetChatForUserAsync(client.UserId)
end

Engine.Message = function(player, prefix, use)
	Events.Message:FireClient(player, `[{prefix}] {use}`, "#ffffff")
end

Engine.GetChatMessages = function(Player)
	--[[
	Removed:
	Snowy+Ollie:
	[7] = Player_DisplayName .. ", You can't fire me, I quit!",
	[8] = "It's a bird! It's a plane! no, it's "..Player_DisplayName.."."

	Birthday:
	[1] = "Happy birthday "..Player_DisplayName.."!",
	[2] = "Hey "..Player_DisplayName..", how does it feel to be a year older but not any wiser?",
	[3] = "Happy birthday "..Player_DisplayName.."! You're one step closer to touching your toes without bending your knees.",
	[4] = "Happy level-up day, "..Player_DisplayName.."! Your character stats have increased.",
	[5] = "Happy birthday "..Player_DisplayName.."! Remember, age is just a number. In your case, a really high one!",
	[6] = "Happy birthday "..Player_DisplayName.."! You're not old, you're vintage!",
	[7] = "Happy birthday "..Player_DisplayName.."! May your Facebook wall be filled with messages from people you never talk to.",
	[8] = "Happy birthday "..Player_DisplayName.."! You're now too old to eat chicken nuggets, but too young to die. Enjoy!",
	[9] = "Happy birthday "..Player_DisplayName.."! Here's to another year of laughing until it hurts, dealing with stupid people and keeping each other sane."

	Other:
	[1] = "Aloha, " .. Player_DisplayName .. "! Welcome to the party!",
	[2] = "Greetings, " .. Player_DisplayName .. "! Prepare to hula!",
	[3] = "Hey there, " .. Player_DisplayName .. "! Time to limbo!",
	[4] = "Howdy, " .. Player_DisplayName .. "! Let's get this luau started!",
	[5] = "Welcome, " .. Player_DisplayName .. "! Get ready to hula your heart out!",
	[6] = "Hola, " .. Player_DisplayName .. "! Let's lie down some fun!",
	[7] = "Yo-ho-ho, " .. Player_DisplayName .. "! Ready to hula like a pirate?",
	[8] = "Heyo, " .. Player_DisplayName .. "! Let's surf some waves of laughter!",
	[9] = "Hello there, " .. Player_DisplayName .. "! Let's hula like nobody's watching!",
	[10] = "Aloha, " .. Player_DisplayName .. "! Let's get this luau popping!",
	[11] = "Howdy-do, " .. Player_DisplayName .. "! Get ready for a tropical adventure!",
	[12] = "Greetings and salutations, " .. Player_DisplayName .. "! Let's hula 'til the sun sets!",
	[13] = "Hey hey, " .. Player_DisplayName .. "! Get ready for a coconutty good time!",
	[14] = "Hello, " .. Player_DisplayName .. "! Let's hula 'til we drop!"
	]]

	--local teamColor = GetTeamColor(game.Players:WaitForChild(PlayerName))
	--print(Type, PlayerName, Player_DisplayName)
	--ChangePlayer_DisplayNameColor(game.Players[PlayerName])
	--Player_DisplayName = "[color=" .. tostring(teamColor) .. "]" .. game.Players:WaitForChild(PlayerName).Player_DisplayName .. "[/color]"

	--local MessagedBanned = {
	--	[1] = Player_DisplayName .. " tried to sneak in, but the server’s bouncer had other plans. Exit stage left! 🚫🎭",
	--	[2] = Player_DisplayName .. " appeared like a ghost, but our anti-phantom protocol vaporized them. Boo-bye! 👻🚫",
	--	[3] = Player_DisplayName .. " attempted a forbidden tango, but the firewall led them in a graceful exit. Adiós! 💃🚫",
	--	[4] = Player_DisplayName .. "’s entrance triggered a trapdoor—straight to the abyss! Sayonara! 🕳️🚫",
	--	[5] = Player_DisplayName .. "r’s encore was a glitchy glitch. The system unplugged them. Static silence! 🎤🚫"
	--}

	local Player_DisplayName = Player.DisplayName

	if Player:GetRankInGroup(32066692) > 100 then
		Player_DisplayName = `<font color='#{Player.TeamColor.Color:ToHex()}'>{Player.DisplayName}</font>`
	end

	return {
		["Snowy+Ollie"] = {
			[1] = "Initializing connection for " .. Player_DisplayName .. ". beep boop... Connected.",
			[2] = "Ugh.. it's " .. Player_DisplayName .. ". I mean.. Welcome back!.. please don't fire me.",
			[3] = "Attention: " .. Player_DisplayName .. " is on deck. System online and ready for maximum fluffiness.",
			[4] = "Boop! " .. Player_DisplayName .. " detected. Welcome back to Kemono Hangout – your furry kingdom!. And, um, don't fire me.",
			[5] = "It's a " .. Player_DisplayName .. " alert! Initiating warm and fuzzy welcome protocol. And, um, don't fire me.",
			[6] = "Oh, it's just you, " .. Player_DisplayName .. ". Kidding! Welcome back, dear friend. Please be gentle with the firing decisions.",
		},
		["Snowy+Ollie_Birthday"] = {
			[1] = "Happy birthday " .. Player_DisplayName .. "."
		},
		["Staff"] = {
			[1] = "Welcome to Kemono Hangout, " .. Player_DisplayName .. ". You're part of the Staff Team now. Let's keep this place fun and safe.",
			[2] = "Hey there, " .. Player_DisplayName .. ". As apart of Staff, your sillynes is our best defense. Welcome to Kemono Hangout.",
			[3] = Player_DisplayName .. ", you're now a Staff Member! Let's make Kemono Hangout a great place for everyone!",
			[4] = "A warm welcome to our new Staff Member, " .. Player_DisplayName .. "! Let's spread joy in Kemono Hangout!"
		},
		["General"] = {
			[1] = "All raise your paws! The mighty " .. Player_DisplayName .. " has joined.",
			[2] = "Incoming fluffiness alert! " .. Player_DisplayName .. " has just entered the hangout.",
			[3] = "Hold on to your tails, folks! " .. Player_DisplayName .. " is in the house.",
			[4] = "Fur-tastic news: " .. Player_DisplayName .. " has just pounced into Kemono Hangout.",
			[5] = "Prepare for a burst of adorableness! " .. Player_DisplayName .. " is here to hang out.",
			[6] = "The fluffy party just got an upgrade – " .. Player_DisplayName .. " has arrived! Time to celebrate."
		}
	}
end

Engine.removeEmojis = function(str)
	local emojiPattern = "[\128-\255]"

	return str:gsub(emojiPattern, "")
end

Engine.WeaponSystem.Weapons = {
	["Shovel"] = {
		["Weapon Name"] = "Shovel",
		["HasEquipAnimation"] = true,
		["Damage"] = 20,
		["Cooldown"] = 1,
		["Range"] = 10,
		["Animations_R6"] = {
			["Idle"] = Animations["Weapon System"].R6.Idle,
			["Swing"] = Animations["Weapon System"].R6.Swing
		},
		["Animations_R15"] = {
			["Idle"] = Animations["Weapon System"].R15.Idle,
			["Swing"] = Animations["Weapon System"].R15.Swing
		}
	},
	["Knife"] = {
		["Weapon Name"] = "Knife",
		["HasEquipAnimation"] = true,
		["Damage"] = {
			[1] = 20,
			[2] = 10
		},
		["Cooldown"] = 0.375,
		["Range"] = 10,
		["Animations_R6"] = {
			["Idle"] = Animations["Weapon System"].R6.Idle,
			["Swing"] = Animations["Weapon System"].R6.Swing
		},
		["Animations_R15"] = {
			["Idle"] = Animations["Weapon System"].R15.Idle,
			["Swing"] = Animations["Weapon System"].R15.Swing
		}
	},
	["Axe"] = {
		["Weapon Name"] = "Axe",
		["HasEquipAnimation"] = true,
		["Damage"] = 35,
		["Cooldown"] = 2.75,
		["Range"] = 10,
		["Can Ragdoll"] = false,
		["Animations_R6"] = {
			["Idle"] = Animations["Weapon System"].R6["Idle - Alt 1"],
			["Swing"] = Animations["Weapon System"].R6["Swing - Alt 1"]
		},
		["Animations_R15"] = {
			["Idle"] = Animations["Weapon System"].R15["Idle - Alt 1"],
			["Swing"] = Animations["Weapon System"].R15["Swing - Alt 1"]
		}
	}
}

local function GetAnimations(Character, WeaponName)
	if Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
		return Engine.WeaponSystem.Weapons[WeaponName]["Animations_R6"]
	else
		return Engine.WeaponSystem.Weapons[WeaponName]["Animations_R15"]
	end
end

Engine.WeaponSystem.Setup = function(what, WeaponName, Weapon, Character)
	local CReturn = nil
	if string.lower(what) == "settings" then
		if Engine.WeaponSystem.Weapons[WeaponName] ~= nil then
			CReturn = Engine.WeaponSystem.Weapons[WeaponName]
		else
			CReturn = {
				["Weapon Name"] = WeaponName,
				["HasEquipAnimation"] = true,
				["Damage"] = 20,
				["Cooldown"] = 3,
				["Range"] = 10,
				["Animations_R6"] = {
					["Idle"] = Animations["Weapon System"].R6.Idle,
					["Swing"] = Animations["Weapon System"].R6.Swing
				},
				["Animations_R15"] = {
					["Idle"] = Animations["Weapon System"].R15.Idle,
					["Swing"] = Animations["Weapon System"].R15.Swing
				}
			}
		end
	end
	
	-- Make sure the Weapon has the Animations folder.
	if not Weapon:FindFirstChild("Animations") then
		local WeaponAnimations = Instance.new("Folder", Weapon)
		WeaponAnimations.Name = "Animations"
	end
	
	-- Get all animations, clone it then parent it to Animations (if it doesn't exist already)
	for _, Animation in pairs(GetAnimations(Character, WeaponName)) do
		if not Weapon.Animations:FindFirstChild(Animation.Name) then
			local _Animation_ = Animation:Clone()
			_Animation_.Parent = Weapon.Animations
			if string.match(_Animation_.Name, "Idle") then
				_Animation_.Name = "Idle"
			end
			if string.match(_Animation_.Name, "Swing") then
				_Animation_.Name = "Swing"
			end
		end
	end
	return CReturn
end

Engine.WeaponSystem.Ragdoll = function(ch, duration, dea)
	local chum = ch:FindFirstChildOfClass("Humanoid")
	if chum then
			if not chum.PlatformStand then
				chum.PlatformStand = true
				if dea then
					chum.Health = 0
					local hpsc = ch:FindFirstChild("Health")
					if hpsc then
						if hpsc:IsA("Script") then
							hpsc.Disabled = true
						end
					end
					if ch:FindFirstChild("HumanoidRootPart") then
						ch:FindFirstChild("HumanoidRootPart"):Destroy()
					end
					push(ch.Head, 10, 0.3)
					monar(ch, ragdolldespawntime)
				elseif ch:FindFirstChild("HumanoidRootPart") then
					if ch:FindFirstChild("HumanoidRootPart").CanCollide then
						ch:FindFirstChild("HumanoidRootPart").CanCollide = false
						coroutine.wrap(function()
							task.wait(duration)
							if ch:FindFirstChild("HumanoidRootPart") then
								ch:FindFirstChild("HumanoidRootPart").CanCollide = true
							end
						end)()
					end
				end
				local savedglue = {}
				local mainpart
				if chum.RigType == Enum.HumanoidRigType.R6 then
					local chtor = ch.Torso
					mainpart = chtor
					if not dea then
						for i,v in pairs(chtor:GetChildren()) do
							if v:IsA("Motor6D") then
								if v.Part1.Name ~= "Head" and v.Part0.Name ~= "HumanoidRootPart" then
									table.insert(savedglue, {v, v.Part0, v.Part1})
									v.Part1 = nil
									v.Part0 = nil
								end
							end
						end
					end
					pcall(function()
						makeragdolllimbr6(ch["Right Arm"], ch.Torso, Vector3.new((ch.Torso.Size.x/2) + (ch.Torso.Size.x/4), (ch.Torso.Size.y/4), 0), Vector3.new(0,ch["Right Arm"].Size.y/4,0), -180, 180, duration)
					end)
					pcall(function()
						makeragdolllimbr6(ch["Left Arm"], ch.Torso, Vector3.new(-(ch.Torso.Size.x/2) - (ch.Torso.Size.x/4), (ch.Torso.Size.y/4), 0), Vector3.new(0,ch["Left Arm"].Size.y/4,0), -180, 180, duration)
					end)
					pcall(function()
						makeragdolllimbr6(ch["Left Leg"], ch.Torso, Vector3.new(-(ch.Torso.Size.x/4), -(ch.Torso.Size.y/2), 0), Vector3.new(0,ch["Left Leg"].Size.y/2,0), -80, 80, duration)
					end)
					pcall(function()
						makeragdolllimbr6(ch["Right Leg"], ch.Torso, Vector3.new((ch.Torso.Size.x/4), -(ch.Torso.Size.y/2), 0), Vector3.new(0,ch["Right Leg"].Size.y/2,0), -80, 80, duration)
					end)
					if dea == true and not ch:FindFirstChild("diedbydecapitation") then
						if ch.Torso:findFirstChild("NeckAttachment") then
							local headattachment = Instance.new("Attachment", ch.Head)
							headattachment.Position = Vector3.new(0,-ch.Head.Size.y/2,0)
							makehingeconnections(ch.Head, headattachment, ch.Torso.NeckAttachment, -50, 50, ragdolldespawntime)
						else
							local wed = Instance.new("Weld", ch.Head)
							wed.Part1 = ch.Head
							wed.Part0 = ch.Torso
							wed.C0 = cfnew(0,(ch.Torso.Size.y/2)+(ch.Head.Size.y/2),0)
						end
					end
					if not dea then
						coroutine.wrap(function()
							task.wait(duration)
							for i,v in pairs(savedglue) do
								v[1].Part0 = v[2]
								v[1].Part1 = v[3]
								savedglue[i] = nil
							end
							chum.PlatformStand = false
						end)()
					end
				elseif chum.RigType == Enum.HumanoidRigType.R15 then
					local chuppertor = ch.UpperTorso
					mainpart = chuppertor
					if not dea then
						for i,v in pairs(ch:GetDescendants()) do
							if v:IsA("Motor6D") then
								if v.Part1.Name ~= "Head" and v.Part0.Name ~= "HumanoidRootPart" then
									table.insert(savedglue, {v, v.Part0, v.Part1})
									v.Part1 = nil
									v.Part0 = nil
								end
							end
						end
					end
					if dea == true and not ch:FindFirstChild("diedbydecapitation") then
						if ch.UpperTorso:findFirstChild("NeckAttachment") then
							local HeadAttachment = Instance.new("Attachment", ch.Head)
							HeadAttachment.Position = Vector3.new(0, -0.5, 0)
							makehingeconnections(ch.Head, HeadAttachment, ch.UpperTorso.NeckAttachment, -50, 50, ragdolldespawntime)
						else
							local wed = Instance.new("Weld", ch.Head)
							wed.Part1 = ch.Head
							wed.Part0 = ch.UpperTorso
							wed.C0 = cfnew(0,(ch.UpperTorso.Size.y/2)+(ch.Head.Size.y/2),0)
						end
					end
					pcall(function()
						makehingeconnections(ch.LowerTorso, ch.LowerTorso.WaistRigAttachment, ch.UpperTorso.WaistRigAttachment, -50, 50, duration)
						makeballconnections(ch.LeftUpperArm, ch.LeftUpperArm.LeftShoulderRigAttachment, ch.UpperTorso.LeftShoulderRigAttachment, -200, 200, duration)
						makehingeconnections(ch.LeftLowerArm, ch.LeftLowerArm.LeftElbowRigAttachment, ch.LeftUpperArm.LeftElbowRigAttachment, 0, -60, duration)
						makehingeconnections(ch.LeftHand, ch.LeftHand.LeftWristRigAttachment, ch.LeftLowerArm.LeftWristRigAttachment, -20, 20, duration)
						--
						makeballconnections(ch.RightUpperArm, ch.RightUpperArm.RightShoulderRigAttachment, ch.UpperTorso.RightShoulderRigAttachment, -200, 200, duration)
						makehingeconnections(ch.RightLowerArm, ch.RightLowerArm.RightElbowRigAttachment, ch.RightUpperArm.RightElbowRigAttachment, 0, -60, duration)
						makehingeconnections(ch.RightHand, ch.RightHand.RightWristRigAttachment, ch.RightLowerArm.RightWristRigAttachment, -20, 20, duration)
						--
						makeballconnections(ch.RightUpperLeg, ch.RightUpperLeg.RightHipRigAttachment, ch.LowerTorso.RightHipRigAttachment, -80, 80, duration)
						makehingeconnections(ch.RightLowerLeg, ch.RightLowerLeg.RightKneeRigAttachment, ch.RightUpperLeg.RightKneeRigAttachment, 0, 60, duration)
						makehingeconnections(ch.RightFoot, ch.RightFoot.RightAnkleRigAttachment, ch.RightLowerLeg.RightAnkleRigAttachment, -20, 20, duration)
						--
						makeballconnections(ch.LeftUpperLeg, ch.LeftUpperLeg.LeftHipRigAttachment, ch.LowerTorso.LeftHipRigAttachment, -80, 80, duration)
						makehingeconnections(ch.LeftLowerLeg, ch.LeftLowerLeg.LeftKneeRigAttachment, ch.LeftUpperLeg.LeftKneeRigAttachment, 0, 60, duration)
						makehingeconnections(ch.LeftFoot, ch.LeftFoot.LeftAnkleRigAttachment, ch.LeftLowerLeg.LeftAnkleRigAttachment, -20, 20, duration)
					end)
					if not dea then
						coroutine.wrap(function()
							task.wait(duration)
							for i,v in pairs(savedglue) do
								v[1].Part0 = v[2]
								v[1].Part1 = v[3]
								savedglue[i] = nil
							end
							chum.PlatformStand = false
						end)()
					end
				end
				if dea then
					for i,v in pairs(ch:GetChildren()) do
						if v:IsA("Accessory") then
							if v:FindFirstChild("Handle") then
								local attachment1 = v.Handle:FindFirstChildOfClass("Attachment")
								if attachment1 then
									for q,w in pairs(ch:GetChildren()) do
										if w:IsA("Part") then
											local attachment2 = w:FindFirstChild(attachment1.Name)
											if attachment2 then
												local hinge = Instance.new("HingeConstraint", v.Handle)
												hinge.Attachment0 = attachment1
												hinge.Attachment1 = attachment2
												hinge.LimitsEnabled = true
												hinge.LowerAngle = 0
												hinge.UpperAngle = 0
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
end

return Engine
