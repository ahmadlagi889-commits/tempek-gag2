-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
local l__Keys__2 = require(game.ReplicatedStorage.UserGenerated.Lang.Keys);
local l__Asserts__3 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local l__JSONEncoder__4 = require(game.ReplicatedStorage.UserGenerated.IO.JSONEncoder);
local u1 = {
    http = 80,
    https = 443
};
local v2 = l__Asserts__3.Optional(l__Asserts__3.Set(l__Keys__2(u1)));
local l__String__5 = l__Asserts__3.String;
local v3 = l__Asserts__3.Optional(l__Asserts__3.IntegerRange(0, 65535));
local function v5(p4) --[[ Line: 34 ]]
    if type(p4) ~= "string" then
        error("string", 2);
    end;
    if not utf8.len(p4) then
        error("UTF8", 2);
    end;
    if #p4 > 0 and string.byte(p4, 1) ~= 47 then
        error("PathPrefix", 2);
    end;
    return p4;
end;
local u6 = l__Asserts__3.Map(l__Asserts__3.String, l__Asserts__3.Any);
local u7 = l__Asserts__3.Table({
    Protocol = v2,
    Host = l__String__5,
    Port = v3,
    Path = v5,
    Params = l__Asserts__3.Optional(u6),
    Fragment = l__Asserts__3.Optional(l__Asserts__3.String)
});
local u16 = {
    AssertProtocol = v2,
    AssertHost = l__String__5,
    AssertPort = v3,
    AssertPath = v5,
    AssertEncodeParams = u6,
    AssertParams = u7,
    EncodePath = function(p8) --[[ Name: EncodePath, Line 72 ]]
        -- upvalues: l__Asserts__3 (copy), l__HttpService__1 (copy)
        l__Asserts__3.String(p8);
        return p8:gsub("([^/]+)", function(p9) --[[ Line: 76 ]]
            -- upvalues: l__HttpService__1 (ref)
            return l__HttpService__1:UrlEncode(p9);
        end);
    end,
    EncodeParams = function(p10) --[[ Name: EncodeParams, Line 82 ]]
        -- upvalues: u6 (copy), l__Keys__2 (copy), l__JSONEncoder__4 (copy), l__HttpService__1 (copy)
        u6(p10);
        local v11 = l__Keys__2(p10);
        table.sort(v11);
        local v12 = {};
        for _, v13 in ipairs(v11) do
            local v14 = l__JSONEncoder__4.Compact(p10[v13]);
            local v15 = l__HttpService__1:UrlEncode(v13) .. "=" .. l__HttpService__1:UrlEncode(v14);
            table.insert(v12, v15);
        end;
        return table.concat(v12, "&");
    end
};
function u16.Build(p17) --[[ Line: 99 ]]
    -- upvalues: u7 (copy), u1 (copy), u16 (copy), l__HttpService__1 (copy)
    u7(p17);
    local v18 = p17.Protocol or "https";
    local v19 = u1[v18] or 80;
    local v20 = p17.Port or v19;
    local v21 = {};
    table.insert(v21, v18);
    table.insert(v21, "://");
    table.insert(v21, p17.Host);
    if v20 ~= v19 then
        table.insert(v21, ":");
        local v22 = tostring(v20);
        table.insert(v21, v22);
    end;
    table.insert(v21, u16.EncodePath(p17.Path));
    local l__Params__6 = p17.Params;
    if l__Params__6 and next(l__Params__6) ~= nil then
        table.insert(v21, "?");
        table.insert(v21, u16.EncodeParams(l__Params__6));
    end;
    if p17.Fragment then
        table.insert(v21, "#");
        table.insert(v21, l__HttpService__1:UrlEncode(p17.Fragment));
    end;
    return table.concat(v21);
end;
return table.freeze(u16);