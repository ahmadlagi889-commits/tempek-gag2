-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__Asserts__4 = require(l__ReplicatedStorage__2.SharedModules.Guild.Asserts);
local l__IconPool__5 = require(l__ReplicatedStorage__2.SharedModules.Guild.IconPool);
local l__MarketplaceServiceHelper__6 = require(l__ReplicatedStorage__2.UserGenerated.Roblox.MarketplaceServiceHelper);
local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
local l__PlayerGui__8 = l__LocalPlayer__7:WaitForChild("PlayerGui");
local l__GuiController__9 = require(l__LocalPlayer__7.PlayerScripts.Controllers.GuiController);
local l__NotificationController__10 = require(l__LocalPlayer__7.PlayerScripts.Controllers.NotificationController);
local l__ColorPickerGuildController__11 = require(l__LocalPlayer__7.PlayerScripts.Controllers.ColorPickerGuildController);
local l__MAX_NAME_LENGTH__12 = l__Asserts__4.MAX_NAME_LENGTH;
local _ = l__Asserts__4.MIN_TAG_LENGTH;
local l__MAX_TAG_LENGTH__13 = l__Asserts__4.MAX_TAG_LENGTH;
local l__MAX_DESCRIPTION_LENGTH__14 = l__Asserts__4.MAX_DESCRIPTION_LENGTH;
local u1 = Color3.fromRGB(110, 231, 167);
local u2 = {
    [1] = true,
    [13] = true
};
local v3 = {
    StartOrder = 9
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
local u17 = "";
local u18 = "";
local u19 = "";
local u20 = u1;
local u21 = u1;
local l__DEFAULT_ICON_ID__15 = l__IconPool__5.DEFAULT_ICON_ID;
local u22 = 0;
local u23 = false;
local function u31(p24) --[[ Line: 115 ]]
    -- upvalues: u1 (copy)
    if typeof(p24) == "string" and p24 ~= "" then
        if string.sub(p24, 1, 1) == "#" then
            p24 = string.sub(p24, 2);
        end;
        if #p24 == 6 then
            local v25 = string.sub(p24, 1, 2);
            local v26 = tonumber(v25, 16);
            local v27 = string.sub(p24, 3, 4);
            local v28 = tonumber(v27, 16);
            local v29 = string.sub(p24, 5, 6);
            local v30 = tonumber(v29, 16);
            if v26 and (v28 and v30) then
                return Color3.fromRGB(v26, v28, v30);
            else
                return u1;
            end;
        else
            return u1;
        end;
    else
        return u1;
    end;
end;
local function u38() --[[ Line: 193 ]]
    -- upvalues: l__Networking__3 (copy), l__Asserts__4 (copy), u31 (copy)
    local v32, v33 = pcall(function() --[[ Line: 194 ]]
        -- upvalues: l__Networking__3 (ref)
        return l__Networking__3.Guild.GetMyGuild:Fire();
    end);
    if not v32 or typeof(v33) ~= "table" then
        return nil;
    end;
    local l__Guild__16 = v33.Guild;
    if typeof(l__Guild__16) ~= "table" then
        return nil;
    end;
    local v34 = 0;
    local l__LastNameChangedAt__17 = l__Guild__16.LastNameChangedAt;
    if typeof(l__LastNameChangedAt__17) == "number" and l__LastNameChangedAt__17 > 0 then
        local v35 = os.time() - l__LastNameChangedAt__17;
        if v35 < 604800 then
            v34 = 604800 - v35;
        end;
    end;
    local l__IconId__18 = l__Guild__16.IconId;
    if typeof(l__IconId__18) ~= "number" or l__IconId__18 <= 0 then
        l__IconId__18 = l__Asserts__4.DEFAULT_ICON_ID;
    end;
    local v36 = {
        Name = tostring(l__Guild__16.Name or ""),
        Tag = tostring(l__Guild__16.Tag or ""),
        Description = tostring(l__Guild__16.Description or ""),
        Color = u31(l__Guild__16.Color),
        TagColor = u31(l__Guild__16.TagColor or l__Guild__16.Color),
        IconId = l__IconId__18
    };
    local v37;
    if typeof(v33.Role) == "string" then
        v37 = v33.Role;
    else
        v37 = nil;
    end;
    v36.Role = v37;
    v36.NameCooldownRemainingAtFetch = v34;
    v36.FetchedAtClock = os.clock();
    return v36;
end;
local function u49() --[[ Line: 271 ]]
    -- upvalues: u6 (ref), l__MAX_NAME_LENGTH__12 (copy), u17 (ref), u12 (ref), u16 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref)
    if u6 then
        local v39 = string.gsub(u6.Text, "[^A-Za-z0-9 _\'%-]", "");
        local v40 = l__MAX_NAME_LENGTH__12;
        local v41 = utf8.len(v39);
        if v41 and v41 > v40 then
            local v42 = utf8.offset(v39, v40 + 1);
            if v42 then
                v39 = string.sub(v39, 1, v42 - 1);
            else
                v39 = string.sub(v39, 1, v40);
            end;
        end;
        if v39 ~= u6.Text then
            u6.Text = v39;
        end;
        u17 = u6.Text;
        if u12 then
            local v43 = u12;
            local v44;
            if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                v44 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
            else
                v44 = false;
            end;
            if not v44 then
                if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                    v44 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v44 = false;
                end;
                if not v44 then
                    if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                        v44 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                    else
                        v44 = false;
                    end;
                    if not v44 then
                        if u16 then
                            local v45 = u20;
                            local l__Color__19 = u16.Color;
                            local v46;
                            if math.abs(v45.R - l__Color__19.R) < 0.001 and math.abs(v45.G - l__Color__19.G) < 0.001 then
                                v46 = math.abs(v45.B - l__Color__19.B) < 0.001;
                            else
                                v46 = false;
                            end;
                            v44 = not v46;
                        else
                            v44 = false;
                        end;
                        if not v44 then
                            if u16 then
                                local v47 = u21;
                                local l__TagColor__20 = u16.TagColor;
                                local v48;
                                if math.abs(v47.R - l__TagColor__20.R) < 0.001 and math.abs(v47.G - l__TagColor__20.G) < 0.001 then
                                    v48 = math.abs(v47.B - l__TagColor__20.B) < 0.001;
                                else
                                    v48 = false;
                                end;
                                v44 = not v48;
                            else
                                v44 = false;
                            end;
                            if not v44 then
                                if u16 then
                                    v44 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                else
                                    v44 = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            v43.Visible = not v44;
        end;
    end;
