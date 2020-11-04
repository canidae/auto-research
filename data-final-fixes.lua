-- dynamically add sprites for tools (to display research ingredients)
for _, tool in pairs( data.raw.tool ) do
    local w = 0
    local h = 0
    local f = nil
    local ok = false

    -- icon specification requires either
    --   - icon and icon_size properties to be defined
    --     OR
    --   - icons (and optionally icon_size) to be defined

    if tool.icon and tool.icon_size then
        w = tool.icon_size
        h = tool.icon_size
        f = tool.icon
        ok = true
    elseif tool.icons and tool.icons[1] and tool.icons[1].icon_size then
        w = tool.icons[1].icon_size
        h = tool.icons[1].icon_size
        f = tool.icons[1].icon
        ok = true
    end

    if ok then
        data:extend( {
            {
                type     = "sprite",
                name     = "auto_research_tool_" .. tool.name,
                filename = f,
                priority = "extra-high-no-scale",
                width    = w,
                height   = h,
                scale    = 16.0 / math.max( w, h ),
            }
        } )
    end
end
