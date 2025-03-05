-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

--TODO: Fix up Varibles.

local System = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Client = ReplicatedStorage.Client
local Animations = Client.Assets.Animations
local Events = Client.Events

local Sounds = Client.Assets.Sounds


local Weapons = require(script.Parent.Weapons)
local Miscellaneous = require(script.Parent.MiscellaneousFunctions)

cfnew = CFrame.new

function GetAnimations(Character, WeaponName)
	if Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
		return Weapons.ActiveWeapons[WeaponName]["Animations_R6"]
	else
		return Weapons.ActiveWeapons[WeaponName]["Animations_R15"]
	end
end

-- Setup the weapon.
function System.Setup(what, WeaponName, Weapon, Character)
	local CReturn = nil
	if string.lower(what) == "settings" then
		if Weapons.ActiveWeapons[WeaponName] ~= nil then
			CReturn = Weapons.GetWeapon(Weapon)
		else
			CReturn = Weapons.GetWeapon("nil")
		end
	end

	Weapons.SetupConfig(Weapon)

	-- Make sure the Weapon has the Animations folder.
	if not Weapon:FindFirstChild("Animations") then
		local WeaponAnimations = Instance.new("Folder", Weapon)
		WeaponAnimations.Name = "Animations"
	end

	-- Get all animations, clone it then parent it to Animations (if it doesn't exist already)
	for _, Animation in pairs(GetAnimations(Character, WeaponName)) do
		if not Weapon.Animations:FindFirstChild(Animation.Name) then
			local _Animation_ = Animation:Clone()
			local isSwing = false
			_Animation_.Parent = Weapon.Animations
			if string.match(_Animation_.Name, " 1") then
				isSwing = true
				_Animation_.Name = "Swing_1"
			elseif string.match(_Animation_.Name, " 2") then
				isSwing = true
				_Animation_.Name = "Swing_2"
			end
			
			if string.match(_Animation_.Name, "Idle") then
				_Animation_.Name = "Idle"
			end
			if string.match(_Animation_.Name, "Swing") and isSwing == false then
				_Animation_.Name = "Swing"
			end
		end
	end
	
	local Varibles = script.Parent.Varibles:Clone()
	Varibles.Parent = Weapon
	
	return CReturn
end

-- Ragdoll Stuff Below
--[[
function monar(WHAT, duration)
	game:GetService("Debris"):AddItem(WHAT, duration)
end
]]

--Creates a BallConnection.
function makeballconnections(limb, attachementone, attachmenttwo, twistlower, twistupper, du)
	local connection = Instance.new('BallSocketConstraint', limb)
	local bone = Instance.new("Part", limb)
	connection.LimitsEnabled = true
	connection.Attachment0 = attachementone
	connection.Attachment1 = attachmenttwo
	connection.TwistLimitsEnabled = true
	connection.TwistLowerAngle = twistlower
	connection.TwistUpperAngle = twistupper
	bone:BreakJoints()
	local bonew = Instance.new("Weld", bone)
	bonew.Part0 = limb
	bonew.Part1 = bone
	bonew.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-limb.Size.y/4.5,0,0)
	if limb.Parent:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
		bone.Size = Vector3.new(limb.Size.y/1.8,limb.Size.z,limb.Size.x)
	else
		bone.Size = Vector3.new(limb.Size.y/3,limb.Size.z,limb.Size.x)
	end
	bone.Transparency = 1
	bone.Shape = "Cylinder"
	local noc = Instance.new("NoCollisionConstraint", bone)
	noc.Part0 = attachementone.Parent
	noc.Part1 = attachmenttwo.Parent
	bone.CanCollide = false
	--monar(bone, du) -- no more monar!
	--monar(connection, du) -- no more monar!
end

-- Creates a Ragdoll Limb, for R6
function makeragdolllimbr6(limb, dudetorso, at1pos, at2pos, lowt, upt, duratio)
	local at1 = Instance.new("Attachment", dudetorso)
	local at2 = Instance.new("Attachment", limb)
	at1.Position = at1pos
	at2.Position = at2pos
	limb.CanCollide = true
	makeballconnections(limb, at1, at2, lowt, upt, duratio)
	--game.Debris:AddItem(at1, duratio) -- no more monar!
	--game.Debris:AddItem(at2, duratio) -- no more monar!
