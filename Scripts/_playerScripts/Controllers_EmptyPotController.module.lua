-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 6
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__Networking__4 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__GardenSyncController__5 = require(script.Parent.GardenSyncController);
local l__PlantVisualizerController__6 = require(script.Parent.PlantVisualizerController);
local l__SeedData__7 = require(l__ReplicatedStorage__2.SharedModules.SeedData);
local l__NotificationController__8 = require(script.Parent.NotificationController);
local l__ProximityPromptService__9 = game:GetService("ProximityPromptService");
local l__LocalPlayer__10 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = nil;
local function u8(p4) --[[ Line: 35 ]]
    local v5 = p4:FindFirstChild("HarvestPart");
    if v5 and v5:IsA("BasePart") then
        return v5;
    end;
    local v6 = p4.PrimaryPart or p4:FindFirstChildWhichIsA("BasePart");
    if not v6 then
        return nil;
    end;
    local v7 = Instance.new("Part");
    v7.Name = "HarvestPart";
    v7.Size = Vector3.new(1, 1, 1);
    v7.Transparency = 1;
    v7.Anchored = true;
    v7.CanCollide = false;
    v7.CanTouch = false;
    v7.CanQuery = false;
    v7.CFrame = v6.CFrame;
    v7.Parent = p4;
    return v7;
end;
local function u21(u9, u10) --[[ Line: 59 ]]
    -- upvalues: u2 (copy), u8 (copy), l__CollectionService__3 (copy), u21 (copy), l__GardenSyncController__5 (copy), l__LocalPlayer__10 (copy), l__SeedData__7 (copy), l__NotificationController__8 (copy), l__Networking__4 (copy)
    if u2[u10] then
        return;
    end;
    local v11 = u8(u9);
    if not v11 then
        return;
    end;
    if not u9:HasTag("InitializationComplete") then
        local u12 = nil;
        u12 = l__CollectionService__3:GetInstanceAddedSignal("InitializationComplete"):Connect(function(p13) --[[ Line: 70 ]]
            -- upvalues: u9 (copy), u12 (ref), u21 (ref), u10 (copy)
            if p13 == u9 then
                u12:Disconnect();
                u21(u9, u10);
            end;
        end);
        return;
    end;
    local v14 = u10:match("^%d+_(.+)$") or u10;
    local u15 = l__GardenSyncController__5:GetPlant(l__LocalPlayer__10.UserId, v14);
    if not u15 then
        return;
    end;
    local v16 = nil;
    for _, v17 in l__SeedData__7 do
        if v17.SeedName == u15.PlantName then
            v16 = v17;
            break;
        end;
    end;
    if v16 and not v16.IsSingleHarvest then
        if u15.IsPotted then
        else
            local v18 = Instance.new("ProximityPrompt");
            v18.Name = "PotPrompt";
            v18.ActionText = "Pot Plant";
            v18.ObjectText = u15.PlantName or "Plant";
            v18.HoldDuration = 1;
            v18.Enabled = true;
            v18.MaxActivationDistance = 8;
            v18.RequiresLineOfSight = false;
            v18.Style = Enum.ProximityPromptStyle.Custom;
            v18.Parent = v11;
            v18.Triggered:Connect(function(p19) --[[ Line: 110 ]]
                -- upvalues: l__LocalPlayer__10 (ref), u9 (copy), u15 (copy), l__NotificationController__8 (ref), u10 (copy), l__Networking__4 (ref)
                if p19 == l__LocalPlayer__10 then
                    if (u9:GetAttribute("Age") or 0) < (u9:GetAttribute("MaxAge") or (u15.MaxAge or 0)) then
                        l__NotificationController__8:CreateNotification("This crop hasn\'t fully grown yet!");
                    else
                        local v20 = u10:match("^%d+_(.+)$") or u10;
                        l__Networking__4.Garden.PotPlant:Fire(v20);
                    end;
                end;
            end);
            u2[u10] = v18;
        end;
    end;
end;
local function u24() --[[ Line: 132 ]]
    -- upvalues: l__PlantVisualizerController__6 (copy), l__LocalPlayer__10 (copy), u21 (copy)
    local v22 = l__PlantVisualizerController__6:GetPlantsFolder(l__LocalPlayer__10.UserId);
    if v22 then
        for _, v23 in v22:GetChildren() do
            if v23:IsA("Model") then
                u21(v23, v23.Name);
            end;
        end;
    end;
end;
local function u28(p25) --[[ Line: 146 ]]
    -- upvalues: u3 (ref), u24 (copy), l__PlantVisualizerController__6 (copy), l__LocalPlayer__10 (copy), u21 (copy)
    if p25:GetAttribute("EmptyPot") then
        u3 = p25;
        u24();
        local v26 = l__PlantVisualizerController__6:GetPlantsFolder(l__LocalPlayer__10.UserId);
        if v26 then
            v26.ChildAdded:Connect(function(p27) --[[ Line: 158 ]]
                -- upvalues: u3 (ref), u21 (ref)
                if u3 and p27:IsA("Model") then
                    u21(p27, p27.Name);
                end;
            end);
        end;
    end;
end;
function v1.Init(_) --[[ Line: 176 ]] end;
function v1.Start(_) --[[ Line: 179 ]]
    -- upvalues: l__LocalPlayer__10 (copy), u28 (copy), u3 (ref), u2 (copy), l__Networking__4 (copy), l__ProximityPromptService__9 (copy)
    local function v35(p29) --[[ Line: 183 ]]
        -- upvalues: u28 (ref), u3 (ref), u2 (ref)
        for _, v30 in p29:GetChildren() do
            if v30:IsA("Tool") then
                u28(v30);
            end;
        end;
        p29.ChildAdded:Connect(function(p31) --[[ Line: 190 ]]
            -- upvalues: u28 (ref)
            if p31:IsA("Tool") then
                u28(p31);
            end;
        end);
        p29.ChildRemoved:Connect(function(p32) --[[ Line: 195 ]]
            -- upvalues: u3 (ref), u2 (ref)
            if p32:IsA("Tool") then
                if not p32:GetAttribute("EmptyPot") then
                    return;
                end;
                u3 = nil;
                for v33, v34 in u2 do
                    if v34 and v34.Parent then
                        v34:Destroy();
                    end;
                    u2[v33] = nil;
                end;
            end;
        end);
    end;
    v35(l__LocalPlayer__10.Character or l__LocalPlayer__10.CharacterAdded:Wait());
    l__LocalPlayer__10.CharacterAdded:Connect(v35);
    l__Networking__4.Garden.PlantPotted.OnClientEvent:Connect(function(p36) --[[ Line: 207 ]]
        -- upvalues: u2 (ref)
        local v37 = u2[p36];
        if v37 and v37.Parent then
            v37:Destroy();
        end;
        u2[p36] = nil;
    end);
    l__ProximityPromptService__9.PromptTriggered:Connect(function(p38, p39) --[[ Line: 216 ]]
        -- upvalues: l__LocalPlayer__10 (ref), l__Networking__4 (ref)
        if p39 == l__LocalPlayer__10 then
            if p38.Name == "PickUpPottedPlantPrompt" then
                local v40 = p38:FindFirstAncestorOfClass("Model");
                if v40 then
                    if v40 and v40.Name == "PotVisual" then
                        v40 = v40:FindFirstAncestorOfClass("Model");
                    end;
                    local v41 = v40:GetAttribute("PlantId");
                    if v41 then
                        l__Networking__4.PotPlacement.PickUpPottedPlant:Fire(v41);
                    end;
                end;
            end;
        end;
    end);
end;
return v1;