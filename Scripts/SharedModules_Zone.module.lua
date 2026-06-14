-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__Heartbeat__3 = l__RunService__2.Heartbeat;
local u1 = l__RunService__2:IsClient();
if u1 then
    u1 = l__Players__1.LocalPlayer;
end;
game:GetService("ReplicatedStorage");
local l__HttpService__4 = game:GetService("HttpService");
local l__enums__5 = require(script.Enum).enums;
local l__Janitor__6 = require(script.Janitor);
local l__Signal__7 = require(script.Signal);
local l__ZonePlusReference__8 = require(script.ZonePlusReference);
local v2 = l__ZonePlusReference__8.getObject();
local l__ZoneController__9 = script.ZoneController;
local l__Tracker__10 = l__ZoneController__9.Tracker;
local l__CollectiveWorldModel__11 = l__ZoneController__9.CollectiveWorldModel;
local u3 = require(l__ZoneController__9);
local v4 = game:GetService("RunService"):IsClient() and "Client" or "Server";
local v5;
if v2 then
    v5 = v2:FindFirstChild(v4);
else
    v5 = v2;
end;
if v5 then
    return require(v2.Value);
end;
local u6 = {};
u6.__index = u6;
if not v5 then
    l__ZonePlusReference__8.addToReplicatedStorage();
end;
u6.enum = l__enums__5;
function u6.new(p7) --[[ Line: 34 ]]
    -- upvalues: u6 (copy), l__enums__5 (copy), l__Janitor__6 (copy), l__HttpService__4 (copy), u3 (copy), l__Signal__7 (copy), u1 (copy)
    local u8 = {};
    setmetatable(u8, u6);
    local v9 = typeof(p7);
    if v9 ~= "table" and v9 ~= "Instance" then
        error("The zone container must be a model, folder, basepart or table!");
    end;
    u8.accuracy = l__enums__5.Accuracy.High;
    u8.autoUpdate = true;
    u8.respectUpdateQueue = true;
    local v10 = l__Janitor__6.new();
    u8.janitor = v10;
    u8._updateConnections = v10:add(l__Janitor__6.new(), "destroy");
    u8.container = p7;
    u8.zoneParts = {};
    u8.overlapParams = {};
    u8.region = nil;
    u8.volume = nil;
    u8.boundMin = nil;
    u8.boundMax = nil;
    u8.recommendedMaxParts = nil;
    u8.zoneId = l__HttpService__4:GenerateGUID();
    u8.activeTriggers = {};
    u8.occupants = {};
    u8.trackingTouchedTriggers = {};
    u8.enterDetection = l__enums__5.Detection.Centre;
    u8.exitDetection = l__enums__5.Detection.Centre;
    u8._currentEnterDetection = nil;
    u8._currentExitDetection = nil;
    u8.totalPartVolume = 0;
    u8.allZonePartsAreBlocks = true;
    u8.trackedItems = {};
    u8.settingsGroupName = nil;
    u8.worldModel = workspace;
    u8.onItemDetails = {};
    u8.itemsToUntrack = {};
    u3.updateDetection(u8);
    u8.updated = v10:add(l__Signal__7.new(), "destroy");
    local v11 = {
        "player",
        "part",
        "localPlayer",
        "item"
    };
    local v12 = { "entered", "exited" };
    for _, u13 in pairs(v11) do
        local u14 = 0;
        local u15 = 0;
        for _, v16 in pairs(v12) do
            local v17 = v10:add(l__Signal__7.new(true), "destroy");
            local u18 = v16:sub(1, 1):upper() .. v16:sub(2);
            u8[u13 .. u18] = v17;
            v17.connectionsChanged:Connect(function(p19) --[[ Line: 105 ]]
                -- upvalues: u13 (copy), u1 (ref), u18 (copy), u14 (ref), u15 (ref), u3 (ref), u8 (copy)
                if u13 == "localPlayer" and (not u1 and p19 == 1) then
                    error(("Can only connect to \'localPlayer%s\' on the client!"):format(u18));
                end;
                u14 = u15;
                u15 = u15 + p19;
                if u14 == 0 and u15 > 0 then
                    u3._registerConnection(u8, u13, u18);
                else
                    if u14 > 0 and u15 == 0 then
                        u3._deregisterConnection(u8, u13);
                    end;
                end;
            end);
        end;
    end;
    u6.touchedConnectionActions = {};
    for _, v20 in pairs(v11) do
        local u21 = u8[("_%sTouchedZone"):format(v20)];
        if u21 then
            u8.trackingTouchedTriggers[v20] = {};
            u6.touchedConnectionActions[v20] = function(p22) --[[ Line: 129 ]]
                -- upvalues: u21 (copy), u8 (copy)
                u21(u8, p22);
            end;
        end;
    end;
    u8:_update();
    u3._registerZone(u8);
    v10:add(function() --[[ Line: 140 ]]
        -- upvalues: u3 (ref), u8 (copy)
        u3._deregisterZone(u8);
    end, true);
    return u8;
