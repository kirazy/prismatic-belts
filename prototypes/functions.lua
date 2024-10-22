-- Copyright (c) 2024 Kirazy
-- Part of Prismatic Belts
--
-- See LICENSE.md in the project directory for license information.

-- Make our function host
if not prismatic_belts then prismatic_belts = {} end
prismatic_belts.migration = require("migration")

local meld = require("meld")

--- Ensure tint is normalized to between 0 and 1
---@param tint data.Color
---@return data.Color
local function normalize_tint(tint)
    local r = tint.r or tint[1]
    local g = tint.g or tint[2]
    local b = tint.b or tint[3]
    local a

    if r > 255 or g > 255 or b > 255 then
        r = r / 255
        g = g / 255
        b = b / 255
        a = tint.a / 255 or tint[4] / 255 or 1
    end

    return { r = r, g = g, b = b, a = a }
end

--- Adjust the alpha value of a given tint
---@param tint data.Color
---@param alpha float
---@return data.Color
function prismatic_belts.adjust_alpha(tint, alpha)
    local normalized_tint = normalize_tint(tint)

    ---@type data.Color
    local adjusted_tint = { r = normalized_tint.r, g = normalized_tint.g, b = normalized_tint.b, a = alpha }

    return adjusted_tint
end

-- Make an icon_pictures table for reskins-library
function prismatic_belts.transport_belt_picture(tint, use_reskin_process)
    local standard_icon = prismatic_belts.transport_belt_icon(tint, use_reskin_process)
    local icon_pictures = { layers = {} }

    for _, layer in pairs(standard_icon) do
        table.insert(icon_pictures.layers, {
            filename = layer.icon,
            size = layer.icon_size,
            mipmaps = layer.icon_mipmaps,
            scale = 0.25,
            tint = layer.tint,
        })
    end

    return icon_pictures
end

----------------------------------------------------------------------------------------------------
-- BELT COLORING API
----------------------------------------------------------------------------------------------------

---@class PrismaticBelts.LogisticsTechnologyIconInputs
---@field base_tint? data.Color # Color to tint the base sprite (gears, rails)
---@field mask_tint? data.Color # Color to tint the mask sprite (belt surface, arrows)
---@field use_reskin_process? boolean # When true, uses the icons compliant with Artisanal Reskins.

--- Returns a complete technology icons definition
---@param inputs PrismaticBelts.LogisticsTechnologyIconInputs
---@return data.IconData[]
function prismatic_belts.logistics_technology_icon(inputs)
    local technology_icons

    if inputs.use_reskin_process then
        ---@type data.IconData[]
        technology_icons = {
            {
                icon = "__prismatic-belts__/graphics/technology/reskins/logistics-technology-base.png",
                icon_size = 256,
                icon_mipmaps = 4,
                tint = inputs.base_tint and prismatic_belts.adjust_alpha(inputs.base_tint, 1),
            },
            {
                icon = "__prismatic-belts__/graphics/technology/reskins/logistics-technology-mask.png",
                icon_size = 256,
                icon_mipmaps = 4,
                tint = inputs.mask_tint,
            },
            {
                icon = "__prismatic-belts__/graphics/technology/reskins/logistics-technology-highlights.png",
                icon_size = 256,
                icon_mipmaps = 4,
                tint = { 1, 1, 1, 0 },
            },
        }
    else
        ---@type data.IconData[]
        technology_icons = {
            {
                icon = "__prismatic-belts__/graphics/technology/standard/logistics-technology-base.png",
                icon_size = 256,
                icon_mipmaps = 4,
                tint = inputs.base_tint and prismatic_belts.adjust_alpha(inputs.base_tint, 1),
            },
            {
                icon = "__prismatic-belts__/graphics/technology/standard/logistics-technology-mask.png",
                icon_size = 256,
                icon_mipmaps = 4,
                tint = inputs.mask_tint,
            },
        }
    end

    return technology_icons
end