end;
local function u61() --[[ Line: 284 ]]
    -- upvalues: u7 (ref), l__MAX_TAG_LENGTH__13 (copy), u18 (ref), u12 (ref), u16 (ref), u17 (ref), u19 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref)
    if u7 then
        local v50 = string.upper(u7.Text);
        local v51 = string.gsub(v50, "[^A-Z0-9]", "");
        local v52 = l__MAX_TAG_LENGTH__13;
        local v53 = utf8.len(v51);
        if v53 and v53 > v52 then
            local v54 = utf8.offset(v51, v52 + 1);
            if v54 then
                v51 = string.sub(v51, 1, v54 - 1);
            else
                v51 = string.sub(v51, 1, v52);
            end;
        end;
        if v51 ~= u7.Text then
            u7.Text = v51;
        end;
        u18 = u7.Text;
        if u12 then
            local v55 = u12;
            local v56;
            if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                v56 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
            else
                v56 = false;
            end;
            if not v56 then
                if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                    v56 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v56 = false;
                end;
                if not v56 then
                    if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                        v56 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                    else
                        v56 = false;
                    end;
                    if not v56 then
                        if u16 then
                            local v57 = u20;
                            local l__Color__21 = u16.Color;
                            local v58;
                            if math.abs(v57.R - l__Color__21.R) < 0.001 and math.abs(v57.G - l__Color__21.G) < 0.001 then
                                v58 = math.abs(v57.B - l__Color__21.B) < 0.001;
                            else
                                v58 = false;
                            end;
                            v56 = not v58;
                        else
                            v56 = false;
                        end;
                        if not v56 then
                            if u16 then
                                local v59 = u21;
                                local l__TagColor__22 = u16.TagColor;
                                local v60;
                                if math.abs(v59.R - l__TagColor__22.R) < 0.001 and math.abs(v59.G - l__TagColor__22.G) < 0.001 then
                                    v60 = math.abs(v59.B - l__TagColor__22.B) < 0.001;
                                else
                                    v60 = false;
                                end;
                                v56 = not v60;
                            else
                                v56 = false;
                            end;
                            if not v56 then
                                if u16 then
                                    v56 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                else
                                    v56 = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            v55.Visible = not v56;
        end;
    end;
end;
local function u72() --[[ Line: 299 ]]
    -- upvalues: u8 (ref), l__MAX_DESCRIPTION_LENGTH__14 (copy), u19 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref)
    if u8 then
        local v62 = string.gsub(u8.Text, "[^ -~]", "");
        local v63 = l__MAX_DESCRIPTION_LENGTH__14;
        local v64 = utf8.len(v62);
        if v64 and v64 > v63 then
            local v65 = utf8.offset(v62, v63 + 1);
            if v65 then
                v62 = string.sub(v62, 1, v65 - 1);
            else
                v62 = string.sub(v62, 1, v63);
            end;
        end;
        if v62 ~= u8.Text then
            u8.Text = v62;
        end;
        u19 = u8.Text;
        if u12 then
            local v66 = u12;
            local v67;
            if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                v67 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
            else
                v67 = false;
            end;
            if not v67 then
                if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                    v67 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v67 = false;
                end;
                if not v67 then
                    if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                        v67 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                    else
                        v67 = false;
                    end;
                    if not v67 then
                        if u16 then
                            local v68 = u20;
                            local l__Color__23 = u16.Color;
                            local v69;
                            if math.abs(v68.R - l__Color__23.R) < 0.001 and math.abs(v68.G - l__Color__23.G) < 0.001 then
                                v69 = math.abs(v68.B - l__Color__23.B) < 0.001;
                            else
                                v69 = false;
                            end;
                            v67 = not v69;
                        else
                            v67 = false;
                        end;
                        if not v67 then
                            if u16 then
                                local v70 = u21;
                                local l__TagColor__24 = u16.TagColor;
                                local v71;
                                if math.abs(v70.R - l__TagColor__24.R) < 0.001 and math.abs(v70.G - l__TagColor__24.G) < 0.001 then
                                    v71 = math.abs(v70.B - l__TagColor__24.B) < 0.001;
                                else
                                    v71 = false;
                                end;
                                v67 = not v71;
                            else
                                v67 = false;
                            end;
                            if not v67 then
                                if u16 then
                                    v67 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                else
                                    v67 = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            v66.Visible = not v67;
        end;
    end;
