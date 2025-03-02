local Checks = {}
local Attributes = require("./Attributes")

function Checks.CheckIfHoildayOrSillyTime()
	if Attributes.GetAttribute("Global", "Christmas") then
		return "Christmas"
	elseif Attributes.GetAttribute("Global", "April Fools") then
		return "April Fools"
	elseif Attributes.GetAttribute("Global", "Halloween") then
		return "Halloween"
	end
	
	return "Normal"
end

return Checks