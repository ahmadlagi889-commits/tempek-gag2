-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__CollectionService__1 = game:GetService("CollectionService");
local l__ProximityPromptService__2 = game:GetService("ProximityPromptService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Players__5 = game:GetService("Players");
local l__RunService__6 = game:GetService("RunService");
local l__DevProductController__7 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController);
local u2 = nil;
local l__LocalPlayer__8 = l__Players__5.LocalPlayer;
local l__PlayerGui__9 = l__LocalPlayer__8:WaitForChild("PlayerGui");
local l__HoldToCollect__10 = l__PlayerGui__9:WaitForChild("HoldToCollect");
local l__Collect__11 = l__HoldToCollect__10:WaitForChild("Collect");
local l__HoldToSteal__12 = l__PlayerGui__9:WaitForChild("HoldToSteal");
local l__Collect__13 = l__HoldToSteal__12:WaitForChild("Collect");
local u3 = {};
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = 0;
local function u10(u9) --[[ Line: 44 ]]
    u9:InputHoldBegin();
    if u9.HoldDuration > 0 then
        task.delay(u9.HoldDuration + 0.05, function() --[[ Line: 47 ]]
            -- upvalues: u9 (copy)
            if u9 and u9:IsDescendantOf(workspace) then
                u9:InputHoldEnd();
            end;
        end);
    else
        u9:InputHoldEnd();
    end;
end;
local u16 = {
    {
        name = "Harvest",
        tag = "HarvestPrompt",
        holding = false,
        pressing = false,
        activateOnTrigger = true,
        ui = l__HoldToCollect__10,
        button = l__Collect__11,
        visible = {},
        queue = {},
        perform = function(_, _, p11, p12) --[[ Name: perform, Line 67 ]]
            -- upvalues: u2 (ref)
            u2.Garden.CollectFruit:Fire(p11, p12 or "");
        end
    },
    {
        name = "Steal",
        tag = "StealPrompt",
        holding = false,
        pressing = false,
        activateOnTrigger = false,
        ui = l__HoldToSteal__12,
        button = l__Collect__13,
        visible = {},
        queue = {},
        gate = function() --[[ Name: isNight, Line 72 ]]
            -- upvalues: l__ReplicatedStorage__3 (copy)
            local v13 = l__ReplicatedStorage__3:FindFirstChild("Night");
            local v14;
            if v13 == nil then
                v14 = false;
            else
                v14 = v13.Value == true;
            end;
            return v14;
        end,
        perform = function(p15, _, _, _) --[[ Name: perform, Line 88 ]]
            -- upvalues: u10 (copy)
            u10(p15);
        end
    }
};
local function u25(p17, p18) --[[ Line: 127 ]]
    local v19 = p17.CFrame:PointToObjectSpace(p18);
    local v20 = p17.Size * 0.5;
    local v21 = math.clamp(v19.X, -v20.X, v20.X);
    local v22 = math.clamp(v19.Y, -v20.Y, v20.Y);
    local v23 = math.clamp(v19.Z, -v20.Z, v20.Z);
    local v24 = Vector3.new(v21, v22, v23);
    return p17.CFrame:PointToWorldSpace(v24);
end;
local function u33(p26, p27) --[[ Line: 140 ]]
    -- upvalues: u25 (copy)
    local v28 = (1 / 0);
    local v29 = nil;
    for _, v30 in p26 do
        if v30.Parent then
            local v31 = u25(v30, p27);
            local l__Magnitude__14 = (p27 - v31).Magnitude;
            if l__Magnitude__14 < v28 then
                v29 = v31;
                v28 = l__Magnitude__14;
            end;
        end;
    end;
    if not v29 then
        return nil;
    end;
    local v32 = p27 - v29;
    return v29 + (v32.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or v32.Unit) * 0.75;
end;
local function u37(p34) --[[ Line: 169 ]]
    local v35 = {};
    for _, v36 in p34:GetDescendants() do
        if v36:IsA("BasePart") and v36.Name ~= "HarvestPart" then
            table.insert(v35, v36);
        end;
    end;
    return v35;
