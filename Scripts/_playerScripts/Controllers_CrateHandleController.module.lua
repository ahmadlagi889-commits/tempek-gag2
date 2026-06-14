-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Assets__3 = l__ReplicatedStorage__2:WaitForChild("Assets");
local l__Crates__4 = l__Assets__3:WaitForChild("Crates");
local l__BackpackListener__5 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = CFrame.new(0, 0, 1.5);
local u6 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
local function u12(p7) --[[ Line: 25 ]]
    -- upvalues: l__Assets__3 (copy), l__Crates__4 (copy)
    local v8 = l__Assets__3:FindFirstChild("GuildCrates");
    if v8 then
        local v9 = v8:FindFirstChild(p7);
        if v9 and v9:IsA("Model") then
            return v9;
        end;
    end;
    local v10 = l__Crates__4:FindFirstChild(p7);
    if v10 and v10:IsA("Model") then
        return v10;
    else
        local v11 = l__Crates__4:FindFirstChild("Arch Crate");
        if v11 and v11:IsA("Model") then
            return v11;
        else
            return nil;
        end;
    end;
end;
function v1.Init(_) --[[ Line: 46 ]] end;
function v1.Start(u13) --[[ Line: 49 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v14 in l__Players__1:GetPlayers() do
        u13:SetupPlayer(v14);
    end;
    l__Players__1.PlayerAdded:Connect(function(p15) --[[ Line: 54 ]]
        -- upvalues: u13 (copy)
        u13:SetupPlayer(p15);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p16) --[[ Line: 58 ]]
        -- upvalues: u2 (ref), l__Players__1 (ref), u13 (copy)
        for v17 in u2 do
            local v18 = not l__Players__1:GetPlayerFromCharacter(v17.Parent) and (v17.Parent and v17.Parent:IsA("Backpack"));
            if v18 then
                v18 = l__Players__1:GetPlayerFromCharacter(v17.Parent.Parent);
            end;
            if v18 == p16 then
                u13:CleanupTool(v17);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p19) --[[ Line: 69 ]]
    p19.Anchored = false;
    p19.CanCollide = false;
    p19.CanQuery = false;
    p19.CanTouch = false;
end;
function v1.DisableVFX(_, p20) --[[ Line: 76 ]]
    for _, v21 in p20:GetDescendants() do
        if v21:IsA("ParticleEmitter") or v21:IsA("Trail") then
            v21.Enabled = false;
        elseif v21:IsA("Fire") or (v21:IsA("Smoke") or v21:IsA("Sparkles")) then
            v21.Enabled = false;
        elseif v21:IsA("Light") then
            v21.Enabled = false;
        end;
    end;
end;
function v1.ClearHandle(_, p22) --[[ Line: 89 ]]
    for _, u23 in p22:GetChildren() do
        if u23.Name == "Handle" or (u23.Name == "Build" or u23:IsA("Model")) then
            u23.Parent = nil;
            task.defer(function() --[[ Line: 93 ]]
                -- upvalues: u23 (copy)
                if u23 then
                    u23:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p24) --[[ Line: 102 ]]
    for _, v25 in p24:GetChildren() do
        if v25.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p26, p27, p28) --[[ Line: 111 ]]
    -- upvalues: u4 (copy), u12 (copy), l__LocalPlayer__6 (copy), u5 (copy), u6 (copy)
    if u4[p27] then
    else
        u4[p27] = true;
        p26:ClearHandle(p27);
        local v29 = p28:FindFirstChild("Right Arm") or p28:FindFirstChild("RightHand");
        if v29 then
            local v30 = p27:GetAttribute("Crate");
            if v30 then
                local v31 = u12(v30);
                if v31 then
                    local v32 = v31:Clone();
                    p26:DisableVFX(v32);
                    local v33 = l__LocalPlayer__6;
                    if v33 then
                        v33 = l__LocalPlayer__6.Character == p28;
                    end;
                    local l__PrimaryPart__7 = v32.PrimaryPart;
                    if l__PrimaryPart__7 then
                        for _, v34 in v32:GetDescendants() do
                            if v34:IsA("BasePart") then
                                p26:PreparePartForTool(v34);
                            end;
                        end;
                        for _, v35 in v32:GetDescendants() do
                            if v35:IsA("BasePart") and v35 ~= l__PrimaryPart__7 then
                                local v36 = Instance.new("WeldConstraint");
                                v36.Part0 = l__PrimaryPart__7;
                                v36.Part1 = v35;
                                v36.Parent = v35;
                            end;
                        end;
                        v32.Name = "Build";
                        v32.Parent = p27;
                        l__PrimaryPart__7.Name = "Handle";
                        l__PrimaryPart__7.Parent = p27;
                        if v33 then
                            p27.Grip = u5;
                        else
                            l__PrimaryPart__7.CFrame = v29.CFrame * u6;
                            local v37 = Instance.new("WeldConstraint");
                            v37.Part0 = l__PrimaryPart__7;
                            v37.Part1 = v29;
                            v37.Parent = l__PrimaryPart__7;
                        end;
                        u4[p27] = nil;
                    else
                        v32:Destroy();
                        u4[p27] = nil;
                    end;
                else
                    u4[p27] = nil;
                end;
            else
                u4[p27] = nil;
            end;
        else
            u4[p27] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p38, p39) --[[ Line: 184 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4[p39] then
    else
        local v40 = u3[p39];
        if v40 then
            local v41 = p39.Parent == v40;
            local v42 = p38:HasHandle(p39);
            if v41 and not v42 then
                p38:SpawnHandle(p39, v40);
            else
                if not v41 and v42 then
                    p38:ClearHandle(p39);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p43) --[[ Line: 200 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v44 = u2[p43];
    if v44 then
        for _, v45 in v44 do
            v45:Disconnect();
        end;
        u2[p43] = nil;
    end;
    u3[p43] = nil;
    u4[p43] = nil;
end;
function v1.CleanupTool(p46, p47) --[[ Line: 212 ]]
    p46:ClearHandle(p47);
    p46:DisconnectTool(p47);
end;
function v1.IsTrackedTool(_, p48) --[[ Line: 217 ]]
    return p48:GetAttribute("Crate") ~= nil;
end;
function v1.SetupTool(u49, u50, p51) --[[ Line: 221 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u49:DisconnectTool(u50);
    local v52 = {};
    u3[u50] = p51;
    local v53 = u50:GetPropertyChangedSignal("Parent");
    table.insert(v52, v53:Connect(function() --[[ Line: 227 ]]
        -- upvalues: u50 (copy), u3 (ref), u49 (copy)
        task.defer(function() --[[ Line: 228 ]]
            -- upvalues: u50 (ref), u3 (ref), u49 (ref)
            if u50 and u3[u50] then
                u49:UpdateToolState(u50);
            end;
        end);
    end));
    u2[u50] = v52;
    task.defer(function() --[[ Line: 237 ]]
        -- upvalues: u50 (copy), u3 (ref), u49 (copy)
        if u50 and u3[u50] then
            u49:UpdateToolState(u50);
        end;
    end);
end;
function v1.SetupCharacter(u54, u55) --[[ Line: 244 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 245 ]]
        -- upvalues: u55 (copy), u54 (copy), l__Players__1 (ref)
        if u55 and u55.Parent then
            for _, v56 in u55:GetChildren() do
                if v56:IsA("Tool") and u54:IsTrackedTool(v56) then
                    u54:SetupTool(v56, u55);
                end;
            end;
            local v57 = l__Players__1:GetPlayerFromCharacter(u55);
            if v57 and v57.Backpack then
                for _, v58 in v57.Backpack:GetChildren() do
                    if v58:IsA("Tool") and u54:IsTrackedTool(v58) then
                        u54:SetupTool(v58, u55);
                    end;
                end;
            end;
            u55.ChildAdded:Connect(function(u59) --[[ Line: 263 ]]
                -- upvalues: u54 (ref), u55 (ref)
                if u59:IsA("Tool") and u54:IsTrackedTool(u59) then
                    task.defer(function() --[[ Line: 265 ]]
                        -- upvalues: u59 (copy), u55 (ref), u54 (ref)
                        if u59 and (u59.Parent and (u55 and u55.Parent)) then
                            u54:SetupTool(u59, u55);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u60, u61) --[[ Line: 275 ]]
    -- upvalues: l__BackpackListener__5 (copy)
    if u61.Character then
        u60:SetupCharacter(u61.Character);
    end;
    u61.CharacterAdded:Connect(function(p62) --[[ Line: 280 ]]
        -- upvalues: u60 (copy)
        u60:SetupCharacter(p62);
    end);
    l__BackpackListener__5.bind(u61, function(u63) --[[ Line: 287 ]]
        -- upvalues: u60 (copy), u61 (copy)
        if u63:IsA("Tool") and u60:IsTrackedTool(u63) then
            task.defer(function() --[[ Line: 289 ]]
                -- upvalues: u61 (ref), u63 (copy), u60 (ref)
                local l__Character__8 = u61.Character;
                if u63 and (u63.Parent and (l__Character__8 and l__Character__8.Parent)) then
                    u60:SetupTool(u63, l__Character__8);
                end;
            end);
        end;
    end);
end;
return v1;