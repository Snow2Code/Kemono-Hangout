local buttons = script.Parent.Buttons
local Menus = script.Parent.MainStuff.Menus
local Main = script.Parent.MainStuff.Menus.GameCodes.Main
local Redeem = Main.Redeem

local Player = game:GetService("Players").LocalPlayer
local ClickDB = false

local RedeemCode = game:GetService("ReplicatedStorage").RemoteEvents["Non-Special"].RedeemCode
local CheckCode = game:GetService("ReplicatedStorage").RemoteFunctions.CheckCode

local UIOpen = script.Parent.UIOpen.Value

buttons["Game Codes"].MouseButton1Click:Connect(function()
	if UIOpen == false then
		UIOpen = true
		Main.Open:Play()
		for _, menu in pairs(Menus:GetChildren()) do
			menu.Visible = false

			Menus.Giftshop.Music.Volume = 0
			Menus.Giftshop.Music:Stop()
		end
		Menus["GameCodes"].Visible = true
		Menus["GameCodes"].Visible = true
		Menus["GameCodes"].Visible = true
		Menus["GameCodes"].Visible = true
	else
		UIOpen = false
		Main.Close:Play()
		for _, menu in pairs(Menus:GetChildren()) do
			menu.Visible = false
			
			Menus.Giftshop.Music.Volume = 0
			Menus.Giftshop.Music:Stop()
		end
	end
end)

Main.Parent.Topbar.Close.MouseButton1Click:Connect(function()
	if UIOpen == false then
		UIOpen = true
		Main.Open:Play()
		Menus["Game Settings"].Visible = false
	else
		UIOpen = false
		Main.Close:Play()
		for _, menu in pairs(Menus:GetChildren()) do
			menu.Visible = false

			Menus.Giftshop.Music.Volume = 0
			Menus.Giftshop.Music:Stop()
		end
	end
end)

local frame_open = false

function Msg(Failed, Color, code)
	local Text = {}
	local Colors = {}

	Text.DoesNotExist = "It seems like that code does not exist."
	Text.NoText = "You haven't typed in a code. Try again."
	Text.AlreadyRedeemed = "It seems like you already redeemed the code."
	Text.Added = "Added"
	Text.Plus = "+"
	Text.RedeemedCode = "Redeemed code"
	Text.ToInventory = "to your inventory"
	Colors.Red = Color3.fromRGB(247, 37, 37)
	Colors.Green = Color3.fromRGB(37, 247, 37)

	if string.lower(Failed) == "redeemed" then
		Main.Error.Text = Text.RedeemedCode .. " " .. code
	elseif string.lower(Failed) == "alreadyredeemed" then
		Main.Error.Text = Text.AlreadyRedeemed
	elseif string.lower(Failed) == "nocode" then
		Main.Error.Text = Text.NoText
	elseif string.lower(Failed) == "doesnotexist" then
		Main.Error.Text = Text.DoesNotExist
	end

	Main.Error.TextColor3 = Colors[Color]
	Main.Error.Visible = true
	wait(3)
	Main.Error.Visible = false
end

Redeem.MouseButton1Click:Connect(function()
	local code = string.lower(Main.Code.Text)
	local ValidCode = CheckCode:InvokeServer(code)
	if ClickDB == false then
		ClickDB = true
		if ValidCode == true then
			local plr_codes = Player['CodesFolder']
			if plr_codes:FindFirstChild(string.lower(Main.Code.Text)) then
				if plr_codes[string.lower(Main.Code.Text)].Value == false then
					RedeemCode:FireServer(string.lower(Main.Code.Text))
					Main.Code.TextEditable = false
					--Main.Code.Text = ''
					Msg("Redeemed", "Green", Main.Code.Text)
					delay(1,function()
						Main.Code.TextEditable = true
						Main.Code.Text = ''
					end)
				else
					Main.Code.TextEditable = false
					--Main.Code.Text = ''
					Msg("AlreadyRedeemed", "Red", Main.Code.Text)
					delay(1.25,function()
						Main.Code.TextEditable = true
						Main.Code.Text = ''
					end)
				end
			end
		else
			Main.Code.TextEditable = false
			--Main.Code.Text = ''
			Msg("DoesNotExist", "Red", Main.Code.Text)
			delay(1.25,function()
				Main.Code.TextEditable = true
				Main.Code.Text = ''
			end)
		end
		wait(0.15)
		ClickDB = false
	end
end)	
--button_animation(Open,true)
--button_animation(Redeem,true)