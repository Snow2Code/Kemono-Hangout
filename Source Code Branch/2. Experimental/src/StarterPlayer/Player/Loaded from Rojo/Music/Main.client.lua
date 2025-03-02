-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

--* For the brave souls who get this far: You are the chosen ones,
--* the valiant knights of programming who toil away, without rest,
--* fixing our most awful code. To you, true saviors, kings of men,
--* I say this: never gonna give you up, never gonna let you down,
--* never gonna run around and desert you. Never gonna make you cry,
--* never gonna say goodbye. Never gonna tell a lie and hurt you.

wait()
local player = game:GetService("Players").LocalPlayer
local Music = script
local ClientSettings = player:WaitForChild("ClientSettings")

--Meaning for true and false for music settings.
-- true: muted
-- false: not muted

ClientSettings:WaitForChild("Cafe"):GetPropertyChangedSignal("Value"):Connect(function()
	if ClientSettings:WaitForChild("Cafe").Value == true then -- Cafe
		Music.MusicCafe.Volume = 0
	elseif ClientSettings:WaitForChild("Cafe").Value == false then -- Cafe
		Music.MusicCafe.Volume = 0.1
	end
end)

ClientSettings:WaitForChild("Hotel"):GetPropertyChangedSignal("Value"):Connect(function()
	if ClientSettings:WaitForChild("Hotel").Value == true then -- Hotel
		Music.MusicHotel.Volume = 0
		Music.MusicHotelLofi.Volume = 0
	elseif ClientSettings:WaitForChild("Hotel").Value == false then -- Hotel
		Music.MusicHotel.Volume = 0.2
		Music.MusicHotelLofi.Volume = 0.1
	end
end)

ClientSettings:WaitForChild("Outside"):GetPropertyChangedSignal("Value"):Connect(function()
	if ClientSettings:WaitForChild("Outside").Value == true then -- Outside
		Music.MusicOutside.Volume = 0
	elseif ClientSettings:WaitForChild("Outside").Value == false then -- Outside
		Music.MusicOutside.Volume = 0.1
	end
end)

if ClientSettings:WaitForChild("Cafe").Value == true then -- Cafe
	Music.MusicCafe.Volume = 0
elseif ClientSettings:WaitForChild("Cafe").Value == false then -- Cafe
	Music.MusicCafe.Volume = 0.1
end

if ClientSettings:WaitForChild("Hotel").Value == true then -- Hotel
	Music.MusicHotel.Volume = 0
	Music.MusicHotelLofi.Volume = 0
elseif ClientSettings:WaitForChild("Hotel").Value == false then -- Hotel
	Music.MusicHotel.Volume = 0.2
	Music.MusicHotelLofi.Volume = 0.1
end
if ClientSettings:WaitForChild("Outside").Value == true then -- Outside
	Music.MusicOutside.Volume = 0
elseif ClientSettings:WaitForChild("Outside").Value == false then -- Outside
	Music.MusicOutside.Volume = 0.1
end


-- //== Copyright fuzzy_james and 0llie_kitty at Protogen StudiØs, All rights reserved. ==\\
--||																																			||
--|| Purpose: music 																													||
--||																																		    ||
-- \\=============================================================================//

-- // i hate this so much

local success, err = pcall(function()
	local client = game:GetService("Players").LocalPlayer
	local main = require(game.ReplicatedStorage.Assets.Modules.ModuleMain)
	local MainFolder = workspace:WaitForChild("Coded", 120).MusicBox
	local fadeTime = 0.1

	local volumes = {
		Cafe = 0.1,
		Hotel = 0.2,
		Lofi = 0.2,
		Outside = 0.1
	}
	
	--[[
	This is buggy, so no.
	local function fadeSound(sound, targetVolume)
		local startVolume = sound.Volume
		local startTime = tick()
		while tick() - startTime < fadeTime do
			local elapsed = tick() - startTime
			sound.Volume = startVolume + (targetVolume - startVolume) * (elapsed / fadeTime)
			wait()
		end
		sound.Volume = targetVolume
	end

	local function stopWithFade(sound)
		fadeSound(sound, 0)
		wait(fadeTime)
		sound:Stop()
	end

	local function playWithFade(sound)
		sound:Play()
		fadeSound(sound, volumes[sound.Name])
	end
	]]

	local function hitregion(player, idkhelp)
		local regions = {"Hotel", "HotelLofi", "Cafe", "Outside"}
		local sounds = {"MusicHotel", "MusicHotelLofi", "MusicCafe", "MusicOutside",}

		for _, region in ipairs(regions) do
			if idkhelp == "Hit" .. region then
				for _, r in ipairs(regions) do
					if r == region then
						if not player:GetAttribute(r .. "Playing") then
							player:SetAttribute(r .. "Playing", true)
							if game.Players.LocalPlayer.PlayerGui.StoreOpen.Value ~= true then
								game.Players.LocalPlayer.PlayerGui.Music["Music" .. region]:Play()
								--0.4.0 removed the Giftshop music sadly. So this isn't need.
							--else
							--	for _, v in pairs(game.Players.LocalPlayer.PlayerGui.Music:GetChildren()) do
							--		if v:IsA("Sound") then
							--			v:Stop()
							--		end
							--	end
							end
						end
					else
						if player:GetAttribute(r .. "Playing") then
							player:SetAttribute(r .. "Playing", false)
							script["Music" .. r]:Stop()
						end
					end
				end
			end
		end
	end

	local _regions = {
		Hotel = MainFolder:WaitForChild("HitHotel", 60),
		HotelLofi = MainFolder:WaitForChild("HitHotelLofi", 60),
		Cafe = MainFolder:WaitForChild("HitCafe", 60),
		Outside = MainFolder:WaitForChild("HitOutside", 60)
	}

	client:SetAttribute("HotelPlaying", false)
	client:SetAttribute("HotelLofiPlaying", false)
	client:SetAttribute("CafePlaying", false)
	client:SetAttribute("OutsidePlaying", false)

	for region, object in pairs(_regions) do
		if object:IsA("BasePart") then
			object.Touched:Connect(function(hit)
				if hit.Name == "PlayerCollision" and hit:GetAttribute("AssignedTo") == client.Name then
					hitregion(client, "Hit" .. region)
				end
			end)
		else
			for _, child in ipairs(object:GetChildren()) do
				if child:IsA("BasePart") then
					child.Touched:Connect(function(hit)
						if hit.Name == "PlayerCollision" and hit:GetAttribute("AssignedTo") == client.Name then
							hitregion(client, "Hit" .. region)
						end
					end)
				end
			end
		end
	end
end)

if not success then
	print("Client error:\n " .. err)
	game.Players.LocalPlayer.Events:FindFirstChild("NotifyFunctionEvent"):Invoke(
		err.."\n^\n|\nError",
		Color3.fromRGB(255, 0, 0)
	)
end


--Old Code? Eh...
--local Music = {
--	"Outside",
--	"Hotel",
--	"Cafe",
--	"Acrophobia",
--	"Summit",
--	"Spooy"
--}

--for _, region in ipairs(workspace.Regions:GetChildren()) do
--	if region:IsA("Folder") then
--		for _, part in ipairs(region:GetChildren()) do
--			if table.find(Music, part.Name) then
--				local sound = script:WaitForChild(part.Name, 60):Clone()
--				sound.Parent = part
--				sound.Looped = true
--				sound:Play()
--				--sound:Destroy()
--			end
--		end
--	end
--end
