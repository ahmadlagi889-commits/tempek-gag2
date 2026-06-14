-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__PlayerGui__4 = l__Players__1.LocalPlayer:WaitForChild("PlayerGui");
local v1 = {
    StartOrder = 10
};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = false;
local function u7() --[[ Line: 43 ]]
    -- upvalues: u2 (ref)
    if u2 then
        u2.Enabled = false;
    end;
end;
local function u13(p8) --[[ Line: 47 ]]
    local v9 = (-1 / 0);
    local v10 = nil;
    for _, v11 in p8 do
        if typeof(v11) == "table" and v11.Kind == "GuildReward" then
            local v12 = tonumber(v11.SentAt) or 0;
            if v9 < v12 then
                v10 = v11;
                v9 = v12;
            end;
        end;
    end;
    return v10;
end;
local function u21(p14) --[[ Line: 62 ]]
    -- upvalues: u6 (ref), u2 (ref), u3 (ref), u13 (copy)
    if u6 then
    elseif typeof(p14) == "table" then
        if u2 and u3 then
            local v15 = u13(p14);
            if v15 then
                local v16 = tonumber(v15.Placement);
                local v17;
                if v16 and v16 > 0 then
                    local l__format__5 = string.format;
                    local v18 = math.floor(v16);
                    v17 = l__format__5("Your guild placed #%s", (tostring(v18):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
                else
                    v17 = "Your guild placed in the contest!";
                end;
                local v19 = u3;
                if v19 then
                    v19.RichText = true;
                    v19.Text = v17;
                    local v20 = v19:FindFirstChild("TextLabel");
                    if v20 and v20:IsA("TextLabel") then
                        v20.RichText = true;
                        v20.Text = v17;
                    end;
                end;
                u2.Enabled = true;
                u6 = true;
            end;
        end;
    end;
end;
local function u30(p22) --[[ Line: 84 ]]
    -- upvalues: u3 (ref), u4 (ref), u5 (ref)
    local v23 = p22:FindFirstChild("GuildWeekComplete");
    if v23 then
        local v24 = v23:FindFirstChild("Content");
        local v25 = v24 and v24:FindFirstChild("Info");
        if v25 then
            local v26 = v25:FindFirstChild("Placement");
            if v26 and v26:IsA("TextLabel") then
                u3 = v26;
            end;
        end;
        local v27 = v23:FindFirstChild("Header");
        if v27 then
            local v28 = v27:FindFirstChild("ExitButton");
            if v28 and v28:IsA("GuiButton") then
                u4 = v28;
            end;
        end;
        local v29 = v23:FindFirstChild("ContinueButton");
        if v29 and v29:IsA("GuiButton") then
            u5 = v29;
        end;
    end;
end;
function v1.Init(_) --[[ Line: 113 ]] end;
function v1.Start(_) --[[ Line: 115 ]]
    -- upvalues: l__PlayerGui__4 (copy), u2 (ref), u30 (copy), u4 (ref), u7 (copy), u5 (ref), l__Networking__3 (copy), u21 (copy)
    task.spawn(function() --[[ Line: 116 ]]
        -- upvalues: l__PlayerGui__4 (ref), u2 (ref), u30 (ref), u4 (ref), u7 (ref), u5 (ref), l__Networking__3 (ref), u21 (ref)
        local l__GuildWeekComplete__6 = l__PlayerGui__4:WaitForChild("GuildWeekComplete", 30);
        if l__GuildWeekComplete__6 and l__GuildWeekComplete__6:IsA("ScreenGui") then
            u2 = l__GuildWeekComplete__6;
            l__GuildWeekComplete__6.Enabled = false;
            u30(l__GuildWeekComplete__6);
            if u4 then
                u4.MouseButton1Click:Connect(u7);
            end;
            if u5 then
                u5.MouseButton1Click:Connect(u7);
            end;
            l__Networking__3.Mailbox.Updated.OnClientEvent:Connect(function(p31) --[[ Line: 124 ]]
                -- upvalues: u21 (ref)
                local v32 = u21;
                if typeof(p31) == "table" then
                    if typeof(p31.Mailbox) == "table" then
                        p31 = p31.Mailbox;
                    end;
                else
                    p31 = nil;
                end;
                v32(p31);
            end);
            task.spawn(function() --[[ Line: 128 ]]
                -- upvalues: l__Networking__3 (ref), u21 (ref)
                local v33, v34 = pcall(function() --[[ Line: 129 ]]
                    -- upvalues: l__Networking__3 (ref)
                    return l__Networking__3.Mailbox.OpenInbox:Fire();
                end);
                if v33 then
                    local v35 = u21;
                    if typeof(v34) == "table" then
                        if typeof(v34.Mailbox) == "table" then
                            v34 = v34.Mailbox;
                        end;
                    else
                        v34 = nil;
                    end;
                    v35(v34);
                end;
            end);
        end;
    end);
end;
return v1;