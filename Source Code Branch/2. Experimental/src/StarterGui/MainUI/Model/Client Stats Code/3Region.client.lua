local success, err = pcall(function()
	local ClientStore = game:GetService("ReplicatedStorage")
	local ui = script.Parent.Parent

	task.spawn(function() -- Region
		ClientStore.Region:GetPropertyChangedSignal("Value"):Connect(function()
			ui.ClientStats["3. Region"].Text = "Region: " .. ClientStore.Region.Value
		end)
	end)
end)

if not success then
	print("Client error:\n " .. err)
	game.Players.LocalPlayer.Events:FindFirstChild("NotifyFunctionEvent"):Invoke(
		err.."\n^\n|\nError",
		Color3.fromRGB(255, 0, 0)
	)
end