end;
local function u81() --[[ Line: 329 ]]
    -- upvalues: l__IconPool__5 (copy), l__DEFAULT_ICON_ID__15 (ref), u22 (ref), u13 (ref), l__Asserts__4 (copy), u15 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref)
    local v73 = l__IconPool__5.GetPool();
    if #v73 == 0 then
    else
        local v74 = math.random(#v73);
        if #v73 > 1 and v73[v74] == l__DEFAULT_ICON_ID__15 then
            v74 = v74 % #v73 + 1;
        end;
        u22 = u22 + 1;
        l__DEFAULT_ICON_ID__15 = v73[v74];
        if u13 then
            u13.Image = l__Asserts__4.IconAssetString(l__DEFAULT_ICON_ID__15);
        end;
        if u15 then
            u15.Text = l__Asserts__4.IsPoolIcon(l__DEFAULT_ICON_ID__15) and "" or tostring(l__DEFAULT_ICON_ID__15);
        end;
        if u12 then
            local v75 = u12;
            local v76;
            if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                v76 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
            else
                v76 = false;
            end;
            if not v76 then
                if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                    v76 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v76 = false;
                end;
                if not v76 then
                    if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                        v76 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                    else
                        v76 = false;
                    end;
                    if not v76 then
                        if u16 then
                            local v77 = u20;
                            local l__Color__25 = u16.Color;
                            local v78;
                            if math.abs(v77.R - l__Color__25.R) < 0.001 and math.abs(v77.G - l__Color__25.G) < 0.001 then
                                v78 = math.abs(v77.B - l__Color__25.B) < 0.001;
                            else
                                v78 = false;
                            end;
                            v76 = not v78;
                        else
                            v76 = false;
                        end;
                        if not v76 then
                            if u16 then
                                local v79 = u21;
                                local l__TagColor__26 = u16.TagColor;
                                local v80;
                                if math.abs(v79.R - l__TagColor__26.R) < 0.001 and math.abs(v79.G - l__TagColor__26.G) < 0.001 then
                                    v80 = math.abs(v79.B - l__TagColor__26.B) < 0.001;
                                else
                                    v80 = false;
                                end;
                                v76 = not v80;
                            else
                                v76 = false;
                            end;
                            if not v76 then
                                if u16 then
                                    v76 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                else
                                    v76 = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            v75.Visible = not v76;
        end;
    end;
end;
local function u93(p82) --[[ Line: 348 ]]
    -- upvalues: u13 (ref), l__Asserts__4 (copy), l__DEFAULT_ICON_ID__15 (ref), u15 (ref), l__NotificationController__10 (copy), u22 (ref), l__MarketplaceServiceHelper__6 (copy), l__GuiController__9 (copy), u2 (copy), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref)
    if string.match(p82, "^%s*$") then
        if u13 then
            u13.Image = l__Asserts__4.IconAssetString(l__DEFAULT_ICON_ID__15);
        end;
        if u15 then
            u15.Text = l__Asserts__4.IsPoolIcon(l__DEFAULT_ICON_ID__15) and "" or tostring(l__DEFAULT_ICON_ID__15);
        end;
    else
        local u83 = tonumber(string.match(p82, "rbxassetid://(%d+)")) or tonumber(string.match(p82, "^%s*(%d+)%s*$"));
        if u83 then
            if u83 == l__DEFAULT_ICON_ID__15 then
                if u13 then
                    u13.Image = l__Asserts__4.IconAssetString(l__DEFAULT_ICON_ID__15);
                end;
                if u15 then
                    u15.Text = l__Asserts__4.IsPoolIcon(l__DEFAULT_ICON_ID__15) and "" or tostring(l__DEFAULT_ICON_ID__15);
                end;
            else
                u22 = u22 + 1;
                local u84 = u22;
                task.spawn(function() --[[ Line: 371 ]]
                    -- upvalues: l__MarketplaceServiceHelper__6 (ref), u83 (copy), u84 (copy), u22 (ref), l__GuiController__9 (ref), u2 (ref), u13 (ref), l__Asserts__4 (ref), l__DEFAULT_ICON_ID__15 (ref), u15 (ref), l__NotificationController__10 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref)
                    local v85, v86 = pcall(l__MarketplaceServiceHelper__6.GetInfoAsync, u83, Enum.InfoType.Asset);
                    if u84 == u22 then
                        if l__GuiController__9:IsOpen("EditGuild") then
                            if v85 then
                                if typeof(v86) == "table" then
                                    v85 = u2[v86.AssetTypeId] == true;
                                else
                                    v85 = false;
                                end;
                            end;
                            if v85 then
                                l__DEFAULT_ICON_ID__15 = u83;
                                if u13 then
                                    u13.Image = l__Asserts__4.IconAssetString(l__DEFAULT_ICON_ID__15);
                                end;
                                if u15 then
                                    u15.Text = l__Asserts__4.IsPoolIcon(l__DEFAULT_ICON_ID__15) and "" or tostring(l__DEFAULT_ICON_ID__15);
                                end;
                                if u12 then
                                    local v87 = u12;
                                    local v88;
                                    if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                                        v88 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
                                    else
                                        v88 = false;
                                    end;
                                    if not v88 then
                                        if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                                            v88 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                                        else
                                            v88 = false;
                                        end;
                                        if not v88 then
                                            if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                                                v88 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                                            else
                                                v88 = false;
                                            end;
                                            if not v88 then
                                                if u16 then
                                                    local v89 = u20;
                                                    local l__Color__27 = u16.Color;
                                                    local v90;
                                                    if math.abs(v89.R - l__Color__27.R) < 0.001 and math.abs(v89.G - l__Color__27.G) < 0.001 then
                                                        v90 = math.abs(v89.B - l__Color__27.B) < 0.001;
                                                    else
                                                        v90 = false;
                                                    end;
                                                    v88 = not v90;
                                                else
                                                    v88 = false;
                                                end;
                                                if not v88 then
                                                    if u16 then
                                                        local v91 = u21;
                                                        local l__TagColor__28 = u16.TagColor;
                                                        local v92;
                                                        if math.abs(v91.R - l__TagColor__28.R) < 0.001 and math.abs(v91.G - l__TagColor__28.G) < 0.001 then
                                                            v92 = math.abs(v91.B - l__TagColor__28.B) < 0.001;
                                                        else
                                                            v92 = false;
                                                        end;
                                                        v88 = not v92;
                                                    else
                                                        v88 = false;
                                                    end;
                                                    if not v88 then
                                                        if u16 then
                                                            v88 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                                        else
                                                            v88 = false;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                    v87.Visible = not v88;
                                end;
                            else
                                if u13 then
                                    u13.Image = l__Asserts__4.IconAssetString(l__DEFAULT_ICON_ID__15);
                                end;
                                if u15 then
                                    u15.Text = l__Asserts__4.IsPoolIcon(l__DEFAULT_ICON_ID__15) and "" or tostring(l__DEFAULT_ICON_ID__15);
                                end;
                                l__NotificationController__10:CreateNotification("That\'s not a valid roblox image id!");
                            end;
                        end;
                    end;
                end);
            end;
        else
            if u13 then
                u13.Image = l__Asserts__4.IconAssetString(l__DEFAULT_ICON_ID__15);
            end;
            if u15 then
                u15.Text = l__Asserts__4.IsPoolIcon(l__DEFAULT_ICON_ID__15) and "" or tostring(l__DEFAULT_ICON_ID__15);
            end;
            l__NotificationController__10:CreateNotification("That\'s not a valid roblox image id!");
        end;
    end;
