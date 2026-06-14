-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__TweenService__1 = game:GetService("TweenService");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__Players__3 = game:GetService("Players");
local l__MarketplaceService__4 = game:GetService("MarketplaceService");
local u2 = script:WaitForChild("Player"):Clone();
local l__LocalPlayer__5 = l__Players__3.LocalPlayer;
if l__LocalPlayer__5 and l__LocalPlayer__5.UserId then
    task.spawn(function() --[[ Line: 21 ]]
        -- upvalues: l__Players__3 (copy), l__LocalPlayer__5 (copy), u2 (copy)
        local v3, v4 = pcall(l__Players__3.GetHumanoidDescriptionFromUserIdAsync, l__Players__3, l__LocalPlayer__5.UserId);
        if v3 and v4 then
            u2.Parent = script;
            u2.Humanoid:ApplyDescriptionResetAsync(v4);
        end;
    end);
end;
local l__Trove__6 = require(game.ReplicatedStorage.ClientModules.Trove);
local l__GuiController__7 = require(script.Parent:WaitForChild("GuiController"));
local l__SceneApi__8 = require(script:WaitForChild("SceneApi"));
local l__DevProductController__9 = require(script.Parent:WaitForChild("DevProductController"));
local l__Networking__10 = require(game.ReplicatedStorage.SharedModules:WaitForChild("Networking"));
local l__RobuxShopContent__11 = require(game.ReplicatedStorage.SharedModules:WaitForChild("RobuxShopContent"));
local l__DevProducts__12 = require(game.ReplicatedStorage.SharedModules:WaitForChild("DevProducts"));
local l__NumberUtils__13 = require(game.ReplicatedStorage.SharedModules:WaitForChild("NumberUtils"));
local l__GearCinematicBars__14 = l__LocalPlayer__5:WaitForChild("PlayerGui"):WaitForChild("GearCinematicBars");
local l__BottomBar__15 = l__GearCinematicBars__14:WaitForChild("BottomBar");
local l__TopBar__16 = l__GearCinematicBars__14:WaitForChild("TopBar");
local l__Prizes__17 = l__GearCinematicBars__14:WaitForChild("PrizesUI"):WaitForChild("Prizes");
local l__BuyButton__18 = l__BottomBar__15:WaitForChild("BuyButton");
local l__GiftButton__19 = l__BottomBar__15:WaitForChild("GiftButton");
local l__PlayerSelector__20 = l__LocalPlayer__5:WaitForChild("PlayerGui"):WaitForChild("PlayerSelector");
local l__GearShopData__21 = require(game.ReplicatedStorage.SharedModules:WaitForChild("GearShopData"));
local l__Items__22 = game.ReplicatedStorage:WaitForChild("StockValues"):WaitForChild("GearShop"):WaitForChild("Items");
local u5 = {};
for _, v6 in l__GearShopData__21.Data do
    u5[v6.ItemName] = v6;
end;
local u7 = {};
for _, v8 in l__RobuxShopContent__11.Gears do
    if v8.GamepassKey then
        u7[v8.Name] = v8.GamepassKey;
    end;
end;
local u9 = {};
local u10 = false;
local u11 = false;
local u12 = Instance.new("BindableEvent");
local u13 = {};
local u14 = nil;
local u15 = nil;
local function u19() --[[ Line: 80 ]]
    -- upvalues: u10 (ref), u11 (ref), u12 (copy), l__Networking__10 (copy), u9 (copy)
    if u10 then
    elseif u11 then
        u12.Event:Wait();
    else
        u11 = true;
        local v16, v17 = pcall(function() --[[ Line: 88 ]]
            -- upvalues: l__Networking__10 (ref)
            return l__Networking__10.GearShop.RequestEquippableState:Fire();
        end);
        if v16 and (typeof(v17) == "table" and typeof(v17.OwnedEquippableGears) == "table") then
            for v18 in v17.OwnedEquippableGears do
                u9[v18] = true;
            end;
        end;
        u10 = true;
        u11 = false;
        u12:Fire();
    end;