end

-- Creates a hinge connection
function makehingeconnections(limb, attachementone, attachmenttwo, lower, upper, du)
	local connection = Instance.new('HingeConstraint', limb)
	local bone = Instance.new("Part", limb)
	connection.LimitsEnabled = true
	connection.Attachment0 = attachementone
	connection.Attachment1 = attachmenttwo
	connection.LimitsEnabled = true
	connection.LowerAngle = lower
	connection.UpperAngle = upper
	bone:BreakJoints()
	local bonew = Instance.new("Weld", bone)
	bonew.Part0 = limb
	bonew.Part1 = bone
	bonew.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-limb.Size.y/4.5,0,0)
	if limb.Parent:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
		bone.Size = Vector3.new(limb.Size.y/1.8,limb.Size.z,limb.Size.x)
	elseif limb.Parent:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
		bone.Size = Vector3.new(limb.Size.y/3,limb.Size.z,limb.Size.x)
	elseif limb.Name == "Head" then
		bone.Size = Vector3.new(limb.Size.y/5,limb.Size.z,limb.Size.x)
	end
	bone.Transparency = 1
	bone.Shape = "Cylinder"
	local noc = Instance.new("NoCollisionConstraint", bone)
	noc.Part0 = attachementone.Parent
	noc.Part1 = attachmenttwo.Parent
	--monar(bone, du) -- no more monar!
	--monar(connection, du) -- no more monar!
end

function System.Ragdoll_Accessorys(character)
	for _, v in pairs(character:GetChildren()) do
		if v:IsA("Accessory") then
			if v:FindFirstChild("Handle") then
				if v.AccessoryType == Enum.AccessoryType.Hat or v.AccessoryType == Enum.AccessoryType.Hair
					or v.AccessoryType == Enum.AccessoryType.Waist or v.AccessoryType == Enum.AccessoryType.Neck
					or v.AccessoryType == Enum.AccessoryType.Pants or v.AccessoryType == Enum.AccessoryType.Shirt
					or v.AccessoryType == Enum.AccessoryType.Face -- Front
					or v.AccessoryType == Enum.AccessoryType.Jacket or v.AccessoryType == Enum.AccessoryType.Shorts
					or v.AccessoryType == Enum.AccessoryType.TShirt or v.AccessoryType == Enum.AccessoryType.Eyebrow
					or v.AccessoryType == Enum.AccessoryType.Eyelash or v.AccessoryType == Enum.AccessoryType.Sweater
					or v.AccessoryType == Enum.AccessoryType.LeftShoe or v.AccessoryType == Enum.AccessoryType.RightShoe
					or v.AccessoryType == Enum.AccessoryType.DressSkirt then

					local attachment1 = v.Handle:FindFirstChildOfClass("Attachment")
					if attachment1 then
						for _, w in pairs(character:GetChildren()) do
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
				else
					local Handle = v.Handle
					Handle:FindFirstChildOfClass("Weld"):Destroy()
					Handle.CanCollide = true
					Handle.Parent = character
					Handle.Name = v.Name
					v:Destroy()
					Handle.Velocity = Vector3.new(math.random(-50, 50), math.random(10, 30), math.random(-50, 50))
				end
			end
		end
	end
end

-- Force em back
function Force(attacker, character)
	-- Apply force to the ragdoll briefly
	local force = Instance.new("BodyVelocity")
	force.MaxForce = Vector3.new(10, 10, 10)
	force.Velocity = Vector3.new()

	if attacker and attacker:FindFirstChild("HumanoidRootPart") then
		local direction = (character.HumanoidRootPart.Position - attacker.HumanoidRootPart.Position).Unit
		force.Velocity = direction * 20 + Vector3.new(0, 10, 0) -- Push away and slightly up
	else
		force.Velocity = Vector3.new(math.random(-30, 30), 25, math.random(-30, 30)) -- Random push
	end

	force.Parent = character.HumanoidRootPart
	
	--[[
	Remove force after certain about of time before the victim
	achieves liftoff and gets mistaken for a low-poly NASA experiment!
	]]
	--if character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
	--	if character.Torso:FindFirstChild("Neck") then
	--		character.Torso:FindFirstChild("Neck"):Destroy()
	--	end
	--end
	task.delay(0.5, function()
		force:Destroy()
		print(character.Name .. " You are not a low-poly NASA experiment!")
	end)
