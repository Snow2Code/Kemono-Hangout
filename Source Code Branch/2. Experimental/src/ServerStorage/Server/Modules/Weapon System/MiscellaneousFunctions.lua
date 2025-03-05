
--TODO: Fix up varibles
local SystemMisc = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Client = ReplicatedStorage.Client
local Animations = Client.Assets.Animations
local Events = Client.Events
local Sounds = Client.Assets.Sounds

-- Get a random sound
function SystemMisc.RandomSound(SoundFolder: Folder, SubFolder)
	local WeaponSounds = SoundFolder:FindFirstChild(SubFolder)
	
	if WeaponSounds then
		local RandomWeaponSound = WeaponSounds:GetChildren()[math.random(1, #WeaponSounds:GetChildren())]
		return RandomWeaponSound
	end
	
	print("Cannot find the Weapon Sound folder for", SoundFolder, "Using default.")
	return Sounds.Weapons:WaitForChild("nil"):WaitForChild(SubFolder)
end

-- Play sound
function SystemMisc.Sound(Tool:Tool, Settings, Sound:string)
	task.spawn(function()
		local Speed = 1 + math.random(-10,10) / 70
		--print("speed", Speed)
		if Sounds.Weapons:FindFirstChild(Tool.Name) then
			if Sound == "Dead" then
				local Sound = Sounds.Weapons:WaitForChild(Tool.Name).Dead:Clone()
				Sound.Parent = Tool.Handle
				Sound:Play()
				Sound.PlaybackSpeed = Speed
				Sound.Ended:Wait()
				Sound:Destroy()
			else
				if Tool.Config["Weapon Name"].Value == "Unknown" then
					local RandomSound = Sounds.Weapons["nil"][Sound]
					local Sound = RandomSound:Clone()

					Sound.Parent = Tool.Handle
					Sound:Play()
					Sound.PlaybackSpeed = Speed
					Sound.Ended:Wait()
					Sound:Destroy()
				else
					local RandomSound = SystemMisc.RandomSound(Sounds.Weapons:WaitForChild(Tool.Name), Sound)
					local ChosenSound = RandomSound:Clone()

					ChosenSound.Parent = Tool.Handle
					ChosenSound:Play()
					ChosenSound.PlaybackSpeed = Speed
					ChosenSound.Ended:Wait()
					ChosenSound:Destroy()
				end
			end
		end
	end)
end

-- The logic for the Victim Text.
function SystemMisc.VictimText(victimCharacter)
	local Team
	local VicName = victimCharacter.Name
	if Players:FindFirstChild(victimCharacter.Name) then
		Team = Players[victimCharacter.Name].Team.TeamColor.Color:ToHex()
		VicName = Players:FindFirstChild(victimCharacter.Name).DisplayName
	else
		Team = "9ff3e9"
	end
	return `<font color='#{Team}'>{VicName}</font>`
end

-- The logic for the message that the player receives after hitting a victim :3
function SystemMisc.NotifyMessage(Player, _Victim, Tool)
	local distance = (Player.Character.PrimaryPart.Position - _Victim.PrimaryPart.Position).Magnitude
	local Victim = SystemMisc.VictimText(_Victim)
	local Damage = `<font color='#DC7A81'>{Tool.Config.Damage.Value}</font>`
	local Message = `Dealt {Damage} damage to {Victim} from {distance} studs away.`

	if Player:GetRankInGroup(32066692) > 200 then
		Message = `Hit {Victim}. Dealt {Damage} damage. Distance {distance}`
	end

	return Message
end

return SystemMisc