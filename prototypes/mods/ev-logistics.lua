local api = require("prototypes.api")

if not mods["ev-logistics"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["hyper-transport-belt"] = {
		logistics_technology = {
			name = "hyper-logistics",
			arrow_tint = util.color("#A673F2FF"),
		},
		belt_animation_set = {
			mask_tint = util.color("#9753f6FF"),
			arrow_tint = util.color("#6302f1FF"),
		},
		belt_icon = {
			arrow_tint = util.color("#A673F2FF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
