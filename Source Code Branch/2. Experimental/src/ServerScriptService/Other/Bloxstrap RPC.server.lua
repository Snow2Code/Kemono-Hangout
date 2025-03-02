-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ServerStorage = game:GetService("ServerStorage")
local Server = ServerStorage.Server
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Events = {--[[  ["Server"] = Server.Events,  ]] ["Client"] = Client.Events}

local BloxstrapRC = require(Server.Modules.BloxstrapRPC)

--BloxstrapRC.
