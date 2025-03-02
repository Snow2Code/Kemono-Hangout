local module = {}

function module.FetchServerStorageData(folder, value)
	local Folder_Final = string.lower(folder)
	local Value_Final = string.lower(value)
	
	if Folder_Final ~= "game" then
		return nil
	else
		if Value_Final ~= "LynsSpecialDay" and Value_Final ~= "OlliesSpecialDay" then
			return nil
		else
			return game:GetService("ServerStorage").Game.SpecialDay:FindFirstChild(value)
		end
	end
end

return module
