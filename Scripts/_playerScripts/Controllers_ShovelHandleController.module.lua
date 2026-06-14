-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__Shovel__4 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Shovel");
local l__KingName__5 = l__ReplicatedStorage__2.ServerValues.KingName;
local l__BackpackListener__6 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local u2 = game.SoundService:FindFirstChild("SFX");
if u2 then
    u2 = u2:FindFirstChild("Shovel_SFX");
end;
local u3;
if u2 then
    u3 = u2:FindFirstChild("Equip");
else
    u3 = u2;
end;
if u2 then
    u2 = u2:FindFirstChild("Unequip");
end;
local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = CFrame.new(0, 0, 0);
local u8 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
local u9 = {};
local u10 = nil;
local function u13(p11) --[[ Line: 37 ]]
    -- upvalues: u9 (copy)
    for _, v12 in p11:GetDescendants() do
        if v12:IsA("BasePart") and not u9[v12] then
            u9[v12] = {
                Material = v12.Material,
                MaterialVariant = v12.MaterialVariant,
                Color = v12.Color
            };
            v12.Material = Enum.Material.Foil;
            v12.MaterialVariant = "";
            v12.Color = Color3.fromRGB(255, 200, 0);
        end;
    end;
end;
local function u16() --[[ Line: 52 ]]
    -- upvalues: u9 (copy)
    for v14, v15 in u9 do
        if v14.Parent then
            v14.Material = v15.Material;
            v14.MaterialVariant = v15.MaterialVariant;
            v14.Color = v15.Color;
        end;
    end;
    table.clear(u9);
end;
local function u18() --[[ Line: 63 ]]
    -- upvalues: l__LocalPlayer__7 (copy), u16 (copy), u10 (ref), l__KingName__5 (copy), u13 (copy)
    local l__Character__8 = l__LocalPlayer__7.Character;
    if l__Character__8 then
        local v17 = l__Character__8:FindFirstChildWhichIsA("Tool");
        if l__KingName__5.Value == l__LocalPlayer__7.Name and (v17 and v17:GetAttribute("Shovel")) then
            if u10 ~= v17 then
                u16();
            end;
            u10 = v17;
            u13(v17);
        else
            u16();
            u10 = nil;
        end;
    else
        u16();
        u10 = nil;
    end;
end;
function v1.Init(_) --[[ Line: 86 ]]
    -- upvalues: l__KingName__5 (copy), u18 (copy)
    l__KingName__5:GetPropertyChangedSignal("Value"):Connect(u18);
end;
function v1.Start(u19) --[[ Line: 90 ]]
    -- upvalues: l__Players__1 (copy), u4 (copy)
    for _, v20 in l__Players__1:GetPlayers() do
        u19:SetupPlayer(v20);
    end;
    l__Players__1.PlayerAdded:Connect(function(p21) --[[ Line: 95 ]]
        -- upvalues: u19 (copy)
        u19:SetupPlayer(p21);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p22) --[[ Line: 99 ]]
        -- upvalues: u4 (ref), l__Players__1 (ref), u19 (copy)
        for v23 in u4 do
            local v24 = not l__Players__1:GetPlayerFromCharacter(v23.Parent) and (v23.Parent and v23.Parent:IsA("Backpack"));
            if v24 then
                v24 = l__Players__1:GetPlayerFromCharacter(v23.Parent.Parent);
            end;
            if v24 == p22 then
                u19:CleanupTool(v23);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p25, p26) --[[ Line: 110 ]]
    p25.Anchored = false;
    p25.CanCollide = false;
    p25.CanQuery = false;
    p25.CanTouch = p26 == true;
end;
function v1.DisableVFX(_, p27) --[[ Line: 117 ]]
    for _, v28 in p27:GetDescendants() do
        if v28:IsA("ParticleEmitter") or (v28:IsA("Trail") or v28:IsA("Beam")) then
            v28.Enabled = false;
        elseif v28:IsA("Fire") or (v28:IsA("Smoke") or v28:IsA("Sparkles")) then
            v28.Enabled = false;
        elseif v28:IsA("Light") then
            v28.Enabled = false;
        end;
    end;
