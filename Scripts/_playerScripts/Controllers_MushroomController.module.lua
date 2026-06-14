-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Networking__1 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__TweenService__3 = game:GetService("TweenService");
local u2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
function u1.Init(_) --[[ Line: 7 ]]
    -- upvalues: l__Networking__1 (copy), u1 (copy), l__LocalPlayer__2 (copy)
    l__Networking__1.Mushrooms.SetInvisiblity.OnClientEvent:Connect(function(p3) --[[ Line: 8 ]]
        -- upvalues: u1 (ref), l__LocalPlayer__2 (ref)
        u1:SetInvisible(l__LocalPlayer__2.Character, p3);
    end);
    l__Networking__1.Mushrooms.PlayFX.OnClientEvent:Connect(function(p4) --[[ Line: 11 ]]
        -- upvalues: u1 (ref), l__LocalPlayer__2 (ref)
        u1:PlayFX(l__LocalPlayer__2.Character, p4);
    end);
end;
function u1.PlayFX(_, p5, p6) --[[ Line: 16 ]]
    -- upvalues: l__TweenService__3 (copy), u2 (copy)
    local v7 = Instance.new("Highlight");
    v7.FillColor = p6;
    v7.Parent = p5;
    v7.FillTransparency = 0;
    v7.OutlineTransparency = 1;
    v7:SetAttribute("InvisiblityHighlight", true);
    v7.Adornee = p5;
    local v8 = l__TweenService__3:Create(v7, u2, {
        FillTransparency = 1
    });
    v8:Play();
    game.Debris:AddItem(v8, u2.Time);
    game.Debris:AddItem(v7, u2.Time);
end;
function u1.SetInvisible(_, p9, p10) --[[ Line: 31 ]]
    if p10 == true then
        local v11 = Instance.new("Highlight");
        v11.Parent = p9;
        v11.FillTransparency = 0.5;
        v11.OutlineTransparency = 0.9967;
        v11.FillColor = Color3.new(1, 1, 1);
        v11:SetAttribute("InvisiblityHighlight", true);
        v11.Adornee = p9;
    else
        for _, v12 in p9:GetChildren() do
            if v12:IsA("Highlight") and v12:GetAttribute("InvisiblityHighlight") then
                v12:Destroy();
            end;
        end;
    end;
end;
return u1;