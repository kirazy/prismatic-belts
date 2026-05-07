local api = require("prototypes.api")
local meld = require("meld")
local sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

-- Setup belt animation sets for vanilla entities
---@type { [data.EntityID]: data.TransportBeltAnimationSetWithCorners }
local belt_animation_sets = {
	["transport-belt"] = {
		animation_set = {
			filename = "__prismatic-belts__/graphics/entity/base/transport-belt/transport-belt.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
			frame_count = 16,
			direction_count = 20,
		},
		frozen_patch = api.get_transport_belt_frozen_patch(api.defines.belt_sprites.standard),
	},
	["fast-transport-belt"] = {
		animation_set = {
			filename = "__prismatic-belts__/graphics/entity/base/fast-transport-belt/fast-transport-belt.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
			frame_count = 32,
			direction_count = 20,
		},
		frozen_patch = api.get_transport_belt_frozen_patch(api.defines.belt_sprites.fast),
	},
	["express-transport-belt"] = {
		animation_set = {
			filename = "__prismatic-belts__/graphics/entity/base/express-transport-belt/express-transport-belt.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
			frame_count = 32,
			direction_count = 20,
		},
		frozen_patch = api.get_transport_belt_frozen_patch(api.defines.belt_sprites.fast),
	},
}

-- Add belt reader sprites.
meld(belt_animation_sets["transport-belt"], belt_reader_gfx)
meld(belt_animation_sets["fast-transport-belt"], belt_reader_gfx)
meld(belt_animation_sets["express-transport-belt"], belt_reader_gfx)

local transport_belts = {
	["transport-belt"] = {
		logistics_technology = "logistics",
		belt_sprites = api.defines.belt_sprites.standard,
	},
	["fast-transport-belt"] = {
		logistics_technology = "logistics-2",
		belt_sprites = api.defines.belt_sprites.fast,
	},
	["express-transport-belt"] = {
		logistics_technology = "logistics-3",
		belt_sprites = api.defines.belt_sprites.fast,
	},
}

local is_reskin_adaptation_needed = mods["reskins-library"] and not (reskins.bobs and (reskins.bobs.triggers.logistics.entities == false))
if is_reskin_adaptation_needed then
	transport_belts["transport-belt"].tier = 1
	transport_belts["fast-transport-belt"].tier = 2
	transport_belts["express-transport-belt"].tier = 3

	if reskins.lib.settings.get_value("reskins-lib-customize-tier-colors") then
		transport_belts["transport-belt"].mask_tint = reskins.lib.tiers.get_belt_tint(1)
		transport_belts["fast-transport-belt"].mask_tint = reskins.lib.tiers.get_belt_tint(2)
		transport_belts["express-transport-belt"].mask_tint = reskins.lib.tiers.get_belt_tint(3)
	end
end

for name, options in pairs(transport_belts) do
	local entity = data.raw["transport-belt"][name]
	if not entity then
		goto continue
	end

	---@type data.IconData[]
	local icon_data = options.mask_tint and api.get_transport_belt_icon({ mask_tint = options.mask_tint }) or { {
		icon = "__prismatic-belts__/graphics/icons/base/" .. name .. ".png",
		icon_size = 64,
	} }

	---@type DeferrableIconData
	local deferrable_icon = {
		name = entity.name,
		type_name = entity.type,
		icon_data = icon_data,
	}

	if is_reskin_adaptation_needed then
		-- Append tier labels for reskins-library
		local do_labels = reskins.lib.settings.get_value("reskins-bobs-do-belt-entity-tier-labeling") == true
		deferrable_icon.icon_data = do_labels and reskins.lib.tiers.add_tier_labels_to_icons(options.tier, icon_data) or icon_data
		deferrable_icon.pictures = do_labels and reskins.lib.sprites.create_sprite_from_icons(icon_data, 1.0) or nil
	end

	sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	local animation_set = options.mask_tint and api.get_transport_belt_animation_set({
		mask_tint = options.mask_tint,
		belt_sprites = options.belt_sprites,
	}) or belt_animation_sets[entity.name]
	api.apply_belt_animation_set_and_update_related_connectables(entity, animation_set)

	if options.mask_tint then
		api.create_or_update_remnants(entity.name, { mask_tint = options.mask_tint })
	else
		local remnants = data.raw["corpse"][entity.name .. "-remnants"]

		if remnants then
			remnants.icons = entity.icons
			remnants.icon = entity.icon
			remnants.icon_size = entity.icon_size

			remnants.animation = make_rotated_animation_variations_from_sheet(2, {
				filename = "__prismatic-belts__/graphics/entity/base/" .. entity.name .. "/remnants/" .. entity.name .. "-remnants.png",
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
	end

	---@type DeferrableIconData
	local assignable_tech_icon = {
		name = options.logistics_technology,
		type_name = "technology",
		icon_data = options.mask_tint and api.get_transport_belt_technology_icon({ mask_tint = options.mask_tint }) or {
			{
				icon = "__prismatic-belts__/graphics/technology/base/" .. options.logistics_technology .. ".png",
				icon_size = 256,
			},
		},
	}
	sprite_utils.icons.assign_deferrable_icon(assignable_tech_icon)

	::continue::
end
