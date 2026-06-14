-- Decompiled with Potassium's decompiler.

local l__Stringify__1 = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify);
local l__DeepEquals__2 = require(game.ReplicatedStorage.UserGenerated.Collections.DeepEquals);
return table.freeze({
    IsEqual = function(p1, p2) --[[ Name: Equals, Line 21 ]]
        return rawequal(p1, p2) and true or (type(p1) ~= "table" or type(p2) ~= "table") and (p1 ~= p1 and p2 ~= p2);
    end,
    ErrorUnsafe = function(p3, p4, ...) --[[ Name: ErrorUnsafe, Line 60 ]]
        local u5 = nil;
        local v7 = table.pack(xpcall(p4, function(p6) --[[ Line: 66 ]]
            -- upvalues: u5 (ref)
            u5 = p6;
        end, ...));
        if v7[1] then
            error("ExpectedError", 2);
        end;
        if u5 ~= p3 then
            error(`ExpectedError Mismatch: {string.format("%q", (tostring(u5)))}`, 2);
        end;
        return table.unpack(v7, 2);
    end,
    Error = function(p8, p9, ...) --[[ Name: Error, Line 79 ]]
        -- upvalues: l__Stringify__1 (copy)
        local u10 = nil;
        local v12 = table.pack(xpcall(p9, function(p11) --[[ Line: 85 ]]
            -- upvalues: u10 (ref)
            u10 = p11;
        end, ...));
        if v12[1] then
            error(`ExpectedError({l__Stringify__1.Pretty(p8, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })})`, 2);
        end;
        if type(u10) == "string" then
            local v13 = tostring(u10);
            local v14, v15 = string.match(v13, "^(.*:%d+): (.+)$");
            if v14 then
                v13 = v15 or v13;
            end;
            u10 = v13;
        end;
        if p8 ~= u10 then
            error(`ExpectedError({l__Stringify__1.Pretty(p8, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}): {l__Stringify__1.Pretty(u10, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}`, 2);
        end;
        return table.unpack(v12, 2);
    end,
    Equal = function(p16, p17) --[[ Name: Equal, Line 101 ]]
        -- upvalues: l__Stringify__1 (copy)
        if not rawequal(p16, p17) and (type(p16) == "table" and type(p17) == "table" or (p16 == p16 or p17 == p17)) then
            error(`Equal({l__Stringify__1.Pretty(p16, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}, {l__Stringify__1.Pretty(p17, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })})`, 2);
        end;
    end,
    DeepEqual = function(p18, p19) --[[ Name: DeepEqual, Line 107 ]]
        -- upvalues: l__DeepEquals__2 (copy), l__Stringify__1 (copy)
        if not l__DeepEquals__2(p18, p19) then
            error(`DeepEqual({l__Stringify__1.Pretty(p18, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}, {l__Stringify__1.Pretty(p19, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })})`, 2);
        end;
    end,
    FuzzyEqual = function(p20, p21, p22) --[[ Name: FuzzyEqual, Line 113 ]]
        if (p22 or 0.001) < math.abs(p20 - p21) then
            error(`FuzzyEqual({tostring(p20)}, {tostring(p21)}): {math.abs(p20 - p21)}`, 2);
        end;
    end,
    ColorEqual = function(p23, p24, p25) --[[ Name: ColorEqual, Line 120 ]]
        -- upvalues: l__Stringify__1 (copy)
        local v26 = Vector3.new(p23.R, p23.G, p23.B) * 255;
        if (p25 or 0.001) < (Vector3.new(p24.R, p24.G, p24.B) * 255 - v26).Magnitude then
            error(`ColorEqual({l__Stringify__1.Pretty(p23, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}, {l__Stringify__1.Pretty(p24, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })})`, 2);
        end;
    end
});