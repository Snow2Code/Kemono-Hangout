-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local ServerAssets = Server.Assets
--local ServerEvents = Server.Events
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local ClientEvents = Client.Events
--local ClientAssets = Client.Assets

local DataStore = game:GetService("DataStoreService")
local GameData = DataStore:GetDataStore("Silly Kemono Hangout Fluffy Paws Data_Settings") -- Seprate datastore just in case.

local _Engine = Server.Modules.Engine
local Engine = require(_Engine)
--local Core = require(ServerStore.Game.CoreModule)

function SaveData(player)
	local ClientSettings = player.ClientSettings
	local MusicData = {}
	MusicData.Cafe = ClientSettings.Cafe.Value
	MusicData.Hotel = ClientSettings.Hotel.Value
	MusicData.Outside = ClientSettings.Outside.Value

	local success, e = pcall(function()
		GameData:SetAsync(player.UserId, MusicData)
	end)
	
	if success then
		Engine.LogToServer(`[Data Manager] Saved data for {player.Name}.`)
	else
		Engine.LogToServerAndCertainClient(player, `[Data Manager] Failed to save data for {player.Name}. Info: e`)
	end
end

Players.PlayerAdded:Connect(function(player)
	local ClientSettings = Instance.new("Folder", player)
	ClientSettings.Name = "ClientSettings"
	
	local CafeMusicSetting = Instance.new("BoolValue", ClientSettings)
	local HotelMusicSetting = Instance.new("BoolValue", ClientSettings)
	local OutsideMusicSetting = Instance.new("BoolValue", ClientSettings)
	CafeMusicSetting.Name = "Cafe"
	HotelMusicSetting.Name = "Hotel"
	OutsideMusicSetting.Name = "Outside"
	
	local MusicData

	local success, err = pcall(function()
		MusicData = GameData:GetAsync(player.UserId)
	end)
	
	if MusicData ~= nil then
		if MusicData.Cafe then
			CafeMusicSetting.Value = MusicData.Cafe
		end
		if MusicData.Hotel then
			HotelMusicSetting.Value = MusicData.Hotel
		end
		if MusicData.Outside then
			OutsideMusicSetting.Value = MusicData.Outside
		end
	end
end)

game:BindToClose(function()
	for _, player in pairs(game.Players:GetChildren()) do
		SaveData(player)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	SaveData(player)
end)