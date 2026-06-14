-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__SharedModules__3 = l__ReplicatedStorage__1:WaitForChild("SharedModules");
local v1 = l__SharedModules__3:FindFirstChild("SeedData");
local u2;
if v1 and v1:IsA("ModuleScript") then
    local v3;
    v3, u2 = pcall(require, v1);
    if not v3 then
        u2 = nil;
    end;
else
    u2 = nil;
end;
local v4 = l__SharedModules__3:FindFirstChild("SprinklerData");
local u5;
if v4 and v4:IsA("ModuleScript") then
    local v6;
    v6, u5 = pcall(require, v4);
    if not v6 then
        u5 = nil;
    end;
else
    u5 = nil;
end;
local v7 = l__SharedModules__3:FindFirstChild("WateringcanData");
local u8;
if v7 and v7:IsA("ModuleScript") then
    local v9;
    v9, u8 = pcall(require, v7);
    if not v9 then
        u8 = nil;
    end;
else
    u8 = nil;
end;
local v10 = l__SharedModules__3:FindFirstChild("MushroomData");
local u11;
if v10 and v10:IsA("ModuleScript") then
    local v12;
    v12, u11 = pcall(require, v10);
    if not v12 then
        u11 = nil;
    end;
else
    u11 = nil;
end;
local v13 = l__SharedModules__3:FindFirstChild("RaccoonData");
local u14;
if v13 and v13:IsA("ModuleScript") then
    local v15;
    v15, u14 = pcall(require, v13);
    if not v15 then
        u14 = nil;
    end;
else
    u14 = nil;
end;
local v16 = l__SharedModules__3:FindFirstChild("GnomeData");
local u17;
if v16 and v16:IsA("ModuleScript") then
    local v18;
    v18, u17 = pcall(require, v16);
    if not v18 then
        u17 = nil;
    end;
else
    u17 = nil;
end;
local v19 = l__SharedModules__3:FindFirstChild("PowerHoseData");
local u20;
if v19 and v19:IsA("ModuleScript") then
    local v21;
    v21, u20 = pcall(require, v19);
    if not v21 then
        u20 = nil;
    end;
else
    u20 = nil;
end;
local v22 = l__SharedModules__3:FindFirstChild("CrateData");
local u23;
if v22 and v22:IsA("ModuleScript") then
    local v24;
    v24, u23 = pcall(require, v22);
    if not v24 then
        u23 = nil;
    end;
else
    u23 = nil;
end;
local v25 = l__SharedModules__3:FindFirstChild("GuildCrateData");
local u26;
if v25 and v25:IsA("ModuleScript") then
    local v27;
    v27, u26 = pcall(require, v25);
    if not v27 then
        u26 = nil;
    end;
else
    u26 = nil;
end;
local v28 = l__SharedModules__3:FindFirstChild("SeedPackData");
local u29;
if v28 and v28:IsA("ModuleScript") then
    local v30;
    v30, u29 = pcall(require, v28);
    if not v30 then
        u29 = nil;
    end;
else
    u29 = nil;
end;
local v31 = l__SharedModules__3:FindFirstChild("EggData");
local u32;
if v31 and v31:IsA("ModuleScript") then
    local v33;
    v33, u32 = pcall(require, v31);
    if not v33 then
        u32 = nil;
    end;
else
    u32 = nil;
end;
local v34 = l__SharedModules__3:FindFirstChild("TrowelData");
local u35;
if v34 and v34:IsA("ModuleScript") then
    local v36;
    v36, u35 = pcall(require, v34);
    if not v36 then
        u35 = nil;
    end;
else
    u35 = nil;
end;
local v37 = l__SharedModules__3:FindFirstChild("PropData");
local u38;
if v37 and v37:IsA("ModuleScript") then
    local v39;
    v39, u38 = pcall(require, v37);
    if not v39 then
        u38 = nil;
    end;
else
    u38 = nil;
