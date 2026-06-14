-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__CollectionService__4 = game:GetService("CollectionService");
local l__Networking__5 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__Gardens__7 = workspace:WaitForChild("Gardens");
local u2 = nil;
local u3 = 0;
local u4 = nil;
local u5 = {};
local u6 = {};
function v1.Init(_) --[[ Line: 30 ]] end;
function v1.Start(u7) --[[ Line: 33 ]]
    -- upvalues: l__UserInputService__2 (copy), u2 (ref), l__LocalPlayer__6 (copy), l__Networking__5 (copy)
    l__UserInputService__2.InputBegan:Connect(function(p8, p9) --[[ Line: 34 ]]
        -- upvalues: u2 (ref), u7 (copy)
        if p9 then
        elseif u2 then
            if p8.UserInputType == Enum.UserInputType.MouseButton1 and true or p8.KeyCode == Enum.KeyCode.ButtonR2 then
                u7:ProcessSwing();
            end;
        end;
    end);
    l__UserInputService__2.TouchTapInWorld:Connect(function(_, p10) --[[ Line: 46 ]]
        -- upvalues: u2 (ref), u7 (copy)
        if p10 then
        elseif u2 then
            u7:ProcessSwing();
        end;
    end);
    local l__Character__8 = l__LocalPlayer__6.Character;
    if l__Character__8 then
        u7:SetupCharacter(l__Character__8);
    end;
    l__LocalPlayer__6.CharacterAdded:Connect(function(p11) --[[ Line: 56 ]]
        -- upvalues: u7 (copy)
        u7:SetupCharacter(p11);
    end);
    l__Networking__5.Crowbar.DoorForced.OnClientEvent:Connect(function(p12, p13, p14) --[[ Line: 60 ]]
        -- upvalues: u7 (copy)
        u7:HandleDoorForced(p12, p13, p14);
    end);
end;
function v1.SetupCharacter(_, p15) --[[ Line: 68 ]]
    -- upvalues: u2 (ref)
    for _, v16 in p15:GetChildren() do
        if v16:IsA("Tool") and v16:GetAttribute("Crowbar") then
            u2 = v16;
        end;
    end;
    p15.ChildAdded:Connect(function(p17) --[[ Line: 75 ]]
        -- upvalues: u2 (ref)
        if p17:IsA("Tool") and p17:GetAttribute("Crowbar") then
            u2 = p17;
        end;
    end);
    p15.ChildRemoved:Connect(function(p18) --[[ Line: 81 ]]
        -- upvalues: u2 (ref)
        if p18:IsA("Tool") and (p18:GetAttribute("Crowbar") and u2 == p18) then
            u2 = nil;
        end;
    end);
end;
function v1.FindPropByIds(_, p19, p20) --[[ Line: 93 ]]
    -- upvalues: l__Players__1 (copy), l__Gardens__7 (copy)
    local v21 = l__Players__1:GetPlayerByUserId(p19);
    if not v21 then
        return nil;
    end;
    local v22 = v21:GetAttribute("PlotId");
    if not v22 then
        return nil;
    end;
    local v23 = l__Gardens__7:FindFirstChild("Plot" .. tostring(v22));
    if not v23 then
        return nil;
    end;
    local v24 = v23:FindFirstChild("Props");
    if not v24 then
        return nil;
    end;
    for _, v25 in v24:GetChildren() do
        if v25:GetAttribute("PropId") == p20 then
            return v25;
        end;
    end;
    return nil;
end;
function v1.FindPropModel(_, p26) --[[ Line: 115 ]]
    local l__Parent__9 = p26.Parent;
    while l__Parent__9 and l__Parent__9 ~= workspace do
        if l__Parent__9:IsA("Model") and l__Parent__9:GetAttribute("PropId") then
            return l__Parent__9;
        end;
        l__Parent__9 = l__Parent__9.Parent;
    end;
    return nil;
end;
function v1.IsDoorPryable(_, p27) --[[ Line: 129 ]]
    -- upvalues: l__LocalPlayer__6 (copy)
    if p27:GetAttribute("ForcedOpen") then
        return false;
    end;
    local v28 = p27:GetAttribute("UserId");
    return (not v28 or v28 ~= l__LocalPlayer__6.UserId) and true or false;
end;
function v1.HandleDoorForced(p29, p30, p31, p32) --[[ Line: 145 ]]
    -- upvalues: u6 (copy), l__CollectionService__4 (copy)
    local u33 = p29:FindPropByIds(p30, p31);
    if u33 then
        if u6[u33] then
            task.cancel(u6[u33]);
            u6[u33] = nil;
        end;
        u33:SetAttribute("ForcedOpen", true);
        local v34 = {};
        local v35 = nil;
        for _, v36 in u33:GetDescendants() do
            if v36:IsA("BasePart") and l__CollectionService__4:HasTag(v36, "CrowbarDoor") then
                table.insert(v34, v36.Color);
                if not v35 then
                    v35 = v36.Position;
                end;
            end;
        end;
        u6[u33] = task.delay(p32, function() --[[ Line: 167 ]]
            -- upvalues: u6 (ref), u33 (copy)
            u6[u33] = nil;
            if u33 and u33.Parent then
                u33:SetAttribute("ForcedOpen", false);
            end;
        end);
    end;
