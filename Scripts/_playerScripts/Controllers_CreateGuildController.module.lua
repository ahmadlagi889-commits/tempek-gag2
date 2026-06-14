-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__Asserts__4 = require(l__ReplicatedStorage__2.SharedModules.Guild.Asserts);
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local l__PlayerGui__6 = l__LocalPlayer__5:WaitForChild("PlayerGui");
local l__GuiController__7 = require(l__LocalPlayer__5.PlayerScripts.Controllers.GuiController);
local l__NotificationController__8 = require(l__LocalPlayer__5.PlayerScripts.Controllers.NotificationController);
local l__DevProductController__9 = require(l__LocalPlayer__5.PlayerScripts.Controllers.DevProductController);
local l__ColorPickerGuildController__10 = require(l__LocalPlayer__5.PlayerScripts.Controllers.ColorPickerGuildController);
local l__MIN_NAME_LENGTH__11 = l__Asserts__4.MIN_NAME_LENGTH;
local l__MAX_NAME_LENGTH__12 = l__Asserts__4.MAX_NAME_LENGTH;
local l__MIN_TAG_LENGTH__13 = l__Asserts__4.MIN_TAG_LENGTH;
local l__MAX_TAG_LENGTH__14 = l__Asserts__4.MAX_TAG_LENGTH;
local l__MAX_DESCRIPTION_LENGTH__15 = l__Asserts__4.MAX_DESCRIPTION_LENGTH;
local v1 = Color3.fromRGB(255, 255, 255);
local v2 = Color3.fromRGB(255, 255, 255);
local v3 = {
    StartOrder = 7
};
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
local u18 = v1;
local u19 = v2;
local u20 = false;
local function u22(p21) --[[ Line: 92 ]]
    return string.gsub(p21, "^%s*(.-)%s*$", "%1");
end;
local function u26(p23, p24) --[[ Line: 135 ]]
    if p23 then
        p23.Text = p24;
        for _, v25 in p23:GetDescendants() do
            if v25:IsA("TextLabel") or v25:IsA("TextButton") then
                v25.Text = p24;
            end;
        end;
    end;
end;
local function u42() --[[ Line: 173 ]]
    -- upvalues: u6 (ref), l__MAX_NAME_LENGTH__12 (copy), u11 (ref), u26 (copy), u15 (ref), l__MIN_NAME_LENGTH__11 (copy), u8 (ref), l__MIN_TAG_LENGTH__13 (copy), l__MAX_TAG_LENGTH__14 (copy), u10 (ref), l__MAX_DESCRIPTION_LENGTH__15 (copy)
    if u6 then
        local v27 = string.gsub(u6.Text, "[^A-Za-z0-9 _\'%-]", "");
        local v28 = l__MAX_NAME_LENGTH__12;
        local v29 = utf8.len(v27);
        if v29 and v29 > v28 then
            local v30 = utf8.offset(v27, v28 + 1);
            if v30 then
                v27 = string.sub(v27, 1, v30 - 1);
            else
                v27 = string.sub(v27, 1, v28);
            end;
        end;
        if v27 ~= u6.Text then
            u6.Text = v27;
        end;
        local v31 = u11;
        local l__Text__16 = u6.Text;
        local v32 = utf8.len(l__Text__16) or #l__Text__16;
        local v33 = l__MAX_NAME_LENGTH__12;
        if v31 then
            u26(v31, (`({v32}/{v33})`));
        end;
        if u15 then
            local v34 = u15;
            local v35 = not u6 and "" or string.gsub(u6.Text, "^%s*(.-)%s*$", "%1");
            local v36 = utf8.len(v35) or #v35;
            local v37;
            if l__MIN_NAME_LENGTH__11 <= v36 then
                v37 = v36 <= l__MAX_NAME_LENGTH__12;
            else
                v37 = false;
            end;
            if v37 then
                local v38 = not u8 and "" or string.gsub(u8.Text, "^%s*(.-)%s*$", "%1");
                local v39 = utf8.len(v38) or #v38;
                if l__MIN_TAG_LENGTH__13 <= v39 then
                    v37 = v39 <= l__MAX_TAG_LENGTH__14;
                else
                    v37 = false;
                end;
                if v37 then
                    local v40 = not u10 and "" or string.gsub(u10.Text, "^%s*(.-)%s*$", "%1");
                    local v41 = utf8.len(v40) or #v40;
                    if v41 >= 1 then
                        v37 = v41 <= l__MAX_DESCRIPTION_LENGTH__15;
                    else
                        v37 = false;
                    end;
                end;
            end;
            v34.Visible = not v37;
        end;
    end;