end;
local v40 = l__SharedModules__3:FindFirstChild("GearShopData");
local u41;
if v40 and v40:IsA("ModuleScript") then
    local v42;
    v42, u41 = pcall(require, v40);
    if not v42 then
        u41 = nil;
    end;
else
    u41 = nil;
end;
local v43 = l__SharedModules__3:FindFirstChild("SellValueData");
local u44;
if v43 and v43:IsA("ModuleScript") then
    local v45;
    v45, u44 = pcall(require, v43);
    if not v45 then
        u44 = nil;
    end;
else
    u44 = nil;
end;
local v46 = l__SharedModules__3:FindFirstChild("FruitValueCalc");
local u47;
if v46 and v46:IsA("ModuleScript") then
    local v48;
    v48, u47 = pcall(require, v46);
    if not v48 then
        u47 = nil;
    end;
else
    u47 = nil;
end;
local v49 = nil;
local v50 = l__ReplicatedStorage__1:FindFirstChild("SharedData");
if v50 then
    v50 = v50:FindFirstChild("PetData");
end;
local u51;
if v50 and v50:IsA("ModuleScript") then
    local v52;
    v52, u51 = pcall(require, v50);
    if not v52 then
        u51 = v49;
    end;
else
    u51 = v49;
end;
local u53 = l__SharedModules__3:FindFirstChild("GearImages");
local u54 = l__SharedModules__3:FindFirstChild("PropImages");
local function u60(p55, p56, p57) --[[ Line: 69 ]]
    if typeof(p55) ~= "table" then
        return nil;
    end;
    for _, v58 in p55 do
        for _, v59 in p57 do
            if v58[v59] == p56 then
                return v58;
            end;
        end;
    end;
    return nil;
end;
local function u66(p61, p62) --[[ Line: 81 ]]
    -- upvalues: u2 (copy), u60 (copy)
    local v63 = u2;
    if typeof(v63) ~= "table" then
        return nil;
    end;
    local v64 = u60(v63, p61, { "SeedName" });
    if not v64 then
        return nil;
    end;
    local v65 = v64[p62];
    if typeof(v65) == "Instance" then
        if v65:IsA("StringValue") then
            return v65.Value;
        end;
        if v65:IsA("ImageLabel") then
            return v65.Image;
        end;
    end;
    return v65;
end;
local u67 = {
    Categories = {
        "Pets",
        "Sprinklers",
        "WateringCans",
        "Mushrooms",
        "Gnomes",
        "Raccoons",
        "Crates",
        "SeedPacks",
        "Trowels",
        "Props",
        "Seeds",
        "HarvestedFruits",
        "Flashbangs",
        "EmptyPots"
    }
};
function u67.IsGiftable(p68) --[[ Line: 115 ]]
    -- upvalues: u67 (copy)
    for _, v69 in u67.Categories do
        if v69 == p68 then
            return true;
        end;
    end;
    return false;
end;
local function u77(p70, p71, p72, p73) --[[ Line: 122 ]]
    -- upvalues: u60 (copy)
    if typeof(p70) ~= "table" then
        return p71, "";
    end;
    local v74 = u60(p70, p71, { p72 });
    if not v74 then
        return p71, "";
    end;
    local v75 = v74[p73];
    local v76 = typeof(v75) ~= "string" and "" or v75;
    return v74[p72] or p71, v76;
end;
local function u82(p78, p79, p80, p81) --[[ Line: 131 ]]
    -- upvalues: u77 (copy)
    if typeof(p78) == "table" and typeof(p78.Data) == "table" then
        p78 = p78.Data;
    end;
    return u77(p78, p79, p80, p81);
