-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__PlayerGui__2 = l__LocalPlayer__1:WaitForChild("PlayerGui");
local l__GuiController__3 = require(l__LocalPlayer__1.PlayerScripts.Controllers.GuiController);
local u1 = Color3.fromRGB(255, 224, 0);
local v2 = {
    StartOrder = 6
};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = false;
local function u15(p9) --[[ Line: 44 ]]
    -- upvalues: u4 (ref), u5 (ref), u6 (ref)
    local v10 = p9:FindFirstChild("Backdrop");
    if v10 then
        v10 = v10:FindFirstChild("ColorPicker");
    end;
    if v10 then
        local v11 = v10:FindFirstChild("CurrentColorValue");
        if v11 and v11:IsA("Color3Value") then
            u4 = v11;
        end;
        local v12 = v10:FindFirstChild("Buttons");
        if v12 then
            local v13 = v12:FindFirstChild("ConfirmButton");
            local v14 = v12:FindFirstChild("CancelButton");
            if v13 and v13:IsA("GuiButton") then
                u5 = v13;
            end;
            if v14 and v14:IsA("GuiButton") then
                u6 = v14;
            end;
        end;
    end;
end;
local function u19() --[[ Line: 67 ]]
    -- upvalues: u5 (ref), u8 (ref), u4 (ref), u7 (ref), u3 (ref), l__GuiController__3 (copy), u6 (ref)
    if u5 then
        u5.MouseButton1Click:Connect(function() --[[ Line: 69 ]]
            -- upvalues: u8 (ref), u4 (ref), u7 (ref), u3 (ref), l__GuiController__3 (ref)
            if u8 then
                local v16;
                if u4 then
                    v16 = u4.Value;
                else
                    v16 = nil;
                end;
                local v17 = u7;
                u7 = nil;
                u8 = false;
                if u3 and l__GuiController__3:IsOpen("ColorPickerGuild") then
                    l__GuiController__3:Close();
                end;
                if v17 then
                    local _, _ = pcall(v17, v16);
                end;
            end;
        end);
    end;
    if u6 then
        u6.MouseButton1Click:Connect(function() --[[ Line: 76 ]]
            -- upvalues: u8 (ref), u7 (ref), u3 (ref), l__GuiController__3 (ref)
            if u8 then
                local v18 = u7;
                u7 = nil;
                u8 = false;
                if u3 and l__GuiController__3:IsOpen("ColorPickerGuild") then
                    l__GuiController__3:Close();
                end;
                if v18 then
                    local _, _ = pcall(v18, nil);
                end;
            end;
        end);
    end;
end;
function v2.Init(_) --[[ Line: 84 ]] end;
function v2.Start(_) --[[ Line: 86 ]]
    -- upvalues: l__PlayerGui__2 (copy), u3 (ref), u15 (copy), u19 (copy), l__GuiController__3 (copy), u8 (ref), u7 (ref)
    task.spawn(function() --[[ Line: 87 ]]
        -- upvalues: l__PlayerGui__2 (ref), u3 (ref), u15 (ref), u19 (ref), l__GuiController__3 (ref), u8 (ref), u7 (ref)
        local l__ColorPickerGuild__4 = l__PlayerGui__2:WaitForChild("ColorPickerGuild", 30);
        if l__ColorPickerGuild__4 and l__ColorPickerGuild__4:IsA("ScreenGui") then
            u3 = l__ColorPickerGuild__4;
            l__ColorPickerGuild__4.Enabled = false;
            u15(l__ColorPickerGuild__4);
            u19();
            l__GuiController__3.GuiUnfocusedSignal:Connect(function(p20) --[[ Line: 97 ]]
                -- upvalues: l__ColorPickerGuild__4 (copy), u8 (ref), u7 (ref), u3 (ref), l__GuiController__3 (ref)
                if p20 == l__ColorPickerGuild__4 and u8 then
                    local v21 = u7;
                    u7 = nil;
                    u8 = false;
                    if u3 and l__GuiController__3:IsOpen("ColorPickerGuild") then
                        l__GuiController__3:Close();
                    end;
                    if v21 then
                        local _, _ = pcall(v21, nil);
                    end;
                end;
            end);
        end;
    end);
end;
function v2.RequestColor(_, p22, p23) --[[ Line: 126 ]]
    -- upvalues: u8 (ref), u7 (ref), u3 (ref), l__GuiController__3 (copy), u4 (ref), u1 (copy)
    if u8 then
        local v24 = u7;
        u7 = nil;
        u8 = false;
        if u3 and l__GuiController__3:IsOpen("ColorPickerGuild") then
            l__GuiController__3:Close();
        end;
        if v24 then
            local _, _ = pcall(v24, nil);
        end;
    end;
    if u3 then
        if u4 and u4.Value == Color3.new(0, 0, 0) then
            u4.Value = p22 or u1;
        end;
        u7 = p23;
        u8 = true;
        l__GuiController__3:Open("ColorPickerGuild", nil, { "HUD" });
    else
        p23(nil);
    end;
end;
function v2.GetCurrentColor(_) --[[ Line: 154 ]]
    -- upvalues: u4 (ref)
    if u4 then
        return u4.Value;
    else
        return nil;
    end;
end;
return v2;