end;
local function u59() --[[ Line: 186 ]]
    -- upvalues: u8 (ref), l__MAX_TAG_LENGTH__14 (copy), u12 (ref), u26 (copy), u15 (ref), u6 (ref), l__MIN_NAME_LENGTH__11 (copy), l__MAX_NAME_LENGTH__12 (copy), l__MIN_TAG_LENGTH__13 (copy), u10 (ref), l__MAX_DESCRIPTION_LENGTH__15 (copy)
    if u8 then
        local v43 = string.upper(u8.Text);
        local v44 = string.gsub(v43, "[^A-Z0-9]", "");
        local v45 = l__MAX_TAG_LENGTH__14;
        local v46 = utf8.len(v44);
        if v46 and v46 > v45 then
            local v47 = utf8.offset(v44, v45 + 1);
            if v47 then
                v44 = string.sub(v44, 1, v47 - 1);
            else
                v44 = string.sub(v44, 1, v45);
            end;
        end;
        if v44 ~= u8.Text then
            u8.Text = v44;
        end;
        local v48 = u12;
        local l__Text__17 = u8.Text;
        local v49 = utf8.len(l__Text__17) or #l__Text__17;
        local v50 = l__MAX_TAG_LENGTH__14;
        if v48 then
            u26(v48, (`({v49}/{v50})`));
        end;
        if u15 then
            local v51 = u15;
            local v52 = not u6 and "" or string.gsub(u6.Text, "^%s*(.-)%s*$", "%1");
            local v53 = utf8.len(v52) or #v52;
            local v54;
            if l__MIN_NAME_LENGTH__11 <= v53 then
                v54 = v53 <= l__MAX_NAME_LENGTH__12;
            else
                v54 = false;
            end;
            if v54 then
                local v55 = not u8 and "" or string.gsub(u8.Text, "^%s*(.-)%s*$", "%1");
                local v56 = utf8.len(v55) or #v55;
                if l__MIN_TAG_LENGTH__13 <= v56 then
                    v54 = v56 <= l__MAX_TAG_LENGTH__14;
                else
                    v54 = false;
                end;
                if v54 then
                    local v57 = not u10 and "" or string.gsub(u10.Text, "^%s*(.-)%s*$", "%1");
                    local v58 = utf8.len(v57) or #v57;
                    if v58 >= 1 then
                        v54 = v58 <= l__MAX_DESCRIPTION_LENGTH__15;
                    else
                        v54 = false;
                    end;
                end;
            end;
            v51.Visible = not v54;
        end;
    end;