--- Returns a complete item icons definition
---@param tint? data.Color # Color to tint the icon.
---@param use_reskin_process? boolean # When true, uses the icons compliant with Artisanal Reskins.
---@return data.IconData[]
function prismatic_belts.transport_belt_icon(tint, use_reskin_process)
    ---@type data.IconData[]
    local item_icons

    if use_reskin_process then
        ---@type data.IconData[]
        item_icons = {
            {
                icon = "__prismatic-belts__/graphics/icons/reskins/transport-belt-icon-base.png",
                icon_size = 64,
                icon_mipmaps = 4,
                tint = tint and prismatic_belts.adjust_alpha(tint, 1),
            },
            {
                icon = "__prismatic-belts__/graphics/icons/reskins/transport-belt-icon-highlights.png",
                icon_size = 64,
                icon_mipmaps = 4,
                tint = { 1, 1, 1, 0 },
            },
        }
    else
        ---@type data.IconData[]
        item_icons = {
            {
                icon = "__prismatic-belts__/graphics/icons/standard/transport-belt-icon.png",
                icon_size = 64,
                icon_mipmaps = 4,
                tint = tint and prismatic_belts.adjust_alpha(tint, 1),
            },
        }
    end

    return item_icons
end

---@class PrismaticBelts.TransportBeltAnimationSetInputs
---@field base_tint? data.Color # Color to tint the base sprite (gears, rails).
---@field mask_tint? data.Color # Color to tint the mask sprite (belt surface, arrows).
---@field brighten_arrows? boolean # When true, blends a white arrow with the underlying tinted belts to brighen the arrows.
---@field use_reskin_process? boolean # When true, uses the tintable color masks consistent with Artisanal Reskins.
---@field variant? 1|2 # Spritesheet to return (1 for slow, 2 for fast).

---Returns a complete belt_animation_set definition
---@param inputs PrismaticBelts.TransportBeltAnimationSetInputs
---@return table
function prismatic_belts.transport_belt_animation_set(inputs)
    local transport_belt_animation_set
    local variant = inputs.variant or 1

    ---@class PrismaticBelts.ReturnBeltAnimationSetLayerInputs
    ---@field blend_mode? data.BlendMode # Blending mode for the layer.
    ---@field directory? "reskins"|"standard" # "standard" or "reskins", determines types of color masks to use.
    ---@field layer "base"|"mask"|"arrows"|"highlights" # "base", "mask" or "arrows" (standard), or "base", "mask" or "highlights" (reskins). Determines specific spritesheet used by the layer
    ---@field tint? data.Color # Color to tint the layer.
    ---@field variant 1|2 # Spritesheet to return (1 for slow, 2 for fast).

    --- Returns a tailored layer of the belt animation set
    ---@param layer_inputs PrismaticBelts.ReturnBeltAnimationSetLayerInputs
    ---@return data.RotatedAnimation
    local function return_belt_animation_set_layer(layer_inputs)
        -- Point to appropriate sprite directory
        local directory = layer_inputs.directory or "standard"

        ---@type data.RotatedAnimation
        local layer = {
            filename = "__prismatic-belts__/graphics/entity/" .. directory .. "/transport-belt-" .. layer_inputs.variant .. "-" .. layer_inputs.layer .. ".png",
                priority = "extra-high",
                width = 128,
                height = 128,
                scale = 0.5,
            frame_count = 16 * layer_inputs.variant,
            tint = layer_inputs.tint,
            blend_mode = layer_inputs.blend_mode,
                direction_count = 20,
        }

        return layer
    end

    -- Setup belt transport set
    if inputs.use_reskin_process then
        ---@type data.TransportBeltAnimationSet
        transport_belt_animation_set = {
            animation_set = {
                layers = {
                    return_belt_animation_set_layer { directory = "reskins", layer = "base", tint = inputs.base_tint and prismatic_belts.adjust_alpha(inputs.base_tint, 1) or nil, variant = variant },
                    return_belt_animation_set_layer { directory = "reskins", layer = "mask", tint = inputs.mask_tint, variant = variant },
                    return_belt_animation_set_layer { directory = "reskins", layer = "highlights", blend_mode = "additive", variant = variant },
                },
            },
        }
    else
        transport_belt_animation_set = {
            animation_set = {
                layers = {
                    return_belt_animation_set_layer { layer = "base", tint = inputs.base_tint and prismatic_belts.adjust_alpha(inputs.base_tint, 1) or nil, variant = variant },
                    return_belt_animation_set_layer { layer = "mask", tint = inputs.mask_tint, variant = variant },
                },
            },
        }

        if inputs.brighten_arrows then
            table.insert(transport_belt_animation_set.animation_set.layers, return_belt_animation_set_layer { layer = "arrows", tint = util.color("4"), blend_mode = "additive-soft", variant = variant })
        end
    end

    -- Add belt reader sprites.
    meld(transport_belt_animation_set, belt_reader_gfx)

    return transport_belt_animation_set
end

