local api = require("prototypes.api")

if not mods["wood-logistics"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["wood-transport-belt"] = {
		logistics_technology = {
			name = "wood-logistics",
			structure_tint = util.color("#A15A40FF"),
			arrow_tint = util.color("#AE7E6AFF"),
		},
		belt_animation_set = {
			mask_tint = util.color("#AE7E6AFF"),
			arrow_tint = util.color("#864828FF"),
			arrow_blend_mode = "normal",
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
