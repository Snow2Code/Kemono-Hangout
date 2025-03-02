-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///


-- \\ Services and Dependencies.
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Server = ServerStorage.Server
local Client = ReplicatedStorage.Client

local Events = {--[[ ["Server"] = Server:WaitForChild("Events"), ]] ["Client"] = Client:WaitForChild("Events") }
local Modules = {["Server"] = Server:WaitForChild("Modules"), ["Client"] = Client:WaitForChild("Modules") }

local Engine = require(Modules.Server.Engine)
local Engine2 = require(Modules.Server.Engine2)


-- \\ Samples

--[[
Purpose: 
]]
function LorenIpsum()

end


-- \\ Comments

-- Sample comment
--\\ Sample Commment                (can be -- \\ or --\\)
--\\ Sample Comment //              (simpilar to the one above.)

-- TODO: Sample                     (Can be "--", "--\\" or "-- \\")
-- FIXME: Sample                    (Similar to the one above)