end;
task.spawn(u19);
l__Networking__10.GearShop.GearEquipState.OnClientEvent:Connect(function(p20, p21) --[[ Line: 103 ]]
    -- upvalues: u9 (copy), u14 (ref), u15 (ref)
    if type(p20) == "string" then
        if p21 then
            u9[p20] = true;
        end;
        if p20 == u14 and u15 then
            u15();
        end;
    end;
end);
l__LocalPlayer__5:GetAttributeChangedSignal("OwnedGamepasses"):Connect(function() --[[ Line: 113 ]]
    -- upvalues: u15 (ref)
    if u15 then
        u15();
    end;
end);
local function u25(p22) --[[ Line: 125 ]]
    -- upvalues: u9 (copy), u7 (copy), l__LocalPlayer__5 (copy)
    if u9[p22] then
        return true;
    end;
    if not u7[p22] then
        return false;
    end;
    local v23 = l__LocalPlayer__5:GetAttribute("OwnedGamepasses");
    if type(v23) ~= "string" or v23 == "" then
        return false;
    end;
    for v24 in v23:gmatch("[^,]+") do
        if v24 == p22 then
            return true;
        end;
    end;
    return false;
end;
local function u32(p26) --[[ Line: 136 ]]
    -- upvalues: u7 (copy), l__DevProducts__12 (copy), l__DevProductController__9 (copy), u13 (copy), l__MarketplaceService__4 (copy)
    local v27 = u7[p26];
    if v27 then
        local v28 = l__DevProducts__12.GetGamepassByKey(v27);
        if not v28 then
            l__DevProductController__9:WaitForGamepassesReady();
            v28 = l__DevProducts__12.GetGamepassByKey(v27);
        end;
        if not v28 then
            return nil;
        end;
        local l__GamepassId__23 = v28.GamepassId;
        if type(l__GamepassId__23) ~= "number" then
            return nil;
        end;
        if u13[l__GamepassId__23] then
            return u13[l__GamepassId__23];
        end;
        local v29, v30 = pcall(l__MarketplaceService__4.GetProductInfoAsync, l__MarketplaceService__4, l__GamepassId__23, Enum.InfoType.GamePass);
        if not v29 or (not v30 or type(v30.PriceInRobux) ~= "number") then
            return nil;
        end;
        u13[l__GamepassId__23] = v30.PriceInRobux;
        return v30.PriceInRobux;
    else
        local v31 = l__DevProductController__9:WaitForPreloadedProductInfo(`Gear:{p26}:1`, 5);
        if v31 and type(v31.PriceInRobux) == "number" then
            return v31.PriceInRobux;
        else
            return nil;
        end;
    end;
end;
local u33 = l__Trove__6.new();
local u34 = nil;
local u35 = nil;
local u36 = nil;
local u37 = nil;
local u38 = nil;
local function u43() --[[ Line: 187 ]]
    -- upvalues: u38 (ref)
    if u38 then
        return u38;
    end;
    u38 = {};
    for _, v39 in script:WaitForChild("GearScenes"):GetChildren() do
        local v40 = string.lower(v39.Name);
        if v39:IsA("Folder") or v39:IsA("Model") then
            local v41 = v39:FindFirstChild("Scene") or v39:FindFirstChildWhichIsA("ModuleScript");
            local v42 = v39:FindFirstChild("FakePlot");
            if v41 and v41:IsA("ModuleScript") then
                u38[v40] = {
                    Module = v41,
                    FakePlot = v42
                };
            end;
        elseif v39:IsA("ModuleScript") then
            u38[v40] = {
                FakePlot = nil,
                Module = v39
            };
        end;
    end;
    return u38;
end;
local function u47() --[[ Line: 231 ]]
    -- upvalues: u43 (copy), u5 (copy)
    local v44 = {};
    for v45, _ in u43() do
        if v45 ~= "default" then
            for v46, _ in u5 do
                if string.lower(v46) == v45 then
                    table.insert(v44, v46);
                    break;
                end;
            end;
        end;
    end;
    return v44;
