-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__SeedPackOpenController__3 = require(script.Parent.SeedPackOpenController);
local l__Networking__4 = require(l__ReplicatedStorage__2.SharedModules.Networking);
require(l__ReplicatedStorage__2.SharedModules.SeedPackData);
local l__SeedPacks__5 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("SeedPacks");
local _ = l__ReplicatedStorage__2.SharedModules.SeedData.SeedImages;
local l__BackpackListener__6 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = false;
local u6 = false;
local u7 = CFrame.new(0.75, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
local u8 = CFrame.new(0, 0, 0) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0);
function v1.Init(_) --[[ Line: 29 ]] end;
function v1.Start(u9) --[[ Line: 32 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v10 in l__Players__1:GetPlayers() do
        u9:SetupPlayer(v10);
    end;
    l__Players__1.PlayerAdded:Connect(function(p11) --[[ Line: 37 ]]
        -- upvalues: u9 (copy)
        u9:SetupPlayer(p11);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p12) --[[ Line: 41 ]]
        -- upvalues: u2 (ref), l__Players__1 (ref), u9 (copy)
        for v13 in u2 do
            local v14 = not l__Players__1:GetPlayerFromCharacter(v13.Parent) and (v13.Parent and v13.Parent:IsA("Backpack"));
            if v14 then
                v14 = l__Players__1:GetPlayerFromCharacter(v13.Parent.Parent);
            end;
            if v14 == p12 then
                u9:CleanupTool(v13);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p15) --[[ Line: 52 ]]
    p15.Anchored = false;
    p15.CanCollide = false;
    p15.CanQuery = false;
    p15.CanTouch = false;
end;
function v1.DisableVFX(_, p16) --[[ Line: 59 ]]
    for _, v17 in p16:GetDescendants() do
        if v17:IsA("ParticleEmitter") or (v17:IsA("Trail") or v17:IsA("Beam")) then
            v17.Enabled = false;
        elseif v17:IsA("Fire") or (v17:IsA("Smoke") or v17:IsA("Sparkles")) then
            v17.Enabled = false;
        elseif v17:IsA("Light") then
            v17.Enabled = false;
        end;
    end;
end;
function v1.ClearVisual(_, p18) --[[ Line: 71 ]]
    for _, u19 in p18:GetChildren() do
        if u19:GetAttribute("_SeedPackVisual") then
            u19.Parent = nil;
            task.defer(function() --[[ Line: 75 ]]
                -- upvalues: u19 (copy)
                if u19 then
                    u19:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasVisual(_, p20) --[[ Line: 84 ]]
    for _, v21 in p20:GetChildren() do
        if v21:GetAttribute("_SeedPackVisual") then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p22, p23, p24) --[[ Line: 93 ]]
    -- upvalues: u4 (copy), l__SeedPacks__5 (copy), l__LocalPlayer__7 (copy), u7 (copy), u8 (copy)
    if u4[p23] then
    else
        u4[p23] = true;
        p22:ClearVisual(p23);
        local v25 = p23:FindFirstChild("Handle");
        if v25 then
            local v26 = p24:FindFirstChild("Right Arm") or p24:FindFirstChild("RightHand");
            if v26 then
                local v27 = p23:GetAttribute("SeedPack");
                if v27 then
                    local v28 = l__SeedPacks__5:FindFirstChild(v27) or l__SeedPacks__5:FindFirstChild("Normal");
                    if v28 then
                        local v29 = v28:Clone();
                        p22:DisableVFX(v29);
                        local v30 = v29.PrimaryPart or (v29:FindFirstChild("Handle") or v29:FindFirstChildWhichIsA("BasePart", true));
                        if v30 then
                            for _, v31 in v29:GetDescendants() do
                                if v31:IsA("BasePart") then
                                    p22:PreparePartForTool(v31);
                                end;
                            end;
                            local v32 = Instance.new("Weld");
                            v32.Part0 = v30;
                            v32.Part1 = v25;
                            v32.Parent = v30;
                            v29:SetAttribute("_SeedPackVisual", true);
                            v29.Parent = p23;
                            local v33 = l__LocalPlayer__7;
                            if v33 then
                                v33 = l__LocalPlayer__7.Character == p24;
                            end;
                            if v33 then
                                p23.Grip = u7;
                            else
                                v30.CFrame = v26.CFrame * u8;
                                local v34 = Instance.new("WeldConstraint");
                                v34.Part0 = v30;
                                v34.Part1 = v26;
                                v34.Parent = v30;
                            end;
                            u4[p23] = nil;
                        else
                            v29:Destroy();
                            u4[p23] = nil;
                        end;
                    else
                        u4[p23] = nil;
                    end;
                else
                    u4[p23] = nil;
                end;
            else
                u4[p23] = nil;
            end;
        else
            u4[p23] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p35, p36) --[[ Line: 163 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4[p36] then
    else
        local v37 = u3[p36];
        if v37 then
            local v38 = p36.Parent == v37;
            local v39 = p35:HasVisual(p36);
            if v38 and not v39 then
                p35:SpawnHandle(p36, v37);
            else
                if not v38 and v39 then
                    p35:ClearVisual(p36);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p40) --[[ Line: 179 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v41 = u2[p40];
    if v41 then
        for _, v42 in v41 do
            v42:Disconnect();
        end;
        u2[p40] = nil;
    end;
    u3[p40] = nil;
    u4[p40] = nil;
end;
function v1.CleanupTool(p43, p44) --[[ Line: 191 ]]
    p43:ClearVisual(p44);
    p43:DisconnectTool(p44);
end;
function v1.IsTrackedTool(_, p45) --[[ Line: 196 ]]
    return p45:GetAttribute("SeedPack") ~= nil;
end;
function v1.SetupTool(u46, u47, p48) --[[ Line: 200 ]]
    -- upvalues: u3 (copy), u5 (ref), l__Networking__4 (copy), l__SeedPackOpenController__3 (copy), u6 (ref), u2 (copy)
    u46:DisconnectTool(u47);
    local v49 = {};
    u3[u47] = p48;
    local v50 = u47:GetPropertyChangedSignal("Parent");
    table.insert(v49, v50:Connect(function() --[[ Line: 206 ]]
        -- upvalues: u47 (copy), u3 (ref), u46 (copy)
        task.defer(function() --[[ Line: 207 ]]
            -- upvalues: u47 (ref), u3 (ref), u46 (ref)
            if u47 and u3[u47] then
                u46:UpdateToolState(u47);
            end;
        end);
    end));
    local function u54(u51) --[[ Line: 214 ]]
        -- upvalues: u5 (ref), l__Networking__4 (ref), l__SeedPackOpenController__3 (ref)
        if u5 then
            return false;
        end;
        u5 = true;
        local v53, v53 = pcall(function() --[[ Line: 218 ]]
            -- upvalues: l__Networking__4 (ref), u51 (copy)
            return l__Networking__4.SeedPack.OpenSeedPack:Fire(u51);
        end);
        if v53 and (v53 and v53.Success) then
            l__SeedPackOpenController__3:Roll({}, {
                Chance = 0,
                Name = v53.WonSeed
            });
        elseif not v53 then
            warn((`[SeedPackHandleController] OpenSeedPack invoke errored ({u51}): {v53}`));
        end;
        u5 = false;
        if v53 then
            if v53 then
                v53 = v53.Success;
            end;
        end;
        return v53;
    end;
    table.insert(v49, u47.Activated:Connect(function() --[[ Line: 235 ]]
        -- upvalues: u47 (copy), u6 (ref), u54 (copy)
        local v55 = u47:GetAttribute("SeedPack");
        if not v55 or u6 then
            return;
        end;
        u6 = true;
        if not u54(v55) then
            u6 = false;
            return;
        end;
        local v56 = tick();
        while u6 and tick() - v56 < 1 do
            task.wait();
        end;
        while u6 do
            local v57 = u47:GetAttribute("SeedPack");
            if not (v57 and u54(v57)) then
                break;
            end;
            local v58 = tick();
            while u6 and tick() - v58 < 0.2 do
                task.wait();
            end;
        end;
    end));
    table.insert(v49, u47.Deactivated:Connect(function() --[[ Line: 266 ]]
        -- upvalues: u6 (ref)
        u6 = false;
    end));
    u2[u47] = v49;
    task.defer(function() --[[ Line: 272 ]]
        -- upvalues: u47 (copy), u3 (ref), u46 (copy)
        if u47 and u3[u47] then
            u46:UpdateToolState(u47);
        end;
    end);
end;
function v1.SetupCharacter(u59, u60) --[[ Line: 279 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 280 ]]
        -- upvalues: u60 (copy), u59 (copy), l__Players__1 (ref)
        if u60 and u60.Parent then
            for _, v61 in u60:GetChildren() do
                if v61:IsA("Tool") and u59:IsTrackedTool(v61) then
                    u59:SetupTool(v61, u60);
                end;
            end;
            local v62 = l__Players__1:GetPlayerFromCharacter(u60);
            if v62 and v62.Backpack then
                for _, v63 in v62.Backpack:GetChildren() do
                    if v63:IsA("Tool") and u59:IsTrackedTool(v63) then
                        u59:SetupTool(v63, u60);
                    end;
                end;
            end;
            u60.ChildAdded:Connect(function(u64) --[[ Line: 299 ]]
                -- upvalues: u59 (ref), u60 (ref)
                if u64:IsA("Tool") and u59:IsTrackedTool(u64) then
                    task.defer(function() --[[ Line: 301 ]]
                        -- upvalues: u64 (copy), u60 (ref), u59 (ref)
                        if u64 and (u64.Parent and (u60 and u60.Parent)) then
                            u59:SetupTool(u64, u60);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u65, u66) --[[ Line: 311 ]]
    -- upvalues: l__BackpackListener__6 (copy)
    if u66.Character then
        u65:SetupCharacter(u66.Character);
    end;
    u66.CharacterAdded:Connect(function(p67) --[[ Line: 316 ]]
        -- upvalues: u65 (copy)
        u65:SetupCharacter(p67);
    end);
    l__BackpackListener__6.bind(u66, function(u68) --[[ Line: 320 ]]
        -- upvalues: u65 (copy), u66 (copy)
        if u68:IsA("Tool") and u65:IsTrackedTool(u68) then
            task.defer(function() --[[ Line: 322 ]]
                -- upvalues: u66 (ref), u68 (copy), u65 (ref)
                local l__Character__8 = u66.Character;
                if u68 and (u68.Parent and (l__Character__8 and l__Character__8.Parent)) then
                    u65:SetupTool(u68, l__Character__8);
                end;
            end);
        end;
    end);
end;
return v1;