-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__MenuOpenClose__1 = game.SoundService.SFX.MenuOpenClose;
local l__Players__2 = game:GetService("Players");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__TweenService__5 = game:GetService("TweenService");
local l__Debris__6 = game:GetService("Debris");
local l__LocalPlayer__7 = l__Players__2.LocalPlayer;
local l__PlayerGui__8 = l__LocalPlayer__7:WaitForChild("PlayerGui");
local u2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local l__Networking__9 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__DevProductController__10 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController);
local l__GrowRateData__11 = require(game.ReplicatedStorage.SharedModules.GrowRateData);
local l__Notification__12 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GrowingList"):WaitForChild("Exit"):WaitForChild("ExitButton"):WaitForChild("Notification");
local u4 = UDim2.new(1, -5, 0.475, 0);
local u5 = UDim2.new(-0.03, 0, 0.475, 0);
local u6 = UDim2.new(1.265, 0, 0.475, 0);
local u7 = UDim2.new(1, 0, 0.475, 0);
local u8 = nil;
local u9 = nil;
l__ReplicatedStorage__3:WaitForChild("PlantGenerationModules"):WaitForChild("Plants");
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = {};
local u15 = {};
local u16 = {};
local u17 = 0;
local u18 = false;
local l__GuiController__13 = require(script.Parent.GuiController);
local function u24(p19) --[[ Line: 93 ]]
    if p19 <= 0 then
        return "Done!";
    else
        local v20 = math.ceil(p19);
        local v21 = math.floor(v20 / 3600);
        local v22 = math.floor(v20 % 3600 / 60);
        local v23 = v20 % 60;
        if v21 > 0 then
            return string.format("%dh %dm", v21, v22);
        elseif v22 > 0 then
            return string.format("%dm %ds", v22, v23);
        else
            return string.format("%ds", v23);
        end;
    end;
end;
local function u29(u25) --[[ Line: 123 ]]
    -- upvalues: u14 (copy), u16 (copy), u18 (ref), u15 (copy), u10 (ref), l__TweenService__5 (copy), u3 (copy), l__Debris__6 (copy)
    local u26 = u14[u25];
    if u26 and not u16[u25] then
        if u18 then
            u16[u25] = true;
            u26.Main_Frame.ProgressBar.TextLabel.Text = "Done!";
            local l__Frame__14 = u26.Main_Frame.ProgressBar.Frame;
            l__Frame__14.Size = UDim2.new(1, 0, l__Frame__14.Size.Y.Scale, l__Frame__14.Size.Y.Offset);
            local l__Main_Frame__15 = u26.Main_Frame;
            local l__AbsolutePosition__16 = l__Main_Frame__15.AbsolutePosition;
            local l__AbsoluteSize__17 = l__Main_Frame__15.AbsoluteSize;
            local u27 = Instance.new("Frame");
            u27.Name = "CompletionFlash";
            u27.BackgroundColor3 = Color3.new(1, 1, 1);
            u27.BackgroundTransparency = 0;
            u27.BorderSizePixel = 0;
            u27.ZIndex = l__Main_Frame__15.ZIndex + 10;
            u27.AnchorPoint = Vector2.new(0.5, 0.5);
            u27.Position = UDim2.fromOffset(l__AbsolutePosition__16.X + l__AbsoluteSize__17.X / 2, l__AbsolutePosition__16.Y + l__AbsoluteSize__17.Y / 2);
            u27.Size = UDim2.fromOffset(l__AbsoluteSize__17.X, l__AbsoluteSize__17.Y);
            u27.Parent = u10;
            local v28 = l__TweenService__5:Create(u27, u3, {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(l__AbsoluteSize__17.X * 1.5, l__AbsoluteSize__17.Y)
            });
            v28:Play();
            l__Debris__6:AddItem(v28, u3.Time);
            task.delay(0.2, function() --[[ Line: 175 ]]
                -- upvalues: u27 (copy)
                if u27 and u27.Parent then
                    u27:Destroy();
                end;
            end);
            task.delay(2, function() --[[ Line: 182 ]]
                -- upvalues: u26 (copy), u14 (ref), u25 (copy), u15 (ref), u16 (ref)
                if u26 and u26.Parent then
                    u26:Destroy();
                end;
                u14[u25] = nil;
                u15[u25] = nil;
                u16[u25] = nil;
            end);
        else
            if u26 and u26.Parent then
                u26:Destroy();
            end;
            u14[u25] = nil;
            u15[u25] = nil;
        end;
    end;