end;
local function u42(p38) --[[ Line: 179 ]]
    local v39 = p38:FindFirstChild("HarvestPart");
    if v39 and v39:IsA("BasePart") then
        return v39;
    end;
    local v40 = p38.PrimaryPart or p38:FindFirstChildWhichIsA("BasePart");
    if not v40 then
        return nil;
    end;
    local v41 = Instance.new("Part");
    v41.Name = "HarvestPart";
    v41.Size = Vector3.new(1, 1, 1);
    v41.Transparency = 1;
    v41.Anchored = true;
    v41.CanCollide = false;
    v41.CanTouch = false;
    v41.CanQuery = false;
    v41.CFrame = v40.CFrame;
    v41.Parent = p38;
    return v41;
end;
local function u45(p43) --[[ Line: 212 ]]
    -- upvalues: u6 (ref), u5 (ref)
    if u6 == p43 and (u5 and u5.Parent) then
    else
        if u5 then
            u5:Destroy();
            u5 = nil;
        end;
        u6 = nil;
        local v44 = Instance.new("Highlight");
        v44.Name = "ActiveHarvestHighlight";
        v44.Adornee = p43;
        v44.FillColor = Color3.fromRGB(255, 224, 94);
        v44.OutlineColor = Color3.fromRGB(255, 255, 255);
        v44.FillTransparency = 1;
        v44.OutlineTransparency = 0.5;
        v44.DepthMode = Enum.HighlightDepthMode.Occluded;
        v44.Parent = p43;
        u5 = v44;
        u6 = p43;
    end;
end;
local function u55() --[[ Line: 233 ]]
    -- upvalues: l__LocalPlayer__8 (copy), u5 (ref), u6 (ref), u3 (copy), u45 (copy)
    local l__Character__15 = l__LocalPlayer__8.Character;
    local v46;
    if l__Character__15 then
        local v47 = l__Character__15:FindFirstChild("HumanoidRootPart");
        if v47 then
            v46 = v47.Position;
        else
            v46 = nil;
        end;
    else
        v46 = nil;
    end;
    if v46 then
        local v48 = (1 / 0);
        local v49 = nil;
        for v50 in u3 do
            if v50:IsDescendantOf(workspace) and v50.Enabled then
                local l__Parent__16 = v50.Parent;
                local v51;
                if l__Parent__16 then
                    v51 = l__Parent__16:FindFirstAncestorWhichIsA("Model");
                else
                    v51 = nil;
                end;
                if v51 then
                    local _, v52 = v51:GetBoundingBox();
                    local v53 = (v46 - v51:GetPivot().Position).Magnitude - v52.Magnitude * 0.5;
                    if v53 < v48 then
                        v49 = v50;
                        v48 = v53;
                    end;
                end;
            end;
        end;
        if v49 then
            local l__Parent__17 = v49.Parent;
            local v54;
            if l__Parent__17 then
                v54 = l__Parent__17:FindFirstAncestorWhichIsA("Model");
            else
                v54 = nil;
            end;
            if v54 then
                u45(v54);
            else
                if u5 then
                    u5:Destroy();
                    u5 = nil;
                end;
                u6 = nil;
            end;
        else
            if u5 then
                u5:Destroy();
                u5 = nil;
            end;
            u6 = nil;
        end;
    else
        if u5 then
            u5:Destroy();
            u5 = nil;
        end;
        u6 = nil;
    end;
