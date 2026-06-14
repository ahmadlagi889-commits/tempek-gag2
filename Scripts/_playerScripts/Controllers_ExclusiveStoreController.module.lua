-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Networking__4 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__NumberUtils__5 = require(l__ReplicatedStorage__3.SharedModules.NumberUtils);
local l__DevProductController__6 = require(l__Players__1.LocalPlayer.PlayerScripts.Controllers.DevProductController);
local l__PlayerSelector__7 = l__Players__1.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PlayerSelector");
local function u8(u2) --[[ Line: 28 ]]
    -- upvalues: l__PlayerSelector__7 (copy), l__Networking__4 (copy), l__DevProductController__6 (copy)
    local u3 = nil;
    task.spawn(function() --[[ Line: 30 ]]
        -- upvalues: l__PlayerSelector__7 (ref), u3 (ref)
        u3 = l__PlayerSelector__7.PlayerSelected.Event:Wait() or "cancelled";
    end);
    l__PlayerSelector__7.Enabled = true;
    repeat
        task.wait();
    until u3 ~= nil;
    if u3 == "cancelled" then
    else
        local v4, v5 = pcall(function() --[[ Line: 43 ]]
            -- upvalues: l__Networking__4 (ref), u3 (ref)
            l__Networking__4.DevProducts.SetGiftTarget:Fire(u3.UserId);
        end);
        if not v4 then
            warn((`[ExclusiveStoreController] SetGiftTarget fire failed ({u2}): {v5}`));
        end;
        local v6, v7 = pcall(function() --[[ Line: 49 ]]
            -- upvalues: l__DevProductController__6 (ref), u2 (copy)
            l__DevProductController__6:PromptPurchase(u2 .. ":Gift");
        end);
        if not v6 then
            warn((`[ExclusiveStoreController] Gift purchase prompt failed ({u2}): {v7}`));
        end;
    end;
