-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__GuildCompetition__4 = require(l__ReplicatedStorage__2.SharedModules.GuildCompetition);
local l__Asserts__5 = require(l__ReplicatedStorage__2.SharedModules.Guild.Asserts);
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__PlayerGui__7 = l__LocalPlayer__6:WaitForChild("PlayerGui");
local l__GuiController__8 = require(l__LocalPlayer__6.PlayerScripts.Controllers.GuiController);
local l__NotificationController__9 = require(l__LocalPlayer__6.PlayerScripts.Controllers.NotificationController);
local l__DevProductController__10 = require(l__LocalPlayer__6.PlayerScripts.Controllers.DevProductController);
local l__LeaveGuildController__11 = require(l__LocalPlayer__6.PlayerScripts.Controllers.LeaveGuildController);
local u1 = {
    {
        From = 20,
        To = 25,
        Key = "Guild:Guild Slots:25",
        FallbackPrice = 37
    },
    {
        From = 25,
        To = 30,
        Key = "Guild:Guild Slots:30",
        FallbackPrice = 79
    },
    {
        From = 30,
        To = 35,
        Key = "Guild:Guild Slots:35",
        FallbackPrice = 189
    },
    {
        From = 35,
        To = 40,
        Key = "Guild:Guild Slots:40",
        FallbackPrice = 279
    },
    {
        From = 40,
        To = 45,
        Key = "Guild:Guild Slots:45",
        FallbackPrice = 399
    },
    {
        From = 45,
        To = 50,
        Key = "Guild:Guild Slots:50",
        FallbackPrice = 499
    }
};
local v2 = {
    StartOrder = 8
};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = {};
local u26 = nil;
local u27 = {};
local u28 = nil;
local u29 = {};
local u30 = {};
local u31 = nil;
local u32 = nil;
local u33 = {};
local u34 = {};
local u35 = false;
local u36 = false;
local u37 = 0;
local u38 = {};
local u39 = {};
local u40 = nil;
local u41 = nil;
local u42 = 0;
local u43 = nil;
local u44 = 0;
local u45 = Color3.fromRGB(70, 255, 0);
local u46 = Color3.fromRGB(220, 60, 60);
local u47 = nil;
local u48 = false;
local u49 = nil;
local function u57(p50) --[[ Line: 269 ]]
    -- upvalues: u40 (ref)
    local v51 = p50 < 0 and 0 or p50;
    local v52 = u40 and u40.phase == "pending" and "Starts in" or "Rewards in";
    local v53 = math.floor(v51 + 0.5);
    if v53 < 3600 then
        local v54 = v53 // 60;
        return string.format("%s %dm %ds", v52, v54, v53 - v54 * 60);
    elseif v53 < 86400 then
        local v55 = v53 // 3600;
        return string.format("%s %dh %dm", v52, v55, (v53 - v55 * 3600) // 60);
    else
        local v56 = v53 // 86400;
        return string.format("%s %dd %dh", v52, v56, (v53 - v56 * 86400) // 3600);
    end;
end;
local function u71(p58, p59) --[[ Line: 308 ]]
    local v60 = utf8.len(p58) or 1;
    if v60 <= 0 then
        return p58;
    end;
    local v61 = 0;
    local v62 = {};
    for _, v63 in utf8.codes(p58) do
        v61 = v61 + 1;
        local v64 = Color3.fromHSV((p59 * 1.2 + (v61 - 1) / v60 * 0.6) % 1, 1, 1);
        local l__format__12 = string.format;
        local v65 = math.floor(v64.R * 255 + 0.5);
        local v66 = math.clamp(v65, 0, 255);
        local v67 = math.floor(v64.G * 255 + 0.5);
        local v68 = math.clamp(v67, 0, 255);
        local v69 = math.floor(v64.B * 255 + 0.5);
        local v70 = l__format__12("#%02X%02X%02X", v66, v68, (math.clamp(v69, 0, 255)));
        table.insert(v62, string.format("<font color=\"%s\">%s</font>", v70, utf8.char(v63)));
    end;
    return table.concat(v62);
end;
local function u78(u72, u73) --[[ Line: 337 ]]
    -- upvalues: l__Players__1 (copy), u33 (copy)
    local v74 = l__Players__1:GetPlayerByUserId(u72);
    local v75;
    if v74 then
        v75 = v74.Name;
    else
        v75 = nil;
    end;
    if v75 then
        u33[u72] = v75;
        u73(v75);
    elseif u33[u72] then
        u73(u33[u72]);
    else
        task.spawn(function() --[[ Line: 345 ]]
            -- upvalues: l__Players__1 (ref), u72 (copy), u33 (ref), u73 (copy)
            local v76, v77 = pcall(function() --[[ Line: 346 ]]
                -- upvalues: l__Players__1 (ref), u72 (ref)
                return l__Players__1:GetNameFromUserIdAsync(u72);
            end);
            if not v76 or typeof(v77) ~= "string" then
                v77 = tostring(u72);
            end;
            u33[u72] = v77;
            u73(v77);
        end);
    end;
end;
local function u81(p79) --[[ Line: 405 ]]
    -- upvalues: u12 (ref)
    if u12 then
        u12.RichText = false;
        u12.TextColor3 = Color3.new(0, 0, 0);
        u12.Text = p79:gsub("<.->", "");
    end;
    local v80 = u12;
    if v80 then
        v80 = u12:FindFirstChild("TextLabel");
    end;
    if v80 and v80:IsA("TextLabel") then
        v80.RichText = true;
        v80.Text = p79;
    end;
end;
local function u85(p82) --[[ Line: 433 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u25 (ref)
    if typeof(p82) ~= "string" or p82 == "" then
        p82 = l__LocalPlayer__6:GetAttribute("GuildId");
        if typeof(p82) ~= "string" then
            return nil;
        end;
    end;
    for v83, v84 in u25 do
        if (v84.guildId or v84.GuildId) == p82 then
            return tonumber(v84.rank or v84.Rank) or v83;
        end;
    end;
    return nil;
end;
local function u88(p86) --[[ Line: 455 ]]
    -- upvalues: u26 (ref), u25 (ref)
    if u26 ~= "weekly" then
        return nil;
    end;
    if typeof(p86) ~= "string" or p86 == "" then
        return nil;
    end;
    for _, v87 in u25 do
        if (v87.guildId or v87.GuildId) == p86 then
            return tonumber(v87.shekels or (v87.Shekels or v87.score));
        end;
    end;
    return nil;
end;
local function u98(p89) --[[ Line: 492 ]]
    -- upvalues: u26 (ref), u85 (copy), u32 (ref), u35 (ref), u71 (copy), u81 (copy)
    if p89 then
        local v90 = tostring(p89.Tag or "");
        local v91 = tostring(p89.Name or "");
        local l__Color__13 = p89.Color;
        if typeof(l__Color__13) == "string" and l__Color__13 ~= "" then
            if l__Color__13:sub(1, 1) ~= "#" then
                l__Color__13 = "#" .. l__Color__13;
            end;
        else
            l__Color__13 = "#FFFFFF";
        end;
        local v92 = p89.TagColor or p89.Color;
        if typeof(v92) == "string" and v92 ~= "" then
            if v92:sub(1, 1) ~= "#" then
                v92 = "#" .. v92;
            end;
        else
            v92 = "#FFFFFF";
        end;
        local u93 = string.format("<font color=\"%s\">[%s]</font> <font color=\"%s\">%s</font>", v92, v90, l__Color__13, v91);
        local v94;
        if typeof(p89.GuildId) == "string" then
            v94 = p89.GuildId;
        else
            v94 = nil;
        end;
        local v95;
        if u26 == "weekly" then
            v95 = u85(v94);
        else
            v95 = nil;
        end;
        if v95 == 1 then
            if u32 then
                task.cancel(u32);
                u32 = nil;
            end;
            local u96 = "(#1)";
            u32 = task.spawn(function() --[[ Line: 476 ]]
                -- upvalues: u35 (ref), u93 (copy), u71 (ref), u96 (copy), u81 (ref)
                local v97 = 0;
                while u35 do
                    u81(u93 .. " " .. u71(u96, v97));
                    v97 = v97 + task.wait(0.04);
                end;
            end);
        elseif v95 and v95 <= 200 then
            if u32 then
                task.cancel(u32);
                u32 = nil;
            end;
            u81(u93 .. string.format(" <font color=\"%s\">(#%d)</font>", v95 == 2 and "#FFBE18" or (v95 == 3 and "#AAAAAA" or "#956D4C"), v95));
        else
            if u32 then
                task.cancel(u32);
                u32 = nil;
            end;
            u81(u93);
        end;
    end;
end;
local function u101() --[[ Line: 528 ]]
    -- upvalues: u30 (copy), u29 (copy)
    for _, u99 in u30 do
        pcall(function() --[[ Line: 530 ]]
            -- upvalues: u99 (copy)
            u99:Disconnect();
        end);
    end;
    table.clear(u30);
    for _, v100 in u29 do
        if v100.Parent then
            v100:Destroy();
        end;
    end;
    table.clear(u29);
end;
local function u114(p102, p103) --[[ Line: 543 ]]
    -- upvalues: u33 (copy)
    local v104 = {};
    if p102 and typeof(p102.Members) == "table" then
        for v105, v106 in p102.Members do
            local v107 = tonumber(v105);
            if v107 then
                v104[v107] = {
                    weeklyShekels = 0,
                    displayName = nil,
                    userId = v107,
                    role = tostring(v106.Role or "Member"),
                    lifetimeShekels = tonumber(v106.LifetimeContribution) or 0
                };
            end;
        end;
    end;
    if typeof(p103) == "table" then
        for _, v108 in p103 do
            local v109 = tonumber(v108.userId or v108.UserId);
            if v109 and v104[v109] then
                v104[v109].weeklyShekels = tonumber(v108.shekels or v108.Shekels) or 0;
                if typeof(v108.name) == "string" then
                    v104[v109].displayName = v108.name;
                    u33[v109] = v108.name;
                end;
            end;
        end;
    end;
    local v110 = {};
    for _, v111 in v104 do
        table.insert(v110, v111);
    end;
    table.sort(v110, function(p112, p113) --[[ Line: 579 ]]
        if p112.weeklyShekels == p113.weeklyShekels then
            if p112.lifetimeShekels == p113.lifetimeShekels then
                return p112.userId < p113.userId;
            else
                return p112.lifetimeShekels > p113.lifetimeShekels;
            end;
        else
            return p112.weeklyShekels > p113.weeklyShekels;
        end;
    end);
    return v110;
end;
local u115 = nil;
local function u201(p116, p117, p118, u119, u120, p121) --[[ Line: 599 ]]
    -- upvalues: u29 (copy), l__LocalPlayer__6 (copy), l__Players__1 (copy), u33 (copy), u78 (copy), l__GuildCompetition__4 (copy), u40 (ref), u34 (copy), u38 (copy), u45 (copy), u46 (copy), u19 (ref), u20 (ref), l__Networking__3 (copy), l__NotificationController__9 (copy), u115 (ref), u30 (copy), l__LeaveGuildController__11 (copy)
    local u122 = p116:Clone();
    u122.Name = `Member_{u119.userId}`;
    u122.LayoutOrder = p118;
    u122.Visible = true;
    u122.Parent = p117;
    table.insert(u29, u122);
    local v123 = u122:FindFirstChild("ContainerFrame");
    if v123 then
        local u124;
        if u119.role == "Owner" or u119.role == "Leader" then
            u124 = true;
        elseif typeof(u120) == "table" then
            u124 = u120.LeaderUserId == u119.userId;
        else
            u124 = false;
        end;
        local v125 = u119.role == "Elder";
        local v126 = u119.userId == l__LocalPlayer__6.UserId;
        local v127 = p121 == "Owner";
        local u128 = v123:FindFirstChild("Username");
        if u128 and u128:IsA("TextLabel") then
            local l__userId__14 = u119.userId;
            local v129 = l__Players__1:GetPlayerByUserId(l__userId__14);
            local v130;
            if v129 then
                v130 = v129.Name;
            else
                v130 = nil;
            end;
            if v130 then
                u33[l__userId__14] = v130;
            elseif u33[l__userId__14] then
                v130 = u33[l__userId__14];
            else
                v130 = tostring(l__userId__14);
            end;
            if u128 then
                u128.RichText = true;
                u128.Text = v130;
                local v131 = u128:FindFirstChild("TextLabel");
                if v131 and v131:IsA("TextLabel") then
                    v131.RichText = true;
                    v131.Text = v130;
                end;
            end;
            u78(u119.userId, function(p132) --[[ Line: 631 ]]
                -- upvalues: u128 (copy)
                if u128.Parent then
                    local v133 = u128;
                    if not v133 then
                        return;
                    end;
                    v133.RichText = true;
                    v133.Text = p132;
                    local v134 = v133:FindFirstChild("TextLabel");
                    if v134 and v134:IsA("TextLabel") then
                        v134.RichText = true;
                        v134.Text = p132;
                    end;
                end;
            end);
        end;
        local v135 = v123:FindFirstChild("Role_Rank");
        if v135 and v135:IsA("TextLabel") then
            v135.RichText = true;
            v135.Text = string.format("%s | #%d", u119.role, p118);
        end;
        local v136 = v123:FindFirstChild("Contributions");
        if v136 then
            v136 = v136:FindFirstChild("Weekly");
        end;
        if v136 then
            v136 = v136:FindFirstChild("TextLabel");
        end;
        if v136 and v136:IsA("TextLabel") then
            v136.RichText = true;
            local l__format__15 = string.format;
            local v137 = "<font color=\"#F9D100\">%s</font>";
            local l__FormatScore__16 = l__GuildCompetition__4.FormatScore;
            local v138 = tonumber(u119.weeklyShekels);
            local v139 = u40;
            local v140;
            if typeof(v139) == "table" then
                local v141;
                if typeof(v139.config) == "table" then
                    v141 = v139.config;
                else
                    v141 = v139.lastConfig;
                end;
                if typeof(v141) == "table" and typeof(v141.scoreFormat) == "string" then
                    v140 = v141.scoreFormat;
                else
                    v140 = nil;
                end;
            else
                v140 = nil;
            end;
            v136.Text = l__format__15(v137, l__FormatScore__16(v138, v140) .. "kg");
        end;
        local v142 = v123:FindFirstChild("PlayerDisplay");
        local u143;
        if v142 then
            u143 = v142:FindFirstChild("MemberImage");
        else
            u143 = v142;
        end;
        if u143 and u143:IsA("ImageLabel") then
            local l__userId__17 = u119.userId;
            local function u145(p144) --[[ Line: 660 ]]
                -- upvalues: u143 (copy)
                if u143.Parent then
                    u143.Image = p144;
                end;
            end;
            if u34[l__userId__17] then
                local v146 = u34[l__userId__17];
                if u143.Parent then
                    u143.Image = v146;
                end;
            else
                task.spawn(function() --[[ Line: 357 ]]
                    -- upvalues: l__Players__1 (ref), l__userId__17 (copy), u34 (ref), u145 (copy)
                    local v147, v148 = pcall(function() --[[ Line: 358 ]]
                        -- upvalues: l__Players__1 (ref), l__userId__17 (ref)
                        return l__Players__1:GetUserThumbnailAsync(l__userId__17, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
                    end);
                    if v147 and typeof(v148) == "string" then
                        u34[l__userId__17] = v148;
                        u145(v148);
                    end;
                end);
            end;
        end;
        local v149;
        if v142 then
            v149 = v142:FindFirstChild("GuildOwnerIcon");
        else
            v149 = v142;
        end;
        if v149 and v149:IsA("ImageLabel") then
            v149.Visible = u124;
        end;
        if v142 then
            v142 = v142:FindFirstChild("Status");
        end;
        if v142 and v142:IsA("Frame") then
            local v150 = u38[typeof(u120) == "table" and (tostring(u120.GuildId or "") or "") or ""];
            local v151 = u119.userId == l__LocalPlayer__6.UserId;
            local v152 = l__Players__1:GetPlayerByUserId(u119.userId) ~= nil;
            local v153;
            if v150 == nil then
                v153 = false;
            else
                v153 = v150[u119.userId] == true;
            end;
            local v154;
            if v151 or (v152 or v153) then
                v154 = u45;
            else
                v154 = u46;
            end;
            v142.BackgroundColor3 = v154;
        end;
        local v155 = v123:FindFirstChild("KickButton");
        if v155 and v155:IsA("GuiButton") then
            local v156;
            if v127 then
                v156 = not v126;
            else
                v156 = v127;
            end;
            v155.Visible = v156;
            if v156 then
                local v170 = v155.MouseButton1Click:Connect(function() --[[ Line: 700 ]]
                    -- upvalues: u122 (copy), u19 (ref), u120 (copy), u29 (ref), u20 (ref), l__Networking__3 (ref), u119 (copy), l__NotificationController__9 (ref), u115 (ref), l__Players__1 (ref), u33 (ref)
                    if u122.Parent then
                        u122:Destroy();
                        if u19 and typeof(u120) == "table" then
                            local v157 = 0;
                            for _, v158 in u29 do
                                if v158.Parent then
                                    v157 = v157 + 1;
                                end;
                            end;
                            local v159 = tonumber(u120.MaxSlots) or 0;
                            local v160 = string.format("%d/%d", v157, v159);
                            local v161 = u19;
                            if v161 then
                                v161.RichText = true;
                                v161.Text = v160;
                                local v162 = v161:FindFirstChild("TextLabel");
                                if v162 and v162:IsA("TextLabel") then
                                    v162.RichText = true;
                                    v162.Text = v160;
                                end;
                            end;
                            if u20 then
                                u20.RichText = true;
                                u20.Text = v160;
                            end;
                        end;
                        task.spawn(function() --[[ Line: 728 ]]
                            -- upvalues: l__Networking__3 (ref), u119 (ref), l__NotificationController__9 (ref), u115 (ref), l__Players__1 (ref), u33 (ref)
                            local v163, v164, v165 = pcall(function() --[[ Line: 729 ]]
                                -- upvalues: l__Networking__3 (ref), u119 (ref)
                                return l__Networking__3.Guild.Kick:Fire(u119.userId);
                            end);
                            if v163 and v164 then
                                local v166 = l__NotificationController__9;
                                local l__format__18 = string.format;
                                local v167 = "Kicked %s";
                                local l__userId__19 = u119.userId;
                                local v168 = l__Players__1:GetPlayerByUserId(l__userId__19);
                                local v169;
                                if v168 then
                                    v169 = v168.Name;
                                else
                                    v169 = nil;
                                end;
                                if v169 then
                                    u33[l__userId__19] = v169;
                                elseif u33[l__userId__19] then
                                    v169 = u33[l__userId__19];
                                else
                                    v169 = tostring(l__userId__19);
                                end;
                                v166:CreateNotification(l__format__18(v167, v169));
                                u115();
                            else
                                l__NotificationController__9:CreateNotification((typeof(v165) ~= "string" or (v165 == "" or not v165)) and "Could not kick that member" or v165);
                                u115();
                            end;
                        end);
                    end;
                end);
                table.insert(u30, v170);
            end;
        end;
        local v171 = v123:FindFirstChild("RankButton");
        if v171 and v171:IsA("GuiButton") then
            local v172 = v127 and not v126;
            if v172 then
                v172 = not u124;
                if v172 then
                    v172 = not v125;
                end;
            end;
            v171.Visible = v172;
            if v172 then
                local v181 = v171.MouseButton1Click:Connect(function() --[[ Line: 780 ]]
                    -- upvalues: u120 (copy), l__NotificationController__9 (ref), l__Networking__3 (ref), u119 (copy), u115 (ref)
                    local v173 = 0;
                    if typeof(u120) == "table" and typeof(u120.Members) == "table" then
                        for _, v174 in u120.Members do
                            if v174.Role == "Elder" then
                                v173 = v173 + 1;
                            end;
                        end;
                    end;
                    if v173 >= 5 then
                        l__NotificationController__9:CreateNotification(string.format("You already have %d/%d elders ranked!", 5, 5));
                    else
                        local u175 = 0;
                        if typeof(u120) == "table" and typeof(u120.Members) == "table" then
                            for _, v176 in u120.Members do
                                if v176.Role == "Elder" then
                                    u175 = u175 + 1;
                                end;
                            end;
                        end;
                        task.spawn(function() --[[ Line: 797 ]]
                            -- upvalues: l__Networking__3 (ref), u119 (ref), l__NotificationController__9 (ref), u175 (copy), u115 (ref)
                            local v177, v178, v179 = pcall(function() --[[ Line: 798 ]]
                                -- upvalues: l__Networking__3 (ref), u119 (ref)
                                return l__Networking__3.Guild.Promote:Fire(u119.userId);
                            end);
                            if v177 and v178 then
                                local v180 = math.min(u175 + 1, 5);
                                l__NotificationController__9:CreateNotification(string.format("You ranked %d/%d elders!", v180, 5));
                                u115();
                            elseif typeof(v179) == "string" and v179 == "elder_limit_reached" then
                                l__NotificationController__9:CreateNotification(string.format("You already have %d/%d elders ranked!", 5, 5));
                            else
                                l__NotificationController__9:CreateNotification((typeof(v179) ~= "string" or (v179 == "" or not v179)) and "Could not rank that member" or v179);
                            end;
                        end);
                    end;
                end);
                table.insert(u30, v181);
            end;
        end;
        local v182 = v123:FindFirstChild("UnRankButton");
        if v182 and v182:IsA("GuiButton") then
            if v127 then
                local v183 = not v126;
                if not v183 then
                    v125 = v183;
                end;
            else
                v125 = v127;
            end;
            v182.Visible = v125;
            if v125 then
                local v191 = v182.MouseButton1Click:Connect(function() --[[ Line: 834 ]]
                    -- upvalues: l__Networking__3 (ref), u119 (copy), l__NotificationController__9 (ref), l__Players__1 (ref), u33 (ref), u115 (ref)
                    task.spawn(function() --[[ Line: 835 ]]
                        -- upvalues: l__Networking__3 (ref), u119 (ref), l__NotificationController__9 (ref), l__Players__1 (ref), u33 (ref), u115 (ref)
                        local v184, v185, v186 = pcall(function() --[[ Line: 836 ]]
                            -- upvalues: l__Networking__3 (ref), u119 (ref)
                            return l__Networking__3.Guild.Demote:Fire(u119.userId);
                        end);
                        if v184 and v185 then
                            local v187 = l__NotificationController__9;
                            local l__format__20 = string.format;
                            local v188 = "Unranked %s from Elder";
                            local l__userId__21 = u119.userId;
                            local v189 = l__Players__1:GetPlayerByUserId(l__userId__21);
                            local v190;
                            if v189 then
                                v190 = v189.Name;
                            else
                                v190 = nil;
                            end;
                            if v190 then
                                u33[l__userId__21] = v190;
                            elseif u33[l__userId__21] then
                                v190 = u33[l__userId__21];
                            else
                                v190 = tostring(l__userId__21);
                            end;
                            v187:CreateNotification(l__format__20(v188, v190));
                            u115();
                        else
                            l__NotificationController__9:CreateNotification((typeof(v186) ~= "string" or (v186 == "" or not v186)) and "Could not unrank that member" or v186);
                        end;
                    end);
                end);
                table.insert(u30, v191);
            end;
        end;
        local v192 = v123:FindFirstChild("LeaveButton");
        if v192 and v192:IsA("GuiButton") then
            v192.Visible = v126;
            if v126 then
                local v193 = u124 and "Disband" or "Leave";
                local v194 = v192:FindFirstChild("TextLabel");
                if v194 and (v194:IsA("TextLabel") and v194) then
                    v194.RichText = true;
                    v194.Text = v193;
                    local v195 = v194:FindFirstChild("TextLabel");
                    if v195 and v195:IsA("TextLabel") then
                        v195.RichText = true;
                        v195.Text = v193;
                    end;
                end;
                local v200 = v192.MouseButton1Click:Connect(function() --[[ Line: 866 ]]
                    -- upvalues: u120 (copy), u124 (copy), l__LeaveGuildController__11 (ref)
                    local v196;
                    if typeof(u120) == "table" then
                        v196 = {};
                        local v197;
                        if typeof(u120.Name) == "string" then
                            v197 = u120.Name;
                        else
                            v197 = nil;
                        end;
                        v196.Name = v197;
                        local v198;
                        if typeof(u120.Tag) == "string" then
                            v198 = u120.Tag;
                        else
                            v198 = nil;
                        end;
                        v196.Tag = v198;
                        local v199;
                        if typeof(u120.Color) == "string" then
                            v199 = u120.Color;
                        else
                            v199 = nil;
                        end;
                        v196.Color = v199;
                        v196.IsOwner = u124;
                    else
                        v196 = nil;
                    end;
                    l__LeaveGuildController__11:Open(v196);
                end);
                table.insert(u30, v200);
            end;
        end;
    end;
end;
local function u217(_, p202, p203) --[[ Line: 892 ]]
    -- upvalues: u23 (ref), u24 (ref), u1 (copy), l__DevProductController__10 (copy)
    if not u23 then
        return;
    end;
    local v204 = p202 and tonumber(p202.MaxSlots) or 0;
    local v205 = v204 >= 50;
    local v206 = p203 == "Owner";
    local v207 = u23;
    if v206 then
        v206 = not v205;
    end;
    v207.Visible = v206;
    u23.LayoutOrder = 1000000;
    local v208 = u23:FindFirstChild("ContainerFrame");
    if v208 then
        v208 = v208:FindFirstChild("Contributions");
    end;
    if v208 then
        local v209 = v208:FindFirstChild("AddMemberSlotsTextLabel");
        if v209 and v209:IsA("TextLabel") then
            v209.Text = string.format("+%d MEMBER SLOTS", 5);
        end;
    end;
    if u24 then
        local v210 = u24:FindFirstChild("TextLabel");
        if not (v210 and v210:IsA("TextLabel")) then
            return;
        end;
        local v211, v212, v213, v214;
        for _, v216 in u1 do
            if v216.From <= v204 and v204 < v216.To then
                if v216 then
                    v211 = l__DevProductController__10:GetPreloadedProductInfo(v216.Key);
                    v212 = v211 and tonumber(v211.PriceInRobux) or v216.FallbackPrice;
                    v213 = string.format("%d R$", v212);
                else
                    v213 = "MAX";
                end;
                if not v210 then
                    return;
                end;
                v210.RichText = true;
                v210.Text = v213;
                v214 = v210:FindFirstChild("TextLabel");
                if v214 and v214:IsA("TextLabel") then
                    v214.RichText = true;
                    v214.Text = v213;
                end;
                return;
            end;
        end;
        local v216 = nil;
        if v216 then
            v211 = l__DevProductController__10:GetPreloadedProductInfo(v216.Key);
            v212 = v211 and tonumber(v211.PriceInRobux) or v216.FallbackPrice;
            v213 = string.format("%d R$", v212);
        else
            v213 = "MAX";
        end;
        if not v210 then
            return;
        end;
        v210.RichText = true;
        v210.Text = v213;
        v214 = v210:FindFirstChild("TextLabel");
        if v214 and v214:IsA("TextLabel") then
            v214.RichText = true;
            v214.Text = v213;
        end;
    end;
end;
local function u227(p218) --[[ Line: 924 ]]
    -- upvalues: u35 (ref), u38 (copy), u29 (copy), l__LocalPlayer__6 (copy), l__Players__1 (copy), u45 (copy), u46 (copy)
    if u35 then
        local v219 = u38[p218];
        for _, v220 in u29 do
            if v220.Parent then
                local v221 = v220:FindFirstChild("ContainerFrame");
                if v221 then
                    v221 = v221:FindFirstChild("PlayerDisplay");
                end;
                if v221 then
                    v221 = v221:FindFirstChild("Status");
                end;
                if v221 and v221:IsA("Frame") then
                    local v222 = string.match(v220.Name, "^Member_(%d+)$");
                    if v222 then
                        v222 = tonumber(v222);
                    end;
                    if v222 then
                        local v223 = v222 == l__LocalPlayer__6.UserId;
                        local v224 = l__Players__1:GetPlayerByUserId(v222) ~= nil;
                        local v225;
                        if v219 == nil then
                            v225 = false;
                        else
                            v225 = v219[v222] == true;
                        end;
                        local v226;
                        if v223 or (v224 or v225) then
                            v226 = u45;
                        else
                            v226 = u46;
                        end;
                        v221.BackgroundColor3 = v226;
                    end;
                end;
            end;
        end;
    end;
end;
local function u239(p228, p229) --[[ Line: 954 ]]
    -- upvalues: u38 (copy), l__LocalPlayer__6 (copy), l__Players__1 (copy)
    local v230 = u38[p228];
    local v231 = {};
    local v232 = 0;
    if typeof(p229) == "table" then
        for v233 in p229 do
            local v234 = tonumber(v233);
            if v234 and not v231[v234] then
                local v235 = v234 == l__LocalPlayer__6.UserId;
                local v236 = l__Players__1:GetPlayerByUserId(v234) ~= nil;
                local v237;
                if v230 == nil then
                    v237 = false;
                else
                    v237 = v230[v234] == true;
                end;
                if v235 or (v236 or v237) then
                    v231[v234] = true;
                    v232 = v232 + 1;
                end;
            end;
        end;
    end;
    if v230 then
        for v238 in v230 do
            if not v231[v238] then
                v232 = v232 + 1;
            end;
        end;
    end;
    return v232;
end;
local function u256() --[[ Line: 1036 ]]
    -- upvalues: u8 (ref), u40 (ref), u9 (ref)
    if u8 then
        local v240 = u40;
        local v241;
        if typeof(v240) == "table" then
            v241 = v240.phase;
        else
            v241 = nil;
        end;
        if v241 == "running" and (typeof(v240.config) == "table" and (typeof(v240.config.displayName) == "string" and v240.config.displayName ~= "")) then
            local v242 = u8;
            local l__displayName__22 = v240.config.displayName;
            if v242 then
                v242.RichText = true;
                v242.Text = l__displayName__22;
                local v243 = v242:FindFirstChild("TextLabel");
                if v243 and v243:IsA("TextLabel") then
                    v243.RichText = true;
                    v243.Text = l__displayName__22;
                end;
            end;
        elseif v241 == "pending" then
            local v244 = u8;
            if v244 then
                v244.RichText = true;
                v244.Text = "Upcoming Competition";
                local v245 = v244:FindFirstChild("TextLabel");
                if v245 and v245:IsA("TextLabel") then
                    v245.RichText = true;
                    v245.Text = "Upcoming Competition";
                end;
            end;
        else
            local v246 = u8;
            local v247 = v240 == nil and "Loading..." or "No Active Competition";
            if v246 then
                v246.RichText = true;
                v246.Text = v247;
                local v248 = v246:FindFirstChild("TextLabel");
                if v248 and v248:IsA("TextLabel") then
                    v248.RichText = true;
                    v248.Text = v247;
                end;
            end;
        end;
        if u9 then
            if v241 == "running" and (typeof(v240.config) == "table" and typeof(v240.config.description) == "table") then
                local v249 = {};
                for _, v250 in v240.config.description do
                    if typeof(v250) == "string" then
                        table.insert(v249, v250);
                    end;
                end;
                local v251 = u9;
                local v252 = table.concat(v249, "\n");
                if not v251 then
                    return;
                end;
                v251.RichText = true;
                v251.Text = v252;
                local v253 = v251:FindFirstChild("TextLabel");
                if v253 and v253:IsA("TextLabel") then
                    v253.RichText = true;
                    v253.Text = v252;
                end;
            else
                local v254 = u9;
                if not v254 then
                    return;
                end;
                v254.RichText = true;
                v254.Text = "";
                local v255 = v254:FindFirstChild("TextLabel");
                if v255 and v255:IsA("TextLabel") then
                    v255.RichText = true;
                    v255.Text = "";
                end;
            end;
        end;
    end;
end;
local function u273() --[[ Line: 1070 ]]
    -- upvalues: u14 (ref), u43 (ref), u44 (ref), u88 (copy), l__GuildCompetition__4 (copy), u40 (ref), u85 (copy)
    if u14 then
        local v257 = u43;
        if typeof(v257) == "string" and v257 ~= "" then
            local v258 = u44;
            local v259 = u88(v257);
            if v259 then
                if v258 >= v259 then
                    v259 = v258;
                end;
            else
                v259 = v258;
            end;
            local l__FormatScore__23 = l__GuildCompetition__4.FormatScore;
            local v260 = u40;
            local v261;
            if typeof(v260) == "table" then
                local v262;
                if typeof(v260.config) == "table" then
                    v262 = v260.config;
                else
                    v262 = v260.lastConfig;
                end;
                if typeof(v262) == "table" and typeof(v262.scoreFormat) == "string" then
                    v261 = v262.scoreFormat;
                else
                    v261 = nil;
                end;
            else
                v261 = nil;
            end;
            local v263 = l__FormatScore__23(v259, v261) .. "kg";
            local v264 = u85(v257);
            if v264 then
                local v265 = u14;
                local v266 = ("Score: %s  •  Rank #%d"):format(v263, v264);
                if not v265 then
                    return;
                end;
                v265.RichText = true;
                v265.Text = v266;
                local v267 = v265:FindFirstChild("TextLabel");
                if v267 and v267:IsA("TextLabel") then
                    v267.RichText = true;
                    v267.Text = v266;
                end;
            else
                local v268 = u14;
                local v269 = "Score: " .. v263;
                if not v268 then
                    return;
                end;
                v268.RichText = true;
                v268.Text = v269;
                local v270 = v268:FindFirstChild("TextLabel");
                if v270 and v270:IsA("TextLabel") then
                    v270.RichText = true;
                    v270.Text = v269;
                end;
            end;
        else
            local v271 = u14;
            if v271 then
                v271.RichText = true;
                v271.Text = "Score: 0";
                local v272 = v271:FindFirstChild("TextLabel");
                if v272 and v272:IsA("TextLabel") then
                    v272.RichText = true;
                    v272.Text = "Score: 0";
                end;
            end;
        end;
    end;
end;
local function u293() --[[ Line: 1094 ]]
    -- upvalues: u5 (ref), u47 (ref), u42 (ref), l__Networking__3 (copy), u40 (ref), u41 (ref), u49 (ref), u6 (ref), u7 (ref), u57 (copy), u10 (ref), u256 (copy)
    if u5 then
        local v274 = u5;
        local v275 = u47 and "Viewing Guild" or "My Guild";
        if v274 then
            v274.RichText = true;
            v274.Text = v275;
            local v276 = v274:FindFirstChild("TextLabel");
            if v276 and v276:IsA("TextLabel") then
                v276.RichText = true;
                v276.Text = v275;
            end;
        end;
    end;
    local v277 = os.clock();
    if v277 - u42 >= 15 then
        u42 = v277;
        task.spawn(function() --[[ Line: 240 ]]
            -- upvalues: l__Networking__3 (ref), u40 (ref), u41 (ref), u49 (ref)
            local v278, v279 = pcall(function() --[[ Line: 241 ]]
                -- upvalues: l__Networking__3 (ref)
                return l__Networking__3.Guild.GetCompetition:Fire();
            end);
            if v278 and typeof(v279) == "table" then
                local v280 = u40;
                local v281;
                if typeof(v280) == "table" then
                    local v282;
                    if typeof(v280.config) == "table" then
                        v282 = v280.config;
                    else
                        v282 = v280.lastConfig;
                    end;
                    if typeof(v282) == "table" and typeof(v282.scoreFormat) == "string" then
                        v281 = v282.scoreFormat;
                    else
                        v281 = nil;
                    end;
                else
                    v281 = nil;
                end;
                u40 = v279;
                if v279.phase == "running" and typeof(v279.endsAt) == "number" then
                    u41 = v279.endsAt;
                elseif v279.phase == "pending" and typeof(v279.startsAt) == "number" then
                    u41 = v279.startsAt;
                else
                    u41 = nil;
                end;
                local v283 = u40;
                local v284;
                if typeof(v283) == "table" then
                    local v285;
                    if typeof(v283.config) == "table" then
                        v285 = v283.config;
                    else
                        v285 = v283.lastConfig;
                    end;
                    if typeof(v285) == "table" and typeof(v285.scoreFormat) == "string" then
                        v284 = v285.scoreFormat;
                    else
                        v284 = nil;
                    end;
                else
                    v284 = nil;
                end;
                local v286 = v284 ~= v281 and u49;
                if v286 then
                    v286();
                end;
            end;
        end);
    end;
    local v287 = os.time();
    local v288;
    if u41 and v287 < u41 then
        v288 = u41;
    else
        v288 = nil;
    end;
    if u6 then
        u6.Visible = v288 ~= nil;
    end;
    if v288 then
        if u7 then
            local v289 = u7;
            local v290 = u57(v288 - v287);
            if v289 then
                v289.RichText = true;
                v289.Text = v290;
                local v291 = v289:FindFirstChild("TextLabel");
                if v291 and v291:IsA("TextLabel") then
                    v291.RichText = true;
                    v291.Text = v290;
                end;
            end;
        end;
        if u10 then
            local v292 = math.clamp((v287 - (v288 - 604800)) / 604800, 0, 1);
            u10.Offset = Vector2.new(v292 + -0.5, 0);
        end;
    end;
    u256();
end;
local function u329(p294) --[[ Line: 1125 ]]
    -- upvalues: u28 (ref), u101 (copy), u81 (copy), u13 (ref), u43 (ref), u44 (ref), u273 (copy), u18 (ref), u19 (ref), u20 (ref), u23 (ref), u17 (ref), l__Asserts__5 (copy), u98 (copy), u27 (copy), u239 (copy), u15 (ref), u16 (ref), u21 (ref), u22 (ref), u114 (copy), u201 (copy), u217 (copy), u39 (copy), l__Networking__3 (copy), u38 (copy), u227 (copy)
    u28 = p294;
    if p294 and typeof(p294) == "table" then
        local l__Guild__24 = p294.Guild;
        local l__Role__25 = p294.Role;
        u98(l__Guild__24);
        local l__IconId__26 = l__Guild__24.IconId;
        if u17 then
            if typeof(l__IconId__26) ~= "number" then
                l__IconId__26 = nil;
            end;
            u17.Image = l__Asserts__5.IconAssetString(l__IconId__26);
        end;
        local v295 = u13;
        local v296 = tostring(l__Guild__24.Description or "");
        if v295 then
            v295.RichText = false;
            v295.Text = v296;
            local v297 = v295:FindFirstChild("TextLabel");
            if v297 and v297:IsA("TextLabel") then
                v297.RichText = false;
                v297.Text = v296;
            end;
        end;
        local u298 = tostring(l__Guild__24.GuildId or "");
        local v299 = u27[u298];
        local v300 = 0;
        if typeof(v299) == "table" then
            for _, v301 in v299 do
                v300 = v300 + (tonumber(v301.shekels or v301.Shekels) or 0);
            end;
        end;
        u43 = u298;
        u44 = v300;
        u273();
        local v302 = 0;
        if typeof(l__Guild__24.Members) == "table" then
            for _ in l__Guild__24.Members do
                v302 = v302 + 1;
            end;
        end;
        local v303 = tonumber(l__Guild__24.MaxSlots) or 0;
        local v304 = string.format("%d/%d", v302, v303);
        local v305 = u19;
        if v305 then
            v305.RichText = true;
            v305.Text = v304;
            local v306 = v305:FindFirstChild("TextLabel");
            if v306 and v306:IsA("TextLabel") then
                v306.RichText = true;
                v306.Text = v304;
            end;
        end;
        if u20 then
            u20.RichText = true;
            u20.Text = v304;
        end;
        local l__Members__27 = l__Guild__24.Members;
        if u18 and u18.Parent then
            local v307 = u239(u298, l__Members__27);
            local v308 = u18;
            local v309 = string.format("Members (%d online)", v307);
            if v308 then
                v308.RichText = true;
                v308.Text = v309;
                local v310 = v308:FindFirstChild("TextLabel");
                if v310 and v310:IsA("TextLabel") then
                    v310.RichText = true;
                    v310.Text = v309;
                end;
            end;
        end;
        if u15 then
            u15.Visible = l__Role__25 == "Owner";
        end;
        if u16 then
            u16.Visible = l__Role__25 == "Owner" and true or l__Role__25 == "Elder";
        end;
        u101();
        if u21 and u22 then
            for v311, v312 in u114(l__Guild__24, v299) do
                u201(u22, u21, v311, v312, l__Guild__24, l__Role__25);
            end;
        end;
        if u21 then
            u217(u21, l__Guild__24, l__Role__25);
        end;
        if u298 == "" then
        elseif u39[u298] then
        else
            u39[u298] = true;
            task.spawn(function() --[[ Line: 1001 ]]
                -- upvalues: l__Networking__3 (ref), u298 (copy), u39 (ref), u38 (ref), u227 (ref), u28 (ref), u18 (ref), u239 (ref)
                local v313, v314 = pcall(function() --[[ Line: 1002 ]]
                    -- upvalues: l__Networking__3 (ref), u298 (ref)
                    return l__Networking__3.Guild.GetOnlineMembers:Fire(u298);
                end);
                u39[u298] = nil;
                if v313 and typeof(v314) == "table" then
                    local v315 = {};
                    for _, v316 in v314 do
                        local v317 = tonumber(v316);
                        if v317 then
                            v315[v317] = true;
                        end;
                    end;
                    u38[u298] = v315;
                    u227(u298);
                    if u28 and (u28.Guild and tostring(u28.Guild.GuildId or "") == u298) then
                        local v318 = u298;
                        local l__Members__28 = u28.Guild.Members;
                        if u18 then
                            if not u18.Parent then
                                return;
                            end;
                            local v319 = u239(v318, l__Members__28);
                            local v320 = u18;
                            local v321 = string.format("Members (%d online)", v319);
                            if not v320 then
                                return;
                            end;
                            v320.RichText = true;
                            v320.Text = v321;
                            local v322 = v320:FindFirstChild("TextLabel");
                            if v322 and v322:IsA("TextLabel") then
                                v322.RichText = true;
                                v322.Text = v321;
                            end;
                        end;
                    end;
                end;
            end);
        end;
    else
        u101();
        u81("");
        local v323 = u13;
        if v323 then
            v323.RichText = false;
            v323.Text = "";
            local v324 = v323:FindFirstChild("TextLabel");
            if v324 and v324:IsA("TextLabel") then
                v324.RichText = false;
                v324.Text = "";
            end;
        end;
        u43 = nil;
        u44 = 0;
        u273();
        local v325 = u18;
        if v325 then
            v325.RichText = true;
            v325.Text = "Members (SOON)";
            local v326 = v325:FindFirstChild("TextLabel");
            if v326 and v326:IsA("TextLabel") then
                v326.RichText = true;
                v326.Text = "Members (SOON)";
            end;
        end;
        local v327 = u19;
        if v327 then
            v327.RichText = true;
            v327.Text = "0/0";
            local v328 = v327:FindFirstChild("TextLabel");
            if v328 and v328:IsA("TextLabel") then
                v328.RichText = true;
                v328.Text = "0/0";
            end;
        end;
        if u20 then
            u20.RichText = true;
            u20.Text = "0/0";
        end;
        if u23 then
            u23.Visible = false;
        end;
        if u17 then
            u17.Image = l__Asserts__5.IconAssetString(nil);
        end;
    end;
end;
local function u371(p330) --[[ Line: 1221 ]]
    -- upvalues: u28 (ref), u101 (copy), u81 (copy), u13 (ref), u43 (ref), u44 (ref), u273 (copy), u18 (ref), u19 (ref), u20 (ref), u23 (ref), u17 (ref), l__Asserts__5 (copy), u98 (copy), u25 (ref), u239 (copy), u15 (ref), u16 (ref), u21 (ref), u22 (ref), u114 (copy), u201 (copy), u39 (copy), l__Networking__3 (copy), u38 (copy), u227 (copy)
    if not p330 or typeof(p330) ~= "table" then
        u28 = nil;
        u101();
        u81("");
        local v331 = u13;
        if v331 then
            v331.RichText = false;
            v331.Text = "";
            local v332 = v331:FindFirstChild("TextLabel");
            if v332 and v332:IsA("TextLabel") then
                v332.RichText = false;
                v332.Text = "";
            end;
        end;
        u43 = nil;
        u44 = 0;
        u273();
        local v333 = u18;
        if v333 then
            v333.RichText = true;
            v333.Text = "Members (SOON)";
            local v334 = v333:FindFirstChild("TextLabel");
            if v334 and v334:IsA("TextLabel") then
                v334.RichText = true;
                v334.Text = "Members (SOON)";
            end;
        end;
        local v335 = u19;
        if v335 then
            v335.RichText = true;
            v335.Text = "0/0";
            local v336 = v335:FindFirstChild("TextLabel");
            if v336 and v336:IsA("TextLabel") then
                v336.RichText = true;
                v336.Text = "0/0";
            end;
        end;
        if u20 then
            u20.RichText = true;
            u20.Text = "0/0";
        end;
        if u23 then
            u23.Visible = false;
        end;
        if u17 then
            u17.Image = l__Asserts__5.IconAssetString(nil);
            return;
        else
            return;
        end;
    end;
    u28 = {
        Role = "Visitor",
        Guild = p330
    };
    u98(p330);
    local l__IconId__29 = p330.IconId;
    if u17 then
        if typeof(l__IconId__29) ~= "number" then
            l__IconId__29 = nil;
        end;
        u17.Image = l__Asserts__5.IconAssetString(l__IconId__29);
    end;
    local v337 = u13;
    local v338 = tostring(p330.Description or "");
    if v337 then
        v337.RichText = false;
        v337.Text = v338;
        local v339 = v337:FindFirstChild("TextLabel");
        if v339 and v339:IsA("TextLabel") then
            v339.RichText = false;
            v339.Text = v338;
        end;
    end;
    local u340 = tostring(p330.GuildId or "");
    local v341 = tonumber(p330.WeeklyShekels) or 0;
    if v341 == 0 then
        for _, v342 in u25 do
            if (v342.guildId or v342.GuildId) == u340 then
                v341 = tonumber(v342.shekels or v342.Shekels) or 0;
                break;
            end;
        end;
    end;
    u43 = u340;
    u44 = v341;
    u273();
    local v343 = tonumber(p330.MemberCount) or 0;
    local v344 = tonumber(p330.MaxSlots) or 0;
    local v345 = string.format("%d/%d", v343, v344);
    local v346 = u19;
    if v346 then
        v346.RichText = true;
        v346.Text = v345;
        local v347 = v346:FindFirstChild("TextLabel");
        if v347 and v347:IsA("TextLabel") then
            v347.RichText = true;
            v347.Text = v345;
        end;
    end;
    if u20 then
        u20.RichText = true;
        u20.Text = v345;
    end;
    local l__Members__30 = p330.Members;
    if u18 and u18.Parent then
        local v348 = u239(u340, l__Members__30);
        local v349 = u18;
        local v350 = string.format("Members (%d online)", v348);
        if v349 then
            v349.RichText = true;
            v349.Text = v350;
            local v351 = v349:FindFirstChild("TextLabel");
            if v351 and v351:IsA("TextLabel") then
                v351.RichText = true;
                v351.Text = v350;
            end;
        end;
    end;
    if u15 then
        u15.Visible = false;
    end;
    if u16 then
        u16.Visible = false;
    end;
    if u23 then
        u23.Visible = false;
    end;
    u101();
    if u21 and (u22 and typeof(p330.Members) == "table") then
        local v352 = {
            GuildId = p330.GuildId,
            LeaderUserId = p330.LeaderUserId,
            Members = p330.Members
        };
        local v353 = {};
        for v354, v355 in p330.Members do
            local v356 = tonumber(v354);
            if v356 then
                local v357 = {
                    userId = v356,
                    shekels = tonumber(v355.WeeklyContribution) or 0
                };
                local v358;
                if typeof(v355.Name) == "string" then
                    v358 = v355.Name;
                else
                    v358 = nil;
                end;
                v357.name = v358;
                table.insert(v353, v357);
            end;
        end;
        for v359, v360 in u114(v352, v353) do
            u201(u22, u21, v359, v360, v352, "Visitor");
        end;
    end;
    if u340 == "" then
    elseif u39[u340] then
    else
        u39[u340] = true;
        task.spawn(function() --[[ Line: 1001 ]]
            -- upvalues: l__Networking__3 (ref), u340 (copy), u39 (ref), u38 (ref), u227 (ref), u28 (ref), u18 (ref), u239 (ref)
            local v361, v362 = pcall(function() --[[ Line: 1002 ]]
                -- upvalues: l__Networking__3 (ref), u340 (ref)
                return l__Networking__3.Guild.GetOnlineMembers:Fire(u340);
            end);
            u39[u340] = nil;
            if v361 and typeof(v362) == "table" then
                local v363 = {};
                for _, v364 in v362 do
                    local v365 = tonumber(v364);
                    if v365 then
                        v363[v365] = true;
                    end;
                end;
                u38[u340] = v363;
                u227(u340);
                if u28 and (u28.Guild and tostring(u28.Guild.GuildId or "") == u340) then
                    local v366 = u340;
                    local l__Members__31 = u28.Guild.Members;
                    if u18 then
                        if not u18.Parent then
                            return;
                        end;
                        local v367 = u239(v366, l__Members__31);
                        local v368 = u18;
                        local v369 = string.format("Members (%d online)", v367);
                        if not v368 then
                            return;
                        end;
                        v368.RichText = true;
                        v368.Text = v369;
                        local v370 = v368:FindFirstChild("TextLabel");
                        if v370 and v370:IsA("TextLabel") then
                            v370.RichText = true;
                            v370.Text = v369;
                        end;
                    end;
                end;
            end;
        end);
    end;
end;
u49 = function() --[[ Line: 1312 ]]
    -- upvalues: u35 (ref), u28 (ref), u47 (ref), u371 (copy), u329 (copy), u273 (copy)
    if u35 then
        local v372 = u28;
        if u47 then
            if typeof(v372) == "table" and v372.Guild then
                u371(v372.Guild);
            end;
        else
            if v372 ~= nil then
                u329(v372);
                return;
            end;
            u273();
        end;
    end;
end;
u115 = function() --[[ Name: fetchAndRender, Line 1346 ]]
    -- upvalues: u47 (ref), l__Networking__3 (copy), u35 (ref), u371 (copy), u28 (ref), u101 (copy), u81 (copy), u13 (ref), u43 (ref), u44 (ref), u273 (copy), u18 (ref), u19 (ref), u20 (ref), u23 (ref), u17 (ref), l__Asserts__5 (copy), u25 (ref), u26 (ref), u98 (copy), u27 (copy), u329 (copy)
    local u373 = u47;
    task.spawn(function() --[[ Line: 1348 ]]
        -- upvalues: u373 (copy), l__Networking__3 (ref), u35 (ref), u371 (ref), u28 (ref), u101 (ref), u81 (ref), u13 (ref), u43 (ref), u44 (ref), u273 (ref), u18 (ref), u19 (ref), u20 (ref), u23 (ref), u17 (ref), l__Asserts__5 (ref), u25 (ref), u26 (ref), u98 (ref), u27 (ref), u329 (ref)
        if u373 then
            local v374, v375 = pcall(function() --[[ Line: 1350 ]]
                -- upvalues: l__Networking__3 (ref), u373 (ref)
                return l__Networking__3.Guild.GetGuildById:Fire(u373);
            end);
            if u35 then
                if v374 and v375 then
                    u371(v375);
                else
                    u28 = nil;
                    u101();
                    u81("");
                    local v376 = u13;
                    if v376 then
                        v376.RichText = false;
                        v376.Text = "";
                        local v377 = v376:FindFirstChild("TextLabel");
                        if v377 and v377:IsA("TextLabel") then
                            v377.RichText = false;
                            v377.Text = "";
                        end;
                    end;
                    u43 = nil;
                    u44 = 0;
                    u273();
                    local v378 = u18;
                    if v378 then
                        v378.RichText = true;
                        v378.Text = "Members (SOON)";
                        local v379 = v378:FindFirstChild("TextLabel");
                        if v379 and v379:IsA("TextLabel") then
                            v379.RichText = true;
                            v379.Text = "Members (SOON)";
                        end;
                    end;
                    local v380 = u19;
                    if v380 then
                        v380.RichText = true;
                        v380.Text = "0/0";
                        local v381 = v380:FindFirstChild("TextLabel");
                        if v381 and v381:IsA("TextLabel") then
                            v381.RichText = true;
                            v381.Text = "0/0";
                        end;
                    end;
                    if u20 then
                        u20.RichText = true;
                        u20.Text = "0/0";
                    end;
                    if u23 then
                        u23.Visible = false;
                    end;
                    if u17 then
                        u17.Image = l__Asserts__5.IconAssetString(nil);
                    end;
                end;
                task.spawn(function() --[[ Line: 1331 ]]
                    -- upvalues: l__Networking__3 (ref), u25 (ref), u26 (ref), u35 (ref), u28 (ref), u98 (ref), u273 (ref)
                    local v382, v383 = pcall(function() --[[ Line: 1332 ]]
                        -- upvalues: l__Networking__3 (ref)
                        return l__Networking__3.Guild.GetLeaderboard:Fire("weekly");
                    end);
                    if v382 and (typeof(v383) == "table" and #v383 > 0) then
                        u25 = v383;
                        u26 = "weekly";
                    end;
                    if u35 and (u28 and u28.Guild) then
                        u98(u28.Guild);
                        u273();
                    end;
                end);
            end;
        else
            local v384, v385 = pcall(function() --[[ Line: 1363 ]]
                -- upvalues: l__Networking__3 (ref)
                return l__Networking__3.Guild.GetMyGuild:Fire();
            end);
            if u35 then
                if v384 then
                    if v385 and (typeof(v385) == "table" and (typeof(v385.GuildmateContribs) == "table" and (v385.Guild and typeof(v385.Guild.GuildId) == "string"))) then
                        u27[v385.Guild.GuildId] = v385.GuildmateContribs;
                    end;
                    u329(v385);
                else
                    u28 = nil;
                    u101();
                    u81("");
                    local v386 = u13;
                    if v386 then
                        v386.RichText = false;
                        v386.Text = "";
                        local v387 = v386:FindFirstChild("TextLabel");
                        if v387 and v387:IsA("TextLabel") then
                            v387.RichText = false;
                            v387.Text = "";
                        end;
                    end;
                    u43 = nil;
                    u44 = 0;
                    u273();
                    local v388 = u18;
                    if v388 then
                        v388.RichText = true;
                        v388.Text = "Members (SOON)";
                        local v389 = v388:FindFirstChild("TextLabel");
                        if v389 and v389:IsA("TextLabel") then
                            v389.RichText = true;
                            v389.Text = "Members (SOON)";
                        end;
                    end;
                    local v390 = u19;
                    if v390 then
                        v390.RichText = true;
                        v390.Text = "0/0";
                        local v391 = v390:FindFirstChild("TextLabel");
                        if v391 and v391:IsA("TextLabel") then
                            v391.RichText = true;
                            v391.Text = "0/0";
                        end;
                    end;
                    if u20 then
                        u20.RichText = true;
                        u20.Text = "0/0";
                    end;
                    if u23 then
                        u23.Visible = false;
                    end;
                    if u17 then
                        u17.Image = l__Asserts__5.IconAssetString(nil);
                    end;
                end;
                task.spawn(function() --[[ Line: 1331 ]]
                    -- upvalues: l__Networking__3 (ref), u25 (ref), u26 (ref), u35 (ref), u28 (ref), u98 (ref), u273 (ref)
                    local v392, v393 = pcall(function() --[[ Line: 1332 ]]
                        -- upvalues: l__Networking__3 (ref)
                        return l__Networking__3.Guild.GetLeaderboard:Fire("weekly");
                    end);
                    if v392 and (typeof(v393) == "table" and #v393 > 0) then
                        u25 = v393;
                        u26 = "weekly";
                    end;
                    if u35 and (u28 and u28.Guild) then
                        u98(u28.Guild);
                        u273();
                    end;
                end);
            end;
        end;
    end);
end;
local function u416() --[[ Line: 1410 ]]
    -- upvalues: u37 (ref), l__NotificationController__9 (copy), u36 (ref), u28 (ref), u1 (copy), l__DevProductController__10 (copy), u35 (ref), l__Networking__3 (copy), u329 (copy)
    local v394 = u37 - os.clock();
    if v394 > 0 then
        l__NotificationController__9:CreateNotification((`Purchase available in {math.ceil(v394)}s`));
        return;
    end;
    if u36 then
        return;
    end;
    if not u28 then
        l__NotificationController__9:CreateNotification("Only the guild owner can buy member slots");
        return;
    end;
    if u28.Role ~= "Owner" then
        l__NotificationController__9:CreateNotification("Only the guild owner can buy member slots");
        return;
    end;
    local l__Guild__32 = u28.Guild;
    if l__Guild__32 then
        l__Guild__32 = u28.Guild.MaxSlots;
    end;
    local u395 = tonumber(l__Guild__32) or 0;
    if u395 >= 50 then
        l__NotificationController__9:CreateNotification("Member slots are already at the maximum");
        return;
    end;
    local u396, u397, u398, u399, v400, v401;
    for _, v409 in u1 do
        if v409.From <= u395 and u395 < v409.To then
            if v409 then
                u396 = v409.Key;
                u36 = true;
                u397 = nil;
                u398 = nil;
                u399 = nil;
                u397 = l__DevProductController__10.PurchaseComplete:Connect(function(p410) --[[ Line: 1454 ]]
                    -- upvalues: u396 (copy), u36 (ref), u397 (ref), u398 (ref), u399 (ref), u37 (ref), u395 (copy), u35 (ref), l__Networking__3 (ref), u329 (ref)
                    if p410 == u396 then
                        u36 = false;
                        if u397 then
                            u397:Disconnect();
                        end;
                        if u398 then
                            u398:Disconnect();
                        end;
                        if u399 then
                            u399:Disconnect();
                        end;
                        u37 = os.clock() + 9;
                        task.spawn(function() --[[ Line: 1467 ]]
                            -- upvalues: u395 (ref), u35 (ref), u37 (ref), l__Networking__3 (ref), u329 (ref)
                            local v411 = u395;
                            for _ = 1, 6 do
                                task.wait(1.5);
                                if not u35 then
                                    u37 = 0;
                                    return;
                                end;
                                local v412, v413 = pcall(function() --[[ Line: 1478 ]]
                                    -- upvalues: l__Networking__3 (ref)
                                    return l__Networking__3.Guild.GetMyGuild:Fire();
                                end);
                                if v412 and (v413 and v413.Guild) then
                                    u329(v413);
                                    if v411 < (tonumber(v413.Guild.MaxSlots) or 0) then
                                        u37 = 0;
                                        return;
                                    end;
                                end;
                            end;
                            u37 = 0;
                        end);
                    end;
                end);
                u398 = l__DevProductController__10.PurchaseFailed:Connect(function(p414) --[[ Line: 1495 ]]
                    -- upvalues: u396 (copy), u36 (ref), u397 (ref), u398 (ref), u399 (ref)
                    if p414 == u396 then
                        u36 = false;
                        if u397 then
                            u397:Disconnect();
                        end;
                        if u398 then
                            u398:Disconnect();
                        end;
                        if u399 then
                            u399:Disconnect();
                        end;
                    end;
                end);
                u399 = l__DevProductController__10.PurchaseCancelled:Connect(function(p415) --[[ Line: 1503 ]]
                    -- upvalues: u396 (copy), u36 (ref), u397 (ref), u398 (ref), u399 (ref)
                    if p415 == u396 then
                        u36 = false;
                        if u397 then
                            u397:Disconnect();
                        end;
                        if u398 then
                            u398:Disconnect();
                        end;
                        if u399 then
                            u399:Disconnect();
                        end;
                    end;
                end);
                v400, v401 = l__DevProductController__10:PromptPurchase(u396);
                if not v400 and v401 ~= "Prompted Robux" then
                    u36 = false;
                    if u397 then
                        u397:Disconnect();
                    end;
                    if u398 then
                        u398:Disconnect();
                    end;
                    if u399 then
                        u399:Disconnect();
                    end;
                end;
                return;
            else
                l__NotificationController__9:CreateNotification("No matching slot tier");
                return;
            end;
        end;
    end;
    local v409 = nil;
    if v409 then
        u396 = v409.Key;
        u36 = true;
        u397 = nil;
        u398 = nil;
        u399 = nil;
        u397 = l__DevProductController__10.PurchaseComplete:Connect(function(p410) --[[ Line: 1454 ]]
            -- upvalues: u396 (copy), u36 (ref), u397 (ref), u398 (ref), u399 (ref), u37 (ref), u395 (copy), u35 (ref), l__Networking__3 (ref), u329 (ref)
            if p410 == u396 then
                u36 = false;
                if u397 then
                    u397:Disconnect();
                end;
                if u398 then
                    u398:Disconnect();
                end;
                if u399 then
                    u399:Disconnect();
                end;
                u37 = os.clock() + 9;
                task.spawn(function() --[[ Line: 1467 ]]
                    -- upvalues: u395 (ref), u35 (ref), u37 (ref), l__Networking__3 (ref), u329 (ref)
                    local v411 = u395;
                    for _ = 1, 6 do
                        task.wait(1.5);
                        if not u35 then
                            u37 = 0;
                            return;
                        end;
                        local v412, v413 = pcall(function() --[[ Line: 1478 ]]
                            -- upvalues: l__Networking__3 (ref)
                            return l__Networking__3.Guild.GetMyGuild:Fire();
                        end);
                        if v412 and (v413 and v413.Guild) then
                            u329(v413);
                            if v411 < (tonumber(v413.Guild.MaxSlots) or 0) then
                                u37 = 0;
                                return;
                            end;
                        end;
                    end;
                    u37 = 0;
                end);
            end;
        end);
        u398 = l__DevProductController__10.PurchaseFailed:Connect(function(p414) --[[ Line: 1495 ]]
            -- upvalues: u396 (copy), u36 (ref), u397 (ref), u398 (ref), u399 (ref)
            if p414 == u396 then
                u36 = false;
                if u397 then
                    u397:Disconnect();
                end;
                if u398 then
                    u398:Disconnect();
                end;
                if u399 then
                    u399:Disconnect();
                end;
            end;
        end);
        u399 = l__DevProductController__10.PurchaseCancelled:Connect(function(p415) --[[ Line: 1503 ]]
            -- upvalues: u396 (copy), u36 (ref), u397 (ref), u398 (ref), u399 (ref)
            if p415 == u396 then
                u36 = false;
                if u397 then
                    u397:Disconnect();
                end;
                if u398 then
                    u398:Disconnect();
                end;
                if u399 then
                    u399:Disconnect();
                end;
            end;
        end);
        v400, v401 = l__DevProductController__10:PromptPurchase(u396);
        if not v400 and v401 ~= "Prompted Robux" then
            u36 = false;
            if u397 then
                u397:Disconnect();
            end;
            if u398 then
                u398:Disconnect();
            end;
            if u399 then
                u399:Disconnect();
            end;
        end;
    else
        l__NotificationController__9:CreateNotification("No matching slot tier");
    end;
end;
local function u445(p417) --[[ Line: 1521 ]]
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), u7 (ref), u10 (ref), u11 (ref), u8 (ref), u9 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u23 (ref), u24 (ref)
    local v418 = p417:FindFirstChild("MainPage");
    if v418 then
        local v419 = v418:FindFirstChild("Header");
        if v419 then
            local v420 = v419:FindFirstChild("ExitButton");
            if v420 and v420:IsA("GuiButton") then
                u4 = v420;
            end;
            local v421 = v419:FindFirstChild("TextLabel");
            if v421 and v421:IsA("TextLabel") then
                u5 = v421;
            end;
            local v422 = v419:FindFirstChild("WeeklyRefreshIn");
            if v422 then
                if v422:IsA("GuiObject") then
                    u6 = v422;
                end;
                local v423 = v422:FindFirstChild("WeeklyTimer");
                if v423 and v423:IsA("TextLabel") then
                    u7 = v423;
                end;
                local v424 = v422:FindFirstChild("UIGradient");
                if v424 and v424:IsA("UIGradient") then
                    u10 = v424;
                end;
            end;
            local v425 = v419:FindFirstChild("ExtraFrame");
            if v425 then
                local v426 = v425:FindFirstChild("ViewPlacementButton");
                if v426 and v426:IsA("GuiButton") then
                    u11 = v426;
                end;
            end;
        end;
        local v427 = v418:FindFirstChild("Content");
        if v427 then
            local v428 = v427:FindFirstChild("WeeklyContributionsTitle");
            if v428 and v428:IsA("TextLabel") then
                u8 = v428;
            end;
            local v429 = v427:FindFirstChild("CompetitionDescription");
            if v429 and v429:IsA("TextLabel") then
                u9 = v429;
            end;
            local v430 = v427:FindFirstChild("GuildInfo");
            if v430 then
                local v431 = v430:FindFirstChild("GuildName_Rank");
                if v431 and v431:IsA("TextLabel") then
                    u12 = v431;
                end;
                local v432 = v430:FindFirstChild("Description");
                if v432 and v432:IsA("TextLabel") then
                    u13 = v432;
                end;
                local v433 = v430:FindFirstChild("TotalContribution");
                if v433 and v433:IsA("TextLabel") then
                    u14 = v433;
                end;
                local v434 = v430:FindFirstChild("EditButton");
                if v434 and v434:IsA("GuiButton") then
                    u15 = v434;
                end;
                local v435 = v430:FindFirstChild("InviteButton");
                if v435 and v435:IsA("GuiButton") then
                    u16 = v435;
                end;
                local v436 = v430:FindFirstChild("BeanstalkDisplay");
                if v436 then
                    local v437 = v436:FindFirstChild("BeanstalkSkinImage");
                    if v437 and v437:IsA("ImageLabel") then
                        u17 = v437;
                    end;
                end;
            end;
            local v438 = v427:FindFirstChild("OnlineCount");
            if v438 and v438:IsA("TextLabel") then
                u18 = v438;
            end;
            local v439 = v427:FindFirstChild("MemberCountTextLabel1");
            if v439 and v439:IsA("TextLabel") then
                u19 = v439;
                local v440 = v439:FindFirstChild("MemberCountTextLabel2");
                if v440 and v440:IsA("TextLabel") then
                    u20 = v440;
                end;
            end;
            local v441 = v427:FindFirstChild("ScrollingFrame");
            if v441 and v441:IsA("ScrollingFrame") then
                u21 = v441;
                local v442 = v441:FindFirstChild("PlayerListTemplate");
                if v442 and v442:IsA("Frame") then
                    u22 = v442;
                    v442.Visible = false;
                end;
                local v443 = v441:FindFirstChild("AddMaxMembersFrame");
                if v443 and v443:IsA("Frame") then
                    u23 = v443;
                    v443.LayoutOrder = 1000000;
                    v443.Visible = false;
                    local v444 = v443:FindFirstChild("ContainerFrame");
                    if v444 then
                        v444 = v444:FindFirstChild("Contributions");
                    end;
                    if v444 then
                        v444 = v444:FindFirstChild("BuyMemberSlotsButton");
                    end;
                    if v444 and v444:IsA("GuiButton") then
                        u24 = v444;
                    end;
                end;
            end;
        end;
    end;
end;
local function u451() --[[ Line: 1625 ]]
    -- upvalues: u4 (ref), l__GuiController__8 (copy), u48 (ref), u15 (ref), l__LocalPlayer__6 (copy), u47 (ref), u16 (ref), u24 (ref), u416 (copy), u11 (ref)
    if u4 then
        u4.MouseButton1Click:Connect(function() --[[ Line: 1627 ]]
            -- upvalues: l__GuiController__8 (ref), u48 (ref)
            if l__GuiController__8:IsOpen("ViewGuildPage") then
                local v446 = u48;
                u48 = false;
                if v446 then
                    l__GuiController__8:Open("ViewGuildLeaderboard", nil, { "HUD" });
                    if l__GuiController__8:IsOpen("ViewGuildPage") then
                        l__GuiController__8:Close();
                    end;
                else
                    l__GuiController__8:Close();
                end;
            end;
        end);
    end;
    if u15 then
        u15.MouseButton1Click:Connect(function() --[[ Line: 1654 ]]
            -- upvalues: l__LocalPlayer__6 (ref), u47 (ref), u48 (ref), l__GuiController__8 (ref)
            if l__LocalPlayer__6:GetAttribute("GuildRole") == "Owner" then
                if u47 then
                else
                    local v447 = u48;
                    l__GuiController__8:Open("EditGuild", nil, { "HUD" });
                    u48 = v447;
                end;
            end;
        end);
    end;
    if u16 then
        u16.MouseButton1Click:Connect(function() --[[ Line: 1674 ]]
            -- upvalues: l__LocalPlayer__6 (ref), u47 (ref), l__GuiController__8 (ref)
            local v448 = l__LocalPlayer__6:GetAttribute("GuildRole");
            if v448 == "Owner" or v448 == "Elder" then
                if u47 then
                else
                    l__GuiController__8:Open("GuildInvite", nil, { "HUD" });
                end;
            end;
        end);
    end;
    if u24 then
        u24.MouseButton1Click:Connect(u416);
    end;
    if u11 then
        u11.MouseButton1Click:Connect(function() --[[ Line: 1703 ]]
            -- upvalues: u47 (ref), u48 (ref), l__LocalPlayer__6 (ref), l__GuiController__8 (ref)
            local v449 = u47;
            local v450 = u48;
            local l__ViewGuildProgressController__33 = require(l__LocalPlayer__6.PlayerScripts.Controllers.ViewGuildProgressController);
            if typeof(l__ViewGuildProgressController__33.SetTargetGuildId) == "function" then
                l__ViewGuildProgressController__33:SetTargetGuildId(u47 or l__LocalPlayer__6:GetAttribute("GuildId"));
            end;
            l__GuiController__8:Open("ViewGuildProgress", nil, { "HUD" });
            u47 = v449;
            u48 = v450;
        end);
    end;
end;
function v2.OpenForGuildId(_, p452) --[[ Line: 1722 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u47 (ref), u48 (ref), l__GuiController__8 (copy), u115 (ref)
    if typeof(p452) == "string" and p452 ~= "" then
        if p452 == l__LocalPlayer__6:GetAttribute("GuildId") then
            u47 = nil;
        else
            u47 = p452;
        end;
        u48 = false;
        if l__GuiController__8:IsOpen("ViewGuildPage") then
            u115();
        else
            l__GuiController__8:Open("ViewGuildPage", nil, { "HUD" });
        end;
    end;
end;
function v2.OpenForGuildIdFromLeaderboard(_, p453) --[[ Line: 1747 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u47 (ref), u48 (ref), l__GuiController__8 (copy), u115 (ref)
    if typeof(p453) == "string" and p453 ~= "" then
        if p453 == l__LocalPlayer__6:GetAttribute("GuildId") then
            u47 = nil;
        else
            u47 = p453;
        end;
        u48 = true;
        if l__GuiController__8:IsOpen("ViewGuildPage") then
            u115();
        else
            l__GuiController__8:Open("ViewGuildPage", nil, { "HUD" });
        end;
    end;
end;
function v2.Init(_) --[[ Line: 1766 ]] end;
function v2.Start(_) --[[ Line: 1768 ]]
    -- upvalues: l__PlayerGui__7 (copy), u3 (ref), u445 (copy), u451 (copy), l__LocalPlayer__6 (copy), u35 (ref), u47 (ref), l__GuiController__8 (copy), u115 (ref), l__Networking__3 (copy), u25 (ref), u26 (ref), u28 (ref), u98 (copy), u273 (copy), u27 (copy), u329 (copy), u38 (copy), u227 (copy), u18 (ref), u293 (copy), u31 (ref), u32 (ref), u48 (ref)
    task.spawn(function() --[[ Line: 1769 ]]
        -- upvalues: l__PlayerGui__7 (ref), u3 (ref), u445 (ref), u451 (ref), l__LocalPlayer__6 (ref), u35 (ref), u47 (ref), l__GuiController__8 (ref), u115 (ref), l__Networking__3 (ref), u25 (ref), u26 (ref), u28 (ref), u98 (ref), u273 (ref), u27 (ref), u329 (ref), u38 (ref), u227 (ref), u18 (ref), u293 (ref), u31 (ref), u32 (ref), u48 (ref)
        local l__ViewGuildPage__34 = l__PlayerGui__7:WaitForChild("ViewGuildPage", 30);
        if l__ViewGuildPage__34 and l__ViewGuildPage__34:IsA("ScreenGui") then
            u3 = l__ViewGuildPage__34;
            l__ViewGuildPage__34.Enabled = false;
            u445(l__ViewGuildPage__34);
            u451();
            l__LocalPlayer__6:GetAttributeChangedSignal("GuildId"):Connect(function() --[[ Line: 1780 ]]
                -- upvalues: u35 (ref), u47 (ref), l__LocalPlayer__6 (ref), l__GuiController__8 (ref), u115 (ref)
                if u35 then
                    if u47 then
                    else
                        if l__LocalPlayer__6:GetAttribute("GuildId") == nil then
                            if l__GuiController__8:IsOpen("ViewGuildPage") then
                                l__GuiController__8:Close();
                            end;
                        else
                            u115();
                        end;
                    end;
                end;
            end);
            l__Networking__3.Guild.TickUpdate.OnClientEvent:Connect(function(p454) --[[ Line: 1794 ]]
                -- upvalues: u25 (ref), u26 (ref), u35 (ref), u28 (ref), u98 (ref), u273 (ref), u27 (ref), u47 (ref), u329 (ref), u38 (ref), u227 (ref), u18 (ref)
                if typeof(p454) == "table" then
                    if p454.Kind == "Leaderboard" then
                        local v455;
                        if typeof(p454.Source) == "string" then
                            v455 = p454.Source;
                        else
                            v455 = nil;
                        end;
                        if v455 == "weekly" then
                            u25 = p454.TopGuilds or {};
                            u26 = "weekly";
                        else
                            u25 = {};
                            u26 = v455;
                        end;
                        if u35 and u28 then
                            u98(u28.Guild);
                            u273();
                        end;
                    elseif p454.Kind == "GuildmateContribs" then
                        local v456 = tostring(p454.GuildId or "");
                        if v456 ~= "" and typeof(p454.Members) == "table" then
                            u27[v456] = p454.Members;
                        end;
                        if u35 and (u28 and not u47) then
                            u329(u28);
                        end;
                    elseif p454.Kind == "GuildPresence" then
                        local v457 = tostring(p454.GuildId or "");
                        local l__UserIds__35 = p454.UserIds;
                        if v457 ~= "" and typeof(l__UserIds__35) == "table" then
                            local v458 = {};
                            for _, v459 in l__UserIds__35 do
                                local v460 = tonumber(v459);
                                if v460 then
                                    v458[v460] = true;
                                end;
                            end;
                            u38[v457] = v458;
                            local v461 = 0;
                            for _ in v458 do
                                v461 = v461 + 1;
                            end;
                            if u35 and (u28 and (u28.Guild and tostring(u28.Guild.GuildId or "") == v457)) then
                                u227(v457);
                                if u18 and u18.Parent then
                                    local v462 = u18;
                                    local v463 = string.format("Members (%d online)", v461);
                                    if not v462 then
                                        return;
                                    end;
                                    v462.RichText = true;
                                    v462.Text = v463;
                                    local v464 = v462:FindFirstChild("TextLabel");
                                    if v464 and v464:IsA("TextLabel") then
                                        v464.RichText = true;
                                        v464.Text = v463;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
            l__GuiController__8.GuiFocusedSignal:Connect(function(p465) --[[ Line: 1854 ]]
                -- upvalues: l__ViewGuildPage__34 (copy), u35 (ref), u293 (ref), u31 (ref), u115 (ref)
                if p465 == l__ViewGuildPage__34 then
                    u35 = true;
                    u293();
                    if not u31 then
                        u31 = task.spawn(function() --[[ Line: 1394 ]]
                            -- upvalues: u35 (ref), u293 (ref)
                            while u35 do
                                u293();
                                task.wait(1);
                            end;
                        end);
                    end;
                    u115();
                end;
            end);
            l__GuiController__8.GuiUnfocusedSignal:Connect(function(p466) --[[ Line: 1862 ]]
                -- upvalues: l__ViewGuildPage__34 (copy), u35 (ref), u31 (ref), u32 (ref), u47 (ref), u48 (ref)
                if p466 == l__ViewGuildPage__34 then
                    u35 = false;
                    if u31 then
                        task.cancel(u31);
                        u31 = nil;
                    end;
                    if u32 then
                        task.cancel(u32);
                        u32 = nil;
                    end;
                    u47 = nil;
                    u48 = false;
                end;
            end);
        end;
    end);
end;
return v2;