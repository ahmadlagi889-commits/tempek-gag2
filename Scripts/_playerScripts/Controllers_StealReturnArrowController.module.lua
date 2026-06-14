-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__TutorialUtils__2 = require(script.Parent.TutorialController.TutorialUtils);
local u1 = assert(l__Players__1.LocalPlayer);
local l__Gardens__3 = workspace:WaitForChild("Gardens");
local v2 = {};
local u3 = nil;
local function u7() --[[ Line: 20 ]]
    -- upvalues: u1 (copy), l__Gardens__3 (copy)
    local v4 = u1:GetAttribute("PlotId");
    if v4 == nil then
        return nil;
    else
        local v5 = l__Gardens__3:FindFirstChild((`Plot{v4}`));
        if v5 then
            local v6 = v5:FindFirstChild("SpawnPoint");
            if v6 and v6:IsA("BasePart") then
                return v6;
            else
                return nil;
            end;
        else
            return nil;
        end;
    end;
end;
local function u10() --[[ Line: 36 ]]
    -- upvalues: u1 (copy), u3 (ref), u7 (copy), l__TutorialUtils__2 (copy)
    local v8 = u1:GetAttribute("CarryingStolenFruit") == true;
    if v8 and not u3 then
        local v9 = u7();
        if v9 then
            u3 = l__TutorialUtils__2.createArrow(u1, CFrame.new(v9.Position)).destroy;
        end;
    elseif not v8 and u3 then
        u3();
        u3 = nil;
    end;
end;
function v2.Start(_) --[[ Line: 50 ]]
    -- upvalues: u1 (copy), u10 (copy)
    u1:GetAttributeChangedSignal("CarryingStolenFruit"):Connect(u10);
    u10();
end;
return v2;