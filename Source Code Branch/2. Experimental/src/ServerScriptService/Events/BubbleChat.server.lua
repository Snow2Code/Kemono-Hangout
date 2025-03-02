-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client:WaitForChild("Events")

local disguise = {
	--"Fun Sized Snow",
	"Snow",
	"Snow, Fractured Mercy",
	"CatFanatic109",
	"SillyFanatic109",
	"XxSuperSillyKittyxX12",
	"The Huntress", 
	--"the🐱"
}

Events.BubbleChat.OnServerInvoke = function(Player)
	local split = "<font color='#FFFFFF'>:</font>"
	print(`\n{Player}\n`)
	local NewProperties = Instance.new("BubbleChatMessageProperties")
	local RankInGroup = Player:GetRankInGroup(32066692)
	--NewProperties.FontFace = Font.fromEnum(Enum.Font.PermanentMarker)
	if RankInGroup > 4 then
		NewProperties.BackgroundTransparency = 0.5
		NewProperties.TextColor3 = Color3.fromRGB(255,255,255)
		if RankInGroup > 4 and RankInGroup < 10 then -- Dev Team
			NewProperties.BackgroundColor3 = Color3.fromRGB(61, 21, 133)
		elseif RankInGroup > 10 and RankInGroup < 12 then -- Silly
			NewProperties.BackgroundColor3 = Color3.fromRGB(255, 152, 220) --179, 0, 255
		elseif RankInGroup > 12 and RankInGroup < 15 then -- Staff
			NewProperties.BackgroundColor3 = Color3.fromRGB(159, 243, 233) --170, 255, 255
		elseif RankInGroup == 254 then --Silly fren
			NewProperties.BackgroundColor3 = Color3.fromRGB(179, 0, 255)
		elseif RankInGroup == 255 then -- Snow
			if Player:GetAttribute("disguised") == true then
				NewProperties.BackgroundColor3 = Color3.fromRGB(192, 255, 246) --179, 0, 255
			else
				NewProperties.BackgroundColor3 = Color3.fromRGB(204, 255, 204)
			end
		end
	elseif RankInGroup == 0 then -- Is a guest

	end
	print(NewProperties)
	return NewProperties
	--if what == "IncomingMessage" then
	--	local NewProperties = Instance.new("BubbleChatMessageProperties")
	--	print(NewProperties.PrefixText)
	--	local RankInGroup = Player:GetRankInGroup(32066692)
		
	--	if RankInGroup == 255 then
	--		if Player:GetAttribute("disguised") == true then
	--			NewProperties.PrefixText = `☢️<font color='#ff98dc'>{disguise[math.random(#disguise)]}</font>{split}`
	--		else
	--			NewProperties.PrefixText = `🐾🐱<font color='#ccffcc'>{Player.DisplayName}</font>{split}`
	--		end
	--	elseif RankInGroup == 254 then -- Silly
	--		NewProperties.PrefixText = `🐾🐱<font color='#ff98dc'>{Player.DisplayName}</font>{split}`
	--	elseif RankInGroup > 12 and RankInGroup < 15 then -- Staff
	--		NewProperties.PrefixText = `🛡️<font color='#9ff3e9'>{Player.DisplayName}</font>{split}`
	--		-- ☢️☣️⚠️🕳️💫
	--	elseif RankInGroup > 10 and RankInGroup < 12 then -- Silly
	--		NewProperties.PrefixText = `🐱<font color='#b300ff'>{Player.DisplayName}</font>{split}`
	--	elseif RankInGroup > 4 and RankInGroup < 10 then -- Dev
	--		NewProperties.PrefixText = `🔨<font color='#3d1585'>{Player.DisplayName}</font>{split}>`
	--	end
		
	--	return NewProperties
end