end;
function u6.fromRegion(p23, p24) --[[ Line: 147 ]]
    -- upvalues: u6 (copy)
    local u25 = Instance.new("Model");
    local function u31(p26, p27) --[[ Line: 150 ]]
        -- upvalues: u31 (copy), u25 (copy)
        if p27.X > 2024 or (p27.Y > 2024 or p27.Z > 2024) then
            local v28 = p27 * 0.25;
            local v29 = p27 * 0.5;
            u31(p26 * CFrame.new(-v28.X, -v28.Y, -v28.Z), v29);
            u31(p26 * CFrame.new(-v28.X, -v28.Y, v28.Z), v29);
            u31(p26 * CFrame.new(-v28.X, v28.Y, -v28.Z), v29);
            u31(p26 * CFrame.new(-v28.X, v28.Y, v28.Z), v29);
            u31(p26 * CFrame.new(v28.X, -v28.Y, -v28.Z), v29);
            u31(p26 * CFrame.new(v28.X, -v28.Y, v28.Z), v29);
            u31(p26 * CFrame.new(v28.X, v28.Y, -v28.Z), v29);
            u31(p26 * CFrame.new(v28.X, v28.Y, v28.Z), v29);
        else
            local v30 = Instance.new("Part");
            v30.CFrame = p26;
            v30.Size = p27;
            v30.Anchored = true;
            v30.Parent = u25;
        end;
    end;
    u31(p23, p24);
    local v32 = u6.new(u25);
    v32:relocate();
    return v32;
end;
function u6._calculateRegion(_, p33, p34) --[[ Line: 179 ]]
    local v35 = {
        Min = {},
        Max = {}
    };
    for u36, v37 in pairs(v35) do
        v37.Values = {};
        function v37.parseCheck(p38, p39) --[[ Line: 183 ]]
            -- upvalues: u36 (copy)
            if u36 == "Min" then
                return p38 <= p39;
            end;
            if u36 == "Max" then
                return p39 <= p38;
            end;
        end;
        function v37.parse(p40, p41) --[[ Line: 190 ]]
            for v42, v43 in pairs(p41) do
                if p40.parseCheck(v43, p40.Values[v42] or v43) then
                    p40.Values[v42] = v43;
                end;
            end;
        end;
    end;
    for _, v44 in pairs(p33) do
        local v45 = v44.Size * 0.5;
        local v46 = {
            v44.CFrame * CFrame.new(-v45.X, -v45.Y, -v45.Z),
            v44.CFrame * CFrame.new(-v45.X, -v45.Y, v45.Z),
            v44.CFrame * CFrame.new(-v45.X, v45.Y, -v45.Z),
            v44.CFrame * CFrame.new(-v45.X, v45.Y, v45.Z),
            v44.CFrame * CFrame.new(v45.X, -v45.Y, -v45.Z),
            v44.CFrame * CFrame.new(v45.X, -v45.Y, v45.Z),
            v44.CFrame * CFrame.new(v45.X, v45.Y, -v45.Z),
            v44.CFrame * CFrame.new(v45.X, v45.Y, v45.Z)
        };
        for _, v47 in pairs(v46) do
            local v48, v49, v50 = v47:GetComponents();
            local v51 = { v48, v49, v50 };
            v35.Min:parse(v51);
            v35.Max:parse(v51);
        end;
    end;
    local v52 = {};
    local v53 = {};
    for v54, v55 in pairs(v35) do
        for _, v58 in pairs(v55.Values) do
            local v57 = v54 == "Min" and v53 and v53 or v52;
            if not p34 then
                local v58 = math.floor((v58 + (v54 == "Min" and -2 or 2) + 2) / 4) * 4;
            end;
            table.insert(v57, v58);
        end;
    end;
    local v59 = Vector3.new(unpack(v53));
    local v60 = Vector3.new(unpack(v52));
    return Region3.new(v59, v60), v59, v60;