end;
local function u102(p94) --[[ Line: 394 ]]
    -- upvalues: l__NotificationController__10 (copy)
    if typeof(p94) == "string" and string.sub(p94, 1, 14) == "name_cooldown:" then
        local v95 = string.sub(p94, 15);
        local v96 = l__NotificationController__10;
        local v97 = (tonumber(v95) or 0) + 0.5;
        local v98 = math.floor(v97);
        local v99 = math.max(0, v98);
        local v100 = v99 // 86400;
        local v101 = (v99 - v100 * 86400) // 3600;
        v96:CreateNotification((`You can change your name in {string.format("%dd %dh", v100, v100 <= 0 and v101 <= 0 and 1 or v101)}`));
    elseif p94 == "name_cooldown" then
        l__NotificationController__10:CreateNotification("You can change your name in 7d 0h");
    elseif p94 == "no_changes" then
        l__NotificationController__10:CreateNotification("Nothing to save");
    elseif p94 == "not_leader" then
        l__NotificationController__10:CreateNotification("Only the guild leader can edit");
    elseif p94 == "guild_not_found" then
        l__NotificationController__10:CreateNotification("Couldn\'t find your guild");
    elseif p94 == "invalid_name" then
        l__NotificationController__10:CreateNotification("That guild name isn\'t allowed");
    elseif p94 == "name_too_long" then
        l__NotificationController__10:CreateNotification("Guild name is too long");
    elseif p94 == "name_taken" then
        l__NotificationController__10:CreateNotification("That guild name is taken");
    elseif p94 == "name_filtered" then
        l__NotificationController__10:CreateNotification("Guild name not allowed, try another!");
    elseif p94 == "invalid_tag" then
        l__NotificationController__10:CreateNotification("Guild tag must be 2-5 letters/digits");
    elseif p94 == "tag_taken" then
        l__NotificationController__10:CreateNotification("That guild tag is taken");
    elseif p94 == "tag_filtered" then
        l__NotificationController__10:CreateNotification("Guild tag not allowed, try another!");
    elseif p94 == "invalid_color" then
        l__NotificationController__10:CreateNotification("That name color isn\'t valid");
    elseif p94 == "invalid_tag_color" then
        l__NotificationController__10:CreateNotification("That tag color isn\'t valid");
    elseif p94 == "invalid_icon" then
        l__NotificationController__10:CreateNotification("That\'s not a valid roblox image id!");
    elseif p94 == "invalid_description" then
        l__NotificationController__10:CreateNotification("That description isn\'t allowed");
    elseif p94 == "description_too_long" then
        l__NotificationController__10:CreateNotification("Guild description is too long");
    elseif p94 == "description_filtered" then
        l__NotificationController__10:CreateNotification("Description not allowed, try another!");
    elseif p94 == "filter_unavailable" then
        l__NotificationController__10:CreateNotification("Couldn\'t verify that text right now - try again in a moment!");
    elseif p94 then
        l__NotificationController__10:CreateNotification((`Failed to save guild ({p94})`));
    else
        l__NotificationController__10:CreateNotification("Failed to save guild");
    end;
end;
local function u111() --[[ Line: 454 ]]
    -- upvalues: u16 (ref), u17 (ref), l__NotificationController__10 (copy)
    if not u16 then
        return true;
    end;
    local v103;
    if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
        v103 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
    else
        v103 = false;
    end;
    if not v103 then
        return true;
    end;
    local v104 = os.clock() - u16.FetchedAtClock;
    local v105 = u16.NameCooldownRemainingAtFetch - v104;
    if v105 <= 0 then
        return true;
    end;
    local v106 = l__NotificationController__10;
    local v107 = math.floor(v105 + 0.5);
    local v108 = math.max(0, v107);
    local v109 = v108 // 86400;
    local v110 = (v108 - v109 * 86400) // 3600;
    v106:CreateNotification((`You can change your name in {string.format("%dd %dh", v109, v109 <= 0 and v110 <= 0 and 1 or v110)}`));
    return false;
