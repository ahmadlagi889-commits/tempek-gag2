-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Asserts__2 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local v1 = l__Asserts__2.Table({
    JoinSource = l__Asserts__2.Enum(Enum.JoinSource),
    ItemType = l__Asserts__2.Optional(l__Asserts__2.Enum(Enum.AvatarItemType)),
    AssetId = l__Asserts__2.Optional(l__Asserts__2.Pattern("^rbxassetid://%d+$")),
    OutfitId = l__Asserts__2.Optional(l__Asserts__2.Pattern("^rbxassetid://%d+$")),
    AssetType = l__Asserts__2.Optional(l__Asserts__2.Enum(Enum.AssetType))
});
local v2 = l__Asserts__2.Table({
    SourceGameId = l__Asserts__2.Optional(l__Asserts__2.Integer),
    SourcePlaceId = l__Asserts__2.Optional(l__Asserts__2.Integer),
    ReferredByPlayerId = l__Asserts__2.Optional(l__Asserts__2.Integer),
    Members = l__Asserts__2.Optional(l__Asserts__2.UniqueArray(l__Asserts__2.Integer)),
    TeleportData = l__Asserts__2.Optional(l__Asserts__2.Storable),
    LaunchData = l__Asserts__2.Optional(l__Asserts__2.Storable),
    GameJoinContext = l__Asserts__2.Optional(v1)
});
local v3 = {};
for _, v4 in ipairs(Enum.DeveloperMemoryTag:GetEnumItems()) do
    local l__Name__3 = v4.Name;
    v3[l__Name__3 == "PhysicsParts" and "BaseParts" or l__Name__3] = l__Asserts__2.FiniteNonNegative;
