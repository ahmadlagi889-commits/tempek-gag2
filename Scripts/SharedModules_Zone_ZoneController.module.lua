-- Decompiled with Potassium's decompiler.

local l__Janitor__1 = require(script.Parent.Janitor);
local l__Enum__2 = require(script.Parent.Enum);
require(script.Parent.Signal);
local l__Tracker__3 = require(script.Tracker);
local l__CollectiveWorldModel__4 = require(script.CollectiveWorldModel);
local l__enums__5 = l__Enum__2.enums;
local l__Players__6 = game:GetService("Players");
local u1 = {};
local u2 = 0;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = 0;
local l__RunService__7 = game:GetService("RunService");
local l__Heartbeat__8 = l__RunService__7.Heartbeat;
local u10 = {};
local u11 = l__RunService__7:IsClient();
if u11 then
    u11 = l__Players__6.LocalPlayer;
end;
local u12 = {};
local u13 = {
    player = l__Tracker__3.new("player"),
    item = l__Tracker__3.new("item")
};
u12.trackers = u13;
local u23 = {
    player = function(p14) --[[ Line: 59 ]]
        -- upvalues: u12 (copy), u1 (copy), u2 (ref)
        return u12._getZonesAndItems("player", u1, u2, true, p14);
    end,
    localPlayer = function(p15) --[[ Line: 62 ]]
        -- upvalues: u11 (copy), u12 (copy), u13 (copy)
        local v16 = {};
        local l__Character__9 = u11.Character;
        if not l__Character__9 then
            return v16;
        end;
        local v17 = u12.getTouchingZones(l__Character__9, true, p15, u13.player);
        for _, v18 in pairs(v17) do
            if v18.activeTriggers.localPlayer then
                local v19 = u11;
                local v20 = v16[v18];
                if not v20 then
                    v20 = {};
                    v16[v18] = v20;
                end;
                local v21 = v19:IsA("Player");
                if v21 then
                    v21 = v19.Character;
                end;
                v20[v19] = v21 or true;
            end;
        end;
        return v16;
    end,
    item = function(p22) --[[ Line: 76 ]]
        -- upvalues: u12 (copy), u1 (copy), u2 (ref)
        return u12._getZonesAndItems("item", u1, u2, true, p22);
    end
};
function u12._registerZone(p24) --[[ Line: 84 ]]
    -- upvalues: u4 (copy), l__Janitor__1 (copy), u12 (copy)
    u4[p24] = true;
    local v25 = p24.janitor:add(l__Janitor__1.new(), "destroy");
    p24._registeredJanitor = v25;
    v25:add(p24.updated:Connect(function() --[[ Line: 88 ]]
        -- upvalues: u12 (ref)
        u12._updateZoneDetails();
    end), "Disconnect");
    u12._updateZoneDetails();
end;
function u12._deregisterZone(p26) --[[ Line: 94 ]]
    -- upvalues: u4 (copy), u12 (copy)
    u4[p26] = nil;
    p26._registeredJanitor:destroy();
    p26._registeredJanitor = nil;
    u12._updateZoneDetails();
end;
function u12._registerConnection(p27, p28) --[[ Line: 101 ]]
    -- upvalues: u9 (ref), u1 (copy), u12 (copy), u3 (copy), u23 (copy)
    local v29 = 0;
    for _, _ in pairs(p27.activeTriggers) do
        v29 = v29 + 1;
    end;
    u9 = u9 + 1;
    if v29 == 0 then
        u1[p27] = true;
        u12._updateZoneDetails();
    end;
    local v30 = u3[p28];
    u3[p28] = v30 and v30 + 1 or 1;
    p27.activeTriggers[p28] = true;
    if p27.touchedConnectionActions[p28] then
        p27:_formTouchedConnection(p28);
    end;
    if u23[p28] then
        u12._formHeartbeat(p28);
    end;
end;
function u12.updateDetection(p31) --[[ Line: 121 ]]
    -- upvalues: l__Tracker__3 (copy), l__enums__5 (copy)
    for v32, v33 in pairs({
        enterDetection = "_currentEnterDetection",
        exitDetection = "_currentExitDetection"
    }) do
        local v34 = p31[v32];
        local v35 = l__Tracker__3.getCombinedTotalVolumes();
        if v34 == l__enums__5.Detection.Automatic then
            if v35 > 729000 then
                v34 = l__enums__5.Detection.Centre;
            else
                v34 = l__enums__5.Detection.WholeBody;
            end;
        end;
        p31[v33] = v34;
    end;
