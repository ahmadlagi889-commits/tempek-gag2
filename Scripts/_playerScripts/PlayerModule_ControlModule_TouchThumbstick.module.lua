-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local l__GuiService__1 = game:GetService("GuiService");
local l__UserInputService__2 = game:GetService("UserInputService");
UserSettings():GetService("UserGameSettings");
local l__CommonUtils__3 = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(l__CommonUtils__3:WaitForChild("FlagUtil")).getUserFlag("UserAllowAbilityControls");
local u2;
if u1 then
    u2 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u2 = nil;
end;
local l__BaseCharacterController__4 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u3 = setmetatable({}, l__BaseCharacterController__4);
u3.__index = u3;
function u3.new() --[[ Line: 29 ]]
    -- upvalues: l__BaseCharacterController__4 (copy), u3 (copy)
    local v4 = l__BaseCharacterController__4.new();
    local v5 = setmetatable(v4, u3);
    v5.isFollowStick = false;
    v5.thumbstickFrame = nil;
    v5.moveTouchObject = nil;
    v5.onTouchMovedConn = nil;
    v5.onTouchEndedConn = nil;
    v5.screenPos = nil;
    v5.stickImage = nil;
    v5.thumbstickSize = nil;
    return v5;
end;
function u3.Enable(p6, p7, p8) --[[ Line: 44 ]]
    if p7 == nil then
        return false;
    end;
    local v9 = p7 and true or false;
    if p6.enabled == v9 then
        return true;
    end;
    p6.moveVector = Vector3.new(0, 0, 0);
    p6.isJumping = false;
    if v9 then
        if not p6.thumbstickFrame then
            p6:Create(p8);
        end;
        p6.thumbstickFrame.Visible = true;
    else
        p6.thumbstickFrame.Visible = false;
        p6:OnInputEnded();
    end;
    p6.enabled = v9;
end;
function u3.OnInputEnded(p10) --[[ Line: 65 ]]
    p10.thumbstickFrame.Position = p10.screenPos;
    p10.stickImage.Position = UDim2.new(0, p10.thumbstickFrame.Size.X.Offset / 2 - p10.thumbstickSize / 4, 0, p10.thumbstickFrame.Size.Y.Offset / 2 - p10.thumbstickSize / 4);
    p10.moveVector = Vector3.new(0, 0, 0);
    p10.isJumping = false;
    p10.thumbstickFrame.Position = p10.screenPos;
    p10.moveTouchObject = nil;
