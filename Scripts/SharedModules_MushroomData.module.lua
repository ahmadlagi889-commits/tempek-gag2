-- Decompiled with Potassium's decompiler.

local l__GearImages__1 = script.Parent.GearImages;
local v1 = {};
local v2 = {};
local v3 = {
    Name = "Invisibility Mushroom",
    LastTime = 30,
    Description = "Go Invisible"
};
local v4 = l__GearImages__1:FindFirstChild("Invisibility Mushroom");
v3.IMG = v4 and v4.Value or "";
v3.Color = Color3.new(0.666667, 0.666667, 0.666667);
local v5 = {
    Name = "Jump Mushroom",
    LastTime = 60,
    Description = "+5 Jump Power"
};
local v6 = l__GearImages__1:FindFirstChild("Jump Mushroom");
v5.IMG = v6 and v6.Value or "";
v5.Color = Color3.new(0, 0.666667, 1);
local v7 = {
    Name = "Shrink Mushroom",
    LastTime = 45,
    Description = "X0.75 Size"
};
local v8 = l__GearImages__1:FindFirstChild("Shrink Mushroom");
v7.IMG = v8 and v8.Value or "";
v7.Color = Color3.new(1, 0.4, 0.8);
local v9 = {
    Name = "Speed Mushroom",
    LastTime = 60,
    Description = "+5 Speed"
};
local v10 = l__GearImages__1:FindFirstChild("Speed Mushroom");
v9.IMG = v10 and v10.Value or "";
v9.Color = Color3.new(0.811765, 0.12549, 0.14902);
local v11 = {
    Name = "Supersize Mushroom",
    LastTime = 45,
    Description = "X1.25 Size"
};
local v12 = l__GearImages__1:FindFirstChild("Supersize Mushroom");
v11.IMG = v12 and v12.Value or "";
v11.Color = Color3.new(0.419608, 0.196078, 0.486275);
v2[1], v2[2], v2[3], v2[4], v2[5] = v3, v5, v7, v9, v11;
v1.Data = v2;
return v1;