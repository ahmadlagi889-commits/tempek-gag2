-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__GuildCompetition__4 = require(l__ReplicatedStorage__2.SharedModules.GuildCompetition);
local l__Asserts__5 = require(l__ReplicatedStorage__2.SharedModules.Guild.Asserts);
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__PlayerGui__7 = l__LocalPlayer__6:WaitForChild("PlayerGui");
local l__GuiController__8 = require(l__LocalPlayer__6.PlayerScripts.Controllers.GuiController);
local l__ViewGuildController__9 = require(l__LocalPlayer__6.PlayerScripts.Controllers.ViewGuildController);
local l__ViewGuildProgressController__10 = require(l__LocalPlayer__6.PlayerScripts.Controllers.ViewGuildProgressController);
local u1 = {
    "RainbowGradient",
    "GoldGradient",
    "SilverGradient",
    "BronzeGradient"
};
local v2 = {
    StartOrder = 9
};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = false;
local u12 = nil;
local u13 = 0;
local u14 = {};
local u15 = {};
local u16 = {};
local u17 = {};
local u18 = nil;
local u19 = nil;
local u20 = (-1 / 0);
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local function u32(p25) --[[ Line: 134 ]]
    -- upvalues: u18 (ref)
    local v26 = p25 < 0 and 0 or p25;
    local v27 = u18 and u18.phase == "pending" and "Starts in" or "Ends in";
    local v28 = math.floor(v26 + 0.5);
    if v28 < 3600 then
        local v29 = v28 // 60;
        return string.format("%s %dm %ds", v27, v29, v28 - v29 * 60);
    elseif v28 < 86400 then
        local v30 = v28 // 3600;
        return string.format("%s %dh %dm", v27, v30, (v28 - v30 * 3600) // 60);
    else
        local v31 = v28 // 86400;
        return string.format("%s %dd %dh", v27, v31, (v28 - v31 * 86400) // 3600);
    end;
end;
local function u41(p33) --[[ Line: 158 ]]
    local v34 = typeof(p33) ~= "string" and "" or p33;
    if #v34 > 0 and v34:sub(1, 1) == "#" then
        v34 = v34:sub(2);
    end;
    if #v34 ~= 6 then
        return "rgb(255,255,255)";
    end;
    local v35 = v34:sub(1, 2);
    local v36 = tonumber(v35, 16);
    local v37 = v34:sub(3, 4);
    local v38 = tonumber(v37, 16);
    local v39 = v34:sub(5, 6);
    local v40 = tonumber(v39, 16);
    return not (v36 and (v38 and v40)) and "rgb(255,255,255)" or string.format("rgb(%d,%d,%d)", v36, v38, v40);
end;
local function u44() --[[ Line: 183 ]]
    -- upvalues: u15 (copy), u14 (copy), u21 (ref), u24 (ref)
    for _, u42 in u15 do
        pcall(function() --[[ Line: 185 ]]
            -- upvalues: u42 (copy)
            u42:Disconnect();
        end);
    end;
    table.clear(u15);
    for _, v43 in u14 do
        if v43.Parent then
            v43:Destroy();
        end;
    end;
    table.clear(u14);
    u21 = nil;
    u24 = nil;
end;
local function u51(p45, p46, p47, p48) --[[ Line: 212 ]]
    -- upvalues: u41 (copy)
    local v49 = u41(p48);
    p45.RichText = true;
    p45.Text = string.format("<font color=\"%s\">%s</font> <font color=\"%s\">[%s]</font>", "rgb(0,0,0)", p46:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"), "rgb(0,0,0)", (p47:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;")));
    local v50 = p45:FindFirstChild("GuildTextLabelName2");
    if v50 and v50:IsA("TextLabel") then
        v50.RichText = true;
        v50.Text = string.format("<font color=\"%s\">%s</font> <font color=\"%s\">[%s]</font>", v49, p46:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"), v49, (p47:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;")));
    end;
