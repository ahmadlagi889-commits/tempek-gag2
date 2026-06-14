-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__TweenService__1 = game:GetService("TweenService");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__Players__3 = game:GetService("Players");
local u2 = script.Player:Clone();
u2.Parent = game.Workspace;
local l__LocalPlayer__4 = game.Players.LocalPlayer;
if l__LocalPlayer__4 and l__LocalPlayer__4.UserId then
    task.spawn(function() --[[ Line: 18 ]]
        -- upvalues: l__Players__3 (copy), l__LocalPlayer__4 (copy), u2 (copy)
        local v3, v4 = pcall(l__Players__3.GetHumanoidDescriptionFromUserIdAsync, l__Players__3, l__LocalPlayer__4.UserId);
        if v3 and v4 then
            u2.Humanoid:ApplyDescriptionResetAsync(v4);
        end;
    end);
end;
task.spawn(function() --[[ Line: 29 ]]
    -- upvalues: u2 (copy)
    task.wait(0.5);
    u2.Parent = script.FakePlot;
end);
local l__Trove__5 = require(game.ReplicatedStorage.ClientModules.Trove);
local l__DisplayPlantGrowthController__6 = require(script.Parent:WaitForChild("DisplayPlantGrowthController"));
local l__GuiController__7 = require(script.Parent:WaitForChild("GuiController"));
local l__LocalPlayer__8 = l__Players__3.LocalPlayer;
local l__CinematicBars__9 = l__LocalPlayer__8:WaitForChild("PlayerGui"):WaitForChild("CinematicBars");
local l__BottomBar__10 = l__CinematicBars__9:WaitForChild("BottomBar");
local l__TopBar__11 = l__CinematicBars__9:WaitForChild("TopBar");
local l__Prizes__12 = l__CinematicBars__9:WaitForChild("PrizesUI"):WaitForChild("Prizes");
local l__FakePlot__13 = script.FakePlot;
local u5 = l__Trove__5.new();
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = {
    "http://www.roblox.com/asset/?id=182435998",
    "http://www.roblox.com/asset/?id=182491037",
    "http://www.roblox.com/asset/?id=182491065",
    "http://www.roblox.com/asset/?id=182436842",
    "http://www.roblox.com/asset/?id=182491248",
    "http://www.roblox.com/asset/?id=182491277",
    "http://www.roblox.com/asset/?id=182436935",
    "http://www.roblox.com/asset/?id=182491368",
    "http://www.roblox.com/asset/?id=182491423"
};
local function u41(u11, u12) --[[ Line: 83 ]]
    -- upvalues: u10 (copy)
    local v13 = u11:FindFirstChildOfClass("Animator") or u11:WaitForChild("Animator", 5);
    local v14 = Instance.new("Animation");
    v14.AnimationId = "http://www.roblox.com/asset/?id=180435571";
    local u15 = v13:LoadAnimation(v14);
    v14:Destroy();
    local v16 = Instance.new("Animation");
    v16.AnimationId = "http://www.roblox.com/asset/?id=125750702";
    local u17 = v13:LoadAnimation(v16);
    v16:Destroy();
    local v18 = Instance.new("Animation");
    v18.AnimationId = "http://www.roblox.com/asset/?id=180436148";
    local v19 = v13:LoadAnimation(v18);
    v18:Destroy();
    local u20 = v19;
    local u21 = {};
    for v22, v23 in ipairs(u10) do
        local v24 = Instance.new("Animation");
        v24.AnimationId = v23;
        local v25 = v13:LoadAnimation(v24);
        v24:Destroy();
        u21[v22] = v25;
    end;
    local u26 = "dance";
    local u27 = nil;
    local function u29() --[[ Line: 116 ]]
        -- upvalues: u21 (copy), u27 (ref)
        local v28 = math.random(1, #u21);
        while v28 == u27 and #u21 > 1 do
            v28 = math.random(1, #u21);
        end;
        u27 = v28;
        return v28;
    end;
    local function u31() --[[ Line: 107 ]]
        -- upvalues: u15 (copy), u17 (copy), u20 (copy), u21 (copy)
        u15:Stop(0);
        u17:Stop(0);
        u20:Stop(0);
        for _, v30 in ipairs(u21) do
            v30:Stop(0);
        end;
    end;
    for _, u32 in ipairs(u21) do
        u32.KeyframeReached:Connect(function(p33) --[[ Line: 131 ]]
            -- upvalues: u32 (copy)
            if p33 == "End" and u32.IsPlaying then
                u32:Play(0);
            end;
        end);
    end;
    u15.KeyframeReached:Connect(function(p34) --[[ Line: 138 ]]
        -- upvalues: u15 (copy)
        if p34 == "End" and u15.IsPlaying then
            u15:Play(0);
        end;
    end);
    u11.Jumping:Connect(function() --[[ Line: 144 ]]
        -- upvalues: u26 (ref), u20 (copy), u15 (copy), u17 (copy)
        if u26 == "jumping" then
            u20:Stop(0);
            u15:Stop(0);
            u17:Play(0);
        end;
    end);
    u11.FreeFalling:Connect(function() --[[ Line: 151 ]]
        -- upvalues: u26 (ref), u17 (copy), u20 (copy)
        if u26 == "jumping" then
            u17:Stop(0);
            u20:Play(0.1);
        end;
    end);
    u11.StateChanged:Connect(function(_, p35) --[[ Line: 157 ]]
        -- upvalues: u26 (ref), u17 (copy), u20 (copy), u15 (copy)
        if u26 == "jumping" then
            if p35 == Enum.HumanoidStateType.Landed then
                u17:Stop(0);
                u20:Stop(0);
                u15:Play(0.1);
            end;
        end;
    end);
    local function v36() --[[ Line: 166 ]]
        -- upvalues: u26 (ref), u31 (copy), u15 (copy), u12 (copy), u11 (copy)
        u26 = "jumping";
        u31();
        u15:Play(0);
        for _ = 1, math.random(4, 10) do
            if not u12.Parent then
                return;
            end;
            u11.Jump = true;
            task.wait(math.random(8, 25) / 100);
        end;
        task.wait(0.3);
    end;
    local function v40() --[[ Line: 179 ]]
        -- upvalues: u26 (ref), u31 (copy), u12 (copy), u21 (copy), u29 (copy)
        u26 = "dance";
        u31();
        local v37 = math.random(6, 14);
        local v38 = 0;
        while v38 < v37 and u12.Parent do
            u31();
            u21[u29()]:Play(0.1);
            local v39 = math.random(20, 50) / 10;
            if v37 < v38 + v39 then
                v39 = v37 - v38;
            end;
            task.wait(v39);
            v38 = v38 + v39;
        end;
    end;
    local _ = "dance";
    u31();
    u21[u29()]:Play(0.1);
    task.wait(math.random(4, 8));
    while u12.Parent do
        v36();
        if not u12.Parent then
            break;
        end;
        v40();
        if not u12.Parent then
            break;
        end;
        task.wait(math.random(3, 10) / 10);
    end;
    u31();
end;
local function u42() --[[ Line: 212 ]]
    -- upvalues: l__TweenService__1 (copy), l__BottomBar__10 (copy), l__TopBar__11 (copy), l__Prizes__12 (copy)
    l__TweenService__1:Create(l__BottomBar__10, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 0)
    }):Play();
    l__TweenService__1:Create(l__TopBar__11, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 1)
    }):Play();
    l__TweenService__1:Create(l__Prizes__12, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(1, 0.5)
    }):Play();