end;
local function u155() --[[ Line: 470 ]]
    -- upvalues: u23 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), l__NotificationController__10 (copy), u111 (copy), l__Networking__3 (copy), u102 (copy), u38 (copy), u6 (ref), u7 (ref), u8 (ref), u13 (ref), l__Asserts__4 (copy), u15 (ref), u12 (ref), l__GuiController__9 (copy)
    if u23 then
    elseif u16 then
        local v112;
        if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
            v112 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
        else
            v112 = false;
        end;
        if not v112 then
            if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                v112 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
            else
                v112 = false;
            end;
            if not v112 then
                if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                    v112 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v112 = false;
                end;
                if not v112 then
                    if u16 then
                        local v113 = u20;
                        local l__Color__29 = u16.Color;
                        local v114;
                        if math.abs(v113.R - l__Color__29.R) < 0.001 and math.abs(v113.G - l__Color__29.G) < 0.001 then
                            v114 = math.abs(v113.B - l__Color__29.B) < 0.001;
                        else
                            v114 = false;
                        end;
                        v112 = not v114;
                    else
                        v112 = false;
                    end;
                    if not v112 then
                        if u16 then
                            local v115 = u21;
                            local l__TagColor__30 = u16.TagColor;
                            local v116;
                            if math.abs(v115.R - l__TagColor__30.R) < 0.001 and math.abs(v115.G - l__TagColor__30.G) < 0.001 then
                                v116 = math.abs(v115.B - l__TagColor__30.B) < 0.001;
                            else
                                v116 = false;
                            end;
                            v112 = not v116;
                        else
                            v112 = false;
                        end;
                        if not v112 then
                            if u16 then
                                v112 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                            else
                                v112 = false;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        if v112 then
            if u111() then
                local v117;
                if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                    v117 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v117 = false;
                end;
                local u118 = not v117 and "" or string.gsub(u17, "^%s*(.-)%s*$", "%1");
                local v119;
                if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                    v119 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v119 = false;
                end;
                local u120 = not v119 and "" or string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1")));
                local v121;
                if u16 then
                    local v122 = u20;
                    local l__Color__31 = u16.Color;
                    local v123;
                    if math.abs(v122.R - l__Color__31.R) < 0.001 and math.abs(v122.G - l__Color__31.G) < 0.001 then
                        v123 = math.abs(v122.B - l__Color__31.B) < 0.001;
                    else
                        v123 = false;
                    end;
                    v121 = not v123;
                else
                    v121 = false;
                end;
                local u124;
                if v121 then
                    local v125 = u20;
                    local l__format__32 = string.format;
                    local v126 = math.floor(v125.R * 255 + 0.5);
                    local v127 = math.clamp(v126, 0, 255);
                    local v128 = math.floor(v125.G * 255 + 0.5);
                    local v129 = math.clamp(v128, 0, 255);
                    local v130 = math.floor(v125.B * 255 + 0.5);
                    u124 = l__format__32("#%02X%02X%02X", v127, v129, (math.clamp(v130, 0, 255)));
                else
                    u124 = "";
                end;
                local v131;
                if u16 then
                    local v132 = u21;
                    local l__TagColor__33 = u16.TagColor;
                    local v133;
                    if math.abs(v132.R - l__TagColor__33.R) < 0.001 and math.abs(v132.G - l__TagColor__33.G) < 0.001 then
                        v133 = math.abs(v132.B - l__TagColor__33.B) < 0.001;
                    else
                        v133 = false;
                    end;
                    v131 = not v133;
                else
                    v131 = false;
                end;
                local u134;
                if v131 then
                    local v135 = u21;
                    local l__format__34 = string.format;
                    local v136 = math.floor(v135.R * 255 + 0.5);
                    local v137 = math.clamp(v136, 0, 255);
                    local v138 = math.floor(v135.G * 255 + 0.5);
                    local v139 = math.clamp(v138, 0, 255);
                    local v140 = math.floor(v135.B * 255 + 0.5);
                    u134 = l__format__34("#%02X%02X%02X", v137, v139, (math.clamp(v140, 0, 255)));
                else
                    u134 = "";
                end;
                local v141;
                if u16 then
                    v141 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                else
                    v141 = false;
                end;
                local u142 = not v141 and 0 or l__DEFAULT_ICON_ID__15;
                local v143;
                if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                    v143 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v143 = false;
                end;
                local u144 = not v143 and "" or string.gsub(u19, "^%s*(.-)%s*$", "%1");
                u23 = true;
                task.spawn(function() --[[ Line: 490 ]]
                    -- upvalues: l__Networking__3 (ref), u118 (copy), u120 (copy), u124 (copy), u134 (copy), u142 (copy), u144 (copy), u23 (ref), l__NotificationController__10 (ref), u102 (ref), u38 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), u6 (ref), u7 (ref), u8 (ref), u13 (ref), l__Asserts__4 (ref), u15 (ref), u12 (ref), l__GuiController__9 (ref)
                    local v145, v146, v147 = pcall(function() --[[ Line: 491 ]]
                        -- upvalues: l__Networking__3 (ref), u118 (ref), u120 (ref), u124 (ref), u134 (ref), u142 (ref), u144 (ref)
                        return l__Networking__3.Guild.EditGuild:Fire(u118, u120, u124, u134, u142, u144);
                    end);
                    u23 = false;
                    if v145 then
                        if v146 then
                            l__NotificationController__10:CreateNotification("Saved guild changes");
                            local v148 = u38();
                            if v148 then
                                u16 = v148;
                                u17 = v148.Name;
                                u18 = v148.Tag;
                                u19 = v148.Description;
                                u20 = v148.Color;
                                u21 = v148.TagColor;
                                l__DEFAULT_ICON_ID__15 = v148.IconId;
                                if u6 then
                                    u6.Text = v148.Name;
                                    u6.TextColor3 = v148.Color;
                                end;
                                if u7 then
                                    u7.Text = v148.Tag;
                                    u7.TextColor3 = v148.TagColor;
                                end;
                                if u8 then
                                    u8.Text = v148.Description;
                                end;
                                if u13 then
                                    u13.Image = l__Asserts__4.IconAssetString(l__DEFAULT_ICON_ID__15);
                                end;
                                if u15 then
                                    u15.Text = l__Asserts__4.IsPoolIcon(l__DEFAULT_ICON_ID__15) and "" or tostring(l__DEFAULT_ICON_ID__15);
                                end;
                                if u12 then
                                    local v149 = u12;
                                    local v150;
                                    if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                                        v150 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
                                    else
                                        v150 = false;
                                    end;
                                    if not v150 then
                                        if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                                            v150 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                                        else
                                            v150 = false;
                                        end;
                                        if not v150 then
                                            if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                                                v150 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                                            else
                                                v150 = false;
                                            end;
                                            if not v150 then
                                                if u16 then
                                                    local v151 = u20;
                                                    local l__Color__35 = u16.Color;
                                                    local v152;
                                                    if math.abs(v151.R - l__Color__35.R) < 0.001 and math.abs(v151.G - l__Color__35.G) < 0.001 then
                                                        v152 = math.abs(v151.B - l__Color__35.B) < 0.001;
                                                    else
                                                        v152 = false;
                                                    end;
                                                    v150 = not v152;
                                                else
                                                    v150 = false;
                                                end;
                                                if not v150 then
                                                    if u16 then
                                                        local v153 = u21;
                                                        local l__TagColor__36 = u16.TagColor;
                                                        local v154;
                                                        if math.abs(v153.R - l__TagColor__36.R) < 0.001 and math.abs(v153.G - l__TagColor__36.G) < 0.001 then
                                                            v154 = math.abs(v153.B - l__TagColor__36.B) < 0.001;
                                                        else
                                                            v154 = false;
                                                        end;
                                                        v150 = not v154;
                                                    else
                                                        v150 = false;
                                                    end;
                                                    if not v150 then
                                                        if u16 then
                                                            v150 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                                        else
                                                            v150 = false;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                    v149.Visible = not v150;
                                end;
                            end;
                            if l__GuiController__9:IsOpen("EditGuild") then
                                l__GuiController__9:Open("ViewGuildPage", nil, { "HUD" });
                                if l__GuiController__9:IsOpen("EditGuild") then
                                    l__GuiController__9:Close();
                                end;
                            end;
                        else
                            u102(typeof(v147) == "string" and v147 and v147 or nil);
                        end;
                    else
                        l__NotificationController__10:CreateNotification("Failed to save guild");
                    end;
                end);
            end;
        else
            l__NotificationController__10:CreateNotification("Nothing to save");
        end;
    end;