end

function System.Ragdoll_Temp(attacker, character, dea)
	--[[
	function ragdollify(ch, 	10, 	dea)

	ragdollify(clr, 	10, 	true)
	]]
	
	print("Ragdolling Chance removed.")
	
	--local humanoid = character:FindFirstChildOfClass("Humanoid")
	--if humanoid then
	--	humanoid.PlatformStand = false
	--	local savedglue = {}
	--	local mainpart
	--	if humanoid.RigType == Enum.HumanoidRigType.R6 then
	--		local chtor = character.Torso
	--		mainpart = chtor
			
	--		local headattachment = Instance.new("Attachment", character.Head)
	--		headattachment.Position = Vector3.new(0, -character.Head.Size.y / 2, 0)
	--		makehingeconnections(character.Head, headattachment, character.Torso.NeckAttachment, -50, 50, 10)
			
	--		if not dea then
	--			for i,v in pairs(chtor:GetChildren()) do
	--				if v:IsA("Motor6D") then
	--					if v.Part1.Name ~= "Head" and v.Part0.Name ~= "HumanoidRootPart" then
	--						table.insert(savedglue, {v, v.Part0, v.Part1})
	--						v.Part1 = nil
	--						v.Part0 = nil
	--					end
	--				end
	--			end
	--		end
	--		System.Ragdoll_Accessorys(character)
	--		pcall(function()
	--			--makeragdolllimbr6(character["Head"], character.Head, Vector3.new((character.Torso.Size.x/2) + (character.Torso.Size.x/4), (character.Torso.Size.y/4), 0), Vector3.new(0,character["Head"].Size.y/4,0), -180, 180, 10)
	--			makeragdolllimbr6(character["Right Arm"], character.Torso, Vector3.new((character.Torso.Size.x/2) + (character.Torso.Size.x/4), (character.Torso.Size.y/4), 0), Vector3.new(0,character["Right Arm"].Size.y/4,0), -180, 180, 10)
	--			makeragdolllimbr6(character["Left Arm"], character.Torso, Vector3.new(-(character.Torso.Size.x/2) - (character.Torso.Size.x/4), (character.Torso.Size.y/4), 0), Vector3.new(0,character["Left Arm"].Size.y/4,0), -180, 180, 10)
	--			makeragdolllimbr6(character["Left Leg"], character.Torso, Vector3.new(-(character.Torso.Size.x/4), -(character.Torso.Size.y/2), 0), Vector3.new(0,character["Left Leg"].Size.y/2,0), -80, 80, 10)
	--			makeragdolllimbr6(character["Right Leg"], character.Torso, Vector3.new((character.Torso.Size.x/4), -(character.Torso.Size.y/2), 0), Vector3.new(0,character["Right Leg"].Size.y/2,0), -80, 80, 10)
	--		end)
			
	--	elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
	--		local chuppertor = character.UpperTorso
	--		mainpart = chuppertor
	--		System.Ragdoll_Accessorys(character)
	--		if not dea then
	--			for i,v in pairs(character:GetDescendants()) do
	--				if v:IsA("Motor6D") then
	--					if v.Part1.Name ~= "Head" and v.Part0.Name ~= "HumanoidRootPart" then
	--						table.insert(savedglue, {v, v.Part0, v.Part1})
	--						v.Part1 = nil
	--						v.Part0 = nil
	--					end
	--				end
	--			end
	--		end
	--		--local HeadAttachment = Instance.new("Attachment", character.Head)
	--		--HeadAttachment.Position = Vector3.new(0, -0.5, 0)
	--		local HeadAttachment = Instance.new("Attachment", character.Head)
	--		HeadAttachment.Position = Vector3.new(0, -character.Head.Size.y / 2, 0)
	--		makehingeconnections(character.Head, HeadAttachment, character.Torso.NeckAttachment, -50, 50, 10)
	--		pcall(function()
	--			--makehingeconnections(character.Head, HeadAttachment, character.UpperTorso.NeckAttachment, -30, 30, 5)
	--			makehingeconnections(character.LowerTorso, character.LowerTorso.WaistRigAttachment, character.UpperTorso.WaistRigAttachment, -30, 30, 5)
	--			makeballconnections(character.LeftUpperArm, character.LeftUpperArm.LeftShoulderRigAttachment, character.UpperTorso.LeftShoulderRigAttachment, -100, 100, 5)
	--			makehingeconnections(character.LeftLowerArm, character.LeftLowerArm.LeftElbowRigAttachment, character.LeftUpperArm.LeftElbowRigAttachment, 0, -60, 10)
	--			makehingeconnections(character.LeftHand, character.LeftHand.LeftWristRigAttachment, character.LeftLowerArm.LeftWristRigAttachment, -20, 20, 10)
	--			--
	--			makeballconnections(character.RightUpperArm, character.RightUpperArm.RightShoulderRigAttachment, character.UpperTorso.RightShoulderRigAttachment, -200, 200, 10)
	--			makehingeconnections(character.RightLowerArm, character.RightLowerArm.RightElbowRigAttachment, character.RightUpperArm.RightElbowRigAttachment, 0, -60, 10)
	--			makehingeconnections(character.RightHand, character.RightHand.RightWristRigAttachment, character.RightLowerArm.RightWristRigAttachment, -20, 20, 10)
	--			--
	--			makeballconnections(character.RightUpperLeg, character.RightUpperLeg.RightHipRigAttachment, character.LowerTorso.RightHipRigAttachment, -80, 80, 10)
	--			makehingeconnections(character.RightLowerLeg, character.RightLowerLeg.RightKneeRigAttachment, character.RightUpperLeg.RightKneeRigAttachment, 0, 60, 10)
	--			makehingeconnections(character.RightFoot, character.RightFoot.RightAnkleRigAttachment, character.RightLowerLeg.RightAnkleRigAttachment, -20, 20, 10)
	--			--
	--			makeballconnections(character.LeftUpperLeg, character.LeftUpperLeg.LeftHipRigAttachment, character.LowerTorso.LeftHipRigAttachment, -80, 80, 10)
	--			makehingeconnections(character.LeftLowerLeg, character.LeftLowerLeg.LeftKneeRigAttachment, character.LeftUpperLeg.LeftKneeRigAttachment, 0, 60, 10)
	--			makehingeconnections(character.LeftFoot, character.LeftFoot.LeftAnkleRigAttachment, character.LeftLowerLeg.LeftAnkleRigAttachment, -20, 20, 10)
	--		end)
	--	end
	--	Force(attacker, character)
	--end