end;
function u6._displayBounds(p61) --[[ Line: 245 ]]
    if not p61.displayBoundParts then
        p61.displayBoundParts = true;
        for v62, v63 in pairs({
            BoundMin = p61.boundMin,
            BoundMax = p61.boundMax
        }) do
            local v64 = Instance.new("Part");
            v64.Anchored = true;
            v64.CanCollide = false;
            v64.Transparency = 0.5;
            v64.Size = Vector3.new(1, 1, 1);
            v64.Color = Color3.fromRGB(255, 0, 0);
            v64.CFrame = CFrame.new(v63);
            v64.Name = v62;
            v64.Parent = workspace;
            p61.janitor:add(v64, "Destroy");
        end;
    end;
end;
function u6._update(u65) --[[ Line: 264 ]]
    -- upvalues: l__RunService__2 (copy)
    local l__container__12 = u65.container;
    local v66 = {};
    local u67 = 0;
    u65._updateConnections:clean();
    local v68 = typeof(l__container__12);
    local v69 = {};
    if v68 == "table" then
        for _, v70 in pairs(l__container__12) do
            if v70:IsA("BasePart") then
                table.insert(v66, v70);
            end;
        end;
    elseif v68 == "Instance" then
        if l__container__12:IsA("BasePart") then
            table.insert(v66, l__container__12);
        else
            table.insert(v69, l__container__12);
            for _, v71 in pairs(l__container__12:GetDescendants()) do
                if v71:IsA("BasePart") then
                    table.insert(v66, v71);
                else
                    table.insert(v69, v71);
                end;
            end;
        end;
    end;
    u65.zoneParts = v66;
    u65.overlapParams = {};
    local v72 = true;
    for _, u73 in pairs(v66) do
        local _, v74 = pcall(function() --[[ Line: 298 ]]
            -- upvalues: u73 (copy)
            return u73.Shape.Name;
        end);
        if v74 ~= "Block" then
            v72 = false;
        end;
    end;
    u65.allZonePartsAreBlocks = v72;
    local v75 = OverlapParams.new();
    v75.FilterType = Enum.RaycastFilterType.Whitelist;
    v75.MaxParts = #v66;
    v75.FilterDescendantsInstances = v66;
    u65.overlapParams.zonePartsWhitelist = v75;
    local v76 = OverlapParams.new();
    v76.FilterType = Enum.RaycastFilterType.Blacklist;
    v76.FilterDescendantsInstances = v66;
    u65.overlapParams.zonePartsIgnorelist = v76;
    local function v79() --[[ Line: 318 ]]
        -- upvalues: u65 (copy), u67 (ref), l__RunService__2 (ref)
        if u65.autoUpdate then
            local u77 = os.clock();
            if u65.respectUpdateQueue then
                u67 = u67 + 1;
                u77 = u77 + 0.1;
            end;
            local u78 = nil;
            u78 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 326 ]]
                -- upvalues: u77 (ref), u78 (ref), u65 (ref), u67 (ref)
                if u77 <= os.clock() then
                    u78:Disconnect();
                    if u65.respectUpdateQueue then
                        u67 = u67 - 1;
                    end;
                    if u67 == 0 and u65.zoneId then
                        u65:_update();
                    end;
                end;
            end);
        end;
    end;
    local v80 = { "Size", "Position" };
    for _, u81 in pairs(v66) do
        for _, v82 in pairs(v80) do
            u65._updateConnections:add(u81:GetPropertyChangedSignal(v82):Connect(v79), "Disconnect");
        end;
        if u81.CollisionGroupId ~= 0 then
            error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.");
        end;
        u65._updateConnections:add(u81:GetPropertyChangedSignal("CollisionGroupId"):Connect(function() --[[ Line: 350 ]]
            -- upvalues: u81 (copy)
            if u81.CollisionGroupId ~= 0 then
                error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.");
            end;
        end), "Disconnect");
    end;
    local v83 = { "ChildAdded", "ChildRemoved" };
    for _, _ in pairs(v69) do
        for _, v84 in pairs(v83) do
            u65._updateConnections:add(u65.container[v84]:Connect(function(p85) --[[ Line: 357 ]]
                -- upvalues: u65 (copy), u67 (ref), l__RunService__2 (ref)
                if p85:IsA("BasePart") and u65.autoUpdate then
                    local u86 = os.clock();
                    if u65.respectUpdateQueue then
                        u67 = u67 + 1;
                        u86 = u86 + 0.1;
                    end;
                    local u87 = nil;
                    u87 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 326 ]]
                        -- upvalues: u86 (ref), u87 (ref), u65 (ref), u67 (ref)
                        if u86 <= os.clock() then
                            u87:Disconnect();
                            if u65.respectUpdateQueue then
                                u67 = u67 - 1;
                            end;
                            if u67 == 0 and u65.zoneId then
                                u65:_update();
                            end;
                        end;
                    end);
                end;
            end), "Disconnect");
        end;
    end;
    local v88, v89, v90 = u65:_calculateRegion(v66);
    local v91, _, _ = u65:_calculateRegion(v66, true);
    u65.region = v88;
    u65.exactRegion = v91;
    u65.boundMin = v89;
    u65.boundMax = v90;
    local l__Size__13 = v88.Size;
    u65.volume = l__Size__13.X * l__Size__13.Y * l__Size__13.Z;
    u65:_updateTouchedConnections();
    u65.updated:Fire();