end;
local function u75() --[[ Line: 202 ]]
    -- upvalues: u10 (ref), l__MAX_DESCRIPTION_LENGTH__15 (copy), u13 (ref), u26 (copy), u15 (ref), u6 (ref), l__MIN_NAME_LENGTH__11 (copy), l__MAX_NAME_LENGTH__12 (copy), u8 (ref), l__MIN_TAG_LENGTH__13 (copy), l__MAX_TAG_LENGTH__14 (copy)
    if u10 then
        local v60 = string.gsub(u10.Text, "[^ -~]", "");
        local v61 = l__MAX_DESCRIPTION_LENGTH__15;
        local v62 = utf8.len(v60);
        if v62 and v62 > v61 then
            local v63 = utf8.offset(v60, v61 + 1);
            if v63 then
                v60 = string.sub(v60, 1, v63 - 1);
            else
                v60 = string.sub(v60, 1, v61);
            end;
        end;
        if v60 ~= u10.Text then
            u10.Text = v60;
        end;
        local v64 = u13;
        local l__Text__18 = u10.Text;
        local v65 = utf8.len(l__Text__18) or #l__Text__18;
        local v66 = l__MAX_DESCRIPTION_LENGTH__15;
        if v64 then
            u26(v64, (`({v65}/{v66})`));
        end;
        if u15 then
            local v67 = u15;
            local v68 = not u6 and "" or string.gsub(u6.Text, "^%s*(.-)%s*$", "%1");
            local v69 = utf8.len(v68) or #v68;
            local v70;
            if l__MIN_NAME_LENGTH__11 <= v69 then
                v70 = v69 <= l__MAX_NAME_LENGTH__12;
            else
                v70 = false;
            end;
            if v70 then
                local v71 = not u8 and "" or string.gsub(u8.Text, "^%s*(.-)%s*$", "%1");
                local v72 = utf8.len(v71) or #v71;
                if l__MIN_TAG_LENGTH__13 <= v72 then
                    v70 = v72 <= l__MAX_TAG_LENGTH__14;
                else
                    v70 = false;
                end;
                if v70 then
                    local v73 = not u10 and "" or string.gsub(u10.Text, "^%s*(.-)%s*$", "%1");
                    local v74 = utf8.len(v73) or #v73;
                    if v74 >= 1 then
                        v70 = v74 <= l__MAX_DESCRIPTION_LENGTH__15;
                    else
                        v70 = false;
                    end;
                end;
            end;
            v67.Visible = not v70;
        end;
    end;
end;
local function u77(p76) --[[ Line: 217 ]]
    -- upvalues: l__NotificationController__8 (copy)
    if p76 == "name_filtered" or p76 == "invalid_name" then
        l__NotificationController__8:CreateNotification("Guild name not allowed, try another!");
    elseif p76 == "tag_filtered" or p76 == "invalid_tag" then
        l__NotificationController__8:CreateNotification("Guild tag not allowed, try another!");
    elseif p76 == "name_too_long" then
        l__NotificationController__8:CreateNotification("Guild name is too long");
    elseif p76 == "name_taken" then
        l__NotificationController__8:CreateNotification("That guild name is taken");
    elseif p76 == "tag_taken" then
        l__NotificationController__8:CreateNotification("That guild tag is taken");
    elseif p76 == "already_in_guild" then
        l__NotificationController__8:CreateNotification("You\'re already in a guild!");
    elseif p76 == "no_creation_token" then
        l__NotificationController__8:CreateNotification("You need to purchase Guild Creation first");
    elseif p76 == "invalid_description" then
        l__NotificationController__8:CreateNotification("That description isn\'t allowed");
    elseif p76 == "description_too_long" then
        l__NotificationController__8:CreateNotification("Guild description is too long");
    elseif p76 == "description_filtered" then
        l__NotificationController__8:CreateNotification("Description not allowed, try another!");
    elseif p76 == "filter_unavailable" then
        l__NotificationController__8:CreateNotification("Couldn\'t verify that text right now - try again in a moment!");
    elseif p76 then
        l__NotificationController__8:CreateNotification((`Failed to create guild ({p76})`));
    else
        l__NotificationController__8:CreateNotification("Failed to create guild");
    end;
