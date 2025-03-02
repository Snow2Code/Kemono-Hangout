-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local ServerAssets = Server.Assets
local _Engine = Server.Modules.Engine
local Engine = require(_Engine)
local Group = require(_Engine.Parent.Group)
local EmotesFolder = ServerAssets.Animations.Emotes

local Emotes = {
	"Smug",
	"Spooky",
	"Distraction",
	"California",
	"Griddy",
	"Sit4",
	"Lethal",
	"Kazotsky",
	"Mannrobics",
	--"Sadcatdance"
}

local function EmoteSound(char, sound, what)
	if what == "play" then
		print(sound)
		char.HumanoidRootPart[sound]:Play()
		--if sound == "Lethal" or sound == "EmoteLethal0" or sound == "EmoteLethal1" then
		--	char.HumanoidRootPart["EmoteLethal" .. math.random(0, 1)]:Play()
		--else
		--	char.HumanoidRootPart[sound]:Play()
		--end
	else
		--for _, a in pairs(char.HumanoidRootPart:GetChildren()) do
		--	for _, b in pairs(EmotesWithSound) do
		--		if b.Value == a.Name then
		--			char.HumanoidRootPart[a.Name]:Stop()
		--		end
		--	end
		--end
	end
end

function playEmote(player, animationName)
	local playing = game.Players[player.Name]:GetAttribute("EmotePlaying")
	if playing == false or playing == nil then
		player:SetAttribute("EmotePlaying", true)

		local char = workspace[player.Name]
		local animationController = workspace[player.Name].Humanoid:WaitForChild("Animator")
		local emote

		if char.Humanoid.RigType == Enum.HumanoidRigType.R15 then
			emote = animationController:LoadAnimation(EmotesFolder.R15:WaitForChild(animationName))
		else
			emote = animationController:LoadAnimation(EmotesFolder.R6:WaitForChild(animationName))
		end

		local lastPosition = char:GetPrimaryPartCFrame().p
		emote:Play()

		for _, v in pairs(Emotes) do
			print("anim: "..animationName)
			print("v.Name:"..v.Name)
			if v.Name == animationName then
				local tranfur = char:GetAttribute("tranfur")
				local trantype = char:GetAttribute("type")
				if tranfur == nil and trantype == nil then
					if v == "Lethal" then
						local the = math.random(1, 3)
						char.HumanoidRootPart["EmoteLethal1"]:Stop()
						char.HumanoidRootPart["EmoteLethal2"]:Stop()
						char.HumanoidRootPart["EmoteLethal3"]:Stop()
						char.HumanoidRootPart["EmoteLethal" .. the]:Play()
					elseif v == "Sadcatdance" then
						task.spawn(function()
							char.HumanoidRootPart.SadCatDance:Play()
							task.wait(1.47)
							char.HumanoidRootPart.SadCatDance.bit2:Play()
							task.wait(1.8)
							char.HumanoidRootPart.SadCatDance.bit3:Play()
						end)
					else
						EmoteSound(char, v.Value, "play")
					end
				else
					if trantype == "rainbow" then
						--break
						return
					end
				end
			end
		end

		local isMoving = false
		local connection
		local function stopEmote() emote:Stop() connection:Disconnect() end

		connection = game:GetService("RunService").Heartbeat:Connect(function()
			local currentPosition = char:GetPrimaryPartCFrame().p
			if (currentPosition - lastPosition).magnitude > 0.01 then
				isMoving = true
				if isMoving then
					stopEmote()
					task.spawn(function()
						player:SetAttribute("EmotePlaying", false)
						EmoteSound(char, "whatever", "stop")
					end)
				end
			else
				isMoving = false
			end
			lastPosition = currentPosition
		end)
	end
end

game.Players.PlayerAdded:Connect(function(player)
	local char = player.Character or player.CharacterAdded:Wait()

	player.Chatted:Connect(function(message)
		message = string.gsub(string.lower(message), "/e ", "")
		local messageUp = string.upper(string.sub(message, 1, 1)) .. string.sub(message, 2, -1)
		if Group.GetRank(player, "Number") > 100 then
			for _, v in pairs(Emotes) do
				--print(v)
				--print(messageUp)
				if v == messageUp then
					local playing = player:GetAttribute("EmotePlaying")
					if playing == nil then
						player:SetAttribute("EmotePlaying", false)
					end

					playEmote(player, messageUp)
				end
			end
		end
	end)
end)