end;
local function u57(p52, p53) --[[ Line: 249 ]]
    -- upvalues: u1 (copy)
    if p52 then
        local v54 = p53 == 1 and "RainbowGradient" or (p53 == 2 and "GoldGradient" or (p53 == 3 and "SilverGradient" or "BronzeGradient"));
        for _, v55 in u1 do
            local v56 = p52:FindFirstChild(v55);
            if v56 and v56:IsA("UIGradient") then
                if v55 == v54 then
                    v56.Enabled = true;
                else
                    v56:Destroy();
                end;
            end;
        end;
    end;
end;
local function u62(p58, p59) --[[ Line: 266 ]]
    -- upvalues: l__Asserts__5 (copy)
    local v60 = p58:FindFirstChild("GuildImage");
    if v60 then
        local v61 = v60:FindFirstChild("GuildSkinImage");
        if v61 and v61:IsA("ImageLabel") then
            if typeof(p59) ~= "number" then
                p59 = nil;
            end;
            v61.Image = l__Asserts__5.IconAssetString(p59);
        end;
    end;
end;
local function u66(p63, p64) --[[ Line: 275 ]]
    -- upvalues: u51 (copy), u62 (copy)
    if typeof(p64) == "table" then
        local v65 = p63:FindFirstChild("GuildTextLabelName1");
        if v65 and v65:IsA("TextLabel") then
            u51(v65, tostring(p64.Name or ""), tostring(p64.Tag or ""), p64.Color);
        end;
        u62(p63, p64.IconId);
    end;
end;
local function u89(p67, p68) --[[ Line: 311 ]]
    -- upvalues: u5 (ref), u4 (ref), u14 (copy), u57 (copy), l__GuildCompetition__4 (copy), u18 (ref), u51 (copy), u62 (copy), u16 (copy), u66 (copy), u17 (copy), l__Networking__3 (copy), l__ViewGuildController__9 (copy), u15 (copy)
    if u5 and u4 then
        local u69 = u5:Clone();
        u69.Name = string.format("PlayerCard_Rank%d", p67);
        u69.Visible = true;
        u69.LayoutOrder = p67;
        u69.Parent = u4;
        table.insert(u14, u69);
        local v70 = u69:FindFirstChild("RankTextLabel1");
        if v70 and v70:IsA("TextLabel") then
            local v71 = "#" .. tostring(p67);
            v70.RichText = false;
            v70.Text = v71;
            local v72 = v70:FindFirstChild("RankTextLabel2");
            if v72 and v72:IsA("TextLabel") then
                v72.RichText = false;
                v72.Text = v71;
            end;
            u57(v70:FindFirstChild("RankTextLabel2"), p67);
        end;
        local v73 = u69:FindFirstChild("TotalContribution");
        if v73 and v73:IsA("TextLabel") then
            local v74 = tonumber(p68.shekels or (p68.Shekels or p68.score));
            v73.RichText = false;
            local v75 = "Score: ";
            local l__FormatScore__11 = l__GuildCompetition__4.FormatScore;
            local v76 = u18;
            local v77;
            if typeof(v76) == "table" then
                local v78;
                if typeof(v76.config) == "table" then
                    v78 = v76.config;
                else
                    v78 = v76.lastConfig;
                end;
                if typeof(v78) == "table" and typeof(v78.scoreFormat) == "string" then
                    v77 = v78.scoreFormat;
                else
                    v77 = nil;
                end;
            else
                v77 = nil;
            end;
            v73.Text = v75 .. l__FormatScore__11(v74, v77) .. "kg";
        end;
        local v79 = u69:FindFirstChild("SheckleImage");
        if v79 and v79:IsA("GuiObject") then
            v79.Visible = false;
        end;
        local v80 = p68.name or p68.Name;
        local v81 = u69:FindFirstChild("GuildTextLabelName1");
        if v81 and v81:IsA("TextLabel") then
            u51(v81, tostring(v80 or "?"), tostring(p68.tag or (p68.Tag or "?")), p68.color or p68.Color);
        end;
        u62(u69, p68.iconId or p68.IconId);
        local u82 = p68.guildId or p68.GuildId;
        local v83;
        if typeof(v80) == "string" then
            v83 = v80 ~= "";
        else
            v83 = false;
        end;
        if typeof(u82) == "string" and (u82 ~= "" and not v83) then
            local v84 = u16[u82];
            if v84 then
                u66(u69, v84);
            elseif not u17[u82] then
                u17[u82] = true;
                task.spawn(function() --[[ Line: 295 ]]
                    -- upvalues: l__Networking__3 (ref), u82 (copy), u17 (ref), u16 (ref), u69 (copy), u66 (ref)
                    local v85, v86 = pcall(function() --[[ Line: 296 ]]
                        -- upvalues: l__Networking__3 (ref), u82 (ref)
                        return l__Networking__3.Guild.GetGuildById:Fire(u82);
                    end);
                    u17[u82] = nil;
                    if v85 and typeof(v86) == "table" then
                        u16[u82] = v86;
                        if u69.Parent then
                            u66(u69, v86);
                        end;
                    end;
                end);
            end;
        end;
        local v87 = u69:FindFirstChild("ViewButton");
        if v87 and v87:IsA("GuiButton") then
            local v88 = v87.MouseButton1Click:Connect(function() --[[ Line: 374 ]]
                -- upvalues: u82 (copy), l__ViewGuildController__9 (ref)
                if typeof(u82) == "string" and u82 ~= "" then
                    l__ViewGuildController__9:OpenForGuildIdFromLeaderboard(u82);
                end;
            end);
            table.insert(u15, v88);
        end;
    end;
