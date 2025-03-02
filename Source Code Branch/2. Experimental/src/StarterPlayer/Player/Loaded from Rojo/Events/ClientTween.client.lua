--!strict
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = Client.Events

local success, err = pcall(function()
	Events.ClientTween.OnClientInvoke = function(instance:Instance, tweenInfo:{[number]:any}, propertyTable:{[string]:any}):Tween
		local Tween = TweenService:Create(instance, TweenInfo.new(table.unpack(tweenInfo)), propertyTable)
		task.spawn(function()
			Tween:Play()
		end)
		return Tween
	end
end)

if not success then
	print("Client error:\n " .. err)
end