end;
local function u177(u156) --[[ Line: 531 ]]
    -- upvalues: u5 (ref), u6 (ref), u9 (ref), u7 (ref), u10 (ref), u8 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref)
    local function v164(p157) --[[ Line: 539 ]]
        -- upvalues: u156 (copy)
        local v158 = u156:FindFirstChild(p157, true);
        if not v158 then
            return nil, nil;
        end;
        local v159 = nil;
        local v160 = v158:FindFirstChild("UsernameGuild");
        local v161;
        if v160 then
            v161 = v160:FindFirstChild("TextBox");
            if v161 then
                if not v161:IsA("TextBox") then
                    v161 = v159;
                end;
            else
                v161 = v159;
            end;
        else
            v161 = v159;
        end;
        local v162 = nil;
        local v163 = v158:FindFirstChild("ColorPickerGuildNameButton");
        if v163 then
            if not v163:IsA("GuiButton") then
                v163 = v162;
            end;
        else
            v163 = v162;
        end;
        return v161, v163;
    end;
    local v165 = u156:FindFirstChild("CloseButton", true) or u156:FindFirstChild("ExitButton", true);
    if v165 and v165:IsA("GuiButton") then
        u5 = v165;
    end;
    local v166, v167 = v164("GuildName");
    u6 = v166;
    u9 = v167;
    local v168, v169 = v164("GuildTag");
    u7 = v168;
    u10 = v169;
    u8 = v164("GuildDescription");
    local v170 = u156:FindFirstChild("ConfirmButton", true);
    if v170 and v170:IsA("GuiButton") then
        u11 = v170;
        local v171 = v170:FindFirstChild("Fade");
        if v171 and v171:IsA("GuiObject") then
            u12 = v171;
        end;
    end;
    local v172 = u156:FindFirstChild("GuildImagePreview", true);
    if v172 then
        local v173 = v172:FindFirstChild("GuildImage", true);
        if v173 and v173:IsA("ImageLabel") then
            u13 = v173;
        end;
        local v174 = v172:FindFirstChild("DiceButton", true);
        if v174 then
            if v174:IsA("GuiButton") then
                u14 = v174;
            else
                local v175 = v174:FindFirstChildOfClass("ImageButton") or v174:FindFirstChildOfClass("TextButton");
                if v175 then
                    u14 = v175;
                end;
            end;
        end;
        local v176 = v172:FindFirstChild("TextBox", true);
        if v176 and v176:IsA("TextBox") then
            u15 = v176;
        end;
    end;
end;
local function u178() --[[ Line: 609 ]]
    -- upvalues: u6 (ref), u49 (copy), u7 (ref), u61 (copy), u8 (ref), u72 (copy)
    if u6 then
        u6.ClearTextOnFocus = false;
        u6:GetPropertyChangedSignal("Text"):Connect(u49);
    end;
    if u7 then
        u7.ClearTextOnFocus = false;
        u7:GetPropertyChangedSignal("Text"):Connect(u61);
    end;
    if u8 then
        u8.ClearTextOnFocus = false;
        u8:GetPropertyChangedSignal("Text"):Connect(u72);
    end;
