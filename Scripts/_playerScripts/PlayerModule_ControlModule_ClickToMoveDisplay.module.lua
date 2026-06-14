-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = "rbxasset://textures/ui/traildot.png";
local u3 = "rbxasset://textures/ui/waypoint.png";
local u4 = false;
local u5 = UDim2.new(0, 42, 0, 50);
local u6 = Vector2.new(0, 0.5);
local u7 = Vector2.new(0, 1);
local u8 = Vector2.new(0, 0.5);
local u9 = Vector2.new(0.1, 0.5);
local u10 = Vector2.new(-0.1, 0.5);
local u11 = Vector2.new(1.5, 1.5);
local u12 = RaycastParams.new();
u12.FilterType = Enum.RaycastFilterType.Exclude;
local l__Players__1 = game:GetService("Players");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Workspace__4 = game:GetService("Workspace");
local l__CommonUtils__5 = script.Parent.Parent:WaitForChild("CommonUtils");
local u13 = require(l__CommonUtils__5:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2");
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local function u25() --[[ Line: 55 ]]
    -- upvalues: u11 (ref), u4 (ref), u2 (ref), u5 (copy), u6 (copy), u3 (ref), u8 (copy)
    local v14 = Instance.new("Part");
    v14.Size = Vector3.new(1, 1, 1);
    v14.Anchored = true;
    v14.CanCollide = false;
    v14.Name = "TrailDot";
    v14.Transparency = 1;
    local v15 = Instance.new("ImageHandleAdornment");
    v15.Name = "TrailDotImage";
    v15.Size = u11;
    v15.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    v15.AlwaysOnTop = u4;
    v15.Image = u2;
    v15.Adornee = v14;
    v15.Parent = v14;
    local v16 = Instance.new("Part");
    v16.Size = Vector3.new(2, 2, 2);
    v16.Anchored = true;
    v16.CanCollide = false;
    v16.Name = "EndWaypoint";
    v16.Transparency = 1;
    local v17 = Instance.new("ImageHandleAdornment");
    v17.Name = "TrailDotImage";
    v17.Size = u11;
    v17.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    v17.AlwaysOnTop = u4;
    v17.Image = u2;
    v17.Adornee = v16;
    v17.Parent = v16;
    local v18 = Instance.new("BillboardGui");
    v18.Name = "EndWaypointBillboard";
    v18.Size = u5;
    v18.LightInfluence = 0;
    v18.SizeOffset = u6;
    v18.AlwaysOnTop = true;
    v18.Adornee = v16;
    v18.Parent = v16;
    local v19 = Instance.new("ImageLabel");
    v19.Image = u3;
    v19.BackgroundTransparency = 1;
    v19.Size = UDim2.new(1, 0, 1, 0);
    v19.Parent = v18;
    local v20 = Instance.new("Part");
    v20.Size = Vector3.new(2, 2, 2);
    v20.Anchored = true;
    v20.CanCollide = false;
    v20.Name = "FailureWaypoint";
    v20.Transparency = 1;
    local v21 = Instance.new("ImageHandleAdornment");
    v21.Name = "TrailDotImage";
    v21.Size = u11;
    v21.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    v21.AlwaysOnTop = u4;
    v21.Image = u2;
    v21.Adornee = v20;
    v21.Parent = v20;
    local v22 = Instance.new("BillboardGui");
    v22.Name = "FailureWaypointBillboard";
    v22.Size = u5;
    v22.LightInfluence = 0;
    v22.SizeOffset = u8;
    v22.AlwaysOnTop = true;
    v22.Adornee = v20;
    v22.Parent = v20;
    local v23 = Instance.new("Frame");
    v23.BackgroundTransparency = 1;
    v23.Size = UDim2.new(0, 0, 0, 0);
    v23.Position = UDim2.new(0.5, 0, 1, 0);
    v23.Parent = v22;
    local v24 = Instance.new("ImageLabel");
    v24.Image = u3;
    v24.BackgroundTransparency = 1;
    v24.Position = UDim2.new(0, -u5.X.Offset / 2, 0, -u5.Y.Offset);
    v24.Size = u5;
    v24.Parent = v23;
    return v14, v16, v20;
end;
local u26, u27, u28 = u25();
local function u37(p29, p30) --[[ Line: 152 ]]
    -- upvalues: u13 (copy), u12 (copy), l__Workspace__4 (copy), l__LocalPlayer__6 (copy)
    if u13 then
        u12.FilterDescendantsInstances = { l__Workspace__4.CurrentCamera, l__LocalPlayer__6.Character };
        local v31 = l__Workspace__4:Raycast(p30 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), u12);
        if v31 then
            p29.CFrame = CFrame.lookAlong(v31.Position, v31.Normal);
            local l__CurrentCamera__7 = l__Workspace__4.CurrentCamera;
            local v32 = l__CurrentCamera__7:FindFirstChild("ClickToMoveDisplay");
            if not v32 then
                v32 = Instance.new("Model");
                v32.Name = "ClickToMoveDisplay";
                v32.Parent = l__CurrentCamera__7;
            end;
            p29.Parent = v32;
        end;
    else
        local v33, v34, v35 = l__Workspace__4:FindPartOnRayWithIgnoreList(Ray.new(p30 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { l__Workspace__4.CurrentCamera, l__LocalPlayer__6.Character });
        if v33 then
            p29.CFrame = CFrame.new(v34, v34 + v35);
            local l__CurrentCamera__8 = l__Workspace__4.CurrentCamera;
            local v36 = l__CurrentCamera__8:FindFirstChild("ClickToMoveDisplay");
            if not v36 then
                v36 = Instance.new("Model");
                v36.Name = "ClickToMoveDisplay";
                v36.Parent = l__CurrentCamera__8;
            end;
            p29.Parent = v36;
        end;
    end;
end;
local u38 = {};
u38.__index = u38;
function u38.Destroy(p39) --[[ Line: 177 ]]
    p39.DisplayModel:Destroy();
end;
function u38.NewDisplayModel(_, p40) --[[ Line: 181 ]]
    -- upvalues: u26 (ref), u37 (copy)
    local v41 = u26:Clone();
    u37(v41, p40);
    return v41;
end;
function u38.new(p42, p43) --[[ Line: 187 ]]
    -- upvalues: u38 (copy)
    local v44 = setmetatable({}, u38);
    v44.DisplayModel = v44:NewDisplayModel(p42);
    v44.ClosestWayPoint = p43;
    return v44;
end;
local u45 = {};
u45.__index = u45;
function u45.Destroy(p46) --[[ Line: 199 ]]
    p46.Destroyed = true;
    p46.Tween:Cancel();
    p46.DisplayModel:Destroy();
end;
function u45.NewDisplayModel(_, p47) --[[ Line: 205 ]]
    -- upvalues: u27 (ref), u37 (copy)
    local v48 = u27:Clone();
    u37(v48, p47);
    return v48;
end;
function u45.CreateTween(p49) --[[ Line: 211 ]]
    -- upvalues: l__TweenService__2 (copy), u7 (copy)
    local v50 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true);
    local v51 = l__TweenService__2:Create(p49.DisplayModel.EndWaypointBillboard, v50, {
        SizeOffset = u7
    });
    v51:Play();
    return v51;
