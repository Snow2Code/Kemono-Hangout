local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local values = {}

function values.SetValue(name, newValue)
	if Server.Values:FindFirstChild(name) then
		Server.Values:WaitForChild(name).Value = newValue
	end
end

function values.GetValue(name)
	if Server.Values:FindFirstChild(name) then
		return Server.Values:WaitForChild(name).Value
	else
		return nil
	end
end

return values