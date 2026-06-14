-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Gnome__3 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Gnome");
local l__BackpackListener__4 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = CFrame.new(0, 0, 0);
local u6 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
function v1.Init(_) --[[ Line: 19 ]] end;
function v1.Start(u7) --[[ Line: 22 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v8 in l__Players__1:GetPlayers() do
        u7:SetupPlayer(v8);
    end;
    l__Players__1.PlayerAdded:Connect(function(p9) --[[ Line: 27 ]]
        -- upvalues: u7 (copy)
        u7:SetupPlayer(p9);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p10) --[[ Line: 31 ]]
        -- upvalues: u2 (ref), l__Players__1 (ref), u7 (copy)
        for v11 in u2 do
            local v12 = not l__Players__1:GetPlayerFromCharacter(v11.Parent) and (v11.Parent and v11.Parent:IsA("Backpack"));
            if v12 then
                v12 = l__Players__1:GetPlayerFromCharacter(v11.Parent.Parent);
            end;
            if v12 == p10 then
                u7:CleanupTool(v11);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p13) --[[ Line: 42 ]]
    p13.Anchored = false;
    p13.CanCollide = false;
    p13.CanQuery = false;
    p13.CanTouch = false;
end;
function v1.DisableVFX(_, p14) --[[ Line: 49 ]]
    for _, v15 in p14:GetDescendants() do
        if v15:IsA("ParticleEmitter") or (v15:IsA("Trail") or v15:IsA("Beam")) then
            v15.Enabled = false;
        elseif v15:IsA("Fire") or (v15:IsA("Smoke") or v15:IsA("Sparkles")) then
            v15.Enabled = false;
        elseif v15:IsA("Light") then
            v15.Enabled = false;
        end;
    end;
end;
function v1.ClearHandle(_, p16) --[[ Line: 61 ]]
    for _, u17 in p16:GetChildren() do
        if u17.Name == "Handle" or (u17.Name == "Build" or u17:IsA("Model")) then
            u17.Parent = nil;
            task.defer(function() --[[ Line: 65 ]]
                -- upvalues: u17 (copy)
                if u17 then
                    u17:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p18) --[[ Line: 74 ]]
    for _, v19 in p18:GetChildren() do
        if v19.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p20, p21, p22) --[[ Line: 83 ]]
    -- upvalues: u4 (copy), l__Gnome__3 (copy), l__LocalPlayer__5 (copy), u5 (copy), u6 (copy)
    if u4[p21] then
    else
        u4[p21] = true;
        p20:ClearHandle(p21);
        local v23 = p22:FindFirstChild("Right Arm") or p22:FindFirstChild("RightHand");
        if v23 then
            if p21:GetAttribute("Gnome") then
                local v24 = l__Gnome__3:Clone();
                p20:DisableVFX(v24);
                local v25 = l__LocalPlayer__5;
                if v25 then
                    v25 = l__LocalPlayer__5.Character == p22;
                end;
                local l__PrimaryPart__6 = v24.PrimaryPart;
                if l__PrimaryPart__6 then
                    for _, v26 in v24:GetDescendants() do
                        if v26:IsA("BasePart") then
                            p20:PreparePartForTool(v26);
                        end;
                    end;
                    for _, v27 in v24:GetDescendants() do
                        if v27:IsA("BasePart") and v27 ~= l__PrimaryPart__6 then
                            local v28 = Instance.new("WeldConstraint");
                            v28.Part0 = l__PrimaryPart__6;
                            v28.Part1 = v27;
                            v28.Parent = v27;
                        end;
                    end;
                    v24.Name = "Build";
                    v24.Parent = p21;
                    l__PrimaryPart__6.Name = "Handle";
                    l__PrimaryPart__6.Parent = p21;
                    if v25 then
                        p21.Grip = u5;
                    else
                        l__PrimaryPart__6.CFrame = v23.CFrame * u6;
                        local v29 = Instance.new("WeldConstraint");
                        v29.Part0 = l__PrimaryPart__6;
                        v29.Part1 = v23;
                        v29.Parent = l__PrimaryPart__6;
                    end;
                    u4[p21] = nil;
                else
                    v24:Destroy();
                    u4[p21] = nil;
                end;
            else
                u4[p21] = nil;
            end;
        else
            u4[p21] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p30, p31) --[[ Line: 150 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4[p31] then
    else
        local v32 = u3[p31];
        if v32 then
            local v33 = p31.Parent == v32;
            local v34 = p30:HasHandle(p31);
            if v33 and not v34 then
                p30:SpawnHandle(p31, v32);
            else
                if not v33 and v34 then
                    p30:ClearHandle(p31);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p35) --[[ Line: 166 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v36 = u2[p35];
    if v36 then
        for _, v37 in v36 do
            v37:Disconnect();
        end;
        u2[p35] = nil;
    end;
    u3[p35] = nil;
    u4[p35] = nil;
end;
function v1.CleanupTool(p38, p39) --[[ Line: 178 ]]
    p38:ClearHandle(p39);
    p38:DisconnectTool(p39);
end;
function v1.IsTrackedTool(_, p40) --[[ Line: 183 ]]
    return p40:GetAttribute("Gnome") ~= nil;
end;
function v1.SetupTool(u41, u42, p43) --[[ Line: 187 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u41:DisconnectTool(u42);
    local v44 = {};
    u3[u42] = p43;
    local v45 = u42:GetPropertyChangedSignal("Parent");
    table.insert(v44, v45:Connect(function() --[[ Line: 193 ]]
        -- upvalues: u42 (copy), u3 (ref), u41 (copy)
        task.defer(function() --[[ Line: 194 ]]
            -- upvalues: u42 (ref), u3 (ref), u41 (ref)
            if u42 and u3[u42] then
                u41:UpdateToolState(u42);
            end;
        end);
    end));
    u2[u42] = v44;
    task.defer(function() --[[ Line: 203 ]]
        -- upvalues: u42 (copy), u3 (ref), u41 (copy)
        if u42 and u3[u42] then
            u41:UpdateToolState(u42);
        end;
    end);
end;
function v1.SetupCharacter(u46, u47) --[[ Line: 210 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 211 ]]
        -- upvalues: u47 (copy), u46 (copy), l__Players__1 (ref)
        if u47 and u47.Parent then
            for _, v48 in u47:GetChildren() do
                if v48:IsA("Tool") and u46:IsTrackedTool(v48) then
                    u46:SetupTool(v48, u47);
                end;
            end;
            local v49 = l__Players__1:GetPlayerFromCharacter(u47);
            if v49 and v49.Backpack then
                for _, v50 in v49.Backpack:GetChildren() do
                    if v50:IsA("Tool") and u46:IsTrackedTool(v50) then
                        u46:SetupTool(v50, u47);
                    end;
                end;
            end;
            u47.ChildAdded:Connect(function(u51) --[[ Line: 230 ]]
                -- upvalues: u46 (ref), u47 (ref)
                if u51:IsA("Tool") and u46:IsTrackedTool(u51) then
                    task.defer(function() --[[ Line: 232 ]]
                        -- upvalues: u51 (copy), u47 (ref), u46 (ref)
                        if u51 and (u51.Parent and (u47 and u47.Parent)) then
                            u46:SetupTool(u51, u47);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u52, u53) --[[ Line: 242 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u53.Character then
        u52:SetupCharacter(u53.Character);
    end;
    u53.CharacterAdded:Connect(function(p54) --[[ Line: 247 ]]
        -- upvalues: u52 (copy)
        u52:SetupCharacter(p54);
    end);
    l__BackpackListener__4.bind(u53, function(u55) --[[ Line: 251 ]]
        -- upvalues: u52 (copy), u53 (copy)
        if u55:IsA("Tool") and u52:IsTrackedTool(u55) then
            task.defer(function() --[[ Line: 253 ]]
                -- upvalues: u53 (ref), u55 (copy), u52 (ref)
                local l__Character__7 = u53.Character;
                if u55 and (u55.Parent and (l__Character__7 and l__Character__7.Parent)) then
                    u52:SetupTool(u55, l__Character__7);
                end;
            end);
        end;
    end);
end;
return v1;