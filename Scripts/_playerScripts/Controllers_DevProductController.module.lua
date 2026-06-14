-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 3
};
local l__Players__1 = game:GetService("Players");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__Signal__5 = require(l__ReplicatedStorage__3.ClientModules.Signal);
local l__MessagePrompt__6 = require(l__ReplicatedStorage__3.ClientModules.MessagePrompt);
local l__Networking__7 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__DevProducts__8 = require(l__ReplicatedStorage__3.SharedModules.DevProducts);
local l__Environment__9 = require(l__ReplicatedStorage__3.SharedModules.Environment);
local l__PlayerStateClient__10 = require(l__ReplicatedStorage__3.ClientModules.PlayerStateClient);
local l__LocalPlayer__11 = l__Players__1.LocalPlayer;
local u2 = l__Environment__9.env == "Dev" and true or l__RunService__4:IsStudio();
local u3 = l__Signal__5.new();
local u4 = l__Signal__5.new();
local u5 = l__Signal__5.new();
local u6 = l__Signal__5.new();
v1.PurchaseStartedSignal = u3;
v1.PurchaseCancelledSignal = u4;
v1.PurchaseCompleteSignal = u5;
v1.PurchaseFailedSignal = u6;
v1.PurchaseStarted = u3;
v1.PurchaseCancelled = u4;
v1.PurchaseComplete = u5;
v1.PurchaseFailed = u6;
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = false;
local u11 = false;
local u12 = false;
local u13 = false;
local function u49(p14, u15) --[[ Line: 83 ]]
    -- upvalues: l__LocalPlayer__11 (copy), u9 (copy), l__MarketplaceService__2 (copy)
    local v16 = l__LocalPlayer__11:FindFirstChildOfClass("PlayerGui");
    if not v16 then
        return nil;
    end;
    local u17 = v16:FindFirstChild("PreRobuxPrompt");
    if not u17 then
        return nil;
    end;
    local v18 = u9[u15];
    local v19;
    if v18 then
        v19 = v18;
    else
        local v20;
        v20, v19 = pcall(function() --[[ Line: 96 ]]
            -- upvalues: l__MarketplaceService__2 (ref), u15 (copy)
            return l__MarketplaceService__2:GetProductInfoAsync(u15, Enum.InfoType.Product);
        end);
        if v20 then
            u9[u15] = v19;
        else
            v19 = v18;
        end;
    end;
    local v21;
    if v19 then
        v21 = v19.Name;
    else
        v21 = v19;
    end;
    local v22;
    if v19 then
        v22 = v19.PriceInRobux;
    else
        v22 = v19;
    end;
    if v19 then
        v19 = v19.IconImageAssetId;
    end;
    local v23;
    if type(v19) == "number" then
        v23 = "rbxassetid://" .. tostring(v19);
    else
        v23 = "https://www.roblox.com/thumbs/asset.ashx?assetid=" .. tostring(u15) .. "&x=100&y=100&format=png";
    end;
    local v24 = type(v22) ~= "number" and "<font family=\"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json\" weight=\"400\">robux</font> ?" or `<font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="400">robux</font> {v22}`;
    if type(v21) ~= "string" or v21 == "" then
        v21 = p14;
    end;
    local function v28(p25, p26) --[[ Line: 115 ]]
        for _, v27 in ipairs(p26) do
            p25 = p25:FindFirstChild(v27);
            if not p25 then
                return nil;
            end;
        end;
        return p25;
    end;
    local v29 = v28(u17, {
        "ProductPurchaseModal",
        "SheetContainer",
        "Sheet",
        "Content",
        "Content",
        "ScrollingFrame",
        "ScrollingFrame",
        "SheetContentContainer",
        "ProductDetailsContainer",
        "ProductDetails"
    });
    if v29 then
        local v30 = v28(v29, { "ItemDetailsFrame", "ItemDetailsFrame", "ItemName" });
        local v31 = v29:FindFirstChild("ItemIcon");
        local v32 = v28(v29, { "ItemDetailsFrame", "ItemDetails", "ItemCost" });
        if v30 and (v30 and (v30:IsA("TextLabel") or (v30:IsA("TextButton") or v30:IsA("TextBox")))) then
            v30.Text = v21;
        end;
        if v31 and (v31 and (v31:IsA("ImageLabel") or v31:IsA("ImageButton"))) then
            v31.Image = v23;
        end;
        if v32 and (v32 and (v32:IsA("TextLabel") or (v32:IsA("TextButton") or v32:IsA("TextBox")))) then
            v32.Text = v24;
        end;
    end;
    local v33 = v28(u17, {
        "ProductPurchaseModal",
        "SheetContainer",
        "Sheet",
        "Content",
        "Actions",
        "1"
    });
    if not v33 then
        return nil;
    end;
    local v34 = v33:FindFirstChild("BuyRobux");
    local v35 = v33:FindFirstChild("BuyTokens");
    if not (v34 and v35) then
        return nil;
    end;
    if u17:IsA("ScreenGui") then
        u17.Enabled = true;
    elseif u17:IsA("LayerCollector") then
        u17.Enabled = true;
    elseif u17:IsA("GuiObject") then
        u17.Visible = true;
    end;
    local u36 = false;
    local u37 = nil;
    local v38 = v34.MouseButton1Click:Connect(function() --[[ Line: 177 ]]
        -- upvalues: u36 (ref), u37 (ref)
        if u36 then
        else
            u36 = true;
            u37 = "Robux";
        end;
    end);
    local v39 = v35.MouseButton1Click:Connect(function() --[[ Line: 181 ]]
        -- upvalues: u36 (ref), u37 (ref)
        if u36 then
        else
            u36 = true;
            u37 = "Tokens";
        end;
    end);
    local v40 = {};
    local v41, v42 = pcall(function() --[[ Line: 187 ]]
        -- upvalues: u17 (copy)
        return u17.ProductPurchaseModal.Backdrop;
    end);
    if v41 and (v42 and v42:IsA("GuiButton")) then
        v40[#v40 + 1] = v42.MouseButton1Click:Connect(function() --[[ Line: 191 ]]
            -- upvalues: u36 (ref), u37 (ref)
            if u36 then
            else
                u36 = true;
                u37 = nil;
            end;
        end);
    end;
    local v43, v44 = pcall(function() --[[ Line: 196 ]]
        -- upvalues: u17 (copy)
        return u17.ProductPurchaseModal.SheetContainer.Sheet.Content.Header.Content.CloseAffordance;
    end);
    if v43 and (v44 and v44:IsA("GuiButton")) then
        v40[#v40 + 1] = v44.MouseButton1Click:Connect(function() --[[ Line: 200 ]]
            -- upvalues: u36 (ref), u37 (ref)
            if u36 then
            else
                u36 = true;
                u37 = nil;
            end;
        end);
    end;
    local v45;
    if u17:IsA("ScreenGui") or u17:IsA("LayerCollector") then
        v45 = u17:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 208 ]]
            -- upvalues: u17 (copy), u36 (ref), u37 (ref)
            if u17.Enabled == false then
                if u36 then
                    return;
                end;
                u36 = true;
                u37 = nil;
            end;
        end);
    else
        v45 = nil;
    end;
    local v46 = os.clock();
    local v47 = u37;
    while not u36 and (u17.Parent and os.clock() - v46 <= 60) do
        task.wait();
    end;
    if v38 then
        v38:Disconnect();
    end;
    if v39 then
        v39:Disconnect();
    end;
    if v45 then
        v45:Disconnect();
    end;
    for _, v48 in ipairs(v40) do
        v48:Disconnect();
    end;
    if u17:IsA("ScreenGui") then
        u17.Enabled = false;
    elseif u17:IsA("LayerCollector") then
        u17.Enabled = false;
    elseif u17:IsA("GuiObject") then
        u17.Visible = false;
    end;
    return v47;
