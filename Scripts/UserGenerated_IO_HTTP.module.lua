-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
local l__Asserts__2 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local v1 = l__Asserts__2.Set({
    "GET",
    "HEAD",
    "POST",
    "PUT",
    "DELETE",
    "OPTIONS",
    "TRACE",
    "PATCH"
});
local v2 = l__Asserts__2.Optional(l__Asserts__2.Enum(Enum.HttpCompression));
local u3 = l__Asserts__2.Table({
    Url = l__Asserts__2.String,
    Method = v1,
    Headers = l__Asserts__2.Optional(l__Asserts__2.Map(l__Asserts__2.String, l__Asserts__2.String)),
    Body = l__Asserts__2.Optional(l__Asserts__2.RawString),
    Compress = v2,
    NoCache = l__Asserts__2.Optional(l__Asserts__2.Boolean)
});
return table.freeze({
    AssertCompress = v2,
    AssertMethod = v1,
    AssertParams = u3,
    Execute = function(p4) --[[ Name: Execute, Line 69 ]]
        -- upvalues: u3 (copy), l__HttpService__1 (copy)
        u3(p4);
        local v5 = p4.Headers or {};
        if p4.NoCache then
            v5 = table.clone(v5);
            v5["Cache-Control"] = "no-cache, no-store, must-revalidate";
            v5.Pragma = "no-cache";
            v5.Expires = "0";
        end;
        local v6, v7 = pcall(l__HttpService__1.RequestAsync, l__HttpService__1, {
            Url = p4.Url,
            Method = p4.Method,
            Headers = v5,
            Body = p4.Body,
            Compress = p4.Compress
        });
        return not v6 and {
            Success = false,
            StatusCode = 400,
            StatusMessage = tostring(v7),
            Headers = {}
        } or v7;
    end
});