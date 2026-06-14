-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Debris__5 = game:GetService("Debris");
local l__SoundService__6 = game:GetService("SoundService");
local l__SocialService__7 = game:GetService("SocialService");
local l__ReplicatedStorage__8 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__8.ClientModules.Chalk);
local l__NotificationCondenser__9 = require(script.NotificationCondenser);
local l__Networking__10 = require(l__ReplicatedStorage__8.SharedModules.Networking);
local l__NumberUtils__11 = require(l__ReplicatedStorage__8.SharedModules.NumberUtils);
local l__Purchase__12 = game.SoundService.SFX.Purchase;
local l__Accept__13 = game.SoundService.SFX.BargainSFX.Accept;
local l__Tick__14 = game.SoundService.SFX.Tick;
local u2 = Instance.new("Sound");
u2.SoundId = "rbxassetid://114731118678981";
u2.Parent = l__SoundService__6;
local function u4(p3) --[[ Line: 25 ]]
    -- upvalues: l__NumberUtils__11 (copy)
    return "<font color=\"#00FF00\">" .. l__NumberUtils__11.Abbreviate(p3) .. "¢</font>";
end;
local l__LocalPlayer__15 = l__Players__1.LocalPlayer;
local l__DevProductController__16 = require(l__LocalPlayer__15.PlayerScripts.Controllers.DevProductController);
local l__Frame__17 = l__LocalPlayer__15:WaitForChild("PlayerGui"):WaitForChild("TopNotification"):WaitForChild("Frame");
local l__Notification__18 = l__SoundService__6.SFX.Notification;
local l__Notification_UI_Mobile__19 = l__ReplicatedStorage__8.Assets.NotificationUI.Notification_UI_Mobile;
local l__Notification_UI__20 = l__ReplicatedStorage__8.Assets.NotificationUI.Notification_UI;
local u5 = {
    ["Common Seed Pack"] = {
        Color = Color3.fromRGB(180, 180, 180)
    },
    ["Uncommon Seed Pack"] = {
        Color = Color3.fromRGB(85, 220, 85)
    },
    ["Rare Seed Pack"] = {
        Color = Color3.fromRGB(85, 140, 255)
    },
    ["Epic Seed Pack"] = {
        Color = Color3.fromRGB(180, 90, 255)
    },
    ["Legendary Seed Pack"] = {
        Color = Color3.fromRGB(255, 220, 70)
    },
    ["Mythic Seed Pack"] = {
        Color = Color3.fromRGB(255, 70, 70)
    },
    ["Super Seed Pack"] = {
        Gradient = "rainbow"
    },
    ["Secret Seed Pack"] = {
        Gradient = "bw"
    },
    ["Gold Seed"] = {
        Gradient = "gold"
    },
    ["Rainbow Seed"] = {
        Gradient = "rainbow"
    }
};
local u6 = {
    Common = {
        Color = Color3.fromRGB(180, 180, 180)
    },
    Uncommon = {
        Color = Color3.fromRGB(85, 220, 85)
    },
    Rare = {
        Color = Color3.fromRGB(85, 140, 255)
    },
    Epic = {
        Color = Color3.fromRGB(180, 90, 255)
    },
    Legendary = {
        Color = Color3.fromRGB(255, 220, 70)
    },
    Mythic = {
        Color = Color3.fromRGB(255, 70, 70)
    },
    Super = {
        Gradient = "rainbow"
    },
    Secret = {
        Gradient = "bw"
    }
};
local u7 = {
    {
        threshold = 5,
        color = "#aaaaaa"
    },
    {
        threshold = 10,
        color = "#55ff7f"
    },
    {
        threshold = 15,
        color = "#ffe066"
    },
    {
        threshold = 20,
        color = "#55aaff"
    },
    {
        threshold = 40,
        color = "#ff5555"
    }
};
local u8 = {};
local u9 = {};
local function u15(p10, p11, p12) --[[ Line: 160 ]]
    -- upvalues: l__TweenService__3 (copy)
    if p10 and p10.Visible then
        l__TweenService__3:Create(p10, p12, {
            BackgroundTransparency = p11
        }):Play();
        local v13 = p10:FindFirstChildWhichIsA("UIStroke");
        if v13 then
            l__TweenService__3:Create(v13, p12, {
                Transparency = p11
            }):Play();
        end;
        for _, v14 in p10:GetDescendants() do
            if v14:IsA("TextLabel") or v14:IsA("TextButton") then
                l__TweenService__3:Create(v14, p12, {
                    TextTransparency = p11,
                    TextStrokeTransparency = p11
                }):Play();
            elseif v14:IsA("ImageLabel") or v14:IsA("ImageButton") then
                l__TweenService__3:Create(v14, p12, {
                    ImageTransparency = p11
                }):Play();
            elseif v14:IsA("UIStroke") then
                l__TweenService__3:Create(v14, p12, {
                    Transparency = p11
                }):Play();
            end;
        end;
    end;