end;
function u12._formHeartbeat(u36) --[[ Line: 140 ]]
    -- upvalues: u10 (copy), l__Heartbeat__8 (copy), u1 (copy), u12 (copy), u23 (copy), l__enums__5 (copy)
    if u10[u36] then
    else
        local u37 = 0;
        u10[u36] = l__Heartbeat__8:Connect(function() --[[ Line: 150 ]]
            -- upvalues: u37 (ref), u1 (ref), u36 (copy), u12 (ref), u23 (ref), l__enums__5 (ref)
            local v38 = os.clock();
            if u37 <= v38 then
                local v39 = nil;
                local v40 = nil;
                for v41, _ in pairs(u1) do
                    if v41.activeTriggers[u36] then
                        local l__accuracy__10 = v41.accuracy;
                        if v39 ~= nil and l__accuracy__10 >= v39 then
                            l__accuracy__10 = v39;
                        end;
                        u12.updateDetection(v41);
                        local l___currentEnterDetection__11 = v41._currentEnterDetection;
                        if v40 == nil or l___currentEnterDetection__11 < v40 then
                            v40 = l___currentEnterDetection__11;
                            v39 = l__accuracy__10;
                        else
                            v39 = l__accuracy__10;
                        end;
                    end;
                end;
                local v42 = u23[u36](v40);
                local v43 = {};
                local v44 = {};
                for v45, v46 in pairs(v42) do
                    local l__settingsGroupName__12 = v45.settingsGroupName;
                    if l__settingsGroupName__12 then
                        l__settingsGroupName__12 = u12.getGroup(v45.settingsGroupName);
                    end;
                    if l__settingsGroupName__12 and l__settingsGroupName__12.onlyEnterOnceExitedAll == true then
                        for v47, _ in pairs(v46) do
                            local v48 = v43[v45.settingsGroupName];
                            if not v48 then
                                v48 = {};
                                v43[v45.settingsGroupName] = v48;
                            end;
                            v48[v47] = v45;
                        end;
                        v44[v45] = v46;
                    end;
                end;
                for v49, v50 in pairs(v44) do
                    local v51 = v43[v49.settingsGroupName];
                    if v51 then
                        for v52, _ in pairs(v50) do
                            local v53 = v51[v52];
                            if v53 and v53 ~= v49 then
                                v50[v52] = nil;
                            end;
                        end;
                    end;
                end;
                local v54 = {
                    {},
                    {}
                };
                for v55, _ in pairs(u1) do
                    if v55.activeTriggers[u36] then
                        local l__accuracy__13 = v55.accuracy;
                        local v56 = v42[v55] or {};
                        local v57 = false;
                        for _, _ in pairs(v56) do
                            v57 = true;
                            break;
                        end;
                        if v57 then
                            if v39 >= l__accuracy__13 then
                                l__accuracy__13 = v39;
                            end;
                        else
                            l__accuracy__13 = v39;
                        end;
                        local v58 = v55:_updateOccupants(u36, v56);
                        v54[1][v55] = v58.exited;
                        v54[2][v55] = v58.entered;
                        v39 = l__accuracy__13;
                    end;
                end;
                local v59 = { "Exited", "Entered" };
                for v60, v61 in pairs(v54) do
                    local v62 = u36 .. v59[v60];
                    for v63, v64 in pairs(v61) do
                        local v65 = v63[v62];
                        if v65 then
                            for _, v66 in pairs(v64) do
                                v65:Fire(v66);
                            end;
                        end;
                    end;
                end;
                u37 = v38 + l__enums__5.Accuracy.getProperty(v39);
            end;
        end);
    end;
