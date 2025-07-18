--=============================================
--            VORP SHARED CONFIG             --
--=============================================

Lang = "Portugues_BR"
Config = Config or {}

Config = {
    autoUpdateDB           = true, -- Enables automatic database updates.

    ReportCrashes          = true, -- Reports crashes to https://monitor.gtp-dev.com login in here to create your API KEY , by doing this you will help the community to improve the server stability and fix crashes faster
    API_KEY                = "",   -- API key for crash reporting. Get your API key at https://monitor.gtp-dev.com to allow more requests make a donation in the website

    -- (IF YOU HAVE WHITELIST ENABLED DONT ENABLE THIS)--
    DeleteFromUsersTable   = true,      -- this will delete from users table if character does not exist "optimising the queries"
    -----------------------------------------------------
    PrintPlayerInfoOnLeave = false,     -- Logs player information in the server console when they leave.
    PrintPlayerInfoOnEnter = false,     -- Logs player information in the server console upon joining.

    CanRespawn             = function() -- use this function to add your own logic if player can respawn or not
        -- add your logic here
        return true                     -- dont touch
    end,
    --=============================================
    --        STARTING CONFIGURATION             --
    --=============================================

    initGold               = 0.0,          -- Initial gold amount for new players.
    initMoney              = 0.0,        -- Initial money amount for new players.
    initRol                = 0.0,          -- Initial role-play currency amount for new players.
    initInvCapacity        = 60.0,         -- Initial number of character inventory weight for new players. for old characters you must change in the database if you dont ave a new server
    initXp                 = 0,            -- Initial experience points for new players.
    initJob                = "Desempregado", -- Default job for new players. Recommended not to change.
    initJobGrade           = 0,            -- Default job grade for new players. Recommended not to change.
    initGroup              = "user",       -- Default user group for new players. Recommended not to change.
    initJobLabel           = "forasteiros", -- Default job label for new players. Recommended not to change.
    Whitelist              = false,        -- Enable if not using TxAdmin's whitelist system.
    SavePlayersStatus      = false,        -- Future deprecated. Advised not to use, as it will be removed.
    maxHealth              = 10,           -- Maximum health for players. 10 is full, 0 is empty.
    maxStamina             = 10,           -- Maximum stamina for players. 10 is full, 0 is empty.
    PVP                    = true,         -- Enables player vs player combat.
    PVPToggle              = false,        -- Allows players to toggle their PVP status.
    CommandOnOffPVP        = 'psp',        -- Command to toggle PVP status, requires PVPToggle to be true.
    savePlayersTimer       = 10,           -- Interval in minutes for automatically saving all players to the database.
    showplayerIDwhenfocus  = true,         -- Shows player Steam name when focusing on them with RMB if set to false.
    disableAutoAIM         = true,         -- Disables auto-aim for controller players if set to false.
    CheckDoubleAccounts    = false,        -- Enables, check if player enter with two accounts if false players can enter with same character and dupe.
    --=============================================
    --          MULTICHARACTER SUPPORT           --
    --=============================================

    SaveDiscordId          = true, -- Saves Discord ID in the character/user database upon joining/leaving.
    MaxCharacters          = 1,    -- Maximum number of characters a player can create. when first join, for old users go to users table and change the number of characters there

    --=============================================
    --             UI CORE SETTINGS              --
    --=============================================

    HideOnlyDEADEYE        = true,  -- Hides only the Dead Eye core in the UI.
    HidePlayersCore        = false, -- Hides player cores in the UI.
    HideHorseCores         = false, -- Hides horse cores in the UI.

    --=============================================
    --          WEBHOOK CONFIGURATIONS           --
    --     Refer to commands.config for usage.   --
    --=============================================

    webhookColor           = 16711680,                            -- Color for embeds in Discord webhooks.
    name                   = "VORP",                              -- Name displayed in webhook embeds.
    logo                   = "https://via.placeholder.com/30x30", -- Logo URL for webhook embeds.
    footerLogo             = "https://via.placeholder.com/30x30", -- Footer logo URL for webhook embeds.
    Avatar                 = "https://via.placeholder.com/30x30", -- Avatar URL for webhook embeds.

    --=============================================
    --            UI CONFIGURATIONS              --
    --=============================================


    HideUi                = true,      -- Shows or hides the overall UI.
    HideGold              = true,      -- Disables the Gold UI for all players.
    HideMoney             = true,      -- Disables the Money UI for all players.
    HideLevel             = true,      -- Disables the Level UI for all players.
    HideID                = true,      -- Disables the ID UI for all players.
    HideTokens            = true,      -- Disables the Token UI for all players.
    HidePVP               = true,      -- Disables the PVP UI for all players.
    UIPosition            = 'TopRight', -- Sets the UI position on the screen. Options are 'TopRight', 'TopLeft', 'BottomRight', 'BottomLeft', 'MiddleRight', 'TopMiddle', 'BottomMiddle'.

    UILayout              = 'Column',   -- Sets the UI layout, options are 'Row' or 'Column'.
    HideWithRader         = true,       -- UI hides when the radar (minimap) is hidden.
    OpenAfterRader        = true,       -- UI shows when the radar (minimap) reappears.
    CloseOnDelay          = false,      -- UI automatically closes after a set time.
    CloseOnDelayMS        = 10000,      -- Time in milliseconds before the UI auto-closes, 10000 equals 10 seconds.
    CommandHideIU         = 'hideUi',   -- Command to hide all UI elements, useful for screenshots.
    CommandToogleUI       = 'toggleUi', -- Command to toggle the visibility of VORP UI elements.
    CommandClearAnim      = 'c', -- Command to stop animations if a player is stuck.

    --=============================================
    --            MAP CONFIGURATIONS             --
    --=============================================

    mapTypeOnFoot         = 3,     -- Radar type when on foot. 0 = Off, 1 = Regular, 2 = Expanded, 3 = Simple (compass).
    mapTypeOnMount        = 3,     -- Radar type when on horse. Same options as on foot.
    enableTypeRadar       = false, -- Enables custom radar types if true, otherwise players use game settings.
    Loadinscreen          = true,  -- Enables loading screens during spawn and respawn.
    LoadinScreenTimer     = 10000, -- Duration of loading screens in milliseconds.

    --=============================================
    --            RESPAWN SETTINGS               --
    --=============================================

    HealthOnRespawn       = 500,                                  -- Player health after respawning at a hospital (max is 500).
    HealthOnResurrection  = 100,                                  -- Player health after being resurrected (max is 500).
    RagdollOnResurrection = true,                                 -- Enables ragdoll and revive effects upon resurrection.
    HealthRecharge        = { enable = true, multiplier = 0.37 }, -- Auto-recharge for health, with a multiplier for speed.
    StaminaRecharge       = { enable = true, multiplier = 0.4 },  -- Auto-recharge for stamina, with a multiplier for speed.
    RespawnTime           = 0,  -- tempo para apart                                  -- Time in seconds before a player can respawn.
    RespawnKey            = 0xDFF812F9,                           -- Key code for respawning (default is 'E').
    RespawnKeyTime        = 5000,                                 -- Time in milliseconds to hold the respawn key.
    CombatLogDeath        = true,                                 -- Combat loggers respawn in a dead state instead of alive.
    UseControlsCamera     = false,                                -- Allows dead or carried players to move the camera with WASD (resource intensive).
    UseDeathHandler       = true,                                 -- Keeps default death handling unless you have a custom system.
    Hospitals             = {                                     -- Spawn points for players respawning at hospitals.
        Valentine = {
            name = "Valentine",
            pos = vector4(-283.83, 806.4, 119.38, 321.76), -- Vector4 coordinates: x, y, z, heading.
        },
        SaintDenis = {
            name = "Saint Denis",
            pos = vector4(2721.4562, -1446.0975, 46.2303, 321.76),
        },
        Armadillo = {
            name = "Armadillo",
            pos = vector4(-3742.5, -2600.9, -13.23, 321.76),
        },
        Blackwater = {
            name = "Black water",
            pos = vector4(-723.9527, -1242.8358, 44.7341, 321.76),
        },
        Rhodes = {
            name = "Rhodes",
            pos = vector4(1229.0, -1306.1, 76.9, 321.76),
        },
    },
    ActiveEagleEye        = true,  -- Enables or disables Eagle Eye feature.
    ActiveDeadEye         = false, -- Enables or disables Dead Eye feature.

    --=============================================
    --         BAN SYSTEM CONFIGURATIONS         --
    --=============================================

    DateTimeFormat        = "%d/%m/%y %H:%M:%S", -- Format for displaying date and time in ban notifications.
    TimeZone              = " CET",              -- Set your server's timezone.
    TimeZoneDifference    = 1,                   -- Time difference from UTC, used in the banning system.

    --=============================================
    --        COMMAND PERMISSION SETTINGS        --
    --=============================================

    NewPlayerWebhook      = "",    -- Webhook URL for logging new player joins.
    SetUserDBadmin        = true,  -- If true, 'addGroup' command also sets admin status in the Users table.
    SetBothDBadmin        = false, -- If true, 'addGroup' sets admin status in both Users and Characters tables.

    --===========================================
    --    DISCORD RICH PRESENCE INTEGRATION    --
    --===========================================
    appid                 = 1067728635643052092,                        -- Discord Application ID. Replace this with your own application's ID.
    biglogo               = "principal",                 -- Name of the image asset to use for the large icon in the rich presence.
    biglogodesc           = " Madruga Dev: ",   -- Description displayed when hovering over the large icon.
    smalllogo             = "logo",            -- Name of the image asset for the small icon in the rich presence. This is optional.
    smalllogodesc         = "Programador", -- Description displayed when hovering over the small icon.
    richpresencebutton    = "Entre No Discord",             -- Text displayed on the rich presence button.
    shownameandid         = true,                       -- Whether to display the player's Steam name and ID.
    Buttons               = {                           -- Configuration for buttons shown in the Discord rich presence.
        {
            text = 'Madruga Store',                     -- Text displayed on the first button.
            -- URL the first button directs to. Replace with your Discord invite link.
            url = 'https://discord.gg/ueDwVpvnyv'

        },
        {
            text = 'Website', -- Text displayed on the second button.
            -- URL the second button directs to. Fill in with your website URL.
            url = ''          -- Example for Rich Presence Button
        }
    },
    --=============================================
}
