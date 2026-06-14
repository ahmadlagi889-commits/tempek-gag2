-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
local l__PlayerGui__5 = l__LocalPlayer__4:WaitForChild("PlayerGui");
local l__GuiController__6 = require(l__LocalPlayer__4.PlayerScripts.Controllers.GuiController);
local l__NotificationController__7 = require(l__LocalPlayer__4.PlayerScripts.Controllers.NotificationController);
local u1 = {
    not_in_guild = "You\'re not in a guild",
    no_invite_permission = "Only Owners and Elders can invite",
    already_member = "They\'re already in your guild",
    target_in_guild = "They\'re already in a guild",
    guild_full = "Your guild is full",
    invite_cooldown = "Slow down -- wait a few seconds",
    already_invited_recently = "You already invited them recently",
    target_not_in_server = "They need to be in this server"
};
local v2 = {
    StartOrder = 9
};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = false;
local u9 = {};
local u10 = {};
local function u13() --[[ Line: 52 ]]
    -- upvalues: u9 (copy), u10 (copy)
    for _, u11 in u9 do
        pcall(function() --[[ Line: 54 ]]
            -- upvalues: u11 (copy)
            u11:Disconnect();
        end);
    end;
    table.clear(u9);
    for _, v12 in u10 do
        if v12.Parent then
            v12:Destroy();
        end;
    end;
    table.clear(u10);
end;
local function u20(u14, u15) --[[ Line: 88 ]]
    -- upvalues: l__Networking__3 (copy), l__NotificationController__7 (copy), u1 (copy)
    u15.Active = false;
    if u15:IsA("TextButton") or u15:IsA("ImageButton") then
        u15.AutoButtonColor = false;
    end;
    task.spawn(function() --[[ Line: 93 ]]
        -- upvalues: l__Networking__3 (ref), u14 (copy), l__NotificationController__7 (ref), u15 (copy), u1 (ref)
        local v16, v17, v18 = pcall(function() --[[ Line: 94 ]]
            -- upvalues: l__Networking__3 (ref), u14 (ref)
            return l__Networking__3.Guild.Invite:Fire(u14);
        end);
        if v16 then
            if v17 then
                l__NotificationController__7:CreateNotification("Guild invite sent!");
            else
                local v19 = tostring(v18 or "");
                l__NotificationController__7:CreateNotification(u1[v19] or ((v19 == "" or not v19) and "Could not invite" or v19));
                u15.Active = true;
            end;
        else
            l__NotificationController__7:CreateNotification("Try again");
            u15.Active = true;
        end;
    end);
end;
local function u26() --[[ Line: 120 ]]
    -- upvalues: l__Networking__3 (copy)
    local v21 = {};
    local v22, v23 = pcall(function() --[[ Line: 122 ]]
        -- upvalues: l__Networking__3 (ref)
        return l__Networking__3.Guild.GetMyGuild:Fire();
    end);
    if v22 and (typeof(v23) == "table" and (typeof(v23.Guild) == "table" and typeof(v23.Guild.Members) == "table")) then
        for v24 in v23.Guild.Members do
            local v25 = tonumber(v24);
            if v25 then
                v21[v25] = true;
            end;
        end;
    end;
    return v21;