end

-- Ragdoll a player (Death)
function System.Ragdoll(character, attacker)
	local humanoid = character:FindFirstChild("Humanoid")
	local savedglue = {}
	local mainpart
	if humanoid then
		if humanoid.RigType == Enum.HumanoidRigType.R6 then
			local chtor = character.Torso
			mainpart = chtor
			
			local headattachment = Instance.new("Attachment", character.Head)
			headattachment.Position = Vector3.new(0, -character.Head.Size.y / 2, 0)
			makehingeconnections(character.Head, headattachment, character.Torso.NeckAttachment, -50, 50, 10)
			System.Ragdoll_Accessorys(character)
			pcall(function()
				makeragdolllimbr6(character["Right Arm"], character.Torso, Vector3.new((character.Torso.Size.x/2) + (character.Torso.Size.x/4), (character.Torso.Size.y/4), 0), Vector3.new(0,character["Right Arm"].Size.y/4,0), -180, 180, 10)
				makeragdolllimbr6(character["Left Arm"], character.Torso, Vector3.new(-(character.Torso.Size.x/2) - (character.Torso.Size.x/4), (character.Torso.Size.y/4), 0), Vector3.new(0,character["Left Arm"].Size.y/4,0), -180, 180, 10)
				makeragdolllimbr6(character["Left Leg"], character.Torso, Vector3.new(-(character.Torso.Size.x/4), -(character.Torso.Size.y/2), 0), Vector3.new(0,character["Left Leg"].Size.y/2,0), -80, 80, 10)
				makeragdolllimbr6(character["Right Leg"], character.Torso, Vector3.new((character.Torso.Size.x/4), -(character.Torso.Size.y/2), 0), Vector3.new(0,character["Right Leg"].Size.y/2,0), -80, 80, 10)
			end)

			
			coroutine.wrap(function()
				task.wait(10)
				for i, v in pairs(savedglue) do
					v[1].Part0 = v[2]
					v[1].Part1 = v[3]
					savedglue[i] = nil
				end
				humanoid.PlatformStand = false
			end)()
		elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
			local chuppertor = character.UpperTorso
			mainpart = chuppertor
			System.Ragdoll_Accessorys(character)
			for i, v in pairs(character:GetDescendants()) do
				if v:IsA("Motor6D") then
					if v.Part1.Name ~= "Head" and v.Part0.Name ~= "HumanoidRootPart" then
						table.insert(savedglue, {v, v.Part0, v.Part1})
						v.Part1 = nil
						v.Part0 = nil
					end
				end
			end
			
			local HeadAttachment = Instance.new("Attachment", character.Head)
			HeadAttachment.Position = Vector3.new(0, -0.5, 0)
			makehingeconnections(character.Head, HeadAttachment, character.UpperTorso.NeckAttachment, -50, 50, 10)

			pcall(function()
				makehingeconnections(character.LowerTorso, character.LowerTorso.WaistRigAttachment, character.UpperTorso.WaistRigAttachment, -50, 50, 10)
				makeballconnections(character.LeftUpperArm, character.LeftUpperArm.LeftShoulderRigAttachment, character.UpperTorso.LeftShoulderRigAttachment, -200, 200, 10)
				makehingeconnections(character.LeftLowerArm, character.LeftLowerArm.LeftElbowRigAttachment, character.LeftUpperArm.LeftElbowRigAttachment, 0, -60, 10)
				makehingeconnections(character.LeftHand, character.LeftHand.LeftWristRigAttachment, character.LeftLowerArm.LeftWristRigAttachment, -20, 20, 10)
				--
				makeballconnections(character.RightUpperArm, character.RightUpperArm.RightShoulderRigAttachment, character.UpperTorso.RightShoulderRigAttachment, -200, 200, 10)
				makehingeconnections(character.RightLowerArm, character.RightLowerArm.RightElbowRigAttachment, character.RightUpperArm.RightElbowRigAttachment, 0, -60, 10)
				makehingeconnections(character.RightHand, character.RightHand.RightWristRigAttachment, character.RightLowerArm.RightWristRigAttachment, -20, 20, 10)
				--
				makeballconnections(character.RightUpperLeg, character.RightUpperLeg.RightHipRigAttachment, character.LowerTorso.RightHipRigAttachment, -80, 80, 10)
				makehingeconnections(character.RightLowerLeg, character.RightLowerLeg.RightKneeRigAttachment, character.RightUpperLeg.RightKneeRigAttachment, 0, 60, 10)
				makehingeconnections(character.RightFoot, character.RightFoot.RightAnkleRigAttachment, character.RightLowerLeg.RightAnkleRigAttachment, -20, 20, 10)
				--
				makeballconnections(character.LeftUpperLeg, character.LeftUpperLeg.LeftHipRigAttachment, character.LowerTorso.LeftHipRigAttachment, -80, 80, 10)
				makehingeconnections(character.LeftLowerLeg, character.LeftLowerLeg.LeftKneeRigAttachment, character.LeftUpperLeg.LeftKneeRigAttachment, 0, 60, 10)
				makehingeconnections(character.LeftFoot, character.LeftFoot.LeftAnkleRigAttachment, character.LeftLowerLeg.LeftAnkleRigAttachment, -20, 20, 10)
			end)
			
			coroutine.wrap(function()
				task.wait(10)
				for i,v in pairs(savedglue) do
					v[1].Part0 = v[2]
					v[1].Part1 = v[3]
					savedglue[i] = nil
				end
				humanoid.PlatformStand = false
			end)()
		end
		Force(attacker, character)
	end
