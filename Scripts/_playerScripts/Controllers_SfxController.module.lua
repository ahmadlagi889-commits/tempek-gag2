-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 6
};
local l__Players__1 = game:GetService("Players");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__SoundService__3 = game:GetService("SoundService");
l__Players__1.LocalPlayer:WaitForChild("PlayerGui");
local l__Click__4 = l__SoundService__3.SFX.Click;
local l__Networking__5 = require(game.ReplicatedStorage.SharedModules.Networking);
local u2 = {};
local function u6(p3) --[[ Line: 16 ]]
    -- upvalues: u2 (copy), l__SoundService__3 (copy)
    local v4 = u2[p3];
    if v4 and v4.Parent then
        return v4;
    end;
    for _, v5 in l__SoundService__3.SFX:GetDescendants() do
        if v5:IsA("Sound") and v5.Name == p3 then
            u2[p3] = v5;
            return v5;
        end;
    end;
    return nil;
end;
function v1.Init(_) --[[ Line: 29 ]]
    -- upvalues: l__Networking__5 (copy), u6 (copy), l__SoundService__3 (copy)
    l__Networking__5.SFX.PlaySound.OnClientEvent:Connect(function(p7) --[[ Line: 30 ]]
        -- upvalues: u6 (ref), l__SoundService__3 (ref)
        local v8 = u6(p7);
        if v8 then
            local u9 = v8:Clone();
            u9.Name = "TemporarySFX";
            u9.Parent = l__SoundService__3;
            u9.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            u9:Play();
            u9.Ended:Once(function() --[[ Line: 38 ]]
                -- upvalues: u9 (copy)
                u9:Destroy();
            end);
        end;
    end);
    l__Networking__5.SFX.PlaySoundVolume.OnClientEvent:Connect(function(p10, p11) --[[ Line: 43 ]]
        -- upvalues: u6 (ref), l__SoundService__3 (ref)
        local v12 = u6(p10);
        if v12 then
            local u13 = v12:Clone();
            u13.Name = "TemporarySFX";
            u13.Parent = l__SoundService__3;
            u13.Volume = p11;
            u13.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            u13:Play();
            u13.Ended:Once(function() --[[ Line: 52 ]]
                -- upvalues: u13 (copy)
                u13:Destroy();
            end);
        end;
    end);
    l__Networking__5.SFX.LocationSFX.OnClientEvent:Connect(function(p14, p15) --[[ Line: 57 ]]
        -- upvalues: u6 (ref)
        local v16 = u6(p15);
        if v16 then
            local u17 = Instance.new("Part");
            u17.Size = Vector3.new(1, 1, 1);
            u17.Anchored = true;
            u17.CanCollide = false;
            u17.CanQuery = false;
            u17.CanTouch = false;
            u17.Transparency = 1;
            u17.Position = p14;
            u17.Parent = workspace;
            local v18 = v16:Clone();
            v18.Name = "LocationSFX";
            v18.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            v18.RollOffMode = Enum.RollOffMode.InverseTapered;
            v18.RollOffMinDistance = 10;
            v18.RollOffMaxDistance = 80;
            v18.Parent = u17;
            v18:Play();
            v18.Ended:Once(function() --[[ Line: 80 ]]
                -- upvalues: u17 (copy)
                u17:Destroy();
            end);
        end;
    end);
end;
function v1.SetupButton(u19, p20) --[[ Line: 86 ]]
    -- upvalues: l__CollectionService__2 (copy)
    if p20:IsA("TextButton") or p20:IsA("ImageButton") then
        if l__CollectionService__2:HasTag(p20, "ClickSFX") then
            p20.MouseButton1Click:Connect(function() --[[ Line: 90 ]]
                -- upvalues: u19 (copy)
                u19:PlayClickSound();
            end);
        end;
    end;
end;
function v1.PlayClickSound(_) --[[ Line: 95 ]]
    -- upvalues: l__Click__4 (copy)
    l__Click__4.TimePosition = 0;
    l__Click__4.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l__Click__4:Play();
end;
function v1.PlaySFX(_, p21) --[[ Line: 101 ]]
    -- upvalues: u6 (copy)
    local v22 = u6(p21);
    if v22 then
        v22.TimePosition = 0;
        v22.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        v22:Play();
    end;
end;
return v1;