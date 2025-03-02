local debounce = false
local tweenSer = game:GetService("TweenService")
local gui = script.Parent
local Scrolling = gui.Settings.Scrolling
local Settings = game.Players.LocalPlayer:WaitForChild("ClientSettings")
local open = Instance.new("BoolValue", game.Players.LocalPlayer)
open.Name = "UIOpen"
open.Value = false

local function updateUI(settingName)
	local settingValue = Settings:WaitForChild(settingName).Value
	local settingUI = Scrolling[settingName]
	if settingValue then
		settingUI.DO.Text = "Currently Muted"
		settingUI.Mute.Text = "Unmute"
	else
		settingUI.DO.Text = "Currently Not Muted"
		settingUI.Mute.Text = "Mute"
	end
end

local function toggleUI()
	if debounce then return end
	debounce = true
	local isOpen = game.Players.LocalPlayer.UIOpen.Value
	local newSize, newPosition, waitTime
	if isOpen then
		newSize = UDim2.new(0, 0, 0, 0)
		newPosition = UDim2.new(0.5, 0, 0.5, 0)
		waitTime = 3
	else
		newSize = UDim2.new(0.422, 0, 0.777, 0)
		newPosition = UDim2.new(0.268, 0, 0.111, 0)
		waitTime = 1
		script.Parent.Settings.Visible = true
	end
	script.Parent.Settings:TweenSizeAndPosition(newSize, newPosition, Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.5, false)
	game.Players.LocalPlayer.UIOpen.Value = not isOpen
	wait(waitTime)
	if not game.Players.LocalPlayer.UIOpen.Value then
		script.Parent.Settings.Visible = false
	end
	debounce = false
end

local function toggleSetting(settingName)
	local settingValue = Settings[settingName].Value
	local newSettingValue = game.ReplicatedStorage.Assets.Remotes["Remote Listener - RemoteFunction"]:InvokeServer("Update Setting", {settingName, not settingValue})
	if newSettingValue then
		Settings[settingName].Value = newSettingValue
	end
end

local function updateAfterToggle(settingName)
	toggleSetting(settingName)
	updateUI(settingName)
end

updateUI("Cafe")
updateUI("Hotel")
updateUI("Outside")
gui.BottomBar.Settings.Button.MouseButton1Click:Connect(toggleUI)
Scrolling.Cafe.Mute.MouseButton1Click:Connect(function() updateAfterToggle("Cafe") end)
Scrolling.Hotel.Mute.MouseButton1Click:Connect(function() updateAfterToggle("Hotel") end)
Scrolling.Outside.Mute.MouseButton1Click:Connect(function() updateAfterToggle("Outside") end)

function Tilt1()
	local tweenInfo = TweenInfo.new(3)
	local goal = {Rotation = 10}

	tweenSer:Create(script.Parent.UpdateScreen.RefreshText, tweenInfo, goal):Play();
	tweenSer:Create(script.Parent.UpdateScreen.RefreshText1, tweenInfo, goal):Play();
	tweenSer:Create(script.Parent.UpdateScreen.RefreshText2, tweenInfo, goal):Play();
	tweenSer:Create(script.Parent.UpdateScreen.RefreshText3, tweenInfo, goal):Play();
	tweenSer:Create(script.Parent.UpdateScreen.RefreshText4, tweenInfo, goal):Play();

	wait(3)
end

function Tilt2()
	local tweenInfo = TweenInfo.new(3)
	local goal = {Rotation = -10}

	tweenSer:Create(script.Parent.UpdateScreen.RefreshText, tweenInfo, goal):Play();
	tweenSer:Create(script.Parent.UpdateScreen.RefreshText1, tweenInfo, goal):Play();
	tweenSer:Create(script.Parent.UpdateScreen.RefreshText2, tweenInfo, goal):Play();
	tweenSer:Create(script.Parent.UpdateScreen.RefreshText3, tweenInfo, goal):Play();
	tweenSer:Create(script.Parent.UpdateScreen.RefreshText4, tweenInfo, goal):Play();

	wait(3)
