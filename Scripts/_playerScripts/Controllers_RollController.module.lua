-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 6
};
local l__Players__1 = game:GetService("Players");
local l__SoundService__2 = game:GetService("SoundService");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__PropData__5 = require(l__ReplicatedStorage__4.SharedModules.PropData);
local l__FenceData__6 = require(l__ReplicatedStorage__4.SharedModules.FenceData);
local l__GuiController__7 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController);
local l__PlayerGui__8 = l__Players__1.LocalPlayer:WaitForChild("PlayerGui");
local l__Click__9 = l__SoundService__2.SFX.Click;
local l__RollFrame_New__10 = l__PlayerGui__8:WaitForChild("RollFrame_New");
local l__Spinner__11 = l__RollFrame_New__10:WaitForChild("Frame"):WaitForChild("Spinner");
local l__Template__12 = l__Spinner__11:WaitForChild("UIListLayout"):WaitForChild("Template");
local l__SkipButton__13 = l__RollFrame_New__10:WaitForChild("BlackBackdrop"):WaitForChild("SkipButton");
local u2 = {};
function v1.Init(_) --[[ Line: 24 ]]
    -- upvalues: l__Template__12 (copy), l__PropData__5 (copy), u2 (copy), l__FenceData__6 (copy)
    l__Template__12.Visible = false;
    for _, v3 in l__PropData__5.Data do
        u2[v3.PropName] = v3.IMG;
    end;
    for _, v4 in l__FenceData__6.Data do
        u2[v4.PropName] = v4.IMG;
    end;
end;
function v1.Start(_) --[[ Line: 36 ]] end;
function v1.GetImage(_, p5) --[[ Line: 39 ]]
    -- upvalues: u2 (copy)
    return u2[p5] or "";
end;
function v1.ReturnRandomItem(_, p6) --[[ Line: 43 ]]
    local v7 = 0;
    for _, v8 in pairs(p6) do
        v7 = v7 + v8.Chance;
    end;
    local v9 = math.random() * v7;
    local v10 = 0;
    for _, v11 in pairs(p6) do
        v10 = v10 + v11.Chance;
        if v9 <= v10 then
            return v11;
        end;
    end;
    return p6[#p6];
end;
function v1.ClearSpinnerFrames(_) --[[ Line: 59 ]]
    -- upvalues: l__Spinner__11 (copy)
    for _, v12 in pairs(l__Spinner__11:GetChildren()) do
        if v12:IsA("Frame") and v12.Name ~= "Template" then
            v12:Destroy();
        end;
    end;
end;
function v1.MakeFrame(p13, p14, p15) --[[ Line: 67 ]]
    -- upvalues: l__Template__12 (copy), l__Spinner__11 (copy)
    local v16 = l__Template__12:Clone();
    local v17 = p14.Image or p13:GetImage(p14.Name);
    v16.Image.Image = v17;
    v16.ItemName.Text = p14.Name;
    v16.Name = "SpinnerFrame";
    v16.LayoutOrder = p15;
    v16.Visible = true;
    v16.Parent = l__Spinner__11;
    return v16;
end;
function v1.Roll(p18, p19, p20) --[[ Line: 79 ]]
    -- upvalues: l__GuiController__7 (copy), l__Spinner__11 (copy), l__Click__9 (copy), l__TweenService__3 (copy), l__SkipButton__13 (copy)
    l__GuiController__7:Open("RollFrame_New");
    p18:ClearSpinnerFrames();
    local v21 = p20 or p18:ReturnRandomItem(p19);
    l__Spinner__11.Position = UDim2.new(0.5, 0, 0.5, 0);
    local v22 = {};
    for v23 = 1, 60 do
        v22[v23] = p18:MakeFrame(v23 == 50 and v21 and v21 or p18:ReturnRandomItem(p19), v23);
    end;
    task.wait();
    local v24 = v22[1];
    local l__X__14 = v24.AbsoluteSize.X;
    local u25;
    if v22[2] then
        u25 = v22[2].AbsolutePosition.X - v24.AbsolutePosition.X;
    else
        u25 = l__X__14;
    end;
    local u26 = v24.AbsolutePosition.X + l__X__14 / 2 - (l__Spinner__11.AbsolutePosition.X + l__Spinner__11.AbsoluteSize.X / 2);
    local u27 = Instance.new("NumberValue");
    u27.Value = 0;
    local u28 = 0;
    local v31 = u27.Changed:Connect(function(p29) --[[ Line: 110 ]]
        -- upvalues: u26 (copy), u25 (copy), l__Spinner__11 (ref), u28 (ref), l__Click__9 (ref)
        l__Spinner__11.Position = UDim2.new(0.5, -(u26 + p29 * u25), 0.5, 0);
        local v30 = math.floor(p29 + 0.5);
        if u28 < v30 then
            u28 = v30;
            l__Click__9:Play();
        end;
    end);
    local u32 = l__TweenService__3:Create(u27, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Value = 49
    });
    local u33 = coroutine.running();
    local u34 = false;
    local function v35() --[[ Line: 127 ]]
        -- upvalues: u34 (ref), u32 (copy), u27 (copy), u26 (copy), u25 (copy), l__Spinner__11 (ref), u33 (copy)
        if u34 then
        else
            u34 = true;
            u32:Cancel();
            u27.Value = 49;
            l__Spinner__11.Position = UDim2.new(0.5, -(u26 + 49 * u25), 0.5, 0);
            task.spawn(u33);
        end;
    end;
    local v36 = l__SkipButton__13.Activated:Once(v35);
    local v37 = u32.Completed:Once(v35);
    u32:Play();
    coroutine.yield();
    if v36 then
        v36:Disconnect();
    end;
    if v37 then
        v37:Disconnect();
    end;
    v31:Disconnect();
    u27:Destroy();
    task.wait(1);
    l__GuiController__7:Close();
    return v21;
end;
return v1;