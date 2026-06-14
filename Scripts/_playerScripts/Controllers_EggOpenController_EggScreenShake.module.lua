-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__CamShake__3 = require(l__ReplicatedStorage__2.ClientModules.CamShake);
return {
    begin = function(p1, p2) --[[ Name: begin, Line 119 ]]
        -- upvalues: l__Players__1 (copy), l__CamShake__3 (copy)
        return {
            _maxGrowTier = 0,
            _resolved = false,
            _eggPosition = p1,
            _pathSize = p2 ~= "Big" and p2 ~= "Huge" and "Normal" or p2,
            onWobbleBeat = function(_, _) --[[ Name: onWobbleBeat, Line 129 ]] end,
            onGrowBeat = function(p3, p4, _) --[[ Name: onGrowBeat, Line 132 ]]
                -- upvalues: l__Players__1 (ref), l__CamShake__3 (ref)
                if p3._resolved or p3._pathSize == "Normal" then
                else
                    p3._maxGrowTier = math.max(p3._maxGrowTier, p4);
                    if p3._pathSize == "Normal" then
                    elseif p4 < 1 then
                    else
                        local l___eggPosition__4 = p3._eggPosition;
                        local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
                        if l__LocalPlayer__5 then
                            l__LocalPlayer__5 = l__LocalPlayer__5.Character;
                        end;
                        if l__LocalPlayer__5 then
                            l__LocalPlayer__5 = l__LocalPlayer__5:FindFirstChild("HumanoidRootPart");
                        end;
                        if not (l__LocalPlayer__5 and l__LocalPlayer__5:IsA("BasePart")) then
                            l__LocalPlayer__5 = nil;
                        end;
                        local v5;
                        if l__LocalPlayer__5 then
                            v5 = (l__LocalPlayer__5.Position - l___eggPosition__4).Magnitude <= 250;
                        else
                            v5 = false;
                        end;
                        if v5 then
                            local l___pathSize__6 = p3._pathSize;
                            local v6 = p4 - 1;
                            l__CamShake__3:ShakeOnce((v6 * 0.85 + 1.4) * (l___pathSize__6 == "Huge" and 1.25 or 1) * 1, v6 * 3 + 8, 0.04, 0.4, Vector3.new(0.3, 0.3, 0.3), Vector3.new(2, 2, 5));
                        end;
                    end;
                end;
            end,
            onHatch = function(_, _) --[[ Name: onHatch, Line 140 ]] end,
            onPetRevealed = function(p7) --[[ Name: onPetRevealed, Line 143 ]]
                -- upvalues: l__Players__1 (ref), l__CamShake__3 (ref)
                if p7._resolved or p7._pathSize == "Normal" then
                else
                    p7._resolved = true;
                    if p7._pathSize == "Normal" then
                    elseif p7._maxGrowTier < 1 then
                    else
                        local l___eggPosition__7 = p7._eggPosition;
                        local l__LocalPlayer__8 = l__Players__1.LocalPlayer;
                        if l__LocalPlayer__8 then
                            l__LocalPlayer__8 = l__LocalPlayer__8.Character;
                        end;
                        if l__LocalPlayer__8 then
                            l__LocalPlayer__8 = l__LocalPlayer__8:FindFirstChild("HumanoidRootPart");
                        end;
                        if not (l__LocalPlayer__8 and l__LocalPlayer__8:IsA("BasePart")) then
                            l__LocalPlayer__8 = nil;
                        end;
                        local v8;
                        if l__LocalPlayer__8 then
                            v8 = (l__LocalPlayer__8.Position - l___eggPosition__7).Magnitude <= 250;
                        else
                            v8 = false;
                        end;
                        if v8 then
                            local v9 = p7._maxGrowTier + 1;
                            local l___pathSize__9 = p7._pathSize;
                            local v10 = v9 - 1;
                            l__CamShake__3:ShakeOnce((v10 * 0.85 + 1.4) * (l___pathSize__9 == "Huge" and 1.25 or 1) * 1, v10 * 3 + 8, 0.08, 0.8, Vector3.new(0.3, 0.3, 0.3), Vector3.new(2, 2, 5));
                        end;
                    end;
                end;
            end,
            finishHatch = function(p11) --[[ Name: finishHatch, Line 151 ]]
                p11._resolved = true;
            end
        };
    end
};