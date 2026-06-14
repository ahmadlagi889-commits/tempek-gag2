-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local u1 = {};
local u2 = {};
function u1.new(p3, p4) --[[ Line: 22 ]]
    -- upvalues: u2 (copy)
    local v5 = {
        Tension = p4 or 0.5,
        Points = {},
        LengthIterations = 1000,
        LengthIndices = {},
        Length = 0,
        ConnectedSplines = {},
        _connections = {}
    };
    if p3 ~= nil then
        for _, v6 in pairs(p3) do
            u2.AddPoint(v5, v6);
        end;
    end;
    setmetatable(v5, {
        __index = u2,
        __newindex = function(_, _, _) --[[ Name: __newindex, Line 44 ]]
            error("Cannot add new indices to CatmullRomSplineObject!");
        end
    });
    return v5;
end;
function u2.ChangeTension(p7, p8) --[[ Line: 57 ]]
    -- upvalues: u2 (copy)
    if type(p8) ~= "number" then
        error("CatmullRomSpline:ChangeTension() expected a number as an input, got " .. tostring(p8) .. "!");
    end;
    p7.Tension = p8;
    u2.UpdateLength(p7);
end;
function u2.ChangeAllSplineTensions(p9, p10) --[[ Line: 70 ]]
    -- upvalues: u2 (copy)
    if type(p10) ~= "number" then
        error("CatmullRomSpline:ChangeAllSplineTensions() expected a number as an input, got " .. tostring(p10) .. "!");
    end;
    local v11 = u2.GetSplines(p9);
    for _, v12 in pairs(v11) do
        v12:ChangeTension(p10);
    end;
