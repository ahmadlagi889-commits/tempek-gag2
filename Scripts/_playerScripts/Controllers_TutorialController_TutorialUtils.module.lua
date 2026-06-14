-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__TweenService__2 = game:GetService("TweenService");
local l__HttpService__3 = game:GetService("HttpService");
local l__RunService__4 = game:GetService("RunService");
local l__LocalPlayer__5 = game:GetService("Players").LocalPlayer;
local u1 = assert(l__LocalPlayer__5);
local l__TutorialUI__6 = u1.PlayerGui:WaitForChild("TutorialUI");
local l__Pointer__7 = l__TutorialUI__6:WaitForChild("Pointer");
local l__Focus__8 = l__TutorialUI__6:WaitForChild("Focus");
local function u8(p2, p3, p4, p5) --[[ Line: 19 ]]
    -- upvalues: l__TweenService__2 (copy)
    local v6 = p5 ~= false;
    local u7 = l__TweenService__2:Create(p2, p3, p4);
    u7.Completed:Once(function() --[[ Line: 28 ]]
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
    if v6 then
        u7:Play();
    end;
    return u7;
end;
local u9 = 0;
local u10 = nil;
local function v25(u11) --[[ Line: 48 ]]
    -- upvalues: l__Focus__8 (copy), u9 (ref), u10 (ref), u8 (copy), l__RunService__4 (copy)
    local l__Visible__9 = l__Focus__8.Visible;
    u9 = u9 + 1;
    local u12 = u9;
    if not l__Visible__9 then
        local l__ViewportSize__10 = workspace.CurrentCamera.ViewportSize;
        local v13 = UDim2.fromOffset(l__ViewportSize__10.X * 0.5, l__ViewportSize__10.Y * 0.5);
        local v14 = UDim2.fromOffset(l__ViewportSize__10.X * 2, l__ViewportSize__10.Y * 2);
        l__Focus__8.Position = v13;
        l__Focus__8.Size = v14;
        l__Focus__8.UIStroke.Transparency = 0.3;
    end;
    l__Focus__8.Visible = true;
    if u10 then
        u10:Cancel();
    end;
    local v15, v16;
    if type(u11) == "function" then
        local v17 = u11();
        if v17 == nil then
            v15 = nil;
            v16 = nil;
        else
            v15 = v17.Position + v17.Size * 0.5;
            v16 = v17.Size;
        end;
    else
        v16 = u11.AbsoluteSize;
        v15 = u11.AbsolutePosition + v16 * 0.5;
    end;
    if v15 and v16 then
        u10 = u8(l__Focus__8, TweenInfo.new(l__Visible__9 and 0.25 or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromOffset(v15.X, v15.Y),
            Size = UDim2.fromOffset(v16.X, v16.Y)
        });
    end;
    local u21 = l__RunService__4.PreRender:Connect(function() --[[ Line: 90 ]]
        -- upvalues: u10 (ref), u11 (copy), l__Focus__8 (ref)
        if u10 and u10.PlaybackState == Enum.PlaybackState.Playing then
        else
            local v18, v19;
            if type(u11) == "function" then
                local v20 = u11();
                if v20 == nil then
                    v18 = nil;
                    v19 = nil;
                else
                    v18 = v20.Position + v20.Size * 0.5;
                    v19 = v20.Size;
                end;
            else
                v19 = u11.AbsoluteSize;
                v18 = u11.AbsolutePosition + v19 * 0.5;
            end;
            if v18 and v19 then
                l__Focus__8.Position = UDim2.fromOffset(v18.X, v18.Y);
                l__Focus__8.Size = UDim2.fromOffset(v19.X, v19.Y);
            end;
        end;
    end);
    return function(p22) --[[ Line: 102 ]]
        -- upvalues: u21 (copy), u10 (ref), u8 (ref), l__Focus__8 (ref), u9 (ref), u12 (copy)
        if u21.Connected then
            u21:Disconnect();
            if u10 then
                u10:Cancel();
            end;
            local l__ViewportSize__11 = workspace.CurrentCamera.ViewportSize;
            local v23 = UDim2.fromOffset(l__ViewportSize__11.X * 0.5, l__ViewportSize__11.Y * 0.5);
            local v24 = UDim2.fromOffset(l__ViewportSize__11.X * 2, l__ViewportSize__11.Y * 2);
            u10 = u8(l__Focus__8, TweenInfo.new(p22 or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = v23,
                Size = v24
            });
            assert(u10).Completed:Once(function() --[[ Line: 120 ]]
                -- upvalues: u9 (ref), u12 (ref), l__Focus__8 (ref)
                if u9 == u12 then
                    l__Focus__8.Visible = false;
                end;
            end);
        end;
    end;
end;
function observeTag(u26, u27, u28)
    -- upvalues: l__CollectionService__1 (copy)
    local u29 = {};
    local u30 = {};
    local u31 = nil;
    local function u82(u32) --[[ Line: 331 ]]
        -- upvalues: u31 (ref), u29 (copy), u30 (copy), u28 (copy), u27 (copy)
        if not u31.Connected then
            return;
        end;
        if u29[u32] ~= nil then
            return;
        end;
        u29[u32] = "__dead__";
        u30[u32] = u32.AncestryChanged:Connect(function() --[[ Line: 341 ]]
            -- upvalues: u32 (copy), u28 (ref), u29 (ref), u27 (ref)
            local u33 = u32;
            local v34, v35;
            if u28 == nil then
                v34 = true;
                if v34 then
                    if u29[u33] == "__dead__" then
                        u29[u33] = "__inflight__";
                        task.defer(function() --[[ Line: 275 ]]
                            -- upvalues: u29 (ref), u33 (copy), u27 (ref)
                            if u29[u33] == "__inflight__" then
                                local v54, v55 = xpcall(function(p51) --[[ Line: 281 ]]
                                    -- upvalues: u27 (ref)
                                    local v52 = u27(p51);
                                    if v52 ~= nil then
                                        local v53 = typeof(v52) == "function";
                                        assert(v53, "callback must return a function or nil");
                                    end;
                                    return v52;
                                end, debug.traceback, u33);
                                if v54 then
                                    if u29[u33] == "__inflight__" then
                                        u29[u33] = v55;
                                    elseif v55 ~= nil then
                                        task.spawn(v55);
                                    end;
                                else
                                    local v56 = string.split(v55, "\n")[1];
                                    local v57 = string.find(v56, ": ");
                                    if v57 then
                                        v56:sub(v57 + 1);
                                    end;
                                end;
                            end;
                        end);
                    end;
                else
                    v35 = u29[u33];
                    u29[u33] = "__dead__";
                    if typeof(v35) == "function" then
                        task.spawn(v35);
                    end;
                end;
            else
                for _, v43 in u28 do
                    if u33:IsDescendantOf(v43) then
                        v34 = true;
                        if v34 then
                            if u29[u33] == "__dead__" then
                                u29[u33] = "__inflight__";
                                task.defer(function() --[[ Line: 275 ]]
                                    -- upvalues: u29 (ref), u33 (copy), u27 (ref)
                                    if u29[u33] == "__inflight__" then
                                        local v54, v55 = xpcall(function(p51) --[[ Line: 281 ]]
                                            -- upvalues: u27 (ref)
                                            local v52 = u27(p51);
                                            if v52 ~= nil then
                                                local v53 = typeof(v52) == "function";
                                                assert(v53, "callback must return a function or nil");
                                            end;
                                            return v52;
                                        end, debug.traceback, u33);
                                        if v54 then
                                            if u29[u33] == "__inflight__" then
                                                u29[u33] = v55;
                                            elseif v55 ~= nil then
                                                task.spawn(v55);
                                            end;
                                        else
                                            local v56 = string.split(v55, "\n")[1];
                                            local v57 = string.find(v56, ": ");
                                            if v57 then
                                                v56:sub(v57 + 1);
                                            end;
                                        end;
                                    end;
                                end);
                                return;
                            end;
                        else
                            v35 = u29[u33];
                            u29[u33] = "__dead__";
                            if typeof(v35) == "function" then
                                task.spawn(v35);
                            end;
                        end;
                        return;
                    end;
                end;
                v34 = false;
                if v34 then
                    if u29[u33] == "__dead__" then
                        u29[u33] = "__inflight__";
                        task.defer(function() --[[ Line: 275 ]]
                            -- upvalues: u29 (ref), u33 (copy), u27 (ref)
                            if u29[u33] == "__inflight__" then
                                local v54, v55 = xpcall(function(p51) --[[ Line: 281 ]]
                                    -- upvalues: u27 (ref)
                                    local v52 = u27(p51);
                                    if v52 ~= nil then
                                        local v53 = typeof(v52) == "function";
                                        assert(v53, "callback must return a function or nil");
                                    end;
                                    return v52;
                                end, debug.traceback, u33);
                                if v54 then
                                    if u29[u33] == "__inflight__" then
                                        u29[u33] = v55;
                                    elseif v55 ~= nil then
                                        task.spawn(v55);
                                    end;
                                else
                                    local v56 = string.split(v55, "\n")[1];
                                    local v57 = string.find(v56, ": ");
                                    if v57 then
                                        v56:sub(v57 + 1);
                                    end;
                                end;
                            end;
                        end);
                    end;
                else
                    v35 = u29[u33];
                    u29[u33] = "__dead__";
                    if typeof(v35) == "function" then
                        task.spawn(v35);
                    end;
                end;
            end;
        end);
        local v58, v59;
        if u28 == nil then
            v58 = true;
            if v58 then
                if u29[u32] == "__dead__" then
                    u29[u32] = "__inflight__";
                    task.defer(function() --[[ Line: 275 ]]
                        -- upvalues: u29 (ref), u32 (copy), u27 (ref)
                        if u29[u32] == "__inflight__" then
                            local v78, v79 = xpcall(function(p75) --[[ Line: 281 ]]
                                -- upvalues: u27 (ref)
                                local v76 = u27(p75);
                                if v76 ~= nil then
                                    local v77 = typeof(v76) == "function";
                                    assert(v77, "callback must return a function or nil");
                                end;
                                return v76;
                            end, debug.traceback, u32);
                            if v78 then
                                if u29[u32] == "__inflight__" then
                                    u29[u32] = v79;
                                elseif v79 ~= nil then
                                    task.spawn(v79);
                                end;
                            else
                                local v80 = string.split(v79, "\n")[1];
                                local v81 = string.find(v80, ": ");
                                if v81 then
                                    v80:sub(v81 + 1);
                                end;
                            end;
                        end;
                    end);
                end;
            else
                v59 = u29[u32];
                u29[u32] = "__dead__";
                if typeof(v59) == "function" then
                    task.spawn(v59);
                end;
            end;
        else
            for _, v67 in u28 do
                if u32:IsDescendantOf(v67) then
                    v58 = true;
                    if v58 then
                        if u29[u32] == "__dead__" then
                            u29[u32] = "__inflight__";
                            task.defer(function() --[[ Line: 275 ]]
                                -- upvalues: u29 (ref), u32 (copy), u27 (ref)
                                if u29[u32] == "__inflight__" then
                                    local v78, v79 = xpcall(function(p75) --[[ Line: 281 ]]
                                        -- upvalues: u27 (ref)
                                        local v76 = u27(p75);
                                        if v76 ~= nil then
                                            local v77 = typeof(v76) == "function";
                                            assert(v77, "callback must return a function or nil");
                                        end;
                                        return v76;
                                    end, debug.traceback, u32);
                                    if v78 then
                                        if u29[u32] == "__inflight__" then
                                            u29[u32] = v79;
                                        elseif v79 ~= nil then
                                            task.spawn(v79);
                                        end;
                                    else
                                        local v80 = string.split(v79, "\n")[1];
                                        local v81 = string.find(v80, ": ");
                                        if v81 then
                                            v80:sub(v81 + 1);
                                        end;
                                    end;
                                end;
                            end);
                            return;
                        end;
                    else
                        v59 = u29[u32];
                        u29[u32] = "__dead__";
                        if typeof(v59) == "function" then
                            task.spawn(v59);
                        end;
                    end;
                    return;
                end;
            end;
            v58 = false;
            if v58 then
                if u29[u32] == "__dead__" then
                    u29[u32] = "__inflight__";
                    task.defer(function() --[[ Line: 275 ]]
                        -- upvalues: u29 (ref), u32 (copy), u27 (ref)
                        if u29[u32] == "__inflight__" then
                            local v78, v79 = xpcall(function(p75) --[[ Line: 281 ]]
                                -- upvalues: u27 (ref)
                                local v76 = u27(p75);
                                if v76 ~= nil then
                                    local v77 = typeof(v76) == "function";
                                    assert(v77, "callback must return a function or nil");
                                end;
                                return v76;
                            end, debug.traceback, u32);
                            if v78 then
                                if u29[u32] == "__inflight__" then
                                    u29[u32] = v79;
                                elseif v79 ~= nil then
                                    task.spawn(v79);
                                end;
                            else
                                local v80 = string.split(v79, "\n")[1];
                                local v81 = string.find(v80, ": ");
                                if v81 then
                                    v80:sub(v81 + 1);
                                end;
                            end;
                        end;
                    end);
                end;
            else
                v59 = u29[u32];
                u29[u32] = "__dead__";
                if typeof(v59) == "function" then
                    task.spawn(v59);
                end;
            end;
        end;
    end;
    u31 = l__CollectionService__1:GetInstanceAddedSignal(u26):Connect(u82);
    local u86 = l__CollectionService__1:GetInstanceRemovedSignal(u26):Connect(function(p83) --[[ Name: onInstanceRemoved, Line 347 ]]
        -- upvalues: u29 (copy), u30 (copy)
        local v84 = u29[p83];
        u29[p83] = "__dead__";
        if typeof(v84) == "function" then
            task.spawn(v84);
        end;
        local v85 = u30[p83];
        if v85 then
            v85:Disconnect();
            u30[p83] = nil;
        end;
        u29[p83] = nil;
    end);
    task.defer(function() --[[ Line: 364 ]]
        -- upvalues: u31 (ref), l__CollectionService__1 (ref), u26 (copy), u82 (copy)
        if u31.Connected then
            for _, v87 in l__CollectionService__1:GetTagged(u26) do
                task.spawn(u82, v87);
            end;
        end;
    end);
    return function() --[[ Line: 375 ]]
        -- upvalues: u31 (ref), u86 (ref), u29 (copy), u30 (copy)
        u31:Disconnect();
        u86:Disconnect();
        local v88 = next(u29);
        while v88 do
            local v89 = u29[v88];
            u29[v88] = "__dead__";
            if typeof(v89) == "function" then
                task.spawn(v89);
            end;
            local v90 = u30[v88];
            if v90 then
                v90:Disconnect();
                u30[v88] = nil;
            end;
            u29[v88] = nil;
            v88 = next(u29);
        end;
    end;
end;
local l__Gardens__12 = workspace:WaitForChild("Gardens");
local l__FruitProxyUtil__13 = require(game.ReplicatedStorage.SharedModules.FruitProxyUtil);
local function u94() --[[ Line: 404 ]]
    -- upvalues: u1 (copy), l__FruitProxyUtil__13 (copy)
    local v91 = {};
    for _, v92 in u1.Backpack:GetChildren() do
        if v92:IsA("Tool") or l__FruitProxyUtil__13.IsFruitProxy(v92) then
            table.insert(v91, v92);
        end;
    end;
    local l__Character__14 = u1.Character;
    local v93 = l__Character__14 and l__Character__14:FindFirstChildWhichIsA("Tool");
    if v93 then
        table.insert(v91, v93);
    end;
    return v91;
end;
local u95 = false;
return table.freeze({
    waitUntilDistance = function(p96, p97) --[[ Name: waitUntilDistance, Line 190 ]]
        -- upvalues: u1 (copy)
        while not u1.Character or u1:DistanceFromCharacter(p96()) > p97 do
            task.wait(0.1);
        end;
    end,
    focusObject = v25,
    createArrow = function(u98, p99, p100) --[[ Name: createArrow, Line 128 ]]
        -- upvalues: l__HttpService__3 (copy), l__RunService__4 (copy), l__TweenService__2 (copy)
        l__HttpService__3:GenerateGUID(false);
        local u101 = p100 or 10;
        local u102 = script.Arrow:Clone();
        u102.CFrame = p99;
        u102.Parent = workspace;
        local u103 = u102:FindFirstChildWhichIsA("Beam");
        local u104 = not u103 and 0 or u103.Width0;
        local u105 = not u103 and 0 or u103.Width1;
        local u106 = false;
        local function v108(p107) --[[ Line: 141 ]]
            -- upvalues: u102 (copy)
            local l__HumanoidRootPart__15 = p107:WaitForChild("HumanoidRootPart");
            if typeof(l__HumanoidRootPart__15) == "Instance" and l__HumanoidRootPart__15:IsA("BasePart") then
                local l__RootAttachment__16 = l__HumanoidRootPart__15:WaitForChild("RootAttachment");
                if typeof(l__RootAttachment__16) == "Instance" and l__RootAttachment__16:IsA("Attachment") then
                    u102.Beam.Attachment1 = l__RootAttachment__16;
                end;
            end;
        end;
        local u109 = u98.CharacterAdded:Connect(v108);
        if u98.Character then
            task.spawn(v108, u98.Character);
        end;
        local u112 = l__RunService__4.PreRender:Connect(function() --[[ Line: 160 ]]
            -- upvalues: u103 (copy), u98 (copy), u102 (copy), u101 (copy), u106 (ref), l__TweenService__2 (ref), u104 (copy), u105 (copy)
            if u103 then
                local v110 = u98:DistanceFromCharacter(u102.Position);
                local v111;
                if v110 > 0 then
                    v111 = v110 <= u101;
                else
                    v111 = false;
                end;
                if v111 == u106 then
                else
                    u106 = v111;
                    if v111 then
                        l__TweenService__2:Create(u103, TweenInfo.new(0.3), {
                            Width0 = 0,
                            Width1 = 0
                        }):Play();
                    else
                        l__TweenService__2:Create(u103, TweenInfo.new(0.3), {
                            Width0 = u104,
                            Width1 = u105
                        }):Play();
                    end;
                end;
            end;
        end);
        return table.freeze({
            move = function(p113) --[[ Name: move, Line 178 ]]
                -- upvalues: u102 (copy)
                u102.CFrame = p113;
            end,
            destroy = function() --[[ Name: destroy, Line 182 ]]
                -- upvalues: u112 (copy), u109 (copy), u102 (copy)
                u112:Disconnect();
                u109:Disconnect();
                u102:Destroy();
            end
        });
    end,
    observeTag = observeTag,
    pointToUI = function(u114, p115, p116, p117) --[[ Name: pointToUI, Line 501 ]]
        -- upvalues: l__TutorialUI__6 (copy), u95 (ref), l__Pointer__7 (copy), u8 (copy), l__RunService__4 (copy)
        local v118 = p115 or l__TutorialUI__6;
        local v119 = p117 or "rbxassetid://7553620727";
        local v120 = p116 or 1;
        while u95 do
            task.wait();
        end;
        u95 = true;
        local function v122() --[[ Line: 517 ]]
            -- upvalues: u114 (copy), l__Pointer__7 (ref)
            local v121 = u114(l__Pointer__7);
            if v121 then
                l__Pointer__7.Position = UDim2.fromOffset(v121.X, v121.Y);
            end;
        end;
        task.spawn(v122);
        l__Pointer__7.Image = v119;
        l__Pointer__7.Parent = v118;
        local v123 = l__Pointer__7:FindFirstChildWhichIsA("UIScale");
        if v123 then
            v123.Scale = v120;
        end;
        l__Pointer__7.Visible = true;
        u8(l__Pointer__7, TweenInfo.new(0.3), {
            ImageTransparency = 0
        });
        local u124;
        if v123 then
            u124 = u8(v123, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                Scale = v120 * 1.1
            }, true);
        else
            u124 = nil;
        end;
        local u125 = l__RunService__4.PreRender:Connect(v122);
        return function() --[[ Line: 546 ]]
            -- upvalues: u125 (copy), u124 (copy), u8 (ref), l__Pointer__7 (ref), l__TutorialUI__6 (ref), u95 (ref)
            if u125.Connected then
                u125:Disconnect();
                if u124 then
                    u124:Cancel();
                end;
                u8(l__Pointer__7, TweenInfo.new(0.3), {
                    ImageTransparency = 1
                }).Completed:Wait();
                l__Pointer__7.Visible = false;
                l__Pointer__7.Parent = l__TutorialUI__6;
                u95 = false;
            end;
        end;
    end,
    getPlayerPlot = function() --[[ Name: getPlayerPlot, Line 390 ]]
        -- upvalues: u1 (copy), l__Gardens__12 (copy)
        local v126 = u1:GetAttribute("PlotId");
        if v126 then
            local v127 = l__Gardens__12:FindFirstChild((`Plot{v126}`));
            if v127 and v127:IsA("Model") then
                return v127;
            else
                return nil;
            end;
        else
            return nil;
        end;
    end,
    getTools = u94,
    hasSeed = function() --[[ Name: hasSeed, Line 432 ]]
        -- upvalues: u94 (copy)
        for _, v128 in u94() do
            if v128:GetAttribute("SeedTool") and true or (string.find(v128.Name, "Seed") and true or false) then
                return true;
            end;
        end;
        return false;
    end,
    waitForSeed = function() --[[ Name: waitForSeed, Line 441 ]]
        -- upvalues: u94 (copy), u1 (copy)
        local u129, u130, v131, v132, v133, v134;
        local v135 = 0;
        while true do
            if v135 == 0 then
                v135 = -1;
                -- block 30
                local v136, v137, v138;
                v136, v137, v138 = u94();
                while true do
                    local v139, v140 = v136(v137, v138);
                    if v139 == nil then
                        break;
                    end;
                    v138 = v139;
                    if not (v140:GetAttribute("SeedTool") or string.find(v140.Name, "Seed")) then
                        continue;
                    end;
                    break;
                end;
                local v141 = true;
                if v141 then
                    return;
                end;
                u129 = false;
                u130 = nil;
                u130 = u1.Backpack.ChildAdded:Connect(function(p142) --[[ Line: 448 ]]
                    -- upvalues: u129 (ref), u130 (ref)
                    if p142:IsA("Tool") and (p142:GetAttribute("SeedTool") or string.find(p142.Name, "Seed")) then
                        u129 = true;
                        if u130 then
                            u130:Disconnect();
                            u130 = nil;
                        end;
                    end;
                end);
                v135 = 1;
                continue;
            elseif v135 == 1 then
                v135 = -1;
                if u129 then
                    if u130 then
                        u130:Disconnect();
                        u130 = nil;
                    end;
                    return;
                end;
                v131, v132, v133 = u94();
                v135 = 3;
                continue;
            elseif v135 == 2 then
                v135 = -1;
                if v134:GetAttribute("SeedTool") and true or (string.find(v134.Name, "Seed") and true or false) then
                    local v143 = true;
                    if v143 then
                        u129 = true;
                        break;
                    end;
                    task.wait(0.2);
                    v135 = 1;
                    continue;
                end;
                v135 = 3;
                continue;
            elseif v135 == 3 then
                v135 = -1;
                local v144;
                if type(v131) == "function" then
                    v144, v134 = v131(v132, v133);
                else
                    v144, v134 = next(v131, v133);
                end;
                if v144 ~= nil then
                    v133 = v144;
                    -- block 16
                    v135 = 2;
                    continue;
                else
                    break;
                end;
            else
                break;
            end;
        end;
    end,
    waitUntilSeedEquipped = function() --[[ Name: waitUntilSeedEquipped, Line 472 ]]
        -- upvalues: u1 (copy)
        while true do
            local l__Character__17 = u1.Character;
            local v145;
            if l__Character__17 then
                v145 = l__Character__17:FindFirstChildWhichIsA("Tool");
            else
                v145 = nil;
            end;
            if v145 and v145:GetAttribute("SeedTool") then
                return;
            end;
            task.wait(0.1);
        end;
    end,
    isInsidePlot = function(p146) --[[ Name: isInsidePlot, Line 483 ]]
        -- upvalues: u1 (copy)
        local l__Character__18 = u1.Character;
        if not l__Character__18 then
            return false;
        end;
        local v147 = l__Character__18:FindFirstChild("HumanoidRootPart");
        if not (v147 and v147:IsA("BasePart")) then
            return false;
        end;
        local v148, v149 = p146:GetBoundingBox();
        local v150 = v148:PointToObjectSpace(v147.Position);
        local v151 = v149 * 0.5;
        local v152;
        if math.abs(v150.X) <= v151.X + 5 then
            v152 = math.abs(v150.Z) <= v151.Z + 5;
        else
            v152 = false;
        end;
        return v152;
    end
});