end;
function u6._updateOccupants(p92, p93, p94) --[[ Line: 393 ]]
    local v95 = p92.occupants[p93];
    if not v95 then
        v95 = {};
        p92.occupants[p93] = v95;
    end;
    local v96 = {};
    for v97, v98 in pairs(v95) do
        local v99 = p94[v97];
        if v99 == nil or v99 ~= v98 then
            v95[v97] = nil;
            if not v96.exited then
                v96.exited = {};
            end;
            table.insert(v96.exited, v97);
        end;
    end;
    for v100, _ in pairs(p94) do
        if v95[v100] == nil then
            v95[v100] = v100:IsA("Player") and (v100.Character or true) or true;
            if not v96.entered then
                v96.entered = {};
            end;
            table.insert(v96.entered, v100);
        end;
    end;
    return v96;
end;
function u6._formTouchedConnection(p101, p102) --[[ Line: 423 ]]
    -- upvalues: l__Janitor__6 (copy)
    local v103 = "_touchedJanitor" .. p102;
    local v104 = p101[v103];
    if v104 then
        v104:clean();
    else
        p101[v103] = p101.janitor:add(l__Janitor__6.new(), "destroy");
    end;
    p101:_updateTouchedConnection(p102);
end;
function u6._updateTouchedConnection(p105, p106) --[[ Line: 435 ]]
    local v107 = p105["_touchedJanitor" .. p106];
    if v107 then
        for _, v108 in pairs(p105.zoneParts) do
            v107:add(v108.Touched:Connect(p105.touchedConnectionActions[p106], p105), "Disconnect");
        end;
    end;
end;
function u6._updateTouchedConnections(p109) --[[ Line: 444 ]]
    for v110, _ in pairs(p109.touchedConnectionActions) do
        local v111 = p109["_touchedJanitor" .. v110];
        if v111 then
            v111:cleanup();
            p109:_updateTouchedConnection(v110);
        end;
    end;
end;
function u6._disconnectTouchedConnection(p112, p113) --[[ Line: 455 ]]
    local v114 = "_touchedJanitor" .. p113;
    local v115 = p112[v114];
    if v115 then
        v115:cleanup();
        p112[v114] = nil;
    end;
