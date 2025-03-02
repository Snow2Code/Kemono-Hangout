local success, err = pcall(function()
	local ClientStore = game:GetService("ReplicatedStorage")
	local Remote = ClientStore.Assets.Remotes["Remote Listener - RemoteEvent"]
	local ui = script.Parent.Parent

	Remote:FireServer("Get Server Location", {[1] = nil, [2] = nil}) -- Check Private

	if ClientStore.ServerType.Value == "Private Server" then -- Check Private
		ui.ClientStats["1. PrivateServer"].Visible = true
	end
end)

if not success then
	print("Client error:\n " .. err)
	game.Players.LocalPlayer.Events:FindFirstChild("NotifyFunctionEvent"):Invoke(
		err.."\n^\n|\nError",
		Color3.fromRGB(255, 0, 0)
	)
end