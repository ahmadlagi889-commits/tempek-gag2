-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Players__3 = game:GetService("Players");
local l__Networking__4 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local u1 = {};
local v2 = {};
local u3 = {};
for _, v4 in require(l__ReplicatedStorage__2.SharedModules.SeedData) do
    u1[v4.SeedName] = v4;
end;
local u5 = {};
local function u9(p6) --[[ Line: 41 ]]
    local v7 = {};
    for _, v8 in p6:GetDescendants() do
        if v8:IsA("BasePart") then
            v7[v8] = v8.Color;
        end;
    end;
    return v7;
end;
local function u17(p10, p11) --[[ Line: 67 ]]
    for v12, v13 in p10 do
        if v12.Parent then
            local v14, v15, v16 = Color3.toHSV(v13);
            v12.Color = Color3.fromHSV(v14, v15 * (1 - p11 * 0.75), v16);
        end;
    end;
end;
function v2.GetDecayAlpha(_, p18, p19) --[[ Line: 81 ]]
    -- upvalues: u5 (copy), u1 (copy)
    local v20 = u5[tostring(p18) .. "_" .. p19];
    if v20 then
        local v21 = u1[v20.SeedName];
        if v21 and v21.PrimeTime then
            if v20.Mutation or v21.AlwaysPrime then
                return 0, true;
            elseif v20.DisplayDecayAlpha == nil then
                local v22 = os.time() - v20.PrimeStartedAt;
                if v22 < v21.PrimeTime then
                    return 0, false;
                else
                    return math.clamp((v22 - v21.PrimeTime) / (v21.PrimeTime * 100), 0, 1) * (1 - (v20.ReviveProgress or 0)), false;
                end;
            else
                return v20.DisplayDecayAlpha, true;
            end;
        else
            return 0, true;
        end;
    else
        return nil, false;
    end;
end;
local function u36(p23, p24, p25, p26, p27, p28, p29) --[[ Line: 106 ]]
    -- upvalues: u1 (copy), u5 (copy), u9 (copy)
    local v30 = u1[p25];
    if v30 and v30.PrimeTime then
        local v31 = tostring(p23) .. "_" .. p24;
        if u5[v31] then
            u5[v31].PrimeStartedAt = p26;
            u5[v31].SeedName = p25;
            u5[v31].ReviveProgress = p28 or (u5[v31].ReviveProgress or 0);
            u5[v31].ReviveProgressTarget = p28 or (u5[v31].ReviveProgressTarget or 0);
            u5[v31].Mutation = p29;
            if p27 then
                u5[v31].Model = p27;
                if not (u5[v31].OriginalColors and next(u5[v31].OriginalColors)) then
                    u5[v31].OriginalColors = u9(p27);
                    u5[v31].LastAppliedColorSig = nil;
                end;
                local u32 = u5[v31];
                if u32.DescendantAddedConn then
                    u32.DescendantAddedConn:Disconnect();
                    u32.DescendantAddedConn = nil;
                end;
                u32.DescendantAddedConn = p27.DescendantAdded:Connect(function(p33) --[[ Line: 57 ]]
                    -- upvalues: u32 (copy)
                    if p33:IsA("BasePart") then
                        local l__OriginalColors__5 = u32.OriginalColors;
                        if l__OriginalColors__5 and l__OriginalColors__5[p33] == nil then
                            l__OriginalColors__5[p33] = p33.Color;
                            u32.LastAppliedColorSig = nil;
                        end;
                    end;
                end);
            end;
        elseif p27 then
            u5[v31] = {
                DisplayDecayAlpha = nil,
                PrimeStartedAt = p26,
                SeedName = p25,
                Model = p27,
                OriginalColors = u9(p27),
                ReviveProgress = p28 or 0,
                ReviveProgressTarget = p28 or 0,
                Mutation = p29
            };
            local u34 = u5[v31];
            if u34.DescendantAddedConn then
                u34.DescendantAddedConn:Disconnect();
                u34.DescendantAddedConn = nil;
            end;
            u34.DescendantAddedConn = p27.DescendantAdded:Connect(function(p35) --[[ Line: 57 ]]
                -- upvalues: u34 (copy)
                if p35:IsA("BasePart") then
                    local l__OriginalColors__6 = u34.OriginalColors;
                    if l__OriginalColors__6 and l__OriginalColors__6[p35] == nil then
                        l__OriginalColors__6[p35] = p35.Color;
                        u34.LastAppliedColorSig = nil;
                    end;
                end;
            end);
        end;
    end;
end;
local function u43(p37, p38) --[[ Line: 149 ]]
    -- upvalues: u5 (copy)
    local v39 = tostring(p37) .. "_" .. p38;
    local v40 = u5[v39];
    if v40 then
        if v40.DescendantAddedConn then
            v40.DescendantAddedConn:Disconnect();
            v40.DescendantAddedConn = nil;
        end;
        if v40.OriginalColors then
            for v41, v42 in v40.OriginalColors do
                if v41.Parent then
                    v41.Color = v42;
                end;
            end;
        end;
    end;
    u5[v39] = nil;
