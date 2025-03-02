local Lighting = game.Lighting
local Player = game.Players.LocalPlayer
local UI = script.Parent
local Menus = UI.MainStuff.Menus

local _Settings_ = {
	["Colors"] = {
		["Red"] = Color3.fromRGB(255, 100, 100),
		["Green"] = Color3.fromRGB(100, 255, 100)
	},
	["Positions"] = {
		["On"] = UDim2.new(0.22, 0, 0.122, 0),
		["Off"] = UDim2.new(0.77, 0, 0.122, 0)
	}
}

function UpdateSetting()
	
end

function GetSetting()
	
end

-- Menus
Menus.Rules.Visible = true
Lighting.StartBlur.Enabled = true

Menus.Rules.Content.Confirm.MouseButton1Click:Connect(function()
	if Player:GetAttribute("UI_Confirmed_Rules_Debounce") ~= true then
		Player:SetAttribute("UI_Confirmed_Rules_Debounce", true)
		Menus.Rules.Visible = false
		repeat
			Lighting.StartBlur.Size = Lighting.StartBlur.Size - 0.5
			task.wait(0.01)
		until Lighting.StartBlur.Size <= 0
		Player:SetAttribute("ComfirmedRules", true)
	end
end)

for _, MusicSetting in ipairs(Menus["Game Settings"].ScrollingFrame["aaa (Music)"]:GetChildren()) do
	if MusicSetting:IsA("Frame") then
		if MusicSetting.Name ~= "aaa (Top)" then
			MusicSetting.Slider.Button.MouseButton1Click:Connect(function()
				print("Click")
			end)
		end
	end
end