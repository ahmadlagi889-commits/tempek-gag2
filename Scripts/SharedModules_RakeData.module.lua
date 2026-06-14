-- Decompiled with Potassium's decompiler.

local v1 = {};
local v2 = {
    RakeName = "Rake",
    Lifetime = 600,
    Cooldown = 3,
    Radius = 7
};
local v3 = script.Parent.GearImages:FindFirstChild("Rake");
v2.Image = v3 and v3.Value or "";
v1[1] = v2;
return v1;