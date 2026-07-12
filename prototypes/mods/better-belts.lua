local api = require("prototypes.api")

if not mods["BetterBelts"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["BetterBelts_ultra-transport-belt"] = {
		logistics_technology = {
			name = "BetterBelts_ultra-class",
			structure_tint = util.color("#14CC14FF"),
		},
		belt_animation_set = {
			mask_tint = util.color("#40CB4AFF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