end;
function u45.TweenInFrom(p52, p53) --[[ Line: 222 ]]
    -- upvalues: l__TweenService__2 (copy)
    p52.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, (p53 - p52.DisplayModel.Position).Y, 0);
    local v54 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v55 = l__TweenService__2:Create(p52.DisplayModel.EndWaypointBillboard, v54, {
        StudsOffset = Vector3.new(0, 0, 0)
    });
    v55:Play();
    return v55;
end;
function u45.new(p56, p57, p58) --[[ Line: 236 ]]
    -- upvalues: u45 (copy)
    local u59 = setmetatable({}, u45);
    u59.DisplayModel = u59:NewDisplayModel(p56);
    u59.Destroyed = false;
    if p58 and (p58 - p56).Magnitude > 5 then
        u59.Tween = u59:TweenInFrom(p58);
        coroutine.wrap(function() --[[ Line: 243 ]]
            -- upvalues: u59 (copy)
            u59.Tween.Completed:Wait();
            if not u59.Destroyed then
                u59.Tween = u59:CreateTween();
            end;
        end)();
    else
        u59.Tween = u59:CreateTween();
    end;
    u59.ClosestWayPoint = p57;
    return u59;
end;
local u60 = {};
u60.__index = u60;
function u60.Hide(p61) --[[ Line: 260 ]]
    p61.DisplayModel.Parent = nil;
end;
function u60.Destroy(p62) --[[ Line: 264 ]]
    p62.DisplayModel:Destroy();
