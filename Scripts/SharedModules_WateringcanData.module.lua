-- Decompiled with Potassium's decompiler.

local l__GearImages__1 = script.Parent.GearImages;
local v1 = {};
local v2 = {
    Name = "Common Watering Can",
    GrowthSpeedMultiplier = 3,
    EffectTime = 10,
    SplashRadius = 5
};
local v3 = l__GearImages__1:FindFirstChild("Common Watering Can");
v2.Image = v3 and v3.Value or "";
local v4 = {
    Name = "Super Watering Can",
    GrowthSpeedMultiplier = 300,
    EffectTime = 15,
    SplashRadius = 8
};
local v5 = l__GearImages__1:FindFirstChild("Super Watering Can");
v4.Image = v5 and v5.Value or "";
v1[1], v1[2] = v2, v4;
return v1;