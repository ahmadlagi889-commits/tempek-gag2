-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__SoundService__4 = game:GetService("SoundService");
local l__Debris__5 = game:GetService("Debris");
local l__Players__6 = game:GetService("Players");
local l__ContentProvider__7 = game:GetService("ContentProvider");
local l__Bezier__8 = require(l__ReplicatedStorage__1.ClientModules.Bezier);
local l__EggHatchAnim__9 = require(script.Parent.EggHatchAnim);
local l__EggScreenShake__10 = require(script.Parent.EggScreenShake);
local l__PetModules__11 = require(l__ReplicatedStorage__1.SharedModules.PetModules);
local l__PetData__12 = require(l__ReplicatedStorage__1.SharedData.PetData);
local l__PetSizes__13 = require(l__ReplicatedStorage__1.SharedData.PetSizes);
local l__AnimatedGradient__14 = require(l__ReplicatedStorage__1.SharedModules.AnimatedGradient);
local u2 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 128, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 0)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 128, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(128, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
});
local l__Assets__15 = l__ReplicatedStorage__1:WaitForChild("Assets");
local l__Eggs__16 = l__Assets__15:WaitForChild("Eggs");
local l__Pets__17 = l__Assets__15:WaitForChild("Pets");
local l__RarityData__18 = l__ReplicatedStorage__1.SharedModules.RarityData;
local u3 = l__Assets__15:FindFirstChild("EggEffects");
local l__Quad__19 = Enum.EasingStyle.Quad;
local u4 = Random.new();
local l__Exponential__20 = Enum.EasingStyle.Exponential;
local l__Quad__21 = Enum.EasingStyle.Quad;
local u5 = {
    "rbxassetid://89897463147043",
    "rbxassetid://84124106284739",
    "rbxassetid://109098770620406",
    "rbxassetid://109098770620406"
};
local u6 = {
    "rbxassetid://92457414302766",
    "rbxassetid://105505525581659",
    "rbxassetid://105012703607081",
    "rbxassetid://105012703607081"
};
local u7 = { "rbxassetid://88608751101502", "rbxassetid://78796672742221" };
local _ = l__Players__6.LocalPlayer;
local v8 = Instance.new("Folder");
v8.Name = "EggOpenSoundCache";
v8.Parent = l__SoundService__4;
local u9 = {};
if not u9["rbxassetid://121132824785522"] then
    local v10 = Instance.new("Sound");
    v10.SoundId = "rbxassetid://121132824785522";
    v10.Parent = v8;
    u9["rbxassetid://121132824785522"] = v10;
end;
if not u9["rbxassetid://104869826618847"] then
    local v11 = Instance.new("Sound");
    v11.SoundId = "rbxassetid://104869826618847";
    v11.Parent = v8;
    u9["rbxassetid://104869826618847"] = v11;
end;
if not u9["rbxassetid://78426714974899"] then
    local v12 = Instance.new("Sound");
    v12.SoundId = "rbxassetid://78426714974899";
    v12.Parent = v8;
    u9["rbxassetid://78426714974899"] = v12;
end;
if not u9["rbxassetid://116376053254864"] then
    local v13 = Instance.new("Sound");
    v13.SoundId = "rbxassetid://116376053254864";
    v13.Parent = v8;
    u9["rbxassetid://116376053254864"] = v13;
end;
if not u9["rbxassetid://131003613792899"] then
    local v14 = Instance.new("Sound");
    v14.SoundId = "rbxassetid://131003613792899";
    v14.Parent = v8;
    u9["rbxassetid://131003613792899"] = v14;
end;
if not u9["rbxassetid://93813602862073"] then
    local v15 = Instance.new("Sound");
    v15.SoundId = "rbxassetid://93813602862073";
    v15.Parent = v8;
    u9["rbxassetid://93813602862073"] = v15;
end;
for _, v16 in u5 do
    if not u9[v16] then
        local v17 = Instance.new("Sound");
        v17.SoundId = v16;
        v17.Parent = v8;
        u9[v16] = v17;
    end;
end;
for _, v18 in u6 do
    if not u9[v18] then
        local v19 = Instance.new("Sound");
        v19.SoundId = v18;
        v19.Parent = v8;
        u9[v18] = v19;
    end;
end;
for _, v20 in u7 do
    if not u9[v20] then
        local v21 = Instance.new("Sound");
        v21.SoundId = v20;
        v21.Parent = v8;
        u9[v20] = v21;
    end;
end;
local function u28(p22, _, p23, p24) --[[ Line: 203 ]]
    -- upvalues: u9 (copy), l__SoundService__4 (copy), l__Debris__5 (copy)
    local v25 = u9[p23];
    local v26;
    if v25 then
        v26 = v25:Clone();
    else
        v26 = Instance.new("Sound");
    end;
    v26.SoundId = p23;
    v26.Volume = p24 or 2;
    local v27 = l__SoundService__4:FindFirstChild("SFXGroup");
    if v27 and v27:IsA("SoundGroup") then
        v26.SoundGroup = v27;
    end;
    v26.RollOffMaxDistance = 250;
    v26.Parent = p22;
    v26:Play();
    l__Debris__5:AddItem(v26, 5);
end;
local function u32(p29, p30) --[[ Line: 221 ]]
    for _, v31 in p29:GetDescendants() do
        if v31:IsA("Trail") or (v31:IsA("ParticleEmitter") or v31:IsA("Beam")) then
            v31.Enabled = p30;
        end;
    end;
end;
local function u37(p33) --[[ Line: 231 ]]
    local v34 = RaycastParams.new();
    v34.FilterType = Enum.RaycastFilterType.Exclude;
    local v35 = workspace:FindFirstChild("Temporary");
    if v35 then
        v34.FilterDescendantsInstances = { v35 };
    end;
    local v36 = workspace:Raycast(p33 + Vector3.new(0, 5, 0), Vector3.new(0, -50, 0), v34);
    if v36 then
        return v36.Position;
    else
        return p33;
    end;
