-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local u2 = l__LocalPlayer__3:GetMouse();
local l__TextTooltip__4 = l__LocalPlayer__3:WaitForChild("PlayerGui"):WaitForChild("Tooltip"):WaitForChild("TextTooltip");
local u3 = nil;
local u4 = false;
local u5 = nil;
local l__HoverSFX__5 = game.SoundService.SFX.HoverSFX;
local u6 = nil;
local function u10(p7) --[[ Line: 18 ]]
    if p7:IsA("TextLabel") or p7:IsA("TextButton") then
        return p7;
    end;
    for _, v8 in {
        "Text",
        "TextLabel",
        "Label",
        "Title",
        "Desc",
        "Description"
    } do
        local v9 = p7:FindFirstChild(v8);
        if v9 and (v9:IsA("TextLabel") or v9:IsA("TextButton")) then
            return v9;
        end;
    end;
    return p7:FindFirstChildWhichIsA("TextLabel", true) or p7:FindFirstChildWhichIsA("TextButton", true);
end;
local function u12(p11) --[[ Line: 31 ]]
    while p11 do
        if p11:IsA("GuiObject") and not p11.Visible then
            return false;
        end;
        if p11:IsA("ScreenGui") and not p11.Enabled then
            return false;
        end;
        p11 = p11.Parent;
    end;
    return true;
end;
function v1.TrackUI(_, u13) --[[ Line: 57 ]]
    -- upvalues: u3 (ref), u4 (ref), u5 (ref)
    u13.MouseEnter:Connect(function() --[[ Line: 58 ]]
        -- upvalues: u3 (ref), u13 (copy), u4 (ref)
        u3 = u13;
        u4 = true;
    end);
    u13.MouseLeave:Connect(function() --[[ Line: 62 ]]
        -- upvalues: u3 (ref), u13 (copy), u4 (ref), u5 (ref)
        if u3 == u13 then
            u4 = false;
            u3 = nil;
            u5 = nil;
        end;
    end);
    u13:GetAttributeChangedSignal("TextToolTip"):Connect(function() --[[ Line: 70 ]]
        -- upvalues: u13 (copy), u3 (ref), u4 (ref)
        if not u13:GetAttribute("TextToolTip") and u3 == u13 then
            u4 = false;
            u3 = nil;
        end;
    end);
    u13.Destroying:Connect(function() --[[ Line: 79 ]]
        -- upvalues: u3 (ref), u13 (copy), u4 (ref)
        if u3 == u13 then
            u4 = false;
            u3 = nil;
        end;
    end);
end;
function v1.Start(u14) --[[ Line: 87 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u6 (ref), u10 (copy), l__TextTooltip__4 (copy), l__RunService__2 (copy), u4 (ref), u3 (ref), u12 (copy), u5 (ref), l__HoverSFX__5 (copy), u2 (copy)
    local l__PlayerGui__6 = l__LocalPlayer__3.PlayerGui;
    u6 = u10(l__TextTooltip__4);
    for _, v15 in l__PlayerGui__6:GetDescendants() do
        local v16 = v15:IsA("GuiObject");
        if v16 then
            v16 = v15:GetAttribute("TextToolTip") ~= nil;
        end;
        if v16 then
            u14:TrackUI(v15);
        end;
    end;
    l__PlayerGui__6.DescendantAdded:Connect(function(p17) --[[ Line: 101 ]]
        -- upvalues: u14 (copy)
        local v18 = p17:IsA("GuiObject");
        if v18 then
            v18 = p17:GetAttribute("TextToolTip") ~= nil;
        end;
        if v18 then
            u14:TrackUI(p17);
        end;
    end);
    l__TextTooltip__4.Visible = false;
    l__RunService__2.Heartbeat:Connect(function() --[[ Line: 108 ]]
        -- upvalues: u4 (ref), u3 (ref), u12 (ref), l__TextTooltip__4 (ref), u5 (ref), l__HoverSFX__5 (ref), u6 (ref), u2 (ref)
        if u4 and u3 then
            if u12(u3) then
                local v19 = u3:GetAttribute("TextToolTip");
                if type(v19) == "string" then
                    if u5 ~= v19 then
                        l__HoverSFX__5.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__HoverSFX__5.TimePosition = 0;
                        l__HoverSFX__5.Playing = true;
                        u5 = v19;
                        if u6 then
                            u6.Text = v19;
                        end;
                    end;
                    l__TextTooltip__4.AnchorPoint = Vector2.new(0, 0);
                    l__TextTooltip__4.Position = UDim2.new(0, u2.X, 0, u2.Y - l__TextTooltip__4.AbsoluteSize.Y - 8);
                    l__TextTooltip__4.Visible = true;
                else
                    l__TextTooltip__4.Visible = false;
                end;
            else
                l__TextTooltip__4.Visible = false;
                u4 = false;
                u3 = nil;
                u5 = nil;
            end;
        else
            l__TextTooltip__4.Visible = false;
        end;
    end);
end;
function v1.Init(_) --[[ Line: 135 ]] end;
return v1;