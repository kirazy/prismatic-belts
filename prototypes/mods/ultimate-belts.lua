local api = require("prototypes.api")

if
	not (
		mods["UltimateBelts"]
		or mods["UltimateBeltsSpaceAge"]
		or mods["NovasUltimateBelts"]
		or mods["UltimateBeltsSpaceAgeFork"]
	)
then
	return
end

local default_base_tint = util.color("#404040FF")

---@type PrismaticBelts.TransportBeltIconInputs
local default_belt_icon = {
	use_three_arrow_variant = true,
}

---@type PrismaticBelts.TransportBeltInputsMapping
local transport_belt_inputs_map = {
	["ultra-fast-belt"] = {
		logistics_technology = {
			name = "ultra-fast-logistics",
		},
		belt_icon = default_belt_icon,
		belt_animation_set = {
			base_tint = default_base_tint,
			mask_tint = util.color("#00B30CFF"),
		},
		forced_connectable_belt_entities = {
			{ name = "ultra-fast-splitter", type_name = "splitter" },
		},
	},
	["extreme-fast-belt"] = {
		logistics_technology = {
			name = "extreme-fast-logistics",
			arrow_tint = { 0.2, 0.2, 0.2, 0 },
		},
		belt_icon = util.merge({ default_belt_icon, { arrow_tint = { 0.2, 0.2, 0.2, 0 } } }),
		belt_animation_set = {
			base_tint = default_base_tint,
			mask_tint = util.color("#E00000FF"),
			arrow_tint = util.color("#555555FF"),
		},
	},
	["ultra-express-belt"] = {
		logistics_technology = {
			name = "ultra-express-logistics",
			arrow_tint = { 0.2, 0.2, 0.2, 0 },
		},
		belt_icon = util.merge({ default_belt_icon, { arrow_tint = { 0.2, 0.2, 0.2, 0 } } }),
		belt_animation_set = {
			base_tint = default_base_tint,
			mask_tint = util.color("#3604B5E8"),
			arrow_tint = util.color("#555555FF"),
		},
	},
	["extreme-express-belt"] = {
		logistics_technology = {
			name = "extreme-express-logistics",
			arrow_tint = { 0.2, 0.2, 0.2, 0 },
		},
		belt_icon = util.merge({ default_belt_icon, { arrow_tint = { 0.2, 0.2, 0.2, 0 } } }),
		belt_animation_set = {
			base_tint = default_base_tint,
			mask_tint = util.color("#002BFFFF"),
			arrow_tint = util.color("#555555FF"),
		},
	},
	["ultimate-belt"] = {
		logistics_technology = {
			name = "ultimate-logistics",
		},
		belt_icon = default_belt_icon,
		belt_animation_set = {
			base_tint = default_base_tint,
			mask_tint = util.color("#00FFDDD1"),
		},
		forced_connectable_belt_entities = {
			{ name = "original-ultimate-splitter", type_name = "splitter" },
			{ name = "original-ultimate-underground-belt", type_name = "underground-belt" },
		},
	},
	["original-ultimate-belt"] = {
		logistics_technology = {
			name = "original-ultimate-logistics",
		},
		belt_icon = default_belt_icon,
		belt_animation_set = {
			base_tint = default_base_tint,
			mask_tint = util.color("#00FFDDD1"),
		},
	},
}

api.transform_belts_and_related_connectables(transport_belt_inputs_map)
