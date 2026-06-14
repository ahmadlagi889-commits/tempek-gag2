-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
return function(u1) --[[ Line: 3 ]]
    local u2 = u1.State(true);
    local u3 = u1.State(false);
    local u4 = u1.State(false);
    local u5 = u1.State(false);
    local u6 = u1.State(false);
    local u7 = u1.State(false);
    local u8 = u1.State(false);
    local u9 = u1.State(false);
    local u10 = u1.State(Color3.fromRGB(115, 140, 152));
    local u11 = u1.State(0);
    table.insert(u1.Internal._initFunctions, function() --[[ Line: 15 ]]
        -- upvalues: u10 (copy), u11 (copy), u1 (copy), u9 (copy)
        local u12 = Instance.new("Frame");
        u12.Name = "Background";
        u12.Size = UDim2.fromScale(1, 1);
        u12.BackgroundColor3 = u10.value;
        u12.BackgroundTransparency = u11.value;
        local u13;
        if u1._config.UseScreenGUIs then
            u13 = Instance.new("ScreenGui");
            u13.Name = "Iris_Background";
            u13.IgnoreGuiInset = true;
            u13.DisplayOrder = u1._config.DisplayOrderOffset - 1;
            u13.ScreenInsets = Enum.ScreenInsets.None;
            u13.Enabled = true;
            u12.Parent = u13;
        else
            u12.ZIndex = u1._config.DisplayOrderOffset - 1;
            u13 = u12;
        end;
        u10:onChange(function(p14) --[[ Line: 37 ]]
            -- upvalues: u12 (copy)
            u12.BackgroundColor3 = p14;
        end);
        u11:onChange(function(p15) --[[ Line: 40 ]]
            -- upvalues: u12 (copy)
            u12.BackgroundTransparency = p15;
        end);
        u9:onChange(function(p16) --[[ Line: 44 ]]
            -- upvalues: u13 (ref), u1 (ref)
            if p16 then
                u13.Parent = u1.Internal.parentInstance;
            else
                u13.Parent = nil;
            end;
        end);
    end);
    local function u19(p17) --[[ Line: 53 ]]
        -- upvalues: u1 (copy)
        u1.PushConfig({
            TextColor = u1._config.TextDisabledColor
        });
        local v18 = u1.Text({ "(?)" });
        u1.PopConfig();
        u1.PushConfig({
            ContentWidth = UDim.new(0, 350)
        });
        if v18.hovered() then
            u1.Tooltip({ p17 });
        end;
        u1.PopConfig();
    end;
    local u88 = {
        Basic = function() --[[ Name: Basic, Line 76 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Basic" });
            u1.SeparatorText({ "Basic" });
            local v20 = u1.State(1);
            u1.Button({ "Button" });
            u1.SmallButton({ "SmallButton" });
            u1.Text({ "Text" });
            u1.TextWrapped({ string.rep("Text Wrapped ", 5) });
            u1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) });
            u1.Text({
                "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>",
                true,
                nil,
                true
            });
            u1.SameLine();
            u1.RadioButton({ "Index \'1\'", 1 }, {
                index = v20
            });
            u1.RadioButton({ "Index \'two\'", "two" }, {
                index = v20
            });
            if u1.RadioButton({ "Index \'false\'", false }, {
                index = v20
            }).active() == false and u1.SmallButton({ "Select last" }).clicked() then
                v20:set(false);
            end;
            u1.End();
            u1.Text({ "The Index is: " .. tostring(v20.value) });
            u1.SeparatorText({ "Inputs" });
            u1.InputNum({});
            u1.DragNum({});
            u1.SliderNum({});
            u1.End();
        end,
        Image = function() --[[ Name: Image, Line 112 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Image" });
            u1.SeparatorText({ "Image Controls" });
            local v21 = u1.State("rbxasset://textures/ui/common/robux.png");
            local v22 = u1.State(UDim2.fromOffset(100, 100));
            local v23 = u1.State(Rect.new(0, 0, 0, 0));
            local v24 = u1.State(Enum.ScaleType.Stretch);
            local v25 = u1.State(false);
            local v27 = u1.ComputedState(v25, function(p26) --[[ Line: 122 ]]
                return p26 and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default;
            end);
            local v28 = u1.State(u1._config.ImageColor);
            local v29 = u1.State(u1._config.ImageTransparency);
            u1.InputColor4({ "Image Tint" }, {
                color = v28,
                transparency = v29
            });
            u1.Combo({ "Asset" }, {
                index = v21
            });
            u1.Selectable({ "Robux Small", "rbxasset://textures/ui/common/robux.png" }, {
                index = v21
            });
            u1.Selectable({ "Robux Large", "rbxasset://textures//ui/common/robux@3x.png" }, {
                index = v21
            });
            u1.Selectable({ "Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png" }, {
                index = v21
            });
            u1.Selectable({ "Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png" }, {
                index = v21
            });
            u1.Selectable({ "famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png" }, {
                index = v21
            });
            u1.End();
            u1.SliderUDim2({
                "Image Size",
                nil,
                nil,
                UDim2.new(1, 240, 1, 240)
            }, {
                number = v22
            });
            u1.SliderRect({
                "Image Rect",
                nil,
                nil,
                Rect.new(256, 256, 256, 256)
            }, {
                number = v23
            });
            u1.Combo({ "Scale Type" }, {
                index = v24
            });
            u1.Selectable({ "Stretch", Enum.ScaleType.Stretch }, {
                index = v24
            });
            u1.Selectable({ "Fit", Enum.ScaleType.Fit }, {
                index = v24
            });
            u1.Selectable({ "Crop", Enum.ScaleType.Crop }, {
                index = v24
            });
            u1.End();
            u1.Checkbox({ "Pixelated" }, {
                isChecked = v25
            });
            u1.PushConfig({
                ImageColor = v28:get(),
                ImageTransparency = v29:get()
            });
            u1.Image({
                v21:get(),
                v22:get(),
                v23:get(),
                v24:get(),
                v27:get()
            });
            u1.PopConfig();
            u1.SeparatorText({ "Tile" });
            local v30 = u1.State(UDim2.fromScale(0.5, 0.5));
            u1.SliderUDim2({
                "Tile Size",
                nil,
                nil,
                UDim2.new(1, 240, 1, 240)
            }, {
                number = v30
            });
            u1.PushConfig({
                ImageColor = v28:get(),
                ImageTransparency = v29:get()
            });
            u1.Image({
                "rbxasset://textures/grid2.png",
                v22:get(),
                nil,
                Enum.ScaleType.Tile,
                v27:get(),
                v30:get()
            });
            u1.PopConfig();
            u1.SeparatorText({ "Slice" });
            local v31 = u1.State(1);
            u1.SliderNum({
                "Image Slice Scale",
                0.1,
                0.1,
                5
            }, {
                number = v31
            });
            u1.PushConfig({
                ImageColor = v28:get(),
                ImageTransparency = v29:get()
            });
            u1.Image({
                "rbxasset://textures/ui/chatBubble_blue_notify_bkg.png",
                v22:get(),
                nil,
                Enum.ScaleType.Slice,
                v27:get(),
                nil,
                Rect.new(12, 12, 56, 56),
                1
            }, v31:get());
            u1.PopConfig();
            u1.SeparatorText({ "Image Button" });
            local v32 = u1.State(0);
            u1.SameLine();
            u1.PushConfig({
                ImageColor = v28:get(),
                ImageTransparency = v29:get()
            });
            if u1.ImageButton({ "rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20) }).clicked() then
                v32:set(v32.value + 1);
            end;
            u1.PopConfig();
            u1.Text({ (`Click count: {v32.value}`) });
            u1.End();
            u1.End();
        end,
        Selectable = function() --[[ Name: Selectable, Line 203 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Selectable" });
            local v33 = u1.State(2);
            u1.Selectable({ "Selectable #1", 1 }, {
                index = v33
            });
            u1.Selectable({ "Selectable #2", 2 }, {
                index = v33
            });
            if u1.Selectable({ "Double click Selectable", 3, true }, {
                index = v33
            }).doubleClicked() then
                v33:set(3);
            end;
            u1.Selectable({ "Impossible to select", 4, true }, {
                index = v33
            });
            if u1.Button({ "Select last" }).clicked() then
                v33:set(4);
            end;
            u1.Selectable({ "Independent Selectable" });
            u1.End();
        end,
        Combo = function() --[[ Name: Combo, Line 223 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Combo" });
            u1.PushConfig({
                ContentWidth = UDim.new(1, -200)
            });
            local v34 = u1.State("No Selection");
            u1.SameLine();
            local v35 = u1.Checkbox({ "No Preview" });
            local v36 = u1.Checkbox({ "No Button" });
            if v35.checked() and v36.isChecked.value == true then
                v36.isChecked:set(false);
            end;
            if v36.checked() and v35.isChecked.value == true then
                v35.isChecked:set(false);
            end;
            u1.End();
            u1.Combo({ "Basic Usage", v36.isChecked:get(), v35.isChecked:get() }, {
                index = v34
            });
            u1.Selectable({ "Select 1", "One" }, {
                index = v34
            });
            u1.Selectable({ "Select 2", "Two" }, {
                index = v34
            });
            u1.Selectable({ "Select 3", "Three" }, {
                index = v34
            });
            u1.End();
            u1.ComboArray({ "Using ComboArray" }, {
                index = "No Selection"
            }, { "Red", "Green", "Blue" });
            local v37 = {};
            for v38 = 1, 50 do
                local v39 = tostring(v38);
                table.insert(v37, v39);
            end;
            u1.ComboArray({ "Height Test" }, {
                index = "1"
            }, v37);
            local v40 = u1.State("7 AM");
            u1.Combo({ "Combo with Inner widgets" }, {
                index = v40
            });
            u1.Tree({ "Morning Shifts" });
            u1.Selectable({ "Shift at 7 AM", "7 AM" }, {
                index = v40
            });
            u1.Selectable({ "Shift at 11 AM", "11 AM" }, {
                index = v40
            });
            u1.Selectable({ "Shift at 3 PM", "3 PM" }, {
                index = v40
            });
            u1.End();
            u1.Tree({ "Night Shifts" });
            u1.Selectable({ "Shift at 6 PM", "6 PM" }, {
                index = v40
            });
            u1.Selectable({ "Shift at 9 PM", "9 PM" }, {
                index = v40
            });
            u1.End();
            u1.End();
            local v41 = u1.ComboEnum({ "Using ComboEnum" }, {
                index = Enum.UserInputState.Begin
            }, Enum.UserInputState);
            u1.Text({ "Selected: " .. v41.index:get().Name });
            u1.PopConfig();
            u1.End();
        end,
        Tree = function() --[[ Name: Tree, Line 286 ]]
            -- upvalues: u1 (copy), u19 (copy)
            u1.Tree({ "Trees" });
            u1.Tree({ "Tree using SpanAvailWidth", true });
            u19("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area");
            u1.End();
            local v42 = u1.Tree({ "Tree with Children" });
            u1.Text({ "Im inside the first tree!" });
            u1.Button({ "Im a button inside the first tree!" });
            u1.Tree({ "Im a tree inside the first tree!" });
            u1.Text({ "I am the innermost text!" });
            u1.End();
            u1.End();
            u1.Checkbox({ "Toggle above tree" }, {
                isChecked = v42.state.isUncollapsed
            });
            u1.End();
        end,
        CollapsingHeader = function() --[[ Name: CollapsingHeader, Line 312 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Collapsing Headers" });
            u1.CollapsingHeader({ "A header" });
            u1.Text({ "This is under the first header!" });
            u1.End();
            local v43 = u1.State(false);
            u1.CollapsingHeader({ "Another header" }, {
                isUncollapsed = v43
            });
            if u1.Button({ "Shhh... secret button!" }).clicked() then
                v43:set(true);
            end;
            u1.End();
            u1.End();
        end,
        Group = function() --[[ Name: Group, Line 333 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Groups" });
            u1.SameLine();
            u1.Group();
            u1.Text({ "I am in group A" });
            u1.Button({ "Im also in A" });
            u1.End();
            u1.Separator();
            u1.Group();
            u1.Text({ "I am in group B" });
            u1.Button({ "Im also in B" });
            u1.Button({ "Also group B" });
            u1.End();
            u1.End();
            u1.End();
        end,
        Tab = function() --[[ Name: Tab, Line 360 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Tabs" });
            u1.Tree({ "Simple" });
            u1.TabBar();
            u1.Tab({ "Apples" });
            u1.Text({ "Who loves apples?" });
            u1.End();
            u1.Tab({ "Broccoli" });
            u1.Text({ "And what about broccoli?" });
            u1.End();
            u1.Tab({ "Carrots" });
            u1.Text({ "But carrots are the best." });
            u1.End();
            u1.End();
            u1.Separator();
            u1.Text({ "Very important questions." });
            u1.End();
            u1.Tree({ "Closable" });
            local v44 = u1.State(true);
            local v45 = u1.State(true);
            local v46 = u1.State(true);
            u1.TabBar();
            u1.Tab({ "🍎", true }, {
                isOpened = v44
            });
            u1.Text({ "Who loves apples?" });
            if u1.Button({ "I don\'t like apples." }).clicked() then
                v44:set(false);
            end;
            u1.End();
            u1.Tab({ "🥦", true }, {
                isOpened = v45
            });
            u1.Text({ "And what about broccoli?" });
            if u1.Button({ "Not for me." }).clicked() then
                v45:set(false);
            end;
            u1.End();
            u1.Tab({ "🥕", true }, {
                isOpened = v46
            });
            u1.Text({ "But carrots are the best." });
            if u1.Button({ "I disagree with you." }).clicked() then
                v46:set(false);
            end;
            u1.End();
            u1.End();
            u1.Separator();
            if u1.Button({ "Actually, let me reconsider it." }).clicked() then
                v44:set(true);
                v45:set(true);
                v46:set(true);
            end;
            u1.End();
            u1.End();
        end,
        Indent = function() --[[ Name: Indent, Line 435 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Indents" });
            u1.Text({ "Not Indented" });
            u1.Indent();
            u1.Text({ "Indented" });
            u1.Indent({ 7 });
            u1.Text({ "Indented by 7 more pixels" });
            u1.End();
            u1.Indent({ -7 });
            u1.Text({ "Indented by 7 less pixels" });
            u1.End();
            u1.End();
            u1.End();
        end,
        Input = function() --[[ Name: Input, Line 457 ]]
            -- upvalues: u1 (copy), u19 (copy)
            u1.Tree({ "Input" });
            local v47 = u1.State(false);
            local v48 = u1.State(false);
            local v49 = u1.State(0);
            local v50 = u1.State(100);
            local v51 = u1.State(1);
            local v52 = u1.State("%d");
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            local v53 = u1.InputNum({
                [u1.Args.InputNum.Text] = "Input Number",
                [u1.Args.InputNum.NoButtons] = v48.value,
                [u1.Args.InputNum.Min] = v49.value,
                [u1.Args.InputNum.Max] = v50.value,
                [u1.Args.InputNum.Increment] = v51.value,
                [u1.Args.InputNum.Format] = { v52.value }
            });
            u1.PopConfig();
            u1.Text({ "The Value is: " .. v53.number.value });
            if u1.Button({ "Randomize Number" }).clicked() then
                v53.number:set(math.random(1, 99));
            end;
            local v54 = u1.Checkbox({ "NoField" }, {
                isChecked = v47
            });
            local v55 = u1.Checkbox({ "NoButtons" }, {
                isChecked = v48
            });
            if v54.checked() and v55.isChecked.value == true then
                v55.isChecked:set(false);
            end;
            if v55.checked() and v54.isChecked.value == true then
                v54.isChecked:set(false);
            end;
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.InputVector2({ "InputVector2" });
            u1.InputVector3({ "InputVector3" });
            u1.InputUDim({ "InputUDim" });
            u1.InputUDim2({ "InputUDim2" });
            local v56 = u1.State(false);
            local v57 = u1.State(false);
            local v58 = u1.State(Color3.new());
            local v59 = u1.State(0);
            u1.SliderNum({
                "Transparency",
                0.01,
                0,
                1
            }, {
                number = v59
            });
            u1.InputColor3({ "InputColor3", v56:get(), v57:get() }, {
                color = v58
            });
            u1.InputColor4({ "InputColor4", v56:get(), v57:get() }, {
                color = v58,
                transparency = v59
            });
            u1.SameLine();
            u1.Text({ (`#{v58:get():ToHex()}`) });
            u1.Checkbox({ "Use Floats" }, {
                isChecked = v56
            });
            u1.Checkbox({ "Use HSV" }, {
                isChecked = v57
            });
            u1.End();
            u1.PopConfig();
            u1.Separator();
            u1.SameLine();
            u1.Text({ "Slider Numbers" });
            u19("ctrl + click slider number widgets to input a number");
            u1.End();
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.SliderNum({
                "Slide Int",
                1,
                1,
                8
            });
            u1.SliderNum({
                "Slide Float",
                0.01,
                0,
                100
            });
            u1.SliderNum({
                "Small Numbers",
                0.001,
                -2,
                1,
                "%f radians"
            });
            u1.SliderNum({
                "Odd Ranges",
                0.001,
                -3.141592653589793,
                3.141592653589793,
                "%f radians"
            });
            u1.SliderNum({
                "Big Numbers",
                10000,
                100000,
                10000000
            });
            u1.SliderNum({
                "Few Numbers",
                1,
                0,
                3
            });
            u1.PopConfig();
            u1.Separator();
            u1.SameLine();
            u1.Text({ "Drag Numbers" });
            u19("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed");
            u1.End();
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.DragNum({ "Drag Int" });
            u1.DragNum({
                "Slide Float",
                0.001,
                -10,
                10
            });
            u1.DragNum({
                "Percentage",
                1,
                0,
                100,
                "%d %%"
            });
            u1.PopConfig();
            u1.End();
        end,
        InputText = function() --[[ Name: InputText, Line 540 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Input Text" });
            local v60 = u1.InputText({ "Input Text Test", "Input Text here" });
            u1.Text({ "The text is: " .. v60.text.value });
            u1.End();
        end,
        MultiInput = function() --[[ Name: MultiInput, Line 549 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Multi-Component Input" });
            local v61 = u1.State(Vector2.new());
            local v62 = u1.State((Vector3.new()));
            local v63 = u1.State(UDim.new());
            local v64 = u1.State(UDim2.new());
            local v65 = u1.State(Color3.new());
            local v66 = u1.State(Rect.new(0, 0, 0, 0));
            u1.SeparatorText({ "Input" });
            u1.InputVector2({}, {
                number = v61
            });
            u1.InputVector3({}, {
                number = v62
            });
            u1.InputUDim({}, {
                number = v63
            });
            u1.InputUDim2({}, {
                number = v64
            });
            u1.InputRect({}, {
                number = v66
            });
            u1.SeparatorText({ "Drag" });
            u1.DragVector2({}, {
                number = v61
            });
            u1.DragVector3({}, {
                number = v62
            });
            u1.DragUDim({}, {
                number = v63
            });
            u1.DragUDim2({}, {
                number = v64
            });
            u1.DragRect({}, {
                number = v66
            });
            u1.SeparatorText({ "Slider" });
            u1.SliderVector2({}, {
                number = v61
            });
            u1.SliderVector3({}, {
                number = v62
            });
            u1.SliderUDim({}, {
                number = v63
            });
            u1.SliderUDim2({}, {
                number = v64
            });
            u1.SliderRect({}, {
                number = v66
            });
            u1.SeparatorText({ "Color" });
            u1.InputColor3({}, {
                color = v65
            });
            u1.InputColor4({}, {
                color = v65
            });
            u1.End();
        end,
        Tooltip = function() --[[ Name: Tooltip, Line 591 ]]
            -- upvalues: u1 (copy)
            u1.PushConfig({
                ContentWidth = UDim.new(0, 250)
            });
            u1.Tree({ "Tooltip" });
            if u1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
                u1.Tooltip({ "I am some helpful tooltip text" });
            end;
            local v67 = u1.State("Hello ");
            local v68 = u1.State(1);
            if u1.InputNum({
                "# of repeat",
                1,
                1,
                50
            }, {
                number = v68
            }).numberChanged() then
                v67:set(string.rep("Hello ", v68:get()));
            end;
            if u1.Checkbox({ "Show dynamic text tooltip" }).state.isChecked.value then
                u1.Tooltip({ v67:get() });
            end;
            u1.End();
            u1.PopConfig();
        end,
        Plotting = function() --[[ Name: Plotting, Line 611 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Plotting" });
            u1.SeparatorText({ "Progress" });
            local v69 = os.clock() * 15;
            local v70 = u1.State(0);
            local v71 = math.abs(v69 % 100 - 50) - 7.5;
            v70:set(math.clamp(v71, 0, 35) / 35);
            u1.ProgressBar({ "Progress Bar" }, {
                progress = v70
            });
            local l__ProgressBar__1 = u1.ProgressBar;
            local v72 = {};
            local v73 = v70:get() * 1753;
            v72[1], v72[2] = "Progress Bar", `{math.floor(v73)}/1753`;
            l__ProgressBar__1(v72, {
                progress = v70
            });
            u1.SeparatorText({ "Graphs" });
            local v74 = u1.State({
                0.5,
                0.8,
                0.2,
                0.9,
                0.1,
                0.6,
                0.4,
                0.7,
                0.3,
                0
            });
            u1.PlotHistogram({
                "Histogram",
                100,
                0,
                1,
                "random"
            }, {
                values = v74
            });
            u1.PlotLines({
                "Lines",
                100,
                0,
                1,
                "random"
            }, {
                values = v74
            });
            local v75 = u1.State("Cos");
            local v76 = u1.State(37);
            local v77 = u1.State(0);
            local v78 = u1.State({});
            local v79 = u1.State(0);
            local v80 = u1.Checkbox({ "Animate" });
            local v81 = u1.ComboArray({ "Plotting Function" }, {
                index = v75
            }, {
                "Sin",
                "Cos",
                "Tan",
                "Saw"
            });
            local v82 = u1.SliderNum({
                "Samples",
                1,
                1,
                145,
                "%d samples"
            }, {
                number = v76
            });
            if u1.SliderNum({
                "Baseline",
                0.1,
                -1,
                1
            }, {
                number = v77
            }).numberChanged() then
                v78:set(v78.value, true);
            end;
            if v80.state.isChecked.value or (v81.closed() or (v82.numberChanged() or #v78.value == 0)) then
                if v80.state.isChecked.value then
                    v79:set(v79.value + u1.Internal._deltaTime);
                end;
                local v83 = math.floor(v79.value * 30) - 1;
                local l__value__2 = v75.value;
                table.clear(v78.value);
                for v84 = 1, v76.value do
                    if l__value__2 == "Sin" then
                        local l__value__3 = v78.value;
                        local v85 = math.rad((v84 + v83) * 5);
                        l__value__3[v84] = math.sin(v85);
                    elseif l__value__2 == "Cos" then
                        local l__value__4 = v78.value;
                        local v86 = math.rad((v84 + v83) * 5);
                        l__value__4[v84] = math.cos(v86);
                    elseif l__value__2 == "Tan" then
                        local l__value__5 = v78.value;
                        local v87 = math.rad((v84 + v83) * 5);
                        l__value__5[v84] = math.tan(v87);
                    elseif l__value__2 == "Saw" then
                        v78.value[v84] = v84 % 2 == v83 % 2 and 1 or -1;
                    end;
                end;
                v78:set(v78.value, true);
            end;
            u1.PlotHistogram({
                "Histogram",
                100,
                -1,
                1,
                "",
                v77:get()
            }, {
                values = v78
            });
            u1.PlotLines({
                "Lines",
                100,
                -1,
                1
            }, {
                values = v78
            });
            u1.End();
        end
    };
    local u89 = {
        "Basic",
        "Image",
        "Selectable",
        "Combo",
        "Tree",
        "CollapsingHeader",
        "Group",
        "Tab",
        "Indent",
        "Input",
        "MultiInput",
        "InputText",
        "Tooltip",
        "Plotting"
    };
    local function u90() --[[ Line: 679 ]]
        -- upvalues: u1 (copy), u90 (copy)
        if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
            u90();
        end;
        u1.End();
    end;
    local function u93(p91) --[[ Line: 689 ]]
        -- upvalues: u1 (copy), u93 (copy)
        u1.Window({ "Recursive Window" }, {
            size = u1.State(Vector2.new(175, 100)),
            isOpened = p91
        });
        local v92 = u1.Checkbox({ "Recurse Again" });
        u1.End();
        if v92.isChecked.value then
            u93(v92.isChecked);
        end;
    end;
    local function u114() --[[ Line: 703 ]]
        -- upvalues: u1 (copy), u4 (copy), u19 (copy)
        local v94 = u1.Window({ "Runtime Info" }, {
            isOpened = u4
        });
        local l___lastVDOM__6 = u1.Internal._lastVDOM;
        local l___states__7 = u1.Internal._states;
        local v95 = u1.State(3);
        local v96 = u1.State(0);
        local v97 = u1.State(os.clock());
        u1.SameLine();
        u1.InputNum({
            [u1.Args.InputNum.Text] = "",
            [u1.Args.InputNum.Format] = "%d Seconds",
            [u1.Args.InputNum.Max] = 10
        }, {
            number = v95
        });
        if u1.Button({ "Disable" }).clicked() then
            u1.Disabled = true;
            task.delay(v95:get(), function() --[[ Line: 718 ]]
                -- upvalues: u1 (ref)
                u1.Disabled = false;
            end);
        end;
        u1.End();
        local v98 = os.clock();
        v96.value = v96.value + (v98 - v97.value - v96.value) * 0.2;
        v97.value = v98;
        u1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", v96.value * 1000, 1 / v96.value) });
        u1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", v94.position.value.X, v94.position.value.Y, v94.size.value.X, v94.size.value.Y) });
        u1.SameLine();
        u1.Text({ "Enter an ID to learn more about it." });
        u19("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs");
        u1.End();
        u1.PushConfig({
            ItemWidth = UDim.new(1, -150)
        });
        local l__value__8 = u1.InputText({ "ID field" }, {
            text = u1.State(v94.ID)
        }).state.text.value;
        u1.PopConfig();
        u1.Indent();
        local v99 = l___lastVDOM__6[l__value__8];
        local v100 = l___states__7[l__value__8];
        if v99 then
            u1.Table({ 1 });
            u1.Text({ string.format("The ID, \"%s\", is a widget", l__value__8) });
            u1.NextRow();
            u1.Text({ string.format("Widget is type: %s", v99.type) });
            u1.NextRow();
            u1.Tree({ "Widget has Args:" }, {
                isUncollapsed = u1.State(true)
            });
            for v101, v102 in v99.arguments do
                u1.Text({ v101 .. " - " .. tostring(v102) });
            end;
            u1.End();
            u1.NextRow();
            if v99.state then
                u1.Tree({ "Widget has State:" }, {
                    isUncollapsed = u1.State(true)
                });
                for v103, v104 in v99.state do
                    u1.Text({ v103 .. " - " .. tostring(v104.value) });
                end;
                u1.End();
            end;
            u1.End();
        elseif v100 then
            u1.Table({ 1 });
            u1.Text({ string.format("The ID, \"%s\", is a state", l__value__8) });
            u1.NextRow();
            u1.Text({ string.format("Value is type: %s, Value = %s", typeof(v100.value), (tostring(v100.value))) });
            u1.NextRow();
            u1.Tree({ "state has connected widgets:" }, {
                isUncollapsed = u1.State(true)
            });
            for v105, v106 in v100.ConnectedWidgets do
                u1.Text({ v105 .. " - " .. v106.type });
            end;
            u1.End();
            u1.NextRow();
            u1.Text({ string.format("state has: %d connected functions", #v100.ConnectedFunctions) });
            u1.End();
        else
            u1.Text({ string.format("The ID, \"%s\", is not a state or widget", l__value__8) });
        end;
        u1.End();
        if u1.Tree({ "Widgets" }).state.isUncollapsed.value then
            local v107 = 0;
            local v108 = "";
            for _, v109 in l___lastVDOM__6 do
                v107 = v107 + 1;
                v108 = v108 .. "\n" .. v109.ID .. " - " .. v109.type;
            end;
            u1.Text({ "Number of Widgets: " .. v107 });
            u1.Text({ v108 });
        end;
        u1.End();
        if u1.Tree({ "States" }).state.isUncollapsed.value then
            local v110 = 0;
            local v111 = "";
            for v112, v113 in l___states__7 do
                v110 = v110 + 1;
                v111 = v111 .. "\n" .. v112 .. " - " .. tostring(v113.value);
            end;
            u1.Text({ "Number of States: " .. v110 });
            u1.Text({ v111 });
        end;
        u1.End();
        u1.End();
    end;
    local function u115() --[[ Line: 827 ]]
        -- upvalues: u1 (copy), u8 (copy)
        u1.Window({ "Debug Panel" }, {
            isOpened = u8
        });
        u1.CollapsingHeader({ "Widgets" });
        u1.SeparatorText({ "GuiService" });
        u1.Text({ (`GuiOffset: {u1.Internal._utility.GuiOffset}`) });
        u1.Text({ (`MouseOffset: {u1.Internal._utility.MouseOffset}`) });
        u1.SeparatorText({ "UserInputService" });
        u1.Text({ (`MousePosition: {u1.Internal._utility.UserInputService:GetMouseLocation()}`) });
        u1.Text({ (`MouseLocation: {u1.Internal._utility.getMouseLocation()}`) });
        u1.Text({ (`Left Control: {u1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)}`) });
        u1.Text({ (`Right Control: {u1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)}`) });
        u1.End();
        u1.End();
    end;
    local function u116() --[[ Line: 848 ]]
        -- upvalues: u1 (copy), u116 (copy)
        if u1.Menu({ "Recursive" }).state.isOpened.value then
            u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl });
            u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl });
            u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl });
            u1.Separator();
            u1.MenuToggle({ "Autosave" });
            u1.MenuToggle({ "Checked" });
            u1.Separator();
            u1.Menu({ "Options" });
            u1.MenuItem({ "Red" });
            u1.MenuItem({ "Yellow" });
            u1.MenuItem({ "Green" });
            u1.MenuItem({ "Blue" });
            u1.Separator();
            u116();
            u1.End();
        end;
        u1.End();
    end;
    local function u117() --[[ Line: 869 ]]
        -- upvalues: u1 (copy), u116 (copy), u2 (copy), u3 (copy), u6 (copy), u7 (copy), u4 (copy), u5 (copy), u8 (copy)
        u1.MenuBar();
        u1.Menu({ "File" });
        u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl });
        u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl });
        u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl });
        u116();
        if u1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt }).clicked() then
            u2:set(false);
        end;
        u1.End();
        u1.Menu({ "Examples" });
        u1.MenuToggle({ "Recursive Window" }, {
            isChecked = u3
        });
        u1.MenuToggle({ "Windowless" }, {
            isChecked = u6
        });
        u1.MenuToggle({ "Main Menu Bar" }, {
            isChecked = u7
        });
        u1.End();
        u1.Menu({ "Tools" });
        u1.MenuToggle({ "Runtime Info" }, {
            isChecked = u4
        });
        u1.MenuToggle({ "Style Editor" }, {
            isChecked = u5
        });
        u1.MenuToggle({ "Debug Panel" }, {
            isChecked = u8
        });
        u1.End();
        u1.End();
    end;
    local function u144() --[[ Line: 918 ]]
        -- upvalues: u1 (copy), u19 (copy), u5 (copy)
        local v139 = {
            { "Sizing", function() --[[ Line: 922 ]]
                    -- upvalues: u1 (ref), u19 (ref)
                    local u118 = u1.State({});
                    u1.SameLine();
                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(u118.value);
                        u118:set({});
                    end;
                    u19("Update the global config with these changes.");
                    u1.End();
                    local function v122(p119, p120) --[[ Line: 936 ]]
                        -- upvalues: u1 (ref), u118 (copy)
                        local v121 = u1[p119](p120, {
                            number = u1.WeakState(u1._config[p120[1]])
                        });
                        if v121.numberChanged() then
                            u118.value[p120[1]] = v121.number:get();
                        end;
                    end;
                    local function v125(p123) --[[ Line: 943 ]]
                        -- upvalues: u1 (ref), u118 (copy)
                        local v124 = u1.Checkbox(p123, {
                            isChecked = u1.WeakState(u1._config[p123[1]])
                        });
                        if v124.checked() or v124.unchecked() then
                            u118.value[p123[1]] = v124.isChecked:get();
                        end;
                    end;
                    u1.SeparatorText({ "Main" });
                    v122("SliderVector2", {
                        "WindowPadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    v122("SliderVector2", {
                        "WindowResizePadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    v122("SliderVector2", {
                        "FramePadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    v122("SliderVector2", {
                        "ItemSpacing",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    v122("SliderVector2", {
                        "ItemInnerSpacing",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    v122("SliderVector2", {
                        "CellPadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    v122("SliderNum", {
                        "IndentSpacing",
                        1,
                        0,
                        36
                    });
                    v122("SliderNum", {
                        "ScrollbarSize",
                        1,
                        0,
                        20
                    });
                    v122("SliderNum", {
                        "GrabMinSize",
                        1,
                        0,
                        20
                    });
                    u1.SeparatorText({ "Borders & Rounding" });
                    v122("SliderNum", {
                        "FrameBorderSize",
                        0.1,
                        0,
                        1
                    });
                    v122("SliderNum", {
                        "WindowBorderSize",
                        0.1,
                        0,
                        1
                    });
                    v122("SliderNum", {
                        "PopupBorderSize",
                        0.1,
                        0,
                        1
                    });
                    v122("SliderNum", {
                        "SeparatorTextBorderSize",
                        1,
                        0,
                        20
                    });
                    v122("SliderNum", {
                        "FrameRounding",
                        1,
                        0,
                        12
                    });
                    v122("SliderNum", {
                        "GrabRounding",
                        1,
                        0,
                        12
                    });
                    v122("SliderNum", {
                        "PopupRounding",
                        1,
                        0,
                        12
                    });
                    u1.SeparatorText({ "Widgets" });
                    v122("SliderVector2", {
                        "DisplaySafeAreaPadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    v122("SliderVector2", {
                        "SeparatorTextPadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(36, 36)
                    });
                    v122("SliderUDim", {
                        "ItemWidth",
                        nil,
                        UDim.new(),
                        UDim.new(1, 200)
                    });
                    v122("SliderUDim", {
                        "ContentWidth",
                        nil,
                        UDim.new(),
                        UDim.new(1, 200)
                    });
                    v122("SliderNum", {
                        "ImageBorderSize",
                        1,
                        0,
                        12
                    });
                    local v126 = u1.ComboEnum({ "WindowTitleAlign" }, {
                        index = u1.WeakState(u1._config.WindowTitleAlign)
                    }, Enum.LeftRight);
                    if v126.closed() then
                        u118.value.WindowTitleAlign = v126.index:get();
                    end;
                    v125({ "RichText" });
                    v125({ "TextWrapped" });
                    u1.SeparatorText({ "Config" });
                    v125({ "UseScreenGUIs" });
                    v122("DragNum", { "DisplayOrderOffset", 1, 0 });
                    v122("DragNum", { "ZIndexOffset", 1, 0 });
                    v122("SliderNum", {
                        "MouseDoubleClickTime",
                        0.1,
                        0,
                        5
                    });
                    v122("SliderNum", {
                        "MouseDoubleClickMaxDist",
                        0.1,
                        0,
                        20
                    });
                end },
            { "Colors", function() --[[ Line: 993 ]]
                    -- upvalues: u1 (ref), u19 (ref)
                    local v127 = u1.State({});
                    u1.SameLine();
                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(v127.value);
                        v127:set({});
                    end;
                    u19("Update the global config with these changes.");
                    u1.End();
                    for _, v128 in {
                        "Text",
                        "TextDisabled",
                        "WindowBg",
                        "PopupBg",
                        "Border",
                        "BorderActive",
                        "ScrollbarGrab",
                        "TitleBg",
                        "TitleBgActive",
                        "TitleBgCollapsed",
                        "MenubarBg",
                        "FrameBg",
                        "FrameBgHovered",
                        "FrameBgActive",
                        "Button",
                        "ButtonHovered",
                        "ButtonActive",
                        "Image",
                        "SliderGrab",
                        "SliderGrabActive",
                        "Header",
                        "HeaderHovered",
                        "HeaderActive",
                        "SelectionImageObject",
                        "SelectionImageObjectBorder",
                        "TableBorderStrong",
                        "TableBorderLight",
                        "TableRowBg",
                        "TableRowBgAlt",
                        "NavWindowingHighlight",
                        "NavWindowingDimBg",
                        "Separator",
                        "CheckMark"
                    } do
                        local v129 = u1.InputColor4({ v128 }, {
                            color = u1.WeakState(u1._config[v128 .. "Color"]),
                            transparency = u1.WeakState(u1._config[v128 .. "Transparency"])
                        });
                        if v129.numberChanged() then
                            v127.value[v128 .. "Color"] = v129.color:get();
                            v127.value[v128 .. "Transparency"] = v129.transparency:get();
                        end;
                    end;
                end },
            { "Fonts", function() --[[ Line: 1056 ]]
                    -- upvalues: u1 (ref), u19 (ref)
                    local v130 = u1.State({});
                    u1.SameLine();
                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(v130.value);
                        v130:set({});
                    end;
                    u19("Update the global config with these changes.");
                    u1.End();
                    local v131 = {
                        ["Code (default)"] = Font.fromEnum(Enum.Font.Code),
                        ["Ubuntu (template)"] = Font.fromEnum(Enum.Font.Ubuntu),
                        Arial = Font.fromEnum(Enum.Font.Arial),
                        Highway = Font.fromEnum(Enum.Font.Highway),
                        Roboto = Font.fromEnum(Enum.Font.Roboto),
                        ["Roboto Mono"] = Font.fromEnum(Enum.Font.RobotoMono),
                        ["Noto Sans"] = Font.new("rbxassetid://12187370747"),
                        ["Builder Sans"] = Font.fromEnum(Enum.Font.BuilderSans),
                        ["Builder Mono"] = Font.new("rbxassetid://16658246179"),
                        Sono = Font.new("rbxassetid://12187374537")
                    };
                    u1.Text({ (`Current Font: {u1._config.TextFont.Family} Weight: {u1._config.TextFont.Weight} Style: {u1._config.TextFont.Style}`) });
                    u1.SeparatorText({ "Size" });
                    local v132 = u1.SliderNum({
                        "Font Size",
                        1,
                        4,
                        20
                    }, {
                        number = u1.WeakState(u1._config.TextSize)
                    });
                    if v132.numberChanged() then
                        v130.value.TextSize = v132.state.number:get();
                    end;
                    u1.SeparatorText({ "Properties" });
                    local v133 = u1.WeakState(u1._config.TextFont.Family);
                    local v134 = u1.ComboEnum({ "Font Weight" }, {
                        index = u1.WeakState(u1._config.TextFont.Weight)
                    }, Enum.FontWeight);
                    local v135 = u1.ComboEnum({ "Font Style" }, {
                        index = u1.WeakState(u1._config.TextFont.Style)
                    }, Enum.FontStyle);
                    u1.SeparatorText({ "Fonts" });
                    for v136, v137 in v131 do
                        local v138 = Font.new(v137.Family, v134.state.index.value, v135.state.index.value);
                        u1.SameLine();
                        u1.PushConfig({
                            TextFont = v138
                        });
                        if u1.Selectable({ `{v136} | "The quick brown fox jumps over the lazy dog."`, v138.Family }, {
                            index = v133
                        }).selected() then
                            v130.value.TextFont = v138;
                        end;
                        u1.PopConfig();
                        u1.End();
                    end;
                end }
        };
        u1.Window({ "Style Editor" }, {
            isOpened = u5
        });
        u1.Text({ "Customize the look of Iris in realtime." });
        local v140 = u1.State("Dark Theme");
        if u1.ComboArray({ "Theme" }, {
            index = v140
        }, { "Dark Theme", "Light Theme" }).closed() then
            if v140.value == "Dark Theme" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
            elseif v140.value == "Light Theme" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.colorLight);
            end;
        end;
        local v141 = u1.State("Classic Size");
        if u1.ComboArray({ "Size" }, {
            index = v141
        }, { "Classic Size", "Larger Size" }).closed() then
            if v141.value == "Classic Size" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
            elseif v141.value == "Larger Size" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.sizeClear);
            end;
        end;
        u1.SameLine();
        if u1.Button({ "Revert" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
            v140:set("Dark Theme");
            v141:set("Classic Size");
        end;
        u19("Reset Iris to the default theme and size.");
        u1.End();
        u1.TabBar();
        for v142, v143 in ipairs(v139) do
            u1.Tab({ v143[1] });
            v139[v142][2]();
            u1.End();
        end;
        u1.End();
        u1.Separator();
        u1.End();
    end;
    local function u151() --[[ Line: 1170 ]]
        -- upvalues: u1 (copy)
        u1.CollapsingHeader({ "Widget Event Interactivity" });
        local v145 = u1.State(0);
        if u1.Button({ "Click to increase Number" }).clicked() then
            v145:set(v145:get() + 1);
        end;
        u1.Text({ "The Number is: " .. v145:get() });
        u1.Separator();
        local v146 = u1.State(false);
        local v147 = u1.State("clicked");
        u1.SameLine();
        u1.RadioButton({ "clicked", "clicked" }, {
            index = v147
        });
        u1.RadioButton({ "rightClicked", "rightClicked" }, {
            index = v147
        });
        u1.RadioButton({ "doubleClicked", "doubleClicked" }, {
            index = v147
        });
        u1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
            index = v147
        });
        u1.End();
        u1.SameLine();
        if u1.Button({ v147:get() .. " to reveal text" })[v147:get()]() then
            v146:set(not v146:get());
        end;
        if v146:get() then
            u1.Text({ "Here i am!" });
        end;
        u1.End();
        u1.Separator();
        local v148 = u1.State(0);
        u1.SameLine();
        if u1.Button({ "Click to show text for 20 frames" }).clicked() then
            v148:set(20);
        end;
        if v148:get() > 0 then
            u1.Text({ "Here i am!" });
        end;
        u1.End();
        local v149 = v148:get() - 1;
        v148:set((math.max(0, v149)));
        u1.Text({ "Text Timer: " .. v148:get() });
        local v150 = u1.Checkbox({ "Event-tracked checkbox" });
        u1.Indent();
        u1.Text({ "unchecked: " .. tostring(v150.unchecked()) });
        u1.Text({ "checked: " .. tostring(v150.checked()) });
        u1.End();
        u1.SameLine();
        if u1.Button({ "Hover over me" }).hovered() then
            u1.Text({ "The button is hovered" });
        end;
        u1.End();
        u1.End();
    end;
    local function u161() --[[ Line: 1241 ]]
        -- upvalues: u1 (copy)
        u1.CollapsingHeader({ "Widget State Interactivity" });
        local v152 = u1.Checkbox({ "Widget-Generated State" });
        u1.Text({ (`isChecked: {v152.state.isChecked.value}\n`) });
        local v153 = u1.State(false);
        local v154 = u1.Checkbox({ "User-Generated State" }, {
            isChecked = v153
        });
        u1.Text({ (`isChecked: {v154.state.isChecked.value}\n`) });
        local v155 = u1.Checkbox({ "Widget Coupled State" });
        local v156 = u1.Checkbox({ "Coupled to above Checkbox" }, {
            isChecked = v155.state.isChecked
        });
        u1.Text({ (`isChecked: {v156.state.isChecked.value}\n`) });
        local v157 = u1.State(false);
        u1.Checkbox({ "Widget and Code Coupled State" }, {
            isChecked = v157
        });
        if u1.Button({ "Click to toggle above checkbox" }).clicked() then
            v157:set(not v157:get());
        end;
        u1.Text({ (`isChecked: {v157.value}\n`) });
        local v158 = u1.State(true);
        local v160 = u1.ComputedState(v158, function(p159) --[[ Line: 1264 ]]
            return not p159;
        end);
        u1.Checkbox({ "ComputedState (dynamic coupling)" }, {
            isChecked = v158
        });
        u1.Checkbox({ "Inverted of above checkbox" }, {
            isChecked = v160
        });
        u1.Text({ (`isChecked: {v160.value}\n`) });
        u1.End();
    end;
    local function u165() --[[ Line: 1274 ]]
        -- upvalues: u1 (copy), u19 (copy)
        u1.CollapsingHeader({ "Dynamic Styles" });
        local v162 = u1.State(0);
        u1.SameLine();
        if u1.Button({ "Change Color" }).clicked() then
            v162:set(math.random());
        end;
        local l__Text__9 = u1.Text;
        local v163 = {};
        local v164 = v162:get() * 255;
        v163[1] = "Hue: " .. math.floor(v164);
        l__Text__9(v163);
        u19("Using PushConfig with a changing value, this can be done with any config field");
        u1.End();
        u1.PushConfig({
            TextColor = Color3.fromHSV(v162:get(), 1, 1)
        });
        u1.Text({ "Text with a unique and changable color" });
        u1.PopConfig();
        u1.End();
    end;
    local function u204() --[[ Line: 1295 ]]
        -- upvalues: u1 (copy), u19 (copy)
        local v166 = u1.State(false);
        u1.CollapsingHeader({ "Tables & Columns" }, {
            isUncollapsed = v166
        });
        if v166.value == false then
            u1.End();
        else
            u1.Tree({ "Basic" });
            u1.SameLine();
            u1.Text({ "Table using NextColumn syntax:" });
            u19("calling Iris.NextColumn() in the inner loop,\nwhich automatically goes to the next row at the end.");
            u1.End();
            u1.Table({ 3 });
            for v167 = 1, 4 do
                for v168 = 1, 3 do
                    u1.Text({ (`Row: {v167}, Column: {v168}`) });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.Text({ "" });
            u1.SameLine();
            u1.Text({ "Table using NextColumn and NextRow syntax:" });
            u19("Calling Iris.NextColumn() in the inner loop and Iris.NextRow() in the outer loop,\nto acehieve a visually identical result. Technically they are not the same.");
            u1.End();
            u1.Table({ 3 });
            for v169 = 1, 4 do
                for v170 = 1, 3 do
                    u1.Text({ (`Row: {v169}, Column: {v170}`) });
                    u1.NextColumn();
                end;
                u1.NextRow();
            end;
            u1.End();
            u1.End();
            u1.Tree({ "Headers, borders and backgrounds" });
            local v171 = u1.State(0);
            local v172 = u1.State(false);
            local v173 = u1.State(false);
            local v174 = u1.State(true);
            local v175 = u1.State(true);
            u1.Checkbox({ "Table header row" }, {
                isChecked = v172
            });
            u1.Checkbox({ "Table row backgrounds" }, {
                isChecked = v173
            });
            u1.Checkbox({ "Table outer border" }, {
                isChecked = v174
            });
            u1.Checkbox({ "Table inner borders" }, {
                isChecked = v175
            });
            u1.SameLine();
            u1.Text({ "Cell contents" });
            u1.RadioButton({ "Text", 0 }, {
                index = v171
            });
            u1.RadioButton({ "Fill button", 1 }, {
                index = v171
            });
            u1.End();
            u1.Table({
                3,
                v172.value,
                v173.value,
                v174.value,
                v175.value
            });
            u1.SetHeaderColumnIndex(1);
            for v176 = 0, 4 do
                for v177 = 1, 3 do
                    if v171.value == 0 then
                        u1.Text({ (`Cell ({v177}, {v176})`) });
                    else
                        u1.Button({ `Cell ({v177}, {v176})`, UDim2.fromScale(1, 0) });
                    end;
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.End();
            u1.Tree({ "Sizing" });
            local v178 = u1.State(false);
            local v179 = u1.State(false);
            u1.Checkbox({ "Resizable" }, {
                isChecked = v178
            });
            u1.Checkbox({ "Limit Table Width" }, {
                isChecked = v179
            });
            u1.SeparatorText({ "stretch, equal" });
            u1.Table({
                3,
                false,
                true,
                true,
                true,
                v178.value
            });
            for _ = 1, 3 do
                for _ = 1, 3 do
                    u1.Text({ "stretch" });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.Table({
                3,
                false,
                true,
                true,
                true,
                v178.value
            });
            for _ = 1, 3 do
                for v180 = 1, 3 do
                    u1.Text({ string.rep(string.char(v180 + 64), v180 * 4) });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.SeparatorText({ "stretch, proportional" });
            u1.Table({
                3,
                false,
                true,
                true,
                true,
                v178.value,
                false,
                true
            });
            for _ = 1, 3 do
                for _ = 1, 3 do
                    u1.Text({ "stretch" });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.Table({
                3,
                false,
                true,
                true,
                true,
                v178.value,
                false,
                true
            });
            for _ = 1, 3 do
                for v181 = 1, 3 do
                    u1.Text({ string.rep(string.char(v181 + 64), v181 * 4) });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.SeparatorText({ "fixed, equal" });
            u1.Table({
                3,
                false,
                true,
                true,
                true,
                v178.value,
                true,
                false,
                v179.value
            });
            for _ = 1, 3 do
                for _ = 1, 3 do
                    u1.Text({ "fixed" });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.Table({
                3,
                false,
                true,
                true,
                true,
                v178.value,
                true,
                false,
                v179.value
            });
            for _ = 1, 3 do
                for v182 = 1, 3 do
                    u1.Text({ string.rep(string.char(v182 + 64), v182 * 4) });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.SeparatorText({ "fixed, proportional" });
            u1.Table({
                3,
                false,
                true,
                true,
                true,
                v178.value,
                true,
                true,
                v179.value
            });
            for _ = 1, 3 do
                for _ = 1, 3 do
                    u1.Text({ "fixed" });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.Table({
                3,
                false,
                true,
                true,
                true,
                v178.value,
                true,
                true,
                v179.value
            });
            for _ = 1, 3 do
                for v183 = 1, 3 do
                    u1.Text({ string.rep(string.char(v183 + 64), v183 * 4) });
                    u1.NextColumn();
                end;
            end;
            u1.End();
            u1.End();
            u1.Tree({ "Resizable" });
            local v184 = u1.State(4);
            local v185 = u1.State(3);
            local v186 = u1.State(false);
            local v187 = u1.State(true);
            local v188 = u1.State(true);
            local v189 = u1.State(true);
            local v190 = u1.State(true);
            local v191 = u1.State(false);
            local v192 = u1.State(false);
            local v193 = u1.State(false);
            local v194 = u1.State(false);
            local v195 = u1.State(false);
            local u196 = u1.State(table.create(10, 100));
            u1.SliderNum({
                "Num Columns",
                1,
                1,
                10
            }, {
                number = v184
            });
            u1.SliderNum({
                "Number of rows",
                1,
                0,
                100
            }, {
                number = v185
            });
            u1.SameLine();
            u1.RadioButton({ "Buttons", true }, {
                index = v186
            });
            u1.RadioButton({ "Text", false }, {
                index = v186
            });
            u1.End();
            u1.Table({ 3 });
            u1.Checkbox({ "Show Header Row" }, {
                isChecked = v187
            });
            u1.NextColumn();
            u1.Checkbox({ "Show Row Backgrounds" }, {
                isChecked = v188
            });
            u1.NextColumn();
            u1.Checkbox({ "Show Outer Border" }, {
                isChecked = v189
            });
            u1.NextColumn();
            u1.Checkbox({ "Show Inner Border" }, {
                isChecked = v190
            });
            u1.NextColumn();
            u1.Checkbox({ "Resizable" }, {
                isChecked = v191
            });
            u1.NextColumn();
            u1.Checkbox({ "Fixed Width" }, {
                isChecked = v192
            });
            u1.NextColumn();
            u1.Checkbox({ "Proportional Width" }, {
                isChecked = v193
            });
            u1.NextColumn();
            u1.Checkbox({ "Limit Table Width" }, {
                isChecked = v194
            });
            u1.NextColumn();
            u1.Checkbox({ "Add extra" }, {
                isChecked = v195
            });
            u1.NextColumn();
            u1.End();
            for u197 = 1, v184.value do
                local v198 = v192.value == true and 1 or 0.05;
                local v199 = v192.value == true and 2 or 0.05;
                local v200 = v192.value == true and 480 or 1;
                u1.SliderNum({
                    `Column {u197} Width`,
                    v198,
                    v199,
                    v200
                }, {
                    number = u1.TableState(u196.value, u197, function(p201) --[[ Line: 1548 ]]
                        -- upvalues: u196 (copy), u197 (copy)
                        u196.value[u197] = p201;
                        u196:set(u196.value, true);
                        return false;
                    end)
                });
            end;
            u1.PushConfig({
                NumColumns = v184.value
            });
            u1.Table({
                v184.value,
                v187.value,
                v188.value,
                v189.value,
                v190.value,
                v191.value,
                v192.value,
                v193.value,
                v194.value
            }, {
                widths = u196
            });
            u1.SetHeaderColumnIndex(1);
            for v202 = 0, v185:get() do
                for v203 = 1, v184.value do
                    if v202 == 0 then
                        if v186.value then
                            u1.Button({ (`H: {v203}`) });
                        else
                            u1.Text({ (`H: {v203}`) });
                        end;
                    elseif v186.value then
                        u1.Button({ (`R: {v202}, C: {v203}`) });
                        u1.Button({ string.rep("...", v203) });
                    else
                        u1.Text({ (`R: {v202}, C: {v203}`) });
                        u1.Text({ string.rep("...", v203) });
                    end;
                    u1.NextColumn();
                end;
            end;
            if v195.value then
                u1.Text({ "A really long piece of text!" });
            end;
            u1.End();
            u1.PopConfig();
            u1.End();
            u1.End();
        end;
    end;
    local function u215() --[[ Line: 1600 ]]
        -- upvalues: u1 (copy), u19 (copy)
        u1.CollapsingHeader({ "Widget Layout" });
        u1.Tree({ "Widget Alignment" });
        u1.Text({ "Iris.SameLine has optional argument supporting horizontal and vertical alignments." });
        u1.Text({ "This allows widgets to be place anywhere on the line." });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "By default child widgets will be aligned to the left." });
        u19("Iris.SameLine()\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()");
        u1.End();
        u1.SameLine();
        u1.Button({ "Button A" });
        u1.Button({ "Button B" });
        u1.End();
        u1.SameLine();
        u1.Text({ "But can be aligned to the center." });
        u19("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()");
        u1.End();
        u1.SameLine({ nil, nil, Enum.HorizontalAlignment.Center });
        u1.Button({ "Button A" });
        u1.Button({ "Button B" });
        u1.End();
        u1.SameLine();
        u1.Text({ "Or right." });
        u19("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()");
        u1.End();
        u1.SameLine({ nil, nil, Enum.HorizontalAlignment.Right });
        u1.Button({ "Button A" });
        u1.Button({ "Button B" });
        u1.End();
        u1.Separator();
        u1.SameLine();
        u1.Text({ "You can also specify the padding." });
        u19("Iris.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()");
        u1.End();
        u1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center });
        u1.Button({ "Button A" });
        u1.Button({ "Button B" });
        u1.End();
        u1.End();
        u1.Tree({ "Widget Sizing" });
        u1.Text({ "Nearly all widgets are the minimum size of the content." });
        u1.Text({ "For example, text and button widgets will be the size of the text labels." });
        u1.Text({ "Some widgets, such as the Image and Button have Size arguments will will set the size of them." });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "The button takes up the full screen-width." });
        u19("Iris.Button({ \"Button\", UDim2.fromScale(1, 0) })");
        u1.End();
        u1.Button({ "Button", UDim2.fromScale(1, 0) });
        u1.SameLine();
        u1.Text({ "The button takes up half the screen-width." });
        u19("Iris.Button({ \"Button\", UDim2.fromScale(0.5, 0) })");
        u1.End();
        u1.Button({ "Button", UDim2.fromScale(0.5, 0) });
        u1.SameLine();
        u1.Text({ "Combining with SameLine, the buttons can fill the screen width." });
        u19("The button will still be larger that the text size.");
        u1.End();
        local v205 = u1.State(2);
        u1.SliderNum({
            "Number of Buttons",
            1,
            1,
            8
        }, {
            number = v205
        });
        u1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center });
        for v206 = 1, v205.value do
            u1.Button({ `Button {v206}`, UDim2.fromScale(1 / v205.value, 0) });
        end;
        u1.End();
        u1.End();
        u1.Tree({ "Content Width" });
        local v207 = u1.State(50);
        local v208 = u1.State(Enum.Axis.X);
        u1.Text({ "The Content Width is a size property which determines the width of input fields." });
        u1.SameLine();
        u1.Text({ "By default the value is UDim.new(0.65, 0)" });
        u19("This is the default value from Dear ImGui.\nIt is 65% of the window width.");
        u1.End();
        u1.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." });
        u1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "Content Width = 150 pixels" });
        u19("UDim.new(0, 150)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(0, 150)
        });
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            number = v207
        });
        u1.InputEnum({ "axis" }, {
            index = v208
        }, Enum.Axis);
        u1.PopConfig();
        u1.SameLine();
        u1.Text({ "Content Width = 50% window width" });
        u19("UDim.new(0.5, 0)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(0.5, 0)
        });
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            number = v207
        });
        u1.InputEnum({ "axis" }, {
            index = v208
        }, Enum.Axis);
        u1.PopConfig();
        u1.SameLine();
        u1.Text({ "Content Width = -150 pixels from the right side" });
        u19("UDim.new(1, -150)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(1, -150)
        });
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            number = v207
        });
        u1.InputEnum({ "axis" }, {
            index = v208
        }, Enum.Axis);
        u1.PopConfig();
        u1.End();
        u1.Tree({ "Content Height" });
        local v209 = u1.State("a single line");
        local v210 = u1.State(50);
        local v211 = u1.State(Enum.Axis.X);
        local v212 = u1.State(0);
        local v213 = os.clock() * 15 % 100 - 50;
        local v214 = math.abs(v213) - 7.5;
        v212:set(math.clamp(v214, 0, 35) / 35);
        u1.Text({ "The Content Height is a size property that determines the minimum size of certain widgets." });
        u1.Text({ "By default the value is UDim.new(0, 0), so there is no minimum height." });
        u1.Text({ "We use Iris.PushConfig() to change this value." });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "Content Height = 0 pixels" });
        u19("UDim.new(0, 0)");
        u1.End();
        u1.InputText({ "text" }, {
            text = v209
        });
        u1.ProgressBar({ "progress" }, {
            progress = v212
        });
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            number = v210
        });
        u1.ComboEnum({ "axis" }, {
            index = v211
        }, Enum.Axis);
        u1.SameLine();
        u1.Text({ "Content Height = 60 pixels" });
        u19("UDim.new(0, 60)");
        u1.End();
        u1.PushConfig({
            ContentHeight = UDim.new(0, 60)
        });
        u1.InputText({
            "text",
            nil,
            nil,
            true
        }, {
            text = v209
        });
        u1.ProgressBar({ "progress" }, {
            progress = v212
        });
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            number = v210
        });
        u1.ComboEnum({ "axis" }, {
            index = v211
        }, Enum.Axis);
        u1.PopConfig();
        u1.Text({ "This property can be used to force the height of a text box." });
        u1.Text({ "Just make sure you enable the MultiLine argument." });
        u1.End();
        u1.End();
    end;
    local function u216() --[[ Line: 1801 ]]
        -- upvalues: u1 (copy), u19 (copy)
        u1.PushConfig({
            ItemWidth = UDim.new(0, 150)
        });
        u1.SameLine();
        u1.TextWrapped({ "Windowless widgets" });
        u19("Widgets which are placed outside of a window will appear on the top left side of the screen.");
        u1.End();
        u1.Button({});
        u1.Tree({});
        u1.InputText({});
        u1.End();
        u1.PopConfig();
    end;
    return function() --[[ Line: 1821 ]]
        -- upvalues: u1 (copy), u2 (copy), u117 (copy), u151 (copy), u161 (copy), u90 (copy), u165 (copy), u89 (copy), u88 (copy), u204 (copy), u215 (copy), u9 (copy), u10 (copy), u11 (copy), u3 (copy), u93 (copy), u4 (copy), u114 (copy), u8 (copy), u115 (copy), u5 (copy), u144 (ref), u6 (copy), u216 (copy), u7 (copy)
        local v217 = u1.State(false);
        local v218 = u1.State(false);
        local v219 = u1.State(false);
        local v220 = u1.State(true);
        local v221 = u1.State(false);
        local v222 = u1.State(false);
        local v223 = u1.State(false);
        local v224 = u1.State(false);
        local v225 = u1.State(false);
        if u2.value ~= false then
            debug.profilebegin("Iris/Demo/Window");
            local v226 = u1.Window({
                [u1.Args.Window.Title] = "Iris Demo Window",
                [u1.Args.Window.NoTitleBar] = v217.value,
                [u1.Args.Window.NoBackground] = v218.value,
                [u1.Args.Window.NoCollapse] = v219.value,
                [u1.Args.Window.NoClose] = v220.value,
                [u1.Args.Window.NoMove] = v221.value,
                [u1.Args.Window.NoScrollbar] = v222.value,
                [u1.Args.Window.NoResize] = v223.value,
                [u1.Args.Window.NoNav] = v224.value,
                [u1.Args.Window.NoMenu] = v225.value
            }, {
                size = u1.State(Vector2.new(600, 550)),
                position = u1.State(Vector2.new(100, 25)),
                isOpened = u2
            });
            if v226.state.isUncollapsed.value and v226.state.isOpened.value then
                debug.profilebegin("Iris/Demo/MenuBar");
                u117();
                debug.profileend();
                u1.Text({ "Iris says hello. (" .. u1.Internal._version .. ")" });
                debug.profilebegin("Iris/Demo/Options");
                u1.CollapsingHeader({ "Window Options" });
                u1.Table({
                    3,
                    false,
                    false,
                    false
                });
                u1.Checkbox({ "NoTitleBar" }, {
                    isChecked = v217
                });
                u1.NextColumn();
                u1.Checkbox({ "NoBackground" }, {
                    isChecked = v218
                });
                u1.NextColumn();
                u1.Checkbox({ "NoCollapse" }, {
                    isChecked = v219
                });
                u1.NextColumn();
                u1.Checkbox({ "NoClose" }, {
                    isChecked = v220
                });
                u1.NextColumn();
                u1.Checkbox({ "NoMove" }, {
                    isChecked = v221
                });
                u1.NextColumn();
                u1.Checkbox({ "NoScrollbar" }, {
                    isChecked = v222
                });
                u1.NextColumn();
                u1.Checkbox({ "NoResize" }, {
                    isChecked = v223
                });
                u1.NextColumn();
                u1.Checkbox({ "NoNav" }, {
                    isChecked = v224
                });
                u1.NextColumn();
                u1.Checkbox({ "NoMenu" }, {
                    isChecked = v225
                });
                u1.NextColumn();
                u1.End();
                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Events");
                u151();
                debug.profileend();
                debug.profilebegin("Iris/Demo/States");
                u161();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Recursive");
                u1.CollapsingHeader({ "Recursive Tree" });
                if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
                    u90();
                end;
                u1.End();
                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Style");
                u165();
                debug.profileend();
                u1.Separator();
                debug.profilebegin("Iris/Demo/Widgets");
                u1.CollapsingHeader({ "Widgets" });
                for _, v227 in u89 do
                    debug.profilebegin((`Iris/Demo/Widgets/{v227}`));
                    u88[v227]();
                    debug.profileend();
                end;
                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Tables");
                u204();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Layout");
                u215();
                debug.profileend();
                u1.CollapsingHeader({ "Background" });
                u1.Checkbox({ "Show background colour" }, {
                    isChecked = u9
                });
                u1.InputColor4({ "Background colour" }, {
                    color = u10,
                    transparency = u11
                });
                u1.End();
            end;
            u1.End();
            debug.profileend();
            if u3.value then
                u93(u3);
            end;
            if u4.value then
                u114();
            end;
            if u8.value then
                u115();
            end;
            if u5.value then
                u144();
            end;
            if u6.value then
                u216();
            end;
            if u7.value then
                u117();
            end;
            return v226;
        end;
        u1.Checkbox({ "Open main window" }, {
            isChecked = u2
        });
    end;
end;