end;
local function u121(u78, u79, u80) --[[ Line: 313 ]]
    -- upvalues: l__DevProductController__9 (copy), l__Networking__3 (copy), u18 (ref), u20 (ref), l__NotificationController__8 (copy), u77 (copy), u19 (ref), l__GuiController__7 (copy)
    local u81 = false;
    local u82 = false;
    local v84 = l__DevProductController__9.PurchaseComplete:Connect(function(p83) --[[ Line: 321 ]]
        -- upvalues: u82 (ref), u81 (ref)
        if p83 == "Guild:Guild Creation:1" then
            u82 = true;
            u81 = true;
        end;
    end);
    local v86 = l__DevProductController__9.PurchaseFailed:Connect(function(p85, _) --[[ Line: 327 ]]
        -- upvalues: u81 (ref)
        if p85 == "Guild:Guild Creation:1" then
            u81 = true;
        end;
    end);
    local v88 = l__DevProductController__9.PurchaseCancelled:Connect(function(p87) --[[ Line: 332 ]]
        -- upvalues: u81 (ref)
        if p87 == "Guild:Guild Creation:1" then
            u81 = true;
        end;
    end);
    local v89, v90 = l__DevProductController__9:PromptPurchase("Guild:Guild Creation:1");
    local v91;
    if v89 then
        if v90 == "Prompted Robux" or u81 then
            v91 = u82;
        else
            u82 = true;
            u81 = true;
            v91 = u82;
        end;
    else
        u81 = true;
        v91 = u82;
    end;
    local v92 = os.clock();
    while not u81 and os.clock() - v92 < 60 do
        task.wait(0.1);
    end;
    if v84 then
        v84:Disconnect();
    end;
    if v86 then
        v86:Disconnect();
    end;
    if v88 then
        v88:Disconnect();
    end;
    if v91 then
        task.spawn(function() --[[ Line: 262 ]]
            -- upvalues: l__Networking__3 (ref), u78 (copy), u79 (copy), u18 (ref), u80 (copy), u20 (ref), l__NotificationController__8 (ref), u77 (ref), u19 (ref), l__GuiController__7 (ref)
            local v101, v102, v103 = pcall(function() --[[ Line: 263 ]]
                -- upvalues: l__Networking__3 (ref), u78 (ref), u79 (ref), u18 (ref), u80 (ref)
                local l__CreateGuild__19 = l__Networking__3.Guild.CreateGuild;
                local v93 = u78;
                local v94 = u79;
                local v95 = u18;
                local l__format__20 = string.format;
                local v96 = math.floor(v95.R * 255 + 0.5);
                local v97 = math.clamp(v96, 0, 255);
                local v98 = math.floor(v95.G * 255 + 0.5);
                local v99 = math.clamp(v98, 0, 255);
                local v100 = math.floor(v95.B * 255 + 0.5);
                return l__CreateGuild__19:Fire(v93, v94, l__format__20("#%02X%02X%02X", v97, v99, (math.clamp(v100, 0, 255))), u80);
            end);
            u20 = false;
            if v101 then
                if v102 then
                    local v104 = u78;
                    local v105 = u79;
                    local v106 = u18;
                    local l__format__21 = string.format;
                    local v107 = math.floor(v106.R * 255 + 0.5);
                    local v108 = math.clamp(v107, 0, 255);
                    local v109 = math.floor(v106.G * 255 + 0.5);
                    local v110 = math.clamp(v109, 0, 255);
                    local v111 = math.floor(v106.B * 255 + 0.5);
                    local v112 = l__format__21("#%02X%02X%02X", v108, v110, (math.clamp(v111, 0, 255)));
                    local v113 = u19;
                    local l__format__22 = string.format;
                    local v114 = math.floor(v113.R * 255 + 0.5);
                    local v115 = math.clamp(v114, 0, 255);
                    local v116 = math.floor(v113.G * 255 + 0.5);
                    local v117 = math.clamp(v116, 0, 255);
                    local v118 = math.floor(v113.B * 255 + 0.5);
                    local v119 = l__format__22("#%02X%02X%02X", v115, v117, (math.clamp(v118, 0, 255)));
                    l__NotificationController__8:CreateNotification((string.format("Created Guild: <font color=\"%s\">%s</font> [<font color=\"%s\">%s</font>]", v112, v104, v119, v105)));
                    l__GuiController__7:Open("ViewGuildPage", nil, { "HUD" });
                    if l__GuiController__7:IsOpen("CreateGuild") then
                        l__GuiController__7:Close();
                    end;
                else
                    local v120 = typeof(v103) == "string" and v103 and v103 or nil;
                    if v120 == "name_taken" then
                        l__NotificationController__8:CreateNotification("That guild name is already taken, but don\'t worry - your next creation is free!");
                    elseif v120 == "tag_taken" then
                        l__NotificationController__8:CreateNotification("That guild tag is already taken, but don\'t worry - your next creation is free!");
                    else
                        u77(v120);
                    end;
                end;
            else
                l__NotificationController__8:CreateNotification("Failed to create guild");
            end;
        end);
    else
        u20 = false;
    end;