end;
local function u41(p38) --[[ Line: 253 ]]
    local v39 = p38:FindFirstChildOfClass("AnimationController");
    if not v39 then
        v39 = Instance.new("AnimationController");
        v39.Parent = p38;
    end;
    local v40 = v39:FindFirstChildOfClass("Animator");
    if not v40 then
        v40 = Instance.new("Animator");
        v40.Parent = v39;
    end;
    return v40;
end;
local function u48(p42, p43) --[[ Line: 270 ]]
    local v44 = p42:FindFirstChild("Animations");
    if p43 then
        p43 = p43.Animations;
    end;
    local v45 = v44 and v44:FindFirstChild("Walk") or p42:FindFirstChild("Walk");
    if not (v45 and v45:IsA("Animation")) then
        v45 = nil;
    end;
    if not v45 then
        if p43 then
            local l__Walk__22 = p43.Walk;
            if l__Walk__22 and l__Walk__22 ~= "" then
                v45 = v44 and v44:FindFirstChild(l__Walk__22) or p42:FindFirstChild(l__Walk__22);
                if not (v45 and v45:IsA("Animation")) then
                    v45 = nil;
                end;
            else
                v45 = nil;
            end;
            if not v45 then
                local l__Fly__23 = p43.Fly;
                if l__Fly__23 and l__Fly__23 ~= "" then
                    v45 = v44 and v44:FindFirstChild(l__Fly__23) or p42:FindFirstChild(l__Fly__23);
                    if not (v45 and v45:IsA("Animation")) then
                        v45 = nil;
                    end;
                else
                    v45 = nil;
                end;
                if not v45 then
                    local l__GroundIdle__24 = p43.GroundIdle;
                    if l__GroundIdle__24 and l__GroundIdle__24 ~= "" then
                        v45 = v44 and v44:FindFirstChild(l__GroundIdle__24) or p42:FindFirstChild(l__GroundIdle__24);
                        if not (v45 and v45:IsA("Animation")) then
                            v45 = nil;
                        end;
                    else
                        v45 = nil;
                    end;
                    if not v45 then
                        local l__Idle__25 = p43.Idle;
                        if l__Idle__25 and l__Idle__25 ~= "" then
                            v45 = v44 and v44:FindFirstChild(l__Idle__25) or p42:FindFirstChild(l__Idle__25);
                            if not (v45 and v45:IsA("Animation")) then
                                v45 = nil;
                            end;
                        else
                            v45 = nil;
                        end;
                    end;
                end;
            end;
        else
            v45 = p43;
        end;
    end;
    if v45 then
        return v45;
    end;
    if v44 then
        for _, v46 in v44:GetChildren() do
            if v46:IsA("Animation") then
                return v46;
            end;
        end;
    end;
    for _, v47 in p42:GetDescendants() do
        if v47:IsA("Animation") then
            return v47;
        end;
    end;
    return nil;
end;
local function u54(p49, p50) --[[ Line: 296 ]]
    local v51 = p49:FindFirstChild("Animations");
    if p50 then
        p50 = p50.Animations;
    end;
    local v52 = v51 and v51:FindFirstChild("Idle") or p49:FindFirstChild("Idle");
    if not (v52 and v52:IsA("Animation")) then
        v52 = nil;
    end;
    if not v52 then
        if p50 then
            local l__Idle__26 = p50.Idle;
            if l__Idle__26 and l__Idle__26 ~= "" then
                v52 = v51 and v51:FindFirstChild(l__Idle__26) or p49:FindFirstChild(l__Idle__26);
                if not (v52 and v52:IsA("Animation")) then
                    v52 = nil;
                end;
            else
                v52 = nil;
            end;
            if not v52 then
                local l__GroundIdle__27 = p50.GroundIdle;
                if l__GroundIdle__27 and l__GroundIdle__27 ~= "" then
                    v52 = v51 and v51:FindFirstChild(l__GroundIdle__27) or p49:FindFirstChild(l__GroundIdle__27);
                    if not (v52 and v52:IsA("Animation")) then
                        v52 = nil;
                    end;
                else
                    v52 = nil;
                end;
                if not v52 then
                    local l__Fly__28 = p50.Fly;
                    if not l__Fly__28 or l__Fly__28 == "" then
                        return nil;
                    end;
                    local v53 = v51 and v51:FindFirstChild(l__Fly__28) or p49:FindFirstChild(l__Fly__28);
                    if v53 and v53:IsA("Animation") then
                        return v53;
                    end;
                    v52 = nil;
                end;
            end;
        else
            v52 = p50;
        end;
    end;
    return v52;
end;
local function u63(p55) --[[ Line: 312 ]]
    local v56 = (1 / 0);
    for _, v57 in p55:GetDescendants() do
        if v57:IsA("BasePart") then
            local l__CFrame__29 = v57.CFrame;
            local l__Size__30 = v57.Size;
            local v58 = l__Size__30.X / 2;
            local v59 = l__Size__30.Y / 2;
            local v60 = l__Size__30.Z / 2;
            for v61 = -1, 1, 2 do
                for v62 = -1, 1, 2 do
                    local l__Y__31 = (l__CFrame__29 * Vector3.new(v61 * v58, v62 * v59, -1 * v60)).Y;
                    if l__Y__31 >= v56 then
                        l__Y__31 = v56;
                    end;
                    v56 = (l__CFrame__29 * Vector3.new(v61 * v58, v62 * v59, 1 * v60)).Y;
                    if v56 >= l__Y__31 then
                        v56 = l__Y__31;
                    end;
                end;
            end;
        end;
    end;
    return v56;
