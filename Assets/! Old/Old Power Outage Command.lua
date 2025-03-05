Special.PowerInterruption.OnServerEvent:Connect(function(client, values)
	if Engine:CheckIfUserIsTrusted(client) then
		local offon = values[1]
		local sound = values[2]

		local ran, failmsg = pcall(function()
			-- Hey it's Lyn here. The coder.
			-- This was planned to be every 40-60 minutes but I changed my mind about that so it's now
			-- owner only triggerable.
			--// Lyn
			if offon == "start" then
				if ServerStore.Game.PL_Active.Value == false then
					ServerStore.Game.PL_Active.Value = true
					--local random_wait = math.random(#times)
					--wait(random_wait)
					local TurnOffSfx = Instance.new("Sound",workspace.Temp)
					TurnOffSfx.Name = "MusicPowerInterrupt"
					local a = math.random(1, 3)
					--TurnOffSfx.SoundId = "rbxassetid://"..math.random(#music)
					if a == 1 then
						TurnOffSfx.SoundId = "rbxassetid://15968226430"
					elseif a == 2 then
						TurnOffSfx.SoundId = "rbxassetid://16477319266"
					elseif a == 3 then
						TurnOffSfx.SoundId = "rbxassetid://15968224871"
					else
						TurnOffSfx.SoundId = "rbxassetid://15968226430"
					end
					TurnOffSfx.Volume = 0.3
					TurnOffSfx.Looped = true
					InterruptLights("TurnOff")
					workspace.Temp.StartPL:Play()
					Notify("nil", "Sudden disturbance power grid detected.", "FireAll") wait(2) --print is old
					Notify("nil", "Unable to initiate Emergency Power grid.", "FireAll") wait(2)
					Notify("nil", "Please stand by...", "FireAll")
					wait(3)
					TurnOffSfx:Play()
					--wait(750)
					--InterruptLights("TurnOn")
				end
			elseif offon == "stop" then
				if ServerStore.Game.PL_Active.Value ~= false then
					InterruptLights("TurnOn")
					workspace.Temp.LightsOn:Play()
					if workspace.Temp.MusicPowerInterrupt then
						workspace.Temp.MusicPowerInterrupt:Destroy()
					end
					ServerStore.Game.PL_Active.Value = false
					Notify("nil", "Power grid has been initiated", "FireAll")
				end
			end
			--end
		end)
		if not ran then
			print("Remote Error:\n"..failmsg)
		end
	end
end)