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
	local hasVif = false

	local success, message = pcall(function()
		hasVif = game.MarketplaceService:UserOwnsGamePassAsync(Player.UserId, 730933732)
	end)

	if not success then
		warn("Error while checking if player has pass: " .. tostring(message))
		return
	end	
	
	if hasVif == false then
		misc["VIFExclusive"]:Destory()
	end

	local function setthing(setting, truefalse) if setting == "ClientStats" then Player.PlayerGui.MainUI.ClientStats.Visible = truefalse end end

	local function settin(settingname)
		local set = menus["Game Settings"].ScrollingFrame[settingname]
		if set:GetAttribute("debounce") == false then
			if set.Frame.Setting.Text == "OFF" then
				set:SetAttribute("debounce", true)
				clicksfx:Play()
				set.Frame.Setting.Text = "ON"
				set.Frame.EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
				set.Frame.EnableSetting.Frame:TweenPosition(
					UDim2.new(0, 42,0, 5),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Linear,
					0.02
				)
				setthing(set.Frame.EnableSetting:GetAttribute("dowhat"), true)
				--wait(2)
				set:SetAttribute("debounce", false)
			else
				set:SetAttribute("debounce", true)
				clicksfx:Play()
				set.Frame.Setting.Text = "OFF"
				set.Frame.EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
				set.Frame.EnableSetting.Frame:TweenPosition(
					UDim2.new(0, 5,0, 5),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Linear,
					0.02
				)
				setthing(set.Frame.EnableSetting:GetAttribute("dowhat"), false)
				--wait(2)
				set:SetAttribute("debounce", false)
			end
		end
	end

	local function UpdateSet(settingName)
		local settingUI = re[settingName]
		local settingValue = Settings:WaitForChild(settingName).Value
		if settingValue then
			re[settingName].Setting.Text = "MUTED/ON"
			re[settingName].EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
			re[settingName].EnableSetting.Frame:TweenPosition(
				UDim2.new(0, 42,0, 5),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Linear,
				0.02
			)
		else
			re[settingName].Setting.Text = "NOT MUTED/OFF"
			re[settingName].EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
			re[settingName].EnableSetting.Frame:TweenPosition(
				UDim2.new(0, 5,0, 5),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Linear,
				0.02
			)
		end
	end

	local function ToggleSet(settingName)
		local settingValue = Settings[settingName].Value
		local newSettingValue = game.ReplicatedStorage.Assets.Remotes["Remote Listener - RemoteFunction"]:InvokeServer("Update Setting", {settingName, not settingValue})
		if newSettingValue then
			Settings[settingName].Value = newSettingValue
		end
	end

	local function updatetog(settingName) clicksfx:Play() UpdateSet(settingName) ToggleSet(settingName) end

	UpdateSet("Cafe")
	UpdateSet("Hotel")
	UpdateSet("Outside")

	misc.Frame.EnableSetting.MouseButton1Click:Connect(function() settin("99Miscellaneous") end)
	re.Cafe.EnableSetting.MouseButton1Click:Connect(function()
		local settingName = "Cafe"
		ToggleSet(settingName)
		local settingUI = re[settingName]
		local settingValue = Settings:WaitForChild(settingName).Value
		if settingValue then
			re[settingName].Setting.Text = "MUTED/ON"
			re[settingName].EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
			re[settingName].EnableSetting.Frame:TweenPosition(
				UDim2.new(0, 42,0, 5),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Linear,
				0.02
			)
		else
			re[settingName].Setting.Text = "NOT MUTED/OFF"
			re[settingName].EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
			re[settingName].EnableSetting.Frame:TweenPosition(
				UDim2.new(0, 5,0, 5),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Linear,
				0.02
			)
		end
	end)
	re.Hotel.EnableSetting.MouseButton1Click:Connect(function()
		local settingName = "Hotel"
		ToggleSet(settingName)
		local settingUI = re[settingName]
		local settingValue = Settings:WaitForChild(settingName).Value
		if settingValue then
			re[settingName].Setting.Text = "MUTED/ON"
			re[settingName].EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
			re[settingName].EnableSetting.Frame:TweenPosition(
				UDim2.new(0, 42,0, 5),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Linear,
				0.02
			)
		else
			re[settingName].Setting.Text = "NOT MUTED/OFF"
			re[settingName].EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
			re[settingName].EnableSetting.Frame:TweenPosition(
				UDim2.new(0, 5,0, 5),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Linear,
				0.02
			)
		end
	end)
	re.Outside.EnableSetting.MouseButton1Click:Connect(function()
		local settingName = "Outside"
		ToggleSet(settingName)
		local settingUI = re[settingName]
		local settingValue = Settings:WaitForChild(settingName).Value
		if settingValue then
			re[settingName].Setting.Text = "MUTED/ON"
			re[settingName].EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
			re[settingName].EnableSetting.Frame:TweenPosition(
				UDim2.new(0, 42,0, 5),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Linear,
				0.02
			)
		else
			re[settingName].Setting.Text = "NOT MUTED/OFF"
			re[settingName].EnableSetting.Frame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
			re[settingName].EnableSetting.Frame:TweenPosition(
				UDim2.new(0, 5,0, 5),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Linear,
				0.02
			)
		end
	end)

	buttons["Game Settings"].MouseButton1Click:Connect(function()
		subclicksfx:Play()
		--buttons("Game Settings")
		local framethingy = buttons
		local menu = "Game Settings"
		--if menus:FindFirstChild(menu):GetAttribute("debounce") == false and buttons:GetAttribute("open") == true then
			if UIOpen == false then
				menus:FindFirstChild(menu):SetAttribute("debounce", true)
				tween:Create(script.Parent.MainStuff.Menus, info, {BackgroundTransparency = 0.3}):Play()
				menus:FindFirstChild(menu):TweenPosition(
					menus:FindFirstChild(menu):GetAttribute("open"),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Linear,
					0.2
				)
				UIOpen = true
				menus:FindFirstChild(menu).Visible = true
				menus:FindFirstChild(menu):SetAttribute("debounce", false)
			else
				for _, frame in ipairs(menus:GetChildren()) do
					frame:SetAttribute("debounce", true)
					tween:Create(script.Parent.MainStuff.Menus, info, {BackgroundTransparency = 1}):Play()
					frame:TweenPosition(
						frame:GetAttribute("closed"),
						Enum.EasingDirection.Out,
						Enum.EasingStyle.Linear,
						0.2
					)
					UIOpen = false
					frame.Visible = false
					Player.PlayerGui.StoreOpen.Value = not Player.PlayerGui.StoreOpen.Value
					frame:SetAttribute("debounce", false)
				end
			end
		--end
	end)

	gamset.Topbar.Close.MouseButton1Click:Connect(function()
		clicksfx:Play()
		--local menu = "Game Settings"
		if menus:FindFirstChild("Game Settings"):GetAttribute("debounce") == false then
			if UIOpen == false then
				menus:FindFirstChild("Game Settings"):SetAttribute("debounce", true)
				tween:Create(script.Parent.MainStuff.Menus, info, {BackgroundTransparency = 1}):Play()
				menus:FindFirstChild("Game Settings"):TweenPosition(
					menus:FindFirstChild("Game Settings"):GetAttribute("open"),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Linear,
					0.2
				)
				UIOpen = true
				menus:FindFirstChild("Game Settings").Visible = true
				menus:FindFirstChild("Game Settings"):SetAttribute("debounce", false)
			else
				for _, frame in ipairs(menus:GetChildren()) do
					frame:SetAttribute("debounce", true)
					tween:Create(script.Parent.MainStuff.Menus, info, {BackgroundTransparency = 1}):Play()
					frame:TweenPosition(
						frame:GetAttribute("closed"),
						Enum.EasingDirection.Out,
						Enum.EasingStyle.Linear,
						0.2
					)
					UIOpen = false
					frame.Visible = false
					frame:SetAttribute("debounce", false)
				end
			end
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