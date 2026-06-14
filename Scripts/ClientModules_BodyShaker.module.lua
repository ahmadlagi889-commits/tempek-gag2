-- Decompiled with Potassium's decompiler.

local v1 = {};
local _ = game.Players.LocalPlayer;
local u2 = {};
local function u14(p3) --[[ Line: 8 ]]
    -- upvalues: u2 (copy)
    repeat
        task.wait();
    until p3:IsDescendantOf(workspace);
    if p3:GetAttribute("Shaking") then
    else
        p3:SetAttribute("Shaking", true);
        local l__Torso__1 = p3:WaitForChild("Torso");
        local l__Neck__2 = l__Torso__1:WaitForChild("Neck");
        local v4 = l__Torso__1:WaitForChild("Left Shoulder");
        local v5 = l__Torso__1:WaitForChild("Right Shoulder");
        local v6 = l__Torso__1:WaitForChild("Left Hip");
        local v7 = l__Torso__1:WaitForChild("Right Hip");
        local l__C0__3 = v4.C0;
        local l__C0__4 = v5.C0;
        local l__C0__5 = v6.C0;
        local l__C0__6 = v7.C0;
        local l__C0__7 = l__Neck__2.C0;
        local v8 = 0;
        while p3:IsDescendantOf(workspace) and u2[p3] do
            task.wait(0);
            v8 = v8 + 1;
            local l__Angles__8 = CFrame.Angles;
            local v9 = math.sin(v8) * 4;
            v4.C0 = l__C0__3 * l__Angles__8(0, math.rad(v9), 0);
            local l__Angles__9 = CFrame.Angles;
            local v10 = math.sin(v8) * -4;
            v5.C0 = l__C0__4 * l__Angles__9(0, math.rad(v10), 0);
            local l__Angles__10 = CFrame.Angles;
            local v11 = math.sin(v8) * -4;
            v7.C0 = l__C0__6 * l__Angles__10(0, math.rad(v11), 0);
            local l__Angles__11 = CFrame.Angles;
            local v12 = math.sin(v8) * 4;
            v6.C0 = l__C0__5 * l__Angles__11(0, math.rad(v12), 0);
            local l__Angles__12 = CFrame.Angles;
            local v13 = math.sin(v8) * 4;
            l__Neck__2.C0 = l__C0__7 * l__Angles__12(0, 0, (math.rad(v13)));
        end;
        v4.C0 = l__C0__3;
        v5.C0 = l__C0__4;
        v6.C0 = l__C0__5;
        v7.C0 = l__C0__6;
        l__Neck__2.C0 = l__C0__7;
        p3:SetAttribute("Shaking", false);
    end;
end;
function v1.EnableShaking(u15) --[[ Line: 62 ]]
    -- upvalues: u14 (copy), u2 (copy)
    if u15 then
        task.spawn(function() --[[ Line: 64 ]]
            -- upvalues: u14 (ref), u15 (copy)
            u14(u15);
        end);
    end;
    u2[u15] = true;
end;
function v1.DisableShaking(p16) --[[ Line: 72 ]]
    -- upvalues: u2 (copy)
    u2[p16] = false;
end;
return v1;