end

game.ReplicatedStorage.Assets.Remotes.Update.OnClientEvent:Connect(function()
	local info = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
	local module = require(script.ModuleScript)
	local scrn = script.Parent.UpdateScreen
	local blckScrn = script.Parent.UpdateScreenBlack
	blckScrn.Visible = true
	script.Update.UpdateSFX:Play()
	workspace.Sounds.Regions:ClearAllChildren()
	wait(0.5)
	blckScrn:TweenSizeAndPosition(
		UDim2.new(5, 0,5, 0),
		UDim2.new(0.5, 0,0.5, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Linear, 0.5, false
	)

	task.spawn(function()
		while wait() do 
			tweenSer:Create(scrn, info, {BackgroundColor3 = Color3.fromHSV(tick()%5/5,1,1)}):Play()
			tweenSer:Create(scrn.UIStroke, info, {Color = Color3.fromHSV(tick()%5/5,1,1)}):Play()
			wait(0.2)
		end
	end)

	local plrname = game.Players.LocalPlayer.Name
	local chance = math.random(1, 2)
	local ChanceFrame = scrn["Chance"..chance]

	local success, err = pcall(function()
		scrn["Chance1"].Model.Rig.Humanoid:LoadAnimation(scrn.Chance1.Model.Rig.Idle):Play()
		ChanceFrame.Visible = true
	end)

	if not success then
		print("Update Screen Error. Report to dev!\n\n"..err)
	end
	wait(5)

	script.Parent.UpdateScreenBlack:TweenSizeAndPosition(
		UDim2.new(0, 0,0, 0), UDim2.new(0.5, 0,0.5, 0),
		Enum.EasingDirection.In,
		Enum.EasingStyle.Linear, 
		0.2,
		false
	)
	workspace[plrname].HumanoidRootPart.Died:Destroy()
	workspace[plrname].HumanoidRootPart.FreeFalling:Destroy()
	workspace[plrname].HumanoidRootPart.GettingUp:Destroy()
	workspace[plrname].HumanoidRootPart.Jumping:Destroy()
	workspace[plrname].HumanoidRootPart.Landing:Destroy()
	workspace[plrname].HumanoidRootPart.Running:Destroy()
	workspace[plrname].HumanoidRootPart.Splash:Destroy()
	workspace[plrname].HumanoidRootPart.Swimming:Destroy()
	workspace[plrname].Humanoid.WalkSpeed = 0
	workspace[plrname].Humanoid.JumpHeight = 0
	module.RandomMusic("Start")
	scrn.Visible = true
	blckScrn.Visible = true

	module.UpdateText("Game is being refreshed")

	task.spawn(function()
		while true do
			wait(8)
			module.UpdateText(module.RandomText())
		end
	end)

	task.spawn(function()
		while wait() do
			if script.Parent.UpdateScreen.Visible == true then
				Tilt1()
				Tilt2()
			end
		end
	end)
	task.spawn(function()
		while true do
			if workspace[plrname].Humanoid.WalkSpeed ~= 0 or workspace[plrname].Humanoid.JumpHeight then	
				workspace[plrname].HumanoidRootPart.Died:Destroy()
				workspace[plrname].HumanoidRootPart.FreeFalling:Destroy()
				workspace[plrname].HumanoidRootPart.GettingUp:Destroy()
				workspace[plrname].HumanoidRootPart.Jumping:Destroy()
				workspace[plrname].HumanoidRootPart.Landing:Destroy()
				workspace[plrname].HumanoidRootPart.Running:Destroy()
				workspace[plrname].HumanoidRootPart.Splash:Destroy()
				workspace[plrname].HumanoidRootPart.Swimming:Destroy()
				workspace[plrname].Humanoid.WalkSpeed = 0
				workspace[plrname].Humanoid.JumpHeight = 0
			end
		end
	end)
end)