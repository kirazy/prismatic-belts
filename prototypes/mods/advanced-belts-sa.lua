local api = require("prototypes.api")

if not mods["AdvancedBeltsSA"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["extreme-belt"] = {
		logistics_technology = {
			name = "extreme-logistics",
		},
		belt_animation_set = {
			mask_tint = util.color("#2BFFE6FF"),
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
	["high-speed-belt"] = {
		logistics_technology = {
			name = "high-speed-logistics",
		},
		belt_animation_set = {
			mask_tint = util.color("#F12BFFFF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
