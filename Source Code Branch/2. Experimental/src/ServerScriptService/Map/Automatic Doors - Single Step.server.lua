-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ServerStorage = game:GetService("ServerStorage")
local Server =  ServerStorage.Server
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local _Engine = Server.Modules.Engine
local Engine = require(_Engine)

-- Gets the goal of the door. (Door Open)
--function CalculateMove(Move, Door:Part, LeftorRight)
--	local Vector = Vector3.new()
--	if LeftorRight == "Left" then
--		--if Door.Orientation.Y == 0 or Door.Orientation.Y == 180 then
--		--	Vector = Vector3.new(4.95, 0, 0)
--		--elseif Door.Orientation.Y == 90 or Door.Orientation.Y == -90 then
--		--	Vector = Vector3.new(0, 0, 4.95)
--		--end
--	else
--		if Door.Orientation.Y == 0 or Door.Orientation.Y == 180 then
--			Vector = Vector3.new(-4.95, 0, 0)
--		elseif Door.Orientation.Y == 90 or Door.Orientation.Y == -90 then
--			Vector = Vector3.new(0, 0, -4.95)
--		end
--	end
--	if Move == "Goal" then
--		return Door.CFrame - Vector
--	else
--		return Door.CFrame + Vector
--	end
--end

function _Door(hit, Door, Varibles, DoorPart)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("Humanoid").Health > 0 then
		local success, e = pcall(function()
			task.spawn(function()
				local DoorTweenInfo = TweenInfo.new(Varibles.Time.Value, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
				if Varibles.Doors.Value == "Double" then
					if string.match(Varibles.DoorType.Value, "VIF") then
					else
						if Varibles.CanBeOpened.Value == true and Varibles.Open.Value ~= true then -- and Varibles.Debounce.Value == false
							local Tweens = {
								["Open"] = {
									["Left"] = TweenService:Create(DoorPart.LeftDoor.MainPart, DoorTweenInfo, {CFrame = DoorPart.LeftDoor.Goal.Value}),
									["Right"] = TweenService:Create(DoorPart.RightDoor.MainPart, DoorTweenInfo, {CFrame = DoorPart.RightDoor.Goal.Value})
								},
								["Close"] = {
									["Left"] = TweenService:Create(DoorPart.LeftDoor.MainPart, DoorTweenInfo, {CFrame = DoorPart.LeftDoor.Original.Value}),
									["Right"] = TweenService:Create(DoorPart.RightDoor.MainPart, DoorTweenInfo, {CFrame = DoorPart.RightDoor.Original.Value})
								}
							}

							Varibles.Open.Value = true

							if string.match(Varibles.DoorType.Value, "April") then
								for leftyrighty, Tween in pairs(Tweens.Open) do
									Engine.PlayTempSound_CertainPart(DoorPart[leftyrighty.."Door"].MainPart, _Engine.Parent.__Sounds.Doors.Open_April)
									DoorPart[leftyrighty.."Door"].MainPart.CFrame = DoorPart[leftyrighty.."Door"].Goal.Value
								end
							else
								for leftyrighty, Tween in pairs(Tweens.Open) do
									Engine.PlayTempSound_CertainPart(DoorPart[leftyrighty.."Door"].MainPart, _Engine.Parent.__Sounds.Doors.Open)
									Tween:Play()
								end
							end
							wait(5)
							if string.match(Varibles.DoorType.Value, "April") then
								for leftyrighty, Tween in pairs(Tweens.Open) do
									Engine.PlayTempSound_CertainPart(DoorPart[leftyrighty.."Door"].MainPart, _Engine.Parent.__Sounds.Doors.Close_April)
									DoorPart[leftyrighty.."Door"].MainPart.CFrame = DoorPart[leftyrighty.."Door"].Original.Value
								end
							else
								for leftyrighty, Tween in pairs(Tweens.Close) do
									Engine.PlayTempSound_CertainPart(DoorPart[leftyrighty.."Door"].MainPart, _Engine.Parent.__Sounds.Doors.Close)
									Tween:Play()
								end
							end
							wait(2)
							Varibles.Open.Value = false
						end
					end
				end
			end)
		end)
		
		if e then
			Engine.WarnToServer("[Door System] Error encourted. Info: "..e)
		end
	end
end

for _, DoorFolder in pairs(CollectionService:GetTagged("doors")) do
	for _, Door in ipairs(DoorFolder:GetChildren()) do
		local Varibles = Door:FindFirstChild("Variable")
		local DoorPart = Door:FindFirstChild("DoorPart")

		if Varibles and DoorPart then
			DoorPart = Door.DoorPartList -- Was DoorPart.Value, changed just in case ^^

			Door.Sensor.Detection.Touched:Connect(function(hit)
				_Door(hit, Door, Varibles, DoorPart)
				--if string.match(Varibles.DoorType.Value, "(Sensor)") then
				--	task.spawn(function()
				--		if Varibles.Doors.Value == "Double" then
				--			if string.match(Varibles.DoorType.Value, "VIF") then
				--			else
				--				if Varibles.CanBeOpened.Value == true and Varibles.Open.Value ~= true then -- and Varibles.Debounce.Value == false
				--					Varibles.Open.Value = true

				--					if string.match(Varibles.DoorType.Value, "April") then
				--						for leftyrighty, Tween in pairs(Tweens.Open) do
				--							Engine.PlayTempSound_CertainPart(DoorPart[leftyrighty.."Door"].MainPart, _Engine.Parent.__Sounds.Doors.Open_April)
				--							DoorPart[leftyrighty.."Door"].MainPart.CFrame = DoorPart[leftyrighty.."Door"].Goal.Value
				--						end
				--					else
				--						for leftyrighty, Tween in pairs(Tweens.Open) do
				--							Engine.PlayTempSound_CertainPart(DoorPart[leftyrighty.."Door"].MainPart, _Engine.Parent.__Sounds.Doors.Open)
				--							Tween:Play()
				--						end
				--					end
				--				end
				--			end
				--		end
				--	end)
				--else
				--	_Door(hit, Door, Varibles, DoorPart)
				--end
			end)
			--Door.Sensor.Detection.TouchEnded:Connect(function()
			--	print("end")
			--	if string.match(Varibles.DoorType.Value, "(Sensor)") and Varibles.CanBeOpened.Value == true and Varibles.Open.Value ~= false then
			--		if string.match(Varibles.DoorType.Value, "April") then
			--			for leftyrighty, Tween in pairs(Tweens.Open) do
			--				Engine.PlayTempSound_CertainPart(DoorPart[leftyrighty.."Door"].MainPart, _Engine.Sounds.Doors.Close_April)
			--				DoorPart[leftyrighty.."Door"].MainPart.CFrame = DoorPart[leftyrighty.."Door"].Original.Value
			--			end
			--		else
			--			for leftyrighty, Tween in pairs(Tweens.Close) do
			--				Engine.PlayTempSound_CertainPart(DoorPart[leftyrighty.."Door"].MainPart, _Engine.Sounds.Doors.Close)
			--				Tween:Play()
			--			end
			--		end
			--		wait(2)
			--		Varibles.Open.Value = false
			--	end
			--end)
		end
	end
end





--for i, folder in pairs(CollectionService:GetTagged("doors")) do
--	for i, door in ipairs(folder:GetChildren()) do
--		local success, fail = pcall(function()
--			door.Sensor.Detection.Touched:Connect(function(hit)
--				if not hit.Parent:IsA("Accessory") then
--					if hit.Parent:GetAttribute("Player") == true then
--						if door:GetAttribute("doors") == "Double" then
--							OpenAndCloseDoor(door, game.Players[hit.Parent.Name]:GetAttribute("HasVIF"))
--						elseif door:GetAttribute("doors") == "Single" then
--							OpenAndCloseDoor(door, game.Players[hit.Parent.Name]:GetAttribute("HasVIF"))
--						end
--					end
--				end
--			end)

--			if door:GetAttribute("type") == "Auto with Pad" then
--				for _, part in ipairs(door:WaitForChild("Pads", 120):GetChildren()) do
--					local prmpt = part.Attachment.Prompt
--					prmpt.Triggered:Connect(function(player)
--						if door:GetAttribute("proxdebounce") == false then
--							door:SetAttribute("proxdebounce", true)
--							door:SetAttribute("canopen", not door:GetAttribute("canopen"))
--							if door:GetAttribute("canopen") == false then
--								prmpt.ActionText = "Disable"
--							else
--								prmpt.ActionText = "Enable"
--							end
--							wait(1)
--							door:SetAttribute("proxdebounce", false)
--						end
--					end)
--				end
--			end
--		end)

--		if not success then
--			print("Door error:\n"..fail)
--		end
--	end
--end