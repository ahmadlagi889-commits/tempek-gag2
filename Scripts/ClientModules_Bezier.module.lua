-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function B(p2, p3, p4)
    local function u6(p5) --[[ Line: 23 ]]
        -- upvalues: u6 (copy)
        return p5 == 0 and 1 or p5 * u6(p5 - 1);
    end;
    local v7 = p2 == 0 and 1 or p2 * u6(p2 - 1);
    local v8 = p3 == 0 and 1 or p3 * u6(p3 - 1);
    local v9 = p2 - p3;
    return v7 / (v8 * (v9 == 0 and 1 or v9 * u6(v9 - 1))) * p4 ^ p3 * (1 - p4) ^ (p2 - p3);
end;
function u1.new(...) --[[ Line: 38 ]]
    -- upvalues: u1 (copy)
    local v10 = setmetatable({}, u1);
    v10.Points = {};
    v10.LengthIterations = 1000;
    v10.LengthIndeces = {};
    v10.Length = 0;
    v10._connections = {};
    for _, v11 in pairs({ ... }) do
        if typeof(v11) == "Vector3" or typeof(v11) == "Instance" and v11:IsA("BasePart") then
            v10:AddBezierPoint(v11);
        else
            error("The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!");
        end;
    end;
    return v10;
end;
function u1.AddBezierPoint(u12, p13, p14) --[[ Line: 70 ]]
    if p13 and (typeof(p13) == "Instance" and p13:IsA("BasePart")) or typeof(p13) == "Vector3" then
        local u15 = {
            Type = typeof(p13) == "Vector3" and "StaicPoint" or "BasePartPoint",
            Point = p13
        };
        if u15.Type == "BasePartPoint" then
            local u17 = p13.Changed:Connect(function(p16) --[[ Line: 84 ]]
                -- upvalues: u12 (copy)
                if p16 == "Position" then
                    u12:UpdateLength();
                end;
            end);
            local v20 = p13.AncestryChanged:Connect(function(_, p18) --[[ Line: 91 ]]
                -- upvalues: u12 (copy), u15 (copy), u17 (ref)
                if p18 == nil then
                    local v19 = table.find(u12.Points, u15);
                    if v19 then
                        table.remove(u12.Points, v19);
                    end;
                    u17:Disconnect();
                    u17:Disconnect();
                end;
            end);
            if not u12._connections[p13] then
                u12._connections[p13] = {};
            end;
            table.insert(u12._connections[p13], u17);
            table.insert(u12._connections[p13], v20);
        end;
        if p14 and type(p14) == "number" then
            table.insert(u12.Points, p14, u15);
        elseif p14 then
            if type(p14) ~= "number" then
                error("Bezier:AddBezierPoint() only accepts an integer as the second argument!");
            end;
        else
            table.insert(u12.Points, u15);
        end;
        u12:UpdateLength();
    else
        error("Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!");
    end;
end;
function u1.ChangeBezierPoint(p21, p22, p23) --[[ Line: 137 ]]
    if type(p22) ~= "number" then
        error("Bezier:ChangeBezierPoint() only accepts a number index as the first argument!");
    end;
    if p23 and (typeof(p23) == "Instance" and p23:IsA("BasePart")) or typeof(p23) == "Vector3" then
        local v24 = p21.Points[p22];
        if v24 then
            v24.Type = typeof(p23) == "Vector3" and "StaicPoint" or "BasePartPoint";
            v24.Point = p23;
            p21:UpdateLength();
        else
            error("Did not find BezierPoint at index " .. tostring(p22));
        end;
    else
        error("Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!");
    end;
end;
function u1.GetAllPoints(p25) --[[ Line: 171 ]]
    local v26 = {};
    for v27 = 1, #p25.Points do
        table.insert(v26, p25:GetPoint(v27));
    end;
    return v26;
end;
function u1.GetPoint(p28, p29) --[[ Line: 189 ]]
    local l__Points__1 = p28.Points;
    if l__Points__1[p29] then
        return typeof(l__Points__1[p29].Point) == "Vector3" and l__Points__1[p29].Point or l__Points__1[p29].Point.Position;
    end;
    error("Did not find a BezierPoint at index " .. tostring(p29) .. "!");
end;
function u1.RemoveBezierPoint(p30, p31) --[[ Line: 202 ]]
    if p30.Points[p31] then
        local v32 = table.remove(p30.Points, p31);
        if typeof(v32.Point) == "Instance" and v32.Point:IsA("BasePart") then
            for _, v33 in pairs(p30._connections[v32.Point]) do
                if v33.Connected then
                    v33:Disconnect();
                end;
            end;
            p30._connections[v32.Point] = nil;
        end;
        p30:UpdateLength();
    end;
