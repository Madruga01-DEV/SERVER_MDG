Config = {}

--Veg Modifiers Flags
local Debris = 1
local Grass = 2
local Bush = 4
local Weed = 8
local Flower = 16
local Sapling = 32
local Tree = 64
local Rock = 128
local LongGrass = 256
local All = Debris + Grass + Bush + Weed + Flower + Sapling + Tree + Rock + LongGrass

-- Veg Modifier Types
local VMT_Cull = 1
local VMT_Flatten = 2
local VMT_FlattenDeepSurface = 4
local VMT_Explode = 8
local VMT_Push = 16
local VMT_Decal = 32

Config.VegMods = {
    { -- casa da colina valantine
        coords = vector3(21.87, 495.48, 163.98), -- Coords
        radius = 10.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types
    },

    { -- spooni_sd_farming Office
        coords = vector3(2694.118, -851.498, 42.312), -- Coords
        radius = 5.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types
    },
    ------------------------------ prefeitura bw  ----------------
    { -- spooni_sd_farming Office
        coords = vector3(-830.221, -1242.324, 43.747), -- Coords 1 
        radius = 10.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types
    },
    { -- spooni_sd_farming Office
        coords = vector3(-815.690, -1242.197, 43.747), -- Coords 2
        radius = 10.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types    
    },
    { -- spooni_sd_farming Office
        coords = vector3(-807.870, -1244.500, 43.747), -- Coords 3
        radius = 10.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types    
    },
    { -- spooni_sd_farming Office
        coords = vector3(-794.169, -1242.613, 43.747), -- Coords 4
        radius = 10.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types    
    },
    { -- spooni_sd_farming Office
        coords = vector3(-785.893, -1244.042, 43.745), -- Coords 5
        radius = 10.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types    
    },
    { -- spooni_sd_farming Office
        coords = vector3(-813.586, -1222.422, 43.746), -- Coords 6
        radius = 50.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types    
    },
    { -- spooni_sd_farming Office
        coords = vector3(-765.383, -1233.758, 44.484), -- Coords 7
        radius = 20.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types    
    },
    { -- açougue valantine
        coords = vector3(-339.63, 719.55, 117.58), -- Coords 7
        radius = 10.0, -- Raduis
        veg = { flag = All, type = VMT_Cull,} -- Veg Modifiers Flags/Types    
    },
}