end;
u10 = l__PlayerGui__8:WaitForChild("GrowingList");
local l__Frame__18 = u10:WaitForChild("Frame");
u11 = l__Frame__18:WaitForChild("Notepad"):WaitForChild("ScrollingFrame");
local u30 = #u11:GetChildren();
function UpdateScrollingFrame()
    -- upvalues: u11 (ref), u30 (copy), u18 (ref), l__Notification__12 (copy)
    local v31 = #u11:GetChildren() - u30;
    if v31 > 0 and u18 == false then
        l__Notification__12.Visible = true;
        l__Notification__12.InletTexture.TextLabel.TextLabel.Text = tostring(v31);
        l__Notification__12.InletTexture.TextLabel.Text = tostring(v31);
    else
        l__Notification__12.Visible = false;
    end;
end;
u11.ChildAdded:Connect(function() --[[ Line: 214 ]]
    UpdateScrollingFrame();
end);
u11.ChildRemoved:Connect(function() --[[ Line: 218 ]]
    UpdateScrollingFrame();
end);
local function u41(u32, p33) --[[ Line: 223 ]]
    -- upvalues: u14 (copy), u17 (ref), u12 (ref), u9 (ref), l__GrowRateData__11 (copy), u15 (copy), u24 (copy), u11 (ref), l__Networking__9 (copy), l__DevProductController__10 (copy)
    if (p33.Age or 0) >= (p33.MaxAge or 1) then
    elseif u14[u32] then
    else
        u17 = u17 + 1;
        local v34 = u12:Clone();
        v34.Name = u32;
        v34.Visible = true;
        v34.LayoutOrder = u17;
        local l__PlantName__19 = p33.PlantName;
        local v35 = u9:FindFirstChild(l__PlantName__19);
        if v35 then
            v34.Main_Frame.PlantImage.Image = v35.Value;
        end;
        local v36 = p33.Age or 0;
        local v37 = p33.MaxAge or 1;
        u15[u32] = {
            LastDisplayedPercent = 0,
            CurrentAge = v36,
            MaxAge = v37,
            StableGrowthAmount = l__GrowRateData__11[l__PlantName__19] and (l__GrowRateData__11[l__PlantName__19].GrowRate or 0.2) or 0.2,
            PlantedAt = p33.PlantedAt or os.time(),
            PlantName = l__PlantName__19
        };
        local v38 = math.clamp(v36 / v37, 0, 1);
        local l__Frame__20 = v34.Main_Frame.ProgressBar.Frame;
        l__Frame__20.Size = UDim2.new(v38, 0, l__Frame__20.Size.Y.Scale, l__Frame__20.Size.Y.Offset);
        u15[u32].LastDisplayedPercent = v38;
        local v39 = u15[u32];
        local v40 = v39.StableGrowthAmount <= 0 and 999999 or (v39.MaxAge - v39.CurrentAge) / v39.StableGrowthAmount;
        v34.Main_Frame.ProgressBar.TextLabel.Text = u24(v40);
        v34.LayoutOrder = v40;
        v34.Parent = u11;
        u14[u32] = v34;
        v34.Main_Frame.BevelEffect.GrowButton.MouseButton1Click:Connect(function() --[[ Line: 286 ]]
            -- upvalues: l__Networking__9 (ref), u32 (copy), l__DevProductController__10 (ref)
            l__Networking__9.GrowPlant:Fire(u32);
            l__DevProductController__10:PromptPurchase("Standalone:Grow Plant:1");
        end);
        u11.CanvasSize = UDim2.new(0, 0, 0, u11.UIListLayout.AbsoluteContentSize.Y);
    end;
end;
local function u45(p42) --[[ Line: 302 ]]
    -- upvalues: u14 (copy), u16 (copy), u15 (copy), u11 (ref)
    local v43 = u14[p42];
    if v43 and not u16[p42] then
        local v44 = u15[p42];
        if v44 and v44.ProgressTween then
            v44.ProgressTween:Cancel();
            v44.ProgressTween:Destroy();
            v44.ProgressTween = nil;
        end;
        v43:Destroy();
        u14[p42] = nil;
        u15[p42] = nil;
    end;
    u11.CanvasSize = UDim2.new(0, 0, 0, u11.UIListLayout.AbsoluteContentSize.Y);
