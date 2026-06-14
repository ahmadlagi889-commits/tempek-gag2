-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local l__GuiService__1 = game:GetService("GuiService");
local l__CommonUtils__2 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__ConnectionUtil__3 = require(l__CommonUtils__2:WaitForChild("ConnectionUtil"));
local l__CharacterUtil__4 = require(l__CommonUtils__2:WaitForChild("CharacterUtil"));
local u1 = require(l__CommonUtils__2:WaitForChild("FlagUtil")).getUserFlag("UserAllowAbilityControls");
local u2;
if u1 then
    u2 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u2 = nil;
end;
local u3 = { "rbxasset://textures/ui/Input/JumpButtonRegular.png", "rbxasset://textures/ui/Input/JumpButtonPressed.png" };
local l__BaseCharacterController__5 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u4 = setmetatable({}, l__BaseCharacterController__5);
u4.__index = u4;
function u4.new() --[[ Line: 61 ]]
    -- upvalues: l__BaseCharacterController__5 (copy), u4 (copy), l__ConnectionUtil__3 (copy)
    local v5 = l__BaseCharacterController__5.new();
    local v6 = setmetatable(v5, u4);
    v6.parentUIFrame = nil;
    v6.jumpButton = nil;
    v6.externallyEnabled = false;
    v6.isJumping = false;
    v6._active = false;
    v6._connectionUtil = l__ConnectionUtil__3.new();
    return v6;
end;
function u4._reset(p7) --[[ Line: 75 ]]
    -- upvalues: u1 (copy), u2 (ref), u3 (copy)
    p7.isJumping = false;
    p7.touchObject = nil;
    if p7.jumpButton then
        if u1 and u2.isEnabled() then
            p7.jumpButton.Image = u3[1];
            return;
        end;
        p7.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;
end;
function u4.EnableButton(u8, p9) --[[ Line: 90 ]]
    -- upvalues: l__GuiService__1 (copy)
    if p9 == u8._active then
    else
        if p9 then
            if not u8.jumpButton then
                u8:Create();
            end;
            u8.jumpButton.Visible = true;
            u8._connectionUtil:trackConnection("JUMP_INPUT_ENDED", u8.jumpButton.InputEnded:Connect(function(p10) --[[ Line: 105 ]]
                -- upvalues: u8 (copy)
                if p10 == u8.touchObject then
                    u8:_reset();
                end;
            end));
            u8._connectionUtil:trackConnection("MENU_OPENED", l__GuiService__1.MenuOpened:Connect(function() --[[ Line: 115 ]]
                -- upvalues: u8 (copy)
                if u8.touchObject then
                    u8:_reset();
                end;
            end));
        else
            if u8.jumpButton then
                u8.jumpButton.Visible = false;
            end;
            u8._connectionUtil:disconnect("JUMP_INPUT_ENDED");
            u8._connectionUtil:disconnect("MENU_OPENED");
        end;
        u8:_reset();
        u8._active = p9;
    end;
end;
function u4.UpdateEnabled(p11) --[[ Line: 132 ]]
    -- upvalues: l__CharacterUtil__4 (copy)
    local v12 = l__CharacterUtil__4.getChild("Humanoid", "Humanoid");
    if v12 and p11.externallyEnabled and (v12.UseJumpPower and v12.JumpPower > 0 or not v12.UseJumpPower and v12.JumpHeight > 0) and v12:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
        p11:EnableButton(true);
    else
        p11:EnableButton(false);
    end;
end;
function u4._setupConfigurations(u13) --[[ Line: 141 ]]
    -- upvalues: l__CharacterUtil__4 (copy)
    local function u14() --[[ Line: 142 ]]
        -- upvalues: u13 (copy)
        u13:UpdateEnabled();
    end;
    local v18 = l__CharacterUtil__4.onChild("Humanoid", "Humanoid", function(p15) --[[ Line: 147 ]]
        -- upvalues: u13 (copy), u14 (copy)
        u13:UpdateEnabled();
        u13:_reset();
        u13._connectionUtil:trackConnection("HUMANOID_JUMP_POWER", p15:GetPropertyChangedSignal("JumpPower"):Connect(u14));
        u13._connectionUtil:trackConnection("HUMANOID_JUMP_HEIGHT", p15:GetPropertyChangedSignal("JumpHeight"):Connect(u14));
        u13._connectionUtil:trackConnection("HUMANOID_STATE_ENABLED_CHANGED", p15.StateEnabledChanged:Connect(function(p16, p17) --[[ Line: 160 ]]
            -- upvalues: u13 (ref)
            if p16 == Enum.HumanoidStateType.Jumping and p17 ~= u13._active then
                u13:UpdateEnabled();
            end;
        end));
    end);
    u13._connectionUtil:trackConnection("HUMANOID", v18);
