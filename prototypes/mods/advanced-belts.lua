local api = require("prototypes.api")
local sprite_utils = { colors = require("__reskins-sprite-utils__.colors") }

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
			mask_tint = sprite_utils.colors.from_argb("FFFFFFFF"),
		},
	},
	["extreme-belt"] = {
		logistics_technology = {
			name = "extreme-logistics",
		},
		belt_animation_set = {
			mask_tint = sprite_utils.colors.from_argb("FFFFFFFF"),
		},
	},
	["supreme-belt"] = {
		logistics_technology = {
			name = "supreme-logistics",
		},
		belt_animation_set = {
			mask_tint = sprite_utils.colors.from_argb("FFFFFFFF"),
		},
	},
	["ultimate-belt"] = {
		logistics_technology = {
			name = "ultimate-logistics",
		},
		belt_animation_set = {
			mask_tint = sprite_utils.colors.from_argb("FFFFFFFF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