end;
local function u53(p46) --[[ Line: 324 ]]
    -- upvalues: u14 (copy), u15 (copy), u16 (copy), u29 (copy), l__TweenService__5 (copy), u2 (copy), u24 (copy)
    local v47 = u14[p46];
    local u48 = u15[p46];
    if v47 and u48 then
        if u16[p46] then
        else
            local v49 = math.clamp(u48.CurrentAge / u48.MaxAge, 0, 1);
            if v49 >= 1 then
                u29(p46);
            else
                if math.abs(v49 - (u48.LastDisplayedPercent or 0)) > 0.001 then
                    local l__Frame__21 = v47.Main_Frame.ProgressBar.Frame;
                    local v50 = UDim2.new(v49, 0, l__Frame__21.Size.Y.Scale, l__Frame__21.Size.Y.Offset);
                    if (u48.LastDisplayedPercent or 0) < v49 then
                        local l__ProgressTween__22 = u48.ProgressTween;
                        if l__ProgressTween__22 then
                            l__ProgressTween__22:Cancel();
                            l__ProgressTween__22:Destroy();
                        end;
                        local u51 = l__TweenService__5:Create(l__Frame__21, u2, {
                            Size = v50
                        });
                        u48.ProgressTween = u51;
                        u51.Completed:Once(function() --[[ Line: 360 ]]
                            -- upvalues: u48 (copy), u51 (copy)
                            if u48.ProgressTween == u51 then
                                u48.ProgressTween = nil;
                            end;
                            u51:Destroy();
                        end);
                        u51:Play();
                    else
                        local l__ProgressTween__23 = u48.ProgressTween;
                        if l__ProgressTween__23 then
                            l__ProgressTween__23:Cancel();
                            l__ProgressTween__23:Destroy();
                            u48.ProgressTween = nil;
                        end;
                        l__Frame__21.Size = v50;
                    end;
                    u48.LastDisplayedPercent = v49;
                end;
                local v52 = u48.StableGrowthAmount <= 0 and 999999 or (u48.MaxAge - u48.CurrentAge) / u48.StableGrowthAmount;
                v47.Main_Frame.ProgressBar.TextLabel.Text = u24(v52);
                v47.LayoutOrder = v52;
            end;
        end;
    end;
end;
local function u60() --[[ Line: 428 ]]
    -- upvalues: u8 (ref), l__LocalPlayer__7 (copy), u41 (copy)
    local v54 = {};
    for v55, v56 in u8:GetGarden(l__LocalPlayer__7.UserId) do
        if (v56.Age or 0) < (v56.MaxAge or 1) then
            table.insert(v54, {
                Id = v55,
                Data = v56
            });
        end;
    end;
    table.sort(v54, function(p57, p58) --[[ Line: 441 ]]
        return (p57.Data.PlantedAt or 0) < (p58.Data.PlantedAt or 0);
    end);
    for _, v59 in v54 do
        u41(v59.Id, v59.Data);
    end;
end;
function v1.Init(_) --[[ Line: 450 ]]
    -- upvalues: u8 (ref), l__LocalPlayer__7 (copy), u9 (ref), l__ReplicatedStorage__3 (copy), u10 (ref), l__PlayerGui__8 (copy), l__Frame__18 (ref), u11 (ref), u12 (ref), u13 (ref), u18 (ref), u6 (copy), u7 (copy)
    u8 = require(l__LocalPlayer__7.PlayerScripts:WaitForChild("Controllers"):WaitForChild("GardenSyncController"));
    u9 = l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("SeedData"):WaitForChild("FruitImages");
    u10 = l__PlayerGui__8:WaitForChild("GrowingList");
    l__Frame__18 = u10:WaitForChild("Frame");
    u11 = l__Frame__18:WaitForChild("Notepad"):WaitForChild("ScrollingFrame");
    u12 = u11:WaitForChild("Template");
    u13 = u10:WaitForChild("Exit"):WaitForChild("ExitButton");
    u12.Visible = false;
    u11.CanvasSize = UDim2.new(0, 0, 0, u11.UIListLayout.AbsoluteContentSize.Y);
    u18 = false;
    l__Frame__18.Position = u6;
    u13.Position = u7;
    u13.TextLabel.Text = "<";
    u13.TextLabel.TextLabel.Text = "<";
    UpdateScrollingFrame();
