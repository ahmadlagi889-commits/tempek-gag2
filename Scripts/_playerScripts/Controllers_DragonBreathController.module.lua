-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("TweenService");
local v1 = {};
local u2 = {};
require(script.CCDIKController);
require(game.ReplicatedStorage.SharedModules.Networking);
require(game.ReplicatedStorage.ClientModules.RagdollModule);
local function u10(p3) --[[ Line: 75 ]]
    -- upvalues: l__Players__1 (copy)
    if p3.Parent:GetAttribute("Decaying") then
    else
        local v4 = game.ReplicatedStorage:FindFirstChild("Night");
        local v5;
        if v4 and v4:IsA("BoolValue") then
            v5 = v4.Value == true;
        else
            v5 = false;
        end;
        if v5 then
            local v6 = p3.Parent:GetAttribute("UserId");
            local v7 = nil;
            local v8 = nil;
            for _, v9 in l__Players__1:GetPlayers() do
                if v9.UserId ~= v6 and v9.Character then
                    local l__Magnitude__2 = ((v9.Character:GetPivot().Position - p3.BasePart.Position) * Vector3.new(1, 0, 1)).Magnitude;
                    if l__Magnitude__2 < 30 and (not v7 or l__Magnitude__2 < v7) then
                        v8 = v9.Character;
                        v7 = l__Magnitude__2;
                    end;
                end;
            end;
            if v8 then
                return v8.HumanoidRootPart;
            end;
        end;
    end;
end;
local u11 = tick();
local l__FlameEffect__3 = script.FlameEffect;
l__FlameEffect__3.Parent = game.Lighting;
l__FlameEffect__3.Enabled = false;
local u12 = nil;
local function u14() --[[ Line: 130 ]]
    -- upvalues: u11 (ref), u12 (ref), l__FlameEffect__3 (copy)
    if tick() - u11 < 1.5 then
    else
        u11 = tick();
        local v13 = game.ReplicatedStorage.Assets.Vignette:Clone();
        v13.ImageLabel.ImageColor3 = Color3.fromRGB(255, 35, 35);
        v13.Parent = game.Players.LocalPlayer.PlayerGui;
        v13.ImageLabel.ImageTransparency = 0.6;
        if u12 then
            u12:Cancel();
        end;
        l__FlameEffect__3.Brightness = 0.1;
        l__FlameEffect__3.Saturation = 0.1;
        l__FlameEffect__3.TintColor = Color3.fromRGB(255, 181, 97);
        u12 = game.TweenService:Create(l__FlameEffect__3, TweenInfo.new(0.5), {
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        l__FlameEffect__3.Enabled = true;
        u12:Play();
        game.TweenService:Create(v13.ImageLabel.UIScale, TweenInfo.new(0.5), {
            Scale = 1.06
        }):Play();
        game.TweenService:Create(v13.ImageLabel, TweenInfo.new(0.5), {
            ImageTransparency = 1
        }):Play();
        task.delay(0.5, function() --[[ Line: 158 ]]
            -- upvalues: l__FlameEffect__3 (ref)
            l__FlameEffect__3.Enabled = false;
        end);
        game.Debris:AddItem(v13, 0.5);
    end;
end;
local function u26(p15, p16) --[[ Line: 200 ]]
    local v17 = {
        10,
        15,
        20,
        25,
        30,
        30,
        15,
        10
    };
    local v18 = {};
    for v19, v20 in p15 do
        if p16[v19] then
            local v21 = v20.CFrame * CFrame.new(0, v20.Size.Y / 2, 0);
            local v22 = Instance.new("Attachment");
            v22.Name = v20.Name .. "AxisAttachment";
            v22.Parent = v20;
            v22.WorldCFrame = v21 * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966);
            local v23 = p15[v19 + 1];
            if v23 then
                local v24 = Instance.new("Attachment");
                v24.Name = v20.Name .. "JointAttachment";
                v24.Parent = v23;
                v24.WorldCFrame = v21 * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966);
                local v25 = Instance.new("BallSocketConstraint");
                v25.Name = v20.Name .. "BallSocket";
                v25.LimitsEnabled = true;
                v25.UpperAngle = v17[v19];
                v25.Attachment0 = v22;
                v25.Attachment1 = v24;
                v25.Parent = v20;
                table.insert(v18, v25);
            end;
        end;
    end;
    return v18;