end
--[[
function System.Ragdoll(victimCharacter, attacker)
	local head = victimCharacter:FindFirstChild("Head")

	for _, joint in ipairs(victimCharacter:GetDescendants()) do
		if joint:IsA("Motor6D") then
			local socket = Instance.new("BallSocketConstraint")
			local a1 = Instance.new("Attachment")
			local a2 = Instance.new("Attachment")
			a1.Parent = joint.Part0
			a2.Parent = joint.Part1
			socket.Parent = joint.Parent
			socket.Attachment0 = a1
			socket.Attachment1 = a2
			a1.CFrame = joint.C0
			a2.CFrame = joint.C1
			socket.LimitsEnabled = true
			socket.TwistLimitsEnabled = true
			joint:Destroy()
		end
	end

	for _, accessory in ipairs(victimCharacter:GetChildren()) do
		if accessory:IsA("Accessory") then
			local handle = accessory:FindFirstChild("Handle")
			if handle then
				handle:FindFirstChildOfClass("Weld"):Destroy()
				handle.CanCollide = true
				handle.Parent = victimCharacter
				handle.Name = accessory.Name
				accessory:Destroy()
				handle.Velocity = Vector3.new(math.random(-50, 50), math.random(10, 30), math.random(-50, 50))
			end
		end
	end

	-- Apply force to the ragdoll briefly
	local force = Instance.new("BodyVelocity")
	force.MaxForce = Vector3.new(100000, 100000, 100000)
	force.Velocity = Vector3.new()

	if attacker and attacker:FindFirstChild("HumanoidRootPart") then
		local direction = (victimCharacter.HumanoidRootPart.Position - attacker.HumanoidRootPart.Position).Unit
		force.Velocity = direction * 20 + Vector3.new(0, 10, 0) -- Push away and slightly up
	else
		force.Velocity = Vector3.new(math.random(-30, 30), 25, math.random(-30, 30)) -- Random push
	end

	force.Parent = victimCharacter.HumanoidRootPart

	-- Remove force after certain about of time before the victim achieves liftoff and gets mistaken for a low-poly NASA experiment!

	task.delay(0.3, function()
		force:Destroy()
		victimCharacter:BreakJoints()
	end)

	-- Remove ragdoll
	task.delay(30, function()
		if victimCharacter then
			game.Debris:AddItem(victimCharacter, 0)
		end
	end)
end
]]

