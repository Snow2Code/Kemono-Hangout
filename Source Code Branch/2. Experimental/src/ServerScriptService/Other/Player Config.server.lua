local _Players = require(game.ServerStorage.PlayerSettings)
local Settings = {
	"ChatMessageColor"
}

game.Players.PlayerAdded:Connect(function(player)
	_Players.AddPlayer(player)
	for _, Setting in pairs(Settings) do
		_Players.UpdateSetting(player, Setting, Color3.new(255, 255, 255))
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	_Players.RemovePlayer(player)
end)