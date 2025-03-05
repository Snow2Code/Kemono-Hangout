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
local Engine = {}
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

return Engine
