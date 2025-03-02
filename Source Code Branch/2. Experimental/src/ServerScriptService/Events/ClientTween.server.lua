-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client:WaitForChild("Events")

Events.ClientTween.OnServerInvoke = function(instance, tweenInfo, propertyTable, yield)
	if instance == nil then return end
	local PlayerList = Players:GetPlayers()
	for count=1, #PlayerList do
		task.spawn(function()
			Events:WaitForChild("ClientTween"):InvokeClient(PlayerList[count], instance, tweenInfo, propertyTable)
		end)	
	end

	task.delay(tweenInfo[1] or 1, function()
		for k,v in next, propertyTable do
			pcall(function()
				instance[k] = v
			end)
		end
	end)

	if yield then
		task.wait(tweenInfo[1] or 1)
	end
end