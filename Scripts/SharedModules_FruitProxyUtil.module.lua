-- Decompiled with Potassium's decompiler.

local l__WeightFormat__1 = require(script.Parent.WeightFormat);
local v1 = {};
local function u8(p2, p3) --[[ Line: 19 ]]
    -- upvalues: l__WeightFormat__1 (copy)
    for v4, v5 in p3 do
        p2:SetAttribute(v4, v5);
    end;
    p2:SetAttribute("HarvestedFruit", true);
    p2:SetAttribute("Fruit", p3.FruitName);
    p2:SetAttribute("Weight", p3.Weight);
    local v6 = l__WeightFormat__1.FormatGrams(p3.Weight or 0);
    local v7 = p3.Mutation and (` [{p3.Mutation}]` or "") or "";
    p2.Name = `{p3.FruitName}{v7} [{v6}]`;
end;
local l__Networking__2 = require(script.Parent.Networking);
function v1.IsFruitProxy(p9) --[[ Line: 7 ]]
    local v10 = p9:IsA("Configuration");
    if v10 then
        v10 = p9:GetAttribute("FruitProxy") == true;
    end;
    return v10;
end;
function v1.IsFruitTool(p11) --[[ Line: 11 ]]
    local v12 = p11:IsA("Tool");
    if v12 then
        v12 = p11:GetAttribute("HarvestedFruit") == true;
    end;
    return v12;
end;
function v1.IsFruitInstance(p13) --[[ Line: 15 ]]
    local v14 = p13:IsA("Configuration");
    if v14 then
        v14 = p13:GetAttribute("FruitProxy") == true;
    end;
    local v15 = not v14 and p13:IsA("Tool");
    if v15 then
        v15 = p13:GetAttribute("HarvestedFruit") == true;
    end;
    return v15;
end;
v1.SetFruitAttributes = u8;
function v1.CreateProxy(p16) --[[ Line: 32 ]]
    -- upvalues: u8 (copy)
    local v17 = Instance.new("Configuration");
    v17:SetAttribute("FruitProxy", true);
    u8(v17, p16);
    return v17;
end;
function v1.CreateTool(p18, p19) --[[ Line: 39 ]]
    -- upvalues: u8 (copy)
    local v20 = p18:Clone();
    u8(v20, p19);
    return v20;
end;
function v1.RequestPromote(u21) --[[ Line: 47 ]]
    -- upvalues: l__Networking__2 (copy)
    task.spawn(function() --[[ Line: 48 ]]
        -- upvalues: l__Networking__2 (ref), u21 (copy)
        l__Networking__2.Backpack.PromoteFruit:Fire(u21);
    end);
end;
function v1.RequestDemote(u22) --[[ Line: 53 ]]
    -- upvalues: l__Networking__2 (copy)
    task.spawn(function() --[[ Line: 54 ]]
        -- upvalues: l__Networking__2 (ref), u22 (copy)
        l__Networking__2.Backpack.DemoteFruit:Fire(u22);
    end);
end;
v1.Pending = {
    Equip = nil,
    Slots = {}
};
return v1;