-- Swing weapon and detect victims.
function System.DetectVictims(ownerCharacter, Settings, HitAttachments, Tool)
	local ownerPlayer = game.Players:GetPlayerFromCharacter(ownerCharacter)
	local canRagdoll = Tool.Config["Can Ragdoll"].Value
	local startTime = tick() -- Get the current time

	local AlreadyHit = {}
	
	for _, Attachment in pairs(HitAttachments) do
		task.spawn(function()
			while tick() - startTime < 0.4 do -- Only check for 0.2 seconds
				--if not Attachment then return end

				local startPos = Attachment.WorldPosition
				local direction = Attachment.Parent.CFrame.LookVector * Settings.Range.Value / 10
				local rayParams = RaycastParams.new()
				rayParams.FilterDescendantsInstances = {Tool.Parent}
				rayParams.FilterType = Enum.RaycastFilterType.Blacklist

				local result = workspace:Raycast(startPos, direction, rayParams)
				if result then
					local hitPart = result.Instance
					local victimCharacter = hitPart.Parent
					local victimHumanoid = victimCharacter and victimCharacter:FindFirstChild("Humanoid")

					if victimHumanoid and victimCharacter ~= Tool.Parent then
						-- Ensure we don't hit the same player multiple times
						if not AlreadyHit[victimCharacter] then
							AlreadyHit[victimCharacter] = true -- Mark as hit

							if victimHumanoid.Health > 0 then
								local ownerPlayer = game.Players:GetPlayerFromCharacter(ownerCharacter)

								task.spawn(function()
									if Tool.Varibles["Can Damage"].Value ~= false then
										Miscellaneous.Sound(Tool, Settings, "Hit")
										ownerPlayer.Events.NotifyEvent:FireClient(
											ownerPlayer,
											`{Miscellaneous.NotifyMessage(ownerPlayer, victimCharacter, Tool)}`,
											Color3.new(255, 255, 255)
										)
									end
								end)

								if victimHumanoid.Health <= Tool.Config.Damage.Value then
									task.spawn(function()
										if Tool.Varibles["Can Damage"].Value ~= false then
											Miscellaneous.Sound(Tool, Settings, "Dead")
											System.Ragdoll(victimCharacter, ownerCharacter)
										end
									end)
								end
								if Tool.Varibles["Can Damage"].Value ~= false then
									victimHumanoid:TakeDamage(Tool.Config.Damage.Value) -- victimHumanoid.MaxHealth
								end
							end
						end
					end
				end
				task.wait(0.05) -- Check every 0.05 seconds
			end
		end)
	end