end;
local function u56(u48, p49) --[[ Line: 258 ]]
    -- upvalues: l__PlayerSelector__20 (copy), l__Players__3 (copy), l__Networking__10 (copy), l__DevProductController__9 (copy)
    local u50 = nil;
    task.spawn(function() --[[ Line: 260 ]]
        -- upvalues: l__PlayerSelector__20 (ref), u50 (ref)
        local v51 = l__PlayerSelector__20.PlayerSelected.Event:Wait();
        if v51 == nil then
            u50 = "cancelled";
        else
            u50 = v51;
        end;
    end);
    l__PlayerSelector__20.Enabled = true;
    repeat
        task.wait();
    until u50 ~= nil;
    if u50 == "cancelled" then
    else
        if p49 then
            local l__Player__24 = u50.Player;
            if not (l__Player__24 and l__Player__24:IsDescendantOf(l__Players__3)) then
                game.ReplicatedStorage:FindFirstChild("Notify"):Fire("That player went offline.");
                return;
            end;
        end;
        local v52, v53 = pcall(function() --[[ Line: 283 ]]
            -- upvalues: l__Networking__10 (ref), u50 (ref)
            l__Networking__10.DevProducts.SetGiftTarget:Fire(u50.UserId);
        end);
        if not v52 then
            warn((`[GearInspectController] SetGiftTarget fire failed ({u48}): {v53}`));
        end;
        local v54, v55 = pcall(function() --[[ Line: 289 ]]
            -- upvalues: l__DevProductController__9 (ref), u48 (copy)
            l__DevProductController__9:PromptPurchase((`{u48}:Gift`));
        end);
        if not v54 then
            warn((`[GearInspectController] Gift purchase prompt failed ({u48}): {v55}`));
        end;
    end;
end;
local function u71(u57) --[[ Line: 298 ]]
    -- upvalues: u19 (copy), u7 (copy), l__BuyButton__18 (copy), u5 (copy), u25 (copy), u32 (copy), l__NumberUtils__13 (copy), u14 (ref), u15 (ref), u33 (copy), l__DevProductController__9 (copy), l__GiftButton__19 (copy), u56 (copy)
    u19();
    local u58 = u7[u57];
    local u59;
    if u58 then
        u59 = true;
    else
        u58 = `Gear:{u57}:1`;
        u59 = false;
    end;
    local u60 = l__BuyButton__18:FindFirstChild("Price");
    local u61;
    if u60 then
        u61 = u60:FindFirstChild("TextLabel");
    else
        u61 = u60;
    end;
    local function u67() --[[ Line: 315 ]]
        -- upvalues: u57 (copy), u7 (ref), u5 (ref), u25 (ref), u60 (copy), u61 (copy), u32 (ref), l__NumberUtils__13 (ref)
        local v62 = u57;
        local v63;
        if u7[v62] then
            v63 = true;
        else
            local v64 = u5[v62];
            if v64 == nil then
                v63 = false;
            else
                v63 = v64.EquippableGear == true;
            end;
        end;
        if v63 and u25(u57) then
            if u60 and u60.Parent then
                u60.Text = "OWNED";
            end;
            if u61 and u61.Parent then
                u61.Text = "OWNED";
            end;
        else
            local v65 = u32(u57);
            if v65 then
                local v66 = `{l__NumberUtils__13.FormatWithCommas(v65)}`;
                if u60 and u60.Parent then
                    u60.Text = v66;
                end;
                if u61 and u61.Parent then
                    u61.Text = v66;
                end;
            else
                if u60 and u60.Parent then
                    u60.Text = "...";
                end;
                if u61 and u61.Parent then
                    u61.Text = "...";
                end;
            end;
        end;
    end;
    l__BuyButton__18.Visible = true;
    u67();
    u14 = u57;
    u15 = u67;
    u33:Add(function() --[[ Line: 333 ]]
        -- upvalues: u14 (ref), u57 (copy), u15 (ref)
        if u14 == u57 then
            u14 = nil;
            u15 = nil;
        end;
    end);
    u33:Add(l__BuyButton__18.Activated:Connect(function() --[[ Line: 340 ]]
        -- upvalues: u57 (copy), u7 (ref), u5 (ref), u25 (ref), u67 (copy), u59 (copy), l__DevProductController__9 (ref), u58 (copy)
        local v68 = u57;
        local v69;
        if u7[v68] then
            v69 = true;
        else
            local v70 = u5[v68];
            if v70 == nil then
                v69 = false;
            else
                v69 = v70.EquippableGear == true;
            end;
        end;
        if v69 and u25(u57) then
            u67();
        elseif u59 then
            l__DevProductController__9:PromptGamepassPurchase(u58);
        else
            l__DevProductController__9:PromptPurchase(u58);
        end;
    end));
    u33:Add(l__GiftButton__19.Activated:Connect(function() --[[ Line: 352 ]]
        -- upvalues: u56 (ref), u58 (copy), u59 (copy)
        u56(u58, u59);
    end));
