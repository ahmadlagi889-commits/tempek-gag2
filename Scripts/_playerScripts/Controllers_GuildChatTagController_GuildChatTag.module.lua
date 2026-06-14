-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__TextChatService__2 = game:GetService("TextChatService");
local v1 = {};
local u2 = false;
local function u7(p3, p4, p5) --[[ Line: 17 ]]
    local v6 = p4:gsub("<", "&lt;"):gsub(">", "&gt;");
    if p3 == "" then
        return string.format("<font color=\"%s\">[%s]</font> ", p5, v6);
    else
        return string.format("<font color=\"%s\">[%s]</font> %s", p5, v6, p3);
    end;
end;
local function u14(p8) --[[ Line: 26 ]]
    -- upvalues: l__Players__1 (copy), u7 (copy)
    local v9 = Instance.new("TextChatMessageProperties");
    local l__TextSource__3 = p8.TextSource;
    if not l__TextSource__3 then
        return v9;
    end;
    local v10 = l__Players__1:GetPlayerByUserId(l__TextSource__3.UserId);
    if not v10 then
        return v9;
    end;
    local v11 = v10:GetAttribute("GuildTag");
    if typeof(v11) ~= "string" or v11 == "" then
        return v9;
    end;
    local v12 = v10:GetAttribute("GuildColor");
    local v13 = (typeof(v12) ~= "string" or v12 == "") and "#6EE7A7" or v12;
    v9.PrefixText = u7(p8.PrefixText, v11, v13);
    return v9;
end;
function v1.Install() --[[ Line: 46 ]]
    -- upvalues: u2 (ref), l__TextChatService__2 (copy), u14 (copy)
    if u2 then
    else
        u2 = true;
        function l__TextChatService__2.OnIncomingMessage(p15) --[[ Line: 52 ]]
            -- upvalues: u14 (ref)
            return u14(p15);
        end;
    end;
end;
return v1;