end;
local function u72(p64) --[[ Line: 333 ]]
    local v65 = (-1 / 0);
    for _, v66 in p64:GetDescendants() do
        if v66:IsA("BasePart") then
            local l__CFrame__32 = v66.CFrame;
            local l__Size__33 = v66.Size;
            local v67 = l__Size__33.X / 2;
            local v68 = l__Size__33.Y / 2;
            local v69 = l__Size__33.Z / 2;
            for v70 = -1, 1, 2 do
                for v71 = -1, 1, 2 do
                    local l__Y__34 = (l__CFrame__32 * Vector3.new(v70 * v67, v71 * v68, -1 * v69)).Y;
                    if v65 >= l__Y__34 then
                        l__Y__34 = v65;
                    end;
                    v65 = (l__CFrame__32 * Vector3.new(v70 * v67, v71 * v68, 1 * v69)).Y;
                    if l__Y__34 >= v65 then
                        v65 = l__Y__34;
                    end;
                end;
            end;
        end;
    end;
    return v65;
end;
local function u78(p73) --[[ Line: 371 ]]
    -- upvalues: u2 (copy), l__AnimatedGradient__14 (copy)
    if p73 then
        local function v76(p74) --[[ Line: 373 ]]
            -- upvalues: u2 (ref), l__AnimatedGradient__14 (ref)
            if p74 and p74:IsA("TextLabel") then
                p74.TextColor3 = Color3.new(1, 1, 1);
                local v75 = Instance.new("UIGradient");
                v75.Color = u2;
                v75.Parent = p74;
                l__AnimatedGradient__14:Add(v75);
            end;
        end;
        for _, v77 in p73:GetChildren() do
            if v77:IsA("TextLabel") then
                v76(v77);
            end;
        end;
    end;
end;
local function u107(p79, p80, p81, p82) --[[ Line: 389 ]]
    -- upvalues: l__Assets__15 (copy), l__PetData__12 (copy), u78 (copy), l__RarityData__18 (copy), l__TweenService__3 (copy), l__Debris__5 (copy)
    local v83 = l__Assets__15:FindFirstChild("SeedNameAttachment");
    if not v83 then
        return nil;
    end;
    local u84 = v83:Clone();
    u84.Position = p81;
    local v85 = u84:FindFirstChild("BillboardGui");
    if not v85 then
        u84.Parent = workspace.Temporary;
        return u84, function() --[[ Line: 399 ]]
            -- upvalues: u84 (copy)
            u84:Destroy();
        end;
    end;
    local u86 = v85:FindFirstChild("Seed_Name");
    local u87 = v85:FindFirstChild("Rarity_Name");
    local u88;
    if p80 and (p80 ~= "" and (u87 and u87:IsA("GuiObject"))) then
        local v89 = u87:Clone();
        v89.Name = "Type_Name";
        v89.LayoutOrder = 1;
        v89.Size = UDim2.new(v89.Size.X.Scale, v89.Size.X.Offset, 0.3, 0);
        v89.Parent = v85;
        u88 = v89;
        u87.LayoutOrder = 2;
        u87.Size = UDim2.new(u87.Size.X.Scale, u87.Size.X.Offset, 0.3, 0);
        if u86 and u86:IsA("GuiObject") then
            u86.LayoutOrder = 0;
            u86.Size = UDim2.new(u86.Size.X.Scale, u86.Size.X.Offset, 0.3, 0);
        end;
        if v85:IsA("BillboardGui") then
            v85.Size = UDim2.new(v85.Size.X.Scale, v85.Size.X.Offset, 4.5, 0);
        end;
    else
        u88 = nil;
    end;
    if u86 then
        local v90 = u86:FindFirstChild("UIScale");
        if v90 and v90:IsA("UIScale") then
            v90.Scale = 0;
        end;
    end;
    if u87 then
        local v91 = u87:FindFirstChild("UIScale");
        if v91 and v91:IsA("UIScale") then
            v91.Scale = 0;
        end;
    end;
    if u88 then
        local v92 = u88:FindFirstChild("UIScale");
        if v92 and v92:IsA("UIScale") then
            v92.Scale = 0;
        end;
    end;
    local v93 = l__PetData__12.GetDisplayName(p79, p82);
    if u86 then
        if u86:IsA("TextLabel") then
            u86.Text = v93;
        end;
        local v94 = u86:FindFirstChild("TextLabel");
        if v94 and v94:IsA("TextLabel") then
            v94.Text = v93;
        end;
    end;
    if u88 then
        if u88 then
            if u88:IsA("TextLabel") then
                u88.Text = p80;
            end;
            local v95 = u88:FindFirstChild("TextLabel");
            if v95 and v95:IsA("TextLabel") then
                v95.Text = p80;
            end;
        end;
        u78(u88);
    end;
    local v96 = l__PetData__12[p79];
    if v96 then
        v96 = l__PetData__12[p79].Rarity;
    end;
    if v96 then
        if u87 then
            if u87:IsA("TextLabel") then
                u87.Text = v96;
            end;
            local v97 = u87:FindFirstChild("TextLabel");
            if v97 and v97:IsA("TextLabel") then
                v97.Text = v96;
            end;
        end;
        local v98 = l__RarityData__18:FindFirstChild("Gradients");
        if v98 then
            v98 = v98:FindFirstChild(v96);
        end;
        if v98 and u87 then
            local v99 = u87:FindFirstChild("TextLabel");
            if v99 then
                v98:Clone().Parent = v99;
            end;
            v98:Clone().Parent = u87;
        end;
    end;
    u84.Parent = workspace.Temporary;
    local function v103(p100, p101) --[[ Line: 463 ]]
        -- upvalues: l__TweenService__3 (ref)
        if p100 then
            local u102 = p100:FindFirstChild("UIScale");
            if u102 and u102:IsA("UIScale") then
                task.delay(p101, function() --[[ Line: 467 ]]
                    -- upvalues: u102 (copy), l__TweenService__3 (ref)
                    if u102.Parent then
                        l__TweenService__3:Create(u102, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                            Scale = 1
                        }):Play();
                    end;
                end);
            end;
        end;
    end;
    v103(u86, 0);
    v103(u88, 0.1);
    v103(u87, 0.15);
    return u84, function() --[[ Name: popOut, Line 478 ]]
        -- upvalues: l__TweenService__3 (ref), u86 (copy), u88 (ref), u87 (copy), l__Debris__5 (ref), u84 (copy)
        local function v106(p104) --[[ Line: 479 ]]
            -- upvalues: l__TweenService__3 (ref)
            if p104 then
                local v105 = p104:FindFirstChild("UIScale");
                if v105 and v105:IsA("UIScale") then
                    l__TweenService__3:Create(v105, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                        Scale = 0
                    }):Play();
                end;
            end;
        end;
        v106(u86);
        v106(u88);
        v106(u87);
        l__Debris__5:AddItem(u84, 0.6000000000000001);
    end;
