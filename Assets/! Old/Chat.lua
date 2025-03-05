local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = Client.Events
local TextChatService = game:GetService("TextChatService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

local split = "<font color='#FFFFFF'>:</font>"

local disguise = {
	--"Fun Sized Snow",
	"Snow",
	"Snow, Fractured Mercy",
	"CatFanatic109",
	"SillyFanatic109",
	"XxSuperSillyKittyxX12",
	"The Huntress", 
	--"the??"
}

function GetMessageColor()
	return Events.GetMessageColor:InvokeServer()
end

TextChatService.OnIncomingMessage = function(Message)
	--print(GetMessageColor())
	local TextChatMessageProperties = Instance.new("TextChatMessageProperties")
	if Message.TextSource then
		local Player = game.Players:GetPlayerByUserId(Message.TextSource.UserId)
		local RankInGroup = Player:GetRankInGroup(32066692)

		if RankInGroup == 255 then
			if Player:GetAttribute("disguised") == true then
				print(`??<font color='#ff98dc'>{Player:GetAttribute("disguise")}</font>{split}`)
				TextChatMessageProperties.PrefixText = `??<font color='#ff98dc'>{Player:GetAttribute("disguise")}</font>{split}`
			else
				TextChatMessageProperties.PrefixText = `????<font color='#ccffcc'>{Player.DisplayName}</font>{split}`
			end
		elseif RankInGroup == 254 then -- Silly
			TextChatMessageProperties.PrefixText = `????<font color='#ff98dc'>{Player.DisplayName}</font>{split}`
		elseif RankInGroup > 12 and RankInGroup < 15 then -- Staff
			TextChatMessageProperties.PrefixText = `???<font color='#9ff3e9'>{Player.DisplayName}</font>{split}`
			-- ???????????
		elseif RankInGroup > 10 and RankInGroup < 12 then -- Silly
			TextChatMessageProperties.PrefixText = `??<font color='#b300ff'>{Player.DisplayName}</font>{split}`
		elseif RankInGroup > 4 and RankInGroup < 10 then -- Dev
			TextChatMessageProperties.PrefixText = `??<font color='#3d1585'>{Player.DisplayName}</font>{split}>`
		end

		return TextChatMessageProperties
	end
end

TextChatService.OnBubbleAdded = function(Message, Adornee)
	if Message.TextSource then
		local NewProperties = Instance.new("BubbleChatMessageProperties")
		local Player = game.Players:GetPlayerByUserId(Message.TextSource.UserId)
		local RankInGroup = Player:GetRankInGroup(32066692)
		--NewProperties.FontFace = Font.fromEnum(Enum.Font.PermanentMarker)
		NewProperties.TextColor3 = Color3.fromRGB(0,0,0) --255,255,255
		
		if RankInGroup > 100 then
			NewProperties.BackgroundTransparency = 0.5
			if RankInGroup > 100 and RankInGroup < 200 then -- Staff
				NewProperties.BackgroundColor3 = Color3.fromRGB(159, 243, 233) --170, 255, 255
			elseif RankInGroup > 200 and RankInGroup < 255 then -- Sillys
				NewProperties.BackgroundColor3 = Color3.fromRGB(255, 152, 220) --179, 0, 255
			elseif RankInGroup == 255 then -- Snow
				if Player:GetAttribute("disguised") == true then
					NewProperties.BackgroundTransparency = 0.3
					NewProperties.BackgroundColor3 = Color3.fromRGB(192, 255, 246) --179, 0, 255
				else
					NewProperties.BackgroundColor3 = Color3.fromRGB(204, 255, 204)
				end
			end
		end
		return NewProperties
	end
end
--	NewProperties.BackgroundColor3 = Color3.fromRGB(61, 21, 133)