end;
function v1.ClearHandle(_, p29) --[[ Line: 129 ]]
    -- upvalues: u10 (ref), u9 (copy)
    if p29 == u10 then
        table.clear(u9);
        u10 = nil;
    end;
    for _, u30 in p29:GetChildren() do
        if u30.Name == "Handle" or (u30.Name == "Build" or u30:IsA("Model")) then
            u30.Parent = nil;
            task.defer(function() --[[ Line: 139 ]]
                -- upvalues: u30 (copy)
                if u30 then
                    u30:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p31) --[[ Line: 148 ]]
    for _, v32 in p31:GetChildren() do
        if v32.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p33, p34, p35) --[[ Line: 157 ]]
    -- upvalues: u6 (copy), l__Shovel__4 (copy), l__LocalPlayer__7 (copy), u3 (copy), u7 (copy), u8 (copy), u18 (copy)
    if u6[p34] then
    else
        u6[p34] = true;
        p33:ClearHandle(p34);
        local v36 = p35:FindFirstChild("Right Arm") or p35:FindFirstChild("RightHand");
        if v36 then
            local v37 = l__Shovel__4:Clone();
            p33:DisableVFX(v37);
            local v38 = p35:GetScale();
            if math.abs(v38 - 1) > 0.0001 then
                if v37:IsA("Model") then
                    v37:ScaleTo(v38);
                elseif v37:IsA("BasePart") then
                    v37.Size = v37.Size * v38;
                end;
            end;
            local v39 = l__LocalPlayer__7;
            if v39 then
                v39 = l__LocalPlayer__7.Character == p35;
            end;
            local v40 = p35:FindFirstChild("HumanoidRootPart");
            if v40 and u3 then
                local v41 = u3:Clone();
                v41.Parent = v40;
                v41.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                v41:Play();
                game.Debris:AddItem(v41, v41.TimeLength <= 0 and 2 or v41.TimeLength / v41.PlaybackSpeed);
            end;
            if v37:IsA("BasePart") then
                p33:PreparePartForTool(v37, v39);
                v37.Name = "Handle";
                v37.Parent = p34;
                if v39 then
                    local v42 = u7;
                    p34.Grip = CFrame.new(v42.Position * v38) * v42.Rotation;
                else
                    local v43 = u8;
                    v37.CFrame = v36.CFrame * (CFrame.new(v43.Position * v38) * v43.Rotation);
                    local v44 = Instance.new("WeldConstraint");
                    v44.Part0 = v37;
                    v44.Part1 = v36;
                    v44.Parent = v37;
                end;
            elseif v37:IsA("Model") then
                local l__PrimaryPart__9 = v37.PrimaryPart;
                if not l__PrimaryPart__9 then
                    v37:Destroy();
                    u6[p34] = nil;
                    return;
                end;
                for _, v45 in v37:GetDescendants() do
                    if v45:IsA("BasePart") then
                        p33:PreparePartForTool(v45, v39);
                    end;
                end;
                for _, v46 in v37:GetDescendants() do
                    if v46:IsA("BasePart") and v46 ~= l__PrimaryPart__9 then
                        local v47 = Instance.new("WeldConstraint");
                        v47.Part0 = l__PrimaryPart__9;
                        v47.Part1 = v46;
                        v47.Parent = v46;
                    end;
                end;
                v37.Name = "Build";
                v37.Parent = p34;
                l__PrimaryPart__9.Name = "Handle";
                l__PrimaryPart__9.Parent = p34;
                if v39 then
                    local v48 = u7;
                    p34.Grip = CFrame.new(v48.Position * v38) * v48.Rotation;
                else
                    local v49 = u8;
                    l__PrimaryPart__9.CFrame = v36.CFrame * (CFrame.new(v49.Position * v38) * v49.Rotation);
                    local v50 = Instance.new("WeldConstraint");
                    v50.Part0 = l__PrimaryPart__9;
                    v50.Part1 = v36;
                    v50.Parent = l__PrimaryPart__9;
                end;
            end;
            u6[p34] = nil;
            if v39 then
                u18();
            end;
        else
            u6[p34] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p51, p52) --[[ Line: 259 ]]
    -- upvalues: u6 (copy), u5 (copy), u2 (copy)
    if u6[p52] then
    else
        local v53 = u5[p52];
        if v53 then
            local v54 = p52.Parent == v53;
            local v55 = p51:HasHandle(p52);
            if v54 and not v55 then
                p51:SpawnHandle(p52, v53);
            else
                if not v54 and v55 then
                    local v56 = v53:FindFirstChild("HumanoidRootPart");
                    if v56 and u2 then
                        local v57 = u2:Clone();
                        v57.Parent = v56;
                        v57.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        v57:Play();
                        game.Debris:AddItem(v57, v57.TimeLength <= 0 and 2 or v57.TimeLength / v57.PlaybackSpeed);
                    end;
                    p51:ClearHandle(p52);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p58) --[[ Line: 289 ]]
    -- upvalues: u4 (copy), u5 (copy), u6 (copy)
    local v59 = u4[p58];
    if v59 then
        for _, v60 in v59 do
            v60:Disconnect();
        end;
        u4[p58] = nil;
    end;
    u5[p58] = nil;
    u6[p58] = nil;
end;
function v1.CleanupTool(p61, p62) --[[ Line: 301 ]]
    p61:ClearHandle(p62);
    p61:DisconnectTool(p62);
end;
function v1.IsTrackedTool(_, p63) --[[ Line: 306 ]]
    return p63:GetAttribute("Shovel") ~= nil;
