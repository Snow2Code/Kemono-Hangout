local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = ReplicatedStorage.Client
local Animations = Client.Assets.Animations
local Weapons = {
	["ActiveWeapons"] = {
		["nil"] = {
			["Weapon Name"] = "Unknown",
			["HasEquipAnimation"] = true,
			["Damage"] = 20,
			["Cooldown"] = 1,
			["Range"] = 10,
			["Can Ragdoll"] = false,
			["DetectVictimWait"] = 0.3,
			["Animations_R6"] = {
				["Idle"] = Animations["Weapon System"].R6.Idle,
				["Swing"] = Animations["Weapon System"].R6.Swing
			},
			["Animations_R15"] = {
				["Idle"] = Animations["Weapon System"].R15.Idle,
				["Swing"] = Animations["Weapon System"].R15.Swing
			}
		},
		["Shovel"] = {
			["Weapon Name"] = "Shovel",
			["HasEquipAnimation"] = true,
			["Damage"] = 20,
			["Cooldown"] = 1,
			["Range"] = 10,
			["Can Ragdoll"] = false,
			["DetectVictimWait"] = 0.3,
			["Animations_R6"] = {
				["Idle"] = Animations["Weapon System"].R6.Idle,
				["Swing"] = Animations["Weapon System"].R6.Swing
			},
			["Animations_R15"] = {
				["Idle"] = Animations["Weapon System"].R15.Idle,
				["Swing"] = Animations["Weapon System"].R15.Swing
			}
		},
		["Knife"] = {
			["Weapon Name"] = "Knife",
			["HasEquipAnimation"] = true,
			-- [[  Knife Old Damage: [1] = 20, [2] = 10  ]]
			["Damage"] = 20,
			["Cooldown"] = 2,-- 0.375,
			["Range"] = 9.5,
			["Can Ragdoll"] = false,
			["DetectVictimWait"] = 0.3,
			["Animations_R6"] = {
				["Idle"] = Animations["Weapon System"].R6["Idle - Knife"],
				["Swing_1"] = Animations["Weapon System"].R6["Swing - Knife 1"],
				["Swing_2"] = Animations["Weapon System"].R6["Swing - Knife 2"]
			},
			["Animations_R15"] = {
				["Idle"] = Animations["Weapon System"].R15["Idle - Knife"],
				["Swing_1"] = Animations["Weapon System"].R15["Swing - Knife 1"],
				["Swing_2"] = Animations["Weapon System"].R15["Swing - Knife 2"]
			}
		},
		["Frying Pan"] = {
			["Weapon Name"] = "Frying Pan",
			["HasEquipAnimation"] = true,
			-- [[  Knife Old Damage: [1] = 20, [2] = 10  ]]
			["Damage"] = 30,
			["Cooldown"] = 2,-- 0.375,
			["Range"] = 9.5,
			["Can Ragdoll"] = false,
			["DetectVictimWait"] = 0.3,
			["Animations_R6"] = {
				["Idle"] = Animations["Weapon System"].R6["Idle"],
				["Swing_1"] = Animations["Weapon System"].R6["Swing - Pan 1"],
				["Swing_2"] = Animations["Weapon System"].R6["Swing - Pan 2"]
			},
			["Animations_R15"] = {
				["Idle"] = Animations["Weapon System"].R15["Idle"],
				["Swing_1"] = Animations["Weapon System"].R15["Swing - Pan 1"],
				["Swing_2"] = Animations["Weapon System"].R15["Swing - Pan 2"]
			}
		},
		

		["Crowbar"] = {
			--swingids = {2156366946, 2156366946, 2156366946}
			--headshotids = {7025209172, 7025209359, 7025209663}
			["Weapon Name"] = "Crowbar",
			["HasEquipAnimation"] = true,
			-- [[  Knife Old Damage: [1] = 20, [2] = 10  ]]
			["Damage"] = 33,
			["Cooldown"] = 4,-- 0.375,
			["Range"] = 9.5,
			["Can Ragdoll"] = false,
			["DetectVictimWait"] = 0.3,
			["Animations_R6"] = {
				["Idle"] = Animations["Weapon System"].R6["Idle - Knife"],
				["Swing_1"] = Animations["Weapon System"].R6["Swing - Knife 1"],
				["Swing_2"] = Animations["Weapon System"].R6["Swing - Knife 2"]
			},
			["Animations_R15"] = {
				["Idle"] = Animations["Weapon System"].R15["Idle - Knife"],
				["Swing_1"] = Animations["Weapon System"].R15["Swing - Knife 1"],
				["Swing_2"] = Animations["Weapon System"].R15["Swing - Knife 2"]
			}
		},
		
		["Pencil Spear"] = {
			["Weapon Name"] = "Pencil Spear",
			["HasEquipAnimation"] = true,
			-- [[  Knife Old Damage: [1] = 20, [2] = 10  ]]
			["Damage"] = 20,
			["Cooldown"] = 3,-- 0.375,
			["Range"] = 15,
			["Can Ragdoll"] = true, -- Random chance to ragdoll victim (not are, should happen often)
			["DetectVictimWait"] = 0.3,
			["Animations_R6"] = {
				["Idle"] = Animations["Weapon System"].R6["Idle - Pencil Spear"],
				["Swing"] = Animations["Weapon System"].R6["Swing - Pencil Spear"],
			},
			["Animations_R15"] = {
				["Idle"] = Animations["Weapon System"].R15["Idle - Pencil Spear"],
				["Swing"] = Animations["Weapon System"].R15["Swing - Pencil Spear"],
			}
		},
		["Axe"] = {
			["Weapon Name"] = "Axe",
			["HasEquipAnimation"] = true,
			["Damage"] = 35,
			["Cooldown"] = 2.75,
			["Range"] = 10,
			["Can Ragdoll"] = false,
			["DetectVictimWait"] = 0.3,
			["Animations_R6"] = {
				["Idle"] = Animations["Weapon System"].R6["Idle - Axe"],
				["Swing"] = Animations["Weapon System"].R6["Swing - Axe"]
			},
			["Animations_R15"] = {
				["Idle"] = Animations["Weapon System"].R15["Idle - Axe"],
				["Swing"] = Animations["Weapon System"].R15["Swing - Axe"]
			}
		}
	}
}

function Weapons.SetupConfig(Weapon: Tool)
	if Weapons.ActiveWeapons[Weapon.Name] then
		local Config = Instance.new("Configuration", Weapon)
		Config.Name = "Config"

		for a, b in pairs(Weapons.ActiveWeapons[Weapon.Name]) do
			if not string.match(a, "Animations_") then
				local Setting
				
				if typeof(b) == "string" then
					Setting = Instance.new("StringValue")
				elseif typeof(b) == "boolean" then
					Setting = Instance.new("BoolValue")
				elseif typeof(b) == "number" then
					Setting = Instance.new("NumberValue")
				end
				
				Setting.Parent = Config
				Setting.Name = a
				Setting.Value = b
			end
		end
	else
		print("Failed to setup config for weapon.")
	end
end

function Weapons.GetWeapon(Weapon)
	if Weapons.ActiveWeapons[Weapon.Name] then
		return Weapons.ActiveWeapons[Weapon.Name]
	end
	return Weapons.ActiveWeapons["nil"]
end


return Weapons