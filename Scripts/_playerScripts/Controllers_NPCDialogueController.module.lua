-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
game:GetService("Debris");
local l__TopText__2 = require(game.ReplicatedStorage.ClientModules.TopText);
local l__NPC__3 = require(game.ReplicatedStorage.ClientModules.NPC);
local _ = game.Players.LocalPlayer;
local u1 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local u2 = {};
local function u7(u3, p4) --[[ Line: 19 ]]
    -- upvalues: u2 (copy), l__TweenService__1 (copy), u1 (copy)
    local v5 = u2[u3];
    if v5 then
        v5:Cancel();
        v5:Destroy();
        u2[u3] = nil;
    end;
    local u6 = l__TweenService__1:Create(u3, u1, {
        OutlineTransparency = p4
    });
    u2[u3] = u6;
    u6.Completed:Once(function() --[[ Line: 28 ]]
        -- upvalues: u2 (ref), u3 (copy), u6 (copy)
        if u2[u3] == u6 then
            u2[u3] = nil;
        end;
        u6:Destroy();
    end);
    u6:Play();
end;
local v8 = {};
local u9 = false;
function v8.DoDialogue(_, u10) --[[ Line: 87 ]]
    -- upvalues: l__TopText__2 (copy), u9 (ref), l__NPC__3 (copy), u7 (copy)
    local l__ProximityPrompt__4 = u10.ProximityPrompt;
    local l__SpeakingNPC__5 = u10.SpeakingNPC;
    local l__PromptList__6 = u10.PromptList;
    local l__OperationMap__7 = u10.OperationMap;
    local l__IntroLines__8 = u10.IntroLines;
    local l__LocalPlayer__9 = game.Players.LocalPlayer;
    local u11 = u10.RootPart or (l__SpeakingNPC__5:FindFirstChild("HumanoidRootPart") or l__SpeakingNPC__5);
    local u12 = l__SpeakingNPC__5:FindFirstChild("DialogueHighlight");
    if not u12 then
        u12 = Instance.new("Highlight");
        if u12 and u12:IsA("Highlight") then
            u12.Name = "DialogueHighlight";
            u12.DepthMode = Enum.HighlightDepthMode.Occluded;
            u12.FillTransparency = 1;
            u12.OutlineTransparency = 1;
            u12.Adornee = l__SpeakingNPC__5;
            u12.Parent = l__SpeakingNPC__5;
        end;
    end;
    local u13 = false;
    local u14 = false;
    local u15 = nil;
    local u16 = {};
    local function u21(p17) --[[ Line: 133 ]]
        -- upvalues: l__TopText__2 (ref), l__SpeakingNPC__5 (copy), l__LocalPlayer__9 (copy), u13 (ref), u15 (ref), u16 (copy), u14 (ref), u9 (ref), l__ProximityPrompt__4 (copy), l__NPC__3 (ref)
        l__TopText__2.TakeAwayResponses(l__SpeakingNPC__5, l__LocalPlayer__9);
        l__TopText__2.RemovePlayerSideFrame(l__LocalPlayer__9);
        if u13 then
            if u15 then
                task.cancel(u15);
            end;
            for _, v18 in u16 do
                v18:Disconnect();
            end;
            table.clear(u16);
            l__TopText__2.TakeAwayResponses(l__SpeakingNPC__5, l__LocalPlayer__9);
            l__TopText__2.RemovePlayerSideFrame(l__LocalPlayer__9);
            if p17.OnDialogueEnded then
                p17.OnDialogueEnded();
            end;
            u14 = false;
            u13 = false;
            if l__SpeakingNPC__5.Parent then
                l__SpeakingNPC__5:SetAttribute("ConversationStarted", false);
            end;
            u9 = false;
            task.defer(function() --[[ Line: 168 ]]
                -- upvalues: l__TopText__2 (ref), l__SpeakingNPC__5 (ref), l__LocalPlayer__9 (ref)
                l__TopText__2.TakeAwayResponses(l__SpeakingNPC__5, l__LocalPlayer__9);
                l__TopText__2.RemovePlayerSideFrame(l__LocalPlayer__9);
            end);
            task.wait(0.5);
            if l__ProximityPrompt__4.Parent then
                local v19 = l__ProximityPrompt__4;
                local v20;
                if l__SpeakingNPC__5.Parent then
                    v20 = not l__SpeakingNPC__5:GetAttribute("DisableDialogue");
                else
                    v20 = false;
                end;
                v19.Enabled = v20;
            end;
            l__NPC__3.EndSpeaking(l__LocalPlayer__9);
        end;
    end;
    local function u39(p22) --[[ Line: 180 ]]
        -- upvalues: u9 (ref), u13 (ref), l__SpeakingNPC__5 (copy), l__NPC__3 (ref), l__LocalPlayer__9 (copy), u14 (ref), l__ProximityPrompt__4 (copy), l__IntroLines__8 (copy), l__TopText__2 (ref), u21 (copy), l__PromptList__6 (copy), u16 (copy), l__OperationMap__7 (copy), u15 (ref)
        if u9 then
        elseif u13 then
        else
            local v23;
            if l__SpeakingNPC__5.Parent then
                v23 = not l__SpeakingNPC__5:GetAttribute("DisableDialogue");
            else
                v23 = false;
            end;
            if v23 then
                u13 = true;
                l__SpeakingNPC__5:SetAttribute("ConversationStarted", true);
                u9 = true;
                l__NPC__3.StartSpeaking(l__LocalPlayer__9);
                u14 = false;
                l__ProximityPrompt__4.Enabled = false;
                if p22.OnDialogueStarted then
                    p22.OnDialogueStarted();
                end;
                if l__IntroLines__8 then
                    if p22.RandomIntroLine then
                        local v24 = Random.new();
                        l__TopText__2.NpcText(l__SpeakingNPC__5, l__IntroLines__8[v24:NextInteger(1, #l__IntroLines__8)], true);
                        task.wait(0.5);
                    else
                        for _, v25 in l__IntroLines__8 do
                            l__TopText__2.NpcText(l__SpeakingNPC__5, v25, true);
                            task.wait(0.5);
                        end;
                    end;
                end;
                if u13 and not u14 then
                    if #l__PromptList__6 > 0 then
                        local u26 = l__TopText__2.ShowChoices(l__LocalPlayer__9, l__PromptList__6);
                        local u27 = "";
                        if not u13 or u14 then
                            l__TopText__2.TakeAwayResponses(l__SpeakingNPC__5, l__LocalPlayer__9);
                            l__TopText__2.RemovePlayerSideFrame(l__LocalPlayer__9);
                            return;
                        end;
                        table.clear(u16);
                        for _, v28 in u26 do
                            local u29 = v28:FindFirstChild("Frame");
                            if u29 then
                                local v30 = u29:FindFirstChild("ImageButton");
                                if v30 then
                                    table.insert(u16, v30.MouseButton1Click:Connect(function() --[[ Line: 243 ]]
                                        -- upvalues: u27 (ref), u29 (copy)
                                        u27 = u29.Frame.Text_Element:GetAttribute("Text");
                                    end));
                                end;
                            end;
                        end;
                        local v34 = l__TopText__2.ConnectChoiceKeyboard(u26, function(p31) --[[ Line: 252 ]]
                            -- upvalues: u27 (ref), u26 (copy)
                            if u27 == "" then
                                local v32 = u26[p31];
                                if v32 then
                                    v32 = v32:FindFirstChild("Frame");
                                end;
                                if v32 then
                                    local v33 = v32.Frame:FindFirstChild("Text_Element");
                                    if v33 then
                                        u27 = v33:GetAttribute("Text") or "";
                                    end;
                                end;
                            end;
                        end);
                        if not u13 or u14 then
                            for _, v35 in u16 do
                                v35:Disconnect();
                            end;
                            table.clear(u16);
                            v34();
                            l__TopText__2.TakeAwayResponses(l__SpeakingNPC__5, l__LocalPlayer__9);
                            l__TopText__2.RemovePlayerSideFrame(l__LocalPlayer__9);
                            return;
                        end;
                        while u27 == "" do
                            task.wait();
                            if u14 or not u13 then
                                for _, v36 in u16 do
                                    v36:Disconnect();
                                end;
                                table.clear(u16);
                                v34();
                                l__TopText__2.TakeAwayResponses(l__SpeakingNPC__5, l__LocalPlayer__9);
                                l__TopText__2.RemovePlayerSideFrame(l__LocalPlayer__9);
                                return;
                            end;
                        end;
                        for _, v37 in u16 do
                            v37:Disconnect();
                        end;
                        v34();
                        l__TopText__2.RemovePlayerSideFrame(l__LocalPlayer__9);
                        if l__LocalPlayer__9.Character then
                            l__TopText__2.PlayerResponse(l__LocalPlayer__9.Character, u27, true);
                            local v38 = l__OperationMap__7[u27];
                            if v38 then
                                u15 = task.spawn(v38);
                                repeat
                                    task.wait();
                                until coroutine.status(u15) == "dead";
                            end;
                        end;
                    end;
                    u21(p22);
                else
                    u21(p22);
                end;
            end;
        end;
    end;
    local u40 = l__ProximityPrompt__4.Triggered:Connect(function(_) --[[ Line: 303 ]]
        -- upvalues: u39 (copy), u10 (copy)
        u39(u10);
    end);
    local u41 = l__ProximityPrompt__4.MaxActivationDistance + 1;
    local u42 = l__SpeakingNPC__5.Destroying:Connect(function() --[[ Line: 310 ]]
        -- upvalues: u13 (ref), u14 (ref), u21 (copy), u10 (copy)
        if u13 then
            u14 = true;
            u21(u10);
        end;
    end);
    local u47 = task.spawn(function() --[[ Line: 318 ]]
        -- upvalues: l__SpeakingNPC__5 (copy), u13 (ref), u21 (copy), u10 (copy), l__LocalPlayer__9 (copy), u11 (copy), u41 (copy), l__TopText__2 (ref), u42 (ref)
        local v43 = false;
        while l__SpeakingNPC__5.Parent do
            task.wait(0.1);
            if not v43 and u13 then
                local v44;
                if l__SpeakingNPC__5.Parent then
                    v44 = not l__SpeakingNPC__5:GetAttribute("DisableDialogue");
                else
                    v44 = false;
                end;
                if v44 then
                    if l__SpeakingNPC__5:IsDescendantOf(workspace) then
                        if l__LocalPlayer__9.Character and l__LocalPlayer__9.Character.PrimaryPart then
                            local v45 = nil;
                            if u11 and u11.Parent then
                                if u11:IsA("BasePart") then
                                    v45 = u11.Position;
                                elseif u11:IsA("Attachment") then
                                    v45 = u11.WorldPosition;
                                elseif u11:IsA("Model") then
                                    v45 = u11:GetPivot().Position;
                                end;
                            end;
                            if v45 and (l__LocalPlayer__9.Character.PrimaryPart.Position - v45).Magnitude >= u41 then
                                if u10.ExitLine then
                                    if u10.RandomExitLine and typeof(u10.ExitLine) == "table" then
                                        local v46 = Random.new();
                                        l__TopText__2.NpcText(l__SpeakingNPC__5, u10.ExitLine[v46:NextInteger(1, #u10.ExitLine)], true);
                                        v43 = false;
                                    else
                                        l__TopText__2.NpcText(l__SpeakingNPC__5, u10.ExitLine, true);
                                        v43 = false;
                                    end;
                                end;
                                u21(u10);
                            end;
                        end;
                    else
                        u21(u10);
                    end;
                else
                    u21(u10);
                end;
            end;
        end;
        if u42 then
            u42:Disconnect();
        end;
    end);
    local u49 = l__ProximityPrompt__4.PromptShown:Connect(function() --[[ Line: 374 ]]
        -- upvalues: l__SpeakingNPC__5 (copy), u12 (ref), u7 (ref)
        local v48;
        if l__SpeakingNPC__5.Parent then
            v48 = not l__SpeakingNPC__5:GetAttribute("DisableDialogue");
        else
            v48 = false;
        end;
        if v48 then
            assert(u12:IsA("Highlight"));
            u7(u12, 0);
        end;
    end);
    local u50 = l__ProximityPrompt__4.PromptHidden:Connect(function() --[[ Line: 380 ]]
        -- upvalues: u12 (ref), u7 (ref)
        assert(u12:IsA("Highlight"));
        u7(u12, 1);
    end);
    return {
        End = function(_) --[[ Name: End, Line 387 ]]
            -- upvalues: u13 (ref), u14 (ref), u21 (copy), u10 (copy)
            if u13 then
                u14 = true;
                u21(u10);
            end;
        end,
        Destroy = function(_) --[[ Name: Destroy, Line 395 ]]
            -- upvalues: u13 (ref), u14 (ref), u21 (copy), u10 (copy), u42 (ref), u47 (ref), u49 (ref), u50 (ref), u40 (ref)
            if u13 then
                u14 = true;
                u21(u10);
            end;
            if u42 then
                u42:Disconnect();
                u42 = nil;
            end;
            if u47 then
                task.cancel(u47);
                u47 = nil;
            end;
            if u49 then
                u49:Disconnect();
                u49 = nil;
            end;
            if u50 then
                u50:Disconnect();
                u50 = nil;
            end;
            if u40 then
                u40:Disconnect();
                u40 = nil;
            end;
        end,
        IsActive = function(_) --[[ Name: IsActive, Line 424 ]]
            -- upvalues: u13 (ref)
            return u13;
        end
    };
end;
return v8;