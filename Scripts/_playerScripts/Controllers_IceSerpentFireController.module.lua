-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Debris__3 = game:GetService("Debris");
local l__Networking__4 = require(l__ReplicatedStorage__1.SharedModules.Networking);
local v1 = {};
local u2 = {};
local function u6(p3) --[[ Line: 30 ]]
    local v4 = workspace:FindFirstChild("_PetVisualClient");
    if v4 then
        v4 = v4:FindFirstChild("Models");
    end;
    if not v4 then
        return nil;
    end;
    local l__Parent__5 = p3.Parent;
    if l__Parent__5 then
        l__Parent__5 = p3.Parent.Name;
    end;
    for _, v5 in pairs(v4:GetChildren()) do
        if v5:IsA("Model") and (v5:GetAttribute("OwnerSlot") == p3.Name and (not l__Parent__5 or v5:GetAttribute("Owner") == l__Parent__5)) then
            return v5;
        end;
    end;
    return nil;
end;
local function u10(p7) --[[ Line: 46 ]]
    for _, v8 in pairs({ "Mouth", "FireOrigin", "Head" }) do
        local v9 = p7:FindFirstChild(v8, true);
        if v9 and v9:IsA("BasePart") then
            return v9;
        end;
    end;
    return p7.PrimaryPart;