end;
function u67.Resolve(p83, p84, p85) --[[ Line: 142 ]]
    -- upvalues: u66 (copy), u51 (ref), u82 (copy), u5 (copy), u8 (copy), u11 (copy), u14 (copy), u17 (copy), u20 (copy), u26 (copy), u23 (copy), u29 (copy), u32 (copy), u54 (copy), u38 (copy), u35 (copy), u53 (copy)
    if p83 == "Seeds" then
        local v86 = u66(p84, "SeedImage") or "";
        local v87 = string.lower(p84);
        if string.sub(v87, -5) ~= " seed" and v87 ~= "seed" then
            p84 = p84 .. " Seed";
        end;
        return p84, typeof(v86) == "string" and v86 and v86 or "";
    end;
    if p83 == "HarvestedFruits" then
        local v88;
        if typeof(p85) == "table" then
            p84 = p85.FruitName or (p85.Name or p84);
            v88 = p85.Mutation;
        else
            v88 = nil;
        end;
        local v89 = u66(p84, "FruitImage") or "";
        if v88 and v88 ~= "" then
            p84 = string.format("%s [%s]", p84, v88);
        end;
        return p84, typeof(v89) == "string" and v89 and v89 or "";
    end;
    if p83 == "Pets" then
        local v90, v91, v92;
        if typeof(p85) == "table" then
            p84 = p85.Name or p84;
            v90 = p85.Mutation;
            v91 = p85.Size;
            v92 = p85.Type;
        else
            v92 = nil;
            v91 = nil;
            v90 = nil;
        end;
        local v93 = "";
        local v94;
        if typeof(u51) == "table" then
            if typeof(u51.GetImage) == "function" then
                local v95;
                v95, v94 = pcall(u51.GetImage, p84, v91);
                if v95 and typeof(v94) == "string" then
                    if v94 == "" then
                        v94 = v93;
                    end;
                else
                    v94 = v93;
                end;
            else
                v94 = v93;
            end;
            if v94 == "" then
                local v96 = u51[p84];
                if typeof(v96) == "table" and typeof(v96.Image) == "string" then
                    v94 = v96.Image;
                end;
            end;
        else
            v94 = v93;
        end;
        local v97;
        if typeof(u51) == "table" and typeof(u51.GetSpeciesDisplayName) == "function" then
            local v98;
            v98, v97 = pcall(u51.GetSpeciesDisplayName, p84);
            if v98 and typeof(v97) == "string" then
                if v97 == "" then
                    v97 = p84;
                end;
            else
                v97 = p84;
            end;
        else
            v97 = p84;
        end;
        local v99 = {};
        if v92 ~= nil and v92 ~= "" then
            table.insert(v99, v92);
        end;
        if v91 ~= nil and v91 ~= "" then
            table.insert(v99, v91);
        end;
        table.insert(v99, v97);
        local v100 = table.concat(v99, " ");
        if v90 ~= nil and v90 ~= "" then
            v100 = string.format("%s [%s]", v100, v90);
        end;
        return v100, v94;
    end;
    if p83 == "Sprinklers" then
        return u82(u5, p84, "SprinklerName", "Image");
    end;
    if p83 == "WateringCans" then
        return u82(u8, p84, "Name", "Image");
    end;
    if p83 == "Mushrooms" then
        return u82(u11, p84, "Name", "IMG");
    end;
    if p83 == "Raccoons" then
        return u82(u14, p84, "Name", "IMG");
    end;
    if p83 == "Gnomes" then
        return u82(u17, p84, "Name", "IMG");
    end;
    if p83 == "PowerHoses" then
        return u82(u20, p84, "Name", "IMG");
    end;
    if p83 == "Crates" then
        local v101 = u26 and u26.GetData and u26.GetData(p84);
        if v101 then
            return v101.Name or p84, v101.IMG or "";
        else
            local v102 = u23 and u23.GetData and u23.GetData(p84);
            if v102 then
                return v102.Name or p84, v102.IMG or "";
            else
                return p84, "";
            end;
        end;
    end;
    if p83 == "SeedPacks" then
        return u82(u29, p84, "PackName", "IMG");
    end;
    if p83 == "Eggs" then
        local v103 = typeof(u32) == "table" and typeof(u32.GetData) == "function" and u32.GetData(p84);
        if v103 then
            local l__IMG__4 = v103.IMG;
            local v104 = v103.EggName or p84;
            if typeof(l__IMG__4) == "string" then
                return v104, l__IMG__4;
            else
                return v104, "";
            end;
        else
            return p84, "";
        end;
    end;
    if p83 ~= "Props" then
        if p83 == "Trowels" then
            local v105 = "";
            if typeof(u35) == "table" then
                local l__Data__5 = u35.Data;
                if typeof(l__Data__5) == "table" and typeof(l__Data__5.IMG) == "string" then
                    v105 = l__Data__5.IMG;
                end;
            end;
            if v105 == "" then
                local v106 = u53;
                if v106 then
                    local v107 = v106:FindFirstChild(p84);
                    if v107 and v107:IsA("StringValue") then
                        v105 = v107.Value;
                    else
                        v105 = not (v107 and v107:IsA("ImageLabel")) and "" or v107.Image;
                    end;
                else
                    v105 = "";
                end;
            end;
            return p84, v105;
        else
            local v108 = u53;
            if v108 then
                local v109 = v108:FindFirstChild(p84);
                if v109 and v109:IsA("StringValue") then
                    return p84, v109.Value;
                elseif v109 and v109:IsA("ImageLabel") then
                    return p84, v109.Image;
                else
                    return p84, "";
                end;
            else
                return p84, "";
            end;
        end;
    end;
    local v110 = u54;
    local v111;
    if v110 then
        local v112 = v110:FindFirstChild(p84);
        if v112 and v112:IsA("StringValue") then
            v111 = v112.Value;
        else
            v111 = not (v112 and v112:IsA("ImageLabel")) and "" or v112.Image;
        end;
    else
        v111 = "";
    end;
    if v111 == "" and (typeof(u38) == "table" and typeof(u38.Data) == "table") then
        for _, v113 in u38.Data do
            if typeof(v113) == "table" and v113.PropName == p84 then
                if typeof(v113.IMG) == "string" then
                    v111 = v113.IMG;
                end;
                break;
            end;
        end;
    end;
    return p84, v111;