end;
local function u19(p16) --[[ Line: 188 ]]
    -- upvalues: l__TweenService__3 (copy), u15 (copy), l__Notification__18 (copy)
    local v17 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v18 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l__TweenService__3:Create(p16.Content.TextLabel, v18, {
        Position = p16.Content.TextLabel.Position
    }):Play();
    l__TweenService__3:Create(p16.ImageLabel, v17, {
        ImageTransparency = 0.5
    }):Play();
    l__TweenService__3:Create(p16.Content.TextLabel, v17, {
        TextTransparency = 0
    }):Play();
    l__TweenService__3:Create(p16.Content.TextLabel, v17, {
        TextStrokeTransparency = 0
    }):Play();
    u15(p16.Content:FindFirstChild("DevProductInventory"), 0, v17);
    l__Notification__18.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l__Notification__18.Playing = true;
    l__Notification__18.TimePosition = 0;
end;
local function u23(p20) --[[ Line: 205 ]]
    -- upvalues: l__TweenService__3 (copy), u15 (copy), l__Debris__5 (copy)
    local v21 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v22 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l__TweenService__3:Create(p20.Content.TextLabel, v22, {
        Position = p20.Content.TextLabel.Position + UDim2.new(0, 0, 0.2, 0)
    }):Play();
    l__TweenService__3:Create(p20.ImageLabel, v21, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__3:Create(p20.Content.TextLabel, v21, {
        TextTransparency = 1
    }):Play();
    l__TweenService__3:Create(p20.Content.TextLabel, v21, {
        TextStrokeTransparency = 1
    }):Play();
    u15(p20.Content:FindFirstChild("DevProductInventory"), 1, v21);
    l__Debris__5:AddItem(p20, v21.Time);
end;
local function u43(p24, p25, p26, p27) --[[ Line: 220 ]]
    -- upvalues: l__LocalPlayer__15 (copy), l__DevProductController__16 (copy), l__SocialService__7 (copy), l__Players__1 (copy), l__Frame__17 (copy)
    local u28 = p24:Clone();
    u28.Content.TextLabel.RichText = string.find(p25, "<%a") ~= nil;
    u28.Content.TextLabel.Text = p25;
    u28:SetAttribute("OG", p25);
    u28:SetAttribute("NotificationTimer", p26);
    if p27 then
        u28:SetAttribute("HelperUserId", p27);
    end;
    local v29 = Instance.new("IntValue");
    v29.Name = "VAL_OBJ";
    v29.Value = 1;
    v29.Parent = u28;
    u28.ImageLabel.ImageTransparency = 1;
    u28.Content.TextLabel.TextTransparency = 1;
    u28.Content.TextLabel.TextStrokeTransparency = 1;
    local function v33(p30) --[[ Line: 239 ]]
        p30.Visible = true;
        p30.BackgroundTransparency = 1;
        local v31 = p30:FindFirstChildWhichIsA("UIStroke");
        if v31 then
            v31.Transparency = 1;
        end;
        for _, v32 in p30:GetDescendants() do
            if v32:IsA("TextLabel") or v32:IsA("TextButton") then
                v32.TextTransparency = 1;
                v32.TextStrokeTransparency = 1;
            elseif v32:IsA("ImageLabel") or v32:IsA("ImageButton") then
                v32.ImageTransparency = 1;
            end;
        end;
    end;
    if p25 == "Your inventory is full" then
        local v34 = (tonumber(l__LocalPlayer__15:GetAttribute("BackpackSpaceUpgradesPurchased")) or 0) >= 37;
        local v35 = u28.Content:FindFirstChild("DevProductInventory");
        if v35 then
            if v34 then
                v35.Visible = false;
            else
                v33(v35);
                v35.Activated:Connect(function() --[[ Line: 271 ]]
                    -- upvalues: l__DevProductController__16 (ref), l__LocalPlayer__15 (ref)
                    local v36 = l__DevProductController__16;
                    local v37 = (tonumber(l__LocalPlayer__15:GetAttribute("BackpackSpaceUpgradesPurchased")) or 0) + 1;
                    v36:PromptPurchase((`SkillUpgrade:Backpack Space:{math.min(v37, 37)}`));
                end);
            end;
        end;
    elseif p25 == "Friend in Server Required!" then
        local v38 = u28.Content:FindFirstChild("DevProductInventory");
        if v38 then
            v33(v38);
            v38.Activated:Connect(function() --[[ Line: 280 ]]
                -- upvalues: l__SocialService__7 (ref), l__LocalPlayer__15 (ref)
                local u39 = Instance.new("ExperienceInviteOptions");
                u39.PromptMessage = "Invite a friend to use the Wheelbarrow!";
                pcall(function() --[[ Line: 36 ]]
                    -- upvalues: l__SocialService__7 (ref), l__LocalPlayer__15 (ref), u39 (copy)
                    l__SocialService__7:PromptGameInvite(l__LocalPlayer__15, u39);
                end);
            end);
        end;
    else
        local v40 = u28:GetAttribute("HelperUserId") and u28.Content:FindFirstChild("DevProductInventory");
        if v40 then
            v33(v40);
            v40.Activated:Connect(function() --[[ Line: 292 ]]
                -- upvalues: u28 (copy), l__Players__1 (ref)
                local v41 = u28:GetAttribute("HelperUserId");
                if type(v41) == "number" then
                    local u42 = l__Players__1:GetPlayerByUserId(v41);
                    if u42 then
                        pcall(function() --[[ Line: 45 ]]
                            -- upvalues: u42 (copy)
                            game.StarterGui:SetCore("PromptSendFriendRequest", u42);
                        end);
                    end;
                end;
            end);
        end;
    end;
    u28.Parent = l__Frame__17;
    return u28;
end;
local function u70(p44, u45, u46, u47, p48, p49, p50, u51) --[[ Line: 312 ]]
    -- upvalues: l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), u43 (copy), u19 (copy), l__RunService__2 (copy), l__Tick__14 (copy), l__Accept__13 (copy)
    local u52 = p49 or tostring;
    local v53 = p44 and l__Notification_UI_Mobile__19 or l__Notification_UI__20;
    local u54 = p50 or (u46 <= 1 and 0 or math.min(u46 * 0.05, 5));
    local v55 = (p48 or 3.5) + math.ceil(u54);
    local v56 = u54 > 0 and 1 or u46;
    local u57 = u43(v53, u45 .. u52(v56) .. u47, v55);
    u57:SetAttribute("OG", (`__odometer_{u45}{u46}_{os.clock()}`));
    u19(u57);
    if u54 <= 0 then
        if u51 then
            u51(u57);
        end;
        return u57;
    end;
    local l__TextLabel__21 = u57.Content.TextLabel;
    local u58 = os.clock();
    local u59 = v56;
    local u60 = 0;
    local u61 = nil;
    u61 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 335 ]]
        -- upvalues: u57 (copy), l__TextLabel__21 (copy), u61 (ref), u58 (copy), u54 (copy), u46 (copy), u59 (ref), u45 (copy), u52 (copy), u47 (copy), u60 (ref), l__Tick__14 (ref), l__Accept__13 (ref), u51 (copy)
        if u57.Parent and l__TextLabel__21.Parent then
            local v62 = (os.clock() - u58) / u54;
            local v63 = math.min(v62, 1);
            local v64 = 1 - (1 - v63) ^ 2;
            local v65;
            if v63 >= 1 then
                v65 = u46;
            else
                local v66 = math.floor((u46 - 1) * v64 + 1 + 0.5);
                v65 = math.clamp(v66, 1, u46);
            end;
            if v65 ~= u59 then
                u59 = v65;
                l__TextLabel__21.Text = u45 .. u52(v65) .. u47;
                local v67 = os.clock();
                if u60 <= v67 then
                    local v68 = v64 + 1;
                    l__Tick__14.PlaybackSpeed = v68;
                    l__Tick__14.TimePosition = 0;
                    l__Tick__14.Playing = true;
                    u60 = v67 + 0.079 / v68;
                end;
            end;
            if v63 >= 1 and u61 then
                u61:Disconnect();
                u61 = nil;
                l__Accept__13.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                l__Accept__13.TimePosition = 0;
                l__Accept__13.Playing = true;
                if u51 then
                    u51(u57);
                end;
            end;
        else
            if u61 then
                u61:Disconnect();
                u61 = nil;
            end;
        end;
    end);
    u57.AncestryChanged:Connect(function(_, p69) --[[ Line: 376 ]]
        -- upvalues: u61 (ref)
        if not p69 and u61 then
            u61:Disconnect();
            u61 = nil;
        end;
    end);
    return u57;
