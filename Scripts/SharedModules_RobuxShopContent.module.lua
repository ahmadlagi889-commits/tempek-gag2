-- Decompiled with Potassium's decompiler.

local function v18(p1) --[[ Line: 1 ]]
    local v2, v3, v4 = p1:ToHSV();
    local v5 = v4 * (1 - v3 / 2);
    local v6 = (v5 == 0 or v5 == 1) and 0 or (v4 - v5) / math.min(v5, 1 - v5);
    local v7 = {};
    local v8 = v2 + 0.03333333333333333;
    local v9 = 0.6 + v3 * 0.4;
    local v10 = Color3.fromHSV(v8, v9 == 0 and 0 or 2 * (1 - 0.6 / v9), v9);
    local v11 = 0.15 + v6 * 0.35 * 0.15;
    local v12 = Color3.fromHSV(v2, v11 == 0 and 0 or 2 * (1 - 0.15 / v11), v11);
    local v13 = 0.17 + v6 * 0.7 * 0.17;
    v7[1], v7[2], v7[3], v7[4] = v10, v12, Color3.fromHSV(v2, v13 == 0 and 0 or 2 * (1 - 0.17 / v13), v13), (function(p14, p15, p16) --[[ Name: fromHSL, Line 6 ]]
    local v17 = p16 + p15 * math.min(p16, 1 - p16);
    return Color3.fromHSV(p14, v17 == 0 and 0 or 2 * (1 - p16 / v17), v17);
end)(v2 + 0.013888888888888888, v6 * 0.9, 0.85);
    table.insert(v7, 1, p1);
    return v7;
end;
return {
    SeedPacks = {
        {
            Name = "Ghost Pepper Pack",
            DisplayName = "Ghost Pepper Pack",
            Colors = v18(Color3.fromRGB(255, 0, 0))
        }
    },
    StarterPack = {
        DisplayName = "Starter Pack",
        Items = {
            {
                Type = "SeedPack",
                Name = "Legendary Seed Pack",
                Count = 1
            },
            {
                Type = "Gear",
                Name = "Common Watering Can",
                Count = 5
            },
            {
                Type = "SeedPack",
                Name = "Rare Seed Pack",
                Count = 3
            }
        }
    },
    Gears = {
        {
            Name = "Vine Wrapper",
            Description = "Wrap people in vines!",
            GamepassKey = "Gamepass:VineWrapper:1",
            Colors = v18(Color3.fromRGB(0, 170, 0))
        },
        {
            Name = "Power Hose",
            Description = "Spray people from distance!",
            GamepassKey = "Gamepass:PowerHose:1",
            Colors = v18(Color3.fromRGB(56, 168, 255))
        },
        {
            Name = "Freeze Ray",
            Description = "Freeze people!",
            GamepassKey = "Gamepass:FreezeRay:1",
            Colors = v18(Color3.fromRGB(120, 220, 255))
        },
        {
            Name = "Rainbow Carpet",
            Description = "Fly anywhere!",
            GamepassKey = "Gamepass:RainbowCarpet:1",
            Colors = v18(Color3.fromRGB(255, 100, 200))
        }
    },
    Sheckles = {
        {
            Amount = 5000,
            Price = 10,
            Image = "rbxassetid://88931175983845"
        },
        {
            Amount = 10000,
            Price = 20,
            Image = "rbxassetid://132134544257550"
        },
        {
            Amount = 25000,
            Price = 50,
            Image = "rbxassetid://72067131155642"
        },
        {
            Amount = 50000,
            Price = 100,
            Image = "rbxassetid://93115005224214"
        },
        {
            Amount = 100000,
            Price = 200,
            Image = "rbxassetid://99416757982094"
        }
    }
};