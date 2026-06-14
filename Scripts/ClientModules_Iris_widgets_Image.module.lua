-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local v4 = {
        hasState = false,
        hasChildren = false,
        Args = {
            Image = 1,
            Size = 2,
            Rect = 3,
            ScaleType = 4,
            ResampleMode = 5,
            TileSize = 6,
            SliceCenter = 7,
            SliceScale = 8
        },
        Discard = function(p3) --[[ Name: Discard, Line 17 ]]
            p3.Instance:Destroy();
        end
    };
    u1.WidgetConstructor("Image", u2.extend(v4, {
        Events = {
            hovered = u2.EVENTS.hover(function(p5) --[[ Line: 25 ]]
                return p5.Instance;
            end)
        },
        Generate = function(_) --[[ Name: Generate, Line 29 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v6 = Instance.new("ImageLabel");
            v6.Name = "Iris_Image";
            v6.BackgroundTransparency = 1;
            v6.BorderSizePixel = 0;
            v6.ImageColor3 = u1._config.ImageColor;
            v6.ImageTransparency = u1._config.ImageTransparency;
            u2.applyFrameStyle(v6, true);
            return v6;
        end,
        Update = function(p7) --[[ Name: Update, Line 41 ]]
            -- upvalues: u2 (copy)
            local l__Instance__1 = p7.Instance;
            l__Instance__1.Image = p7.arguments.Image or u2.ICONS.UNKNOWN_TEXTURE;
            l__Instance__1.Size = p7.arguments.Size;
            if p7.arguments.ScaleType then
                l__Instance__1.ScaleType = p7.arguments.ScaleType;
                if p7.arguments.ScaleType == Enum.ScaleType.Tile and p7.arguments.TileSize then
                    l__Instance__1.TileSize = p7.arguments.TileSize;
                elseif p7.arguments.ScaleType == Enum.ScaleType.Slice then
                    if p7.arguments.SliceCenter then
                        l__Instance__1.SliceCenter = p7.arguments.SliceCenter;
                    end;
                    if p7.arguments.SliceScale then
                        l__Instance__1.SliceScale = p7.arguments.SliceScale;
                    end;
                end;
            end;
            if p7.arguments.Rect then
                l__Instance__1.ImageRectOffset = p7.arguments.Rect.Min;
                l__Instance__1.ImageRectSize = Vector2.new(p7.arguments.Rect.Width, p7.arguments.Rect.Height);
            end;
            if p7.arguments.ResampleMode then
                l__Instance__1.ResampleMode = p7.arguments.ResampleMode;
            end;
        end
    }));
    u1.WidgetConstructor("ImageButton", u2.extend(v4, {
        Events = {
            clicked = u2.EVENTS.click(function(p8) --[[ Line: 75 ]]
                return p8.Instance;
            end),
            rightClicked = u2.EVENTS.rightClick(function(p9) --[[ Line: 78 ]]
                return p9.Instance;
            end),
            doubleClicked = u2.EVENTS.doubleClick(function(p10) --[[ Line: 81 ]]
                return p10.Instance;
            end),
            ctrlClicked = u2.EVENTS.ctrlClick(function(p11) --[[ Line: 84 ]]
                return p11.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p12) --[[ Line: 87 ]]
                return p12.Instance;
            end)
        },
        Generate = function(_) --[[ Name: Generate, Line 91 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v13 = Instance.new("ImageButton");
            v13.Name = "Iris_ImageButton";
            v13.AutomaticSize = Enum.AutomaticSize.XY;
            v13.BackgroundColor3 = u1._config.FrameBgColor;
            v13.BackgroundTransparency = u1._config.FrameBgTransparency;
            v13.BorderSizePixel = 0;
            v13.Image = "";
            v13.ImageTransparency = 1;
            v13.AutoButtonColor = false;
            u2.applyFrameStyle(v13, true);
            u2.UIPadding(v13, Vector2.new(u1._config.ImageBorderSize, u1._config.ImageBorderSize));
            local v14 = Instance.new("ImageLabel");
            v14.Name = "ImageLabel";
            v14.BackgroundTransparency = 1;
            v14.BorderSizePixel = 0;
            v14.ImageColor3 = u1._config.ImageColor;
            v14.ImageTransparency = u1._config.ImageTransparency;
            v14.Parent = v13;
            u2.applyInteractionHighlights("Background", v13, v13, {
                Color = u1._config.FrameBgColor,
                Transparency = u1._config.FrameBgTransparency,
                HoveredColor = u1._config.FrameBgHoveredColor,
                HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                ActiveColor = u1._config.FrameBgActiveColor,
                ActiveTransparency = u1._config.FrameBgActiveTransparency
            });
            return v13;
        end,
        Update = function(p15) --[[ Name: Update, Line 124 ]]
            -- upvalues: u2 (copy)
            local l__ImageLabel__2 = p15.Instance.ImageLabel;
            l__ImageLabel__2.Image = p15.arguments.Image or u2.ICONS.UNKNOWN_TEXTURE;
            l__ImageLabel__2.Size = p15.arguments.Size;
            if p15.arguments.ScaleType then
                l__ImageLabel__2.ScaleType = p15.arguments.ScaleType;
                if p15.arguments.ScaleType == Enum.ScaleType.Tile and p15.arguments.TileSize then
                    l__ImageLabel__2.TileSize = p15.arguments.TileSize;
                elseif p15.arguments.ScaleType == Enum.ScaleType.Slice then
                    if p15.arguments.SliceCenter then
                        l__ImageLabel__2.SliceCenter = p15.arguments.SliceCenter;
                    end;
                    if p15.arguments.SliceScale then
                        l__ImageLabel__2.SliceScale = p15.arguments.SliceScale;
                    end;
                end;
            end;
            if p15.arguments.Rect then
                l__ImageLabel__2.ImageRectOffset = p15.arguments.Rect.Min;
                l__ImageLabel__2.ImageRectSize = Vector2.new(p15.arguments.Rect.Width, p15.arguments.Rect.Height);
            end;
            if p15.arguments.ResampleMode then
                l__ImageLabel__2.ResampleMode = p15.arguments.ResampleMode;
            end;
        end
    }));
end;