end;
function u6._partTouchedZone(u116, u117) --[[ Line: 467 ]]
    -- upvalues: l__Janitor__6 (copy), l__Heartbeat__3 (copy), l__enums__5 (copy)
    local l__part__14 = u116.trackingTouchedTriggers.part;
    if l__part__14[u117] then
    else
        local u118 = 0;
        local u119 = false;
        local l__Position__15 = u117.Position;
        local u120 = os.clock();
        local u121 = u116.janitor:add(l__Janitor__6.new(), "destroy");
        l__part__14[u117] = u121;
        if not ({
            Seat = true,
            VehicleSeat = true
        })[u117.ClassName] and ({
            HumanoidRootPart = true
        })[u117.Name] then
            u117.CanTouch = false;
        end;
        local u122 = math.round(u117.Size.X * u117.Size.Y * u117.Size.Z * 100000) * 0.00001;
        u116.totalPartVolume = u116.totalPartVolume + u122;
        u121:add(l__Heartbeat__3:Connect(function() --[[ Line: 485 ]]
            -- upvalues: u118 (ref), l__enums__5 (ref), u116 (copy), u117 (copy), u119 (ref), l__Position__15 (ref), u120 (ref), u121 (copy)
            local v123 = os.clock();
            if u118 <= v123 then
                local v124 = l__enums__5.Accuracy.getProperty(u116.accuracy);
                u118 = v123 + v124;
                local v125 = u116:findPoint(u117.CFrame) or u116:findPart(u117);
                if u119 then
                    if not v125 then
                        u119 = false;
                        l__Position__15 = u117.Position;
                        u120 = os.clock();
                        u116.partExited:Fire(u117);
                    end;
                else
                    if v125 then
                        u119 = true;
                        u116.partEntered:Fire(u117);
                        return;
                    end;
                    if (u117.Position - l__Position__15).Magnitude > 1.5 and v124 <= v123 - u120 then
                        u121:cleanup();
                    end;
                end;
            end;
        end), "Disconnect");
        u121:add(function() --[[ Line: 516 ]]
            -- upvalues: l__part__14 (copy), u117 (copy), u116 (copy), u122 (copy)
            l__part__14[u117] = nil;
            u117.CanTouch = true;
            u116.totalPartVolume = math.round((u116.totalPartVolume - u122) * 100000) * 0.00001;
        end, true);
    end;
end;
local u129 = {
    Ball = function(p126) --[[ Line: 524 ]]
        return "GetPartBoundsInRadius", { p126.Position, p126.Size.X };
    end,
    Block = function(p127) --[[ Line: 527 ]]
        return "GetPartBoundsInBox", { p127.CFrame, p127.Size };
    end,
    Other = function(p128) --[[ Line: 530 ]]
        return "GetPartsInPart", { p128 };
    end
};
function u6._getRegionConstructor(p130, u131, p132) --[[ Line: 534 ]]
    -- upvalues: u129 (copy)
    local v133, v134 = pcall(function() --[[ Line: 535 ]]
        -- upvalues: u131 (copy)
        return u131.Shape.Name;
    end);
    local v135 = nil;
    local v136 = nil;
    if v133 and p130.allZonePartsAreBlocks then
        local v137 = u129[v134];
        if v137 then
            v135, v136 = v137(u131);
        end;
    end;
    if not v135 then
        v135, v136 = u129.Other(u131);
    end;
    if p132 then
        table.insert(v136, p132);
    end;
    return v135, v136;
end;
function u6.findLocalPlayer(p138) --[[ Line: 555 ]]
    -- upvalues: u1 (copy)
    if not u1 then
        error("Can only call \'findLocalPlayer\' on the client!");
    end;
    return p138:findPlayer(u1);
end;
function u6._find(p139, p140, p141) --[[ Line: 562 ]]
    -- upvalues: u3 (copy)
    u3.updateDetection(p139);
    local v142 = u3.getTouchingZones(p141, false, p139._currentEnterDetection, u3.trackers[p140]);
    for _, v143 in pairs(v142) do
        if v143 == p139 then
            return true;
        end;
    end;
    return false;
end;
function u6.findPlayer(p144, p145) --[[ Line: 574 ]]
    local l__Character__16 = p145.Character;
    if l__Character__16 then
        l__Character__16 = l__Character__16:FindFirstChildOfClass("Humanoid");
    end;
    if l__Character__16 then
        return p144:_find("player", p145.Character);
    else
        return false;
    end;
end;
function u6.findItem(p146, p147) --[[ Line: 583 ]]
    return p146:_find("item", p147);
end;
function u6.findPart(p148, p149) --[[ Line: 587 ]]
    local v150, v151 = p148:_getRegionConstructor(p149, p148.overlapParams.zonePartsWhitelist);
    local v152 = p148.worldModel[v150](p148.worldModel, unpack(v151));
    if #v152 > 0 then
        return true, v152;
    else
        return false;
    end;
end;
function u6.getCheckerPart(p153) --[[ Line: 597 ]]
    -- upvalues: u3 (copy)
    local l__checkerPart__17 = p153.checkerPart;
    if not l__checkerPart__17 then
        l__checkerPart__17 = p153.janitor:add(Instance.new("Part"), "Destroy");
        l__checkerPart__17.Size = Vector3.new(0.1, 0.1, 0.1);
        l__checkerPart__17.Name = "ZonePlusCheckerPart";
        l__checkerPart__17.Anchored = true;
        l__checkerPart__17.Transparency = 1;
        l__checkerPart__17.CanCollide = false;
        p153.checkerPart = l__checkerPart__17;
    end;
    local l__worldModel__18 = p153.worldModel;
    if l__worldModel__18 == workspace then
        l__worldModel__18 = u3.getWorkspaceContainer();
    end;
    if l__checkerPart__17.Parent ~= l__worldModel__18 then
        l__checkerPart__17.Parent = l__worldModel__18;
    end;
    return l__checkerPart__17;
