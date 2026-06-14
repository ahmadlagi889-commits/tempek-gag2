-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CommonUtils__2 = script.Parent.Parent.Parent:WaitForChild("CommonUtils");
local l__FlagUtil__3 = require(l__CommonUtils__2:WaitForChild("FlagUtil"));
local l__CameraWrapper__4 = require(l__CommonUtils__2:WaitForChild("CameraWrapper"));
local l__ConnectionUtil__5 = require(l__CommonUtils__2:WaitForChild("ConnectionUtil"));
local u1 = l__FlagUtil__3.getUserFlag("UserRaycastUpdateAPI2");
local u2 = l__FlagUtil__3.getUserFlag("UserCurrentCameraUpdate2");
local u3 = l__FlagUtil__3.getUserFlag("UserPlayerConnectionMemoryLeak");
local u4;
if u2 then
    u4 = l__CameraWrapper__4.new();
else
    u4 = nil;
end;
local u5;
if u2 then
    u5 = nil;
else
    u5 = game.Workspace.CurrentCamera;
end;
if u2 then
    u4:Enable();
end;
local l__min__6 = math.min;
local l__tan__7 = math.tan;
local l__rad__8 = math.rad;
local l__new__9 = Ray.new;
local u6 = RaycastParams.new();
u6.IgnoreWater = true;
u6.FilterType = Enum.RaycastFilterType.Exclude;
u6.RespectCanCollide = true;
local u7 = RaycastParams.new();
u7.IgnoreWater = true;
u7.FilterType = Enum.RaycastFilterType.Include;
local u8;
if u3 then
    u8 = l__ConnectionUtil__5.new();
else
    u8 = nil;
end;
local u9 = nil;
local u10 = nil;
local u11, u12, u13;
if u2 then
    local function v17() --[[ Line: 57 ]]
        -- upvalues: u4 (copy), l__rad__8 (copy), u10 (ref), l__tan__7 (copy), u9 (ref)
        local v14 = u4:getCamera();
        local v15 = l__rad__8(v14.FieldOfView);
        local l__ViewportSize__10 = v14.ViewportSize;
        local v16 = l__ViewportSize__10.X / l__ViewportSize__10.Y;
        u10 = l__tan__7(v15 / 2) * 2;
        u9 = v16 * u10;
    end;
    u4:Connect("FieldOfView", v17);
    u4:Connect("ViewportSize", v17);
    local v18 = u4:getCamera();
    local v19 = l__rad__8(v18.FieldOfView);
    local l__ViewportSize__11 = v18.ViewportSize;
    local v20 = l__ViewportSize__11.X / l__ViewportSize__11.Y;
    local v21 = l__tan__7(v19 / 2) * 2;
    local v22 = v20 * v21;
    local l__NearPlaneZ__12 = u4:getCamera().NearPlaneZ;
    u4:Connect("NearPlaneZ", function() --[[ Line: 73 ]]
        -- upvalues: l__NearPlaneZ__12 (ref), u4 (copy)
        l__NearPlaneZ__12 = u4:getCamera().NearPlaneZ;
    end);
    u11 = v21;
    u12 = v22;
    u13 = l__NearPlaneZ__12;
else
    local function v25() --[[ Line: 79 ]]
        -- upvalues: u5 (ref), l__rad__8 (copy), u10 (ref), l__tan__7 (copy), u9 (ref)
        local v23 = l__rad__8(u5.FieldOfView);
        local l__ViewportSize__13 = u5.ViewportSize;
        local v24 = l__ViewportSize__13.X / l__ViewportSize__13.Y;
        u10 = l__tan__7(v23 / 2) * 2;
        u9 = v24 * u10;
    end;
    u5:GetPropertyChangedSignal("FieldOfView"):Connect(v25);
    u5:GetPropertyChangedSignal("ViewportSize"):Connect(v25);
    local v26 = l__rad__8(u5.FieldOfView);
    local l__ViewportSize__14 = u5.ViewportSize;
    local v27 = l__ViewportSize__14.X / l__ViewportSize__14.Y;
    local v28 = l__tan__7(v26 / 2) * 2;
    local v29 = v27 * v28;
    local l__NearPlaneZ__15 = u5.NearPlaneZ;
    u5:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() --[[ Line: 93 ]]
        -- upvalues: l__NearPlaneZ__15 (ref), u5 (ref)
        l__NearPlaneZ__15 = u5.NearPlaneZ;
    end);
    u11 = v28;
    u12 = v29;
    u13 = l__NearPlaneZ__15;
