-- Decompiled with Potassium's decompiler.

local u11 = {
    SnapToGrid = function(p1, p2, p3) --[[ Name: SnapToGrid, Line 3 ]]
        local v4 = p2.CFrame:PointToObjectSpace(p1);
        local v5 = math.round(v4.X / p3) * p3;
        local l__Y__1 = v4.Y;
        local v6 = math.round(v4.Z / p3) * p3;
        local v7 = Vector3.new(v5, l__Y__1, v6);
        return p2.CFrame:PointToWorldSpace(v7);
    end,
    GetGardenRotationY = function(p8) --[[ Name: GetGardenRotationY, Line 13 ]]
        local _, v9, _ = p8.CFrame:ToEulerAnglesYXZ();
        return v9;
    end,
    CalculateYOffset = function(p10) --[[ Name: CalculateYOffset, Line 18 ]]
        if not (p10 and p10.PrimaryPart) then
            return 0;
        end;
        local l__PrimaryPart__2 = p10.PrimaryPart;
        return l__PrimaryPart__2.Size.Y / 2 + (p10:GetPivot().Position.Y - l__PrimaryPart__2.Position.Y);
    end
};
function u11.PositionModel(p12, p13, p14, p15) --[[ Line: 32 ]]
    -- upvalues: u11 (copy)
    if not (p12 and p12.PrimaryPart) then
        return CFrame.new(p13);
    end;
    local v16 = CFrame.Angles(0, p14 + math.rad(p15), 0);
    local v17 = p12.PrimaryPart:FindFirstChild("FloorAttachment");
    if v17 then
        return CFrame.new(p13) * v16 * v17.CFrame:Inverse();
    end;
    local v18 = u11.CalculateYOffset(p12);
    return CFrame.new(p13 + Vector3.new(0, v18, 0)) * v16;
end;
return u11;