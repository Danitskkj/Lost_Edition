SMODS.current_mod.optional_features = {
	retrigger_joker = true -- Quantum edition, retrigger joker one time 
}

-- Main table for the mod
LOSTEDMOD = {
    vars = {
        the_joker_triggered = false,
    },
    funcs = {}
}

-- Debugging functions
function sendDebugMessage(msg)
    print("[Lost Edition DEBUG] " .. tostring(msg))
end

function sendErrorMessage(msg)
    print("[Lost Edition ERROR] " .. tostring(msg))
end

-- List of modules to be loaded
local includes = {
    'tables',
    'utilities', 
    'assets',
    'compat',
    'hooks/game',
    'hooks/overrides',
    'hooks/pow_mult',
    'hooks/UI_definitions',
    'hooks/intro',
    'speed_options',
    'music',
    'themes',
    'items',
}

-- Load modules
for _, include in ipairs(includes) do
    local success, error_msg = pcall(function()
        local init, error = SMODS.load_file("includes/" .. include .. ".lua")
        if error then
            sendErrorMessage("Failed to load " .. include .. " with error: " .. error)
        else
            if init then init() end
            sendDebugMessage("Loaded module: " .. include)
        end
    end)
    if not success then
        sendErrorMessage("Error in module " .. include .. ": " .. error_msg)
    end
end

-- Reset jokers on run start
function SMODS.current_mod.reset_game_globals(run_start)
    G.GAME.negative_rate = 1
    G.GAME.losted_mysterious_completed = false
    LOSTEDMOD.funcs.reset_losted_obsidian_card()
    LOSTEDMOD.funcs.reset_losted_moist_cake()
    LOSTEDMOD.funcs.reset_losted_sarcophagus()
    LOSTEDMOD.funcs.reset_losted_sticky()
end

function G.FUNCS.initPostSplash()
end
