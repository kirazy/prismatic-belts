local api = require("prototypes.api")

if not mods["factorioplus"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["basic-transport-belt"] = {
		logistics_technology = { name = "logistics-basic" },
		belt_animation_set = {
			mask_tint = util.color("#7D7D7DD1"),
		},
	},
	["turbo-transport-belt"] = {
		logistics_technology = { name = "logistics-4" },
		belt_animation_set = {
			mask_tint = util.color("#8AE58AFF"),
		},
	},
	["supersonic-transport-belt"] = {
		logistics_technology = { name = "logistics-5" },
		belt_animation_set = {
			mask_tint = util.color("#CC8BE4FF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
