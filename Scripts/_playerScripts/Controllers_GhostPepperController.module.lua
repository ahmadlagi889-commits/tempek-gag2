-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Players__4 = game:GetService("Players");
local l__LocalPlayer__5 = l__Players__4.LocalPlayer;
local l__Networking__6 = require(l__ReplicatedStorage__2.SharedModules.Networking);
require(l__ReplicatedStorage__2.ClientModules.Signal).new();
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = false;
local u6 = nil;
local u7 = 0;
local u8 = 0;
local u9 = nil;
local u10 = OverlapParams.new();
u10.FilterType = Enum.RaycastFilterType.Include;
u10.FilterDescendantsInstances = {};
local function u13() --[[ Line: 39 ]]
    -- upvalues: l__Players__4 (copy), u10 (copy)
    local v11 = {};
    for _, v12 in l__Players__4:GetPlayers() do
        if v12.Character then
            table.insert(v11, v12.Character);
        end;
    end;
    u10.FilterDescendantsInstances = v11;
end;
l__Players__4.PlayerAdded:Connect(u13);
l__Players__4.PlayerRemoving:Connect(u13);
task.spawn(function() --[[ Line: 52 ]]
    -- upvalues: u13 (copy)
    while true do
        u13();
        task.wait(5);
    end;
end);
function u1.GetPlantFromFruit(_, p14) --[[ Line: 59 ]]
    local l__Parent__7 = p14.Parent;
    if l__Parent__7 and (not l__Parent__7 or l__Parent__7.Name == "Fruits") then
        return l__Parent__7.Parent;
    end;
end;
function u1.UpdateAppearance(_, p15, p16) --[[ Line: 65 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__CollectionService__1 (copy)
    if p16 then
        local v17 = l__ReplicatedStorage__2.Assets.VFX.StatusVFX:FindFirstChild("BurningVFX");
        if v17 == nil then
        else
            for _, v18 in v17:GetChildren() do
                local v19 = v18:Clone();
                v19.Parent = p15:FindFirstChild("Torso") or p15.PrimaryPart;
                v19.Enabled = true;
                v19:AddTag("GhostPepperAppearance");
            end;
        end;
    else
        for _, v20 in l__CollectionService__1:GetTagged("GhostPepperAppearance") do
            if v20:IsDescendantOf(p15) then
                v20:RemoveTag("GhostPepperAppearance");
                if v20:IsA("ParticleEmitter") then
                    v20.Enabled = false;
                    game.Debris:AddItem(v20, 1);
                end;
            end;
        end;
    end;
end;
function u1.StartLocalBurnEffects(_) --[[ Line: 95 ]]
    -- upvalues: u5 (ref), u7 (ref), u8 (ref), l__LocalPlayer__5 (copy), u9 (ref), u6 (ref), l__RunService__3 (copy)
    if u5 then
    else
        u5 = true;
        u7 = tick();
        u8 = 0;
        local l__Character__8 = l__LocalPlayer__5.Character;
        if l__Character__8 then
            l__Character__8 = l__Character__8:FindFirstChildOfClass("Humanoid");
        end;
        if l__Character__8 then
            l__Character__8.WalkSpeed = l__Character__8.WalkSpeed + 7;
            u9 = l__Character__8;
        end;
        u6 = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 113 ]]
            -- upvalues: u7 (ref), l__LocalPlayer__5 (ref), u8 (ref)
            local v21 = tick() - u7;
            local l__Character__9 = l__LocalPlayer__5.Character;
            if l__Character__9 then
                l__Character__9 = l__Character__9:FindFirstChildOfClass("Humanoid");
            end;
            if l__Character__9 and l__Character__9.Health > 0 then
                l__Character__9.Jump = true;
            end;
            if l__Character__9 and (l__Character__9.Health > 0 and v21 - u8 >= 0.1) then
                u8 = v21;
                l__Character__9:TakeDamage(1);
            end;
        end);
    end;
end;
function u1.StopLocalBurnEffects(_) --[[ Line: 132 ]]
    -- upvalues: u5 (ref), u6 (ref), u9 (ref)
    if u5 then
        u5 = false;
        if u6 then
            u6:Disconnect();
            u6 = nil;
        end;
        if u9 and u9.Parent then
            u9.WalkSpeed = u9.WalkSpeed - 7;
        end;
        u9 = nil;
    end;