end;
local function u93(p71, p72, p73, p74) --[[ Line: 386 ]]
    -- upvalues: l__Purchase__12 (copy), l__LocalPlayer__15 (copy), u70 (copy), u4 (copy), u6 (copy), u1 (copy), u2 (copy), l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), l__NotificationCondenser__9 (copy), l__Frame__17 (copy), u9 (copy), u8 (copy), u43 (copy), u19 (copy)
    local v75 = p74 or 3.5;
    local v76 = string.match(p72, "^You stole (%d+) fruits!$");
    if v76 then
        l__Purchase__12.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l__Purchase__12.Playing = true;
        l__Purchase__12.TimePosition = 0;
        local v77 = tonumber(l__LocalPlayer__15:GetAttribute("StolenCarryValue")) or 0;
        local v78 = math.floor(v77);
        if v78 > 0 then
            u70(p71, "You <font color=\"#FF4444\">stole</font> ", v78, " worth of fruit!", v75, u4, 2);
            return;
        else
            u70(p71, "You stole ", tonumber(v76), " fruits!", v75);
            return;
        end;
    end;
    local v79, v80 = string.match(p72, "^(An?) (%a+) pet has spawned!$");
    if v79 and (v80 and u6[v80]) then
        u1:CreateRarityWordNotification(v79 .. " ", v80, " pet has spawned!", v80);
        return;
    end;
    local v81 = string.match(p72, "^Guild Competition Record: ([%d%.]+)kg!$");
    if v81 and tonumber(v81) then
        u1:CreateGuildRecordNotification(p71, tonumber(v81), v75);
        return;
    end;
    if string.match(p72, "^New sell price record!") then
        u2.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        u2.TimePosition = 0;
        u2.Playing = true;
    end;
    local v82 = p71 and l__Notification_UI_Mobile__19 or l__Notification_UI__20;
    local v83 = l__NotificationCondenser__9:GetCondenseKey(p72);
    local v84 = nil;
    if v83 then
        for _, v85 in ipairs(l__Frame__17:GetChildren()) do
            if v85:IsA("Frame") and v85:GetAttribute("CondenseKey") == v83.Rule.Key then
                v84 = v85;
                break;
            end;
        end;
        if v84 then
            if p71 then
                local v86 = u8[v83.Rule.Key] or {};
                table.insert(v86, {
                    Text = p72,
                    Duration = v75,
                    IsMobile = p71
                });
                u8[v83.Rule.Key] = v86;
                return;
            else
                local v87 = u9[v84] or {};
                local v88 = {};
                for _, v89 in ipairs(v87) do
                    v88[v89.Plain] = true;
                end;
                if not v88[v83.Variant.Plain] then
                    table.insert(v87, v83.Variant);
                end;
                u9[v84] = v87;
                if #v87 >= 2 then
                    v84.Content.TextLabel.RichText = true;
                    v84.Content.TextLabel.Text = l__NotificationCondenser__9:BuildCondensedText(v87, v83.Rule.Suffix, v83.Rule.PluralSuffix);
                end;
                v84:SetAttribute("NotificationTimer", v75);
                return;
            end;
        end;
    elseif not p73 then
        for _, v90 in ipairs(l__Frame__17:GetChildren()) do
            if v90:IsA("Frame") and v90:GetAttribute("OG") == p72 then
                v84 = v90;
                break;
            end;
        end;
        if v84 then
            local v91 = v84:FindFirstChild("VAL_OBJ");
            if v91 then
                v91.Value = v91.Value + 1;
                v84.Content.TextLabel.Text = p72 .. " [X" .. v91.Value .. "]";
            end;
            v84:SetAttribute("NotificationTimer", v75);
            return;
        end;
    end;
    local v92 = u43(v82, p72, v75);
    if v83 then
        v92:SetAttribute("CondenseKey", v83.Rule.Key);
        u9[v92] = { v83.Variant };
    end;
    u19(v92);
