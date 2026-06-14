-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {};
v1.enums = u2;
function v1.createEnum(p3, u4) --[[ Line: 20 ]]
    -- upvalues: u2 (copy)
    local v5 = typeof(p3) == "string";
    assert(v5, "bad argument #1 - enums must be created using a string name!");
    local v6 = typeof(u4) == "table";
    assert(v6, "bad argument #2 - enums must be created using a table!");
    assert(not u2[p3], ("enum \'%s\' already exists!"):format(p3));
    local u7 = {};
    local u8 = {};
    local u9 = {};
    local u19 = {
        getName = function(p10) --[[ Name: getName, Line 30 ]]
            -- upvalues: u8 (copy), u9 (copy), u4 (copy)
            local v11 = tostring(p10);
            local v12 = u8[v11] or u9[v11];
            if v12 then
                return u4[v12][1];
            end;
        end,
        getValue = function(p13) --[[ Name: getValue, Line 40 ]]
            -- upvalues: u7 (copy), u9 (copy), u4 (copy)
            local v14 = tostring(p13);
            local v15 = u7[v14] or u9[v14];
            if v15 then
                return u4[v15][2];
            end;
        end,
        getProperty = function(p16) --[[ Name: getProperty, Line 50 ]]
            -- upvalues: u7 (copy), u8 (copy), u4 (copy)
            local v17 = tostring(p16);
            local v18 = u7[v17] or u8[v17];
            if v18 then
                return u4[v18][3];
            end;
        end
    };
    local v20 = {};
    for v21, v22 in pairs(u4) do
        local v23 = typeof(v22) == "table";
        assert(v23, ("bad argument #2.%s - details must only be comprised of tables!"):format(v21));
        local v24 = v22[1];
        local v25 = typeof(v24) == "string";
        assert(v25, ("bad argument #2.%s.1 - detail name must be a string!"):format(v21));
        local v26 = typeof(not u7[v24]);
        assert(v26, ("bad argument #2.%s.1 - the detail name \'%s\' already exists!"):format(v21, v24));
        local v27 = typeof(not u19[v24]);
        assert(v27, ("bad argument #2.%s.1 - that name is reserved."):format(v21, v24));
        u7[tostring(v24)] = v21;
        local v28 = v22[2];
        local v29 = tostring(v28);
        local v30 = typeof(not u8[v29]);
        assert(v30, ("bad argument #2.%s.2 - the detail value \'%s\' already exists!"):format(v21, v29));
        u8[v29] = v21;
        local v31 = v22[3];
        if v31 then
            local v32 = typeof(not u9[v31]);
            local v33 = tostring(v31);
            assert(v32, ("bad argument #2.%s.3 - the detail property \'%s\' already exists!"):format(v21, v33));
            u9[tostring(v31)] = v21;
        end;
        v20[v24] = v28;
        setmetatable(v20, {
            __index = function(_, p34) --[[ Name: __index, Line 80 ]]
                -- upvalues: u19 (copy)
                return u19[p34];
            end
        });
    end;
    u2[p3] = v20;
    return v20;
end;
function v1.getEnums() --[[ Line: 90 ]]
    -- upvalues: u2 (copy)
    return u2;
end;
local l__createEnum__1 = v1.createEnum;
for _, v35 in pairs(script:GetChildren()) do
    if v35:IsA("ModuleScript") then
        local v36 = require(v35);
        l__createEnum__1(v35.Name, v36);
    end;
end;
return v1;