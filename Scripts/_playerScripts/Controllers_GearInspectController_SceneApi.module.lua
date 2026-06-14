-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local l__TweenService__1 = game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Players__4 = game:GetService("Players");
local u2 = {
    List = nil,
    Fetched = false
};
local function u11(p3) --[[ Line: 18 ]]
    -- upvalues: u2 (copy), l__Players__4 (copy)
    if u2.Fetched then
        return u2.List;
    end;
    u2.Fetched = true;
    local l__LocalPlayer__5 = l__Players__4.LocalPlayer;
    if not l__LocalPlayer__5 then
        u2.List = {};
        return u2.List;
    end;
    local v4, u5 = pcall(function() --[[ Line: 29 ]]
        -- upvalues: l__Players__4 (ref), l__LocalPlayer__5 (copy)
        return l__Players__4:GetFriendsAsync(l__LocalPlayer__5.UserId);
    end);
    if not (v4 and u5) then
        u2.List = {};
        return u2.List;
    end;
    local v6 = 0;
    local v7 = {};
    while v6 < p3 do
        local v8, v9 = pcall(function() --[[ Line: 41 ]]
            -- upvalues: u5 (copy)
            return u5:GetCurrentPage();
        end);
        if not (v8 and v9) then
            break;
        end;
        for _, v10 in v9 do
            table.insert(v7, v10);
            v6 = v6 + 1;
            if p3 <= v6 then
                break;
            end;
        end;
        if u5.IsFinished or not pcall(function() --[[ Line: 51 ]]
            -- upvalues: u5 (copy)
            u5:AdvanceToNextPageAsync();
        end) then
            break;
        end;
    end;
    u2.List = v7;
    return v7;
end;
function u1.new(p12) --[[ Line: 60 ]]
    -- upvalues: u1 (copy)
    local u13 = setmetatable({}, u1);
    u13.Plot = p12.Plot;
    u13.PlayerModel = p12.PlayerModel;
    u13.PlayerHumanoid = p12.PlayerHumanoid;
    u13.Camera = p12.Camera;
    u13.Trove = p12.Trove;
    u13.GearData = p12.GearData;
    u13.Options = p12.Options;
    u13.ActiveTracks = {};
    u13.ActiveCameraTween = nil;
    u13.Trove:Add(function() --[[ Line: 73 ]]
        -- upvalues: u13 (copy)
        for _, v14 in u13.ActiveTracks do
            if v14 then
                v14:Stop(0);
            end;
        end;
        u13.ActiveTracks = {};
        if u13.ActiveCameraTween then
            u13.ActiveCameraTween:Cancel();
            u13.ActiveCameraTween = nil;
        end;
    end);
    return u13;
