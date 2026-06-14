-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Keys__2 = require(game.ReplicatedStorage.UserGenerated.Lang.Keys);
local l__Asserts__3 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local l__Stringify__4 = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify);
local u1 = {
    Pretty = true,
    IndentChar = " ",
    IndentSize = 2
};
local function u5(...) --[[ Line: 62 ]]
    -- upvalues: l__Stringify__4 (copy), u1 (copy)
    local v2 = table.pack(...);
    for v3 = 1, v2.n do
        local v4 = v2[v3];
        if type(v4) ~= "string" then
            if typeof(v4) == "Instance" then
                v4 = `{v4.ClassName}[{v4:GetFullName()}]`;
            else
                v4 = l__Stringify__4.Serialize(v4, u1);
            end;
        end;
        v2[v3] = v4;
    end;
    return table.unpack(v2);
end;
local v6, v7;
if l__RunService__1:IsStudio() then
    v6 = print;
    v7 = warn;
else
    v6 = function(...) --[[ Line: 70 ]]
        -- upvalues: u5 (copy)
        local l__spawn__5 = task.spawn;
        local function v9(p8, ...) --[[ Line: 71 ]]
            -- upvalues: u5 (ref)
            print(p8, u5(...));
        end;
        local v10, v11, v12 = debug.info(2, "sln");
        local v13 = `{v10}:{v11}`;
        if v12 then
            v13 = v13 .. ` {v12}`;
        end;
        l__spawn__5(v9, `[{v13}]`, ...);
    end;
    v7 = function(...) --[[ Line: 75 ]]
        -- upvalues: u5 (copy)
        local l__spawn__6 = task.spawn;
        local function v15(p14, ...) --[[ Line: 76 ]]
            -- upvalues: u5 (ref)
            warn(p14, u5(...));
        end;
        local v16, v17, v18 = debug.info(2, "sln");
        local v19 = `{v16}:{v17}`;
        if v18 then
            v19 = v19 .. ` {v18}`;
        end;
        l__spawn__6(v15, `[{v19}]`, ...);
    end;
end;
local function u20() --[[ Line: 88 ]] end;
local u21 = {
    Trace = 1,
    Debug = 2,
    Info = 3,
    Warn = 4,
    Error = 5,
    Critical = 6,
    Off = 7
};
table.freeze(u21);
local u22 = {
    Trace = v6,
    Debug = v6,
    Info = v6,
    Warn = v7,
    Error = v7,
    Critical = v7,
    Off = u20
};
table.freeze(u22);
local v23 = l__Asserts__3.Set(l__Keys__2(u21));
local u24 = table.clone(u22);
local u25 = "Info";
local function u32(p26, p27) --[[ Line: 117 ]]
    -- upvalues: u21 (copy), u25 (ref), u24 (copy), u22 (copy), u20 (copy)
    assert(u21[p26]);
    local v28 = p27 == nil and true or type(p27) == "boolean";
    assert(v28);
    if u25 == p26 and not p27 then
    else
        u25 = p26;
        local v29 = assert(u21[p26]);
        for v30, v31 in pairs(u21) do
            if v29 <= v31 then
                u24[v30] = u22[v30];
            else
                u24[v30] = u20;
            end;
        end;
    end;
end;
u32(u25, true);
local v33 = {
    Levels = u21,
    AssertLevel = v23
};
setmetatable(v33, {
    __index = u24
});
function v33.GetLevel() --[[ Line: 145 ]]
    -- upvalues: u25 (ref)
    return u25;
end;
function v33.SetLevel(p34) --[[ Line: 149 ]]
    -- upvalues: u32 (copy)
    u32(p34);
end;
function v33.Sink(p35) --[[ Line: 153 ]]
    -- upvalues: u24 (copy)
    return assert(u24[p35]);
end;
return table.freeze(v33);