-- Decompiled with Potassium's decompiler.

local u1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ProximityPromptService__2 = game:GetService("ProximityPromptService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__TweenService__4 = game:GetService("TweenService");
local l__Networking__5 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__PlayerStateClient__6 = require(l__ReplicatedStorage__3.ClientModules.PlayerStateClient);
local l__AnimatedGradient__7 = require(l__ReplicatedStorage__3.SharedModules.AnimatedGradient);
local l__PetTypes__8 = require(l__ReplicatedStorage__3.SharedData.PetTypes);
local l__MailboxFlags__9 = require(l__ReplicatedStorage__3.SharedModules.Flags.MailboxFlags);
local l__LocalPlayer__10 = l__Players__1.LocalPlayer;
local l__PlayerGui__11 = l__LocalPlayer__10:WaitForChild("PlayerGui");
local l__GuiController__12 = require(l__LocalPlayer__10.PlayerScripts.Controllers.GuiController);
local l__NotificationController__13 = require(l__LocalPlayer__10.PlayerScripts.Controllers.NotificationController);
local l__MailboxItemCatalog__14 = require(script.MailboxItemCatalog);
local u2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u3 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u4 = nil;
local u5 = false;
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = {};
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
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = nil;
local u35 = "Send";
local u36 = 0;
local u37 = nil;
local u38 = nil;
local u39 = nil;
local u40 = {};
local u41 = false;
local u42 = 0;
local u43 = {};
local u44 = false;
local u45 = {};
local function u47() --[[ Line: 132 ]]
    -- upvalues: u6 (copy)
    for _, u46 in u6 do
        pcall(function() --[[ Line: 134 ]]
            -- upvalues: u46 (copy)
            u46:Disconnect();
        end);
    end;
    table.clear(u6);
end;
local function u51(p48, p49) --[[ Line: 143 ]]
    if p48 then
        for _, v50 in p48:GetDescendants() do
            if v50:IsA("BasePart") then
                v50.Transparency = p49;
            end;
        end;
    end;
end;
local function u56(p52) --[[ Line: 152 ]]
    -- upvalues: u44 (ref), u51 (copy)
    local v53 = p52:FindFirstChild("Notification");
    if v53 then
        v53 = v53:FindFirstChildWhichIsA("BillboardGui");
    end;
    if v53 then
        v53.Enabled = u44;
    end;
    local v54 = p52:FindFirstChild("FlagUp");
    local v55 = p52:FindFirstChild("FlagDown");
    u51(v54, u44 and 0 or 1);
    u51(v55, u44 and 1 or 0);
end;
local function u61(u57) --[[ Line: 175 ]]
    -- upvalues: u45 (copy), u56 (copy), u7 (copy)
    if u45[u57] then
    else
        u45[u57] = true;
        u56(u57);
        local v58 = u57.DescendantAdded:Connect(function() --[[ Line: 180 ]]
            -- upvalues: u56 (ref), u57 (copy)
            u56(u57);
        end);
        table.insert(u7, v58);
        local v60 = u57.AncestryChanged:Connect(function(_, p59) --[[ Line: 183 ]]
            -- upvalues: u45 (ref), u57 (copy)
            if p59 == nil then
                u45[u57] = nil;
            end;
        end);
        table.insert(u7, v60);
    end;
end;
local function u66() --[[ Line: 190 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local v62 = workspace:FindFirstChild("Gardens");
    if not v62 then
        return nil;
    end;
    local v63 = l__LocalPlayer__10:GetAttribute("PlotId");
    local v64 = v63 ~= nil and v62:FindFirstChild("Plot" .. tostring(v63));
    if v64 then
        return v64;
    end;
    for _, v65 in v62:GetChildren() do
        if v65:GetAttribute("OwnerUserId") == l__LocalPlayer__10.UserId then
            return v65;
        end;
    end;
    return nil;
end;
local function u71() --[[ Line: 206 ]]
    -- upvalues: u66 (copy), u61 (copy), u7 (copy)
    local v67 = u66();
    if v67 then
        for _, v68 in v67:GetDescendants() do
            if v68:IsA("Model") and v68.Name == "GreyMailBox" then
                u61(v68);
            end;
        end;
        local v70 = v67.DescendantAdded:Connect(function(p69) --[[ Line: 215 ]]
            -- upvalues: u61 (ref)
            if p69:IsA("Model") and p69.Name == "GreyMailBox" then
                u61(p69);
            end;
        end);
        table.insert(u7, v70);
    end;
end;
local function u75(p72, p73) --[[ Line: 254 ]]
    for _, v74 in p72:GetChildren() do
        if not (p73[v74] or (v74:IsA("UIGridLayout") or (v74:IsA("UIListLayout") or (v74:IsA("UIPadding") or (v74:IsA("UISizeConstraint") or v74:IsA("UIAspectRatioConstraint")))))) then
            v74:Destroy();
        end;
    end;
end;
local function u79(p76, p77) --[[ Line: 268 ]]
    -- upvalues: u79 (copy)
    if p76:IsA("TextLabel") or (p76:IsA("TextButton") or p76:IsA("TextBox")) then
        p76.Text = p77;
    end;
    for _, v78 in p76:GetChildren() do
        if v78:IsA("TextLabel") or (v78:IsA("TextButton") or v78:IsA("TextBox")) then
            v78.Text = p77;
        end;
        u79(v78, p77);
    end;
end;
local function u83(p80, p81) --[[ Line: 280 ]]
    if p80:IsA("TextLabel") or p80:IsA("TextButton") then
        p80.Text = p81;
    end;
    for _, v82 in p80:GetDescendants() do
        if v82:IsA("TextLabel") or v82:IsA("TextButton") then
            v82.Text = p81;
        end;
    end;
end;
local function u84() --[[ Line: 292 ]]
    -- upvalues: u34 (ref), u35 (ref), u8 (ref), u9 (ref), u83 (copy), u37 (ref), u36 (ref), u40 (copy)
    if u34 then
        if u35 == "Receive" then
            if next(u8) == nil and next(u9) == nil then
                u34.Visible = true;
                u83(u34, "You dont have any mail");
            else
                u34.Visible = false;
            end;
        elseif u35 == "Send" and (u37 ~= nil and (u36 == 0 and next(u40) == nil)) then
            u34.Visible = true;
            u83(u34, "You dont have anything to send");
        else
            u34.Visible = false;
        end;
    end;
end;
local function u100(u85, u86) --[[ Line: 323 ]]
    -- upvalues: u10 (ref), u11 (ref), l__MailboxItemCatalog__14 (copy), u1 (copy), u83 (copy), u6 (copy)
    if not (u10 and u11) then
        return nil;
    end;
    local v87 = typeof(u86) == "table" and u86.Kind == "GuildReward" and l__MailboxItemCatalog__14.BuildGuildRewardVisual(u11, u85, u86, function() --[[ Line: 338 ]]
        -- upvalues: u1 (ref), u85 (copy), u86 (copy)
        u1:_claimGift(u85, u86, nil);
    end);
    if v87 then
        return v87;
    end;
    local u88 = u10:Clone();
    u88.Name = "Gift_" .. u85;
    u88.Visible = true;
    local v89 = u88:FindFirstChild("Interior");
    if not v89 then
        return nil;
    end;
    local v90 = v89:FindFirstChild("TopFrame");
    local v91 = string.format("From @%s!", (tostring(u86.FromName or "?")));
    if v90 then
        local v92 = v90:FindFirstChild("SentPlayerNameTextLabel1");
        if v92 then
            u83(v92, v91);
        end;
        local v93 = v90:FindFirstChild("SubjectLine1");
        if v93 then
            u83(v93, v91);
        end;
        local u94 = v90:FindFirstChild("SentPlayerImageLabel");
        if u94 and u94:IsA("ImageLabel") then
            task.spawn(function() --[[ Line: 376 ]]
                -- upvalues: l__MailboxItemCatalog__14 (ref), u86 (copy), u88 (copy), u94 (copy)
                local v95 = l__MailboxItemCatalog__14.GetHeadshot(u86.From or 0);
                if v95 ~= "" and u88.Parent then
                    u94.Image = v95;
                end;
            end);
        end;
    end;
    local l__Note__15 = u86.Note;
    local v96 = (typeof(l__Note__15) ~= "string" or l__Note__15 == "") and "Here is a gift!" or l__Note__15;
    local v97 = v89:FindFirstChild("NoteTextlabel");
    if v97 then
        u83(v97, v96);
    end;
    local u98 = v89:FindFirstChild("Claim");
    if u98 and u98:IsA("GuiButton") then
        local v99 = u98.MouseButton1Click:Connect(function() --[[ Line: 396 ]]
            -- upvalues: u1 (ref), u85 (copy), u86 (copy), u98 (copy)
            u1:_claimGift(u85, u86, u98);
        end);
        table.insert(u6, v99);
    end;
    u88.Parent = u11;
    return u88;
end;
local function u104(u101, p102) --[[ Line: 405 ]]
    -- upvalues: u12 (ref), u10 (ref), u11 (ref), l__MailboxItemCatalog__14 (copy), u1 (copy)
    local v103 = u12 or u10;
    if v103 and u11 then
        return l__MailboxItemCatalog__14.BuildInviteVisual(v103, u11, u101, p102, function() --[[ Line: 417 ]]
            -- upvalues: u1 (ref), u101 (copy)
            u1:_respondInvite(u101, true);
        end, function() --[[ Line: 418 ]]
            -- upvalues: u1 (ref), u101 (copy)
            u1:_respondInvite(u101, false);
        end);
    else
        return nil;
    end;
end;
local function u118() --[[ Line: 422 ]]
    -- upvalues: u8 (ref), u9 (ref), u44 (ref), u45 (copy), u56 (copy), u27 (ref), u11 (ref), u10 (ref), u104 (copy), u100 (copy), u84 (copy)
    local v105 = false;
    for _ in u8 do
        v105 = true;
        break;
    end;
    if not v105 then
        for _ in u9 do
            v105 = true;
            break;
        end;
    end;
    if u44 ~= v105 then
        u44 = v105;
        for v106 in u45 do
            if v106.Parent then
                u56(v106);
            else
                u45[v106] = nil;
            end;
        end;
        if u27 then
            u27.Visible = u44;
        end;
    end;
    if u11 and u10 then
        for _, v107 in u11:GetChildren() do
            local l__Name__16 = v107.Name;
            if string.sub(l__Name__16, 1, 5) == "Gift_" or string.sub(l__Name__16, 1, 7) == "Invite_" then
                v107:Destroy();
            end;
        end;
        local v108 = {};
        for v109, v110 in u8 do
            local v111 = {
                kind = "Gift",
                id = v109,
                sortAt = tonumber(v110.SentAt) or 0,
                payload = v110
            };
            table.insert(v108, v111);
        end;
        for v112, v113 in u9 do
            local v114 = {
                kind = "Invite",
                id = v112,
                sortAt = tonumber(v113.ReceivedAt or v113.ExpiresAt) or 0,
                payload = v113
            };
            table.insert(v108, v114);
        end;
        table.sort(v108, function(p115, p116) --[[ Line: 462 ]]
            return p115.sortAt > p116.sortAt;
        end);
        for _, v117 in v108 do
            if v117.kind == "Invite" then
                u104(v117.id, v117.payload);
            else
                u100(v117.id, v117.payload);
            end;
        end;
        u84();
    end;
end;
function u1._respondInvite(_, u119, u120) --[[ Line: 477 ]]
    -- upvalues: u13 (copy), u11 (ref), u9 (ref), u8 (ref), u44 (ref), u45 (copy), u56 (copy), u27 (ref), l__Networking__5 (copy), l__NotificationController__13 (copy)
    if u13[u119] then
    else
        u13[u119] = true;
        local v121 = u11;
        if v121 then
            v121 = u11:FindFirstChild("Invite_" .. u119);
        end;
        if v121 then
            v121:Destroy();
        end;
        u9[u119] = nil;
        local v122 = false;
        for _ in u8 do
            v122 = true;
            break;
        end;
        if not v122 then
            for _ in u9 do
                v122 = true;
                break;
            end;
        end;
        if u44 ~= v122 then
            u44 = v122;
            for v123 in u45 do
                if v123.Parent then
                    u56(v123);
                else
                    u45[v123] = nil;
                end;
            end;
            if u27 then
                u27.Visible = u44;
            end;
        end;
        task.spawn(function() --[[ Line: 490 ]]
            -- upvalues: l__Networking__5 (ref), u119 (copy), u120 (copy), u13 (ref), l__NotificationController__13 (ref)
            local v124, v125, v126 = pcall(function() --[[ Line: 491 ]]
                -- upvalues: l__Networking__5 (ref), u119 (ref), u120 (ref)
                return l__Networking__5.Guild.RespondInvite:Fire(u119, u120);
            end);
            u13[u119] = nil;
            if v124 then
                if v125 then
                    if u120 then
                        l__NotificationController__13:CreateNotification("Joined guild!");
                    end;
                else
                    if v126 and v126 ~= "" then
                        l__NotificationController__13:CreateNotification(v126);
                    end;
                end;
            else
                l__NotificationController__13:CreateNotification("Try again");
            end;
        end);
    end;
end;
function u1._claimGift(_, u127, u128, u129) --[[ Line: 511 ]]
    -- upvalues: u43 (copy), l__Networking__5 (copy), l__NotificationController__13 (copy), l__MailboxItemCatalog__14 (copy), u11 (ref), u8 (ref), u9 (ref), u44 (ref), u45 (copy), u56 (copy), u27 (ref)
    if u43[u127] then
    else
        u43[u127] = true;
        if u129 then
            if u129:IsA("TextButton") or u129:IsA("ImageButton") then
                u129.AutoButtonColor = false;
            end;
            u129.Active = false;
        end;
        task.spawn(function() --[[ Line: 525 ]]
            -- upvalues: l__Networking__5 (ref), u127 (copy), u43 (ref), u129 (copy), l__NotificationController__13 (ref), u128 (copy), l__MailboxItemCatalog__14 (ref), u11 (ref), u8 (ref), u9 (ref), u44 (ref), u45 (ref), u56 (ref), u27 (ref)
            local v130, v131, v132 = pcall(function() --[[ Line: 526 ]]
                -- upvalues: l__Networking__5 (ref), u127 (ref)
                return l__Networking__5.Mailbox.Claim:Fire(u127);
            end);
            u43[u127] = nil;
            if u129 then
                u129.Active = true;
            end;
            if v130 then
                if v131 then
                    local l__Items__17 = u128.Items;
                    if typeof(l__Items__17) == "table" and #l__Items__17 > 0 then
                        for _, v133 in ipairs(l__Items__17) do
                            local v134, _ = l__MailboxItemCatalog__14.Resolve(v133.Category, v133.ItemName, v133.Pet or v133.Fruit);
                            l__NotificationController__13:CreateNotification(string.format("x%d %s", v133.Count or 1, v134));
                        end;
                    else
                        local v135, _ = l__MailboxItemCatalog__14.Resolve(u128.Category, u128.ItemName, u128.Payload);
                        l__NotificationController__13:CreateNotification(string.format("x1 %s", v135));
                    end;
                    local v136 = u11;
                    if v136 then
                        v136 = u11:FindFirstChild("Gift_" .. u127);
                    end;
                    if v136 then
                        v136:Destroy();
                    end;
                    u8[u127] = nil;
                    local v137 = false;
                    for _ in u8 do
                        v137 = true;
                        break;
                    end;
                    if not v137 then
                        for _ in u9 do
                            v137 = true;
                            break;
                        end;
                    end;
                    if u44 == v137 then
                    else
                        u44 = v137;
                        for v138 in u45 do
                            if v138.Parent then
                                u56(v138);
                            else
                                u45[v138] = nil;
                            end;
                        end;
                        if u27 then
                            u27.Visible = u44;
                        end;
                    end;
                else
                    if v132 and v132 ~= "" then
                        l__NotificationController__13:CreateNotification(v132);
                    end;
                end;
            else
                l__NotificationController__13:CreateNotification("Try again");
            end;
        end);
    end;
end;
local u139 = {};
local function u155(u140, u141, p142, p143) --[[ Line: 591 ]]
    -- upvalues: u14 (ref), u15 (ref), u139 (copy), u83 (copy), l__MailboxItemCatalog__14 (copy), u6 (copy), u1 (copy)
    if not (u14 and u15) then
        return nil;
    end;
    if u139[u140] and u139[u140].Parent then
        return u139[u140];
    end;
    local u144 = u14:Clone();
    u144.Name = p143 .. "_" .. tostring(u140);
    u144.Visible = true;
    local v145 = u144:FindFirstChild("Button");
    if not (v145 and v145:IsA("GuiButton")) then
        u144:Destroy();
        return nil;
    end;
    local u146 = v145:FindFirstChild("HoverFrame");
    if u146 and u146:IsA("GuiObject") then
        u146.Visible = false;
    end;
    local v147 = v145:FindFirstChild("PlayerDisplayName1");
    if v147 then
        u83(v147, u141);
    end;
    local v148 = v145:FindFirstChild("PlayerUsername");
    if v148 and (v148:IsA("TextLabel") or v148:IsA("TextButton")) then
        v148.Text = "@" .. p142;
    end;
    local v149 = v145:FindFirstChild("PlayerDisplay");
    if v149 then
        local u150 = v149:FindFirstChild("PlayerImage");
        if u150 and u150:IsA("ImageLabel") then
            task.spawn(function() --[[ Line: 627 ]]
                -- upvalues: l__MailboxItemCatalog__14 (ref), u140 (copy), u144 (copy), u150 (copy)
                local v151 = l__MailboxItemCatalog__14.GetHeadshot(u140);
                if v151 ~= "" and u144.Parent then
                    u150.Image = v151;
                end;
            end);
        end;
    end;
    local v152 = v145.MouseEnter:Connect(function() --[[ Line: 636 ]]
        -- upvalues: u146 (copy)
        if u146 and u146:IsA("GuiObject") then
            u146.Visible = true;
        end;
    end);
    table.insert(u6, v152);
    local v153 = v145.MouseLeave:Connect(function() --[[ Line: 641 ]]
        -- upvalues: u146 (copy)
        if u146 and u146:IsA("GuiObject") then
            u146.Visible = false;
        end;
    end);
    table.insert(u6, v153);
    local v154 = v145.MouseButton1Click:Connect(function() --[[ Line: 646 ]]
        -- upvalues: u1 (ref), u140 (copy), u141 (copy)
        u1:_pickRecipient(u140, u141);
    end);
    table.insert(u6, v154);
    u144.Parent = u15;
    u139[u140] = u144;
    return u144;
end;
local function u161() --[[ Line: 662 ]]
    -- upvalues: u15 (ref), u14 (ref), u75 (copy), u139 (copy), u38 (ref), l__Players__1 (copy), l__LocalPlayer__10 (copy), u155 (copy), u4 (ref)
    if u15 and u14 then
        u75(u15, {
            [u14] = true
        });
        table.clear(u139);
        u38 = nil;
    end;
    for _, v156 in l__Players__1:GetPlayers() do
        if v156 ~= l__LocalPlayer__10 then
            u155(v156.UserId, v156.DisplayName, v156.Name, "Server");
        end;
    end;
    task.spawn(function() --[[ Line: 670 ]]
        -- upvalues: l__Players__1 (ref), l__LocalPlayer__10 (ref), u4 (ref), u139 (ref), u155 (ref)
        local v157, u158 = pcall(function() --[[ Line: 671 ]]
            -- upvalues: l__Players__1 (ref), l__LocalPlayer__10 (ref)
            return l__Players__1:GetFriendsAsync(l__LocalPlayer__10.UserId);
        end);
        if not (v157 and u158) then
            return;
        end;
        local v159 = 0;
        while v159 < 30 do
            for _, v160 in u158:GetCurrentPage() do
                if not (u4 and u4.Enabled) then
                    return;
                end;
                if v159 >= 30 then
                    break;
                end;
                local l__Id__18 = v160.Id;
                if l__Id__18 and (l__Id__18 ~= l__LocalPlayer__10.UserId and not u139[l__Id__18]) then
                    u155(l__Id__18, v160.DisplayName or v160.Username, v160.Username, "Friend");
                    v159 = v159 + 1;
                end;
            end;
            if u158.IsFinished or not pcall(function() --[[ Line: 690 ]]
                -- upvalues: u158 (copy)
                u158:AdvanceToNextPageAsync();
            end) then
                break;
            end;
        end;
    end);
end;
local function u169(_) --[[ Line: 705 ]]
    -- upvalues: u16 (ref), l__Networking__5 (copy), u4 (ref), u37 (ref), u38 (ref), u155 (copy)
    if u16 then
        local u162 = string.gsub(u16.Text or "", "^%s*@?(.-)%s*$", "%1");
        if u162 == "" then
        else
            local v163;
            if #u162 < 3 or #u162 > 20 then
                v163 = false;
            else
                v163 = string.match(u162, "^[%w_]+$") ~= nil;
            end;
            if v163 then
                task.spawn(function() --[[ Line: 712 ]]
                    -- upvalues: l__Networking__5 (ref), u162 (copy), u4 (ref), u37 (ref), u38 (ref), u155 (ref)
                    local v164, v165, v166 = pcall(function() --[[ Line: 713 ]]
                        -- upvalues: l__Networking__5 (ref), u162 (ref)
                        return l__Networking__5.Mailbox.LookupPlayer:Fire(u162);
                    end);
                    if v164 and (typeof(v165) == "number" and v165 > 0) then
                        if u4 and u4.Enabled then
                            if u37 then
                            else
                                if u38 then
                                    u38:Destroy();
                                    u38 = nil;
                                end;
                                local v167 = u155;
                                if v166 == "" or not v166 then
                                    v166 = u162;
                                end;
                                local v168 = v167(v165, v166, u162, "Search");
                                if v168 then
                                    u38 = v168;
                                    v168.LayoutOrder = -1;
                                end;
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end;
end;
local function u170() --[[ Line: 735 ]]
    -- upvalues: u38 (ref)
    if u38 then
        u38:Destroy();
        u38 = nil;
    end;
end;
local u171 = {};
local function u177(p172, p173, p174) --[[ Line: 761 ]]
    -- upvalues: l__MailboxItemCatalog__14 (copy), u171 (copy)
    if l__MailboxItemCatalog__14.IsGiftable(p172) then
        if p172 == "HarvestedFruits" then
            local v175;
            if typeof(p174) == "table" then
                v175 = p174.Id ~= nil;
            else
                v175 = false;
            end;
            return v175;
        elseif p172 == "Pets" then
            if typeof(p174) == "table" and p174.Id ~= nil then
                if u171[p173] then
                    return false;
                else
                    return p174.Equipped ~= true;
                end;
            else
                return false;
            end;
        else
            local v176;
            if typeof(p174) == "number" then
                v176 = p174 > 0;
            else
                v176 = false;
            end;
            return v176;
        end;
    else
        return false;
    end;
end;
local function u181(p178) --[[ Line: 779 ]]
    local v179 = { p178 };
    for _, v180 in p178:GetDescendants() do
        if v180:IsA("GuiButton") then
            table.insert(v179, v180);
        end;
    end;
    return v179;
end;
local function u186(p182, p183, p184) --[[ Line: 796 ]]
    -- upvalues: l__PetTypes__8 (copy), l__AnimatedGradient__7 (copy)
    if p182 then
        local v185;
        if p183 == "Pets" and typeof(p184) == "table" then
            v185 = p184.Type == l__PetTypes__8.Rainbow;
        else
            v185 = false;
        end;
        if v185 then
            l__AnimatedGradient__7:AddRainbowColor(p182, "ImageColor3");
        else
            l__AnimatedGradient__7:Remove(p182);
            p182.ImageColor3 = Color3.new(1, 1, 1);
        end;
    end;
end;
local function u204(p187, u188, u189, u190, _, p191, p192, u193) --[[ Line: 819 ]]
    -- upvalues: u186 (copy), u83 (copy), u181 (copy), l__TweenService__4 (copy), u3 (copy), u1 (copy), u6 (copy), u2 (copy)
    p187.Visible = true;
    local v194 = p187:FindFirstChild("Frame");
    if v194 then
        local v195 = v194:FindFirstChild("Button");
        if v195 and v195:IsA("GuiButton") then
            local v196 = v195:FindFirstChild("ItemImage");
            if v196 and v196:IsA("ImageLabel") then
                v196.Image = p191;
                u186(v196, u189, u193);
            end;
            local v197 = v195:FindFirstChild("AmountTextLabel1");
            if v197 then
                u83(v197, u189 == "Pets" and "" or "x" .. tostring(p192));
            end;
            local u198 = v195:FindFirstChild("SendFlash");
            if u198 and u198:IsA("Frame") then
                u198.BackgroundTransparency = 1;
            end;
            local function u199(_) --[[ Line: 848 ]]
                -- upvalues: u198 (copy), l__TweenService__4 (ref), u3 (ref), u1 (ref), u188 (copy), u189 (copy), u190 (copy), u193 (copy)
                if u198 then
                    u198.BackgroundTransparency = 0.25;
                    l__TweenService__4:Create(u198, u3, {
                        BackgroundTransparency = 0.75
                    }):Play();
                end;
                u1:_addToSend(u188, u189, u190, u193);
            end;
            for _, u200 in u181(v195) do
                local v201 = u200.MouseButton1Click:Connect(function() --[[ Line: 857 ]]
                    -- upvalues: u199 (copy), u200 (copy)
                    u199(u200);
                end);
                table.insert(u6, v201);
                if u198 then
                    local v202 = u200.MouseEnter:Connect(function() --[[ Line: 861 ]]
                        -- upvalues: l__TweenService__4 (ref), u198 (copy), u2 (ref)
                        l__TweenService__4:Create(u198, u2, {
                            BackgroundTransparency = 0.75
                        }):Play();
                    end);
                    table.insert(u6, v202);
                    local v203 = u200.MouseLeave:Connect(function() --[[ Line: 864 ]]
                        -- upvalues: l__TweenService__4 (ref), u198 (copy), u2 (ref)
                        l__TweenService__4:Create(u198, u2, {
                            BackgroundTransparency = 1
                        }):Play();
                    end);
                    table.insert(u6, v203);
                end;
            end;
        end;
    end;
end;
local function u223() --[[ Line: 871 ]]
    -- upvalues: u18 (ref), u17 (ref), u36 (ref), u84 (copy), u75 (copy), l__PlayerStateClient__6 (copy), l__MailboxItemCatalog__14 (copy), u177 (copy), u40 (copy), u204 (copy)
    if u18 and u17 then
        u75(u18, {
            [u17] = true
        });
        local v205 = 0;
        local v206 = l__PlayerStateClient__6:GetLocalReplica();
        if v206 then
            local l__Data__19 = v206.Data;
            if l__Data__19 then
                l__Data__19 = v206.Data.Inventory;
            end;
            if typeof(l__Data__19) == "table" then
                for _, v207 in l__MailboxItemCatalog__14.Categories do
                    local v208 = l__Data__19[v207];
                    if typeof(v208) == "table" then
                        if v207 == "HarvestedFruits" or v207 == "Pets" then
                            for v209, v210 in v208 do
                                if u177(v207, v209, v210) then
                                    local v211 = v207 .. ":" .. v209;
                                    local v212 = 1 - (u40[v211] and (u40[v211].Selected or 0) or 0);
                                    if v212 > 0 then
                                        local v213, v214 = l__MailboxItemCatalog__14.Resolve(v207, v209, v210);
                                        local v215 = u17:Clone();
                                        v215.Name = "Inv_" .. v211;
                                        v215.Parent = u18;
                                        u204(v215, v211, v207, v209, v213, v214, v212, v210);
                                        v205 = v205 + 1;
                                    end;
                                end;
                            end;
                        else
                            for v216, v217 in v208 do
                                if u177(v207, v216, v217) then
                                    local v218 = v207 .. ":" .. v216;
                                    local v219 = v217 - (u40[v218] and (u40[v218].Selected or 0) or 0);
                                    if v219 > 0 then
                                        local v220, v221 = l__MailboxItemCatalog__14.Resolve(v207, v216, nil);
                                        local v222 = u17:Clone();
                                        v222.Name = "Inv_" .. v218;
                                        v222.Parent = u18;
                                        u204(v222, v218, v207, v216, v220, v221, v219, nil);
                                        v205 = v205 + 1;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                u36 = v205;
                u84();
            else
                u36 = v205;
                u84();
            end;
        else
            u36 = v205;
            u84();
        end;
    else
        u36 = 0;
        u84();
    end;
end;
local function u238(p224, u225, _, p226, p227, p228, p229) --[[ Line: 941 ]]
    -- upvalues: u186 (copy), u83 (copy), u6 (copy), u1 (copy)
    p224.Visible = true;
    local v230 = p224:FindFirstChild("Frame");
    if v230 then
        local v231 = v230:FindFirstChild("Button");
        if v231 and v231:IsA("GuiButton") then
            local v232 = v231:FindFirstChild("ItemImage");
            if v232 and v232:IsA("ImageLabel") then
                v232.Image = p226;
                u186(v232, p228, p229);
            end;
            local v233 = v231:FindFirstChild("AmountTextLabel1");
            if v233 then
                u83(v233, p228 == "Pets" and "" or "x" .. tostring(p227));
            end;
            local u234 = v231:FindFirstChild("RemoveHoverFrame");
            if u234 and u234:IsA("GuiObject") then
                u234.Visible = false;
                local v235 = v231.MouseEnter:Connect(function() --[[ Line: 962 ]]
                    -- upvalues: u234 (copy)
                    u234.Visible = true;
                end);
                table.insert(u6, v235);
                local v236 = v231.MouseLeave:Connect(function() --[[ Line: 965 ]]
                    -- upvalues: u234 (copy)
                    u234.Visible = false;
                end);
                table.insert(u6, v236);
            end;
            local v237 = v231.MouseButton1Click:Connect(function() --[[ Line: 970 ]]
                -- upvalues: u1 (ref), u225 (copy)
                u1:_removeFromSend(u225);
            end);
            table.insert(u6, v237);
        end;
    end;
end;
local function u247() --[[ Line: 975 ]]
    -- upvalues: u20 (ref), u19 (ref), u75 (copy), u40 (copy), l__MailboxItemCatalog__14 (copy), u238 (copy), u30 (ref)
    if u20 and u19 then
        u75(u20, {
            [u19] = true
        });
        for v239, v240 in u40 do
            if v240.Selected > 0 then
                local v241, v242 = l__MailboxItemCatalog__14.Resolve(v240.Category, v240.ItemKey, v240.EntryValue);
                local v243 = u19:Clone();
                v243.Name = "Send_" .. v239;
                v243.Parent = u20;
                u238(v243, v239, v241, v242, v240.Selected, v240.Category, v240.EntryValue);
            end;
        end;
        if u30 then
            local v244 = u30;
            local v245 = 0;
            for _, v246 in u40 do
                v245 = v245 + v246.Selected;
            end;
            v244.Visible = v245 == 0;
        end;
    end;
end;
function u1._addToSend(_, p248, p249, p250, p251) --[[ Line: 991 ]]
    -- upvalues: u40 (copy), l__NotificationController__13 (copy), u223 (copy), u247 (copy)
    local v252 = 0;
    for _, v253 in u40 do
        v252 = v252 + v253.Selected;
    end;
    if v252 >= 20 then
        l__NotificationController__13:CreateNotification(string.format("Up to %d items per gift", 20));
    else
        local v254 = u40[p248];
        if not v254 then
            v254 = {
                Selected = 0,
                Category = p249,
                ItemKey = p250,
                EntryValue = p251
            };
            u40[p248] = v254;
        end;
        v254.Selected = v254.Selected + 1;
        u223();
        u247();
    end;
end;
function u1._removeFromSend(_, p255) --[[ Line: 1008 ]]
    -- upvalues: u40 (copy), u223 (copy), u247 (copy)
    local v256 = u40[p255];
    if v256 then
        v256.Selected = v256.Selected - 1;
        if v256.Selected <= 0 then
            u40[p255] = nil;
        end;
        u223();
        u247();
    end;
end;
function u1._resetToPlayerList(_) --[[ Line: 1029 ]]
    -- upvalues: u37 (ref), u22 (ref), u23 (ref), u40 (copy), u247 (copy), u223 (copy), u31 (ref), u16 (ref), u161 (copy), u84 (copy)
    u37 = nil;
    if u22 then
        u22.Visible = false;
    end;
    if u23 then
        u23.Visible = true;
    end;
    table.clear(u40);
    u247();
    u223();
    if u31 then
        u31.Text = "";
    end;
    if u16 then
        u16.Text = "";
    end;
    u161();
    u84();
end;
function u1._pickRecipient(_, u257, p258) --[[ Line: 1040 ]]
    -- upvalues: u37 (ref), u23 (ref), u22 (ref), u33 (ref), u83 (copy), u32 (ref), l__MailboxItemCatalog__14 (copy), u4 (ref), u40 (copy), u247 (copy), u223 (copy), u31 (ref), u84 (copy)
    u37 = {
        userId = u257,
        displayName = p258
    };
    if u23 then
        u23.Visible = false;
    end;
    if u22 then
        u22.Visible = true;
    end;
    if u33 then
        u83(u33, "Send to " .. p258);
    end;
    if u32 then
        task.spawn(function() --[[ Line: 1050 ]]
            -- upvalues: l__MailboxItemCatalog__14 (ref), u257 (copy), u4 (ref), u32 (ref)
            local v259 = l__MailboxItemCatalog__14.GetHeadshot(u257);
            if v259 ~= "" and (u4 and u4.Enabled) then
                u32.Image = v259;
            end;
        end);
    end;
    table.clear(u40);
    u247();
    u223();
    if u31 then
        u31.Text = "";
    end;
    u223();
    u247();
    u84();
end;
local function u269() --[[ Line: 1065 ]]
    -- upvalues: u41 (ref), u37 (ref), u40 (copy), u42 (ref), u31 (ref), u28 (ref), l__Networking__5 (copy), l__NotificationController__13 (copy), u1 (copy)
    if u41 then
    elseif u37 then
        local v260 = 0;
        for _, v261 in u40 do
            v260 = v260 + v261.Selected;
        end;
        if v260 == 0 then
        else
            local v262 = os.clock();
            if v262 - u42 < 1.5 then
            else
                u42 = v262;
                local u263 = {};
                for _, v264 in u40 do
                    if v264.Selected > 0 then
                        table.insert(u263, {
                            Category = v264.Category,
                            ItemKey = v264.ItemKey,
                            Count = v264.Selected
                        });
                    end;
                end;
                if #u263 == 0 then
                else
                    local u265 = u31 and u31.Text or "";
                    local l__userId__20 = u37.userId;
                    u41 = true;
                    if u28 then
                        u28.Active = false;
                    end;
                    task.spawn(function() --[[ Line: 1091 ]]
                        -- upvalues: l__Networking__5 (ref), l__userId__20 (copy), u263 (copy), u265 (copy), u41 (ref), u28 (ref), l__NotificationController__13 (ref), u1 (ref)
                        local v266, v267, v268 = pcall(function() --[[ Line: 1092 ]]
                            -- upvalues: l__Networking__5 (ref), l__userId__20 (ref), u263 (ref), u265 (ref)
                            return l__Networking__5.Mailbox.SendBatch:Fire(l__userId__20, u263, u265);
                        end);
                        u41 = false;
                        if u28 then
                            u28.Active = true;
                        end;
                        if v266 then
                            if v267 then
                                l__NotificationController__13:CreateNotification((v268 == "" or not v268) and "Gift sent!" or v268);
                                u1:_resetToPlayerList();
                            else
                                l__NotificationController__13:CreateNotification((v268 == "" or not v268) and "Could not send gift" or v268);
                            end;
                        else
                            l__NotificationController__13:CreateNotification("Try again");
                        end;
                    end);
                end;
            end;
        end;
    end;
end;
local function u271() --[[ Line: 1117 ]]
    -- upvalues: u31 (ref)
    if u31 then
        local l__Text__21 = u31.Text;
        if utf8.len(l__Text__21) and utf8.len(l__Text__21) > 100 then
            utf8.offset(l__Text__21, 101);
            local v270 = utf8.offset(l__Text__21, 101);
            if v270 then
                u31.Text = string.sub(l__Text__21, 1, v270 - 1);
            else
                u31.Text = string.sub(l__Text__21, 1, 100);
            end;
        else
            if #l__Text__21 > 400 then
                u31.Text = string.sub(l__Text__21, 1, 100);
            end;
        end;
    end;
end;
local function u277(p272) --[[ Line: 1154 ]]
    -- upvalues: l__GuiController__12 (copy), u7 (copy)
    local u273 = {};
    local v274 = p272:FindFirstChild("ExitButton", true);
    if not (v274 and v274:IsA("GuiButton")) then
        v274 = nil;
    end;
    if v274 and not u273[v274] then
        u273[v274] = v274.MouseButton1Click:Connect(function() --[[ Line: 1159 ]]
            -- upvalues: l__GuiController__12 (ref)
            if l__GuiController__12:IsOpen("MailboxUI") then
                l__GuiController__12:Close();
            end;
        end);
    end;
    local v276 = p272.DescendantAdded:Connect(function(p275) --[[ Line: 1171 ]]
        -- upvalues: u273 (copy), l__GuiController__12 (ref)
        if p275.Name == "ExitButton" and p275:IsA("GuiButton") then
            if u273[p275] then
                return;
            end;
            u273[p275] = p275.MouseButton1Click:Connect(function() --[[ Line: 1159 ]]
                -- upvalues: l__GuiController__12 (ref)
                if l__GuiController__12:IsOpen("MailboxUI") then
                    l__GuiController__12:Close();
                end;
            end);
        end;
    end);
    table.insert(u7, v276);
end;
local function u283(p278) --[[ Line: 1178 ]]
    -- upvalues: u34 (ref), u25 (ref), u26 (ref), u27 (ref), u44 (ref), u24 (ref), u10 (ref), u11 (ref), u12 (ref), u21 (ref), u22 (ref), u33 (ref), u32 (ref), u31 (ref), u28 (ref), u29 (ref), u30 (ref), u18 (ref), u17 (ref), u20 (ref), u19 (ref), u23 (ref), u15 (ref), u14 (ref), u16 (ref)
    local l__Frame__22 = p278:WaitForChild("Frame", 10);
    if l__Frame__22 then
        local v279 = l__Frame__22:FindFirstChild("Info");
        if v279 and v279:IsA("TextLabel") then
            u34 = v279;
        end;
        local l__Header__23 = l__Frame__22:WaitForChild("Header", 5);
        if l__Header__23 then
            u25 = l__Header__23:FindFirstChild("ToggleButtonSend");
            u26 = l__Header__23:FindFirstChild("ToggleButtonRecieve");
            if u25 then
                local v280 = u25:FindFirstChild("Text");
                if v280 then
                    v280 = v280:FindFirstChild("Notification");
                end;
                if v280 and v280:IsA("Frame") then
                    u27 = v280;
                end;
            end;
            if u27 then
                u27.Visible = u44;
            end;
        end;
        u24 = l__Frame__22:FindFirstChild("RecieveFrame");
        if u24 then
            u10 = u24:FindFirstChild("GiftTemplate");
            u11 = u24;
            if u10 then
                u10.Visible = false;
            end;
            u12 = u24:FindFirstChild("GuildInviteTemplate");
            if u12 then
                u12.Visible = false;
            end;
        end;
        u21 = l__Frame__22:FindFirstChild("SendingFrame");
        if u21 then
            u22 = u21:FindFirstChild("ItemSendFrame");
            if u22 then
                u33 = u22:FindFirstChild("Sending");
                u32 = u22:FindFirstChild("PlayerImage");
                u31 = u22:FindFirstChild("NoteTextBox");
                u28 = u22:FindFirstChild("SendButton");
                u29 = u22:FindFirstChild("CancelButton");
                if u28 then
                    u30 = u28:FindFirstChild("CanSendFrame");
                end;
                local v281 = u22:FindFirstChild("ScrollingFrames");
                if v281 then
                    u18 = v281:FindFirstChild("InventoryFrame");
                    u17 = u18 and u18:FindFirstChild("ItemFrameTemplate");
                    if u17 then
                        u17.Visible = false;
                    end;
                    u20 = v281:FindFirstChild("SendingFrame");
                    u19 = u20 and u20:FindFirstChild("ItemFrameTemplate");
                    if u19 then
                        u19.Visible = false;
                    end;
                end;
            end;
            u23 = u21:FindFirstChild("SelectPlayerFrame");
            if u23 then
                u15 = u23:FindFirstChild("PlayerList");
                u14 = u15 and u15:FindFirstChild("SendTemplate");
                if u14 then
                    u14.Visible = false;
                end;
                local v282 = u23:FindFirstChild("Topbar");
                if v282 then
                    u16 = v282:FindFirstChild("SearchBox");
                end;
            end;
        end;
    end;
end;
local function u292(p284) --[[ Line: 1260 ]]
    -- upvalues: u5 (ref), u283 (copy), u277 (copy), u31 (ref), u271 (copy), u7 (copy), u84 (copy), u25 (ref), u35 (ref), u24 (ref), u21 (ref), u26 (ref), u1 (copy), u29 (ref), u28 (ref), u269 (copy), u16 (ref), u169 (copy), u170 (copy)
    if u5 then
    else
        u5 = true;
        u283(p284);
        u277(p284);
        if u31 then
            u31.PlaceholderText = "Add a note (optional)";
            u31.ClearTextOnFocus = false;
            local v285 = u31:GetPropertyChangedSignal("Text"):Connect(u271);
            table.insert(u7, v285);
        end;
        u84();
        if u25 then
            local v286 = u25.MouseButton1Click:Connect(function() --[[ Line: 1272 ]]
                -- upvalues: u35 (ref), u24 (ref), u21 (ref), u25 (ref), u26 (ref), u84 (ref)
                u35 = "Receive";
                if u24 then
                    u24.Visible = true;
                end;
                if u21 then
                    u21.Visible = false;
                end;
                if u25 then
                    u25.Visible = false;
                end;
                if u26 then
                    u26.Visible = true;
                end;
                u84();
            end);
            table.insert(u7, v286);
        end;
        if u26 then
            local v287 = u26.MouseButton1Click:Connect(function() --[[ Line: 1275 ]]
                -- upvalues: u35 (ref), u24 (ref), u21 (ref), u25 (ref), u26 (ref), u1 (ref), u84 (ref)
                u35 = "Send";
                if u24 then
                    u24.Visible = false;
                end;
                if u21 then
                    u21.Visible = true;
                end;
                if u25 then
                    u25.Visible = true;
                end;
                if u26 then
                    u26.Visible = false;
                end;
                u1:_resetToPlayerList();
                u84();
            end);
            table.insert(u7, v287);
        end;
        if u29 then
            local v288 = u29.MouseButton1Click:Connect(function() --[[ Line: 1279 ]]
                -- upvalues: u1 (ref)
                u1:_resetToPlayerList();
            end);
            table.insert(u7, v288);
        end;
        if u28 then
            local v289 = u28.MouseButton1Click:Connect(u269);
            table.insert(u7, v289);
        end;
        if u16 then
            local v290 = u16.FocusLost:Connect(u169);
            table.insert(u7, v290);
            local v291 = u16:GetPropertyChangedSignal("Text"):Connect(u170);
            table.insert(u7, v291);
        end;
        u35 = "Send";
        if u24 then
            u24.Visible = false;
        end;
        if u21 then
            u21.Visible = true;
        end;
        if u25 then
            u25.Visible = true;
        end;
        if u26 then
            u26.Visible = false;
        end;
        u1:_resetToPlayerList();
        u84();
    end;
end;
local function u295() --[[ Line: 1297 ]]
    -- upvalues: u39 (ref), l__PlayerStateClient__6 (copy), u295 (copy), u4 (ref), u22 (ref), u223 (copy)
    if u39 then
    else
        local v293 = l__PlayerStateClient__6:GetLocalReplica();
        if v293 then
            u39 = v293:OnChange(function(_, p294) --[[ Line: 1306 ]]
                -- upvalues: u4 (ref), u22 (ref), u223 (ref)
                if u4 and u4.Enabled then
                    if u22 and u22.Visible then
                        if typeof(p294) == "table" and p294[1] == "Inventory" then
                            u223();
                        end;
                    end;
                end;
            end);
        else
            l__PlayerStateClient__6:OnLocalReplica(function() --[[ Line: 1301 ]]
                -- upvalues: u295 (ref)
                u295();
            end);
        end;
    end;
end;
local function u298() --[[ Line: 1315 ]]
    -- upvalues: l__Networking__5 (copy), u8 (ref), u118 (copy)
    local v296, v297 = pcall(function() --[[ Line: 1316 ]]
        -- upvalues: l__Networking__5 (ref)
        return l__Networking__5.Mailbox.OpenInbox:Fire();
    end);
    if v296 and typeof(v297) == "table" then
        u8 = v297;
        u118();
    end;
end;
local u299 = nil;
local u300 = 0;
function u1.Init(_) --[[ Line: 1395 ]] end;
function u1.Start(_) --[[ Line: 1398 ]]
    -- upvalues: l__Networking__5 (copy), u171 (copy), u7 (copy), l__ProximityPromptService__2 (copy), l__LocalPlayer__10 (copy), l__MailboxFlags__9 (copy), l__NotificationController__13 (copy), l__GuiController__12 (copy), l__PlayerGui__11 (copy), u4 (ref), u292 (copy), u295 (copy), u298 (copy), u299 (ref), u300 (ref), u44 (ref), u45 (copy), u56 (copy), u27 (ref), u8 (ref), u118 (copy), u35 (ref), u24 (ref), u21 (ref), u25 (ref), u26 (ref), u1 (copy), u84 (copy), u47 (copy), u37 (ref), u38 (ref), u139 (copy), u40 (copy), u247 (copy), u223 (copy), u31 (ref), u16 (ref), u9 (ref), u71 (copy)
    local v302 = l__Networking__5.Pets.PetEquipped.OnClientEvent:Connect(function(p301) --[[ Line: 1399 ]]
        -- upvalues: u171 (ref)
        if typeof(p301) == "string" then
            u171[p301] = true;
        end;
    end);
    table.insert(u7, v302);
    local v304 = l__Networking__5.Pets.PetUnequipped.OnClientEvent:Connect(function(p303) --[[ Line: 1403 ]]
        -- upvalues: u171 (ref)
        if typeof(p303) == "string" then
            u171[p303] = nil;
        end;
    end);
    table.insert(u7, v304);
    task.spawn(function() --[[ Line: 1407 ]]
        -- upvalues: l__Networking__5 (ref), u171 (ref)
        local v305, v306 = pcall(function() --[[ Line: 1408 ]]
            -- upvalues: l__Networking__5 (ref)
            return l__Networking__5.Pets.GetEquippedPets:Fire();
        end);
        if v305 and typeof(v306) == "table" then
            for _, v307 in v306 do
                if typeof(v307) == "table" and typeof(v307.Id) == "string" then
                    u171[v307.Id] = true;
                end;
            end;
        end;
    end);
    local v310 = l__ProximityPromptService__2.PromptTriggered:Connect(function(p308, p309) --[[ Line: 1420 ]]
        -- upvalues: l__LocalPlayer__10 (ref), l__MailboxFlags__9 (ref), l__NotificationController__13 (ref), l__GuiController__12 (ref)
        if p309 == l__LocalPlayer__10 then
            if p308.Name == "MailboxPrompt" then
                if l__MailboxFlags__9.OpenEnabled:Get() then
                    if not l__GuiController__12:IsOpen("MailboxUI") then
                        l__GuiController__12:Open("MailboxUI", nil, { "HUD" });
                    end;
                else
                    l__NotificationController__13:CreateNotification("The mailbox is temporarily disabled.");
                end;
            end;
        end;
    end);
    table.insert(u7, v310);
    l__MailboxFlags__9.OpenEnabled.Changed:Connect(function(p311) --[[ Line: 1437 ]]
        -- upvalues: l__GuiController__12 (ref)
        if p311 then
        else
            if l__GuiController__12:IsOpen("MailboxUI") then
                l__GuiController__12:Close();
            end;
        end;
    end);
    task.spawn(function() --[[ Line: 1444 ]]
        -- upvalues: l__PlayerGui__11 (ref), u4 (ref), u292 (ref)
        local l__MailboxUI__24 = l__PlayerGui__11:WaitForChild("MailboxUI");
        if l__MailboxUI__24:IsA("ScreenGui") then
            u4 = l__MailboxUI__24;
            u292(l__MailboxUI__24);
        end;
    end);
    local v324 = l__GuiController__12.GuiFocusedSignal:Connect(function(p312) --[[ Line: 1451 ]]
        -- upvalues: u295 (ref), u298 (ref), u299 (ref), u300 (ref), l__Networking__5 (ref), u44 (ref), u45 (ref), u56 (ref), u27 (ref), u8 (ref), u118 (ref), u35 (ref), u24 (ref), u21 (ref), u25 (ref), u26 (ref), u1 (ref), u84 (ref)
        if p312 and p312.Name == "MailboxUI" then
            u295();
            task.spawn(u298);
            if not u299 then
                u300 = u300 + 1;
                local u313 = u300;
                local u314 = 30;
                local u315 = 0;
                local u316 = nil;
                u299 = task.spawn(function() --[[ Line: 1343 ]]
                    -- upvalues: u300 (ref), u313 (copy), u314 (ref), l__Networking__5 (ref), u316 (ref), u315 (ref), u44 (ref), u45 (ref), u56 (ref), u27 (ref), u8 (ref), u118 (ref)
                    while u300 == u313 do
                        task.wait(u314);
                        if u300 ~= u313 then
                            break;
                        end;
                        local v317, v318 = pcall(function() --[[ Line: 1347 ]]
                            -- upvalues: l__Networking__5 (ref)
                            return l__Networking__5.Mailbox.IndexProbe:Fire();
                        end);
                        if v317 then
                            local v319 = tonumber(v318) or 0;
                            if u316 == nil or v319 ~= u316 then
                                u315 = 0;
                                u314 = 30;
                                u316 = v319;
                                local v320 = v319 > 0;
                                if u44 ~= v320 then
                                    u44 = v320;
                                    for v321 in u45 do
                                        if v321.Parent then
                                            u56(v321);
                                        else
                                            u45[v321] = nil;
                                        end;
                                    end;
                                    if u27 then
                                        u27.Visible = u44;
                                    end;
                                end;
                                local v322, v323 = pcall(function() --[[ Line: 1316 ]]
                                    -- upvalues: l__Networking__5 (ref)
                                    return l__Networking__5.Mailbox.OpenInbox:Fire();
                                end);
                                if v322 and typeof(v323) == "table" then
                                    u8 = v323;
                                    u118();
                                end;
                            else
                                u315 = u315 + 1;
                                if u315 >= 5 then
                                    u314 = math.min(u314 * 2, 120);
                                end;
                            end;
                        end;
                    end;
                end);
            end;
            u35 = "Send";
            if u24 then
                u24.Visible = false;
            end;
            if u21 then
                u21.Visible = true;
            end;
            if u25 then
                u25.Visible = true;
            end;
            if u26 then
                u26.Visible = false;
            end;
            u1:_resetToPlayerList();
            u84();
        end;
    end);
    table.insert(u7, v324);
    local v326 = l__GuiController__12.GuiUnfocusedSignal:Connect(function(p325) --[[ Line: 1457 ]]
        -- upvalues: u47 (ref), u300 (ref), u299 (ref), u37 (ref), u38 (ref), u139 (ref), u40 (ref), u247 (ref), u223 (ref), u31 (ref), u16 (ref)
        if p325 and p325.Name == "MailboxUI" then
            u47();
            u300 = u300 + 1;
            u299 = nil;
            u37 = nil;
            u38 = nil;
            table.clear(u139);
            table.clear(u40);
            u247();
            u223();
            if u31 then
                u31.Text = "";
            end;
            if u16 then
                u16.Text = "";
            end;
        end;
    end);
    table.insert(u7, v326);
    local v333 = l__Networking__5.Mailbox.Updated.OnClientEvent:Connect(function(p327) --[[ Line: 1463 ]]
        -- upvalues: u8 (ref), u9 (ref), u118 (ref), u44 (ref), u45 (ref), u56 (ref), u27 (ref)
        if typeof(p327) == "table" then
            local v328 = typeof(p327.PendingInvites) == "table";
            local v329 = typeof(p327.Mailbox) == "table";
            local v330 = typeof(p327.Badge) == "number";
            if v328 then
                u9 = p327.PendingInvites;
            end;
            if v329 then
                u8 = p327.Mailbox;
                u118();
            elseif v330 then
                local v331 = p327.Badge > 0 and true or next(u9) ~= nil;
                if u44 ~= v331 then
                    u44 = v331;
                    for v332 in u45 do
                        if v332.Parent then
                            u56(v332);
                        else
                            u45[v332] = nil;
                        end;
                    end;
                    if u27 then
                        u27.Visible = u44;
                    end;
                end;
                if v328 then
                    u118();
                end;
            elseif v328 then
                u118();
            else
                u8 = p327;
                u118();
            end;
        else
            u8 = {};
            u9 = {};
            u118();
        end;
    end);
    table.insert(u7, v333);
    local v337 = l__Networking__5.Guild.InvitePrompt.OnClientEvent:Connect(function(p334, p335) --[[ Line: 1519 ]]
        -- upvalues: u9 (ref), u118 (ref), l__NotificationController__13 (ref)
        if typeof(p334) == "string" and typeof(p335) == "table" then
            u9[p334] = {
                GuildId = tostring(p335.GuildId or ""),
                GuildName = tostring(p335.GuildName or ""),
                GuildTag = tostring(p335.GuildTag or ""),
                FromUserId = tonumber(p335.FromUserId) or 0,
                FromName = tostring(p335.FromName or ""),
                ExpiresAt = tonumber(p335.ExpiresAt) or 0,
                ReceivedAt = tonumber(p335.ReceivedAt) or os.time(),
                MemberCount = tonumber(p335.MemberCount),
                MaxSlots = tonumber(p335.MaxSlots)
            };
            u118();
            local v336 = tostring(p335.FromName or "Someone");
            l__NotificationController__13:CreateNotification(string.format("%s has invited you to their guild!", v336));
        end;
    end);
    table.insert(u7, v337);
    task.spawn(function() --[[ Line: 1545 ]]
        -- upvalues: l__Networking__5 (ref), u8 (ref), u118 (ref)
        task.wait(2);
        local v338, v339 = pcall(function() --[[ Line: 1316 ]]
            -- upvalues: l__Networking__5 (ref)
            return l__Networking__5.Mailbox.OpenInbox:Fire();
        end);
        if v338 and typeof(v339) == "table" then
            u8 = v339;
            u118();
        end;
    end);
    task.spawn(function() --[[ Line: 1551 ]]
        -- upvalues: u71 (ref)
        u71();
    end);
    local v340 = l__LocalPlayer__10:GetAttributeChangedSignal("PlotId"):Connect(function() --[[ Line: 1554 ]]
        -- upvalues: u71 (ref)
        u71();
    end);
    table.insert(u7, v340);
end;
return u1;