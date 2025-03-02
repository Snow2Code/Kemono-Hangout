local success, err = pcall(function()
	local ClientStore = game:GetService("ReplicatedStorage")
	local ClientAssets = ClientStore:WaitForChild("Assets")
	local Remote = ClientStore.Assets.Remotes["Remote Listener - RemoteEvent"]
	local Player = game:GetService("Players").LocalPlayer
	local RunService = game:GetService("RunService")
	local tween = game:GetService("TweenService")
	local info = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)

	local UIOpen = script.Parent.UIOpen.Value
	local ui = script.Parent
	local buttons = ui.Buttons
	local menus = ui.MainStuff.Menus
	local gamset = menus["Game Settings"]
	local giftshop = menus["Giftshop"]
	local scrollie = gamset.ScrollingFrame
	local re = scrollie["1RegionStuff"]
	local misc = gamset.ScrollingFrame["99Miscellaneous"]
	local clicksfx = script.MouseClickSFX
	local subclicksfx = script.SubMenuClickSFX
	local Player = game:GetService("Players").LocalPlayer
	local Settings = Player:WaitForChild("ClientSettings")
	
	task.spawn(function()
		giftshop.Topbar.Pawprints.Value.Text = tostring(Player:WaitForChild("Pawprints", 60).Value)
		giftshop.Topbar.FluffTokens.Value.Text = tostring(Player:WaitForChild("FluffTokens", 60).Value)
		wait(0.1)
	end)
	
	task.spawn(function()
		while true do
			Player:WaitForChild("Pawprints", 60):GetPropertyChangedSignal("Value"):Connect(function(new)
				giftshop.Topbar.Pawprints.Value.Text = tostring(Player:WaitForChild("Pawprints", 60).Value)
			end)
			Player:WaitForChild("FluffTokens", 60):GetPropertyChangedSignal("Value"):Connect(function(new)
				giftshop.Topbar.FluffTokens.Value.Text = tostring(Player:WaitForChild("FluffTokens", 60).Value)
			end)
			wait(0.1)
		end
	end)

	giftshop.Topbar.Close.MouseButton1Click:Connect(function()
		giftshop.Visible = false
		menus.Giftshop.Music.Volume = 0.03 wait(0.01)
		menus.Giftshop.Music.Volume = 0.02 wait(0.01)
		menus.Giftshop.Music.Volume = 0.01 wait(0.01)
		menus.Giftshop.Music.Volume = 0.00 wait(0.01)
		menus.Giftshop.Music:Stop()
		menus.Giftshop.Music.Volume = 0.03
	end)

	for _, frame in pairs(giftshop.Main:GetChildren()) do
		if frame.Name ~= "UIListLayout" then
			if frame.Purchase.AutoButtonColor ~= false and frame.Purchase.Text ~= "You own it!" then
				frame.Purchase.MouseButton1Click:Connect(function()
					print(frame:GetAttribute("product"))
					ClientStore.RemoteEvents["Non-Special"].PurchaseItem:FireServer(frame:GetAttribute("product"))
				end)
			end
		end
	end

	Player:WaitForChild("Items").ChildAdded:Connect(function(child)
		for _, frame in pairs(giftshop.Main:GetChildren()) do
			if child.Name == frame:GetAttribute("product") then
				frame.Purchase.AutoButtonColor = true
				frame.Purchase.Text = "You own it!"
			end
		end
	end)

	task.spawn(function()
		while true do
			for _, item in pairs(Player.Items:GetChildren()) do
				for _, frame in pairs(giftshop.Main:GetChildren()) do
					if item.Name == frame:GetAttribute("product") then
						frame.Purchase.AutoButtonColor = true
						frame.Purchase.Text = "You own it!"
					end
				end
			end
			wait(0.1)
		end
	end)

	ClientStore.RemoteEvents["Non-Special"].OpenUI.OnClientEvent:Connect(function(menu)
		if menus[menu] then
			for _, frame in pairs(menus:GetChildren()) do
				frame.Visible = false
			end

			menus[menu].Visible = not menus[menu].Visible
			if menu == "Giftshop" then
				Player.PlayerGui.StoreOpen.Value = not Player.PlayerGui.StoreOpen.Value
				for _, v in pairs(Player.PlayerGui.Music:GetChildren()) do if v:IsA("Sound") then v:Stop() end end
				menus[menu].Music:Play()
				menus.Giftshop.Music.Volume = 0.01 wait(0.01)
				menus.Giftshop.Music.Volume = 0.02 wait(0.01)
				menus.Giftshop.Music.Volume = 0.03
			end
		end
	end)

	Player.PlayerGui.StoreOpen.Changed:Connect(function(new)
		if new ~= true then
			menus.Giftshop.Music.Volume = 0.03 wait(0.01)
			menus.Giftshop.Music.Volume = 0.02 wait(0.01)
			menus.Giftshop.Music.Volume = 0.01 wait(0.01)
			menus.Giftshop.Music.Volume = 0.00 wait(0.01)
			menus.Giftshop.Music:Stop()
			menus.Giftshop.Music.Volume = 0.03
		end
	end)
end)

if not success then
	print("Client error:\n " .. err)
	game.Players.LocalPlayer.Events:FindFirstChild("NotifyFunctionEvent"):Invoke(
		err.."\n^\n|\nError",
		Color3.fromRGB(255, 0, 0)
	)
end