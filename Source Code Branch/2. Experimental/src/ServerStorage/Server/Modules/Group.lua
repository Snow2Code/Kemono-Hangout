local module = {}
local GroupID = 32066692

function module.GetRank(player, _type)
	if player:IsInGroup(GroupID) then
		local Rank = player:GetRankInGroup(GroupID)
		
		if _type == "Number" or _type == nil then
			return Rank
		else
			return game:GetService("GroupService"):GetRankNameInGroup(GroupID, Rank)
		end
	else
		if _type == "Number" or _type == nil then
			return 0
		else
			return "Guest"
		end
	end
end

function module.CheckRank(player:Player)
	if player:IsInGroup(GroupID) then
		local Rank = player:GetRankInGroup(GroupID)
		local HasVIF = game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 730933732)
		local this

		--this = {["Rank"] = "", ["Team"] = game.Teams[""]}
		if Rank == 0 then
			if HasVIF then
				this = {["Rank"] = "VIF🐾", ["Team"] = game.Teams["VIF"]}
			else
				this = {["Rank"] = "Guest", ["Team"] = game.Teams["Guest"]}
			end
		elseif Rank == 1 then -- Member 🐾
			if HasVIF then
				this = {["Rank"] = "Member 🐾", ["Team"] = game.Teams["VIF"]}
			else
				this = {["Rank"] = "Member 🐾", ["Team"] = game.Teams["Members"]}
			end
		elseif Rank == 2 then -- Donator 💸
			if HasVIF then
				this = {["Rank"] = "Donator 💸", ["Team"] = game.Teams["VIF"]}
			else
				this = {["Rank"] = "Donator 💸", ["Team"] = game.Teams["Members"]}
			end
		elseif Rank == 3 then -- Known ✨
			if HasVIF then
				this = {["Rank"] = "Known ✨", ["Team"] = game.Teams["VIF"]}
			else
				this = {["Rank"] = "Known ✨", ["Team"] = game.Teams["Members"]}
			end
		elseif Rank == 4 then -- Known 💖
			this = {["Rank"] = "Known 💖", ["Team"] = game.Teams["VIF"]} --this = {["Rank"] = "", ["Team"] = game.Teams["Members"]}
		elseif Rank == 5 then -- VIF🐾
			this = {["Rank"] = "VIF🐾", ["Team"] = game.Teams["VIF"]}
		elseif Rank > 100 and Rank < 200 then
			this = {["Rank"] = player:GetRoleInGroup(GroupID), ["Team"] = game.Teams["Staff"]}
			if Rank == 102 then
				this = {["Rank"] = player:GetRoleInGroup(GroupID), ["Team"] = game.Teams["Head Staff"]}
			elseif Rank > 103 and Rank < 200 then
				this = {["Rank"] = player:GetRoleInGroup(GroupID), ["Team"] = game.Teams["Head Staff"]}
			end
		elseif Rank > 200 then
			this = {["Rank"] = player:GetRoleInGroup(GroupID), ["Team"] = game.Teams["Head Staff"]}
		end
		return this
	else
		return {["Rank"] = "Guest", ["Team"] = game.Teams["Guest"]}
	end
end

return module
