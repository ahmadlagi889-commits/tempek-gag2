-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = nil;
local function u12(p4, p5) --[[ Line: 25 ]]
    local v6 = p4.CFrame:PointToObjectSpace(p5);
    local v7 = p4.Size * 0.5;
    local v8 = math.clamp(v6.X, -v7.X, v7.X);
    local v9 = math.clamp(v6.Y, -v7.Y, v7.Y);
    local v10 = math.clamp(v6.Z, -v7.Z, v7.Z);
    local v11 = Vector3.new(v8, v9, v10);
    return p4.CFrame:PointToWorldSpace(v11);
end;
local function u21(p13, p14, p15) --[[ Line: 38 ]]
    -- upvalues: u12 (copy)
    local v16 = (1 / 0);
    local v17 = nil;
    for _, v18 in p13 do
        if v18.Parent then
            local v19 = u12(v18, p14);
            local l__Magnitude__4 = (p14 - v19).Magnitude;
            if l__Magnitude__4 < v16 then
                v17 = v19;
                v16 = l__Magnitude__4;
            end;
        end;
    end;
    if not v17 then
        return nil;
    end;
    local v20 = p14 - v17;
    return v17 + (v20.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or v20.Unit) * p15;
end;
local function u26(p22, p23) --[[ Line: 66 ]]
    local v24 = {};
    for _, v25 in p22:GetDescendants() do
        if v25:IsA("BasePart") and v25 ~= p23 then
            table.insert(v24, v25);
        end;
    end;
    return v24;
end;
local function u32(p27, p28) --[[ Line: 76 ]]
    local v29 = p27:FindFirstChild(p28);
    if v29 and v29:IsA("BasePart") then
        return v29;
    end;
    local v30 = p27.PrimaryPart or p27:FindFirstChildWhichIsA("BasePart");
    if not v30 then
        return nil;
    end;
    local v31 = Instance.new("Part");
    v31.Name = p28;
    v31.Size = Vector3.new(1, 1, 1);
    v31.Transparency = 1;
    v31.Anchored = true;
    v31.CanCollide = false;
    v31.CanTouch = false;
    v31.CanQuery = false;
    v31.CFrame = v30.CFrame;
    v31.Parent = p27;
    return v31;
end;
function v1.AttachToModel(u33, u34, p35) --[[ Line: 153 ]]
    -- upvalues: u32 (copy), u26 (copy), u2 (copy), u3 (ref), l__RunService__2 (copy), l__LocalPlayer__3 (copy), u21 (copy)
    local v36 = p35 or {};
    if not (u33 and u34) then
        return function() --[[ Line: 156 ]] end;
    end;
    local v37 = v36.PartName or "SmartPromptPart";
    local v38 = tonumber(v36.SurfaceOffset) or 0.75;
    local v39 = tonumber(v36.FollowSpeed) or 18;
    local v40 = tonumber(v36.TrackDistance) or 24;
    local v41 = tonumber(v36.MaxActivationDistance);
    local u42 = u32(u34, v37);
    if not u42 then
        return function() --[[ Line: 167 ]] end;
    end;
    if v41 then
        u33.MaxActivationDistance = v41;
    end;
    u33.RequiresLineOfSight = false;
    u33.Parent = u42;
    local u43 = {
        model = u34,
        part = u42,
        surfaceOffset = v38,
        followSpeed = v39,
        trackDistance = math.max(v40, u33.MaxActivationDistance + 8),
        parts = u26(u34, u42)
    };
    local function v45(p44) --[[ Line: 189 ]]
        -- upvalues: u43 (copy), u26 (ref), u34 (copy), u42 (copy)
        if p44 and not p44:IsA("BasePart") then
        else
            u43.parts = u26(u34, u42);
        end;
    end;
    u43.partsConn = u34.DescendantAdded:Connect(v45);
    u43.partsRemovedConn = u34.DescendantRemoving:Connect(v45);
    u2[u33] = u43;
    if not u3 then
        u3 = l__RunService__2.Heartbeat:Connect(function(p46) --[[ Line: 106 ]]
            -- upvalues: u2 (ref), u3 (ref), l__LocalPlayer__3 (ref), u21 (ref)
            if next(u2) == nil then
                if u3 then
                    u3:Disconnect();
                    u3 = nil;
                end;
            else
                local l__Character__5 = l__LocalPlayer__3.Character;
                local v47;
                if l__Character__5 then
                    local v48 = l__Character__5:FindFirstChild("HumanoidRootPart");
                    if v48 then
                        v47 = v48.Position;
                    else
                        v47 = nil;
                    end;
                else
                    v47 = nil;
                end;
                if v47 then
                    for v49, v50 in u2 do
                        if v49.Parent then
                            local l__model__6 = v50.model;
                            local l__part__7 = v50.part;
                            if l__model__6 and (l__model__6.Parent and (l__part__7 and l__part__7.Parent)) then
                                if v50.trackDistance >= (l__model__6:GetPivot().Position - v47).Magnitude then
                                    local v51 = u21(v50.parts, v47, v50.surfaceOffset);
                                    if v51 then
                                        local v52 = math.clamp(p46 * v50.followSpeed, 0, 1);
                                        l__part__7.CFrame = CFrame.new(l__part__7.Position:Lerp(v51, v52));
                                    end;
                                end;
                            else
                                if v50.partsConn then
                                    v50.partsConn:Disconnect();
                                end;
                                if v50.partsRemovedConn then
                                    v50.partsRemovedConn:Disconnect();
                                end;
                                u2[v49] = nil;
                            end;
                        else
                            if v50.partsConn then
                                v50.partsConn:Disconnect();
                            end;
                            if v50.partsRemovedConn then
                                v50.partsRemovedConn:Disconnect();
                            end;
                            u2[v49] = nil;
                        end;
                    end;
                end;
            end;
        end);
    end;
    local function v54() --[[ Line: 201 ]]
        -- upvalues: u2 (ref), u33 (copy)
        local v53 = u2[u33];
        if v53 then
            if v53.partsConn then
                v53.partsConn:Disconnect();
            end;
            if v53.partsRemovedConn then
                v53.partsRemovedConn:Disconnect();
            end;
        end;
        u2[u33] = nil;
    end;
    u33.Destroying:Once(v54);
    u34.Destroying:Once(v54);
    return v54;
end;
return v1;