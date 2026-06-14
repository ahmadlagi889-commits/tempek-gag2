-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__EggEffect__4 = require(script.EggEffect);
function v1.Init(_) --[[ Line: 10 ]] end;
function v1.Start(_) --[[ Line: 13 ]]
    -- upvalues: l__Networking__3 (copy), l__EggEffect__4 (copy), l__Players__1 (copy)
    l__Networking__3.Egg.ReplicateOpenEgg.OnClientEvent:Connect(function(u2, u3, u4, u5, p6, u7, u8) --[[ Line: 14 ]]
        -- upvalues: l__EggEffect__4 (ref), l__Players__1 (ref), l__Networking__3 (ref)
        if u2 and u2.Character then
            local v9 = u2.Character:FindFirstChild("HumanoidRootPart");
            if v9 and v9:IsA("BasePart") then
                local l__Position__5 = v9.Position;
                local u10 = CFrame.new(p6, p6 + CFrame.new(p6, l__Position__5).LookVector);
                if u7 == "" then
                    u7 = nil;
                end;
                if u8 == "" then
                    u8 = nil;
                end;
                task.spawn(function() --[[ Line: 29 ]]
                    -- upvalues: l__EggEffect__4 (ref), u3 (copy), u4 (copy), u5 (copy), l__Position__5 (copy), u10 (copy), u2 (copy), u7 (copy), u8 (copy), l__Players__1 (ref), l__Networking__3 (ref)
                    l__EggEffect__4.Open(u3, u4, u5, l__Position__5, u10, u2, u7, u8);
                    if u2 == l__Players__1.LocalPlayer then
                        l__Networking__3.Egg.ConfirmEgg:Fire(u3, u4, u5);
                    end;
                end);
            end;
        end;
    end);
end;
return v1;