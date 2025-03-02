-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

game.Players.PlayerAdded:Connect(function(player)
	local _character = player.Character or player.CharacterAdded:Wait()
	
	player.CharacterAdded:Connect(function(Character)
		local Part = Instance.new("Part")
		Character.HumanoidRootPart.Anchored = true
		
		if Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
			Part.Size = Part.Size + Vector3.new(0, Character["Left Leg"].Size.Y, 0) + Vector3.new(0, 0.6, 0.6)
		else
			Part.Size = Vector3.new(2.7, 5, 2.45)
			Part.CFrame = Character.HumanoidRootPart.CFrame + Vector3.new(0, -1.1, 0)
		end
		
		Part.Name = "PlayerCollision"
		Part:SetAttribute("AssignedTo", Character.Name)
		Part.CanCollide = false
		Part.Massless = true
		Part.BrickColor = BrickColor.new("Really red")
		Part.Transparency = 0.7 -- 0.7
		Part.Parent = Character

		local Weld = Instance.new("WeldConstraint", Part)
		Weld.Part0 = Character.HumanoidRootPart
		Weld.Part1 = Part
		
		for _, descendant in ipairs(Character:GetDescendants()) do
			--print(typeof(descendant), descendant.ClassName)			
			pcall(function()
				if descendant:IsA("BasePart") then -- Ensure it's a valid object (like a Part, MeshPart, etc.)
					descendant.CanQuery.Value = false
					descendant.CanTouch.Value = false
				end
			end)
		end
		
		--if e then
		--	game.Players:GetPlayerFromCharacter(Character):Kick("\n[Player Collision]\nReport this to a developer: "..e)
		--end
		wait(0.5)
		Character.HumanoidRootPart.Anchored = false
	end)
	
	player:GetAttributeChangedSignal("IsTranfur"):Connect(function()
		if _character:GetAttribute("Is_Tranfur") == true then
			wait(4)
			_character:WaitForChild("PlayerCollision").CFrame = _character.HumanoidRootPart.CFrame + Vector3.new(0, -1.1, 0)
		end
	end)
	
end)