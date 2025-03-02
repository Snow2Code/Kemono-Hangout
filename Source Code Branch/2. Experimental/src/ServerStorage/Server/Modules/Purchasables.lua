local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local ServerAssets = Server.Assets
local PurchasableFolder = ServerAssets.Items.Purchasables
local PurchasableFolders = require("./PurchasablesFolders")

local Purchaseables = {
	["Ollie the Dragon Plushie"] = {
		["Name"] = "Ollie the Dragon Plushie",
		["Price"] = 30,
		["Currency"] = "Pawprints",
		["Folder"] = PurchasableFolder:WaitForChild(PurchasableFolders["Ollie the Dragon Plushie"]),
		["Item"] = PurchasableFolder:WaitForChild(PurchasableFolders["Ollie the Dragon Plushie"])
	},
	["Peppermint Paws Plushie"] = {
		["Name"] = "Peppermint Paws Plushie",
		["Price"] = 25,
		["Currency"] = "Pawprints",
		["Folder"] = PurchasableFolder:WaitForChild(PurchasableFolders["Peppermint Paws Plushie"]),
		["Item"] = PurchasableFolder:WaitForChild(PurchasableFolders["Peppermint Paws Plushie"])
	}
}

return Purchaseables