end

function System.Swing(SwingType, Tool, HitAttachments, SwingAnimation)
	--[[
	Dev/test trail for attachments
	task.spawn(function()
		for _, Attachment in pairs(HitAttachments) do
			local Trail = Instance.new("Trail", Attachment)
			local A1 = Instance.new("Attachment", Attachment)
			A1.WorldCFrame = A1.WorldCFrame + Vector3.new(0.35, 0, 0)
			
			Trail.Texture = "rbxassetid://922357545"
			Trail.Lifetime = 0.2
			Trail.WidthScale = NumberSequence.new(0.02)
			Trail.MinLength = 0.5
			Trail.Color = ColorSequence.new(Color3.new(255, 0, 0))
			
			Trail.Attachment0 = Attachment
			Trail.Attachment1 = A1
			Trail.Enabled = true
		end
	end)
	]]
	if SwingType == "Normal" then
		if not Tool.Varibles.Equipped.Value then return end -- Ensure the tool is equipped
		if not Tool.Varibles["Can Swing"].Value then return end -- Prevent spam
		if not Tool.Config then
			warn("WeaponSettings is nil, aborting swing.")
			return
		end

		Tool.Varibles["Can Swing"].Value = false
		if Tool.Handle:FindFirstChild("!SWING_TRAIL") then
			Tool.Handle["!SWING_TRAIL"].Enabled = true
		end

		if SwingAnimation then -- Play swing animation
			SwingAnimation:Play()
			task.spawn(function()
				wait(Tool.Config.Cooldown.Value + 1)
				Tool.Varibles["Can Swing"].Value = true
				Tool.Varibles["Can Hit"].Value = true
				Tool.Varibles["Can Damage"].Value = true
				for _, Attachment in pairs(HitAttachments) do
					for _, sub in ipairs(Attachment:GetChildren()) do
						if sub:IsA("Attachment") or sub:IsA("Trail") then
							sub:Destroy()
						end
					end
				end
			end)
		end

		wait(0.3)
		Miscellaneous.Sound(Tool, Tool.Config, "Swing") -- Swing Sound
		wait(0.2)
		System.DetectVictims(Tool.Varibles["Character"].Value, Tool.Config, HitAttachments, Tool)
		SwingAnimation.Ended:Wait()

		if Tool.Handle:FindFirstChild("!SWING_TRAIL") then
			Tool.Handle["!SWING_TRAIL"].Enabled = false
		end
	end
end

