-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local function u4(p1) --[[ Line: 5 ]]
    local v2 = {};
    for _, v3 in p1:GetDescendants() do
        if v3:IsA("BasePart") then
            table.insert(v2, v3);
        end;
    end;
    return v2;
end;
local function u9(p5, p6) --[[ Line: 15 ]]
    for _, v7 in p5 do
        if v7 ~= p6 then
            v7:BreakJoints();
            local v8 = Instance.new("WeldConstraint");
            v8.Part0 = p6;
            v8.Part1 = v7;
            v8.Parent = p6;
        end;
        v7.Anchored = false;
    end;
    p6.Anchored = false;
end;
local function v12(p10) --[[ Line: 30 ]]
    -- upvalues: u4 (copy), u9 (copy)
    local v11 = u4(p10);
    if #v11 == 0 then
    else
        if p10:IsA("Model") and p10.PrimaryPart then
            p10 = p10.PrimaryPart;
        elseif not p10:IsA("BasePart") then
            p10 = v11[1];
        end;
        if p10 then
            u9(v11, p10);
        end;
    end;
end;
for _, v13 in l__CollectionService__1:GetTagged("AutoWeld") do
    task.spawn(v12, v13);
end;
l__CollectionService__1:GetInstanceAddedSignal("AutoWeld"):Connect(v12);