end;
local function u111(p108) --[[ Line: 497 ]]
    local v109 = p108.PrimaryPart or (p108:FindFirstChild("Torso") or p108:FindFirstChild("HumanoidRootPart") or (p108:FindFirstChild("RootPart") or p108:FindFirstChildWhichIsA("BasePart")));
    if not v109 then
        return nil;
    end;
    p108.PrimaryPart = v109;
    for _, v110 in p108:GetDescendants() do
        if v110:IsA("BasePart") then
            v110.CanCollide = false;
            v110.CanQuery = false;
            v110.CanTouch = false;
            v110.Massless = true;
            v110.Anchored = v110 == v109;
        end;
    end;
    return v109;
end;
local function u165(p112, p113, p114, u115, p116, p117) --[[ Line: 523 ]]
    -- upvalues: l__PetModules__11 (copy), l__Pets__17 (copy), l__Assets__15 (copy), u111 (copy), l__PetSizes__13 (copy), u63 (copy), u41 (copy), u54 (copy), u107 (copy), u72 (copy), l__RunService__2 (copy), u48 (copy), l__TweenService__3 (copy), l__Quad__21 (copy)
    local v118 = l__PetModules__11[p112];
    local v119, v120, u121, v122, v123, u124, v125, v126, v127, v128, v129, v130, v131, v132, u133, v134, v135, v136, v137, u138, u139, v140, v141, v142, v143, v144, v145, v146, v147, v148, v149, v150, v151, v152;
    if l__Pets__17 then
        local v153 = l__Pets__17;
        local v154;
        if v118 then
            v154 = v118.AssetName or p112;
        else
            v154 = p112;
        end;
        v119 = v153:FindFirstChild(v154);
        if v119 then
            if v119 and v119:IsA("Model") then
                v120 = v119:Clone();
                u121 = u111(v120);
                if u121 then
                    v122 = l__PetSizes__13.GetScale(p116, v118 and {
                        Big = v118.BigScale,
                        Huge = v118.HugeScale
                    } or nil);
                    if v122 ~= 1 then
                        v120:ScaleTo(v122);
                    end;
                    if v118 then
                        v123 = v118.Pivot;
                    else
                        v123 = v118;
                    end;
                    if typeof(v123) == "Vector3" then
                        u124 = CFrame.Angles(math.rad(v123.X), math.rad(v123.Y), (math.rad(v123.Z)));
                    else
                        u124 = CFrame.identity;
                    end;
                    v125 = p113 + Vector3.new(0, 0, 0);
                    if u115 then
                        v126 = u115.Character;
                    else
                        v126 = u115;
                    end;
                    if v126 then
                        v126 = v126:FindFirstChild("HumanoidRootPart");
                    end;
                    if not (v126 and v126:IsA("BasePart")) then
                        v126 = nil;
                    end;
                    v127 = v126 and Vector3.new(v126.Position.X, v125.Y, v126.Position.Z) or v125 + p114 * Vector3.new(1, 0, 1);
                    v120:PivotTo(CFrame.lookAt(v125, v127) * u124);
                    v120.Parent = workspace.Temporary;
                    v128 = u63(v120);
                    if v128 ~= (1 / 0) then
                        v129 = p113.Y + 0 - v128;
                        if math.abs(v129) > 0.001 then
                            v120:PivotTo(v120:GetPivot() + Vector3.new(0, v129, 0));
                        end;
                    end;
                    if p117 == "Rainbow" then
                        v120:AddTag("PetRainbow");
                    end;
                    v130 = u41(v120);
                    v131 = u54(v120, v118);
                    if v131 then
                        v132 = v130:LoadAnimation(v131);
                        v132.Looped = true;
                        v132:Play();
                    else
                        v132 = nil;
                    end;
                    u133, v134 = u107(p112, p117, v125, p116);
                    v135 = u72(v120);
                    v136 = 3;
                    if u133 then
                        v137 = u133:FindFirstChild("BillboardGui");
                        if v137 and v137:IsA("BillboardGui") then
                            v136 = v137.Size.Y.Scale;
                        end;
                        u138 = v135 - u121.Position.Y + v136 / 2 + 1;
                        u133.Position = u121.Position + Vector3.new(0, u138, 0);
                    else
                        u138 = 1;
                    end;
                    u139 = true;
                    v140 = l__RunService__2.RenderStepped:Connect(function(p161) --[[ Line: 609 ]]
                        -- upvalues: u139 (ref), u121 (copy), u115 (copy), u124 (copy), u133 (copy), u138 (ref)
                        if u139 then
                            if u121 and u121.Parent then
                                local v162 = u115;
                                if v162 then
                                    v162 = u115.Character;
                                end;
                                if v162 then
                                    v162 = v162:FindFirstChild("HumanoidRootPart");
                                end;
                                if not (v162 and v162:IsA("BasePart")) then
                                    v162 = nil;
                                end;
                                local l__Position__36 = u121.Position;
                                if v162 then
                                    local v163 = Vector3.new(v162.Position.X, l__Position__36.Y, v162.Position.Z);
                                    local v164 = CFrame.lookAt(l__Position__36, v163) * u124;
                                    u121.CFrame = u121.CFrame:Lerp(v164, (math.clamp(p161 * 8, 0, 1)));
                                end;
                                if u133 and u133.Parent then
                                    u133.Position = l__Position__36 + Vector3.new(0, u138, 0);
                                end;
                            end;
                        end;
                    end);
                    task.wait(5);
                    u139 = false;
                    if v140 then
                        v140:Disconnect();
                    end;
                    if v134 then
                        v134();
                    end;
                    if v132 then
                        v132:Stop(0.1);
                    end;
                    if u115 then
                        v141 = u115.Character;
                    else
                        v141 = u115;
                    end;
                    if v141 then
                        v141 = v141:FindFirstChild("HumanoidRootPart");
                    end;
                    if not (v141 and v141:IsA("BasePart")) then
                        v141 = nil;
                    end;
                    if v141 then
                        v142 = u48(v120, v118);
                        if v142 then
                            v143 = v130:LoadAnimation(v142);
                            v143.Looped = true;
                            v143:Play();
                        else
                            v143 = nil;
                        end;
                        v144 = u121.Position;
                        v145 = 0;
                        while v145 < 0.6 do
                            v145 = v145 + l__RunService__2.Heartbeat:Wait();
                            v146 = l__TweenService__3:GetValue(v145 / 0.6, l__Quad__21, Enum.EasingDirection.Out);
                            if u115 then
                                v147 = u115.Character;
                            else
                                v147 = u115;
                            end;
                            if v147 then
                                v147 = v147:FindFirstChild("HumanoidRootPart");
                            end;
                            if not (v147 and v147:IsA("BasePart")) then
                                v147 = nil;
                            end;
                            if v147 then
                                v148 = v147.Position or v144;
                            else
                                v148 = v144;
                            end;
                            v149 = (1 - v146) ^ 2 * v144 + 2 * (1 - v146) * v146 * ((v144 + v148) / 2 + Vector3.new(0, 8, 0)) + v146 ^ 2 * v148;
                            v120:ScaleTo((math.max(v122 * ((v146 <= 0.7 and 0 or (v146 - 0.7) / 0.30000000000000004) * -0.95 + 1), 0.01)));
                            v150 = Vector3.new(v148.X, v149.Y, v148.Z);
                            if (v150 - v149).Magnitude > 0.001 then
                                u121.CFrame = CFrame.lookAt(v149, v150) * u124;
                            else
                                u121.CFrame = CFrame.new(v149) * u121.CFrame.Rotation;
                            end;
                        end;
                        if v143 then
                            v143:Stop(0);
                        end;
                    else
                        v151 = 0;
                        while v151 < 0.6 do
                            v151 = v151 + l__RunService__2.Heartbeat:Wait();
                            v152 = l__TweenService__3:GetValue(v151 / 0.6, l__Quad__21, Enum.EasingDirection.Out);
                            v120:ScaleTo((math.max(v122 * ((v152 <= 0.7 and 0 or (v152 - 0.7) / 0.30000000000000004) * -0.95 + 1), 0.01)));
                        end;
                    end;
                    v120:Destroy();
                    return;
                else
                    v120:Destroy();
                    return;
                end;
            else
                return;
            end;
        end;
    end;
    local v159 = l__Assets__15;
    local v160;
    if v118 then
        v160 = v118.AssetName or p112;
    else
        v160 = p112;
    end;
    v119 = v159:FindFirstChild(v160);
    if v119 and v119:IsA("Model") then
        v120 = v119:Clone();
        u121 = u111(v120);
        if u121 then
            v122 = l__PetSizes__13.GetScale(p116, v118 and {
                Big = v118.BigScale,
                Huge = v118.HugeScale
            } or nil);
            if v122 ~= 1 then
                v120:ScaleTo(v122);
            end;
            if v118 then
                v123 = v118.Pivot;
            else
                v123 = v118;
            end;
            if typeof(v123) == "Vector3" then
                u124 = CFrame.Angles(math.rad(v123.X), math.rad(v123.Y), (math.rad(v123.Z)));
            else
                u124 = CFrame.identity;
            end;
            v125 = p113 + Vector3.new(0, 0, 0);
            if u115 then
                v126 = u115.Character;
            else
                v126 = u115;
            end;
            if v126 then
                v126 = v126:FindFirstChild("HumanoidRootPart");
            end;
            if not (v126 and v126:IsA("BasePart")) then
                v126 = nil;
            end;
            v127 = v126 and Vector3.new(v126.Position.X, v125.Y, v126.Position.Z) or v125 + p114 * Vector3.new(1, 0, 1);
            v120:PivotTo(CFrame.lookAt(v125, v127) * u124);
            v120.Parent = workspace.Temporary;
            v128 = u63(v120);
            if v128 ~= (1 / 0) then
                v129 = p113.Y + 0 - v128;
                if math.abs(v129) > 0.001 then
                    v120:PivotTo(v120:GetPivot() + Vector3.new(0, v129, 0));
                end;
            end;
            if p117 == "Rainbow" then
                v120:AddTag("PetRainbow");
            end;
            v130 = u41(v120);
            v131 = u54(v120, v118);
            if v131 then
                v132 = v130:LoadAnimation(v131);
                v132.Looped = true;
                v132:Play();
            else
                v132 = nil;
            end;
            u133, v134 = u107(p112, p117, v125, p116);
            v135 = u72(v120);
            v136 = 3;
            if u133 then
                v137 = u133:FindFirstChild("BillboardGui");
                if v137 and v137:IsA("BillboardGui") then
                    v136 = v137.Size.Y.Scale;
                end;
                u138 = v135 - u121.Position.Y + v136 / 2 + 1;
                u133.Position = u121.Position + Vector3.new(0, u138, 0);
            else
                u138 = 1;
            end;
            u139 = true;
            v140 = l__RunService__2.RenderStepped:Connect(function(p161) --[[ Line: 609 ]]
                -- upvalues: u139 (ref), u121 (copy), u115 (copy), u124 (copy), u133 (copy), u138 (ref)
                if u139 then
                    if u121 and u121.Parent then
                        local v162 = u115;
                        if v162 then
                            v162 = u115.Character;
                        end;
                        if v162 then
                            v162 = v162:FindFirstChild("HumanoidRootPart");
                        end;
                        if not (v162 and v162:IsA("BasePart")) then
                            v162 = nil;
                        end;
                        local l__Position__36 = u121.Position;
                        if v162 then
                            local v163 = Vector3.new(v162.Position.X, l__Position__36.Y, v162.Position.Z);
                            local v164 = CFrame.lookAt(l__Position__36, v163) * u124;
                            u121.CFrame = u121.CFrame:Lerp(v164, (math.clamp(p161 * 8, 0, 1)));
                        end;
                        if u133 and u133.Parent then
                            u133.Position = l__Position__36 + Vector3.new(0, u138, 0);
                        end;
                    end;
                end;
            end);
            task.wait(5);
            u139 = false;
            if v140 then
                v140:Disconnect();
            end;
            if v134 then
                v134();
            end;
            if v132 then
                v132:Stop(0.1);
            end;
            if u115 then
                v141 = u115.Character;
            else
                v141 = u115;
            end;
            if v141 then
                v141 = v141:FindFirstChild("HumanoidRootPart");
            end;
            if not (v141 and v141:IsA("BasePart")) then
                v141 = nil;
            end;
            if v141 then
                v142 = u48(v120, v118);
                if v142 then
                    v143 = v130:LoadAnimation(v142);
                    v143.Looped = true;
                    v143:Play();
                else
                    v143 = nil;
                end;
                v144 = u121.Position;
                v145 = 0;
                while v145 < 0.6 do
                    v145 = v145 + l__RunService__2.Heartbeat:Wait();
                    v146 = l__TweenService__3:GetValue(v145 / 0.6, l__Quad__21, Enum.EasingDirection.Out);
                    if u115 then
                        v147 = u115.Character;
                    else
                        v147 = u115;
                    end;
                    if v147 then
                        v147 = v147:FindFirstChild("HumanoidRootPart");
                    end;
                    if not (v147 and v147:IsA("BasePart")) then
                        v147 = nil;
                    end;
                    if v147 then
                        v148 = v147.Position or v144;
                    else
                        v148 = v144;
                    end;
                    v149 = (1 - v146) ^ 2 * v144 + 2 * (1 - v146) * v146 * ((v144 + v148) / 2 + Vector3.new(0, 8, 0)) + v146 ^ 2 * v148;
                    v120:ScaleTo((math.max(v122 * ((v146 <= 0.7 and 0 or (v146 - 0.7) / 0.30000000000000004) * -0.95 + 1), 0.01)));
                    v150 = Vector3.new(v148.X, v149.Y, v148.Z);
                    if (v150 - v149).Magnitude > 0.001 then
                        u121.CFrame = CFrame.lookAt(v149, v150) * u124;
                    else
                        u121.CFrame = CFrame.new(v149) * u121.CFrame.Rotation;
                    end;
                end;
                if v143 then
                    v143:Stop(0);
                end;
            else
                v151 = 0;
                while v151 < 0.6 do
                    v151 = v151 + l__RunService__2.Heartbeat:Wait();
                    v152 = l__TweenService__3:GetValue(v151 / 0.6, l__Quad__21, Enum.EasingDirection.Out);
                    v120:ScaleTo((math.max(v122 * ((v152 <= 0.7 and 0 or (v152 - 0.7) / 0.30000000000000004) * -0.95 + 1), 0.01)));
                end;
            end;
            v120:Destroy();
        else
            v120:Destroy();
        end;
    end;
