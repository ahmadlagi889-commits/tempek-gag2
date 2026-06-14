-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 2
};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Gardens__2 = workspace:WaitForChild("Gardens");
local l__PlotAssets__3 = l__ReplicatedStorage__1:WaitForChild("Assets"):WaitForChild("PlotAssets");
local l__TopLayer__4 = workspace:WaitForChild("Baseplate").TopLayer;
local u2 = nil;
local u3 = nil;
local u4 = {};
local u5 = {};
local u6 = {};
local function u10(p7, p8) --[[ Line: 41 ]]
    local v9 = p7:FindFirstChild("BottomFace", true);
    if v9 and v9:IsA("BasePart") then
        local l__Y__5 = (v9.CFrame * CFrame.new(0, -v9.Size.Y * 0.5, 0)).Position.Y;
        if math.abs(p8 - l__Y__5) > 0.0001 then
            p7:TranslateBy((Vector3.new(0, p8 - l__Y__5, 0)));
        end;
    end;
end;
local function u17(p11) --[[ Line: 51 ]]
    -- upvalues: l__PlotAssets__3 (copy)
    local v12 = l__PlotAssets__3:FindFirstChild("FenceThemes");
    local v13;
    if v12 then
        v13 = v12:FindFirstChild("Default");
    else
        v13 = v12;
    end;
    local v14 = (typeof(p11) ~= "string" or (p11 == "" or not p11)) and "Default" or p11;
    if v12 then
        v12 = v12:FindFirstChild(v14);
    end;
    if not v12 then
        v12 = v13;
        v14 = "Default";
    end;
    if not v12 then
        return nil, nil, "Default";
    end;
    local v15 = v12:FindFirstChild("FencePole");
    local v16 = v12:FindFirstChild("FenceConnectors");
    if v13 then
        v15 = v15 or v13:FindFirstChild("FencePole");
        v16 = v16 or v13:FindFirstChild("FenceConnectors");
    end;
    return v15, v16, v14;
