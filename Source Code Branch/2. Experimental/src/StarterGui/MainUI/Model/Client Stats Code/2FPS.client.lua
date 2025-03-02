local success, err = pcall(function()
	local RunService = game:GetService("RunService")
	local ui = script.Parent.Parent
	local fps = 0

	task.spawn(function() -- FPS
		local TimeFun = RunService:IsRunning() and time or os.clock()
		local start, LastInterat
		local FUpdate = {}
		local function heartbeat()
			LastInterat = TimeFun()
			for index = #FUpdate, 1, -1 do
				FUpdate[index + 1] = FUpdate[index] >= LastInterat -1 and FUpdate[index] or nil
			end
			FUpdate[1] = LastInterat
			fps = math.floor(TimeFun() - start >= 1 and #FUpdate or #FUpdate / (TimeFun() - start))
			ui.ClientStats["2. FPS"].Text = "FPS: "..fps
		end
		start = TimeFun()
		RunService.Heartbeat:Connect(heartbeat)
	end)
end)

if not success then
	print("Client error:\n " .. err)
	game.Players.LocalPlayer.Events:FindFirstChild("NotifyFunctionEvent"):Invoke(
	err.."\n^\n|\nError",
	Color3.fromRGB(255, 0, 0)
	)
end