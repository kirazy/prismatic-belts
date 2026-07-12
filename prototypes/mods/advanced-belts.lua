local api = require("prototypes.api")

if not mods["AdvancedBeltsUpdated"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["elite-belt"] = {
		logistics_technology = {
			name = "elite-logistics",
		},
		belt_animation_set = {
			mask_tint = util.color("#2DEB2DFF"),
		},
	},
	["extreme-belt"] = {
		logistics_technology = {
			name = "extreme-logistics",
		},
		belt_animation_set = {
			mask_tint = util.color("#2BFFE6FF"),
		},
	},
	["supreme-belt"] = {
		logistics_technology = {
			name = "supreme-logistics",
		},
		belt_animation_set = {
			mask_tint = util.color("#F12BFFFF"),
		},
	},
	["ultimate-belt"] = {
		logistics_technology = {
			name = "ultimate-logistics",
		},
		belt_animation_set = {
			mask_tint = util.color("#FF7F4DFF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
