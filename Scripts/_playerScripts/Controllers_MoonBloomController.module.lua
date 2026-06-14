-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__Networking__5 = require(l__ReplicatedStorage__4.SharedModules.Networking);
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__Gravity__7 = game.SoundService.SFX.Gravity;
local u1 = {
    NewGravity = 20,
    Duration = 15,
    JumpHeightMult = 4,
    Applied = false,
    DefaultGravity = workspace.Gravity
};
local l__RadialFXController__8 = require(script.Parent.RadialFXController);
local l__FieldOfViewController__9 = require(script.Parent.FieldOfViewController);
local u2 = TweenInfo.new(7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u4 = {
    Connections = {}
};
local u5 = nil;
local u6 = 0;
function u4.RegisterPart(_, p7) --[[ Line: 56 ]]
    -- upvalues: u4 (copy), u1 (copy), l__LocalPlayer__6 (copy), l__Networking__5 (copy), l__RadialFXController__8 (copy), l__TweenService__3 (copy), u2 (copy), l__Gravity__7 (copy), u6 (ref), l__FieldOfViewController__9 (copy), u5 (ref), u3 (copy), l__CollectionService__2 (copy)
    if u4.Connections[p7] then
    else
        u4.Connections[p7] = p7.Touched:Connect(function(p8) --[[ Line: 60 ]]
            -- upvalues: u1 (ref), l__LocalPlayer__6 (ref), l__Networking__5 (ref), u4 (ref), l__RadialFXController__8 (ref), l__TweenService__3 (ref), u2 (ref), l__Gravity__7 (ref), u6 (ref), l__FieldOfViewController__9 (ref), u5 (ref), u3 (ref), l__CollectionService__2 (ref)
            if u1.Applied then
            else
                local l__Character__10 = l__LocalPlayer__6.Character;
                if l__Character__10 then
                    if p8:IsDescendantOf(l__Character__10) then
                        u1.Applied = true;
                        l__Networking__5.MoonBloom.GravityTouched:Fire();
                        for v9, v10 in u4.Connections do
                            v10:Disconnect();
                            u4.Connections[v9] = nil;
                        end;
                        if not l__LocalPlayer__6:GetAttribute("BaseJumpHeight") then
                            l__LocalPlayer__6:SetAttribute("BaseJumpHeight", l__Character__10.Humanoid.JumpHeight);
                        end;
                        local u11 = l__LocalPlayer__6:GetAttribute("BaseJumpHeight");
                        l__Character__10.Humanoid.JumpHeight = u11 * u1.JumpHeightMult;
                        workspace.Gravity = u1.NewGravity;
                        l__RadialFXController__8:PlayFX("MoonBloom");
                        local v12 = Instance.new("Highlight");
                        v12.Adornee = l__Character__10;
                        v12.Parent = l__LocalPlayer__6.PlayerGui;
                        v12.FillColor = Color3.new(0, 0.666667, 1);
                        v12.OutlineTransparency = 1;
                        v12.FillTransparency = 0.5;
                        l__TweenService__3:Create(v12, u2, {
                            FillTransparency = 1
                        }):Play();
                        game.Debris:AddItem(v12, u2.Time);
                        l__Gravity__7.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__Gravity__7.TimePosition = 0;
                        l__Gravity__7.Playing = true;
                        u6 = l__FieldOfViewController__9:GetAdjuster();
                        l__FieldOfViewController__9:SetAdjuster(u6 + 30, false);
                        if u5 then
                            task.cancel(u5);
                        end;
                        u5 = task.delay(1, function() --[[ Line: 105 ]]
                            -- upvalues: u5 (ref), l__FieldOfViewController__9 (ref), u6 (ref)
                            u5 = nil;
                            l__FieldOfViewController__9:SetAdjuster(u6, false);
                        end);
                        task.delay(u1.Duration, function() --[[ Line: 111 ]]
                            -- upvalues: u5 (ref), l__FieldOfViewController__9 (ref), u6 (ref), l__TweenService__3 (ref), u3 (ref), u1 (ref), l__Character__10 (copy), u11 (copy), l__CollectionService__2 (ref), u4 (ref)
                            if u5 then
                                task.cancel(u5);
                                u5 = nil;
                            end;
                            l__FieldOfViewController__9:SetAdjuster(u6, false);
                            local v13 = l__TweenService__3:Create(workspace, u3, {
                                Gravity = u1.DefaultGravity
                            });
                            v13:Play();
                            game.Debris:AddItem(v13, u3.Time);
                            local v14 = l__TweenService__3:Create(l__Character__10.Humanoid, u3, {
                                JumpHeight = u11
                            });
                            v14:Play();
                            game.Debris:AddItem(v14, u3.Time);
                            task.delay(u3.Time, function() --[[ Line: 126 ]]
                                -- upvalues: u1 (ref), l__CollectionService__2 (ref), u4 (ref)
                                u1.Applied = false;
                                for _, v15 in l__CollectionService__2:GetTagged("MoonBloom") do
                                    u4:RegisterPart(v15);
                                end;
                            end);
                        end);
                    end;
                end;
            end;
        end);
    end;
end;
function u4.UnregisterPart(_, p16) --[[ Line: 135 ]]
    -- upvalues: u4 (copy)
    if u4.Connections[p16] then
        u4.Connections[p16]:Disconnect();
        u4.Connections[p16] = nil;
    end;
end;
function u4.Start(u17) --[[ Line: 142 ]]
    -- upvalues: l__CollectionService__2 (copy), u1 (copy)
    for _, v18 in l__CollectionService__2:GetTagged("MoonBloom") do
        u17:RegisterPart(v18);
    end;
    l__CollectionService__2:GetInstanceAddedSignal("MoonBloom"):Connect(function(p19) --[[ Line: 148 ]]
        -- upvalues: u1 (ref), u17 (copy)
        if not u1.Applied then
            u17:RegisterPart(p19);
        end;
    end);
    l__CollectionService__2:GetInstanceRemovedSignal("MoonBloom"):Connect(function(p20) --[[ Line: 155 ]]
        -- upvalues: u17 (copy)
        u17:UnregisterPart(p20);
    end);
end;
return u4;