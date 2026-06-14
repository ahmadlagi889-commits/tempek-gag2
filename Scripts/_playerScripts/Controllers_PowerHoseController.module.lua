-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
function v1.Init(_) --[[ Line: 9 ]] end;
function v1.Start(u2) --[[ Line: 12 ]]
    -- upvalues: l__LocalPlayer__4 (copy), l__Networking__3 (copy)
    local l__Character__5 = l__LocalPlayer__4.Character;
    if l__Character__5 then
        u2:SetupCharacter(l__Character__5);
    end;
    l__LocalPlayer__4.CharacterAdded:Connect(function(p3) --[[ Line: 17 ]]
        -- upvalues: u2 (copy)
        u2:SetupCharacter(p3);
    end);
    l__Networking__3.PowerHose.KnockbackFx.OnClientEvent:Connect(function(p4) --[[ Line: 21 ]]
        -- upvalues: u2 (copy)
        u2:PlayKnockbackFx(p4);
    end);
end;
function v1.SetupCharacter(u5, p6) --[[ Line: 26 ]]
    local u7 = {};
    local function v9(u8) --[[ Line: 29 ]]
        -- upvalues: u7 (copy), u5 (copy)
        if u8:IsA("Tool") and (u8:GetAttribute("PowerHose") and not u7[u8]) then
            u7[u8] = true;
            u8.Activated:Connect(function() --[[ Line: 32 ]]
                -- upvalues: u5 (ref), u8 (copy)
                u5:OnToolActivated(u8);
            end);
        end;
    end;
    p6.ChildAdded:Connect(v9);
    for _, v10 in p6:GetChildren() do
        v9(v10);
    end;
end;
function v1.OnToolActivated(_, p11) --[[ Line: 44 ]]
    -- upvalues: l__LocalPlayer__4 (copy), l__Networking__3 (copy)
    local l__Character__6 = l__LocalPlayer__4.Character;
    if l__Character__6 then
        if p11.Parent == l__Character__6 then
            local v12 = p11:GetAttribute("CooldownEnd");
            if v12 and os.clock() < v12 then
            else
                l__Networking__3.PowerHose.Activate:Fire(p11);
                local v13 = p11:GetAttribute("Cooldown") or 10;
                p11:SetAttribute("CooldownEnd", os.clock() + v13);
            end;
        end;
    end;
end;
function v1.PlayKnockbackFx(_, _) --[[ Line: 58 ]] end;
return v1;