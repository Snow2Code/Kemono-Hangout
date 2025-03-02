-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: Handles the set times to add paws and whatnot, also the Currency instance creation
-- \\
-- \\\	///

local group = 32066692
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local AnalyticsService = game:GetService("AnalyticsService")
local Engine = require(game.ServerStorage.Server.Modules.Engine)
local DataStore = game:GetService("DataStoreService")
local GameData = DataStore:GetDataStore("Silly Kemono Hangout Fluffy Paws Data")

local Client = ReplicatedStorage.Client
--local Assets = Client.Asset
local Events = Client.Events

local Purchasables = require(game.ServerStorage.Server.Modules.Purchasables)

game.Players.PlayerAdded:Connect(function(player)
	local Leaderstats = Instance.new("Folder", player)
	Leaderstats.Name = "leaderstats"
	
	local items = Instance.new("Folder", player)
	items.Name = "Items"
	
	local pawprints = Instance.new("NumberValue", player)
	pawprints.Name = "Pawprints"
	
	local FluffTokens = Instance.new("NumberValue", player)
	FluffTokens.Name = "FluffTokens"

	local data

	local success,errorMsg = pcall(function()
		data = GameData:GetAsync(player.UserId)
	end)

	if data ~= nil then
		if data.Pawprints then
			player["Pawprints"].Value = data.Pawprints
		end
		if data.FluffTokens then 
			player["FluffTokens"].Value = data.FluffTokens
		end
		if data.OwnedItems then
			for _, OwnedItem in pairs(data.OwnedItems) do
				local ItemValue = Instance.new("BoolValue")
				ItemValue.Name = OwnedItem.Name
				ItemValue.Parent = items
				ItemValue.Value = OwnedItem.Value

				local ItemInPurchasables = Purchasables[OwnedItem.Name]
				local Item = ItemInPurchasables.Item
				
				if Item then
					Item:Clone().Parent = player.StarterGear
					if not player.Backpack:FindFirstChild(ItemInPurchasables.Name) then
						Item:Clone().Parent = player.Backpack
					end
				end
			end
		end
	end

	local success, e = pcall(function()
		local HasVIF = MarketplaceService.UserOwnsGamePassAsync(MarketplaceService, player.UserId, 730933732)
	end)
	--if success and hasPass then
	--	player:SetAttribute("HasVIF", true)
	--end
end)

Players.PlayerRemoving:Connect(function(player)
	local data = {--[[Pawprints = player.Pawprints.Value, FluffTokens = player.FluffTokens.Value]]}

	data.Pawprints = player.Pawprints.Value
	data.FluffTokens = player.FluffTokens.Value

	data.OwnedItems = {}

	for _, item in pairs(player.Items:GetChildren()) do
		table.insert(data.OwnedItems, {["Name"] = item.Name, ["Value"] = item.Value})
	end

	--print(data.OwnedItems)

	local success, e = pcall(function()
		--print(data)
		--print(player.UserId)
		GameData:SetAsync(player.UserId, data)
	end)

	if success then
		Engine.LogToServer(`Saved data (Pawprints, FluffTokens and items for {player.Name} ({player.DisplayName})`)
	else
		Engine.WarnToServer(`Error saving data for {player.Name} ({player.DisplayName}). Info > {e}`)
	end
end)


--[[

This is Legacy Code, it's from the old source code,.
Because it's legacy and I do not know what it is for. It'll be removed, in the sense of a code comment. Just in case.

Events["Remote Listener - RemoteEvent"].OnServerEvent:Connect(function(client, rl, misc)
	if rl == "Save Leaderdata" then
		local ValueName = misc[1]
		local Amount = misc[2]

		if ValueName == "Pawprints" then
			if Amount ~= 10 then
				client.leaderstats.Pawprints.Value = client.leaderstats.Pawprints.Value + Amount
			end
		elseif ValueName == "FluffTokens" then
			if Amount ~= 10 then
				client.leaderstats["FluffTokens"].Value = client.leaderstats["FluffTokens"].Value + Amount
			end
		end
	end
end)

]]


function Pawprints()
	while true do
		wait(180)
		for _, player in ipairs(game.Players:GetChildren()) do
			local Pawprints = player:WaitForChild("Pawprints")
			local Amount = 0
			if player:GetAttribute("HasVIF") ~= true then
				Amount = math.random(10, 20)
			else
				Amount = math.random(50, 70)
			end

			AnalyticsService:LogEconomyEvent(
				player,
				Enum.AnalyticsEconomyFlowType.Source,
				"Pawprints", -- Currency name
				Amount, -- Amount earned
				Pawprints.Value, -- Current balance
				Enum.AnalyticsEconomyTransactionType.TimedReward.Name -- Transaction type
			)

			Pawprints.Value = Pawprints.Value + Amount

			AnalyticsService:LogEconomyEvent(
				player,
				Enum.AnalyticsEconomyFlowType.Source,
				"Pawprints", -- Currency name
				Amount, -- Amount earned
				Pawprints.Value, -- Balance after transaction
				Enum.AnalyticsEconomyTransactionType.TimedReward.Name -- Transaction type
			)
		end
		wait(0.2)
	end
end

function FluffTokens()
	while true do
		wait(220)
		for _, player in ipairs(game.Players:GetChildren()) do
			local FluffTokens = player:WaitForChild("FluffTokens")
			local Amount = 0
			if player:GetAttribute("HasVIF") ~= true then
				Amount = 2
			else
				Amount = 4
			end

			AnalyticsService:LogEconomyEvent(
				player,
				Enum.AnalyticsEconomyFlowType.Source,
				"FluffTokens", -- Currency name
				Amount, -- Amount earned
				FluffTokens.Value, -- Current balance
				Enum.AnalyticsEconomyTransactionType.TimedReward.Name -- Transaction type
			)

			FluffTokens.Value = FluffTokens.Value + Amount

			AnalyticsService:LogEconomyEvent(
				player,
				Enum.AnalyticsEconomyFlowType.Source,
				"FluffTokens", -- Currency name
				Amount, -- Amount earned
				FluffTokens.Value, -- Balance after transaction
				Enum.AnalyticsEconomyTransactionType.TimedReward.Name -- Transaction type
			)
		end
		wait(0.2)
	end
end

task.spawn(function()
	Pawprints()
end)

task.spawn(function()
	FluffTokens()
end)