-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__Debris__3 = game:GetService("Debris");
local u1 = {};
local u2 = {};
local l__Players__4 = game:GetService("Players");
local function u9(p3) --[[ Line: 23 ]]
    -- upvalues: l__Players__4 (copy)
    local v4 = p3 + Vector3.new(0, 10, 0);
    local v5 = RaycastParams.new();
    v5.FilterType = Enum.RaycastFilterType.Exclude;
    local v6 = {};
    for _, v7 in l__Players__4:GetPlayers() do
        if v7.Character then
            table.insert(v6, v7.Character);
        end;
    end;
    v5.FilterDescendantsInstances = v6;
    local v8 = workspace:Raycast(v4, Vector3.new(0, -25, 0), v5);
    if v8 and v8.Instance.Transparency < 1 then
        return v8.Position;
    else
        return nil;
    end;
end;
function u1.FindDropPosition(p10) --[[ Line: 63 ]]
    -- upvalues: u9 (copy), u2 (copy)
    local v11, v12, v13, v14, v15, v16, v17, v18;
    local v19 = 0;
    while true do
        if v19 == 0 then
            v19 = -1;
            -- block 20
            local l__Character__5 = p10.Character;
            if not l__Character__5 then
                return nil;
            end;
            if not l__Character__5.PrimaryPart then
                return nil;
            end;
            local v20 = l__Character__5:GetPivot();
            v12 = v20.Position;
            local _, v21, _ = v20:ToOrientation();
            v13 = v21 + 1.5707963267948966;
            local v22, v23;
            -- NumForInit
local v11, v22, v23 = 10, 30, 1
-- end NumForInit;
            v11 = v11 + v23;
            if v23 > 0 and v11 <= v22 or v23 <= 0 and v11 >= v22 then
                v19 = 3;
                continue;
            else
                break;
            end;
        elseif v19 == 1 then
            v19 = -1;
            local v24, v25;
            -- NumForInit
local v14, v24, v25 = 0, 180, 15
-- end NumForInit;
            v14 = v14 + v25;
            if v25 > 0 and v14 <= v24 or v25 <= 0 and v14 >= v24 then
                return nil;
            else
                break;
            end;
        elseif v19 == 2 then
            v19 = -1;
            local v26, v27, v28;
            if type(v26) == "function" then
                local v29;
                v27, v15 = v26(v29, v28);
            else
                v27, v15 = next(v26, v28);
            end;
            if v27 ~= nil then
                v28 = v27;
                v19 = 1;
                continue;
            else
                break;
            end;
        elseif v19 == 3 then
            v19 = -1;
            local v30 = math.rad(v14 * v15) - v13;
            local v31 = v11 * math.cos(v30);
            local v32 = v11 * math.sin(v30);
            local v33 = u9(v12 + Vector3.new(v31, 0, v32));
            if not v33 then
                v19 = 2;
                continue;
            end;
            v16, v17, v18 = u2, nil, nil;
            v19 = 4;
            continue;
        elseif v19 == 4 then
            v19 = -1;
            local v34, v35;
            if type(v16) == "function" then
                v34, v35 = v16(v17, v18);
            else
                v34, v35 = next(v16, v18);
            end;
            if v34 ~= nil then
                v18 = v34;
                -- block 13
                v19 = 1;
                continue;
            else
                break;
            end;
        else
            break;
        end;
    end;
end;
local u36 = 0;
local function u43(u37, u38) --[[ Line: 143 ]]
    -- upvalues: u36 (ref), l__RunService__1 (copy)
    u36 = u36 + 1;
    local u39 = ("CrateRS_%d"):format(u36);
    local u40 = 0;
    local u41 = false;
    l__RunService__1:BindToRenderStep(u39, Enum.RenderPriority.Last.Value, function(p42) --[[ Line: 153 ]]
        -- upvalues: u41 (ref), u40 (ref), u38 (copy), u37 (copy), l__RunService__1 (ref), u39 (copy)
        if u41 then
        else
            u40 = math.min(u40 + p42, u38);
            if u37(p42, (math.clamp(u40 / u38, 0, 1))) or u38 <= u40 then
                u41 = true;
                l__RunService__1:UnbindFromRenderStep(u39);
            end;
        end;
    end);
    while not u41 do
        task.wait();
    end;
