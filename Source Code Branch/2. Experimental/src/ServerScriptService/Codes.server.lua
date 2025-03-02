-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: Handles code system.
-- \\
-- \\\	///

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DataStore = game:GetService("DataStoreService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = Client.Events

local Engine = require(ServerStorage.Server.Modules.Engine)

local CodesDatabase = DataStore:GetDataStore("Redeemed Codes Database V2.3")

local Codes = Engine.GetGameCodes()

function SaveData(player)
	local PlayerStorage = ServerStorage.Server.PlayerStorage:FindFirstChild(player.UserId)
	if PlayerStorage then
		local CodeData = {["Codes"] = {}}

		for _, Code in pairs(PlayerStorage.Codes:GetChildren()) do 
			if Code.Value == true then
				table.insert(CodeData.Codes, {["Name"] = Code.Name, ["Value"] = Code.Value})
			end
		end

		CodesDatabase:SetAsync(player.UserId, CodeData)

		local success, e = pcall(function()
			CodesDatabase:SetAsync(player.UserId, CodeData)
		end)
		if not success then
			warn(e)
		end
	end
end

Events.Codes.CheckCode.OnServerInvoke = function(player, givenCode)
	givenCode = string.lower(givenCode)
	for _, code in pairs(Codes) do
		if code == givenCode then
			return true
		end
	end
	--for _, code in pairs(code_table) do 
	--	if string.lower(Main.Code.Text) == string.lower(code.Name) then
	--		code_valid = true
	--		break
	--	end
	--end -- from client
	return false
end

Events.Codes.Redeem.OnServerEvent:Connect(function(player,code)
	local folder = player.CodesFolder
	if folder:FindFirstChild(code) then
		if folder[code].Value == false then
			local FoundTABLE
			for _, v in pairs(Codes) do 
				if v.Name == code then
					FoundTABLE = v
					break
				end
			end
			if FoundTABLE then
				if FoundTABLE.Currency == "Pawprints" or FoundTABLE.Currency == "FluffTokens" then
					folder[code].Value = true
					player[FoundTABLE.Currency].Value += FoundTABLE.Value
				end
			end
		--else
			--// Already Redeemed
		end
	--else
		--// Invalid Code
	end
end)

Players.PlayerAdded:Connect(function(player)
	--ClientStore.RemoteEvents["Non-Special"].RedeemCode:FireClient(player, Codes)
	
	local PlayerStorage = Instance.new("Folder", ServerStorage.Server.PlayerStorage)
	PlayerStorage.Name = tostring(player.UserId)
	
	local CodeFolder = Instance.new("Folder")
	CodeFolder.Name = "Codes"
	CodeFolder.Parent = PlayerStorage
	
	local data
	
	local success, err = pcall(function()
		data = CodesDatabase:GetAsync(player.UserId)
	end)
	
	if data ~= nil then
		if data.Codes then
			for _, code in pairs(data.Codes) do
				if not CodeFolder:FindFirstChild(code.Name) then
					local Code = Instance.new("BoolValue")
					Code.Name = code.Name
					Code.Value = code.Value
					Code.Parent = CodeFolder
				else
					CodeFolder[code.Name].Value = code.Value
				end
			end
		end
	end
end)

Players.PlayerRemoving:Connect(SaveData)

game:BindToClose(function()
	for _, player in pairs(Players:GetPlayers()) do 
		local s, e = pcall(function()
			SaveData(player)
		end)
		if not s then warn(e) end
	end
end)