end;
local function u38(p27, p28, u29) --[[ Line: 136 ]]
    -- upvalues: u10 (copy), l__Players__1 (copy), u20 (copy), u9 (copy)
    local v30 = p27:Clone();
    v30.Name = `Player_{u29.UserId}`;
    v30.LayoutOrder = #u10 + 1;
    v30.Visible = true;
    v30.Parent = p28;
    table.insert(u10, v30);
    local v31 = v30:FindFirstChild("PlayerName");
    if v31 and v31:IsA("TextLabel") then
        local l__DisplayName__8 = u29.DisplayName;
        v31.Text = l__DisplayName__8;
        local v32 = v31:FindFirstChild("GuildTextLabelName2");
        if v32 and v32:IsA("TextLabel") then
            v32.Text = l__DisplayName__8;
        end;
    end;
    local u33 = v30:FindFirstChild("PlayerImage");
    if u33 then
        u33 = u33:FindFirstChild("Icon");
    end;
    if u33 and u33:IsA("ImageLabel") then
        local l__UserId__9 = u29.UserId;
        task.spawn(function() --[[ Line: 74 ]]
            -- upvalues: l__Players__1 (ref), l__UserId__9 (copy), u33 (copy)
            local v34, v35 = pcall(function() --[[ Line: 75 ]]
                -- upvalues: l__Players__1 (ref), l__UserId__9 (ref)
                return l__Players__1:GetUserThumbnailAsync(l__UserId__9, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
            end);
            if v34 and (typeof(v35) == "string" and u33.Parent) then
                u33.Image = v35;
            end;
        end);
    end;
    local u36 = v30:FindFirstChild("InviteButton");
    if u36 and u36:IsA("GuiButton") then
        local v37 = u36.MouseButton1Click:Connect(function() --[[ Line: 157 ]]
            -- upvalues: u20 (ref), u29 (copy), u36 (copy)
            u20(u29.UserId, u36);
        end);
        table.insert(u9, v37);
    end;
end;
local function u44() --[[ Line: 163 ]]
    -- upvalues: u8 (ref), u4 (ref), u5 (ref), u13 (copy), u26 (copy), l__Players__1 (copy), l__LocalPlayer__4 (copy), u38 (copy), u6 (ref)
    if u8 then
        if u4 and u5 then
            local v39 = u4;
            local v40 = u5;
            u13();
            local v41 = u26();
            if u8 then
                local v42 = 0;
                for _, v43 in l__Players__1:GetPlayers() do
                    if v43 ~= l__LocalPlayer__4 and not (v41[v43.UserId] or v43:GetAttribute("GuildId")) then
                        u38(v40, v39, v43);
                        v42 = v42 + 1;
                    end;
                end;
                if u6 then
                    u6.Visible = v42 == 0;
                end;
                v39.Visible = v42 > 0;
            end;
        end;
    end;
end;
local function u53(p45) --[[ Line: 191 ]]
    -- upvalues: u7 (ref), u6 (ref), u4 (ref), u5 (ref)
    local v46 = p45:FindFirstChild("Frame");
    if v46 then
        local v47 = v46:FindFirstChild("Header");
        if v47 then
            local v48 = v47:FindFirstChild("ExitButton");
            if v48 and v48:IsA("GuiButton") then
                u7 = v48;
            end;
        end;
        local v49 = v46:FindFirstChild("Content");
        if v49 then
            local v50 = v49:FindFirstChild("StatusLabel");
            if v50 and v50:IsA("TextLabel") then
                u6 = v50;
            end;
            local v51 = v49:FindFirstChild("ScrollingFrame");
            if v51 and v51:IsA("ScrollingFrame") then
                u4 = v51;
                local v52 = v51:FindFirstChild("PlayerTemplate");
                if v52 and v52:IsA("GuiObject") then
                    u5 = v52;
                    v52.Visible = false;
                end;
            end;
        end;
    end;
end;
function v2.Init(_) --[[ Line: 232 ]] end;
function v2.Start(_) --[[ Line: 234 ]]
    -- upvalues: l__PlayerGui__5 (copy), u3 (ref), u53 (copy), u7 (ref), l__GuiController__6 (copy), u8 (ref), u44 (copy), u13 (copy), l__Players__1 (copy)
    task.spawn(function() --[[ Line: 235 ]]
        -- upvalues: l__PlayerGui__5 (ref), u3 (ref), u53 (ref), u7 (ref), l__GuiController__6 (ref), u8 (ref), u44 (ref), u13 (ref), l__Players__1 (ref)
        local l__GuildInvite__10 = l__PlayerGui__5:WaitForChild("GuildInvite", 30);
        if l__GuildInvite__10 and l__GuildInvite__10:IsA("ScreenGui") then
            u3 = l__GuildInvite__10;
            l__GuildInvite__10.Enabled = false;
            u53(l__GuildInvite__10);
            if u7 then
                u7.MouseButton1Click:Connect(function() --[[ Line: 220 ]]
                    -- upvalues: l__GuiController__6 (ref)
                    if l__GuiController__6:IsOpen("GuildInvite") then
                        l__GuiController__6:Open("ViewGuildPage", nil, { "HUD" });
                        if l__GuiController__6:IsOpen("GuildInvite") then
                            l__GuiController__6:Close();
                        end;
                    end;
                end);
            end;
            l__GuiController__6.GuiFocusedSignal:Connect(function(p54) --[[ Line: 245 ]]
                -- upvalues: l__GuildInvite__10 (copy), u8 (ref), u44 (ref)
                if p54 == l__GuildInvite__10 then
                    u8 = true;
                    u44();
                end;
            end);
            l__GuiController__6.GuiUnfocusedSignal:Connect(function(p55) --[[ Line: 251 ]]
                -- upvalues: l__GuildInvite__10 (copy), u8 (ref), u13 (ref)
                if p55 == l__GuildInvite__10 then
                    u8 = false;
                    u13();
                end;
            end);
            l__Players__1.PlayerAdded:Connect(function() --[[ Line: 259 ]]
                -- upvalues: u8 (ref), u44 (ref)
                if u8 then
                    u44();
                end;
            end);
            l__Players__1.PlayerRemoving:Connect(function() --[[ Line: 262 ]]
                -- upvalues: u8 (ref), u44 (ref)
                if u8 then
                    task.defer(u44);
                end;
            end);
        end;
    end);
end;
return v2;