-- Decompiled with Potassium's decompiler.

local l__Networking__1 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"));
local l__Players__2 = game:GetService("Players");
game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__Zone__4 = require(game.ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Zone"));
local u1 = {
    Color3.fromRGB(231, 71, 204),
    Color3.fromRGB(47, 121, 231),
    Color3.fromRGB(55, 231, 126),
    Color3.fromRGB(190, 231, 55),
    Color3.fromRGB(231, 129, 46),
    Color3.fromRGB(231, 55, 55),
    Color3.fromRGB(120, 55, 231),
    Color3.fromRGB(55, 210, 231),
    Color3.fromRGB(231, 55, 120),
    Color3.fromRGB(231, 210, 55)
};
local function u27(p2) --[[ Line: 40 ]]
    -- upvalues: u1 (copy)
    local v3 = p2:GetAttribute("ExtraData");
    local v4;
    if type(v3) == "number" then
        local v5 = #u1;
        if v5 <= 0 then
            v4 = 1;
        else
            local v6 = tonumber(v3) or 1;
            v4 = (math.floor(v6) - 1) % v5 + 1;
        end;
    elseif type(v3) == "string" then
        local v7 = v3:match("(%d+)");
        local v8 = tonumber(v7) or 1;
        local v9 = #u1;
        if v9 <= 0 then
            v4 = 1;
        else
            local v10 = tonumber(v8) or 1;
            v4 = (math.floor(v10) - 1) % v9 + 1;
        end;
    else
        v4 = 1;
    end;
    local v11 = p2:GetAttribute("PropId");
    local v12 = 0;
    local v13 = 0;
    local v14 = 0;
    local v15 = 0;
    local v16 = {};
    for _, v17 in p2.Parent:GetDescendants() do
        if v17:IsA("Model") then
            v12 = v12 + 1;
            local v18 = v17:GetAttribute("PropName");
            if v18 and string.find(v18, "Teleport Pad") then
                v13 = v13 + 1;
                local v19 = v17:GetAttribute("ExtraData");
                local v20;
                if type(v19) == "number" then
                    local v21 = #u1;
                    if v21 <= 0 then
                        v20 = 1;
                    else
                        local v22 = tonumber(v19) or 1;
                        v20 = (math.floor(v22) - 1) % v21 + 1;
                    end;
                elseif type(v19) == "string" then
                    local v23 = v19:match("(%d+)");
                    local v24 = tonumber(v23) or 1;
                    local v25 = #u1;
                    if v25 <= 0 then
                        v20 = 1;
                    else
                        local v26 = tonumber(v24) or 1;
                        v20 = (math.floor(v26) - 1) % v25 + 1;
                    end;
                else
                    v20 = 1;
                end;
                if v17:GetAttribute("PropId") == v11 then
                    v15 = v15 + 1;
                elseif v20 == v4 then
                    table.insert(v16, v17);
                else
                    v14 = v14 + 1;
                end;
            end;
        end;
    end;
    return #v16 > 0 and v16[math.random(1, #v16)] or nil;
end;
local l__Teleport__5 = game.SoundService.SFX.Teleport;
return function(u28) --[[ Line: 78 ]]
    -- upvalues: l__Players__2 (copy), u1 (copy), l__Networking__1 (copy), l__Zone__4 (copy), l__TweenService__3 (copy), u27 (copy), l__Teleport__5 (copy)
    local u29;
    repeat
        u29 = game:GetService("Players"):GetPlayerByUserId(u28:GetAttribute("UserId"));
    until u29 and u28:IsDescendantOf(workspace);
    local u30 = u28:FindFirstChild("TouchPart");
    if u29 == l__Players__2.LocalPlayer then
        u28:WaitForChild("ProximityPromptPart"):WaitForChild("ProximityPrompt").Triggered:Connect(function() --[[ Line: 90 ]]
            -- upvalues: u28 (copy), u1 (ref), l__Networking__1 (ref)
            local v31 = u28:GetAttribute("ExtraData");
            local v32;
            if type(v31) == "number" then
                local v33 = #u1;
                if v33 <= 0 then
                    v32 = 1;
                else
                    local v34 = tonumber(v31) or 1;
                    v32 = (math.floor(v34) - 1) % v33 + 1;
                end;
            elseif type(v31) == "string" then
                local v35 = v31:match("(%d+)");
                local v36 = tonumber(v35) or 1;
                local v37 = #u1;
                if v37 <= 0 then
                    v32 = 1;
                else
                    local v38 = tonumber(v36) or 1;
                    v32 = (math.floor(v38) - 1) % v37 + 1;
                end;
            else
                v32 = 1;
            end;
            local v39 = v32 + 1;
            local v40 = #u1;
            local v41;
            if v40 <= 0 then
                v41 = 1;
            else
                local v42 = tonumber(v39) or 1;
                v41 = (math.floor(v42) - 1) % v40 + 1;
            end;
            local v43 = u28:GetAttribute("PropId") or u28.Name;
            l__Networking__1.Prop.SetPropExtraData:Fire(v43, (tostring(v41)));
        end);
    end;
    u28:FindFirstChild("Zone");
    local v44 = l__Zone__4.new({ u28:WaitForChild("Zone") });
    local function v53() --[[ Line: 101 ]]
        -- upvalues: u28 (copy), u1 (ref), u30 (copy)
        local v45 = u28:GetAttribute("ExtraData");
        local v46;
        if type(v45) == "number" then
            local v47 = #u1;
            if v47 <= 0 then
                v46 = 1;
            else
                local v48 = tonumber(v45) or 1;
                v46 = (math.floor(v48) - 1) % v47 + 1;
            end;
        elseif type(v45) == "string" then
            local v49 = v45:match("(%d+)");
            local v50 = tonumber(v49) or 1;
            local v51 = #u1;
            if v51 <= 0 then
                v46 = 1;
            else
                local v52 = tonumber(v50) or 1;
                v46 = (math.floor(v52) - 1) % v51 + 1;
            end;
        else
            v46 = 1;
        end;
        u30.Color = u1[v46];
    end;
    local u54 = u28.PrimaryPart or u28:FindFirstChildWhichIsA("BasePart");
    local u55 = u54.CFrame:ToObjectSpace(u30.CFrame);
    local u56 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local u57 = nil;
    v44.localPlayerEntered:Connect(function() --[[ Line: 112 ]]
        -- upvalues: u28 (copy), u54 (copy), u55 (copy), l__TweenService__3 (ref), u30 (copy), u56 (copy), l__Players__2 (ref), u57 (ref), u27 (ref), l__Teleport__5 (ref), u29 (ref)
        if not u28:GetAttribute("IsBeingMoved") then
            l__TweenService__3:Create(u30, u56, {
                CFrame = u54.CFrame * u55 * CFrame.new(0, -0.1, 0)
            }):Play();
        end;
        local l__Character__6 = l__Players__2.LocalPlayer.Character;
        local v58;
        if l__Character__6 then
            v58 = l__Character__6:GetAttribute("_TelepadArrival");
        else
            v58 = l__Character__6;
        end;
        if v58 then
            l__Character__6:SetAttribute("_TelepadArrival", nil);
        end;
        u57 = task.delay(v58 and 5 or 0.1, function() --[[ Line: 128 ]]
            -- upvalues: u27 (ref), u28 (ref), u30 (ref), l__Teleport__5 (ref), u57 (ref), l__Character__6 (copy), u29 (ref), l__Players__2 (ref)
            local v59 = u27(u28);
            if v59 then
                local v60 = u30:FindFirstChild("Break");
                l__Teleport__5.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                l__Teleport__5.TimePosition = 0;
                l__Teleport__5.Playing = true;
                if v60 then
                    v60:Emit(5);
                end;
            end;
            task.wait(0.2);
            u57 = nil;
            if v59 then
                local v61 = l__Character__6;
                if v61 then
                    v61 = l__Character__6:FindFirstChild("HumanoidRootPart");
                end;
                local v62 = l__Character__6 and v61 and (v59:FindFirstChild("TouchPart") or (v59.PrimaryPart or v59:FindFirstChildWhichIsA("BasePart")));
                if v62 then
                    local v63 = v62.CFrame * CFrame.new(0, 3.5, 0);
                    l__Character__6:SetAttribute("_TelepadArrival", true);
                    l__Character__6:PivotTo(v63);
                end;
            elseif u29 == l__Players__2.LocalPlayer then
                game.ReplicatedStorage.Notify:Fire("This teleport pad has no destination!");
            end;
        end);
    end);
    v44.localPlayerExited:Connect(function() --[[ Line: 164 ]]
        -- upvalues: u28 (copy), u54 (copy), u55 (copy), l__TweenService__3 (ref), u30 (copy), u56 (copy), u57 (ref)
        if not u28:GetAttribute("IsBeingMoved") then
            l__TweenService__3:Create(u30, u56, {
                CFrame = u54.CFrame * u55
            }):Play();
        end;
        if u57 then
            task.cancel(u57);
            u57 = nil;
        end;
    end);
    local v64 = u28:GetAttribute("ExtraData");
    local v65;
    if type(v64) == "number" then
        local v66 = #u1;
        if v66 <= 0 then
            v65 = 1;
        else
            local v67 = tonumber(v64) or 1;
            v65 = (math.floor(v67) - 1) % v66 + 1;
        end;
    elseif type(v64) == "string" then
        local v68 = v64:match("(%d+)");
        local v69 = tonumber(v68) or 1;
        local v70 = #u1;
        if v70 <= 0 then
            v65 = 1;
        else
            local v71 = tonumber(v69) or 1;
            v65 = (math.floor(v71) - 1) % v70 + 1;
        end;
    else
        v65 = 1;
    end;
    u30.Color = u1[v65];
    u28:GetAttributeChangedSignal("ExtraData"):Connect(v53);
end;