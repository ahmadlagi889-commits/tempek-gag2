-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__SoundService__3 = game:GetService("SoundService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__SeedData__6 = require(l__ReplicatedStorage__4.SharedModules.SeedData);
local l__Plants__7 = l__ReplicatedStorage__4.PlantGenerationModules.Plants;
local l__Fruits__8 = l__ReplicatedStorage__4.PlantGenerationModules.Fruits;
local l__Fruits__9 = l__ReplicatedStorage__4.Assets.Fruits;
l__SoundService__3:FindFirstChild("MusicTracks");
local u2 = {};
local v3 = l__SoundService__3:FindFirstChild("SFX");
if v3 then
    v3 = l__SoundService__3.SFX:FindFirstChild("OfflineGrowthNormal");
end;
u2.Normal = v3;
local v4 = l__SoundService__3:FindFirstChild("SFX");
if v4 then
    v4 = l__SoundService__3.SFX:FindFirstChild("OfflineGrowthIntense");
end;
u2.Intense = v4;
local u5 = {};
local u6 = {};
local u7 = {};
for _, v8 in l__Plants__7:GetChildren() do
    if v8:IsA("ModuleScript") then
        u5[v8.Name] = require(v8);
    end;
end;
for _, v9 in l__Fruits__8:GetChildren() do
    if v9:IsA("ModuleScript") then
        u6[v9.Name] = require(v9);
    end;
end;
for _, v10 in l__SeedData__6 do
    u7[v10.SeedName] = v10;
end;
local function u14(p11) --[[ Line: 86 ]]
    -- upvalues: u2 (copy), l__TweenService__2 (copy)
    local v12 = u2[p11 and "Intense" or "Normal"];
    if not v12 then
        return nil, nil;
    end;
    v12.Looped = true;
    v12.Volume = 0;
    v12:Stop();
    v12:Play();
    local v13 = l__TweenService__2:Create(v12, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Volume = 2
    });
    v13:Play();
    return v12, v13;
end;
local function u18(u15, p16) --[[ Line: 115 ]]
    -- upvalues: l__TweenService__2 (copy)
    if u15 then
        u15.Looped = false;
        local v17 = l__TweenService__2:Create(u15, TweenInfo.new(p16 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Volume = 0
        });
        v17:Play();
        v17.Completed:Once(function() --[[ Line: 132 ]]
            -- upvalues: u15 (copy)
            if u15.Volume <= 0.01 then
                u15:Stop();
                u15.Volume = 2;
            end;
        end);
    end;
end;
local function u32(p19, p20, p21, p22, p23, p24, p25, p26) --[[ Line: 141 ]]
    -- upvalues: l__TweenService__2 (copy), l__RunService__1 (copy)
    if p22 <= 0 then
        p19:SetAttribute("Age", p21);
        if p26 then
            p26(p21, 1);
        end;
        return true;
    else
        local v27 = os.clock();
        while p19.Parent do
            if p25 and p25() then
                return false;
            end;
            local v28 = (os.clock() - v27) / p22;
            local v29 = math.clamp(v28, 0, 1);
            local v30 = l__TweenService__2:GetValue(v29, p23, p24);
            local v31 = p20 + (p21 - p20) * v30;
            p19:SetAttribute("Age", v31);
            if p26 then
                p26(v31, v30);
            end;
            if v29 >= 0.5 then
                return true;
            end;
            l__RunService__1.Heartbeat:Wait();
        end;
        return false;
    end;