end;
local u50 = Instance.new("BindableEvent");
local function u61() --[[ Line: 237 ]]
    -- upvalues: u10 (ref), u11 (ref), l__DevProducts__8 (copy), u9 (copy), u12 (ref), u50 (copy), l__MarketplaceService__2 (copy)
    if u10 then
    else
        u10 = true;
        if not u11 then
            repeat
                task.wait();
            until u11;
        end;
        local v51 = {};
        for _, v52 in l__DevProducts__8.Products do
            local v53;
            if type(v52) == "table" then
                v53 = v52.ProductId or nil;
            else
                v53 = nil;
            end;
            if type(v53) == "number" and not v51[v53] then
                v51[v53] = true;
            end;
        end;
        local v54 = {};
        for v55 in v51 do
            if u9[v55] == nil then
                table.insert(v54, v55);
            end;
        end;
        if #v54 == 0 then
            u12 = true;
            u50:Fire();
        else
            local u56 = #v54;
            for _, u57 in v54 do
                task.spawn(function() --[[ Line: 269 ]]
                    -- upvalues: l__MarketplaceService__2 (ref), u57 (copy), u9 (ref), u56 (ref), u12 (ref), u50 (ref)
                    for v58 = 1, 3 do
                        local v59, v60 = pcall(l__MarketplaceService__2.GetProductInfoAsync, l__MarketplaceService__2, u57, Enum.InfoType.Product);
                        if v59 then
                            u9[u57] = v60;
                            break;
                        end;
                        if v58 < 3 then
                            task.wait(v58 * 0.5);
                        end;
                    end;
                    u56 = u56 - 1;
                    if u56 == 0 then
                        u12 = true;
                        u50:Fire();
                    end;
                end);
            end;
        end;
    end;
