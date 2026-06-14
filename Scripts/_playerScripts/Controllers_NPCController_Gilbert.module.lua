-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__TweenService__3 = game:GetService("TweenService");
local l__TopText__4 = require(l__ReplicatedStorage__2.ClientModules.TopText);
local l__NPC__5 = require(l__ReplicatedStorage__2.ClientModules.NPC);
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
l__LocalPlayer__6:WaitForChild("PlayerGui");
local l__GuiController__7 = require(l__LocalPlayer__6.PlayerScripts.Controllers.GuiController);
local l__NotificationController__8 = require(l__LocalPlayer__6.PlayerScripts.Controllers.NotificationController);
local l__ViewGuildProgressController__9 = require(l__LocalPlayer__6.PlayerScripts.Controllers.ViewGuildProgressController);
local u1 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local u2 = {
    "View Guild",
    "View Leaderboard",
    "View Rewards",
    "Nevermind"
};
local u3 = {
    "Create Guild",
    "View Leaderboard",
    "View Rewards",
    "What are guilds?",
    "Nevermind"
};
local u4 = { "What can I do for you, member?", "Welcome back. How\'s the guild?" };
local u5 = { "Looking to start a guild?", "Need help with guilds?" };
local u6 = false;
local u7 = nil;
local function u11(p8, p9) --[[ Line: 60 ]]
    -- upvalues: l__TweenService__3 (copy), u1 (copy)
    local v10 = p8:FindFirstChild("DialogueHighlight");
    if not v10 then
        v10 = Instance.new("Highlight");
        v10.Name = "DialogueHighlight";
        v10.DepthMode = Enum.HighlightDepthMode.Occluded;
        v10.FillTransparency = 1;
        v10.OutlineTransparency = 1;
        v10.Adornee = p8;
        v10.Parent = p8;
    end;
    assert(v10);
    l__TweenService__3:Create(v10, u1, {
        OutlineTransparency = p9
    }):Play();
end;
local function u36(p12, p13) --[[ Line: 81 ]]
    -- upvalues: l__TopText__4 (copy), u6 (ref)
    -- block 33
    local v14 = l__TopText__4.ShowChoices(p12, p13);
    if #v14 == 0 then
        return nil, nil;
    end;
    local v15 = {};
    local u16 = nil;
    for u17, v18 in v14 do
        local v19 = v18:FindFirstChild("Frame");
        if v19 then
            local v20 = v19:FindFirstChild("ImageButton");
            if v20 and v20:IsA("GuiButton") then
                table.insert(v15, v20.MouseButton1Click:Connect(function() --[[ Line: 104 ]]
                    -- upvalues: u16 (ref), u17 (copy)
                    u16 = u17;
                end));
            end;
        end;
    end;
    local v22 = l__TopText__4.ConnectChoiceKeyboard(v14, function(p21) --[[ Line: 110 ]]
        -- upvalues: u16 (ref)
        if u16 == nil then
            u16 = p21;
        end;
    end);
    while true do
        if u16 ~= nil then
            for _, v23 in v15 do
                v23:Disconnect();
            end;
            v22();
            l__TopText__4.RemovePlayerSideFrame(p12);
            local v24 = p13[u16];
            if p12.Character then
                l__TopText__4.PlayerResponse(p12.Character, v24, true);
            end;
            return u16, v24;
        end;
        if not u6 then
            for _, v25 in v15 do
                v25:Disconnect();
            end;
            v22();
            l__TopText__4.RemovePlayerSideFrame(p12);
            return nil, nil;
        end;
        local v26, v27, v28;
        v26, v27, v28 = v14, nil, nil;
        local v29, v30;
        if type(v26) == "function" then
            v29, v30 = v26(v27, v28);
        else
            v29, v30 = next(v26, v28);
        end;
        v28 = v29;
        local v31 = false;
        if not v31 then
            for _, v35 in v15 do
                v35:Disconnect();
            end;
            v22();
            return nil, nil;
        end;
        task.wait(0.05);
        if not v31 then
            for _, v35 in v15 do
                v35:Disconnect();
            end;
            v22();
            return nil, nil;
        end;
        task.wait(0.05);
        v31 = false;
        if not v31 then
            for _, v35 in v15 do
                v35:Disconnect();
            end;
            v22();
            return nil, nil;
        end;
        task.wait(0.05);
        if not v31 then
            for _, v35 in v15 do
                v35:Disconnect();
            end;
            v22();
            return nil, nil;
        end;
        task.wait(0.05);
    end;