end;
local function u99(p94) --[[ Line: 527 ]]
    -- upvalues: l__UserInputService__4 (copy), l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), l__Frame__17 (copy), u43 (copy), u19 (copy)
    local l__CurrentCamera__22 = workspace.CurrentCamera;
    local v95;
    if l__CurrentCamera__22 then
        local l__ViewportSize__23 = l__CurrentCamera__22.ViewportSize;
        v95 = math.min(l__ViewportSize__23.X, l__ViewportSize__23.Y) <= 600;
    else
        v95 = l__UserInputService__4.TouchEnabled;
    end;
    local v96 = v95 and l__Notification_UI_Mobile__19 or l__Notification_UI__20;
    local v97 = `{p94.Name} is helping your garden! Friend?`;
    for _, v98 in l__Frame__17:GetChildren() do
        if v98:IsA("Frame") and v98:GetAttribute("HelperUserId") == p94.UserId then
            v98:SetAttribute("NotificationTimer", 7);
            return;
        end;
    end;
    u19((u43(v96, v97, 7, p94.UserId)));
end;
local function u113(p100, p101, p102) --[[ Line: 569 ]]
    local v103 = table.create(#p100);
    for v104 = 1, #p100 do
        local v105 = string.sub(p100, v104, v104);
        local v106, v107, v108;
        if p102 == "rainbow" then
            local v109 = Color3.fromHSV((p101 * 0.6 + (v104 - 1) * 0.02) % 1, 1, 1);
            v106 = math.floor(v109.R * 255);
            v107 = math.floor(v109.G * 255);
            v108 = math.floor(v109.B * 255);
        elseif p102 == "gold" then
            local v110 = math.sin(p101 * 5 + v104 * 0.55) * 0.5 + 0.5;
            v107 = math.floor(v110 * 60 + 180);
            v108 = math.floor(v110 * 40 + 20);
            v106 = 255;
        else
            local v111 = (math.sin(p101 * 4 + v104 * 0.45) * 0.5 + 0.5) * 255;
            v106 = math.floor(v111);
            v108 = v106;
            v107 = v108;
            local v112 = v108;
            v108 = v107;
            v112 = v107;
        end;
        if v105 == " " then
            v103[v104] = " ";
        else
            v103[v104] = `<font color="rgb({v106},{v107},{v108})">{v105}</font>`;
        end;
    end;
    return table.concat(v103);
end;
function u1.CreateSeedPackSpawnNotification(_, u114) --[[ Line: 611 ]]
    -- upvalues: u5 (copy), l__UserInputService__4 (copy), l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), u113 (copy), l__Frame__17 (copy), u19 (copy), l__RunService__2 (copy)
    local v115 = u5[u114];
    if v115 then
        local l__CurrentCamera__24 = workspace.CurrentCamera;
        local v116;
        if l__CurrentCamera__24 then
            local l__ViewportSize__25 = l__CurrentCamera__24.ViewportSize;
            v116 = math.min(l__ViewportSize__25.X, l__ViewportSize__25.Y) <= 600;
        else
            v116 = l__UserInputService__4.TouchEnabled;
        end;
        local v117 = v116 and l__Notification_UI_Mobile__19 or l__Notification_UI__20;
        local v118;
        if v115.Gradient then
            v118 = `A {u113(u114, 0, v115.Gradient)} Spawned!`;
        else
            local v119 = v115.Color or Color3.new(1, 1, 1);
            v118 = `A <font color="rgb({math.floor(v119.R * 255)},{math.floor(v119.G * 255)},{math.floor(v119.B * 255)})">{u114}</font> Spawned!`;
        end;
        local u120 = v117:Clone();
        u120:SetAttribute("OG", (`__seedpack_{u114}_{os.clock()}`));
        u120:SetAttribute("NotificationTimer", 6);
        u120.Content.TextLabel.RichText = true;
        u120.Content.TextLabel.Text = v118;
        local v121 = Instance.new("IntValue");
        v121.Name = "VAL_OBJ";
        v121.Value = 1;
        v121.Parent = u120;
        u120.ImageLabel.ImageTransparency = 1;
        u120.Content.TextLabel.TextTransparency = 1;
        u120.Content.TextLabel.TextStrokeTransparency = 1;
        u120.Parent = l__Frame__17;
        u19(u120);
        if v115.Gradient then
            local l__TextLabel__26 = u120.Content.TextLabel;
            local l__Gradient__27 = v115.Gradient;
            local u122 = os.clock();
            local u123 = nil;
            u123 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 650 ]]
                -- upvalues: u120 (copy), l__TextLabel__26 (copy), u123 (ref), u114 (copy), u122 (copy), l__Gradient__27 (copy), u113 (ref)
                if u120.Parent and l__TextLabel__26.Parent then
                    l__TextLabel__26.Text = `A {u113(u114, os.clock() - u122, l__Gradient__27)} Spawned!`;
                else
                    u123:Disconnect();
                end;
            end);
            u120.AncestryChanged:Connect(function(_, p124) --[[ Line: 657 ]]
                -- upvalues: u123 (ref)
                if not p124 and u123 then
                    u123:Disconnect();
                    u123 = nil;
                end;
            end);
        end;
    end;
