local api = require("prototypes.api")

if not mods["beyond-belts"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["bb-hyper-belt"] = {
		logistics_technology = { name = "bb-hyper-logistics" },
		belt_animation_set = {
			mask_tint = util.color("#2EE5D0FF"),
		},
	},
	["bb-extreme-belt"] = {
		logistics_technology = { name = "bb-extreme-logistics" },
		belt_animation_set = {
			mask_tint = util.color("#FF7040FF"),
		},
	},
	["bb-ultimate-belt"] = {
		logistics_technology = { name = "bb-ultimate-logistics" },
		belt_animation_set = {
			mask_tint = util.color("#F04DFFFF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