---@class PrismaticBelts.CreateRemnantInputs
---@field base_tint? data.Color # Color to tint the base sprite (gears, rails)
---@field mask_tint? data.Color # Color to tint the mask sprite (belt surface, arrows)
---@field brighten_arrows? boolean # When true, blends a white arrow with the underlying tinted belts to brighen the arrows
---@field use_reskin_process? boolean # When true, uses the tintable color masks consistent with Artisanal Reskins

---Reskins, or creates as needed, appropriate transport belt remnants.
---@param name string # The prototype name of the transport belt.
---@param inputs PrismaticBelts.CreateRemnantInputs # Table of parameters that configure the remnant sprites.
function prismatic_belts.create_remnant(name, inputs)
    ---@type data.RotatedAnimation
    local remnant_layers

    ---@class PrismaticBelts.ReturnRemnantLayerInputs
    ---@field blend_mode? data.BlendMode # Blending mode for the layer.
    ---@field directory? "reskins"|"standard" # "standard" or "reskins", determines types of color masks to use.
    ---@field layer "base"|"mask"|"arrows"|"highlights" # "base", "mask" or "arrows" (standard), or "base", "mask" or "highlights" (reskins). Determines specific spritesheet used by the layer
    ---@field tint? data.Color # Color to tint the layer.

    --- Returns a tailored layer of the belt remnants.
    ---@param layer_inputs PrismaticBelts.ReturnRemnantLayerInputs
    ---@return data.RotatedAnimation
    local function return_remnant_layer(layer_inputs)
        -- Point to appropriate sprite directory
        local directory = layer_inputs.directory or "standard"

        ---@type data.RotatedAnimation
        local layer = {
            filename = "__prismatic-belts__/graphics/entity/" .. directory .. "/remnants/transport-belt-remnants-" .. layer_inputs.layer .. ".png",
            line_length = 1,
            width = 106,
            height = 102,
            frame_count = 1,
            variation_count = 1,
            axially_symmetrical = false,
            direction_count = 4,
            tint = layer_inputs.tint,
            blend_mode = layer_inputs.blend_mode,
                shift = util.by_pixel(1, -0.5),
                scale = 0.5,
        }

        return layer
    end

    -- Setup belt transport set
    if inputs.use_reskin_process then
        remnant_layers = {
            return_remnant_layer { directory = "reskins", layer = "base", tint = inputs.base_tint and prismatic_belts.adjust_alpha(inputs.base_tint, 1) or nil },
            return_remnant_layer { directory = "reskins", layer = "mask", tint = inputs.mask_tint },
            return_remnant_layer { directory = "reskins", layer = "highlights", blend_mode = "additive" },
        }
    else
        remnant_layers = {
            return_remnant_layer { layer = "base", tint = inputs.base_tint and prismatic_belts.adjust_alpha(inputs.base_tint, 1) or nil },
            return_remnant_layer { layer = "mask", tint = inputs.mask_tint },
        }

        if inputs.brighten_arrows then
            table.insert(remnant_layers, return_remnant_layer { layer = "arrows", tint = util.color("4"), blend_mode = "additive-soft" })
        end
    end

    -- Fetch remnant
    local remnants = data.raw["corpse"][name .. "-remnants"]

    -- If there is no existing remnant, create one
    if not remnants then
        remnants = {
            type = "corpse",
            name = "prismatic-belts-" .. name .. "-remnants",
            icons = data.raw["transport-belt"][name].icons,
            icon = data.raw["transport-belt"][name].icon,
            icon_size = data.raw["transport-belt"][name].icon_size,
            icon_mipmaps = data.raw["transport-belt"][name].icon_mipmaps,
            flags = { "placeable-neutral", "not-on-map" },
            subgroup = "belt-remnants",
            order = (data.raw.item[name] and data.raw.item[name].order) and data.raw.item[name].order .. "-a[" .. name .. "-remnants]" or "a-a-a",
            selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            tile_width = 1,
            tile_height = 1,
            selectable_in_game = false,
            time_before_removed = 60 * 60 * 15, -- 15 minutes
            final_render_layer = "remnants",
            animation = make_rotated_animation_variations_from_sheet(2, { layers = remnant_layers }),
        }

        data:extend({ remnants })

        -- Assign the corpse
        data.raw["transport-belt"][name].corpse = "prismatic-belts-" .. name .. "-remnants"
    else
        remnants.icons = data.raw["transport-belt"][name].icons
        remnants.icon = data.raw["transport-belt"][name].icon
        remnants.icon_size = data.raw["transport-belt"][name].icon_size
        remnants.animation = make_rotated_animation_variations_from_sheet(2, { layers = remnant_layers })
    end
end
