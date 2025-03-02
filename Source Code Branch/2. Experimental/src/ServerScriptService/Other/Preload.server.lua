-- \\\ Copyright fuzzy_james and 0llie_kitty at Kemono Universe, All rights reserved. ///
-- \\
-- \\ Purpose: 
-- \\
-- \\\	///

local ContentProvider = game:GetService("ContentProvider")

local assets = {
	--game.Workspace,
	--game.ReplicatedStorage,
	game.ServerStorage.Server,
}

-- This will be hit as each asset resolves
local callback = function(assetId, assetFetchStatus)
	--print("< SERVER > PreloadAsync() resolved asset ID:", assetId)
	--print("< SERVER > PreloadAsync() final AssetFetchStatus:", assetFetchStatus)
end

-- Preload the content and time it
local startTime = os.clock()
ContentProvider:PreloadAsync(assets, callback)

local deltaTime = os.clock() - startTime
print(("Preloading complete, took %.2f seconds"):format(deltaTime))