end;
function u1.CreateRarityWordNotification(_, u125, u126, u127, p128) --[[ Line: 688 ]]
    -- upvalues: u6 (copy), l__UserInputService__4 (copy), l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), u113 (copy), l__Frame__17 (copy), u19 (copy), l__RunService__2 (copy)
    local v129 = u6[p128] or u6.Common;
    local l__CurrentCamera__28 = workspace.CurrentCamera;
    local v130;
    if l__CurrentCamera__28 then
        local l__ViewportSize__29 = l__CurrentCamera__28.ViewportSize;
        v130 = math.min(l__ViewportSize__29.X, l__ViewportSize__29.Y) <= 600;
    else
        v130 = l__UserInputService__4.TouchEnabled;
    end;
    local v131 = v130 and l__Notification_UI_Mobile__19 or l__Notification_UI__20;
    local v132;
    if v129.Gradient then
        v132 = `{u125}{u113(u126, 0, v129.Gradient)}{u127}`;
    else
        local v133 = v129.Color or Color3.new(1, 1, 1);
        v132 = `{u125}<font color="rgb({math.floor(v133.R * 255)},{math.floor(v133.G * 255)},{math.floor(v133.B * 255)})">{u126}</font>{u127}`;
    end;
    local u134 = v131:Clone();
    u134:SetAttribute("OG", (`__rarity_word_{u126}_{p128}_{os.clock()}`));
    u134:SetAttribute("NotificationTimer", 6);
    u134.Content.TextLabel.RichText = true;
    u134.Content.TextLabel.Text = v132;
    local v135 = Instance.new("IntValue");
    v135.Name = "VAL_OBJ";
    v135.Value = 1;
    v135.Parent = u134;
    u134.ImageLabel.ImageTransparency = 1;
    u134.Content.TextLabel.TextTransparency = 1;
    u134.Content.TextLabel.TextStrokeTransparency = 1;
    u134.Parent = l__Frame__17;
    u19(u134);
    if v129.Gradient then
        local l__TextLabel__30 = u134.Content.TextLabel;
        local l__Gradient__31 = v129.Gradient;
        local u136 = os.clock();
        local u137 = nil;
        u137 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 724 ]]
            -- upvalues: u134 (copy), l__TextLabel__30 (copy), u137 (ref), u125 (copy), u126 (copy), u127 (copy), u136 (copy), l__Gradient__31 (copy), u113 (ref)
            if u134.Parent and l__TextLabel__30.Parent then
                local v138 = u127;
                l__TextLabel__30.Text = `{u125}{u113(u126, os.clock() - u136, l__Gradient__31)}{v138}`;
            else
                u137:Disconnect();
            end;
        end);
        u134.AncestryChanged:Connect(function(_, p139) --[[ Line: 731 ]]
            -- upvalues: u137 (ref)
            if not p139 and u137 then
                u137:Disconnect();
                u137 = nil;
            end;
        end);
    end;
