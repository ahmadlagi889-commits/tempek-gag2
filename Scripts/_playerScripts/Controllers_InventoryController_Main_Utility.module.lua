-- Decompiled with Potassium's decompiler.

local u1 = Color3.fromRGB(0, 162, 255);
local u2 = Color3.fromRGB(78, 84, 96);
local u3 = Color3.fromRGB(204, 204, 204);
local u4 = Color3.fromRGB(255, 255, 255);
local u5 = Color3.fromRGB(150, 150, 150);
local l__HttpService__1 = game:GetService("HttpService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__GuiService__3 = game:GetService("GuiService");
local l__RunService__4 = game:GetService("RunService");
local l__PlayerGui__5 = game.Players.LocalPlayer.PlayerGui;
l__PlayerGui__5:WaitForChild("BackpackGui");
local l__ContextActionService__6 = game:GetService("ContextActionService");
local l__VRService__7 = game:GetService("VRService");
local v6, v7 = pcall(function() --[[ Line: 39 ]]
    return false;
end);
local u8 = v6 and v7;
local u15 = {
    Create = function(u9) --[[ Name: Create, Line 48 ]]
        return function(p10) --[[ Line: 49 ]]
            -- upvalues: u9 (copy)
            local v11 = Instance.new(u9);
            local v12 = nil;
            for v13, v14 in pairs(p10) do
                if type(v13) == "number" then
                    v14.Parent = v11;
                elseif v13 == "Parent" then
                    v12 = v14;
                else
                    v11[v13] = v14;
                end;
            end;
            if v12 then
                v11.Parent = v12;
            end;
            return v11;
        end;
    end
};
local u16 = {};
setmetatable(u16, {
    __mode = "k"
});
local u17 = u15.Create("ImageLabel")({
    Image = "",
    BackgroundTransparency = 1
});
function clamp(p18, p19, p20)
    local v21 = math.min(p19, p20);
    return math.max(p18, v21);
end;
function ClampVector2(p22, p23, p24)
    return Vector2.new(clamp(p22.x, p23.x, p24.x), clamp(p22.y, p23.y, p24.y));
end;
local function u29(p25, p26, p27, p28) --[[ Line: 90 ]]
    if p28 <= p25 then
        return p26 + p27;
    else
        return p27 * p25 / p28 + p26;
    end;
end;
local function u35(p30, p31, p32, p33) --[[ Line: 98 ]]
    if p33 <= p30 then
        return p31 + p32;
    end;
    local v34 = p30 / p33;
    return p31 - p32 * v34 * (v34 - 2);
end;
local function u41(p36, p37, p38, p39) --[[ Line: 107 ]]
    if p39 <= p36 then
        return p37 + p38;
    else
        local v40 = p36 / p39;
        if v40 < 0.5 then
            return 2 * p38 * v40 * v40 + p37;
        else
            return p37 + p38 * (2 * (2 - v40) * v40 - 1);
        end;
    end;
end;
function PropertyTweener(u42, u43, u44, u45, u46, u47, u48)
    -- upvalues: l__RunService__4 (copy)
    local u49 = {
        StartTime = tick()
    };
    u49.EndTime = u49.StartTime + u46;
    u49.Cancelled = false;
    local u50 = false;
    local u51 = 0;
    u42[u43] = u47(0, u44, u45 - u44, u46);
    coroutine.wrap(function() --[[ Line: 141 ]]
        -- upvalues: u49 (copy), u42 (copy), u43 (copy), u47 (copy), u44 (copy), u45 (copy), u46 (copy), u51 (ref), l__RunService__4 (ref), u50 (ref), u48 (copy)
        local v52 = tick();
        while v52 < u49.EndTime and u42 do
            if u49.Cancelled then
                return;
            end;
            u42[u43] = u47(v52 - u49.StartTime, u44, u45 - u44, u46);
            u51 = clamp(0, 1, (v52 - u49.StartTime) / u46);
            l__RunService__4.RenderStepped:wait();
            v52 = tick();
        end;
        if u49.Cancelled == false and u42 then
            if u42 then
                u42[u43] = u47(1, u44, u45 - u44, 1);
            end;
            u50 = true;
            u51 = 1;
            if u48 then
                u48();
            end;
        end;
    end)();
    function u49.GetFinal(_) --[[ Line: 157 ]]
        -- upvalues: u45 (copy)
        return u45;
    end;
    function u49.GetPercentComplete(_) --[[ Line: 161 ]]
        -- upvalues: u51 (ref)
        return u51;
    end;
    function u49.IsFinished(_) --[[ Line: 165 ]]
        -- upvalues: u50 (ref)
        return u50;
    end;
    function u49.Finish(p53) --[[ Line: 169 ]]
        -- upvalues: u50 (ref), u42 (copy), u43 (copy), u47 (copy), u44 (copy), u45 (copy), u51 (ref), u48 (copy)
        if not u50 then
            p53:Cancel();
            if u42 then
                u42[u43] = u47(1, u44, u45 - u44, 1);
            end;
            u50 = true;
            u51 = 1;
            if u48 then
                u48();
            end;
        end;
    end;
    function u49.Cancel(_) --[[ Line: 176 ]]
        -- upvalues: u49 (copy)
        u49.Cancelled = true;
    end;
    return u49;
end;
local function u59() --[[ Line: 185 ]]
    local v54 = {};
    local u55 = Instance.new("BindableEvent");
    local u56 = nil;
    local u57 = nil;
    function v54.fire(_, ...) --[[ Line: 193 ]]
        -- upvalues: u56 (ref), u57 (ref), u55 (copy)
        u56 = { ... };
        u57 = select("#", ...);
        u55:Fire();
    end;
    function v54.connect(_, u58) --[[ Line: 199 ]]
        -- upvalues: u55 (copy), u56 (ref), u57 (ref)
        if not u58 then
            error("connect(nil)", 2);
        end;
        return u55.Event:Connect(function() --[[ Line: 201 ]]
            -- upvalues: u58 (copy), u56 (ref), u57 (ref)
            u58(unpack(u56, 1, u57));
        end);
    end;
    function v54.wait(_) --[[ Line: 206 ]]
        -- upvalues: u55 (copy), u56 (ref), u57 (ref)
        u55.Event:wait();
        if not u56 then
            error("Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.");
        end;
        return unpack(u56, 1, u57);
    end;
    return v54;
end;
local function u60() --[[ Line: 217 ]]
    while not workspace.CurrentCamera do
        workspace.Changed:wait();
    end;
    while workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0) or workspace.CurrentCamera.ViewportSize == Vector2.new(1, 1) do
        workspace.CurrentCamera.Changed:wait();
    end;
    return workspace.CurrentCamera.ViewportSize;
end;
local function u67(u61, u62, u63, u64) --[[ Line: 340 ]]
    local function v65() --[[ Line: 341 ]]
        -- upvalues: u61 (copy), u63 (copy), u62 (copy)
        if u61.Active then
            u63(u62);
        end;
    end;
    local function v66() --[[ Line: 346 ]]
        -- upvalues: u61 (copy), u64 (copy), u62 (copy)
        if u61.Active then
            u64(u62);
        end;
    end;
    u61.MouseEnter:Connect(v66);
    u61.SelectionGained:Connect(v66);
    u61.MouseLeave:Connect(v65);
    u61.SelectionLost:Connect(v65);
    u63(u62);
end;
local function u72(p68, p69) --[[ Line: 360 ]]
    -- upvalues: u16 (copy), u60 (copy)
    u16[p68] = p69;
    local v70 = u60();
    local v71 = u60();
    p69(v70, v71.Y > v71.X);
end;
local u73 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
};
local function u94(p74, p75, u76, u77, u78) --[[ Line: 376 ]]
    -- upvalues: u15 (copy), u73 (copy), l__UserInputService__2 (copy), l__GuiService__3 (copy), l__VRService__7 (copy)
    local v79 = u15.Create("ImageLabel")({
        Image = "",
        BackgroundTransparency = 1
    });
    local u80 = u15.Create("ImageButton")({
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = p74 .. "Button",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = p75,
        SelectionImageObject = v79
    });
    u15.Create("BoolValue")({
        Name = "Enabled",
        Value = true,
        Parent = u80
    });
    if u76 then
        u80.MouseButton1Click:Connect(function() --[[ Line: 404 ]]
            -- upvalues: u76 (copy), u73 (ref), l__UserInputService__2 (ref)
            u76(u73[l__UserInputService__2:GetLastInputType()] or false);
        end);
    end;
    local u81 = nil;
    local function v83(p82) --[[ Line: 414 ]]
        -- upvalues: u81 (ref)
        u81 = p82;
    end;
    u80.InputBegan:Connect(function(p84) --[[ Line: 443 ]]
        -- upvalues: u80 (copy), u78 (copy), u77 (copy), u81 (ref)
        if u80.Selectable and (p84.UserInputType == Enum.UserInputType.MouseMovement or p84.UserInputType == Enum.UserInputType.Touch) then
            local v85 = u78;
            if v85 == nil and u77 then
                v85 = u77.HubRef;
            end;
            if v85 and v85.Active or v85 == nil then
                u80.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
                local v86 = u80;
                if u81 then
                    v86 = u81;
                end;
                if v85 then
                    v85:ScrollToFrame(v86);
                end;
            end;
        end;
    end);
    u80.InputEnded:Connect(function(p87) --[[ Line: 448 ]]
        -- upvalues: u80 (copy), l__GuiService__3 (ref)
        if u80.Selectable and l__GuiService__3.SelectedCoreObject ~= u80 and (p87.UserInputType == Enum.UserInputType.MouseMovement or p87.UserInputType == Enum.UserInputType.Touch) then
            u80.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
        end;
    end);
    u80.SelectionGained:Connect(function() --[[ Line: 455 ]]
        -- upvalues: u78 (copy), u77 (copy), u80 (copy), u81 (ref)
        local v88 = u78;
        if v88 == nil and u77 then
            v88 = u77.HubRef;
        end;
        if v88 and v88.Active or v88 == nil then
            u80.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
            local v89 = u80;
            if u81 then
                v89 = u81;
            end;
            if v88 then
                v88:ScrollToFrame(v89);
            end;
        end;
    end);
    u80.SelectionLost:Connect(function() --[[ Line: 458 ]]
        -- upvalues: u80 (copy)
        u80.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
    end);
    l__GuiService__3.Changed:Connect(function(p90) --[[ Line: 462 ]]
        -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u80 (copy), u78 (copy), u77 (copy), u81 (ref)
        if p90 == "SelectedCoreObject" then
            local v91;
            if l__VRService__7.VREnabled then
                v91 = false;
            else
                v91 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v91 then
                if l__GuiService__3.SelectedCoreObject == nil or l__GuiService__3.SelectedCoreObject ~= u80 then
                    u80.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
                else
                    if u80.Selectable then
                        local v92 = u78;
                        if v92 == nil and u77 then
                            v92 = u77.HubRef;
                        end;
                        if v92 and v92.Active or v92 == nil then
                            u80.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
                            local v93 = u80;
                            if u81 then
                                v93 = u81;
                            end;
                            if v92 then
                                v92:ScrollToFrame(v93);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
    return u80, v83;
end;
local function u106(p95, p96, p97, p98, p99, p100) --[[ Line: 479 ]]
    -- upvalues: u94 (copy), u15 (copy), u60 (copy), l__UserInputService__2 (copy)
    local v101, v102 = u94(p95, p97, p98, p99, p100);
    local v103 = u15.Create("TextLabel")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 24,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
        Name = p95 .. "TextLabel",
        Size = UDim2.new(1, 0, 1, -8),
        Position = UDim2.new(0, 0, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextYAlignment = Enum.TextYAlignment.Center,
        Font = Enum.Font.SourceSansBold,
        Text = p96,
        Parent = v101
    });
    local v104 = Instance.new("UITextSizeConstraint", v103);
    local v105 = u60();
    local l__TouchEnabled__8 = l__UserInputService__2.TouchEnabled;
    if l__TouchEnabled__8 then
        l__TouchEnabled__8 = v105.Y < 500 and true or v105.X < 700;
    end;
    if l__TouchEnabled__8 then
        v103.TextSize = 18;
    elseif false then
        v103.TextSize = 36;
    end;
    v104.MaxTextSize = v103.TextSize;
    return v101, v103, v102;
