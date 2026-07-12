local api = require("prototypes.api")

if not mods["5dim_transport"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["5d-transport-belt-04"] = {
		logistics_technology = {
			name = "logistics-4",
		},
		belt_animation_set = {
			mask_tint = util.color("#FFA8F9FF"),
		},
	},
	["5d-transport-belt-05"] = {
		logistics_technology = {
			name = "logistics-5",
		},
		belt_animation_set = {
			mask_tint = util.color("#58FF4FFF"),
		},
	},
	["5d-transport-belt-06"] = {
		logistics_technology = {
			name = "logistics-6",
		},
		belt_animation_set = {
			mask_tint = util.color("#B18E77FF"),
		},
	},
	["5d-transport-belt-07"] = {
		logistics_technology = {
			name = "logistics-7",
		},
		belt_animation_set = {
			mask_tint = util.color("#A168C7FF"),
		},
	},
	["5d-transport-belt-08"] = {
		logistics_technology = {
			name = "logistics-8",
		},
		belt_animation_set = {
			mask_tint = util.color("#CDCDCBFF"),
		},
	},
	["5d-transport-belt-09"] = {
		logistics_technology = {
			name = "logistics-9",
		},
		belt_animation_set = {
			mask_tint = util.color("#FF9736FF"),
		},
	},
	["5d-transport-belt-10"] = {
		logistics_technology = {
			name = "logistics-10",
		},
		belt_animation_set = {
			mask_tint = util.color("#9A9BFFFF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