end;
local function u163() --[[ Line: 367 ]]
    -- upvalues: u20 (ref), u6 (ref), u8 (ref), u10 (ref), l__NotificationController__8 (copy), l__MIN_NAME_LENGTH__11 (copy), l__MAX_NAME_LENGTH__12 (copy), l__MIN_TAG_LENGTH__13 (copy), l__MAX_TAG_LENGTH__14 (copy), l__MAX_DESCRIPTION_LENGTH__15 (copy), l__LocalPlayer__5 (copy), l__Networking__3 (copy), u77 (copy), u18 (ref), u19 (ref), l__GuiController__7 (copy), u121 (copy)
    if u20 then
    else
        local u122 = not u6 and "" or string.gsub(u6.Text, "^%s*(.-)%s*$", "%1");
        local u123 = not u8 and "" or string.gsub(u8.Text, "^%s*(.-)%s*$", "%1");
        local u124 = not u10 and "" or string.gsub(u10.Text, "^%s*(.-)%s*$", "%1");
        local v125 = utf8.len(u122) or #u122;
        local v126 = utf8.len(u123) or #u123;
        local v127 = utf8.len(u124) or #u124;
        if v125 < 1 then
            l__NotificationController__8:CreateNotification("Enter a guild name first!");
        elseif v125 < l__MIN_NAME_LENGTH__11 or l__MAX_NAME_LENGTH__12 < v125 then
            l__NotificationController__8:CreateNotification((`Guild name must be {l__MIN_NAME_LENGTH__11}-{l__MAX_NAME_LENGTH__12} characters`));
        elseif v126 < l__MIN_TAG_LENGTH__13 or l__MAX_TAG_LENGTH__14 < v126 then
            l__NotificationController__8:CreateNotification("Guild tag must be 2-5 characters");
        elseif v127 < 1 then
            l__NotificationController__8:CreateNotification("Enter a guild description first!");
        elseif l__MAX_DESCRIPTION_LENGTH__15 < v127 then
            l__NotificationController__8:CreateNotification("Guild description is too long");
        elseif l__LocalPlayer__5:GetAttribute("GuildId") == nil then
            u20 = true;
            task.spawn(function() --[[ Line: 410 ]]
                -- upvalues: l__Networking__3 (ref), u122 (copy), u123 (copy), u124 (copy), u20 (ref), l__NotificationController__8 (ref), u77 (ref), u18 (ref), u19 (ref), l__GuiController__7 (ref), u121 (ref)
                local v128, v129, v130, v131 = pcall(function() --[[ Line: 411 ]]
                    -- upvalues: l__Networking__3 (ref), u122 (ref), u123 (ref), u124 (ref)
                    return l__Networking__3.Guild.CheckCreateAvailability:Fire(u122, u123, u124);
                end);
                if v128 then
                    if v129 then
                        if v131 then
                            local u132 = u122;
                            local u133 = u123;
                            local u134 = u124;
                            task.spawn(function() --[[ Line: 262 ]]
                                -- upvalues: l__Networking__3 (ref), u132 (copy), u133 (copy), u18 (ref), u134 (copy), u20 (ref), l__NotificationController__8 (ref), u77 (ref), u19 (ref), l__GuiController__7 (ref)
                                local v143, v144, v145 = pcall(function() --[[ Line: 263 ]]
                                    -- upvalues: l__Networking__3 (ref), u132 (ref), u133 (ref), u18 (ref), u134 (ref)
                                    local l__CreateGuild__23 = l__Networking__3.Guild.CreateGuild;
                                    local v135 = u132;
                                    local v136 = u133;
                                    local v137 = u18;
                                    local l__format__24 = string.format;
                                    local v138 = math.floor(v137.R * 255 + 0.5);
                                    local v139 = math.clamp(v138, 0, 255);
                                    local v140 = math.floor(v137.G * 255 + 0.5);
                                    local v141 = math.clamp(v140, 0, 255);
                                    local v142 = math.floor(v137.B * 255 + 0.5);
                                    return l__CreateGuild__23:Fire(v135, v136, l__format__24("#%02X%02X%02X", v139, v141, (math.clamp(v142, 0, 255))), u134);
                                end);
                                u20 = false;
                                if v143 then
                                    if v144 then
                                        local v146 = u132;
                                        local v147 = u133;
                                        local v148 = u18;
                                        local l__format__25 = string.format;
                                        local v149 = math.floor(v148.R * 255 + 0.5);
                                        local v150 = math.clamp(v149, 0, 255);
                                        local v151 = math.floor(v148.G * 255 + 0.5);
                                        local v152 = math.clamp(v151, 0, 255);
                                        local v153 = math.floor(v148.B * 255 + 0.5);
                                        local v154 = l__format__25("#%02X%02X%02X", v150, v152, (math.clamp(v153, 0, 255)));
                                        local v155 = u19;
                                        local l__format__26 = string.format;
                                        local v156 = math.floor(v155.R * 255 + 0.5);
                                        local v157 = math.clamp(v156, 0, 255);
                                        local v158 = math.floor(v155.G * 255 + 0.5);
                                        local v159 = math.clamp(v158, 0, 255);
                                        local v160 = math.floor(v155.B * 255 + 0.5);
                                        local v161 = l__format__26("#%02X%02X%02X", v157, v159, (math.clamp(v160, 0, 255)));
                                        l__NotificationController__8:CreateNotification((string.format("Created Guild: <font color=\"%s\">%s</font> [<font color=\"%s\">%s</font>]", v154, v146, v161, v147)));
                                        l__GuiController__7:Open("ViewGuildPage", nil, { "HUD" });
                                        if l__GuiController__7:IsOpen("CreateGuild") then
                                            l__GuiController__7:Close();
                                        end;
                                    else
                                        local v162 = typeof(v145) == "string" and v145 and v145 or nil;
                                        if v162 == "name_taken" then
                                            l__NotificationController__8:CreateNotification("That guild name is already taken, but don\'t worry - your next creation is free!");
                                        elseif v162 == "tag_taken" then
                                            l__NotificationController__8:CreateNotification("That guild tag is already taken, but don\'t worry - your next creation is free!");
                                        else
                                            u77(v162);
                                        end;
                                    end;
                                else
                                    l__NotificationController__8:CreateNotification("Failed to create guild");
                                end;
                            end);
                        else
                            u121(u122, u123, u124);
                        end;
                    else
                        u20 = false;
                        u77(typeof(v130) == "string" and v130 and v130 or nil);
                    end;
                else
                    u20 = false;
                    l__NotificationController__8:CreateNotification("Failed to create guild");
                end;
            end);
        else
            l__NotificationController__8:CreateNotification("You\'re already in a guild!");
        end;
    end;
