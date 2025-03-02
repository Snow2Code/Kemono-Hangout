local VIFRemotes = game.ReplicatedStorage.RemoteEvents.VIF
local VIFFrame = script.Parent.MainStuff.Menus.VIFExclusive
local Settings = VIFFrame.ScrollingFrame["1 Settings"].Scrolling
local player = game.Players.LocalPlayer

local hasVif = false

local success, message = pcall(function()
	hasVif = game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 730933732)
end)

if not success then
	warn("Error while checking if player has pass: " .. tostring(message))
	return
end	

local NewTagColor = nil

if hasVif then
	Settings["2 Color"].ColorEditor.eventthing.Event:Connect(function(color)
		NewTagColor = color
	end)

	Settings["2 Color"].Update.MouseButton1Click:Connect(function()
		if NewTagColor ~= nil then
			local data = {}
			data.Color = NewTagColor
			VIFRemotes.CustoimizeTag:FireServer("Color", NewTagColor)
		end
	end)

	Settings["1 Text"].Update.MouseButton1Click:Connect(function()
		if Settings["1 Text"].Text.Text ~= nil then
			local data = {}
			local textlower = string.lower(Settings["1 Text"].Text.Text)
			if textlower == "displayname" then
				data.Text = player.DisplayName
				VIFRemotes.CustoimizeTag:FireServer("Text", data)
			elseif textlower == "username" then
				data.Text = player.Name
				VIFRemotes.CustoimizeTag:FireServer("Text", data)
			else
				data.Text = Settings["1 Text"].Text.Text
				VIFRemotes.CustoimizeTag:FireServer("Text", data)
			end
		end
	end)
end