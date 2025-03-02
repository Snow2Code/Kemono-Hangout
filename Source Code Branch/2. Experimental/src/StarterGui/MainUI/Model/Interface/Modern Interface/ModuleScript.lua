local module = {}
local scrn = script.Parent.Parent.UpdateScreen
local blckScrn = script.Parent.Parent.UpdateScreenBlack
local textTable = {
	[1] = "I wonder what awaits.",
	[2] = "I need to rethink and analyze.",
	[3] = "Not everyone is around to help.",
	[4] = "Life is strange, life is bizzare!",
	[5] = "Learning never exhausts the mind.",
	[6] = "No one is around to help.",
	[7] = "Life is hard, life is stressful.",
	[8] = "I need peace and tranquitity.",
	[9] = "I don't have to prove myself to anyone."
}
local music = {
	[1] = "Incoming Update",
	[2] = "Irresponsible Update",
	[3] = "Past Update",
	[4] = "Update Screen",
	[5] = "Progress Pulse",
}
local tweenSer = game:GetService("TweenService")
local textUpdate = {
	scrn.RefreshText,
	scrn.RefreshText1,
	scrn.RefreshText2,
	scrn.RefreshText3,
	scrn.RefreshText4
}

function module.UpdateText(text)
	--tween:Create(script.Parent.RefreshText, info, {Text = text[math.random(1,3)]}):Play()
	--local randomText = text[math.random(1,3)]
	--if text > 0 then
	for i = 1, #text, 1 do
		script.Parent.Parent.UpdateScreen.RefreshText.Text = string.sub(text,1,i)
		script.Parent.Parent.UpdateScreen.RefreshText1.Text = string.sub(text,1,i)
		script.Parent.Parent.UpdateScreen.RefreshText2.Text = string.sub(text,1,i)
		script.Parent.Parent.UpdateScreen.RefreshText3.Text = string.sub(text,1,i)
		script.Parent.Parent.UpdateScreen.RefreshText4.Text = string.sub(text,1,i)
		--script:FindFirstChild("Type"):Play() --Removed. Keeping just in case
		wait(0.05)
	end
	--else

	--end
end

function module.RandomText()
	return textTable[math.random(1,9)]
end

function module.RandomMusic(startstop)
	local musicChoice = music[math.random(#music)]
	if startstop == "Start" then
		script.Parent.Update:WaitForChild(musicChoice):Play()
	elseif startstop == "Stop" then
		script.Parent.Update:WaitForChild(musicChoice):Stop()
	end
end

return module
