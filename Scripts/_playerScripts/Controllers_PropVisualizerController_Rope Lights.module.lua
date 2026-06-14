-- Decompiled with Potassium's decompiler.

local l__Networking__1 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"));
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
local l__SmartProximityPrompt__4 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("SmartProximityPrompt"));
local u1 = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(255, 60, 60),
    Color3.fromRGB(255, 150, 60),
    Color3.fromRGB(255, 235, 80),
    Color3.fromRGB(255, 130, 200),
    Color3.fromRGB(170, 95, 255),
    Color3.fromRGB(80, 255, 120),
    Color3.fromRGB(80, 160, 255)
};
return function(u2) --[[ Line: 21 ]]
    -- upvalues: l__Players__2 (copy), u1 (copy), l__RunService__3 (copy), l__SmartProximityPrompt__4 (copy), l__Networking__1 (copy)
    local v3;
    repeat
        v3 = l__Players__2:GetPlayerByUserId(u2:GetAttribute("UserId"));
    until v3;
    local function u24(p4) --[[ Line: 55 ]]
        local v5 = {};
        local v6 = {};
        for _, v7 in (p4:FindFirstChild("Build") or p4):GetDescendants() do
            if v7:IsA("BasePart") then
                local v8 = v7:GetAttribute("String");
                local v9 = tonumber(v8);
                if v9 then
                    v5[v9] = v5[v9] or {};
                    table.insert(v5[v9], v7);
                end;
            end;
        end;
        for v10, v11 in v5 do
            table.sort(v11, function(p12, p13) --[[ Line: 73 ]]
                local v14 = tonumber(p12:GetAttribute("Index"));
                local v15 = tonumber(p13:GetAttribute("Index"));
                if v14 and (v15 and v14 ~= v15) then
                    return v14 < v15;
                else
                    local v16 = p12.Name:match("(%d+)");
                    local v17 = v16 and tonumber(v16) or nil;
                    local v18 = p13.Name:match("(%d+)");
                    local v19 = v18 and tonumber(v18) or nil;
                    if v17 and (v19 and v17 ~= v19) then
                        return v17 < v19;
                    else
                        local l__Position__5 = p12.Position;
                        local l__Position__6 = p13.Position;
                        if l__Position__5.X == l__Position__6.X then
                            if l__Position__5.Z == l__Position__6.Z then
                                return l__Position__5.Y < l__Position__6.Y;
                            else
                                return l__Position__5.Z < l__Position__6.Z;
                            end;
                        else
                            return l__Position__5.X < l__Position__6.X;
                        end;
                    end;
                end;
            end);
            for v20, v21 in ipairs(v11) do
                local v22 = {};
                for _, v23 in v21:GetChildren() do
                    if v23:IsA("Light") then
                        table.insert(v22, {
                            Obj = v23,
                            BaseBrightness = v23.Brightness
                        });
                    end;
                end;
                v6[v21] = {
                    StringId = v10,
                    Index = v20,
                    Lights = v22
                };
            end;
        end;
        return v5, v6;
    end;
    local u25 = nil;
    local function u31(p26, p27, p28, p29) --[[ Line: 116 ]]
        p26.Material = Enum.Material.Neon;
        p26.Color = p28;
        for _, v30 in ipairs(p27.Lights) do
            local l__Obj__7 = v30.Obj;
            if l__Obj__7 and l__Obj__7.Parent then
                l__Obj__7.Color = p28;
                l__Obj__7.Brightness = v30.BaseBrightness * p29;
            end;
        end;
    end;
    local function u58(p32) --[[ Line: 129 ]]
        -- upvalues: u25 (ref), u1 (ref), u24 (copy), u2 (copy), u31 (copy), l__RunService__3 (ref)
        if u25 then
            u25:Disconnect();
            u25 = nil;
        end;
        local v33 = u1;
        local v34 = #u1;
        local v35 = tonumber(p32) or 1;
        local v36 = v33[(math.floor(v35) - 1) % v34 + 1];
        local u37, u38 = u24(u2);
        local u39, u40, _ = v36:ToHSV();
        local u41 = workspace:GetAttribute("ActivePhase") == "Night" and 1 or 0.5;
        local u42 = workspace:GetAttribute("ActivePhase") == "Night";
        local u43 = u41;
        local u44 = 1;
        for _, v45 in u37 do
            for _, v46 in ipairs(v45) do
                local v47 = u38[v46];
                if v47 then
                    u31(v46, v47, Color3.fromHSV(u39, u40, u41), (u41 - 0.5) / 0.5 * 0.85 + 0.15);
                end;
            end;
        end;
        u25 = l__RunService__3.RenderStepped:Connect(function(p48) --[[ Line: 161 ]]
            -- upvalues: u2 (ref), u25 (ref), u42 (ref), u43 (ref), u44 (ref), u41 (ref), u39 (copy), u40 (copy), u37 (copy), u38 (copy), u31 (ref)
            if u2.Parent then
                local v49 = workspace:GetAttribute("ActivePhase") == "Night";
                if v49 ~= u42 then
                    u42 = v49;
                    u43 = v49 and 1 or 0.5;
                    u44 = 0;
                end;
                if u44 >= 1 then
                else
                    u44 = math.min(u44 + p48, 1);
                    local v50 = u44 / 1;
                    local v51 = v50 * v50 * (3 - v50 * 2);
                    local v52 = u43 == 1 and 0.5 or 1;
                    u41 = v52 + (u43 - v52) * v51;
                    local v53 = Color3.fromHSV(u39, u40, u41);
                    local v54 = (u41 - 0.5) / 0.5 * 0.85 + 0.15;
                    for _, v55 in u37 do
                        for _, v56 in ipairs(v55) do
                            local v57 = u38[v56];
                            if v57 then
                                u31(v56, v57, v53, v54);
                            end;
                        end;
                    end;
                end;
            else
                if u25 then
                    u25:Disconnect();
                    u25 = nil;
                end;
            end;
        end);
    end;
    local function v67() --[[ Line: 203 ]]
        -- upvalues: u2 (copy), u1 (ref), u58 (copy)
        local v59 = u2:GetAttribute("ExtraData");
        local v60;
        if type(v59) == "number" then
            local v61 = #u1;
            local v62 = tonumber(v59) or 1;
            v60 = (math.floor(v62) - 1) % v61 + 1;
        elseif type(v59) == "string" then
            local v63 = v59:match("(%d+)");
            local v64 = tonumber(v63) or 1;
            local v65 = #u1;
            local v66 = tonumber(v64) or 1;
            v60 = (math.floor(v66) - 1) % v65 + 1;
        else
            v60 = 1;
        end;
        u58(v60);
    end;
    local v68 = u2:GetAttribute("ExtraData");
    local v69;
    if type(v68) == "number" then
        local v70 = #u1;
        local v71 = tonumber(v68) or 1;
        v69 = (math.floor(v71) - 1) % v70 + 1;
    elseif type(v68) == "string" then
        local v72 = v68:match("(%d+)");
        local v73 = tonumber(v72) or 1;
        local v74 = #u1;
        local v75 = tonumber(v73) or 1;
        v69 = (math.floor(v75) - 1) % v74 + 1;
    else
        v69 = 1;
    end;
    u58(v69);
    u2:GetAttributeChangedSignal("ExtraData"):Connect(v67);
    if v3 == l__Players__2.LocalPlayer then
        local v76 = u2:FindFirstChild("Primary");
        if v76 and v76:FindFirstChild("ChangeColour") then
            local l__ChangeColour__8 = v76.ChangeColour;
            if l__ChangeColour__8 and l__ChangeColour__8:IsA("ProximityPrompt") then
                l__SmartProximityPrompt__4.AttachToModel(l__ChangeColour__8, u2, {
                    PartName = "ChangeColourPart",
                    MaxActivationDistance = 10,
                    TrackDistance = 24,
                    SurfaceOffset = 0.75,
                    FollowSpeed = 18
                });
                l__ChangeColour__8.Triggered:Connect(function() --[[ Line: 230 ]]
                    -- upvalues: u2 (copy), u1 (ref), l__Networking__1 (ref)
                    local v77 = u2:GetAttribute("ExtraData");
                    local v78;
                    if type(v77) == "number" then
                        local v79 = #u1;
                        local v80 = tonumber(v77) or 1;
                        v78 = (math.floor(v80) - 1) % v79 + 1;
                    elseif type(v77) == "string" then
                        local v81 = v77:match("(%d+)");
                        local v82 = tonumber(v81) or 1;
                        local v83 = #u1;
                        local v84 = tonumber(v82) or 1;
                        v78 = (math.floor(v84) - 1) % v83 + 1;
                    else
                        v78 = 1;
                    end;
                    local v85 = v78 + 1;
                    local v86 = #u1;
                    local v87 = tonumber(v85) or 1;
                    local v88 = (math.floor(v87) - 1) % v86 + 1;
                    local v89 = u2:GetAttribute("PropId") or u2.Name;
                    l__Networking__1.Prop.SetPropExtraData:Fire(v89, (tostring(v88)));
                end);
            end;
        end;
    else
        local v90 = u2:FindFirstChild("Primary");
        if v90 then
            v90:ClearAllChildren();
        end;
    end;
end;