end;
function u1.GrowFruits(p33, p34, p35) --[[ Line: 200 ]]
    -- upvalues: u6 (copy), l__Fruits__9 (copy), l__RunService__1 (copy), u32 (copy)
    local v36 = p35 or {};
    local u37 = v36.duration or 6;
    local u38 = v36.seed or 0;
    local u39 = v36.sizeMultiplier or 1;
    local u40 = v36.easingStyle or Enum.EasingStyle.Sine;
    local u41 = v36.easingDirection or Enum.EasingDirection.InOut;
    local l___cancelled__10 = v36._cancelled;
    local l__onComplete__11 = v36.onComplete;
    local u42 = u6[p33];
    if not u42 then
        return;
    end;
    local u43 = l__Fruits__9:FindFirstChild(p33);
    if not u43 then
        return;
    end;
    local u44 = p34:FindFirstChild("Fruits");
    if not u44 then
        u44 = Instance.new("Folder");
        u44.Name = "Fruits";
        u44.Parent = p34;
    end;
    local v45 = p34:FindFirstChild("FruitSpawnLocations");
    if not v45 then
        return;
    end;
    local u46 = u42.GrowData and (u42.GrowData.MaxAge or 100) or 100;
    local v47 = {};
    for u48, u49 in v45:GetChildren() do
        if u49:IsA("BasePart") then
            if l___cancelled__10 and l___cancelled__10() then
                break;
            end;
            table.insert(v47, function() --[[ Line: 249 ]]
                -- upvalues: u43 (copy), u48 (copy), u46 (copy), u39 (copy), u49 (copy), u42 (copy), u38 (copy), l__RunService__1 (ref), l___cancelled__10 (copy), u44 (ref), u32 (ref), u37 (copy), u40 (copy), u41 (copy)
                local v50 = u43:Clone();
                v50.Name = ("DisplayFruit_%d"):format(u48);
                v50:SetAttribute("Age", 0);
                v50:SetAttribute("MaxAge", u46);
                v50:SetAttribute("SizeMulti", u39);
                v50:PivotTo(u49.CFrame);
                u42.InitFruit(v50, u38 + u48, u39);
                repeat
                    l__RunService__1.Heartbeat:Wait();
                until v50:HasTag("InitializationComplete") or l___cancelled__10 and l___cancelled__10();
                if l___cancelled__10 and l___cancelled__10() then
                    v50:Destroy();
                else
                    u42.BeginFruitGrowth(v50);
                    v50.Parent = u44;
                    u32(v50, 0, u46, u37, u40, u41, nil);
                    if l___cancelled__10 and l___cancelled__10() then
                        v50:Destroy();
                    end;
                end;
            end);
        end;
    end;
    local u51 = 0;
    for _, u52 in v47 do
        task.spawn(function() --[[ Line: 289 ]]
            -- upvalues: u52 (copy), u51 (ref)
            u52();
            u51 = u51 + 1;
        end);
    end;
    while u51 < #v47 do
        l__RunService__1.Heartbeat:Wait();
    end;
    if l__onComplete__11 then
        l__onComplete__11();
    end;