end;
function v1.Init(_) --[[ Line: 61 ]] end;
function v1.Setup(_, p9) --[[ Line: 63 ]]
    -- upvalues: l__DevProductController__6 (copy), l__NumberUtils__5 (copy), l__RunService__2 (copy), u8 (copy), l__Networking__4 (copy)
    local l__container__8 = p9.container;
    local l__templates__9 = p9.templates;
    for _, v10 in l__templates__9 do
        v10.Visible = false;
    end;
    local l__Robux_Shelf__10 = l__container__8:WaitForChild("Robux_Shelf");
    l__Robux_Shelf__10.Visible = false;
    local l__Buttons__11 = l__Robux_Shelf__10.Main_Frame.Buttons;
    local u11 = l__Buttons__11:WaitForChild("1Button");
    local l__GiftButton1__12 = l__Buttons__11:WaitForChild("GiftButton1");
    local l__Seed_Name__13 = l__Robux_Shelf__10.Main_Frame:WaitForChild("Seed_Name");
    local u12 = {};
    local u13 = nil;
    local u14 = false;
    local u15 = Color3.fromHex("#2d2617");
    local u16 = Color3.fromHex("#2f0000");
    local u17 = ColorSequence.new(Color3.fromHex("#ff0000"));
    local u18 = {};
    local function u31(p19, p20, p21) --[[ Line: 93 ]]
        -- upvalues: u15 (copy), u16 (copy), u18 (copy), u17 (copy)
        local v22 = p19:FindFirstChild("Text");
        if v22 then
            local v23 = v22:FindFirstChild("TextLabel");
            if v23 then
                local v24 = v23:FindFirstChildWhichIsA("TextLabel");
                local v25 = v23:FindFirstChildWhichIsA("UIStroke");
                if v25 then
                    local v26;
                    if p20 then
                        v26 = u15;
                    else
                        v26 = u16;
                    end;
                    v25.Color = v26;
                end;
                if v24 then
                    local v27 = v24:FindFirstChildWhichIsA("UIStroke");
                    if v27 then
                        local v28;
                        if p20 then
                            v28 = u15;
                        else
                            v28 = u16;
                        end;
                        v27.Color = v28;
                    end;
                    local v29 = v24:FindFirstChildWhichIsA("UIGradient");
                    if v29 then
                        if not u18[p21] then
                            u18[p21] = v29.Color;
                        end;
                        local v30;
                        if p20 then
                            v30 = u18[p21];
                        else
                            v30 = u17;
                        end;
                        v29.Color = v30;
                    end;
                end;
            end;
        end;
    end;
    local function u41() --[[ Line: 139 ]]
        -- upvalues: u13 (ref), l__Robux_Shelf__10 (copy), u12 (copy), l__Seed_Name__13 (copy), l__DevProductController__6 (ref), l__NumberUtils__5 (ref), u11 (copy), l__GiftButton1__12 (copy)
        if not u13 then
            l__Robux_Shelf__10.Visible = false;
            return;
        end;
        local u32, u34;
        if u13 then
            for _, u34 in u12 do
                if u34.frame == u13 then
                    if u34 then
                        u32 = u34.itemData;
                        l__Seed_Name__13.Value = u32.itemName;
                        task.spawn(function() --[[ Line: 155 ]]
                            -- upvalues: l__DevProductController__6 (ref), u32 (copy), u13 (ref), u34 (copy), l__NumberUtils__5 (ref), u11 (ref)
                            local v39 = l__DevProductController__6:WaitForPreloadedProductInfo(u32.productKey, 5);
                            if u13 == u34.frame then
                                if v39 then
                                    local v40 = `{l__NumberUtils__5.FormatWithCommas(v39.PriceInRobux)}`;
                                    u11.TextDisplay.TextLabel.Text = v40;
                                    u11.TextDisplay.TextLabel.TextLabel.Text = v40;
                                else
                                    u11.TextDisplay.TextLabel.Text = "Buy";
                                    u11.TextDisplay.TextLabel.TextLabel.Text = "Buy";
                                end;
                            end;
                        end);
                        l__GiftButton1__12.Visible = u32.giftable;
                        l__Robux_Shelf__10.Visible = true;
                        return;
                    else
                        l__Robux_Shelf__10.Visible = false;
                        return;
                    end;
                end;
            end;
            u34 = nil;
            if u34 then
                u32 = u34.itemData;
                l__Seed_Name__13.Value = u32.itemName;
                task.spawn(function() --[[ Line: 155 ]]
                    -- upvalues: l__DevProductController__6 (ref), u32 (copy), u13 (ref), u34 (copy), l__NumberUtils__5 (ref), u11 (ref)
                    local v39 = l__DevProductController__6:WaitForPreloadedProductInfo(u32.productKey, 5);
                    if u13 == u34.frame then
                        if v39 then
                            local v40 = `{l__NumberUtils__5.FormatWithCommas(v39.PriceInRobux)}`;
                            u11.TextDisplay.TextLabel.Text = v40;
                            u11.TextDisplay.TextLabel.TextLabel.Text = v40;
                        else
                            u11.TextDisplay.TextLabel.Text = "Buy";
                            u11.TextDisplay.TextLabel.TextLabel.Text = "Buy";
                        end;
                    end;
                end);
                l__GiftButton1__12.Visible = u32.giftable;
                l__Robux_Shelf__10.Visible = true;
            else
                l__Robux_Shelf__10.Visible = false;
            end;
        else
            u34 = nil;
            if u34 then
                u32 = u34.itemData;
                l__Seed_Name__13.Value = u32.itemName;
                task.spawn(function() --[[ Line: 155 ]]
                    -- upvalues: l__DevProductController__6 (ref), u32 (copy), u13 (ref), u34 (copy), l__NumberUtils__5 (ref), u11 (ref)
                    local v39 = l__DevProductController__6:WaitForPreloadedProductInfo(u32.productKey, 5);
                    if u13 == u34.frame then
                        if v39 then
                            local v40 = `{l__NumberUtils__5.FormatWithCommas(v39.PriceInRobux)}`;
                            u11.TextDisplay.TextLabel.Text = v40;
                            u11.TextDisplay.TextLabel.TextLabel.Text = v40;
                        else
                            u11.TextDisplay.TextLabel.Text = "Buy";
                            u11.TextDisplay.TextLabel.TextLabel.Text = "Buy";
                        end;
                    end;
                end);
                l__GiftButton1__12.Visible = u32.giftable;
                l__Robux_Shelf__10.Visible = true;
            else
                l__Robux_Shelf__10.Visible = false;
            end;
        end;
    end;
    local function u45(p42) --[[ Line: 174 ]]
        -- upvalues: u12 (copy), u13 (ref), l__Robux_Shelf__10 (copy), u18 (copy)
        local v43 = u12[p42];
        if v43 then
            if u13 == v43.frame then
                u13 = nil;
                l__Robux_Shelf__10.Visible = false;
            end;
            if v43.heartbeat then
                v43.heartbeat:Disconnect();
            end;
            for _, v44 in v43.connections do
                v44:Disconnect();
            end;
            u18[p42] = nil;
            v43.frame:Destroy();
            u12[p42] = nil;
        end;
    end;
    local function u82(u46, p47) --[[ Line: 197 ]]
        -- upvalues: u45 (copy), l__templates__9 (copy), l__container__8 (copy), l__DevProductController__6 (ref), l__NumberUtils__5 (ref), u31 (copy), u13 (ref), l__Robux_Shelf__10 (copy), u12 (copy), u41 (copy), l__RunService__2 (ref)
        u45(u46);
        local v48 = l__templates__9[u46];
        if v48 then
            local u49 = p47.items[1];
            if u49 then
                local u50 = v48:Clone();
                u50.Name = "ActiveDeal_" .. u46;
                u50.Visible = true;
                u50.Parent = l__container__8;
                local v51 = u50:FindFirstChild("Main_Frame");
                if v51 then
                    local v52 = {};
                    local v53 = v51:FindFirstChild("Seed_Text");
                    if v53 then
                        v53.Text = u49.itemName;
                        local v54 = v53:FindFirstChildWhichIsA("TextLabel");
                        if v54 then
                            v54.Text = u49.itemName;
                        end;
                    end;
                    local v55 = v51:FindFirstChild("ImageDisplay");
                    local v56 = v55 and v55:FindFirstChild("Vector");
                    if v56 then
                        v56.Image = u49.image or "";
                    end;
                    local v57 = v51:FindFirstChild("Rarity");
                    local v58 = v57 and v57:FindFirstChild("Rarity_Text");
                    if v58 then
                        v58.Text = u46;
                        local v59 = v58:FindFirstChildWhichIsA("TextLabel");
                        if v59 then
                            v59.Text = u46;
                        end;
                    end;
                    local v60 = v51:FindFirstChild("Stock_Text");
                    if v60 then
                        v60.Text = u49.stock <= 0 and "0 Stock" or "x" .. u49.stock .. " in Stock";
                    end;
                    local v61 = v51:FindFirstChild("SoldOut");
                    if v61 then
                        v61.Visible = u49.stock <= 0;
                    end;
                    local v62 = v51:FindFirstChild("Text");
                    local u63 = v62 and v62:FindFirstChild("TextLabel");
                    if u63 then
                        if u49.stock <= 0 then
                            u63.Text = "SOLD OUT";
                            local v64 = u63:FindFirstChildWhichIsA("TextLabel");
                            if v64 then
                                v64.Text = "SOLD OUT";
                            end;
                        else
                            task.spawn(function() --[[ Line: 269 ]]
                                -- upvalues: l__DevProductController__6 (ref), u49 (copy), l__NumberUtils__5 (ref), u63 (copy)
                                local v65 = l__DevProductController__6:WaitForPreloadedProductInfo(u49.productKey, 5);
                                local v66 = not v65 and "" or `{l__NumberUtils__5.FormatWithCommas(v65.PriceInRobux)}`;
                                u63.Text = v66;
                                local v67 = u63:FindFirstChildWhichIsA("TextLabel");
                                if v67 then
                                    v67.Text = v66;
                                end;
                            end);
                        end;
                    end;
                    u31(v51, u49.stock > 0, u46);
                    local v68 = v51:FindFirstChild("TextButton");
                    if v68 then
                        table.insert(v52, v68.Activated:Connect(function() --[[ Line: 287 ]]
                            -- upvalues: u13 (ref), u50 (copy), l__Robux_Shelf__10 (ref), u12 (ref), u41 (ref)
                            if u13 == u50 then
                                u13 = nil;
                                l__Robux_Shelf__10.Visible = false;
                                return;
                            end;
                            local v69 = nil;
                            for _, v70 in u12 do
                                if v70.frame == u50 then
                                    v69 = v70;
                                    break;
                                end;
                            end;
                            if v69 and v69.itemData.stock <= 0 then
                            else
                                u13 = u50;
                                l__Robux_Shelf__10.LayoutOrder = u50.LayoutOrder + 1;
                                u41();
                            end;
                        end));
                    end;
                    local u71 = v51:FindFirstChild("LeavesIn");
                    local u72;
                    if u71 then
                        u72 = u71:FindFirstChild("Timer");
                    else
                        u72 = u71;
                    end;
                    if u71 then
                        u71 = u71:FindFirstChild("UIGradient");
                    end;
                    local l__expiresAt__14 = p47.expiresAt;
                    local l__restockTime__15 = p47.restockTime;
                    u12[u46] = {
                        frame = u50,
                        heartbeat = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 317 ]]
                            -- upvalues: l__expiresAt__14 (copy), u45 (ref), u46 (copy), u72 (copy), u71 (copy), l__restockTime__15 (copy)
                            local v73 = l__expiresAt__14 - os.time();
                            if v73 <= 0 then
                                u45(u46);
                            else
                                if u72 then
                                    local v74 = u72;
                                    local v75 = math.ceil(v73);
                                    local v76 = math.max(v75, 0);
                                    local v77 = math.floor(v76 / 60);
                                    local v78 = v76 % 60;
                                    local v79;
                                    if v77 > 0 then
                                        v79 = string.format("%dm %ds", v77, v78);
                                    else
                                        v79 = tostring(v78) .. "s";
                                    end;
                                    v74.Text = v79;
                                    local v80 = u72;
                                    local v81;
                                    if v73 <= 30 then
                                        v81 = Color3.fromHex("#ff0000");
                                    else
                                        v81 = Color3.new(1, 1, 1);
                                    end;
                                    v80.TextColor3 = v81;
                                end;
                                if u71 then
                                    u71.Offset = Vector2.new(v73 / l__restockTime__15, 0);
                                end;
                            end;
                        end),
                        itemData = u49,
                        connections = v52
                    };
                end;
            end;
        end;
    end;
    local function u96(p83, p84) --[[ Line: 343 ]]
        -- upvalues: u12 (copy), l__DevProductController__6 (ref), l__NumberUtils__5 (ref), u31 (copy), u13 (ref), l__Robux_Shelf__10 (copy)
        local u85 = u12[p83];
        if u85 then
            local v86 = p84.items[1];
            if v86 then
                u85.itemData.stock = v86.stock;
                local v87 = u85.frame:FindFirstChild("Main_Frame");
                if v87 then
                    local v88 = v87:FindFirstChild("Stock_Text");
                    if v88 then
                        v88.Text = v86.stock <= 0 and "0 Stock" or "x" .. v86.stock .. " in Stock";
                    end;
                    local v89 = v87:FindFirstChild("SoldOut");
                    if v89 then
                        v89.Visible = v86.stock <= 0;
                    end;
                    local v90 = v87:FindFirstChild("Text");
                    local u91 = v90 and v90:FindFirstChild("TextLabel");
                    if u91 then
                        if v86.stock <= 0 then
                            u91.Text = "SOLD OUT";
                            local v92 = u91:FindFirstChildWhichIsA("TextLabel");
                            if v92 then
                                v92.Text = "SOLD OUT";
                            end;
                        else
                            task.spawn(function() --[[ Line: 378 ]]
                                -- upvalues: l__DevProductController__6 (ref), u85 (copy), l__NumberUtils__5 (ref), u91 (copy)
                                local v93 = l__DevProductController__6:WaitForPreloadedProductInfo(u85.itemData.productKey, 5);
                                local v94 = not v93 and "" or `{l__NumberUtils__5.FormatWithCommas(v93.PriceInRobux)}`;
                                u91.Text = v94;
                                local v95 = u91:FindFirstChildWhichIsA("TextLabel");
                                if v95 then
                                    v95.Text = v94;
                                end;
                            end);
                        end;
                    end;
                    u31(v87, v86.stock > 0, p83);
                    if v86.stock <= 0 and u13 == u85.frame then
                        u13 = nil;
                        l__Robux_Shelf__10.Visible = false;
                    end;
                end;
            end;
        end;
    end;
    u11.Activated:Connect(function() --[[ Line: 403 ]]
        -- upvalues: u14 (ref), u13 (ref), u12 (copy), l__DevProductController__6 (ref)
        if u14 then
            return;
        end;
        local v97, v98, u100;
        if u13 then
            for _, u100 in u12 do
                if u100.frame == u13 then
                    if u100 then
                        if u100.itemData.stock <= 0 then
                            return;
                        else
                            u14 = true;
                            v97, v98 = pcall(function() --[[ Line: 410 ]]
                                -- upvalues: l__DevProductController__6 (ref), u100 (copy)
                                l__DevProductController__6:PromptPurchase(u100.itemData.productKey);
                            end);
                            if not v97 then
                                warn((`[ExclusiveStoreController] Buy purchase prompt failed ({u100.itemData.productKey}): {v98}`));
                            end;
                            task.wait();
                            u14 = false;
                            return;
                        end;
                    else
                        return;
                    end;
                end;
            end;
            u100 = nil;
            if u100 then
                if u100.itemData.stock <= 0 then
                else
                    u14 = true;
                    v97, v98 = pcall(function() --[[ Line: 410 ]]
                        -- upvalues: l__DevProductController__6 (ref), u100 (copy)
                        l__DevProductController__6:PromptPurchase(u100.itemData.productKey);
                    end);
                    if not v97 then
                        warn((`[ExclusiveStoreController] Buy purchase prompt failed ({u100.itemData.productKey}): {v98}`));
                    end;
                    task.wait();
                    u14 = false;
                end;
            end;
        else
            u100 = nil;
            if u100 then
                if u100.itemData.stock <= 0 then
                else
                    u14 = true;
                    v97, v98 = pcall(function() --[[ Line: 410 ]]
                        -- upvalues: l__DevProductController__6 (ref), u100 (copy)
                        l__DevProductController__6:PromptPurchase(u100.itemData.productKey);
                    end);
                    if not v97 then
                        warn((`[ExclusiveStoreController] Buy purchase prompt failed ({u100.itemData.productKey}): {v98}`));
                    end;
                    task.wait();
                    u14 = false;
                end;
            end;
        end;
    end);
    l__GiftButton1__12.Activated:Connect(function() --[[ Line: 420 ]]
        -- upvalues: u14 (ref), u13 (ref), u12 (copy), u8 (ref)
        if u14 then
            return;
        end;
        local v101, v102, u104;
        if u13 then
            for _, u104 in u12 do
                if u104.frame == u13 then
                    if u104 then
                        if u104.itemData.stock <= 0 then
                            return;
                        elseif u104.itemData.giftable then
                            u14 = true;
                            v101, v102 = pcall(function() --[[ Line: 428 ]]
                                -- upvalues: u8 (ref), u104 (copy)
                                u8(u104.itemData.productKey);
                            end);
                            if not v101 then
                                warn((`[ExclusiveStoreController] Gift flow failed ({u104.itemData.productKey}): {v102}`));
                            end;
                            task.wait();
                            u14 = false;
                            return;
                        else
                            return;
                        end;
                    else
                        return;
                    end;
                end;
            end;
            u104 = nil;
            if u104 then
                if u104.itemData.stock <= 0 then
                elseif u104.itemData.giftable then
                    u14 = true;
                    v101, v102 = pcall(function() --[[ Line: 428 ]]
                        -- upvalues: u8 (ref), u104 (copy)
                        u8(u104.itemData.productKey);
                    end);
                    if not v101 then
                        warn((`[ExclusiveStoreController] Gift flow failed ({u104.itemData.productKey}): {v102}`));
                    end;
                    task.wait();
                    u14 = false;
                end;
            end;
        else
            u104 = nil;
            if u104 then
                if u104.itemData.stock <= 0 then
                elseif u104.itemData.giftable then
                    u14 = true;
                    v101, v102 = pcall(function() --[[ Line: 428 ]]
                        -- upvalues: u8 (ref), u104 (copy)
                        u8(u104.itemData.productKey);
                    end);
                    if not v101 then
                        warn((`[ExclusiveStoreController] Gift flow failed ({u104.itemData.productKey}): {v102}`));
                    end;
                    task.wait();
                    u14 = false;
                end;
            end;
        end;
    end);
    l__Networking__4.ExclusiveShop.DealUpdate.OnClientEvent:Connect(function(p105) --[[ Line: 441 ]]
        -- upvalues: u12 (copy), u45 (copy), u96 (copy), u82 (copy)
        for v106 in pairs(u12) do
            if not p105[v106] then
                u45(v106);
            end;
        end;
        for v107, v108 in p105 do
            if u12[v107] then
                u96(v107, v108);
            else
                u82(v107, v108);
            end;
        end;
    end);
end;
return v1;