end;
local function u14() --[[ Line: 54 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    local v11 = l__ReplicatedStorage__1:FindFirstChild("Assets");
    if v11 then
        v11 = v11:FindFirstChild("VFX");
    end;
    if v11 then
        local v12 = v11:FindFirstChild("OtherStorage");
        if v12 then
            v12 = v12:FindFirstChild("IceFireEmitter");
        end;
        if v12 and v12:IsA("Attachment") then
            return v12;
        else
            local v13 = v11:FindFirstChild("StatusVFX");
            if v13 then
                v13 = v13:FindFirstChild("BurningVFX");
            end;
            if v13 then
                v13 = v13:FindFirstChild("fire");
            end;
            if v13 and v13:IsA("ParticleEmitter") then
                return v13;
            else
                return nil;
            end;
        end;
    else
        return nil;
    end;
end;
local function u19(p15, p16) --[[ Line: 90 ]]
    local v17 = {};
    for _, v18 in pairs(p15.Keypoints) do
        table.insert(v17, NumberSequenceKeypoint.new(v18.Time, v18.Value * p16, v18.Envelope * p16));
    end;
    return NumberSequence.new(v17);
end;
local function u24(p20, p21) --[[ Line: 100 ]]
    -- upvalues: u19 (copy)
    if p21 == 1 then
    else
        local v22 = p20:GetDescendants();
        table.insert(v22, p20);
        for _, v23 in pairs(v22) do
            if v23:IsA("Beam") then
                v23.Width0 = v23.Width0 * p21;
                v23.Width1 = v23.Width1 * p21;
            elseif v23:IsA("ParticleEmitter") then
                v23.Size = u19(v23.Size, p21);
            end;
        end;
    end;
end;
local function u32(p25, p26) --[[ Line: 115 ]]
    local u27 = p25:FindFirstChildOfClass("AnimationController");
    if u27 then
        u27 = u27:FindFirstChildOfClass("Animator");
    end;
    if u27 then
        local v28 = p25:FindFirstChild("Animations");
        local u29 = v28 and v28:FindFirstChild("Breathe") or p25:FindFirstChild("Breathe");
        if u29 and u29:IsA("Animation") then
            local v30, u31 = pcall(function() --[[ Line: 125 ]]
                -- upvalues: u27 (copy), u29 (copy)
                return u27:LoadAnimation(u29);
            end);
            if v30 and u31 then
                u31.Looped = true;
                u31.Priority = Enum.AnimationPriority.Action;
                u31:Play(0.15);
                task.delay(p26, function() --[[ Line: 132 ]]
                    -- upvalues: u31 (copy)
                    if u31 and u31.IsPlaying then
                        u31:Stop(0.2);
                    end;
                end);
            end;
        end;
    end;
end;
local function u60(u33, u34, u35, p36) --[[ Line: 138 ]]
    -- upvalues: u10 (copy), u14 (copy), u24 (copy), u2 (copy), u32 (copy), l__RunService__2 (copy), l__Debris__3 (copy)
    local u37 = u10(u34);
    if u37 then
        local v38, v39 = pcall(function() --[[ Line: 83 ]]
            -- upvalues: u34 (copy)
            return u34:GetScale();
        end);
        local u40 = (not v38 or (type(v39) ~= "number" or v39 <= 0)) and 1 or v39;
        local u41 = Instance.new("Part");
        u41.Name = "IceSerpentFireBeam";
        u41.Anchored = true;
        u41.CanCollide = false;
        u41.CanQuery = false;
        u41.CanTouch = false;
        u41.Massless = true;
        u41.Transparency = 1;
        u41.Size = Vector3.new(u40 * 0.2, u40 * 0.2, 1);
        u41.Parent = workspace;
        local u42 = nil;
        local u43 = nil;
        local v44 = u14();
        if v44 then
            local v45 = v44:Clone();
            v45.Parent = u41;
            u24(v45, u40);
            if v45:IsA("Attachment") then
                v45.Position = Vector3.new(0, 0, -0.5);
                local v46 = Instance.new("Attachment");
                v46.Parent = u41;
                u43 = v46;
                u42 = v45;
                for _, v47 in pairs(v45:GetDescendants()) do
                    if v47:IsA("Beam") then
                        v47.Attachment0 = v45;
                        v47.Attachment1 = v46;
                        v47.Enabled = true;
                    end;
                end;
            end;
        end;
        local u48 = {};
        local v49 = u2[u33];
        if v49 and v49.Beam then
            v49.Token = u48;
            if v49.Beam.Parent then
                v49.Beam:Destroy();
            end;
        end;
        u2[u33] = {
            Token = u48,
            Beam = u41
        };
        u32(u34, p36);
        local u50 = os.clock() + p36;
        local u51 = nil;
        u51 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 197 ]]
            -- upvalues: u2 (ref), u33 (copy), u48 (copy), u50 (copy), u41 (copy), u37 (copy), u51 (ref), u35 (copy), u40 (copy), u42 (ref), u43 (ref)
            local v52 = u2[u33];
            if v52 and (v52.Token == u48 and (u50 > os.clock() and (u41.Parent and u37.Parent))) then
                local l__Position__6 = u37.Position;
                local v53 = u35;
                local v54;
                if v53 then
                    v54 = v53:FindFirstChild("HumanoidRootPart");
                    if not (v54 and v54:IsA("BasePart")) then
                        v54 = nil;
                    end;
                else
                    v54 = nil;
                end;
                local v55;
                if v54 then
                    v55 = v54.Position;
                else
                    v55 = l__Position__6 + u37.CFrame.LookVector * 10;
                end;
                local v56 = math.min((v55 - l__Position__6).Magnitude, 60);
                local v57 = v56 < 0.1 and 0.1 or v56;
                u41.Size = Vector3.new(u40 * 0.2, u40 * 0.2, v57);
                u41.CFrame = CFrame.lookAt(l__Position__6, v55) * CFrame.new(0, 0, -v57 * 0.5);
                if u42 then
                    u42.WorldCFrame = CFrame.lookAt(l__Position__6, v55);
                end;
                if u43 then
                    u43.WorldPosition = v55;
                end;
            else
                if u51 then
                    u51:Disconnect();
                end;
            end;
        end);
        task.delay(p36, function() --[[ Line: 219 ]]
            -- upvalues: u51 (ref), u2 (ref), u33 (copy), u48 (copy), u41 (copy), l__Debris__3 (ref)
            if u51 then
                u51:Disconnect();
            end;
            local v58 = u2[u33];
            if v58 and v58.Token ~= u48 then
            else
                u2[u33] = nil;
                for _, v59 in pairs(u41:GetDescendants()) do
                    if v59:IsA("ParticleEmitter") then
                        v59.Enabled = false;
                    elseif v59:IsA("Beam") then
                        v59.Enabled = false;
                    end;
                end;
                l__Debris__3:AddItem(u41, 2);
            end;
        end);
    end;
end;
function v1.Init(_) --[[ Line: 239 ]] end;
function v1.Start(_) --[[ Line: 241 ]]
    -- upvalues: l__Networking__4 (copy), u6 (copy), u60 (copy)
    l__Networking__4.IceSerpent.BreathStart.OnClientEvent:Connect(function(p61, p62, p63) --[[ Line: 242 ]]
        -- upvalues: u6 (ref), u60 (ref)
        if typeof(p61) == "Instance" then
            if type(p63) == "number" and p63 > 0 then
                local v64 = u6(p61);
                if v64 then
                    u60(p61, v64, p62, p63);
                end;
            end;
        end;
    end);
end;
return v1;