end;
function u1.SpawnDummy(p15, p16, p17) --[[ Line: 88 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy)
    if typeof(p16) == "string" then
        local v18 = l__ReplicatedStorage__3:FindFirstChild("SceneAssets");
        if v18 then
            v18 = v18:FindFirstChild("Dummies");
        end;
        if v18 then
            p16 = v18:FindFirstChild(p16);
        end;
    end;
    if not p16 then
        return nil;
    end;
    local v19 = p16:Clone();
    v19.Parent = p15.Plot;
    if p17 then
        local v20 = typeof(p17) == "CFrame" and p17 and p17 or CFrame.new(p17);
        if v19.PrimaryPart then
            v19:PivotTo(v20);
        end;
    end;
    p15.Trove:Add(v19);
    return v19;
end;
function u1.PlayAnimation(p21, p22, p23, p24) --[[ Line: 114 ]]
    local v25 = p23 or p21.PlayerHumanoid;
    if not v25 then
        return nil;
    end;
    local v26, v27;
    if typeof(p22) == "Instance" then
        v26 = p22;
        v27 = false;
    else
        v26 = Instance.new("Animation");
        v27 = true;
        if typeof(p22) == "number" then
            v26.AnimationId = `rbxassetid://{p22}`;
        else
            v26.AnimationId = tostring(p22);
        end;
    end;
    local u28 = v25:LoadAnimation(v26);
    if v27 then
        v26:Destroy();
    end;
    u28:Play(p24 or 0.1);
    table.insert(p21.ActiveTracks, u28);
    p21.Trove:Add(function() --[[ Line: 141 ]]
        -- upvalues: u28 (copy)
        if u28 then
            u28:Stop(0);
        end;
    end);
    return u28;
end;
function u1.SpawnProp(p29, p30, p31) --[[ Line: 149 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy)
    if typeof(p30) == "string" then
        local v32 = l__ReplicatedStorage__3:FindFirstChild("SceneAssets");
        if v32 then
            v32 = v32:FindFirstChild("Props");
        end;
        if v32 then
            p30 = v32:FindFirstChild(p30);
        end;
    end;
    if not p30 then
        return nil;
    end;
    local v33 = p30:Clone();
    v33.Parent = p29.Plot;
    if p31 then
        local v34 = typeof(p31) == "CFrame" and p31 and p31 or CFrame.new(p31);
        if v33:IsA("Model") then
            if v33.PrimaryPart then
                v33:PivotTo(v34);
            end;
        elseif v33:IsA("BasePart") then
            v33.CFrame = v34;
        end;
    end;
    p29.Trove:Add(v33);
    return v33;
end;
function u1.SetCamera(p35, p36, p37) --[[ Line: 179 ]]
    p35.Camera.CameraType = Enum.CameraType.Scriptable;
    p35.Camera.CFrame = p36;
    if p37 then
        p35.Camera.FieldOfView = p37;
    end;
end;
function u1.CameraShot(p38, p39, p40) --[[ Line: 189 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v41 = p40 or {};
    p38.Camera.CameraType = Enum.CameraType.Scriptable;
    if p38.ActiveCameraTween then
        p38.ActiveCameraTween:Cancel();
        p38.ActiveCameraTween = nil;
    end;
    local v42 = TweenInfo.new(v41.Duration or 1, v41.EasingStyle or Enum.EasingStyle.Quad, v41.EasingDirection or Enum.EasingDirection.InOut);
    local v43 = {
        CFrame = p39
    };
    if v41.FieldOfView then
        v43.FieldOfView = v41.FieldOfView;
    end;
    local v44 = l__TweenService__1:Create(p38.Camera, v42, v43);
    p38.ActiveCameraTween = v44;
    v44:Play();
    return v44;
end;
function u1.OrbitCamera(u45, u46, p47) --[[ Line: 216 ]]
    -- upvalues: l__RunService__2 (copy)
    local v48 = p47 or {};
    local u49 = v48.Radius or 8;
    local u50 = v48.Height or 4;
    local u51 = v48.Speed or 0.4;
    local l__FieldOfView__6 = v48.FieldOfView;
    u45.Camera.CameraType = Enum.CameraType.Scriptable;
    if l__FieldOfView__6 then
        u45.Camera.FieldOfView = l__FieldOfView__6;
    end;
    local u52 = 0;
    local v59 = l__RunService__2.RenderStepped:Connect(function(p53) --[[ Line: 229 ]]
        -- upvalues: u52 (ref), u51 (copy), u46 (copy), u49 (copy), u50 (copy), u45 (copy)
        u52 = u52 + p53 * u51;
        local v54 = u46;
        local v55 = math.cos(u52) * u49;
        local v56 = u50;
        local v57 = math.sin(u52) * u49;
        local v58 = v54 + Vector3.new(v55, v56, v57);
        u45.Camera.CFrame = CFrame.lookAt(v58, u46);
    end);
    u45.Trove:Add(v59);
    return v59;
end;
function u1.Wait(_, p60) --[[ Line: 239 ]]
    task.wait(p60);
end;
function u1.GetGearModel(p61) --[[ Line: 244 ]]
    local l__GearData__7 = p61.GearData;
    if l__GearData__7 then
        l__GearData__7 = p61.GearData.Model or p61.GearData.Tool;
    end;
    return l__GearData__7;
end;
function u1.ApplyRandomFriendAppearance(_, p62, p63) --[[ Line: 249 ]]
    -- upvalues: u11 (copy), l__Players__4 (copy)
    if p62 then
        local u64 = p62:FindFirstChildOfClass("Humanoid");
        if u64 then
            local v65 = u11(p63 or 50);
            if v65 and #v65 ~= 0 then
                local u66 = v65[math.random(1, #v65)];
                if u66 and u66.Id then
                    local v67, u68 = pcall(function() --[[ Line: 260 ]]
                        -- upvalues: l__Players__4 (ref), u66 (copy)
                        return l__Players__4:GetHumanoidDescriptionFromUserIdAsync(u66.Id);
                    end);
                    if v67 and u68 then
                        return pcall(function() --[[ Line: 265 ]]
                            -- upvalues: u64 (copy), u68 (copy)
                            u64:ApplyDescriptionResetAsync(u68);
                        end);
                    else
                        return false;
                    end;
                else
                    return false;
                end;
            else
                return false;
            end;
        else
            return false;
        end;
    else
        return false;
    end;
end;
return u1;