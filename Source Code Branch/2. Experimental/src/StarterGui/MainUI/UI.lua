local ui = {}

local RealUI = script.Parent

--[[
	Opens a menu.
]]
function ui.Open(ToOpen)
	--if ToOpen
	local Menu:Frame = RealUI.MainStuff.Menus:FindFirstChild(ToOpen)
	for _, Menu_:Frame in ipairs(RealUI.MainStuff.Menus:GetChildren()) do
		if Menu_.Name ~= Menu.Name then
			Menu_.Visible = false
			Menu_.Position = Menu_:GetAttribute("closed")
		end
	end
	if Menu then
		if Menu.Visible == false then
			script.ClickOpen:Play()
			Menu.Visible = true
			Menu:TweenPosition(Menu:GetAttribute("open"), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0.1)
		else
			script.ClickClose:Play()
			Menu:TweenPosition(Menu:GetAttribute("closed"), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0.1)
			wait(0.1)
			Menu.Visible = false
		end
	else
		print("\n\nCannot find " .. ToOpen .. " Menu.\n\n")
	end
end

return ui
