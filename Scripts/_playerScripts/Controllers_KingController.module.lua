-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__ServerValues__2 = l__ReplicatedStorage__1.ServerValues;
local l__KingFruitID__3 = l__ServerValues__2.KingFruitID;
local l__KingEnabled__4 = l__ServerValues__2.KingEnabled;
local l__Gardens__5 = workspace:WaitForChild("Gardens");
local u1 = {};
local v2 = {
    StartOrder = 3
};
for _, v3 in require(l__ReplicatedStorage__1.SharedModules.SeedData) do
    local v4 = v3.SeedName or v3.PlantName;
    if v3.IsSingleHarvest then
        u1[v4] = true;
    end;
end;
local u5 = nil;
local u6 = nil;
local u7 = 0;
local u8 = 0;
local function u13(p9) --[[ Line: 45 ]]
    local v10 = 0;
    local v11 = Vector3.new(0, 0, 0);
    for _, v12 in p9:GetDescendants() do
        if v12:IsA("BasePart") and v12.Transparency < 1 then
            v10 = v10 + 1;
            v11 = v11 + v12.Position;
        end;
    end;
    if v10 == 0 then
        return nil;
    else
        return v11 / v10;
    end;
end;
local function u22() --[[ Line: 102 ]]
    -- upvalues: l__KingEnabled__4 (copy), u7 (ref), u5 (ref), u6 (ref), u8 (ref), l__KingFruitID__3 (copy), l__Gardens__5 (copy), u1 (copy), u13 (copy)
    if l__KingEnabled__4.Value then
        u8 = u8 + 1;
        local u14 = u8;
        local l__Value__6 = l__KingFruitID__3.Value;
        task.spawn(function() --[[ Line: 112 ]]
            -- upvalues: u14 (copy), u8 (ref), l__Gardens__5 (ref), u1 (ref), l__Value__6 (copy), u7 (ref), u5 (ref), u6 (ref), u13 (ref)
            while u14 == u8 do
                for _, v15 in l__Gardens__5:GetChildren() do
                    for _, v16 in v15.Plants:GetChildren() do
                        if not u1[v16.Name] then
                            local v17 = v16:FindFirstChild("Fruits");
                            if v17 then
                                for _, u18 in v17:GetChildren() do
                                    if u18:GetAttribute("FruitId") == l__Value__6 then
                                        u7 = u7 + 1;
                                        if u5 then
                                            u5:Destroy();
                                            u5 = nil;
                                        end;
                                        if u6 then
                                            u6:Destroy();
                                            u6 = nil;
                                        end;
                                        u7 = u7 + 1;
                                        local u19 = u7;
                                        task.spawn(function() --[[ Line: 64 ]]
                                            -- upvalues: u19 (copy), u7 (ref), u13 (ref), u18 (copy), u5 (ref), u6 (ref)
                                            local v20 = nil;
                                            while u19 == u7 do
                                                v20 = u13(u18);
                                                if v20 then
                                                    break;
                                                end;
                                                if not u18.Parent then
                                                    return;
                                                end;
                                                task.wait(0.1);
                                            end;
                                            if u19 ~= u7 then
                                                return;
                                            end;
                                            u5 = Instance.new("Highlight");
                                            u5.FillTransparency = 0.25;
                                            u5.OutlineTransparency = 0.5;
                                            u5.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                                            u5.FillColor = Color3.new(1, 0.784314, 0);
                                            u5.OutlineColor = Color3.new(1, 0.784314, 0);
                                            u5.Adornee = u18;
                                            u5.Name = "KingHighlight";
                                            u5.Parent = u18;
                                            u6 = script.attRef:Clone();
                                            u6.Parent = u18;
                                            u6.WorldCFrame = CFrame.new(v20);
                                            local l__CurrentCamera__7 = workspace.CurrentCamera;
                                            while u19 == u7 do
                                                local l__Position__8 = l__CurrentCamera__7.CFrame.Position;
                                                if not (u18.Parent and u18.PrimaryPart) then
                                                    break;
                                                end;
                                                local l__Position__9 = u18.PrimaryPart.Position;
                                                local v21 = (Vector3.new(l__Position__8.X, 0, l__Position__8.Z) - Vector3.new(l__Position__9.X, 0, l__Position__9.Z)).Magnitude < 200;
                                                u5.Enabled = v21;
                                                u6.BillboardGui.Enabled = v21;
                                                task.wait();
                                            end;
                                        end);
                                        return;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                task.wait(0.5);
            end;
        end);
    else
        u7 = u7 + 1;
        if u5 then
            u5:Destroy();
            u5 = nil;
        end;
        if u6 then
            u6:Destroy();
            u6 = nil;
        end;
        u8 = u8 + 1;
    end;