end;
local function u116(p107, p108, p109, p110, p111, p112, p113) --[[ Line: 511 ]]
    -- upvalues: u94 (copy), u15 (copy)
    local v114, v115 = u94(p107, p109, p111, p112, p113);
    return v114, u15.Create("ImageLabel")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2,
        Name = p107 .. "ImageLabel",
        Size = p110,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = p108,
        Parent = v114
    }), v115;
end;
local function u127(p117, p118, p119, p120, p121, p122) --[[ Line: 530 ]]
    -- upvalues: u106 (copy), u15 (copy)
    local v123, v124, v125 = u106(p118, p119, p120, p121, p117, p122);
    local v126 = u15.Create("Frame")({
        BackgroundTransparency = 1,
        Name = p118 .. "Row",
        Size = UDim2.new(1, 0, p120.Y.Scale, p120.Y.Offset),
        Parent = p117.Page
    });
    v123.Parent = v126;
    v123.AnchorPoint = Vector2.new(1, 0);
    v123.Position = UDim2.new(1, -20, 0, 0);
    return v126, v123, v124, v125;
end;
local function u187(p128, u129, u130) --[[ Line: 545 ]]
    -- upvalues: l__HttpService__1 (copy), u15 (copy), l__PlayerGui__5 (copy), l__VRService__7 (copy), l__UserInputService__2 (copy), l__GuiService__3 (copy), l__ContextActionService__6 (copy), u106 (copy)
    local u131 = Color3.fromRGB(178, 178, 178);
    local u132 = Color3.fromRGB(229, 229, 229);
    local u133 = Color3.fromRGB(255, 255, 255);
    local u134 = nil;
    local u135 = {
        CurrentIndex = nil
    };
    Instance.new("BindableEvent").Name = "IndexChanged";
    if type(p128) ~= "table" then
        error("CreateDropDown dropDownStringTable (first arg) is not a table", 2);
        return u135;
    end;
    local u136 = Instance.new("BindableEvent");
    u136.Name = "IndexChanged";
    local u137 = true;
    local u138 = l__HttpService__1:GenerateGUID(false);
    local u139 = nil;
    local u140 = p128;
    local u141 = u15.Create("ImageButton")({
        Name = "DropDownFullscreenFrame",
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 10,
        Active = true,
        Visible = false,
        Selectable = false,
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Parent = l__PlayerGui__5.RobloxGui
    });
    local function v143(p142) --[[ Line: 592 ]]
        -- upvalues: l__VRService__7 (ref), l__PlayerGui__5 (ref), u141 (copy), u135 (copy), u140 (ref)
        if p142 == "VREnabled" then
            if l__VRService__7.VREnabled then
                u141.Parent = require(l__PlayerGui__5.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):GetGUI();
                u141.BackgroundTransparency = 1;
            else
                u141.Parent = l__PlayerGui__5.RobloxGui;
                u141.BackgroundTransparency = 0.2;
            end;
            if u135.UpdateDropDownList then
                u135:UpdateDropDownList(u140);
            end;
        end;
    end;
    l__VRService__7.Changed:Connect(v143);
    v143("VREnabled");
    local u144 = u15.Create("ImageLabel")({
        Name = "DropDownSelectionFrame",
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        BackgroundTransparency = 1,
        ZIndex = 10,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = UDim2.new(0.6, 0, 0.9, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = u141
    });
    local u145 = u15.Create("ScrollingFrame")({
        Name = "DropDownScrollingFrame",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 10,
        Size = UDim2.new(1, -20, 1, -25),
        Position = UDim2.new(0, 10, 0, 10),
        Parent = u144
    });
    local u146 = nil;
    local u147 = false;
    local function u151(p148, p149) --[[ Line: 640 ]]
        -- upvalues: u135 (copy), u137 (ref), u130 (copy), u141 (copy), l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u134 (ref), u146 (ref), l__ContextActionService__6 (ref), u138 (copy), u139 (ref), u147 (ref), l__PlayerGui__5 (ref)
        if p148 == nil or p149 == Enum.UserInputState.Begin then
            u135.DropDownFrame.Selectable = u137;
            u130:SetActive(true);
            if u141.Visible then
                local v150;
                if l__VRService__7.VREnabled then
                    v150 = false;
                else
                    v150 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                end;
                if v150 then
                    l__GuiService__3.SelectedCoreObject = u134;
                end;
            end;
            u141.Visible = false;
            if u146 then
                u146:Disconnect();
            end;
            l__ContextActionService__6:UnbindAction(u138 .. "Action");
            l__ContextActionService__6:UnbindAction(u138 .. "FreezeAction");
            u139.Value = u137;
            u147 = false;
            if l__VRService__7.VREnabled then
                require(l__PlayerGui__5.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(u141, 0);
            end;
        end;
    end;
    local function u152() --[[ Line: 664 ]] end;
    local function v154() --[[ Line: 666 ]]
        -- upvalues: u137 (ref), u135 (copy), u147 (ref), u141 (copy), l__VRService__7 (ref), l__PlayerGui__5 (ref), u134 (ref), l__GuiService__3 (ref), u146 (ref), u133 (copy), u132 (copy), u131 (copy), l__ContextActionService__6 (ref), u138 (copy), u152 (copy), u151 (copy), u130 (copy), u139 (ref)
        if u137 then
            u135.DropDownFrame.Selectable = false;
            u147 = true;
            u141.Visible = true;
            if l__VRService__7.VREnabled then
                require(l__PlayerGui__5.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(u141, 0.5);
            end;
            u134 = u135.DropDownFrame;
            if u135.CurrentIndex and u135.CurrentIndex > 0 then
                l__GuiService__3.SelectedCoreObject = u135.Selections[u135.CurrentIndex];
            end;
            u146 = l__GuiService__3:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 683 ]]
                -- upvalues: u135 (ref), l__GuiService__3 (ref), u133 (ref), l__VRService__7 (ref), u132 (ref), u131 (ref)
                for v153 = 1, #u135.Selections do
                    if l__GuiService__3.SelectedCoreObject == u135.Selections[v153] then
                        u135.Selections[v153].TextColor3 = u133;
                    else
                        u135.Selections[v153].TextColor3 = l__VRService__7.VREnabled and u132 or u131;
                    end;
                end;
            end);
            l__ContextActionService__6:BindActionAtPriority(u138 .. "FreezeAction", u152, false, Enum.ContextActionPriority.High.Value, Enum.UserInputType.Keyboard, Enum.UserInputType.Gamepad1);
            l__ContextActionService__6:BindActionAtPriority(u138 .. "Action", u151, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape);
            u130:SetActive(false);
            u139.Value = false;
        end;
    end;
    u135.DropDownFrame = u106("DropDownFrame", "Choose One", UDim2.new(0.6, 0, 0, 50), v154, nil, u130);
    u135.DropDownFrame.Position = UDim2.new(1, 0, 0.5, 0);
    u135.DropDownFrame.AnchorPoint = Vector2.new(1, 0.5);
    u139 = u135.DropDownFrame.Enabled;
    local l__DropDownFrameTextLabel__9 = u135.DropDownFrame.DropDownFrameTextLabel;
    l__DropDownFrameTextLabel__9.Position = UDim2.new(0, 15, 0, 0);
    l__DropDownFrameTextLabel__9.Size = UDim2.new(1, -50, 1, -8);
    l__DropDownFrameTextLabel__9.ClipsDescendants = true;
    l__DropDownFrameTextLabel__9.TextXAlignment = Enum.TextXAlignment.Left;
    local u155 = u15.Create("ImageLabel")({
        Name = "DropDownImage",
        Image = "rbxasset://textures/ui/Settings/DropDown/DropDown.png",
        BackgroundTransparency = 1,
        ZIndex = 2,
        AnchorPoint = Vector2.new(1, 0.5),
        Size = UDim2.new(0, 15, 0, 10),
        Position = UDim2.new(1, -12, 0.5, 0),
        Parent = u135.DropDownFrame
    });
    u135.DropDownImage = u155;
    local function u160(p156) --[[ Line: 727 ]]
        -- upvalues: u135 (copy), l__DropDownFrameTextLabel__9 (copy), u136 (copy)
        local v157 = false;
        for v158, v159 in pairs(u135.Selections) do
            if v158 == p156 then
                l__DropDownFrameTextLabel__9.Text = v159.Text;
                u135.CurrentIndex = v158;
                v157 = true;
            end;
        end;
        if v157 then
            u136:Fire(p156);
        end;
    end;
    local function u165(p161) --[[ Line: 743 ]]
        -- upvalues: u135 (copy), l__DropDownFrameTextLabel__9 (copy), u136 (copy)
        local v162 = false;
        for v163, v164 in pairs(u135.Selections) do
            if v164.Text == p161 then
                l__DropDownFrameTextLabel__9.Text = v164.Text;
                u135.CurrentIndex = v163;
                v162 = true;
            end;
        end;
        if v162 then
            u136:Fire(u135.CurrentIndex);
        end;
        return v162;
    end;
    local _ = false;
    u135.IndexChanged = u136.Event;
    function u135.SetSelectionIndex(_, p166) --[[ Line: 797 ]]
        -- upvalues: u160 (copy)
        u160(p166);
    end;
    function u135.SetSelectionByValue(_, p167) --[[ Line: 801 ]]
        -- upvalues: u165 (copy)
        return u165(p167);
    end;
    function u135.ResetSelectionIndex(_) --[[ Line: 805 ]]
        -- upvalues: u135 (copy), l__DropDownFrameTextLabel__9 (copy), u151 (copy)
        u135.CurrentIndex = nil;
        l__DropDownFrameTextLabel__9.Text = "Choose One";
        u151();
    end;
    function u135.GetSelectedIndex(_) --[[ Line: 811 ]]
        -- upvalues: u135 (copy)
        return u135.CurrentIndex;
    end;
    function u135.SetZIndex(_, p168) --[[ Line: 815 ]]
        -- upvalues: u135 (copy), u155 (copy), l__DropDownFrameTextLabel__9 (copy)
        u135.DropDownFrame.ZIndex = p168;
        u155.ZIndex = p168;
        l__DropDownFrameTextLabel__9.ZIndex = p168;
    end;
    function u135.SetInteractable(_, p169) --[[ Line: 821 ]]
        -- upvalues: u137 (ref), u135 (copy), u151 (copy), l__VRService__7 (ref), u139 (ref), u147 (ref)
        u137 = p169;
        u135.DropDownFrame.Selectable = u137;
        if u137 then
            u135.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0;
            u135.DropDownFrame.ImageTransparency = 0;
            u135.DropDownImage.ImageTransparency = 0;
            if not l__VRService__7.VREnabled then
                u135:SetZIndex(2);
            end;
        else
            u151();
            if l__VRService__7.VREnabled then
                u135.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5;
                u135.DropDownFrame.ImageTransparency = 0.5;
                u135.DropDownImage.ImageTransparency = 0.5;
            else
                u135.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0;
                u135.DropDownFrame.ImageTransparency = 0;
                u135.DropDownImage.ImageTransparency = 0;
            end;
            if not l__VRService__7.VREnabled then
                u135:SetZIndex(1);
            end;
        end;
        local v170 = u139;
        if p169 then
            p169 = not u147;
        end;
        v170.Value = p169;
    end;
    function u135.UpdateDropDownList(_, p171) --[[ Line: 842 ]]
        -- upvalues: u140 (ref), u135 (copy), l__VRService__7 (ref), u15 (ref), u132 (copy), u131 (copy), u145 (copy), u129 (copy), l__DropDownFrameTextLabel__9 (copy), u133 (copy), u151 (copy), u136 (copy), l__UserInputService__2 (ref), l__GuiService__3 (ref), u138 (copy), u141 (copy), u144 (copy)
        u140 = p171;
        if u135.Selections then
            for v172 = 1, #u135.Selections do
                u135.Selections[v172]:Destroy();
            end;
        end;
        u135.Selections = {};
        u135.SelectionInfo = {};
        local l__VREnabled__10 = l__VRService__7.VREnabled;
        local v173 = l__VREnabled__10 and Enum.Font.SourceSansBold or Enum.Font.SourceSans;
        local v174 = l__VREnabled__10 and 70 or 50;
        local v175 = v174 + 1;
        local v176 = l__VREnabled__10 and 36 or 24;
        local u177 = l__VREnabled__10 and 600 or 400;
        for u178, v179 in pairs(p171) do
            local v180 = u15.Create("Frame")({
                BackgroundTransparency = 0.7,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0)
            });
            local u181 = u15.Create("TextButton")({
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                ZIndex = 10,
                Name = "Selection" .. tostring(u178),
                Size = UDim2.new(1, -28, 0, v174),
                Position = UDim2.new(0, 14, 0, (u178 - 1) * v175),
                TextColor3 = l__VRService__7.VREnabled and u132 or u131,
                Font = v173,
                TextSize = v176,
                Text = v179,
                SelectionImageObject = v180,
                Parent = u145
            });
            if u178 == u129 then
                u135.CurrentIndex = u178;
                l__DropDownFrameTextLabel__9.Text = v179;
                u181.TextColor3 = u133;
            elseif not u129 and u178 == 1 then
                u181.TextColor3 = u133;
            end;
            local function v182() --[[ Line: 896 ]]
                -- upvalues: l__DropDownFrameTextLabel__9 (ref), u181 (copy), u151 (ref), u135 (ref), u178 (copy), u136 (ref)
                l__DropDownFrameTextLabel__9.Text = u181.Text;
                u151();
                u135.CurrentIndex = u178;
                u136:Fire(u178);
            end;
            u181.MouseButton1Click:Connect(v182);
            u181.MouseEnter:Connect(function() --[[ Line: 905 ]]
                -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u181 (copy)
                local v183;
                if l__VRService__7.VREnabled then
                    v183 = false;
                else
                    v183 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                end;
                if v183 then
                    l__GuiService__3.SelectedCoreObject = u181;
                end;
            end);
            u135.Selections[u178] = u181;
            u135.SelectionInfo[u181] = {
                Clicked = v182
            };
        end;
        l__GuiService__3:RemoveSelectionGroup(u138);
        l__GuiService__3:AddSelectionTuple(u138, unpack(u135.Selections));
        u145.CanvasSize = UDim2.new(1, -20, 0, #p171 * v175);
        local function u184() --[[ Line: 920 ]]
            -- upvalues: u145 (ref), u141 (ref), u144 (ref), u177 (copy)
            if u145.CanvasSize.Y.Offset < u141.AbsoluteSize.Y - 10 then
                u144.Size = UDim2.new(0, u177, 0, u145.CanvasSize.Y.Offset + 25);
            else
                u144.Size = UDim2.new(0, u177, 0.9, 0);
            end;
        end;
        u141.Changed:Connect(function(p185) --[[ Line: 929 ]]
            -- upvalues: u184 (copy)
            if p185 == "AbsoluteSize" then
                u184();
            end;
        end);
        u184();
    end;
    u135:UpdateDropDownList(p128);
    u141.MouseButton1Click:Connect(u151);
    u130.PoppedMenu:Connect(function(p186) --[[ Line: 942 ]]
        -- upvalues: u141 (copy), u151 (copy)
        if p186 == u141 then
            u151();
        end;
    end);
    return u135;
end;
local function u258(p188, u189) --[[ Line: 952 ]]
    -- upvalues: u15 (copy), u17 (copy), u3 (copy), l__UserInputService__2 (copy), u4 (copy), u67 (copy), l__VRService__7 (copy), l__GuiService__3 (copy), u35 (copy), u5 (copy), u16 (copy), u60 (copy)
    local u190 = 0;
    local u191 = {
        HubRef = nil
    };
    if type(p188) ~= "table" then
        error("CreateSelector selectionStringTable (first arg) is not a table", 2);
        return u191;
    end;
    local u192 = Instance.new("BindableEvent");
    u192.Name = "IndexChanged";
    local u193 = true;
    u191.CurrentIndex = 0;
    u191.SelectorFrame = u15.Create("ImageButton")({
        Name = "Selector",
        Image = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        ZIndex = 2,
        NextSelectionLeft = u191.SelectorFrame,
        NextSelectionRight = u191.SelectorFrame,
        Size = UDim2.new(0.6, 0, 0, 50),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        SelectionImageObject = u17
    });
    local u194 = u15.Create("ImageButton")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 3,
        Selectable = false,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        SelectionImageObject = u17,
        Parent = u191.SelectorFrame
    });
    local u195 = u15.Create("ImageButton")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 3,
        Selectable = false,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        SelectionImageObject = u17,
        Parent = u191.SelectorFrame
    });
    local u196 = u15.Create("ImageLabel")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Settings/Slider/Left.png",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 30),
        ImageColor3 = u3,
        Parent = u194
    });
    local u197 = u15.Create("ImageLabel")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Settings/Slider/Right.png",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 30),
        ImageColor3 = u3,
        Parent = u195
    });
    if not l__UserInputService__2.TouchEnabled then
        local function v199(p198) --[[ Line: 1043 ]]
            -- upvalues: u3 (ref)
            p198.ImageColor3 = u3;
        end;
        local function v201(p200) --[[ Line: 1044 ]]
            -- upvalues: u4 (ref)
            p200.ImageColor3 = u4;
        end;
        u67(u194, u196, v199, v201);
        u67(u195, u197, v199, v201);
    end;
    u191.Selections = {};
    local u202 = {};
    local u203 = {};
    local u204 = u15.Create("ImageButton")({
        Name = "AutoSelectButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 2,
        Position = UDim2.new(0, u194.Size.X.Offset, 0, 0),
        Size = UDim2.new(1, u194.Size.X.Offset * -2, 1, 0),
        Parent = u191.SelectorFrame,
        SelectionImageObject = u17
    });
    u204.MouseButton1Click:Connect(function() --[[ Line: 1064 ]]
        -- upvalues: u193 (ref), u191 (copy), l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref)
        if u193 then
            if #u191.Selections <= 1 then
            else
                local v205 = u191.CurrentIndex + 1;
                u191:SetSelectionIndex(#u191.Selections < v205 and 1 or v205);
                local v206;
                if l__VRService__7.VREnabled then
                    v206 = false;
                else
                    v206 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                end;
                if v206 then
                    l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
                end;
            end;
        end;
    end);
    u203[u204] = true;
    local function u214(p207, p208) --[[ Line: 1079 ]]
        -- upvalues: u191 (copy), u194 (copy), u202 (ref), u35 (ref), u192 (copy)
        for v209, v210 in pairs(u191.Selections) do
            local v211 = v209 == p207;
            local v212 = UDim2.new(0, u194.Size.X.Offset, 0, 0);
            local v213 = UDim2.new(0, u194.Size.X.Offset * p208 * 3, 0, 0);
            if u202[v210] then
                v213 = UDim2.new(0, u194.Size.X.Offset * -p208 * 3, 0, 0);
            end;
            if v213.X.Offset < 0 then
                v213 = UDim2.new(0, v213.X.Offset + v210.AbsoluteSize.X / 4, 0, 0);
            end;
            if v211 then
                u202[v210] = true;
                v210.Position = v213;
                v210.Visible = true;
                PropertyTweener(v210, "TextTransparency", 1, 0, 0.165, u35);
                if v210:IsDescendantOf(game) then
                    v210:TweenPosition(v212, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.15, true);
                else
                    v210.Position = v212;
                end;
                u191.CurrentIndex = v209;
                u192:Fire(p207);
            elseif u202[v210] then
                u202[v210] = false;
                PropertyTweener(v210, "TextTransparency", 0, 1, 0.165, u35);
                if v210:IsDescendantOf(game) then
                    v210:TweenPosition(v213, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.135, true);
                else
                    v210.Position = UDim2.new(v213);
                end;
            end;
        end;
    end;
    local function u219(p215, p216) --[[ Line: 1118 ]]
        -- upvalues: u193 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u191 (copy), u214 (copy)
        if u193 then
            if p215 == nil or (p215.UserInputType == Enum.UserInputType.MouseButton1 or (p215.UserInputType == Enum.UserInputType.Gamepad1 or (p215.UserInputType == Enum.UserInputType.Gamepad2 or (p215.UserInputType == Enum.UserInputType.Gamepad3 or (p215.UserInputType == Enum.UserInputType.Gamepad4 or p215.UserInputType == Enum.UserInputType.Keyboard))))) then
                local v217;
                if l__VRService__7.VREnabled then
                    v217 = false;
                else
                    v217 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                end;
                if v217 then
                    l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
                end;
                local v218 = p216 + u191.CurrentIndex;
                u214(#u191.Selections < v218 and 1 or (v218 < 1 and #u191.Selections or v218), u191.CurrentIndex < v218 and 1 or -1);
            end;
        end;
    end;
    local u220 = nil;
    u191.IndexChanged = u192.Event;
    function u191.SetSelectionIndex(_, p221) --[[ Line: 1174 ]]
        -- upvalues: u214 (copy)
        u214(p221, 1);
    end;
    function u191.GetSelectedIndex(_) --[[ Line: 1178 ]]
        -- upvalues: u191 (copy)
        return u191.CurrentIndex;
    end;
    function u191.SetZIndex(_, p222) --[[ Line: 1182 ]]
        -- upvalues: u194 (copy), u195 (copy), u196 (copy), u197 (copy), u191 (copy)
        u194.ZIndex = p222;
        u195.ZIndex = p222;
        u196.ZIndex = p222;
        u197.ZIndex = p222;
        for v223 = 1, #u191.Selections do
            u191.Selections[v223].ZIndex = p222;
        end;
    end;
    function u191.SetInteractable(_, p224) --[[ Line: 1193 ]]
        -- upvalues: u193 (ref), u191 (copy), u194 (copy), u195 (copy), u196 (copy), u5 (ref), u197 (copy), u3 (ref)
        u193 = p224;
        u191.SelectorFrame.Selectable = u193;
        u194.Active = u193;
        u195.Active = u193;
        if u193 then
            for _, v225 in pairs(u191.Selections) do
                v225.TextColor3 = Color3.fromRGB(255, 255, 255);
            end;
            u196.ImageColor3 = u3;
            u197.ImageColor3 = u3;
        else
            for _, v226 in pairs(u191.Selections) do
                v226.TextColor3 = Color3.fromRGB(49, 49, 49);
            end;
            u196.ImageColor3 = u5;
            u197.ImageColor3 = u5;
        end;
    end;
    function u191.UpdateOptions(_, p227) --[[ Line: 1215 ]]
        -- upvalues: u191 (copy), u202 (ref), u15 (ref), u194 (copy), u189 (copy), u195 (copy)
        for _, v228 in pairs(u191.Selections) do
            v228:Destroy();
        end;
        u202 = {};
        u191.Selections = {};
        for v229, v230 in pairs(p227) do
            local v231 = u15.Create("TextLabel")({
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                TextTransparency = 0.5,
                TextSize = 24,
                ZIndex = 2,
                Visible = false,
                Name = "Selection" .. tostring(v229),
                Size = UDim2.new(1, u194.Size.X.Offset * -2, 1, 0),
                Position = UDim2.new(1, 0, 0, 0),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextYAlignment = Enum.TextYAlignment.Center,
                Font = Enum.Font.SourceSans,
                Text = v230,
                Parent = u191.SelectorFrame
            });
            if false then
                v231.TextSize = 36;
            end;
            if v229 == u189 then
                u191.CurrentIndex = v229;
                v231.Position = UDim2.new(0, u194.Size.X.Offset, 0, 0);
                v231.Visible = true;
                u202[v231] = true;
            else
                u202[v231] = false;
            end;
            u191.Selections[v229] = v231;
        end;
        local v232 = #u191.Selections > 1;
        u194.Visible = v232;
        u195.Visible = v232;
    end;
    l__VRService__7.Changed:Connect(function(p233) --[[ Name: onVREnabled, Line 1264 ]]
        -- upvalues: l__VRService__7 (ref), u194 (copy), u195 (copy), u204 (copy)
        if p233 == "VREnabled" then
            local l__VREnabled__11 = l__VRService__7.VREnabled;
            u194.Selectable = l__VREnabled__11;
            u195.Selectable = l__VREnabled__11;
            u204.Selectable = l__VREnabled__11;
        end;
    end);
    local l__VREnabled__12 = l__VRService__7.VREnabled;
    u194.Selectable = l__VREnabled__12;
    u195.Selectable = l__VREnabled__12;
    u204.Selectable = l__VREnabled__12;
    u194.InputBegan:Connect(function(p234) --[[ Line: 1276 ]]
        -- upvalues: u193 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u191 (copy), u214 (copy)
        if p234.UserInputType == Enum.UserInputType.Touch then
            if not u193 then
                return;
            end;
            local v235;
            if l__VRService__7.VREnabled then
                v235 = false;
            else
                v235 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v235 then
                l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
            end;
            local v236 = -1 + u191.CurrentIndex;
            u214(#u191.Selections < v236 and 1 or (v236 < 1 and #u191.Selections or v236), u191.CurrentIndex < v236 and 1 or -1);
        end;
    end);
    u194.MouseButton1Click:Connect(function() --[[ Line: 1281 ]]
        -- upvalues: l__UserInputService__2 (ref), u193 (ref), l__VRService__7 (ref), l__GuiService__3 (ref), u191 (copy), u214 (copy)
        if not l__UserInputService__2.TouchEnabled then
            if not u193 then
                return;
            end;
            local v237;
            if l__VRService__7.VREnabled then
                v237 = false;
            else
                v237 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v237 then
                l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
            end;
            local v238 = -1 + u191.CurrentIndex;
            u214(#u191.Selections < v238 and 1 or (v238 < 1 and #u191.Selections or v238), u191.CurrentIndex < v238 and 1 or -1);
        end;
    end);
    u195.InputBegan:Connect(function(p239) --[[ Line: 1286 ]]
        -- upvalues: u193 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u191 (copy), u214 (copy)
        if p239.UserInputType == Enum.UserInputType.Touch then
            if not u193 then
                return;
            end;
            local v240;
            if l__VRService__7.VREnabled then
                v240 = false;
            else
                v240 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v240 then
                l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
            end;
            local v241 = 1 + u191.CurrentIndex;
            u214(#u191.Selections < v241 and 1 or (v241 < 1 and #u191.Selections or v241), u191.CurrentIndex < v241 and 1 or -1);
        end;
    end);
    u195.MouseButton1Click:Connect(function() --[[ Line: 1291 ]]
        -- upvalues: l__UserInputService__2 (ref), u193 (ref), l__VRService__7 (ref), l__GuiService__3 (ref), u191 (copy), u214 (copy)
        if not l__UserInputService__2.TouchEnabled then
            if not u193 then
                return;
            end;
            local v242;
            if l__VRService__7.VREnabled then
                v242 = false;
            else
                v242 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v242 then
                l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
            end;
            local v243 = 1 + u191.CurrentIndex;
            u214(#u191.Selections < v243 and 1 or (v243 < 1 and #u191.Selections or v243), u191.CurrentIndex < v243 and 1 or -1);
        end;
    end);
    local u244 = true;
    u191:UpdateOptions(p188);
    l__UserInputService__2.InputBegan:Connect(function(p245) --[[ Line: 1300 ]]
        -- upvalues: u193 (ref), u244 (ref), l__GuiService__3 (ref), u191 (copy), l__VRService__7 (ref), l__UserInputService__2 (ref), u214 (copy)
        if u193 then
            if u244 then
                if p245.UserInputType == Enum.UserInputType.Gamepad1 or p245.UserInputType == Enum.UserInputType.Keyboard then
                    if l__GuiService__3.SelectedCoreObject == u191.SelectorFrame then
                        if p245.KeyCode == Enum.KeyCode.DPadLeft or (p245.KeyCode == Enum.KeyCode.Left or p245.KeyCode == Enum.KeyCode.A) then
                            if u193 then
                                if p245 == nil or (p245.UserInputType == Enum.UserInputType.MouseButton1 or (p245.UserInputType == Enum.UserInputType.Gamepad1 or (p245.UserInputType == Enum.UserInputType.Gamepad2 or (p245.UserInputType == Enum.UserInputType.Gamepad3 or (p245.UserInputType == Enum.UserInputType.Gamepad4 or p245.UserInputType == Enum.UserInputType.Keyboard))))) then
                                    local v246;
                                    if l__VRService__7.VREnabled then
                                        v246 = false;
                                    else
                                        v246 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                                    end;
                                    if v246 then
                                        l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
                                    end;
                                    local v247 = -1 + u191.CurrentIndex;
                                    u214(#u191.Selections < v247 and 1 or (v247 < 1 and #u191.Selections or v247), u191.CurrentIndex < v247 and 1 or -1);
                                end;
                            end;
                        else
                            if p245.KeyCode == Enum.KeyCode.DPadRight or (p245.KeyCode == Enum.KeyCode.Right or p245.KeyCode == Enum.KeyCode.D) then
                                if not u193 then
                                    return;
                                end;
                                if p245 ~= nil and (p245.UserInputType ~= Enum.UserInputType.MouseButton1 and (p245.UserInputType ~= Enum.UserInputType.Gamepad1 and (p245.UserInputType ~= Enum.UserInputType.Gamepad2 and (p245.UserInputType ~= Enum.UserInputType.Gamepad3 and (p245.UserInputType ~= Enum.UserInputType.Gamepad4 and p245.UserInputType ~= Enum.UserInputType.Keyboard))))) then
                                    return;
                                end;
                                local v248;
                                if l__VRService__7.VREnabled then
                                    v248 = false;
                                else
                                    v248 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                                end;
                                if v248 then
                                    l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
                                end;
                                local v249 = 1 + u191.CurrentIndex;
                                u214(#u191.Selections < v249 and 1 or (v249 < 1 and #u191.Selections or v249), u191.CurrentIndex < v249 and 1 or -1);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
    l__UserInputService__2.InputChanged:Connect(function(p250) --[[ Line: 1314 ]]
        -- upvalues: u193 (ref), u244 (ref), u190 (ref), l__GuiService__3 (ref), u191 (copy), u219 (copy)
        if u193 then
            if u244 then
                if p250.UserInputType == Enum.UserInputType.Gamepad1 then
                    local l__SelectedCoreObject__13 = l__GuiService__3.SelectedCoreObject;
                    if l__SelectedCoreObject__13 and l__SelectedCoreObject__13:IsDescendantOf(u191.SelectorFrame.Parent) then
                        if p250.KeyCode == Enum.KeyCode.Thumbstick1 then
                            if p250.Position.X > 0.8 and (p250.Delta.X > 0 and u190 ~= 1) then
                                u190 = 1;
                                u219(p250, u190);
                            elseif p250.Position.X < -0.8 and (p250.Delta.X < 0 and u190 ~= -1) then
                                u190 = -1;
                                u219(p250, u190);
                            else
                                if math.abs(p250.Position.X) < 0.8 then
                                    u190 = 0;
                                end;
                            end;
                        end;
                    end;
                end;
            else
                u190 = 0;
            end;
        end;
    end);
    u191.SelectorFrame.AncestryChanged:Connect(function(_, p251) --[[ Line: 1337 ]]
        -- upvalues: u244 (ref), u220 (ref), l__GuiService__3 (ref), u191 (copy), u203 (copy), l__VRService__7 (ref)
        u244 = p251;
        if u244 then
            u220 = l__GuiService__3:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 1150 ]]
                -- upvalues: u191 (ref), l__GuiService__3 (ref), u203 (ref), l__VRService__7 (ref)
                if #u191.Selections <= 0 then
                elseif l__GuiService__3.SelectedCoreObject == u191.SelectorFrame then
                    u191.Selections[u191.CurrentIndex].TextTransparency = 0;
                elseif l__GuiService__3.SelectedCoreObject == nil or not u203[l__GuiService__3.SelectedCoreObject] then
                    u191.Selections[u191.CurrentIndex].TextTransparency = 0.5;
                elseif l__VRService__7.VREnabled then
                    u191.Selections[u191.CurrentIndex].TextTransparency = 0;
                else
                    l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
                end;
            end);
        elseif u220 then
            u220:Disconnect();
        end;
    end);
    u16[u191.SelectorFrame] = function(_, p252) --[[ Name: onResized, Line 1346 ]]
        -- upvalues: u191 (copy)
        local v253 = p252 and 16 or 24;
        for _, v254 in pairs(u191.Selections) do
            v254.TextSize = v253;
        end;
    end;
    u60();
    local v255 = u60();
    local v256 = v255.Y > v255.X and 16 or 24;
    for _, v257 in pairs(u191.Selections) do
        v257.TextSize = v256;
    end;
    u220 = l__GuiService__3:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 1150 ]]
        -- upvalues: u191 (copy), l__GuiService__3 (ref), u203 (copy), l__VRService__7 (ref)
        if #u191.Selections <= 0 then
        elseif l__GuiService__3.SelectedCoreObject == u191.SelectorFrame then
            u191.Selections[u191.CurrentIndex].TextTransparency = 0;
        elseif l__GuiService__3.SelectedCoreObject == nil or not u203[l__GuiService__3.SelectedCoreObject] then
            u191.Selections[u191.CurrentIndex].TextTransparency = 0.5;
        elseif l__VRService__7.VREnabled then
            u191.Selections[u191.CurrentIndex].TextTransparency = 0;
        else
            l__GuiService__3.SelectedCoreObject = u191.SelectorFrame;
        end;
    end);
    return u191;
end;
local function u277(p259, p260, u261, u262, p263) --[[ Line: 1365 ]]
    -- upvalues: l__PlayerGui__5 (copy), l__VRService__7 (copy), u15 (copy), l__HttpService__1 (copy), l__ContextActionService__6 (copy), l__GuiService__3 (copy), u106 (copy), l__UserInputService__2 (copy)
    local l__RobloxGui__14 = l__PlayerGui__5.RobloxGui;
    if l__RobloxGui__14:FindFirstChild("AlertViewFullScreen") then
    else
        local u264 = nil;
        local function v267(p265) --[[ Line: 1374 ]]
            -- upvalues: l__VRService__7 (ref), l__PlayerGui__5 (ref), l__RobloxGui__14 (ref), u264 (ref)
            if p265 == "VREnabled" then
                local v266 = nil;
                if l__VRService__7.VREnabled then
                    v266 = require(l__PlayerGui__5.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu");
                    l__RobloxGui__14 = v266:GetGUI();
                else
                    l__RobloxGui__14 = l__PlayerGui__5.RobloxGui;
                end;
                if u264 and u264.Parent ~= nil then
                    u264.Parent = l__RobloxGui__14;
                    if l__VRService__7.VREnabled then
                        v266:SetSubpanelDepth(u264, 0.5);
                    end;
                end;
            end;
        end;
        local u268 = l__VRService__7.Changed:Connect(v267);
        Color3.fromRGB(59, 166, 241);
        Color3.fromRGB(255, 255, 255);
        u264 = u15.Create("ImageLabel")({
            Name = "AlertViewBacking",
            Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
            BackgroundTransparency = 1,
            ImageTransparency = 1,
            ZIndex = 9,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 6, 46, 44),
            Size = UDim2.new(0, 400, 0, 350),
            Position = UDim2.new(0.5, -200, 0.5, -175),
            Parent = l__RobloxGui__14
        });
        v267("VREnabled");
        if p263 or l__VRService__7.VREnabled then
            u264.ImageTransparency = 0;
        else
            u264.Size = UDim2.new(0.8, 0, 0, 350);
            u264.Position = UDim2.new(0.1, 0, 0.1, 0);
        end;
        if l__PlayerGui__5.RobloxGui.AbsoluteSize.Y <= u264.Size.Y.Offset then
            u264.Size = UDim2.new(u264.Size.X.Scale, u264.Size.X.Offset, u264.Size.Y.Scale, l__PlayerGui__5.RobloxGui.AbsoluteSize.Y);
            u264.Position = UDim2.new(u264.Position.X.Scale, -u264.Size.X.Offset / 2, 0.5, -u264.Size.Y.Offset / 2);
        end;
        u15.Create("TextLabel")({
            Name = "AlertViewText",
            BackgroundTransparency = 1,
            TextSize = 36,
            TextWrapped = true,
            ZIndex = 10,
            Size = UDim2.new(0.95, 0, 0.6, 0),
            Position = UDim2.new(0.025, 0, 0.05, 0),
            Font = Enum.Font.SourceSansBold,
            Text = p259,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            Parent = u264
        });
        u15.Create("ImageLabel")({
            Image = "",
            BackgroundTransparency = 1
        });
        local u269 = l__HttpService__1:GenerateGUID(false);
        local function v271(_, p270) --[[ Line: 1449 ]]
            -- upvalues: l__VRService__7 (ref), u264 (ref), l__PlayerGui__5 (ref), u262 (copy), l__ContextActionService__6 (ref), u269 (copy), l__GuiService__3 (ref), u261 (copy), u268 (copy)
            if l__VRService__7.VREnabled and (p270 == Enum.UserInputState.Begin or p270 == Enum.UserInputState.Cancel) then
            elseif u264 then
                if l__VRService__7.VREnabled then
                    require(l__PlayerGui__5.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(u264, 0);
                end;
                u264:Destroy();
                u264 = nil;
                if u262 then
                    u262();
                end;
                l__ContextActionService__6:UnbindAction(u269);
                l__GuiService__3.SelectedCoreObject = nil;
                if u261 then
                    u261:ShowBar();
                end;
                if u268 then
                    u268:Disconnect();
                end;
            end;
        end;
        local v272 = UDim2.new(1, -20, 0, 60);
        local v273 = UDim2.new(0, 10, 0.65, 0);
        if not p263 then
            v272 = UDim2.new(0, 200, 0, 50);
            v273 = UDim2.new(0.5, -100, 0.65, 0);
        end;
        local v274, v275 = u106("AlertViewButton", p260, v272, v271);
        v274.Position = v273;
        v274.NextSelectionLeft = v274;
        v274.NextSelectionRight = v274;
        v274.NextSelectionUp = v274;
        v274.NextSelectionDown = v274;
        v274.ZIndex = 9;
        v275.ZIndex = v274.ZIndex;
        v274.Parent = u264;
        local v276;
        if l__VRService__7.VREnabled then
            v276 = false;
        else
            v276 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
        end;
        if v276 then
            l__GuiService__3.SelectedCoreObject = v274;
        end;
        l__GuiService__3.SelectedCoreObject = v274;
        l__ContextActionService__6:BindActionAtPriority(u269, v271, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonA);
        if u261 and not l__VRService__7.VREnabled then
            u261:HideBar();
            u261.Pages.CurrentPage:Hide(1, 1);
        end;
    end;
end;
local function u359(p278, p279, u280) --[[ Line: 1506 ]]
    -- upvalues: l__HttpService__1 (copy), u15 (copy), u17 (copy), l__UserInputService__2 (copy), u4 (copy), u3 (copy), u4 (copy), u67 (copy), u60 (copy), u1 (copy), u2 (copy), l__VRService__7 (copy), l__GuiService__3 (copy), l__RunService__4 (copy)
    local u281 = {};
    local u282 = tonumber(p278);
    local u283 = p279;
    local u284 = 0;
    local u285 = nil;
    local u286 = true;
    local u287 = l__HttpService__1:GenerateGUID(false);
    if u282 > 0 then
        local u288 = Instance.new("BindableEvent");
        u288.Name = "ValueChanged";
        u281.SliderFrame = u15.Create("ImageButton")({
            Name = "Slider",
            Image = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            ZIndex = 2,
            NextSelectionLeft = u281.SliderFrame,
            NextSelectionRight = u281.SliderFrame,
            Size = UDim2.new(0.6, 0, 0, 50),
            Position = UDim2.new(1, 0, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            SelectionImageObject = u17
        });
        u281.StepsContainer = u15.Create("Frame")({
            Name = "StepsContainer",
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, -100, 1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Parent = u281.SliderFrame
        });
        local u289 = u15.Create("ImageButton")({
            Name = "LeftButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            Active = true,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0, 50, 0, 50),
            SelectionImageObject = u17,
            Parent = u281.SliderFrame
        });
        local u290 = u15.Create("ImageButton")({
            Name = "RightButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            Active = true,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0, 50, 0, 50),
            SelectionImageObject = u17,
            Parent = u281.SliderFrame
        });
        local u291 = u15.Create("ImageLabel")({
            Name = "LeftButton",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/Slider/Less.png",
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 30, 0, 30),
            Parent = u289,
            ImageColor3 = l__UserInputService__2.TouchEnabled and u4 or u3
        });
        local u292 = u15.Create("ImageLabel")({
            Name = "RightButton",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/Slider/More.png",
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 30, 0, 30),
            Parent = u290,
            ImageColor3 = l__UserInputService__2.TouchEnabled and u4 or u3
        });
        if not l__UserInputService__2.TouchEnabled then
            local function v294(p293) --[[ Line: 1615 ]]
                -- upvalues: u3 (ref)
                p293.ImageColor3 = u3;
            end;
            local function v296(p295) --[[ Line: 1616 ]]
                -- upvalues: u4 (ref)
                p295.ImageColor3 = u4;
            end;
            u67(u289, u291, v294, v296);
            u67(u290, u292, v294, v296);
        end;
        u281.Steps = {};
        local v297 = u60();
        local l__TouchEnabled__15 = l__UserInputService__2.TouchEnabled;
        if l__TouchEnabled__15 then
            l__TouchEnabled__15 = v297.Y < 500 and true or v297.X < 700;
        end;
        local v298 = 1 / u282;
        for v299 = 1, u282 do
            local v300 = u15.Create("ImageButton")({
                BackgroundTransparency = 0.36,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Active = false,
                Image = "",
                ZIndex = 3,
                Selectable = false,
                ImageTransparency = 0.36,
                Name = "Step" .. tostring(v299),
                BackgroundColor3 = u1,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new((v299 - 1) * v298, 2, 0.5, 0),
                Size = UDim2.new(v298, -4, 0.48, 0),
                Parent = u281.StepsContainer,
                SelectionImageObject = u17
            });
            if u283 < v299 then
                v300.BackgroundColor3 = u2;
            end;
            if v299 == 1 or v299 == u282 then
                v300.BackgroundTransparency = 1;
                v300.ScaleType = Enum.ScaleType.Slice;
                v300.SliceCenter = Rect.new(3, 3, 32, 21);
                if v299 <= u283 then
                    if v299 == 1 then
                        v300.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png";
                    else
                        v300.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png";
                    end;
                elseif v299 == 1 then
                    v300.Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png";
                else
                    v300.Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png";
                end;
            end;
            u281.Steps[#u281.Steps + 1] = v300;
        end;
        local function u302() --[[ Line: 1680 ]]
            -- upvalues: u282 (copy), u281 (copy), u2 (ref)
            for v301 = 1, u282 do
                u281.Steps[v301].BackgroundColor3 = u2;
                if v301 == 1 then
                    u281.Steps[v301].Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png";
                elseif v301 == u282 then
                    u281.Steps[v301].Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png";
                end;
            end;
        end;
        local function u304() --[[ Line: 1690 ]]
            -- upvalues: u282 (copy), u283 (ref), u281 (copy), u1 (ref)
            for v303 = 1, u282 do
                if u283 < v303 then
                    break;
                end;
                u281.Steps[v303].BackgroundColor3 = u1;
                if v303 == 1 then
                    u281.Steps[v303].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png";
                elseif v303 == u282 then
                    u281.Steps[v303].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png";
                end;
            end;
        end;
        local function u306(p305) --[[ Line: 1711 ]]
            -- upvalues: u280 (ref), u289 (copy), u290 (copy), u282 (copy), u283 (ref), u302 (copy), u304 (copy), u285 (ref), u288 (copy)
            if not u280 then
                u280 = 0;
            end;
            u289.Visible = true;
            u290.Visible = true;
            if p305 <= u280 then
                p305 = u280;
                u289.Visible = false;
            end;
            if u282 <= p305 then
                p305 = u282;
                u290.Visible = false;
            end;
            if u283 == p305 then
            else
                u283 = p305;
                u302();
                u304();
                u285 = tick();
                u288:Fire(u283);
            end;
        end;
        local function u318(p307, p308, p309) --[[ Line: 1741 ]]
            -- upvalues: u286 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u281 (copy), u284 (ref), u283 (ref), u282 (copy), u306 (copy)
            if u286 then
                if p307 == nil then
                else
                    local v310;
                    if p307 then
                        if p307.UserInputType == Enum.UserInputType.MouseButton1 or p307.UserInputType == Enum.UserInputType.Touch then
                            v310 = true;
                        elseif p307.UserInputType == Enum.UserInputType.Gamepad1 then
                            v310 = p307.KeyCode == Enum.KeyCode.ButtonA;
                        else
                            v310 = false;
                        end;
                    else
                        v310 = false;
                    end;
                    if v310 then
                        local v311;
                        if l__VRService__7.VREnabled then
                            v311 = false;
                        else
                            v311 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                        end;
                        if v311 and not l__VRService__7.VREnabled then
                            l__GuiService__3.SelectedCoreObject = u281.SliderFrame;
                        end;
                        if l__VRService__7.VREnabled then
                            u284 = 0;
                        elseif p309 then
                            u284 = p308 - u283;
                        else
                            u284 = 0;
                            local u312 = nil;
                            local u315 = l__UserInputService__2.InputChanged:Connect(function(p313) --[[ Line: 1761 ]]
                                -- upvalues: u282 (ref), u281 (ref), u306 (ref)
                                if p313.UserInputType == Enum.UserInputType.MouseMovement then
                                    local l__X__16 = p313.Position.X;
                                    for v314 = 1, u282 do
                                        local l__X__17 = u281.Steps[v314].AbsolutePosition.X;
                                        if l__X__17 <= l__X__16 and l__X__16 <= l__X__17 + u281.Steps[v314].AbsoluteSize.X then
                                            u306(v314);
                                            return;
                                        end;
                                        if v314 == 1 and l__X__16 < l__X__17 then
                                            u306(0);
                                            return;
                                        end;
                                        if v314 == u282 and l__X__17 <= l__X__16 then
                                            u306(v314);
                                            return;
                                        end;
                                    end;
                                end;
                            end);
                            u312 = l__UserInputService__2.InputEnded:Connect(function(p316) --[[ Line: 1780 ]]
                                -- upvalues: u284 (ref), u312 (ref), u315 (ref)
                                local v317;
                                if p316 then
                                    if p316.UserInputType == Enum.UserInputType.MouseButton1 or p316.UserInputType == Enum.UserInputType.Touch then
                                        v317 = true;
                                    elseif p316.UserInputType == Enum.UserInputType.Gamepad1 then
                                        v317 = p316.KeyCode == Enum.KeyCode.ButtonA;
                                    else
                                        v317 = false;
                                    end;
                                else
                                    v317 = false;
                                end;
                                if v317 then
                                    u284 = 0;
                                    u312:Disconnect();
                                    u315:Disconnect();
                                end;
                            end);
                        end;
                        u306(p308);
                    end;
                end;
            end;
        end;
        u281.ValueChanged = u288.Event;
        function u281.SetValue(_, p319) --[[ Line: 1809 ]]
            -- upvalues: u306 (copy)
            u306(p319);
        end;
        function u281.GetValue(_) --[[ Line: 1813 ]]
            -- upvalues: u283 (ref)
            return u283;
        end;
        function u281.SetInteractable(_, p320) --[[ Line: 1817 ]]
            -- upvalues: u284 (ref), u286 (ref), u281 (copy), u302 (copy), u304 (copy)
            u284 = 0;
            u286 = p320;
            u281.SliderFrame.Selectable = p320;
            if u286 then
                u304();
            else
                u302();
            end;
        end;
        function u281.SetZIndex(_, p321) --[[ Line: 1828 ]]
            -- upvalues: u289 (copy), u290 (copy), u291 (copy), u292 (copy), u281 (copy)
            u289.ZIndex = p321;
            u290.ZIndex = p321;
            u291.ZIndex = p321;
            u292.ZIndex = p321;
            for v322 = 1, #u281.Steps do
                u281.Steps[v322].ZIndex = p321;
            end;
        end;
        function u281.SetMinStep(_, p323) --[[ Line: 1839 ]]
            -- upvalues: u282 (copy), u280 (ref), u283 (ref), u289 (copy), u290 (copy)
            if p323 >= 0 and p323 <= u282 then
                u280 = p323;
            end;
            if u283 <= u280 then
                u283 = u280;
                u289.Visible = false;
            end;
            if u282 <= u283 then
                u283 = u282;
                u290.Visible = false;
            end;
        end;
        u289.InputBegan:Connect(function(p324) --[[ Line: 1856 ]]
            -- upvalues: u283 (ref), u286 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u281 (copy), u284 (ref), u306 (copy)
            local v325 = u283 - 1;
            if u286 then
                if p324 == nil then
                else
                    local v326;
                    if p324 then
                        if p324.UserInputType == Enum.UserInputType.MouseButton1 or p324.UserInputType == Enum.UserInputType.Touch then
                            v326 = true;
                        elseif p324.UserInputType == Enum.UserInputType.Gamepad1 then
                            v326 = p324.KeyCode == Enum.KeyCode.ButtonA;
                        else
                            v326 = false;
                        end;
                    else
                        v326 = false;
                    end;
                    if v326 then
                        local v327;
                        if l__VRService__7.VREnabled then
                            v327 = false;
                        else
                            v327 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                        end;
                        if v327 and not l__VRService__7.VREnabled then
                            l__GuiService__3.SelectedCoreObject = u281.SliderFrame;
                        end;
                        if l__VRService__7.VREnabled then
                            u284 = 0;
                        else
                            u284 = v325 - u283;
                        end;
                        u306(v325);
                    end;
                end;
            end;
        end);
        u289.InputEnded:Connect(function(p328) --[[ Line: 1857 ]]
            -- upvalues: u286 (ref), u284 (ref)
            if u286 then
                local v329;
                if p328 then
                    if p328.UserInputType == Enum.UserInputType.MouseButton1 or p328.UserInputType == Enum.UserInputType.Touch then
                        v329 = true;
                    elseif p328.UserInputType == Enum.UserInputType.Gamepad1 then
                        v329 = p328.KeyCode == Enum.KeyCode.ButtonA;
                    else
                        v329 = false;
                    end;
                else
                    v329 = false;
                end;
                if v329 then
                    u284 = 0;
                end;
            end;
        end);
        u290.InputBegan:Connect(function(p330) --[[ Line: 1858 ]]
            -- upvalues: u283 (ref), u286 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u281 (copy), u284 (ref), u306 (copy)
            local v331 = u283 + 1;
            if u286 then
                if p330 == nil then
                else
                    local v332;
                    if p330 then
                        if p330.UserInputType == Enum.UserInputType.MouseButton1 or p330.UserInputType == Enum.UserInputType.Touch then
                            v332 = true;
                        elseif p330.UserInputType == Enum.UserInputType.Gamepad1 then
                            v332 = p330.KeyCode == Enum.KeyCode.ButtonA;
                        else
                            v332 = false;
                        end;
                    else
                        v332 = false;
                    end;
                    if v332 then
                        local v333;
                        if l__VRService__7.VREnabled then
                            v333 = false;
                        else
                            v333 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                        end;
                        if v333 and not l__VRService__7.VREnabled then
                            l__GuiService__3.SelectedCoreObject = u281.SliderFrame;
                        end;
                        if l__VRService__7.VREnabled then
                            u284 = 0;
                        else
                            u284 = v331 - u283;
                        end;
                        u306(v331);
                    end;
                end;
            end;
        end);
        u290.InputEnded:Connect(function(p334) --[[ Line: 1859 ]]
            -- upvalues: u286 (ref), u284 (ref)
            if u286 then
                local v335;
                if p334 then
                    if p334.UserInputType == Enum.UserInputType.MouseButton1 or p334.UserInputType == Enum.UserInputType.Touch then
                        v335 = true;
                    elseif p334.UserInputType == Enum.UserInputType.Gamepad1 then
                        v335 = p334.KeyCode == Enum.KeyCode.ButtonA;
                    else
                        v335 = false;
                    end;
                else
                    v335 = false;
                end;
                if v335 then
                    u284 = 0;
                end;
            end;
        end);
        local function v339(p336) --[[ Line: 1861 ]]
            -- upvalues: l__VRService__7 (ref), u289 (copy), u286 (ref), u290 (copy), u281 (copy), u282 (copy)
            if p336 == "VREnabled" then
                if l__VRService__7.VREnabled then
                    u289.Selectable = u286;
                    u290.Selectable = u286;
                    u281.SliderFrame.Selectable = u286;
                    for v337 = 1, u282 do
                        u281.Steps[v337].Selectable = u286;
                        u281.Steps[v337].Active = u286;
                    end;
                else
                    u289.Selectable = false;
                    u290.Selectable = false;
                    u281.SliderFrame.Selectable = u286;
                    for v338 = 1, u282 do
                        u281.Steps[v338].Selectable = false;
                        u281.Steps[v338].Active = false;
                    end;
                end;
            end;
        end;
        l__VRService__7.Changed:Connect(v339);
        v339("VREnabled");
        local function u342(p340) --[[ Line: 1701 ]]
            -- upvalues: u282 (copy), u281 (copy)
            for v341 = 1, u282 do
                if v341 == 1 or v341 == u282 then
                    u281.Steps[v341].ImageTransparency = p340;
                else
                    u281.Steps[v341].BackgroundTransparency = p340;
                end;
            end;
        end;
        for u343 = 1, u282 do
            u281.Steps[u343].InputBegan:Connect(function(p344) --[[ Line: 1888 ]]
                -- upvalues: u318 (copy), u343 (copy)
                u318(p344, u343);
            end);
            u281.Steps[u343].InputEnded:Connect(function(p345) --[[ Line: 1891 ]]
                -- upvalues: u286 (ref), u284 (ref)
                if u286 then
                    local v346;
                    if p345 then
                        if p345.UserInputType == Enum.UserInputType.MouseButton1 or p345.UserInputType == Enum.UserInputType.Touch then
                            v346 = true;
                        elseif p345.UserInputType == Enum.UserInputType.Gamepad1 then
                            v346 = p345.KeyCode == Enum.KeyCode.ButtonA;
                        else
                            v346 = false;
                        end;
                    else
                        v346 = false;
                    end;
                    if v346 then
                        u284 = 0;
                    end;
                end;
            end);
        end;
        u281.SliderFrame.InputBegan:Connect(function(p347) --[[ Line: 1895 ]]
            -- upvalues: l__VRService__7 (ref), l__GuiService__3 (ref), u281 (copy), u318 (copy), u283 (ref)
            if l__VRService__7.VREnabled then
                local l__SelectedCoreObject__18 = l__GuiService__3.SelectedCoreObject;
                if not (l__SelectedCoreObject__18 and l__SelectedCoreObject__18:IsDescendantOf(u281.SliderFrame.Parent)) then
                    return;
                end;
            end;
            u318(p347, u283);
        end);
        u281.SliderFrame.InputEnded:Connect(function(p348) --[[ Line: 1902 ]]
            -- upvalues: l__VRService__7 (ref), l__GuiService__3 (ref), u281 (copy), u286 (ref), u284 (ref)
            if l__VRService__7.VREnabled then
                local l__SelectedCoreObject__19 = l__GuiService__3.SelectedCoreObject;
                if not (l__SelectedCoreObject__19 and l__SelectedCoreObject__19:IsDescendantOf(u281.SliderFrame.Parent)) then
                    return;
                end;
            end;
            if u286 then
                local v349;
                if p348 then
                    if p348.UserInputType == Enum.UserInputType.MouseButton1 or p348.UserInputType == Enum.UserInputType.Touch then
                        v349 = true;
                    elseif p348.UserInputType == Enum.UserInputType.Gamepad1 then
                        v349 = p348.KeyCode == Enum.KeyCode.ButtonA;
                    else
                        v349 = false;
                    end;
                else
                    v349 = false;
                end;
                if v349 then
                    u284 = 0;
                end;
            end;
        end);
        local function u350() --[[ Line: 1911 ]]
            -- upvalues: u285 (ref), u306 (copy), u283 (ref), u284 (ref)
            if u285 == nil then
            else
                if tick() - u285 >= 0.2 then
                    u306(u283 + u284);
                end;
            end;
        end;
        local u351 = true;
        local u352 = {
            [Enum.KeyCode.Thumbstick1] = true,
            [Enum.KeyCode.DPadLeft] = -1,
            [Enum.KeyCode.DPadRight] = 1,
            [Enum.KeyCode.Left] = -1,
            [Enum.KeyCode.Right] = 1,
            [Enum.KeyCode.A] = -1,
            [Enum.KeyCode.D] = 1,
            [Enum.KeyCode.ButtonA] = true
        };
        l__UserInputService__2.InputBegan:Connect(function(p353) --[[ Line: 1935 ]]
            -- upvalues: u286 (ref), u351 (ref), l__GuiService__3 (ref), u281 (copy), u352 (copy), u284 (ref), u306 (copy), u283 (ref)
            if u286 then
                if u351 then
                    if p353.UserInputType == Enum.UserInputType.Gamepad1 or p353.UserInputType == Enum.UserInputType.Keyboard then
                        local l__SelectedCoreObject__20 = l__GuiService__3.SelectedCoreObject;
                        if l__SelectedCoreObject__20 and l__SelectedCoreObject__20:IsDescendantOf(u281.SliderFrame.Parent) then
                            if u352[p353.KeyCode] == -1 then
                                u284 = -1;
                                u306(u283 - 1);
                            else
                                if u352[p353.KeyCode] == 1 then
                                    u284 = 1;
                                    u306(u283 + 1);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end);
        l__UserInputService__2.InputEnded:Connect(function(p354) --[[ Line: 1952 ]]
            -- upvalues: u286 (ref), l__GuiService__3 (ref), u281 (copy), u352 (copy), u284 (ref)
            if u286 then
                if p354.UserInputType == Enum.UserInputType.Gamepad1 or p354.UserInputType == Enum.UserInputType.Keyboard then
                    local l__SelectedCoreObject__21 = l__GuiService__3.SelectedCoreObject;
                    if l__SelectedCoreObject__21 and l__SelectedCoreObject__21:IsDescendantOf(u281.SliderFrame.Parent) then
                        if u352[p354.KeyCode] then
                            u284 = 0;
                        end;
                    end;
                end;
            end;
        end);
        l__UserInputService__2.InputChanged:Connect(function(p355) --[[ Line: 1964 ]]
            -- upvalues: u286 (ref), u284 (ref), u351 (ref), l__GuiService__3 (ref), u281 (copy), u306 (copy), u283 (ref)
            if u286 then
                if u351 then
                    if p355.UserInputType == Enum.UserInputType.Gamepad1 then
                        local l__SelectedCoreObject__22 = l__GuiService__3.SelectedCoreObject;
                        if l__SelectedCoreObject__22 and l__SelectedCoreObject__22:IsDescendantOf(u281.SliderFrame.Parent) then
                            if p355.KeyCode == Enum.KeyCode.Thumbstick1 then
                                if p355.Position.X > 0.8 and (p355.Delta.X > 0 and u284 ~= 1) then
                                    u284 = 1;
                                    u306(u283 + 1);
                                elseif p355.Position.X < -0.8 and (p355.Delta.X < 0 and u284 ~= -1) then
                                    u284 = -1;
                                    u306(u283 - 1);
                                else
                                    if math.abs(p355.Position.X) < 0.8 then
                                        u284 = 0;
                                    end;
                                end;
                            end;
                        end;
                    end;
                else
                    u284 = 0;
                end;
            else
                u284 = 0;
            end;
        end);
        local u356 = false;
        l__GuiService__3.Changed:Connect(function(p357) --[[ Line: 1991 ]]
            -- upvalues: l__GuiService__3 (ref), u281 (copy), u342 (copy), u356 (ref), u285 (ref), l__RunService__4 (ref), u287 (copy), u350 (copy)
            if p357 == "SelectedCoreObject" then
                local l__SelectedCoreObject__23 = l__GuiService__3.SelectedCoreObject;
                if l__SelectedCoreObject__23 then
                    l__SelectedCoreObject__23 = l__SelectedCoreObject__23:IsDescendantOf(u281.SliderFrame.Parent);
                end;
                if l__SelectedCoreObject__23 then
                    u342(0);
                    if not u356 then
                        u356 = true;
                        u285 = tick();
                        l__RunService__4:BindToRenderStep(u287, Enum.RenderPriority.Input.Value + 1, u350);
                    end;
                else
                    u342(0.36);
                    if u356 then
                        u356 = false;
                        l__RunService__4:UnbindFromRenderStep(u287);
                    end;
                end;
            end;
        end);
        u281.SliderFrame.AncestryChanged:Connect(function(_, p358) --[[ Line: 2012 ]]
            -- upvalues: u351 (ref)
            u351 = p358;
        end);
        u306(u283);
        return u281;
    end;
    error("CreateNewSlider failed because numOfSteps (first arg) is 0 or negative, please supply a positive integer", 2);
end;
local u360 = 50;
local u361 = {};
local function u416(u362, u363, p364, p365, p366, p367) --[[ Line: 2025 ]]
    -- upvalues: u361 (copy), u15 (copy), u360 (ref), u17 (copy), u8 (copy), u60 (copy), u16 (copy), u359 (copy), u258 (copy), u187 (copy), l__VRService__7 (copy), l__UserInputService__2 (copy), l__GuiService__3 (copy), l__PlayerGui__5 (copy)
    local v368 = p364 ~= "TextBox";
    local v369 = not u361[u362] and 0 or u361[u362];
    local u370 = u15.Create("ImageButton")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        ZIndex = 2,
        Selectable = false,
        Name = u363 .. "Frame",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(2, 2, 18, 18),
        Size = UDim2.new(1, 0, 0, u360),
        Position = UDim2.new(0, 0, 0, v369),
        SelectionImageObject = u17,
        Parent = u362.Page
    });
    u370.ImageColor3 = u370.BackgroundColor3;
    if u370 and p367 then
        u370.Position = UDim2.new(u370.Position.X.Scale, u370.Position.X.Offset, u370.Position.Y.Scale, u370.Position.Y.Offset + p367);
    end;
    local u371 = u15.Create("TextLabel")({
        TextSize = 16,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = u363 .. "Label",
        Text = u363,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Parent = u370
    });
    local u372 = Instance.new("UITextSizeConstraint");
    if u8 then
        u371.Size = UDim2.new(0.35, 0, 1, 0);
        u371.TextScaled = true;
        u371.TextWrapped = true;
        u372.Parent = u371;
        u372.MaxTextSize = 16;
    end;
    if not v368 then
        u371.Text = "";
    end;
    local function v374(_, p373) --[[ Line: 2088 ]]
        -- upvalues: u371 (ref), u372 (copy)
        if p373 then
            u371.TextSize = 16;
        else
            u371.TextSize = 24;
        end;
        u372.MaxTextSize = u371.TextSize;
    end;
    u60();
    local v375 = u60();
    if v375.Y > v375.X then
        u371.TextSize = 16;
    else
        u371.TextSize = 24;
    end;
    u372.MaxTextSize = u371.TextSize;
    u16[u370] = v374;
    u60();
    local v376 = u60();
    if v376.Y > v376.X then
        u371.TextSize = 16;
    else
        u371.TextSize = 24;
    end;
    u372.MaxTextSize = u371.TextSize;
    local u377 = nil;
    local u378 = nil;
    if p364 == "Slider" then
        u378 = u359(p365, p366);
        u378.SliderFrame.Parent = u370;
        u377 = u378.SliderFrame;
    elseif p364 == "Selector" then
        u378 = u258(p365, p366);
        u378.SelectorFrame.Parent = u370;
        u377 = u378.SelectorFrame;
    elseif p364 == "DropDown" then
        u378 = u187(p365, p366, u362.HubRef);
        u378.DropDownFrame.Parent = u370;
        u377 = u378.DropDownFrame;
    elseif p364 == "TextBox" then
        local u379 = false;
        local u380 = false;
        local v381 = u15.Create("ImageLabel")({
            Image = "",
            BackgroundTransparency = 1
        });
        u378 = {
            HubRef = nil
        };
        local u382 = u15.Create("TextBox")({
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            TextWrapped = true,
            TextSize = 24,
            ZIndex = 2,
            ClearTextOnFocus = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.6, 0, 1, 0),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = u363,
            TextColor3 = Color3.fromRGB(49, 49, 49),
            TextYAlignment = Enum.TextYAlignment.Top,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.SourceSans,
            SelectionImageObject = v381,
            Parent = u370
        });
        u377 = u382;
        u382.Focused:Connect(function() --[[ Line: 2146 ]]
            -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u382 (copy), u363 (copy)
            local v383;
            if l__VRService__7.VREnabled then
                v383 = false;
            else
                v383 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v383 then
                l__GuiService__3.SelectedCoreObject = u382;
            end;
            if u382.Text == u363 then
                u382.Text = "";
            end;
        end);
        u382.FocusLost:Connect(function(_, _) --[[ Line: 2155 ]]
            -- upvalues: u380 (ref)
            u380 = false;
        end);
        if p367 then
            u382.Position = UDim2.new(u382.Position.X.Scale, u382.Position.X.Offset, u382.Position.Y.Scale, u382.Position.Y.Offset + p367);
        end;
        u377.SelectionGained:Connect(function() --[[ Line: 2163 ]]
            -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), u382 (copy), u378 (ref), u377 (ref)
            local v384;
            if l__VRService__7.VREnabled then
                v384 = false;
            else
                v384 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v384 then
                u382.BackgroundTransparency = 0.1;
                if u378.HubRef then
                    u378.HubRef:ScrollToFrame(u377);
                end;
            end;
        end);
        u377.SelectionLost:Connect(function() --[[ Line: 2172 ]]
            -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), u382 (copy)
            local v385;
            if l__VRService__7.VREnabled then
                v385 = false;
            else
                v385 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v385 then
                u382.BackgroundTransparency = 0.5;
            end;
        end);
        local function v387(p386) --[[ Line: 2189 ]]
            -- upvalues: l__GuiService__3 (ref), u377 (ref), u380 (ref), u382 (copy)
            if p386.UserInputState == Enum.UserInputState.Begin and (p386.KeyCode == Enum.KeyCode.Return and l__GuiService__3.SelectedCoreObject == u377) then
                u380 = true;
                u382:CaptureFocus();
            end;
        end;
        u382.MouseEnter:Connect(function() --[[ Line: 2178 ]]
            -- upvalues: l__PlayerGui__5 (ref), u377 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), u362 (copy), l__GuiService__3 (ref), u379 (ref)
            local v388 = l__PlayerGui__5.RobloxGui:FindFirstChild("DropDownFullscreenFrame");
            if v388 and v388.Visible then
            else
                local v389 = u377;
                if v389 and (v389.Visible and v389.ZIndex > 1) then
                    local v390;
                    if l__VRService__7.VREnabled then
                        v390 = false;
                    else
                        v390 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                    end;
                    if v390 and u362.Active then
                        l__GuiService__3.SelectedCoreObject = v389;
                        u379 = true;
                    end;
                end;
            end;
        end);
        l__UserInputService__2.InputBegan:Connect(v387);
    elseif p364 == "TextEntry" then
        local u391 = false;
        local u392 = false;
        local v393 = u15.Create("ImageLabel")({
            Image = "",
            BackgroundTransparency = 1
        });
        u378 = {
            HubRef = nil
        };
        local u394 = u15.Create("TextBox")({
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextWrapped = false,
            TextSize = 24,
            ZIndex = 2,
            ClearTextOnFocus = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.4, -10, 0, 40),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = u363,
            TextColor3 = Color3.fromRGB(178, 178, 178),
            TextYAlignment = Enum.TextYAlignment.Center,
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.SourceSans,
            SelectionImageObject = v393,
            Parent = u370
        });
        u377 = u394;
        u394.Focused:Connect(function() --[[ Line: 2236 ]]
            -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), l__GuiService__3 (ref), u394 (copy), u363 (copy)
            local v395;
            if l__VRService__7.VREnabled then
                v395 = false;
            else
                v395 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v395 then
                l__GuiService__3.SelectedCoreObject = u394;
            end;
            if u394.Text == u363 then
                u394.Text = "";
            end;
        end);
        u394.FocusLost:Connect(function(_, _) --[[ Line: 2245 ]]
            -- upvalues: u392 (ref)
            u392 = false;
        end);
        if p367 then
            u394.Position = UDim2.new(u394.Position.X.Scale, u394.Position.X.Offset, u394.Position.Y.Scale, u394.Position.Y.Offset + p367);
        end;
        u377.SelectionGained:Connect(function() --[[ Line: 2253 ]]
            -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), u394 (copy), u378 (ref), u377 (ref)
            local v396;
            if l__VRService__7.VREnabled then
                v396 = false;
            else
                v396 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v396 then
                u394.BackgroundTransparency = 0.8;
                if u378.HubRef then
                    u378.HubRef:ScrollToFrame(u377);
                end;
            end;
        end);
        u377.SelectionLost:Connect(function() --[[ Line: 2262 ]]
            -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), u394 (copy)
            local v397;
            if l__VRService__7.VREnabled then
                v397 = false;
            else
                v397 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v397 then
                u394.BackgroundTransparency = 1;
            end;
        end);
        local function v399(p398) --[[ Line: 2279 ]]
            -- upvalues: l__GuiService__3 (ref), u377 (ref), u392 (ref), u394 (copy)
            if p398.UserInputState == Enum.UserInputState.Begin and (p398.KeyCode == Enum.KeyCode.Return and l__GuiService__3.SelectedCoreObject == u377) then
                u392 = true;
                u394:CaptureFocus();
            end;
        end;
        u370.MouseEnter:Connect(function() --[[ Line: 2268 ]]
            -- upvalues: l__PlayerGui__5 (ref), u377 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), u362 (copy), l__GuiService__3 (ref), u391 (ref)
            local v400 = l__PlayerGui__5.RobloxGui:FindFirstChild("DropDownFullscreenFrame");
            if v400 and v400.Visible then
            else
                local v401 = u377;
                if v401 and (v401.Visible and v401.ZIndex > 1) then
                    local v402;
                    if l__VRService__7.VREnabled then
                        v402 = false;
                    else
                        v402 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                    end;
                    if v402 and u362.Active then
                        l__GuiService__3.SelectedCoreObject = v401;
                        u391 = true;
                    end;
                end;
            end;
        end);
        function u378.SetZIndex(_, p403) --[[ Line: 2291 ]]
            -- upvalues: u394 (copy)
            u394.ZIndex = p403;
        end;
        function u378.SetInteractable(_, p404) --[[ Line: 2295 ]]
            -- upvalues: u394 (copy)
            u394.Selectable = p404;
            if p404 then
                u394.TextColor3 = Color3.fromRGB(178, 178, 178);
                u394.ZIndex = 2;
            else
                u394.TextColor3 = Color3.fromRGB(49, 49, 49);
                u394.ZIndex = 1;
            end;
        end;
        function u378.SetValue(_, p405) --[[ Line: 2306 ]]
            -- upvalues: u394 (copy)
            u394.Text = p405;
        end;
        local u406 = Instance.new("BindableEvent");
        u406.Name = "ValueChanged";
        u394.FocusLost:Connect(function() --[[ Line: 2313 ]]
            -- upvalues: u406 (copy), u394 (copy)
            u406:Fire(u394.Text);
        end);
        u378.ValueChanged = u406.Event;
        l__UserInputService__2.InputBegan:Connect(v399);
    end;
    u378.Name = u363 .. "ValueChanger";
    local v407 = v369 + u360;
    if p367 then
        v407 = v407 + p367;
    end;
    u361[u362] = v407;
    if v368 then
        u370.MouseEnter:Connect(function() --[[ Line: 2332 ]]
            -- upvalues: l__PlayerGui__5 (ref), u378 (ref), l__VRService__7 (ref), l__UserInputService__2 (ref), u362 (copy), l__GuiService__3 (ref)
            local v408 = l__PlayerGui__5.RobloxGui:FindFirstChild("DropDownFullscreenFrame");
            if v408 and v408.Visible then
            else
                local v409 = u378.SliderFrame or u378.SliderFrame or u378.DropDownFrame or u378.SelectorFrame;
                if v409 and (v409.Visible and v409.ZIndex > 1) then
                    local v410;
                    if l__VRService__7.VREnabled then
                        v410 = false;
                    else
                        v410 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
                    end;
                    if v410 and u362.Active then
                        l__GuiService__3.SelectedCoreObject = v409;
                    end;
                end;
            end;
        end);
        l__VRService__7.Changed:Connect(function(p411) --[[ Name: onVREnabled, Line 2354 ]]
            -- upvalues: l__VRService__7 (ref), u370 (ref), u377 (ref), l__GuiService__3 (ref)
            if p411 == "VREnabled" then
                if l__VRService__7.VREnabled then
                    u370.Selectable = true;
                    u370.Active = true;
                    u377.Active = true;
                    l__GuiService__3.Changed:Connect(function(p412) --[[ Line: 2360 ]]
                        -- upvalues: l__GuiService__3 (ref), u370 (ref)
                        if p412 == "SelectedCoreObject" then
                            local l__SelectedCoreObject__24 = l__GuiService__3.SelectedCoreObject;
                            if l__SelectedCoreObject__24 and (l__SelectedCoreObject__24 == u370 or l__SelectedCoreObject__24:IsDescendantOf(u370)) then
                                u370.ImageTransparency = 0.5;
                                u370.BackgroundTransparency = 1;
                                return;
                            end;
                            u370.ImageTransparency = 1;
                            u370.BackgroundTransparency = 1;
                        end;
                    end);
                    return;
                end;
                u370.Selectable = false;
                u370.Active = false;
            end;
        end);
        if l__VRService__7.VREnabled then
            u370.Selectable = true;
            u370.Active = true;
            u377.Active = true;
            l__GuiService__3.Changed:Connect(function(p413) --[[ Line: 2360 ]]
                -- upvalues: l__GuiService__3 (ref), u370 (ref)
                if p413 == "SelectedCoreObject" then
                    local l__SelectedCoreObject__25 = l__GuiService__3.SelectedCoreObject;
                    if l__SelectedCoreObject__25 and (l__SelectedCoreObject__25 == u370 or l__SelectedCoreObject__25:IsDescendantOf(u370)) then
                        u370.ImageTransparency = 0.5;
                        u370.BackgroundTransparency = 1;
                        return;
                    end;
                    u370.ImageTransparency = 1;
                    u370.BackgroundTransparency = 1;
                end;
            end);
        else
            u370.Selectable = false;
            u370.Active = false;
        end;
        u377.SelectionGained:Connect(function() --[[ Line: 2381 ]]
            -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), u370 (ref), u378 (ref)
            local v414;
            if l__VRService__7.VREnabled then
                v414 = false;
            else
                v414 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v414 then
                if l__VRService__7.VREnabled then
                    u370.ImageTransparency = 0.5;
                    u370.BackgroundTransparency = 1;
                else
                    u370.ImageTransparency = 1;
                    u370.BackgroundTransparency = 0.5;
                end;
                if u378.HubRef then
                    u378.HubRef:ScrollToFrame(u370);
                end;
            end;
        end);
        u377.SelectionLost:Connect(function() --[[ Line: 2396 ]]
            -- upvalues: l__VRService__7 (ref), l__UserInputService__2 (ref), u370 (ref)
            local v415;
            if l__VRService__7.VREnabled then
                v415 = false;
            else
                v415 = (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
            end;
            if v415 then
                u370.ImageTransparency = 1;
                u370.BackgroundTransparency = 1;
            end;
        end);
    end;
    u362:AddRow(u370, u371, u378, p367, false);
    u378.Selection = u377;
    return u370, u371, u378;
end;
local function u427(p417, p418, p419, p420) --[[ Line: 2411 ]]
    -- upvalues: u361 (copy), u15 (copy), u360 (ref), u17 (copy), u16 (copy), u60 (copy), l__GuiService__3 (copy), l__VRService__7 (copy)
    local v421 = not u361[p417] and 0 or u361[p417];
    local u422 = u15.Create("ImageButton")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        ZIndex = 2,
        Selectable = false,
        Name = p418 .. "Frame",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10),
        Size = UDim2.new(1, 0, 0, u360),
        Position = UDim2.new(0, 0, 0, v421),
        SelectionImageObject = u17,
        Parent = p417.Page
    });
    u422.ImageColor3 = u422.BackgroundColor3;
    u422.SelectionGained:Connect(function() --[[ Line: 2437 ]]
        -- upvalues: u422 (copy)
        u422.BackgroundTransparency = 0.5;
    end);
    u422.SelectionLost:Connect(function() --[[ Line: 2440 ]]
        -- upvalues: u422 (copy)
        u422.BackgroundTransparency = 1;
    end);
    local u423 = u15.Create("TextLabel")({
        TextSize = 16,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = p418 .. "Label",
        Text = p418,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Parent = u422
    });
    u16[u422] = function(_, p424) --[[ Name: onResized, Line 2458 ]]
        -- upvalues: u423 (copy)
        if p424 then
            u423.TextSize = 16;
        else
            u423.TextSize = 24;
        end;
    end;
    u60();
    local v425 = u60();
    if v425.Y > v425.X then
        u423.TextSize = 16;
    else
        u423.TextSize = 24;
    end;
    if p420 then
        u422.Position = UDim2.new(u422.Position.X.Scale, u422.Position.X.Offset, u422.Position.Y.Scale, u422.Position.Y.Offset + p420);
    end;
    local v426 = v421 + u360;
    if p420 then
        v426 = v426 + p420;
    end;
    u361[p417] = v426;
    u422.MouseEnter:Connect(function() --[[ Line: 2479 ]]
        -- upvalues: u422 (copy), l__GuiService__3 (ref)
        if u422.Visible then
            l__GuiService__3.SelectedCoreObject = u422;
        end;
    end);
    p419.SelectionImageObject = u17;
    p419.SelectionGained:Connect(function() --[[ Line: 2488 ]]
        -- upvalues: l__VRService__7 (ref), u422 (copy)
        if l__VRService__7.VREnabled then
            u422.ImageTransparency = 0.5;
            u422.BackgroundTransparency = 1;
        else
            u422.ImageTransparency = 1;
            u422.BackgroundTransparency = 0.5;
        end;
    end);
    p419.SelectionLost:Connect(function() --[[ Line: 2497 ]]
        -- upvalues: u422 (copy)
        u422.ImageTransparency = 1;
        u422.BackgroundTransparency = 1;
    end);
    p419.Parent = u422;
    p417:AddRow(u422, u423, p419, p420, true);
    return u422;
