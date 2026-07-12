local api = require("prototypes.api")

if not mods["iper-belt"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["iper-transport-belt"] = {
		logistics_technology = {
			name = "iper-transport-belts",
		},
		belt_animation_set = {
			mask_tint = util.color("#5D65D9FF"),
			arrow_tint = util.color("#2B3DF1FF"),
		},
		belt_icon = {
			arrow_tint = util.color("#a6acffFF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
