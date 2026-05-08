local api = require("prototypes.api")
local meld = require("meld")
local sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

if not mods["space-age"] then
	return
end

-- Setup belt animation sets for space-age entities.
---@type { [data.EntityID] : data.TransportBeltAnimationSetWithCorners }
local belt_animation_sets = {
	["turbo-transport-belt"] = {
		alternate = true,
		animation_set = {
			filename = "__prismatic-belts__/graphics/entity/space-age/turbo-transport-belt/turbo-transport-belt.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
			frame_count = 64,
			direction_count = 20,
		},
		frozen_patch = api.get_transport_belt_frozen_patch(api.defines.belt_sprites.turbo),
	},
}

-- Add belt reader sprites.
meld(belt_animation_sets["turbo-transport-belt"], belt_reader_gfx)

local transport_belts = {
	["turbo-transport-belt"] = { logistics_technology = "turbo-transport-belt" },
}

for name, options in pairs(transport_belts) do
	local entity = data.raw["transport-belt"][name]
	if not entity then
		goto continue
	end

	---@type DeferrableIconData
	local deferrable_icon = {
		name = entity.name,
		type_name = entity.type,
		icon_data = {
			{
				icon = "__prismatic-belts__/graphics/icons/space-age/" .. name .. ".png",
				icon_size = 64,
			},
		},
	}
	sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	api.apply_belt_animation_set_and_update_related_connectables(entity, belt_animation_sets["turbo-transport-belt"])

	local remnants = data.raw["corpse"][name .. "-remnants"]
	if remnants then
		remnants.icons = entity.icons
		remnants.icon = entity.icon
		remnants.icon_size = entity.icon_size

		remnants.animation = make_rotated_animation_variations_from_sheet(2, {
			filename = "__prismatic-belts__/graphics/entity/space-age/" .. name .. "/remnants/" .. name .. "-remnants.png",
			line_length = 1,
			width = 106,
			height = 102,
			frame_count = 1,
			variation_count = 1,
			axially_symmetrical = false,
			direction_count = 4,
			shift = util.by_pixel(1, -0.5),
			scale = 0.5,
		})
	end

	---@type DeferrableIconData
	local assignable_tech_icon = {
		name = options.logistics_technology,
		type_name = "technology",
		icon_data = {
			{
				icon = "__prismatic-belts__/graphics/technology/space-age/" .. options.logistics_technology .. ".png",
				icon_size = 256,
			},
		},
	}
	sprite_utils.icons.assign_deferrable_icon(assignable_tech_icon)

	::continue::
end