end;
require(game.ReplicatedStorage.SharedModules.PlantSizeMultipliers);
function u1.GrowPlant(u53, p54) --[[ Line: 311 ]]
    -- upvalues: u7 (copy), u5 (copy), l__RunService__1 (copy), u14 (copy), u32 (copy), u18 (copy), u1 (copy), l__UserInputService__5 (copy)
    local u55 = p54 or {};
    local l__parent__12 = u55.parent;
    local v56 = u55.position or Vector3.new(0, 0, 0);
    local u57 = u55.seed or 0;
    local _ = u55.sizeMultiplier or 1;
    local u58 = u55.duration or 6;
    local u59 = u55.startAge or 0;
    local l__endAge__13 = u55.endAge;
    local u60 = u55.easingStyle or Enum.EasingStyle.Sine;
    local u61 = u55.easingDirection or Enum.EasingDirection.InOut;
    local u62 = u55.playSound ~= false;
    local u63 = u55.intense or false;
    local l__onStep__14 = u55.onStep;
    local l__onComplete__15 = u55.onComplete;
    local l__onCancelled__16 = u55.onCancelled;
    assert(l__parent__12, "Parent is required");
    local u64 = false;
    local function u65() --[[ Line: 340 ]]
        -- upvalues: u64 (ref)
        return u64;
    end;
    local v66 = u7[u53];
    assert(v66, ("No seed data found for \'%s\'"):format(u53));
    local u67 = u5[u53];
    assert(u67, ("No generation module found for \'%s\'"):format(u53));
    local u68 = v66.PlantModel:Clone();
    u68:SetAttribute("SeedName", u53);
    u68:SetAttribute("MaxAge", v66.MaxAge or 1);
    u68:SetAttribute("Age", u59);
    u68:PivotTo(CFrame.new(v56));
    u68.Parent = l__parent__12;
    local v69 = {};
    local v70 = true;
    local u71 = u64;
    local u72 = v69;
    local u73 = v70;
    for _, v74 in u68:GetDescendants() do
        if u73 then
            if v74:IsA("BasePart") then
                u72[v74] = v74.Transparency;
                v74.Transparency = 1;
            end;
        end;
    end;
    local u76 = u68.DescendantAdded:Connect(function(p75) --[[ Line: 379 ]]
        -- upvalues: u73 (ref), u72 (ref)
        if u73 then
            if p75:IsA("BasePart") then
                u72[p75] = p75.Transparency;
                p75.Transparency = 1;
            end;
        end;
    end);
    local l__camera__17 = u55.camera;
    local u77, u78, u79, u80, u81;
    if l__camera__17 then
        u77 = l__camera__17.CameraType;
        u78 = l__camera__17.CameraSubject;
        u79 = l__camera__17.CFrame;
        u80 = l__camera__17.FieldOfView;
        l__camera__17.CameraType = Enum.CameraType.Scriptable;
        local l__CFrame__18 = l__camera__17.CFrame;
        u81 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 405 ]]
            -- upvalues: l__camera__17 (copy), l__CFrame__18 (copy)
            l__camera__17.CameraType = Enum.CameraType.Scriptable;
            l__camera__17.CFrame = l__CFrame__18;
        end);
    else
        u81 = nil;
        u80 = nil;
        u78 = nil;
        u77 = nil;
        u79 = nil;
    end;
    local function u86() --[[ Line: 412 ]]
        -- upvalues: u68 (copy)
        local v82 = u68:FindFirstChild("Rig");
        if not v82 then
            return pcall(function() --[[ Line: 427 ]]
                -- upvalues: u68 (ref)
                return u68:GetBoundingBox();
            end);
        end;
        v82.Parent = nil;
        local v83, v84, v85 = pcall(function() --[[ Line: 419 ]]
            -- upvalues: u68 (ref)
            return u68:GetBoundingBox();
        end);
        v82.Parent = u68;
        return v83, v84, v85;
    end;
    local u87 = nil;
    local v88 = math.random(1, 3);
    local u89 = math.clamp(v88, 1, 3);
    task.spawn(function() --[[ Line: 442 ]]
        -- upvalues: u67 (copy), u68 (copy), u57 (copy), u89 (ref), l__RunService__1 (ref), u71 (ref), u81 (ref), u73 (ref), u76 (copy), u59 (copy), u72 (ref), l__endAge__13 (ref), u87 (ref), u62 (copy), u14 (ref), u63 (copy), l__camera__17 (copy), u86 (copy), u32 (ref), u58 (copy), u60 (copy), u61 (copy), u65 (copy), l__onStep__14 (copy), u18 (ref), u55 (ref), u1 (ref), u53 (copy), l__UserInputService__5 (ref), u80 (ref), l__onComplete__15 (copy), l__onCancelled__16 (copy)
        u67.InitPlant(u68, u57, u89);
        repeat
            l__RunService__1.Heartbeat:Wait();
        until u68:HasTag("InitializationComplete") or u71;
        if u71 then
            if u81 then
                u81:Disconnect();
                u81 = nil;
            end;
            u73 = false;
            u76:Disconnect();
            u68:Destroy();
        else
            u67.BeginPlantGrowth(u68);
            u73 = false;
            u76:Disconnect();
            u68:SetAttribute("Age", u59);
            for v90, v91 in u72 do
                if v90 and v90.Parent then
                    v90.Transparency = v91;
                end;
            end;
            u72 = nil;
            if l__endAge__13 == nil then
                l__endAge__13 = u68:GetAttribute("MaxAge") or 1;
            end;
            u87 = u62 and u14(u63) or nil;
            local l__Position__19 = u68:GetPivot().Position;
            local v92 = l__camera__17.CFrame.Position - l__Position__19;
            local v93 = Vector3.new(-v92.X, 0, -v92.Z);
            local v94 = Instance.new("Highlight");
            v94.FillColor = Color3.fromRGB(255, 255, 255);
            v94.FillTransparency = 1;
            v94.OutlineColor = Color3.fromRGB(0, 0, 0);
            v94.OutlineTransparency = 0.75;
            v94.DepthMode = Enum.HighlightDepthMode.Occluded;
            v94.Parent = u68;
            local l__Unit__20 = (v93.Magnitude < 0.01 and Vector3.new(0, 0, -1) or v93).Unit;
            local l__Unit__21 = l__Unit__20:Cross(Vector3.new(0, 1, 0)).Unit;
            local u95 = l__Position__19 + l__Unit__20 * 10;
            local u96 = 7;
            local u97 = 0;
            local u98 = 24;
            local l__CFrame__22 = l__camera__17.CFrame;
            local function v130(p99, _, p100, p101) --[[ Line: 538 ]]
                -- upvalues: u86 (ref), l__Position__19 (copy), l__camera__17 (ref), u95 (ref), u96 (ref), u97 (ref), u98 (ref), l__Unit__20 (ref), l__Unit__21 (copy)
                local v102 = 5;
                local v103 = 0;
                local v104, v105, v106 = u86();
                if v104 and (v105 and v106) then
                    v102 = math.max(v102, v106.Magnitude * 0.5);
                    v103 = math.max(v103, v106.Y * 0.35);
                end;
                local v107 = v104 and (v105 and v105.Position) or l__Position__19;
                local v108 = math.rad(l__camera__17.FieldOfView * 0.5);
                local v109 = math.max(v102, 5) * 1.4;
                local v110 = math.max(v108, 0.1);
                local v111 = v109 / math.tan(v110) + 8;
                local v112 = math.clamp(v111, 20, 58);
                local v113 = u95;
                local v114 = math.max(p101, 0.016666666666666666) * -0.6;
                u95 = v113:Lerp(v107, 1 - math.exp(v114));
                local v115 = u96;
                local v116 = v109 - u96;
                local v117 = math.max(p101, 0.016666666666666666) * -0.4;
                u96 = v115 + v116 * (1 - math.exp(v117));
                local v118 = u97;
                local v119 = v103 - u97;
                local v120 = math.max(p101, 0.016666666666666666) * -0.5;
                u97 = v118 + v119 * (1 - math.exp(v120));
                local v121 = u98;
                local v122 = v112 - u98;
                local v123 = math.max(p101, 0.016666666666666666) * -0.4;
                u98 = v121 + v122 * (1 - math.exp(v123));
                local v124 = math.sin(p100 * 0.55) * 0.075;
                local l__Unit__23 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v124):VectorToWorldSpace(l__Unit__20).Unit;
                local v125 = l__Unit__21 * (math.sin(p100 * 0.55 * 0.6) * 1.25);
                local v126 = math.clamp(p99 * 5 + 5 + u97 * 0.12, 4, 12);
                local v127 = math.clamp(1.2 - u97 * 0.08, 0.35, 1.2);
                local v128 = u95 - l__Unit__23 * u98 + Vector3.new(0, v126, 0) + v125;
                local v129 = u95 + Vector3.new(0, v127, 0);
                return CFrame.new(v128, v129);
            end;
            local u131 = false;
            local u132 = false;
            local v133 = os.clock();
            local v134 = 0;
            task.spawn(function() --[[ Line: 585 ]]
                -- upvalues: u32 (ref), u68 (ref), u59 (ref), l__endAge__13 (ref), u58 (ref), u60 (ref), u61 (ref), u65 (ref), l__onStep__14 (ref), u132 (ref), u131 (ref)
                local v135 = u32(u68, u59, l__endAge__13, u58, u60, u61, u65, l__onStep__14);
                u132 = not v135;
                if v135 then
                    u68:SetAttribute("Age", l__endAge__13);
                end;
                u131 = true;
            end);
            local v136;
            if l__camera__17 then
                if u81 then
                    u81:Disconnect();
                    u81 = nil;
                end;
                l__CFrame__22 = v130(0, 0, 0, 0.016666666666666666);
                l__camera__17.CFrame = l__CFrame__22;
                v136 = u132;
                while not u131 and (not u71 and u68.Parent) do
                    local v137 = os.clock() - v133;
                    local v138 = math.clamp(v137 / u58, 0, 1);
                    local v139 = v138 < 0.5 and v138 * 2 * v138 or 1 - (v138 * -2 + 2) ^ 3 / 2;
                    l__camera__17.CameraType = Enum.CameraType.Scriptable;
                    l__CFrame__22 = l__CFrame__22:Lerp(v130(v139, v138, v137, v134), (math.clamp(((1 - v138) * 0.45 + 0.55) * 0.8 * v134, 0, 0.12)));
                    l__camera__17.CFrame = l__CFrame__22;
                    v134 = l__RunService__1.Heartbeat:Wait();
                end;
            else
                v136 = u132;
            end;
            while not u131 do
                l__RunService__1.Heartbeat:Wait();
            end;
            local v140 = not v136;
            if l__camera__17 and v140 then
                u18(u87, 1.5);
                local v141 = u55.idleDuration or 3;
                local v142 = os.clock();
                local _ = 2 + v141;
                task.spawn(function() --[[ Line: 656 ]]
                    -- upvalues: u1 (ref), u53 (ref), u68 (ref), u55 (ref), u58 (ref), u57 (ref), u89 (ref), u60 (ref), u61 (ref), u65 (ref)
                    u1.GrowFruits(u53, u68, {
                        duration = u55.fruitDuration or u58,
                        seed = u57,
                        sizeMultiplier = u89,
                        easingStyle = u60,
                        easingDirection = u61,
                        _cancelled = u65
                    });
                end);
                local v143, v144, _ = u86();
                local v145 = v143 and (v144 and v144.Position) or u68:GetPivot().Position;
                local u146 = 0;
                local u147 = 0;
                local u148 = false;
                local u149 = os.clock();
                local u150 = l__UserInputService__5:GetMouseLocation();
                local u151 = 0;
                local u152 = os.clock();
                local u153 = {};
                local u154 = nil;
                local v160 = l__UserInputService__5.InputChanged:Connect(function(p155) --[[ Line: 691 ]]
                    -- upvalues: u151 (ref), u152 (ref), u153 (ref), u154 (ref), u148 (ref), l__UserInputService__5 (ref), u150 (ref), u146 (ref), u147 (ref), u149 (ref)
                    if p155.UserInputType == Enum.UserInputType.MouseWheel then
                        u151 = math.max(u151 + p155.Position.Z * 4, -8);
                        u152 = os.clock();
                    else
                        if p155.UserInputType == Enum.UserInputType.Touch then
                            u153[p155] = p155.Position;
                            local v156 = {};
                            for _, v157 in u153 do
                                table.insert(v156, v157);
                            end;
                            if #v156 == 2 then
                                local l__Magnitude__24 = (v156[1] - v156[2]).Magnitude;
                                if u154 ~= nil then
                                    u151 = math.max(u151 + (l__Magnitude__24 - u154) * 0.18, -8);
                                    u152 = os.clock();
                                end;
                                u154 = l__Magnitude__24;
                                return;
                            end;
                            u154 = nil;
                        end;
                        if u148 then
                            if p155.UserInputType == Enum.UserInputType.MouseMovement or p155.UserInputType == Enum.UserInputType.Touch then
                                local v158 = l__UserInputService__5:GetMouseLocation();
                                local v159 = v158 - u150;
                                u150 = v158;
                                u146 = u146 - v159.X * 0.4;
                                u147 = math.clamp(u147 - v159.Y * 0.4, -30, 30);
                                u149 = os.clock();
                            end;
                        end;
                    end;
                end);
                local v162 = l__UserInputService__5.InputBegan:Connect(function(p161) --[[ Line: 736 ]]
                    -- upvalues: u153 (ref), u148 (ref), u149 (ref), u150 (ref), l__UserInputService__5 (ref)
                    if p161.UserInputType == Enum.UserInputType.MouseButton1 or p161.UserInputType == Enum.UserInputType.Touch then
                        u153[p161] = p161.Position;
                        u148 = true;
                        u149 = os.clock();
                        u150 = l__UserInputService__5:GetMouseLocation();
                    end;
                end);
                local v165 = l__UserInputService__5.InputEnded:Connect(function(p163) --[[ Line: 745 ]]
                    -- upvalues: u153 (ref), u154 (ref), u148 (ref)
                    if p163.UserInputType == Enum.UserInputType.MouseButton1 or p163.UserInputType == Enum.UserInputType.Touch then
                        u153[p163] = nil;
                        u154 = nil;
                        local v164 = false;
                        for _ in u153 do
                            v164 = true;
                            break;
                        end;
                        if not v164 then
                            u148 = false;
                        end;
                    end;
                end);
                local v166 = u146;
                local v167 = u149;
                local v168 = u152;
                local v169 = u147;
                local v170 = u148;
                local v171 = false;
                while not (u71 or u71) do
                    local v172 = os.clock() - v142;
                    local v173 = math.clamp(v172 / 2, 0, 1);
                    local v174 = os.clock() - v133;
                    if not v170 then
                        local v175 = (v172 - 2) / math.max(v141, 0.001);
                        math.clamp(v175, 0, 1);
                    end;
                    if os.clock() - v168 >= 2.5 then
                        u151 = u151 * (1 - (1 - math.exp(v134 * -2.5)));
                    end;
                    u151 = math.clamp(u151, -8, 22);
                    local v176 = math.clamp(u151 + 0, -8, 40);
                    l__camera__17.FieldOfView = u80;
                    if not v170 and os.clock() - v167 >= 2 then
                        local v177 = 1 - math.exp(v134 * -3.5);
                        u146 = v166 * (1 - v177);
                        u147 = v169 * (1 - v177);
                        v169 = u147;
                        v166 = u146;
                    end;
                    if not v171 and 2 + v141 <= v172 then
                        v171 = true;
                        if l__onComplete__15 then
                            task.spawn(function() --[[ Line: 807 ]]
                                -- upvalues: l__onComplete__15 (ref), u68 (ref)
                                l__onComplete__15(u68);
                            end);
                        end;
                    end;
                    local v178 = v130(1, 1, v174, v134);
                    local v179 = v178:Lerp(CFrame.new(v178.Position + (v145 - v178.Position).Unit * v176 + Vector3.new(0, -1.25, 0), v145 + Vector3.new(0, 0.55, 0)), v173);
                    if math.abs(v166) > 0.001 or math.abs(v169) > 0.001 then
                        local v180 = v179.Position - v145;
                        local v181 = CFrame.new(v145) * CFrame.Angles(0, math.rad(v166), 0) * CFrame.Angles(math.rad(v169), 0, 0) * CFrame.new(v180);
                        v179 = CFrame.new(v181.Position, v145 + Vector3.new(0, 0.55, 0));
                    end;
                    l__CFrame__22 = l__CFrame__22:Lerp(v179, (math.clamp(v134 * 3.2, 0, 0.1)));
                    l__camera__17.CFrame = l__CFrame__22;
                    v134 = l__RunService__1.Heartbeat:Wait();
                end;
                v160:Disconnect();
                v162:Disconnect();
                v165:Disconnect();
                u153 = {};
                u154 = nil;
            end;
            if v140 then
                if l__onComplete__15 then
                    l__onComplete__15(u68);
                end;
            else
                if l__onCancelled__16 then
                    l__onCancelled__16(u68);
                end;
            end;
        end;
    end);
    return function(p182) --[[ Line: 867 ]]
        -- upvalues: u71 (ref), u18 (ref), u87 (ref), u73 (ref), u76 (copy), u81 (ref), l__camera__17 (copy), u77 (ref), u78 (ref), u80 (ref), u79 (ref)
        u71 = true;
        u18(u87, 1.5);
        u73 = false;
        if u76 then
            u76:Disconnect();
        end;
        if u81 then
            u81:Disconnect();
            u81 = nil;
        end;
        if not p182 and l__camera__17 then
            l__camera__17.CameraType = u77;
            l__camera__17.CameraSubject = u78;
            l__camera__17.FieldOfView = u80;
            l__camera__17.CFrame = u79;
        end;
    end;
end;
return u1;