end;
local function u193() --[[ Line: 624 ]]
    -- upvalues: u9 (ref), l__ColorPickerGuildController__11 (copy), u20 (ref), u6 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), l__GuiController__9 (copy), u10 (ref), u7 (ref)
    if u9 then
        u9.MouseButton1Click:Connect(function() --[[ Line: 626 ]]
            -- upvalues: l__ColorPickerGuildController__11 (ref), u20 (ref), u6 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), l__GuiController__9 (ref)
            l__ColorPickerGuildController__11:RequestColor(u20, function(p179) --[[ Line: 627 ]]
                -- upvalues: u20 (ref), u6 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), l__GuiController__9 (ref)
                if p179 then
                    u20 = p179;
                    if u6 then
                        u6.TextColor3 = p179;
                    end;
                    if u12 then
                        local v180 = u12;
                        local v181;
                        if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                            v181 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
                        else
                            v181 = false;
                        end;
                        if not v181 then
                            if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                                v181 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                            else
                                v181 = false;
                            end;
                            if not v181 then
                                if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                                    v181 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                                else
                                    v181 = false;
                                end;
                                if not v181 then
                                    if u16 then
                                        local v182 = u20;
                                        local l__Color__37 = u16.Color;
                                        local v183;
                                        if math.abs(v182.R - l__Color__37.R) < 0.001 and math.abs(v182.G - l__Color__37.G) < 0.001 then
                                            v183 = math.abs(v182.B - l__Color__37.B) < 0.001;
                                        else
                                            v183 = false;
                                        end;
                                        v181 = not v183;
                                    else
                                        v181 = false;
                                    end;
                                    if not v181 then
                                        if u16 then
                                            local v184 = u21;
                                            local l__TagColor__38 = u16.TagColor;
                                            local v185;
                                            if math.abs(v184.R - l__TagColor__38.R) < 0.001 and math.abs(v184.G - l__TagColor__38.G) < 0.001 then
                                                v185 = math.abs(v184.B - l__TagColor__38.B) < 0.001;
                                            else
                                                v185 = false;
                                            end;
                                            v181 = not v185;
                                        else
                                            v181 = false;
                                        end;
                                        if not v181 then
                                            if u16 then
                                                v181 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                            else
                                                v181 = false;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        v180.Visible = not v181;
                    end;
                end;
                if not l__GuiController__9:IsOpen("EditGuild") then
                    l__GuiController__9:Open("EditGuild", nil, { "HUD" });
                end;
            end);
        end);
    end;
    if u10 then
        u10.MouseButton1Click:Connect(function() --[[ Line: 637 ]]
            -- upvalues: l__ColorPickerGuildController__11 (ref), u21 (ref), u7 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), l__DEFAULT_ICON_ID__15 (ref), l__GuiController__9 (ref)
            l__ColorPickerGuildController__11:RequestColor(u21, function(p186) --[[ Line: 638 ]]
                -- upvalues: u21 (ref), u7 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), l__DEFAULT_ICON_ID__15 (ref), l__GuiController__9 (ref)
                if p186 then
                    u21 = p186;
                    if u7 then
                        u7.TextColor3 = p186;
                    end;
                    if u12 then
                        local v187 = u12;
                        local v188;
                        if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                            v188 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
                        else
                            v188 = false;
                        end;
                        if not v188 then
                            if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                                v188 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                            else
                                v188 = false;
                            end;
                            if not v188 then
                                if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                                    v188 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                                else
                                    v188 = false;
                                end;
                                if not v188 then
                                    if u16 then
                                        local v189 = u20;
                                        local l__Color__39 = u16.Color;
                                        local v190;
                                        if math.abs(v189.R - l__Color__39.R) < 0.001 and math.abs(v189.G - l__Color__39.G) < 0.001 then
                                            v190 = math.abs(v189.B - l__Color__39.B) < 0.001;
                                        else
                                            v190 = false;
                                        end;
                                        v188 = not v190;
                                    else
                                        v188 = false;
                                    end;
                                    if not v188 then
                                        if u16 then
                                            local v191 = u21;
                                            local l__TagColor__40 = u16.TagColor;
                                            local v192;
                                            if math.abs(v191.R - l__TagColor__40.R) < 0.001 and math.abs(v191.G - l__TagColor__40.G) < 0.001 then
                                                v192 = math.abs(v191.B - l__TagColor__40.B) < 0.001;
                                            else
                                                v192 = false;
                                            end;
                                            v188 = not v192;
                                        else
                                            v188 = false;
                                        end;
                                        if not v188 then
                                            if u16 then
                                                v188 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                            else
                                                v188 = false;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        v187.Visible = not v188;
                    end;
                end;
                if not l__GuiController__9:IsOpen("EditGuild") then
                    l__GuiController__9:Open("EditGuild", nil, { "HUD" });
                end;
            end);
        end);
    end;
