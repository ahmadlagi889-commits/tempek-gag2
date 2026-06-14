-- Decompiled with Potassium's decompiler.

local u1 = {
    Products = {},
    Gamepasses = {}
};
local u2 = {};
local u3 = {};
local u4 = {};
for _, v5 in u1.Products do
    if type(v5) == "table" and type(v5.Key) == "string" then
        u3[v5.Key] = v5;
    end;
    if type(v5) == "table" and type(v5.ProductId) == "number" then
        u2[v5.ProductId] = v5;
    end;
end;
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.SharedModules.SeedData);
require(l__ReplicatedStorage__1.SharedModules.Networking);
local l__SeedShop__2 = l__ReplicatedStorage__1:WaitForChild("StockValues"):WaitForChild("SeedShop");
l__SeedShop__2:WaitForChild("Items");
l__SeedShop__2:WaitForChild("UnixNextRestock");
l__SeedShop__2:WaitForChild("UnixLastRestock");
function u1.GetByKey(p6) --[[ Line: 41 ]]
    -- upvalues: u3 (copy)
    return u3[p6];
end;
function u1.GetByProductId(p7) --[[ Line: 45 ]]
    -- upvalues: u2 (copy)
    return u2[p7];
end;
function u1.GetSeedProductKey(p8) --[[ Line: 49 ]]
    return "Seed:" .. p8;
end;
function u1.AddProduct(p9) --[[ Line: 53 ]]
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    u1.Products[#u1.Products + 1] = p9;
    if type(p9) == "table" and type(p9.Key) == "string" then
        u3[p9.Key] = p9;
    end;
    if type(p9) == "table" and type(p9.ProductId) == "number" then
        u2[p9.ProductId] = p9;
    end;
end;
function u1.AddGamepass(p10) --[[ Line: 57 ]]
    -- upvalues: u1 (copy), u4 (copy)
    u1.Gamepasses[p10.Key] = p10;
    if type(p10.GamepassId) == "number" then
        u4[p10.GamepassId] = p10;
    end;
end;
function u1.GetByGamepassId(p11) --[[ Line: 64 ]]
    -- upvalues: u4 (copy)
    return u4[p11];
end;
function u1.GetGamepassByKey(p12) --[[ Line: 68 ]]
    -- upvalues: u1 (copy)
    return u1.Gamepasses[p12];
end;
return u1;