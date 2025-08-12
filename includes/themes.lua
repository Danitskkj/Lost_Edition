-- Lost Edition: Theme Functions
-- Based on the Cardsauce mod

-- Initialize default values
G.SETTINGS.losted_theme_selection = G.SETTINGS.losted_theme_selection or "losted_edition"
G.C.LOSTED_OUTER = G.C.LOSTED_OUTER or HEX("8B5CF6")
G.C.LOSTED_INNER = G.C.LOSTED_INNER or HEX("EC4899")
G.C.LOSTED_BLIND = G.C.LOSTED_BLIND or HEX("6D3BBE")
G.C.LOSTED_WON = G.C.LOSTED_WON or HEX("3B206B")

-- Called by the UI to select a theme
function G.FUNCS.change_losted_theme_preset(args)
    if args and args.to_key then
        G.SETTINGS.losted_theme_selection = G.losted_theme_presets_strings[args.to_key]
    end
end

-- Called by the "Apply" button
function G.FUNCS.apply_losted_theme()
    local theme_data
    for _, preset in ipairs(G.losted_theme_presets) do
        if preset.key == G.SETTINGS.losted_theme_selection then
            theme_data = preset
            break
        end
    end
    if not theme_data then return end

    local function get_color(value) return G.C[value] or HEX(value) end

    for _, def in ipairs(theme_data.colors) do
        G.C[def[2]] = get_color(def[1])
    end

    ease_background_colour{ new_colour = G.C.LOSTED_INNER, special_colour = G.C.LOSTED_OUTER }
    if G.GAME and G.GAME.blind and G.GAME.blind.change_colour then
        G.GAME.blind:change_colour(G.C.LOSTED_BLIND)
    end
    G.C.BLIND.Small = G.C.LOSTED_BLIND
    G.C.BLIND.Big = G.C.LOSTED_BLIND
    G.C.BLIND.won = G.C.LOSTED_WON

    G:save_settings()
end

-- Apply theme on startup
G.FUNCS.apply_losted_theme()
return true