end;
local v5 = l__Asserts__2.Table({
    ContactsCount = l__Asserts__2.IntegerNonNegative,
    DataReceiveKbps = l__Asserts__2.FiniteNonNegative,
    DataSendKbps = l__Asserts__2.FiniteNonNegative,
    FrameTime = l__Asserts__2.FiniteNonNegative,
    HeartbeatTime = l__Asserts__2.FiniteNonNegative,
    InstanceCount = l__Asserts__2.IntegerNonNegative,
    MovingPrimitivesCount = l__Asserts__2.IntegerNonNegative,
    PhysicsReceiveKbps = l__Asserts__2.FiniteNonNegative,
    PhysicsSendKbps = l__Asserts__2.FiniteNonNegative,
    PhysicsStepTime = l__Asserts__2.FiniteNonNegative,
    PrimitivesCount = l__Asserts__2.IntegerNonNegative,
    RenderCPUFrameTime = l__Asserts__2.FiniteNonNegative,
    RenderGPUFrameTime = l__Asserts__2.Number,
    SceneDrawcallCount = l__Asserts__2.IntegerNonNegative,
    SceneTriangleCount = l__Asserts__2.IntegerNonNegative,
    ShadowsDrawcallCount = l__Asserts__2.IntegerNonNegative,
    ShadowsTriangleCount = l__Asserts__2.IntegerNonNegative,
    UI2DDrawcallCount = l__Asserts__2.IntegerNonNegative,
    UI2DTriangleCount = l__Asserts__2.IntegerNonNegative,
    UI3DDrawcallCount = l__Asserts__2.IntegerNonNegative,
    UI3DTriangleCount = l__Asserts__2.IntegerNonNegative,
    MemoryUsageMbForTag = l__Asserts__2.Table(v3),
    TotalMemoryUsageMb = l__Asserts__2.FiniteNonNegative
});
local v6 = {
    AssertGameJoinContext = v1,
    AssertJoinData = v2,
    AssertData = l__Asserts__2.Table({
        System = l__Asserts__2.Table({
            UWP = l__Asserts__2.Optional(l__Asserts__2.Boolean),
            Windows = l__Asserts__2.Boolean,
            Time = l__Asserts__2.Finite,
            Clock = l__Asserts__2.Finite,
            ElapsedTime = l__Asserts__2.Finite,
            TimezoneOffset = l__Asserts__2.String,
            Timezone = l__Asserts__2.String,
            TimezoneDST = l__Asserts__2.Boolean,
            HeapSize = l__Asserts__2.FiniteNonNegative
        }),
        Game = l__Asserts__2.Table({
            LoadingDuration = l__Asserts__2.Optional(l__Asserts__2.FiniteNonNegative)
        }),
        LocalPlayer = l__Asserts__2.Table({
            JoinData = v2,
            NetworkPing = l__Asserts__2.Optional(l__Asserts__2.FinitePositive)
        }),
        TeleportService = l__Asserts__2.Table({
            TeleportData = l__Asserts__2.Optional(l__Asserts__2.Storable)
        }),
        Workspace = l__Asserts__2.Table({
            ServerTimeNow = l__Asserts__2.Finite,
            RealPhysicsFPS = l__Asserts__2.FiniteNonNegative,
            DistributedGameTime = l__Asserts__2.FiniteNonNegative,
            NumAwakeParts = l__Asserts__2.FiniteNonNegative,
            PhysicsThrottling = l__Asserts__2.IntegerRange(0, 100)
        }),
        Stats = l__Asserts__2.Optional(v5),
        UserInputService = l__Asserts__2.Table({
            DeviceForm = l__Asserts__2.Optional(l__Asserts__2.Enum(Enum.DeviceForm))
        }),
        GuiService = l__Asserts__2.Table({
            IsTenFootInterface = l__Asserts__2.Boolean,
            TouchControlsEnabled = l__Asserts__2.Boolean,
            GuiInsetTopLeft = l__Asserts__2.Vector2Finite,
            GuiInsetBotRight = l__Asserts__2.Vector2Finite,
            IsModalDialog = l__Asserts__2.Boolean,
            MenuIsOpen = l__Asserts__2.Boolean,
            PreferredTransparency = l__Asserts__2.Range(0, 1),
            ReducedMotionEnabled = l__Asserts__2.Boolean,
            CoreGuiNavigationEnabled = l__Asserts__2.Boolean,
            GuiNavigationEnabled = l__Asserts__2.Boolean,
            AutoSelectGuiEnabled = l__Asserts__2.Boolean
        }),
        CurrentCamera = l__Asserts__2.Table({
            ViewportSize = l__Asserts__2.Vector2Finite
        }),
        LocalizationService = l__Asserts__2.Table({
            RobloxLocaleId = l__Asserts__2.StringRange(0, 1000),
            SystemLocaleId = l__Asserts__2.StringRange(0, 5000)
        }),
        VoiceChatService = l__Asserts__2.Table({
            VoiceEnabled = l__Asserts__2.Optional(l__Asserts__2.Boolean)
        }),
        UserSettings = l__Asserts__2.Table({
            GameSettings = l__Asserts__2.Table({
                ControlMode = l__Asserts__2.Enum(Enum.ControlMode),
                VignetteEnabled = l__Asserts__2.Boolean,
                ComputerCameraMovementMode = l__Asserts__2.Enum(Enum.ComputerCameraMovementMode),
                ComputerMovementMode = l__Asserts__2.Enum(Enum.ComputerMovementMode),
                GamepadCameraSensitivity = l__Asserts__2.FiniteNonNegative,
                MouseSensitivity = l__Asserts__2.Range(0, 10),
                RotationType = l__Asserts__2.Enum(Enum.RotationType),
                SavedQualityLevel = l__Asserts__2.Enum(Enum.SavedQualitySetting),
                TouchCameraMovementMode = l__Asserts__2.Enum(Enum.TouchCameraMovementMode),
                TouchMovementMode = l__Asserts__2.Enum(Enum.TouchMovementMode),
                InFullScreen = l__Asserts__2.Boolean,
                InStudioMode = l__Asserts__2.Boolean
            })
        })
    }),
    AcceptRemote = script:WaitForChild("Accept"),
    PingRemote = script:WaitForChild("Ping"),
    MenuStateRemote = script:WaitForChild("MenuState"),
    FocusStateRemote = script:WaitForChild("FocusState")
};
return table.freeze(v6);