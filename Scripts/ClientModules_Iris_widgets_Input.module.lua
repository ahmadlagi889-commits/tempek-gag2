-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 6 ]]
    local u4 = {
        Init = function(_) --[[ Line: 8 ]] end,
        Get = function(p3) --[[ Line: 9 ]]
            -- upvalues: u1 (copy)
            return p3.lastNumberChangedTick == u1._cycleTick;
        end
    };
    local function u9(p5, p6, p7) --[[ Line: 14 ]]
        if typeof(p5) == "number" then
            return p5;
        end;
        if typeof(p5) == "Vector2" then
            if p6 == 1 then
                return p5.X;
            end;
            if p6 == 2 then
                return p5.Y;
            end;
        elseif typeof(p5) == "Vector3" then
            if p6 == 1 then
                return p5.X;
            end;
            if p6 == 2 then
                return p5.Y;
            end;
            if p6 == 3 then
                return p5.Z;
            end;
        elseif typeof(p5) == "UDim" then
            if p6 == 1 then
                return p5.Scale;
            end;
            if p6 == 2 then
                return p5.Offset;
            end;
        elseif typeof(p5) == "UDim2" then
            if p6 == 1 then
                return p5.X.Scale;
            end;
            if p6 == 2 then
                return p5.X.Offset;
            end;
            if p6 == 3 then
                return p5.Y.Scale;
            end;
            if p6 == 4 then
                return p5.Y.Offset;
            end;
        elseif typeof(p5) == "Color3" then
            local v8;
            if p7.UseHSV then
                v8 = { p5:ToHSV() };
            else
                v8 = { p5.R, p5.G, p5.B };
            end;
            if p6 == 1 then
                return v8[1];
            end;
            if p6 == 2 then
                return v8[2];
            end;
            if p6 == 3 then
                return v8[3];
            end;
        elseif typeof(p5) == "Rect" then
            if p6 == 1 then
                return p5.Min.X;
            end;
            if p6 == 2 then
                return p5.Min.Y;
            end;
            if p6 == 3 then
                return p5.Max.X;
            end;
            if p6 == 4 then
                return p5.Max.Y;
            end;
        elseif typeof(p5) == "table" then
            return p5[p6];
        end;
        error((`Incorrect datatype or value: {p5} {typeof(p5)} {p6}.`));
    end;
    local function u17(p10, p11, p12, p13) --[[ Line: 74 ]]
        if typeof(p10) == "number" then
            return p12;
        end;
        if typeof(p10) == "Vector2" then
            if p11 == 1 then
                return Vector2.new(p12, p10.Y);
            end;
            if p11 == 2 then
                return Vector2.new(p10.X, p12);
            end;
        elseif typeof(p10) == "Vector3" then
            if p11 == 1 then
                return Vector3.new(p12, p10.Y, p10.Z);
            end;
            if p11 == 2 then
                return Vector3.new(p10.X, p12, p10.Z);
            end;
            if p11 == 3 then
                return Vector3.new(p10.X, p10.Y, p12);
            end;
        elseif typeof(p10) == "UDim" then
            if p11 == 1 then
                return UDim.new(p12, p10.Offset);
            end;
            if p11 == 2 then
                return UDim.new(p10.Scale, p12);
            end;
        elseif typeof(p10) == "UDim2" then
            if p11 == 1 then
                return UDim2.new(UDim.new(p12, p10.X.Offset), p10.Y);
            end;
            if p11 == 2 then
                return UDim2.new(UDim.new(p10.X.Scale, p12), p10.Y);
            end;
            if p11 == 3 then
                return UDim2.new(p10.X, UDim.new(p12, p10.Y.Offset));
            end;
            if p11 == 4 then
                return UDim2.new(p10.X, UDim.new(p10.Y.Scale, p12));
            end;
        elseif typeof(p10) == "Rect" then
            if p11 == 1 then
                return Rect.new(Vector2.new(p12, p10.Min.Y), p10.Max);
            end;
            if p11 == 2 then
                return Rect.new(Vector2.new(p10.Min.X, p12), p10.Max);
            end;
            if p11 == 3 then
                return Rect.new(p10.Min, Vector2.new(p12, p10.Max.Y));
            end;
            if p11 == 4 then
                return Rect.new(p10.Min, Vector2.new(p10.Max.X, p12));
            end;
        elseif typeof(p10) == "Color3" then
            if p13.UseHSV then
                local v14, v15, v16 = p10:ToHSV();
                if p11 == 1 then
                    return Color3.fromHSV(p12, v15, v16);
                end;
                if p11 == 2 then
                    return Color3.fromHSV(v14, p12, v16);
                end;
                if p11 == 3 then
                    return Color3.fromHSV(v14, v15, p12);
                end;
            end;
            if p11 == 1 then
                return Color3.new(p12, p10.G, p10.B);
            end;
            if p11 == 2 then
                return Color3.new(p10.R, p12, p10.B);
            end;
            if p11 == 3 then
                return Color3.new(p10.R, p10.G, p12);
            end;
        end;
        error((`Incorrect datatype or value {p10} {typeof(p10)} {p11}.`));
    end;
    local u18 = {
        Num = { 1 },
        Vector2 = { 1, 1 },
        Vector3 = { 1, 1, 1 },
        UDim = { 0.01, 1 },
        UDim2 = {
            0.01,
            1,
            0.01,
            1
        },
        Color3 = { 1, 1, 1 },
        Color4 = {
            1,
            1,
            1,
            1
        },
        Rect = {
            1,
            1,
            1,
            1
        }
    };
    local u19 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 0, 0 },
        UDim2 = {
            0,
            0,
            0,
            0
        },
        Rect = {
            0,
            0,
            0,
            0
        }
    };
    local u20 = {
        Num = { 100 },
        Vector2 = { 100, 100 },
        Vector3 = { 100, 100, 100 },
        UDim = { 1, 960 },
        UDim2 = {
            1,
            960,
            1,
            960
        },
        Rect = {
            960,
            960,
            960,
            960
        }
    };
    local u21 = {
        Num = { "" },
        Vector2 = { "X: ", "Y: " },
        Vector3 = { "X: ", "Y: ", "Z: " },
        UDim = { "", "" },
        UDim2 = {
            "",
            "",
            "",
            ""
        },
        Color3_RGB = { "R: ", "G: ", "B: " },
        Color3_HSV = { "H: ", "S: ", "V: " },
        Color4_RGB = {
            "R: ",
            "G: ",
            "B: ",
            "T: "
        },
        Color4_HSV = {
            "H: ",
            "S: ",
            "V: ",
            "T: "
        },
        Rect = {
            "X: ",
            "Y: ",
            "X: ",
            "Y: "
        }
    };
    local u22 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 3, 0 },
        UDim2 = {
            3,
            0,
            3,
            0
        },
        Color3 = { 0, 0, 0 },
        Color4 = {
            0,
            0,
            0,
            0
        },
        Rect = {
            0,
            0,
            0,
            0
        }
    };
    local function u50(u23, u24, u25, u26) --[[ Line: 194 ]]
        -- upvalues: u4 (copy), u2 (copy), u1 (copy), u22 (copy), u9 (copy), u21 (copy), u18 (copy), u19 (copy), u20 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u4,
                hovered = u2.EVENTS.hover(function(p27) --[[ Line: 207 ]]
                    return p27.Instance;
                end)
            },
            GenerateState = function(p28) --[[ Name: GenerateState, Line 211 ]]
                -- upvalues: u1 (ref), u26 (copy)
                if p28.state.number == nil then
                    p28.state.number = u1._widgetState(p28, "number", u26);
                end;
                if p28.state.editingText == nil then
                    p28.state.editingText = u1._widgetState(p28, "editingText", 0);
                end;
            end,
            Update = function(u29) --[[ Name: Update, Line 219 ]]
                -- upvalues: u24 (copy), u25 (copy), u22 (ref), u9 (ref), u21 (ref), u23 (copy), u1 (ref), u18 (ref), u19 (ref), u20 (ref)
                local l__Instance__1 = u29.Instance;
                l__Instance__1.TextLabel.Text = u29.arguments.Text or `Input {u24}`;
                if u29.arguments.Format and typeof(u29.arguments.Format) ~= "table" then
                    u29.arguments.Format = { u29.arguments.Format };
                elseif not u29.arguments.Format then
                    local v30 = {};
                    for v31 = 1, u25 do
                        local v32 = u22[u24][v31];
                        if u29.arguments.Increment then
                            local v33 = u9(u29.arguments.Increment, v31, u29.arguments);
                            local v34 = -math.log10(v33 == 0 and 1 or v33);
                            local v35 = math.ceil(v34);
                            v32 = math.max(v32, v35, v32);
                        end;
                        if u29.arguments.Max then
                            local v36 = u9(u29.arguments.Max, v31, u29.arguments);
                            local v37 = -math.log10(v36 == 0 and 1 or v36);
                            local v38 = math.ceil(v37);
                            v32 = math.max(v32, v38, v32);
                        end;
                        if u29.arguments.Min then
                            local v39 = u9(u29.arguments.Min, v31, u29.arguments);
                            local v40 = -math.log10(v39 == 0 and 1 or v39);
                            local v41 = math.ceil(v40);
                            v32 = math.max(v32, v41, v32);
                        end;
                        if v32 > 0 then
                            v30[v31] = `%.{v32}f`;
                        else
                            v30[v31] = "%d";
                        end;
                    end;
                    u29.arguments.Format = v30;
                    u29.arguments.Prefix = u21[u24];
                end;
                if u23 == "Input" and u24 == "Num" then
                    l__Instance__1.SubButton.Visible = not u29.arguments.NoButtons;
                    l__Instance__1.AddButton.Visible = not u29.arguments.NoButtons;
                    l__Instance__1.InputField1.Size = UDim2.new(UDim.new(u1._config.ContentWidth.Scale, u1._config.ContentWidth.Offset - (u29.arguments.NoButtons and 0 or 2 * u1._config.ItemInnerSpacing.X + 2 * (u1._config.TextSize + 2 * u1._config.FramePadding.Y))), u1._config.ContentHeight);
                end;
                if u23 == "Slider" then
                    for v42 = 1, u25 do
                        local l__GrabBar__2 = l__Instance__1:FindFirstChild("SliderField" .. tostring(v42)).GrabBar;
                        local v43 = u29.arguments.Increment and u9(u29.arguments.Increment, v42, u29.arguments) or u18[u24][v42];
                        local v44 = u29.arguments.Min and u9(u29.arguments.Min, v42, u29.arguments) or u19[u24][v42];
                        local v45 = u29.arguments.Max and u9(u29.arguments.Max, v42, u29.arguments) or u20[u24][v42];
                        local v46 = 1 / math.floor((1 + v45 - v44) / v43);
                        l__GrabBar__2.Size = UDim2.fromScale(v46, 1);
                    end;
                    local u47 = #u1._postCycleCallbacks + 1;
                    local u48 = u1._cycleTick + 1;
                    u1._postCycleCallbacks[u47] = function() --[[ Line: 283 ]]
                        -- upvalues: u1 (ref), u48 (copy), u29 (copy), u24 (ref), u47 (copy)
                        if u48 <= u1._cycleTick then
                            if u29.lastCycleTick ~= -1 then
                                u29.state.number.lastChangeTick = u1._cycleTick;
                                u1._widgets[`Slider{u24}`].UpdateState(u29);
                            end;
                            u1._postCycleCallbacks[u47] = nil;
                        end;
                    end;
                end;
            end,
            Discard = function(p49) --[[ Name: Discard, Line 294 ]]
                -- upvalues: u2 (ref)
                p49.Instance:Destroy();
                u2.discardState(p49);
            end
        };
    end;
    local function u59(p51, p52, p53, p54) --[[ Line: 301 ]]
        -- upvalues: u9 (copy), u17 (copy), u1 (copy)
        local v55 = tonumber(p52.Text:match("-?%d*%.?%d*"));
        local l__number__3 = p51.state.number;
        if p54 == "Color4" and p53 == 4 then
            l__number__3 = p51.state.transparency;
        elseif p54 == "Color3" or p54 == "Color4" then
            l__number__3 = p51.state.color;
        end;
        if v55 ~= nil then
            if p54 == "Color3" or p54 == "Color4" and not p51.arguments.UseFloats then
                v55 = v55 / 255;
            end;
            if p51.arguments.Min ~= nil then
                v55 = math.max(v55, u9(p51.arguments.Min, p53, p51.arguments));
            end;
            if p51.arguments.Max ~= nil then
                v55 = math.min(v55, u9(p51.arguments.Max, p53, p51.arguments));
            end;
            if p51.arguments.Increment then
                local v56 = v55 / u9(p51.arguments.Increment, p53, p51.arguments);
                v55 = math.round(v56) * u9(p51.arguments.Increment, p53, p51.arguments);
            end;
            l__number__3:set(u17(l__number__3.value, p53, v55, p51.arguments));
            p51.lastNumberChangedTick = u1._cycleTick + 1;
        end;
        local v57 = u9(l__number__3.value, p53, p51.arguments);
        if p54 == "Color3" or p54 == "Color4" and not p51.arguments.UseFloats then
            v57 = math.round(v57 * 255);
        end;
        local v58 = p51.arguments.Format[p53] or p51.arguments.Format[1];
        if p51.arguments.Prefix then
            v58 = p51.arguments.Prefix[p53] .. v58;
        end;
        p52.Text = string.format(v58, v57);
        p51.state.editingText:set(0);
        p52:ReleaseFocus(true);
    end;
    local function u71(u60, p61, p62) --[[ Line: 349 ]]
        -- upvalues: u2 (copy), u1 (copy), u9 (copy)
        local v63 = u2.abstractButton.Generate(u60);
        v63.Name = "SubButton";
        v63.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize);
        v63.Text = "-";
        v63.TextXAlignment = Enum.TextXAlignment.Center;
        v63.ZIndex = 5;
        v63.LayoutOrder = 5;
        v63.Parent = p61;
        u2.applyButtonClick(v63, function() --[[ Line: 359 ]]
            -- upvalues: u2 (ref), u60 (copy), u9 (ref), u1 (ref)
            local v64 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
            local v65 = u60.arguments.Increment and u9(u60.arguments.Increment, 1, u60.arguments) or 1;
            local v66 = u60.state.number.value - v65 * (v64 and 100 or 1);
            if u60.arguments.Min ~= nil then
                v66 = math.max(v66, u9(u60.arguments.Min, 1, u60.arguments));
            end;
            if u60.arguments.Max ~= nil then
                v66 = math.min(v66, u9(u60.arguments.Max, 1, u60.arguments));
            end;
            u60.state.number:set(v66);
            u60.lastNumberChangedTick = u1._cycleTick + 1;
        end);
        local v67 = u2.abstractButton.Generate(u60);
        v67.Name = "AddButton";
        v67.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize);
        v67.Text = "+";
        v67.TextXAlignment = Enum.TextXAlignment.Center;
        v67.ZIndex = 6;
        v67.LayoutOrder = 6;
        v67.Parent = p61;
        u2.applyButtonClick(v67, function() --[[ Line: 382 ]]
            -- upvalues: u2 (ref), u60 (copy), u9 (ref), u1 (ref)
            local v68 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
            local v69 = u60.arguments.Increment and u9(u60.arguments.Increment, 1, u60.arguments) or 1;
            local v70 = u60.state.number.value + v69 * (v68 and 100 or 1);
            if u60.arguments.Min ~= nil then
                v70 = math.max(v70, u9(u60.arguments.Min, 1, u60.arguments));
            end;
            if u60.arguments.Max ~= nil then
                v70 = math.min(v70, u9(u60.arguments.Max, 1, u60.arguments));
            end;
            u60.state.number:set(v70);
            u60.lastNumberChangedTick = u1._cycleTick + 1;
        end);
        return 2 * u1._config.ItemInnerSpacing.X + p62 * 2;
    end;
    local function u77(u72, u73, p74, u75) --[[ Line: 399 ]]
        -- upvalues: u1 (copy), u2 (copy), u59 (copy)
        local u76 = Instance.new("TextBox");
        u76.Name = "InputField" .. tostring(u73);
        u76.AutomaticSize = Enum.AutomaticSize.Y;
        u76.Size = UDim2.new(p74, u1._config.ContentHeight);
        u76.BackgroundColor3 = u1._config.FrameBgColor;
        u76.BackgroundTransparency = u1._config.FrameBgTransparency;
        u76.TextTruncate = Enum.TextTruncate.AtEnd;
        u76.ClearTextOnFocus = false;
        u76.ZIndex = u73;
        u76.LayoutOrder = u73;
        u76.ClipsDescendants = true;
        u2.applyFrameStyle(u76);
        u2.applyTextStyle(u76);
        u2.UISizeConstraint(u76, Vector2.xAxis);
        u76.FocusLost:Connect(function() --[[ Line: 416 ]]
            -- upvalues: u59 (ref), u72 (copy), u76 (copy), u73 (copy), u75 (copy)
            u59(u72, u76, u73, u75);
        end);
        u76.Focused:Connect(function() --[[ Line: 420 ]]
            -- upvalues: u76 (copy), u72 (copy), u73 (copy)
            u76.CursorPosition = #u76.Text + 1;
            u76.SelectionStart = 1;
            u72.state.editingText:set(u73);
        end);
        return u76;
    end;
    local function v96(u78, u79, p80) --[[ Line: 431 ]]
        -- upvalues: u50 (copy), u2 (copy), u1 (copy), u71 (copy), u77 (copy), u9 (copy)
        local v81 = u50("Input", u78, u79, p80);
        return u2.extend(v81, {
            Generate = function(p82) --[[ Name: Generate, Line 435 ]]
                -- upvalues: u78 (copy), u1 (ref), u2 (ref), u79 (copy), u71 (ref), u77 (ref)
                local v83 = Instance.new("Frame");
                v83.Name = "Iris_Input" .. u78;
                v83.AutomaticSize = Enum.AutomaticSize.Y;
                v83.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
                v83.BackgroundTransparency = 1;
                v83.BorderSizePixel = 0;
                u2.UIListLayout(v83, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v84 = u79 ~= 1 and 0 or u71(p82, v83, u1._config.TextSize + 2 * u1._config.FramePadding.Y);
                local v85 = UDim.new(u1._config.ContentWidth.Scale / u79, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u79 - 1) - v84) / u79);
                local v86 = UDim.new(v85.Scale * (u79 - 1), v85.Offset * (u79 - 1) + u1._config.ItemInnerSpacing.X * (u79 - 1) + v84);
                local v87 = u1._config.ContentWidth - v86;
                for v88 = 1, u79 do
                    local v89 = u77;
                    local v90;
                    if v88 == u79 then
                        v90 = v87;
                    else
                        v90 = v85;
                    end;
                    v89(p82, v88, v90, u78).Parent = v83;
                end;
                local v91 = Instance.new("TextLabel");
                v91.Name = "TextLabel";
                v91.AutomaticSize = Enum.AutomaticSize.XY;
                v91.BackgroundTransparency = 1;
                v91.BorderSizePixel = 0;
                v91.LayoutOrder = 7;
                u2.applyTextStyle(v91);
                v91.Parent = v83;
                return v83;
            end,
            UpdateState = function(p92) --[[ Name: UpdateState, Line 478 ]]
                -- upvalues: u79 (copy), u9 (ref)
                local l__Instance__4 = p92.Instance;
                for v93 = 1, u79 do
                    local v94 = l__Instance__4:FindFirstChild("InputField" .. tostring(v93));
                    local v95 = p92.arguments.Format[v93] or p92.arguments.Format[1];
                    if p92.arguments.Prefix then
                        v95 = p92.arguments.Prefix[v93] .. v95;
                    end;
                    v94.Text = string.format(v95, u9(p92.state.number.value, v93, p92.arguments));
                end;
            end
        });
    end;
    local u97 = 0;
    local u98 = false;
    local u99 = nil;
    local u100 = 0;
    local u101 = "";
    local function u106() --[[ Line: 506 ]]
        -- upvalues: u2 (copy), u97 (ref), u98 (ref), u99 (ref), u101 (ref), u100 (ref), u9 (copy), u18 (copy), u17 (copy), u1 (copy)
        local l__X__5 = u2.getMouseLocation().X;
        local v102 = l__X__5 - u97;
        u97 = l__X__5;
        if u98 == false then
        elseif u99 == nil then
        else
            local l__number__6 = u99.state.number;
            if u101 == "Color3" or u101 == "Color4" then
                local v103 = u99;
                l__number__6 = v103.state.color;
                if u100 == 4 then
                    l__number__6 = v103.state.transparency;
                end;
            end;
            local v104 = (u99.arguments.Increment and u9(u99.arguments.Increment, u100, u99.arguments) or u18[u101][u100]) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) and 10 or 1) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)) and 0.1 or 1) * ((u101 == "Color3" or u101 == "Color4") and 5 or 1);
            local v105 = u9(l__number__6.value, u100, u99.arguments) + v102 * v104;
            if u99.arguments.Min ~= nil then
                v105 = math.max(v105, u9(u99.arguments.Min, u100, u99.arguments));
            end;
            if u99.arguments.Max ~= nil then
                v105 = math.min(v105, u9(u99.arguments.Max, u100, u99.arguments));
            end;
            l__number__6:set(u17(l__number__6.value, u100, v105, u99.arguments));
            u99.lastNumberChangedTick = u1._cycleTick + 1;
        end;
    end;
    local function u115(p107, p108, p109, p110, p111) --[[ Line: 546 ]]
        -- upvalues: u2 (copy), u1 (copy), u98 (ref), u99 (ref), u100 (ref), u101 (ref), u106 (copy)
        local v112 = u2.getTime();
        local v113 = v112 - p107.lastClickedTime < u1._config.MouseDoubleClickTime;
        local v114 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
        if v113 and (Vector2.new(p110, p111) - p107.lastClickedPosition).Magnitude < u1._config.MouseDoubleClickMaxDist or v114 then
            p107.state.editingText:set(p109);
        else
            p107.lastClickedTime = v112;
            p107.lastClickedPosition = Vector2.new(p110, p111);
            u98 = true;
            u99 = p107;
            u100 = p109;
            u101 = p108;
            u106();
        end;
    end;
    u2.registerEvent("InputChanged", function() --[[ Line: 564 ]]
        -- upvalues: u1 (copy), u106 (copy)
        if u1._started then
            u106();
        end;
    end);
    u2.registerEvent("InputEnded", function(p116) --[[ Line: 571 ]]
        -- upvalues: u1 (copy), u98 (ref), u99 (ref), u100 (ref)
        if u1._started then
            if p116.UserInputType == Enum.UserInputType.MouseButton1 and u98 then
                u98 = false;
                u99 = nil;
                u100 = 0;
            end;
        end;
    end);
    local function u125(u117, u118, p119, u120) --[[ Line: 582 ]]
        -- upvalues: u1 (copy), u2 (copy), u59 (copy), u115 (copy)
        local v121 = Instance.new("TextButton");
        v121.Name = "DragField" .. tostring(u118);
        v121.AutomaticSize = Enum.AutomaticSize.Y;
        v121.Size = p119;
        v121.BackgroundColor3 = u1._config.FrameBgColor;
        v121.BackgroundTransparency = u1._config.FrameBgTransparency;
        v121.Text = "";
        v121.AutoButtonColor = false;
        v121.LayoutOrder = u118;
        v121.ClipsDescendants = true;
        u2.applyFrameStyle(v121);
        u2.applyTextStyle(v121);
        u2.UISizeConstraint(v121, Vector2.xAxis);
        v121.TextXAlignment = Enum.TextXAlignment.Center;
        u2.applyInteractionHighlights("Background", v121, v121, {
            Color = u1._config.FrameBgColor,
            Transparency = u1._config.FrameBgTransparency,
            HoveredColor = u1._config.FrameBgHoveredColor,
            HoveredTransparency = u1._config.FrameBgHoveredTransparency,
            ActiveColor = u1._config.FrameBgActiveColor,
            ActiveTransparency = u1._config.FrameBgActiveTransparency
        });
        local u122 = Instance.new("TextBox");
        u122.Name = "InputField";
        u122.Size = UDim2.fromScale(1, 1);
        u122.BackgroundTransparency = 1;
        u122.ClearTextOnFocus = false;
        u122.TextTruncate = Enum.TextTruncate.AtEnd;
        u122.ClipsDescendants = true;
        u122.Visible = false;
        u2.applyFrameStyle(u122, true);
        u2.applyTextStyle(u122);
        u122.Parent = v121;
        u122.FocusLost:Connect(function() --[[ Line: 623 ]]
            -- upvalues: u59 (ref), u117 (copy), u122 (copy), u118 (copy), u120 (copy)
            u59(u117, u122, u118, u120);
        end);
        u122.Focused:Connect(function() --[[ Line: 627 ]]
            -- upvalues: u122 (copy), u117 (copy), u118 (copy)
            u122.CursorPosition = #u122.Text + 1;
            u122.SelectionStart = 1;
            u117.state.editingText:set(u118);
        end);
        u2.applyButtonDown(v121, function(p123, p124) --[[ Line: 635 ]]
            -- upvalues: u115 (ref), u117 (copy), u120 (copy), u118 (copy)
            u115(u117, u120, u118, p123, p124);
        end);
        return v121;
    end;
    local function u147(u126, u127, p128) --[[ Line: 642 ]]
        -- upvalues: u50 (copy), u2 (copy), u1 (copy), u125 (copy), u9 (copy)
        local v129 = u50("Drag", u126, u127, p128);
        return u2.extend(v129, {
            Generate = function(p130) --[[ Name: Generate, Line 646 ]]
                -- upvalues: u126 (copy), u1 (ref), u2 (ref), u127 (copy), u125 (ref)
                p130.lastClickedTime = -1;
                p130.lastClickedPosition = Vector2.zero;
                local v131 = Instance.new("Frame");
                v131.Name = "Iris_Drag" .. u126;
                v131.AutomaticSize = Enum.AutomaticSize.Y;
                v131.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
                v131.BackgroundTransparency = 1;
                v131.BorderSizePixel = 0;
                u2.UIListLayout(v131, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v132 = 0;
                local v133 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
                if u126 == "Color3" or u126 == "Color4" then
                    v132 = v132 + (u1._config.ItemInnerSpacing.X + v133);
                    local v134 = Instance.new("ImageLabel");
                    v134.Name = "ColorBox";
                    v134.Size = UDim2.fromOffset(v133, v133);
                    v134.BorderSizePixel = 0;
                    v134.Image = u2.ICONS.ALPHA_BACKGROUND_TEXTURE;
                    v134.ImageTransparency = 1;
                    v134.LayoutOrder = 5;
                    u2.applyFrameStyle(v134, true);
                    v134.Parent = v131;
                end;
                local v135 = UDim.new(u1._config.ContentWidth.Scale / u127, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u127 - 1) - v132) / u127);
                local v136 = UDim.new(v135.Scale * (u127 - 1), v135.Offset * (u127 - 1) + u1._config.ItemInnerSpacing.X * (u127 - 1) + v132);
                local v137 = u1._config.ContentWidth - v136;
                for v138 = 1, u127 do
                    local v139 = u125;
                    local v140;
                    if v138 == u127 then
                        v140 = UDim2.new(v137, u1._config.ContentHeight);
                    else
                        v140 = UDim2.new(v135, u1._config.ContentHeight);
                    end;
                    v139(p130, v138, v140, u126).Parent = v131;
                end;
                local v141 = Instance.new("TextLabel");
                v141.Name = "TextLabel";
                v141.AutomaticSize = Enum.AutomaticSize.XY;
                v141.BackgroundTransparency = 1;
                v141.BorderSizePixel = 0;
                v141.LayoutOrder = 6;
                u2.applyTextStyle(v141);
                v141.Parent = v131;
                return v131;
            end,
            UpdateState = function(p142) --[[ Name: UpdateState, Line 703 ]]
                -- upvalues: u127 (copy), u126 (copy), u9 (ref), u1 (ref)
                local l__Instance__7 = p142.Instance;
                for v143 = 1, u127 do
                    local l__number__8 = p142.state.number;
                    if u126 == "Color3" or u126 == "Color4" then
                        l__number__8 = p142.state.color;
                        if v143 == 4 then
                            l__number__8 = p142.state.transparency;
                        end;
                    end;
                    local v144 = l__Instance__7:FindFirstChild("DragField" .. tostring(v143));
                    local l__InputField__9 = v144.InputField;
                    local v145 = u9(l__number__8.value, v143, p142.arguments);
                    if (u126 == "Color3" or u126 == "Color4") and not p142.arguments.UseFloats then
                        v145 = math.round(v145 * 255);
                    end;
                    local v146 = p142.arguments.Format[v143] or p142.arguments.Format[1];
                    if p142.arguments.Prefix then
                        v146 = p142.arguments.Prefix[v143] .. v146;
                    end;
                    v144.Text = string.format(v146, v145);
                    l__InputField__9.Text = tostring(v145);
                    if p142.state.editingText.value == v143 then
                        l__InputField__9.Visible = true;
                        l__InputField__9:CaptureFocus();
                        v144.TextTransparency = 1;
                    else
                        l__InputField__9.Visible = false;
                        v144.TextTransparency = u1._config.TextTransparency;
                    end;
                end;
                if u126 == "Color3" or u126 == "Color4" then
                    local l__ColorBox__10 = l__Instance__7.ColorBox;
                    l__ColorBox__10.BackgroundColor3 = p142.state.color.value;
                    if u126 == "Color4" then
                        l__ColorBox__10.ImageTransparency = 1 - p142.state.transparency.value;
                    end;
                end;
            end
        });
    end;
    local function v153(u148, ...) --[[ Line: 752 ]]
        -- upvalues: u147 (ref), u2 (copy), u21 (copy), u1 (copy)
        local u149 = { ... };
        local v150 = u147(u148, u148 == "Color4" and 4 or 3, u149[1]);
        return u2.extend(v150, {
            Args = {
                Text = 1,
                UseFloats = 2,
                UseHSV = 3,
                Format = 4
            },
            Update = function(p151) --[[ Name: Update, Line 763 ]]
                -- upvalues: u148 (copy), u21 (ref), u1 (ref)
                p151.Instance.TextLabel.Text = p151.arguments.Text or `Drag {u148}`;
                if p151.arguments.Format and typeof(p151.arguments.Format) ~= "table" then
                    p151.arguments.Format = { p151.arguments.Format };
                elseif not p151.arguments.Format then
                    if p151.arguments.UseFloats then
                        p151.arguments.Format = { "%.3f" };
                    else
                        p151.arguments.Format = { "%d" };
                    end;
                    p151.arguments.Prefix = u21[u148 .. (p151.arguments.UseHSV and "_HSV" or "_RGB")];
                end;
                p151.arguments.Min = {
                    0,
                    0,
                    0,
                    0
                };
                p151.arguments.Max = {
                    1,
                    1,
                    1,
                    1
                };
                p151.arguments.Increment = {
                    0.001,
                    0.001,
                    0.001,
                    0.001
                };
                if p151.state then
                    p151.state.color.lastChangeTick = u1._cycleTick;
                    if u148 == "Color4" then
                        p151.state.transparency.lastChangeTick = u1._cycleTick;
                    end;
                    u1._widgets[p151.type].UpdateState(p151);
                end;
            end,
            GenerateState = function(p152) --[[ Name: GenerateState, Line 794 ]]
                -- upvalues: u1 (ref), u149 (copy), u148 (copy)
                if p152.state.color == nil then
                    p152.state.color = u1._widgetState(p152, "color", u149[1]);
                end;
                if u148 == "Color4" and p152.state.transparency == nil then
                    p152.state.transparency = u1._widgetState(p152, "transparency", u149[2]);
                end;
                if p152.state.editingText == nil then
                    p152.state.editingText = u1._widgetState(p152, "editingText", false);
                end;
            end
        });
    end;
    local u154 = false;
    local u155 = nil;
    local u156 = 0;
    local u157 = "";
    local function u165() --[[ Line: 822 ]]
        -- upvalues: u154 (ref), u155 (ref), u156 (ref), u9 (copy), u18 (copy), u157 (ref), u19 (copy), u20 (copy), u2 (copy), u17 (copy), u1 (copy)
        if u154 == false then
        elseif u155 == nil then
        else
            local v158 = u155.Instance:FindFirstChild("SliderField" .. tostring(u156));
            local l__GrabBar__11 = v158.GrabBar;
            local v159 = u155.arguments.Increment and u9(u155.arguments.Increment, u156, u155.arguments) or u18[u157][u156];
            local v160 = u155.arguments.Min and u9(u155.arguments.Min, u156, u155.arguments) or u19[u157][u156];
            local v161 = u155.arguments.Max and u9(u155.arguments.Max, u156, u155.arguments) or u20[u157][u156];
            local l__X__12 = l__GrabBar__11.AbsoluteSize.X;
            local v162 = (u2.getMouseLocation().X - (v158.AbsolutePosition.X - u2.GuiOffset.X + l__X__12 / 2)) / (v158.AbsoluteSize.X - l__X__12) * math.floor((v161 - v160) / v159);
            local v163 = math.round(v162) * v159 + v160;
            local v164 = math.clamp(v163, v160, v161);
            u155.state.number:set(u17(u155.state.number.value, u156, v164, u155.arguments));
            u155.lastNumberChangedTick = u1._cycleTick + 1;
        end;
    end;
    local function u169(p166, p167, p168) --[[ Line: 848 ]]
        -- upvalues: u2 (copy), u154 (ref), u155 (ref), u156 (ref), u157 (ref), u165 (copy)
        if u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            p166.state.editingText:set(p168);
        else
            u154 = true;
            u155 = p166;
            u156 = p168;
            u157 = p167;
            u165();
        end;
    end;
    u2.registerEvent("InputChanged", function() --[[ Line: 861 ]]
        -- upvalues: u1 (copy), u165 (copy)
        if u1._started then
            u165();
        end;
    end);
    u2.registerEvent("InputEnded", function(p170) --[[ Line: 868 ]]
        -- upvalues: u1 (copy), u154 (ref), u155 (ref), u156 (ref), u157 (ref)
        if u1._started then
            if p170.UserInputType == Enum.UserInputType.MouseButton1 and u154 then
                u154 = false;
                u155 = nil;
                u156 = 0;
                u157 = "";
            end;
        end;
    end);
    local function u179(u171, u172, p173, u174) --[[ Line: 880 ]]
        -- upvalues: u1 (copy), u2 (copy), u59 (copy), u169 (copy)
        local v175 = Instance.new("TextButton");
        v175.Name = "SliderField" .. tostring(u172);
        v175.AutomaticSize = Enum.AutomaticSize.Y;
        v175.Size = p173;
        v175.BackgroundColor3 = u1._config.FrameBgColor;
        v175.BackgroundTransparency = u1._config.FrameBgTransparency;
        v175.Text = "";
        v175.AutoButtonColor = false;
        v175.LayoutOrder = u172;
        v175.ClipsDescendants = true;
        u2.applyFrameStyle(v175);
        u2.applyTextStyle(v175);
        u2.UISizeConstraint(v175, Vector2.xAxis);
        local v176 = Instance.new("TextLabel");
        v176.Name = "OverlayText";
        v176.Size = UDim2.fromScale(1, 1);
        v176.BackgroundTransparency = 1;
        v176.BorderSizePixel = 0;
        v176.ZIndex = 10;
        v176.ClipsDescendants = true;
        u2.applyTextStyle(v176);
        v176.TextXAlignment = Enum.TextXAlignment.Center;
        v176.Parent = v175;
        u2.applyInteractionHighlights("Background", v175, v175, {
            Color = u1._config.FrameBgColor,
            Transparency = u1._config.FrameBgTransparency,
            HoveredColor = u1._config.FrameBgHoveredColor,
            HoveredTransparency = u1._config.FrameBgHoveredTransparency,
            ActiveColor = u1._config.FrameBgActiveColor,
            ActiveTransparency = u1._config.FrameBgActiveTransparency
        });
        local u177 = Instance.new("TextBox");
        u177.Name = "InputField";
        u177.Size = UDim2.fromScale(1, 1);
        u177.BackgroundTransparency = 1;
        u177.ClearTextOnFocus = false;
        u177.TextTruncate = Enum.TextTruncate.AtEnd;
        u177.ClipsDescendants = true;
        u177.Visible = false;
        u2.applyFrameStyle(u177, true);
        u2.applyTextStyle(u177);
        u177.Parent = v175;
        u177.FocusLost:Connect(function() --[[ Line: 933 ]]
            -- upvalues: u59 (ref), u171 (copy), u177 (copy), u172 (copy), u174 (copy)
            u59(u171, u177, u172, u174);
        end);
        u177.Focused:Connect(function() --[[ Line: 937 ]]
            -- upvalues: u177 (copy), u171 (copy), u172 (copy)
            u177.CursorPosition = #u177.Text + 1;
            u177.SelectionStart = 1;
            u171.state.editingText:set(u172);
        end);
        u2.applyButtonDown(v175, function() --[[ Line: 945 ]]
            -- upvalues: u169 (ref), u171 (copy), u174 (copy), u172 (copy)
            u169(u171, u174, u172);
        end);
        local v178 = Instance.new("Frame");
        v178.Name = "GrabBar";
        v178.AnchorPoint = Vector2.new(0.5, 0.5);
        v178.Position = UDim2.fromScale(0, 0.5);
        v178.BackgroundColor3 = u1._config.SliderGrabColor;
        v178.Transparency = u1._config.SliderGrabTransparency;
        v178.BorderSizePixel = 0;
        v178.ZIndex = 5;
        u2.applyInteractionHighlights("Background", v175, v178, {
            Color = u1._config.SliderGrabColor,
            Transparency = u1._config.SliderGrabTransparency,
            HoveredColor = u1._config.SliderGrabColor,
            HoveredTransparency = u1._config.SliderGrabTransparency,
            ActiveColor = u1._config.SliderGrabActiveColor,
            ActiveTransparency = u1._config.SliderGrabActiveTransparency
        });
        if u1._config.GrabRounding > 0 then
            u2.UICorner(v178, u1._config.GrabRounding);
        end;
        u2.UISizeConstraint(v178, Vector2.new(u1._config.GrabMinSize, 0));
        v178.Parent = v175;
        return v175;
    end;
    local function v206(u180, u181, p182) --[[ Line: 978 ]]
        -- upvalues: u50 (copy), u2 (copy), u1 (copy), u179 (copy), u9 (copy), u18 (copy), u19 (copy), u20 (copy)
        local v183 = u50("Slider", u180, u181, p182);
        return u2.extend(v183, {
            Generate = function(p184) --[[ Name: Generate, Line 982 ]]
                -- upvalues: u180 (copy), u1 (ref), u2 (ref), u181 (copy), u179 (ref)
                local v185 = Instance.new("Frame");
                v185.Name = "Iris_Slider" .. u180;
                v185.AutomaticSize = Enum.AutomaticSize.Y;
                v185.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
                v185.BackgroundTransparency = 1;
                v185.BorderSizePixel = 0;
                u2.UIListLayout(v185, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v186 = UDim.new(u1._config.ContentWidth.Scale / u181, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u181 - 1)) / u181);
                local v187 = UDim.new(v186.Scale * (u181 - 1), v186.Offset * (u181 - 1) + u1._config.ItemInnerSpacing.X * (u181 - 1));
                local v188 = u1._config.ContentWidth - v187;
                for v189 = 1, u181 do
                    local v190 = u179;
                    local v191;
                    if v189 == u181 then
                        v191 = UDim2.new(v188, u1._config.ContentHeight);
                    else
                        v191 = UDim2.new(v186, u1._config.ContentHeight);
                    end;
                    v190(p184, v189, v191, u180).Parent = v185;
                end;
                local v192 = Instance.new("TextLabel");
                v192.Name = "TextLabel";
                v192.AutomaticSize = Enum.AutomaticSize.XY;
                v192.BackgroundTransparency = 1;
                v192.BorderSizePixel = 0;
                v192.LayoutOrder = 5;
                u2.applyTextStyle(v192);
                v192.Parent = v185;
                return v185;
            end,
            UpdateState = function(p193) --[[ Name: UpdateState, Line 1016 ]]
                -- upvalues: u181 (copy), u9 (ref), u18 (ref), u180 (copy), u19 (ref), u20 (ref)
                local l__Instance__13 = p193.Instance;
                for v194 = 1, u181 do
                    local v195 = l__Instance__13:FindFirstChild("SliderField" .. tostring(v194));
                    local l__InputField__14 = v195.InputField;
                    local l__OverlayText__15 = v195.OverlayText;
                    local l__GrabBar__16 = v195.GrabBar;
                    local v196 = u9(p193.state.number.value, v194, p193.arguments);
                    local v197 = p193.arguments.Format[v194] or p193.arguments.Format[1];
                    if p193.arguments.Prefix then
                        v197 = p193.arguments.Prefix[v194] .. v197;
                    end;
                    l__OverlayText__15.Text = string.format(v197, v196);
                    l__InputField__14.Text = tostring(v196);
                    local v198 = p193.arguments.Increment and u9(p193.arguments.Increment, v194, p193.arguments) or u18[u180][v194];
                    local v199 = p193.arguments.Min and u9(p193.arguments.Min, v194, p193.arguments) or u19[u180][v194];
                    local v200 = p193.arguments.Max and u9(p193.arguments.Max, v194, p193.arguments) or u20[u180][v194];
                    local l__X__17 = v195.AbsoluteSize.X;
                    local v201 = l__X__17 - l__GrabBar__16.AbsoluteSize.X;
                    local v202 = (v196 - v199) / (v200 - v199);
                    local v203 = math.floor((v200 - v199) / v198);
                    local v204 = math.floor(v202 * v203) / v203;
                    local v205 = math.clamp(v204, 0, 1);
                    l__GrabBar__16.Position = UDim2.fromScale(v201 / l__X__17 * v205 + (1 - v201 / l__X__17) / 2, 0.5);
                    if p193.state.editingText.value == v194 then
                        l__InputField__14.Visible = true;
                        l__OverlayText__15.Visible = false;
                        l__GrabBar__16.Visible = false;
                        l__InputField__14:CaptureFocus();
                    else
                        l__InputField__14.Visible = false;
                        l__OverlayText__15.Visible = true;
                        l__GrabBar__16.Visible = true;
                    end;
                end;
            end
        });
    end;
    local v207 = v96("Num", 1, 0);
    v207.Args.NoButtons = 6;
    u1.WidgetConstructor("InputNum", v207);
    u1.WidgetConstructor("InputVector2", v96("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("InputVector3", v96("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("InputUDim", v96("UDim", 2, UDim.new()));
    u1.WidgetConstructor("InputUDim2", v96("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("InputRect", v96("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("DragNum", u147("Num", 1, 0));
    u1.WidgetConstructor("DragVector2", u147("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("DragVector3", u147("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("DragUDim", u147("UDim", 2, UDim.new()));
    u1.WidgetConstructor("DragUDim2", u147("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("DragRect", u147("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("InputColor3", v153("Color3", Color3.fromRGB(0, 0, 0)));
    u1.WidgetConstructor("InputColor4", v153("Color4", Color3.fromRGB(0, 0, 0), 0));
    u1.WidgetConstructor("SliderNum", v206("Num", 1, 0));
    u1.WidgetConstructor("SliderVector2", v206("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("SliderVector3", v206("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("SliderUDim", v206("UDim", 2, UDim.new()));
    u1.WidgetConstructor("SliderUDim2", v206("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("SliderRect", v206("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("InputText", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            TextHint = 2,
            ReadOnly = 3,
            MultiLine = 4
        },
        Events = {
            textChanged = {
                Init = function(p208) --[[ Line: 1146 ]]
                    p208.lastTextChangedTick = 0;
                end,
                Get = function(p209) --[[ Line: 1149 ]]
                    -- upvalues: u1 (copy)
                    return p209.lastTextChangedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p210) --[[ Line: 1153 ]]
                return p210.Instance;
            end)
        },
        Generate = function(u211) --[[ Name: Generate, Line 1157 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v212 = Instance.new("Frame");
            v212.Name = "Iris_InputText";
            v212.AutomaticSize = Enum.AutomaticSize.Y;
            v212.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v212.BackgroundTransparency = 1;
            v212.BorderSizePixel = 0;
            u2.UIListLayout(v212, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local u213 = Instance.new("TextBox");
            u213.Name = "InputField";
            u213.AutomaticSize = Enum.AutomaticSize.Y;
            u213.Size = UDim2.new(u1._config.ContentWidth, u1._config.ContentHeight);
            u213.BackgroundColor3 = u1._config.FrameBgColor;
            u213.BackgroundTransparency = u1._config.FrameBgTransparency;
            u213.Text = "";
            u213.TextYAlignment = Enum.TextYAlignment.Top;
            u213.PlaceholderColor3 = u1._config.TextDisabledColor;
            u213.ClearTextOnFocus = false;
            u213.ClipsDescendants = true;
            u2.applyFrameStyle(u213);
            u2.applyTextStyle(u213);
            u2.UISizeConstraint(u213, Vector2.xAxis);
            u213.Parent = v212;
            u213.FocusLost:Connect(function() --[[ Line: 1185 ]]
                -- upvalues: u211 (copy), u213 (copy), u1 (ref)
                u211.state.text:set(u213.Text);
                u211.lastTextChangedTick = u1._cycleTick + 1;
            end);
            local v214 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local v215 = Instance.new("TextLabel");
            v215.Name = "TextLabel";
            v215.AutomaticSize = Enum.AutomaticSize.X;
            v215.Size = UDim2.fromOffset(0, v214);
            v215.BackgroundTransparency = 1;
            v215.BorderSizePixel = 0;
            v215.LayoutOrder = 1;
            u2.applyTextStyle(v215);
            v215.Parent = v212;
            return v212;
        end,
        GenerateState = function(p216) --[[ Name: GenerateState, Line 1206 ]]
            -- upvalues: u1 (copy)
            if p216.state.text == nil then
                p216.state.text = u1._widgetState(p216, "text", "");
            end;
        end,
        Update = function(p217) --[[ Name: Update, Line 1211 ]]
            local l__Instance__18 = p217.Instance;
            local l__TextLabel__19 = l__Instance__18.TextLabel;
            local l__InputField__20 = l__Instance__18.InputField;
            l__TextLabel__19.Text = p217.arguments.Text or "Input Text";
            l__InputField__20.PlaceholderText = p217.arguments.TextHint or "";
            l__InputField__20.TextEditable = not p217.arguments.ReadOnly;
            l__InputField__20.MultiLine = p217.arguments.MultiLine or false;
        end,
        UpdateState = function(p218) --[[ Name: UpdateState, Line 1221 ]]
            p218.Instance.InputField.Text = p218.state.text.value;
        end,
        Discard = function(p219) --[[ Name: Discard, Line 1227 ]]
            -- upvalues: u2 (copy)
            p219.Instance:Destroy();
            u2.discardState(p219);
        end
    });
end;