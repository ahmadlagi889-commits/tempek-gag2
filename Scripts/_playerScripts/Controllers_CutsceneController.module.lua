-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__ContentProvider__1 = game:GetService("ContentProvider");
local l__RunService__2 = game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
local l__Networking__4 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__LocalPlayer__5 = l__Players__3.LocalPlayer;
local u2 = false;
local u3 = {};
local u4 = {};
local u5 = {};
function lerp(p6, p7, p8)
    return p6 + (p7 - p6) * p8;
end;
local function u12() --[[ Line: 22 ]]
    -- upvalues: u4 (ref), u5 (ref)
    for _, v9 in u4 do
        v9:Destroy();
    end;
    u4 = {};
    for v10, v11 in u5 do
        v10.Enabled = v11;
    end;
    u5 = {};
end;
function u1.Play(u13) --[[ Line: 37 ]]
    -- upvalues: l__ContentProvider__1 (copy), u12 (copy), u4 (ref), l__LocalPlayer__5 (copy), u5 (ref), u3 (copy), u2 (ref), l__RunService__2 (copy)
    local l__Animations__6 = require(u13.Animations);
    local l__Markers__7 = require(u13.Markers);
    local l__FoV__8 = require(u13.FoV);
    local v14 = {};
    local v15 = {};
    for v16, v17 in l__Animations__6 do
        if u13.Rigs:FindFirstChild(v16) then
            local v18 = Instance.new("Animation");
            v18.AnimationId = v17;
            v14[v16] = v18;
            table.insert(v15, v18);
        end;
    end;
    l__ContentProvider__1:PreloadAsync(v15);
    repeat
        task.wait(0.25);
    until l__ContentProvider__1.RequestQueueSize == 0;
    u12();
    table.insert(u4, u13);
    for _, v19 in l__LocalPlayer__5.PlayerGui:GetChildren() do
        if v19:IsA("ScreenGui") or v19:IsA("BillboardGui") then
            u5[v19] = v19.Enabled;
            v19.Enabled = false;
        end;
    end;
    for v20, v21 in v14 do
        local v22 = u13.Rigs:FindFirstChild(v20);
        if v22 then
            local v23 = v22:FindFirstChildOfClass("AnimationController") or v22:FindFirstChildOfClass("Humanoid");
            if v23 then
                u3[v20] = v23:LoadAnimation(v21);
                if v20 == "Camera" then
                    for v24, u25 in l__Markers__7 do
                        u3.Camera:GetMarkerReachedSignal(v24):Connect(function() --[[ Line: 94 ]]
                            -- upvalues: u25 (copy), u13 (copy), u3 (ref)
                            u25(u13, u3);
                        end);
                    end;
                end;
            end;
        end;
    end;
    u3.Camera.Stopped:Once(function() --[[ Name: EndCutscene, Line 102 ]]
        -- upvalues: u2 (ref), l__Markers__7 (copy), u13 (copy), u3 (ref), u12 (ref)
        if u2 then
            l__Markers__7.EndState(u13);
        end;
        u2 = false;
        for _, v26 in u3 do
            v26:Stop(0);
            v26:Destroy();
        end;
        u12();
    end);
    for _, v27 in u3 do
        v27.Looped = false;
        v27.Priority = Enum.AnimationPriority.Action4;
        v27:Play(0);
    end;
    u2 = true;
    local l__Value__9 = u13.DefaultCamera.Value;
    local l__CurrentCamera__10 = workspace.CurrentCamera;
    l__CurrentCamera__10.CameraType = Enum.CameraType.Scriptable;
    l__CurrentCamera__10.CameraSubject = l__Value__9;
    local u28 = 0;
    if l__LocalPlayer__5.Character then
        l__LocalPlayer__5.Character.Humanoid.AutoRotate = false;
    end;
    game:GetService("StarterGui"):SetCore("ResetButtonCallback", false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
    local function u29() --[[ Line: 141 ]]
        -- upvalues: l__RunService__2 (ref), l__LocalPlayer__5 (ref), l__CurrentCamera__10 (copy)
        l__RunService__2:UnbindFromRenderStep("Cutscene_Track");
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        game:GetService("StarterGui"):SetCore("ResetButtonCallback", true);
        if l__LocalPlayer__5.Character then
            l__LocalPlayer__5.Character.Humanoid.AutoRotate = true;
        end;
        l__CurrentCamera__10.CameraType = Enum.CameraType.Custom;
        l__CurrentCamera__10.FieldOfView = 70;
        l__CurrentCamera__10.CameraSubject = l__LocalPlayer__5.Character.Humanoid;
    end;
    local u30 = l__FoV__8[1];
    l__CurrentCamera__10.FieldOfView = u30;
    l__RunService__2:BindToRenderStep("Cutscene_Track", Enum.RenderPriority.Camera.Value - 1, function(p31) --[[ Line: 158 ]]
        -- upvalues: u2 (ref), u29 (copy), l__CurrentCamera__10 (copy), l__Value__9 (copy), u28 (ref), l__FoV__8 (copy), u30 (ref)
        if not u2 then
            return u29();
        end;
        l__CurrentCamera__10.CFrame = l__Value__9.CFrame;
        l__CurrentCamera__10.Focus = l__CurrentCamera__10.CFrame * CFrame.new(0, 0, -5);
        u28 = u28 + p31 * 24;
        if l__FoV__8[math.ceil(u28)] and math.ceil(u28) < #l__FoV__8 then
            local v32 = l__FoV__8[math.ceil(u28)];
            l__CurrentCamera__10.FieldOfView = u30;
            u30 = lerp(u30, v32, p31 * 11);
        end;
    end);
    task.spawn(function() --[[ Line: 177 ]]
        -- upvalues: u2 (ref), u12 (ref)
        repeat
            task.wait(0.025);
        until u2 == false;
        u12();
    end);
end;
function u1.Preload(p33, u34) --[[ Line: 187 ]]
    -- upvalues: l__ContentProvider__1 (copy)
    local u35 = {};
    for v36, v37 in require(p33.Animations) do
        if p33.Rigs:FindFirstChild(v36) then
            local v38 = Instance.new("Animation");
            v38.AnimationId = v37;
            table.insert(u35, v38);
        end;
    end;
    for _, v39 in p33:GetDescendants() do
        if v39:HasTag("Preload") then
            table.insert(u35, v39);
        end;
    end;
    task.spawn(function() --[[ Line: 207 ]]
        -- upvalues: u35 (copy), u34 (copy), l__ContentProvider__1 (ref)
        for v40 = 1, #u35 do
            local v41 = u34 / #u35;
            l__ContentProvider__1:PreloadAsync({ u35[v40] });
            task.wait(v41 + Random.new():NextNumber());
        end;
    end);
end;
function u1.IsPlaying() --[[ Line: 216 ]]
    -- upvalues: u2 (ref)
    return u2;
end;
function u1.Stop() --[[ Line: 220 ]]
    -- upvalues: u2 (ref)
    u2 = false;
end;
l__Networking__4.PlayCutscene.OnClientEvent:Connect(function(p42) --[[ Line: 224 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__5 (copy)
    local v43 = game.ReplicatedStorage.Assets.Cutscenes:FindFirstChild(p42);
    if v43 then
        if u1.IsPlaying() then
        else
            l__LocalPlayer__5:RequestStreamAroundAsync(v43:GetPivot().p);
            local v44 = v43:Clone();
            v44.Parent = workspace;
            u1.Play(v44);
        end;
    end;
end);
return u1;