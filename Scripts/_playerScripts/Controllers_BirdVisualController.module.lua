-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 4
};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__SoundService__3 = game:GetService("SoundService");
local l__Networking__4 = require(l__ReplicatedStorage__1.SharedModules.Networking);
local l__Assets__5 = l__ReplicatedStorage__1:WaitForChild("Assets");
local l__Robin__6 = l__Assets__5:WaitForChild("Pets"):WaitForChild("Robin");
local l__PopVFX__7 = l__Assets__5:WaitForChild("PopVFX");
local l__Birds__8 = workspace:WaitForChild("Birds");
local u2 = Instance.new("Folder");
u2.Name = "BirdVisuals";
u2.Parent = workspace;
local u3 = {};
local u4 = {};
l__Networking__4.Bird.Positions.OnClientEvent:Connect(function(p5) --[[ Line: 36 ]]
    -- upvalues: u4 (copy)
    if typeof(p5) == "table" then
        for _, v6 in p5 do
            local v7 = v6[1];
            local v8 = v6[2];
            if typeof(v7) == "Instance" and (v7:IsA("BasePart") and typeof(v8) == "Vector3") then
                u4[v7] = v8;
            end;
        end;
    end;
end);
l__Networking__4.Bird.FruitEaten.OnClientEvent:Connect(function(p9) --[[ Line: 47 ]]
    -- upvalues: l__PopVFX__7 (copy), u2 (copy)
    if typeof(p9) == "Vector3" then
        local v10 = l__PopVFX__7:Clone();
        if v10:IsA("BasePart") then
            v10.CFrame = CFrame.new(p9);
            v10.Parent = u2;
            game.Debris:AddItem(v10, 3);
        elseif v10:IsA("Model") then
            v10:PivotTo(CFrame.new(p9));
            v10.Parent = u2;
            game.Debris:AddItem(v10, 3);
            for _, v11 in v10:GetDescendants() do
                if v11:IsA("ParticleEmitter") then
                    v11:Emit(v11:GetAttribute("EmitCount") or 50);
                end;
            end;
        else
            local v12 = Instance.new("Model");
            v10.Parent = v12;
            v12.Parent = u2;
            v12:PivotTo(CFrame.new(p9));
            game.Debris:AddItem(v12, 3);
        end;
    end;
end);
local function u19(p13) --[[ Line: 72 ]]
    -- upvalues: u3 (copy), l__Robin__6 (copy), u4 (copy), u2 (copy), l__SoundService__3 (copy)
    if u3[p13] then
    else
        local v14 = l__Robin__6:Clone();
        v14.Name = "BirdVisual_" .. p13.Name;
        local l__PrimaryPart__9 = v14.PrimaryPart;
        if l__PrimaryPart__9 then
            l__PrimaryPart__9.Anchored = true;
        end;
        for _, v15 in v14:GetDescendants() do
            if v15:IsA("BasePart") then
                v15.CanCollide = false;
                v15.CanQuery = false;
                v15.CanTouch = false;
                if v15 ~= l__PrimaryPart__9 then
                    v15.Anchored = false;
                end;
            end;
        end;
        local v16 = u4[p13] or p13.Position;
        local v17 = CFrame.new(v16);
        if l__PrimaryPart__9 then
            v14:PivotTo(v17);
        end;
        v14.Parent = u2;
        local v18;
        if l__PrimaryPart__9 then
            v18 = Instance.new("Sound");
            v18.SoundId = "rbxassetid://100707184833885";
            v18.Volume = 0.2;
            v18.PlaybackSpeed = 1;
            v18.RollOffMaxDistance = 400;
            v18.RollOffMode = Enum.RollOffMode.InverseTapered;
            v18.Looped = true;
            v18.SoundGroup = l__SoundService__3:FindFirstChild("SFXGroup");
            v18.Parent = l__PrimaryPart__9;
            v18:Play();
        else
            v18 = nil;
        end;
        u3[p13] = {
            Part = p13,
            Model = v14,
            CurrentCF = v17,
            LastTargetPos = v16,
            Sound = v18
        };
    end;
end;
function v1.Init(_) --[[ Line: 133 ]] end;
function v1.Start(_) --[[ Line: 136 ]]
    -- upvalues: l__Birds__8 (copy), u19 (copy), u3 (copy), u4 (copy), l__RunService__2 (copy)
    for _, v20 in l__Birds__8:GetChildren() do
        if v20:IsA("BasePart") then
            u19(v20);
        end;
    end;
    l__Birds__8.ChildAdded:Connect(function(p21) --[[ Line: 143 ]]
        -- upvalues: u19 (ref)
        if p21:IsA("BasePart") then
            u19(p21);
        end;
    end);
    l__Birds__8.ChildRemoved:Connect(function(p22) --[[ Line: 149 ]]
        -- upvalues: u3 (ref), u4 (ref)
        if p22:IsA("BasePart") then
            local v23 = u3[p22];
            if not v23 then
                return;
            end;
            if v23.Sound then
                v23.Sound:Stop();
            end;
            if v23.Model then
                v23.Model:Destroy();
            end;
            u4[p22] = nil;
            u3[p22] = nil;
        end;
    end);
    l__RunService__2.RenderStepped:Connect(function(p24) --[[ Line: 155 ]]
        -- upvalues: u3 (ref), u4 (ref)
        debug.profilebegin("Controllers/BirdVisualController/RenderStepped");
        local v25 = math.min(1, 14 * p24);
        for v26, v27 in u3 do
            if v26 and v26.Parent then
                local l__Model__10 = v27.Model;
                if l__Model__10 and l__Model__10.PrimaryPart then
                    local v28 = u4[v26] or v26.Position;
                    local v29 = v27.CurrentCF.Position:Lerp(v28, v25);
                    local v30 = v28.X - v27.LastTargetPos.X;
                    local v31 = v28.Z - v27.LastTargetPos.Z;
                    local v32;
                    if v30 * v30 + v31 * v31 > 0.0001 then
                        local v33 = v29 + Vector3.new(v30, (v28.Y - v27.LastTargetPos.Y) * 0.5, v31);
                        v32 = CFrame.lookAt(v29, v33);
                    else
                        local _, v34, _ = v27.CurrentCF:ToEulerAnglesYXZ();
                        v32 = CFrame.new(v29) * CFrame.Angles(0, v34, 0);
                    end;
                    v27.CurrentCF = v32;
                    l__Model__10.PrimaryPart.CFrame = v32;
                    v27.LastTargetPos = v28;
                end;
            else
                local v35 = u3[v26];
                if v35 then
                    if v35.Sound then
                        v35.Sound:Stop();
                    end;
                    if v35.Model then
                        v35.Model:Destroy();
                    end;
                    u4[v26] = nil;
                    u3[v26] = nil;
                end;
            end;
        end;
        debug.profileend();
    end);
end;
return v1;