end;
function v2.Init(_) --[[ Line: 134 ]]
    -- upvalues: l__KingEnabled__4 (copy), u7 (ref), u5 (ref), u6 (ref), u8 (ref), l__KingFruitID__3 (copy), l__Gardens__5 (copy), u1 (copy), u13 (copy), u22 (copy)
    if l__KingEnabled__4.Value then
        if l__KingEnabled__4.Value then
            u8 = u8 + 1;
            local u23 = u8;
            local l__Value__10 = l__KingFruitID__3.Value;
            task.spawn(function() --[[ Line: 112 ]]
                -- upvalues: u23 (copy), u8 (ref), l__Gardens__5 (ref), u1 (ref), l__Value__10 (copy), u7 (ref), u5 (ref), u6 (ref), u13 (ref)
                while u23 == u8 do
                    for _, v24 in l__Gardens__5:GetChildren() do
                        for _, v25 in v24.Plants:GetChildren() do
                            if not u1[v25.Name] then
                                local v26 = v25:FindFirstChild("Fruits");
                                if v26 then
                                    for _, u27 in v26:GetChildren() do
                                        if u27:GetAttribute("FruitId") == l__Value__10 then
                                            u7 = u7 + 1;
                                            if u5 then
                                                u5:Destroy();
                                                u5 = nil;
                                            end;
                                            if u6 then
                                                u6:Destroy();
                                                u6 = nil;
                                            end;
                                            u7 = u7 + 1;
                                            local u28 = u7;
                                            task.spawn(function() --[[ Line: 64 ]]
                                                -- upvalues: u28 (copy), u7 (ref), u13 (ref), u27 (copy), u5 (ref), u6 (ref)
                                                local v29 = nil;
                                                while u28 == u7 do
                                                    v29 = u13(u27);
                                                    if v29 then
                                                        break;
                                                    end;
                                                    if not u27.Parent then
                                                        return;
                                                    end;
                                                    task.wait(0.1);
                                                end;
                                                if u28 ~= u7 then
                                                    return;
                                                end;
                                                u5 = Instance.new("Highlight");
                                                u5.FillTransparency = 0.25;
                                                u5.OutlineTransparency = 0.5;
                                                u5.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                                                u5.FillColor = Color3.new(1, 0.784314, 0);
                                                u5.OutlineColor = Color3.new(1, 0.784314, 0);
                                                u5.Adornee = u27;
                                                u5.Name = "KingHighlight";
                                                u5.Parent = u27;
                                                u6 = script.attRef:Clone();
                                                u6.Parent = u27;
                                                u6.WorldCFrame = CFrame.new(v29);
                                                local l__CurrentCamera__11 = workspace.CurrentCamera;
                                                while u28 == u7 do
                                                    local l__Position__12 = l__CurrentCamera__11.CFrame.Position;
                                                    if not (u27.Parent and u27.PrimaryPart) then
                                                        break;
                                                    end;
                                                    local l__Position__13 = u27.PrimaryPart.Position;
                                                    local v30 = (Vector3.new(l__Position__12.X, 0, l__Position__12.Z) - Vector3.new(l__Position__13.X, 0, l__Position__13.Z)).Magnitude < 200;
                                                    u5.Enabled = v30;
                                                    u6.BillboardGui.Enabled = v30;
                                                    task.wait();
                                                end;
                                            end);
                                            return;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                    task.wait(0.5);
                end;
            end);
        else
            u7 = u7 + 1;
            if u5 then
                u5:Destroy();
                u5 = nil;
            end;
            if u6 then
                u6:Destroy();
                u6 = nil;
            end;
            u8 = u8 + 1;
        end;
    end;
    l__KingFruitID__3:GetPropertyChangedSignal("Value"):Connect(u22);
    l__Gardens__5.ChildAdded:Connect(u22);
    l__KingEnabled__4:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 142 ]]
        -- upvalues: l__KingEnabled__4 (ref), u7 (ref), u5 (ref), u6 (ref), u8 (ref), l__KingFruitID__3 (ref), l__Gardens__5 (ref), u1 (ref), u13 (ref)
        if l__KingEnabled__4.Value then
            if l__KingEnabled__4.Value then
                u8 = u8 + 1;
                local u31 = u8;
                local l__Value__14 = l__KingFruitID__3.Value;
                task.spawn(function() --[[ Line: 112 ]]
                    -- upvalues: u31 (copy), u8 (ref), l__Gardens__5 (ref), u1 (ref), l__Value__14 (copy), u7 (ref), u5 (ref), u6 (ref), u13 (ref)
                    while u31 == u8 do
                        for _, v32 in l__Gardens__5:GetChildren() do
                            for _, v33 in v32.Plants:GetChildren() do
                                if not u1[v33.Name] then
                                    local v34 = v33:FindFirstChild("Fruits");
                                    if v34 then
                                        for _, u35 in v34:GetChildren() do
                                            if u35:GetAttribute("FruitId") == l__Value__14 then
                                                u7 = u7 + 1;
                                                if u5 then
                                                    u5:Destroy();
                                                    u5 = nil;
                                                end;
                                                if u6 then
                                                    u6:Destroy();
                                                    u6 = nil;
                                                end;
                                                u7 = u7 + 1;
                                                local u36 = u7;
                                                task.spawn(function() --[[ Line: 64 ]]
                                                    -- upvalues: u36 (copy), u7 (ref), u13 (ref), u35 (copy), u5 (ref), u6 (ref)
                                                    local v37 = nil;
                                                    while u36 == u7 do
                                                        v37 = u13(u35);
                                                        if v37 then
                                                            break;
                                                        end;
                                                        if not u35.Parent then
                                                            return;
                                                        end;
                                                        task.wait(0.1);
                                                    end;
                                                    if u36 ~= u7 then
                                                        return;
                                                    end;
                                                    u5 = Instance.new("Highlight");
                                                    u5.FillTransparency = 0.25;
                                                    u5.OutlineTransparency = 0.5;
                                                    u5.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                                                    u5.FillColor = Color3.new(1, 0.784314, 0);
                                                    u5.OutlineColor = Color3.new(1, 0.784314, 0);
                                                    u5.Adornee = u35;
                                                    u5.Name = "KingHighlight";
                                                    u5.Parent = u35;
                                                    u6 = script.attRef:Clone();
                                                    u6.Parent = u35;
                                                    u6.WorldCFrame = CFrame.new(v37);
                                                    local l__CurrentCamera__15 = workspace.CurrentCamera;
                                                    while u36 == u7 do
                                                        local l__Position__16 = l__CurrentCamera__15.CFrame.Position;
                                                        if not (u35.Parent and u35.PrimaryPart) then
                                                            break;
                                                        end;
                                                        local l__Position__17 = u35.PrimaryPart.Position;
                                                        local v38 = (Vector3.new(l__Position__16.X, 0, l__Position__16.Z) - Vector3.new(l__Position__17.X, 0, l__Position__17.Z)).Magnitude < 200;
                                                        u5.Enabled = v38;
                                                        u6.BillboardGui.Enabled = v38;
                                                        task.wait();
                                                    end;
                                                end);
                                                return;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        task.wait(0.5);
                    end;
                end);
            else
                u7 = u7 + 1;
                if u5 then
                    u5:Destroy();
                    u5 = nil;
                end;
                if u6 then
                    u6:Destroy();
                    u6 = nil;
                end;
                u8 = u8 + 1;
            end;
        else
            u7 = u7 + 1;
            if u5 then
                u5:Destroy();
                u5 = nil;
            end;
            if u6 then
                u6:Destroy();
                u6 = nil;
            end;
            u8 = u8 + 1;
        end;
    end);
end;
return v2;