end;
function u6.findPoint(p154, p155) --[[ Line: 618 ]]
    if typeof(p155) == "Vector3" then
        p155 = CFrame.new(p155);
    end;
    local v156 = p154:getCheckerPart();
    v156.CFrame = p155;
    local v157, v158 = p154:_getRegionConstructor(v156, p154.overlapParams.zonePartsWhitelist);
    local v159 = p154.worldModel[v157](p154.worldModel, unpack(v158));
    if #v159 > 0 then
        return true, v159;
    else
        return false;
    end;
end;
function u6._getAll(p160, p161) --[[ Line: 635 ]]
    -- upvalues: u3 (copy)
    u3.updateDetection(p160);
    local v162 = {};
    local v163 = u3._getZonesAndItems(p161, {
        self = true
    }, p160.volume, false, p160._currentEnterDetection)[p160];
    if v163 then
        for v164, _ in pairs(v163) do
            table.insert(v162, v164);
        end;
    end;
    return v162;
end;
function u6.getPlayers(p165) --[[ Line: 648 ]]
    return p165:_getAll("player");
end;
function u6.getItems(p166) --[[ Line: 652 ]]
    return p166:_getAll("item");
end;
function u6.getParts(p167) --[[ Line: 656 ]]
    local v168 = {};
    if p167.activeTriggers.part then
        for v169, _ in pairs(p167.trackingTouchedTriggers.part) do
            table.insert(v168, v169);
        end;
        return v168;
    end;
    local v170 = p167.worldModel:GetPartBoundsInBox(p167.region.CFrame, p167.region.Size, p167.overlapParams.zonePartsIgnorelist);
    for _, v171 in pairs(v170) do
        if p167:findPart(v171) then
            table.insert(v168, v171);
        end;
    end;
    return v168;
end;
function u6.getRandomPoint(p172) --[[ Line: 677 ]]
    local l__exactRegion__19 = p172.exactRegion;
    local l__Size__20 = l__exactRegion__19.Size;
    local l__CFrame__21 = l__exactRegion__19.CFrame;
    local v173 = Random.new();
    local v174 = nil;
    local v175, v176;
    repeat
        v175 = l__CFrame__21 * CFrame.new(v173:NextNumber(-l__Size__20.X / 2, l__Size__20.X / 2), v173:NextNumber(-l__Size__20.Y / 2, l__Size__20.Y / 2), v173:NextNumber(-l__Size__20.Z / 2, l__Size__20.Z / 2));
        local v177;
        v177, v176 = p172:findPoint(v175);
        v174 = v177 and true or v174;
    until v174;
    return v175.Position, v176;
end;
function u6.setAccuracy(p178, p179) --[[ Line: 696 ]]
    -- upvalues: l__enums__5 (copy)
    local v180 = tonumber(p179);
    if v180 then
        if not l__enums__5.Accuracy.getName(v180) then
            error(("%s is an invalid enumId!"):format(v180));
        end;
    else
        v180 = l__enums__5.Accuracy[p179];
        if not v180 then
            error(("\'%s\' is an invalid enumName!"):format(p179));
        end;
    end;
    p178.accuracy = v180;
end;
function u6.setDetection(p181, p182) --[[ Line: 712 ]]
    -- upvalues: l__enums__5 (copy)
    local v183 = tonumber(p182);
    if v183 then
        if not l__enums__5.Detection.getName(v183) then
            error(("%s is an invalid enumId!"):format(v183));
        end;
    else
        v183 = l__enums__5.Detection[p182];
        if not v183 then
            error(("\'%s\' is an invalid enumName!"):format(p182));
        end;
    end;
    p181.enterDetection = v183;
    p181.exitDetection = v183;