end;
local function u96(p90) --[[ Line: 395 ]]
    -- upvalues: u18 (ref)
    local v91 = {};
    local v92 = u18;
    local v93;
    if typeof(v92) == "table" then
        local v94;
        if typeof(v92.config) == "table" then
            v94 = v92.config;
        else
            v94 = v92.lastConfig;
        end;
        if typeof(v94) == "table" and typeof(v94.scoreFormat) == "string" then
            v93 = v94.scoreFormat;
        else
            v93 = nil;
        end;
    else
        v93 = nil;
    end;
    v91[1] = tostring(v93);
    for _, v95 in p90 do
        if typeof(v95) == "table" then
            v91[#v91 + 1] = string.format("%s:%s:%s:%s:%s:%s:%s", tostring(v95.guildId or (v95.GuildId or "")), tostring(v95.rank or (v95.Rank or "")), tostring(v95.shekels or v95.Shekels or (v95.score or "")), tostring(v95.name or (v95.Name or "")), tostring(v95.tag or (v95.Tag or "")), tostring(v95.color or (v95.Color or "")), (tostring(v95.iconId or (v95.IconId or ""))));
        end;
    end;
    return table.concat(v91, "|");
end;
local function u102(p97) --[[ Line: 411 ]]
    -- upvalues: u96 (copy), u24 (ref), u14 (copy), u21 (ref), u9 (ref), u44 (copy), u89 (copy)
    local v98 = u96(p97);
    if v98 == u24 and #u14 > 0 then
        u21 = p97;
        if u9 then
            u9.Text = "";
            u9.Visible = false;
        end;
        return #u14;
    end;
    u44();
    u21 = p97;
    u24 = v98;
    local v99 = 0;
    if p97 then
        for v100 = 1, math.min(#p97, 200) do
            local v101 = p97[v100];
            if typeof(v101) == "table" and (tonumber(v101.shekels or v101.Shekels) or 0) > 0 then
                u89(tonumber(v101.rank or v101.Rank) or v100, v101);
                v99 = v99 + 1;
            end;
        end;
    end;
    if v99 > 0 then
        if not u9 then
            return v99;
        end;
        u9.Text = "";
        u9.Visible = false;
    end;
    return v99;
end;
u22 = function() --[[ Line: 453 ]]
    -- upvalues: u11 (ref), u21 (ref), u102 (copy)
    if u11 then
        local v103 = u21;
        if v103 then
            u102(v103);
        end;
    end;
end;
local function u116(p104) --[[ Line: 541 ]]
    -- upvalues: u6 (ref), u7 (ref), u8 (ref), u10 (ref), u9 (ref), u4 (ref), u5 (ref)
    local v105 = p104:FindFirstChild("ContributionLeaderboard");
    if v105 then
        local v106 = v105:FindFirstChild("Header");
        if v106 then
            local v107 = v106:FindFirstChild("ExitButton");
            if v107 and v107:IsA("GuiButton") then
                u6 = v107;
            end;
            local v108 = v106:FindFirstChild("RefreshIn");
            if v108 then
                if v108:IsA("GuiObject") then
                    u7 = v108;
                end;
                local v109 = v108:FindFirstChild("Timer");
                if v109 and v109:IsA("TextLabel") then
                    u8 = v109;
                end;
            end;
            local v110 = v106:FindFirstChild("ExtraFrame");
            if v110 then
                local v111 = v110:FindFirstChild("ViewPlacementButton");
                if v111 and v111:IsA("GuiButton") then
                    u10 = v111;
                end;
            end;
        end;
        local v112 = v105:FindFirstChild("Content");
        if v112 then
            local v113 = v112:FindFirstChild("StatusLabel");
            if v113 and v113:IsA("TextLabel") then
                u9 = v113;
            end;
            local v114 = v112:FindFirstChild("ScrollingFrame");
            if v114 then
                if v114:IsA("ScrollingFrame") then
                    u4 = v114;
                    local v115 = v114:FindFirstChild("PlayerCard_Template_Rank1");
                    if v115 then
                        if v115:IsA("ImageButton") then
                            u5 = v115;
                            v115.Visible = false;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
local function u117() --[[ Line: 594 ]]
    -- upvalues: u6 (ref), l__GuiController__8 (copy), u10 (ref), l__ViewGuildProgressController__10 (copy)
    if u6 then
        u6.MouseButton1Click:Connect(function() --[[ Line: 596 ]]
            -- upvalues: l__GuiController__8 (ref)
            if l__GuiController__8:IsOpen("ViewGuildLeaderboard") then
                l__GuiController__8:Close();
            end;
        end);
    end;
    if u10 then
        u10.MouseButton1Click:Connect(function() --[[ Line: 603 ]]
            -- upvalues: l__ViewGuildProgressController__10 (ref), l__GuiController__8 (ref)
            l__ViewGuildProgressController__10:SetReturnGui("ViewGuildLeaderboard");
            l__GuiController__8:Open("ViewGuildProgress", nil, { "HUD" });
        end);
    end;
end;
function v2.Init(_) --[[ Line: 614 ]] end;
function v2.Start(_) --[[ Line: 616 ]]
    -- upvalues: u20 (ref), l__Networking__3 (copy), u18 (ref), u19 (ref), u22 (ref), u23 (ref), l__PlayerGui__7 (copy), u3 (ref), u116 (copy), u117 (copy), u11 (ref), u102 (copy), u13 (ref), l__GuiController__8 (copy), u8 (ref), u7 (ref), u32 (copy), u12 (ref), u44 (copy), u9 (ref), u14 (copy)
    task.spawn(function() --[[ Line: 617 ]]
        -- upvalues: u20 (ref), l__Networking__3 (ref), u18 (ref), u19 (ref), u22 (ref), u23 (ref), l__PlayerGui__7 (ref), u3 (ref), u116 (ref), u117 (ref), u11 (ref), u102 (ref), u13 (ref), l__GuiController__8 (ref), u8 (ref), u7 (ref), u32 (ref), u12 (ref), u44 (ref), u9 (ref), u14 (ref)
        local v118 = os.clock();
        if v118 - u20 >= 15 then
            u20 = v118;
            task.spawn(function() --[[ Line: 102 ]]
                -- upvalues: l__Networking__3 (ref), u18 (ref), u19 (ref), u22 (ref)
                local v119, v120 = pcall(function() --[[ Line: 103 ]]
                    -- upvalues: l__Networking__3 (ref)
                    return l__Networking__3.Guild.GetCompetition:Fire();
                end);
                if v119 and typeof(v120) == "table" then
                    local v121 = u18;
                    local v122;
                    if typeof(v121) == "table" then
                        local v123;
                        if typeof(v121.config) == "table" then
                            v123 = v121.config;
                        else
                            v123 = v121.lastConfig;
                        end;
                        if typeof(v123) == "table" and typeof(v123.scoreFormat) == "string" then
                            v122 = v123.scoreFormat;
                        else
                            v122 = nil;
                        end;
                    else
                        v122 = nil;
                    end;
                    u18 = v120;
                    if v120.phase == "running" and typeof(v120.endsAt) == "number" then
                        u19 = v120.endsAt;
                    elseif v120.phase == "pending" and typeof(v120.startsAt) == "number" then
                        u19 = v120.startsAt;
                    else
                        u19 = nil;
                    end;
                    local v124 = u18;
                    local v125;
                    if typeof(v124) == "table" then
                        local v126;
                        if typeof(v124.config) == "table" then
                            v126 = v124.config;
                        else
                            v126 = v124.lastConfig;
                        end;
                        if typeof(v126) == "table" and typeof(v126.scoreFormat) == "string" then
                            v125 = v126.scoreFormat;
                        else
                            v125 = nil;
                        end;
                    else
                        v125 = nil;
                    end;
                    local v127 = v125 ~= v122 and u22;
                    if v127 then
                        v127();
                    end;
                end;
            end);
        end;
        task.spawn(function() --[[ Line: 624 ]]
            -- upvalues: l__Networking__3 (ref), u23 (ref)
            local v128, v129 = pcall(function() --[[ Line: 625 ]]
                -- upvalues: l__Networking__3 (ref)
                return l__Networking__3.Guild.GetLeaderboard:Fire("weekly");
            end);
            if v128 and (typeof(v129) == "table" and (#v129 > 0 and not u23)) then
                u23 = v129;
            end;
        end);
        local l__ViewGuildLeaderboard__12 = l__PlayerGui__7:WaitForChild("ViewGuildLeaderboard", 30);
        if l__ViewGuildLeaderboard__12 and l__ViewGuildLeaderboard__12:IsA("ScreenGui") then
            u3 = l__ViewGuildLeaderboard__12;
            l__ViewGuildLeaderboard__12.Enabled = false;
            u116(l__ViewGuildLeaderboard__12);
            u117();
            l__Networking__3.Guild.TickUpdate.OnClientEvent:Connect(function(p130) --[[ Line: 645 ]]
                -- upvalues: u23 (ref), u11 (ref), u102 (ref), u13 (ref)
                if typeof(p130) == "table" then
                    if p130.Kind == "Leaderboard" then
                        local l__TopGuilds__13 = p130.TopGuilds;
                        if typeof(l__TopGuilds__13) == "table" and #l__TopGuilds__13 > 0 then
                            u23 = l__TopGuilds__13;
                        end;
                        if u11 then
                            if typeof(l__TopGuilds__13) == "table" and u102(l__TopGuilds__13) > 0 then
                                u13 = u13 + 1;
                            end;
                        end;
                    end;
                end;
            end);
            l__GuiController__8.GuiFocusedSignal:Connect(function(p131) --[[ Line: 667 ]]
                -- upvalues: l__ViewGuildLeaderboard__12 (copy), u11 (ref), u8 (ref), u20 (ref), l__Networking__3 (ref), u18 (ref), u19 (ref), u22 (ref), u7 (ref), u32 (ref), u12 (ref), u23 (ref), u102 (ref), u44 (ref), u9 (ref), u13 (ref), u14 (ref)
                if p131 == l__ViewGuildLeaderboard__12 then
                    u11 = true;
                    if u8 then
                        local v132 = os.clock();
                        if v132 - u20 >= 15 then
                            u20 = v132;
                            task.spawn(function() --[[ Line: 102 ]]
                                -- upvalues: l__Networking__3 (ref), u18 (ref), u19 (ref), u22 (ref)
                                local v133, v134 = pcall(function() --[[ Line: 103 ]]
                                    -- upvalues: l__Networking__3 (ref)
                                    return l__Networking__3.Guild.GetCompetition:Fire();
                                end);
                                if v133 and typeof(v134) == "table" then
                                    local v135 = u18;
                                    local v136;
                                    if typeof(v135) == "table" then
                                        local v137;
                                        if typeof(v135.config) == "table" then
                                            v137 = v135.config;
                                        else
                                            v137 = v135.lastConfig;
                                        end;
                                        if typeof(v137) == "table" and typeof(v137.scoreFormat) == "string" then
                                            v136 = v137.scoreFormat;
                                        else
                                            v136 = nil;
                                        end;
                                    else
                                        v136 = nil;
                                    end;
                                    u18 = v134;
                                    if v134.phase == "running" and typeof(v134.endsAt) == "number" then
                                        u19 = v134.endsAt;
                                    elseif v134.phase == "pending" and typeof(v134.startsAt) == "number" then
                                        u19 = v134.startsAt;
                                    else
                                        u19 = nil;
                                    end;
                                    local v138 = u18;
                                    local v139;
                                    if typeof(v138) == "table" then
                                        local v140;
                                        if typeof(v138.config) == "table" then
                                            v140 = v138.config;
                                        else
                                            v140 = v138.lastConfig;
                                        end;
                                        if typeof(v140) == "table" and typeof(v140.scoreFormat) == "string" then
                                            v139 = v140.scoreFormat;
                                        else
                                            v139 = nil;
                                        end;
                                    else
                                        v139 = nil;
                                    end;
                                    local v141 = v139 ~= v136 and u22;
                                    if v141 then
                                        v141();
                                    end;
                                end;
                            end);
                        end;
                        local v142 = os.time();
                        local v143;
                        if u19 and v142 < u19 then
                            v143 = u19;
                        else
                            v143 = nil;
                        end;
                        if u7 then
                            u7.Visible = v143 ~= nil;
                        end;
                        u8.Text = not v143 and "" or u32(v143 - v142);
                    end;
                    if not u12 then
                        u12 = task.spawn(function() --[[ Line: 524 ]]
                            -- upvalues: u11 (ref), u8 (ref), u20 (ref), l__Networking__3 (ref), u18 (ref), u19 (ref), u22 (ref), u7 (ref), u32 (ref)
                            while u11 do
                                if u8 then
                                    local v144 = os.clock();
                                    if v144 - u20 >= 15 then
                                        u20 = v144;
                                        task.spawn(function() --[[ Line: 102 ]]
                                            -- upvalues: l__Networking__3 (ref), u18 (ref), u19 (ref), u22 (ref)
                                            local v145, v146 = pcall(function() --[[ Line: 103 ]]
                                                -- upvalues: l__Networking__3 (ref)
                                                return l__Networking__3.Guild.GetCompetition:Fire();
                                            end);
                                            if v145 and typeof(v146) == "table" then
                                                local v147 = u18;
                                                local v148;
                                                if typeof(v147) == "table" then
                                                    local v149;
                                                    if typeof(v147.config) == "table" then
                                                        v149 = v147.config;
                                                    else
                                                        v149 = v147.lastConfig;
                                                    end;
                                                    if typeof(v149) == "table" and typeof(v149.scoreFormat) == "string" then
                                                        v148 = v149.scoreFormat;
                                                    else
                                                        v148 = nil;
                                                    end;
                                                else
                                                    v148 = nil;
                                                end;
                                                u18 = v146;
                                                if v146.phase == "running" and typeof(v146.endsAt) == "number" then
                                                    u19 = v146.endsAt;
                                                elseif v146.phase == "pending" and typeof(v146.startsAt) == "number" then
                                                    u19 = v146.startsAt;
                                                else
                                                    u19 = nil;
                                                end;
                                                local v150 = u18;
                                                local v151;
                                                if typeof(v150) == "table" then
                                                    local v152;
                                                    if typeof(v150.config) == "table" then
                                                        v152 = v150.config;
                                                    else
                                                        v152 = v150.lastConfig;
                                                    end;
                                                    if typeof(v152) == "table" and typeof(v152.scoreFormat) == "string" then
                                                        v151 = v152.scoreFormat;
                                                    else
                                                        v151 = nil;
                                                    end;
                                                else
                                                    v151 = nil;
                                                end;
                                                local v153 = v151 ~= v148 and u22;
                                                if v153 then
                                                    v153();
                                                end;
                                            end;
                                        end);
                                    end;
                                    local v154 = os.time();
                                    local v155;
                                    if u19 and v154 < u19 then
                                        v155 = u19;
                                    else
                                        v155 = nil;
                                    end;
                                    if u7 then
                                        u7.Visible = v155 ~= nil;
                                    end;
                                    u8.Text = not v155 and "" or u32(v155 - v154);
                                end;
                                task.wait(1);
                            end;
                        end);
                    end;
                    local v156 = u23;
                    if not v156 or u102(v156) <= 0 then
                        u44();
                        if u9 then
                            u9.Text = "Loading...";
                            u9.Visible = true;
                        end;
                    end;
                    u13 = u13 + 1;
                    local u157 = u13;
                    task.spawn(function() --[[ Line: 475 ]]
                        -- upvalues: u11 (ref), u157 (copy), u13 (ref), l__Networking__3 (ref), u23 (ref), u102 (ref), u14 (ref), u9 (ref)
                        for _ = 1, 12 do
                            if not u11 or u157 ~= u13 then
                                return;
                            end;
                            local v158, v159 = pcall(function() --[[ Line: 480 ]]
                                -- upvalues: l__Networking__3 (ref)
                                return l__Networking__3.Guild.GetLeaderboard:Fire("weekly");
                            end);
                            if not u11 or u157 ~= u13 then
                                return;
                            end;
                            local v160 = (not v158 or typeof(v159) ~= "table") and {} or v159;
                            if #v160 > 0 then
                                u23 = v160;
                                if u102(v160) > 0 then
                                    return;
                                end;
                            elseif #u14 > 0 then
                                return;
                            end;
                            if u9 then
                                u9.Text = "Loading...";
                                u9.Visible = true;
                            end;
                            task.wait(2);
                        end;
                        if u11 and u157 == u13 then
                            if not u9 then
                                return;
                            end;
                            u9.Text = "No guilds have scored yet";
                            u9.Visible = true;
                        end;
                    end);
                end;
            end);
            l__GuiController__8.GuiUnfocusedSignal:Connect(function(p161) --[[ Line: 685 ]]
                -- upvalues: l__ViewGuildLeaderboard__12 (copy), u11 (ref), u12 (ref)
                if p161 == l__ViewGuildLeaderboard__12 then
                    u11 = false;
                    if u12 then
                        task.cancel(u12);
                        u12 = nil;
                    end;
                end;
            end);
        end;
    end);
end;
return v2;