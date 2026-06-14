-- Decompiled with Potassium's decompiler.

return {
    getUserFlag = function(u1) --[[ Name: getUserFlag, Line 11 ]]
        local v2, v3 = pcall(function() --[[ Line: 12 ]]
            -- upvalues: u1 (copy)
            return UserSettings():IsUserFeatureEnabled(u1);
        end);
        return v2 and v3;
    end
};