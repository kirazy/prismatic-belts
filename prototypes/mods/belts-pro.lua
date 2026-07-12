local api = require("prototypes.api")

if not mods["Belts_Pro"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["advanced-transport-belt"] = {
		belt_animation_set = {
			mask_tint = util.color("#62E856FF"),
		},
	},
	["superior-transport-belt"] = {
		logistics_technology = {
			name = "superior-belts",
			structure_tint = util.color("#AA00CCFF"),
		},
		belt_animation_set = {
			mask_tint = util.color("#DE66FFFF"),
		},
	},
	["ultrasuperior-transport-belt"] = {
		logistics_technology = {
			name = "ultrasuperior-belts",
			structure_tint = util.color("#FF0080FF"),
		},
		belt_animation_set = {
			mask_tint = util.color("#CC3380FF"),
			arrow_tint = util.color("#FD0071FF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
