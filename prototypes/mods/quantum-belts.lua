local api = require("prototypes.api")

if not mods["quantum-belts"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["quantum-belt"] = {
		logistics_technology = { name = "quantum-logistics" },
		belt_animation_set = {
			mask_tint = util.color("#D92EE5FF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
