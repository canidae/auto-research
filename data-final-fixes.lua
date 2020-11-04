-- Dynamically add sprites for tools (to display research ingredients)
for _, tool in pairs(data.raw.tool) do
    -- Setup locals
    local sprite_layers = {}

    -- Check for an icons definition
    if tool.icons then
        -- We're working with an icons definition, this may be fully defined or only partially defined, if partially defined we will fully define it for our local layer
        for _, icon_data in pairs(tool.icons) do
            table.insert(sprite_layers, {
                filename = icon_data.icon,
                size = icon_data.icon_size or tool.icon_size,
                mipmap_count = icon_data.icon_mipmaps or tool.icon_mipmaps,
                tint = icon_data.tint,
                blend_mode = icon_data.blend_mode,
                shift = icon_data.shift,
                scale = 20 / (icon_data.icon_size or tool.icon_size),
                flags = {"gui-icon"},
            })
        end
    else
        -- We're working with a standard icon, no icons table
        table.insert(sprite_layers, {
            filename = tool.icon,
            size = tool.icon_size,
            mipmap_count = tool.icon_mipmaps,
            scale = 20 / tool.icon_size,
            flags = {"gui-icon"},
        })
    end

    -- Build the sprite
    data:extend({
        {
            type = "sprite",
            name = "auto_research_tool_" .. tool.name,
            layers = sprite_layers,
        }
    })
end