end;
function u1.UpdateLength(p34) --[[ Line: 225 ]]
    local v35 = p34:GetAllPoints();
    local l__LengthIterations__2 = p34.LengthIterations;
    if #v35 < 2 then
        return 0, {
            { 0, 0, 0 },
            { 0, 0, 0 }
        };
    end;
    local v36 = 0;
    local v37 = {};
    for v38 = 1, l__LengthIterations__2 do
        local v39 = p34:CalculateDerivativeAt((v38 - 1) / (l__LengthIterations__2 - 1));
        v36 = v36 + v39.Magnitude * (1 / l__LengthIterations__2);
        table.insert(v37, { (v38 - 1) / (l__LengthIterations__2 - 1), v36, v39 });
    end;
    p34.Length = v36;
    p34.LengthIndeces = v37;
end;
function u1.CalculatePositionAt(p40, p41) --[[ Line: 251 ]]
    if type(p41) ~= "number" then
        error("Bezier:CalculatePositionAt() only accepts a number, got " .. tostring(p41) .. "!");
    end;
    if #p40.Points > 0 then
        local v42 = p40:GetAllPoints();
        local v43 = #v42;
        local v44 = Vector3.new();
        for v45 = 1, v43 do
            local v46 = v42[v45];
            v44 = v44 + B(v43 - 1, v45 - 1, p41) * v46;
        end;
        return v44;
    end;
    error("Bezier:CalculatePositionAt() only works if there is at least 1 BezierPoint!");
