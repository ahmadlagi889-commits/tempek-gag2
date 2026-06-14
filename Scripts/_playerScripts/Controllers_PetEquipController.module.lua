-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__PlayerStateClient__4 = require(l__ReplicatedStorage__2.ClientModules.PlayerStateClient);
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local u1 = {
    Raccoon = "Raccoons"
};
local u2 = {};
local function u6(p3) --[[ Line: 53 ]]
    -- upvalues: u2 (copy)
    if p3:GetAttribute("PetId") ~= nil then
        return nil;
    end;
    for _, v4 in u2 do
        local v5 = p3:GetAttribute(v4);
        if type(v5) == "string" and v5 ~= "" then
            return v5;
        end;
    end;
    return nil;
end;
local v7 = {
    StartOrder = 5
};
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = {};
local u15 = {};
function v7.Start(_) --[[ Line: 180 ]]
    -- upvalues: l__LocalPlayer__5 (copy), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u13 (ref), l__Networking__3 (copy), u1 (copy), l__PlayerStateClient__4 (copy), u14 (copy), u15 (copy), u12 (ref), u6 (copy)
    local l__EquipPet__6 = l__LocalPlayer__5:WaitForChild("PlayerGui"):WaitForChild("EquipPet", 30);
    if l__EquipPet__6 and l__EquipPet__6:IsA("ScreenGui") then
        local l__Container__7 = l__EquipPet__6:WaitForChild("Container", 10);
        if l__Container__7 and l__Container__7:IsA("GuiObject") then
            local l__EquipButton__8 = l__Container__7:WaitForChild("EquipButton", 10);
            local l__UnequipButton__9 = l__Container__7:WaitForChild("UnequipButton", 10);
            if l__EquipButton__8 and l__EquipButton__8:IsA("GuiButton") then
                if l__UnequipButton__9 and l__UnequipButton__9:IsA("GuiButton") then
                    u8 = l__EquipPet__6;
                    u9 = l__Container__7;
                    u10 = l__EquipButton__8;
                    u11 = l__UnequipButton__9;
                    l__EquipPet__6.Enabled = false;
                    l__EquipButton__8.Visible = false;
                    l__UnequipButton__9.Visible = false;
                    l__EquipButton__8.Activated:Connect(function() --[[ Line: 220 ]]
                        -- upvalues: u13 (ref), l__Networking__3 (ref)
                        if u13 then
                            l__Networking__3.Pets.RequestEquipByName:Fire(u13);
                        end;
                    end);
                    l__UnequipButton__9.Activated:Connect(function() --[[ Line: 225 ]]
                        -- upvalues: u13 (ref), l__Networking__3 (ref)
                        if u13 then
                            l__Networking__3.Pets.RequestUnequipByName:Fire(u13);
                        end;
                    end);
                    task.spawn(function() --[[ Line: 235 ]]
                        -- upvalues: l__Networking__3 (ref), u10 (ref), u13 (ref), u1 (ref), l__PlayerStateClient__4 (ref), u11 (ref), u14 (ref), u15 (ref)
                        local v16, v17 = pcall(function() --[[ Line: 236 ]]
                            -- upvalues: l__Networking__3 (ref)
                            return l__Networking__3.Pets.GetEquippedPets:Fire();
                        end);
                        if v16 and type(v17) == "table" then
                            for _, v18 in v17 do
                                if type(v18) == "table" and (type(v18.Name) == "string" and type(v18.Id) == "string") then
                                    u14[v18.Name] = (u14[v18.Name] or 0) + 1;
                                    u15[v18.Id] = v18.Name;
                                end;
                            end;
                            if u10 then
                                if u13 then
                                    local v19 = u10;
                                    local v20 = u13;
                                    local v21 = u1[v20];
                                    local v22;
                                    if v21 then
                                        local v23 = l__PlayerStateClient__4:GetLocalReplica();
                                        if v23 and v23.Data then
                                            local l__Inventory__10 = v23.Data.Inventory;
                                            if type(l__Inventory__10) == "table" then
                                                local v24 = l__Inventory__10[v21];
                                                v22 = type(v24) == "table" and (tonumber(v24[v20]) or 0) or 0;
                                            else
                                                v22 = 0;
                                            end;
                                        else
                                            v22 = 0;
                                        end;
                                    else
                                        v22 = 0;
                                    end;
                                    v19.Visible = v22 > 0;
                                else
                                    u10.Visible = false;
                                end;
                            end;
                            if u11 then
                                if u13 then
                                    local v25 = u13;
                                    local v26 = l__PlayerStateClient__4:GetLocalReplica();
                                    local v27;
                                    if v26 and v26.Data then
                                        local l__Inventory__11 = v26.Data.Inventory;
                                        if type(l__Inventory__11) == "table" then
                                            local l__Pets__12 = l__Inventory__11.Pets;
                                            v27 = type(l__Pets__12) == "table" and (tonumber(l__Pets__12[v25]) or 0) or 0;
                                        else
                                            v27 = 0;
                                        end;
                                    else
                                        v27 = 0;
                                    end;
                                    local v28 = u14[u13] or 0;
                                    if v27 > 0 then
                                        v28 = v27;
                                    end;
                                    u11.Visible = v28 > 0;
                                else
                                    u11.Visible = false;
                                end;
                            end;
                        else
                            if u10 then
                                if u13 then
                                    local v29 = u10;
                                    local v30 = u13;
                                    local v31 = u1[v30];
                                    local v32;
                                    if v31 then
                                        local v33 = l__PlayerStateClient__4:GetLocalReplica();
                                        if v33 and v33.Data then
                                            local l__Inventory__13 = v33.Data.Inventory;
                                            if type(l__Inventory__13) == "table" then
                                                local v34 = l__Inventory__13[v31];
                                                v32 = type(v34) == "table" and (tonumber(v34[v30]) or 0) or 0;
                                            else
                                                v32 = 0;
                                            end;
                                        else
                                            v32 = 0;
                                        end;
                                    else
                                        v32 = 0;
                                    end;
                                    v29.Visible = v32 > 0;
                                else
                                    u10.Visible = false;
                                end;
                            end;
                            if u11 then
                                if u13 then
                                    local v35 = u13;
                                    local v36 = l__PlayerStateClient__4:GetLocalReplica();
                                    local v37;
                                    if v36 and v36.Data then
                                        local l__Inventory__14 = v36.Data.Inventory;
                                        if type(l__Inventory__14) == "table" then
                                            local l__Pets__15 = l__Inventory__14.Pets;
                                            v37 = type(l__Pets__15) == "table" and (tonumber(l__Pets__15[v35]) or 0) or 0;
                                        else
                                            v37 = 0;
                                        end;
                                    else
                                        v37 = 0;
                                    end;
                                    local v38 = u14[u13] or 0;
                                    if v37 > 0 then
                                        v38 = v37;
                                    end;
                                    u11.Visible = v38 > 0;
                                else
                                    u11.Visible = false;
                                end;
                            end;
                        end;
                    end);
                    l__Networking__3.Pets.PetEquipped.OnClientEvent:Connect(function(p39, p40) --[[ Line: 255 ]]
                        -- upvalues: u15 (ref), u14 (ref), u10 (ref), u13 (ref), u1 (ref), l__PlayerStateClient__4 (ref), u11 (ref)
                        if type(p39) == "string" and type(p40) == "table" then
                            local l__Name__16 = p40.Name;
                            if type(l__Name__16) == "string" then
                                if not u15[p39] then
                                    u15[p39] = l__Name__16;
                                    u14[l__Name__16] = (u14[l__Name__16] or 0) + 1;
                                end;
                                if u10 then
                                    if u13 then
                                        local v41 = u10;
                                        local v42 = u13;
                                        local v43 = u1[v42];
                                        local v44;
                                        if v43 then
                                            local v45 = l__PlayerStateClient__4:GetLocalReplica();
                                            if v45 and v45.Data then
                                                local l__Inventory__17 = v45.Data.Inventory;
                                                if type(l__Inventory__17) == "table" then
                                                    local v46 = l__Inventory__17[v43];
                                                    v44 = type(v46) == "table" and (tonumber(v46[v42]) or 0) or 0;
                                                else
                                                    v44 = 0;
                                                end;
                                            else
                                                v44 = 0;
                                            end;
                                        else
                                            v44 = 0;
                                        end;
                                        v41.Visible = v44 > 0;
                                    else
                                        u10.Visible = false;
                                    end;
                                end;
                                if u11 then
                                    if u13 then
                                        local v47 = u13;
                                        local v48 = l__PlayerStateClient__4:GetLocalReplica();
                                        local v49;
                                        if v48 and v48.Data then
                                            local l__Inventory__18 = v48.Data.Inventory;
                                            if type(l__Inventory__18) == "table" then
                                                local l__Pets__19 = l__Inventory__18.Pets;
                                                v49 = type(l__Pets__19) == "table" and (tonumber(l__Pets__19[v47]) or 0) or 0;
                                            else
                                                v49 = 0;
                                            end;
                                        else
                                            v49 = 0;
                                        end;
                                        local v50 = u14[u13] or 0;
                                        if v49 > 0 then
                                            v50 = v49;
                                        end;
                                        u11.Visible = v50 > 0;
                                    else
                                        u11.Visible = false;
                                    end;
                                end;
                            end;
                        end;
                    end);
                    l__Networking__3.Pets.PetUnequipped.OnClientEvent:Connect(function(p51) --[[ Line: 269 ]]
                        -- upvalues: u15 (ref), u14 (ref), u10 (ref), u13 (ref), u1 (ref), l__PlayerStateClient__4 (ref), u11 (ref)
                        if type(p51) == "string" then
                            local v52 = u15[p51];
                            if v52 then
                                u15[p51] = nil;
                                local v53 = (u14[v52] or 0) - 1;
                                local v54 = u14;
                                if v53 <= 0 then
                                    v53 = nil;
                                end;
                                v54[v52] = v53;
                                if u10 then
                                    if u13 then
                                        local v55 = u10;
                                        local v56 = u13;
                                        local v57 = u1[v56];
                                        local v58;
                                        if v57 then
                                            local v59 = l__PlayerStateClient__4:GetLocalReplica();
                                            if v59 and v59.Data then
                                                local l__Inventory__20 = v59.Data.Inventory;
                                                if type(l__Inventory__20) == "table" then
                                                    local v60 = l__Inventory__20[v57];
                                                    v58 = type(v60) == "table" and (tonumber(v60[v56]) or 0) or 0;
                                                else
                                                    v58 = 0;
                                                end;
                                            else
                                                v58 = 0;
                                            end;
                                        else
                                            v58 = 0;
                                        end;
                                        v55.Visible = v58 > 0;
                                    else
                                        u10.Visible = false;
                                    end;
                                end;
                                if u11 then
                                    if u13 then
                                        local v61 = u13;
                                        local v62 = l__PlayerStateClient__4:GetLocalReplica();
                                        local v63;
                                        if v62 and v62.Data then
                                            local l__Inventory__21 = v62.Data.Inventory;
                                            if type(l__Inventory__21) == "table" then
                                                local l__Pets__22 = l__Inventory__21.Pets;
                                                v63 = type(l__Pets__22) == "table" and (tonumber(l__Pets__22[v61]) or 0) or 0;
                                            else
                                                v63 = 0;
                                            end;
                                        else
                                            v63 = 0;
                                        end;
                                        local v64 = u14[u13] or 0;
                                        if v63 > 0 then
                                            v64 = v63;
                                        end;
                                        u11.Visible = v64 > 0;
                                    else
                                        u11.Visible = false;
                                    end;
                                end;
                            end;
                        end;
                    end);
                    if l__PlayerStateClient__4:GetLocalReplica() then
                        local v65 = l__PlayerStateClient__4:GetLocalReplica();
                        if v65 then
                            v65:OnChange(function(_, p66) --[[ Line: 287 ]]
                                -- upvalues: u10 (ref), u13 (ref), u1 (ref), l__PlayerStateClient__4 (ref), u11 (ref), u14 (ref)
                                if type(p66) == "table" then
                                    if p66[1] == "Inventory" then
                                        if u10 then
                                            if u13 then
                                                local v67 = u10;
                                                local v68 = u13;
                                                local v69 = u1[v68];
                                                local v70;
                                                if v69 then
                                                    local v71 = l__PlayerStateClient__4:GetLocalReplica();
                                                    if v71 and v71.Data then
                                                        local l__Inventory__23 = v71.Data.Inventory;
                                                        if type(l__Inventory__23) == "table" then
                                                            local v72 = l__Inventory__23[v69];
                                                            v70 = type(v72) == "table" and (tonumber(v72[v68]) or 0) or 0;
                                                        else
                                                            v70 = 0;
                                                        end;
                                                    else
                                                        v70 = 0;
                                                    end;
                                                else
                                                    v70 = 0;
                                                end;
                                                v67.Visible = v70 > 0;
                                            else
                                                u10.Visible = false;
                                            end;
                                        end;
                                        if u11 then
                                            if u13 then
                                                local v73 = u13;
                                                local v74 = l__PlayerStateClient__4:GetLocalReplica();
                                                local v75;
                                                if v74 and v74.Data then
                                                    local l__Inventory__24 = v74.Data.Inventory;
                                                    if type(l__Inventory__24) == "table" then
                                                        local l__Pets__25 = l__Inventory__24.Pets;
                                                        v75 = type(l__Pets__25) == "table" and (tonumber(l__Pets__25[v73]) or 0) or 0;
                                                    else
                                                        v75 = 0;
                                                    end;
                                                else
                                                    v75 = 0;
                                                end;
                                                local v76 = u14[u13] or 0;
                                                if v75 > 0 then
                                                    v76 = v75;
                                                end;
                                                u11.Visible = v76 > 0;
                                            else
                                                u11.Visible = false;
                                            end;
                                        end;
                                    end;
                                end;
                            end);
                        end;
                    else
                        l__PlayerStateClient__4:OnLocalReplica(function() --[[ Line: 298 ]]
                            -- upvalues: l__PlayerStateClient__4 (ref), u10 (ref), u13 (ref), u1 (ref), u11 (ref), u14 (ref)
                            local v77 = l__PlayerStateClient__4:GetLocalReplica();
                            if v77 then
                                v77:OnChange(function(_, p78) --[[ Line: 287 ]]
                                    -- upvalues: u10 (ref), u13 (ref), u1 (ref), l__PlayerStateClient__4 (ref), u11 (ref), u14 (ref)
                                    if type(p78) == "table" then
                                        if p78[1] == "Inventory" then
                                            if u10 then
                                                if u13 then
                                                    local v79 = u10;
                                                    local v80 = u13;
                                                    local v81 = u1[v80];
                                                    local v82;
                                                    if v81 then
                                                        local v83 = l__PlayerStateClient__4:GetLocalReplica();
                                                        if v83 and v83.Data then
                                                            local l__Inventory__26 = v83.Data.Inventory;
                                                            if type(l__Inventory__26) == "table" then
                                                                local v84 = l__Inventory__26[v81];
                                                                v82 = type(v84) == "table" and (tonumber(v84[v80]) or 0) or 0;
                                                            else
                                                                v82 = 0;
                                                            end;
                                                        else
                                                            v82 = 0;
                                                        end;
                                                    else
                                                        v82 = 0;
                                                    end;
                                                    v79.Visible = v82 > 0;
                                                else
                                                    u10.Visible = false;
                                                end;
                                            end;
                                            if u11 then
                                                if u13 then
                                                    local v85 = u13;
                                                    local v86 = l__PlayerStateClient__4:GetLocalReplica();
                                                    local v87;
                                                    if v86 and v86.Data then
                                                        local l__Inventory__27 = v86.Data.Inventory;
                                                        if type(l__Inventory__27) == "table" then
                                                            local l__Pets__28 = l__Inventory__27.Pets;
                                                            v87 = type(l__Pets__28) == "table" and (tonumber(l__Pets__28[v85]) or 0) or 0;
                                                        else
                                                            v87 = 0;
                                                        end;
                                                    else
                                                        v87 = 0;
                                                    end;
                                                    local v88 = u14[u13] or 0;
                                                    if v87 > 0 then
                                                        v88 = v87;
                                                    end;
                                                    u11.Visible = v88 > 0;
                                                else
                                                    u11.Visible = false;
                                                end;
                                            end;
                                        end;
                                    end;
                                end);
                            end;
                            if u10 then
                                if u13 then
                                    local v89 = u10;
                                    local v90 = u13;
                                    local v91 = u1[v90];
                                    local v92;
                                    if v91 then
                                        local v93 = l__PlayerStateClient__4:GetLocalReplica();
                                        if v93 and v93.Data then
                                            local l__Inventory__29 = v93.Data.Inventory;
                                            if type(l__Inventory__29) == "table" then
                                                local v94 = l__Inventory__29[v91];
                                                v92 = type(v94) == "table" and (tonumber(v94[v90]) or 0) or 0;
                                            else
                                                v92 = 0;
                                            end;
                                        else
                                            v92 = 0;
                                        end;
                                    else
                                        v92 = 0;
                                    end;
                                    v89.Visible = v92 > 0;
                                else
                                    u10.Visible = false;
                                end;
                            end;
                            if u11 then
                                if u13 then
                                    local v95 = u13;
                                    local v96 = l__PlayerStateClient__4:GetLocalReplica();
                                    local v97;
                                    if v96 and v96.Data then
                                        local l__Inventory__30 = v96.Data.Inventory;
                                        if type(l__Inventory__30) == "table" then
                                            local l__Pets__31 = l__Inventory__30.Pets;
                                            v97 = type(l__Pets__31) == "table" and (tonumber(l__Pets__31[v95]) or 0) or 0;
                                        else
                                            v97 = 0;
                                        end;
                                    else
                                        v97 = 0;
                                    end;
                                    local v98 = u14[u13] or 0;
                                    if v97 > 0 then
                                        v98 = v97;
                                    end;
                                    u11.Visible = v98 > 0;
                                else
                                    u11.Visible = false;
                                end;
                            end;
                        end);
                    end;
                    local function v147(p99) --[[ Line: 307 ]]
                        -- upvalues: u12 (ref), u13 (ref), u8 (ref), u10 (ref), u1 (ref), l__PlayerStateClient__4 (ref), u11 (ref), u14 (ref), u6 (ref)
                        u12 = nil;
                        u13 = nil;
                        if u13 then
                            if u8 then
                                u8.Enabled = true;
                            end;
                            if u10 then
                                if u13 then
                                    local v100 = u10;
                                    local v101 = u13;
                                    local v102 = u1[v101];
                                    local v103;
                                    if v102 then
                                        local v104 = l__PlayerStateClient__4:GetLocalReplica();
                                        if v104 and v104.Data then
                                            local l__Inventory__32 = v104.Data.Inventory;
                                            if type(l__Inventory__32) == "table" then
                                                local v105 = l__Inventory__32[v102];
                                                v103 = type(v105) == "table" and (tonumber(v105[v101]) or 0) or 0;
                                            else
                                                v103 = 0;
                                            end;
                                        else
                                            v103 = 0;
                                        end;
                                    else
                                        v103 = 0;
                                    end;
                                    v100.Visible = v103 > 0;
                                else
                                    u10.Visible = false;
                                end;
                            end;
                            if u11 then
                                if u13 then
                                    local v106 = u13;
                                    local v107 = l__PlayerStateClient__4:GetLocalReplica();
                                    local v108;
                                    if v107 and v107.Data then
                                        local l__Inventory__33 = v107.Data.Inventory;
                                        if type(l__Inventory__33) == "table" then
                                            local l__Pets__34 = l__Inventory__33.Pets;
                                            v108 = type(l__Pets__34) == "table" and (tonumber(l__Pets__34[v106]) or 0) or 0;
                                        else
                                            v108 = 0;
                                        end;
                                    else
                                        v108 = 0;
                                    end;
                                    local v109 = u14[u13] or 0;
                                    if v108 > 0 then
                                        v109 = v108;
                                    end;
                                    u11.Visible = v109 > 0;
                                else
                                    u11.Visible = false;
                                end;
                            end;
                        elseif u8 then
                            u8.Enabled = false;
                        end;
                        for _, v110 in p99:GetChildren() do
                            local v111;
                            if v110:IsA("Tool") then
                                v111 = u6(v110) ~= nil;
                            else
                                v111 = false;
                            end;
                            if v111 then
                                u12 = v110;
                                local v112;
                                if v110 then
                                    v112 = u6(v110);
                                else
                                    v112 = nil;
                                end;
                                u13 = v112;
                                if u13 then
                                    if u8 then
                                        u8.Enabled = true;
                                    end;
                                    if u10 then
                                        if u13 then
                                            local v113 = u10;
                                            local v114 = u13;
                                            local v115 = u1[v114];
                                            local v116;
                                            if v115 then
                                                local v117 = l__PlayerStateClient__4:GetLocalReplica();
                                                if v117 and v117.Data then
                                                    local l__Inventory__35 = v117.Data.Inventory;
                                                    if type(l__Inventory__35) == "table" then
                                                        local v118 = l__Inventory__35[v115];
                                                        v116 = type(v118) == "table" and (tonumber(v118[v114]) or 0) or 0;
                                                    else
                                                        v116 = 0;
                                                    end;
                                                else
                                                    v116 = 0;
                                                end;
                                            else
                                                v116 = 0;
                                            end;
                                            v113.Visible = v116 > 0;
                                        else
                                            u10.Visible = false;
                                        end;
                                    end;
                                    if u11 then
                                        if u13 then
                                            local v119 = u13;
                                            local v120 = l__PlayerStateClient__4:GetLocalReplica();
                                            local v121;
                                            if v120 and v120.Data then
                                                local l__Inventory__36 = v120.Data.Inventory;
                                                if type(l__Inventory__36) == "table" then
                                                    local l__Pets__37 = l__Inventory__36.Pets;
                                                    v121 = type(l__Pets__37) == "table" and (tonumber(l__Pets__37[v119]) or 0) or 0;
                                                else
                                                    v121 = 0;
                                                end;
                                            else
                                                v121 = 0;
                                            end;
                                            local v122 = u14[u13] or 0;
                                            if v121 > 0 then
                                                v122 = v121;
                                            end;
                                            u11.Visible = v122 > 0;
                                        else
                                            u11.Visible = false;
                                        end;
                                    end;
                                elseif u8 then
                                    u8.Enabled = false;
                                end;
                                break;
                            end;
                        end;
                        p99.ChildAdded:Connect(function(p123) --[[ Line: 317 ]]
                            -- upvalues: u6 (ref), u12 (ref), u13 (ref), u8 (ref), u10 (ref), u1 (ref), l__PlayerStateClient__4 (ref), u11 (ref), u14 (ref)
                            local v124;
                            if p123:IsA("Tool") then
                                v124 = u6(p123) ~= nil;
                            else
                                v124 = false;
                            end;
                            if v124 then
                                u12 = p123;
                                local v125;
                                if p123 then
                                    v125 = u6(p123);
                                else
                                    v125 = nil;
                                end;
                                u13 = v125;
                                if u13 then
                                    if u8 then
                                        u8.Enabled = true;
                                    end;
                                    if u10 then
                                        if u13 then
                                            local v126 = u10;
                                            local v127 = u13;
                                            local v128 = u1[v127];
                                            local v129;
                                            if v128 then
                                                local v130 = l__PlayerStateClient__4:GetLocalReplica();
                                                if v130 and v130.Data then
                                                    local l__Inventory__38 = v130.Data.Inventory;
                                                    if type(l__Inventory__38) == "table" then
                                                        local v131 = l__Inventory__38[v128];
                                                        v129 = type(v131) == "table" and (tonumber(v131[v127]) or 0) or 0;
                                                    else
                                                        v129 = 0;
                                                    end;
                                                else
                                                    v129 = 0;
                                                end;
                                            else
                                                v129 = 0;
                                            end;
                                            v126.Visible = v129 > 0;
                                        else
                                            u10.Visible = false;
                                        end;
                                    end;
                                    if u11 then
                                        if u13 then
                                            local v132 = u13;
                                            local v133 = l__PlayerStateClient__4:GetLocalReplica();
                                            local v134;
                                            if v133 and v133.Data then
                                                local l__Inventory__39 = v133.Data.Inventory;
                                                if type(l__Inventory__39) == "table" then
                                                    local l__Pets__40 = l__Inventory__39.Pets;
                                                    v134 = type(l__Pets__40) == "table" and (tonumber(l__Pets__40[v132]) or 0) or 0;
                                                else
                                                    v134 = 0;
                                                end;
                                            else
                                                v134 = 0;
                                            end;
                                            local v135 = u14[u13] or 0;
                                            if v134 > 0 then
                                                v135 = v134;
                                            end;
                                            u11.Visible = v135 > 0;
                                            return;
                                        else
                                            u11.Visible = false;
                                            return;
                                        end;
                                    else
                                        return;
                                    end;
                                end;
                                if u8 then
                                    u8.Enabled = false;
                                end;
                            end;
                        end);
                        p99.ChildRemoved:Connect(function(p136) --[[ Line: 322 ]]
                            -- upvalues: u12 (ref), u13 (ref), u8 (ref), u10 (ref), u1 (ref), l__PlayerStateClient__4 (ref), u11 (ref), u14 (ref)
                            if u12 and p136 == u12 then
                                u12 = nil;
                                u13 = nil;
                                if u13 then
                                    if u8 then
                                        u8.Enabled = true;
                                    end;
                                    if u10 then
                                        if u13 then
                                            local v137 = u10;
                                            local v138 = u13;
                                            local v139 = u1[v138];
                                            local v140;
                                            if v139 then
                                                local v141 = l__PlayerStateClient__4:GetLocalReplica();
                                                if v141 and v141.Data then
                                                    local l__Inventory__41 = v141.Data.Inventory;
                                                    if type(l__Inventory__41) == "table" then
                                                        local v142 = l__Inventory__41[v139];
                                                        v140 = type(v142) == "table" and (tonumber(v142[v138]) or 0) or 0;
                                                    else
                                                        v140 = 0;
                                                    end;
                                                else
                                                    v140 = 0;
                                                end;
                                            else
                                                v140 = 0;
                                            end;
                                            v137.Visible = v140 > 0;
                                        else
                                            u10.Visible = false;
                                        end;
                                    end;
                                    if u11 then
                                        if u13 then
                                            local v143 = u13;
                                            local v144 = l__PlayerStateClient__4:GetLocalReplica();
                                            local v145;
                                            if v144 and v144.Data then
                                                local l__Inventory__42 = v144.Data.Inventory;
                                                if type(l__Inventory__42) == "table" then
                                                    local l__Pets__43 = l__Inventory__42.Pets;
                                                    v145 = type(l__Pets__43) == "table" and (tonumber(l__Pets__43[v143]) or 0) or 0;
                                                else
                                                    v145 = 0;
                                                end;
                                            else
                                                v145 = 0;
                                            end;
                                            local v146 = u14[u13] or 0;
                                            if v145 > 0 then
                                                v146 = v145;
                                            end;
                                            u11.Visible = v146 > 0;
                                            return;
                                        else
                                            u11.Visible = false;
                                            return;
                                        end;
                                    else
                                        return;
                                    end;
                                end;
                                if u8 then
                                    u8.Enabled = false;
                                end;
                            end;
                        end);
                    end;
                    if l__LocalPlayer__5.Character then
                        v147(l__LocalPlayer__5.Character);
                    end;
                    l__LocalPlayer__5.CharacterAdded:Connect(v147);
                end;
            end;
        end;
    end;
end;
return v7;