end;
function u2.AddPoint(u13, p14, p15) --[[ Line: 86 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local l__Points__2 = u13.Points;
    local function v19(p16) --[[ Line: 89 ]]
        -- upvalues: u2 (ref), u13 (copy)
        local v17 = u2.GetPoints(u13);
        for _, v18 in pairs(v17) do
            if typeof(v18) ~= typeof(p16) then
                return false;
            end;
        end;
        return true;
    end;
    if #l__Points__2 == 4 then
        if typeof(p14) == "number" or (typeof(p14) == "Vector2" or typeof(p14) == "Vector3") then
            if v19(p14) then
                local v20 = u2.GetSplines(u13);
                local v21 = v20[#v20];
                local v22 = u1.new({
                    v21.Points[2],
                    v21.Points[3],
                    v21.Points[4],
                    p14
                }, v21.Tension);
                u2.ConnectSpline(u13, v22);
            end;
        elseif p14:IsA("BasePart") and v19(p14.Position) then
            local v23 = u2.GetSplines(u13);
            local v24 = v23[#v23];
            local v25 = u1.new({
                v24.Points[2],
                v24.Points[3],
                v24.Points[4],
                p14
            }, v24.Tension);
            u2.ConnectSpline(u13, v25);
        end;
    elseif typeof(p14) == "number" then
        if v19(p14) then
            table.insert(l__Points__2, p15 or #l__Points__2 + 1, p14);
        end;
    elseif typeof(p14) == "Vector2" then
        if v19(p14) then
            table.insert(l__Points__2, p15 or #l__Points__2 + 1, p14);
        end;
    elseif typeof(p14) == "Vector3" then
        if v19(p14) then
            table.insert(l__Points__2, p15 or #l__Points__2 + 1, p14);
        end;
    elseif p14:IsA("BasePart") then
        if v19(p14.Position) then
            table.insert(l__Points__2, p15 or #l__Points__2 + 1, p14);
            u13._connections[p14] = p14.Changed:Connect(function(p26) --[[ Line: 131 ]]
                -- upvalues: u2 (ref), u13 (copy)
                if p26 == "Position" then
                    u2.UpdateLength(u13);
                end;
            end);
        end;
    else
        error("Invalid input received for CatmullRomSpline:AddPoint(), expected Vector3 or BasePart, got " .. tostring(p14) .. "!");
    end;
    if #l__Points__2 == 4 then
        u2.UpdateLength(u13);
    end;
end;
function u2.RemovePoint(p27, p28) --[[ Line: 150 ]]
    if type(p) ~= "number" then
        error("CatmullRomSpline:RemovePoint() expected a number as the input, got " .. tostring(p28) .. "!");
    end;
    local v29 = table.remove(p27.Points, p28);
    if v29 ~= nil and (typeof(v29) == "Instance" and (v29:IsA("BasePart") and p27._connections[v29])) then
        p27._connections[v29]:Disconnect();
        p27._connections[v29] = nil;
    end;
end;
function u2.GetPoints(p30) --[[ Line: 170 ]]
    local v31 = {};
    for v32 = 1, #p30.Points do
        v31[v32] = typeof(p30.Points[v32]) == "Instance" and p30.Points[v32].Position or p30.Points[v32];
    end;
    return v31;
end;
function u2.ConnectSpline(u33, p34) --[[ Line: 187 ]]
    -- upvalues: u2 (copy)
    local l__Points__3 = p34.Points;
    local v35 = u2.GetSplines(u33);
    local l__Points__4 = v35[#v35].Points;
    if not (function(p36) --[[ Name: checkIfPointsMatch, Line 195 ]]
        -- upvalues: u2 (ref), u33 (copy)
        local v37 = u2.GetPoints(u33);
        for _, v38 in pairs(v37) do
            if typeof(v38) ~= typeof(p36) then
                return false;
            end;
        end;
        return true;
    end)((typeof(l__Points__4[1]) == "number" or typeof(l__Points__4[1]) == "Vector3") and l__Points__4[1] or l__Points__4[1].Position) then
        error("Cannot connect the spline because the splines do not have the same types of points!");
    end;
    if l__Points__4[2] == l__Points__3[1] and (l__Points__4[3] == l__Points__3[2] and l__Points__4[4] == l__Points__3[3]) then
        table.insert(u33.ConnectedSplines, p34);
        u2.UpdateLength(u33);
    else
        error("Cannot connect the spline because the splines do not share 3 common points!");
    end;
end;
function u2.GetSplines(p39) --[[ Line: 218 ]]
    local v40 = { p39 };
    for v41 = 1, #p39.ConnectedSplines do
        table.insert(v40, p39.ConnectedSplines[v41]);
    end;
    return v40;
end;
function u2.GetSplineAt(p42, p43) --[[ Line: 230 ]]
    -- upvalues: u2 (copy)
    local v44 = u2.GetSplines(p42);
    if type(p43) ~= "number" then
        error("CatmullRomSpline:GetSplineAt() expected a number as an input, got " .. tostring(p43) .. "!");
    end;
    if #v44 == 1 then
        return p42, p43;
    end;
    local v45 = 1 / #v44;
    if p43 <= 0 then
        return p42, p43 * v45;
    end;
    if p43 >= 1 then
        return v44[#v44], (p43 - 1) * v45 + 1;
    end;
    local v46 = math.ceil(p43 * #v44);
    local v47 = v44[v46];
    local v48 = (v46 - 1) * v45;
    local v49 = v46 * v45;
    local v50 = 1 / (v49 - v48);
    return v47, v50 * p43 - v50 * v49 + 1;
end;
function u2.UpdateLength(p51) --[[ Line: 265 ]]
    -- upvalues: u2 (copy)
    local v52 = u2.GetSplines(p51);
    local v53 = {};
    local v54 = 0;
    for v55, v56 in pairs(v52) do
        local v57 = u2.GetPoints(v56);
        if #v57 ~= 4 then
            error("Cannot get the length of the CatmullRomSpline object, expected 4 control points for all splines, got " .. tostring(#v53) .. " points for spline " .. tostring(v55) .. "!");
        end;
        for _, v58 in pairs(v57) do
            table.insert(v53, v58);
        end;
    end;
    local l__LengthIterations__5 = p51.LengthIterations;
    local v59 = {};
    for v60 = 1, l__LengthIterations__5 do
        local v61 = u2.CalculateDerivativeAt(p51, (v60 - 1) / (l__LengthIterations__5 - 1));
        if typeof(v61) == "number" then
            v54 = v54 + v61 * (1 / l__LengthIterations__5);
        else
            v54 = v54 + v61.Magnitude * (1 / l__LengthIterations__5);
        end;
        table.insert(v59, { (v60 - 1) / (l__LengthIterations__5 - 1), v54, v61 });
    end;
    p51.Length = v54;
    p51.LengthIndices = v59;
end;
function u2.CalculatePositionAt(p62, p63) --[[ Line: 301 ]]
    -- upvalues: u2 (copy)
    if type(p63) ~= "number" then
        error("The given t value in CatmullRomSpline:CalculatePositionAt() was not between 0 and 1, got " .. tostring(p63) .. "!");
    end;
    local v64, v65 = u2.GetSplineAt(p62, p63);
    local v66 = u2.GetPoints(v64);
    if #v66 ~= 4 then
        error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#v66) .. "), expected 4 points!");
    end;
    local l__Tension__6 = v64.Tension;
    return v66[2] + l__Tension__6 * (v66[3] - v66[1]) * v65 + (3 * (v66[3] - v66[2]) - l__Tension__6 * (v66[4] - v66[2]) - 2 * l__Tension__6 * (v66[3] - v66[1])) * v65 ^ 2 + (-2 * (v66[3] - v66[2]) + l__Tension__6 * (v66[4] - v66[2]) + l__Tension__6 * (v66[3] - v66[1])) * v65 ^ 3;
end;
function u2.CalculatePositionRelativeToLength(p67, p68) --[[ Line: 330 ]]
    -- upvalues: u2 (copy)
    if type(p68) ~= "number" then
        error("CatmullRomSpline:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(p68) .. "!");
    end;
    local l__Points__7 = p67.Points;
    if #l__Points__7 ~= 4 then
        error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#l__Points__7) .. "), expected 4 points!");
        return;
    end;
    local l__Length__8 = p67.Length;
    local l__LengthIndices__9 = p67.LengthIndices;
    local _ = p67.LengthIterations;
    u2.GetPoints(p67);
    local v69 = l__Length__8 * p68;
    local v70 = nil;
    local v71 = nil;
    for v72, v73 in ipairs(l__LengthIndices__9) do
        if v69 - v73[2] <= 0 or v72 == #l__LengthIndices__9 then
            v71 = v73;
            v70 = v72;
            break;
        end;
    end;
    local v74, v75;
    if l__LengthIndices__9[v70 - 1] then
        v74 = u2.CalculatePositionAt(p67, l__LengthIndices__9[v70 - 1][1]);
        v75 = u2.CalculatePositionAt(p67, v71[1]);
    else
        v74 = u2.CalculatePositionAt(p67, v71[1]);
        v75 = u2.CalculatePositionAt(p67, l__LengthIndices__9[v70 + 1][1]);
    end;
    if typeof(v74) == "number" and typeof(v75) == "number" then
        return v74 + (v75 - v74) * (1 - (v71[2] - v69) / (v75 - v74));
    else
        return v74 + (v75 - v74) * (1 - (v71[2] - v69) / (v75 - v74).Magnitude);
    end;
end;
function u2.CalculateDerivativeAt(p76, p77) --[[ Line: 387 ]]
    -- upvalues: u2 (copy)
    if type(p77) ~= "number" then
        error("The given t value in CatmullRomSpline:CalculateDerivativeAt() was not between 0 and 1, got " .. tostring(p77) .. "!");
    end;
    local v78, v79 = u2.GetSplineAt(p76, p77);
    local v80 = u2.GetPoints(v78);
    if #v80 ~= 4 then
        error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#v80) .. "), expected 4 points!");
    end;
    local l__Tension__10 = v78.Tension;
    return l__Tension__10 * (v80[3] - v80[1]) + 2 * (3 * (v80[3] - v80[2]) - l__Tension__10 * (v80[4] - v80[2]) - 2 * l__Tension__10 * (v80[3] - v80[1])) * v79 + 3 * (-2 * (v80[3] - v80[2]) + l__Tension__10 * (v80[4] - v80[2]) + l__Tension__10 * (v80[3] - v80[1])) * v79 ^ 2;
end;
function u2.CalculateDerivativeRelativeToLength(p81, p82) --[[ Line: 415 ]]
    -- upvalues: u2 (copy)
    if type(p82) ~= "number" then
        error("CatmullRomSpline:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(p82) .. "!");
    end;
    local l__Points__11 = p81.Points;
    if #l__Points__11 ~= 4 then
        error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#l__Points__11) .. "), expected 4 points!");
        return;
    end;
    local l__Length__12 = p81.Length;
    local l__LengthIndices__13 = p81.LengthIndices;
    local _ = p81.LengthIterations;
    u2.GetPoints(p81);
    local v83 = l__Length__12 * p82;
    local v84 = nil;
    local v85 = nil;
    for v86, v87 in ipairs(l__LengthIndices__13) do
        if v83 - v87[2] <= 0 or v86 == #l__LengthIndices__13 then
            v85 = v87;
            v84 = v86;
            break;
        end;
    end;
    local v88, v89;
    if l__LengthIndices__13[v84 - 1] then
        v88 = u2.CalculateDerivativeAt(p81, l__LengthIndices__13[v84 - 1][1]);
        v89 = u2.CalculateDerivativeAt(p81, v85[1]);
    else
        v88 = u2.CalculateDerivativeAt(p81, v85[1]);
        v89 = u2.CalculateDerivativeAt(p81, l__LengthIndices__13[v84 + 1][1]);
    end;
    local v90;
    if typeof(v88) == "number" and typeof(v89) == "number" then
        v90 = math.abs(v89 - v88) <= 0 and 0 or (v85[2] - v83) / (v89 - v88);
    else
        v90 = (v89 - v88).Magnitude <= 0 and 0 or (v85[2] - v83) / (v89 - v88).Magnitude;
    end;
    return v88 + (v89 - v88) * (1 - v90);
end;
function u2.CreateTween(u91, u92, p93, u94, u95) --[[ Line: 483 ]]
    -- upvalues: l__TweenService__1 (copy), u2 (copy)
    if typeof(u92) ~= "Instance" then
        error("CatmullRomSplineObject:CreateTween() expected an instance as the first input, got " .. tostring(u92) .. "!");
    end;
    if typeof(p93) ~= "TweenInfo" then
        error("CatmullRomSplineObject:CreateTween() expected a TweenInfo object as the second input, got " .. tostring(p93) .. "!");
    end;
    local v96 = true;
    for _, u97 in pairs(u94) do
        local v98, v99 = pcall(function() --[[ Line: 497 ]]
            -- upvalues: u92 (copy), u97 (copy)
            return u92[u97];
        end);
        if not v98 or v99 == nil then
            v96 = false;
        end;
    end;
    if not v96 then
        error("CatmullRomSplineObject:CreateTween() was given properties in the property table that do not belong to the instance!");
    end;
    local u100 = Instance.new("NumberValue");
    local u101 = l__TweenService__1:Create(u100, p93, {
        Value = 1
    });
    local u102 = nil;
    u101.Changed:Connect(function(p103) --[[ Line: 512 ]]
        -- upvalues: u101 (copy), u102 (ref), u100 (copy), u94 (copy), u95 (copy), u2 (ref), u91 (copy), u92 (copy)
        if p103 == "PlaybackState" then
            if u101.PlaybackState == Enum.PlaybackState.Playing then
                u102 = u100.Changed:Connect(function(p104) --[[ Line: 516 ]]
                    -- upvalues: u94 (ref), u95 (ref), u2 (ref), u91 (ref), u92 (ref)
                    for _, v105 in pairs(u94) do
                        local v106 = u95 and u2.CalculatePositionRelativeToLength(u91, p104) or u2.CalculatePositionAt(u91, p104);
                        local v107 = u95 and u2.CalculateDerivativeRelativeToLength(u91, p104) or u2.CalculateDerivativeAt(u91, p104);
                        if typeof(v106) == "Vector3" and typeof(v107) == "Vector3" then
                            v106 = CFrame.new(v106, v106 + v107) or v106;
                        end;
                        if typeof(u92[v105]) == "number" or (typeof(u92[v105] == "Vector2") or typeof(u92[v105]) == "CFrame") then
                            u92[v105] = v106;
                        elseif typeof(u92[v105] == "Vector3") then
                            u92[v105] = v106.Position;
                        else
                            error("CatmullRomSplineObject:CreateTween() could not set the value of the instance property " .. tostring(v105) .. ", not a numerical value!");
                        end;
                    end;
                end);
                return;
            end;
            if u102 ~= nil then
                u102:Disconnect();
                u102 = nil;
            end;
        end;
    end);
    return u101;
end;
return u1;