end;
local u30 = {};
local u31 = {};
local function v42(u32) --[[ Line: 111 ]]
    -- upvalues: u31 (copy), u30 (ref), u3 (copy), u8 (copy)
    local function v36(p33) --[[ Line: 112 ]]
        -- upvalues: u31 (ref), u32 (copy), u30 (ref)
        u31[u32] = p33;
        local v34 = 1;
        u30 = {};
        for _, v35 in pairs(u31) do
            u30[v34] = v35;
            v34 = v34 + 1;
        end;
    end;
    local function v39() --[[ Line: 116 ]]
        -- upvalues: u31 (ref), u32 (copy), u30 (ref)
        u31[u32] = nil;
        local v37 = 1;
        u30 = {};
        for _, v38 in pairs(u31) do
            u30[v37] = v38;
            v37 = v37 + 1;
        end;
    end;
    if u3 then
        u8:trackConnection(`{u32.UserId}CharacterAdded`, u32.CharacterAdded:Connect(v36));
        u8:trackConnection(`{u32.UserId}CharacterRemoving`, u32.CharacterRemoving:Connect(v39));
    else
        u32.CharacterAdded:Connect(v36);
        u32.CharacterRemoving:Connect(v39);
    end;
    if u32.Character then
        u31[u32] = u32.Character;
        local v40 = 1;
        u30 = {};
        for _, v41 in pairs(u31) do
            u30[v40] = v41;
            v40 = v40 + 1;
        end;
    end;
end;
local function v46(p43) --[[ Line: 134 ]]
    -- upvalues: u31 (copy), u30 (ref), u3 (copy), u8 (copy)
    u31[p43] = nil;
    local v44 = 1;
    u30 = {};
    for _, v45 in pairs(u31) do
        u30[v44] = v45;
        v44 = v44 + 1;
    end;
    if u3 then
        u8:disconnect((`{p43.UserId}CharacterAdded`));
        u8:disconnect((`{p43.UserId}CharacterRemoving`));
    end;
end;
l__Players__1.PlayerAdded:Connect(v42);
l__Players__1.PlayerRemoving:Connect(v46);
for _, v47 in ipairs(l__Players__1:GetPlayers()) do
    v42(v47);
end;
local v48 = 1;
u30 = {};
local u49 = u30;
for _, v50 in pairs(u31) do
    u49[v48] = v50;
    v48 = v48 + 1;
end;
local u51 = nil;
local u52 = nil;
if u2 then
    u4:Connect("CameraSubject", function() --[[ Line: 174 ]]
        -- upvalues: u4 (copy), u52 (ref)
        local l__CameraSubject__16 = u4:getCamera().CameraSubject;
        if l__CameraSubject__16 and l__CameraSubject__16:IsA("Humanoid") then
            u52 = l__CameraSubject__16.RootPart;
        elseif l__CameraSubject__16 and l__CameraSubject__16:IsA("BasePart") then
            u52 = l__CameraSubject__16;
        else
            u52 = nil;
        end;
    end);
else
    u5:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 185 ]]
        -- upvalues: u5 (ref), u52 (ref)
        local l__CameraSubject__17 = u5.CameraSubject;
        if l__CameraSubject__17:IsA("Humanoid") then
            u52 = l__CameraSubject__17.RootPart;
        elseif l__CameraSubject__17:IsA("BasePart") then
            u52 = l__CameraSubject__17;
        else
            u52 = nil;
        end;
    end);