end;
local function u80(p72) --[[ Line: 364 ]]
    -- upvalues: u47 (copy), l__Items__22 (copy), l__Prizes__17 (copy), u5 (copy), u33 (copy), u34 (ref), u1 (copy)
    local v73 = {};
    for _, v74 in u47() do
        if v74 ~= p72 then
            local v75 = l__Items__22:FindFirstChild(v74);
            if v75 and v75.Value > 0 and true or false then
                table.insert(v73, v74);
            end;
        end;
    end;
    local v76 = 1;
    while l__Prizes__17:FindFirstChild((`Item{v76}`)) do
        local v77 = l__Prizes__17:FindFirstChild((`Item{v76}`));
        local u78 = v73[v76];
        if u78 then
            local v79 = u5[u78];
            v77.Visible = true;
            if v77:FindFirstChild("ItemImage") and (v79 and v79.IMG) then
                v77.ItemImage.Image = v79.IMG;
            end;
            if v77:FindFirstChild("ItemName") then
                v77.ItemName.Text = u78;
            end;
            if v77:FindFirstChild("Odds") then
                v77.Odds.Visible = false;
            end;
            if v77:FindFirstChild("Inspect") then
                u33:Add(v77.Inspect.Activated:Connect(function() --[[ Line: 393 ]]
                    -- upvalues: u34 (ref), u1 (ref), u78 (copy)
                    u1.Inspect({
                        GearName = u78
                    }, u34);
                end));
            end;
        else
            v77.Visible = false;
        end;
        v76 = v76 + 1;
    end;
end;
local function u81() --[[ Line: 407 ]]
    -- upvalues: l__TweenService__1 (copy), l__BottomBar__15 (copy), l__TopBar__16 (copy), l__Prizes__17 (copy)
    l__TweenService__1:Create(l__BottomBar__15, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 0)
    }):Play();
    l__TweenService__1:Create(l__TopBar__16, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 1)
    }):Play();
    l__TweenService__1:Create(l__Prizes__17, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(1, 0.5)
    }):Play();
end;
local function u82() --[[ Line: 414 ]]
    -- upvalues: l__TweenService__1 (copy), l__BottomBar__15 (copy), l__TopBar__16 (copy), l__Prizes__17 (copy)
    l__TweenService__1:Create(l__BottomBar__15, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 1)
    }):Play();
    l__TweenService__1:Create(l__TopBar__16, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 0)
    }):Play();
    l__TweenService__1:Create(l__Prizes__17, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(0, 0.5)
    }):Play();
end;
function u1.Stop(p83) --[[ Line: 421 ]]
    -- upvalues: u36 (ref), u33 (copy), u81 (copy), u37 (ref), u34 (ref), u35 (ref)
    if u36 then
        pcall(u36, true);
        u36 = nil;
    end;
    if u33 then
        u33:Clean();
    end;
    if p83 then
        u81();
        if u37 then
            local l__CurrentCamera__25 = game.Workspace.CurrentCamera;
            l__CurrentCamera__25.CameraType = u37.CameraType;
            l__CurrentCamera__25.CameraSubject = u37.CameraSubject;
            l__CurrentCamera__25.FieldOfView = u37.FieldOfView;
            l__CurrentCamera__25.CFrame = u37.CFrame;
            u37 = nil;
        end;
        u34 = nil;
        u35 = nil;
    end;
