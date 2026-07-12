local api = require("prototypes.api")

if not mods["RandomFactorioThings"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["nuclear-transport-belt"] = {
		logistics_technology = {
			name = "nuclear-logistics",
		},
		belt_animation_set = {
			mask_tint = util.color("#00FF00FF"),
		},
	},
	["plutonium-transport-belt"] = {
		logistics_technology = {
			name = "plutonium-logistics",
		},
		belt_animation_set = {
			mask_tint = util.color("#00E1FFDE"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