end;
function v1.HandleDoorForced(p37, p38, p39, p40) --[[ Line: 174 ]]
    -- upvalues: l__Players__1 (copy), l__Gardens__7 (copy), u6 (copy), l__CollectionService__4 (copy)
    local u41 = p37:FindPropByIds(p38, p39);
    if u41 then
        if u6[u41] then
            task.cancel(u6[u41]);
            u6[u41] = nil;
        end;
        u41:SetAttribute("ForcedOpen", true);
        local v42 = {};
        local v43 = nil;
        for _, v44 in u41:GetDescendants() do
            if v44:IsA("BasePart") and l__CollectionService__4:HasTag(v44, "CrowbarDoor") then
                table.insert(v42, v44.Color);
                if not v43 then
                    v43 = v44.Position;
                end;
            end;
        end;
        u6[u41] = task.delay(p40, function() --[[ Line: 217 ]]
            -- upvalues: u6 (ref), u41 (copy)
            u6[u41] = nil;
            if u41 and u41.Parent then
                u41:SetAttribute("ForcedOpen", false);
            end;
        end);
    else
        local v45 = l__Players__1:GetPlayerByUserId(p38);
        if v45 then
            local v46 = v45:GetAttribute("PlotId");
            if v46 then
                local v47 = l__Gardens__7:FindFirstChild("Plot" .. tostring(v46));
                local v48 = v47 and v47:FindFirstChild("Props");
                if v48 then
                    for _, _ in v48:GetChildren() do

                    end;
                end;
            end;
        end;
    end;
end;
function v1.PlaySwingAnimation(_) --[[ Line: 227 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u4 (ref)
    local l__Character__10 = l__LocalPlayer__6.Character;
    if l__Character__10 then
        local v49 = l__Character__10:FindFirstChildOfClass("Humanoid");
        if v49 then
            local v50 = v49:FindFirstChildOfClass("Animator");
            if v50 then
                local v51 = Instance.new("Animation");
                v51.AnimationId = "rbxassetid://78592768207309";
                u4 = v50:LoadAnimation(v51);
                u4.Looped = false;
                u4.Priority = Enum.AnimationPriority.Action4;
                u4:Play();
            end;
        end;
    end;
end;
function v1.ProcessSwing(p52) --[[ Line: 243 ]]
    -- upvalues: u2 (ref), u3 (ref), l__Networking__5 (copy)
    if u2 then
        local v53 = os.clock();
        if v53 - u3 < 1 then
        else
            u3 = v53;
            p52:PlaySwingAnimation();
            l__Networking__5.Crowbar.SwingCrowbar:Fire();
            p52:ActivateHitDetection();
        end;
    end;
end;
function v1.ActivateHitDetection(u54) --[[ Line: 262 ]]
    -- upvalues: u2 (ref), l__LocalPlayer__6 (copy), l__CollectionService__4 (copy), l__Networking__5 (copy), l__Players__1 (copy), u5 (copy)
    local v55 = u2;
    if v55 then
        local v56 = l__LocalPlayer__6:GetAttribute("IsInOwnGarden") and "NormalCollision" or "GardenCollision";
        local v57 = {};
        local v58 = {};
        local u59 = {};
        local u60 = {};
        local u61 = 0;
        local u62 = {};
        for _, v63 in v55:GetDescendants() do
            if v63:IsA("BasePart") then
                if v63.Name == v56 then
                    table.insert(v57, v63.Name);
                else
                    table.insert(v58, v63);
                end;
            end;
        end;
        for _, _ in v58 do

        end;
        if #v58 == 0 then
            for _, _ in v55:GetDescendants() do

            end;
        end;
        for _, v64 in v58 do
            local v72 = v64.Touched:Connect(function(p65) --[[ Line: 298 ]]
                -- upvalues: u61 (ref), l__CollectionService__4 (ref), u54 (copy), u62 (copy), l__Networking__5 (ref), l__Players__1 (ref), l__LocalPlayer__6 (ref), u59 (copy), u5 (ref)
                if p65:IsA("BasePart") then
                    u61 = u61 + 1;
                    if l__CollectionService__4:HasTag(p65, "CrowbarDoor") then
                        local v66 = u54:FindPropModel(p65);
                        if v66 then
                            if u62[v66] then
                            elseif u54:IsDoorPryable(v66) then
                                u62[v66] = true;
                                local v67 = v66:GetAttribute("UserId");
                                local v68 = v66:GetAttribute("PropId");
                                if v67 and v68 then
                                    l__Networking__5.Crowbar.PryDoor:Fire(v67, v68);
                                end;
                            end;
                        end;
                    else
                        local v69 = p65:FindFirstAncestorWhichIsA("Model");
                        if v69 then
                            local v70 = l__Players__1:GetPlayerFromCharacter(v69);
                            if v70 and v70 ~= l__LocalPlayer__6 then
                                if u59[v70] then
                                else
                                    local v71 = os.clock();
                                    if u5[v70] and v71 - u5[v70] < 0.5 then
                                    else
                                        u59[v70] = true;
                                        u5[v70] = v71;
                                        l__Networking__5.Crowbar.HitPlayer:Fire(v70.UserId);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
            table.insert(u60, v72);
        end;
        task.delay(0.4, function() --[[ Line: 350 ]]
            -- upvalues: u60 (copy)
            for _, v73 in u60 do
                v73:Disconnect();
            end;
        end);
    end;
end;
return v1;