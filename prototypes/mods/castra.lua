local api = require("prototypes.api")

if not mods["castra"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["military-transport-belt"] = {
		logistics_technology = {
			name = "military-transport-belt",
			base_tint = util.color("#DEDCF5FF"),
		},
		belt_icon = {
			base_tint = util.color("#DEDCF5FF"),
		},
		belt_animation_set = {
			base_tint = util.color("#6B6A75FF"),
			mask_tint = util.color("#B37D47FF"),
			tint_base_as_overlay = true,
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
