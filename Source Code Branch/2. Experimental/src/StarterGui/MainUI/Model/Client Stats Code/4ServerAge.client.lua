local ClientStore = game:GetService("ReplicatedStorage")
local ui = script.Parent.Parent

--task.spawn(function() -- Server Age
--	ClientStore.ServerAge:GetPropertyChangedSignal("Value"):Connect(function()
--		ui.ClientStats["4. ServerAge"].Text = ClientStore.ServerAge.Value
--	end)
--end)
local remote = ClientStore.ServerVersionUpdate

local function getTimeUnit(s)
	if s < 60 then
		return s, "second"
	elseif s < 60 * 60 then
		return s / 60, "minute"
	elseif s < 60 * 60 * 24 then
		return s / 60 / 60, "hour"
	elseif s < 60 * 60 * 24 * 7 then
		return s / 60 / 60 / 24, "day"
	else
		return s / 60 / 60 / 24 / 7, "week"
	end
end

local function stringTimeAgo(secondsAgo)
	local value, unit = getTimeUnit(secondsAgo)
	value = math.floor(value)
	if not (value == 1) then
		unit = unit.."s"
	end
	return value.." "..unit
end

remote.OnClientEvent:connect(function(serverAge, timeSinceUpdate)
	ui.ClientStats["4. ServerAge"].Text = stringTimeAgo(serverAge)
end)