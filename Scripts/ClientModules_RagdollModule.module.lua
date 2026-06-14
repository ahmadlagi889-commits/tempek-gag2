-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Players__1 = game:GetService("Players");
local l__Networking__2 = require(game.ReplicatedStorage.SharedModules.Networking);
local u2 = {
    Neck = {
        CF = { CFrame.new(0, 1, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1), CFrame.new(0, -0.5, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1) }
    },
    HumanoidRootPart = {
        CF = { CFrame.new(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), CFrame.new(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) }
    },
    ["Right Shoulder"] = {
        CF = { CFrame.new(1.3, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), CFrame.new(-0.2, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) }
    },
    ["Left Shoulder"] = {
        CF = { CFrame.new(-1.3, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1), CFrame.new(0.2, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1) }
    },
    ["Right Hip"] = {
        CF = { CFrame.new(0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1) }
    },
    ["Left Hip"] = {
        CF = { CFrame.new(-0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1) }
    }
};
local function u6(p3, p4) --[[ Line: 26 ]]
    for _, v5 in pairs(p3.Torso:GetDescendants()) do
        if v5:IsA("Motor6D") then
            v5.Enabled = p4;
        end;
    end;
end;
local function u13(p7, p8) --[[ Line: 34 ]]
    if p8 then
        for _, v9 in pairs(p7:GetChildren()) do
            if v9:IsA("BasePart") and v9.Name ~= "HumanoidRootPart" then
                local v10 = v9:Clone();
                v10.Size = v9.Size * 0.75;
                v10.CanCollide = true;
                v10.Massless = true;
                v10.Name = "Collider";
                v10.Transparency = 1;
                v10.Parent = p7;
                local v11 = Instance.new("Weld");
                v11.Part0 = v9;
                v11.Part1 = v10;
                v11.Parent = v10;
            end;
        end;
    else
        for _, v12 in pairs(p7:GetChildren()) do
            if v12.Name == "Collider" then
                v12:Destroy();
            end;
        end;
    end;
end;
local function u22(p14, p15) --[[ Line: 61 ]]
    -- upvalues: u2 (copy)
    local v16 = p14:FindFirstChild("Torso");
    if p15 then
        for _, v17 in pairs(p14.Torso:GetChildren()) do
            if v17:IsA("Motor6D") then
                local v18 = Instance.new("Attachment");
                local v19 = Instance.new("Attachment");
                local v20 = Instance.new("BallSocketConstraint");
                v18.Name = "RagdollAttachment";
                v18.CFrame = u2[v17.Name].CF[2];
                v18.Parent = v17.Part1;
                v19.Name = "RagdollAttachment";
                v19.CFrame = u2[v17.Name].CF[1];
                v19.Parent = v16;
                v20.Name = "RagdollConstraint";
                v20.Attachment0 = v18;
                v20.Attachment1 = v19;
                v20.LimitsEnabled = true;
                v20.UpperAngle = 180;
                v20.TwistLimitsEnabled = true;
                v20.TwistLowerAngle = -90;
                v20.TwistUpperAngle = 90;
                v20.Parent = v16;
                v17.Part1.CollisionGroup = "Ragdoll";
            end;
        end;
    else
        for _, v21 in pairs(v16:GetChildren()) do
            if v21.Name == "RagdollConstraint" then
                v21.Attachment0:Destroy();
                v21.Attachment1:Destroy();
                v21:Destroy();
            elseif v21:IsA("Motor6D") then
                v21.Part1.CollisionGroup = "Default";
            end;
        end;
    end;
end;
function u1.Unragdoll(_, p23) --[[ Line: 107 ]]
    -- upvalues: l__Players__1 (copy), u6 (copy), u22 (copy)
    local v24 = p23:FindFirstChildWhichIsA("Humanoid");
    l__Players__1:GetPlayerFromCharacter(p23);
    if v24:GetState() == Enum.HumanoidStateType.Dead then
    elseif v24.RootPart then
        p23:SetAttribute("Ragdolled", nil);
        u6(p23, true);
        for _, v25 in pairs(p23:GetChildren()) do
            if v25.Name == "Collider" then
                v25:Destroy();
            end;
        end;
        u22(p23, false);
        v24.AutoRotate = true;
        v24.PlatformStand = false;
        v24:ChangeState(Enum.HumanoidStateType.GettingUp);
    end;
end;
function u1.Ragdoll(_, u26, p27) --[[ Line: 125 ]]
    -- upvalues: l__Players__1 (copy), u6 (copy), u13 (copy), u22 (copy), u1 (copy)
    local v28 = u26:FindFirstChildWhichIsA("Humanoid");
    l__Players__1:GetPlayerFromCharacter(u26);
    if v28 and v28.RootPart then
        if v28:GetState() == Enum.HumanoidStateType.Dead then
        elseif u26:GetAttribute("Ragdolled") then
        else
            u26:SetAttribute("Ragdolled", true);
            u6(u26, false);
            u13(u26, true);
            u22(u26, true);
            v28.AutoRotate = false;
            v28.PlatformStand = true;
            v28:ChangeState(Enum.HumanoidStateType.Physics);
            if p27 then
                task.delay(p27, function() --[[ Line: 152 ]]
                    -- upvalues: u1 (ref), u26 (copy)
                    u1:Unragdoll(u26);
                end);
            end;
        end;
    end;
end;
if game:GetService("RunService"):IsClient() then
    l__Networking__2.Ragdoll.Enable.OnClientEvent:Connect(function(p29) --[[ Line: 159 ]]
        -- upvalues: u1 (copy)
        u1:Ragdoll(game.Players.LocalPlayer.Character, p29);
    end);
    l__Networking__2.Ragdoll.Disable.OnClientEvent:Connect(function(_) --[[ Line: 164 ]]
        -- upvalues: u1 (copy)
        u1:Unragdoll(game.Players.LocalPlayer.Character);
    end);
    l__Networking__2.Ragdoll.EnableForRig.OnClientEvent:Connect(function(p30) --[[ Line: 169 ]]
        -- upvalues: u1 (copy)
        if p30 and p30:IsDescendantOf(workspace) then
            u1:Ragdoll(p30);
        end;
    end);
    l__Networking__2.Ragdoll.DisableForRig.OnClientEvent:Connect(function(p31) --[[ Line: 174 ]]
        -- upvalues: u1 (copy)
        if p31 then
            u1:Unragdoll(p31);
        end;
    end);
    l__Networking__2.Ragdoll.StartRagdoll.OnClientEvent:Connect(function(p32) --[[ Line: 180 ]]
        -- upvalues: u1 (copy)
        if p32 and p32:IsDescendantOf(workspace) then
            u1:Ragdoll(p32);
        end;
    end);
    l__Networking__2.Ragdoll.StopRagdoll.OnClientEvent:Connect(function(p33) --[[ Line: 185 ]]
        -- upvalues: u1 (copy)
        if p33 then
            u1:Unragdoll(p33);
        end;
    end);
end;
return u1;