end;
local function u43() --[[ Line: 219 ]]
    -- upvalues: l__TweenService__1 (copy), l__BottomBar__10 (copy), l__TopBar__11 (copy), l__Prizes__12 (copy)
    l__TweenService__1:Create(l__BottomBar__10, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 1)
    }):Play();
    l__TweenService__1:Create(l__TopBar__11, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 0)
    }):Play();
    l__TweenService__1:Create(l__Prizes__12, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 0.5)
    }):Play();
end;
function u1.Stop(p44) --[[ Line: 226 ]]
    -- upvalues: u8 (ref), u5 (copy), u42 (copy), u9 (ref), u6 (ref), u7 (ref)
    if u8 then
        u8(true);
        u8 = nil;
    end;
    if u5 then
        u5:Clean();
    end;
    if p44 then
        u42();
        if u9 then
            local l__CurrentCamera__14 = game.Workspace.CurrentCamera;
            l__CurrentCamera__14.CameraType = u9.CameraType;
            l__CurrentCamera__14.CameraSubject = u9.CameraSubject;
            l__CurrentCamera__14.FieldOfView = u9.FieldOfView;
            l__CurrentCamera__14.CFrame = u9.CFrame;
            u9 = nil;
        end;
        u6 = nil;
        u7 = nil;
    end;
