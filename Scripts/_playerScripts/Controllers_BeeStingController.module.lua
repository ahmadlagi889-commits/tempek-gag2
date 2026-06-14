-- Decompiled with Potassium's decompiler.

local l__Lighting__1 = game:GetService("Lighting");
local l__Players__2 = game:GetService("Players");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__TweenService__5 = game:GetService("TweenService");
local l__LocalPlayer__6 = l__Players__2.LocalPlayer;
local l__Networking__7 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local v1 = {};
local u2 = false;
local u3 = 0;
local u4 = 0;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = (-1 / 0);
local u10 = 0;
local u11 = 0;
local u12 = nil;
local function u19() --[[ Line: 94 ]]
    -- upvalues: u12 (ref), l__LocalPlayer__6 (copy)
    if u12 then
        return u12;
    end;
    local v13 = l__LocalPlayer__6:FindFirstChild("PlayerScripts");
    if not v13 then
        return nil;
    end;
    local u14 = v13:FindFirstChild("PlayerModule");
    if not u14 then
        return nil;
    end;
    local v15, u16 = pcall(function() --[[ Line: 100 ]]
        -- upvalues: u14 (copy)
        return require(u14);
    end);
    if not (v15 and u16) then
        return nil;
    end;
    local v17, v18 = pcall(function() --[[ Line: 104 ]]
        -- upvalues: u16 (copy)
        return u16:GetControls();
    end);
    if not (v17 and v18) then
        return nil;
    end;
    u12 = v18;
    return u12;
end;
local u20 = nil;
local u21 = nil;
local u22 = false;
local function u29() --[[ Line: 123 ]]
    -- upvalues: u20 (ref), l__LocalPlayer__6 (copy)
    if u20 then
        return u20;
    end;
    local v23 = l__LocalPlayer__6:FindFirstChild("PlayerScripts");
    if not v23 then
        return nil;
    end;
    local v24 = v23:FindFirstChild("PlayerModule");
    if not v24 then
        return nil;
    end;
    local v25 = v24:FindFirstChild("CameraModule");
    if not v25 then
        return nil;
    end;
    local u26 = v25:FindFirstChild("CameraInput");
    if not u26 then
        return nil;
    end;
    local v27, v28 = pcall(function() --[[ Line: 133 ]]
        -- upvalues: u26 (copy)
        return require(u26);
    end);
    if not (v27 and v28) then
        return nil;
    end;
    u20 = v28;
    return u20;
end;
local function u34() --[[ Line: 141 ]]
    -- upvalues: l__LocalPlayer__6 (copy), l__Lighting__1 (copy), u6 (ref), u7 (ref), u8 (ref)
    local v30 = l__LocalPlayer__6:FindFirstChildOfClass("PlayerGui");
    if v30 then
        local v31 = Instance.new("ScreenGui");
        v31.Name = "BeeStingScreenEffect";
        v31.IgnoreGuiInset = true;
        v31.ResetOnSpawn = false;
        v31.DisplayOrder = 1000;
        v31.Parent = v30;
        local v32 = Instance.new("Frame");
        v32.Name = "RedFlash";
        v32.Size = UDim2.fromScale(1, 1);
        v32.BackgroundColor3 = Color3.fromRGB(255, 55, 55);
        v32.BackgroundTransparency = 1;
        v32.BorderSizePixel = 0;
        v32.ZIndex = 10;
        v32.Parent = v31;
        local v33 = Instance.new("BlurEffect");
        v33.Name = "BeeStingBlur";
        v33.Size = 1;
        v33.Enabled = true;
        v33.Parent = l__Lighting__1;
        u6 = v31;
        u7 = v32;
        u8 = v33;
    end;
end;
local function u36() --[[ Line: 186 ]]
    -- upvalues: l__LocalPlayer__6 (copy), l__TweenService__5 (copy)
    local l__Character__8 = l__LocalPlayer__6.Character;
    if l__Character__8 then
        local v35 = l__Character__8:FindFirstChildOfClass("Humanoid");
        if v35 then
            l__TweenService__5:Create(v35, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CameraOffset = Vector3.new(0, 0, 0)
            }):Play();
        end;
    end;
