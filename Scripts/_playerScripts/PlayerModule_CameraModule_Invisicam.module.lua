-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CommonUtils__2 = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(l__CommonUtils__2:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2");
local u2 = {
    LIMBS = 2,
    MOVEMENT = 3,
    CORNERS = 4,
    CIRCLE1 = 5,
    CIRCLE2 = 6,
    LIMBMOVE = 7,
    SMART_CIRCLE = 8,
    CHAR_OUTLINE = 9
};
local u3 = {
    Head = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    LeftLowerArm = true,
    RightLowerArm = true,
    LeftUpperLeg = true,
    RightUpperLeg = true
};
local u4 = {
    Vector3.new(1, 1, -1),
    Vector3.new(1, -1, -1),
    Vector3.new(-1, -1, -1),
    Vector3.new(-1, 1, -1)
};
local u5 = RaycastParams.new();
u5.FilterType = Enum.RaycastFilterType.Exclude;
local u6 = RaycastParams.new();
u6.FilterType = Enum.RaycastFilterType.Include;
local function u12(p7, ...) --[[ Line: 71 ]]
    local v8 = {};
    local v9 = "";
    for _, v10 in pairs({ ... }) do
        v8[v10] = true;
        v9 = v9 .. (v9 == "" and "" or " or ") .. v10;
    end;
    local v11 = type(p7);
    assert(v8[v11], v9 .. " type expected, got: " .. v11);
end;
local function u32(p13, p14, p15, p16) --[[ Line: 91 ]]
    local v17 = p14:Cross(p16);
    local v18 = p15.X - p13.X;
    local v19 = p15.Y - p13.Y;
    local v20 = p15.Z - p13.Z;
    local l__X__3 = p14.X;
    local v21 = -p16.X;
    local l__X__4 = v17.X;
    local l__Y__5 = p14.Y;
    local v22 = -p16.Y;
    local l__Y__6 = v17.Y;
    local l__Z__7 = p14.Z;
    local v23 = -p16.Z;
    local l__Z__8 = v17.Z;
    local v24 = l__X__3 * (v22 * l__Z__8 - l__Y__6 * v23) - v21 * (l__Y__5 * l__Z__8 - l__Y__6 * l__Z__7) + l__X__4 * (l__Y__5 * v23 - v22 * l__Z__7);
    if v24 == 0 then
        return Vector3.new(0, 0, 0);
    end;
    local v25 = -p16.X;
    local l__X__9 = v17.X;
    local v26 = -p16.Y;
    local l__Y__10 = v17.Y;
    local v27 = -p16.Z;
    local l__Z__11 = v17.Z;
    local v28 = (v18 * (v26 * l__Z__11 - l__Y__10 * v27) - v25 * (v19 * l__Z__11 - l__Y__10 * v20) + l__X__9 * (v19 * v27 - v26 * v20)) / v24;
    local l__X__12 = p14.X;
    local l__X__13 = v17.X;
    local l__Y__14 = p14.Y;
    local l__Y__15 = v17.Y;
    local l__Z__16 = p14.Z;
    local l__Z__17 = v17.Z;
    local v29 = (l__X__12 * (v19 * l__Z__17 - l__Y__15 * v20) - v18 * (l__Y__14 * l__Z__17 - l__Y__15 * l__Z__16) + l__X__13 * (l__Y__14 * v20 - v19 * l__Z__16)) / v24;
    local v30 = p13 + v28 * p14;
    local v31 = p15 + v29 * p16;
    return (v31 - v30).Magnitude >= 0.25 and Vector3.new(0, 0, 0) or v30 + (v31 - v30) * 0.5;
end;
local l__BaseOcclusion__18 = require(script.Parent:WaitForChild("BaseOcclusion"));
local u33 = setmetatable({}, l__BaseOcclusion__18);
u33.__index = u33;
function u33.new() --[[ Line: 124 ]]
    -- upvalues: l__BaseOcclusion__18 (copy), u33 (copy), u2 (copy)
    local v34 = l__BaseOcclusion__18.new();
    local v35 = setmetatable(v34, u33);
    v35.char = nil;
    v35.humanoidRootPart = nil;
    v35.torsoPart = nil;
    v35.headPart = nil;
    v35.childAddedConn = nil;
    v35.childRemovedConn = nil;
    v35.behaviors = {};
    v35.behaviors[u2.LIMBS] = v35.LimbBehavior;
    v35.behaviors[u2.MOVEMENT] = v35.MoveBehavior;
    v35.behaviors[u2.CORNERS] = v35.CornerBehavior;
    v35.behaviors[u2.CIRCLE1] = v35.CircleBehavior;
    v35.behaviors[u2.CIRCLE2] = v35.CircleBehavior;
    v35.behaviors[u2.LIMBMOVE] = v35.LimbMoveBehavior;
    v35.behaviors[u2.SMART_CIRCLE] = v35.SmartCircleBehavior;
    v35.behaviors[u2.CHAR_OUTLINE] = v35.CharacterOutlineBehavior;
    v35.mode = u2.SMART_CIRCLE;
    v35.behaviorFunction = v35.SmartCircleBehavior;
    v35.savedHits = {};
    v35.trackedLimbs = {};
    v35.camera = game.Workspace.CurrentCamera;
    v35.enabled = false;
    return v35;
end;
function u33.Enable(p36, p37) --[[ Line: 157 ]]
    p36.enabled = p37;
    if not p37 then
        p36:Cleanup();
    end;
end;
function u33.GetOcclusionMode(_) --[[ Line: 165 ]]
    return Enum.DevCameraOcclusionMode.Invisicam;
end;
function u33.LimbBehavior(p38, p39) --[[ Line: 170 ]]
    for v40, _ in pairs(p38.trackedLimbs) do
        p39[#p39 + 1] = v40.Position;
    end;
end;
function u33.MoveBehavior(p41, p42) --[[ Line: 176 ]]
    for v43 = 1, 3 do
        local l__Position__19 = p41.humanoidRootPart.Position;
        local l__Velocity__20 = p41.humanoidRootPart.Velocity;
        local v44 = Vector3.new(l__Velocity__20.X, 0, l__Velocity__20.Z).Magnitude / 2;
        p42[#p42 + 1] = l__Position__19 + (v43 - 1) * p41.humanoidRootPart.CFrame.lookVector * v44;
    end;
end;
function u33.CornerBehavior(p45, p46) --[[ Line: 185 ]]
    -- upvalues: u4 (copy)
    local l__CFrame__21 = p45.humanoidRootPart.CFrame;
    local l__Position__22 = l__CFrame__21.Position;
    local v47 = l__CFrame__21 - l__Position__22;
    local v48 = p45.char:GetExtentsSize() / 2;
    p46[#p46 + 1] = l__Position__22;
    for v49 = 1, #u4 do
        p46[#p46 + 1] = l__Position__22 + v47 * (v48 * u4[v49]);
    end;
end;
function u33.CircleBehavior(p50, p51) --[[ Line: 196 ]]
    -- upvalues: u2 (copy)
    local v52;
    if p50.mode == u2.CIRCLE1 then
        v52 = p50.humanoidRootPart.CFrame;
    else
        local l__CoordinateFrame__23 = p50.camera.CoordinateFrame;
        v52 = l__CoordinateFrame__23 - l__CoordinateFrame__23.Position + p50.humanoidRootPart.Position;
    end;
    p51[#p51 + 1] = v52.Position;
    for v53 = 0, 9 do
        local v54 = 0.6283185307179586 * v53;
        local v55 = math.cos(v54);
        local v56 = math.sin(v54);
        local v57 = Vector3.new(v55, v56, 0) * 3;
        p51[#p51 + 1] = v52 * v57;
    end;
end;
function u33.LimbMoveBehavior(p58, p59) --[[ Line: 212 ]]
    p58:LimbBehavior(p59);
    p58:MoveBehavior(p59);
end;
function u33.CharacterOutlineBehavior(p60, p61) --[[ Line: 217 ]]
    -- upvalues: u1 (copy), u6 (copy)
    local l__unit__24 = p60.torsoPart.CFrame.upVector.unit;
    local l__unit__25 = p60.torsoPart.CFrame.rightVector.unit;
    p61[#p61 + 1] = p60.torsoPart.CFrame.p;
    p61[#p61 + 1] = p60.torsoPart.CFrame.p + l__unit__24;
    p61[#p61 + 1] = p60.torsoPart.CFrame.p - l__unit__24;
    p61[#p61 + 1] = p60.torsoPart.CFrame.p + l__unit__25;
    p61[#p61 + 1] = p60.torsoPart.CFrame.p - l__unit__25;
    if p60.headPart then
        p61[#p61 + 1] = p60.headPart.CFrame.p;
    end;
    local v62 = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(p60.camera.CoordinateFrame.lookVector.X, 0, p60.camera.CoordinateFrame.lookVector.Z)));
    local v63 = p60.torsoPart and p60.torsoPart.Position or p60.humanoidRootPart.Position;
    local v64 = { p60.torsoPart };
    if p60.headPart then
        v64[#v64 + 1] = p60.headPart;
    end;
    for v65 = 1, 24 do
        local v66 = 6.283185307179586 * v65 / 24;
        local v67 = math.cos(v66);
        local v68 = math.sin(v66);
        local v69 = v62 * (Vector3.new(v67, v68, 0) * 3);
        local l__X__26 = v69.X;
        local v70 = math.max(v69.Y, -2.25);
        local v71 = Vector3.new(l__X__26, v70, v69.Z);
        if u1 then
            u6.FilterDescendantsInstances = v64;
            local v72 = game.Workspace:Raycast(v63 + v71, -3 * v71, u6);
            if v72 then
                local l__Position__27 = v72.Position;
                p61[#p61 + 1] = l__Position__27 + 0.2 * (v63 - l__Position__27).unit;
            end;
        else
            local v73 = Ray.new(v63 + v71, -3 * v71);
            local v74, v75 = game.Workspace:FindPartOnRayWithWhitelist(v73, v64, false);
            if v74 then
                p61[#p61 + 1] = v75 + 0.2 * (v63 - v75).unit;
            end;
        end;
    end;
end;
function u33.SmartCircleBehavior(p76, p77) --[[ Line: 268 ]]
    -- upvalues: u1 (copy), u5 (copy), u32 (copy)
    local l__unit__28 = p76.torsoPart.CFrame.upVector.unit;
    local l__unit__29 = p76.torsoPart.CFrame.rightVector.unit;
    p77[#p77 + 1] = p76.torsoPart.CFrame.p;
    p77[#p77 + 1] = p76.torsoPart.CFrame.p + l__unit__28;
    p77[#p77 + 1] = p76.torsoPart.CFrame.p - l__unit__28;
    p77[#p77 + 1] = p76.torsoPart.CFrame.p + l__unit__29;
    p77[#p77 + 1] = p76.torsoPart.CFrame.p - l__unit__29;
    if p76.headPart then
        p77[#p77 + 1] = p76.headPart.CFrame.p;
    end;
    local v78 = p76.camera.CFrame - p76.camera.CFrame.p;
    local v79 = Vector3.new(0, 0.5, 0) + (p76.torsoPart and p76.torsoPart.Position or p76.humanoidRootPart.Position);
    for v80 = 1, 24 do
        local v81 = 0.2617993877991494 * v80 - 1.5707963267948966;
        local v82 = math.cos(v81);
        local v83 = math.sin(v81);
        local v84 = v79 + v78 * (Vector3.new(v82, v83, 0) * 2.5);
        local v85 = v84 - p76.camera.CFrame.p;
        if u1 then
            u5.FilterDescendantsInstances = { p76.char };
            local v86 = game.Workspace:Raycast(v79, v84 - v79, u5);
            if v86 then
                local l__Position__30 = v86.Position;
                local l__Normal__31 = v86.Normal;
                local v87 = l__Position__30 + 0.1 * l__Normal__31.unit;
                local v88 = v87 - v79;
                local l__unit__32 = v88:Cross(v85).unit:Cross(l__Normal__31).unit;
                local l__unit__33 = (v87 - p76.camera.CFrame.p).unit;
                if v88.unit:Dot(-l__unit__32) < v88.unit:Dot(l__unit__33) then
                    v84 = u32(v87, l__unit__32, v84, v85);
                    if v84.Magnitude > 0 then
                        local v89 = game.Workspace:Raycast(v87, v84 - v87, u5);
                        if v89 then
                            v84 = v89.Position + 0.1 * v89.Normal.Unit;
                        end;
                    else
                        v84 = v87;
                    end;
                else
                    v84 = v87;
                end;
                local v90 = game.Workspace:Raycast(v79, v84 - v79, u5);
                if v90 then
                    v84 = v90.Position - 0.1 * (v84 - v79).unit;
                end;
            end;
            p77[#p77 + 1] = v84;
        else
            local v91 = Ray.new(v79, v84 - v79);
            local v92, v93, v94 = game.Workspace:FindPartOnRayWithIgnoreList(v91, { p76.char }, false, false);
            if v92 then
                local v95 = v93 + 0.1 * v94.unit;
                local v96 = v95 - v79;
                local l__unit__34 = v96:Cross(v85).unit:Cross(v94).unit;
                local l__unit__35 = (v95 - p76.camera.CFrame.p).unit;
                if v96.unit:Dot(-l__unit__34) < v96.unit:Dot(l__unit__35) then
                    v84 = u32(v95, l__unit__34, v84, v85);
                    if v84.Magnitude > 0 then
                        local v97 = Ray.new(v95, v84 - v95);
                        local v98, v99, v100 = game.Workspace:FindPartOnRayWithIgnoreList(v97, { p76.char }, false, false);
                        if v98 then
                            v84 = v99 + 0.1 * v100.unit;
                        end;
                    else
                        v84 = v95;
                    end;
                else
                    v84 = v95;
                end;
                local v101 = Ray.new(v79, v84 - v79);
                local v102, v103, _ = game.Workspace:FindPartOnRayWithIgnoreList(v101, { p76.char }, false, false);
                if v102 then
                    v84 = v103 - 0.1 * (v84 - v79).unit;
                end;
            end;
            p77[#p77 + 1] = v84;
        end;
    end;
end;
function u33.CheckTorsoReference(p104) --[[ Line: 403 ]]
    if p104.char then
        p104.torsoPart = p104.char:FindFirstChild("Torso");
        if not p104.torsoPart then
            p104.torsoPart = p104.char:FindFirstChild("UpperTorso");
            if not p104.torsoPart then
                p104.torsoPart = p104.char:FindFirstChild("HumanoidRootPart");
            end;
        end;
        p104.headPart = p104.char:FindFirstChild("Head");
    end;
end;
function u33.CharacterAdded(u105, p106, p107) --[[ Line: 417 ]]
    -- upvalues: l__Players__1 (copy), u3 (copy)
    if p107 == l__Players__1.LocalPlayer then
        if u105.childAddedConn then
            u105.childAddedConn:Disconnect();
            u105.childAddedConn = nil;
        end;
        if u105.childRemovedConn then
            u105.childRemovedConn:Disconnect();
            u105.childRemovedConn = nil;
        end;
        u105.char = p106;
        u105.trackedLimbs = {};
        u105.childAddedConn = p106.ChildAdded:Connect(function(p108) --[[ Name: childAdded, Line 433 ]]
            -- upvalues: u3 (ref), u105 (copy)
            if p108:IsA("BasePart") then
                if u3[p108.Name] then
                    u105.trackedLimbs[p108] = true;
                end;
                if p108.Name == "Torso" or p108.Name == "UpperTorso" then
                    u105.torsoPart = p108;
                end;
                if p108.Name == "Head" then
                    u105.headPart = p108;
                end;
            end;
        end);
        u105.childRemovedConn = p106.ChildRemoved:Connect(function(p109) --[[ Name: childRemoved, Line 449 ]]
            -- upvalues: u105 (copy)
            u105.trackedLimbs[p109] = nil;
            u105:CheckTorsoReference();
        end);
        for _, v110 in pairs(u105.char:GetChildren()) do
            if v110:IsA("BasePart") then
                if u3[v110.Name] then
                    u105.trackedLimbs[v110] = true;
                end;
                if v110.Name == "Torso" or v110.Name == "UpperTorso" then
                    u105.torsoPart = v110;
                end;
                if v110.Name == "Head" then
                    u105.headPart = v110;
                end;
            end;
        end;
    end;
end;
function u33.SetMode(p111, p112) --[[ Line: 463 ]]
    -- upvalues: u12 (copy), u2 (copy)
    u12(p112, "number");
    for _, v113 in pairs(u2) do
        if v113 == p112 then
            p111.mode = p112;
            p111.behaviorFunction = p111.behaviors[p111.mode];
            return;
        end;
    end;
    error("Invalid mode number");
end;
function u33.GetObscuredParts(p114) --[[ Line: 475 ]]
    return p114.savedHits;
end;
function u33.Cleanup(p115) --[[ Line: 480 ]]
    for v116, v117 in pairs(p115.savedHits) do
        v116.LocalTransparencyModifier = v117;
    end;
end;
function u33.Update(u118, _, p119, p120) --[[ Line: 486 ]]
    if not (u118.enabled and u118.char) then
        return p119, p120;
    end;
    u118.camera = game.Workspace.CurrentCamera;
    if not u118.humanoidRootPart then
        local v121 = u118.char:FindFirstChildOfClass("Humanoid");
        if v121 and v121.RootPart then
            u118.humanoidRootPart = v121.RootPart;
        else
            u118.humanoidRootPart = u118.char:FindFirstChild("HumanoidRootPart");
            if not u118.humanoidRootPart then
                return p119, p120;
            end;
        end;
        local u122 = nil;
        u122 = u118.humanoidRootPart.AncestryChanged:Connect(function(p123, p124) --[[ Line: 511 ]]
            -- upvalues: u118 (copy), u122 (ref)
            if p123 == u118.humanoidRootPart and not p124 then
                u118.humanoidRootPart = nil;
                if u122 and u122.Connected then
                    u122:Disconnect();
                    u122 = nil;
                end;
            end;
        end);
    end;
    if not u118.torsoPart then
        u118:CheckTorsoReference();
        if not u118.torsoPart then
            return p119, p120;
        end;
    end;
    local v125 = {};
    u118.behaviorFunction(u118, v125);
    local v126 = { u118.char };
    local v127 = u118.camera:GetPartsObscuringTarget({ u118.headPart and u118.headPart.CFrame.p or v125[1], u118.torsoPart and u118.torsoPart.CFrame.p or v125[2] }, v126);
    local v128 = 0;
    local v129 = {};
    local v130 = 0.75;
    local v131 = {};
    local v132 = 0.75;
    for v133 = 1, #v127 do
        local v134 = v127[v133];
        v128 = v128 + 1;
        v129[v134] = true;
        for _, v135 in pairs(v134:GetChildren()) do
            if v135:IsA("Decal") or v135:IsA("Texture") then
                v128 = v128 + 1;
                break;
            end;
        end;
    end;
    if v128 > 0 then
        v130 = math.pow(0.375 / v128 + 0.375, 1 / v128);
        v132 = math.pow(0.25 / v128 + 0.25, 1 / v128);
    end;
    local v136 = u118.camera:GetPartsObscuringTarget(v125, v126);
    local v137 = {};
    for v138 = 1, #v136 do
        local v139 = v136[v138];
        v137[v139] = v129[v139] and v130 and v130 or v132;
        if v139.Transparency < v137[v139] then
            v131[v139] = true;
            if not u118.savedHits[v139] then
                u118.savedHits[v139] = v139.LocalTransparencyModifier;
            end;
        end;
        for _, v140 in pairs(v139:GetChildren()) do
            if (v140:IsA("Decal") or v140:IsA("Texture")) and v140.Transparency < v137[v139] then
                v137[v140] = v137[v139];
                v131[v140] = true;
                if not u118.savedHits[v140] then
                    u118.savedHits[v140] = v140.LocalTransparencyModifier;
                end;
            end;
        end;
    end;
    for v141, v142 in pairs(u118.savedHits) do
        if v131[v141] then
            v141.LocalTransparencyModifier = v141.Transparency < 1 and ((v137[v141] - v141.Transparency) / (1 - v141.Transparency) or 0) or 0;
        else
            v141.LocalTransparencyModifier = v142;
            u118.savedHits[v141] = nil;
        end;
    end;
    return p119, p120;
end;
return u33;