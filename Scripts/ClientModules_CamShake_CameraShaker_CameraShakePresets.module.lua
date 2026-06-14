-- Decompiled with Potassium's decompiler.

local l__CameraShakeInstance__1 = require(script.Parent.CameraShakeInstance);
local u11 = {
    Bump = function() --[[ Name: Bump, Line 26 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v1 = l__CameraShakeInstance__1.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v1.RotationInfluence = Vector3.new(0, 0, 0);
        return v1;
    end,
    Bump2 = function() --[[ Name: Bump2, Line 33 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v2 = l__CameraShakeInstance__1.new(4, 4, 0.1, 0.75);
        v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v2.RotationInfluence = Vector3.new(0, 0, 0);
        return v2;
    end,
    Explosion = function() --[[ Name: Explosion, Line 42 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v3 = l__CameraShakeInstance__1.new(5, 10, 0, 1.5);
        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v3.RotationInfluence = Vector3.new(4, 1, 1);
        return v3;
    end,
    SideExplosion = function() --[[ Name: SideExplosion, Line 49 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v4 = l__CameraShakeInstance__1.new(5, 10, 0, 1.5);
        v4.PositionInfluence = Vector3.new(0.25, 0.25, 0);
        v4.RotationInfluence = Vector3.new(1, 1, 1);
        return v4;
    end,
    Earthquake = function() --[[ Name: Earthquake, Line 58 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v5 = l__CameraShakeInstance__1.new(0.6, 3.5, 2, 10);
        v5.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v5.RotationInfluence = Vector3.new(1, 1, 4);
        return v5;
    end,
    SoftEarthquake = function() --[[ Name: SoftEarthquake, Line 65 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v6 = l__CameraShakeInstance__1.new(0.3, 1.75, 0, 0);
        v6.PositionInfluence = Vector3.new(0.1, 0.1, 0.1);
        v6.RotationInfluence = Vector3.new(0.1, 0.1, 0.1);
        return v6;
    end,
    BadTrip = function() --[[ Name: BadTrip, Line 74 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v7 = l__CameraShakeInstance__1.new(10, 0.15, 5, 10);
        v7.PositionInfluence = Vector3.new(0, 0, 0.15);
        v7.RotationInfluence = Vector3.new(2, 1, 4);
        return v7;
    end,
    HandheldCamera = function() --[[ Name: HandheldCamera, Line 84 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v8 = l__CameraShakeInstance__1.new(1, 0.25, 5, 10);
        v8.PositionInfluence = Vector3.new(0.05, 0.05, 0.05);
        v8.RotationInfluence = Vector3.new(0.1, 0.1, 0.1);
        return v8;
    end,
    Vibration = function() --[[ Name: Vibration, Line 94 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v9 = l__CameraShakeInstance__1.new(0.4, 20, 2, 2);
        v9.PositionInfluence = Vector3.new(0, 0.15, 0);
        v9.RotationInfluence = Vector3.new(1.25, 0, 4);
        return v9;
    end,
    RoughDriving = function() --[[ Name: RoughDriving, Line 104 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v10 = l__CameraShakeInstance__1.new(1, 2, 1, 1);
        v10.PositionInfluence = Vector3.new(0, 0, 0);
        v10.RotationInfluence = Vector3.new(1, 1, 1);
        return v10;
    end
};
return setmetatable({}, {
    __index = function(_, p12) --[[ Name: __index, Line 116 ]]
        -- upvalues: u11 (copy)
        local v13 = u11[p12];
        if type(v13) == "function" then
            return v13();
        end;
        error("No preset found with index \"" .. p12 .. "\"");
    end
});