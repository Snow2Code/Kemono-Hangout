local Players = {}
local module = {}

function module.AddPlayer(player:Player)
	--table.insert(Players, player.Name)
	Players[player.Name] = {}
end

function module.RemovePlayer(player:Player)
	Players[player.Name] = nil --table.remove(Players, player.Name)
end

function module.UpdateSetting(player:Player, Setting, Value)
	Players[player.Name][Setting] = Value
end

function module.GetSetting(player:Player, Setting)
	return Players[player.Name][Setting]
end

return module
