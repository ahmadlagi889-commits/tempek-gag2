-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local u1 = {};
return function(u2) --[[ Line: 5 ]]
    -- upvalues: u1 (copy)
    u1.GuiService = game:GetService("GuiService");
    u1.RunService = game:GetService("RunService");
    u1.UserInputService = game:GetService("UserInputService");
    u1.ContextActionService = game:GetService("ContextActionService");
    u1.TextService = game:GetService("TextService");
    u1.ICONS = {
        BLANK_SQUARE = "rbxassetid://83265623867126",
        RIGHT_POINTING_TRIANGLE = "rbxassetid://105541346271951",
        DOWN_POINTING_TRIANGLE = "rbxassetid://95465797476827",
        MULTIPLICATION_SIGN = "rbxassetid://133890060015237",
        BOTTOM_RIGHT_CORNER = "rbxassetid://125737344915000",
        CHECKMARK = "rbxassetid://109638815494221",
        BORDER = "rbxassetid://133803690460269",
        ALPHA_BACKGROUND_TEXTURE = "rbxassetid://114090016039876",
        UNKNOWN_TEXTURE = "rbxassetid://95045813476061"
    };
    u1.IS_STUDIO = u1.RunService:IsStudio();
    function u1.getTime() --[[ Line: 25 ]]
        -- upvalues: u1 (ref)
        if u1.IS_STUDIO then
            return os.clock();
        else
            return time();
        end;
    end;
    local v3 = u1;
    local v4;
    if u2._config.IgnoreGuiInset then
        v4 = -u1.GuiService:GetGuiInset();
    else
        v4 = Vector2.zero;
    end;
    v3.GuiOffset = v4;
    local v5 = u1;
    local v6;
    if u2._config.IgnoreGuiInset then
        v6 = Vector2.zero;
    else
        v6 = u1.GuiService:GetGuiInset();
    end;
    v5.MouseOffset = v6;
    local u7 = nil;
    u7 = u1.GuiService:GetPropertyChangedSignal("TopbarInset"):Once(function() --[[ Line: 41 ]]
        -- upvalues: u1 (ref), u2 (copy), u7 (ref)
        local v8 = u1;
        local v9;
        if u2._config.IgnoreGuiInset then
            v9 = Vector2.zero;
        else
            v9 = u1.GuiService:GetGuiInset();
        end;
        v8.MouseOffset = v9;
        local v10 = u1;
        local v11;
        if u2._config.IgnoreGuiInset then
            v11 = -u1.GuiService:GetGuiInset();
        else
            v11 = Vector2.zero;
        end;
        v10.GuiOffset = v11;
        u7:Disconnect();
    end);
    task.delay(5, function() --[[ Line: 47 ]]
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);
    function u1.getMouseLocation() --[[ Line: 51 ]]
        -- upvalues: u1 (ref)
        return u1.UserInputService:GetMouseLocation() - u1.MouseOffset;
    end;
    function u1.isPosInsideRect(p12, p13, p14) --[[ Line: 55 ]]
        local v15;
        if p12.X >= p13.X and (p12.X <= p14.X and p12.Y >= p13.Y) then
            v15 = p12.Y <= p14.Y;
        else
            v15 = false;
        end;
        return v15;
    end;
    function u1.findBestWindowPosForPopup(p16, p17, p18, p19) --[[ Line: 59 ]]
        local v20;
        if p16.X + p17.X + 20 > p19.X then
            if p16.Y + p17.Y + 20 > p19.Y then
                v20 = p16 + Vector2.new(0, -(20 + p17.Y));
            else
                v20 = p16 + Vector2.new(0, 20);
            end;
        else
            v20 = p16 + Vector2.new(20);
        end;
        local l__new__1 = Vector2.new;
        local v21 = math.min(v20.X + p17.X, p19.X) - p17.X;
        local v22 = math.max(v21, p18.X);
        local v23 = math.min(v20.Y + p17.Y, p19.Y) - p17.Y;
        return l__new__1(v22, (math.max(v23, p18.Y)));
    end;
    function u1.getScreenSizeForWindow(p24) --[[ Line: 78 ]]
        if p24.Instance:IsA("GuiBase2d") then
            return p24.Instance.AbsoluteSize;
        else
            local l__Parent__2 = p24.Instance.Parent;
            if l__Parent__2:IsA("GuiBase2d") then
                return l__Parent__2.AbsoluteSize;
            elseif l__Parent__2.Parent:IsA("GuiBase2d") then
                return l__Parent__2.AbsoluteSize;
            else
                return workspace.CurrentCamera.ViewportSize;
            end;
        end;
    end;
    function u1.extend(p25, p26) --[[ Line: 95 ]]
        local v27 = table.clone(p25);
        for v28, v29 in p26 do
            v27[v28] = v29;
        end;
        return v27;
    end;
    function u1.UIPadding(p30, p31) --[[ Line: 103 ]]
        local v32 = Instance.new("UIPadding");
        v32.PaddingLeft = UDim.new(0, p31.X);
        v32.PaddingRight = UDim.new(0, p31.X);
        v32.PaddingTop = UDim.new(0, p31.Y);
        v32.PaddingBottom = UDim.new(0, p31.Y);
        v32.Parent = p30;
        return v32;
    end;
    function u1.UIListLayout(p33, p34, p35) --[[ Line: 113 ]]
        local v36 = Instance.new("UIListLayout");
        v36.SortOrder = Enum.SortOrder.LayoutOrder;
        v36.Padding = p35;
        v36.FillDirection = p34;
        v36.Parent = p33;
        return v36;
    end;
    function u1.UIStroke(p37, p38, p39, p40) --[[ Line: 122 ]]
        local v41 = Instance.new("UIStroke");
        v41.Thickness = p38;
        v41.Color = p39;
        v41.Transparency = p40;
        v41.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        v41.LineJoinMode = Enum.LineJoinMode.Round;
        v41.Parent = p37;
        return v41;
    end;
    function u1.UICorner(p42, p43) --[[ Line: 133 ]]
        local v44 = Instance.new("UICorner");
        v44.CornerRadius = UDim.new(p43 and 0 or 1, p43 or 0);
        v44.Parent = p42;
        return v44;
    end;
    function u1.UISizeConstraint(p45, p46, p47) --[[ Line: 140 ]]
        local v48 = Instance.new("UISizeConstraint");
        v48.MinSize = p46 or v48.MinSize;
        v48.MaxSize = p47 or v48.MaxSize;
        v48.Parent = p45;
        return v48;
    end;
    function u1.applyTextStyle(p49) --[[ Line: 150 ]]
        -- upvalues: u2 (copy)
        p49.FontFace = u2._config.TextFont;
        p49.TextSize = u2._config.TextSize;
        p49.TextColor3 = u2._config.TextColor;
        p49.TextTransparency = u2._config.TextTransparency;
        p49.TextXAlignment = Enum.TextXAlignment.Left;
        p49.TextYAlignment = Enum.TextYAlignment.Center;
        p49.RichText = u2._config.RichText;
        p49.TextWrapped = u2._config.TextWrapped;
        p49.AutoLocalize = false;
    end;
    function u1.applyInteractionHighlights(u50, p51, u52, u53) --[[ Line: 163 ]]
        -- upvalues: u1 (ref), u2 (copy)
        local u54 = false;
        u1.applyMouseEnter(p51, function() --[[ Line: 165 ]]
            -- upvalues: u52 (copy), u50 (copy), u53 (copy), u54 (ref)
            u52[u50 .. "Color3"] = u53.HoveredColor;
            u52[u50 .. "Transparency"] = u53.HoveredTransparency;
            u54 = false;
        end);
        u1.applyMouseLeave(p51, function() --[[ Line: 172 ]]
            -- upvalues: u52 (copy), u50 (copy), u53 (copy), u54 (ref)
            u52[u50 .. "Color3"] = u53.Color;
            u52[u50 .. "Transparency"] = u53.Transparency;
            u54 = true;
        end);
        u1.applyInputBegan(p51, function(p55) --[[ Line: 179 ]]
            -- upvalues: u52 (copy), u50 (copy), u53 (copy)
            if p55.UserInputType == Enum.UserInputType.MouseButton1 or p55.UserInputType == Enum.UserInputType.Gamepad1 then
                u52[u50 .. "Color3"] = u53.ActiveColor;
                u52[u50 .. "Transparency"] = u53.ActiveTransparency;
            end;
        end);
        u1.applyInputEnded(p51, function(p56) --[[ Line: 187 ]]
            -- upvalues: u54 (ref), u52 (copy), u50 (copy), u53 (copy)
            if (p56.UserInputType == Enum.UserInputType.MouseButton1 or p56.UserInputType == Enum.UserInputType.Gamepad1) and not u54 then
                if p56.UserInputType == Enum.UserInputType.MouseButton1 then
                    u52[u50 .. "Color3"] = u53.HoveredColor;
                    u52[u50 .. "Transparency"] = u53.HoveredTransparency;
                end;
                if p56.UserInputType == Enum.UserInputType.Gamepad1 then
                    u52[u50 .. "Color3"] = u53.Color;
                    u52[u50 .. "Transparency"] = u53.Transparency;
                end;
            end;
        end);
        p51.SelectionImageObject = u2.SelectionImageObject;
    end;
    function u1.applyInteractionHighlightsWithMultiHighlightee(u57, p58, u59) --[[ Line: 204 ]]
        -- upvalues: u1 (ref), u2 (copy)
        local u60 = false;
        u1.applyMouseEnter(p58, function() --[[ Line: 206 ]]
            -- upvalues: u59 (copy), u57 (copy), u60 (ref)
            for _, v61 in u59 do
                v61[1][u57 .. "Color3"] = v61[2].HoveredColor;
                v61[1][u57 .. "Transparency"] = v61[2].HoveredTransparency;
                u60 = false;
            end;
        end);
        u1.applyMouseLeave(p58, function() --[[ Line: 215 ]]
            -- upvalues: u59 (copy), u57 (copy), u60 (ref)
            for _, v62 in u59 do
                v62[1][u57 .. "Color3"] = v62[2].Color;
                v62[1][u57 .. "Transparency"] = v62[2].Transparency;
                u60 = true;
            end;
        end);
        u1.applyInputBegan(p58, function(p63) --[[ Line: 224 ]]
            -- upvalues: u59 (copy), u57 (copy)
            if p63.UserInputType == Enum.UserInputType.MouseButton1 or p63.UserInputType == Enum.UserInputType.Gamepad1 then
                for _, v64 in u59 do
                    v64[1][u57 .. "Color3"] = v64[2].ActiveColor;
                    v64[1][u57 .. "Transparency"] = v64[2].ActiveTransparency;
                end;
            end;
        end);
        u1.applyInputEnded(p58, function(p65) --[[ Line: 234 ]]
            -- upvalues: u60 (ref), u59 (copy), u57 (copy)
            if (p65.UserInputType == Enum.UserInputType.MouseButton1 or p65.UserInputType == Enum.UserInputType.Gamepad1) and not u60 then
                for _, v66 in u59 do
                    if p65.UserInputType == Enum.UserInputType.MouseButton1 then
                        v66[1][u57 .. "Color3"] = v66[2].HoveredColor;
                        v66[1][u57 .. "Transparency"] = v66[2].HoveredTransparency;
                    end;
                    if p65.UserInputType == Enum.UserInputType.Gamepad1 then
                        v66[1][u57 .. "Color3"] = v66[2].Color;
                        v66[1][u57 .. "Transparency"] = v66[2].Transparency;
                    end;
                end;
            end;
        end);
        p58.SelectionImageObject = u2.SelectionImageObject;
    end;
    function u1.applyFrameStyle(p67, p68, p69) --[[ Line: 253 ]]
        -- upvalues: u2 (copy), u1 (ref)
        local l__FrameBorderSize__3 = u2._config.FrameBorderSize;
        local l__FrameRounding__4 = u2._config.FrameRounding;
        p67.BorderSizePixel = 0;
        if l__FrameBorderSize__3 > 0 then
            u1.UIStroke(p67, l__FrameBorderSize__3, u2._config.BorderColor, u2._config.BorderTransparency);
        end;
        if l__FrameRounding__4 > 0 and not p69 then
            u1.UICorner(p67, l__FrameRounding__4);
        end;
        if not p68 then
            u1.UIPadding(p67, u2._config.FramePadding);
        end;
    end;
    function u1.applyButtonClick(p70, u71) --[[ Line: 271 ]]
        p70.MouseButton1Click:Connect(function() --[[ Line: 272 ]]
            -- upvalues: u71 (copy)
            u71();
        end);
    end;
    function u1.applyButtonDown(p72, u73) --[[ Line: 277 ]]
        -- upvalues: u1 (ref)
        p72.MouseButton1Down:Connect(function(p74, p75) --[[ Line: 278 ]]
            -- upvalues: u1 (ref), u73 (copy)
            local v76 = Vector2.new(p74, p75) - u1.MouseOffset;
            u73(v76.X, v76.Y);
        end);
    end;
    function u1.applyMouseEnter(p77, u78) --[[ Line: 284 ]]
        -- upvalues: u1 (ref)
        p77.MouseEnter:Connect(function(p79, p80) --[[ Line: 285 ]]
            -- upvalues: u1 (ref), u78 (copy)
            local v81 = Vector2.new(p79, p80) - u1.MouseOffset;
            u78(v81.X, v81.Y);
        end);
    end;
    function u1.applyMouseMoved(p82, u83) --[[ Line: 291 ]]
        -- upvalues: u1 (ref)
        p82.MouseMoved:Connect(function(p84, p85) --[[ Line: 292 ]]
            -- upvalues: u1 (ref), u83 (copy)
            local v86 = Vector2.new(p84, p85) - u1.MouseOffset;
            u83(v86.X, v86.Y);
        end);
    end;
    function u1.applyMouseLeave(p87, u88) --[[ Line: 298 ]]
        -- upvalues: u1 (ref)
        p87.MouseLeave:Connect(function(p89, p90) --[[ Line: 299 ]]
            -- upvalues: u1 (ref), u88 (copy)
            local v91 = Vector2.new(p89, p90) - u1.MouseOffset;
            u88(v91.X, v91.Y);
        end);
    end;
    function u1.applyInputBegan(p92, u93) --[[ Line: 305 ]]
        p92.InputBegan:Connect(function(...) --[[ Line: 306 ]]
            -- upvalues: u93 (copy)
            u93(...);
        end);
    end;
    function u1.applyInputEnded(p94, u95) --[[ Line: 311 ]]
        p94.InputEnded:Connect(function(...) --[[ Line: 312 ]]
            -- upvalues: u95 (copy)
            u95(...);
        end);
    end;
    function u1.discardState(p96) --[[ Line: 317 ]]
        for _, v97 in p96.state do
            v97.ConnectedWidgets[p96.ID] = nil;
        end;
    end;
    function u1.registerEvent(u98, u99) --[[ Line: 323 ]]
        -- upvalues: u2 (copy), u1 (ref)
        table.insert(u2._initFunctions, function() --[[ Line: 324 ]]
            -- upvalues: u2 (ref), u1 (ref), u98 (copy), u99 (copy)
            table.insert(u2._connections, u1.UserInputService[u98]:Connect(u99));
        end);
    end;
    u1.EVENTS = {
        hover = function(u100) --[[ Name: hover, Line 330 ]]
            -- upvalues: u1 (ref)
            return {
                Init = function(u101) --[[ Line: 332 ]]
                    -- upvalues: u100 (copy), u1 (ref)
                    local v102 = u100(u101);
                    u1.applyMouseEnter(v102, function() --[[ Line: 334 ]]
                        -- upvalues: u101 (copy)
                        u101.isHoveredEvent = true;
                    end);
                    u1.applyMouseLeave(v102, function() --[[ Line: 337 ]]
                        -- upvalues: u101 (copy)
                        u101.isHoveredEvent = false;
                    end);
                    u101.isHoveredEvent = false;
                end,
                Get = function(p103) --[[ Line: 342 ]]
                    return p103.isHoveredEvent;
                end
            };
        end,
        click = function(u104) --[[ Name: click, Line 348 ]]
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u105) --[[ Line: 350 ]]
                    -- upvalues: u104 (copy), u1 (ref), u2 (ref)
                    local v106 = u104(u105);
                    u105.lastClickedTick = -1;
                    u1.applyButtonClick(v106, function() --[[ Line: 354 ]]
                        -- upvalues: u105 (copy), u2 (ref)
                        u105.lastClickedTick = u2._cycleTick + 1;
                    end);
                end,
                Get = function(p107) --[[ Line: 358 ]]
                    -- upvalues: u2 (ref)
                    return p107.lastClickedTick == u2._cycleTick;
                end
            };
        end,
        rightClick = function(u108) --[[ Name: rightClick, Line 364 ]]
            -- upvalues: u2 (copy)
            return {
                Init = function(u109) --[[ Line: 366 ]]
                    -- upvalues: u108 (copy), u2 (ref)
                    local v110 = u108(u109);
                    u109.lastRightClickedTick = -1;
                    v110.MouseButton2Click:Connect(function() --[[ Line: 370 ]]
                        -- upvalues: u109 (copy), u2 (ref)
                        u109.lastRightClickedTick = u2._cycleTick + 1;
                    end);
                end,
                Get = function(p111) --[[ Line: 374 ]]
                    -- upvalues: u2 (ref)
                    return p111.lastRightClickedTick == u2._cycleTick;
                end
            };
        end,
        doubleClick = function(u112) --[[ Name: doubleClick, Line 380 ]]
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u113) --[[ Line: 382 ]]
                    -- upvalues: u112 (copy), u1 (ref), u2 (ref)
                    local v114 = u112(u113);
                    u113.lastClickedTime = -1;
                    u113.lastClickedPosition = Vector2.zero;
                    u113.lastDoubleClickedTick = -1;
                    u1.applyButtonDown(v114, function(p115, p116) --[[ Line: 388 ]]
                        -- upvalues: u1 (ref), u113 (copy), u2 (ref)
                        local v117 = u1.getTime();
                        if v117 - u113.lastClickedTime < u2._config.MouseDoubleClickTime and (Vector2.new(p115, p116) - u113.lastClickedPosition).Magnitude < u2._config.MouseDoubleClickMaxDist then
                            u113.lastDoubleClickedTick = u2._cycleTick + 1;
                        else
                            u113.lastClickedTime = v117;
                            u113.lastClickedPosition = Vector2.new(p115, p116);
                        end;
                    end);
                end,
                Get = function(p118) --[[ Line: 399 ]]
                    -- upvalues: u2 (ref)
                    return p118.lastDoubleClickedTick == u2._cycleTick;
                end
            };
        end,
        ctrlClick = function(u119) --[[ Name: ctrlClick, Line 405 ]]
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u120) --[[ Line: 407 ]]
                    -- upvalues: u119 (copy), u1 (ref), u2 (ref)
                    local v121 = u119(u120);
                    u120.lastCtrlClickedTick = -1;
                    u1.applyButtonClick(v121, function() --[[ Line: 411 ]]
                        -- upvalues: u1 (ref), u120 (copy), u2 (ref)
                        if u1.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u1.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                            u120.lastCtrlClickedTick = u2._cycleTick + 1;
                        end;
                    end);
                end,
                Get = function(p122) --[[ Line: 417 ]]
                    -- upvalues: u2 (ref)
                    return p122.lastCtrlClickedTick == u2._cycleTick;
                end
            };
        end
    };
    u2._utility = u1;
    require(script.Root)(u2, u1);
    require(script.Window)(u2, u1);
    require(script.Menu)(u2, u1);
    require(script.Format)(u2, u1);
    require(script.Text)(u2, u1);
    require(script.Button)(u2, u1);
    require(script.Checkbox)(u2, u1);
    require(script.RadioButton)(u2, u1);
    require(script.Image)(u2, u1);
    require(script.Tree)(u2, u1);
    require(script.Tab)(u2, u1);
    require(script.Input)(u2, u1);
    require(script.Combo)(u2, u1);
    require(script.Plot)(u2, u1);
    require(script.Table)(u2, u1);
end;