end;
function u1.Start(_) --[[ Line: 261 ]] end;
function u1.Init(_) --[[ Line: 265 ]] end;
function u1.Inspect(p45, p46, p47) --[[ Line: 270 ]]
    -- upvalues: u7 (ref), u9 (ref), u1 (copy), l__FakePlot__13 (copy), u41 (copy), u5 (copy), l__GuiController__7 (copy), u6 (ref), l__LocalPlayer__8 (copy), l__StarterGui__2 (copy), u43 (copy), l__TopBar__11 (copy), l__DisplayPlantGrowthController__6 (copy), u8 (ref)
    local l__SeedName__15 = p45.SeedName;
    u7 = l__SeedName__15;
    if not u9 then
        local l__CurrentCamera__16 = game.Workspace.CurrentCamera;
        u9 = {
            CameraType = l__CurrentCamera__16.CameraType,
            CameraSubject = l__CurrentCamera__16.CameraSubject,
            FieldOfView = l__CurrentCamera__16.FieldOfView,
            CFrame = l__CurrentCamera__16.CFrame
        };
    end;
    u1.Stop(false);
    local v48 = p47 or {};
    local v49 = l__FakePlot__13:Clone();
    v49.Parent = game.Workspace;
    local l__Player__17 = v49:WaitForChild("Player");
    local l__Humanoid__18 = l__Player__17:WaitForChild("Humanoid");
    task.spawn(function() --[[ Line: 305 ]]
        -- upvalues: l__Player__17 (copy), u41 (ref), l__Humanoid__18 (copy)
        l__Player__17.HumanoidRootPart.Anchored = false;
        u41(l__Humanoid__18, l__Player__17);
    end);
    u5:Add(v49);
    l__GuiController__7:Close();
    if p46 then
        u6 = p46;
    end;
    local u50 = {};
    for _, v51 in l__LocalPlayer__8.PlayerGui:GetChildren() do
        if v51:IsA("ScreenGui") and v51.Name ~= "CinematicBars" then
            u50[v51] = v51.Enabled;
            v51.Enabled = false;
        end;
    end;
    l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
    l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
    u5:Add(function() --[[ Line: 338 ]]
        -- upvalues: l__StarterGui__2 (ref), u50 (copy)
        l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
        l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        for v52, v53 in u50 do
            if v52 then
                v52.Enabled = v53;
            end;
        end;
    end);
    u43();
    l__TopBar__11.NameLabel.Text = `{string.upper(l__SeedName__15)} SEED`;
    l__TopBar__11.NameLabel.TextLabel.Text = `{string.upper(l__SeedName__15)} SEED`;
    u5:Add(l__TopBar__11.ExitButton.Activated:Connect(function() --[[ Line: 356 ]]
        -- upvalues: u6 (ref), u1 (ref)
        local v54 = u6;
        u1.Stop(true);
        if v54 then
            v54();
        end;
    end));
    math.randomseed(os.clock() * 1000);
    u8 = l__DisplayPlantGrowthController__6.GrowPlant(l__SeedName__15, {
        duration = v48.duration or 10,
        fruitDuration = v48.fruitDuration or 30,
        idleDuration = v48.idleDuration or 10,
        startAge = v48.startAge or 0,
        endAge = v48.endAge or 75,
        intense = v48.intense or true,
        easingStyle = v48.easingStyle or Enum.EasingStyle.Quad,
        easingDirection = v48.easingDirection or Enum.EasingDirection.InOut,
        camera = game.Workspace.CurrentCamera,
        seed = v48.seed or math.random(0, 2147483647),
        position = v49.PrimaryPart.Position + Vector3.new(0, v49.PrimaryPart.Size.Y / 2, 0),
        parent = v49,
        onStep = v48.onStep,
        onComplete = v48.onComplete,
        onCancelled = v48.onCancelled
    });
end;
return u1;