end;
function u6.trackItem(u184, u185) --[[ Line: 729 ]]
    -- upvalues: l__Janitor__6 (copy), l__Tracker__10 (copy)
    local v186 = u185:IsA("BasePart");
    local v187;
    if v186 then
        v187 = false;
    else
        v187 = u185:FindFirstChildOfClass("Humanoid");
        if v187 then
            v187 = u185:FindFirstChild("HumanoidRootPart");
        end;
    end;
    assert(v186 or v187, "Only BaseParts or Characters/NPCs can be tracked!");
    if u184.trackedItems[u185] then
    else
        if u184.itemsToUntrack[u185] then
            u184.itemsToUntrack[u185] = nil;
        end;
        local v188 = u184.janitor:add(l__Janitor__6.new(), "destroy");
        local v189 = {
            janitor = v188,
            item = u185,
            isBasePart = v186,
            isCharacter = v187
        };
        u184.trackedItems[u185] = v189;
        v188:add(u185.AncestryChanged:Connect(function() --[[ Line: 754 ]]
            -- upvalues: u185 (copy), u184 (copy)
            if not u185:IsDescendantOf(game) then
                u184:untrackItem(u185);
            end;
        end), "Disconnect");
        require(l__Tracker__10).itemAdded:Fire(v189);
    end;
end;
function u6.untrackItem(p190, p191) --[[ Line: 764 ]]
    -- upvalues: l__Tracker__10 (copy)
    local v192 = p190.trackedItems[p191];
    if v192 then
        v192.janitor:destroy();
    end;
    p190.trackedItems[p191] = nil;
    require(l__Tracker__10).itemRemoved:Fire(v192);
end;
function u6.bindToGroup(p193, p194) --[[ Line: 775 ]]
    -- upvalues: u3 (copy)
    p193:unbindFromGroup();
    (u3.getGroup(p194) or u3.setGroup(p194))._memberZones[p193.zoneId] = p193;
    p193.settingsGroupName = p194;
end;
function u6.unbindFromGroup(p195) --[[ Line: 782 ]]
    -- upvalues: u3 (copy)
    if p195.settingsGroupName then
        local v196 = u3.getGroup(p195.settingsGroupName);
        if v196 then
            v196._memberZones[p195.zoneId] = nil;
        end;
        p195.settingsGroupName = nil;
    end;
end;
function u6.relocate(p197) --[[ Line: 792 ]]
    -- upvalues: l__CollectiveWorldModel__11 (copy)
    if p197.hasRelocated then
    else
        local v198 = require(l__CollectiveWorldModel__11).setupWorldModel(p197);
        p197.worldModel = v198;
        p197.hasRelocated = true;
        local l__container__22 = p197.container;
        if typeof(l__container__22) == "table" then
            l__container__22 = Instance.new("Folder");
            for _, v199 in pairs(p197.zoneParts) do
                v199.Parent = l__container__22;
            end;
        end;
        p197.relocationContainer = p197.janitor:add(l__container__22, "Destroy", "RelocationContainer");
        l__container__22.Parent = v198;
    end;
end;
function u6._onItemCallback(u200, p201, p202, u203, u204) --[[ Line: 813 ]]
    local v205 = u200.onItemDetails[u203];
    if not v205 then
        v205 = {};
        u200.onItemDetails[u203] = v205;
    end;
    if #v205 == 0 then
        u200.itemsToUntrack[u203] = true;
    end;
    table.insert(v205, u203);
    u200:trackItem(u203);
    if u200:findItem(u203) == p202 then
        u204();
        if u200.itemsToUntrack[u203] then
            u200.itemsToUntrack[u203] = nil;
            u200:untrackItem(u203);
        end;
    else
        local u206 = nil;
        u206 = u200[p201]:Connect(function(p207) --[[ Line: 838 ]]
            -- upvalues: u206 (ref), u203 (copy), u204 (copy), u200 (copy)
            if u206 and p207 == u203 then
                u206:Disconnect();
                u206 = nil;
                u204();
                if u200.itemsToUntrack[u203] then
                    u200.itemsToUntrack[u203] = nil;
                    u200:untrackItem(u203);
                end;
            end;
        end);
    end;
end;
function u6.onItemEnter(p208, ...) --[[ Line: 859 ]]
    p208:_onItemCallback("itemEntered", true, ...);
end;
function u6.onItemExit(p209, ...) --[[ Line: 863 ]]
    p209:_onItemCallback("itemExited", false, ...);
end;
function u6.destroy(p210) --[[ Line: 867 ]]
    p210:unbindFromGroup();
    p210.janitor:destroy();
end;
u6.Destroy = u6.destroy;
return u6;