end;
function u1.Start(_) --[[ Line: 454 ]] end;
function u1.Init(_) --[[ Line: 458 ]] end;
function u1.Inspect(p84, p85, p86) --[[ Line: 463 ]]
    -- upvalues: u35 (ref), u37 (ref), u1 (copy), u43 (copy), u33 (copy), u2 (copy), l__GuiController__7 (copy), u34 (ref), l__LocalPlayer__5 (copy), l__StarterGui__2 (copy), u80 (copy), u71 (copy), u82 (copy), l__TopBar__16 (copy), l__SceneApi__8 (copy), u36 (ref)
    local v87 = p84.GearName or p84.Name;
    u35 = v87;
    if not u37 then
        local l__CurrentCamera__26 = game.Workspace.CurrentCamera;
        u37 = {
            CameraType = l__CurrentCamera__26.CameraType,
            CameraSubject = l__CurrentCamera__26.CameraSubject,
            FieldOfView = l__CurrentCamera__26.FieldOfView,
            CFrame = l__CurrentCamera__26.CFrame
        };
    end;
    u1.Stop(false);
    local v88 = p86 or {};
    local v89 = u43();
    local l__default__27 = v89.default;
    local v90 = v89[string.lower(v87)] or l__default__27;
    local v91, v92;
    if v90 then
        v91 = v90.FakePlot or (l__default__27 and l__default__27.FakePlot or nil);
        v92 = require(v90.Module);
    else
        v92 = nil;
        v91 = nil;
    end;
    if v92 then
        if v91 then
            local v93 = v91:Clone();
            v93.Parent = game.Workspace;
            u33:Add(v93);
            local v94 = u2:Clone();
            v94.Parent = v93;
            local l__Humanoid__28 = v94:WaitForChild("Humanoid");
            if v94.PrimaryPart then
                v94.PrimaryPart.Anchored = false;
                local v95 = v93:FindFirstChild("PlayerSpawn", true);
                if v95 and v95:IsA("BasePart") then
                    v94:PivotTo(v95.CFrame + Vector3.new(0, 3, 0));
                elseif v93.PrimaryPart then
                    v94:PivotTo(v93.PrimaryPart.CFrame + Vector3.new(0, v93.PrimaryPart.Size.Y / 2 + 3, 0));
                end;
            end;
            l__GuiController__7:Close();
            if p85 then
                u34 = p85;
            end;
            local u96 = {};
            for _, v97 in l__LocalPlayer__5.PlayerGui:GetChildren() do
                if v97:IsA("ScreenGui") and v97.Name ~= "GearCinematicBars" then
                    u96[v97] = v97.Enabled;
                    v97.Enabled = false;
                end;
            end;
            l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
            l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
            l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            u33:Add(function() --[[ Line: 539 ]]
                -- upvalues: l__StarterGui__2 (ref), u96 (copy)
                l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
                l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
                for v98, v99 in u96 do
                    if v98 then
                        v98.Enabled = v99;
                    end;
                end;
            end);
            u80(v87);
            u71(v87);
            u82();
            l__TopBar__16.NameLabel.Text = `{string.upper(v87)} GEAR`;
            l__TopBar__16.NameLabel.TextLabel.Text = `{string.upper(v87)} GEAR`;
            u33:Add(l__TopBar__16.ExitButton.Activated:Connect(function() --[[ Line: 560 ]]
                -- upvalues: u34 (ref), u1 (ref)
                local v100 = u34;
                u1.Stop(true);
                if v100 then
                    v100();
                end;
            end));
            math.randomseed(os.clock() * 1000);
            local v101 = l__SceneApi__8.new({
                Plot = v93,
                PlayerModel = v94,
                PlayerHumanoid = l__Humanoid__28,
                Camera = game.Workspace.CurrentCamera,
                Trove = u33,
                GearData = p84,
                Options = v88
            });
            u36 = v92.Run(v101);
        end;
    end;
end;
return u1;