end;
local function u187(p164) --[[ Line: 439 ]]
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u11 (ref), u8 (ref), u9 (ref), u12 (ref), u10 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref)
    local v165 = p164:FindFirstChild("MainPage");
    if v165 then
        local v166 = v165:FindFirstChild("Header");
        if v166 then
            local v167 = v166:FindFirstChild("ExitButton");
            if v167 and v167:IsA("GuiButton") then
                u5 = v167;
            end;
        end;
        local v168 = v165:FindFirstChild("Content");
        if v168 then
            local v169 = v168:FindFirstChild("Name");
            if v169 then
                local v170 = v169:FindFirstChild("TextField");
                if v170 then
                    local v171 = v170:FindFirstChild("TextBox");
                    if v171 and v171:IsA("TextBox") then
                        u6 = v171;
                    end;
                end;
                local v172 = v169:FindFirstChild("ColorPickerButton");
                if v172 and v172:IsA("GuiButton") then
                    u7 = v172;
                end;
                local v173 = v169:FindFirstChild("CharacterCounter");
                if v173 and v173:IsA("TextLabel") then
                    u11 = v173;
                end;
            end;
            local v174 = v168:FindFirstChild("Tag");
            if v174 then
                local v175 = v174:FindFirstChild("TextField");
                if v175 then
                    local v176 = v175:FindFirstChild("TextBox");
                    if v176 and v176:IsA("TextBox") then
                        u8 = v176;
                    end;
                end;
                local v177 = v174:FindFirstChild("ColorPickerButton");
                if v177 and v177:IsA("GuiButton") then
                    u9 = v177;
                end;
                local v178 = v174:FindFirstChild("CharacterCounter");
                if v178 and v178:IsA("TextLabel") then
                    u12 = v178;
                end;
            end;
            local v179 = v168:FindFirstChild("Description");
            if v179 then
                local v180 = v179:FindFirstChild("TextField");
                if v180 then
                    local v181 = v180:FindFirstChild("TextBox");
                    if v181 and v181:IsA("TextBox") then
                        u10 = v181;
                    end;
                end;
                local v182 = v179:FindFirstChild("CharacterCounter");
                if v182 and v182:IsA("TextLabel") then
                    u13 = v182;
                end;
            end;
        end;
        local v183 = v165:FindFirstChild("CreateButton");
        if v183 and v183:IsA("GuiButton") then
            u14 = v183;
            local v184 = v183:FindFirstChild("CreateBlock");
            if v184 and v184:IsA("GuiObject") then
                u15 = v184;
            end;
            local v185 = v183:FindFirstChild("TextLabel");
            if v185 and v185:IsA("TextLabel") then
                u16 = v185;
                local v186 = v185:FindFirstChild("TextLabel");
                if v186 and v186:IsA("TextLabel") then
                    u17 = v186;
                end;
            end;
        end;
    end;
