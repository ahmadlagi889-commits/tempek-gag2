-- Decompiled with Potassium's decompiler.

local l__CommonUtils__1 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__FlagUtil__2 = require(l__CommonUtils__1:WaitForChild("FlagUtil"));
local l__ZoomController__3 = require(script.Parent:WaitForChild("ZoomController"));
local u1 = l__FlagUtil__2.getUserFlag("UserFixCameraFPError");
local u2 = {};
u2.__index = u2;
local u3 = CFrame.new();
function u2.new() --[[ Line: 35 ]]
    -- upvalues: u2 (copy)
    return setmetatable({
        lastCFrame = nil
    }, u2);
end;
function u2.Step(p4, p5, p6) --[[ Line: 41 ]]
    -- upvalues: u3 (copy)
    local v7 = p4.lastCFrame or p6;
    p4.lastCFrame = p6;
    local l__Position__4 = p6.Position;
    local _, _, _, v8, v9, v10, v11, v12, v13, v14, v15, v16 = p6:GetComponents();
    local u17 = CFrame.new(0, 0, 0, v8, v9, v10, v11, v12, v13, v14, v15, v16);
    local l__p__5 = v7.p;
    local _, _, _, v18, v19, v20, v21, v22, v23, v24, v25, v26 = v7:GetComponents();
    local v27 = CFrame.new(0, 0, 0, v18, v19, v20, v21, v22, v23, v24, v25, v26);
    local u28 = (l__Position__4 - l__p__5) / p5;
    local v29, v30 = (u17 * v27:inverse()):ToAxisAngle();
    local u31 = v29 * v30 / p5;
    return {
        extrapolate = function(p32) --[[ Name: extrapolate, Line 56 ]]
            -- upvalues: u28 (copy), l__Position__4 (copy), u31 (copy), u3 (ref), u17 (copy)
            local v33 = u28 * p32 + l__Position__4;
            local v34 = u31 * p32;
            local l__Magnitude__6 = v34.Magnitude;
            local v35;
            if l__Magnitude__6 > 0.00001 then
                v35 = CFrame.fromAxisAngle(v34, l__Magnitude__6);
            else
                v35 = u3;
            end;
            return v35 * u17 + v33;
        end,
        posVelocity = u28,
        rotVelocity = u31
    };
end;
function u2.Reset(p36) --[[ Line: 69 ]]
    p36.lastCFrame = nil;
end;
local l__BaseOcclusion__7 = require(script.Parent:WaitForChild("BaseOcclusion"));
local u37 = setmetatable({}, l__BaseOcclusion__7);
u37.__index = u37;
function u37.new() --[[ Line: 79 ]]
    -- upvalues: l__BaseOcclusion__7 (copy), u37 (copy), u2 (copy)
    local v38 = l__BaseOcclusion__7.new();
    local v39 = setmetatable(v38, u37);
    v39.focusExtrapolator = u2.new();
    return v39;
end;
function u37.GetOcclusionMode(_) --[[ Line: 85 ]]
    return Enum.DevCameraOcclusionMode.Zoom;
end;
function u37.Enable(p40, _) --[[ Line: 89 ]]
    p40.focusExtrapolator:Reset();
end;
function u37.Update(p41, p42, p43, p44, _) --[[ Line: 93 ]]
    -- upvalues: u1 (copy), l__ZoomController__3 (copy)
    local v45;
    if u1 then
        v45 = CFrame.lookAlong(p44.p, -p43.LookVector) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1);
    else
        v45 = CFrame.new(p44.p, p43.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1);
    end;
    local v46 = p41.focusExtrapolator:Step(p42, v45);
    local v47 = l__ZoomController__3.Update(p42, v45, v46);
    return v45 * CFrame.new(0, 0, v47), p44;
end;
function u37.CharacterAdded(_, _, _) --[[ Line: 117 ]] end;
function u37.CharacterRemoving(_, _, _) --[[ Line: 121 ]] end;
function u37.OnCameraSubjectChanged(_, _) --[[ Line: 124 ]] end;
return u37;