end;
local function u51() --[[ Line: 270 ]]
    -- upvalues: u6 (ref), u7 (ref), u8 (ref), u34 (copy), u2 (ref), u3 (ref), l__RunService__4 (copy), u19 (copy), l__LocalPlayer__6 (copy), u22 (ref), u29 (copy), u21 (ref), u5 (ref), u4 (ref), u20 (ref), u36 (copy), u9 (ref), u10 (ref), u11 (ref)
    if u6 then
        u6:Destroy();
        u6 = nil;
        u7 = nil;
    end;
    if u8 then
        u8:Destroy();
        u8 = nil;
    end;
    u34();
    if u7 then
        u2 = true;
        u3 = tick();
        l__RunService__4:BindToRenderStep("BeeStingInvertMovement", Enum.RenderPriority.Input.Value + 1, function() --[[ Line: 203 ]]
            -- upvalues: u19 (ref), l__LocalPlayer__6 (ref)
            local v37 = u19();
            if v37 then
                local l__Character__9 = l__LocalPlayer__6.Character;
                if l__Character__9 then
                    l__Character__9 = l__Character__9:FindFirstChildOfClass("Humanoid");
                end;
                if l__Character__9 then
                    l__Character__9:Move(-v37:GetMoveVector(), true);
                end;
            end;
        end);
        if not u22 then
            local u38 = u29();
            if u38 and typeof(u38.getRotation) == "function" then
                pcall(function() --[[ Line: 232 ]]
                    -- upvalues: u21 (ref), u38 (copy)
                    u21 = u38.getRotation;
                    function u38.getRotation(...) --[[ Line: 234 ]]
                        -- upvalues: u21 (ref)
                        local v39 = u21(...);
                        if typeof(v39) == "Vector2" then
                            return -v39;
                        else
                            return v39;
                        end;
                    end;
                end);
                u22 = true;
            end;
        end;
        u5 = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 285 ]]
            -- upvalues: u4 (ref), u2 (ref), u5 (ref), l__RunService__4 (ref), u21 (ref), u20 (ref), u22 (ref), u36 (ref), u6 (ref), u7 (ref), u8 (ref), l__LocalPlayer__6 (ref), u3 (ref), u9 (ref), u10 (ref), u11 (ref)
            local v40 = tick();
            if u4 <= v40 then
                if u2 then
                    u2 = false;
                    if u5 then
                        u5:Disconnect();
                        u5 = nil;
                    end;
                    pcall(function() --[[ Line: 217 ]]
                        -- upvalues: l__RunService__4 (ref)
                        l__RunService__4:UnbindFromRenderStep("BeeStingInvertMovement");
                    end);
                    if u21 and u20 then
                        pcall(function() --[[ Line: 247 ]]
                            -- upvalues: u20 (ref), u21 (ref)
                            u20.getRotation = u21;
                        end);
                    end;
                    u21 = nil;
                    u22 = false;
                    u36();
                    if u6 then
                        u6:Destroy();
                        u6 = nil;
                        u7 = nil;
                    end;
                    if u8 then
                        u8:Destroy();
                        u8 = nil;
                    end;
                end;
            else
                local l__Character__10 = l__LocalPlayer__6.Character;
                if l__Character__10 then
                    l__Character__10 = l__Character__10:FindFirstChildOfClass("Humanoid");
                end;
                if l__Character__10 then
                    local v41 = v40 - u3;
                    local v42 = math.sin(v41 * 4) * 1.65 + math.sin(v41 * 7.3) * 0.49499999999999994;
                    local v43 = math.cos(v41 * 5.2) * 1.35 + math.sin(v41 * 9.1) * 0.3375;
                    local v44 = v40 - u9;
                    if v44 >= 0 and v44 < 0.35 then
                        local v45 = (1 - v44 / 0.35) ^ 3;
                        v42 = v42 + u10 * 3 * v45;
                        v43 = v43 + u11 * 3 * v45;
                    end;
                    l__Character__10.CameraOffset = Vector3.new(v42, v43, 0);
                end;
                local v46 = math.sin((v40 - u3) * 2.5);
                local v47 = math.max(0, v46);
                local v48 = 0.8 - v47 * 0.2;
                local v49 = v40 - u9;
                local v50 = (v49 < 0 or v49 >= 0.28) and 1 or 0.05 + 0.95 * (v49 / 0.28);
                if u7 then
                    u7.BackgroundTransparency = math.min(v48, v50);
                end;
                if u8 then
                    u8.Size = v47 * 4 + 1;
                end;
            end;
        end);
    end;
end;
local function u56(p52) --[[ Line: 348 ]]
    -- upvalues: u9 (ref), u10 (ref), u11 (ref), u2 (ref), u4 (ref), u51 (copy)
    local v53 = tick();
    u9 = v53;
    local v54 = math.random() * 3.141592653589793 * 2;
    u10 = math.cos(v54);
    u11 = math.sin(v54);
    local v55 = (typeof(p52) ~= "number" or p52 <= 0) and 3.5 or p52;
    if u2 then
        u4 = v53 + v55;
    else
        u4 = v53 + v55;
        u51();
    end;
end;
function v1.Init(_) --[[ Line: 379 ]]
    -- upvalues: l__Networking__7 (copy), u56 (copy)
    l__Networking__7.Bee.Sting.OnClientEvent:Connect(u56);
end;
return v1;