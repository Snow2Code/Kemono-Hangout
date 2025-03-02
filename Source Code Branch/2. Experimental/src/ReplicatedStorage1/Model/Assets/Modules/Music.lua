local module = {}

--this could of been easier to do but eh. i already done this

function module.GetOutsideMusicStuffz()
	local MusicIDs = {
		["Song1"] = 9046862941,
		["Song2"] = 9046863253,
		["Song3"] = 9046863253,
		["Song4"] = 9047105533,
	}
	
	local BuildingsIDs = {
		["Hotel"] = 1,
		["HotelLift"] = 1845375096,
		["Cafe"] = 1840684529,
	}
	
	local MusicVolume = {
		["Song1"] = 0.2,
		["Song2"] = 0.2,
		["Song3"] = 0.2,
		["Song4"] = 0.2,
	}
	
	local Artist = {
		["Song1"] = "APM Music",
		["Song2"] = "APM Music",
		["Song3"] = "APM Music",
		["Song4"] = "APM Music",
	}
end

function module.GetInsideMusicStuffz(Building)
	-- goes unused :(  
	--(for now)
	local MusicVolume = { ["Hotel"] = 0.3, ["HotelLift"] = 0.3, ["Cafe"] = 0.3, ["GameRoom"] = 0.3 }
	local Artist = "APM Music"
	local BuildingsIDs = {
		["Hotel"] = 1841979451,
		["HotelLift"] = 1845375096,
		["Cafe"] = 1840684529,
		["GameRoom"] = 9043887091
	}
	

	if BuildingsIDs[Building] then
		local audioID = BuildingsIDs[Building]
		local artist = Artist
		local volume = MusicVolume[Building]
		
		--return audioID, artist, volume
		--return audioID
	else
		print("No building found in module with the name " .. Building)
		return nil
	end
end


return module
