-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage:WaitForChild("Client")
local Events = Client:WaitForChild("Events")

Events.ServerWarn.OnServerEvent:Connect(function(_script_, message)
    warn(`[Client to Server]\nFile: {_script_.Name}\n\nMessage:\n{message}\n`)
end)