end;
local function v43(p27) --[[ Line: 251 ]]
    -- upvalues: u26 (copy), u2 (copy)
    local v28 = {};
    if not p27.Parent:HasTag("InitializationComplete") then
        repeat
            task.wait();
        until p27.Parent:HasTag("InitializationComplete");
    end;
    for _, v29 in ipairs(p27.Spine:GetChildren()) do
        if v29:FindFirstChild("Motor6D") then
            table.insert(v28, v29);
        end;
    end;
    table.sort(v28, function(p30, p31) --[[ Line: 263 ]]
        return tonumber(p30.Name) < tonumber(p31.Name);
    end);
    local v32 = {};
    for _, v33 in v28 do
        local v34 = v33:FindFirstChild(v33.Name) or v33:FindFirstChildOfClass("Motor6D");
        table.insert(v32, v34);
    end;
    u26(v28, v32);
    local v35 = {};
    local v36 = {};
    for _, v37 in v32 do
        if v37 then
            v35[v37] = v37.C0;
            v36[v37] = v37.C1;
        end;
    end;
    for _, v38 in p27:GetDescendants() do
        if v38:IsA("BasePart") and (v38.Name ~= "BasePart" and (v38.Name ~= "HarvestPart" and v38.Parent ~= p27.Base)) then
            v38.Anchored = false;
        end;
    end;
    local l__AnimationController__4 = p27.AnimationController;
    local v39 = p27.BasePart:Clone();
    v39.Name = "RotationHandler";
    v39.Anchored = true;
    v39.Parent = p27;
    local l__Target1__5 = v39.Target1;
    local l__Target2__6 = v39.Target2;
    local l__Center__7 = l__AnimationController__4.Center;
    l__Center__7.Target = l__Target1__5;
    l__Center__7.Enabled = true;
    local l__Top__8 = l__AnimationController__4.Top;
    l__Top__8.Target = l__Target2__6;
    l__Top__8.Enabled = true;
    local v40 = Random.new():NextInteger(1, 9999);
    local v41 = p27.BasePart.CFrame:ToObjectSpace(l__Target1__5.WorldCFrame);
    local v42 = p27.BasePart.CFrame:ToObjectSpace(l__Target2__6.WorldCFrame);
    u2[p27] = {
        CurrentTarget = nil,
        TargetLocked = false,
        LookTarget = nil,
        Model = p27,
        Offsets = {
            CenterOffset = v41 * CFrame.new(0, 2, 0),
            TopOffset = v42
        },
        RandomOffset = v40,
        CenterOffset = v41,
        TopOffset = v42,
        Base = v39,
        OriginalCF = p27:GetPivot(),
        NextAttack = tick(),
        LastDecision = tick(),
        RestPoses = v35,
        Owner = game.Players:GetPlayerByUserId(p27.Parent:GetAttribute("UserId")),
        StartingPivot = v39.CFrame,
        Attachment1 = l__Target1__5,
        Attachment2 = l__Target2__6,
        DragonBreathEnd = game.ReplicatedStorage.Assets.DragonBreathEnd:Clone(),
        PrimaryPart = v39
    };
end;
game.CollectionService:GetInstanceAddedSignal("DragonBreath"):Connect(v43);
local function u47() --[[ Line: 170 ]]
    local v44, v45 = pcall(function() --[[ Line: 171 ]]
        return UserSettings().GameSettings;
    end);
    if not (v44 and v45) then
        return 30;
    end;
    local l__SavedQualityLevel__9 = v45.SavedQualityLevel;
    local v46 = nil;
    if typeof(l__SavedQualityLevel__9) == "EnumItem" then
        l__SavedQualityLevel__9 = l__SavedQualityLevel__9.Value;
    elseif type(l__SavedQualityLevel__9) ~= "number" then
        l__SavedQualityLevel__9 = v46;
    end;
    return type(l__SavedQualityLevel__9) == "number" and (l__SavedQualityLevel__9 == 0 and 30 or (l__SavedQualityLevel__9 >= 7 and 60 or (l__SavedQualityLevel__9 >= 4 and 25 or 30))) or 60;
end;
for _, v48 in game.CollectionService:GetTagged("DragonBreath") do
    v43(v48);