end;
local u114 = nil;
local function u117() --[[ Line: 293 ]]
    -- upvalues: u114 (ref), u41 (copy)
    if u114 == nil then
        local v115 = {};
        if typeof(u41) == "table" and typeof(u41.Data) == "table" then
            for _, v116 in u41.Data do
                if typeof(v116) == "table" and (typeof(v116.ItemName) == "string" and typeof(v116.Cost) == "number") then
                    v115[v116.ItemName] = v116.Cost;
                end;
            end;
        end;
        u114 = v115;
    end;
end;
function u67.GetValue(p118, p119, p120, p121) --[[ Line: 313 ]]
    -- upvalues: u47 (copy), u44 (copy), u117 (copy), u114 (ref)
    if p118 == "HarvestedFruits" then
        if typeof(p120) ~= "table" then
            return 0;
        end;
        if typeof(u47) ~= "function" then
            return 0;
        end;
        local v122, v123 = pcall(u47, p120.FruitName or (p120.Name or p119), p120.SizeMultiplier or 1, p120.Mutation, p121);
        return (not v122 or typeof(v123) ~= "number") and 0 or v123;
    else
        if p118 == "Seeds" then
            if typeof(u44) == "table" then
                local v124 = u44[p119];
                if typeof(v124) == "number" then
                    return v124;
                end;
            end;
            return 0;
        end;
        u117();
        local v125 = u114;
        return (not v125 or typeof(v125[p119]) ~= "number") and 0 or v125[p119];
    end;