end;
function u60.NewDisplayModel(_, p63) --[[ Line: 268 ]]
    -- upvalues: u28 (ref), u37 (copy), u13 (copy), u12 (copy), l__Workspace__4 (copy), l__LocalPlayer__6 (copy)
    local v64 = u28:Clone();
    u37(v64, p63);
    if u13 then
        u12.FilterDescendantsInstances = { l__Workspace__4.CurrentCamera, l__LocalPlayer__6.Character };
        local v65 = l__Workspace__4:Raycast(p63 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), u12);
        if v65 then
            v64.CFrame = CFrame.lookAlong(v65.Position, v65.Normal);
            local l__CurrentCamera__9 = l__Workspace__4.CurrentCamera;
            local v66 = l__CurrentCamera__9:FindFirstChild("ClickToMoveDisplay");
            if not v66 then
                v66 = Instance.new("Model");
                v66.Name = "ClickToMoveDisplay";
                v66.Parent = l__CurrentCamera__9;
            end;
            v64.Parent = v66;
            return v64;
        end;
    else
        local v67, v68, v69 = l__Workspace__4:FindPartOnRayWithIgnoreList(Ray.new(p63 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { l__Workspace__4.CurrentCamera, l__LocalPlayer__6.Character });
        if v67 then
            v64.CFrame = CFrame.new(v68, v68 + v69);
            local l__CurrentCamera__10 = l__Workspace__4.CurrentCamera;
            local v70 = l__CurrentCamera__10:FindFirstChild("ClickToMoveDisplay");
            if not v70 then
                v70 = Instance.new("Model");
                v70.Name = "ClickToMoveDisplay";
                v70.Parent = l__CurrentCamera__10;
            end;
            v64.Parent = v70;
        end;
    end;
    return v64;
end;
function u60.RunFailureTween(p71) --[[ Line: 292 ]]
    -- upvalues: l__TweenService__2 (copy), u9 (copy), u10 (copy), u8 (copy)
    wait(0.125);
    local v72 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v73 = l__TweenService__2:Create(p71.DisplayModel.FailureWaypointBillboard, v72, {
        SizeOffset = u9
    });
    v73:Play();
    l__TweenService__2:Create(p71.DisplayModel.FailureWaypointBillboard.Frame, v72, {
        Rotation = 10
    }):Play();
    v73.Completed:wait();
    local v74 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true);
    local v75 = l__TweenService__2:Create(p71.DisplayModel.FailureWaypointBillboard, v74, {
        SizeOffset = u10
    });
    v75:Play();
    local v76 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true);
    l__TweenService__2:Create(p71.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, v76, {
        ImageColor3 = Color3.new(0.75, 0.75, 0.75)
    }):Play();
    l__TweenService__2:Create(p71.DisplayModel.FailureWaypointBillboard.Frame, v76, {
        Rotation = -10
    }):Play();
    v75.Completed:wait();
    local v77 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v78 = l__TweenService__2:Create(p71.DisplayModel.FailureWaypointBillboard, v77, {
        SizeOffset = u8
    });
    v78:Play();
    l__TweenService__2:Create(p71.DisplayModel.FailureWaypointBillboard.Frame, v77, {
        Rotation = 0
    }):Play();
    v78.Completed:wait();
    wait(0.125);
end;
function u60.new(p79) --[[ Line: 341 ]]
    -- upvalues: u60 (copy)
    local v80 = setmetatable({}, u60);
    v80.DisplayModel = v80:NewDisplayModel(p79);
    return v80;