end;
local function u47(p44, p45) --[[ Line: 190 ]]
    local v46 = Vector3.new(p45.X, p44.Y, p45.Z);
    if (p44.Position - v46).Magnitude < 0.001 then
        return p44;
    else
        return CFrame.lookAt(p44.Position, v46);
    end;
end;
local function u50(p48) --[[ Line: 201 ]]
    for _, v49 in p48:GetDescendants() do
        if v49:IsA("BasePart") then
            v49.Anchored = true;
            v49.CanCollide = false;
            v49.CastShadow = false;
            v49.CanQuery = false;
        end;
    end;
end;
local function u60(p51, p52, p53, p54) --[[ Line: 239 ]]
    -- upvalues: l__Debris__3 (copy)
    if p52 then
        if typeof(p52) == "Instance" and p52:IsA("Folder") then
            p52 = p52:GetChildren();
        elseif type(p52) ~= "table" then
            return;
        end;
        if #p52 == 0 then
        else
            local v55 = Instance.new("Part");
            v55.Anchored = true;
            v55.CanCollide = false;
            v55.Transparency = 1;
            v55.Size = Vector3.new(0, 0, 0);
            v55.CFrame = CFrame.new(p51);
            v55.Parent = workspace;
            local v56 = 0;
            for _, v57 in p52 do
                if v57:IsA("ParticleEmitter") then
                    local v58 = v57:Clone();
                    v58.Enabled = false;
                    if p53 then
                        v58.Color = ColorSequence.new(p53);
                    end;
                    v58.Parent = v55;
                    local v59 = v58:GetAttribute("EmitCount") or v58.Rate;
                    v58:Emit((math.ceil(v59)));
                    v56 = math.max(v56, v58.Lifetime.Max);
                end;
            end;
            l__Debris__3:AddItem(v55, p54 or v56 + 0.5);
        end;
    end;
end;
local u61 = UDim2.fromScale(5, 5);
local function u67(p62, p63) --[[ Line: 332 ]]
    -- upvalues: u61 (copy)
    local v64 = Instance.new("Part");
    v64.Anchored = true;
    v64.CanCollide = false;
    v64.CanQuery = false;
    v64.CastShadow = false;
    v64.Transparency = 1;
    v64.Size = Vector3.new(1, 1, 1);
    v64.CFrame = p63;
    local v65 = Instance.new("BillboardGui");
    v65.Name = "ItemImageBillboard";
    v65.Size = u61;
    v65.StudsOffset = Vector3.new(0, 0, 0);
    v65.Adornee = v64;
    v65.AlwaysOnTop = true;
    v65.LightInfluence = 0;
    v65.Parent = v64;
    local v66 = Instance.new("ImageLabel");
    v66.Name = "ItemImage";
    v66.Image = p62;
    v66.Size = UDim2.fromScale(1, 1);
    v66.Position = UDim2.fromScale(0, 0);
    v66.BackgroundTransparency = 1;
    v66.ScaleType = Enum.ScaleType.Fit;
    v66.Parent = v65;
    return v64, 2.5;
