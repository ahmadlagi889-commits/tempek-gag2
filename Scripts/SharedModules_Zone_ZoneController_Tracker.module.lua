-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local _ = game:GetService("RunService").Heartbeat;
local l__Signal__2 = require(script.Parent.Parent.Signal);
local l__Janitor__3 = require(script.Parent.Parent.Janitor);
local u1 = {};
u1.__index = u1;
local u2 = {};
u1.trackers = u2;
u1.itemAdded = l__Signal__2.new();
u1.itemRemoved = l__Signal__2.new();
u1.bodyPartsToIgnore = {
    UpperTorso = true,
    LowerTorso = true,
    Torso = true,
    LeftHand = true,
    RightHand = true,
    LeftFoot = true,
    RightFoot = true
};
function u1.getCombinedTotalVolumes() --[[ Line: 35 ]]
    -- upvalues: u2 (copy)
    local v3 = 0;
    for v4, _ in pairs(u2) do
        v3 = v3 + v4.totalVolume;
    end;
    return v3;
end;
function u1.getCharacterSize(p5) --[[ Line: 43 ]]
    local v6;
    if p5 then
        v6 = p5:FindFirstChild("Head");
    else
        v6 = p5;
    end;
    if p5 then
        p5 = p5:FindFirstChild("HumanoidRootPart");
    end;
    if not (p5 and v6) then
        return nil;
    end;
    if not v6:IsA("BasePart") then
        v6 = p5;
    end;
    local l__Y__4 = v6.Size.Y;
    local l__Size__5 = p5.Size;
    return l__Size__5 * Vector3.new(2, 2, 1) + Vector3.new(0, l__Y__4, 0), p5.CFrame * CFrame.new(0, l__Y__4 / 2 - l__Size__5.Y / 2, 0);
end;
function u1.new(p7) --[[ Line: 60 ]]
    -- upvalues: u1 (copy), l__Janitor__3 (copy), l__Players__1 (copy), u2 (copy)
    local u8 = {};
    setmetatable(u8, u1);
    u8.name = p7;
    u8.totalVolume = 0;
    u8.parts = {};
    u8.partToItem = {};
    u8.items = {};
    u8.whitelistParams = nil;
    u8.characters = {};
    u8.baseParts = {};
    u8.exitDetections = {};
    u8.janitor = l__Janitor__3.new();
    if p7 == "player" then
        local function u11() --[[ Line: 76 ]]
            -- upvalues: l__Players__1 (ref), u8 (copy)
            local v9 = {};
            for _, v10 in pairs(l__Players__1:GetPlayers()) do
                local l__Character__6 = v10.Character;
                if l__Character__6 then
                    v9[l__Character__6] = true;
                end;
            end;
            u8.characters = v9;
        end;
        local function v17(p12) --[[ Line: 87 ]]
            -- upvalues: u11 (copy), u8 (copy)
            local function v15(p13) --[[ Line: 88 ]]
                -- upvalues: u11 (ref), u8 (ref)
                local l__Humanoid__7 = p13:WaitForChild("Humanoid", 3);
                if l__Humanoid__7 then
                    u11();
                    u8:update();
                    for _, v14 in pairs(l__Humanoid__7:GetChildren()) do
                        if v14:IsA("NumberValue") then
                            v14.Changed:Connect(function() --[[ Line: 95 ]]
                                -- upvalues: u8 (ref)
                                u8:update();
                            end);
                        end;
                    end;
                end;
            end;
            if p12.Character then
                v15(p12.Character);
            end;
            p12.CharacterAdded:Connect(v15);
            p12.CharacterRemoving:Connect(function(p16) --[[ Line: 106 ]]
                -- upvalues: u8 (ref)
                u8.exitDetections[p16] = nil;
            end);
        end;
        l__Players__1.PlayerAdded:Connect(v17);
        for _, v18 in pairs(l__Players__1:GetPlayers()) do
            v17(v18);
        end;
        l__Players__1.PlayerRemoving:Connect(function(_) --[[ Line: 116 ]]
            -- upvalues: u11 (copy), u8 (copy)
            u11();
            u8:update();
        end);
    elseif p7 == "item" then
        u1.itemAdded:Connect(function(p19) --[[ Line: 131 ]]
            -- upvalues: u8 (copy)
            if p19.isCharacter then
                u8.characters[p19.item] = true;
            elseif p19.isBasePart then
                u8.baseParts[p19.item] = true;
            end;
            u8:update();
        end);
        u1.itemRemoved:Connect(function(p20) --[[ Line: 134 ]]
            -- upvalues: u8 (copy)
            u8.exitDetections[p20.item] = nil;
            if p20.isCharacter then
                u8.characters[p20.item] = nil;
            elseif p20.isBasePart then
                u8.baseParts[p20.item] = nil;
            end;
            u8:update();
        end);
    end;
    u2[u8] = true;
    task.defer(u8.update, u8);
    return u8;