end;
function u1.CalculatePositionRelativeToLength(p47, p48) --[[ Line: 291 ]]
    if type(p48) ~= "number" then
        error("Bezier:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(p48) .. "!");
    end;
    if #p47.Points <= 0 then
        error("Bezier:CalculatePositionRelativeToLength() only works if there is at least 1 BezierPoint!");
        return;
    end;
    local l__Length__3 = p47.Length;
    local l__LengthIndeces__4 = p47.LengthIndeces;
    local _ = p47.LengthIterations;
    if #p47:GetAllPoints() <= 1 then
        return p47:CalculatePositionAt(0);
    end;
    local v49 = l__Length__3 * p48;
    local v50 = nil;
    local v51 = nil;
    for v52, v53 in ipairs(l__LengthIndeces__4) do
        if v49 - v53[2] <= 0 or v52 == #l__LengthIndeces__4 then
            v51 = v53;
            v50 = v52;
            break;
        end;
    end;
    local v54, v55;
    if l__LengthIndeces__4[v50 - 1] then
        v54 = p47:CalculatePositionAt(l__LengthIndeces__4[v50 - 1][1]);
        v55 = p47:CalculatePositionAt(v51[1]);
    else
        v54 = p47:CalculatePositionAt(v51[1]);
        v55 = p47:CalculatePositionAt(l__LengthIndeces__4[v50 + 1][1]);
    end;
    return v54 + (v55 - v54) * (1 - (v51[2] - v49) / (v55 - v54).Magnitude);
end;
function u1.CalculateDerivativeAt(p56, p57) --[[ Line: 357 ]]
    if type(p57) ~= "number" then
        error("Bezier:CalculateDerivativeAt() only accepts a number, got " .. tostring(p57) .. "!");
    end;
    if #p56.Points > 1 then
        local v58 = p56:GetAllPoints();
        local v59 = #v58;
        local _ = v59 - 1;
        local v60 = Vector3.new();
        for v61 = 1, v59 - 1 do
            local v62 = (v59 - 1) * (v58[v61 + 1] - v58[v61]);
            v60 = v60 + B(v59 - 2, v61 - 1, p57) * v62;
        end;
        return v60;
    end;
    error("Bezier:CalculateDerivativeAt() only works if there are at least 2 BezierPoints!");
end;
function u1.CalculateDerivativeRelativeToLength(p63, p64) --[[ Line: 400 ]]
    if type(p64) ~= "number" then
        error("Bezier:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(p64) .. "!");
    end;
    if #p63.Points <= 1 then
        error("Bezier:CalculateDerivativeRelativeToLength() only works if there are at least 2 BezierPoints!");
        return;
    end;
    local l__Length__5 = p63.Length;
    local l__LengthIndeces__6 = p63.LengthIndeces;
    local _ = p63.LengthIterations;
    p63:GetAllPoints();
    local v65 = l__Length__5 * p64;
    local v66 = nil;
    local v67 = nil;
    for v68, v69 in ipairs(l__LengthIndeces__6) do
        if v65 - v69[2] <= 0 or v68 == #l__LengthIndeces__6 then
            v67 = v69;
            v66 = v68;
            break;
        end;
    end;
    local v70, v71;
    if l__LengthIndeces__6[v66 - 1] then
        v70 = p63:CalculateDerivativeAt(l__LengthIndeces__6[v66 - 1][1]);
        v71 = p63:CalculateDerivativeAt(v67[1]);
    else
        v70 = p63:CalculateDerivativeAt(v67[1]);
        v71 = p63:CalculateDerivativeAt(l__LengthIndeces__6[v66 + 1][1]);
    end;
    return v70 + (v71 - v70) * (1 - (v67[2] - v65) / (v71 - v70).Magnitude);
end;
function u1.CreateVector3Tween(u72, u73, u74, p75, u76) --[[ Line: 458 ]]
    if #u72.Points == 0 then
        error("Bezier:CreateVector3Tween() only works if there is at least 1 BezierPoint in the Bezier!");
    end;
    if typeof(u73) ~= "Instance" and typeof(u73) ~= "table" then
        error("Bezier:CreateVector3Tween() requires an Instance or a table as the first argument!");
    end;
    if typeof(p75) ~= "TweenInfo" then
        error("Bezier:CreateVector3Tween() requires a TweenInfo object as the third argument!");
    end;
    local v79, v80 = pcall(function() --[[ Line: 476 ]]
        -- upvalues: u74 (copy), u73 (copy)
        local v77 = true;
        for _, v78 in pairs(u74) do
            if typeof(u73[v78]) ~= "Vector3" and typeof(u73[v78]) ~= "nil" then
                return false;
            end;
        end;
        return v77;
    end);
    if v79 and v80 then
        local l__TweenService__7 = game:GetService("TweenService");
        local u81 = Instance.new("NumberValue");
        local u82 = l__TweenService__7:Create(u81, p75, {
            Value = 1
        });
        local u83 = nil;
        u82.Changed:Connect(function(p84) --[[ Line: 493 ]]
            -- upvalues: u82 (copy), u83 (ref), u81 (copy), u74 (copy), u73 (copy), u76 (copy), u72 (copy)
            if p84 == "PlaybackState" then
                if u82.PlaybackState == Enum.PlaybackState.Playing then
                    u83 = u81.Changed:Connect(function(p85) --[[ Line: 497 ]]
                        -- upvalues: u74 (ref), u73 (ref), u76 (ref), u72 (ref)
                        for _, v86 in pairs(u74) do
                            u73[v86] = u76 and u72:CalculatePositionRelativeToLength(p85) or u72:CalculatePositionAt(p85);
                        end;
                    end);
                    return;
                end;
                if u83 then
                    u83:Disconnect();
                    u83 = nil;
                end;
            end;
        end);
        return u82;
    end;
    error("Bezier:CreateVector3Tween() requires a matching property table with Vector3 or nil property names for the object as the second argument!");
end;
function u1.CreateCFrameTween(u87, u88, u89, p90, u91) --[[ Line: 519 ]]
    if #u87.Points <= 1 then
        error("Bezier:CreateVector3Tween() only works if there are at least 2 BezierPoints in the Bezier!");
    end;
    if typeof(u88) ~= "Instance" and typeof(u88) ~= "table" then
        error("Bezier:CreateCFrameTween() requires an Instance or a table as the first argument!");
    end;
    if typeof(p90) ~= "TweenInfo" then
        error("Bezier:CreateCFrameTween() requires a TweenInfo object as the third argument!");
    end;
    local v94, v95 = pcall(function() --[[ Line: 537 ]]
        -- upvalues: u89 (copy), u88 (copy)
        local v92 = true;
        for _, v93 in pairs(u89) do
            if typeof(u88[v93]) ~= "CFrame" and typeof(u88[v93]) ~= "nil" then
                return false;
            end;
        end;
        return v92;
    end);
    if v94 and v95 then
        local l__TweenService__8 = game:GetService("TweenService");
        local u96 = Instance.new("NumberValue");
        local u97 = l__TweenService__8:Create(u96, p90, {
            Value = 1
        });
        local u98 = nil;
        u97.Changed:Connect(function(p99) --[[ Line: 554 ]]
            -- upvalues: u97 (copy), u98 (ref), u96 (copy), u89 (copy), u91 (copy), u87 (copy), u88 (copy)
            if p99 == "PlaybackState" then
                if u97.PlaybackState == Enum.PlaybackState.Playing then
                    u98 = u96.Changed:Connect(function(p100) --[[ Line: 558 ]]
                        -- upvalues: u89 (ref), u91 (ref), u87 (ref), u88 (ref)
                        for _, v101 in pairs(u89) do
                            local v102 = u91 and u87:CalculatePositionRelativeToLength(p100) or u87:CalculatePositionAt(p100);
                            local v103 = u91 and u87:CalculateDerivativeRelativeToLength(p100) or u87:CalculateDerivativeAt(p100);
                            u88[v101] = CFrame.new(v102, v102 + v103);
                        end;
                    end);
                    return;
                end;
                if u98 then
                    u98:Disconnect();
                    u98 = nil;
                end;
            end;
        end);
        return u97;
    end;
    error("Bezier:CreateCFrameTween() requires a matching property table with CFrame or nil property names for the object as the second argument!");
end;
return u1;