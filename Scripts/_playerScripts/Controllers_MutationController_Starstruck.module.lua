-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__MaterialService__3 = game:GetService("MaterialService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__EffectLoadManager__5 = require(l__ReplicatedStorage__4.SharedModules.EffectLoadManager);
local l__VFX__6 = script.VFX;
local l__EmissiveStrength__7 = l__MaterialService__3.StarInlet.EmissiveStrength;
local u2 = {};
local u3 = 0;
local u4 = nil;
local u5 = 0;
local u6 = 0;
function v1.ApplyMutationEffect(p7) --[[ Line: 94 ]]
    -- upvalues: u2 (copy), l__CollectionService__2 (copy), l__VFX__6 (copy), l__EffectLoadManager__5 (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), l__RunService__1 (copy), l__EmissiveStrength__7 (copy), l__MaterialService__3 (copy)
    if u2[p7] then
    else
        local v8 = {
            vfx = {},
            parts = {}
        };
        u2[p7] = v8;
        l__CollectionService__2:AddTag(p7, "Starstruck");
        if p7:IsA("BasePart") then
            table.insert(v8.parts, p7);
        end;
        for _, v9 in p7:GetDescendants() do
            if v9:IsA("BasePart") then
                table.insert(v8.parts, v9);
            end;
        end;
        local v10;
        if p7:IsA("Model") then
            v10 = p7.PrimaryPart or v8.parts[1];
        else
            v10 = v8.parts[1];
        end;
        if v10 then
            for _, v11 in l__VFX__6:GetChildren() do
                local v12 = v11:Clone();
                v12.Parent = v10;
                table.insert(v8.vfx, v12);
            end;
        end;
        for _, v13 in v8.parts do
            v13.MaterialVariant = "StarInlet";
        end;
        l__EffectLoadManager__5.Register();
        u3 = u3 + 1;
        if u3 == 1 then
            if u4 then
                return;
            end;
            u5 = 0;
            u6 = 0;
            u4 = l__RunService__1.RenderStepped:Connect(function(p14) --[[ Line: 67 ]]
                -- upvalues: u6 (ref), l__EffectLoadManager__5 (ref), u5 (ref), l__EmissiveStrength__7 (ref), l__MaterialService__3 (ref)
                u6 = u6 + p14;
                if u6 < l__EffectLoadManager__5.GetTickInterval() then
                    return;
                end;
                debug.profilebegin("Mutations/Starstruck/Pulse");
                u5 = (u5 + u6) % 4;
                local v15 = l__EmissiveStrength__7;
                if u5 <= 3 then
                    l__MaterialService__3.StarInlet.EmissiveStrength = v15;
                    u6 = 0;
                    debug.profileend();
                    return;
                end;
                local v16 = (u5 - 3) / 0.5;
                local v17;
                if v16 <= 1 then
                    if v16 < 0.5 then
                        v17 = v16 * 2 * v16;
                    else
                        v17 = 1 - (v16 * -2 + 2) ^ 2 / 2;
                    end;
                    if v17 then
                        v15 = l__EmissiveStrength__7 + (12 - l__EmissiveStrength__7) * v17;
                        l__MaterialService__3.StarInlet.EmissiveStrength = v15;
                        u6 = 0;
                        debug.profileend();
                        return;
                    end;
                end;
                local v18 = 2 - v16;
                if v18 < 0.5 then
                    v17 = v18 * 2 * v18;
                else
                    v17 = 1 - (v18 * -2 + 2) ^ 2 / 2;
                end;
                v15 = l__EmissiveStrength__7 + (12 - l__EmissiveStrength__7) * v17;
                l__MaterialService__3.StarInlet.EmissiveStrength = v15;
                u6 = 0;
                debug.profileend();
            end);
        end;
    end;
end;
function v1.RemoveMutationEffect(p19) --[[ Line: 141 ]]
    -- upvalues: u2 (copy), l__EffectLoadManager__5 (copy), u3 (ref), u4 (ref), l__MaterialService__3 (copy), l__EmissiveStrength__7 (copy)
    local v20 = u2[p19];
    if v20 then
        u2[p19] = nil;
        for _, v21 in v20.vfx do
            if v21.Parent then
                v21:Destroy();
            end;
        end;
        for _, v22 in v20.parts do
            if v22.Parent then
                v22.MaterialVariant = "";
            end;
        end;
        l__EffectLoadManager__5.Unregister();
        u3 = math.max(0, u3 - 1);
        if u3 == 0 then
            if u4 then
                u4:Disconnect();
                u4 = nil;
            end;
            l__MaterialService__3.StarInlet.EmissiveStrength = l__EmissiveStrength__7;
        end;
    end;
end;
l__CollectionService__2:GetInstanceAddedSignal("Starstruck"):Connect(v1.ApplyMutationEffect);
l__CollectionService__2:GetInstanceRemovedSignal("Starstruck"):Connect(v1.RemoveMutationEffect);
for _, v23 in l__CollectionService__2:GetTagged("Starstruck") do
    task.spawn(v1.ApplyMutationEffect, v23);
end;
return v1;