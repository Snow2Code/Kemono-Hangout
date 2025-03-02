local InputService = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local CodeFolder = script.Parent
local _UI_ = CodeFolder.Parent
local Frame = _UI_:WaitForChild("Notifications")
local Temp = Frame:WaitForChild("Template")
local Gamepad = true

local Func = script.Parent.NotifyFunction

while not Player:FindFirstChild("Events") do 
	wait() 
end
local ServerEvent = Player.Events:FindFirstChild("NotifyEvent")
while not ServerEvent do 
	wait()
	ServerEvent = Player.Events:FindFirstChild("NotifyEvent")
end
local ServerFunEvent = Player.Events:FindFirstChild("NotifyFunctionEvent")
while not ServerFunEvent do 
	wait()
	ServerFunEvent = Player.Events:FindFirstChild("NotifyFunctionEvent")
end
local MessageEvent = Player.Events:FindFirstChild("MessageEvent")
while not MessageEvent do 
	wait()
	MessageEvent = Player.Events:FindFirstChild("MessageEvent")
end

local function NewNotification(Message, Color)
	--local Label = Frame:GetChildren()
	--for i = 1, #Label do
	--	if Label[i].ClassName == "TextLabel" and Label[i].Name ~= "Template" then
	--		Label[i].Desired.Value = Label[i].Desired.Value - 20
	--		Label[i]:TweenPosition(UDim2.new(0, 0, 0, Label[i].Desired.Value), "InOut", "Quad", 0.5, true)
	--	end
	--end
	--local New = Temp:Clone()
	--New.Name = "Label"
	--New.Parent = Frame
	--New.Text = Message
	--New.TextColor3 = Color
	--New.Position = UDim2.new(0, 0, 1, -20)
	--New:TweenPosition(UDim2.new(0, 0, 0, 0), "InOut", "Quad", 0.5, true)
	--New.Visible = true
	local Label = Frame:GetChildren()
	for i=1,#Label do
		if Label[i].ClassName == "TextLabel" and Label[i].Name ~= "Template" then
			Label[i].Desired.Value = Label[i].Desired.Value + 20
			Label[i]:TweenPosition(UDim2.new(0,0,0,Label[i].Desired.Value),"InOut","Quad",0.5,true)
		end
	end
	local New = Temp:Clone()
	New.Name = "Label"
	New.Parent = Frame
	New.Text = Message
	New.TextColor3 = Color
	New.Position = UDim2.new(0,0,0,-20)
	New:TweenPosition(UDim2.new(0,0,0,0),"InOut","Quad",0.5,true)
	New.Visible = true
end

function Func.OnInvoke(Message, Color)
	NewNotification(Message, Color)
end

ServerEvent.OnClientEvent:connect(function(Message, Color)
	NewNotification(Message, Color)
end)

ServerFunEvent.OnInvoke = function(Message, Color)
	NewNotification(Message, Color)
end

MessageEvent.OnClientEvent:connect(function(Message)
	print("Received server message")
	NewNotification(Message, Color3.new(0, 170/255, 1))
	NewNotification("SERVER MESSAGE", Color3.new(0, 170/255, 1))
end)

local Counter = 0
while wait(0.1) do
	Counter = Counter + 0.1

	local Label = Frame:GetChildren()
	for i=1,#Label do
		if Label[i].ClassName == "TextLabel" and Label[i].Name ~= "Template" then
			if Label[i].Time.Value > 0 and Counter >= 1 then
				--Count counter
				Label[i].Time.Value = Label[i].Time.Value - 1
			elseif Label[i].Time.Value <= 0 then
				--Fade
				Label[i].TextTransparency = Label[i].TextTransparency + 0.1
				Label[i].TextStrokeTransparency = Label[i].TextStrokeTransparency + 0.1
				if Label[i].TextTransparency >= 1 then
					Label[i]:remove()
				end
			end
		end
	end

	if Counter >= 1 then
		Counter = Counter - 1
	end
end