end;
function u3.Create(u11, u12) --[[ Line: 74 ]]
    -- upvalues: u1 (copy), u2 (ref), l__UserInputService__2 (copy), l__GuiService__1 (copy)
    if u11.thumbstickFrame then
        u11.thumbstickFrame:Destroy();
        u11.thumbstickFrame = nil;
        if u11.onTouchMovedConn then
            u11.onTouchMovedConn:Disconnect();
            u11.onTouchMovedConn = nil;
        end;
        if u11.onTouchEndedConn then
            u11.onTouchEndedConn:Disconnect();
            u11.onTouchEndedConn = nil;
        end;
        if u11.absoluteSizeChangedConn then
            u11.absoluteSizeChangedConn:Disconnect();
            u11.absoluteSizeChangedConn = nil;
        end;
        if u1 and u11.avatarAbilitiesEnabledChangedConn then
            u11.avatarAbilitiesEnabledChangedConn:Disconnect();
            u11.avatarAbilitiesEnabledChangedConn = nil;
        end;
    end;
    u11.thumbstickFrame = Instance.new("Frame");
    u11.thumbstickFrame.Name = "ThumbstickFrame";
    u11.thumbstickFrame.Active = true;
    u11.thumbstickFrame.Visible = false;
    u11.thumbstickFrame.BackgroundTransparency = 1;
    local u13 = Instance.new("ImageLabel");
    u13.Name = "OuterImage";
    u13.Image = "rbxasset://textures/ui/TouchControlsSheet.png";
    u13.ImageRectOffset = Vector2.new();
    u13.ImageRectSize = Vector2.new(220, 220);
    u13.BackgroundTransparency = 1;
    u13.Position = UDim2.new(0, 0, 0, 0);
    u11.stickImage = Instance.new("ImageLabel");
    u11.stickImage.Name = "StickImage";
    u11.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png";
    u11.stickImage.ImageRectOffset = Vector2.new(220, 0);
    u11.stickImage.ImageRectSize = Vector2.new(111, 111);
    u11.stickImage.BackgroundTransparency = 1;
    u11.stickImage.ZIndex = 2;
    local function v15() --[[ Line: 120 ]]
        -- upvalues: u12 (copy), u1 (ref), u2 (ref), u11 (copy), u13 (copy)
        local v14 = math.min(u12.AbsoluteSize.X, u12.AbsoluteSize.Y) <= 500;
        if u1 and u2.isEnabled() then
            u11.thumbstickSize = v14 and 72 or 120;
            u11.screenPos = UDim2.new(0, v14 and 64 or 100, 1, -u11.thumbstickSize - (v14 and 64 or 112));
        else
            u11.thumbstickSize = v14 and 70 or 120;
            u11.screenPos = v14 and UDim2.new(0, u11.thumbstickSize / 2 - 10, 1, -u11.thumbstickSize - 20) or UDim2.new(0, u11.thumbstickSize / 2, 1, -u11.thumbstickSize * 1.75);
        end;
        u11.thumbstickFrame.Size = UDim2.new(0, u11.thumbstickSize, 0, u11.thumbstickSize);
        u11.thumbstickFrame.Position = u11.screenPos;
        u13.Size = UDim2.new(0, u11.thumbstickSize, 0, u11.thumbstickSize);
        u11.stickImage.Size = UDim2.new(0, u11.thumbstickSize / 2, 0, u11.thumbstickSize / 2);
        u11.stickImage.Position = UDim2.new(0, u11.thumbstickSize / 2 - u11.thumbstickSize / 4, 0, u11.thumbstickSize / 2 - u11.thumbstickSize / 4);
    end;
    v15();
    u11.absoluteSizeChangedConn = u12:GetPropertyChangedSignal("AbsoluteSize"):Connect(v15);
    if u1 then
        u11.avatarAbilitiesEnabledChangedConn = u2.GetEnabledChangedSignal():Connect(v15);
    end;
    u13.Parent = u11.thumbstickFrame;
    u11.stickImage.Parent = u11.thumbstickFrame;
    local u16 = nil;
    local function u22(p17) --[[ Line: 172 ]]
        -- upvalues: u16 (ref), u11 (copy)
        local v18 = Vector2.new(p17.X - u16.X, p17.Y - u16.Y);
        local l__magnitude__5 = v18.magnitude;
        local v19 = u11.thumbstickFrame.AbsoluteSize.X / 2;
        if u11.isFollowStick and v19 < l__magnitude__5 then
            local v20 = v18.unit * v19;
            u11.thumbstickFrame.Position = UDim2.new(0, p17.X - u11.thumbstickFrame.AbsoluteSize.X / 2 - v20.X, 0, p17.Y - u11.thumbstickFrame.AbsoluteSize.Y / 2 - v20.Y);
        else
            local v21 = math.min(l__magnitude__5, v19);
            v18 = v18.unit * v21;
        end;
        u11.stickImage.Position = UDim2.new(0, v18.X + u11.stickImage.AbsoluteSize.X / 2, 0, v18.Y + u11.stickImage.AbsoluteSize.Y / 2);
    end;
    u11.thumbstickFrame.InputBegan:Connect(function(p23) --[[ Line: 189 ]]
        -- upvalues: u11 (copy), u16 (ref)
        if u11.moveTouchObject or (p23.UserInputType ~= Enum.UserInputType.Touch or p23.UserInputState ~= Enum.UserInputState.Begin) then
        else
            u11.moveTouchObject = p23;
            u11.thumbstickFrame.Position = UDim2.new(0, p23.Position.X - u11.thumbstickFrame.Size.X.Offset / 2, 0, p23.Position.Y - u11.thumbstickFrame.Size.Y.Offset / 2);
            u16 = Vector2.new(u11.thumbstickFrame.AbsolutePosition.X + u11.thumbstickFrame.AbsoluteSize.X / 2, u11.thumbstickFrame.AbsolutePosition.Y + u11.thumbstickFrame.AbsoluteSize.Y / 2);
            Vector2.new(p23.Position.X - u16.X, p23.Position.Y - u16.Y);
        end;
    end);
    u11.onTouchMovedConn = l__UserInputService__2.TouchMoved:Connect(function(p24, _) --[[ Line: 204 ]]
        -- upvalues: u11 (copy), u16 (ref), u22 (copy)
        if p24 == u11.moveTouchObject then
            u16 = Vector2.new(u11.thumbstickFrame.AbsolutePosition.X + u11.thumbstickFrame.AbsoluteSize.X / 2, u11.thumbstickFrame.AbsolutePosition.Y + u11.thumbstickFrame.AbsoluteSize.Y / 2);
            local v25 = Vector2.new(p24.Position.X - u16.X, p24.Position.Y - u16.Y) / (u11.thumbstickSize / 2);
            local l__magnitude__6 = v25.magnitude;
            local v26;
            if l__magnitude__6 < 0.05 then
                v26 = Vector3.new();
            else
                local v27 = v25.unit * math.min(1, (l__magnitude__6 - 0.05) / 0.95);
                v26 = Vector3.new(v27.X, 0, v27.Y);
            end;
            u11.moveVector = v26;
            u22(p24.Position);
        end;
    end);
    u11.onTouchEndedConn = l__UserInputService__2.TouchEnded:Connect(function(p28, _) --[[ Line: 214 ]]
        -- upvalues: u11 (copy)
        if p28 == u11.moveTouchObject then
            u11:OnInputEnded();
        end;
    end);
    l__GuiService__1.MenuOpened:Connect(function() --[[ Line: 220 ]]
        -- upvalues: u11 (copy)
        if u11.moveTouchObject then
            u11:OnInputEnded();
        end;
    end);
    u11.thumbstickFrame.Parent = u12;
end;
return u3;