end;
local u81 = Instance.new("Animation");
u81.AnimationId = "rbxassetid://2874840706";
local u82 = nil;
local function u94(p83, p84) --[[ Line: 373 ]]
    -- upvalues: u38 (copy), u45 (copy)
    local v85 = {};
    local v86 = 1;
    for v87 = 1, #p83 - 1 do
        local v88 = (p83[v87].Position - p83[#p83].Position).Magnitude < 3;
        local v89;
        if v87 % 2 == 0 then
            v89 = not v88;
        else
            v89 = false;
        end;
        if v89 then
            v85[v86] = u38.new(p83[v87].Position, v87);
            v86 = v86 + 1;
        end;
    end;
    local v90 = u45.new(p83[#p83].Position, #p83, p84);
    table.insert(v85, v90);
    local v91 = {};
    local v92 = 1;
    for v93 = #v85, 1, -1 do
        v91[v92] = v85[v93];
        v92 = v92 + 1;
    end;
    return v91;
end;
local u95 = 0;
function v1.CreatePathDisplay(u96, p97) --[[ Line: 407 ]]
    -- upvalues: u95 (ref), u94 (copy), l__RunService__3 (copy), l__Workspace__4 (copy), u11 (ref)
    u95 = u95 + 1;
    local u98 = u94(u96, p97);
    local function u102(p99) --[[ Line: 411 ]]
        -- upvalues: u98 (copy)
        for v100 = #u98, 1, -1 do
            local v101 = u98[v100];
            if v101.ClosestWayPoint > p99 then
                break;
            end;
            v101:Destroy();
            u98[v100] = nil;
        end;
    end;
    local u103 = "ClickToMoveResizeTrail" .. u95;
    l__RunService__3:BindToRenderStep(u103, Enum.RenderPriority.Camera.Value - 1, function() --[[ Name: resizeTrailDots, Line 425 ]]
        -- upvalues: u98 (copy), l__RunService__3 (ref), u103 (copy), l__Workspace__4 (ref), u11 (ref)
        if #u98 == 0 then
            l__RunService__3:UnbindFromRenderStep(u103);
        else
            local l__p__11 = l__Workspace__4.CurrentCamera.CFrame.p;
            for v104 = 1, #u98 do
                local v105 = u98[v104].DisplayModel:FindFirstChild("TrailDotImage");
                if v105 then
                    v105.Size = u11 * (math.clamp((u98[v104].DisplayModel.Position - l__p__11).Magnitude - 10, 0, 90) / 90 * 1.5 + 1);
                end;
            end;
        end;
    end);
    return function() --[[ Name: removePath, Line 441 ]]
        -- upvalues: u102 (copy), u96 (copy)
        u102(#u96);
    end, u102;
end;
local u106 = nil;
function v1.DisplayFailureWaypoint(p107) --[[ Line: 449 ]]
    -- upvalues: u106 (ref), u60 (copy)
    if u106 then
        u106:Hide();
    end;
    local u108 = u60.new(p107);
    u106 = u108;
    coroutine.wrap(function() --[[ Line: 455 ]]
        -- upvalues: u108 (ref)
        u108:RunFailureTween();
        u108:Destroy();
        u108 = nil;
    end)();
end;
function v1.CreateEndWaypoint(p109) --[[ Line: 462 ]]
    -- upvalues: u45 (copy)
    return u45.new(p109);
end;
function v1.PlayFailureAnimation() --[[ Line: 466 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u82 (ref), u81 (copy)
    local l__Character__12 = l__LocalPlayer__6.Character;
    local v110;
    if l__Character__12 then
        v110 = l__Character__12:FindFirstChildOfClass("Humanoid");
    else
        v110 = nil;
    end;
    if v110 then
        local v111;
        if v110 == nil then
            v111 = u82;
        else
            u82 = v110:LoadAnimation(u81);
            assert(u82, "");
            u82.Priority = Enum.AnimationPriority.Action;
            u82.Looped = false;
            v111 = u82;
        end;
        v111:Play();
    end;
end;
function v1.CancelFailureAnimation() --[[ Line: 474 ]]
    -- upvalues: u82 (ref)
    if u82 ~= nil and u82.IsPlaying then
        u82:Stop();
    end;
end;
function v1.SetWaypointTexture(p112) --[[ Line: 480 ]]
    -- upvalues: u2 (ref), u26 (ref), u27 (ref), u28 (ref), u25 (copy)
    u2 = p112;
    local v113, v114, v115 = u25();
    u26 = v113;
    u27 = v114;
    u28 = v115;
end;
function v1.GetWaypointTexture() --[[ Line: 485 ]]
    -- upvalues: u2 (ref)
    return u2;
end;
function v1.SetWaypointRadius(p116) --[[ Line: 489 ]]
    -- upvalues: u11 (ref), u26 (ref), u27 (ref), u28 (ref), u25 (copy)
    u11 = Vector2.new(p116, p116);
    local v117, v118, v119 = u25();
    u26 = v117;
    u27 = v118;
    u28 = v119;
end;
function v1.GetWaypointRadius() --[[ Line: 494 ]]
    -- upvalues: u11 (ref)
    return u11.X;
end;
function v1.SetEndWaypointTexture(p120) --[[ Line: 498 ]]
    -- upvalues: u3 (ref), u26 (ref), u27 (ref), u28 (ref), u25 (copy)
    u3 = p120;
    local v121, v122, v123 = u25();
    u26 = v121;
    u27 = v122;
    u28 = v123;
end;
function v1.GetEndWaypointTexture() --[[ Line: 503 ]]
    -- upvalues: u3 (ref)
    return u3;
end;
function v1.SetWaypointsAlwaysOnTop(p124) --[[ Line: 507 ]]
    -- upvalues: u4 (ref), u26 (ref), u27 (ref), u28 (ref), u25 (copy)
    u4 = p124;
    local v125, v126, v127 = u25();
    u26 = v125;
    u27 = v126;
    u28 = v127;
end;
function v1.GetWaypointsAlwaysOnTop() --[[ Line: 512 ]]
    -- upvalues: u4 (ref)
    return u4;
end;
return v1;