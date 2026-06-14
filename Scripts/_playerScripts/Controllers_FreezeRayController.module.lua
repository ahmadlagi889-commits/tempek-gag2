-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__FreezeRay__4 = game.SoundService.SFX.FreezeRay;
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
function v1.Init(_) --[[ Line: 11 ]] end;
function v1.Start(u2) --[[ Line: 14 ]]
    -- upvalues: l__LocalPlayer__5 (copy), l__Networking__3 (copy)
    local l__Character__6 = l__LocalPlayer__5.Character;
    if l__Character__6 then
        u2:SetupCharacter(l__Character__6);
    end;
    l__LocalPlayer__5.CharacterAdded:Connect(function(p3) --[[ Line: 20 ]]
        -- upvalues: u2 (copy)
        u2:SetupCharacter(p3);
    end);
    l__Networking__3.FreezeRay.FreezeFx.OnClientEvent:Connect(function(p4, p5) --[[ Line: 24 ]]
        -- upvalues: u2 (copy)
        u2:PlayFreezeFx(p4, p5);
    end);
end;
function v1.SetupCharacter(u6, p7) --[[ Line: 29 ]]
    p7.ChildAdded:Connect(function(u8) --[[ Name: tryConnect, Line 30 ]]
        -- upvalues: u6 (copy)
        if u8:IsA("Tool") and u8:GetAttribute("FreezeRay") then
            u8.Activated:Connect(function() --[[ Line: 32 ]]
                -- upvalues: u6 (ref), u8 (copy)
                u6:OnToolActivated(u8);
            end);
        end;
    end);
    for _, u9 in p7:GetChildren() do
        if u9:IsA("Tool") and u9:GetAttribute("FreezeRay") then
            u9.Activated:Connect(function() --[[ Line: 32 ]]
                -- upvalues: u6 (copy), u9 (copy)
                u6:OnToolActivated(u9);
            end);
        end;
    end;
end;
local u10 = Instance.new("Animation");
u10.AnimationId = "rbxassetid://117986819831165";
function v1.OnToolActivated(p11, p12) --[[ Line: 50 ]]
    -- upvalues: l__LocalPlayer__5 (copy), l__FreezeRay__4 (copy), l__Networking__3 (copy), u10 (copy)
    local l__Character__7 = l__LocalPlayer__5.Character;
    if l__Character__7 then
        if p12.Parent == l__Character__7 then
            local v13 = p12:GetAttribute("CooldownEnd");
            if v13 and os.clock() < v13 then
            else
                local v14 = l__LocalPlayer__5:GetMouse();
                if v14 then
                    local v15 = p11:GetFilteredMouseTarget(v14, l__Character__7);
                    if v15 then
                        l__FreezeRay__4.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__FreezeRay__4.Playing = true;
                        l__FreezeRay__4.TimePosition = 0;
                        l__Networking__3.FreezeRay.Fire:Fire(v15, p12);
                        local v16 = l__Character__7.Humanoid.Animator:LoadAnimation(u10);
                        v16:Play();
                        game.Debris:AddItem(v16, 1);
                        local v17 = p12:GetAttribute("Cooldown") or 10;
                        p12:SetAttribute("CooldownEnd", os.clock() + v17);
                    end;
                end;
            end;
        end;
    end;
end;
function v1.GetFilteredMouseTarget(_, p18, p19) --[[ Line: 83 ]]
    local v20 = workspace.CurrentCamera:ScreenPointToRay(p18.X, p18.Y);
    local v21 = RaycastParams.new();
    v21.FilterType = Enum.RaycastFilterType.Exclude;
    v21.FilterDescendantsInstances = { p19 };
    local l__Origin__8 = v20.Origin;
    local v22 = v20.Direction * 1000;
    for _ = 1, 10 do
        local v23 = workspace:Raycast(l__Origin__8, v22, v21);
        if not v23 then
            return l__Origin__8 + v22;
        end;
        if v23.Instance.Transparency < 1 then
            return v23.Position;
        end;
        local l__FilterDescendantsInstances__9 = v21.FilterDescendantsInstances;
        table.insert(l__FilterDescendantsInstances__9, v23.Instance);
        v21.FilterDescendantsInstances = l__FilterDescendantsInstances__9;
        local v24 = v22.Magnitude - (v23.Position - l__Origin__8).Magnitude;
        l__Origin__8 = v23.Position + v20.Direction * 0.01;
        v22 = v20.Direction * v24;
    end;
    return l__Origin__8 + v22;
end;
function v1.PlayFreezeFx(_, _, _) --[[ Line: 117 ]] end;
local function v28(u25) --[[ Line: 122 ]]
    local v26 = script.Highlight:Clone();
    v26.Parent = u25;
    v26.Enabled = true;
    v26.Adornee = u25;
    game.TweenService:Create(v26, TweenInfo.new(0.1), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    game.Debris:AddItem(v26, 0.1);
    task.delay(0.1, function() --[[ Line: 133 ]]
        -- upvalues: u25 (copy)
        game.TweenService:Create(u25, TweenInfo.new(0.1), {
            Transparency = 0.4
        }):Play();
    end);
    for _, u27 in u25:GetChildren() do
        if u27:IsA("ParticleEmitter") then
            u27:Emit(u27:GetAttribute("EmitCount") or 0);
        elseif u27:IsA("PointLight") then
            game.TweenService:Create(u27, TweenInfo.new(0.1), {
                Brightness = 6
            }):Play();
            task.delay(0.3, function() --[[ Line: 143 ]]
                -- upvalues: u27 (copy)
                game.TweenService:Create(u27, TweenInfo.new(0.1), {
                    Brightness = 1
                }):Play();
            end);
        end;
    end;
end;
for _, v29 in game.CollectionService:GetTagged("Ice_Block") do
    v28(v29);
end;
game:GetService("CollectionService"):GetInstanceAddedSignal("Ice_Block"):Connect(v28);
return v1;