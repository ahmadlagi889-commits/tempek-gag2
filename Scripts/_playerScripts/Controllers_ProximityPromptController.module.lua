-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 2
};
local l__UserInputService__1 = game:GetService("UserInputService");
local l__ProximityPromptService__2 = game:GetService("ProximityPromptService");
local l__TweenService__3 = game:GetService("TweenService");
local l__TextService__4 = game:GetService("TextService");
local l__PlayerGui__5 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local u2 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
};
local u3 = {
    ["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
    [","] = "rbxasset://textures/ui/Controls/comma.png",
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
    ["."] = "rbxasset://textures/ui/Controls/period.png",
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
};
local u4 = {
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.RightControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.RightAlt] = "Alt",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12"
};
local u5 = nil;
function v1.Init(_) --[[ Line: 50 ]]
    -- upvalues: u5 (ref)
    u5 = game:GetService("ReplicatedStorage"):FindFirstChild("ProximityPromptTemplates");
end;
function v1.Start(u6) --[[ Line: 56 ]]
    -- upvalues: l__ProximityPromptService__2 (copy)
    l__ProximityPromptService__2.PromptShown:Connect(function(p7, p8) --[[ Line: 58 ]]
        -- upvalues: u6 (copy)
        if p7:GetAttribute("DontShow") == nil then
            if p7.Style == Enum.ProximityPromptStyle.Default then
                return;
            end;
            local v9 = u6:CreatePrompt(p7, p8, (u6:GetScreenGui()));
            p7.PromptHidden:Wait();
            v9();
        end;
    end);
end;
function v1.GetScreenGui(_) --[[ Line: 73 ]]
    -- upvalues: l__PlayerGui__5 (copy)
    local v10 = l__PlayerGui__5:FindFirstChild("ProximityPrompts");
    if v10 == nil then
        v10 = Instance.new("ScreenGui");
        v10.Name = "ProximityPrompts";
        v10.ResetOnSpawn = false;
        v10.Parent = l__PlayerGui__5;
    end;
    return v10;
end;
function v1.SetUpCircularProgressBar(_, p11) --[[ Line: 86 ]]
    local l__UIGradient__6 = p11.LeftGradient.ProgressBarImage.UIGradient;
    local l__UIGradient__7 = p11.RightGradient.ProgressBarImage.UIGradient;
    p11.Progress.Changed:Connect(function(p12) --[[ Line: 91 ]]
        -- upvalues: l__UIGradient__6 (copy), l__UIGradient__7 (copy)
        local v13 = math.clamp(p12 * 360, 0, 360);
        l__UIGradient__6.Rotation = math.clamp(v13, 180, 360);
        l__UIGradient__7.Rotation = math.clamp(v13, 0, 180);
    end);