end;
function u1.CreateGuildRecordNotification(_, p140, u141, p142) --[[ Line: 745 ]]
    -- upvalues: u7 (copy), u70 (copy), l__RunService__2 (copy), u113 (copy)
    local u143;
    for _, v144 in u7 do
        if u141 < v144.threshold then
            u143 = v144.color;
            u70(p140, not u143 and "Guild Competition Record: " or `Guild Competition Record: <font color="{u143}">`, u141, u143 and "kg</font>!" or "kg!", p142, nil, nil, function(u150) --[[ Line: 752 ]]
                -- upvalues: u143 (copy), u141 (copy), l__RunService__2 (ref), u113 (ref)
                if u143 then
                else
                    local l__Content__33 = u150.Content;
                    if l__Content__33 then
                        l__Content__33 = u150.Content:FindFirstChild("TextLabel");
                    end;
                    if l__Content__33 then
                        l__Content__33.RichText = true;
                        local u151 = `{u141}kg`;
                        local u152 = os.clock();
                        local u153 = nil;
                        u153 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 762 ]]
                            -- upvalues: u150 (copy), l__Content__33 (copy), u153 (ref), u151 (copy), u152 (copy), u113 (ref)
                            if u150.Parent and l__Content__33.Parent then
                                l__Content__33.Text = `Guild Competition Record: {u113(u151, os.clock() - u152, "rainbow")}!`;
                            else
                                if u153 then
                                    u153:Disconnect();
                                    u153 = nil;
                                end;
                            end;
                        end);
                        u150.AncestryChanged:Connect(function(_, p154) --[[ Line: 769 ]]
                            -- upvalues: u153 (ref)
                            if not p154 and u153 then
                                u153:Disconnect();
                                u153 = nil;
                            end;
                        end);
                    end;
                end;
            end);
            return;
        end;
    end;
    u143 = nil;
    u70(p140, not u143 and "Guild Competition Record: " or `Guild Competition Record: <font color="{u143}">`, u141, u143 and "kg</font>!" or "kg!", p142, nil, nil, function(u150) --[[ Line: 752 ]]
        -- upvalues: u143 (copy), u141 (copy), l__RunService__2 (ref), u113 (ref)
        if u143 then
        else
            local l__Content__33 = u150.Content;
            if l__Content__33 then
                l__Content__33 = u150.Content:FindFirstChild("TextLabel");
            end;
            if l__Content__33 then
                l__Content__33.RichText = true;
                local u151 = `{u141}kg`;
                local u152 = os.clock();
                local u153 = nil;
                u153 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 762 ]]
                    -- upvalues: u150 (copy), l__Content__33 (copy), u153 (ref), u151 (copy), u152 (copy), u113 (ref)
                    if u150.Parent and l__Content__33.Parent then
                        l__Content__33.Text = `Guild Competition Record: {u113(u151, os.clock() - u152, "rainbow")}!`;
                    else
                        if u153 then
                            u153:Disconnect();
                            u153 = nil;
                        end;
                    end;
                end);
                u150.AncestryChanged:Connect(function(_, p154) --[[ Line: 769 ]]
                    -- upvalues: u153 (ref)
                    if not p154 and u153 then
                        u153:Disconnect();
                        u153 = nil;
                    end;
                end);
            end;
        end;
    end);
end;
function u1.CreateBirdSeedDropNotification(_, u155, p156, u157) --[[ Line: 778 ]]
    -- upvalues: u6 (copy), l__UserInputService__4 (copy), l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), u113 (copy), l__Frame__17 (copy), u19 (copy), l__RunService__2 (copy)
    local v158 = u6[p156] or u6.Common;
    local l__CurrentCamera__34 = workspace.CurrentCamera;
    local v159;
    if l__CurrentCamera__34 then
        local l__ViewportSize__35 = l__CurrentCamera__34.ViewportSize;
        v159 = math.min(l__ViewportSize__35.X, l__ViewportSize__35.Y) <= 600;
    else
        v159 = l__UserInputService__4.TouchEnabled;
    end;
    local v160 = v159 and l__Notification_UI_Mobile__19 or l__Notification_UI__20;
    local v161;
    if v158.Gradient then
        v161 = `Your {u157} dropped a {u113(u155 .. " Seed", 0, v158.Gradient)}!`;
    else
        local v162 = v158.Color or Color3.new(1, 1, 1);
        v161 = `Your {u157} dropped a <font color="rgb({math.floor(v162.R * 255)},{math.floor(v162.G * 255)},{math.floor(v162.B * 255)})">{u155} Seed</font>!`;
    end;
    local u163 = v160:Clone();
    u163:SetAttribute("OG", (`__bird_seed_{u155}_{os.clock()}`));
    u163:SetAttribute("NotificationTimer", 6);
    u163.Content.TextLabel.RichText = true;
    u163.Content.TextLabel.Text = v161;
    local v164 = Instance.new("IntValue");
    v164.Name = "VAL_OBJ";
    v164.Value = 1;
    v164.Parent = u163;
    u163.ImageLabel.ImageTransparency = 1;
    u163.Content.TextLabel.TextTransparency = 1;
    u163.Content.TextLabel.TextStrokeTransparency = 1;
    u163.Parent = l__Frame__17;
    u19(u163);
    if v158.Gradient then
        local l__TextLabel__36 = u163.Content.TextLabel;
        local l__Gradient__37 = v158.Gradient;
        local u165 = os.clock();
        local u166 = nil;
        u166 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 814 ]]
            -- upvalues: u163 (copy), l__TextLabel__36 (copy), u166 (ref), u155 (copy), u165 (copy), l__Gradient__37 (copy), u157 (copy), u113 (ref)
            if u163.Parent and l__TextLabel__36.Parent then
                local v167 = l__TextLabel__36;
                local v168 = u155;
                local v169 = os.clock() - u165;
                v167.Text = `Your {u157} dropped a {u113(v168 .. " Seed", v169, l__Gradient__37)}!`;
            else
                u166:Disconnect();
            end;
        end);
        u163.AncestryChanged:Connect(function(_, p170) --[[ Line: 821 ]]
            -- upvalues: u166 (ref)
            if not p170 and u166 then
                u166:Disconnect();
                u166 = nil;
            end;
        end);
    end;
