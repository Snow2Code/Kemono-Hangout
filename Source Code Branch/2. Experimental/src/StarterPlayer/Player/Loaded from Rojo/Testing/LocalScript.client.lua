
local Players = game.Players
local Player:Player = Players.LocalPlayer
local ReplicatedStorage = game.ReplicatedStorage
local Client = ReplicatedStorage.Client
local TopbarIcon = require(Client.Modules.Topbar.Icon)

local _UI_ = Player.PlayerGui:WaitForChild("MainUI")
local UIModule = require(_UI_.UI)

Player:GetAttributeChangedSignal("ComfirmedRules"):Connect(function()
	if Player:GetAttribute("ComfirmedRules") == true then
		local Menus = {}
		
		local function Selected(What)
			print(`\n{Player.DisplayName} has selected a new thing: {What}\n`)
			local _MENU_ = nil
			if What == "Menus.Codes" then
				_MENU_ = "GameCodes"
			elseif What == "Menus.Settings" then
				_MENU_ = "Game Settings"
			elseif What == "Menus.Shop" then
				_MENU_ = "Shop"
			elseif What == "Menus.VIF" then
				_MENU_ = "VIFExclusive"
			elseif What == "Menus.Commands" then
				_MENU_ = "SnowyCommands"
			end
			UIModule.Open(_MENU_)
		end

		local function Event(SelectID)
			Selected(SelectID)
		end
		
		local function AddMenuItem(Label, SelectID, Image)
			local insert = nil
			if Image ~= nil then
				insert = TopbarIcon.new():setLabel(Label):setImage(Image):bindEvent("selected", function() Event(SelectID) end):oneClick(true)
			else
				insert = TopbarIcon.new():setLabel(Label):bindEvent("selected", function() Event(SelectID) end):oneClick(true)
			end
			table.insert(Menus, insert)
		end

		-- Default Stuff
		AddMenuItem("Game Codes", "Menus.Codes", 16149184217)
		AddMenuItem("Settings", "Menus.Settings", 17129985991)
		AddMenuItem("Shop", "Menus.Shop", 5459770609)
		--AddMenuItem("A", "B")

		if Client.Events.Player.HasVIF:InvokeServer() then
			AddMenuItem("VIF Exclusive", "Menus.VIF")
		end

		if Client.Events.Player.HasCommands:InvokeServer() then
			AddMenuItem("Thing for Commands", "Commands")
		end

		TopbarIcon.new()
			:setLabel("User Menus")
			:setCaption("Open stuff.")
			:align("Left")
			:modifyTheme({"Dropdown", "MaxIcons", 5})
			:modifyChildTheme({"Widget", "MinimumWidth", 100})
			:setMenu(Menus)
			:setImage(17129986325)
	end
end)