end;
function v1.Start(_) --[[ Line: 478 ]]
    -- upvalues: u8 (ref), l__LocalPlayer__7 (copy), u41 (copy), u45 (copy), u15 (copy), u16 (copy), l__RunService__4 (copy), u53 (copy), l__GuiController__13 (copy), u13 (ref), l__MenuOpenClose__1 (copy), u18 (ref), l__Frame__18 (ref), u4 (copy), u5 (copy), u6 (copy), u7 (copy), l__Players__2 (copy), u60 (copy)
    u8:OnPlantAdded(function(p61, p62, p63) --[[ Line: 480 ]]
        -- upvalues: l__LocalPlayer__7 (ref), u41 (ref)
        if p61 == l__LocalPlayer__7.UserId then
            u41(p62, p63);
        end;
    end);
    u8:OnPlantRemoved(function(p64, p65) --[[ Line: 487 ]]
        -- upvalues: l__LocalPlayer__7 (ref), u45 (ref)
        if p64 == l__LocalPlayer__7.UserId then
            u45(p65);
        end;
    end);
    u8:OnPlantGrowthUpdated(function(p66, p67, p68, p69) --[[ Line: 494 ]]
        -- upvalues: l__LocalPlayer__7 (ref), u15 (ref), u16 (ref)
        if p66 == l__LocalPlayer__7.UserId and (u15[p67] and not u16[p67]) then
            if math.abs(p68 - u15[p67].CurrentAge) > 0.5 or p69 <= 0 then
                u15[p67].CurrentAge = p68;
            end;
            u15[p67].StableGrowthAmount = p69;
        end;
    end);
    u8:OnPlantAgeSync(function(p70, p71) --[[ Line: 501 ]]
        -- upvalues: l__LocalPlayer__7 (ref), u15 (ref), u16 (ref)
        if p70 == l__LocalPlayer__7.UserId then
            for v72, v73 in p71 do
                if u15[v72] and (not u16[v72] and u15[v72].CurrentAge < v73) then
                    u15[v72].CurrentAge = v73;
                end;
            end;
        end;
    end);
    local u74 = 0;
    l__RunService__4.Heartbeat:Connect(function(p75) --[[ Line: 517 ]]
        -- upvalues: u74 (ref), u15 (ref), u16 (ref)
        u74 = u74 + p75;
        if u74 < 0.25 then
        else
            local v76 = u74;
            u74 = 0;
            debug.profilebegin("Controllers/GrowingListController/Heartbeat/simulatePlantGrowth");
            for v77, v78 in u15 do
                if not u16[v77] and v78.CurrentAge < v78.MaxAge then
                    v78.CurrentAge = math.min(v78.CurrentAge + v76 * v78.StableGrowthAmount, v78.MaxAge);
                end;
            end;
            debug.profileend();
        end;
    end);
    task.spawn(function() --[[ Line: 534 ]]
        -- upvalues: u15 (ref), u53 (ref)
        while true do
            task.wait(1);
            debug.profilebegin("Controllers/GrowingListController/UI/UpdateAllPlantTemplates");
            local v79 = (1 / 0);
            for v80 in u15 do
                local v81 = u15[v80];
                local v82 = v81.StableGrowthAmount <= 0 and 999999 or (v81.MaxAge - v81.CurrentAge) / v81.StableGrowthAmount;
                if v82 <= v79 then
                    v79 = v82;
                end;
                u53(v80);
            end;
            debug.profileend();
        end;
    end);
    l__GuiController__13:Hook("Click", u13).Clicked:Connect(function() --[[ Line: 560 ]]
        -- upvalues: l__MenuOpenClose__1 (ref), u18 (ref), l__Frame__18 (ref), u4 (ref), u13 (ref), u5 (ref), u6 (ref), u7 (ref)
        l__MenuOpenClose__1.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l__MenuOpenClose__1.TimePosition = 0;
        l__MenuOpenClose__1.Playing = true;
        if u18 then
            l__Frame__18.Position = u6;
            u13.Position = u7;
            u13.TextLabel.Text = "<";
            u13.TextLabel.TextLabel.Text = "<";
        else
            l__Frame__18.Position = u4;
            u13.Position = u5;
            u13.TextLabel.Text = ">";
            u13.TextLabel.TextLabel.Text = ">";
        end;
        u18 = not u18;
        UpdateScrollingFrame();
    end);
    task.spawn(function() --[[ Line: 577 ]]
        -- upvalues: l__LocalPlayer__7 (ref), l__Players__2 (ref), u60 (ref)
        repeat
            task.wait();
        until l__LocalPlayer__7:HasTag("DataLoaded") or not l__LocalPlayer__7:IsDescendantOf(l__Players__2);
        if l__LocalPlayer__7:IsDescendantOf(l__Players__2) then
            task.wait(0.5);
            u60();
        end;
    end);
end;
return v1;