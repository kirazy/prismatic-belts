local api = require("prototypes.api")

if not mods["periodic-madness"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["transport-belt"] = {
		preset = api.defines.belt_presets.standard,
		logistics_technology_name = "logistics",
	},
	["fast-transport-belt"] = {
		logistics_technology = {
			name = "logistics-2",
			structure_tint = util.color("#ff4000FF"),
		},
		belt_animation_set = {
			mask_tint = util.color("#f36f37d1"),
		},
	},
	["pm-advanced-transport-belt"] = {
		preset = api.defines.belt_presets.fast,
		logistics_technology_name = "logistics-3",
	},
	["express-transport-belt"] = {
		belt_animation_set = {
			mask_tint = util.color("#33b4ffFF"),
		},
		logistics_technology = {
			name = "pm-logistics-4",
		},
	},
	["pm-high-density-transport-belt"] = {
		logistics_technology = {
			name = "pm-logistics-5",
			structure_tint = util.color("#7b4cd9FF"),
		},
		belt_animation_set = {
			mask_tint = util.color("#d480ffd1"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
