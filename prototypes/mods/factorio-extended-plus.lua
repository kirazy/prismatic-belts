local api = require("prototypes.api")

if not (mods["FactorioExtended-Plus-Transport"] or mods["FactorioExtended-Plus-Transport2"]) then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["rapid-transport-belt-mk1"] = {
		logistics_technology = {
			name = "logistics-4",
		},
		belt_animation_set = {
			mask_tint = util.color("#2CD529D1"),
		},
	},
	["rapid-transport-belt-mk2"] = {
		logistics_technology = {
			name = "logistics-5",
		},
		belt_animation_set = {
			mask_tint = util.color("#9A2CC9D1"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