end;
function v1.Open(_, p166, p167, p168, p169, u170, p171, p172) --[[ Line: 690 ]]
    -- upvalues: l__Eggs__16 (copy), u37 (copy), u3 (copy), u32 (copy), u28 (copy), l__Bezier__8 (copy), l__RunService__2 (copy), l__TweenService__3 (copy), l__Quad__19 (copy), u5 (copy), l__EggScreenShake__10 (copy), u6 (copy), u7 (copy), l__EggHatchAnim__9 (copy), l__Exponential__20 (copy), u4 (copy), u165 (copy)
    local v173 = l__Eggs__16:FindFirstChild(p166);
    if not v173 then
        return;
    end;
    local v174 = u37(p169.Position);
    local v175 = Vector3.new(p169.Position.X, v174.Y + 0, p169.Position.Z);
    local v176 = CFrame.new(v175, v175 + p169.LookVector * Vector3.new(1, 0, 1));
    local u177 = v173:Clone();
    for _, v178 in u177:GetDescendants() do
        if v178:IsA("BasePart") then
            v178.Anchored = true;
            v178.CanCollide = false;
            v178.CanQuery = false;
            v178.CanTouch = false;
        end;
    end;
    local u179 = u177.PrimaryPart or (u177:FindFirstChild("Handle") or u177:FindFirstChildWhichIsA("BasePart"));
    if not u179 then
        u177:Destroy();
        return;
    end;
    if u3 and u3:FindFirstChild("Attachment") then
        u3.Attachment:Clone().Parent = u179;
    end;
    local u180 = u3.Shake:Clone();
    u180.Parent = u179;
    local u181 = u3.Highlight:Clone();
    u181.Parent = u179;
    u181.DepthMode = Enum.HighlightDepthMode.Occluded;
    u181.FillTransparency = 1;
    u181.OutlineTransparency = 1;
    u177:PivotTo(CFrame.new(p168, p168 + v176.LookVector * Vector3.new(1, 0, 1)));
    u177.Parent = workspace.Temporary;
    u32(u177, true);
    u28(u179, u170, "rbxassetid://121132824785522");
    local v182 = l__Bezier__8.new(p168, (p168 + v176.Position) / 2 + Vector3.new(0, 16, 0), v176.Position);
    local v183 = 0;
    while v183 < 0.3 do
        v183 = v183 + l__RunService__2.Heartbeat:Wait();
        local v184 = v182:CalculatePositionAt((l__TweenService__3:GetValue(v183 / 0.3, l__Quad__19, Enum.EasingDirection.Out)));
        u177:PivotTo(CFrame.new(v184, v184 + v176.LookVector));
    end;
    u177:PivotTo(v176);
    u28(u179, u170, "rbxassetid://104869826618847");
    u32(u177, false);
    for v185 = 1, 2 do
        local v186 = 0.45 ^ (v185 - 1) * 2.5;
        if v186 <= 0 then
            break;
        end;
        local v187 = math.sqrt(v186 / 2.5) * 0.2;
        local v188 = 0;
        while v188 < v187 do
            v188 = v188 + l__RunService__2.Heartbeat:Wait();
            local v189 = math.clamp(v188 / v187, 0, 1);
            u177:PivotTo(v176 * CFrame.new(0, v186 * 4 * v189 * (1 - v189), 0));
        end;
        u177:PivotTo(v176);
    end;
    task.wait(1);
    local u190 = u5;
    local u191 = 0;
    local function v194() --[[ Line: 784 ]]
        -- upvalues: u179 (copy), u191 (ref), u190 (ref), u28 (ref), u170 (copy), u181 (copy), u180 (copy)
        u191 = u191 + 1;
        local v192 = u190[u191];
        if v192 then
            u28(u179, u170, v192);
        end;
        u181.FillTransparency = 0;
        u181.OutlineTransparency = 0.5;
        game.TweenService:Create(u181, TweenInfo.new(0.3), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
        for _, v193 in u180:GetChildren() do
            if v193:IsA("ParticleEmitter") then
                v193:Emit(v193:GetAttribute("EmitCount"));
            end;
        end;
    end;
    local u195 = l__EggScreenShake__10.begin(v176.Position, p171);
    local v200 = {
        onWobbleBeat = function(p196) --[[ Name: onWobbleBeat, Line 807 ]]
            -- upvalues: u195 (copy)
            u195:onWobbleBeat(p196);
        end,
        onGrowStart = function(p197, _) --[[ Name: onGrowStart, Line 810 ]]
            -- upvalues: u28 (ref), u179 (copy), u170 (copy), u190 (ref), u6 (ref), u191 (ref), u7 (ref)
            if p197 == 1 then
                u28(u179, u170, "rbxassetid://131003613792899", 4);
                u190 = u6;
                u191 = 0;
            else
                if p197 == 2 then
                    u28(u179, u170, "rbxassetid://93813602862073", 4);
                    u190 = u7;
                    u191 = 0;
                end;
            end;
        end,
        onGrowBeat = function(p198, p199) --[[ Name: onGrowBeat, Line 821 ]]
            -- upvalues: u195 (copy)
            u195:onGrowBeat(p198, p199);
        end
    };
    if p171 == "Big" then
        l__EggHatchAnim__9.RunBigPreHatchSequence(u177, v176, v194, v200);
    elseif p171 == "Huge" then
        l__EggHatchAnim__9.RunHugePreHatchSequence(u177, v176, v194, v200);
    else
        l__EggHatchAnim__9.RunPreHatchSequence(u177, v176, l__EggHatchAnim__9.NormalPreHatchConfig, v194, v200);
    end;
    u195:onHatch(p171);
    local v201 = u177:GetScale() - 1;
    if math.abs(v201) <= 0.001 then
        u177:PivotTo(v176);
    end;
    if p171 == "Big" then
        u28(u179, u170, "rbxassetid://78426714974899", 4);
    elseif p171 == "Huge" then
        u28(u179, u170, "rbxassetid://116376053254864", 4);
    end;
    local u202 = {};
    for _, v203 in u177:GetDescendants() do
        if v203:IsA("BasePart") then
            v203.Color = Color3.new(1, 1, 1);
            if v203:IsA("MeshPart") then
                v203.TextureID = "";
            end;
            table.insert(u202, {
                Part = v203,
                Start = v203.Transparency
            });
        elseif v203:IsA("Decal") or (v203:IsA("Texture") or v203:IsA("SurfaceAppearance")) then
            v203:Destroy();
        end;
    end;
    local u204 = u177:GetScale();
    local u205 = l__EggHatchAnim__9.ResolveHatchTargetScale(p171, u204);
    if p171 ~= "Huge" then
        task.spawn(function() --[[ Line: 865 ]]
            -- upvalues: l__RunService__2 (ref), l__TweenService__3 (ref), l__Exponential__20 (ref), u177 (copy), u204 (copy), u205 (copy), u202 (copy)
            local v206 = 0;
            while v206 < 0.6 do
                v206 = v206 + l__RunService__2.Heartbeat:Wait();
                local v207 = l__TweenService__3:GetValue(math.clamp(v206 / 0.6, 0, 1), l__Exponential__20, Enum.EasingDirection.Out);
                u177:ScaleTo(u204 + (u205 - u204) * v207);
                for _, v208 in u202 do
                    if v208.Part.Parent then
                        v208.Part.Transparency = v208.Start + (1 - v208.Start) * v207;
                    end;
                end;
            end;
            u177:Destroy();
        end);
    end;
    if p171 == "Huge" then
        local u209 = 0;
        game.TweenService:Create(u181, TweenInfo.new(0.6), {
            FillTransparency = 0,
            OutlineTransparency = 0
        }):Play();
        local u210 = true;
        task.spawn(function() --[[ Line: 894 ]]
            -- upvalues: u209 (ref), u210 (ref), l__RunService__2 (ref), l__TweenService__3 (ref), l__Exponential__20 (ref), u177 (copy), u204 (copy)
            while u209 < 1.2 and u210 do
                u209 = u209 + l__RunService__2.Heartbeat:Wait();
                local v211 = l__TweenService__3:GetValue(math.clamp(u209 / 0.6, 0, 1), l__Exponential__20, Enum.EasingDirection.Out);
                u177:ScaleTo(u204 + (0.2 - u204) * v211);
            end;
            u209 = 0;
            while u209 < 3 and u210 do
                u209 = u209 + l__RunService__2.Heartbeat:Wait();
                local v212 = l__TweenService__3:GetValue(math.clamp(u209 / 3, 0, 1), l__Exponential__20, Enum.EasingDirection.Out);
                u177:ScaleTo(0.2 + (u204 - 0.2) * v212);
            end;
        end);
        local u213 = game.ReplicatedStorage.Assets.EggEffects.HugeUnlock:Clone();
        u213.Parent = workspace.Temporary;
        u213:PivotTo(u177:GetPivot());
        local v214 = u177:GetPivot();
        local v215 = u213.ScaleMe:GetPivot();
        for _, v216 in u213.HugeEffect:GetChildren() do
            l__TweenService__3:Create(v216, TweenInfo.new(0.8), {
                TimeScale = 1
            }):Play();
        end;
        for _, v217 in u213.Floor:GetChildren() do
            l__TweenService__3:Create(v217, TweenInfo.new(3), {
                TimeScale = 1
            }):Play();
        end;
        for _, v218 in u213.ScaleMe.HugeEffect.Attachment:GetChildren() do
            l__TweenService__3:Create(v218, TweenInfo.new(3), {
                TimeScale = 1
            }):Play();
        end;
        local v219 = 0;
        local v220 = 0;
        while v219 < 2 do
            local v221 = l__RunService__2.Heartbeat:Wait();
            v219 = v219 + v221;
            v220 = v220 + 1080 * (v221 * v219 / 2);
            local v222 = l__TweenService__3:GetValue(math.clamp(v219 / 2, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            local v223 = CFrame.new(u4:NextNumber(-1, 1) * v222 * 0.5, u4:NextNumber(-1, 1) * v222 * 0.5, u4:NextNumber(-1, 1) * v222 * 0.5);
            u177:PivotTo(v214:Lerp(v215, v222) * v223 * CFrame.Angles(0, math.rad(v220), 0));
            u213.HugeEffect:PivotTo(CFrame.new(u177.PrimaryPart.Position));
            u213.ScaleMe:PivotTo(CFrame.new(u177.PrimaryPart.Position));
            u213.ScaleMe:ScaleTo(v222);
        end;
        local v224 = u177:GetScale();
        task.delay(1.3, function() --[[ Line: 964 ]]
            -- upvalues: u213 (copy)
            for _, v225 in u213:GetDescendants() do
                if v225:IsA("ParticleEmitter") then
                    v225.Enabled = false;
                end;
            end;
        end);
        local v226 = 0;
        while v226 < 1.5 do
            local v227 = l__RunService__2.Heartbeat:Wait();
            v226 = v226 + v227;
            local v228 = CFrame.new(u4:NextNumber(-1, 1) * 0.5, u4:NextNumber(-1, 1) * 0.5, u4:NextNumber(-1, 1) * 0.5);
            v220 = v220 + 1080 * v227;
            if v226 > 1.1 then
                local v229 = v226 - 1.1;
                u210 = false;
                local v230 = l__TweenService__3:GetValue(math.clamp(v229 / 0.4, 0, 1), l__Exponential__20, Enum.EasingDirection.Out);
                u177:ScaleTo(v224 + (0.1 - v224) * v230);
                u177:PivotTo(v215:Lerp(v214, (l__TweenService__3:GetValue(math.clamp(v229 / 0.4, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.In))) * v228 * CFrame.Angles(0, math.rad(v220), 0));
                u213.HugeEffect:PivotTo(CFrame.new(u177.PrimaryPart.Position));
                u213.ScaleMe:PivotTo(CFrame.new(u177.PrimaryPart.Position));
            else
                u177:PivotTo(v215 * v228 * CFrame.Angles(0, math.rad(v220), 0));
            end;
        end;
        local v231 = u3.Huge:Clone();
        v231.Parent = workspace.Terrain;
        v231.WorldPosition = u177:GetPivot().Position;
        u177:Destroy();
        for _, v232 in v231:GetChildren() do
            if v232:IsA("ParticleEmitter") then
                v232:Emit(v232:GetAttribute("EmitCount"));
            elseif v232:IsA("PointLight") then
                l__TweenService__3:Create(v232, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Range = 0,
                    Brightness = 1
                }):Play();
            end;
        end;
        game.Debris:AddItem(v231, 7);
        u177:Destroy();
    else
        local v233 = p171 == "Big" and u3.Big:Clone() or u3.Common:Clone();
        v233.Parent = workspace.Terrain;
        v233.WorldPosition = u177:GetPivot().Position;
        for _, v234 in v233:GetChildren() do
            if v234:IsA("ParticleEmitter") then
                v234:Emit(v234:GetAttribute("EmitCount"));
            elseif v234:IsA("PointLight") then
                l__TweenService__3:Create(v234, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Range = 0,
                    Brightness = 1
                }):Play();
            end;
        end;
        game.Debris:AddItem(v233, 7);
    end;
    if p171 == "Big" or p171 == "Huge" then
        u195:onPetRevealed();
    end;
    task.wait(0.1);
    u165(p167, Vector3.new(v176.Position.X, v174.Y, v176.Position.Z), v176.LookVector, u170, p171, p172);
end;
task.spawn(function() --[[ Line: 1069 ]]
    -- upvalues: u9 (copy), l__ContentProvider__7 (copy)
    local u235 = {};
    for _, v236 in u9 do
        table.insert(u235, v236);
    end;
    local u237 = {};
    local v240, v241 = pcall(function() --[[ Line: 1076 ]]
        -- upvalues: l__ContentProvider__7 (ref), u235 (copy), u237 (copy)
        l__ContentProvider__7:PreloadAsync(u235, function(p238, p239) --[[ Line: 1077 ]]
            -- upvalues: u237 (ref)
            if p239 == Enum.AssetFetchStatus.Failure or p239 == Enum.AssetFetchStatus.TimedOut then
                table.insert(u237, p238);
            end;
        end);
    end);
    if v240 then
        if #u237 > 0 then
            warn((`[EggEffect] {#u237} egg-open sound(s) failed to preload: {table.concat(u237, ", ")}`));
        end;
    else
        warn((`[EggEffect] Sound preload errored: {v241}`));
    end;
end);
return v1;