end;
local function u64(u56) --[[ Line: 276 ]]
    -- upvalues: u4 (copy), u42 (copy), u37 (copy), u3 (copy), u16 (copy), u55 (copy), u7 (ref)
    if u4[u56] then
    elseif u56:IsDescendantOf(workspace) then
        local l__Parent__18 = u56.Parent;
        local u57;
        if l__Parent__18 then
            u57 = l__Parent__18:FindFirstAncestorWhichIsA("Model");
        else
            u57 = nil;
        end;
        local l__Parent__19 = u56.Parent;
        if u57 and (l__Parent__19 and l__Parent__19:IsA("BasePart")) then
            u56.MaxActivationDistance = 10;
            local v58;
            if l__Parent__19.Name == "HarvestPart" then
                v58 = l__Parent__19;
            else
                v58 = u42(u57);
                if v58 then
                    u56.Parent = v58;
                else
                    v58 = l__Parent__19;
                end;
            end;
            local u59 = {
                needsSnap = true,
                model = u57,
                part = v58,
                parts = u37(u57),
                boundingRadius = select(2, u57:GetBoundingBox()).Magnitude * 0.5
            };
            local function v61(p60) --[[ Line: 308 ]]
                -- upvalues: u59 (copy), u37 (ref), u57 (copy)
                if p60 and not p60:IsA("BasePart") then
                else
                    u59.parts = u37(u57);
                    u59.boundingRadius = select(2, u57:GetBoundingBox()).Magnitude * 0.5;
                end;
            end;
            u59.partsConn = u57.DescendantAdded:Connect(v61);
            u59.partsRemovedConn = u57.DescendantRemoving:Connect(v61);
            u4[u56] = u59;
            u56.Destroying:Once(function() --[[ Line: 319 ]]
                -- upvalues: u4 (ref), u56 (copy), u3 (ref), u16 (ref), u55 (ref), u7 (ref)
                local v62 = u4[u56];
                if v62 then
                    if v62.partsConn then
                        v62.partsConn:Disconnect();
                    end;
                    if v62.partsRemovedConn then
                        v62.partsRemovedConn:Disconnect();
                    end;
                end;
                u4[u56] = nil;
                u3[u56] = nil;
                for _, v63 in u16 do
                    v63.visible[u56] = nil;
                end;
                u55();
                u7();
            end);
        end;
    end;
end;
local function u73(p65) --[[ Line: 335 ]]
    -- upvalues: l__LocalPlayer__8 (copy), u4 (copy), u33 (copy)
    local l__Character__20 = l__LocalPlayer__8.Character;
    local v66;
    if l__Character__20 then
        local v67 = l__Character__20:FindFirstChild("HumanoidRootPart");
        if v67 then
            v66 = v67.Position;
        else
            v66 = nil;
        end;
    else
        v66 = nil;
    end;
    if v66 then
        local v68 = math.clamp(p65 * 18, 0, 1);
        for v69, v70 in u4 do
            if v69:IsDescendantOf(workspace) then
                local l__model__21 = v70.model;
                local l__part__22 = v70.part;
                if l__model__21 and (l__model__21:IsDescendantOf(workspace) and (l__part__22 and l__part__22.Parent)) then
                    local l__Position__23 = l__model__21:GetPivot().Position;
                    if math.max(24, v69.MaxActivationDistance + 8) >= (l__Position__23 - v66).Magnitude - (v70.boundingRadius or 0) then
                        local v71 = u33(v70.parts, v66);
                        if v71 then
                            if v70.needsSnap then
                                l__part__22.CFrame = CFrame.new(v71);
                                v70.needsSnap = false;
                            else
                                local v72 = l__part__22.Position:Lerp(v71, v68);
                                l__part__22.CFrame = CFrame.new(v72);
                            end;
                        end;
                    end;
                else
                    if v70.partsConn then
                        v70.partsConn:Disconnect();
                    end;
                    if v70.partsRemovedConn then
                        v70.partsRemovedConn:Disconnect();
                    end;
                    u4[v69] = nil;
                end;
            else
                if v70.partsConn then
                    v70.partsConn:Disconnect();
                end;
                if v70.partsRemovedConn then
                    v70.partsRemovedConn:Disconnect();
                end;
                u4[v69] = nil;
            end;
        end;
    end;
end;
local function u78(p74) --[[ Line: 385 ]]
    -- upvalues: l__UserInputService__4 (copy)
    local l__TouchEnabled__24 = l__UserInputService__4.TouchEnabled;
    if l__TouchEnabled__24 then
        l__TouchEnabled__24 = not l__UserInputService__4.KeyboardEnabled;
    end;
    if not l__TouchEnabled__24 then
        p74.ui.Enabled = false;
        return;
    end;
    p74.ui.Enabled = true;
    if p74.gate and not p74.gate() then
        p74.button.Visible = false;
        return;
    end;
    if p74.pressing then
        p74.button.Visible = true;
        return;
    end;
    local v75 = false;
    for v76 in p74.visible do
        if v76:IsDescendantOf(workspace) and v76.Enabled then
            local v77 = v76:HasTag("StealPrompt");
            if v77 then
                v77 = v76.HoldDuration > 0;
            end;
            if not v77 then
                v75 = true;
                break;
            end;
        end;
    end;
    p74.button.Visible = v75;
