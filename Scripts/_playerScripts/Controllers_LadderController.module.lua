-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
function v1.Init(_) --[[ Line: 11 ]] end;
function v1.Start(u2) --[[ Line: 14 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Character__5 = l__LocalPlayer__4.Character;
    if l__Character__5 then
        u2:SetupCharacter(l__Character__5);
    end;
    l__LocalPlayer__4.CharacterAdded:Connect(function(p3) --[[ Line: 19 ]]
        -- upvalues: u2 (copy)
        u2:SetupCharacter(p3);
    end);
end;
function v1.SetupCharacter(u4, p5) --[[ Line: 24 ]]
    p5.ChildAdded:Connect(function(u6) --[[ Name: tryConnect, Line 25 ]]
        -- upvalues: u4 (copy)
        if u6:IsA("Tool") and u6:GetAttribute("Ladder") then
            u6.Activated:Connect(function() --[[ Line: 27 ]]
                -- upvalues: u4 (ref), u6 (copy)
                u4:OnToolActivated(u6);
            end);
        end;
    end);
    for _, u7 in p5:GetChildren() do
        if u7:IsA("Tool") and u7:GetAttribute("Ladder") then
            u7.Activated:Connect(function() --[[ Line: 27 ]]
                -- upvalues: u4 (copy), u7 (copy)
                u4:OnToolActivated(u7);
            end);
        end;
    end;
end;
function v1.OnToolActivated(_, p8) --[[ Line: 39 ]]
    -- upvalues: l__LocalPlayer__4 (copy), l__Networking__3 (copy)
    local l__Character__6 = l__LocalPlayer__4.Character;
    if l__Character__6 then
        if p8.Parent == l__Character__6 then
            local v9 = p8:GetAttribute("CooldownEnd");
            if v9 and os.clock() < v9 then
            else
                local v10 = l__Character__6:FindFirstChild("HumanoidRootPart");
                if v10 then
                    local v11 = v10.Position + v10.CFrame.LookVector * 6;
                    local v12 = p8:GetAttribute("Ladder");
                    l__Networking__3.Place.PlaceLadder:Fire(v11, v12, p8);
                    p8:SetAttribute("CooldownEnd", os.clock() + 60);
                end;
            end;
        end;
    end;
end;
return v1;