end;
local function u188() --[[ Line: 525 ]]
    -- upvalues: u6 (ref), u18 (ref), u42 (copy), u8 (ref), u19 (ref), u59 (copy), u10 (ref), u75 (copy)
    if u6 then
        u6.ClearTextOnFocus = false;
        u6.TextColor3 = u18;
        u6:GetPropertyChangedSignal("Text"):Connect(u42);
        u42();
    end;
    if u8 then
        u8.ClearTextOnFocus = false;
        u8.TextColor3 = u19;
        u8:GetPropertyChangedSignal("Text"):Connect(u59);
        u59();
    end;
    if u10 then
        u10.ClearTextOnFocus = false;
        u10:GetPropertyChangedSignal("Text"):Connect(u75);
        u75();
    end;
end;
local function u191() --[[ Line: 545 ]]
    -- upvalues: u7 (ref), l__ColorPickerGuildController__10 (copy), u18 (ref), u6 (ref), l__GuiController__7 (copy), u9 (ref), u19 (ref), u8 (ref)
    if u7 then
        u7.MouseButton1Click:Connect(function() --[[ Line: 547 ]]
            -- upvalues: l__ColorPickerGuildController__10 (ref), u18 (ref), u6 (ref), l__GuiController__7 (ref)
            l__ColorPickerGuildController__10:RequestColor(u18, function(p189) --[[ Line: 548 ]]
                -- upvalues: u18 (ref), u6 (ref), l__GuiController__7 (ref)
                if p189 then
                    u18 = p189;
                    if u6 then
                        u6.TextColor3 = p189;
                    end;
                end;
                if not l__GuiController__7:IsOpen("CreateGuild") then
                    l__GuiController__7:Open("CreateGuild", nil, { "HUD" });
                end;
            end);
        end);
    end;
    if u9 then
        u9.MouseButton1Click:Connect(function() --[[ Line: 560 ]]
            -- upvalues: l__ColorPickerGuildController__10 (ref), u19 (ref), u8 (ref), l__GuiController__7 (ref)
            l__ColorPickerGuildController__10:RequestColor(u19, function(p190) --[[ Line: 561 ]]
                -- upvalues: u19 (ref), u8 (ref), l__GuiController__7 (ref)
                if p190 then
                    u19 = p190;
                    if u8 then
                        u8.TextColor3 = p190;
                    end;
                end;
                if not l__GuiController__7:IsOpen("CreateGuild") then
                    l__GuiController__7:Open("CreateGuild", nil, { "HUD" });
                end;
            end);
        end);
    end;
end;
local function u192() --[[ Line: 578 ]]
    -- upvalues: u14 (ref), u26 (copy), u16 (ref), u17 (ref), u163 (copy)
    if u14 then
        u14.MouseEnter:Connect(function() --[[ Line: 581 ]]
            -- upvalues: u26 (ref), u16 (ref), u17 (ref)
            u26(u16, "99 R$");
            u26(u17, "99 R$");
        end);
        u14.MouseLeave:Connect(function() --[[ Line: 585 ]]
            -- upvalues: u26 (ref), u16 (ref), u17 (ref)
            u26(u16, "Create");
            u26(u17, "Create");
        end);
        u14.MouseButton1Click:Connect(u163);
    end;