end;
function u12._deregisterConnection(p67, p68) --[[ Line: 249 ]]
    -- upvalues: u9 (ref), u3 (copy), u10 (copy), u1 (copy), u12 (copy)
    u9 = u9 - 1;
    if u3[p68] == 1 then
        u3[p68] = nil;
        local v69 = u10[p68];
        if v69 then
            u10[p68] = nil;
            v69:Disconnect();
        end;
    else
        local v70 = u3;
        v70[p68] = v70[p68] - 1;
    end;
    p67.activeTriggers[p68] = nil;
    local v71 = 0;
    for _, _ in pairs(p67.activeTriggers) do
        v71 = v71 + 1;
    end;
    if v71 == 0 then
        u1[p67] = nil;
        u12._updateZoneDetails();
    end;
    if p67.touchedConnectionActions[p68] then
        p67:_disconnectTouchedConnection(p68);
    end;
end;
function u12._updateZoneDetails() --[[ Line: 271 ]]
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u2 (ref), u4 (copy), u1 (copy)
    u5 = {};
    u6 = {};
    u7 = {};
    u8 = {};
    u2 = 0;
    for v72, _ in pairs(u4) do
        local v73 = u1[v72];
        if v73 then
            u2 = u2 + v72.volume;
        end;
        for _, v74 in pairs(v72.zoneParts) do
            if v73 then
                table.insert(u5, v74);
                u6[v74] = v72;
            end;
            table.insert(u7, v74);
            u8[v74] = v72;
        end;
    end;
end;
function u12._getZonesAndItems(p75, p76, p77, p78, p79) --[[ Line: 293 ]]
    -- upvalues: u13 (copy), u12 (copy), l__Players__6 (copy), l__CollectiveWorldModel__4 (copy)
    if not p77 then
        for v80, _ in pairs(p76) do
            p77 = p77 + v80.volume;
        end;
    end;
    local v81 = {};
    local v82 = u13[p75];
    if v82.totalVolume < p77 then
        for _, v83 in pairs(v82.items) do
            local v84 = u12.getTouchingZones(v83, p78, p79, v82);
            for _, v85 in pairs(v84) do
                if not p78 or v85.activeTriggers[p75] then
                    local v86;
                    if p75 == "player" then
                        v86 = l__Players__6:GetPlayerFromCharacter(v83);
                    else
                        v86 = v83;
                    end;
                    if v86 then
                        local v87 = v81[v85];
                        if not v87 then
                            v87 = {};
                            v81[v85] = v87;
                        end;
                        local v88 = v86:IsA("Player");
                        if v88 then
                            v88 = v86.Character;
                        end;
                        v87[v86] = v88 or true;
                    end;
                end;
            end;
        end;
        return v81;
    else
        for v89, _ in pairs(p76) do
            if not p78 or v89.activeTriggers[p75] then
                local v90 = l__CollectiveWorldModel__4:GetPartBoundsInBox(v89.region.CFrame, v89.region.Size, v82.whitelistParams);
                local v91 = {};
                for _, v92 in pairs(v90) do
                    local v93 = v82.partToItem[v92];
                    if not v91[v93] then
                        v91[v93] = true;
                    end;
                end;
                for v94, _ in pairs(v91) do
                    if p75 == "player" then
                        local v95 = l__Players__6:GetPlayerFromCharacter(v94);
                        if v89:findPlayer(v95) then
                            local v96 = v81[v89];
                            if not v96 then
                                v96 = {};
                                v81[v89] = v96;
                            end;
                            local v97 = v95:IsA("Player");
                            if v97 then
                                v97 = v95.Character;
                            end;
                            v96[v95] = v97 or true;
                        end;
                    elseif v89:findItem(v94) then
                        local v98 = v81[v89];
                        if not v98 then
                            v98 = {};
                            v81[v89] = v98;
                        end;
                        local v99 = v94:IsA("Player");
                        if v99 then
                            v99 = v94.Character;
                        end;
                        v98[v94] = v99 or true;
                    end;
                end;
            end;
        end;
        return v81;
    end;
end;
function u12.getZones() --[[ Line: 354 ]]
    -- upvalues: u4 (copy)
    local v100 = {};
    for v101, _ in pairs(u4) do
        table.insert(v100, v101);
    end;
    return v100;
