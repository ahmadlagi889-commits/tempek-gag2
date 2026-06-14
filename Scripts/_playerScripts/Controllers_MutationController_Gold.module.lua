-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__GrowEffects__1 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects"));
local l__VFX__2 = script.VFX;
local u2 = {};
local u3 = Color3.fromHSV(0.14, 1, 1);
function v1.ApplyMutationEffect(u4) --[[ Line: 64 ]]
    -- upvalues: u2 (copy), l__GrowEffects__1 (copy), l__VFX__2 (copy), u3 (copy)
    if u4:IsA("Model") and (u4.PrimaryPart and (not u2[u4] and (u4:IsA("Model") and u4.PrimaryPart))) then
        l__GrowEffects__1.AddDescendantsAtBaseline(u4, function() --[[ Line: 27 ]]
            -- upvalues: u4 (copy), l__VFX__2 (ref), u2 (ref)
            local v5, v6 = u4:GetBoundingBox();
            local v7 = Instance.new("Part");
            v7.Name = "GoldVFX";
            v7.Size = v6;
            v7.CFrame = v5;
            v7.Transparency = 1;
            v7.CanCollide = false;
            v7.CanQuery = false;
            v7.CanTouch = false;
            v7.Anchored = true;
            v7.Massless = true;
            v7:AddTag("MutationVFX");
            v7.Parent = u4;
            for _, v8 in l__VFX__2:GetChildren() do
                v8:Clone().Parent = v7;
            end;
            u2[u4] = v7;
        end);
    end;
    if u4:IsA("BasePart") then
        u4.Color = u3;
        u4.Reflectance = 0.5;
        u4.Material = Enum.Material.Plastic;
        u4.MaterialVariant = "GoldStudTexture";
    end;
    for _, v9 in u4:GetDescendants() do
        if v9:IsA("BasePart") then
            local l__Parent__3 = v9.Parent;
            local v10;
            while true do
                if not l__Parent__3 or l__Parent__3 == u4 then
                    v10 = false;
                    break;
                end;
                if l__Parent__3.Name == "Fruits" then
                    v10 = true;
                    break;
                end;
                l__Parent__3 = l__Parent__3.Parent;
            end;
            if not v10 then
                v9.Color = u3;
                v9.Reflectance = 0.5;
                v9.Material = Enum.Material.Plastic;
                v9.MaterialVariant = "GoldStudTexture";
            end;
        end;
    end;
    u4.DescendantAdded:Connect(function(p11) --[[ Line: 77 ]]
        -- upvalues: u4 (copy), u3 (ref), u2 (ref), l__GrowEffects__1 (ref), l__VFX__2 (ref)
        if p11:IsA("BasePart") then
            local v12 = u4;
            local l__Parent__4 = p11.Parent;
            local v13;
            while true do
                if not l__Parent__4 or l__Parent__4 == v12 then
                    v13 = false;
                    break;
                end;
                if l__Parent__4.Name == "Fruits" then
                    v13 = true;
                    break;
                end;
                l__Parent__4 = l__Parent__4.Parent;
            end;
            if not v13 then
                p11.Color = u3;
                p11.Reflectance = 0.5;
                p11.Material = Enum.Material.Plastic;
                p11.MaterialVariant = "GoldStudTexture";
            end;
        end;
        if not u2[u4] then
            local u14 = u4;
            if u14:IsA("Model") and u14.PrimaryPart then
                if u2[u14] then
                    return;
                end;
                if u14:IsA("Model") then
                    if not u14.PrimaryPart then
                        return;
                    end;
                    l__GrowEffects__1.AddDescendantsAtBaseline(u14, function() --[[ Line: 27 ]]
                        -- upvalues: u14 (copy), l__VFX__2 (ref), u2 (ref)
                        local v15, v16 = u14:GetBoundingBox();
                        local v17 = Instance.new("Part");
                        v17.Name = "GoldVFX";
                        v17.Size = v16;
                        v17.CFrame = v15;
                        v17.Transparency = 1;
                        v17.CanCollide = false;
                        v17.CanQuery = false;
                        v17.CanTouch = false;
                        v17.Anchored = true;
                        v17.Massless = true;
                        v17:AddTag("MutationVFX");
                        v17.Parent = u14;
                        for _, v18 in l__VFX__2:GetChildren() do
                            v18:Clone().Parent = v17;
                        end;
                        u2[u14] = v17;
                    end);
                end;
            end;
        end;
    end);
end;
return v1;