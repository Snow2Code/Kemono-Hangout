local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local DatastoreService = game:GetService("DataStoreService")

local Datastore = DatastoreService:GetDataStore("Player Settings")

local Settings = {"LeaderboardNames"}

function LeavingAndServerClose(player)
	local SaveData = {
		["Settings"] = {}
	}
	
	for i, setting in ipairs(ServerStorage.PlayerSettings[player.Name].Settings:GetChildren()) do
		SaveData["Settings"][i] = {["SettingName"] = setting.Name, ["Value"] = setting.Value}
	end
	
	Datastore:SetAsync(player.UserId, SaveData)
end

Players.PlayerAdded:Connect(function(player)
	local plrFolder, plrSettings = Instance.new("Folder"), Instance.new("Folder")
	local leaderboardNames = Instance.new("BoolValue")
	
	plrFolder.Name = player.Name
	plrSettings.Name = "Settings"
	plrFolder.Parent = ServerStorage.PlayerSettings
	plrSettings.Parent = plrFolder
	
	for _, setting in Settings do
		leaderboardNames.Name = setting
		leaderboardNames.Value = false
		leaderboardNames.Parent = plrSettings
	end

	local Data
	
	local success, fail = pcall(function()
		Data = Datastore:GetAsync(player.UserId)
	end)
	
	if Data ~= nil then
		if Data.Settings then
			for i, v in pairs(Data.Settings) do
				if plrSettings:FindFirstChild(v.SettingName) then
					plrSettings[v.SettingName].Value = v.Value
				end
			end
		end
	end
end)

Players.PlayerRemoving:Connect(LeavingAndServerClose)

game:BindToClose(function()
	for _, player in Players:GetPlayers() do
		LeavingAndServerClose(player)
	end
end)