end;
local function u85(p18, u19, p20) --[[ Line: 75 ]]
    -- upvalues: u2 (ref), l__PlotAssets__3 (copy), u3 (ref), u4 (copy), u17 (copy), l__TopLayer__4 (copy), u10 (copy)
    if not u2 then
        local l__BedSection__6 = l__PlotAssets__3.BedSection;
        local v21 = l__BedSection__6:FindFirstChild("BottomFace", true);
        u2 = v21 and (v21:IsA("BasePart") and v21.Size) or l__BedSection__6:GetExtentsSize();
        local l__FRONT_BedSection__7 = l__PlotAssets__3.FRONT_BedSection;
        local v22 = l__FRONT_BedSection__7:FindFirstChild("BottomFace", true);
        u3 = v22 and (v22:IsA("BasePart") and v22.Size) or l__FRONT_BedSection__7:GetExtentsSize();
    end;
    local u23 = u4[u19];
    if not u23 then
        u23 = {
            fenceSkin = "Default",
            poles = {},
            connectors = {},
            beds = {}
        };
        u4[u19] = u23;
    end;
    local u24, u25, v26 = u17(p20);
    if u24 and u25 then
        if u23.fenceSkin ~= v26 then
            for _, v27 in u23.poles do
                v27:Destroy();
            end;
            for _, v28 in u23.connectors do
                v28:Destroy();
            end;
            u23.poles = {};
            u23.connectors = {};
            u23.fenceSkin = v26;
        end;
        local v29 = u24:FindFirstChild("BottomFace", true);
        local u30 = v29 and (v29:IsA("BasePart") and v29.Size) or u24:GetExtentsSize();
        local v31 = u25:FindFirstChild("BottomFace", true);
        local u32 = v31 and (v31:IsA("BasePart") and v31.Size) or u25:GetExtentsSize();
        local u33 = u30.X + u32.X;
        local v34 = math.ceil(18 / u33);
        local u35 = l__TopLayer__4.Position.Y + l__TopLayer__4.Size.X * 0.5;
        local v36 = math.floor((p18.Size.Z - u3.X) / (u2.X + 0)) + 1;
        local v37 = math.max(1, v36);
        local v38 = u3.X + (v37 - 1) * (u2.X + 0);
        local v39 = 2 * u2.Z + 11 + 5;
        local v40 = v38 + 4;
        local v41 = math.ceil(v39 / u33);
        local v42;
        if v34 > 0 then
            v42 = math.max(v41, v34 + 2);
            if (v42 - v34) % 2 ~= 0 then
                v42 = v42 + 1 or v42;
            end;
        else
            v42 = math.max(v41, 1);
        end;
        local v43 = math.ceil(v40 / u33);
        local v44 = math.max(1, v43);
        local v45 = v42 * u33;
        local v46 = v44 * u33;
        local v47 = v45 * 0.5;
        local v48 = v46 * 0.5;
        local v49 = p18.Size.Z * 0.5 - v48;
        local u50 = 1;
        local u51 = 1;
        local u52 = {};
        local u53 = {};
        local function v66(p54, p55, p56, p57, p58) --[[ Line: 132 ]]
            -- upvalues: u23 (ref), u50 (ref), u24 (copy), u19 (copy), u52 (copy), u33 (copy), u10 (ref), u35 (copy), u51 (ref), u25 (copy), u53 (copy), u30 (copy), u32 (copy)
            local v59 = p57 and (math.floor((p56 - p58) / 2 + 1e-6) or -1) or -1;
            local v60 = p57 and (v59 + p58 - 1 or -1) or -1;
            for v61 = 0, p56 do
                if not p57 or (v59 + 1 > v61 or v61 > v60) then
                    local v62 = u23.poles[u50] or u24:Clone();
                    if not u23.poles[u50] then
                        v62.Parent = u19;
                    end;
                    u52[u50] = v62;
                    v62:PivotTo(CFrame.lookAt(p54 + p55 * (v61 * u33), p54 + p55 * (v61 * u33) + p55) * CFrame.Angles(0, 1.5707963267948966, 0));
                    u10(v62, u35);
                    u50 = u50 + 1;
                end;
            end;
            for v63 = 0, p56 - 1 do
                if not p57 or (v59 > v63 or v63 > v60) then
                    local v64 = u23.connectors[u51] or u25:Clone();
                    if not u23.connectors[u51] then
                        v64.Parent = u19;
                    end;
                    u53[u51] = v64;
                    local v65 = p54 + p55 * (v63 * u33 + u30.X * 0.5 + u32.X * 0.5);
                    v64:PivotTo(CFrame.lookAt(v65, v65 + p55) * CFrame.Angles(0, 1.5707963267948966, 0));
                    u10(v64, u35);
                    u51 = u51 + 1;
                end;
            end;
        end;
        local l__CFrame__8 = p18.CFrame;
        v66(l__CFrame__8:PointToWorldSpace((Vector3.new(-v47, 0, -v48 + v49))), l__CFrame__8:VectorToWorldSpace(Vector3.new(1, 0, 0)), v42, false, 0);
        v66(l__CFrame__8:PointToWorldSpace((Vector3.new(v47, 0, -v48 + v49))), l__CFrame__8:VectorToWorldSpace(Vector3.new(0, 0, 1)), v44, false, 0);
        v66(l__CFrame__8:PointToWorldSpace((Vector3.new(v47, 0, v48 + v49))), l__CFrame__8:VectorToWorldSpace(Vector3.new(-1, 0, 0)), v42, true, v34);
        v66(l__CFrame__8:PointToWorldSpace((Vector3.new(-v47, 0, v48 + v49))), l__CFrame__8:VectorToWorldSpace(Vector3.new(0, 0, -1)), v44, false, 0);
        local v67 = u51;
        for v68 = u50, #u23.poles do
            u23.poles[v68]:Destroy();
        end;
        for v69 = v67, #u23.connectors do
            u23.connectors[v69]:Destroy();
        end;
        u23.poles = u52;
        u23.connectors = u53;
        local v70 = -(u2.Z * 0.5 + 5.5);
        local v71 = u2.Z * 0.5 + 5.5;
        local v72 = -v38 * 0.5 + (v37 - 1) * (u2.X + 0) + u3.X * 0.5;
        local v73 = p18.Size.Z * 0.5 - 2 - u3.X * 0.5;
        local v74 = -v38 * 0.5 + u2.X * 0.5 + (v73 - v72);
        local v75 = 1;
        local v76 = {};
        for v77 = 1, 2 do
            local v78 = v77 == 1 and v70 and v70 or v71;
            for v79 = 1, v37 do
                local v80 = v79 == v37;
                local v81 = v80 and u3 or u2;
                local v82 = v80 and l__PlotAssets__3.FRONT_BedSection or l__PlotAssets__3.BedSection;
                local v83 = u23.beds[v75];
                if v83 and v83.Name ~= v82.Name then
                    v83:Destroy();
                    v83 = nil;
                end;
                if not v83 then
                    v83 = v82:Clone();
                    v83.Parent = u19;
                end;
                v76[v75] = v83;
                v83:PivotTo(l__CFrame__8 * CFrame.new(v78, u35 - p18.Position.Y + v81.Y * 0.5, v80 and v73 and v73 or v74 + (v79 - 1) * (u2.X + 0)) * CFrame.Angles(0, 1.5707963267948966, 0));
                u10(v83, u35);
                v75 = v75 + 1;
            end;
        end;
        for v84 = v75, #u23.beds do
            u23.beds[v84]:Destroy();
        end;
        u23.beds = v76;
    end;