end;
function u12.getTouchingZones(p102, p103, p104, p105) --[[ Line: 374 ]]
    -- upvalues: l__enums__5 (copy), l__Tracker__3 (copy), u5 (ref), u7 (ref), u6 (ref), u8 (ref), l__CollectiveWorldModel__4 (copy)
    local v106;
    if p105 then
        v106 = p105.exitDetections[p102];
        p105.exitDetections[p102] = nil;
    else
        v106 = nil;
    end;
    local v107 = v106 or p104;
    local v108 = nil;
    local v109 = nil;
    local v110 = p102:IsA("BasePart");
    local v111 = not v110;
    local v112 = {};
    if v110 then
        v108 = p102.Size;
        v109 = p102.CFrame;
        table.insert(v112, p102);
    elseif v107 == l__enums__5.Detection.WholeBody then
        v108, v109 = l__Tracker__3.getCharacterSize(p102);
        v112 = p102:GetChildren();
    else
        local v113 = p102:FindFirstChild("HumanoidRootPart");
        if v113 then
            v108 = v113.Size;
            v109 = v113.CFrame;
            table.insert(v112, v113);
        end;
    end;
    if not (v108 and v109) then
        return {};
    end;
    local v114 = p103 and u5 or u7;
    local v115 = p103 and u6 or u8;
    local v116 = OverlapParams.new();
    v116.FilterType = Enum.RaycastFilterType.Whitelist;
    v116.MaxParts = #v114;
    v116.FilterDescendantsInstances = v114;
    local v117 = l__CollectiveWorldModel__4:GetPartBoundsInBox(v109, v108, v116);
    local v118 = {};
    local v119 = {};
    local v120 = {};
    for _, v121 in pairs(v117) do
        local v122 = v115[v121];
        if v122 and v122.allZonePartsAreBlocks then
            v118[v122] = true;
            v119[v121] = v122;
        else
            table.insert(v120, v121);
        end;
    end;
    local v123 = #v120;
    local v124 = 0;
    if v123 > 0 then
        local v125 = OverlapParams.new();
        v125.FilterType = Enum.RaycastFilterType.Whitelist;
        v125.MaxParts = v123;
        v125.FilterDescendantsInstances = v120;
        for _, v126 in pairs(v112) do
            local v127 = false;
            if v126:IsA("BasePart") and not (v111 and l__Tracker__3.bodyPartsToIgnore[v126.Name]) then
                local v128 = l__CollectiveWorldModel__4:GetPartsInPart(v126, v125);
                for _, v129 in pairs(v128) do
                    if not v119[v129] then
                        local v130 = v115[v129];
                        if v130 then
                            v118[v130] = true;
                            v119[v129] = v130;
                            v124 = v124 + 1;
                        end;
                        if v124 == v123 then
                            v127 = true;
                            break;
                        end;
                    end;
                end;
                if v127 then
                    break;
                end;
            end;
        end;
    end;
    local v131 = nil;
    local v132 = {};
    for v133, _ in pairs(v118) do
        if v131 == nil or v133._currentExitDetection < v131 then
            v131 = v133._currentExitDetection;
        end;
        table.insert(v132, v133);
    end;
    if v131 and p105 then
        p105.exitDetections[p102] = v131;
    end;
    return v132, v119;
end;
local u134 = {};
function u12.setGroup(p135, p136) --[[ Line: 491 ]]
    -- upvalues: u134 (copy)
    local v137 = u134[p135];
    if not v137 then
        v137 = {};
        u134[p135] = v137;
    end;
    v137.onlyEnterOnceExitedAll = true;
    v137._name = p135;
    v137._memberZones = {};
    if typeof(p136) == "table" then
        for v138, v139 in pairs(p136) do
            v137[v138] = v139;
        end;
    end;
    return v137;
end;
function u12.getGroup(p140) --[[ Line: 515 ]]
    -- upvalues: u134 (copy)
    return u134[p140];
end;
local u141 = nil;
local u142 = string.format("ZonePlus%sContainer", l__RunService__7:IsClient() and "Client" or "Server");
function u12.getWorkspaceContainer() --[[ Line: 521 ]]
    -- upvalues: u141 (ref), u142 (copy)
    local v143 = u141 or workspace:FindFirstChild(u142);
    if not v143 then
        v143 = Instance.new("Folder");
        v143.Name = u142;
        v143.Parent = workspace;
        u141 = v143;
    end;
    return v143;
end;
return u12;