function System.Swing_Alt(SwingType, Tool, HitAttachments, SwingAnimation)

	task.spawn(function()
		for _, Attachment in pairs(HitAttachments) do
			local Trail = Instance.new("Trail", Attachment)
			local A1 = Instance.new("Attachment", Attachment)
			A1.WorldCFrame = A1.WorldCFrame + Vector3.new(0.35, 0, 0)

			Trail.Texture = "rbxassetid://922357545"
			Trail.Lifetime = 0.2
			Trail.WidthScale = NumberSequence.new(0.02)
			Trail.MinLength = 0.5
			Trail.Color = ColorSequence.new(Color3.new(255, 0, 0))

			Trail.Attachment0 = Attachment
			Trail.Attachment1 = A1
			Trail.Enabled = true
		end
	end)
	
	if SwingType == "Normal" then
		if not Tool.Varibles.Equipped.Value then return end -- Ensure the tool is equipped
		if not Tool.Varibles["Can Swing"].Value then return end -- Prevent spam
		if not Tool.Config then
			warn("WeaponSettings is nil, aborting swing.")
			return
		end

		Tool.Varibles["Can Swing"].Value = false

		if SwingAnimation then -- Play swing animation
			SwingAnimation:Play()
			task.spawn(function()
				wait(Tool.Config.Cooldown.Value)
				Tool.Varibles["Can Swing"].Value = true
				Tool.Varibles["Can Hit"].Value = true
				Tool.Varibles["Can Damage"].Value = true
				for _, Attachment in pairs(HitAttachments) do
					for _, sub in ipairs(Attachment:GetChildren()) do
						if sub:IsA("Attachment") or sub:IsA("Trail") then
							sub:Destroy()
						end
					end
				end
			end)
		end

		wait(0.3)
		Miscellaneous.Sound(Tool, Tool.Config, "Swing") -- Swing Sound
		wait(0.2)
		System.DetectVictims(Tool.Varibles["Character"].Value, Tool.Config, HitAttachments, Tool)
	elseif SwingType == "AltAnims" then
		-- Didn't work here, so it'll be moved to the Weapon.
		--if not Tool.Varibles.Equipped.Value then return end -- Ensure the tool is equipped
		--if not Tool.Varibles["Can Swing"].Value then return end -- Prevent spam
		--if not Tool.Config then
		--	warn("WeaponSettings is nil, aborting swing.")
		--	return
		--end
		
		--local Varibles = Tool.Varibles
		--if not Tool.Animations:FindFirstChild("Swing_" .. Varibles["Swing Animation"].Value) then
		--	Tool.Varibles["Swing Animation"].Value = 1
		--end

		--SwingAnimation = Tool.Parent.Humanoid.Animator:LoadAnimation(Tool.Animations:FindFirstChild("Swing_"..Varibles["Swing Animation"].Value))

		--Tool.Varibles["Can Swing"].Value = false

		--if SwingAnimation then -- Play swing animation
		--	SwingAnimation:Play()
		--	task.spawn(function()
		--		wait(Tool.Config.Cooldown.Value)
		--		Varibles["Swing Animation"] = Varibles["Swing Animation"] + 1
		--		Tool.Varibles["Can Swing"].Value = true
		--		Tool.Varibles["Can Hit"].Value = true
		--		Tool.Varibles["Can Damage"].Value = true
		--		for _, Attachment in pairs(HitAttachments) do
		--			for _, sub in ipairs(Attachment:GetChildren()) do
		--				if sub:IsA("Attachment") or sub:IsA("Trail") then
		--					sub:Destroy()
		--				end
		--			end
		--		end
		--	end)
		--end

		--wait(0.3)
		--Miscellaneous.Sound(Tool, Tool.Config, "Swing") -- Swing Sound
		--wait(0.2)
		--System.DetectVictims(Tool.Varibles["Character"].Value, Tool.Config, HitAttachments, Tool)	
	end
end

--	if not Equipped then return end -- Ensure the tool is equipped
--	if not CanSwing then return end -- Prevent spam
--	if not WeaponSettings then
--		warn("WeaponSettings is nil, aborting swing.")
--		return
--	end

--	CanSwing = false
--	task.spawn(function()
--		wait(0.3)
--		WeaponSystem.Sound(Tool, WeaponSettings, "Swing") -- Swing Sound
--	end)

--	if WeaponSettings.HasEquipAnimation and IdleAnimation then -- Stop idle animation if applicable
--		IdleAnimation:Stop()
--	end

--	if Tool.Animations:FindFirstChild("Swing_"..SwingID) then -- Play swing animation
--		SwingAnimation:Play()
--	end

--	wait(0.5)
--	local VictimDetection = task.spawn(function() -- Spawn hit detection
--		WeaponSystem.DetectVictims(ownerCharacter, WeaponSettings, Weapon_Hit_Attachments, Tool)
--	end)

--	wait(0.5)
--	task.cancel(VictimDetection)

--	wait(0.35)
--	--[[
--	The SwingAnimation.Stopped is buggy for knife, so it's wait(0.6)
--	SwingAnimation.Stopped:Wait() -- Wait for swing animation to finish
--	]]
--	if Equipped and WeaponSettings.HasEquipAnimation and IdleAnimation then -- Reset animations
--		IdleAnimation:Play()
--	end

--	-- Reset hit tracking and cooldown
--	table.clear(AlreadyHit)
--	SwingID = SwingID + 1
--	task.wait(WeaponSettings.Cooldown)
--	CanSwing = true

return System