end;
u7 = function() --[[ Line: 413 ]]
    -- upvalues: u16 (copy), u78 (ref)
    for _, v79 in u16 do
        u78(v79);
    end;
end;
local function u87(p80, u81) --[[ Line: 419 ]]
    if p80.gate and not p80.gate() then
        return false;
    end;
    if not u81:IsDescendantOf(workspace) then
        return false;
    end;
    if not u81.Enabled then
        return false;
    end;
    if u81:GetAttribute("Collected") then
        return false;
    end;
    local v82 = u81:HasTag("StealPrompt");
    if v82 then
        v82 = u81.HoldDuration > 0;
    end;
    if v82 then
        return false;
    end;
    local l__Parent__25 = u81.Parent;
    if not l__Parent__25 then
        return false;
    end;
    local v83 = l__Parent__25:FindFirstAncestorWhichIsA("Model");
    if not v83 then
        return false;
    end;
    local v84 = v83:GetAttribute("PlantId");
    local v85 = v83:GetAttribute("FruitId");
    if p80.activateOnTrigger and not v84 then
        return false;
    end;
    u81:SetAttribute("Collected", true);
    local v86 = math.max(0.09, u81.HoldDuration + 0.1);
    task.delay(v86, function() --[[ Line: 440 ]]
        -- upvalues: u81 (copy)
        if u81 and u81:IsDescendantOf(workspace) then
            u81:SetAttribute("Collected", nil);
        end;
    end);
    p80.perform(u81, v83, v84, v85);
    return true;
end;
local function u95(u88) --[[ Line: 462 ]]
    -- upvalues: l__ProximityPromptService__2 (copy), u87 (copy)
    if u88.holding then
    else
        u88.holding = true;
        for v89 in u88.visible do
            if not table.find(u88.queue, v89) then
                table.insert(u88.queue, v89);
            end;
        end;
        local v92 = l__ProximityPromptService__2.PromptShown:Connect(function(p90) --[[ Line: 470 ]]
            -- upvalues: u88 (copy)
            if p90:HasTag(u88.tag) then
                local v91 = u88;
                if not table.find(v91.queue, p90) then
                    table.insert(v91.queue, p90);
                end;
            end;
        end);
        while u88.holding do
            if #u88.queue == 0 then
                for v93 in u88.visible do
                    if not table.find(u88.queue, v93) then
                        table.insert(u88.queue, v93);
                    end;
                end;
            end;
            local v94;
            if #u88.queue == 0 then
                v94 = nil;
            else
                v94 = table.remove(u88.queue, 1);
            end;
            if v94 then
                u87(u88, v94);
            end;
            task.wait(0.1);
        end;
        v92:Disconnect();
        table.clear(u88.queue);
    end;
end;
local function u97() --[[ Line: 500 ]]
    -- upvalues: u16 (copy), u78 (ref)
    for _, v96 in u16 do
        v96.holding = false;
        v96.pressing = false;
        u78(v96);
    end;
end;
local function u102(p98) --[[ Line: 506 ]]
    -- upvalues: l__UserInputService__4 (copy), u95 (copy)
    local u99 = false;
    local u100 = nil;
    u100 = l__UserInputService__4.InputEnded:Connect(function(p101) --[[ Line: 509 ]]
        -- upvalues: u100 (ref), u99 (ref)
        if p101.KeyCode == Enum.KeyCode.E or p101.KeyCode == Enum.KeyCode.ButtonX then
            u100:Disconnect();
            u99 = true;
        end;
    end);
    task.wait(0.5);
    if not u99 then
        u100:Disconnect();
        u95(p98);
    end;