end;
function v1.GetPreloadedProductInfoByProductId(_, p62) --[[ Line: 290 ]]
    -- upvalues: u9 (copy)
    return u9[p62];
end;
function v1.GetPreloadedProductInfo(_, p63) --[[ Line: 294 ]]
    -- upvalues: l__DevProducts__8 (copy), u9 (copy)
    local v64 = l__DevProducts__8.GetByKey(p63);
    if v64 then
        local l__ProductId__12 = v64.ProductId;
        if type(l__ProductId__12) == "number" then
            return u9[l__ProductId__12];
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.WaitForPreloadedProductInfoByProductId(_, p65, _) --[[ Line: 306 ]]
    -- upvalues: u12 (ref), u50 (copy), u9 (copy)
    if not u12 then
        u50.Event:Wait();
    end;
    if type(p65) == "number" then
        return u9[p65];
    else
        return nil;
    end;
end;
function v1.WaitForPreloadedProductInfo(_, p66, _) --[[ Line: 314 ]]
    -- upvalues: u12 (ref), u50 (copy), l__DevProducts__8 (copy), u9 (copy)
    if not u12 then
        u50.Event:Wait();
    end;
    local v67 = l__DevProducts__8.GetByKey(p66);
    if v67 then
        local l__ProductId__13 = v67.ProductId;
        if type(l__ProductId__13) == "number" then
            return u9[l__ProductId__13];
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.PromptPurchaseInternal(_, p68) --[[ Line: 327 ]]
    -- upvalues: l__DevProducts__8 (copy), l__PlayerStateClient__10 (copy), u49 (copy), l__Networking__7 (copy), l__MarketplaceService__2 (copy), l__LocalPlayer__11 (copy)
    local v69 = l__DevProducts__8.GetByKey(p68);
    if not v69 then
        return false, "Invalid product";
    end;
    local l__ProductId__14 = v69.ProductId;
    if type(l__ProductId__14) ~= "number" then
        return false, "Invalid product";
    end;
    local l__TokenCost__15 = v69.TokenCost;
    local v70 = l__PlayerStateClient__10:GetLocalReplica() or l__PlayerStateClient__10:WaitForLocalReplica(2);
    local v71 = v70 and (v70.Data.Tokens or 0) or 0;
    local v72;
    if type(l__TokenCost__15) == "number" and l__TokenCost__15 >= 0 then
        v72 = l__TokenCost__15 <= v71;
    else
        v72 = false;
    end;
    if not v72 then
        l__MarketplaceService__2:PromptProductPurchase(l__LocalPlayer__11, l__ProductId__14);
        return true, "Prompted Robux";
    end;
    local v73 = u49(p68, l__ProductId__14);
    if v73 == "Tokens" then
        return l__Networking__7.DevProducts.PurchaseWithTokens:Fire(p68);
    end;
    if v73 ~= "Robux" then
        return false, "Cancelled";
    end;
    l__MarketplaceService__2:PromptProductPurchase(l__LocalPlayer__11, l__ProductId__14);
    return true, "Prompted Robux";
