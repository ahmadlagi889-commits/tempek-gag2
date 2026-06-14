-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local u1 = Color3.fromRGB(40, 40, 40);
local u2 = Color3.fromRGB(255, 255, 255);
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local l__PlayerGui__4 = l__LocalPlayer__3:WaitForChild("PlayerGui");
local l__Message__5 = l__PlayerGui__4:WaitForChild("Message");
local l__MainPage__6 = l__Message__5:WaitForChild("MainPage");
local l__Header__7 = l__MainPage__6:WaitForChild("Header");
local l__Title__8 = l__Header__7:WaitForChild("Title");
local l__TextLabel__9 = l__Title__8:WaitForChild("TextLabel");
local l__ExitButton__10 = l__Header__7:WaitForChild("ExitButton");
local l__TextLabel__11 = l__MainPage__6:WaitForChild("Content"):WaitForChild("Message"):WaitForChild("TextLabel");
local l__TextLabel__12 = l__TextLabel__11:WaitForChild("TextLabel");
local l__Options__13 = l__MainPage__6:WaitForChild("Options");
local l__Template__14 = l__Options__13:WaitForChild("Template");
local l__Controllers__15 = l__LocalPlayer__3:WaitForChild("PlayerScripts"):WaitForChild("Controllers");
local l__GuiController__16 = require(l__Controllers__15:WaitForChild("GuiController"));
l__Message__5.Enabled = false;
local u3 = nil;
local u4 = {};
local u5 = false;
local u6 = nil;
local u7 = nil;
local u8 = false;
local function u13(p9) --[[ Line: 133 ]]
    local v10 = table.create(#p9.Keypoints);
    for v11, v12 in p9.Keypoints do
        local l__Value__17 = v12.Value;
        v10[v11] = ColorSequenceKeypoint.new(v12.Time, Color3.new(l__Value__17.R * 0.6, l__Value__17.G * 0.6, l__Value__17.B * 0.6));
    end;
    return ColorSequence.new(v10);
end;
local function u28(p14) --[[ Line: 148 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local u15 = Instance.new("Frame");
    u15.Name = "DelayRing";
    u15.AnchorPoint = Vector2.new(1, 0);
    u15.Position = UDim2.new(1, -4, 0, 4);
    u15.Size = UDim2.fromScale(0.25, 0.55);
    u15.BackgroundTransparency = 1;
    u15.ZIndex = 5;
    local v16 = Instance.new("UIAspectRatioConstraint");
    v16.AspectRatio = 1;
    v16.Parent = u15;
    local v17 = Instance.new("ImageLabel");
    v17.Name = "Background";
    v17.Size = UDim2.fromScale(1, 1);
    v17.BackgroundTransparency = 1;
    v17.Image = "rbxasset://textures/ui/Controls/RadialFill.png";
    v17.ImageColor3 = u1;
    v17.ImageTransparency = 0.45;
    v17.ZIndex = u15.ZIndex;
    v17.Parent = u15;
    local function v25(p18, p19) --[[ Line: 171 ]]
        -- upvalues: u15 (copy), u2 (ref)
        local v20 = Instance.new("Frame");
        v20.Name = p18;
        v20.Size = UDim2.fromScale(0.5, 1);
        local v21;
        if p19 then
            v21 = UDim2.fromScale(0.5, 0);
        else
            v21 = UDim2.new();
        end;
        v20.Position = v21;
        v20.BackgroundTransparency = 1;
        v20.ClipsDescendants = true;
        v20.ZIndex = u15.ZIndex + 1;
        v20.Parent = u15;
        local v22 = Instance.new("ImageLabel");
        v22.Name = "ProgressBarImage";
        v22.Size = UDim2.fromScale(2, 1);
        local v23;
        if p19 then
            v23 = UDim2.fromScale(-1, 0);
        else
            v23 = UDim2.new();
        end;
        v22.Position = v23;
        v22.BackgroundTransparency = 1;
        v22.Image = "rbxasset://textures/ui/Controls/RadialFill.png";
        v22.ImageColor3 = u2;
        v22.ZIndex = v20.ZIndex;
        v22.Parent = v20;
        local v24 = Instance.new("UIGradient");
        v24.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.499, 0),
            NumberSequenceKeypoint.new(0.5, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
        v24.Parent = v22;
        return v24;
    end;
    local v26 = v25("RightHalf", true);
    local v27 = v25("LeftHalf", false);
    v26.Rotation = 180;
    v27.Rotation = 360;
    u15.Parent = p14;
    return {
        Frame = u15,
        RightGradient = v26,
        LeftGradient = v27
    };
end;
local function u35(p29) --[[ Line: 218 ]]
    local v30 = p29.yield == true;
    local v31;
    if p29.options then
        v31 = p29.options;
    else
        v31 = v30 and { "Yes", "No" } or { "Ok" };
    end;
    if #v31 > 2 then
        error("MessagePrompt.Prompt only supports 1 or 2 options", 3);
    end;
    if #v31 == 0 then
        error("MessagePrompt.Prompt requires at least 1 option", 3);
    end;
    local l__optionDelays__18 = p29.optionDelays;
    if l__optionDelays__18 and #l__optionDelays__18 ~= #v31 then
        error("MessagePrompt.Prompt optionDelays length must match options length", 3);
    end;
    local v32 = table.create(#v31);
    for v33 = 1, #v31 do
        local v34;
        if l__optionDelays__18 then
            v34 = l__optionDelays__18[v33];
        else
            v34 = nil;
        end;
        v32[v33] = v34;
    end;
    return v31, v32;
end;
local function u39(p36) --[[ Line: 270 ]]
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), l__GuiController__16 (copy), l__Message__5 (copy), l__PlayerGui__4 (copy)
    if u5 then
        u5 = false;
        local v37 = u6;
        local v38 = u7;
        u6 = nil;
        u7 = nil;
        if l__GuiController__16.Gui == l__Message__5 then
            if p36 then
                l__GuiController__16:Close(true);
            elseif v37 and l__PlayerGui__4:FindFirstChild(v37) then
                l__GuiController__16:Open(v37, true);
            else
                l__GuiController__16:Close(true);
            end;
            if v38 then
                l__GuiController__16:RestoreHudStates(v38);
            end;
        end;
    end;
end;
local u40 = nil;
u40 = function(u41, u42) --[[ Line: 317 ]]
    -- upvalues: u35 (copy), l__ExitButton__10 (copy), l__TextLabel__9 (copy), l__Title__8 (copy), l__Message__5 (copy), u3 (ref), u4 (copy), u40 (ref), u8 (ref), u39 (copy), l__TextLabel__12 (copy), l__TextLabel__11 (copy), l__Template__14 (copy), l__Options__13 (copy), u13 (copy), u28 (copy), l__RunService__2 (copy)
    local v43, v44 = u35(u41);
    local u45 = #v43 == 1 and 1 or 2;
    local v46 = u41.hideClose == true;
    local u47 = u41.titleOverride or "Alert";
    local u48 = false;
    local u49 = {};
    local u50 = {};
    local function u60(p51) --[[ Line: 328 ]]
        -- upvalues: u48 (ref), u49 (copy), u50 (copy), l__ExitButton__10 (ref), u47 (copy), l__TextLabel__9 (ref), l__Title__8 (ref), l__Message__5 (ref), u3 (ref), u42 (copy), u4 (ref), u40 (ref), u8 (ref), u41 (copy), u39 (ref)
        if u48 then
        else
            u48 = true;
            for _, v52 in u49 do
                v52:Disconnect();
            end;
            table.clear(u49);
            for _, v53 in u50 do
                v53:Destroy();
            end;
            table.clear(u50);
            l__ExitButton__10.Visible = true;
            l__ExitButton__10.Active = true;
            local v54 = u47;
            l__TextLabel__9.Text = v54;
            l__Title__8.Text = string.gsub(v54, "<font([^>]*)>", function(p55) --[[ Line: 116 ]]
                local v56 = string.gsub(p55, "%s*color%s*=%s*\"[^\"]*\"", "");
                return "<font" .. string.gsub(v56, "%s*color%s*=%s*\'[^\']*\'", "") .. ">";
            end);
            l__Message__5.Enabled = false;
            u3 = nil;
            if u42 then
                task.spawn(u42, p51);
            end;
            if not u3 and #u4 ~= 0 then
                local v57 = table.remove(u4, 1);
                u40(v57.Config, v57.Resume);
            end;
            if not (u3 or u8) then
                local v58 = p51 == 1;
                local v59;
                if u41.dontRestore == true or v58 and u41.dontRestoreOnSuccess == true then
                    v59 = true;
                else
                    v59 = not v58;
                    if v59 then
                        v59 = u41.dontRestoreOnFail == true;
                    end;
                end;
                u39(v59);
            end;
        end;
    end;
    u3 = {
        Respond = u60
    };
    l__TextLabel__9.Text = u47;
    l__Title__8.Text = string.gsub(u47, "<font([^>]*)>", function(p61) --[[ Line: 116 ]]
        local v62 = string.gsub(p61, "%s*color%s*=%s*\"[^\"]*\"", "");
        return "<font" .. string.gsub(v62, "%s*color%s*=%s*\'[^\']*\'", "") .. ">";
    end);
    local l__message__19 = u41.message;
    l__TextLabel__12.Text = l__message__19;
    l__TextLabel__11.Text = string.gsub(l__message__19, "<font([^>]*)>", function(p63) --[[ Line: 116 ]]
        local v64 = string.gsub(p63, "%s*color%s*=%s*\"[^\"]*\"", "");
        return "<font" .. string.gsub(v64, "%s*color%s*=%s*\'[^\']*\'", "") .. ">";
    end);
    l__ExitButton__10.Visible = not v46;
    l__ExitButton__10.Active = not v46;
    if not v46 then
        local v65 = l__ExitButton__10.Activated:Connect(function() --[[ Line: 376 ]]
            -- upvalues: u60 (copy), u45 (copy)
            u60(u45);
        end);
        table.insert(u49, v65);
    end;
    local u66 = u48;
    for u67, v68 in v43 do
        local u69 = l__Template__14:Clone();
        u69.Name = `Option{u67}`;
        u69.Visible = true;
        u69.LayoutOrder = u67;
        local l__TextLabel__20 = u69:WaitForChild("TextLabel");
        local l__TextLabel__21 = l__TextLabel__20:WaitForChild("TextLabel");
        l__TextLabel__20.Text = v68;
        l__TextLabel__21.Text = v68;
        local u70 = u69:WaitForChild(u67 == 1 and "GreenGradient" or "RedGradient");
        u70.Enabled = true;
        u69.Parent = l__Options__13;
        table.insert(u50, u69);
        local u71 = v44[u67];
        if u71 and u71 > 0 then
            local l__Color__22 = u70.Color;
            u70.Color = u13(l__Color__22);
            u69.Active = false;
            u69.AutoButtonColor = false;
            local u72 = u28(u69);
            local u73 = os.clock();
            local u74 = nil;
            u74 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 417 ]]
                -- upvalues: u66 (ref), u73 (copy), u71 (copy), u72 (copy), u74 (ref), u70 (copy), l__Color__22 (copy), u69 (copy), u67 (copy), u60 (copy), u49 (copy)
                if u66 then
                else
                    local v75 = 1 - (os.clock() - u73) / u71;
                    local v76 = math.max(0, v75);
                    local v77 = math.clamp(v76 * 360, 0, 360);
                    u72.RightGradient.Rotation = math.clamp(v77, 0, 180);
                    u72.LeftGradient.Rotation = math.clamp(v77, 180, 360);
                    if v76 <= 0 then
                        u74:Disconnect();
                        if u66 then
                            return;
                        end;
                        u72.Frame:Destroy();
                        u70.Color = l__Color__22;
                        u69.Active = true;
                        u69.AutoButtonColor = true;
                        local u78 = u67;
                        local v79 = u69.Activated:Connect(function() --[[ Line: 383 ]]
                            -- upvalues: u60 (ref), u78 (copy)
                            u60(u78);
                        end);
                        table.insert(u49, v79);
                    end;
                end;
            end);
            table.insert(u49, u74);
        else
            local v80 = u69.Activated:Connect(function() --[[ Line: 383 ]]
                -- upvalues: u60 (copy), u67 (copy)
                u60(u67);
            end);
            table.insert(u49, v80);
        end;
    end;
    local l__duration__23 = u41.duration;
    if l__duration__23 and l__duration__23 > 0 then
        local u81 = os.clock();
        local u82 = nil;
        u82 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 443 ]]
            -- upvalues: u66 (ref), l__duration__23 (copy), u81 (copy), u82 (ref), u60 (copy), u45 (copy), u47 (copy), l__TextLabel__9 (ref), l__Title__8 (ref)
            if u66 then
            else
                local v83 = l__duration__23 - (os.clock() - u81);
                if v83 <= 0 then
                    u82:Disconnect();
                    u60(u45);
                else
                    local v84 = math.ceil(v83);
                    local v85 = `{u47} ({math.max(1, v84)}s)`;
                    l__TextLabel__9.Text = v85;
                    l__Title__8.Text = string.gsub(v85, "<font([^>]*)>", function(p86) --[[ Line: 116 ]]
                        local v87 = string.gsub(p86, "%s*color%s*=%s*\"[^\"]*\"", "");
                        return "<font" .. string.gsub(v87, "%s*color%s*=%s*\'[^\']*\'", "") .. ">";
                    end);
                end;
            end;
        end);
        table.insert(u49, u82);
    end;
    l__Message__5.Enabled = true;