end;
function u67.GetHeadshot(u126) --[[ Line: 341 ]]
    -- upvalues: l__Players__2 (copy)
    local v127, v128 = pcall(function() --[[ Line: 342 ]]
        -- upvalues: l__Players__2 (ref), u126 (copy)
        return l__Players__2:GetUserThumbnailAsync(u126, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
    end);
    return (not v127 or typeof(v128) ~= "string") and "" or v128;
end;
local function u132(p129, p130) --[[ Line: 386 ]]
    if p129:IsA("TextLabel") or p129:IsA("TextButton") then
        p129.Text = p130;
    end;
    for _, v131 in p129:GetDescendants() do
        if v131:IsA("TextLabel") or v131:IsA("TextButton") then
            v131.Text = p130;
        end;
    end;
end;
local u133 = {
    Common = "#bfbfbf",
    Uncommon = "#44d200",
    Rare = "#2f8bff",
    Epic = "#a64bff",
    Legendary = "#ffd11a",
    Mythic = "#ff3b3b",
    Super = "#ffffff"
};
local function u139(p134, p135) --[[ Line: 442 ]]
    if p135 == "Owner" then
        local v136 = p134:FindFirstChild("GuildRewardTemplate_Owner");
        if not (v136 and v136:IsA("Frame")) then
            v136 = nil;
        end;
        if v136 then
            return v136, "Owner";
        end;
    end;
    if p135 == "Elder" then
        local v137 = p134:FindFirstChild("GuildRewardTemplate_Elder");
        if not (v137 and v137:IsA("Frame")) then
            v137 = nil;
        end;
        if v137 then
            return v137, "Elder";
        end;
    end;
    local v138 = p134:FindFirstChild("GuildRewardTemplate");
    if not (v138 and v138:IsA("Frame")) then
        v138 = nil;
    end;
    return v138, "Member";
end;
local function u144(p140) --[[ Line: 468 ]]
    local v141 = p140:FindFirstChild("Frame");
    if v141 then
        local v142 = v141:FindFirstChild("PrizeDisplayTemplate");
        if v142 and v142:IsA("Frame") then
            return v142, v141;
        end;
    end;
    local v143 = p140:FindFirstChild("PrizeDisplayTemplate");
    if v143 and v143:IsA("Frame") then
        return v143, p140;
    else
        return nil, nil;
    end;
end;
local l__SeedpackReward__6 = game.SoundService.SFX.SeedpackSFX.SeedpackReward;
function u67.BuildGuildRewardVisual(p145, p146, p147, u148) --[[ Line: 505 ]]
    -- upvalues: u139 (copy), u133 (copy), u144 (copy), u67 (copy), l__SeedpackReward__6 (copy)
    if not p145 then
        return nil;
    end;
    local v149 = u139(p145, typeof(p147.RoleAtFlip) ~= "string" and "Member" or p147.RoleAtFlip);
    if not v149 then
        return nil;
    end;
    local v150 = v149:Clone();
    v150.Name = "Gift_" .. p146;
    v150.Visible = true;
    local v151 = v150:FindFirstChild("Interior");
    if not v151 then
        v150:Destroy();
        return nil;
    end;
    local v152 = typeof(p147.Tier) == "string" and (u133[p147.Tier] or "#ffffff") or "#ffd11a";
    local v153 = string.format("<font color=\"%s\">Guild Reward</font>", v152);
    local v154 = v151:FindFirstChild("TopFrame");
    if v154 then
        local v155 = v154:FindFirstChild("SubjectLine1");
        if v155 and (v155:IsA("TextLabel") or v155:IsA("TextButton")) then
            v155.RichText = true;
            v155.Text = v153;
            local v156 = v155:FindFirstChild("SubjectLine2");
            if v156 and (v156:IsA("TextLabel") or v156:IsA("TextButton")) then
                v156.RichText = true;
                v156.Text = v153;
            end;
        end;
    end;
    local v157 = tonumber(p147.Placement) or 0;
    local v158 = v151:FindFirstChild("NoteTextlabel");
    if v158 and (v158:IsA("TextLabel") or v158:IsA("TextButton")) then
        v158.RichText = false;
        v158.Text = v157 <= 0 and "Your guild placed in the contest!" or string.format("Your guild placed #%d", v157);
    end;
    local v159, v160 = u144(v151);
    if v159 and v160 then
        v159.Visible = false;
        local v161 = typeof(p147.Items) ~= "table" and {} or p147.Items;
        for v162, v163 in #v161 == 0 and (typeof(p147.CrateName) == "string" and p147.CrateName ~= "") and {
            {
                Category = "Crates",
                ItemName = p147.CrateName,
                Count = tonumber(p147.BaseAmount) or 1
            }
        } or v161 do
            if typeof(v163) == "table" then
                local v164 = typeof(v163.ItemName) ~= "string" and "" or v163.ItemName;
                local v165 = typeof(v163.Category) ~= "string" and "Crates" or v163.Category;
                local v166 = tonumber(v163.Count) or 1;
                local _, v167 = u67.Resolve(v165, v164, v163);
                local v168 = v159:Clone();
                v168.Name = string.format("PrizeDisplay_%d", v162);
                v168.Visible = true;
                v168.LayoutOrder = v162;
                v168.Parent = v160;
                local v169 = v168.Frame:FindFirstChild("PrizeImage");
                if v169 and v169:IsA("ImageLabel") then
                    v169.Image = v167;
                end;
                for _, v170 in { "Count", "Amount", "CountLabel" } do
                    local v171 = v168.Frame:FindFirstChild(v170);
                    if v171 and (v171:IsA("TextLabel") or v171:IsA("TextButton")) then
                        v171.Text = "x" .. tostring(v166);
                    end;
                end;
            end;
        end;
    end;
    local v172 = v151:FindFirstChild("Claim");
    if v172 and v172:IsA("GuiButton") then
        v172.MouseButton1Click:Connect(function() --[[ Line: 614 ]]
            -- upvalues: l__SeedpackReward__6 (ref), u148 (copy)
            l__SeedpackReward__6.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__SeedpackReward__6.Playing = true;
            l__SeedpackReward__6.TimePosition = 0;
            u148();
        end);
    end;
    v150.Parent = p145;
    return v150;
