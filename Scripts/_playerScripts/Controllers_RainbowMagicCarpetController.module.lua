-- Decompiled with Potassium's decompiler.

local u1 = {
    StartOrder = 6
};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local l__CurrentCamera__4 = workspace.CurrentCamera;
local l__Networking__5 = require(game.ReplicatedStorage.SharedModules.Networking);
local u2 = {};
local u3 = {};
local u4 = false;
local u5 = false;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local function u13() --[[ Line: 57 ]]
    -- upvalues: u8 (ref)
    if u8 and u8.Parent then
        for _, v11 in { "FlightSpin", "FlightPower", "FlightHold" } do
            local v12 = u8:FindFirstChild(v11);
            if v12 then
                v12:Destroy();
            end;
        end;
    end;
end;
local function u17() --[[ Line: 66 ]]
    -- upvalues: u2 (ref), u3 (copy)
    for _, v14 in u2 do
        if v14.AnimationTrack then
            v14.AnimationTrack:Stop();
        end;
    end;
    u2 = {};
    for v15, u16 in u3 do
        pcall(function() --[[ Line: 76 ]]
            -- upvalues: u16 (copy)
            u16:Destroy();
        end);
        u3[v15] = nil;
    end;
end;
local function u29() --[[ Line: 81 ]]
    -- upvalues: u6 (ref), u7 (ref), u8 (ref), u10 (ref), u4 (ref), u9 (ref), u5 (ref), l__CurrentCamera__4 (copy)
    local v18 = u6 and u6.Parent and (u7 and u7.Parent);
    if v18 then
        if u7.Health > 0 then
            v18 = u8;
            if v18 then
                v18 = u8.Parent;
            end;
        else
            v18 = false;
        end;
    end;
    if v18 then
        if u10 then
            u10:Disconnect();
        end;
        u10 = u8.ChildAdded:Connect(function(p19) --[[ Line: 88 ]]
            -- upvalues: u4 (ref), u8 (ref), u7 (ref), u9 (ref), u5 (ref), u6 (ref), l__CurrentCamera__4 (ref)
            if u4 then
                return;
            end;
            if p19.Name ~= "FlightHold" then
                return;
            end;
            local v20 = u8:FindFirstChild("FlightSpin");
            local v21 = u8:FindFirstChild("FlightPower");
            local v22 = u8:FindFirstChild("FlightHold");
            if not (v20 and (v21 and v22)) then
                return;
            end;
            u4 = true;
            u7.PlatformStand = true;
            u7.AutoRotate = false;
            if u9 then
                u9:Disconnect();
                u9 = nil;
            end;
            if u7 then
                u9 = u7:GetPropertyChangedSignal("Jump"):Connect(function() --[[ Line: 42 ]]
                    -- upvalues: u7 (ref)
                    u7.Jump = false;
                end);
            end;
            u8.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            u8.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
            while u4 and (u5 and (v20.Parent and (v21.Parent and v22.Parent))) do
                local v23 = u6 and u6.Parent and (u7 and u7.Parent);
                if v23 then
                    if u7.Health > 0 then
                        v23 = u8;
                        if v23 then
                            v23 = u8.Parent;
                        end;
                    else
                        v23 = false;
                    end;
                end;
                if not v23 then
                    break;
                end;
                local v24 = l__CurrentCamera__4.CFrame:VectorToWorldSpace(Vector3.new(0, 0, -1));
                local v25 = l__CurrentCamera__4.CFrame:VectorToWorldSpace(Vector3.new(-1, 0, 0));
                local v26 = CFrame.new(Vector3.new(0, 0, 0), l__CurrentCamera__4.CFrame.LookVector * Vector3.new(1, 0, 1)):VectorToObjectSpace(u7.MoveDirection);
                local v27 = v24 * 90 * -v26.Z + v25 * 60 * -v26.X;
                v20.CFrame = CFrame.new(Vector3.new(0, 0, 0), v24);
                if v27.Magnitude < 1 then
                    v22.MaxForce = Vector3.new(1, 1, 1) * v22.P;
                    v21.MaxForce = Vector3.new(0, 0, 0);
                    v22.Position = u8.Position;
                else
                    v22.MaxForce = Vector3.new(0, 0, 0);
                    v21.MaxForce = Vector3.new(1, 1, 1) * v21.P * 100;
                end;
                v21.Velocity = v27;
                task.wait(0.016666666666666666);
            end;
            u4 = false;
            local v28 = u6 and u6.Parent and (u7 and u7.Parent);
            if v28 then
                if u7.Health > 0 then
                    v28 = u8;
                    if v28 then
                        v28 = u8.Parent;
                    end;
                else
                    v28 = false;
                end;
            end;
            if v28 then
                u8.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                u8.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                if u7 then
                    u7.PlatformStand = false;
                    u7.AutoRotate = true;
                    if u9 then
                        u9:Disconnect();
                        u9 = nil;
                    end;
                end;
                u7:ChangeState(Enum.HumanoidStateType.Freefall);
            end;
        end);
    end;
