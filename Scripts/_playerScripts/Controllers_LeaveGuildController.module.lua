-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__MessagePrompt__4 = require(l__ReplicatedStorage__2.ClientModules.MessagePrompt);
local l__NotificationController__5 = require(l__Players__1.LocalPlayer.PlayerScripts.Controllers.NotificationController);
local v1 = {
    StartOrder = 9
};
local function u6(p2) --[[ Line: 34 ]]
    local v3 = string.gsub(p2, "&", "&amp;");
    local v4 = string.gsub(v3, "<", "&lt;");
    local v5 = string.gsub(v4, ">", "&gt;");
    return string.gsub(v5, "\"", "&quot;");
end;
function v1.Open(_, p7) --[[ Line: 83 ]]
    -- upvalues: l__MessagePrompt__4 (copy), u6 (copy), l__Networking__3 (copy), l__NotificationController__5 (copy)
    local u8 = p7 and typeof(p7.Name) == "string" and (p7.Name or "Guild Name") or "Guild Name";
    local u9 = p7 and typeof(p7.Tag) == "string" and (p7.Tag or "TAG") or "TAG";
    local u10;
    if p7 then
        u10 = p7.Color;
    else
        u10 = p7;
    end;
    if typeof(u10) == "string" and u10 ~= "" then
        if string.sub(u10, 1, 1) ~= "#" then
            u10 = "#" .. u10;
        end;
    else
        u10 = "#FFFFFF";
    end;
    local u11;
    if p7 == nil then
        u11 = false;
    else
        u11 = p7.IsOwner == true;
    end;
    task.spawn(function() --[[ Line: 97 ]]
        -- upvalues: l__MessagePrompt__4 (ref), u8 (copy), u9 (copy), u10 (copy), u11 (copy), u6 (ref), l__Networking__3 (ref), l__NotificationController__5 (ref)
        local l__Prompt__6 = l__MessagePrompt__4.Prompt;
        local v12 = {
            yield = true,
            dontRestoreOnSuccess = true
        };
        local v13 = u9;
        local v14 = u10;
        local v15 = u11;
        local v16 = u6(u8);
        local v17 = u6(v13);
        v12.message = string.format("Are you sure you want to %s <font color=\"%s\">%s</font> <font color=\"%s\">[%s]</font>?", v15 and "disband" or "leave", v14, v16, v14, v17);
        v12.titleOverride = u11 and "Disband Guild" or "Leave Guild";
        v12.options = l__MessagePrompt__4.Choices.YesNo;
        if l__Prompt__6(v12) then
            local u18 = u8;
            local u19 = u11;
            task.spawn(function() --[[ Line: 53 ]]
                -- upvalues: l__Networking__3 (ref), u19 (copy), l__NotificationController__5 (ref), u18 (copy)
                local v20, v21, v22 = pcall(function() --[[ Line: 54 ]]
                    -- upvalues: l__Networking__3 (ref)
                    return l__Networking__3.Guild.Leave:Fire();
                end);
                if v20 and v21 then
                    l__NotificationController__5:CreateNotification(string.format("%s %s", u19 and "Disbanded" or "Left", u18));
                else
                    l__NotificationController__5:CreateNotification((typeof(v22) ~= "string" or v22 == "") and (u19 and "Could not disband guild" or "Could not leave guild") or v22);
                end;
            end);
        end;
    end);
end;
function v1.Close(_) --[[ Line: 116 ]] end;
function v1.Init(_) --[[ Line: 118 ]] end;
function v1.Start(_) --[[ Line: 120 ]] end;
return v1;