end;
local function u37() --[[ Line: 149 ]]
    -- upvalues: l__LocalPlayer__6 (copy), l__NotificationController__8 (copy), l__GuiController__7 (copy)
    if l__LocalPlayer__6:GetAttribute("GuildId") ~= nil then
        l__NotificationController__8:CreateNotification("You\'re already in a guild!");
    else
        if not l__GuiController__7:IsOpen("CreateGuild") then
            l__GuiController__7:Open("CreateGuild", nil, { "HUD" });
        end;
    end;
end;
local function u38() --[[ Line: 159 ]]
    -- upvalues: l__LocalPlayer__6 (copy), l__NotificationController__8 (copy), l__GuiController__7 (copy)
    if l__LocalPlayer__6:GetAttribute("GuildId") ~= nil then
        if not l__GuiController__7:IsOpen("ViewGuildPage") then
            l__GuiController__7:Open("ViewGuildPage", nil, { "HUD" });
        end;
    else
        l__NotificationController__8:CreateNotification("You aren\'t in a guild");
    end;
end;
local function u39() --[[ Line: 175 ]]
    -- upvalues: l__GuiController__7 (copy), l__ViewGuildProgressController__9 (copy)
    if not l__GuiController__7:IsOpen("ViewGuildProgress") then
        l__ViewGuildProgressController__9:SetNoReturn();
        l__GuiController__7:Open("ViewGuildProgress", nil, { "HUD" });
    end;
end;
local function u41(p40) --[[ Line: 194 ]]
    -- upvalues: l__TopText__4 (copy), u6 (ref)
    l__TopText__4.NpcText(p40, "You must be invited to join!", true);
    task.wait(2.5);
    if u6 then
        l__TopText__4.NpcText(p40, "Get weekly exclusive prizes!", true);
        task.wait(2.5);
        if u6 then
            l__TopText__4.NpcText(p40, "Compete globally!", true);
            task.wait(2.5);
        end;
    end;
end;
local function u44(p42, p43) --[[ Line: 206 ]]
    -- upvalues: u6 (ref), l__TopText__4 (copy), l__LocalPlayer__6 (copy), l__NPC__5 (copy), u11 (copy)
    u6 = false;
    l__TopText__4.TakeAwayResponses(p42, l__LocalPlayer__6);
    l__TopText__4.RemovePlayerSideFrame(l__LocalPlayer__6);
    l__NPC__5.EndSpeaking(l__LocalPlayer__6);
    u11(p42, 1);
    task.wait(0.4);
    if p43.Parent then
        p43.Enabled = true;
    end;