end;
local function u108(u103) --[[ Line: 524 ]]
    -- upvalues: u78 (ref), u87 (copy), u95 (copy)
    if u103.button:IsA("GuiButton") then
        u103.button.MouseButton1Down:Connect(function() --[[ Line: 529 ]]
            -- upvalues: u103 (copy), u78 (ref), u87 (ref), u95 (ref)
            u103.pressing = true;
            u78(u103);
            for v104 in u103.visible do
                u87(u103, v104);
            end;
            local u105 = false;
            local v106 = u103.button.MouseButton1Up:Once(function() --[[ Line: 539 ]]
                -- upvalues: u105 (ref)
                u105 = true;
            end);
            task.wait(0.5);
            if v106.Connected then
                v106:Disconnect();
            end;
            if not u105 then
                u95(u103);
            end;
        end);
        u103.button.MouseButton1Up:Connect(function() --[[ Line: 554 ]]
            -- upvalues: u103 (copy), u78 (ref)
            local v107 = u103;
            v107.holding = false;
            v107.pressing = false;
            u78(v107);
        end);
    end;
end;
function v1.Init(_) --[[ Line: 559 ]]
    -- upvalues: u2 (ref), l__ReplicatedStorage__3 (copy), u7 (ref), l__CollectionService__1 (copy), u64 (copy), l__ProximityPromptService__2 (copy), u3 (copy), u55 (copy), u16 (copy), u78 (ref), u108 (copy), u87 (copy), l__UserInputService__4 (copy), u102 (copy), l__DevProductController__7 (copy), u97 (copy), l__LocalPlayer__8 (copy), l__RunService__6 (copy), u73 (copy), u8 (ref)
    u2 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("Networking"));
    u7();
    task.spawn(function() --[[ Line: 564 ]]
        -- upvalues: l__ReplicatedStorage__3 (ref), u7 (ref)
        local l__Night__26 = l__ReplicatedStorage__3:WaitForChild("Night", 10);
        if l__Night__26 then
            l__Night__26.Changed:Connect(u7);
        end;
    end);
    for _, v109 in { "HarvestPrompt", "StealPrompt", "GrowPrompt" } do
        for _, v110 in l__CollectionService__1:GetTagged(v109) do
            if v110:IsA("ProximityPrompt") then
                u64(v110);
            end;
        end;
        l__CollectionService__1:GetInstanceAddedSignal(v109):Connect(function(p111) --[[ Line: 578 ]]
            -- upvalues: u64 (ref)
            if p111:IsA("ProximityPrompt") then
                u64(p111);
            end;
        end);
    end;
    l__ProximityPromptService__2.PromptShown:Connect(function(p112) --[[ Line: 585 ]]
        -- upvalues: u64 (ref), u3 (ref), u55 (ref), u16 (ref), u78 (ref)
        if p112:HasTag("HarvestPrompt") or (p112:HasTag("StealPrompt") or p112:HasTag("GrowPrompt")) then
            u64(p112);
            u3[p112] = true;
            u55();
        end;
        for _, v114 in u16 do
            if p112:HasTag(v114.tag) then
                if v114 then
                    v114.visible[p112] = true;
                    u78(v114);
                end;
                return;
            end;
        end;
        local v114 = nil;
        if v114 then
            v114.visible[p112] = true;
            u78(v114);
        end;
    end);
    l__ProximityPromptService__2.PromptHidden:Connect(function(p115) --[[ Line: 599 ]]
        -- upvalues: u16 (ref), u78 (ref), u3 (ref), u55 (ref)
        for _, v117 in u16 do
            if p115:HasTag(v117.tag) then
                if v117 then
                    v117.visible[p115] = nil;
                    u78(v117);
                end;
                if p115:HasTag("HarvestPrompt") or (p115:HasTag("StealPrompt") or p115:HasTag("GrowPrompt")) then
                    u3[p115] = nil;
                    u55();
                end;
            end;
        end;
        local v117 = nil;
        if v117 then
            v117.visible[p115] = nil;
            u78(v117);
        end;
        if p115:HasTag("HarvestPrompt") or (p115:HasTag("StealPrompt") or p115:HasTag("GrowPrompt")) then
            u3[p115] = nil;
            u55();
        end;
    end);
    for _, v118 in u16 do
        u108(v118);
    end;
    l__ProximityPromptService__2.PromptTriggered:Connect(function(p119) --[[ Line: 616 ]]
        -- upvalues: u16 (ref), u87 (ref)
        for _, v121 in u16 do
            if p119:HasTag(v121.tag) then
                if v121 and v121.activateOnTrigger then
                    u87(v121, p119);
                end;
            end;
        end;
        local v121 = nil;
        if v121 and v121.activateOnTrigger then
            u87(v121, p119);
        end;
    end);
    l__ProximityPromptService__2.PromptTriggered:Connect(function(p122) --[[ Line: 623 ]]
        -- upvalues: u16 (ref), l__UserInputService__4 (ref), u102 (ref)
        for _, v124 in u16 do
            if p122:HasTag(v124.tag) then
                if v124 then
                    if l__UserInputService__4:IsKeyDown(Enum.KeyCode.E) or l__UserInputService__4:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX) then
                        u102(v124);
                        return;
                    else
                        return;
                    end;
                else
                    return;
                end;
            end;
        end;
        local v124 = nil;
        if v124 then
            if l__UserInputService__4:IsKeyDown(Enum.KeyCode.E) or l__UserInputService__4:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX) then
                u102(v124);
            end;
        end;
    end);
    l__ProximityPromptService__2.PromptTriggered:Connect(function(p125) --[[ Line: 634 ]]
        -- upvalues: u2 (ref), l__DevProductController__7 (ref)
        if p125:HasTag("GrowPrompt") then
            local l__Parent__27 = p125.Parent;
            local v126;
            if l__Parent__27 then
                v126 = l__Parent__27:FindFirstAncestorWhichIsA("Model");
            else
                v126 = nil;
            end;
            if not v126 then
                return;
            end;
            local v127 = v126:GetAttribute("PlantId");
            if not v127 then
                return;
            end;
            u2.GrowPlant:Fire(v127);
            l__DevProductController__7:PromptPurchase("Standalone:Grow Plant:1");
        end;
    end);
    l__UserInputService__4.InputBegan:Connect(function(p128, _) --[[ Line: 645 ]]
        -- upvalues: u16 (ref), u102 (ref)
        if p128.KeyCode == Enum.KeyCode.E or p128.KeyCode == Enum.KeyCode.ButtonX then
            for _, v129 in u16 do
                if next(v129.visible) ~= nil then
                    task.spawn(u102, v129);
                end;
            end;
        end;
    end);
    l__UserInputService__4.InputEnded:Connect(function(p130) --[[ Line: 655 ]]
        -- upvalues: u16 (ref), u78 (ref)
        if p130.KeyCode == Enum.KeyCode.E or p130.KeyCode == Enum.KeyCode.ButtonX then
            for _, v131 in u16 do
                v131.holding = false;
                v131.pressing = false;
                u78(v131);
            end;
        end;
    end);
    l__UserInputService__4.InputEnded:Connect(function(p132) --[[ Line: 661 ]]
        -- upvalues: u16 (ref), u78 (ref)
        if p132.UserInputType == Enum.UserInputType.Touch then
            for _, v133 in u16 do
                v133.holding = false;
                v133.pressing = false;
                u78(v133);
            end;
        end;
    end);
    l__UserInputService__4.WindowFocusReleased:Connect(u97);
    u55();
    u7();
    l__LocalPlayer__8.CharacterAdded:Connect(function() --[[ Line: 672 ]]
        -- upvalues: u55 (ref), u7 (ref)
        task.defer(function() --[[ Line: 673 ]]
            -- upvalues: u55 (ref), u7 (ref)
            u55();
            u7();
        end);
    end);
    l__RunService__6.Heartbeat:Connect(function(p134) --[[ Line: 679 ]]
        -- upvalues: u73 (ref), u8 (ref), u55 (ref)
        debug.profilebegin("Controllers/HarvestPromptController/Heartbeat");
        u73(p134);
        u8 = u8 + 1;
        if u8 >= 3 then
            u8 = 0;
            u55();
        end;
        debug.profileend();
    end);
end;
function v1.Start(_) --[[ Line: 691 ]] end;
return v1;