end;
function v2.Init(_) --[[ Line: 172 ]]
    -- upvalues: l__Networking__4 (copy), u43 (copy), u5 (copy), u3 (copy), l__RunService__1 (copy), l__Players__3 (copy), u1 (copy), u17 (copy)
    l__Networking__4.Garden.PlantRemoved.OnClientEvent:Connect(function(p44, p45) --[[ Line: 174 ]]
        -- upvalues: u43 (ref)
        u43(p44, p45);
    end);
    l__Networking__4.Garden.PlantReviveProgressUpdated.OnClientEvent:Connect(function(p46, p47, p48) --[[ Line: 179 ]]
        -- upvalues: u5 (ref), u3 (ref)
        local v49 = tostring(p46) .. "_" .. p47;
        local v50 = u5[v49];
        if v50 then
            v50.ReviveProgressTarget = p48;
        end;
        local v51 = u3[v49];
        if v51 then
            v51.ReviveProgress = p48;
        end;
    end);
    l__Networking__4.Garden.PlantMutationUpdated.OnClientEvent:Connect(function(p52, p53, p54) --[[ Line: 194 ]]
        -- upvalues: u5 (ref)
        local v55 = u5[tostring(p52) .. "_" .. p53];
        if v55 then
            v55.Mutation = p54;
            v55.LastAppliedColorSig = nil;
        end;
    end);
    l__RunService__1.Heartbeat:Connect(function(p56) --[[ Line: 207 ]]
        -- upvalues: u5 (ref), l__Players__3 (ref), u1 (ref), u17 (ref)
        local v57 = os.time();
        for v58, v59 in u5 do
            if v59.Model and v59.Model.Parent then
                if l__Players__3.LocalPlayer:GetAttribute("PrimeEnabled") and not v59.Mutation then
                    local v60 = u1[v59.SeedName];
                    if v60 and (v60.PrimeTime and not v60.AlwaysPrime) then
                        local l__PrimeTime__7 = v60.PrimeTime;
                        local v61 = l__PrimeTime__7 * 100;
                        local v62 = v57 - v59.PrimeStartedAt;
                        local v63;
                        if l__PrimeTime__7 <= v62 then
                            local v64 = math.clamp((v62 - l__PrimeTime__7) / v61, 0, 1);
                            local v65 = v59.ReviveProgressTarget or (v59.ReviveProgress or 0);
                            local v66 = v59.ReviveProgress or 0;
                            if v66 ~= v65 then
                                if v66 < v65 then
                                    v59.ReviveProgress = math.min(v66 + 0.5 * p56, v65);
                                else
                                    v59.ReviveProgress = math.max(v66 - 0.5 * p56, v65);
                                end;
                            end;
                            v63 = v64 * (1 - (v59.ReviveProgress or 0));
                        else
                            v63 = 0;
                        end;
                        local l__DisplayDecayAlpha__8 = v59.DisplayDecayAlpha;
                        if l__DisplayDecayAlpha__8 == nil then
                            v59.DisplayDecayAlpha = v63;
                        else
                            local v67 = v63 - l__DisplayDecayAlpha__8;
                            if math.abs(v67) < 0.0001 then
                                v59.DisplayDecayAlpha = v63;
                            elseif math.abs(v67) < 0.01 then
                                v59.DisplayDecayAlpha = v63;
                            else
                                v59.DisplayDecayAlpha = l__DisplayDecayAlpha__8 + v67 * math.clamp(p56 / 1, 0, 1);
                            end;
                        end;
                        local v68 = v59.DisplayDecayAlpha or 0;
                        local v69 = math.floor(v68 * 1024 + 0.5);
                        if v59.LastAppliedColorSig ~= v69 then
                            v59.LastAppliedColorSig = v69;
                            u17(v59.OriginalColors, v68);
                        end;
                    end;
                end;
            else
                if v59.DescendantAddedConn then
                    v59.DescendantAddedConn:Disconnect();
                    v59.DescendantAddedConn = nil;
                end;
                u5[v58] = nil;
            end;
        end;
    end);
end;
function v2.RegisterPlantModel(_, p70, p71, p72, p73, p74, p75, p76) --[[ Line: 291 ]]
    -- upvalues: u1 (copy), u3 (copy), u36 (copy)
    if p73 and p73 > 0 then
        local v77 = u1[p72];
        if v77 and v77.PrimeTime then
            local v78 = tostring(p70) .. "_" .. p71;
            if p74 then
                local v79 = u3[v78];
                if v79 then
                    p73 = math.max(p73, v79.PrimeStartedAt);
                    p75 = p75 or v79.Mutation;
                    p76 = p76 or v79.ReviveProgress;
                    u3[v78] = nil;
                end;
                u36(p70, p71, p72, p73, p74, p76, p75);
            else
                u3[v78] = {
                    SeedName = p72,
                    PrimeStartedAt = p73,
                    Mutation = p75,
                    ReviveProgress = p76
                };
            end;
        end;
    end;
end;
function v2.UnregisterPlantModel(_, p80, p81) --[[ Line: 318 ]]
    -- upvalues: u43 (copy)
    u43(p80, p81);
end;
function v2.GetDecayAlphaByKey(p82, p83) --[[ Line: 323 ]]
    local v84, v85 = string.match(p83, "^(%d+)_(.+)$");
    if v84 and v85 then
        return p82:GetDecayAlpha(tonumber(v84), v85);
    else
        return nil, false;
    end;
end;
function v2.GetActiveEntries(_) --[[ Line: 329 ]]
    -- upvalues: u5 (copy)
    return u5;
end;
return v2;