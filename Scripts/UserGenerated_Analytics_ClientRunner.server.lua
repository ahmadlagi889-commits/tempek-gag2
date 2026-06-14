-- Decompiled with Potassium's decompiler.

local u1 = os.clock();
local l__GuiService__1 = game:GetService("GuiService");
local l__HttpService__2 = game:GetService("HttpService");
local l__LocalizationService__3 = game:GetService("LocalizationService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Players__5 = game:GetService("Players");
local l__ReplicatedStorage__6 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Stats__7 = game:GetService("Stats");
local l__TeleportService__8 = game:GetService("TeleportService");
local l__VoiceChatServiceHelper__9 = require(l__ReplicatedStorage__6.UserGenerated.Roblox.VoiceChatServiceHelper);
local l__ThreadJoin__10 = require(l__ReplicatedStorage__6.UserGenerated.Concurrency.ThreadJoin);
local l__ClientKit__11 = require(l__ReplicatedStorage__6.UserGenerated.Analytics.ClientKit);
local l__UTF8Sub__12 = require(l__ReplicatedStorage__6.UserGenerated.Strings.UTF8Sub);
local l__LocalPlayer__13 = l__Players__5.LocalPlayer;
local u2 = nil;
function SafeGet(u3, u4, p5)
    local v6, v7 = pcall(function(_, _) --[[ Line: 48 ]]
        -- upvalues: u3 (copy), u4 (copy)
        return u3[u4];
    end, u3, u4);
    if v6 then
        return v7;
    else
        return p5;
    end;
end;
function IsUWP()
    local v8, v9 = pcall(function() --[[ Line: 56 ]]
        return tostring({ 1 }):match("^table: 0x(00000000%x+)$") ~= nil;
    end);
    return v8 and v9;
end;
function IsWindows()
    -- upvalues: l__GuiService__1 (copy)
    return SafeGet(l__GuiService__1, "IsWindows", false);
end;
function GetDeviceForm()
    -- upvalues: l__UserInputService__4 (copy), l__GuiService__1 (copy)
    if l__UserInputService__4.VREnabled then
        return Enum.DeviceForm.VR;
    elseif l__GuiService__1:IsTenFootInterface() then
        return Enum.DeviceForm.Console;
    elseif IsWindows() then
        return Enum.DeviceForm.Desktop;
    elseif l__UserInputService__4.GyroscopeEnabled or l__UserInputService__4.AccelerometerEnabled then
        return Enum.DeviceForm.Phone;
    elseif l__UserInputService__4.MouseEnabled then
        return Enum.DeviceForm.Desktop;
    elseif l__UserInputService__4.TouchEnabled then
        return Enum.DeviceForm.Phone;
    elseif l__UserInputService__4.GamepadEnabled then
        return Enum.DeviceForm.Console;
    else
        return nil;
    end;
end;
function IsLoaded()
    -- upvalues: l__LocalPlayer__13 (copy)
    if game:IsLoaded() then
        local l__Character__14 = l__LocalPlayer__13.Character;
        if l__Character__14 then
            return l__Character__14.PrimaryPart and l__Character__14:FindFirstChild("Humanoid") and true or false;
        else
            return false;
        end;
    else
        return false;
    end;
end;
task.spawn(function() --[[ Line: 119 ]]
    -- upvalues: u2 (ref)
    while not IsLoaded() do
        task.wait();
    end;
    u2 = os.clock();
end);
function GetStartTime()
    -- upvalues: u1 (copy)
    local l____StartTime__15 = _G.__StartTime;
    if type(l____StartTime__15) == "number" then
        return l____StartTime__15;
    else
        return u1;
    end;
end;
function GetLoadDurationAsync(p10)
    -- upvalues: u2 (ref)
    local v11;
    while true do
        v11 = u2;
        if v11 then
            break;
        end;
        if p10 then
            return nil;
        end;
        task.wait();
    end;
    local v12 = v11 - GetStartTime();
    return math.max(0, v12);
end;
function Build()
    -- upvalues: l__GuiService__1 (copy), l__LocalPlayer__13 (copy), l__HttpService__2 (copy), l__Stats__7 (copy), l__TeleportService__8 (copy), l__LocalizationService__3 (copy), l__UTF8Sub__12 (copy), l__VoiceChatServiceHelper__9 (copy), l__ThreadJoin__10 (copy)
    local v13 = GetLoadDurationAsync(false);
    local v14 = os.time();
    local v15 = os.clock();
    local v16 = workspace:GetServerTimeNow();
    local v17 = elapsedTime();
    local l__GameSettings__16 = UserSettings().GameSettings;
    local v18, v19 = l__GuiService__1:GetGuiInset();
    local u20 = nil;
    pcall(function() --[[ Line: 168 ]]
        -- upvalues: l__LocalPlayer__13 (ref), u20 (ref)
        local v21 = l__LocalPlayer__13:GetNetworkPing();
        if v21 > 0 then
            u20 = v21 * 1000;
        end;
    end);
    local u22 = l__LocalPlayer__13:GetJoinData();
    if u22.LaunchData ~= nil then
        pcall(function() --[[ Line: 176 ]]
            -- upvalues: u22 (copy), l__HttpService__2 (ref)
            u22.LaunchData = l__HttpService__2:JSONDecode(u22.LaunchData);
        end);
    end;
    local v25 = l__Stats__7.MemoryTrackingEnabled and {
        ContactsCount = l__Stats__7.ContactsCount,
        DataReceiveKbps = l__Stats__7.DataReceiveKbps,
        DataSendKbps = l__Stats__7.DataSendKbps,
        FrameTime = l__Stats__7.FrameTime,
        HeartbeatTime = l__Stats__7.HeartbeatTime,
        InstanceCount = l__Stats__7.InstanceCount,
        MovingPrimitivesCount = l__Stats__7.MovingPrimitivesCount,
        PhysicsReceiveKbps = l__Stats__7.PhysicsReceiveKbps,
        PhysicsSendKbps = l__Stats__7.PhysicsSendKbps,
        PhysicsStepTime = l__Stats__7.PhysicsStepTime,
        PrimitivesCount = l__Stats__7.PrimitivesCount,
        RenderCPUFrameTime = l__Stats__7.RenderCPUFrameTime,
        RenderGPUFrameTime = l__Stats__7.RenderGPUFrameTime,
        SceneDrawcallCount = l__Stats__7.SceneDrawcallCount,
        SceneTriangleCount = l__Stats__7.SceneTriangleCount,
        ShadowsDrawcallCount = l__Stats__7.ShadowsDrawcallCount,
        ShadowsTriangleCount = l__Stats__7.ShadowsTriangleCount,
        UI2DDrawcallCount = l__Stats__7.UI2DDrawcallCount,
        UI2DTriangleCount = l__Stats__7.UI2DTriangleCount,
        UI3DDrawcallCount = l__Stats__7.UI3DDrawcallCount,
        UI3DTriangleCount = l__Stats__7.UI3DTriangleCount,
        MemoryUsageMbForTag = (function() --[[ Line: 207 ]]
            -- upvalues: l__Stats__7 (ref)
            local v23 = {};
            for _, v24 in ipairs(Enum.DeveloperMemoryTag:GetEnumItems()) do
                local l__Name__17 = v24.Name;
                v23[l__Name__17 == "PhysicsParts" and "BaseParts" or l__Name__17] = l__Stats__7:GetMemoryUsageMbForTag(v24);
            end;
            return v23;
        end)(),
        TotalMemoryUsageMb = l__Stats__7:GetTotalMemoryUsageMb()
    } or nil;
    local u26 = {
        System = {
            UWP = IsUWP(),
            Windows = IsWindows(),
            Time = v14,
            Clock = v15,
            ElapsedTime = v17,
            TimezoneOffset = os.date("%z"),
            Timezone = l__HttpService__2:UrlEncode((os.date("%Z"))),
            TimezoneDST = os.date("*t").isdst == true,
            HeapSize = gcinfo()
        },
        Game = {
            LoadingDuration = v13
        },
        LocalPlayer = {
            JoinData = u22,
            NetworkPing = u20
        },
        TeleportService = {
            TeleportData = l__TeleportService__8:GetLocalPlayerTeleportData()
        },
        Workspace = {
            ServerTimeNow = v16,
            RealPhysicsFPS = workspace:GetRealPhysicsFPS(),
            DistributedGameTime = workspace.DistributedGameTime,
            NumAwakeParts = workspace:GetNumAwakeParts(),
            PhysicsThrottling = workspace:GetPhysicsThrottling()
        },
        Stats = v25,
        UserInputService = {
            DeviceForm = GetDeviceForm()
        },
        GuiService = {
            IsTenFootInterface = l__GuiService__1:IsTenFootInterface(),
            TouchControlsEnabled = l__GuiService__1.TouchControlsEnabled,
            GuiInsetTopLeft = v18,
            GuiInsetBotRight = v19,
            IsModalDialog = SafeGet(l__GuiService__1, "IsModalDialog", false),
            MenuIsOpen = l__GuiService__1.MenuIsOpen,
            PreferredTransparency = math.clamp(l__GuiService__1.PreferredTransparency, 0, 1),
            ReducedMotionEnabled = l__GuiService__1.ReducedMotionEnabled,
            CoreGuiNavigationEnabled = l__GuiService__1.CoreGuiNavigationEnabled,
            GuiNavigationEnabled = l__GuiService__1.GuiNavigationEnabled,
            AutoSelectGuiEnabled = l__GuiService__1.AutoSelectGuiEnabled
        },
        CurrentCamera = {
            ViewportSize = workspace.CurrentCamera.ViewportSize
        },
        LocalizationService = {
            RobloxLocaleId = l__LocalizationService__3.RobloxLocaleId:lower(),
            SystemLocaleId = l__UTF8Sub__12(l__LocalizationService__3.SystemLocaleId:lower(), 1, 1000)
        },
        VoiceChatService = {},
        UserSettings = {
            GameSettings = {
                ControlMode = l__GameSettings__16.ControlMode,
                VignetteEnabled = l__GameSettings__16.VignetteEnabled,
                ComputerCameraMovementMode = l__GameSettings__16.ComputerCameraMovementMode,
                ComputerMovementMode = l__GameSettings__16.ComputerMovementMode,
                GamepadCameraSensitivity = l__GameSettings__16.GamepadCameraSensitivity,
                MouseSensitivity = l__GameSettings__16.MouseSensitivity,
                RotationType = l__GameSettings__16.RotationType,
                SavedQualityLevel = l__GameSettings__16.SavedQualityLevel,
                TouchCameraMovementMode = l__GameSettings__16.TouchCameraMovementMode,
                TouchMovementMode = l__GameSettings__16.TouchMovementMode,
                InFullScreen = l__GameSettings__16:InFullScreen(),
                InStudioMode = l__GameSettings__16:InStudioMode()
            }
        }
    };
    local v27 = {};
    table.insert(v27, task.spawn(function() --[[ Line: 301 ]]
        -- upvalues: u26 (copy), l__VoiceChatServiceHelper__9 (ref), l__LocalPlayer__13 (ref)
        u26.VoiceChatService.VoiceEnabled = l__VoiceChatServiceHelper__9.IsVoiceEnabledForUserIdAsync(l__LocalPlayer__13.UserId, false);
    end));
    for _, v28 in ipairs(v27) do
        l__ThreadJoin__10(v28);
    end;
    return u26;
end;
local u29 = false;
function Send()
    -- upvalues: u29 (ref), l__ClientKit__11 (copy)
    if u29 then
        return true;
    end;
    u29 = true;
    local v31 = pcall(function() --[[ Line: 324 ]]
        -- upvalues: l__ClientKit__11 (ref)
        local v30 = Build();
        l__ClientKit__11.AcceptRemote:FireServer(v30);
    end);
    u29 = false;
    return v31;
end;
local u32 = (-1 / 0);
l__GuiService__1.MenuOpened:Connect(function() --[[ Line: 333 ]]
    -- upvalues: u32 (ref)
    local v33 = os.clock();
    if v33 - u32 > 15 then
        u32 = v33;
        Send();
    end;
end);
l__UserInputService__4.WindowFocusReleased:Connect(function() --[[ Line: 341 ]]
    -- upvalues: u32 (ref)
    local v34 = os.clock();
    if v34 - u32 > 15 then
        u32 = v34;
        Send();
    end;
end);
task.spawn(function() --[[ Line: 349 ]]
    while true do
        Send();
        task.wait(150 + 300 * math.random());
    end;
end);