local api = require("prototypes.api")

if not mods["slow-belts-updated"] then
	return
end

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["slowest-belt"] = {
		belt_animation_set = {
			mask_tint = util.color("#DF8CBFFF"),
		},
	},
	["slower-belt"] = {
		belt_animation_set = {
			mask_tint = util.color("#DD9370FF"),
		},
	},
	["slow-belt"] = {
		belt_animation_set = {
			mask_tint = util.color("#6D77B9FF"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