end;
function u1.CreateSeedPackClaimedNotification(_, u171, u172) --[[ Line: 830 ]]
    -- upvalues: u5 (copy), l__UserInputService__4 (copy), l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), u113 (copy), l__Frame__17 (copy), u19 (copy), l__RunService__2 (copy)
    local v173 = u5[u172];
    if v173 then
        local l__CurrentCamera__38 = workspace.CurrentCamera;
        local v174;
        if l__CurrentCamera__38 then
            local l__ViewportSize__39 = l__CurrentCamera__38.ViewportSize;
            v174 = math.min(l__ViewportSize__39.X, l__ViewportSize__39.Y) <= 600;
        else
            v174 = l__UserInputService__4.TouchEnabled;
        end;
        local v175 = v174 and l__Notification_UI_Mobile__19 or l__Notification_UI__20;
        local v176;
        if v173.Gradient then
            v176 = `{u171} found a {u113(u172, 0, v173.Gradient)}!`;
        else
            local v177 = v173.Color or Color3.new(1, 1, 1);
            v176 = `{u171} found a <font color="rgb({math.floor(v177.R * 255)},{math.floor(v177.G * 255)},{math.floor(v177.B * 255)})">{u172}</font>!`;
        end;
        local u178 = v175:Clone();
        u178:SetAttribute("OG", (`__seedpack_claimed_{u171}_{u172}_{os.clock()}`));
        u178:SetAttribute("NotificationTimer", 6);
        u178.Content.TextLabel.RichText = true;
        u178.Content.TextLabel.Text = v176;
        local v179 = Instance.new("IntValue");
        v179.Name = "VAL_OBJ";
        v179.Value = 1;
        v179.Parent = u178;
        u178.ImageLabel.ImageTransparency = 1;
        u178.Content.TextLabel.TextTransparency = 1;
        u178.Content.TextLabel.TextStrokeTransparency = 1;
        u178.Parent = l__Frame__17;
        u19(u178);
        if v173.Gradient then
            local l__TextLabel__40 = u178.Content.TextLabel;
            local l__Gradient__41 = v173.Gradient;
            local u180 = os.clock();
            local u181 = nil;
            u181 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 869 ]]
                -- upvalues: u178 (copy), l__TextLabel__40 (copy), u181 (ref), u171 (copy), u172 (copy), u180 (copy), l__Gradient__41 (copy), u113 (ref)
                if u178.Parent and l__TextLabel__40.Parent then
                    l__TextLabel__40.Text = `{u171} found a {u113(u172, os.clock() - u180, l__Gradient__41)}!`;
                else
                    u181:Disconnect();
                end;
            end);
            u178.AncestryChanged:Connect(function(_, p182) --[[ Line: 876 ]]
                -- upvalues: u181 (ref)
                if not p182 and u181 then
                    u181:Disconnect();
                    u181 = nil;
                end;
            end);
        end;
    end;
