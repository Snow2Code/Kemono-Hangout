-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: A easter egg. This code is mostly imported from PFW and other code in Kemono Hangout
-- \\
-- \\\	///


-- Based on PFW code, modified as normal.
-- This is a easter egg of PFW also.
-- Actual date created: 3/12/2023

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server

local _Engine = Server.Modules.Engine
local Engine = require(_Engine)

local Attributes = {
	["Players"] = {}
}

Players.PlayerAdded:Connect(function(player)
	Attributes.Players[player.Name] = {["Alive"] = true, ["Can Trigger Fallen Easter Egg"] = true}
	
	player.CharacterAdded:Connect(function(character)
		Attributes.Players[player.Name].Alive = true
		Attributes.Players[player.Name]["Can Trigger Fallen Easter Egg"] = true
		
		character.Humanoid.Died:Connect(function()
			Attributes.Players[player.Name].Alive = false
			Attributes.Players[player.Name]["Can Trigger Fallen Easter Egg"] = false
		end)
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	Attributes.Players[player.Name] = nil
end)

task.spawn(function()
	local function RandomFallSound()
		local FallenSounds = _Engine.Parent.__Sounds["Easter Eggs"].Fallen:GetChildren()
		local randomSoundInFallen = math.random(#FallenSounds)
		local RandomSound = FallenSounds[randomSoundInFallen]
		
		return RandomSound
	end
	
	while true do
		wait(0.01)
		for _, player in ipairs(Players:GetPlayers()) do
			local Character = player.Character or player.CharacterAdded:Wait()
			local Humanoid = Character:WaitForChild("Humanoid")
			if Character and player:GetAttribute("InVoid") ~= true then
				local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
				local Height = HumanoidRootPart.Position.Y

				if Height < -490 then --[[ -500]]
					-- Fallen Easter Egg
					task.spawn(function()
						if Attributes.Players[player.Name]["Can Trigger Fallen Easter Egg"] == true then
							Attributes.Players[player.Name]["Can Trigger Fallen Easter Egg"] = false
							Engine.PlaySound_Global(RandomFallSound())
						end
					end)
				elseif Height > 490 then
					-- Fallen Easter Egg but for being a firework
					if Attributes.Players[player.Name]["Can Trigger Fallen Easter Egg"] == true then
						Attributes.Players[player.Name]["Can Trigger Fallen Easter Egg"] = false
						local Boom = Instance.new("Explosion")
						Boom.ExplosionType = Enum.ExplosionType.NoCraters
						Boom.Position = workspace[player.Name].HumanoidRootPart.Position
						Boom.TimeScale = 20
						Boom.BlastPressure = "inf"
						Boom.BlastRadius = 100
						Boom.Parent = workspace[player.Name].HumanoidRootPart
						Engine.PlaySound_Global(RandomFallSound())
					end
				end
			end
		end
	end
end)