-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__SoundService__2 = game:GetService("SoundService");
local l__Bezier__3 = require(l__ReplicatedStorage__1.ClientModules.Bezier);
local l__Spring2__4 = require(l__ReplicatedStorage__1.ClientModules.Spring2);
local l__SeedData__5 = require(l__ReplicatedStorage__1.SharedModules.SeedData);
local l__Networking__6 = require(l__ReplicatedStorage__1.SharedModules.Networking);
local l__CamShake__7 = require(l__ReplicatedStorage__1.ClientModules.CamShake);
local l__RarityData__8 = l__ReplicatedStorage__1.SharedModules.RarityData;
local l__SeedPackEffects__9 = l__ReplicatedStorage__1.Assets.SeedPackEffects;
local u2 = {};
local u3 = l__SeedPackEffects__9.Luck:Clone();
local u4 = Instance.new("Attachment");
u3.Parent = u4;
u4.Parent = workspace.Terrain;
local u5 = RaycastParams.new();
u5.FilterDescendantsInstances = {};
u5.FilterType = Enum.RaycastFilterType.Include;
local function u8(p6) --[[ Line: 50 ]]
    -- upvalues: u5 (copy)
    local l__Position__10 = workspace.CurrentCamera.CFrame.Position;
    local v7 = game.Players.LocalPlayer:GetMouse().Hit.Position - l__Position__10;
    u5.FilterDescendantsInstances = { p6 };
    return workspace:Raycast(l__Position__10, v7, u5);