end;
local _ = game.SoundService.SFX.CrateSFX;
function u1.Play(p68) --[[ Line: 422 ]]
    -- upvalues: u1 (copy), u9 (copy), u2 (copy), u50 (copy), l__Debris__3 (copy), u43 (copy), u47 (copy), u60 (copy), u67 (copy), u61 (copy), l__TweenService__2 (copy)
    local l__Player__6 = p68.Player;
    local v69 = p68.Rarity or 0.5;
    local v70 = p68.Sounds or {};
    local v71 = math.clamp(1 - v69, 0, 1);
    local v72 = p68.IsBestItem == true;
    local v73 = v72 and 2 or 1;
    local v74 = v72 and 2 or 1;
    local v75;
    if v72 then
        v75 = 1.5 + math.random() * 1.5;
    else
        v75 = nil;
    end;
    local l__VFX__7 = p68.VFX;
    local v76 = p68.Particles or {};
    local l__Impact__8 = v76.Impact;
    if not l__Impact__8 then
        if l__VFX__7 then
            l__Impact__8 = l__VFX__7:FindFirstChild("Impact");
        else
            l__Impact__8 = nil;
        end;
    end;
    local l__Explosion__9 = v76.Explosion;
    if not l__Explosion__9 then
        if l__VFX__7 then
            l__Explosion__9 = l__VFX__7:FindFirstChild("Explosion");
        else
            l__Explosion__9 = nil;
        end;
    end;
    local l__Trail__10 = v76.Trail;
    if not l__Trail__10 then
        if l__VFX__7 then
            l__Trail__10 = l__VFX__7:FindFirstChild("Trail");
        else
            l__Trail__10 = nil;
        end;
    end;
    local u77;
    if p68.ItemImage == nil then
        u77 = false;
    else
        u77 = p68.ItemImage ~= "";
    end;
    local l__Character__11 = l__Player__6.Character;
    local u78 = not (l__Character__11 and l__Character__11.PrimaryPart) and Vector3.new(0, 10, 0) or l__Character__11.PrimaryPart.Position;
    local v79;
    if p68.Position and ((p68.Position - u78).Magnitude < 100 and p68.Position.Magnitude > 1) then
        v79 = p68.Position;
    else
        v79 = u1.FindDropPosition(l__Player__6);
        if not v79 then
            local l__Character__12 = l__Player__6.Character;
            if l__Character__12 and l__Character__12.PrimaryPart then
                local v80 = l__Character__12:GetPivot();
                local v81 = v80.Position + v80.LookVector * 6;
                v79 = u9(v81) or v81 + Vector3.new(0, -3, 0);
            else
                v79 = u78;
            end;
        end;
    end;
    table.insert(u2, v79);
    local u82 = p68.CrateModel:Clone();
    if not u82.PrimaryPart then
        local v83 = u82:FindFirstChild("Center");
        if v83 then
            u82.PrimaryPart = v83;
        else
            local v84 = u82:FindFirstChildWhichIsA("BasePart", true);
            if v84 then
                u82.PrimaryPart = v84;
            end;
        end;
    end;
    u50(u82);
    local u85 = u82:GetExtentsSize().Y / 2;
    local l__PrimaryPart__13 = u82.PrimaryPart;
    local u86 = {};
    local v87;
    if l__Trail__10 then
        local v88 = Instance.new("Attachment");
        v88.Name = "TrailBottom";
        v88.Position = Vector3.new(0, -l__PrimaryPart__13.Size.Y / 2, 0);
        v88.Parent = l__PrimaryPart__13;
        local v89 = Instance.new("Attachment");
        v89.Name = "TrailTop";
        v89.Position = Vector3.new(0, l__PrimaryPart__13.Size.Y / 2, 0);
        v89.Parent = l__PrimaryPart__13;
        v87 = l__Trail__10:Clone();
        v87.Attachment0 = v88;
        v87.Attachment1 = v89;
        v87.Lifetime = 0.5;
        v87.Enabled = false;
        v87.Parent = l__PrimaryPart__13;
        table.insert(u86, v88);
        table.insert(u86, v89);
        table.insert(u86, v87);
    else
        v87 = nil;
    end;
    u82:PivotTo(CFrame.new(u78));
    u82:ScaleTo(0.001);
    u82.Parent = workspace;
    local l__Spawn__14 = v70.Spawn;
    if l__Spawn__14 then
        local v90 = l__Spawn__14:Clone();
        v90.Parent = l__PrimaryPart__13 or workspace;
        v90:Play();
        l__Debris__3:AddItem(v90, v90.TimeLength + 1);
    end;
    if v87 then
        v87.Enabled = true;
    end;
    local u91 = Vector3.new(v79.X, v79.Y + u85, v79.Z);
    local v92 = (u78 + u91) / 2;
    local l__Magnitude__15 = ((u78 - u91) * Vector3.new(1, 0, 1)).Magnitude;
    local l__X__16 = v92.X;
    local v93 = math.max(u78.Y, u91.Y) + l__Magnitude__15;
    local u94 = Vector3.new(l__X__16, v93, v92.Z);
    local function u97(p95) --[[ Line: 176 ]]
        -- upvalues: u78 (copy), u94 (copy), u91 (copy)
        local v96 = 1 - p95;
        return v96 * v96 * u78 + v96 * 2 * p95 * u94 + p95 * p95 * u91;
    end;
    local v98 = CFrame.new(u91);
    local v99 = Vector3.new(u78.X, v98.Y, u78.Z);
    if (v98.Position - v99).Magnitude >= 0.001 then
        v98 = CFrame.lookAt(v98.Position, v99);
    end;
    u43(function(_, p100) --[[ Line: 554 ]]
        -- upvalues: u82 (copy), u47 (ref), u97 (copy), u78 (copy)
        local v101 = u82;
        local v102 = math.clamp(p100 * 2, 0, 1);
        local v103;
        if v102 == 0 then
            v103 = 0;
        elseif v102 == 1 then
            v103 = 1;
        else
            local v104 = v102 * 2;
            if v104 < 1 then
                v103 = math.pow(2, (v104 - 1) * 10) * 0.5 - 0.0005;
            else
                v103 = (-math.pow(2, (v104 - 1) * -10) + 2) * 0.50025;
            end;
        end;
        v101:ScaleTo(v103);
        local v105 = 1 - math.cos(p100 * 3.141592653589793 / 2);
        u82:PivotTo(u47(CFrame.new(u97(v105)), u78));
        return nil;
    end, 0.5);
    u82:ScaleTo(1);
    u82:PivotTo(v98);
    task.delay(0.5, function() --[[ Line: 567 ]]
        -- upvalues: u86 (ref)
        for _, v106 in u86 do
            if v106 then
                v106:Destroy();
            end;
        end;
        u86 = {};
    end);
    u60(v79, l__Impact__8);
    local l__Land__17 = v70.Land;
    if l__Land__17 then
        local v107 = l__Land__17:Clone();
        v107.Parent = l__PrimaryPart__13 or workspace;
        v107:Play();
        l__Debris__3:AddItem(v107, v107.TimeLength + 1);
    end;
    local u108 = u82:GetPivot();
    u43(function(_, p109) --[[ Line: 588 ]]
        -- upvalues: u82 (copy), u108 (copy)
        local v110;
        if p109 < 0.36363636363636365 then
            v110 = p109 * 7.5625 * p109;
        elseif p109 < 0.7272727272727273 then
            local v111 = p109 - 0.5454545454545454;
            v110 = v111 * 7.5625 * v111 + 0.75;
        elseif p109 < 0.9090909090909091 then
            local v112 = p109 - 0.8181818181818182;
            v110 = v112 * 7.5625 * v112 + 0.9375;
        else
            local v113 = p109 - 0.9545454545454546;
            v110 = v113 * 7.5625 * v113 + 0.984375;
        end;
        u82:PivotTo(u108 + Vector3.new(0, 1.5 * (1 - v110), 0));
        return nil;
    end, 0.4);
    u82:PivotTo(u108);
    task.wait(0.5);
    local u114 = u82:GetPivot();
    local v115 = 1.8 * (v71 * 1 + 0.3) * v73;
    local u116 = 15 * (v71 * 1.2 + 0.15);
    local u117 = v75 or v71 * 0.5 + 1;
    local l__Shake__18 = v70.Shake;
    if l__Shake__18 then
        local v118 = l__Shake__18:Clone();
        v118.Parent = l__PrimaryPart__13 or workspace;
        v118:Play();
        l__Debris__3:AddItem(v118, v118.TimeLength + 1);
    end;
    u43(function(_, p119) --[[ Line: 611 ]]
        -- upvalues: u116 (copy), u117 (copy), u85 (copy), u82 (copy), u114 (copy)
        local v120 = math.min(p119 * 2, 1);
        local v121 = v120 * -1 * (v120 - 2);
        local v122 = math.max((p119 - 0.6) / 0.4, 0);
        local v123 = v121 * (1 - v122 * -1 * (v122 - 2));
        local v124 = p119 * 1.2 * 5;
        local v125 = u116 * math.sin(6.283185307179586 * v124) * v123;
        local v126 = math.rad(v125);
        local v127 = u116 * 0.6 * math.sin(6.283185307179586 * v124 * 1.3) * v123;
        local v128 = math.rad(v127);
        local v129 = u116 * 0.3 * math.cos(6.283185307179586 * v124 * 1.7) * v123;
        local v130 = math.rad(v129);
        local v131 = 0.22499999999999998 * math.sin(6.283185307179586 * v124 * 0.8) * v123;
        local v132 = 0.12 * math.cos(6.283185307179586 * v124 * 1.1) * v123;
        local v133 = 1 + (u117 - 1) * v123;
        local v134 = u85 * (v133 - 1);
        u82:ScaleTo(v133);
        u82:PivotTo(u114 * CFrame.fromOrientation(v126, v128, v130) + Vector3.new(v132, v131 + v134, 0));
        return nil;
    end, v115);
    u82:ScaleTo(1);
    u82:PivotTo(u114);
    local l__Position__19 = u114.Position;
    local v135, u136, v137;
    if u77 then
        local v138;
        v138, v135 = u67(p68.ItemImage, CFrame.new(l__Position__19));
        u136 = v138;
        v137 = v138;
        local v139 = v138:FindFirstChild("ItemImageBillboard");
        if v139 then
            v139.Size = UDim2.fromScale(0, 0);
        end;
        v138.Parent = workspace;
    elseif p68.ItemModel then
        u136 = p68.ItemModel:Clone();
        if not u136.PrimaryPart then
            local v140 = u136:FindFirstChild("Center");
            if v140 then
                u136.PrimaryPart = v140;
            else
                local v141 = u136:FindFirstChildWhichIsA("BasePart", true);
                if v141 then
                    u136.PrimaryPart = v141;
                end;
            end;
        end;
        u50(u136);
        v135 = u136:GetExtentsSize().Y / 2;
        u136:PivotTo(u47(CFrame.new(l__Position__19), u78));
        u136.Parent = workspace;
        v137 = u136.PrimaryPart;
    else
        u136 = Instance.new("Part");
        u136.Size = Vector3.new(1, 1, 1);
        u136.Transparency = 1;
        u136.Anchored = true;
        u136.CanCollide = false;
        u136.CFrame = CFrame.new(l__Position__19);
        u136.Parent = workspace;
        v137 = u136;
        v135 = 0.5;
    end;
    local u142;
    if u77 then
        u142 = nil;
    else
        u142 = Instance.new("Highlight");
        u142.FillColor = Color3.new(1, 1, 1);
        u142.OutlineColor = Color3.new(1, 1, 1);
        u142.FillTransparency = 0;
        u142.OutlineTransparency = 0;
        u142.DepthMode = Enum.HighlightDepthMode.Occluded;
        u142.Parent = u136;
    end;
    local u143 = Instance.new("Highlight");
    u143.FillColor = Color3.new(1, 1, 1);
    u143.OutlineColor = Color3.new(1, 1, 1);
    u143.FillTransparency = 0;
    u143.OutlineTransparency = 0;
    u143.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    u143.Parent = u82;
    local l__Explosion__20 = v70.Explosion;
    if l__Explosion__20 then
        local v144 = l__Explosion__20:Clone();
        if v74 then
            v144.Volume = l__Explosion__20.Volume * v74;
        end;
        v144.Parent = l__PrimaryPart__13 or workspace;
        v144:Play();
        l__Debris__3:AddItem(v144, v144.TimeLength + 1);
    end;
    u60(l__Position__19, l__Explosion__9, p68.RarityColor);
    u43(function(_, p145) --[[ Line: 724 ]]
        -- upvalues: u82 (copy), u143 (copy)
        u82:ScaleTo(1 + p145 * 0.5);
        u143.FillTransparency = p145;
        u143.OutlineTransparency = p145;
        for _, v146 in u82:GetDescendants() do
            if v146:IsA("BasePart") then
                v146.Transparency = p145;
            end;
        end;
        return nil;
    end, 0.25);
    u82:Destroy();
    local u147 = Vector3.new(l__Position__19.X, l__Position__19.Y + u85 + v135, l__Position__19.Z);
    local l__Reveal__21 = v70.Reveal;
    if l__Reveal__21 then
        local v148 = l__Reveal__21:Clone();
        v148.Parent = v137 or workspace;
        v148:Play();
        l__Debris__3:AddItem(v148, v148.TimeLength + 1);
    end;
    u60(u147, l__Explosion__9, p68.RarityColor);
    local u149;
    if u77 then
        u149 = u136:FindFirstChild("ItemImageBillboard");
    else
        u149 = nil;
    end;
    u43(function(_, p150) --[[ Line: 759 ]]
        -- upvalues: l__Position__19 (copy), u147 (copy), u77 (copy), u136 (ref), u149 (ref), u61 (ref), u47 (ref), l__Player__6 (copy), u142 (ref)
        local v151;
        if p150 == 0 then
            v151 = 0;
        elseif p150 == 1 then
            v151 = 1;
        else
            local v152 = p150 * 2;
            if v152 < 1 then
                v151 = math.pow(2, (v152 - 1) * 10) * 0.5 - 0.0005;
            else
                v151 = (-math.pow(2, (v152 - 1) * -10) + 2) * 0.50025;
            end;
        end;
        local v153 = l__Position__19:Lerp(u147, v151);
        if u77 then
            u136.CFrame = CFrame.new(v153);
            if u149 then
                local v154 = math.clamp(p150 * 1.5, 0, 1);
                local v155;
                if v154 == 0 then
                    v155 = 0;
                elseif v154 == 1 then
                    v155 = 1;
                else
                    local v156 = v154 * 2;
                    if v156 < 1 then
                        v155 = math.pow(2, (v156 - 1) * 10) * 0.5 - 0.0005;
                    else
                        v155 = (-math.pow(2, (v156 - 1) * -10) + 2) * 0.50025;
                    end;
                end;
                u149.Size = UDim2.fromScale(u61.X.Scale * v155, u61.Y.Scale * v155);
            end;
        else
            local v157 = u136;
            local v158 = u47;
            local v159 = CFrame.new(v153);
            local l__Character__22 = l__Player__6.Character;
            v157:PivotTo(v158(v159, not (l__Character__22 and l__Character__22.PrimaryPart) and Vector3.new(0, 10, 0) or l__Character__22.PrimaryPart.Position));
            if u142 then
                u142.FillTransparency = p150;
                u142.OutlineTransparency = p150;
            end;
        end;
        return nil;
    end, 0.6);
    if u142 then
        u142:Destroy();
    end;
    local v160 = nil;
    if not u77 then
        local v161 = game.ReplicatedStorage.Assets.VFX:FindFirstChild("ItemShine");
        local v162 = v161 and v161:FindFirstChild("Attachment");
        if v162 then
            v162:Clone().Parent = v137;
        end;
    end;
    if p68.BillboardTemplate then
        v160 = p68.BillboardTemplate:Clone();
        local l__Size__23 = v160.Size;
        v160.Size = UDim2.new(l__Size__23.X.Scale * 0.15, l__Size__23.X.Offset * 0.15, l__Size__23.Y.Scale * 0.15, l__Size__23.Y.Offset * 0.15);
        v160.Adornee = v137;
        v160.StudsOffset = Vector3.new(0, v135 + 1.5, 0);
        v160.Parent = u136;
        local v163 = v160:FindFirstChild("Frame");
        if v163 and v163:IsA("Frame") then
            local v164 = v163:FindFirstChild("ItemName");
            if v164 and v164:IsA("TextLabel") then
                v164.Text = p68.ItemName;
            end;
            local v165 = v163:FindFirstChild("ItemLuck");
            if v165 and v165:IsA("TextLabel") then
                local v166;
                if p68.Rarity then
                    v166 = string.format("%s - %.1f%%", p68.RarityName, p68.Rarity * 100);
                else
                    v166 = p68.RarityName;
                end;
                v165.Text = v166;
                v165.TextColor3 = p68.RarityColor;
                local v167 = v165:FindFirstChildWhichIsA("UIGradient");
                if v167 then
                    v167.Color = ColorSequence.new(p68.RarityColor);
                end;
            end;
        end;
        l__TweenService__2:Create(v160, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = l__Size__23
        }):Play();
    end;
    local u168;
    if u77 then
        u168 = u136.Position;
    else
        u168 = u136:GetPivot().Position;
    end;
    u43(function(_, p169) --[[ Line: 868 ]]
        -- upvalues: u168 (ref), u77 (copy), u136 (ref), u47 (ref), l__Player__6 (copy)
        local v170 = math.sin(1.5707963267948966 * p169);
        local v171 = -math.abs(v170) * 2;
        local v172 = u168 + Vector3.new(0, v171, 0);
        if u77 then
            u136.CFrame = CFrame.new(v172);
        else
            local v173 = u136;
            local v174 = u47;
            local v175 = CFrame.new(v172);
            local l__Character__24 = l__Player__6.Character;
            v173:PivotTo(v174(v175, not (l__Character__24 and l__Character__24.PrimaryPart) and Vector3.new(0, 10, 0) or l__Character__24.PrimaryPart.Position));
        end;
        return nil;
    end, 2.5);
    if v160 then
        local l__Size__25 = v160.Size;
        l__TweenService__2:Create(v160, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(l__Size__25.X.Scale * 0.15, l__Size__25.X.Offset * 0.15, l__Size__25.Y.Scale * 0.15, l__Size__25.Y.Offset * 0.15)
        }):Play();
        l__Debris__3:AddItem(v160, 0.15);
    end;
    local u176;
    if u77 then
        u176 = u136.Position;
    else
        u176 = u136:GetPivot().Position;
    end;
    local l__Collect__26 = v70.Collect;
    if l__Collect__26 then
        local v177 = l__Collect__26:Clone();
        v177.Parent = v137 or workspace;
        v177:Play();
        l__Debris__3:AddItem(v177, v177.TimeLength + 1);
    end;
    u43(function(_, p178) --[[ Line: 907 ]]
        -- upvalues: l__Player__6 (copy), u176 (ref), u77 (copy), u136 (ref), u149 (ref), u61 (ref)
        local l__Character__27 = l__Player__6.Character;
        local u179 = not (l__Character__27 and l__Character__27.PrimaryPart) and Vector3.new(0, 10, 0) or l__Character__27.PrimaryPart.Position;
        local u180 = u176;
        local v181 = u176;
        local v182 = (v181 + u179) / 2;
        local l__Magnitude__28 = ((v181 - u179) * Vector3.new(1, 0, 1)).Magnitude;
        local l__X__29 = v182.X;
        local v183 = math.max(v181.Y, u179.Y) + l__Magnitude__28;
        local u184 = Vector3.new(l__X__29, v183, v182.Z);
        local v187 = (function(p185) --[[ Line: 176 ]]
            -- upvalues: u180 (copy), u184 (copy), u179 (copy)
            local v186 = 1 - p185;
            return v186 * v186 * u180 + v186 * 2 * p185 * u184 + p185 * p185 * u179;
        end)(p178);
        if u77 then
            u136.CFrame = CFrame.new(v187);
            if u149 then
                local v188 = 1 - (p178 == 0 and 0 or math.pow(2, (p178 - 1) * 10) - 0.001);
                u149.Size = UDim2.fromScale(u61.X.Scale * v188, u61.Y.Scale * v188);
            end;
        else
            local v189 = Vector3.new(u179.X, v187.Y, u179.Z);
            local v190;
            if (v187 - v189).Magnitude < 0.001 then
                v190 = CFrame.new(v187);
            else
                v190 = CFrame.lookAt(v187, v189);
            end;
            if u136:IsA("Model") then
                u136:PivotTo(v190);
                u136:ScaleTo(1 - (p178 == 0 and 0 or math.pow(2, (p178 - 1) * 10) - 0.001));
            else
                u136.CFrame = v190;
            end;
        end;
        return nil;
    end, 0.5);
    if p68.OnCollected then
        p68.OnCollected();
    end;
    if u77 then
        u136:Destroy();
    else
        u136:Destroy();
    end;
    local v191 = table.find(u2, v79);
    if v191 then
        table.remove(u2, v191);
    end;
end;
return u1;