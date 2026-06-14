-- Decompiled with Potassium's decompiler.

local u1 = {
    Dev = 9638499374,
    Live = 10200395747
};
local u2 = {
    Dev = {
        Primary = 132935919810877,
        NewUser = 99129412870047,
        FirstSession = 115012049182484
    },
    Live = {
        Primary = 97598239454123,
        NewUser = 133438856880402,
        FirstSession = 77085202503540
    }
};
local v3 = {
    Dev = {
        InstantPurchases = true
    },
    Live = {
        InstantPurchases = false
    }
};
local v4 = {
    Dev = 4
};
local l__RunService__1 = game:GetService("RunService");
local v7 = (function() --[[ Name: ResolveEnv, Line 68 ]]
    -- upvalues: u1 (copy), l__RunService__1 (copy)
    for v5, v6 in u1 do
        if v6 == game.GameId then
            return v5;
        end;
    end;
    if l__RunService__1:IsStudio() then
        return "Dev";
    end;
    warn((`[Environment] unknown gameId {game.GameId}; defaulting to Live`));
    return "Live";
end)();
local v11 = (function(p8) --[[ Name: ResolvePlaceType, Line 85 ]]
    -- upvalues: u2 (copy), l__RunService__1 (copy)
    for v9, v10 in u2[p8] do
        if v10 == game.PlaceId then
            return v9;
        end;
    end;
    if not l__RunService__1:IsStudio() then
        warn((`[Environment] unknown placeId {game.PlaceId}; treating as Primary`));
    end;
    return "Primary";
end)(v7);
local v12;
if l__RunService__1:IsServer() then
    v12 = game.PrivateServerId == "" and "Standard" or (game.PrivateServerOwnerId == 0 and "Reserved" or "Private");
    script:SetAttribute("serverType", v12);
else
    v12 = script:GetAttribute("serverType");
    if v12 == nil then
        script:GetAttributeChangedSignal("serverType"):Wait();
        v12 = script:GetAttribute("serverType");
    end;
    local v13 = typeof(v12) == "string";
    local v14 = `serverType attribute missing or invalid: {tostring(v12)}`;
    assert(v13, v14);
end;
return table.freeze({
    env = v7,
    gameId = u1[v7],
    placeType = v11,
    placeId = game.PlaceId,
    places = table.freeze(u2[v7]),
    serverType = v12,
    config = table.freeze(v3[v7]),
    dataStoreVersion = v4[v7]
});