end;
local function u91(p86) --[[ Line: 217 ]]
    -- upvalues: u4 (copy)
    local v87 = u4[p86];
    if v87 then
        for _, v88 in v87.poles do
            v88:Destroy();
        end;
        for _, v89 in v87.connectors do
            v89:Destroy();
        end;
        for _, v90 in v87.beds do
            v90:Destroy();
        end;
        u4[p86] = nil;
    end;
end;
function v1.RenderPlot(_, u92) --[[ Line: 226 ]]
    -- upvalues: u6 (copy), u85 (copy)
    if u6[u92] then
    else
        u6[u92] = true;
        task.defer(function() --[[ Line: 229 ]]
            -- upvalues: u6 (ref), u92 (copy), u85 (ref)
            u6[u92] = nil;
            local v93 = u92:FindFirstChild("PlotSizeReference");
            local v94 = u92:FindFirstChild("Visual");
            if v93 and v94 then
                if v93:IsA("BasePart") and v94:IsA("Folder") then
                    local v95 = u92:GetAttribute("FenceSkin");
                    u85(v93, v94, typeof(v95) == "string" and v95 and v95 or "Default");
                end;
            end;
        end);
    end;
end;
function v1.SetupPlot(u96, u97) --[[ Line: 241 ]]
    -- upvalues: u5 (copy), u91 (copy)
    if u97:IsA("Model") then
        if string.match(u97.Name, "^Plot%d+$") then
            local v98 = u5[u97];
            if v98 then
                for _, v99 in v98 do
                    v99:Disconnect();
                end;
            end;
            local v100 = {};
            u5[u97] = v100;
            local v101 = u97:GetAttributeChangedSignal("FenceSkin");
            table.insert(v100, v101:Connect(function() --[[ Line: 255 ]]
                -- upvalues: u96 (copy), u97 (copy)
                u96:RenderPlot(u97);
            end));
            local v102 = u97:GetAttributeChangedSignal("GardenExpansion");
            table.insert(v100, v102:Connect(function() --[[ Line: 258 ]]
                -- upvalues: u96 (copy), u97 (copy)
                u96:RenderPlot(u97);
            end));
            local v103 = u97:FindFirstChild("PlotSizeReference");
            if v103 and v103:IsA("BasePart") then
                local v104 = v103:GetPropertyChangedSignal("Size");
                table.insert(v100, v104:Connect(function() --[[ Line: 264 ]]
                    -- upvalues: u96 (copy), u97 (copy)
                    u96:RenderPlot(u97);
                end));
                local v105 = v103:GetPropertyChangedSignal("CFrame");
                table.insert(v100, v105:Connect(function() --[[ Line: 267 ]]
                    -- upvalues: u96 (copy), u97 (copy)
                    u96:RenderPlot(u97);
                end));
            end;
            table.insert(v100, u97.AncestryChanged:Connect(function(_, p106) --[[ Line: 272 ]]
                -- upvalues: u97 (copy), u91 (ref), u5 (ref)
                if p106 then
                else
                    local v107 = u97:FindFirstChild("Visual");
                    if v107 and v107:IsA("Folder") then
                        u91(v107);
                    end;
                    local v108 = u5[u97];
                    if v108 then
                        for _, v109 in v108 do
                            v109:Disconnect();
                        end;
                        u5[u97] = nil;
                    end;
                end;
            end));
            u96:RenderPlot(u97);
        end;
    end;
end;
function v1.Init(_) --[[ Line: 290 ]] end;
function v1.Start(u110) --[[ Line: 293 ]]
    -- upvalues: l__Gardens__2 (copy)
    for _, v111 in l__Gardens__2:GetChildren() do
        u110:SetupPlot(v111);
    end;
    l__Gardens__2.ChildAdded:Connect(function(p112) --[[ Line: 298 ]]
        -- upvalues: u110 (copy)
        u110:SetupPlot(p112);
    end);
end;
return v1;