end;
function v1.Open(u9, p10, u11, p12, u13) --[[ Line: 65 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u2 (copy), l__Spring2__4 (copy), l__SeedPackEffects__9 (copy), l__SoundService__2 (copy), l__Networking__6 (copy), u8 (copy), u4 (copy), u3 (copy), l__Bezier__3 (copy), l__SeedData__5 (copy), l__CamShake__7 (copy), l__RarityData__8 (copy)
    local v14 = l__ReplicatedStorage__1.Assets.SeedPacks:FindFirstChild(p10);
    u2[u9] = u11;
    local v15 = v14 or l__ReplicatedStorage__1.Assets.SeedPacks.Normal;
    local v16 = CFrame.new(p12, p12 + u13.LookVector * Vector3.new(1, 0, 1));
    local u17 = l__Spring2__4.new(Vector3.new(0, 0, 0));
    u17.Speed = 11;
    u17.Damper = 0.85;
    local u18 = v15:Clone();
    u18:PivotTo(v16);
    local v19 = RaycastParams.new();
    v19.FilterType = Enum.RaycastFilterType.Exclude;
    v19.FilterDescendantsInstances = { workspace.Temporary };
    local v20 = workspace:Raycast(u13.Position, Vector3.new(-0, -7, -0), v19);
    if v20 and v20.Position then
        local v21 = Vector3.new(u13.X, v20.Position.Y + 2, u13.Z);
        u13 = CFrame.new(v21, v21 + u13.LookVector * Vector3.new(1, 0, 1));
    end;
    local u22;
    if l__SeedPackEffects__9:FindFirstChild(p10) then
        u22 = l__SeedPackEffects__9:FindFirstChild(p10):Clone();
    else
        u22 = l__SeedPackEffects__9.Attachment:Clone();
    end;
    u22.Parent = u18.PrimaryPart or u18.Handle;
    local v23 = u18:GetAttribute("Color");
    for _, v24 in u22:GetDescendants() do
        if v24:HasTag("ColorPart") then
            v24.Color = ColorSequence.new(v23);
        end;
    end;
    local v25 = u18.PrimaryPart or u18:FindFirstChild("Handle");
    local v26 = Instance.new("Sound");
    v26.SoundId = "rbxassetid://73484699086664";
    v26.Volume = 1;
    v26.RollOffMaxDistance = 200;
    v26.Looped = false;
    v26.SoundGroup = l__SoundService__2:FindFirstChild("SFXGroup");
    v26.Parent = v25;
    local v27 = Instance.new("Sound");
    v27.SoundId = "rbxassetid://121908287846654";
    v27.Volume = 1;
    v27.RollOffMaxDistance = 200;
    v27.Looped = false;
    v27.SoundGroup = l__SoundService__2:FindFirstChild("SFXGroup");
    v27.Parent = v25;
    local v28 = Instance.new("Sound");
    v28.SoundId = "rbxassetid://100648776972641";
    v28.Volume = 1;
    v28.RollOffMaxDistance = 200;
    v28.Looped = true;
    v28.SoundGroup = l__SoundService__2:FindFirstChild("SFXGroup");
    v28.Parent = v25;
    local v29 = Instance.new("Sound");
    v29.SoundId = "rbxassetid://100636385506315";
    v29.Volume = 1;
    v29.RollOffMaxDistance = 200;
    v29.Looped = false;
    v29.SoundGroup = l__SoundService__2:FindFirstChild("SFXGroup");
    v29.Parent = v25;
    local v30 = v29;
    local u31 = false;
    local u32 = Instance.new("Part");
    u32.CanCollide = false;
    u32.CanQuery = true;
    u32.CanTouch = false;
    u32.Anchored = true;
    local v33 = u18:GetExtentsSize() * 1.25;
    u32.Transparency = 1;
    u32.Size = v33;
    u32.CFrame = u13;
    u32.Parent = workspace.Temporary;
    game.Debris:AddItem(u32, 4.8);
    local u34 = script.ClickDetector:Clone();
    u34.Parent = u32;
    local u37 = u34.MouseClick:Connect(function() --[[ Line: 143 ]]
        -- upvalues: u31 (ref), l__Networking__6 (ref), u9 (copy), u8 (ref), u32 (copy), u4 (ref), u3 (ref)
        if not u31 then
            l__Networking__6.SeedPack.ClickPack:Fire(u9);
        end;
        u31 = true;
        task.delay(0.1, function() --[[ Line: 149 ]]
            -- upvalues: u31 (ref)
            u31 = false;
        end);
        local v35 = u8(u32);
        local v36 = v35 and v35.Position or game.Players.LocalPlayer:GetMouse().Hit.Position;
        if v35 then
            u4.WorldCFrame = CFrame.new(v36);
            u3:Emit(16);
        end;
    end);
    task.delay(3.8, function() --[[ Line: 164 ]]
        -- upvalues: u37 (ref), u34 (copy)
        u37:Disconnect();
        u34:Destroy();
    end);
    local v38 = l__Bezier__3.new(v16.Position, (v16.Position + u13.Position) / 2 + Vector3.new(0, 16, 0), u13.Position);
    for _, v39 in u18:GetDescendants() do
        if v39:IsA("BasePart") then
            v39.Anchored = true;
            v39.CanQuery = true;
        end;
    end;
    u18.Parent = workspace.Temporary;
    v26:Play();
    local v40 = 0;
    while v40 < 0.3 do
        v40 = v40 + game:GetService("RunService").Heartbeat:Wait();
        local v41 = v38:CalculatePositionAt((game:GetService("TweenService"):GetValue(v40 / 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)));
        u18:PivotTo(CFrame.new(v41, v41 + u13.LookVector));
    end;
    v27:Play();
    local v42 = 0;
    while v42 < 0.5 do
        v42 = v42 + game:GetService("RunService").Heartbeat:Wait();
        local v43 = 1 - v42 / 0.5;
        local v44 = math.rad(v43 * 1440) - 1.5707963267948966;
        local v45 = (math.sin(v44) + 1) / 2 * v43;
        u18:PivotTo(u13 * CFrame.new(0, v45 * 0.5, 0));
    end;
    v28:Play();
    local u46 = nil;
    local u47 = 0;
    local u48 = true;
    task.spawn(function() --[[ Line: 216 ]]
        -- upvalues: u22 (ref), u48 (ref), u47 (ref), u46 (ref), u18 (ref), u17 (copy), u13 (ref)
        u22.Trail.Trail.Enabled = false;
        local v49 = 0;
        while u48 do
            local v50 = game:GetService("RunService").Heartbeat:Wait();
            v49 = v49 + v50;
            local v51 = CFrame.Angles(0, 0, 0);
            if u47 > 0 then
                u47 = math.max(u47 - v50, 0);
                v51 = u46();
            end;
            local v52 = math.clamp(v49, 0, 1);
            local v53 = tick();
            local v54 = math.rad(v53 * 3);
            local v55 = math.cos(v54) * 0.3;
            local v56 = math.sin(v53 * 2.2) * 0.4;
            local v57 = math.rad(v53 * 1.6);
            local v58 = math.cos(v57) * 0.1;
            local v59 = Vector3.new(v55, v56, v58);
            u17.Target = u18:GetPivot():VectorToObjectSpace(v59);
            u17:Update(v50);
            local v60 = u18;
            local v61 = u13 * CFrame.new((Vector3.new(0, 0, 0)):Lerp(u17.Position, v52));
            local v62 = CFrame.new();
            local l__Angles__11 = CFrame.Angles;
            local v63 = tick() * 2;
            local v64 = math.cos(v63) * 0.06;
            local v65 = tick() * 1.5;
            local v66 = math.sin(v65) * 0.1;
            local v67 = tick() * 2;
            v60:PivotTo(v61 * v62:Lerp(l__Angles__11(v64, v66, math.sin(v67) * 0.1), v52) * v51);
        end;
    end);
    task.wait(0.4);
    u46 = function() --[[ Line: 256 ]]
        -- upvalues: u47 (ref)
        local v68 = 1 - u47 / 0.9;
        local v69 = tick() * 90;
        local v70 = v68 * math.sin(v69);
        return CFrame.Angles(0, 0, (math.rad(v70 * 2)));
    end;
    u47 = 0.9;
    task.wait(1.4);
    u46 = function() --[[ Line: 266 ]]
        -- upvalues: u47 (ref)
        local v71 = 1 - u47 / 0.9;
        local v72 = tick() * 90;
        local v73 = v71 * math.sin(v72);
        return CFrame.Angles(0, 0, (math.rad(v73 * 4)));
    end;
    u47 = 0.9;
    task.wait(1.4);
    u46 = function() --[[ Line: 280 ]]
        -- upvalues: u47 (ref)
        local v74 = 1 - u47 / 0.8;
        local v75 = tick() * 90;
        local v76 = v74 * math.sin(v75);
        return CFrame.Angles(0, 0, (math.rad(v76 * 6)));
    end;
    u47 = 0.8;
    task.wait(0.8);
    local u77 = u48;
    local u78 = u47;
    local u79 = nil;
    for _, v80 in pairs(l__SeedData__5) do
        if v80.SeedName == u11 then
            u79 = v80;
        end;
    end;
    if table.find({ "Legendary", "Mythic" }, u79.Rarity) then
        local v81 = Instance.new("Sound");
        v81.SoundId = "rbxassetid://82591599137987";
        v81.Volume = 1;
        v81.RollOffMaxDistance = 200;
        v81.Looped = false;
        v81.SoundGroup = l__SoundService__2:FindFirstChild("SFXGroup");
        v81.Parent = v25;
        v81:Play();
        task.wait(0.8);
        local u82 = l__SeedPackEffects__9.Highlight:Clone();
        u82.FillTransparency = 1;
        u82.OutlineTransparency = 1;
        u82.Parent = u18;
        u82.Enabled = true;
        local v83 = 1 - ((game.Workspace.CurrentCamera.CFrame.Position - u18:GetPivot().p).Magnitude + 20) / 90;
        l__CamShake__7:StartShake(2 * v83, 14 * v83, 12, Vector3.new(0.2, 0.2, 0));
        u46 = function() --[[ Line: 324 ]]
            -- upvalues: u78 (ref), u82 (copy), u18 (ref)
            local v84 = 1 - u78 / 3;
            u82.FillTransparency = 1 - v84;
            u82.OutlineTransparency = 1 - v84;
            u18:ScaleTo(v84 * 3 + 1);
            local v85 = Random.new():NextUnitVector() * v84;
            local v86 = u18:GetExtentsSize().Y / 2 * 0.1;
            local v87 = tick() * 90;
            local v88 = v84 * math.sin(v87);
            return CFrame.new(v85 * v86) * CFrame.new(0, u18:GetExtentsSize().Y / 2 * v84, 0) * CFrame.Angles(0, 0, (math.rad(v88 * 6)));
        end;
        u47 = 3;
        task.wait(3);
        for _, v89 in u22.BigEmit:GetChildren() do
            v89:Emit(v89:GetAttribute("EmitCount"));
        end;
        l__CamShake__7:StopSustained(0.5);
    else
        for _, v90 in u22.Emit:GetChildren() do
            v90:Emit(v90:GetAttribute("EmitCount"));
        end;
    end;
    v28:Stop();
    v30:Play();
    for _, v91 in u18:GetDescendants() do
        if v91:IsA("BasePart") or v91:IsA("Decal") then
            v91.Transparency = 1;
        elseif v91:IsA("SurfaceGui") then
            v91.Enabled = false;
        end;
    end;
    for _, v92 in u22.Aura:GetChildren() do
        v92.Enabled = false;
    end;
    task.spawn(function() --[[ Line: 377 ]]
        -- upvalues: u11 (ref), u2 (ref), u9 (copy), l__ReplicatedStorage__1 (ref), u77 (ref), u13 (ref), u79 (ref), l__RarityData__8 (ref), l__SeedPackEffects__9 (ref)
        u11 = u2[u9];
        u2[u9] = nil;
        local v93 = l__ReplicatedStorage__1.Assets.Seeds:FindFirstChild(u11);
        if v93 then
            u77 = false;
            local v94 = v93:Clone();
            local v95 = Instance.new("Model");
            v94.Parent = v95;
            v95.PrimaryPart = v94;
            local u96 = v95;
            u96:PivotTo(u13);
            u96.Parent = workspace.Temporary;
            local u97 = l__ReplicatedStorage__1.Assets.SeedNameAttachment:Clone();
            u97.Position = u13.Position + Vector3.new(0, 1.5, 0);
            u97.BillboardGui.Rarity_Name.UIScale.Scale = 0;
            u97.BillboardGui.Seed_Name.UIScale.Scale = 0;
            u97.Parent = workspace.Temporary;
            game.TweenService:Create(u97, TweenInfo.new(3), {
                Position = u13.Position + Vector3.new(0, 3, 0)
            }):Play();
            u97.BillboardGui.Seed_Name.TextLabel.Text = u11;
            u97.BillboardGui.Seed_Name.Text = u11;
            game.TweenService:Create(u97.BillboardGui.Seed_Name.UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                Scale = 1
            }):Play();
            task.delay(0.15, function() --[[ Line: 410 ]]
                -- upvalues: u97 (copy)
                game.TweenService:Create(u97.BillboardGui.Rarity_Name.UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                    Scale = 1
                }):Play();
            end);
            task.delay(3, function() --[[ Line: 416 ]]
                -- upvalues: u97 (copy), u96 (ref)
                game.TweenService:Create(u97.BillboardGui.Seed_Name.UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                    Scale = 0
                }):Play();
                task.delay(0.15, function() --[[ Line: 419 ]]
                    -- upvalues: u97 (ref), u96 (ref)
                    game.TweenService:Create(u97.BillboardGui.Rarity_Name.UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                        Scale = 0
                    }):Play();
                    game.Debris:AddItem(u97, 1);
                    task.wait(0.15);
                    local v98 = 0;
                    while v98 < 1 do
                        v98 = v98 + game:GetService("RunService").Heartbeat:Wait();
                        local v99 = 1 - game.TweenService:GetValue(v98, Enum.EasingStyle.Back, Enum.EasingDirection.InOut);
                        u96:ScaleTo((math.clamp(v99, 0.01, 1)));
                    end;
                    u96:Destroy();
                end);
            end);
            if u79 then
                local l__Rarity__12 = u79.Rarity;
                local v100 = l__RarityData__8.Gradients:FindFirstChild(l__Rarity__12);
                u97.BillboardGui.Rarity_Name.TextLabel.Text = l__Rarity__12;
                u97.BillboardGui.Rarity_Name.Text = l__Rarity__12;
                if v100 then
                    v100:Clone().Parent = u97.BillboardGui.Rarity_Name.TextLabel;
                    v100:Clone().Parent = u97.BillboardGui.Rarity_Name;
                end;
            end;
            local u101 = l__SeedPackEffects__9.Highlight:Clone();
            u101.Parent = u96;
            u101.Enabled = true;
            task.delay(0.2, function() --[[ Line: 457 ]]
                -- upvalues: u101 (copy)
                game.TweenService:Create(u101, TweenInfo.new(0.7), {
                    FillTransparency = 1
                }):Play();
                game.Debris:AddItem(u101, 0.3);
            end);
            local v102 = u96;
            local v103 = 0;
            local v104 = 0;
            while v103 < 5 do
                local v105 = game:GetService("RunService").Heartbeat:Wait();
                v103 = v103 + v105;
                v104 = v104 + 25.132741228718345 * math.clamp(1 - v103 / 1, 0.1, 1) * v105;
                local v106 = tick();
                local v107 = (math.sin(v106) + 1) * 0.5 / 2;
                v102:PivotTo(u13 * CFrame.Angles(0, v104, 0) * CFrame.new(0, v107, 0));
            end;
        end;
    end);
    game.Debris:AddItem(u18, 5);
end;
function v1.UpdateDropData(p108, p109) --[[ Line: 488 ]]
    -- upvalues: u2 (copy)
    if u2[p108] == nil then
    else
        u2[p108] = p109;
    end;
end;
return v1;