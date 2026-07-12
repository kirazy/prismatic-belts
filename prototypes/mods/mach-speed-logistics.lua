local api = require("prototypes.api")

if not mods["mach-speed-logistics"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["mach-transport-belt"] = {
		logistics_technology = {
			name = "mach-speed-logistics",
			structure_tint = util.color("#B800CCFF"),
		},
		belt_animation_set = {
			base_tint = util.color("#404040FF"),
			mask_tint = util.color("#A11EABD1"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