end;
function u67.BuildInviteVisual(p173, p174, p175, u176, u177, u178) --[[ Line: 626 ]]
    -- upvalues: u132 (copy), u67 (copy)
    if not (p173 and p173:IsA("Frame")) then
        return nil;
    end;
    local u179 = p173:Clone();
    u179.Name = "Invite_" .. p175;
    u179.Visible = true;
    local v180 = u179:FindFirstChild("Interior");
    if not v180 then
        u179:Destroy();
        return nil;
    end;
    local v181 = tostring(u176.GuildName or "Unknown Guild");
    local v182 = tostring(u176.GuildTag or "?");
    local v183 = tostring(u176.FromName or "?");
    local v184 = v180:FindFirstChild("TopFrame");
    if v184 then
        local v185 = v184:FindFirstChild("SubjectLine1");
        if v185 then
            u132(v185, string.format("Guild Invite from @%s", v183));
        end;
        local u186 = v184:FindFirstChild("SentPlayerImageLabel");
        if u186 and u186:IsA("ImageLabel") then
            task.spawn(function() --[[ Line: 666 ]]
                -- upvalues: u67 (ref), u176 (copy), u179 (copy), u186 (copy)
                local v187 = u67.GetHeadshot(u176.FromUserId or 0);
                if v187 ~= "" and u179.Parent then
                    u186.Image = v187;
                end;
            end);
        end;
    end;
    local v188 = v180:FindFirstChild("NoteTextlabel");
    if v188 then
        local v189 = not (u176.MemberCount and u176.MaxSlots) and "?/? Members" or string.format("%d/%d Members", u176.MemberCount, u176.MaxSlots);
        u132(v188, string.format("%s [%s] | %s", v181, v182, v189));
    end;
    local v190 = v180:FindFirstChild("JoinButton");
    if v190 and v190:IsA("GuiButton") then
        v190.MouseButton1Click:Connect(function() --[[ Line: 691 ]]
            -- upvalues: u177 (copy)
            u177();
        end);
    end;
    local v191 = v180:FindFirstChild("ExitButton");
    if v191 and v191:IsA("GuiButton") then
        v191.MouseButton1Click:Connect(function() --[[ Line: 699 ]]
            -- upvalues: u178 (copy)
            u178();
        end);
    end;
    u179.Parent = p174;
    return u179;
end;
return u67;