end;
function u1.Init(_) --[[ Line: 141 ]] end;
function u1.Equip(_) --[[ Line: 144 ]]
    -- upvalues: u5 (ref), u6 (ref), l__LocalPlayer__3 (copy), u7 (ref), u8 (ref), u9 (ref), u29 (copy)
    if u5 then
    else
        u6 = l__LocalPlayer__3.Character;
        if u6 then
            u7 = u6:FindFirstChildOfClass("Humanoid");
            u8 = u6:FindFirstChild("HumanoidRootPart");
            u5 = true;
            local v30 = u6 and u6.Parent and (u7 and u7.Parent);
            if v30 then
                if u7.Health > 0 then
                    v30 = u8;
                    if v30 then
                        v30 = u8.Parent;
                    end;
                else
                    v30 = false;
                end;
            end;
            if v30 then
                if u7 then
                    u7.PlatformStand = false;
                    u7.AutoRotate = true;
                    if u9 then
                        u9:Disconnect();
                        u9 = nil;
                    end;
                end;
                if u8 then
                    u8.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                    u8.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                end;
                task.spawn(u29);
            else
                u5 = false;
            end;
        end;
    end;
end;
function u1.Unequip(_) --[[ Line: 170 ]]
    -- upvalues: u5 (ref), u4 (ref), u17 (copy), u10 (ref), u7 (ref), u9 (ref), u13 (copy)
    if u5 then
        u4 = false;
        u5 = false;
        u17();
        if u10 then
            u10:Disconnect();
            u10 = nil;
        end;
        if u7 then
            u7.PlatformStand = false;
            u7.AutoRotate = true;
            if u9 then
                u9:Disconnect();
                u9 = nil;
            end;
        end;
        u13();
    end;
