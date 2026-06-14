-- Decompiled with Potassium's decompiler.

local l__Value__1 = Enum.ContextActionPriority.High.Value;
local u1 = {
    0.10999999999999999,
    0.30000000000000004,
    0.4,
    0.5,
    0.6,
    0.7,
    0.75
};
local u2 = #u1;
local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local l__Players__2 = game:GetService("Players");
local l__GuiService__3 = game:GetService("GuiService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__ContextActionService__5 = game:GetService("ContextActionService");
local l__RunService__6 = game:GetService("RunService");
local l__TweenService__7 = game:GetService("TweenService");
local l__CommonUtils__8 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__FlagUtil__9 = require(l__CommonUtils__8:WaitForChild("FlagUtil"));
local u4 = l__FlagUtil__9.getUserFlag("UserAllowAbilityControls");
local u5 = l__FlagUtil__9.getUserFlag("UserAllowAbilityControlsBonus");
local v6, v7 = pcall(function() --[[ Line: 42 ]]
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate");
end);
local u8 = v6 and v7;
local u9;
if u4 then
    u9 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u9 = nil;
end;
local l__LocalPlayer__10 = l__Players__2.LocalPlayer;
if not l__LocalPlayer__10 then
    l__Players__2:GetPropertyChangedSignal("LocalPlayer"):Wait();
    l__LocalPlayer__10 = l__Players__2.LocalPlayer;
end;
local l__BaseCharacterController__11 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u10 = setmetatable({}, l__BaseCharacterController__11);
u10.__index = u10;
function u10.new() --[[ Line: 64 ]]
    -- upvalues: l__BaseCharacterController__11 (copy), u10 (copy)
    local v11 = l__BaseCharacterController__11.new();
    local v12 = setmetatable(v11, u10);
    v12.moveTouchObject = nil;
    v12.moveTouchLockedIn = false;
    v12.moveTouchFirstChanged = false;
    v12.moveTouchStartPosition = nil;
    v12.startImage = nil;
    v12.endImage = nil;
    v12.middleImages = {};
    v12.startImageFadeTween = nil;
    v12.endImageFadeTween = nil;
    v12.middleImageFadeTweens = {};
    v12.isFirstTouch = true;
    v12.thumbstickFrame = nil;
    v12.onRenderSteppedConn = nil;
    v12.fadeInAndOutBalance = 0.5;
    v12.fadeInAndOutHalfDuration = 0.3;
    v12.hasFadedBackgroundInPortrait = false;
    v12.hasFadedBackgroundInLandscape = false;
    v12.tweenInAlphaStart = nil;
    v12.tweenOutAlphaStart = nil;
    return v12;
end;
function u10.GetIsJumping(p13) --[[ Line: 99 ]]
    local l__isJumping__12 = p13.isJumping;
    p13.isJumping = false;
    return l__isJumping__12;
end;
function u10.Enable(p14, p15, p16) --[[ Line: 105 ]]
    if p15 == nil then
        return false;
    end;
    local v17 = p15 and true or false;
    if p14.enabled == v17 then
        return true;
    end;
    if v17 then
        if not p14.thumbstickFrame then
            p14:Create(p16);
        end;
        p14:BindContextActions();
    else
        p14:UnbindContextActions();
        p14:OnInputEnded();
    end;
    p14.enabled = v17;
    p14.thumbstickFrame.Visible = v17;
    return nil;
end;
function u10.OnInputEnded(p18) --[[ Line: 130 ]]
    p18.moveTouchObject = nil;
    p18.moveVector = Vector3.new(0, 0, 0);
    p18:FadeThumbstick(false);
end;
function u10.FadeThumbstick(p19, p20) --[[ Line: 136 ]]
    -- upvalues: l__TweenService__7 (copy), u3 (copy), u1 (copy)
    if p20 or not p19.moveTouchObject then
        if p19.isFirstTouch then
        else
            if p19.startImageFadeTween then
                p19.startImageFadeTween:Cancel();
            end;
            if p19.endImageFadeTween then
                p19.endImageFadeTween:Cancel();
            end;
            for v21 = 1, #p19.middleImages do
                if p19.middleImageFadeTweens[v21] then
                    p19.middleImageFadeTweens[v21]:Cancel();
                end;
            end;
            if p20 then
                p19.startImageFadeTween = l__TweenService__7:Create(p19.startImage, u3, {
                    ImageTransparency = 0
                });
                p19.startImageFadeTween:Play();
                p19.endImageFadeTween = l__TweenService__7:Create(p19.endImage, u3, {
                    ImageTransparency = 0.2
                });
                p19.endImageFadeTween:Play();
                for v22 = 1, #p19.middleImages do
                    p19.middleImageFadeTweens[v22] = l__TweenService__7:Create(p19.middleImages[v22], u3, {
                        ImageTransparency = u1[v22]
                    });
                    p19.middleImageFadeTweens[v22]:Play();
                end;
            else
                p19.startImageFadeTween = l__TweenService__7:Create(p19.startImage, u3, {
                    ImageTransparency = 1
                });
                p19.startImageFadeTween:Play();
                p19.endImageFadeTween = l__TweenService__7:Create(p19.endImage, u3, {
                    ImageTransparency = 1
                });
                p19.endImageFadeTween:Play();
                for v23 = 1, #p19.middleImages do
                    p19.middleImageFadeTweens[v23] = l__TweenService__7:Create(p19.middleImages[v23], u3, {
                        ImageTransparency = 1
                    });
                    p19.middleImageFadeTweens[v23]:Play();
                end;
            end;
        end;
    end;
end;
function u10.FadeThumbstickFrame(p24, p25, p26) --[[ Line: 179 ]]
    p24.fadeInAndOutHalfDuration = p25 * 0.5;
    p24.fadeInAndOutBalance = p26;
    p24.tweenInAlphaStart = tick();
end;
function u10.InputInFrame(p27, p28) --[[ Line: 185 ]]
    local l__AbsolutePosition__13 = p27.thumbstickFrame.AbsolutePosition;
    local v29 = l__AbsolutePosition__13 + p27.thumbstickFrame.AbsoluteSize;
    local l__Position__14 = p28.Position;
    return l__Position__14.X >= l__AbsolutePosition__13.X and (l__Position__14.Y >= l__AbsolutePosition__13.Y and (l__Position__14.X <= v29.X and l__Position__14.Y <= v29.Y));
end;
function u10.DoFadeInBackground(p30) --[[ Line: 197 ]]
    -- upvalues: l__LocalPlayer__10 (ref)
    local v31 = l__LocalPlayer__10:FindFirstChildOfClass("PlayerGui");
    local v32 = false;
    if v31 then
        if v31.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v31.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v32 = p30.hasFadedBackgroundInLandscape;
            p30.hasFadedBackgroundInLandscape = true;
        elseif v31.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v32 = p30.hasFadedBackgroundInPortrait;
            p30.hasFadedBackgroundInPortrait = true;
        end;
    end;
    if not v32 then
        p30.fadeInAndOutHalfDuration = 0.3;
        p30.fadeInAndOutBalance = 0.5;
        p30.tweenInAlphaStart = tick();
    end;
end;
function u10.DoMove(p33, p34) --[[ Line: 220 ]]
    local v35;
    if p34.Magnitude < p33.radiusOfDeadZone then
        v35 = Vector3.new(0, 0, 0);
    else
        local v36 = p34.Unit * (1 - math.max(0, (p33.radiusOfMaxSpeed - p34.Magnitude) / p33.radiusOfMaxSpeed));
        v35 = Vector3.new(v36.X, 0, v36.Y);
    end;
    p33.moveVector = v35;
end;
function u10.LayoutMiddleImages(p37, p38, p39) --[[ Line: 238 ]]
    -- upvalues: u2 (copy)
    local v40 = p37.thumbstickSize / 2 + p37.middleSize;
    local v41 = p39 - p38;
    local v42 = v41.Magnitude - p37.thumbstickRingSize / 2 - p37.middleSize;
    local l__Unit__15 = v41.Unit;
    local v43 = p37.middleSpacing * u2;
    local l__middleSpacing__16 = p37.middleSpacing;
    if v43 < v42 then
        l__middleSpacing__16 = v42 / u2;
    end;
    for v44 = 1, u2 do
        local v45 = p37.middleImages[v44];
        local v46 = v40 + l__middleSpacing__16 * (v44 - 2);
        local v47 = v40 + l__middleSpacing__16 * (v44 - 1);
        if v46 < v42 then
            local v48 = p39 - l__Unit__15 * v47;
            local v49 = math.clamp(1 - (v47 - v42) / l__middleSpacing__16, 0, 1);
            v45.Visible = true;
            v45.Position = UDim2.new(0, v48.X, 0, v48.Y);
            v45.Size = UDim2.new(0, p37.middleSize * v49, 0, p37.middleSize * v49);
        else
            v45.Visible = false;
        end;
    end;
end;
function u10.MoveStick(p50, p51) --[[ Line: 269 ]]
    local v52 = Vector2.new(p50.moveTouchStartPosition.X, p50.moveTouchStartPosition.Y) - p50.thumbstickFrame.AbsolutePosition;
    local v53 = Vector2.new(p51.X, p51.Y) - p50.thumbstickFrame.AbsolutePosition;
    p50.endImage.Position = UDim2.new(0, v53.X, 0, v53.Y);
    p50:LayoutMiddleImages(v52, v53);
end;
function u10.BindContextActions(u54) --[[ Line: 277 ]]
    -- upvalues: l__TweenService__7 (copy), l__ContextActionService__5 (copy), l__Value__1 (copy), l__UserInputService__4 (copy)
    local function u57(p55) --[[ Line: 278 ]]
        -- upvalues: u54 (copy), l__TweenService__7 (ref)
        if u54.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;
        if not u54:InputInFrame(p55) then
            return Enum.ContextActionResult.Pass;
        end;
        if u54.isFirstTouch then
            u54.isFirstTouch = false;
            local v56 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
            l__TweenService__7:Create(u54.startImage, v56, {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play();
            l__TweenService__7:Create(u54.endImage, v56, {
                Size = UDim2.new(0, u54.thumbstickSize, 0, u54.thumbstickSize),
                ImageColor3 = Color3.new(0, 0, 0)
            }):Play();
        end;
        u54.moveTouchLockedIn = false;
        u54.moveTouchObject = p55;
        u54.moveTouchStartPosition = p55.Position;
        u54.moveTouchFirstChanged = true;
        u54:DoFadeInBackground();
        return Enum.ContextActionResult.Pass;
    end;
    local function u61(p58) --[[ Line: 310 ]]
        -- upvalues: u54 (copy)
        if p58 ~= u54.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;
        if u54.moveTouchFirstChanged then
            u54.moveTouchFirstChanged = false;
            local v59 = Vector2.new(p58.Position.X - u54.thumbstickFrame.AbsolutePosition.X, p58.Position.Y - u54.thumbstickFrame.AbsolutePosition.Y);
            u54.startImage.Visible = true;
            u54.startImage.Position = UDim2.new(0, v59.X, 0, v59.Y);
            u54.endImage.Visible = true;
            u54.endImage.Position = u54.startImage.Position;
            u54:FadeThumbstick(true);
            u54:MoveStick(p58.Position);
        end;
        u54.moveTouchLockedIn = true;
        local v60 = Vector2.new(p58.Position.X - u54.moveTouchStartPosition.X, p58.Position.Y - u54.moveTouchStartPosition.Y);
        if math.abs(v60.X) > 0 or math.abs(v60.Y) > 0 then
            u54:DoMove(v60);
            u54:MoveStick(p58.Position);
        end;
        return Enum.ContextActionResult.Sink;
    end;
    l__ContextActionService__5:BindActionAtPriority("DynamicThumbstickAction", function(_, p62, p63) --[[ Name: handleInput, Line 353 ]]
        -- upvalues: u57 (copy), u54 (copy)
        if p62 == Enum.UserInputState.Begin then
            return u57(p63);
        elseif p62 == Enum.UserInputState.Change then
            if p63 == u54.moveTouchObject then
                return Enum.ContextActionResult.Sink;
            else
                return Enum.ContextActionResult.Pass;
            end;
        else
            if p62 == Enum.UserInputState.End then
                if p63 == u54.moveTouchObject then
                    u54:OnInputEnded();
                    if u54.moveTouchLockedIn then
                        return Enum.ContextActionResult.Sink;
                    end;
                end;
                return Enum.ContextActionResult.Pass;
            end;
            if p62 == Enum.UserInputState.Cancel then
                u54:OnInputEnded();
            end;
        end;
    end, false, l__Value__1, Enum.UserInputType.Touch);
    u54.TouchMovedCon = l__UserInputService__4.TouchMoved:Connect(function(p64, _) --[[ Line: 376 ]]
        -- upvalues: u61 (copy)
        u61(p64);
    end);
end;
function u10.UnbindContextActions(p65) --[[ Line: 381 ]]
    -- upvalues: l__ContextActionService__5 (copy)
    l__ContextActionService__5:UnbindAction("DynamicThumbstickAction");
    if p65.TouchMovedCon then
        p65.TouchMovedCon:Disconnect();
    end;
end;
function u10.Create(u66, u67) --[[ Line: 389 ]]
    -- upvalues: u4 (copy), u8 (ref), u2 (copy), u1 (copy), u5 (copy), u9 (ref), l__RunService__6 (copy), l__UserInputService__4 (copy), l__GuiService__3 (copy), l__LocalPlayer__10 (ref)
    if u66.thumbstickFrame then
        u66.thumbstickFrame:Destroy();
        u66.thumbstickFrame = nil;
        if u66.onRenderSteppedConn then
            u66.onRenderSteppedConn:Disconnect();
            u66.onRenderSteppedConn = nil;
        end;
        if u66.absoluteSizeChangedConn then
            u66.absoluteSizeChangedConn:Disconnect();
            u66.absoluteSizeChangedConn = nil;
        end;
        if u4 and u66.avatarAbilitiesEnabledChangedConn then
            u66.avatarAbilitiesEnabledChangedConn:Disconnect();
            u66.avatarAbilitiesEnabledChangedConn = nil;
        end;
    end;
    local u68 = u8 and 100 or 0;
    u66.thumbstickFrame = Instance.new("Frame");
    u66.thumbstickFrame.BorderSizePixel = 0;
    u66.thumbstickFrame.Name = "DynamicThumbstickFrame";
    u66.thumbstickFrame.Visible = false;
    u66.thumbstickFrame.BackgroundTransparency = 1;
    u66.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    u66.thumbstickFrame.Active = false;
    u66.thumbstickFrame.Size = UDim2.new(0.4, u68, 0.6666666666666666, u68);
    u66.thumbstickFrame.Position = UDim2.new(0, -u68, 0.3333333333333333, 0);
    u66.startImage = Instance.new("ImageLabel");
    u66.startImage.Name = "ThumbstickStart";
    u66.startImage.Visible = true;
    u66.startImage.BackgroundTransparency = 1;
    u66.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u66.startImage.ImageRectOffset = Vector2.new(1, 1);
    u66.startImage.ImageRectSize = Vector2.new(144, 144);
    u66.startImage.ImageColor3 = Color3.new(0, 0, 0);
    u66.startImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u66.startImage.ZIndex = 10;
    u66.startImage.Parent = u66.thumbstickFrame;
    u66.endImage = Instance.new("ImageLabel");
    u66.endImage.Name = "ThumbstickEnd";
    u66.endImage.Visible = true;
    u66.endImage.BackgroundTransparency = 1;
    u66.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u66.endImage.ImageRectOffset = Vector2.new(1, 1);
    u66.endImage.ImageRectSize = Vector2.new(144, 144);
    u66.endImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u66.endImage.ZIndex = 10;
    u66.endImage.Parent = u66.thumbstickFrame;
    local function u70(p69) --[[ Line: 410 ]]
        -- upvalues: u66 (copy), u68 (copy)
        if p69 then
            u66.thumbstickFrame.Size = UDim2.new(1, u68, 0.4, u68);
            u66.thumbstickFrame.Position = UDim2.new(0, -u68, 0.6, 0);
        else
            u66.thumbstickFrame.Size = UDim2.new(0.4, u68, 0.6666666666666666, u68);
            u66.thumbstickFrame.Position = UDim2.new(0, -u68, 0.3333333333333333, 0);
        end;
    end;
    for v71 = 1, u2 do
        u66.middleImages[v71] = Instance.new("ImageLabel");
        u66.middleImages[v71].Name = "ThumbstickMiddle";
        u66.middleImages[v71].Visible = false;
        u66.middleImages[v71].BackgroundTransparency = 1;
        u66.middleImages[v71].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u66.middleImages[v71].ImageRectOffset = Vector2.new(1, 1);
        u66.middleImages[v71].ImageRectSize = Vector2.new(144, 144);
        u66.middleImages[v71].ImageTransparency = u1[v71];
        u66.middleImages[v71].AnchorPoint = Vector2.new(0.5, 0.5);
        u66.middleImages[v71].ZIndex = 9;
        u66.middleImages[v71].Parent = u66.thumbstickFrame;
    end;
    local function v75() --[[ Line: 466 ]]
        -- upvalues: u67 (copy), u4 (ref), u5 (ref), u9 (ref), u66 (copy), u68 (copy)
        local l__AbsoluteSize__17 = u67.AbsoluteSize;
        local v72 = math.min(l__AbsoluteSize__17.X, l__AbsoluteSize__17.Y) > 500;
        if u4 then
            local v73 = u5 and (u9.isEnabled() and v72) and 1.6216216216216217 or (v72 and 2 or 1);
            u66.thumbstickSize = 45 * v73;
            u66.thumbstickRingSize = 20 * v73;
            u66.middleSize = 10 * v73;
            u66.middleSpacing = 14 * v73;
            u66.radiusOfDeadZone = 2 * v73;
            u66.radiusOfMaxSpeed = 20 * v73;
            local v74 = 74 * v73;
            if u9.isEnabled() then
                u66.startImage.Position = UDim2.new(0, v74 * 0.5 + u68 + (v72 and 100 or 64), 1, -v74 * 0.5 - u68 - (v72 and 112 or 64));
                u66.startImage.Size = UDim2.new(0, v74, 0, v74);
            else
                u66.startImage.Position = UDim2.new(0, u66.thumbstickRingSize * 3.3 + u68, 1, -u66.thumbstickRingSize * 2.8 - u68);
                u66.startImage.Size = UDim2.new(0, v74, 0, v74);
            end;
        else
            if v72 then
                u66.thumbstickSize = 90;
                u66.thumbstickRingSize = 40;
                u66.middleSize = 20;
                u66.middleSpacing = 28;
                u66.radiusOfDeadZone = 4;
                u66.radiusOfMaxSpeed = 40;
            else
                u66.thumbstickSize = 45;
                u66.thumbstickRingSize = 20;
                u66.middleSize = 10;
                u66.middleSpacing = 14;
                u66.radiusOfDeadZone = 2;
                u66.radiusOfMaxSpeed = 20;
            end;
            u66.startImage.Position = UDim2.new(0, u66.thumbstickRingSize * 3.3 + u68, 1, -u66.thumbstickRingSize * 2.8 - u68);
            u66.startImage.Size = UDim2.new(0, u66.thumbstickRingSize * 3.7, 0, u66.thumbstickRingSize * 3.7);
        end;
        u66.endImage.Position = u66.startImage.Position;
        u66.endImage.Size = UDim2.new(0, u66.thumbstickSize * 0.8, 0, u66.thumbstickSize * 0.8);
    end;
    v75();
    u66.absoluteSizeChangedConn = u67:GetPropertyChangedSignal("AbsoluteSize"):Connect(v75);
    if u4 then
        u66.avatarAbilitiesEnabledChangedConn = u9.GetEnabledChangedSignal():Connect(v75);
    end;
    local u76 = nil;
    local function v78() --[[ Line: 534 ]]
        -- upvalues: u76 (ref), u70 (copy)
        if u76 then
            u76:Disconnect();
            u76 = nil;
        end;
        local l__CurrentCamera__18 = workspace.CurrentCamera;
        if l__CurrentCamera__18 then
            local function v77() --[[ Line: 541 ]]
                -- upvalues: l__CurrentCamera__18 (copy), u70 (ref)
                local l__ViewportSize__19 = l__CurrentCamera__18.ViewportSize;
                u70(l__ViewportSize__19.X < l__ViewportSize__19.Y);
            end;
            u76 = l__CurrentCamera__18:GetPropertyChangedSignal("ViewportSize"):Connect(v77);
            local l__ViewportSize__20 = l__CurrentCamera__18.ViewportSize;
            u70(l__ViewportSize__20.X < l__ViewportSize__20.Y);
        end;
    end;
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(v78);
    if workspace.CurrentCamera then
        v78();
    end;
    u66.moveTouchStartPosition = nil;
    u66.startImageFadeTween = nil;
    u66.endImageFadeTween = nil;
    u66.middleImageFadeTweens = {};
    u66.onRenderSteppedConn = l__RunService__6.RenderStepped:Connect(function() --[[ Line: 561 ]]
        -- upvalues: u66 (copy)
        if u66.tweenInAlphaStart == nil then
            if u66.tweenOutAlphaStart ~= nil then
                local v79 = tick() - u66.tweenOutAlphaStart;
                local v80 = u66.fadeInAndOutHalfDuration * 2 - u66.fadeInAndOutHalfDuration * 2 * u66.fadeInAndOutBalance;
                u66.thumbstickFrame.BackgroundTransparency = math.min(v79 / v80, 1) * 0.35 + 0.65;
                if v80 < v79 then
                    u66.tweenOutAlphaStart = nil;
                end;
            end;
        else
            local v81 = tick() - u66.tweenInAlphaStart;
            local v82 = u66.fadeInAndOutHalfDuration * 2 * u66.fadeInAndOutBalance;
            u66.thumbstickFrame.BackgroundTransparency = 1 - math.min(v81 / v82, 1) * 0.35;
            if v82 < v81 then
                u66.tweenOutAlphaStart = tick();
                u66.tweenInAlphaStart = nil;
            end;
        end;
    end);
    u66.onTouchEndedConn = l__UserInputService__4.TouchEnded:connect(function(p83) --[[ Line: 580 ]]
        -- upvalues: u66 (copy)
        if p83 == u66.moveTouchObject then
            u66:OnInputEnded();
        end;
    end);
    l__GuiService__3.MenuOpened:connect(function() --[[ Line: 586 ]]
        -- upvalues: u66 (copy)
        if u66.moveTouchObject then
            u66:OnInputEnded();
        end;
    end);
    local u84 = l__LocalPlayer__10:FindFirstChildOfClass("PlayerGui");
    while not u84 do
        l__LocalPlayer__10.ChildAdded:wait();
        u84 = l__LocalPlayer__10:FindFirstChildOfClass("PlayerGui");
    end;
    local u85 = nil;
    local u86 = u84.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or u84.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight;
    local _ = u84:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function() --[[ Line: 608 ]]
        -- upvalues: u86 (copy), u84 (ref), u85 (ref), u66 (copy)
        if u86 and u84.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait or not u86 and u84.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
            u85:disconnect();
            u66.fadeInAndOutHalfDuration = 2.5;
            u66.fadeInAndOutBalance = 0.05;
            u66.tweenInAlphaStart = tick();
            if u86 then
                u66.hasFadedBackgroundInPortrait = true;
                return;
            end;
            u66.hasFadedBackgroundInLandscape = true;
        end;
    end);
    u66.thumbstickFrame.Parent = u67;
    if game:IsLoaded() then
        u66.fadeInAndOutHalfDuration = 2.5;
        u66.fadeInAndOutBalance = 0.05;
        u66.tweenInAlphaStart = tick();
    else
        coroutine.wrap(function() --[[ Line: 628 ]]
            -- upvalues: u66 (copy)
            game.Loaded:Wait();
            u66.fadeInAndOutHalfDuration = 2.5;
            u66.fadeInAndOutBalance = 0.05;
            u66.tweenInAlphaStart = tick();
        end)();
    end;
end;
return u10;