end;
function v1.Init(_) --[[ Line: 359 ]]
    -- upvalues: l__MarketplaceService__2 (copy), l__LocalPlayer__11 (copy), u7 (copy), u5 (copy), u6 (copy), u8 (copy), u2 (copy), l__Networking__7 (copy), l__DevProducts__8 (copy), u11 (ref), u61 (copy), u13 (ref)
    l__MarketplaceService__2.PromptProductPurchaseFinished:Connect(function(p74, p75, p76) --[[ Line: 360 ]]
        -- upvalues: l__LocalPlayer__11 (ref), u7 (ref), u5 (ref), u6 (ref)
        if p74 == l__LocalPlayer__11.UserId then
            local v77 = u7[p75];
            if v77 then
                u7[p75] = nil;
                if p76 then
                    u5:Fire(v77);
                else
                    u6:Fire(v77, "Robux purchase cancelled");
                end;
            end;
        end;
    end);
    l__MarketplaceService__2.PromptGamePassPurchaseFinished:Connect(function(p78, u79, p80) --[[ Line: 374 ]]
        -- upvalues: l__LocalPlayer__11 (ref), u8 (ref), u2 (ref), l__Networking__7 (ref), u5 (ref), u6 (ref)
        if p78 == l__LocalPlayer__11 then
            local u81 = u8[u79];
            if u81 then
                u8[u79] = nil;
                if p80 then
                    task.spawn(function() --[[ Line: 390 ]]
                        -- upvalues: u81 (copy), u79 (copy), u2 (ref), l__Networking__7 (ref), u5 (ref), u6 (ref)
                        local v82 = `[GamepassGearDebug] purchase finished for {u81} (id {u79}); notifying server`;
                        if u2 then
                            print(v82);
                        end;
                        local v83, v84, v85 = pcall(l__Networking__7.DevProducts.GamepassPurchased.Fire, l__Networking__7.DevProducts.GamepassPurchased, u81);
                        if v83 and v84 then
                            local v86 = `[GamepassGearDebug] server confirmed grant for {u81}`;
                            if u2 then
                                print(v86);
                            end;
                            u5:Fire(u81);
                        else
                            local v87 = warn;
                            local v88 = "[GamepassGearDebug] server grant FAILED for %*: invokeOk=%*, message=%*";
                            local v89 = u81;
                            if v83 then
                                v84 = v85;
                            end;
                            v87((v88:format(v89, v83, v84)));
                            u6:Fire(u81, not v83 and "Server error" or v85);
                        end;
                    end);
                else
                    u6:Fire(u81, "Gamepass purchase cancelled");
                end;
            else
                if p80 then
                    warn((`[GamepassGearDebug] gamepass {u79} purchased but no pending key; server NOT notified`));
                end;
            end;
        end;
    end);
    task.spawn(function() --[[ Line: 406 ]]
        -- upvalues: l__DevProducts__8 (ref), u11 (ref), u61 (ref)
        local v90 = workspace:GetAttribute("RemoteDeveloperProducts");
        if not v90 then
            workspace:GetAttributeChangedSignal("RemoteDeveloperProducts"):Wait();
            v90 = workspace:GetAttribute("RemoteDeveloperProducts");
        end;
        for _, v91 in game:GetService("HttpService"):JSONDecode(v90) do
            l__DevProducts__8.AddProduct({
                Key = v91[1],
                ProductId = v91[3],
                TokenCost = v91[2]
            });
        end;
        u11 = true;
        task.spawn(u61);
    end);
    task.spawn(function() --[[ Line: 425 ]]
        -- upvalues: l__DevProducts__8 (ref), u13 (ref)
        local v92 = workspace:GetAttribute("RemoteGamepasses");
        if not v92 then
            workspace:GetAttributeChangedSignal("RemoteGamepasses"):Wait();
            v92 = workspace:GetAttribute("RemoteGamepasses");
        end;
        for _, v93 in game:GetService("HttpService"):JSONDecode(v92) do
            l__DevProducts__8.AddGamepass({
                Key = v93[1],
                GamepassId = v93[2],
                Name = v93[3],
                Image = v93[4]
            });
        end;
        u13 = true;
    end);
