local abs, pi, sin, asin, acos, sign, deg, rad, clamp = math.abs, math.pi, math.sin, math.asin, math.acos, math.sign, math.deg, math.rad, math.clamp 

local startAxis = Vector2.new(1, 0)
local barOffset = 36

local Frame = script.Parent.Frame
local ColorWheel = script.Parent.ColorWheel
local ColorWheel_Radius = ColorWheel.AbsoluteSize/2
local ColorWheel_Cursor = ColorWheel.Cursor
local ValueSelector = script.Parent.ValueSelector

function setColor(newColor)
	Frame.BackgroundColor3 = newColor
end

local function updateValueSelector(newColor)
	ValueSelector.BackgroundColor3 = newColor
end

local function getValue()
	return ValueSelector:GetAttribute("Value") or 1
end

local function getColorbyVector(vector: Vector2)
	
	local cosVector, sinVector = startAxis:Dot(vector.Unit), startAxis:Cross(vector.Unit)
	local arcCosVector, arcSinVector = acos(cosVector), asin(sinVector)
	
	if sign(arcSinVector) <= 0 then
		arcCosVector = rad(deg(2*pi) - deg(arcCosVector))
	end
	
	local hue: number = deg(arcCosVector)/360
	
	local saturation: number = clamp((vector.Magnitude/(ColorWheel_Radius.Magnitude))/sin(rad(45)), 0, 1)
	
	local value: number = getValue()
	
	local color = Color3.fromHSV(hue, saturation, value)
	return color
end

local function selectNewColor(x, y)
	local SizeOffet = ColorWheel.AbsoluteSize/2
	local ColorWheelOffset: Vector2 = ColorWheel.AbsolutePosition + SizeOffet

	local position: Vector2 = (Vector2.new(x, y - barOffset) - ColorWheelOffset)
	
	local relativePosition: Vector2 = position + ColorWheel_Radius
	
	if position.Magnitude >= ColorWheel_Radius.X then
		position = position.Unit * ColorWheel_Radius.X
		relativePosition = position + ColorWheel_Radius
	end
	
	local rx, ry = relativePosition.X, relativePosition.Y
	ColorWheel_Cursor.Position = UDim2.fromOffset(rx, ry)
	
	position = Vector2.new(position.X, -position.Y)
	
	setColor(getColorbyVector(position))
	ColorWheel:SetAttribute("LastVector", position)
end

ColorWheel.MouseButton1Down:Connect(function(x, y)
	local movedConnection
	local leaveConnection
	local upConnection
	
	movedConnection = ColorWheel.MouseMoved:Connect(selectNewColor)
	
	local function disconnect(x, y)
		selectNewColor(x, y)
		
		movedConnection:Disconnect()
		leaveConnection:Disconnect()
		upConnection:Disconnect()
	end
	leaveConnection = ColorWheel.MouseLeave:Connect(disconnect)
	upConnection = ColorWheel.MouseButton1Up:Connect(disconnect)
	
	selectNewColor(x, y)
end)


local function setNewValue(_,y)
	local ratio = (y - ValueSelector.AbsolutePosition.Y - 36)/ValueSelector.AbsoluteSize.Y
	ratio = math.clamp(ratio, 0, 1)
	ValueSelector:SetAttribute("Value", 1-ratio)
	ColorWheel.ImageColor3 = Color3.fromRGB(255 * (1-ratio), 255 * (1-ratio), 255 * (1-ratio))
	
	local lastVector = ColorWheel:GetAttribute("LastVector")
	if lastVector then
		setColor(getColorbyVector(lastVector))
	end
	
	ValueSelector.Cursor.Position = UDim2.new(0, 0, ratio, 0)
end

ValueSelector.MouseButton1Down:Connect(function(_, y)
	
	local movedConnection
	local leaveConnection
	local upConnection
	
	movedConnection = ValueSelector.MouseMoved:Connect(setNewValue)
	
	local function disconnect(_, y)
		setNewValue(nil, y)
		
		movedConnection:Disconnect()
		leaveConnection:Disconnect()
		upConnection:Disconnect()
	end
	leaveConnection = ValueSelector.MouseLeave:Connect(disconnect)
	upConnection = ValueSelector.MouseButton1Up:Connect(disconnect)
	
	setNewValue(nil, y)
end)

script.Parent.Parent.Update.MouseButton1Click:Connect(function() script.Parent.eventthing:Fire(script.Parent.Frame.BackgroundColor3) end)