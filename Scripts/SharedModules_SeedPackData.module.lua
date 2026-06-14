-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__SeedPacks__2 = l__ReplicatedStorage__1:WaitForChild("Assets"):WaitForChild("SeedPacks");
local l__SeedData__3 = require(l__ReplicatedStorage__1.SharedModules.SeedData);
local l__SellValueData__4 = require(l__ReplicatedStorage__1.SharedModules.SellValueData);
local u1 = {
    Data = {
        {
            PackName = "Ghost Pepper Pack",
            IMG = "rbxassetid://133021483253462",
            CustomProgressBased = false,
            Model = l__SeedPacks__2:WaitForChild("Ghost Pepper Pack"),
            Seeds = {
                {
                    SeedName = "Baby Cactus",
                    Chance = 50
                },
                {
                    SeedName = "Horned Melon",
                    Chance = 30
                },
                {
                    SeedName = "Glow Mushroom",
                    Chance = 15
                },
                {
                    SeedName = "Poison Ivy",
                    Chance = 4
                },
                {
                    SeedName = "Ghost Pepper",
                    Chance = 1
                }
            }
        },
        {
            PackName = "Common Seed Pack",
            Rarity = "Common",
            IMG = "rbxassetid://115799317193062",
            CustomProgressBased = true,
            TargetPercentile = 0.1,
            Spread = 0.15,
            Model = l__SeedPacks__2:WaitForChild("Common Seed Pack")
        },
        {
            PackName = "Uncommon Seed Pack",
            Rarity = "Uncommon",
            IMG = "rbxassetid://95821847618828",
            CustomProgressBased = true,
            TargetPercentile = 0.22,
            Spread = 0.15,
            Model = l__SeedPacks__2:WaitForChild("Uncommon Seed Pack")
        },
        {
            PackName = "Rare Seed Pack",
            Rarity = "Rare",
            IMG = "rbxassetid://100209155560487",
            CustomProgressBased = true,
            TargetPercentile = 0.35,
            Spread = 0.15,
            Model = l__SeedPacks__2:WaitForChild("Rare Seed Pack")
        },
        {
            PackName = "Mythic Seed Pack",
            Rarity = "Mythic",
            IMG = "rbxassetid://107746478038169",
            CustomProgressBased = true,
            TargetPercentile = 0.5,
            Spread = 0.15,
            Model = l__SeedPacks__2:WaitForChild("Mythic Seed Pack")
        },
        {
            PackName = "Legendary Seed Pack",
            Rarity = "Legendary",
            IMG = "rbxassetid://125344445268180",
            CustomProgressBased = true,
            TargetPercentile = 0.65,
            Spread = 0.13,
            Model = l__SeedPacks__2:WaitForChild("Legendary Seed Pack")
        },
        {
            PackName = "Super Seed Pack",
            Rarity = "Super",
            IMG = "rbxassetid://99496177404475",
            CustomProgressBased = true,
            TargetPercentile = 0.78,
            Spread = 0.13,
            Model = l__SeedPacks__2:WaitForChild("Super Seed Pack")
        },
        {
            PackName = "Secret Seed Pack",
            Rarity = "Secret",
            IMG = "rbxassetid://113604428669546",
            CustomProgressBased = true,
            TargetPercentile = 0.87,
            Spread = 0.13,
            Model = l__SeedPacks__2:WaitForChild("Secret Seed Pack")
        }
    }
};
function u1.GetData(p2) --[[ Line: 95 ]]
    -- upvalues: u1 (copy)
    for _, v3 in u1.Data do
        if v3.PackName == p2 then
            return v3;
        end;
    end;
    return nil;
end;
local u4 = nil;
local function u13() --[[ Line: 116 ]]
    -- upvalues: u4 (ref), l__SeedData__3 (copy), l__SellValueData__4 (copy)
    if u4 then
        return u4;
    end;
    local v5 = {};
    for _, v6 in l__SeedData__3 do
        if v6.RestockShop and v6.SeedName then
            local v7 = {
                Name = v6.SeedName
            };
            local v8 = l__SellValueData__4[v6.SeedName] or 0;
            if not v6.IsSingleHarvest then
                v8 = v8 * 6;
            end;
            v7.Gen = v8;
            table.insert(v5, v7);
        end;
    end;
    table.sort(v5, function(p9, p10) --[[ Line: 131 ]]
        if p9.Gen == p10.Gen then
            return p9.Name < p10.Name;
        else
            return p9.Gen < p10.Gen;
        end;
    end);
    local v11 = {};
    for _, v12 in v5 do
        table.insert(v11, v12.Name);
    end;
    u4 = v11;
    return v11;
end;
function u1.GetRandomSeed(p14, p15) --[[ Line: 155 ]]
    -- upvalues: u1 (copy), u13 (copy)
    local v16 = u1.GetData(p14);
    if not v16 then
        return nil;
    end;
    if v16.Seeds and #v16.Seeds > 0 then
        local v17 = 0;
        for _, v18 in v16.Seeds do
            v17 = v17 + v18.Chance;
        end;
        local v19 = math.random() * v17;
        local v20 = 0;
        for _, v21 in v16.Seeds do
            v20 = v20 + v21.Chance;
            if v19 <= v20 then
                return v21.SeedName;
            end;
        end;
        return v16.Seeds[#v16.Seeds].SeedName;
    end;
    local v22 = u13();
    if #v22 == 0 then
        return nil;
    end;
    if #v22 == 1 then
        return v22[1];
    end;
    local v23 = v16.TargetPercentile or 0.5;
    local v24 = v16.Spread or 0.15;
    if p15 and p15 > 0 then
        v23 = math.min(1, v23 + p15);
    end;
    local v25 = v24 <= 0 and 0.0001 or v24;
    local v26 = #v22;
    local v27 = table.create(v26);
    local v28 = 0;
    for v29 = 1, v26 do
        local v30 = ((v29 - 1) / (v26 - 1) - v23) / v25;
        local v31 = math.exp(-0.5 * v30 * v30);
        v27[v29] = v31;
        v28 = v28 + v31;
    end;
    if v28 <= 0 then
        return v22[v26];
    end;
    local v32 = math.random() * v28;
    local v33 = 0;
    for v34 = 1, v26 do
        v33 = v33 + v27[v34];
        if v32 <= v33 then
            return v22[v34];
        end;
    end;
    return v22[v26];
end;
return u1;