-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
local u2 = l__LocalPlayer__4:GetMouse();
local u3 = {};
local u4 = false;
local u5 = false;
local u6 = nil;
local u7 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local u8 = {};
local function u15(p9, p10) --[[ Line: 27 ]]
    -- upvalues: u8 (copy), l__TweenService__3 (copy), u7 (copy)
    for _, v11 in u8 do
        v11:Cancel();
    end;
    table.clear(u8);
    local v12 = l__TweenService__3:Create(p9, u7, {
        TextTransparency = p10
    });
    v12:Play();
    table.insert(u8, v12);
    local v13 = p9:FindFirstChildOfClass("UIStroke");
    if v13 then
        local v14 = l__TweenService__3:Create(v13, u7, {
            Transparency = p10
        });
        v14:Play();
        table.insert(u8, v14);
    end;
end;
local function u18(u16, p17) --[[ Line: 42 ]]
    -- upvalues: u3 (copy), u4 (ref), u6 (ref)
    if u3[u16] then
    else
        u3[u16] = p17;
        u16:GetAttributeChangedSignal("HoverDescription"):Connect(function() --[[ Line: 47 ]]
            -- upvalues: u3 (ref), u16 (copy), u4 (ref), u6 (ref)
            u3[u16] = u16:GetAttribute("HoverDescription");
            if u4 and u6 == u16 then
                u6 = u16;
            end;
        end);
        u16.MouseEnter:Connect(function() --[[ Line: 54 ]]
            -- upvalues: u6 (ref), u16 (copy), u4 (ref)
            u6 = u16;
            u4 = true;
        end);
        u16.MouseLeave:Connect(function() --[[ Line: 59 ]]
            -- upvalues: u6 (ref), u16 (copy), u4 (ref)
            if u6 == u16 then
                u4 = false;
            end;
        end);
        u16.Destroying:Connect(function() --[[ Line: 65 ]]
            -- upvalues: u3 (ref), u16 (copy), u6 (ref), u4 (ref)
            u3[u16] = nil;
            if u6 == u16 then
                u4 = false;
                u6 = nil;
            end;
        end);
    end;
end;
function v1.Start(_) --[[ Line: 74 ]]
    -- upvalues: l__LocalPlayer__4 (copy), u18 (copy), l__RunService__2 (copy), u4 (ref), u6 (ref), u3 (copy), u2 (copy), u5 (ref), u15 (copy)
    local l__HoverUI__5 = l__LocalPlayer__4:WaitForChild("PlayerGui"):WaitForChild("HoverUI");
    for _, v19 in l__LocalPlayer__4.PlayerGui:GetDescendants() do
        if v19:GetAttribute("HoverDescription") then
            u18(v19, v19:GetAttribute("HoverDescription"));
        end;
    end;
    l__LocalPlayer__4.PlayerGui.DescendantAdded:Connect(function(p20) --[[ Line: 83 ]]
        -- upvalues: u18 (ref)
        if p20:GetAttribute("HoverDescription") then
            u18(p20, p20:GetAttribute("HoverDescription"));
        end;
    end);
    local u21 = script.Time:Clone();
    local l__TXT__6 = u21.TXT;
    u21.Parent = l__HoverUI__5;
    l__RunService__2.Heartbeat:Connect(function() --[[ Line: 93 ]]
        -- upvalues: u4 (ref), u6 (ref), u3 (ref), l__TXT__6 (copy), u21 (copy), u2 (ref), u5 (ref), u15 (ref)
        if u4 and u6 then
            local v22 = u3[u6] or "";
            l__TXT__6.Text = v22;
            u21.Text = v22;
            u21.Position = UDim2.new(0, u2.X - u21.AbsoluteSize.X / 2, 0, u2.Y);
            if not u5 then
                u15(l__TXT__6, 0);
                u5 = true;
            end;
        elseif u5 then
            u15(l__TXT__6, 1);
            u5 = false;
        end;
    end);
end;
return v1;