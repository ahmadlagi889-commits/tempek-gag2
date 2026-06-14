-- Decompiled with Potassium's decompiler.

local l__GearImages__1 = script.Parent.GearImages;
local v1 = {};
local v2 = {
    SprinklerName = "Common Sprinkler",
    SizeLuckBonus = 7,
    GrowSpeedBonus = 1.5,
    Lifetime = 120,
    Radius = 20,
    ReviveRate = 0.01
};
local v3 = l__GearImages__1:FindFirstChild("Common Sprinkler");
v2.Image = v3 and v3.Value or "";
local v4 = {
    SprinklerName = "Uncommon Sprinkler",
    SizeLuckBonus = 21,
    GrowSpeedBonus = 2,
    Lifetime = 120,
    Radius = 25,
    ReviveRate = 0.014285714285714285
};
local v5 = l__GearImages__1:FindFirstChild("Uncommon Sprinkler");
v4.Image = v5 and v5.Value or "";
local v6 = {
    SprinklerName = "Rare Sprinkler",
    SizeLuckBonus = 40,
    GrowSpeedBonus = 3,
    Lifetime = 120,
    Radius = 30,
    ReviveRate = 0.025
};
local v7 = l__GearImages__1:FindFirstChild("Rare Sprinkler");
v6.Image = v7 and v7.Value or "";
local v8 = {
    SprinklerName = "Legendary Sprinkler",
    SizeLuckBonus = 65,
    GrowSpeedBonus = 4,
    Lifetime = 120,
    Radius = 40,
    ReviveRate = 0.05
};
local v9 = l__GearImages__1:FindFirstChild("Legendary Sprinkler");
v8.Image = v9 and v9.Value or "";
local v10 = {
    SprinklerName = "Super Sprinkler",
    SizeLuckBonus = 100,
    GrowSpeedBonus = 5,
    Lifetime = 120,
    Radius = 55,
    ReviveRate = 0.1
};
local v11 = l__GearImages__1:FindFirstChild("Super Sprinkler");
v10.Image = v11 and v11.Value or "";
v1[1], v1[2], v1[3], v1[4], v1[5] = v2, v4, v6, v8, v10;
return v1;