end;
local u491 = {
    Create = function(_, u428) --[[ Name: Create, Line 2511 ]]
        return function(p429) --[[ Line: 2512 ]]
            -- upvalues: u428 (copy)
            local v430 = Instance.new(u428);
            local v431 = nil;
            for v432, v433 in pairs(p429) do
                if type(v432) == "number" then
                    v433.Parent = v430;
                elseif v432 == "Parent" then
                    v431 = v433;
                else
                    v430[v432] = v433;
                end;
            end;
            if v431 then
                v430.Parent = v431;
            end;
            return v430;
        end;
    end,
    RayPlaneIntersection = function(_, p434, p435, p436) --[[ Name: RayPlaneIntersection, Line 2533 ]]
        local l__unit__26 = p435.unit;
        local l__Unit__27 = p434.Unit;
        local v437 = l__unit__26:Dot(l__Unit__27.Direction);
        if v437 == 0 then
            return nil;
        else
            local v438 = l__unit__26:Dot(p436 - l__Unit__27.Origin) / v437;
            if v438 < 0 then
                return nil;
            else
                return l__Unit__27.Origin + l__Unit__27.Direction * v438;
            end;
        end;
    end,
    GetEaseLinear = function(_) --[[ Name: GetEaseLinear, Line 2551 ]]
        -- upvalues: u29 (copy)
        return u29;
    end,
    GetEaseOutQuad = function(_) --[[ Name: GetEaseOutQuad, Line 2554 ]]
        -- upvalues: u35 (copy)
        return u35;
    end,
    GetEaseInOutQuad = function(_) --[[ Name: GetEaseInOutQuad, Line 2557 ]]
        -- upvalues: u41 (copy)
        return u41;
    end,
    CreateNewSlider = function(_, p439, p440, p441) --[[ Name: CreateNewSlider, Line 2561 ]]
        -- upvalues: u359 (copy)
        return u359(p439, p440, p441);
    end,
    CreateNewSelector = function(_, p442, p443) --[[ Name: CreateNewSelector, Line 2565 ]]
        -- upvalues: u258 (copy)
        return u258(p442, p443);
    end,
    CreateNewDropDown = function(_, p444, p445) --[[ Name: CreateNewDropDown, Line 2569 ]]
        -- upvalues: u187 (copy)
        return u187(p444, p445, nil);
    end,
    AddNewRow = function(_, p446, p447, p448, p449, p450, p451) --[[ Name: AddNewRow, Line 2573 ]]
        -- upvalues: u416 (copy)
        return u416(p446, p447, p448, p449, p450, p451);
    end,
    AddNewRowObject = function(_, p452, p453, p454, p455) --[[ Name: AddNewRowObject, Line 2577 ]]
        -- upvalues: u427 (copy)
        return u427(p452, p453, p454, p455);
    end,
    ShowAlert = function(_, p456, p457, p458, p459, p460) --[[ Name: ShowAlert, Line 2581 ]]
        -- upvalues: u277 (copy)
        u277(p456, p457, p458, p459, p460);
    end,
    IsSmallTouchScreen = function(_) --[[ Name: IsSmallTouchScreen, Line 2585 ]]
        -- upvalues: u60 (copy), l__UserInputService__2 (copy)
        local v461 = u60();
        local l__TouchEnabled__28 = l__UserInputService__2.TouchEnabled;
        if l__TouchEnabled__28 then
            l__TouchEnabled__28 = v461.Y < 500 and true or v461.X < 700;
        end;
        return l__TouchEnabled__28;
    end,
    IsPortrait = function(_) --[[ Name: IsPortrait, Line 2589 ]]
        -- upvalues: u60 (copy)
        local v462 = u60();
        return v462.Y > v462.X;
    end,
    MakeStyledButton = function(_, p463, p464, p465, p466, p467, p468) --[[ Name: MakeStyledButton, Line 2593 ]]
        -- upvalues: u106 (copy)
        return u106(p463, p464, p465, p466, p467, p468);
    end,
    MakeStyledImageButton = function(_, p469, p470, p471, p472, p473, p474, p475) --[[ Name: MakeStyledImageButton, Line 2597 ]]
        -- upvalues: u116 (copy)
        return u116(p469, p470, p471, p472, p473, p474, p475);
    end,
    AddButtonRow = function(_, p476, p477, p478, p479, p480, p481) --[[ Name: AddButtonRow, Line 2601 ]]
        -- upvalues: u127 (copy)
        return u127(p476, p477, p478, p479, p480, p481);
    end,
    CreateSignal = function(_) --[[ Name: CreateSignal, Line 2605 ]]
        -- upvalues: u59 (copy)
        return u59();
    end,
    UsesSelectedObject = function(_) --[[ Name: UsesSelectedObject, Line 2609 ]]
        -- upvalues: l__VRService__7 (copy), l__UserInputService__2 (copy)
        if l__VRService__7.VREnabled then
            return false;
        else
            return (not l__UserInputService__2.TouchEnabled or l__UserInputService__2.GamepadEnabled) and true or false;
        end;
    end,
    TweenProperty = function(_, p482, p483, p484, p485, p486, p487, p488) --[[ Name: TweenProperty, Line 2613 ]]
        return PropertyTweener(p482, p483, p484, p485, p486, p487, p488);
    end,
    OnResized = function(_, p489, p490) --[[ Name: OnResized, Line 2617 ]]
        -- upvalues: u72 (copy)
        return u72(p489, p490);
    end
};
function u491.FireOnResized(_) --[[ Line: 2621 ]]
    -- upvalues: u60 (copy), u491 (copy), u16 (copy)
    local v492 = u60();
    local v493 = u491:IsPortrait();
    for _, v494 in pairs(u16) do
        v494(v492, v493);
    end;
end;
function u491.Lerp(_, p495, p496, p497) --[[ Line: 2632 ]]
    return (1 - p495) * p496 + p495 * p497;
end;
function u491.Round(_, p498) --[[ Line: 2637 ]]
    return p498 % 1 >= 0.5 and math.ceil(p498) or math.floor(p498);
end;
return u491;