end;
function v1.SetupTool(u64, u65, p66) --[[ Line: 310 ]]
    -- upvalues: u5 (copy), u4 (copy)
    u64:DisconnectTool(u65);
    local v67 = {};
    u5[u65] = p66;
    local v68 = u65:GetPropertyChangedSignal("Parent");
    table.insert(v67, v68:Connect(function() --[[ Line: 316 ]]
        -- upvalues: u65 (copy), u5 (ref), u64 (copy)
        task.defer(function() --[[ Line: 317 ]]
            -- upvalues: u65 (ref), u5 (ref), u64 (ref)
            if u65 and u5[u65] then
                u64:UpdateToolState(u65);
            end;
        end);
    end));
    u4[u65] = v67;
    task.defer(function() --[[ Line: 326 ]]
        -- upvalues: u65 (copy), u5 (ref), u64 (copy)
        if u65 and u5[u65] then
            u64:UpdateToolState(u65);
        end;
    end);
end;
function v1.SetupCharacter(u69, u70) --[[ Line: 333 ]]
    -- upvalues: l__Players__1 (copy), l__RunService__3 (copy)
    task.defer(function() --[[ Line: 334 ]]
        -- upvalues: u70 (copy), u69 (copy), l__Players__1 (ref), l__RunService__3 (ref)
        if u70 and u70.Parent then
            for _, v71 in u70:GetChildren() do
                if v71:IsA("Tool") and u69:IsTrackedTool(v71) then
                    u69:SetupTool(v71, u70);
                end;
            end;
            local v72 = l__Players__1:GetPlayerFromCharacter(u70);
            if v72 and v72.Backpack then
                for _, v73 in v72.Backpack:GetChildren() do
                    if v73:IsA("Tool") and u69:IsTrackedTool(v73) then
                        u69:SetupTool(v73, u70);
                    end;
                end;
            end;
            u70.ChildAdded:Connect(function(u74) --[[ Line: 353 ]]
                -- upvalues: u69 (ref), u70 (ref)
                if u74:IsA("Tool") and u69:IsTrackedTool(u74) then
                    task.defer(function() --[[ Line: 355 ]]
                        -- upvalues: u74 (copy), u70 (ref), u69 (ref)
                        if u74 and (u74.Parent and (u70 and u70.Parent)) then
                            u69:SetupTool(u74, u70);
                        end;
                    end);
                end;
            end);
            local u75 = u70:GetScale();
            local u76 = nil;
            u76 = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 365 ]]
                -- upvalues: u70 (ref), u76 (ref), u69 (ref), u75 (ref)
                if not (u70 and u70.Parent) then
                    u76:Disconnect();
                    return;
                end;
                local v77 = false;
                for _, v78 in u70:GetChildren() do
                    if v78:IsA("Tool") and u69:IsTrackedTool(v78) then
                        v77 = true;
                        break;
                    end;
                end;
                local v79 = v77 and (u70:FindFirstChild("Right Arm") or u70:FindFirstChild("RightHand"));
                if v79 then
                    local v80 = v79:FindFirstChild("RightGrip");
                    local v81 = v79:FindFirstChild("RightGripAttachment");
                    if v80 and (v80:IsA("Weld") and v81) then
                        local l__C0__10 = v80.C0;
                        local l__Position__11 = v81.CFrame.Position;
                        if (l__C0__10.Position - l__Position__11).Magnitude > 0.0001 then
                            v80.C0 = CFrame.new(l__Position__11) * (l__C0__10 - l__C0__10.Position);
                        end;
                    end;
                end;
                if v77 then
                    local v82 = u70:GetScale();
                    if math.abs(v82 - u75) < 0.0001 then
                    else
                        u75 = v82;
                        for _, v83 in u70:GetChildren() do
                            if v83:IsA("Tool") and u69:IsTrackedTool(v83) then
                                u69:SpawnHandle(v83, u70);
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u84, u85) --[[ Line: 409 ]]
    -- upvalues: l__BackpackListener__6 (copy)
    if u85.Character then
        u84:SetupCharacter(u85.Character);
    end;
    u85.CharacterAdded:Connect(function(p86) --[[ Line: 414 ]]
        -- upvalues: u84 (copy)
        u84:SetupCharacter(p86);
    end);
    l__BackpackListener__6.bind(u85, function(u87) --[[ Line: 418 ]]
        -- upvalues: u84 (copy), u85 (copy)
        if u87:IsA("Tool") and u84:IsTrackedTool(u87) then
            task.defer(function() --[[ Line: 420 ]]
                -- upvalues: u85 (ref), u87 (copy), u84 (ref)
                local l__Character__12 = u85.Character;
                if u87 and (u87.Parent and (l__Character__12 and l__Character__12.Parent)) then
                    u84:SetupTool(u87, l__Character__12);
                end;
            end);
        end;
    end);
end;
return v1;