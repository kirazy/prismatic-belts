local api = require("prototypes.api")

if not (mods["promethium-belts"] or mods["promethium-belts-rebalance"]) then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["promethium-transport-belt"] = {
		logistics_technology = {
			name = "promethium-transport-belt",
			structure_tint = util.color("#FF1AF4FF"),
		},
		belt_animation_set = {
			mask_tint = util.color("#DD5FC1FF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