end;
function v1.CreatePrompt(p14, u15, p16, p17) --[[ Line: 98 ]]
    -- upvalues: u5 (ref), l__TweenService__3 (copy), l__UserInputService__1 (copy), u2 (copy), u3 (copy), u4 (copy), l__TextService__4 (copy)
    local u18 = {};
    local u19 = {};
    local u20 = {};
    local u21 = {};
    local v22 = TweenInfo.new(u15.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u23 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local u24 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local v25 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u26 = nil;
    local v27 = u15:GetAttribute("Theme");
    if v27 and u5 then
        local v28 = u5:FindFirstChild(v27);
        if v28 then
            u26 = v28:Clone();
        end;
    end;
    if u26 == nil and u5 then
        local v29 = u5:FindFirstChild("Default");
        if v29 then
            u26 = v29:Clone();
        end;
    end;
    if u26 == nil then
        return function() --[[ Line: 127 ]] end;
    end;
    u26.Enabled = true;
    local l__PromptFrame__8 = u26.PromptFrame;
    local l__InputFrame__9 = l__PromptFrame__8.InputFrame;
    local l__ActionText__10 = l__PromptFrame__8.ActionText;
    local l__ObjectText__11 = l__PromptFrame__8.ObjectText;
    local l__BackgroundTransparency__12 = l__PromptFrame__8.BackgroundTransparency;
    local l__ImageTransparency__13 = l__PromptFrame__8.ImageTransparency;
    l__PromptFrame__8.BackgroundTransparency = 1;
    l__PromptFrame__8.ImageTransparency = 1;
    local v30 = l__TweenService__3;
    local v31 = {
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = UDim2.fromScale(0.5, 1)
    };
    table.insert(u18, v30:Create(l__PromptFrame__8, u23, v31));
    local v32 = l__TweenService__3;
    local v33 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = l__BackgroundTransparency__12,
        ImageTransparency = l__ImageTransparency__13
    };
    table.insert(u19, v32:Create(l__PromptFrame__8, u23, v33));
    local v34 = l__TweenService__3;
    local v35 = {
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = UDim2.fromScale(0.5, 1)
    };
    table.insert(u20, v34:Create(l__PromptFrame__8, u23, v35));
    local v36 = l__TweenService__3;
    local v37 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = l__BackgroundTransparency__12,
        ImageTransparency = l__ImageTransparency__13
    };
    table.insert(u21, v36:Create(l__PromptFrame__8, u23, v37));
    local function u39(p38) --[[ Line: 148 ]]
        -- upvalues: u18 (copy), l__TweenService__3 (ref), u23 (copy), u19 (copy), u20 (copy), u21 (copy)
        local l__Transparency__14 = p38.Transparency;
        p38.Transparency = 1;
        table.insert(u18, l__TweenService__3:Create(p38, u23, {
            Transparency = 1
        }));
        table.insert(u19, l__TweenService__3:Create(p38, u23, {
            Transparency = l__Transparency__14
        }));
        table.insert(u20, l__TweenService__3:Create(p38, u23, {
            Transparency = 1
        }));
        table.insert(u21, l__TweenService__3:Create(p38, u23, {
            Transparency = l__Transparency__14
        }));
    end;
    local function u41(p40) --[[ Line: 157 ]]
        -- upvalues: u18 (copy), l__TweenService__3 (ref), u23 (copy), u19 (copy), u20 (copy), u21 (copy)
        local l__BackgroundTransparency__15 = p40.BackgroundTransparency;
        p40.BackgroundTransparency = 1;
        table.insert(u18, l__TweenService__3:Create(p40, u23, {
            BackgroundTransparency = 1
        }));
        table.insert(u19, l__TweenService__3:Create(p40, u23, {
            BackgroundTransparency = l__BackgroundTransparency__15
        }));
        table.insert(u20, l__TweenService__3:Create(p40, u23, {
            BackgroundTransparency = 1
        }));
        table.insert(u21, l__TweenService__3:Create(p40, u23, {
            BackgroundTransparency = l__BackgroundTransparency__15
        }));
    end;
    local function u43(p42) --[[ Line: 166 ]]
        -- upvalues: u18 (copy), l__TweenService__3 (ref), u23 (copy), u19 (copy), u20 (copy), u21 (copy)
        local l__TextTransparency__16 = p42.TextTransparency;
        local l__TextStrokeTransparency__17 = p42.TextStrokeTransparency;
        p42.TextTransparency = 1;
        p42.TextStrokeTransparency = 1;
        table.insert(u18, l__TweenService__3:Create(p42, u23, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }));
        table.insert(u19, l__TweenService__3:Create(p42, u23, {
            TextTransparency = l__TextTransparency__16,
            TextStrokeTransparency = l__TextStrokeTransparency__17
        }));
        table.insert(u20, l__TweenService__3:Create(p42, u23, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }));
        table.insert(u21, l__TweenService__3:Create(p42, u23, {
            TextTransparency = l__TextTransparency__16,
            TextStrokeTransparency = l__TextStrokeTransparency__17
        }));
    end;
    local function u45(p44) --[[ Line: 177 ]]
        -- upvalues: u18 (copy), l__TweenService__3 (ref), u23 (copy), u19 (copy), u20 (copy), u21 (copy)
        local l__ImageTransparency__18 = p44.ImageTransparency;
        p44.ImageTransparency = 1;
        table.insert(u18, l__TweenService__3:Create(p44, u23, {
            ImageTransparency = 1
        }));
        table.insert(u19, l__TweenService__3:Create(p44, u23, {
            ImageTransparency = l__ImageTransparency__18
        }));
        table.insert(u20, l__TweenService__3:Create(p44, u23, {
            ImageTransparency = 1
        }));
        table.insert(u21, l__TweenService__3:Create(p44, u23, {
            ImageTransparency = l__ImageTransparency__18
        }));
    end;
    local function u48(p46) --[[ Line: 186 ]]
        -- upvalues: u39 (copy), u41 (copy), u43 (copy), u45 (copy), u48 (copy)
        if p46:IsA("UIStroke") then
            u39(p46);
        elseif not p46:IsA("UIGradient") and p46:IsA("GuiObject") then
            u41(p46);
            if p46:IsA("TextLabel") then
                u43(p46);
            elseif p46:IsA("ImageLabel") then
                u45(p46);
            end;
        end;
        for _, v47 in p46:GetChildren() do
            u48(v47);
        end;
    end;
    local v49 = {
        [l__InputFrame__9] = false,
        [l__ActionText__10] = true,
        [l__ObjectText__11] = true
    };
    for _, v50 in l__PromptFrame__8:GetChildren() do
        if v49[v50] == nil then
            u48(v50);
        elseif v49[v50] == true then
            for _, v51 in v50:GetChildren() do
                u48(v51);
            end;
        end;
    end;
    local l__Frame__19 = l__InputFrame__9.Frame;
    local l__UIScale__20 = l__Frame__19.UIScale;
    table.insert(u18, l__TweenService__3:Create(l__UIScale__20, u23, {
        Scale = p16 == Enum.ProximityPromptInputType.Touch and 1.6 or 1.33
    }));
    table.insert(u19, l__TweenService__3:Create(l__UIScale__20, u23, {
        Scale = 1
    }));
    u43(l__ActionText__10);
    u43(l__ObjectText__11);
    local l__ButtonFrame__21 = l__Frame__19.ButtonFrame;
    local l__ButtonImage__22 = l__Frame__19.ButtonImage;
    local l__ButtonText__23 = l__Frame__19.ButtonText;
    local l__ButtonTextImage__24 = l__Frame__19.ButtonTextImage;
    (function() --[[ Name: setupButtonFrameTweens, Line 234 ]]
        -- upvalues: l__ButtonFrame__21 (copy), u20 (copy), l__TweenService__3 (ref), u24 (copy), u21 (copy)
        local l__BackgroundTransparency__25 = l__ButtonFrame__21.BackgroundTransparency;
        local l__ImageTransparency__26 = l__ButtonFrame__21.ImageTransparency;
        table.insert(u20, l__TweenService__3:Create(l__ButtonFrame__21, u24, {
            BackgroundTransparency = 1,
            ImageTransparency = 1
        }));
        table.insert(u21, l__TweenService__3:Create(l__ButtonFrame__21, u24, {
            BackgroundTransparency = l__BackgroundTransparency__25,
            ImageTransparency = l__ImageTransparency__26
        }));
        for _, v52 in l__ButtonFrame__21:GetChildren() do
            if v52:IsA("UIStroke") then
                local l__Transparency__27 = v52.Transparency;
                table.insert(u20, l__TweenService__3:Create(v52, u24, {
                    Transparency = 1
                }));
                table.insert(u21, l__TweenService__3:Create(v52, u24, {
                    Transparency = l__Transparency__27
                }));
            end;
        end;
    end)();
    local function v54() --[[ Line: 251 ]]
        -- upvalues: l__ButtonText__23 (copy), u20 (copy), l__TweenService__3 (ref), u24 (copy), u21 (copy)
        local l__TextTransparency__28 = l__ButtonText__23.TextTransparency;
        local l__TextStrokeTransparency__29 = l__ButtonText__23.TextStrokeTransparency;
        local l__BackgroundTransparency__30 = l__ButtonText__23.BackgroundTransparency;
        l__ButtonText__23.BackgroundTransparency = 1;
        l__ButtonText__23.TextStrokeTransparency = 1;
        l__ButtonText__23.TextTransparency = 1;
        table.insert(u20, l__TweenService__3:Create(l__ButtonText__23, u24, {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            BackgroundTransparency = 1
        }));
        table.insert(u21, l__TweenService__3:Create(l__ButtonText__23, u24, {
            TextTransparency = l__TextTransparency__28,
            TextStrokeTransparency = l__TextStrokeTransparency__29,
            BackgroundTransparency = l__BackgroundTransparency__30
        }));
        for _, v53 in l__ButtonText__23:GetChildren() do
            if v53:IsA("UIStroke") then
                local l__Transparency__31 = v53.Transparency;
                table.insert(u20, l__TweenService__3:Create(v53, u24, {
                    Transparency = 1
                }));
                table.insert(u21, l__TweenService__3:Create(v53, u24, {
                    Transparency = l__Transparency__31
                }));
            end;
        end;
    end;
    local function v55() --[[ Line: 271 ]]
        -- upvalues: l__ButtonImage__22 (copy), u20 (copy), l__TweenService__3 (ref), u24 (copy), u21 (copy)
        local l__ImageTransparency__32 = l__ButtonImage__22.ImageTransparency;
        local l__BackgroundTransparency__33 = l__ButtonImage__22.BackgroundTransparency;
        l__ButtonImage__22.BackgroundTransparency = 1;
        l__ButtonImage__22.ImageTransparency = 1;
        table.insert(u20, l__TweenService__3:Create(l__ButtonImage__22, u24, {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        }));
        table.insert(u21, l__TweenService__3:Create(l__ButtonImage__22, u24, {
            ImageTransparency = l__ImageTransparency__32,
            BackgroundTransparency = l__BackgroundTransparency__33
        }));
    end;
    local function v56() --[[ Line: 281 ]]
        -- upvalues: l__ButtonTextImage__24 (copy), u20 (copy), l__TweenService__3 (ref), u24 (copy), u21 (copy)
        local l__BackgroundTransparency__34 = l__ButtonTextImage__24.BackgroundTransparency;
        local l__ImageTransparency__35 = l__ButtonTextImage__24.ImageTransparency;
        l__ButtonTextImage__24.BackgroundTransparency = 1;
        l__ButtonTextImage__24.ImageTransparency = 1;
        table.insert(u20, l__TweenService__3:Create(l__ButtonTextImage__24, u24, {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        }));
        table.insert(u21, l__TweenService__3:Create(l__ButtonTextImage__24, u24, {
            ImageTransparency = l__ImageTransparency__35,
            BackgroundTransparency = l__BackgroundTransparency__34
        }));
    end;
    if p16 == Enum.ProximityPromptInputType.Gamepad then
        local v57 = l__UserInputService__1:GetImageForKeyCode(u15.GamepadKeyCode);
        if v57 ~= "" then
            v56();
            l__ButtonTextImage__24.Image = v57;
            l__ButtonText__23.Visible = false;
            l__ButtonImage__22.Visible = false;
            l__ButtonTextImage__24.Visible = true;
        end;
    elseif p16 == Enum.ProximityPromptInputType.Touch then
        v55();
        l__ButtonImage__22.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png";
        l__ButtonText__23.Visible = false;
        l__ButtonTextImage__24.Visible = false;
        l__ButtonImage__22.Visible = true;
    else
        v55();
        l__ButtonImage__22.Visible = true;
        local v58 = l__UserInputService__1:GetStringForKeyCode(u15.KeyboardKeyCode);
        local v59 = u2[u15.KeyboardKeyCode];
        if v59 == nil then
            v59 = u3[v58];
        end;
        if v59 == nil then
            v58 = u4[u15.KeyboardKeyCode] or v58;
        end;
        if v59 then
            v56();
            l__ButtonTextImage__24.Image = v59;
            l__ButtonText__23.Visible = false;
            l__ButtonTextImage__24.Visible = true;
        elseif v58 == nil or v58 == "" then
            error("ProximityPrompt \'" .. u15.Name .. "\' has an unsupported keycode for rendering UI: " .. tostring(u15.KeyboardKeyCode));
        else
            if string.len(v58) > 2 then
                l__ButtonText__23.TextSize = math.round(l__ButtonText__23.TextSize * 6 / 7);
            end;
            v54();
            l__ButtonText__23.Text = v58;
            l__ButtonTextImage__24.Visible = false;
            l__ButtonText__23.Visible = true;
        end;
    end;
    if p16 == Enum.ProximityPromptInputType.Touch or u15.ClickablePrompt then
        local l__TextButton__36 = u26.TextButton;
        local u60 = false;
        l__TextButton__36.InputBegan:Connect(function(p61) --[[ Line: 347 ]]
            -- upvalues: u15 (copy), u60 (ref)
            if (p61.UserInputType == Enum.UserInputType.Touch or p61.UserInputType == Enum.UserInputType.MouseButton1) and p61.UserInputState ~= Enum.UserInputState.Change then
                u15:InputHoldBegin();
                u60 = true;
            end;
        end);
        l__TextButton__36.InputEnded:Connect(function(p62) --[[ Line: 355 ]]
            -- upvalues: u60 (ref), u15 (copy)
            if (p62.UserInputType == Enum.UserInputType.Touch or p62.UserInputType == Enum.UserInputType.MouseButton1) and u60 then
                u60 = false;
                u15:InputHoldEnd();
            end;
        end);
        u26.Active = true;
    end;
    if u15.HoldDuration > 0 then
        local l__ProgressBar__37 = l__Frame__19.ProgressBar;
        p14:SetUpCircularProgressBar(l__ProgressBar__37);
        table.insert(u18, l__TweenService__3:Create(l__ProgressBar__37.Progress, v22, {
            Value = 1
        }));
        table.insert(u19, l__TweenService__3:Create(l__ProgressBar__37.Progress, v25, {
            Value = 0
        }));
    end;
    local u63, u64;
    if u15.HoldDuration > 0 then
        u63 = u15.PromptButtonHoldBegan:Connect(function() --[[ Line: 380 ]]
            -- upvalues: u18 (copy)
            for _, v65 in u18 do
                v65:Play();
            end;
        end);
        u64 = u15.PromptButtonHoldEnded:Connect(function() --[[ Line: 386 ]]
            -- upvalues: u19 (copy)
            for _, v66 in u19 do
                v66:Play();
            end;
        end);
    else
        u63 = nil;
        u64 = nil;
    end;
    local u68 = u15.Triggered:Connect(function() --[[ Line: 393 ]]
        -- upvalues: u20 (copy)
        for _, v67 in u20 do
            v67:Play();
        end;
    end);
    local u70 = u15.TriggerEnded:Connect(function() --[[ Line: 399 ]]
        -- upvalues: u21 (copy)
        for _, v69 in u21 do
            v69:Play();
        end;
    end);
    local function v77() --[[ Line: 405 ]]
        -- upvalues: u15 (copy), l__ActionText__10 (copy), l__TextService__4 (ref), l__ObjectText__11 (copy), u26 (ref)
        local v71 = Instance.new("GetTextBoundsParams");
        v71.Text = u15.ActionText;
        v71.Font = l__ActionText__10.FontFace;
        v71.Size = l__ActionText__10.TextSize;
        v71.Width = 1000;
        local v72 = l__TextService__4:GetTextBoundsAsync(v71);
        local v73 = Instance.new("GetTextBoundsParams");
        v73.Text = u15.ObjectText;
        v73.Font = l__ObjectText__11.FontFace;
        v73.Size = l__ObjectText__11.TextSize;
        v73.Width = 1000;
        local v74 = l__TextService__4:GetTextBoundsAsync(v73);
        local v75 = math.max(v72.X, v74.X);
        local v76 = (u15.ActionText == nil or u15.ActionText == "") and (u15.ObjectText == nil or u15.ObjectText == "") and 72 or v75 + 72 + 24;
        l__ActionText__10.Position = UDim2.new(0.5, 72 - v76 / 2, 0, (u15.ObjectText == nil or u15.ObjectText == "") and 0 or 9);
        l__ObjectText__11.Position = UDim2.new(0.5, 72 - v76 / 2, 0, -10);
        l__ActionText__10.Text = u15.ActionText;
        l__ObjectText__11.Text = u15.ObjectText;
        l__ActionText__10.AutoLocalize = u15.AutoLocalize;
        l__ActionText__10.RootLocalizationTable = u15.RootLocalizationTable;
        l__ObjectText__11.AutoLocalize = u15.AutoLocalize;
        l__ObjectText__11.RootLocalizationTable = u15.RootLocalizationTable;
        u26.Size = UDim2.fromOffset(v76, 72);
        u26.SizeOffset = Vector2.new(u15.UIOffset.X / u26.Size.Width.Offset, u15.UIOffset.Y / u26.Size.Height.Offset);
    end;
    local u78 = u15.Changed:Connect(v77);
    v77();
    u26.Adornee = u15.Parent;
    u26.Parent = p17;
    for _, v79 in u21 do
        v79:Play();
    end;
    return function() --[[ Name: cleanup, Line 460 ]]
        -- upvalues: u63 (ref), u64 (ref), u68 (ref), u70 (ref), u78 (copy), u20 (copy), u26 (ref)
        if u63 then
            u63:Disconnect();
        end;
        if u64 then
            u64:Disconnect();
        end;
        u68:Disconnect();
        u70:Disconnect();
        u78:Disconnect();
        for _, v80 in u20 do
            v80:Play();
        end;
        task.wait(0.2);
        u26.Parent = nil;
    end;
end;
return v1;