end;
function v1.PromptPurchase(p94, p95) --[[ Line: 444 ]]
    -- upvalues: u3 (copy), l__DevProducts__8 (copy), u6 (copy), l__Environment__9 (copy), u9 (copy), l__MessagePrompt__6 (copy), l__Networking__7 (copy), u5 (copy), u4 (copy), u7 (copy)
    u3:Fire(p95);
    local v96 = l__DevProducts__8.GetByKey(p95);
    if v96 then
        local v97 = workspace:GetAttribute("InstantPurchasesEnabled");
        if type(v97) ~= "boolean" then
            v97 = l__Environment__9.config.InstantPurchases;
        end;
        if v97 then
            local l__ProductId__16 = v96.ProductId;
            local v98;
            if type(l__ProductId__16) == "number" then
                v98 = u9[l__ProductId__16];
            else
                v98 = nil;
            end;
            local v99;
            if v98 and (type(v98.Name) == "string" and v98.Name ~= "") then
                v99 = v98.Name;
            else
                v99 = p95;
            end;
            if l__MessagePrompt__6.Prompt({
                titleOverride = "Instant Purchase",
                yield = true,
                message = `Instant purchase {v99}?`,
                options = l__MessagePrompt__6.Choices.YesNo
            }) then
                local v100, v101 = l__Networking__7.DevProducts.InstantGrant:Fire(p95);
                if v100 then
                    u5:Fire(p95);
                    return true, "Instant granted";
                else
                    u6:Fire(p95, v101 or "Instant grant failed");
                    return false, v101 or "Instant grant failed";
                end;
            else
                u4:Fire(p95);
                return false, "Cancelled";
            end;
        else
            local v102, v103 = p94:PromptPurchaseInternal(p95);
            if v102 and v103 == "Prompted Robux" then
                local l__ProductId__17 = v96.ProductId;
                if type(l__ProductId__17) == "number" then
                    u7[l__ProductId__17] = p95;
                end;
                return v102, v103;
            elseif v102 then
                u5:Fire(p95);
                return v102, v103;
            elseif v103 == "Cancelled" then
                u4:Fire(p95);
                return v102, v103;
            else
                u6:Fire(p95, v103);
                return v102, v103;
            end;
        end;
    else
        u6:Fire(p95, "Invalid product");
        return false, "Invalid product";
    end;
end;
function v1.PromptGamepassPurchase(_, p104) --[[ Line: 503 ]]
    -- upvalues: u3 (copy), l__DevProducts__8 (copy), u6 (copy), l__MarketplaceService__2 (copy), l__LocalPlayer__11 (copy), l__Environment__9 (copy), l__MessagePrompt__6 (copy), l__Networking__7 (copy), u5 (copy), u4 (copy), u8 (copy)
    u3:Fire(p104);
    local v105 = l__DevProducts__8.GetGamepassByKey(p104);
    if v105 then
        local l__GamepassId__18 = v105.GamepassId;
        if type(l__GamepassId__18) == "number" then
            local v106, v107 = pcall(l__MarketplaceService__2.UserOwnsGamePassAsync, l__MarketplaceService__2, l__LocalPlayer__11.UserId, l__GamepassId__18);
            if v106 and v107 then
                u6:Fire(p104, "Already owned");
                return false, "Already owned";
            else
                local v108 = l__LocalPlayer__11:GetAttribute("OwnedGamepasses");
                if type(v108) == "string" and v108 ~= "" then
                    local v109 = p104:match("^Gamepass:([^:]+)");
                    if v109 then
                        for v110 in v108:gmatch("[^,]+") do
                            if v110 == v109 then
                                u6:Fire(p104, "Already owned");
                                return false, "Already owned";
                            end;
                        end;
                    end;
                end;
                local v111 = workspace:GetAttribute("InstantPurchasesEnabled");
                if type(v111) ~= "boolean" then
                    v111 = l__Environment__9.config.InstantPurchases;
                end;
                if v111 then
                    local v112;
                    if type(v105.Name) == "string" and v105.Name ~= "" then
                        v112 = v105.Name;
                    else
                        v112 = p104;
                    end;
                    if l__MessagePrompt__6.Prompt({
                        titleOverride = "Instant Purchase",
                        yield = true,
                        message = `Instant purchase {v112}?`,
                        options = l__MessagePrompt__6.Choices.YesNo
                    }) then
                        local v113, v114 = l__Networking__7.DevProducts.InstantGrantGamepass:Fire(p104);
                        if v113 then
                            u5:Fire(p104);
                            return true, "Instant granted";
                        else
                            u6:Fire(p104, v114 or "Instant grant failed");
                            return false, v114 or "Instant grant failed";
                        end;
                    else
                        u4:Fire(p104);
                        return false, "Cancelled";
                    end;
                else
                    u8[l__GamepassId__18] = p104;
                    l__MarketplaceService__2:PromptGamePassPurchase(l__LocalPlayer__11, l__GamepassId__18);
                    return true, "Prompted Gamepass";
                end;
            end;
        else
            u6:Fire(p104, "Invalid gamepass");
            return false, "Invalid gamepass";
        end;
    else
        u6:Fire(p104, "Invalid gamepass");
        return false, "Invalid gamepass";
    end;
end;
function v1.WaitForGamepassesReady(_) --[[ Line: 567 ]]
    -- upvalues: u13 (ref)
    if u13 then
    else
        while not u13 do
            task.wait();
        end;
    end;
end;
return v1;