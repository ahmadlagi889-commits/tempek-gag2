-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__GrowEffects__1 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects"));
local u2 = Color3.fromRGB(180, 220, 255);
local l__VFX__2 = script.VFX;
local u3 = {};
function v1.ApplyMutationEffect(u4) --[[ Line: 71 ]]
    -- upvalues: u3 (copy), l__GrowEffects__1 (copy), l__VFX__2 (copy), u2 (copy)
    if u4:IsA("Model") and (u4.PrimaryPart and (not u3[u4] and (u4:IsA("Model") and u4.PrimaryPart))) then
        l__GrowEffects__1.AddDescendantsAtBaseline(u4, function() --[[ Line: 23 ]]
            -- upvalues: u4 (copy), l__VFX__2 (ref), u3 (ref)
            local v5, v6 = u4:GetBoundingBox();
            local v7 = Instance.new("Part");
            v7.Name = "FrozenVFX";
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
            local v8 = game.ReplicatedStorage.Assets.Stud_Part:Clone();
            v8.Name = "FrozenFX";
            v8.Size = v6;
            v8.CFrame = v5;
            v8.Transparency = 0.5;
            v8.Color = Color3.fromRGB(160, 210, 255);
            v8.CanCollide = false;
            v8.CanQuery = false;
            v8.CanTouch = false;
            v8.Anchored = true;
            v8.Massless = true;
            v8.Parent = u4;
            for _, v9 in l__VFX__2:GetChildren() do
                v9:Clone().Parent = v8;
            end;
            u3[u4] = v8;
        end);
    end;
    if u4:IsA("BasePart") then
        u4.Color = u2;
        u4.Reflectance = 0.4;
    end;
    for _, v10 in u4:GetDescendants() do
        if v10:IsA("BasePart") then
            local l__Parent__3 = v10.Parent;
            local v11;
            while true do
                if not l__Parent__3 or l__Parent__3 == u4 then
                    v11 = false;
                    break;
                end;
                if l__Parent__3.Name == "Fruits" then
                    v11 = true;
                    break;
                end;
                l__Parent__3 = l__Parent__3.Parent;
            end;
            if not v11 then
                v10.Color = u2;
                v10.Reflectance = 0.4;
            end;
        end;
    end;
    u4.DescendantAdded:Connect(function(p12) --[[ Line: 84 ]]
        -- upvalues: u4 (copy), u2 (ref), u3 (ref), l__GrowEffects__1 (ref), l__VFX__2 (ref)
        if p12:IsA("BasePart") then
            local v13 = u4;
            local l__Parent__4 = p12.Parent;
            local v14;
            while true do
                if not l__Parent__4 or l__Parent__4 == v13 then
                    v14 = false;
                    break;
                end;
                if l__Parent__4.Name == "Fruits" then
                    v14 = true;
                    break;
                end;
                l__Parent__4 = l__Parent__4.Parent;
            end;
            if not v14 then
                p12.Color = u2;
                p12.Reflectance = 0.4;
            end;
        end;
        if not u3[u4] then
            local u15 = u4;
            if u15:IsA("Model") and u15.PrimaryPart then
                if u3[u15] then
                    return;
                end;
                if u15:IsA("Model") then
                    if not u15.PrimaryPart then
                        return;
                    end;
                    l__GrowEffects__1.AddDescendantsAtBaseline(u15, function() --[[ Line: 23 ]]
                        -- upvalues: u15 (copy), l__VFX__2 (ref), u3 (ref)
                        local v16, v17 = u15:GetBoundingBox();
                        local v18 = Instance.new("Part");
                        v18.Name = "FrozenVFX";
                        v18.Size = v17;
                        v18.CFrame = v16;
                        v18.Transparency = 1;
                        v18.CanCollide = false;
                        v18.CanQuery = false;
                        v18.CanTouch = false;
                        v18.Anchored = true;
                        v18.Massless = true;
                        v18:AddTag("MutationVFX");
                        v18.Parent = u15;
                        local v19 = game.ReplicatedStorage.Assets.Stud_Part:Clone();
                        v19.Name = "FrozenFX";
                        v19.Size = v17;
                        v19.CFrame = v16;
                        v19.Transparency = 0.5;
                        v19.Color = Color3.fromRGB(160, 210, 255);
                        v19.CanCollide = false;
                        v19.CanQuery = false;
                        v19.CanTouch = false;
                        v19.Anchored = true;
                        v19.Massless = true;
                        v19.Parent = u15;
                        for _, v20 in l__VFX__2:GetChildren() do
                            v20:Clone().Parent = v19;
                        end;
                        u3[u15] = v19;
                    end);
                end;
            end;
        end;
    end);
end;
return v1;