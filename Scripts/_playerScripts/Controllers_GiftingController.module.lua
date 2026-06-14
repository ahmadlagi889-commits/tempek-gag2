-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local u1 = require("@game/ReplicatedStorage/SharedModules/Networking");
local l__LocalPlayer__2 = l__Players__1.LocalPlayer;
local l__Gifting__3 = l__LocalPlayer__2.PlayerGui:WaitForChild("Gifting");
local l__Notification__4 = l__Gifting__3:WaitForChild("Notification");
local u2 = {
    Crate = "Crates",
    Gnome = "Gnomes",
    Mushroom = "Mushrooms",
    Sprinkler = "Sprinklers",
    WateringCan = "WateringCans",
    HarvestedFruit = "HarvestedFruits",
    SeedTool = "Seeds"
};
local v3 = {};
local u4 = nil;
local u5 = {};
local u6 = nil;
local u7 = {};
function v3._createPrompt(_, u8, p9) --[[ Line: 33 ]]
    -- upvalues: u4 (ref), u1 (copy), u5 (copy)
    local l__HumanoidRootPart__5 = p9:WaitForChild("HumanoidRootPart", 10);
    if l__HumanoidRootPart__5 then
        local u10 = Instance.new("ProximityPrompt");
        u10.ClickablePrompt = true;
        u10.Name = "Gift";
        u10.HoldDuration = 0.5;
        u10.MaxActivationDistance = 10;
        u10.RequiresLineOfSight = false;
        u10.Style = Enum.ProximityPromptStyle.Custom;
        u10.KeyboardKeyCode = Enum.KeyCode.G;
        u10.ActionText = "Gift";
        u10.Enabled = u4 ~= nil;
        u10.Triggered:Connect(function() --[[ Line: 50 ]]
            -- upvalues: u4 (ref), u1 (ref), u8 (copy)
            if u4 then
                u1.Gifting.Send:Fire(u8.UserId, u4.type, u4.uuid);
            end;
        end);
        u10.Destroying:Connect(function() --[[ Line: 58 ]]
            -- upvalues: u5 (ref), u10 (copy)
            local v11 = table.find(u5, u10);
            if v11 then
                table.remove(u5, v11);
            end;
        end);
        u10.Parent = l__HumanoidRootPart__5;
        table.insert(u5, u10);
    end;
end;
function v3._updateEquippedTool(_, p12) --[[ Line: 70 ]]
    -- upvalues: u2 (copy), u4 (ref), u5 (copy)
    local v13 = p12:FindFirstChildWhichIsA("Tool");
    local v14 = nil;
    if v13 then
        for v15, v16 in u2 do
            local v17 = v13:GetAttribute(v15);
            if v17 then
                local v18 = v13:GetAttribute("Id");
                if type(v18) == "string" then
                    v17 = v18;
                elseif type(v17) ~= "string" then
                    v17 = v13.Name;
                end;
                v14 = {
                    type = v16,
                    uuid = v17
                };
                break;
            end;
        end;
    end;
    u4 = v14;
    for _, v19 in u5 do
        v19.Enabled = v14 ~= nil;
    end;
end;
function v3._watchPlayer(u20, u21) --[[ Line: 100 ]]
    -- upvalues: l__LocalPlayer__2 (copy)
    if u21 == l__LocalPlayer__2 then
    else
        u21.CharacterAdded:Connect(function(p22) --[[ Line: 105 ]]
            -- upvalues: u20 (copy), u21 (copy)
            u20:_createPrompt(u21, p22);
        end);
        if u21.Character then
            u20:_createPrompt(u21, u21.Character);
        end;
    end;
end;
function v3._watchLocalPlayer(u23, u24) --[[ Line: 114 ]]
    u23:_updateEquippedTool(u24);
    u24.ChildAdded:Connect(function() --[[ Line: 117 ]]
        -- upvalues: u23 (copy), u24 (copy)
        u23:_updateEquippedTool(u24);
    end);
    u24.ChildRemoved:Connect(function() --[[ Line: 121 ]]
        -- upvalues: u23 (copy), u24 (copy)
        u23:_updateEquippedTool(u24);
    end);
end;
function v3._dismissGift(p25, p26) --[[ Line: 126 ]]
    -- upvalues: u6 (ref), u1 (copy), u7 (copy), l__Gifting__3 (copy)
    if u6 then
        if p26 then
            u1.Gifting.Response:Fire(u6.player, false);
        end;
        u6 = nil;
        if next(u7) then
            p25:_showNextGift();
        else
            l__Gifting__3.Enabled = false;
        end;
    end;
end;
function v3._showNextGift(u27) --[[ Line: 144 ]]
    -- upvalues: u6 (ref), u7 (copy), l__Players__1 (copy), l__Notification__4 (copy), l__Gifting__3 (copy)
    if u6 then
    else
        local u28 = table.remove(u7, 1);
        if u28 then
            if u28.player and u28.player:IsDescendantOf(l__Players__1) then
                u6 = u28;
                task.delay(30, function() --[[ Line: 163 ]]
                    -- upvalues: u6 (ref), u28 (copy), u27 (copy)
                    if u6 == u28 then
                        u27:_dismissGift(true);
                    end;
                end);
                l__Notification__4.TextLabel.Text = `@{u28.player.Name} gifted:`;
                l__Notification__4.Reward.Text = u28.itemName;
                l__Notification__4.Reward.TextLabel.Text = u28.itemName;
                l__Gifting__3.Enabled = true;
            else
                u27:_showNextGift();
            end;
        end;
    end;
end;
function v3.Init(u29) --[[ Line: 176 ]]
    -- upvalues: u1 (copy), u7 (copy), u6 (ref)
    u1.Gifting.Prompted.OnClientEvent:Connect(function(p30, p31) --[[ Line: 177 ]]
        -- upvalues: u7 (ref), u6 (ref), u29 (copy)
        table.insert(u7, {
            player = p30,
            itemName = p31
        });
        if not u6 then
            u29:_showNextGift();
        end;
    end);
end;
function v3.Start(u32) --[[ Line: 186 ]]
    -- upvalues: l__LocalPlayer__2 (copy), l__Players__1 (copy), l__Notification__4 (copy), u6 (ref), u1 (copy)
    if l__LocalPlayer__2.Character then
        u32:_watchLocalPlayer(l__LocalPlayer__2.Character);
    end;
    l__LocalPlayer__2.CharacterAdded:Connect(function(p33) --[[ Line: 191 ]]
        -- upvalues: u32 (copy)
        u32:_watchLocalPlayer(p33);
    end);
    for _, v34 in l__Players__1:GetPlayers() do
        u32:_watchPlayer(v34);
    end;
    l__Players__1.PlayerAdded:Connect(function(p35) --[[ Line: 199 ]]
        -- upvalues: u32 (copy)
        u32:_watchPlayer(p35);
    end);
    l__Notification__4.Buttons.AcceptButton.Activated:Connect(function() --[[ Line: 203 ]]
        -- upvalues: u6 (ref), u1 (ref), u32 (copy)
        if u6 then
            u1.Gifting.Response:Fire(u6.player, true);
            u32:_dismissGift(false);
        end;
    end);
    l__Notification__4.Buttons.DeclineButton.Activated:Connect(function() --[[ Line: 212 ]]
        -- upvalues: u32 (copy)
        u32:_dismissGift(true);
    end);
end;
return v3;