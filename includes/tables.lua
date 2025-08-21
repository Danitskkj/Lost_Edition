-- Data structure for all visual themes.
G.losted_theme_presets = {
    -- The 'key' is for internal use, 'name' is what shows up in the menu.
    { name = 'Lost Edition',       key = 'losted_edition',      colors = { {'8B5CF6', 'LOSTED_OUTER'}, {'EC4899', 'LOSTED_INNER'}, {'6D3BBE', 'LOSTED_BLIND'}, {'3B206B', 'LOSTED_WON'} } },
    { name = 'Balatro Original',   key = 'balatro_original',    colors = { {'RED', 'LOSTED_OUTER'}, {'BLUE', 'LOSTED_INNER'}, {'50846e', 'LOSTED_BLIND'}, {'4f6367', 'LOSTED_WON'} } },
    { name = 'Dark Mode',          key = 'dark_mode',           colors = { {'2D3748', 'LOSTED_OUTER'}, {'4A5568', 'LOSTED_INNER'}, {'23263A', 'LOSTED_BLIND'}, {'181A26', 'LOSTED_WON'} } },
    { name = 'Royal Amethyst',     key = 'royal_amethyst',      colors = { {'7C3AED', 'LOSTED_OUTER'}, {'C084FC', 'LOSTED_INNER'}, {'5B21B6', 'LOSTED_BLIND'}, {'3B0764', 'LOSTED_WON'} } },
    { name = 'Oceanic Depths',     key = 'oceanic_depths',      colors = { {'155E75', 'LOSTED_OUTER'}, {'38BDF8', 'LOSTED_INNER'}, {'164E63', 'LOSTED_BLIND'}, {'082F49', 'LOSTED_WON'} } },
    { name = 'Verdant Grove',      key = 'verdant_grove',       colors = { {'166534', 'LOSTED_OUTER'}, {'4ADE80', 'LOSTED_INNER'}, {'14532D', 'LOSTED_BLIND'}, {'052E16', 'LOSTED_WON'} } },
    { name = 'Solar Flare',        key = 'solar_flare',         colors = { {'F59E42', 'LOSTED_OUTER'}, {'FDE68A', 'LOSTED_INNER'}, {'B45309', 'LOSTED_BLIND'}, {'78350F', 'LOSTED_WON'} } },
    { name = 'Sakura Dream',       key = 'sakura_dream',        colors = { {'F472B6', 'LOSTED_OUTER'}, {'FBCFE8', 'LOSTED_INNER'}, {'BE185D', 'LOSTED_BLIND'}, {'831843', 'LOSTED_WON'} } },
    { name = 'Cyber Neon',         key = 'cyber_neon',          colors = { {'06B6D4', 'LOSTED_OUTER'}, {'A21CAF', 'LOSTED_INNER'}, {'0E7490', 'LOSTED_BLIND'}, {'581C87', 'LOSTED_WON'} } },
    { name = 'Ember Night',        key = 'ember_night',         colors = { {'DC2626', 'LOSTED_OUTER'}, {'F87171', 'LOSTED_INNER'}, {'7C2D12', 'LOSTED_BLIND'}, {'431407', 'LOSTED_WON'} } },
    { name = 'Plasmatic Flow',      key = 'plasmatic_flow',     colors = { {'D98BAE', 'LOSTED_OUTER'}, {'8A8FC9', 'LOSTED_INNER'}, {'A88DBF', 'LOSTED_BLIND'}, {'E886B0', 'LOSTED_WON'} } }
}

-- Generate helper tables from the main preset table for the UI
G.losted_theme_presets_nums = {}
G.losted_theme_presets_strings = {}
G.losted_theme_selector_options = {}

for i, preset in ipairs(G.losted_theme_presets) do
    G.losted_theme_presets_nums[preset.key] = i
    G.losted_theme_presets_strings[i] = preset.key
    table.insert(G.losted_theme_selector_options, preset.name)
end

return true