end;
function v3.Init(_) --[[ Line: 688 ]] end;
function v3.Start(_) --[[ Line: 690 ]]
    -- upvalues: l__PlayerGui__8 (copy), u4 (ref), u177 (copy), u5 (ref), l__GuiController__9 (copy), u178 (copy), u193 (copy), u11 (ref), u155 (copy), u14 (ref), u81 (copy), u15 (ref), u93 (copy), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), u38 (copy), l__NotificationController__10 (copy), u6 (ref), u7 (ref), u8 (ref), u13 (ref), l__Asserts__4 (copy)
    task.spawn(function() --[[ Line: 691 ]]
        -- upvalues: l__PlayerGui__8 (ref), u4 (ref), u177 (ref), u5 (ref), l__GuiController__9 (ref), u178 (ref), u193 (ref), u11 (ref), u155 (ref), u14 (ref), u81 (ref), u15 (ref), u93 (ref), u12 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), u38 (ref), l__NotificationController__10 (ref), u6 (ref), u7 (ref), u8 (ref), u13 (ref), l__Asserts__4 (ref)
        local l__EditGuild__41 = l__PlayerGui__8:WaitForChild("EditGuild", 30);
        if l__EditGuild__41 and l__EditGuild__41:IsA("ScreenGui") then
            u4 = l__EditGuild__41;
            l__EditGuild__41.Enabled = false;
            u177(l__EditGuild__41);
            if u5 then
                u5.MouseButton1Click:Connect(function() --[[ Line: 596 ]]
                    -- upvalues: l__GuiController__9 (ref)
                    if l__GuiController__9:IsOpen("EditGuild") then
                        l__GuiController__9:Open("ViewGuildPage", nil, { "HUD" });
                        if l__GuiController__9:IsOpen("EditGuild") then
                            l__GuiController__9:Close();
                        end;
                    end;
                end);
            end;
            u178();
            u193();
            if u11 then
                u11.MouseButton1Click:Connect(u155);
            end;
            if u14 then
                u14.MouseButton1Click:Connect(u81);
            end;
            if u15 then
                u15.ClearTextOnFocus = false;
                u15.FocusLost:Connect(function() --[[ Line: 659 ]]
                    -- upvalues: u15 (ref), u93 (ref)
                    if u15 then
                        u93(u15.Text);
                    end;
                end);
            end;
            if u12 then
                local v194 = u12;
                local v195;
                if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                    v195 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
                else
                    v195 = false;
                end;
                if not v195 then
                    if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                        v195 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                    else
                        v195 = false;
                    end;
                    if not v195 then
                        if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                            v195 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                        else
                            v195 = false;
                        end;
                        if not v195 then
                            if u16 then
                                local v196 = u20;
                                local l__Color__42 = u16.Color;
                                local v197;
                                if math.abs(v196.R - l__Color__42.R) < 0.001 and math.abs(v196.G - l__Color__42.G) < 0.001 then
                                    v197 = math.abs(v196.B - l__Color__42.B) < 0.001;
                                else
                                    v197 = false;
                                end;
                                v195 = not v197;
                            else
                                v195 = false;
                            end;
                            if not v195 then
                                if u16 then
                                    local v198 = u21;
                                    local l__TagColor__43 = u16.TagColor;
                                    local v199;
                                    if math.abs(v198.R - l__TagColor__43.R) < 0.001 and math.abs(v198.G - l__TagColor__43.G) < 0.001 then
                                        v199 = math.abs(v198.B - l__TagColor__43.B) < 0.001;
                                    else
                                        v199 = false;
                                    end;
                                    v195 = not v199;
                                else
                                    v195 = false;
                                end;
                                if not v195 then
                                    if u16 then
                                        v195 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                    else
                                        v195 = false;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                v194.Visible = not v195;
            end;
            l__GuiController__9.GuiFocusedSignal:Connect(function(p200) --[[ Line: 706 ]]
                -- upvalues: l__EditGuild__41 (copy), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), u38 (ref), l__NotificationController__10 (ref), u6 (ref), u7 (ref), u8 (ref), u13 (ref), l__Asserts__4 (ref), u15 (ref), u12 (ref)
                if p200 == l__EditGuild__41 then
                    local v201;
                    if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                        v201 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
                    else
                        v201 = false;
                    end;
                    if not v201 then
                        if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                            v201 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                        else
                            v201 = false;
                        end;
                        if not v201 then
                            if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                                v201 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                            else
                                v201 = false;
                            end;
                            if not v201 then
                                if u16 then
                                    local v202 = u20;
                                    local l__Color__44 = u16.Color;
                                    local v203;
                                    if math.abs(v202.R - l__Color__44.R) < 0.001 and math.abs(v202.G - l__Color__44.G) < 0.001 then
                                        v203 = math.abs(v202.B - l__Color__44.B) < 0.001;
                                    else
                                        v203 = false;
                                    end;
                                    v201 = not v203;
                                else
                                    v201 = false;
                                end;
                                if not v201 then
                                    if u16 then
                                        local v204 = u21;
                                        local l__TagColor__45 = u16.TagColor;
                                        local v205;
                                        if math.abs(v204.R - l__TagColor__45.R) < 0.001 and math.abs(v204.G - l__TagColor__45.G) < 0.001 then
                                            v205 = math.abs(v204.B - l__TagColor__45.B) < 0.001;
                                        else
                                            v205 = false;
                                        end;
                                        v201 = not v205;
                                    else
                                        v201 = false;
                                    end;
                                    if not v201 then
                                        if u16 then
                                            v201 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                        else
                                            v201 = false;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                    if v201 then
                        return;
                    end;
                    task.spawn(function() --[[ Line: 677 ]]
                        -- upvalues: u38 (ref), l__NotificationController__10 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), l__DEFAULT_ICON_ID__15 (ref), u6 (ref), u7 (ref), u8 (ref), u13 (ref), l__Asserts__4 (ref), u15 (ref), u12 (ref)
                        local v206 = u38();
                        if v206 then
                            u16 = v206;
                            u17 = v206.Name;
                            u18 = v206.Tag;
                            u19 = v206.Description;
                            u20 = v206.Color;
                            u21 = v206.TagColor;
                            l__DEFAULT_ICON_ID__15 = v206.IconId;
                            if u6 then
                                u6.Text = v206.Name;
                                u6.TextColor3 = v206.Color;
                            end;
                            if u7 then
                                u7.Text = v206.Tag;
                                u7.TextColor3 = v206.TagColor;
                            end;
                            if u8 then
                                u8.Text = v206.Description;
                            end;
                            if u13 then
                                u13.Image = l__Asserts__4.IconAssetString(l__DEFAULT_ICON_ID__15);
                            end;
                            if u15 then
                                u15.Text = l__Asserts__4.IsPoolIcon(l__DEFAULT_ICON_ID__15) and "" or tostring(l__DEFAULT_ICON_ID__15);
                            end;
                            if u12 then
                                local v207 = u12;
                                local v208;
                                if u16 and string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= u16.Name then
                                    v208 = string.gsub(u17, "^%s*(.-)%s*$", "%1") ~= "";
                                else
                                    v208 = false;
                                end;
                                if not v208 then
                                    if u16 and string.upper((string.gsub(u18, "^%s*(.-)%s*$", "%1"))) ~= u16.Tag then
                                        v208 = string.gsub(u18, "^%s*(.-)%s*$", "%1") ~= "";
                                    else
                                        v208 = false;
                                    end;
                                    if not v208 then
                                        if u16 and string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= u16.Description then
                                            v208 = string.gsub(u19, "^%s*(.-)%s*$", "%1") ~= "";
                                        else
                                            v208 = false;
                                        end;
                                        if not v208 then
                                            if u16 then
                                                local v209 = u20;
                                                local l__Color__46 = u16.Color;
                                                local v210;
                                                if math.abs(v209.R - l__Color__46.R) < 0.001 and math.abs(v209.G - l__Color__46.G) < 0.001 then
                                                    v210 = math.abs(v209.B - l__Color__46.B) < 0.001;
                                                else
                                                    v210 = false;
                                                end;
                                                v208 = not v210;
                                            else
                                                v208 = false;
                                            end;
                                            if not v208 then
                                                if u16 then
                                                    local v211 = u21;
                                                    local l__TagColor__47 = u16.TagColor;
                                                    local v212;
                                                    if math.abs(v211.R - l__TagColor__47.R) < 0.001 and math.abs(v211.G - l__TagColor__47.G) < 0.001 then
                                                        v212 = math.abs(v211.B - l__TagColor__47.B) < 0.001;
                                                    else
                                                        v212 = false;
                                                    end;
                                                    v208 = not v212;
                                                else
                                                    v208 = false;
                                                end;
                                                if not v208 then
                                                    if u16 then
                                                        v208 = l__DEFAULT_ICON_ID__15 ~= u16.IconId;
                                                    else
                                                        v208 = false;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                                v207.Visible = not v208;
                            end;
                        else
                            l__NotificationController__10:CreateNotification("Couldn\'t load your guild");
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
return v3;