end;
function u1._preventMultiFrameUpdates(u21, u22, ...) --[[ Line: 148 ]]
    u21._preventMultiDetails = u21._preventMultiDetails or {};
    local u23 = u21._preventMultiDetails[u22];
    if not u23 then
        u23 = {
            calling = false,
            callsThisFrame = 0,
            updatedThisFrame = false
        };
        u21._preventMultiDetails[u22] = u23;
    end;
    u23.callsThisFrame = u23.callsThisFrame + 1;
    if u23.callsThisFrame ~= 1 then
        return true;
    end;
    local u24 = table.pack(...);
    task.defer(function() --[[ Line: 165 ]]
        -- upvalues: u23 (ref), u21 (copy), u22 (copy), u24 (copy)
        local l__callsThisFrame__8 = u23.callsThisFrame;
        u23.callsThisFrame = 0;
        if l__callsThisFrame__8 > 1 then
            u21[u22](u21, unpack(u24));
        end;
    end);
    return false;
end;
function u1.update(u25) --[[ Line: 177 ]]
    -- upvalues: u1 (copy), l__Janitor__3 (copy)
    if u25:_preventMultiFrameUpdates("update") then
    else
        u25.totalVolume = 0;
        u25.parts = {};
        u25.partToItem = {};
        u25.items = {};
        for u26, _ in pairs(u25.characters) do
            local v27 = u1.getCharacterSize(u26);
            if v27 then
                u25.totalVolume = u25.totalVolume + v27.X * v27.Y * v27.Z;
                local v28 = u25.janitor:add(l__Janitor__3.new(), "destroy", "trackCharacterParts-" .. u25.name);
                local u29 = v28;
                for _, u30 in pairs(u26:GetChildren()) do
                    if u30:IsA("BasePart") and not u1.bodyPartsToIgnore[u30.Name] then
                        u25.partToItem[u30] = u26;
                        table.insert(u25.parts, u30);
                        u29:add(u30.AncestryChanged:Connect(function() --[[ Line: 199 ]]
                            -- upvalues: u30 (copy), u29 (ref), u25 (copy)
                            if not u30:IsDescendantOf(game) and (u30.Parent == nil and u29 ~= nil) then
                                u29:destroy();
                                u29 = nil;
                                u25:update();
                            end;
                        end), "Disconnect");
                    end;
                end;
                u29:add(u26.AncestryChanged:Connect(function() --[[ Line: 199 ]]
                    -- upvalues: u26 (copy), u29 (ref), u25 (copy)
                    if not u26:IsDescendantOf(game) and (u26.Parent == nil and u29 ~= nil) then
                        u29:destroy();
                        u29 = nil;
                        u25:update();
                    end;
                end), "Disconnect");
                table.insert(u25.items, u26);
            end;
        end;
        for v31, _ in pairs(u25.baseParts) do
            local l__Size__9 = v31.Size;
            u25.totalVolume = u25.totalVolume + l__Size__9.X * l__Size__9.Y * l__Size__9.Z;
            u25.partToItem[v31] = v31;
            table.insert(u25.parts, v31);
            table.insert(u25.items, v31);
        end;
        u25.whitelistParams = OverlapParams.new();
        u25.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist;
        u25.whitelistParams.MaxParts = #u25.parts;
        u25.whitelistParams.FilterDescendantsInstances = u25.parts;
    end;
end;
return u1;