end;
local function u89() --[[ Line: 466 ]]
    -- upvalues: u8 (ref), u4 (copy), u3 (ref)
    u8 = true;
    for _, v88 in u4 do
        if v88.Resume then
            task.spawn(v88.Resume, 0);
        end;
    end;
    table.clear(u4);
    if u3 then
        u3.Respond(0);
    end;
    u8 = false;
end;
local v93 = {
    Choices = table.freeze({
        Ok = table.freeze({ "Ok" }),
        YesNo = table.freeze({ "Yes", "No" }),
        ConfirmDeny = table.freeze({ "Confirm", "Deny" })
    }),
    Prompt = function(p90) --[[ Name: Prompt, Line 490 ]]
        -- upvalues: u35 (copy), u89 (copy), u5 (ref), u7 (ref), l__GuiController__16 (copy), l__Message__5 (copy), u6 (ref), u40 (ref), u3 (ref), u4 (copy)
        u35(p90);
        local v91 = p90.yield == true;
        local v92;
        if v91 then
            v92 = coroutine.running();
        else
            v92 = nil;
        end;
        if p90.force then
            u89();
            if not u5 then
                u5 = true;
                u7 = l__GuiController__16:SnapshotHudStates();
                local l__Gui__24 = l__GuiController__16.Gui;
                if l__Gui__24 and l__Gui__24 ~= l__Message__5 then
                    u6 = l__Gui__24.Name;
                else
                    u6 = nil;
                end;
                l__GuiController__16:Open("Message", true);
            end;
            u40(p90, v92);
        elseif u3 then
            table.insert(u4, {
                Config = p90,
                Resume = v92
            });
        else
            if not u5 then
                u5 = true;
                u7 = l__GuiController__16:SnapshotHudStates();
                local l__Gui__25 = l__GuiController__16.Gui;
                if l__Gui__25 and l__Gui__25 ~= l__Message__5 then
                    u6 = l__Gui__25.Name;
                else
                    u6 = nil;
                end;
                l__GuiController__16:Open("Message", true);
            end;
            u40(p90, v92);
        end;
        if v91 then
            return coroutine.yield() == 1;
        else
            return nil;
        end;
    end
};
return table.freeze(v93);