end;
l__LocalPlayer__5.CharacterAdded:Connect(function() --[[ Line: 152 ]]
    -- upvalues: u5 (ref), u6 (ref), u9 (ref)
    if u5 then
        u5 = false;
        if u6 then
            u6:Disconnect();
            u6 = nil;
        end;
        u9 = nil;
    end;
end);
function u1.StartOrRefreshBurn(_, u22, p23) --[[ Line: 165 ]]
    -- upvalues: u3 (copy), u1 (copy), l__LocalPlayer__5 (copy), l__Networking__6 (copy), u4 (copy)
    if table.find(u3, u22) == nil then
        table.insert(u3, u22);
        u1:UpdateAppearance(u22.Character, true);
        if u22 == l__LocalPlayer__5 then
            u1:StartLocalBurnEffects();
        end;
        if p23 then
            l__Networking__6.GhostPepperService.TouchBegan:Fire(u22.Character, p23);
        end;
    end;
    local u24 = {};
    u4[u22] = u24;
    task.delay(5, function() --[[ Line: 185 ]]
        -- upvalues: u4 (ref), u22 (copy), u24 (copy), u1 (ref)
        if u4[u22] == u24 then
            u4[u22] = nil;
            u1:EndBurn(u22);
        end;
    end);
end;
function u1.EndBurn(_, p25) --[[ Line: 194 ]]
    -- upvalues: u3 (copy), u1 (copy), l__LocalPlayer__5 (copy), l__Networking__6 (copy)
    local v26 = table.find(u3, p25);
    if v26 then
        table.remove(u3, v26);
        if p25.Character then
            u1:UpdateAppearance(p25.Character, false);
        end;
        if p25 == l__LocalPlayer__5 then
            u1:StopLocalBurnEffects();
        end;
        l__Networking__6.GhostPepperService.TouchEnded:Fire(p25.Character);
    end;
end;
function u1.RegisterPoisonObject(_, p27) --[[ Line: 211 ]]
    -- upvalues: u2 (copy)
    table.insert(u2, {
        Object = p27
    });
end;
function u1.UnregisterPoisonObject(_, p28) --[[ Line: 217 ]]
    -- upvalues: u2 (copy)
    for v29, v30 in u2 do
        if v30.Object == p28 then
            table.remove(u2, v29);
            return;
        end;
    end;
end;
function u1.GetTouchingParts(_, p31) --[[ Line: 226 ]]
    -- upvalues: l__Players__4 (copy), u10 (copy), u1 (copy), l__LocalPlayer__5 (copy)
    local l__Position__10 = p31.Position;
    local v32 = false;
    for _, v33 in l__Players__4:GetPlayers() do
        local l__Character__11 = v33.Character;
        if l__Character__11 then
            l__Character__11 = l__Character__11:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__11 and (l__Character__11.Position - l__Position__10).Magnitude < 30 then
            v32 = true;
            break;
        end;
    end;
    if v32 then
        local v34 = workspace:GetPartsInPart(p31, u10);
        if #v34 == 0 then
        else
            local v35 = {};
            for _, v36 in v34 do
                if v36.Parent then
                    local v37 = v36:FindFirstAncestorWhichIsA("Model");
                    local v38;
                    if v37 then
                        v38 = l__Players__4:GetPlayerFromCharacter(v37);
                    else
                        v38 = nil;
                    end;
                    if v38 and not v35[v38] then
                        local v39 = u1:GetPlantFromFruit(p31.Parent);
                        if v39 then
                            local v40 = v39:GetAttribute("UserId");
                            if v40 and (not v40 or v40 ~= l__LocalPlayer__5.UserId) then
                                v35[v38] = true;
                                local v41;
                                if p31.Parent then
                                    v41 = p31.Parent:GetAttribute("FruitId") or nil;
                                else
                                    v41 = nil;
                                end;
                                u1:StartOrRefreshBurn(v38, v41);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function u1.Routine(_) --[[ Line: 264 ]]
    -- upvalues: u2 (copy), u1 (copy)
    for _, v42 in u2 do
        u1:GetTouchingParts(v42.Object);
    end;
end;
function u1.Init(_) --[[ Line: 273 ]]
    -- upvalues: l__CollectionService__1 (copy), u1 (copy)
    for _, v43 in l__CollectionService__1:GetTagged("GhostPepper") do
        u1:RegisterPoisonObject(v43);
    end;
    l__CollectionService__1:GetInstanceAddedSignal("GhostPepper"):Connect(function(p44) --[[ Line: 278 ]]
        -- upvalues: u1 (ref)
        u1:RegisterPoisonObject(p44);
    end);
    l__CollectionService__1:GetInstanceRemovedSignal("GhostPepper"):Connect(function(p45) --[[ Line: 282 ]]
        -- upvalues: u1 (ref)
        u1:UnregisterPoisonObject(p45);
    end);
    task.spawn(function() --[[ Line: 286 ]]
        -- upvalues: u1 (ref)
        while true do
            u1:Routine();
            task.wait(0.5);
        end;
    end);
end;
return u1;