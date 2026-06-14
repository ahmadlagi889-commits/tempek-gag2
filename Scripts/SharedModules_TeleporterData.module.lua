-- Decompiled with Potassium's decompiler.

local v1 = {};
local v2 = {};
local v3 = {
    Name = "Teleporter",
    Description = "Teleport around your garden!",
    TeleportDistance = 15
};
local v4 = script.Parent.GearImages:FindFirstChild("Teleporter");
v3.IMG = v4 and v4.Value or "";
v2[1] = v3;
v1.Data = v2;
return v1;