end;
local function u57(u45, u46, p47) --[[ Line: 218 ]]
    -- upvalues: u6 (ref), l__NPC__5 (copy), l__LocalPlayer__6 (copy), u11 (copy), u7 (ref), l__TopText__4 (copy), u4 (copy), u5 (copy), u2 (copy), u3 (copy), u36 (copy), u37 (copy), l__GuiController__7 (copy), u38 (copy), u39 (copy), u41 (copy), u44 (copy)
    if u6 then
        return;
    end;
    if not l__NPC__5.CanSpeak(l__LocalPlayer__6) then
        return;
    end;
    u6 = true;
    l__NPC__5.StartSpeaking(l__LocalPlayer__6);
    p47.Enabled = false;
    u11(u45, 1);
    if u7 then
        u7:Play(0.1, 100, 1);
    end;
    local v48 = task.spawn(function() --[[ Line: 234 ]]
        -- upvalues: u6 (ref), l__LocalPlayer__6 (ref), u46 (copy), l__TopText__4 (ref), u45 (copy)
        while u6 do
            task.wait(0.25);
            local l__Character__10 = l__LocalPlayer__6.Character;
            if l__Character__10 then
                l__Character__10 = l__Character__10:FindFirstChild("HumanoidRootPart");
            end;
            if l__Character__10 and (l__Character__10:IsA("BasePart") and (l__Character__10.Position - u46.Position).Magnitude > 10) then
                l__TopText__4.NpcText(u45, "...", true);
                u6 = false;
                l__TopText__4.RemovePlayerSideFrame(l__LocalPlayer__6);
                return;
            end;
        end;
    end);
    local u49 = false;
    local v50 = l__LocalPlayer__6:GetAttributeChangedSignal("GuildId"):Connect(function() --[[ Line: 256 ]]
        -- upvalues: u49 (ref), u6 (ref), l__TopText__4 (ref), l__LocalPlayer__6 (ref)
        u49 = true;
        u6 = false;
        l__TopText__4.RemovePlayerSideFrame(l__LocalPlayer__6);
    end);
    local v51;
    if l__LocalPlayer__6:GetAttribute("GuildId") ~= nil then
        local v52 = u4;
        v51 = v52[math.random(1, #v52)];
    else
        local v53 = u5;
        v51 = v53[math.random(1, #v53)];
    end;
    l__TopText__4.NpcText(u45, v51, true);
    task.wait(0.4);
    local v54 = u49;
    while u6 do
        local v55;
        if l__LocalPlayer__6:GetAttribute("GuildId") ~= nil then
            v55 = u2;
        else
            v55 = u3;
        end;
        local _, v56 = u36(l__LocalPlayer__6, v55);
        if v54 or not v56 then
            break;
        end;
        if v56 == "Create Guild" then
            u37();
            break;
        end;
        if v56 == "View Guild Shop!" then
            l__GuiController__7:Open("GuildShop");
            break;
        end;
        if v56 == "View Guild" then
            u38();
            break;
        end;
        if v56 == "View Leaderboard" then
            if not l__GuiController__7:IsOpen("ViewGuildLeaderboard") then
                l__GuiController__7:Open("ViewGuildLeaderboard", nil, { "HUD" });
            end;
            break;
        end;
        if v56 == "View Rewards" then
            u39();
            break;
        end;
        if v56 ~= "What are guilds?" then
            if v56 == "Nevermind" then
                task.wait(0.5);
            end;
            break;
        end;
        u41(u45);
    end;
    v50:Disconnect();
    if coroutine.status(v48) ~= "dead" then
        task.cancel(v48);
    end;
    u44(u45, p47);
end;
return function() --[[ Line: 324 ]]
    -- upvalues: u7 (ref), u11 (copy), u6 (ref), l__LocalPlayer__6 (copy), u57 (copy)
    task.spawn(function() --[[ Line: 325 ]]
        -- upvalues: u7 (ref), u11 (ref), u6 (ref), l__LocalPlayer__6 (ref), u57 (ref)
        local l__NPCS__11 = workspace:WaitForChild("NPCS", 30);
        if l__NPCS__11 then
            local l__Gilbert__12 = l__NPCS__11:WaitForChild("Gilbert", 30);
            if l__Gilbert__12 and l__Gilbert__12:IsA("Model") then
                local l__HumanoidRootPart__13 = l__Gilbert__12:WaitForChild("HumanoidRootPart", 10);
                if l__HumanoidRootPart__13 and l__HumanoidRootPart__13:IsA("BasePart") then
                    local l__ProximityPrompt__14 = l__HumanoidRootPart__13:WaitForChild("ProximityPrompt", 10);
                    if l__ProximityPrompt__14 and l__ProximityPrompt__14:IsA("ProximityPrompt") then
                        local l__Humanoid__15 = l__Gilbert__12:WaitForChild("Humanoid", 10);
                        local l__Animations__16 = l__Gilbert__12:WaitForChild("Animations", 10);
                        if l__Humanoid__15 and (l__Humanoid__15:IsA("Humanoid") and l__Animations__16) then
                            local l__Animator__17 = l__Humanoid__15:WaitForChild("Animator", 10);
                            local v58 = l__Animations__16:FindFirstChild("Interact");
                            if l__Animator__17 and (l__Animator__17:IsA("Animator") and (v58 and v58:IsA("Animation"))) then
                                u7 = l__Animator__17:LoadAnimation(v58);
                            end;
                        end;
                        l__ProximityPrompt__14.PromptShown:Connect(function() --[[ Line: 354 ]]
                            -- upvalues: u11 (ref), l__Gilbert__12 (copy)
                            u11(l__Gilbert__12, 0);
                        end);
                        l__ProximityPrompt__14.PromptHidden:Connect(function() --[[ Line: 357 ]]
                            -- upvalues: u6 (ref), u11 (ref), l__Gilbert__12 (copy)
                            if not u6 then
                                u11(l__Gilbert__12, 1);
                            end;
                        end);
                        l__ProximityPrompt__14.Triggered:Connect(function(p59) --[[ Line: 362 ]]
                            -- upvalues: l__LocalPlayer__6 (ref), u57 (ref), l__Gilbert__12 (copy), l__HumanoidRootPart__13 (copy), l__ProximityPrompt__14 (copy)
                            if p59 == l__LocalPlayer__6 then
                                task.spawn(u57, l__Gilbert__12, l__HumanoidRootPart__13, l__ProximityPrompt__14);
                            end;
                        end);
                    end;
                end;
            end;
        end;
    end);
end;