end;
task.spawn(function() --[[ Line: 379 ]]
    -- upvalues: u47 (copy), u2 (copy), u10 (copy), l__Players__1 (copy), u14 (copy)
    while true do
        local l__wait__10 = task.wait;
        local v49 = u47();
        local v50 = l__wait__10(v49 <= 0 and 0.02 or 1 / math.clamp(v49, 15, 60));
        for v51, v52 in u2 do
            if v51:IsDescendantOf(workspace) then
                if tick() - v52.LastDecision > 1 then
                    v52.LastDecision = tick();
                    v52.CurrentTarget = u10(v51);
                end;
                if v52.CurrentTarget then
                    v51.Head.Base.TopJaw.DesiredAngle = -0.2;
                    v51.Head.Base.BottomJaw.DesiredAngle = 0.5;
                    v52.DragonBreathEnd.Parent = workspace.Temporary;
                    if not v52.DragonBreathEnd:GetAttribute("Enabled") then
                        v52.DragonBreathEnd:SetAttribute("Enabled", true);
                        for _, v53 in v52.DragonBreathEnd:GetDescendants() do
                            if v53:IsA("ParticleEmitter") or v53:IsA("SurfaceGui") then
                                v53.Enabled = true;
                            end;
                        end;
                        for _, v54 in v51.Head.Base.Emitter:GetChildren() do
                            if v54:IsA("Beam") then
                                v54.Attachment1 = v52.DragonBreathEnd.Attachment;
                            end;
                        end;
                        for _, v55 in v51.Head.Base.Emitter:GetChildren() do
                            if v55:IsA("Beam") or v55:IsA("ParticleEmitter") then
                                v55.Enabled = true;
                            end;
                        end;
                    end;
                    v51.Head.Base.Emitter.WorldCFrame = CFrame.new(v51.Head.Base.Emitter.WorldPosition, v52.CurrentTarget.Position);
                    local v56 = v52.CurrentTarget.Position * Vector3.new(1, 0, 1) + Vector3.new(0, workspace.Baseplate.Center.Position.Y, 0);
                    if not v52.LastPosition then
                        v52.LastPosition = v56;
                    end;
                    v52.LastPosition = v52.LastPosition:Lerp(v56, v50 * 3);
                    local v57 = v52.LastPosition - v51.Head.Base.Emitter.WorldPosition;
                    local v58 = v52.Owner:GetAttribute("PlotId");
                    local v59;
                    if v58 then
                        v59 = workspace:WaitForChild("Gardens"):FindFirstChild("Plot" .. v58);
                    else
                        v59 = v51.Parent.Parent.Parent;
                    end;
                    local v60 = RaycastParams.new();
                    v60.FilterType = Enum.RaycastFilterType.Include;
                    v60.FilterDescendantsInstances = {
                        v59.Visual,
                        workspace.Baseplate,
                        v52.CurrentTarget.Parent,
                        game.Players.LocalPlayer.Character
                    };
                    local v61 = workspace:Raycast(v51.Head.Base.Emitter.WorldPosition, v57, v60);
                    if v61 and v61.Position then
                        v52.DragonBreathEnd.CFrame = CFrame.new(v61.Position + Vector3.new(0, 0.1, 0));
                        if v61.Instance:IsDescendantOf(game.Players.LocalPlayer.Character) or v61.Instance:IsDescendantOf(v52.CurrentTarget.Parent) then
                            v52.DragonBreathEnd.SurfaceGui.Enabled = false;
                        else
                            v52.DragonBreathEnd.SurfaceGui.Enabled = true;
                        end;
                    else
                        v52.DragonBreathEnd.CFrame = CFrame.new(v52.LastPosition + Vector3.new(0, 0.1, 0));
                        v52.DragonBreathEnd.SurfaceGui.Enabled = true;
                    end;
                    local v62 = OverlapParams.new();
                    v62.FilterDescendantsInstances = { game.Players.LocalPlayer.Character };
                    v62.FilterType = Enum.RaycastFilterType.Include;
                    if #workspace:GetPartBoundsInRadius(v52.DragonBreathEnd.Position, 2.2, v62) > 0 and v52.Owner ~= l__Players__1.LocalPlayer then
                        u14();
                    end;
                else
                    if v52.DragonBreathEnd:GetAttribute("Enabled") then
                        for _, v63 in v52.DragonBreathEnd:GetDescendants() do
                            if v63:IsA("ParticleEmitter") or v63:IsA("SurfaceGui") then
                                v63.Enabled = false;
                            end;
                        end;
                        for _, v64 in v51.Head.Base.Emitter:GetChildren() do
                            if v64:IsA("Beam") or v64:IsA("ParticleEmitter") then
                                v64.Enabled = false;
                            end;
                        end;
                        v52.DragonBreathEnd:SetAttribute("Enabled", false);
                    end;
                    v51.Head.Base.TopJaw.DesiredAngle = 0;
                    v51.Head.Base.BottomJaw.DesiredAngle = 0;
                end;
                v52.Attachment1.WorldCFrame = v52.Base.CFrame * v52.CenterOffset;
                v52.Attachment2.WorldCFrame = v52.Base.CFrame * v52.TopOffset;
            else
                u2[v51] = nil;
            end;
        end;
    end;
end);
return v1;