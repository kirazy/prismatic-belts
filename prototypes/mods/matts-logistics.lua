local api = require("prototypes.api")

if not mods["matts-logistics"] then
	return
end

local default_animation_set = {
	base_tint = util.color("#737373FF"),
	tint_base_as_overlay = false,
}

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["ultra-fast-transport-belt"] = {
		logistics_technology = {
			name = "logistics-4",
		},
		belt_animation_set = util.merge({
			default_animation_set,
			{
				mask_tint = util.color("#74CC66FF"),
			},
		}),
	},
	["extreme-fast-transport-belt"] = {
		logistics_technology = {
			name = "logistics-5",
		},
		belt_animation_set = util.merge({
			default_animation_set,
			{
				mask_tint = util.color("#CC7E66FF"),
			},
		}),
	},
	["ultra-express-transport-belt"] = {
		logistics_technology = {
			name = "logistics-6",
		},
		belt_animation_set = util.merge({
			default_animation_set,
			{
				mask_tint = util.color("#8F66CCFF"),
			},
		}),
	},
	["extreme-express-transport-belt"] = {
		logistics_technology = {
			name = "logistics-7",
		},
		belt_animation_set = util.merge({
			default_animation_set,
			{
				mask_tint = util.color("#667ACCFF"),
			},
		}),
	},
	["ultimate-transport-belt"] = {
		logistics_technology = {
			name = "logistics-8",
		},
		belt_animation_set = util.merge({
			default_animation_set,
			{
				mask_tint = util.color("#737373FF"),
				arrow_tint = util.color("#B3B3B3FF"),
			},
		}),
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