end;
l__Networking__5.Carpet.Equip.OnClientEvent:Connect(function() --[[ Line: 187 ]]
    -- upvalues: u1 (copy)
    u1:Equip();
end);
l__Networking__5.Carpet.Unequip.OnClientEvent:Connect(function() --[[ Line: 191 ]]
    -- upvalues: u1 (copy)
    u1:Unequip();
end);
l__Networking__5.Carpet.PlayAnimation.OnClientEvent:Connect(function(p31) --[[ Line: 195 ]]
    -- upvalues: u5 (ref), u7 (ref), u3 (copy), u2 (ref)
    if u5 and u7 then
        local v32 = game.ReplicatedStorage.Assets:FindFirstChild(p31, true);
        if v32 then
            local v33 = u7:FindFirstChildOfClass("Animator") or u7:WaitForChild("Animator", 5);
            if v33 then
                local v34 = u3[v32];
                if v34 then
                    v34:Stop();
                else
                    v34 = v33:LoadAnimation(v32);
                    u3[v32] = v34;
                end;
                for v35 = #u2, 1, -1 do
                    if u2[v35].Animation == v32 then
                        table.remove(u2, v35);
                    end;
                end;
                table.insert(u2, {
                    Animation = v32,
                    AnimationTrack = v34
                });
                v34:Play();
            end;
        end;
    end;
end);
l__Networking__5.Carpet.StopAnimation.OnClientEvent:Connect(function(p36) --[[ Line: 224 ]]
    -- upvalues: u2 (ref)
    for v37 = #u2, 1, -1 do
        if u2[v37].Animation.Name == p36 then
            u2[v37].AnimationTrack:Stop();
            table.remove(u2, v37);
        end;
    end;
end);
l__Networking__5.Carpet.Activated.OnClientEvent:Connect(function(p38) --[[ Line: 233 ]]
    -- upvalues: u5 (ref), u4 (ref), u13 (copy), u7 (ref), u9 (ref), u6 (ref), u8 (ref)
    if u5 then
        if not p38 then
            u4 = false;
            u13();
            if u7 then
                u7.PlatformStand = false;
                u7.AutoRotate = true;
                if u9 then
                    u9:Disconnect();
                    u9 = nil;
                end;
            end;
            local v39 = u6 and u6.Parent and (u7 and u7.Parent);
            if v39 then
                if u7.Health > 0 then
                    v39 = u8;
                    if v39 then
                        v39 = u8.Parent;
                    end;
                else
                    v39 = false;
                end;
            end;
            if v39 then
                u7:ChangeState(Enum.HumanoidStateType.Freefall);
            end;
        end;
    end;
end);
local function v58(p40) --[[ Line: 253 ]]
    -- upvalues: l__RunService__2 (copy)
    local l__Value__6 = p40.TargetFloat.Value;
    local l__HumanoidRootPart__7 = l__Value__6:WaitForChild("HumanoidRootPart");
    local l__RootJoint__8 = l__HumanoidRootPart__7:WaitForChild("RootJoint");
    local u41 = {};
    for _, v42 in p40.Carpet:GetChildren() do
        if v42:IsA("Bone") then
            u41[v42] = v42.CFrame;
        end;
    end;
    local function u50(p43, p44) --[[ Line: 267 ]]
        -- upvalues: u41 (copy)
        for v45, v46 in u41 do
            local l__X__9 = v46.Position.X;
            local v47 = p44 * math.sin(1.0471975511965976 * l__X__9 + p43);
            local v48 = p44 * 1.0471975511965976 * math.cos(1.0471975511965976 * l__X__9 + p43);
            local v49 = math.atan(v48);
            v45.CFrame = v46 * CFrame.new(0, v47, 0) * CFrame.Angles(0, 0, v49);
        end;
    end;
    local l__X__10 = p40.Carpet:WaitForChild("Bone_04").CFrame.Position.X;
    local l__C0__11 = l__RootJoint__8.C0;
    local l__Name__12 = l__Value__6.Name;
    local u51 = 0;
    local u52 = 0;
    l__RunService__2:BindToRenderStep("CarpetSway" .. l__Name__12, Enum.RenderPriority.Character.Value + 1, function(p53) --[[ Line: 285 ]]
        -- upvalues: l__HumanoidRootPart__7 (copy), u52 (ref), u51 (ref), u50 (copy), l__X__10 (copy), l__RootJoint__8 (copy), l__C0__11 (copy)
        u52 = u52 + ((l__HumanoidRootPart__7.AssemblyLinearVelocity.Magnitude > 1 and 1 or 0) - u52) * math.min(p53 * 4, 1);
        local v54 = u52 * 0.3 + 0.2;
        u51 = u51 + (u52 * 3 + 1) * p53;
        u50(u51, v54);
        local v55 = v54 * math.sin(1.0471975511965976 * l__X__10 + u51);
        local v56 = v54 * 1.0471975511965976 * math.cos(1.0471975511965976 * l__X__10 + u51);
        local v57 = math.atan(v56);
        l__RootJoint__8.C0 = l__C0__11 * CFrame.new(0, 0.5, v55 + 0.1) * CFrame.Angles(-v57, 0, 0);
    end);
    repeat
        task.wait();
    until not (game.CollectionService:HasTag(p40, "RainbowCarpet") and p40:IsDescendantOf(workspace));
    l__RunService__2:UnbindFromRenderStep("CarpetSway" .. l__Name__12);
    l__RootJoint__8.C0 = l__C0__11;
end;
game.CollectionService:GetInstanceRemovedSignal("RainbowCarpet"):Connect(function(_) --[[ Line: 309 ]] end);
game.CollectionService:GetInstanceAddedSignal("RainbowCarpet"):Connect(v58);
for _, v59 in game.CollectionService:GetTagged("RainbowCarpet") do
    v58(v59);
end;
return u1;