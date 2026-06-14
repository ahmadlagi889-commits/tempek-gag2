-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__Name__3 = script.Name;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = 200;
local u6 = 0.016666666666666666;
local u7 = 1;
local function v12(p8) --[[ Line: 43 ]]
    -- upvalues: u3 (copy), u2 (copy), u4 (copy), u7 (ref)
    local v9 = u3[p8];
    if v9 then
        local v10 = #u2;
        local v11 = u2[v10];
        u2[v9] = v11;
        u3[v11] = v9;
        u2[v10] = nil;
        u3[p8] = nil;
        u4[p8] = nil;
        if u7 > #u2 then
            u7 = 1;
        end;
    end;
end;
local u13 = u7;
local function v15(p14) --[[ Line: 31 ]]
    -- upvalues: u3 (copy), u2 (copy), u4 (copy)
    if p14:IsA("Texture") then
        if u3[p14] then
        else
            p14.OffsetStudsV = math.random(1, 20);
            p14.OffsetStudsU = math.random(1, 20);
            table.insert(u2, p14);
            u3[p14] = #u2;
            u4[p14] = os.clock();
        end;
    end;
end;
for _, v16 in l__CollectionService__2:GetTagged(l__Name__3) do
    v15(v16);
end;
l__CollectionService__2:GetInstanceAddedSignal(l__Name__3):Connect(v15);
l__CollectionService__2:GetInstanceRemovedSignal(l__Name__3):Connect(v12);
function v1.Start(_) --[[ Line: 69 ]]
    -- upvalues: l__RunService__1 (copy), u2 (copy), u6 (ref), u5 (ref), u13 (ref), u4 (copy)
    l__RunService__1.Heartbeat:Connect(function(p17) --[[ Line: 70 ]]
        -- upvalues: u2 (ref), u6 (ref), u5 (ref), u13 (ref), u4 (ref)
        local v18 = #u2;
        if v18 == 0 then
        else
            u6 = u6 + (p17 - u6) * 0.1;
            if u6 > 0.019166666666666665 then
                local v19 = math.floor(u5 * 0.85);
                u5 = math.max(20, v19);
            else
                u5 = math.min(200, u5 + 2);
            end;
            local v20 = math.min(v18, u5);
            local v21 = os.clock();
            for _ = 1, v20 do
                local v22 = u2[u13];
                if v22 and v22.Parent then
                    local v23 = v21 - (u4[v22] or v21);
                    u4[v22] = v21;
                    local v24 = v22.OffsetStudsV + 2 * v23;
                    local l__StudsPerTileV__4 = v22.StudsPerTileV;
                    if l__StudsPerTileV__4 > 0 then
                        v24 = v24 % l__StudsPerTileV__4;
                    end;
                    v22.OffsetStudsV = v24;
                end;
                u13 = u13 + 1;
                if v18 < u13 then
                    u13 = 1;
                end;
            end;
        end;
    end);
end;
return v1;