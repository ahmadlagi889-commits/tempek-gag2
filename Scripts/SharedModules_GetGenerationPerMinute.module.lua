-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__GardenSyncController__3 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController);
local l__SeedData__4 = require(l__ReplicatedStorage__2.SharedModules.SeedData);
local l__SellValueData__5 = require(l__ReplicatedStorage__2.SharedModules.SellValueData);
local u1 = {};
for _, v2 in l__SeedData__4 do
    u1[v2.SeedName or v2.PlantName] = v2;
end;
return function(p3) --[[ Name: GetGenerationPerMinute, Line 13 ]]
    -- upvalues: l__Players__1 (copy), l__GardenSyncController__3 (copy), l__SellValueData__5 (copy), u1 (copy)
    local v4;
    if p3 then
        v4 = p3.UserId;
    else
        v4 = l__Players__1.LocalPlayer.UserId;
    end;
    local v5 = l__GardenSyncController__3:GetGarden(v4);
    if not (v5 and next(v5)) then
        return 0;
    end;
    local v6 = {};
    for _, v7 in v5 do
        local l__PlantName__6 = v7.PlantName;
        if l__PlantName__6 then
            local v8 = l__SellValueData__5[l__PlantName__6] or 0;
            if v8 > 0 then
                local v9 = u1[l__PlantName__6];
                if v9 and v9.IsSingleHarvest or false then
                    table.insert(v6, {
                        isSingleHarvest = true,
                        value = v8
                    });
                else
                    local l__MaxFruitSpawnLocations__7 = v7.MaxFruitSpawnLocations;
                    for _ = 1, (not l__MaxFruitSpawnLocations__7 or l__MaxFruitSpawnLocations__7 == 0) and 1 or l__MaxFruitSpawnLocations__7 do
                        table.insert(v6, {
                            isSingleHarvest = false,
                            value = v8
                        });
                    end;
                end;
            end;
        end;
    end;
    table.sort(v6, function(p10, p11) --[[ Line: 50 ]]
        return p10.value > p11.value;
    end);
    local v12 = 0;
    for v13 = 1, math.min(#v6, 100) do
        local v14 = v6[v13];
        if v14.isSingleHarvest then
            v12 = v12 + v14.value;
        else
            v12 = v12 + v14.value * 6;
        end;
    end;
    return v12;
end;