end;
function v3.Init(_) --[[ Line: 610 ]] end;
function v3.Start(_) --[[ Line: 612 ]]
    -- upvalues: l__PlayerGui__6 (copy), u4 (ref), u187 (copy), u5 (ref), l__GuiController__7 (copy), u188 (copy), u191 (copy), u192 (copy), u26 (copy), u16 (ref), u17 (ref), u15 (ref), u6 (ref), u22 (copy), l__MIN_NAME_LENGTH__11 (copy), l__MAX_NAME_LENGTH__12 (copy), u8 (ref), l__MIN_TAG_LENGTH__13 (copy), l__MAX_TAG_LENGTH__14 (copy), u10 (ref), l__MAX_DESCRIPTION_LENGTH__15 (copy)
    task.spawn(function() --[[ Line: 613 ]]
        -- upvalues: l__PlayerGui__6 (ref), u4 (ref), u187 (ref), u5 (ref), l__GuiController__7 (ref), u188 (ref), u191 (ref), u192 (ref), u26 (ref), u16 (ref), u17 (ref), u15 (ref), u6 (ref), u22 (ref), l__MIN_NAME_LENGTH__11 (ref), l__MAX_NAME_LENGTH__12 (ref), u8 (ref), l__MIN_TAG_LENGTH__13 (ref), l__MAX_TAG_LENGTH__14 (ref), u10 (ref), l__MAX_DESCRIPTION_LENGTH__15 (ref)
        local l__CreateGuild__27 = l__PlayerGui__6:WaitForChild("CreateGuild", 30);
        if l__CreateGuild__27 and l__CreateGuild__27:IsA("ScreenGui") then
            u4 = l__CreateGuild__27;
            l__CreateGuild__27.Enabled = false;
            u187(l__CreateGuild__27);
            if u5 then
                u5.MouseButton1Click:Connect(function() --[[ Line: 594 ]]
                    -- upvalues: l__GuiController__7 (ref)
                    if l__GuiController__7:IsOpen("CreateGuild") then
                        l__GuiController__7:Close();
                    end;
                end);
            end;
            u188();
            u191();
            u192();
            l__GuiController__7.GuiFocusedSignal:Connect(function(p193) --[[ Line: 627 ]]
                -- upvalues: l__CreateGuild__27 (copy), u26 (ref), u16 (ref), u17 (ref), u15 (ref), u6 (ref), u22 (ref), l__MIN_NAME_LENGTH__11 (ref), l__MAX_NAME_LENGTH__12 (ref), u8 (ref), l__MIN_TAG_LENGTH__13 (ref), l__MAX_TAG_LENGTH__14 (ref), u10 (ref), l__MAX_DESCRIPTION_LENGTH__15 (ref)
                if p193 == l__CreateGuild__27 then
                    u26(u16, "Create");
                    u26(u17, "Create");
                    if not u15 then
                        return;
                    end;
                    local v194 = u15;
                    local v195 = not u6 and "" or u22(u6.Text);
                    local v196 = utf8.len(v195) or #v195;
                    local v197;
                    if l__MIN_NAME_LENGTH__11 <= v196 then
                        v197 = v196 <= l__MAX_NAME_LENGTH__12;
                    else
                        v197 = false;
                    end;
                    if v197 then
                        local v198 = not u8 and "" or u22(u8.Text);
                        local v199 = utf8.len(v198) or #v198;
                        if l__MIN_TAG_LENGTH__13 <= v199 then
                            v197 = v199 <= l__MAX_TAG_LENGTH__14;
                        else
                            v197 = false;
                        end;
                        if v197 then
                            local v200 = not u10 and "" or u22(u10.Text);
                            local v201 = utf8.len(v200) or #v200;
                            if v201 >= 1 then
                                v197 = v201 <= l__MAX_DESCRIPTION_LENGTH__15;
                            else
                                v197 = false;
                            end;
                        end;
                    end;
                    v194.Visible = not v197;
                end;
            end);
        end;
    end);
end;
return v3;