end;
function u1.Init(_) --[[ Line: 885 ]] end;
function u1.Start(u183) --[[ Line: 888 ]]
    -- upvalues: l__Frame__17 (copy), u23 (copy), u8 (copy), l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), u43 (copy), u19 (copy), l__Networking__10 (copy), u93 (copy), l__UserInputService__4 (copy), l__Players__1 (copy), u99 (copy)
    task.spawn(function() --[[ Line: 889 ]]
        -- upvalues: l__Frame__17 (ref), u23 (ref), u8 (ref), l__Notification_UI_Mobile__19 (ref), l__Notification_UI__20 (ref), u43 (ref), u19 (ref)
        while true do
            for _, v184 in l__Frame__17:GetChildren() do
                if v184:IsA("Frame") and (v184.Name == "Notification_UI" or v184.Name == "Notification_UI_Mobile") then
                    local v185 = v184:GetAttribute("NotificationTimer");
                    if v185 and type(v185) == "number" then
                        local v186 = v185 - 1;
                        if v186 <= 0 then
                            v184:SetAttribute("NotificationTimer", nil);
                            local v187 = v184:GetAttribute("CondenseKey");
                            u23(v184);
                            if v187 then
                                local v188 = u8[v187] or {};
                                if #v188 >= 1 then
                                    local v189 = v188[1];
                                    table.remove(v188, 1);
                                    local u190 = u43(v189.IsMobile and l__Notification_UI_Mobile__19 or l__Notification_UI__20, v189.Text, v189.Duration);
                                    u190:SetAttribute("CondenseKey", v187);
                                    task.spawn(function() --[[ Line: 914 ]]
                                        -- upvalues: u19 (ref), u190 (copy)
                                        task.wait(0.4);
                                        u19(u190);
                                    end);
                                end;
                            end;
                        else
                            v184:SetAttribute("NotificationTimer", v186);
                        end;
                    end;
                end;
            end;
            task.wait(1);
        end;
    end);
    l__Networking__10.Notification.OnClientEvent:Connect(function(...) --[[ Line: 931 ]]
        -- upvalues: u93 (ref), l__UserInputService__4 (ref)
        local v191 = u93;
        local l__CurrentCamera__42 = workspace.CurrentCamera;
        local v192;
        if l__CurrentCamera__42 then
            local l__ViewportSize__43 = l__CurrentCamera__42.ViewportSize;
            v192 = math.min(l__ViewportSize__43.X, l__ViewportSize__43.Y) <= 600;
        else
            v192 = l__UserInputService__4.TouchEnabled;
        end;
        v191(v192, ...);
    end);
    game.ReplicatedStorage.Notify.Event:Connect(function(...) --[[ Line: 934 ]]
        -- upvalues: u93 (ref), l__UserInputService__4 (ref)
        local v193 = u93;
        local l__CurrentCamera__44 = workspace.CurrentCamera;
        local v194;
        if l__CurrentCamera__44 then
            local l__ViewportSize__45 = l__CurrentCamera__44.ViewportSize;
            v194 = math.min(l__ViewportSize__45.X, l__ViewportSize__45.Y) <= 600;
        else
            v194 = l__UserInputService__4.TouchEnabled;
        end;
        v193(v194, ...);
    end);
    l__Networking__10.HelperRequest.OnClientEvent:Connect(function(p195) --[[ Line: 938 ]]
        -- upvalues: l__Players__1 (ref), u99 (ref)
        if type(p195) == "number" then
            local v196 = l__Players__1:GetPlayerByUserId(p195);
            if v196 then
                u99(v196);
            end;
        end;
    end);
    l__Networking__10.SeedPackSpawn.Claimed.OnClientEvent:Connect(function(p197, p198) --[[ Line: 950 ]]
        -- upvalues: u183 (copy)
        if type(p197) == "string" and type(p198) == "string" then
            u183:CreateSeedPackClaimedNotification(p197, p198);
        end;
    end);
    l__Networking__10.Bird.SeedDropped.OnClientEvent:Connect(function(p199, p200, p201) --[[ Line: 955 ]]
        -- upvalues: u183 (copy)
        if type(p199) == "string" and type(p200) == "string" then
            u183:CreateBirdSeedDropNotification(p199, p200, (type(p201) ~= "string" or p201 == "") and "bird" or p201);
        end;
    end);
end;
function u1.CreateNotification(_, p202, p203, p204) --[[ Line: 961 ]]
    -- upvalues: l__UserInputService__4 (copy), u93 (copy)
    local l__CurrentCamera__46 = workspace.CurrentCamera;
    local v205;
    if l__CurrentCamera__46 then
        local l__ViewportSize__47 = l__CurrentCamera__46.ViewportSize;
        v205 = math.min(l__ViewportSize__47.X, l__ViewportSize__47.Y) <= 600;
    else
        v205 = l__UserInputService__4.TouchEnabled;
    end;
    u93(v205, p202, p203, p204);
end;
function u1.CreateStickyNotification(_, p206) --[[ Line: 976 ]]
    -- upvalues: l__UserInputService__4 (copy), l__Notification_UI_Mobile__19 (copy), l__Notification_UI__20 (copy), l__Frame__17 (copy), u19 (copy), u23 (copy)
    local l__CurrentCamera__48 = workspace.CurrentCamera;
    local v207;
    if l__CurrentCamera__48 then
        local l__ViewportSize__49 = l__CurrentCamera__48.ViewportSize;
        v207 = math.min(l__ViewportSize__49.X, l__ViewportSize__49.Y) <= 600;
    else
        v207 = l__UserInputService__4.TouchEnabled;
    end;
    local u208 = (v207 and l__Notification_UI_Mobile__19 or l__Notification_UI__20):Clone();
    u208:SetAttribute("NotificationTimer", nil);
    u208.Content.TextLabel.RichText = true;
    u208.Content.TextLabel.Text = p206;
    u208:SetAttribute("OG", "__sticky__");
    u208.ImageLabel.ImageTransparency = 1;
    u208.Content.TextLabel.TextTransparency = 1;
    u208.Content.TextLabel.TextStrokeTransparency = 1;
    u208.Parent = l__Frame__17;
    u19(u208);
    local v209 = {};
    local u210 = false;
    function v209.SetText(_, p211) --[[ Line: 1001 ]]
        -- upvalues: u210 (ref), u208 (copy)
        if u210 or not u208.Parent then
        else
            u208.Content.TextLabel.RichText = true;
            u208.Content.TextLabel.Text = p211;
        end;
    end;
    function v209.Dismiss(_) --[[ Line: 1007 ]]
        -- upvalues: u210 (ref), u208 (copy), u23 (ref)
        if u210 then
        else
            u210 = true;
            if u208.Parent then
                u23(u208);
            end;
        end;
    end;
    return v209;
end;
return u1;