end;
function u4.Enable(p19, p20, p21) --[[ Line: 172 ]]
    if p21 then
        p19.parentUIFrame = p21;
    end;
    if p19.externallyEnabled == p20 then
    else
        p19.externallyEnabled = p20;
        p19:UpdateEnabled();
        if p20 then
            p19:_setupConfigurations();
        else
            p19._connectionUtil:disconnectAll();
        end;
    end;
end;
function u4.Create(u22) --[[ Line: 189 ]]
    -- upvalues: u1 (copy), u2 (ref), u3 (copy)
    if u22.parentUIFrame then
        if u22.jumpButton then
            u22.jumpButton:Destroy();
            u22.jumpButton = nil;
        end;
        if u22.absoluteSizeChangedConn then
            u22.absoluteSizeChangedConn:Disconnect();
            u22.absoluteSizeChangedConn = nil;
        end;
        if u1 and u22.avatarAbilitiesEnabledChangedConn then
            u22.avatarAbilitiesEnabledChangedConn:Disconnect();
            u22.avatarAbilitiesEnabledChangedConn = nil;
        end;
        u22.jumpButton = Instance.new("ImageButton");
        u22.jumpButton.Name = "JumpButton";
        u22.jumpButton.Visible = false;
        u22.jumpButton.BackgroundTransparency = 1;
        if u1 and u2.isEnabled() then
            u22.jumpButton.Image = u3[1];
        else
            u22.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
            u22.jumpButton.ImageRectOffset = Vector2.new(1, 146);
            u22.jumpButton.ImageRectSize = Vector2.new(144, 144);
        end;
        local function v28() --[[ Line: 224 ]]
            -- upvalues: u22 (copy), u1 (ref), u2 (ref), u3 (ref)
            local v23 = math.min(u22.parentUIFrame.AbsoluteSize.x, u22.parentUIFrame.AbsoluteSize.y) <= 500;
            if u1 and u2.isEnabled() then
                local v24 = v23 and 72 or 120;
                local v25 = -v24 - (v23 and 64 or 100);
                local v26 = -v24 - (v23 and 64 or 112);
                u22.jumpButton.Image = u3[1];
                u22.jumpButton.ImageRectOffset = Vector2.new(0, 0);
                u22.jumpButton.ImageRectSize = Vector2.new(0, 0);
                u22.jumpButton.Size = UDim2.new(0, v24, 0, v24);
                u22.jumpButton.Position = UDim2.new(1, v25, 1, v26);
            else
                local v27 = v23 and 70 or 120;
                if u1 then
                    u22.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
                    u22.jumpButton.ImageRectOffset = Vector2.new(1, 146);
                    u22.jumpButton.ImageRectSize = Vector2.new(144, 144);
                end;
                u22.jumpButton.Size = UDim2.new(0, v27, 0, v27);
                u22.jumpButton.Position = v23 and UDim2.new(1, -(v27 * 1.5 - 10), 1, -v27 - 20) or UDim2.new(1, -(v27 * 1.5 - 10), 1, -v27 * 1.75);
            end;
        end;
        v28();
        u22.absoluteSizeChangedConn = u22.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(v28);
        if u1 then
            u22.avatarAbilitiesEnabledChangedConn = u2.GetEnabledChangedSignal():Connect(v28);
        end;
        u22.touchObject = nil;
        u22.jumpButton.InputBegan:connect(function(p29) --[[ Line: 262 ]]
            -- upvalues: u22 (copy), u1 (ref), u2 (ref), u3 (ref)
            if u22.touchObject or (p29.UserInputType ~= Enum.UserInputType.Touch or p29.UserInputState ~= Enum.UserInputState.Begin) then
            else
                u22.touchObject = p29;
                if u1 and u2.isEnabled() then
                    u22.jumpButton.Image = u3[2];
                else
                    u22.jumpButton.ImageRectOffset = Vector2.new(146, 146);
                end;
                u22.isJumping = true;
            end;
        end);
        u22.jumpButton.Parent = u22.parentUIFrame;
    end;
end;
return u4;