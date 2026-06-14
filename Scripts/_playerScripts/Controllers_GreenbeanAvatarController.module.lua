-- Decompiled with Potassium's decompiler.

local l__AvatarEditorService__1 = game:GetService("AvatarEditorService");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Players__4 = game:GetService("Players");
local l__Networking__5 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__GreenbeanAvatarItems__6 = require(l__ReplicatedStorage__3.SharedData.GreenbeanAvatarItems);
local l__GreenbeanCheck__7 = require(l__ReplicatedStorage__3.SharedData.GreenbeanCheck);
local l__GreenbeanHumanoidDescription__8 = l__ReplicatedStorage__3.Assets.GreenbeanHumanoidDescription;
local v1 = {};
local l__LocalPlayer__9 = l__Players__4.LocalPlayer;
local u2 = false;
l__AvatarEditorService__1.PromptSaveAvatarCompleted:Connect(function(p3, p4) --[[ Line: 17 ]]
    -- upvalues: u2 (ref), l__GreenbeanCheck__7 (copy), l__Networking__5 (copy)
    u2 = false;
    if p3 == Enum.AvatarPromptResult.Success and l__GreenbeanCheck__7.IsGreenbeanDescription(p4) then
        l__Networking__5.Greenbean.Action:Fire("LoadAvatar");
    end;
end);
l__Networking__5.Greenbean.Action.OnClientEvent:Connect(function(p5) --[[ Line: 25 ]]
    -- upvalues: l__MarketplaceService__2 (copy), u2 (ref), l__AvatarEditorService__1 (copy), l__GreenbeanHumanoidDescription__8 (copy)
    if p5 == "PromptBulkPurchase" then
        l__MarketplaceService__2.PromptBulkPurchaseFinished:Once(function(_, p6, _) --[[ Line: 27 ]]
            -- upvalues: u2 (ref), l__AvatarEditorService__1 (ref), l__GreenbeanHumanoidDescription__8 (ref)
            if p6 == Enum.MarketplaceBulkPurchasePromptStatus.Completed and not u2 then
                u2 = true;
                pcall(function() --[[ Line: 33 ]]
                    -- upvalues: l__AvatarEditorService__1 (ref), l__GreenbeanHumanoidDescription__8 (ref)
                    l__AvatarEditorService__1:PromptSaveAvatar(l__GreenbeanHumanoidDescription__8, Enum.HumanoidRigType.R6);
                end);
            end;
        end);
    else
        if p5 == "PromptSaveAvatar" then
            if u2 then
                return;
            end;
            u2 = true;
            pcall(function() --[[ Line: 43 ]]
                -- upvalues: l__AvatarEditorService__1 (ref), l__GreenbeanHumanoidDescription__8 (ref)
                l__AvatarEditorService__1:PromptSaveAvatar(l__GreenbeanHumanoidDescription__8, Enum.HumanoidRigType.R6);
            end);
        end;
    end;
end);
local u7 = nil;
local function u13(p8) --[[ Line: 50 ]]
    -- upvalues: u7 (ref), l__MarketplaceService__2 (copy), l__LocalPlayer__9 (copy)
    if u7 then
        return u7;
    end;
    local v9 = {};
    for _, u10 in p8 do
        local v11 = false;
        local v12 = false;
        if u10.Type == Enum.MarketplaceProductType.AvatarAsset then
            v11, v12 = pcall(function() --[[ Line: 59 ]]
                -- upvalues: l__MarketplaceService__2 (ref), l__LocalPlayer__9 (ref), u10 (copy)
                return l__MarketplaceService__2:PlayerOwnsAsset(l__LocalPlayer__9, (tonumber(u10.Id)));
            end);
        elseif u10.Type == Enum.MarketplaceProductType.AvatarBundle then
            v11, v12 = pcall(function() --[[ Line: 63 ]]
                -- upvalues: l__MarketplaceService__2 (ref), l__LocalPlayer__9 (ref), u10 (copy)
                return l__MarketplaceService__2:PlayerOwnsBundle(l__LocalPlayer__9, (tonumber(u10.Id)));
            end);
        end;
        if not (v11 and v12) then
            table.insert(v9, u10);
        end;
    end;
    u7 = v9;
    task.delay(20, function() --[[ Line: 74 ]]
        -- upvalues: u7 (ref)
        u7 = nil;
    end);
    return v9;
end;
function v1.Prompt(_) --[[ Line: 81 ]]
    -- upvalues: u2 (ref), u13 (copy), l__GreenbeanAvatarItems__6 (copy), l__Networking__5 (copy)
    if u2 then
    elseif #u13(l__GreenbeanAvatarItems__6) == 0 then
        l__Networking__5.Greenbean.Action:Fire("PromptSaveAvatar");
    else
        l__Networking__5.Greenbean.Action:Fire("PromptBulkPurchase");
    end;
end;
return v1;