end;
local u53 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
};
local function u64(p54, p55) --[[ Line: 225 ]]
    -- upvalues: u1 (copy), u6 (copy), u49 (ref), l__new__9 (copy)
    if u1 then
        u6.FilterDescendantsInstances = u49;
        local v56 = workspace:Raycast(p54, p55, u6);
        if v56 then
            return v56.Position, true;
        end;
        return p54 + p55, false;
    else
        local v57 = #u49;
        while true do
            local v58, v59 = workspace:FindPartOnRayWithIgnoreList(l__new__9(p54, p55), u49, false, true);
            if v58 then
                if v58.CanCollide then
                    local v60 = u49;
                    for v61 = #v60, v57 + 1, -1 do
                        v60[v61] = nil;
                    end;
                    return v59, true;
                end;
                u49[#u49 + 1] = v58;
            end;
            if not v58 then
                local v62 = u49;
                for v63 = #v62, v57 + 1, -1 do
                    v62[v63] = nil;
                end;
                return p54 + p55, false;
            end;
        end;
    end;
end;
local function u90(p65, p66, p67, p68) --[[ Line: 258 ]]
    -- upvalues: u49 (ref), u13 (ref), u1 (copy), u6 (copy), u51 (ref), u7 (copy), l__new__9 (copy)
    debug.profilebegin("queryPoint");
    local v69 = #u49;
    local v70 = p67 + u13;
    local v71 = p65 + p66 * v70;
    local v72 = (1 / 0);
    local v73 = (1 / 0);
    local v74 = 0;
    local v75;
    if u1 then
        u6.FilterDescendantsInstances = u49;
        local v76 = p65;
        while true do
            local v77 = workspace:Raycast(p65, v71 - p65, u6);
            if not v77 then
                v75 = v72;
                break;
            end;
            v74 = v74 + 1;
            local l__Instance__18 = v77.Instance;
            local l__Position__19 = v77.Position;
            v75 = (l__Position__19 - v76).Magnitude;
            if v74 >= 64 then
                v73 = v75;
                v75 = v72;
            else
                local v78;
                if 1 - (1 - l__Instance__18.Transparency) * (1 - l__Instance__18.LocalTransparencyModifier) < 0.25 then
                    v78 = u1 or l__Instance__18.CanCollide;
                    if v78 then
                        if u51 == (l__Instance__18:GetRootPart() or l__Instance__18) then
                            v78 = false;
                        else
                            v78 = not l__Instance__18:IsA("TrussPart");
                        end;
                    end;
                else
                    v78 = false;
                end;
                if v78 then
                    u7.FilterDescendantsInstances = { l__Instance__18 };
                    if workspace:Raycast(v71, l__Position__19 - v71, u7) then
                        local v79;
                        if p68 then
                            v79 = workspace:Raycast(p68, v71 - p68, u7) or workspace:Raycast(v71, p68 - v71, u7);
                        else
                            v79 = false;
                        end;
                        if v79 then
                            v73 = v75;
                            v75 = v72;
                        elseif v70 >= v72 then
                            v75 = v72;
                        end;
                    else
                        v73 = v75;
                        v75 = v72;
                    end;
                else
                    v75 = v72;
                end;
            end;
            u6:AddToFilter(l__Instance__18);
            p65 = l__Position__19 - p66 * 0.001;
            if v73 < (1 / 0) or not l__Instance__18 then
                break;
            end;
            v72 = v75;
        end;
    else
        local v80 = p65;
        while true do
            local v81;
            if true then
                local v82;
                v81, v82 = workspace:FindPartOnRayWithIgnoreList(l__new__9(p65, v71 - p65), u49, false, true);
                v74 = v74 + 1;
                if v81 then
                    local v83 = v74 >= 64;
                    local v84;
                    if 1 - (1 - v81.Transparency) * (1 - v81.LocalTransparencyModifier) < 0.25 then
                        v84 = u1 or v81.CanCollide;
                        if v84 then
                            if u51 == (v81:GetRootPart() or v81) then
                                v84 = false;
                            else
                                v84 = not v81:IsA("TrussPart");
                            end;
                        end;
                    else
                        v84 = false;
                    end;
                    if v84 or v83 then
                        local v85 = { v81 };
                        local v86 = workspace:FindPartOnRayWithWhitelist(l__new__9(v71, v82 - v71), v85, true);
                        v75 = (v82 - v80).Magnitude;
                        if v86 and not v83 then
                            local v87;
                            if p68 then
                                v87 = workspace:FindPartOnRayWithWhitelist(l__new__9(p68, v71 - p68), v85, true) or workspace:FindPartOnRayWithWhitelist(l__new__9(v71, p68 - v71), v85, true);
                            else
                                v87 = false;
                            end;
                            if v87 then
                                v73 = v75;
                                v75 = v72;
                            elseif v70 >= v72 then
                                v75 = v72;
                            end;
                        else
                            v73 = v75;
                            v75 = v72;
                        end;
                    else
                        v75 = v72;
                    end;
                    u49[#u49 + 1] = v81;
                    p65 = v82 - p66 * 0.001;
                else
                    v75 = v72;
                end;
            end;
            if v73 < (1 / 0) or not v81 then
                break;
            end;
            v72 = v75;
        end;
        local v88 = u49;
        for v89 = #v88, v69 + 1, -1 do
            v88[v89] = nil;
        end;
    end;
    debug.profileend();
    return v75 - u13, v73 - u13;
end;
local function u102(p91, p92) --[[ Line: 361 ]]
    -- upvalues: u5 (ref), u2 (copy), u4 (copy), u12 (ref), u11 (ref), u13 (ref), u90 (copy)
    debug.profilebegin("queryViewport");
    local l__p__20 = p91.p;
    local l__rightVector__21 = p91.rightVector;
    local l__upVector__22 = p91.upVector;
    local v93 = -p91.lookVector;
    local v94;
    if u2 then
        v94 = u4:getCamera();
    else
        v94 = u5;
    end;
    u5 = v94;
    local l__ViewportSize__23 = u5.ViewportSize;
    local v95 = (1 / 0);
    local v96 = (1 / 0);
    for v97 = 0, 1 do
        local v98 = l__rightVector__21 * ((v97 - 0.5) * u12);
        for v99 = 0, 1 do
            local v100, v101 = u90(l__p__20 + u13 * (v98 + l__upVector__22 * ((v99 - 0.5) * u11)), v93, p92, u5:ViewportPointToRay(l__ViewportSize__23.x * v97, l__ViewportSize__23.y * v99).Origin);
            if v101 >= v95 then
                v101 = v95;
            end;
            if v100 < v96 then
                v96 = v100;
                v95 = v101;
            else
                v95 = v101;
            end;
        end;
    end;
    debug.profileend();
    return v96, v95;
end;
local function u111(p103, p104, p105) --[[ Line: 404 ]]
    -- upvalues: u64 (copy), l__min__6 (copy), u90 (copy), u53 (copy)
    debug.profilebegin("testPromotion");
    local l__p__24 = p103.p;
    local l__rightVector__25 = p103.rightVector;
    local l__upVector__26 = p103.upVector;
    local v106 = -p103.lookVector;
    debug.profilebegin("extrapolate");
    local l__Magnitude__27 = (u64(l__p__24, p105.posVelocity * 1.25) - l__p__24).Magnitude;
    for v107 = 0, l__min__6(1.25, p105.rotVelocity.magnitude + l__Magnitude__27 / p105.posVelocity.magnitude), 0.0625 do
        local v108 = p105.extrapolate(v107);
        if p104 <= u90(v108.p, -v108.lookVector, p104) then
            return false;
        end;
    end;
    debug.profileend();
    debug.profilebegin("testOffsets");
    for _, v109 in ipairs(u53) do
        local v110 = u64(l__p__24, l__rightVector__25 * v109.x + l__upVector__26 * v109.y);
        if u90(v110, (l__p__24 + v106 * p104 - v110).Unit, p104) == (1 / 0) then
            return false;
        end;
    end;
    debug.profileend();
    debug.profileend();
    return true;
end;
return function(p112, p113, p114) --[[ Name: Popper, Line 453 ]]
    -- upvalues: u51 (ref), u52 (ref), u102 (copy), u111 (copy)
    debug.profilebegin("popper");
    u51 = u52 and u52:GetRootPart() or u52;
    local v115, v116 = u102(p112, p113);
    if v116 >= p113 then
        v116 = p113;
    end;
    if v115 < v116 then
        if not u111(p112, p113, p114) then
            v115 = v116;
        end;
    else
        v115 = v116;
    end;
    u51 = nil;
    debug.profileend();
    return v115;
end;