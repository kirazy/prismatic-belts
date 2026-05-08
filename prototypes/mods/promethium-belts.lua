local api = require("prototypes.api")
local sprite_utils = { colors = require("__reskins-sprite-utils__.colors") }

if not mods["promethium-belts"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["promethium-transport-belt"] = {
		logistics_technology = {
			name = "promethium-transport-belt",
		},
		belt_animation_set = {
			mask_tint = sprite_utils.colors.from_argb("FFDD5FC1"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
