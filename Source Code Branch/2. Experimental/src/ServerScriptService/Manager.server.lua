-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///


-- \\ Services and Dependencies.
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local MarketPlace = game:GetService("MarketplaceService")

local Server = ServerStorage.Server
local Client = ReplicatedStorage.Client

local Events = {--[[ ["Server"] = Server:WaitForChild("Events"), ]] ["Client"] = Client:WaitForChild("Events") }
local Modules = {["Server"] = Server:WaitForChild("Modules"), ["Client"] = Client:WaitForChild("Modules") }
local Assets = {["Server"] = Server:WaitForChild("Assets"), ["Client"] = Client:WaitForChild("Assets") }

local CustomizeColor = game:GetService("DataStoreService"):GetDataStore("Customize VIF Color")
local CustomizeText = game:GetService("DataStoreService"):GetDataStore("Customize VIF Text")

local Group = require(Server.Modules.Group)
local Engine = require(Modules.Server.Engine)
local Engine2 = require(Modules.Server.Engine2)

local group = 32066692

function JoinMessage(Player, msgSub)
	local Messages = Engine2.GetChatMessages(Player)
	print(Messages)
	Events.Client.Message:FireAllClients(Messages[msgSub][math.random(1, #Messages[msgSub])])
end

Players.PlayerAdded:Connect(function(player)
	local success, e = pcall(function()
		player.CharacterAdded:Connect(function(character)
			character:SetAttribute("Player", true)
			if character then
				local tag = Server.NameTag:Clone() --ServerAssets
				local tag_user, tag_rank, tag_icons = tag:FindFirstChild("User"),tag:FindFirstChild("Rank"), tag:FindFirstChild("Icons")
				local Rank = Group.GetRank(player, "Number")
				local isVIF = false
				local UserText = ""
				local VIFTagColor, VIFTagText = CustomizeColor:GetAsync(tostring(player.UserId)), CustomizeText:GetAsync(tostring(player.UserId))
				local Icons = {}

				tag.Parent = character.Head

				if not tag then
					Engine.LogToServerAndCertainClient(player, "Player is missing the tag GUI.")
					return
				end

				local success, message = pcall(function()
					isVIF = game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 730933732)
				end)

				if VIFTagColor ~= nil and isVIF then
					UserText = VIFTagText
				else
					UserText = player.DisplayName
				end
				
				tag_user.Text = UserText
				tag_user.ShadowText.Text = UserText

				if tag and player and player.Team then
					tag.Rank.Text = Engine2.removeEmojis(player:GetRoleInGroup(group)) -- player.Team.Name
					tag.Rank.ShadowText.Text = Engine2.removeEmojis(player:GetRoleInGroup(group)) -- player.Team.Name
					tag.Rank.TextColor3 = player.TeamColor.Color
					if VIFTagColor ~= nil and isVIF then
						local Components = VIFTagColor:split(",")
						local savedR, savedG, savedB = tonumber(Components[1]), tonumber(Components[2]), tonumber(Components[3])
						local retrievedColor = Color3.new(savedR, savedG, savedB)
						tag_user.TextColor3 = retrievedColor
					end
				end

				if Rank > 100 and Rank < 200 then  -- Staff
					table.insert(Icons, "Staff")
				elseif Rank >= 200 then
					table.insert(Icons, "Owner")
					table.insert(Icons, "Developer")
				end

				if player.MembershipType == Enum.MembershipType.Premium then
					table.insert(Icons, "Premium")
				end

				for _, icon in pairs(Icons) do
					if tag:FindFirstChild("Icons") then
						if tag.Icons:FindFirstChild(icon) then
							tag.Icons:WaitForChild(icon).Visible = true
						end
					end
				end

				character.Humanoid.NameDisplayDistance = 0
				character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			end
		end)
		
		if player.AccountAge < 28 then
			if player.Name ~= "Snow2Code" then
				player:Kick("Your account must be 4 weeks old to join.")
				return
			end
		end

		local character = player.Character or player.CharacterAdded:Wait()
		character:SetAttribute("Player", true)

		local leaderstats
		if not player:FindFirstChild("leaderstats") then
			leaderstats = Instance.new("Folder", player)
			leaderstats.Name = "leaderstats"
		else
			leaderstats = player:FindFirstChild("leaderstats")
			leaderstats.Name = "leaderstats"
		end

		local RoleValue = Instance.new("StringValue", leaderstats)
		RoleValue.Name = "Role"

		local msgSub

		local Events_ = Instance.new("Folder", player)
		Events_.Name = "Events"
		local NotifyEvent = Instance.new("RemoteEvent", Events_)
		NotifyEvent.Name = "NotifyEvent"
		local NotifyFunctionEvent = Instance.new("BindableFunction", Events_)
		NotifyFunctionEvent.Name = "NotifyFunctionEvent"
		local MessageEvent = Instance.new("RemoteEvent", Events_)
		MessageEvent.Name = "MessageEvent"

		local Rank = player:GetRankInGroup(group)
		local Role = Group.CheckRank(player)
		--role = string.gsub(RankInGroup, "%p", "")  --old

		if Rank ~= nil then
			if Rank >= 0 and Rank < 100 then
				msgSub = "General"
			elseif Rank > 100 and Rank < 200 then
				msgSub = "Staff"
			elseif Rank >= 200 then
				if player.UserId == 546537609 or player.UserId == 3643895594 then
					msgSub = "Snowy+Ollie"
					if player.UserId == 3643895594 and Engine.GetDate() == "07 February" then
						msgSub = msgSub.."_Birthday"
					elseif player.UserId == 546537609 and Engine.GetDate() == "08 October" then
						msgSub = msgSub.."_Birthday"
					end
				else
					msgSub = "Staff"
				end
			elseif Rank == 255 then
				msgSub = "Snowy+Ollie"
			end
			RoleValue.Value = Role.Rank
			player.Team = Role.Team
			JoinMessage(player, msgSub)
			player:SetAttribute("Role", Role.Rank)
			
			player:GetPropertyChangedSignal("Team"):Connect(function()
				if character and character:FindFirstChild("Head") and character:WaitForChild("Head"):FindFirstChild("NameTag") then
					print("Test")
					character.Head.NameTag.Rank.Text = "Updating..."
					wait(1)
					local Text = player.Team.Name
					if player:GetRankInGroup(group) > 100 then
						Text = Engine2.removeEmojis(player:GetRoleInGroup(group))
					end
					character.Head.NameTag.Rank.Text = Text -- player.Team.Name
					character.Head.NameTag.Rank.ShadowText.Text = Text -- player.Team.Name
					character.Head.NameTag.Rank.TextColor3 = player.TeamColor.Color
				end
			end)
		end
	end)

	if not success then
		Engine.LogToBoth(`Manager Script: {e}`)
	end
end)


game:BindToClose(function()
	for _, player in pairs(game.Players:GetChildren()) do
		game:GetService("TeleportService"):Teleport(16919962965, player)
	end
end)