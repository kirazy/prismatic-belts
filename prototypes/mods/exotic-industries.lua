local api = require("prototypes.api")

if not (mods["exotic-space-industries"] or mods["exotic-space-industries-remembrance"]) then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["ei-neo-belt"] = {
		logistics_technology = { name = "ei-neo-logistics" },
		belt_animation_set = {
			base_tint = util.color("#575769FF"),
			mask_tint = util.color("#C34DFFFF"),
			arrow_tint = util.color("#AC00E5FF"),
			tint_base_as_overlay = true,
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
