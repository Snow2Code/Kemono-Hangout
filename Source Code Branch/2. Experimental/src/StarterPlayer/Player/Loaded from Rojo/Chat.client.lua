local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = Client.Events
local TextChatService = game:GetService("TextChatService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

function GetMessageColor()
	return Events.Chat.GetMessageColor:InvokeServer()
end

function GetDate()
	return Events.Misc.GetDate:InvokeServer()
end

function CMsgProp(Player)
	local RankInGroup = Player:GetRankInGroup(32066692)
	local Team = Events.Chat.GetTeam:InvokeServer()
	local Prop = {
		["StartEmojis"] = "",
		["Name"] = Player.DisplayName,
		["NameColor"] = Player.Team.TeamColor.Color:ToHex(),
		["MessageColor"] = GetMessageColor()
	}

	if RankInGroup >= 200 then
		if Player.UserId == 3643895594 then
			if GetDate() == "07 February" then
				Prop.StartEmojis = "🎂"
			else
				Prop.StartEmojis = "💚" --🐾🐱
			end
		elseif Player.UserId == 546537609 then
			if GetDate() == "08 October" then
				Prop.StartEmojis = "🎂"
			else
				Prop.StartEmojis = "💚" --🐾🐱
			end
		else
			Prop.StartEmojis = "💚" --🐾🐱
		end
		--Properties.PrefixText = `🐾🐱<font color='#ff98dc'>{Player.DisplayName}</font>{split}`
	elseif RankInGroup > 100 and RankInGroup < 200 or Team == "Staff" or Team == "Head Staff" then -- Staff
		Prop.StartEmojis = "🔨" -- 🛡️
	end

	return Prop
end

TextChatService.OnIncomingMessage = function(Message)
	local Properties = Instance.new("TextChatMessageProperties")
	if Message.TextSource then
		local Player = game.Players:GetPlayerByUserId(Message.TextSource.UserId)
		local Prop = CMsgProp(Player)
		
		Prop.MessageColor = Prop.MessageColor:ToHex()
		
		Properties.PrefixText = `{Prop.StartEmojis} <font color='#{Prop.NameColor}'>{Player.DisplayName}</font><font color='#FFFFFF'>:</font>`
		--Properties.Text = "Test"
		
		return Properties
	end
end

TextChatService.OnBubbleAdded = function(Message, Adornee)
	if Message.TextSource then
		local NewProperties = Instance.new("BubbleChatMessageProperties")
		local Player = game.Players:GetPlayerByUserId(Message.TextSource.UserId)
		local Team = Events.Chat.GetTeam:InvokeServer()
		local RankInGroup = Player:GetRankInGroup(32066692)
		--NewProperties.FontFace = Font.fromEnum(Enum.Font.PermanentMarker)
		
		if RankInGroup > 100 then
			NewProperties.BackgroundTransparency = 0.5
			NewProperties.TextColor3 = Color3.fromRGB(0, 0, 0) --255,255,255
			NewProperties.BackgroundColor3 = Team.TeamColor.Color
		end

		return NewProperties
	end
end
--	NewProperties.BackgroundColor3 = Color3.fromRGB(61, 21, 133)