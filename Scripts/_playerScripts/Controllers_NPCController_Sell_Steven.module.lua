-- Decompiled with Potassium's decompiler.

local l__Steven__1 = workspace:WaitForChild("NPCS"):WaitForChild("Steven");
local l__ProximityPrompt__2 = l__Steven__1:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt");
local u1 = require("../NPCDialogueController");
local l__TopText__3 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("TopText"));
local l__SellValueData__4 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("SellValueData"));
local l__FruitValueCalc__5 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("FruitValueCalc"));
require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("MutationData"));
local l__Networking__6 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__BidOddModule__7 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("BidOddModule"));
local l__NumberUtils__8 = require(game.ReplicatedStorage.SharedModules.NumberUtils);
local l__RunService__9 = game:GetService("RunService");
local l__HarvestedFruitHandleController__10 = require(script.Parent.Parent.HarvestedFruitHandleController);
local l__RadialFXController__11 = require(script.Parent.Parent.RadialFXController);
require(game.Players.LocalPlayer.PlayerScripts.Controllers.PlantLifecycleHandler);
local l__ABTests__12 = require(game:GetService("ReplicatedStorage").UserGenerated.ABTests);
local l__Animations__13 = l__Steven__1:WaitForChild("Animations");
local l__Success__14 = l__Animations__13:WaitForChild("Success");
local l__Idle__15 = l__Animations__13:WaitForChild("Idle");
l__Animations__13:WaitForChild("Interact");
local l__Fail__16 = l__Animations__13:WaitForChild("Fail");
local l__Buy__17 = l__Animations__13:WaitForChild("Buy");
local l__PetData__18 = require(game.ReplicatedStorage.SharedData.PetData);
local l__BargainSFX__19 = game.SoundService.SFX.BargainSFX;
local l__SellSFX__20 = game.SoundService.SFX.SellSFX;
local l__Normal__21 = l__SellSFX__20.Normal;
local l__Rainbow__22 = l__SellSFX__20.Rainbow;
local l__Accept__23 = l__BargainSFX__19.Accept;
local l__Decline__24 = l__BargainSFX__19.Decline;
local l__Animator__25 = l__Steven__1:WaitForChild("Humanoid"):WaitForChild("Animator");
local u2 = l__Animator__25:LoadAnimation(l__Success__14);
local v3 = l__Animator__25:LoadAnimation(l__Idle__15);
local u4 = l__Animator__25:LoadAnimation(l__Fail__16);
local u5 = l__Animator__25:LoadAnimation(l__Buy__17);
v3:Play(0.1, 3, 1);
local l__DevProductController__26 = require(script.Parent.Parent.DevProductController);
local l__NotificationController__27 = require(script.Parent.Parent.NotificationController);
local u6 = 0;
local function u19() --[[ Line: 68 ]]
    -- upvalues: l__DevProductController__26 (copy)
    local u7 = false;
    local u8 = false;
    local v10 = l__DevProductController__26.PurchaseComplete:Connect(function(p9) --[[ Line: 72 ]]
        -- upvalues: u8 (ref), u7 (ref)
        if p9 == "Standalone:Skip Cooldown:1" then
            u8 = true;
            u7 = true;
        end;
    end);
    local v12 = l__DevProductController__26.PurchaseFailed:Connect(function(p11, _) --[[ Line: 75 ]]
        -- upvalues: u7 (ref)
        if p11 == "Standalone:Skip Cooldown:1" then
            u7 = true;
        end;
    end);
    local v14 = l__DevProductController__26.PurchaseCancelled:Connect(function(p13) --[[ Line: 78 ]]
        -- upvalues: u7 (ref)
        if p13 == "Standalone:Skip Cooldown:1" then
            u7 = true;
        end;
    end);
    local v15, v16 = l__DevProductController__26:PromptPurchase("Standalone:Skip Cooldown:1");
    local v17;
    if v15 then
        if v16 == "Prompted Robux" or u7 then
            v17 = u8;
        else
            u8 = true;
            u7 = true;
            v17 = u8;
        end;
    else
        u7 = true;
        v17 = u8;
    end;
    local v18 = os.clock();
    while not u7 and os.clock() - v18 < 60 do
        task.wait(0.1);
    end;
    v10:Disconnect();
    v12:Disconnect();
    v14:Disconnect();
    return v17;
end;
l__Networking__6.NPCS.LegendaryFx.OnClientEvent:Connect(function() --[[ Name: PlayStevenLegendaryParticles, Line 105 ]]
    -- upvalues: l__Steven__1 (copy)
    local v20 = l__Steven__1:FindFirstChild("HumanoidRootPart");
    if v20 then
        for _, v21 in v20:GetDescendants() do
            if v21:IsA("ParticleEmitter") then
                local v22 = v21:GetAttribute("EmitCount");
                if v22 and v22 > 0 then
                    v21:Emit(v22);
                end;
            end;
        end;
    end;
end);
local function u24(p23) --[[ Line: 126 ]]
    -- upvalues: l__NumberUtils__8 (copy)
    return l__NumberUtils__8.Abbreviate(p23) .. "¢";
end;
local function u44(p25, p26) --[[ Line: 130 ]]
    -- upvalues: l__TopText__3 (copy)
    -- block 27
    local v27 = l__TopText__3.ShowChoices(p25, p26);
    local u28 = nil;
    local v29 = {};
    if #v27 == 0 then
        return nil, "__DISMISSED__";
    end;
    for u30, v31 in v27 do
        local v32 = v31:FindFirstChild("Frame");
        if v32 then
            local v33 = v32:FindFirstChild("ImageButton");
            if v33 then
                table.insert(v29, v33.MouseButton1Click:Connect(function() --[[ Line: 153 ]]
                    -- upvalues: u28 (ref), u30 (copy)
                    u28 = u30;
                end));
            end;
        end;
    end;
    local v35 = l__TopText__3.ConnectChoiceKeyboard(v27, function(p34) --[[ Line: 159 ]]
        -- upvalues: u28 (ref)
        if u28 == nil then
            u28 = p34;
        end;
    end);
    -- block 21
    local v36 = false;
    while true do
        local v37, v38, v39, v40, v41;
        if not (v37 and v37.Parent) then
            if type(v38) == "function" then
                v39, v37 = v38(v40, v41);
            else
                v39, v37 = next(v38, v41);
            end;
            v41 = v39;
            -- block 11
        end;
        v36 = true;
        if not v36 then
            for _, v42 in v29 do
                v42:Disconnect();
            end;
            v35();
            return nil, "__DISMISSED__";
        end;
        task.wait(0.05);
        if u28 ~= nil then
            for _, v43 in v29 do
                v43:Disconnect();
            end;
            v35();
            l__TopText__3.RemovePlayerSideFrame(p25);
            if p25.Character then
                l__TopText__3.PlayerResponse(p25.Character, p26[u28], true);
            end;
            return u28, p26[u28];
        end;
        v38, v40, v41 = v27, nil, nil;
        if type(v38) == "function" then
            v39, v37 = v38(v40, v41);
        else
            v39, v37 = next(v38, v41);
        end;
        v41 = v39;
        -- block 11
    end;
end;
local function u92(p45, u46, u47, u48, p49, u50) --[[ Line: 187 ]]
    -- upvalues: l__TopText__3 (copy)
    -- block 54
    local v51 = os.clock() < u48;
    local u52 = nil;
    local u53 = {};
    local v54 = table.clone(u46);
    if v51 then
        local v55 = u48 - os.clock();
        local v56 = math.max(0, v55);
        v54[u47] = string.format("%s <font color=\"#888888\">[%.1fs]</font>", u46[u47], v56);
    end;
    local u57 = l__TopText__3.ShowChoices(p45, v54);
    if #u57 == 0 then
        return nil, "__DISMISSED__";
    end;
    local u58 = nil;
    if v51 then
        local u59 = u57[u47];
        if u59 then
            u59 = u59:FindFirstChild("Frame");
        end;
        if u59 then
            u59 = u59:FindFirstChild("Frame");
        end;
        if u59 then
            u59 = u59:FindFirstChild("Text_Element");
        end;
        if u59 and u59:IsA("TextLabel") then
            u58 = task.spawn(function() --[[ Line: 225 ]]
                -- upvalues: u52 (ref), u57 (copy), u48 (copy), u59 (ref), u46 (copy), u47 (copy), u50 (copy)
                while true do
                    if u52 ~= nil then
                        return;
                    end;
                    local v60, v61, v62;
                    v60, v61, v62 = u57, nil, nil;
                    while true do
                        local v63, v64 = v60(v61, v62);
                        if v63 == nil then
                            break;
                        end;
                        v62 = v63;
                        -- block 0
                        if not (v64 and v64.Parent) then
                            continue;
                        end;
                        break;
                        if not (v64 and v64.Parent) then
                            continue;
                        end;
                        break;
                    end;
                    local v65 = true;
                    if not v65 then
                        break;
                    end;
                    local v66 = u48 - os.clock();
                    if v66 <= 0 then
                        u59.Text = "[\"" .. u46[u47] .. "\"]";
                        local v67 = u50 and u57[u50];
                        if v67 then
                            v67:Destroy();
                            return;
                        end;
                        break;
                    end;
                    u59.Text = string.format("[\"%s <font color=\"#888888\">[%.1fs]</font>\"]", u46[u47], v66);
                    task.wait(0.1);
                end;
            end);
        end;
    end;
    local u68 = {};
    if p49 then
        for v69, u70 in pairs(p49) do
            local v71 = u57[v69];
            if v71 then
                local u72 = v71:FindFirstChild("Frame");
                if u72 then
                    u72 = u72:FindFirstChild("Frame");
                end;
                if u72 then
                    u72 = u72:FindFirstChild("Text_Element");
                end;
                if u72 then
                    table.insert(u68, task.spawn(function() --[[ Line: 261 ]]
                        -- upvalues: u52 (ref), u57 (copy), u72 (copy), u70 (copy), l__TopText__3 (ref)
                        -- block 13
                        local v73 = 0;
                        while true do
                            if u52 ~= nil then
                                return;
                            end;
                            local v74, v75, v76;
                            v74, v75, v76 = u57, nil, nil;
                            while true do
                                local v77, v78 = v74(v75, v76);
                                if v77 == nil then
                                    break;
                                end;
                                v76 = v77;
                                if not (v78 and v78.Parent) then
                                    continue;
                                end;
                                break;
                            end;
                            local v79 = true;
                            if not v79 then
                                break;
                            end;
                            v73 = v73 + task.wait(0.04);
                            if not (u72 and u72.Parent) then
                                break;
                            end;
                            u72.Text = "[\"" .. u70.before .. l__TopText__3.BuildRainbowText(u70.colored, v73) .. u70.after .. "\"]";
                        end;
                    end));
                end;
            end;
        end;
    end;
    for u80, v81 in ipairs(u57) do
        local v82 = v81:FindFirstChild("Frame");
        if v82 then
            local v83 = v82:FindFirstChild("ImageButton");
            if v83 then
                table.insert(u53, v83.MouseButton1Click:Connect(function() --[[ Line: 279 ]]
                    -- upvalues: u52 (ref), u80 (copy)
                    u52 = u80;
                end));
            end;
        end;
    end;
    local u85 = l__TopText__3.ConnectChoiceKeyboard(u57, function(p84) --[[ Line: 288 ]]
        -- upvalues: u52 (ref)
        if u52 == nil then
            u52 = p84;
        end;
    end);
    local function v88() --[[ Line: 294 ]]
        -- upvalues: u58 (ref), u53 (copy), u68 (copy), u85 (copy)
        if u58 then
            task.cancel(u58);
        end;
        for _, v86 in u53 do
            v86:Disconnect();
        end;
        for _, v87 in u68 do
            task.cancel(v87);
        end;
        u85();
    end;
    while true do
        if u52 ~= nil then
            v88();
            l__TopText__3.RemovePlayerSideFrame(p45);
            if v51 and (u52 == u47 and os.clock() < u48) then
                return u47, "__COOLDOWN__";
            end;
            if u50 and u52 == u50 then
                return u52, u46[u52];
            end;
            local v89 = u46[u52];
            if p45.Character then
                l__TopText__3.PlayerResponse(p45.Character, v89, true);
            end;
            return u52, v89;
        end;
        local v90;
        for _, v91 in u57 do
            if v91 and v91.Parent then
                v90 = true;
                if not v90 then
                    v88();
                    return nil, "__DISMISSED__";
                end;
                task.wait(0.05);
            end;
        end;
        v90 = false;
        if not v90 then
            v88();
            return nil, "__DISMISSED__";
        end;
        task.wait(0.05);
        v90 = true;
        if not v90 then
            v88();
            return nil, "__DISMISSED__";
        end;
        task.wait(0.05);
    end;
end;
local function u100(p93) --[[ Line: 336 ]]
    -- upvalues: l__SellValueData__4 (copy), l__FruitValueCalc__5 (copy)
    local l__Character__28 = p93.Character;
    if l__Character__28 then
        l__Character__28 = l__Character__28:FindFirstChildOfClass("Tool");
    end;
    if l__Character__28 then
        if l__Character__28:GetAttribute("PottedPlant") == true then
            local v94 = { "I don\'t buy potted plants, just the fruits!", "I only want harvested fruits, not the whole plant." };
            return nil, v94[math.random(#v94)];
        else
            local v95 = l__Character__28:GetAttribute("FruitName");
            if v95 then
                local v96 = l__Character__28:GetAttribute("Id");
                if not v96 then
                    return nil, "I can\'t tell what that is..";
                end;
                if not l__SellValueData__4[v95] then
                    return nil, "I\'ve never seen that before";
                end;
                local v97 = l__Character__28:GetAttribute("DecayAlpha");
                return {
                    Tool = l__Character__28,
                    FruitName = v95,
                    FruitId = v96,
                    BaseValue = l__FruitValueCalc__5(v95, l__Character__28:GetAttribute("SizeMultiplier"), l__Character__28:GetAttribute("Mutation"), p93, v97),
                    DecayAlpha = v97
                };
            elseif l__Character__28:GetAttribute("Pet") then
                return "Pet", {
                    PetID = l__Character__28:GetAttribute("PetId"),
                    Tool = l__Character__28,
                    PetName = l__Character__28:GetAttribute("Pet")
                };
            elseif l__Character__28.Name == "Shovel" then
                local v98 = { "I don\'t want your shovel.", "Bring me a fruit, not a shovel..", "I only want plants!" };
                return nil, v98[math.random(#v98)];
            else
                local v99 = { "That isn\'t a plant..", "What am I meant to do with that?", "Plants only, please.." };
                return nil, v99[math.random(#v99)];
            end;
        end;
    else
        return nil, "You aren\'t holding anything!";
    end;
end;
local function u127(p101, p102, _) --[[ Line: 433 ]]
    -- upvalues: l__Networking__6 (copy), l__TopText__3 (copy), l__Steven__1 (copy), u6 (ref), l__BidOddModule__7 (copy), u2 (copy), l__Accept__23 (copy), l__RadialFXController__11 (copy), l__NumberUtils__8 (copy), l__Decline__24 (copy), u4 (copy), u92 (copy), l__NotificationController__27 (copy), u19 (copy), l__HarvestedFruitHandleController__10 (copy), u5 (copy), l__Rainbow__22 (copy), u24 (copy), l__Normal__21 (copy)
    local v103 = l__Networking__6.NPCS.CheckDailyDeal:Fire();
    if v103 then
        v103 = v103.Available;
    end;
    local v104 = p102.TotalValue * 5;
    l__TopText__3.NpcText(l__Steven__1, "Let me reconsider everything...", true);
    task.wait(0.5);
    local v105 = l__Networking__6.NPCS.AskBidAll:Fire();
    if not (v105 and v105.Success) then
        if v105 and v105.Reason == "Cooldown" then
            l__TopText__3.NpcText(l__Steven__1, string.format("Slow down! Ask me again in %d seconds.", v105.Remaining), true);
            u6 = os.clock() + v105.Remaining;
        elseif v105 and v105.Reason == "NoMoney" then
            l__TopText__3.NpcText(l__Steven__1, "You can\'t afford my appraisal fee for all of this!", true);
        else
            l__TopText__3.NpcText(l__Steven__1, "I can\'t do that right now.", true);
        end;
        task.wait(1);
        return;
    end;
    local l__NewTotalOffer__29 = v105.NewTotalOffer;
    u6 = os.clock() + l__BidOddModule__7.BID_COOLDOWN;
    local v106;
    if (v105.IncreasedCount or 0) > 0 then
        u2:Play(0.2, 10, 1);
        if v105.HadLegendary then
            local v107 = {
                { "LEGENDARY " .. string.upper(p101.DisplayName) .. "! I offer you... ", "!" }
            };
            l__Accept__23.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__Accept__23.TimePosition = 0;
            l__Accept__23.Playing = true;
            l__RadialFXController__11:PlayFX("Rainbow");
            local v108 = v107[math.random(#v107)];
            l__TopText__3.RainbowNpcText(l__Steven__1, v108[1], l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢", v108[2], true);
            task.wait(1);
            v106 = true;
        else
            l__Accept__23.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__Accept__23.TimePosition = 0;
            l__Accept__23.Playing = true;
            l__RadialFXController__11:PlayFX("Green");
            l__TopText__3.NpcText(l__Steven__1, string.format("I can do <font color=\'#00FF00\'>%s</font> now. %d higher, %d unchanged.", l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢", v105.IncreasedCount or 0, v105.SameCount or 0), true);
            task.wait(1);
            v106 = false;
        end;
    else
        l__RadialFXController__11:PlayFX("Red");
        local v109 = v105.RefusedAll and "No deal. I\'m not raising any of these right now." or "Still <font color=\'#FFFF00\'>%s</font>. Nothing went higher this time.";
        l__TopText__3.NpcText(l__Steven__1, v105.RefusedAll and v109 and v109 or string.format(v109, l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢"), true);
        l__Decline__24.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l__Decline__24.Playing = true;
        u4:Play(0.2, 10, 1);
        task.wait(1);
        v106 = false;
    end;
    while true do
        local v110 = math.floor(l__NewTotalOffer__29 * (l__BidOddModule__7.CostMultiplier - 1));
        local v111 = string.format("Ask for more <font color=\"#FF4444\">[COST: %s]</font>", l__NumberUtils__8.Abbreviate(v110) .. "¢");
        local v112 = { v106 and string.format("Deal [SELL: %s]", l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢") or string.format("Deal <font color=\"#FFFF00\">[SELL: %s]</font>", l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢"), v111 };
        local v113 = os.clock() < u6 and #v112 or nil;
        local v114;
        if v103 then
            local l__format__30 = string.format;
            local v115 = l__NumberUtils__8.Abbreviate(v104) .. "¢";
            table.insert(v112, l__format__30("Daily Deal [SELL: %s]", v115));
            v114 = #v112;
        else
            v114 = nil;
        end;
        table.insert(v112, "Nevermind");
        local v116 = {};
        if v106 then
            v116[1] = {
                before = "Deal ",
                after = "",
                colored = "[SELL: " .. (l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢") .. "]"
            };
        end;
        if v103 and v114 then
            v116[v114] = {
                before = "Daily Deal ",
                after = "",
                colored = "[SELL: " .. (l__NumberUtils__8.Abbreviate(v104) .. "¢") .. "]"
            };
        end;
        if next(v116) == nil then
            v116 = nil;
        end;
        local v117, v118 = u92(p101, v112, 2, u6, v116, v113);
        if v118 == "__COOLDOWN__" then
            local v119 = u6 - os.clock();
            local v120 = math.max(0, v119);
            l__NotificationController__27:CreateNotification(`Please wait {math.ceil(v120)}s`, false, 2);
        elseif v113 and v117 == v113 then
            if u19() then
                u6 = 0;
            end;
            task.wait(0.3);
        else
            if v118 == "__DISMISSED__" then
                task.wait(0.2);
                return;
            end;
            if v117 ~= 2 then
                if v117 == 1 then
                    if v106 and p101.Character then
                        l__TopText__3.RainbowPlayerResponse(p101.Character, "Deal ", "[SELL: " .. (l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢") .. "]", "", true);
                    end;
                    task.wait(0.5);
                    if p102.FruitCount > 100 then
                        l__TopText__3.NpcText(l__Steven__1, "Calculating...", true);
                        task.wait(1);
                    end;
                    task.wait(0.25);
                    l__TopText__3.NpcText(l__Steven__1, "Let me get your payment...", true);
                    task.wait(0.5);
                    local v121 = l__Networking__6.NPCS.SellAll:Fire();
                    if v121 and v121.Success then
                        l__HarvestedFruitHandleController__10:DisconnectAllFruitTools();
                        u5:Play(0.2, 10, 1);
                        if v106 then
                            l__Rainbow__22.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                            l__Rainbow__22.TimePosition = 0;
                            l__Rainbow__22.Playing = true;
                            l__Networking__6.NPCS.LegendaryFx:Fire();
                            l__TopText__3.NpcCountUp(l__Steven__1, {
                                TextBefore = "Here\'s ",
                                Rainbow = true,
                                ShouldDisappear = false,
                                TextAfter = string.format(" for %d items!", v121.SoldCount),
                                FinalAmount = v121.SellPrice,
                                Format = u24
                            });
                        else
                            l__Normal__21.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                            l__Normal__21.TimePosition = 0;
                            l__Normal__21.Playing = true;
                            l__TopText__3.NpcCountUp(l__Steven__1, {
                                TextBefore = "Here\'s ",
                                Color = "#00FF00",
                                ShouldDisappear = false,
                                TextAfter = string.format(" for %d items!", v121.SoldCount),
                                FinalAmount = v121.SellPrice,
                                Format = u24
                            });
                        end;
                        task.wait(1);
                        return;
                    else
                        l__TopText__3.NpcText(l__Steven__1, "Something went wrong.. try again.", true);
                        task.wait(1);
                        return;
                    end;
                elseif v103 and v117 == v114 then
                    task.wait(0.5);
                    if p102.FruitCount > 100 then
                        l__TopText__3.NpcText(l__Steven__1, "Calculating...", true);
                        task.wait(1);
                    end;
                    task.wait(0.25);
                    l__TopText__3.NpcText(l__Steven__1, "Daily deal it is! Let me get your payment...", true);
                    task.wait(0.5);
                    local v122 = l__Networking__6.NPCS.UseDailyDealAll:Fire();
                    if v122 and v122.Success then
                        l__HarvestedFruitHandleController__10:DisconnectAllFruitTools();
                        u5:Play(0.2, 10, 1);
                        l__Rainbow__22.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__Rainbow__22.TimePosition = 0;
                        l__Rainbow__22.Playing = true;
                        l__TopText__3.NpcCountUp(l__Steven__1, {
                            TextBefore = "DAILY DEAL! Here\'s ",
                            Rainbow = true,
                            ShouldDisappear = false,
                            TextAfter = string.format(" for %d items!", v122.SoldCount),
                            FinalAmount = v122.SellPrice,
                            Format = u24
                        });
                        task.wait(1);
                        return;
                    else
                        if v122 and v122.Reason == "NotAvailable" then
                            l__TopText__3.NpcText(l__Steven__1, "That deal expired.. sorry!", true);
                        else
                            l__TopText__3.NpcText(l__Steven__1, "Something went wrong.. try again.", true);
                        end;
                        task.wait(1);
                        return;
                    end;
                else
                    task.wait(0.5);
                    return;
                end;
            end;
            task.wait(0.5);
            l__TopText__3.NpcText(l__Steven__1, "Let me reconsider everything...", true);
            task.wait(0.5);
            local v123 = l__Networking__6.NPCS.AskBidAll:Fire();
            if v123 and v123.Success then
                l__NewTotalOffer__29 = v123.NewTotalOffer;
                u6 = os.clock() + l__BidOddModule__7.BID_COOLDOWN;
                if (v123.IncreasedCount or 0) > 0 then
                    u2:Play(0.2, 10, 1);
                    if v123.HadLegendary then
                        local v124 = {
                            { "LEGENDARY " .. string.upper(p101.DisplayName) .. "! I offer you... ", "!" }
                        };
                        l__Accept__23.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__Accept__23.TimePosition = 0;
                        l__Accept__23.Playing = true;
                        l__RadialFXController__11:PlayFX("Rainbow");
                        local v125 = v124[math.random(#v124)];
                        l__TopText__3.RainbowNpcText(l__Steven__1, v125[1], l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢", v125[2], true);
                        task.wait(1);
                        v106 = true;
                    else
                        l__Accept__23.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__Accept__23.TimePosition = 0;
                        l__Accept__23.Playing = true;
                        l__RadialFXController__11:PlayFX("Green");
                        l__TopText__3.NpcText(l__Steven__1, string.format("I can do <font color=\'#00FF00\'>%s</font> now. %d higher, %d unchanged.", l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢", v123.IncreasedCount or 0, v123.SameCount or 0), true);
                        task.wait(1);
                        v106 = false;
                    end;
                else
                    l__RadialFXController__11:PlayFX("Red");
                    local v126 = v123.RefusedAll and "No deal. I\'m not raising any of these right now." or "Still <font color=\'#FFFF00\'>%s</font>. Nothing went higher this time.";
                    l__TopText__3.NpcText(l__Steven__1, v123.RefusedAll and v126 and v126 or string.format(v126, l__NumberUtils__8.Abbreviate(l__NewTotalOffer__29) .. "¢"), true);
                    l__Decline__24.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    l__Decline__24.Playing = true;
                    u4:Play(0.2, 10, 1);
                    task.wait(1);
                    v106 = false;
                end;
            else
                if v123 and v123.Reason == "Cooldown" then
                    l__TopText__3.NpcText(l__Steven__1, string.format("Slow down! Ask me again in %d seconds.", v123.Remaining), true);
                    u6 = os.clock() + v123.Remaining;
                elseif v123 and v123.Reason == "NoMoney" then
                    l__TopText__3.NpcText(l__Steven__1, "You can\'t afford my appraisal fee for all of this!", true);
                else
                    l__TopText__3.NpcText(l__Steven__1, "I can\'t do that right now.", true);
                end;
                task.wait(1);
            end;
        end;
    end;
end;
local function u166(p128, p129, _) --[[ Line: 752 ]]
    -- upvalues: l__Networking__6 (copy), l__TopText__3 (copy), l__Steven__1 (copy), u6 (ref), l__BidOddModule__7 (copy), u2 (copy), l__Accept__23 (copy), l__NumberUtils__8 (copy), l__RadialFXController__11 (copy), l__Decline__24 (copy), u4 (copy), u92 (copy), l__NotificationController__27 (copy), u19 (copy), u100 (copy), l__Rainbow__22 (copy), u5 (copy), u24 (copy), l__Normal__21 (copy)
    local v130 = l__Networking__6.NPCS.CheckDailyDeal:Fire();
    if v130 then
        v130 = v130.Available;
    end;
    local v131 = p129.BaseValue * 5;
    l__TopText__3.NpcText(l__Steven__1, "Let me reconsider...", true);
    task.wait(0.5);
    local v132 = l__Networking__6.NPCS.AskBid:Fire(p129.FruitId);
    if not (v132 and v132.Success) then
        if v132 and v132.Reason == "Cooldown" then
            l__TopText__3.NpcText(l__Steven__1, string.format("Slow down! Ask me again in %d seconds.", v132.Remaining), true);
            u6 = os.clock() + v132.Remaining;
        elseif v132 and v132.Reason == "NoMoney" then
            l__TopText__3.NpcText(l__Steven__1, "You can\'t afford my appraisal fee!", true);
        elseif v132 and v132.Reason == "Favorited" then
            l__TopText__3.NpcText(l__Steven__1, "You cannot bargain favorited fruit!", true);
        else
            l__TopText__3.NpcText(l__Steven__1, "I can\'t do that right now.", true);
        end;
        task.wait(1);
        return;
    end;
    local l__NewOffer__31 = v132.NewOffer;
    u6 = os.clock() + l__BidOddModule__7.BID_COOLDOWN;
    local v133;
    if v132.Won then
        u2:Play(0.2, 10, 1);
        if v132.Multiplier == 20 then
            local v134 = {
                { "LEGENDARY " .. string.upper(p128.DisplayName) .. "! I offer you... ", "!" }
            };
            l__Accept__23.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__Accept__23.TimePosition = 0;
            l__Accept__23.Playing = true;
            local v135 = v134[math.random(#v134)];
            l__TopText__3.RainbowNpcText(l__Steven__1, v135[1], l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢", v135[2], true);
            l__RadialFXController__11:PlayFX("Rainbow");
            task.wait(1);
            v133 = true;
        else
            local v136 = { "Actually, I can do <font color=\'#00FF00\'>%s</font>!", "On second thought.. <font color=\'#00FF00\'>%s</font>!", "You drive a hard bargain. <font color=\'#00FF00\'>%s</font>." };
            l__Accept__23.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__Accept__23.TimePosition = 0;
            l__Accept__23.Playing = true;
            l__TopText__3.NpcText(l__Steven__1, v136[math.random(#v136)]:format(l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢"), true);
            l__RadialFXController__11:PlayFX("Green");
            task.wait(1);
            v133 = false;
        end;
    else
        local v137 = { "Sorry, <font color=\'#FFFF00\'>%s</font> is the best I can do.", "I thought about it.. <font color=\'#FFFF00\'>%s</font>. Can\'t go higher.", "No luck. Still <font color=\'#FFFF00\'>%s</font>." };
        l__Decline__24.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l__Decline__24.TimePosition = 0;
        l__Decline__24.Playing = true;
        u4:Play(0.2, 10, 1);
        l__TopText__3.NpcText(l__Steven__1, v137[math.random(#v137)]:format(l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢"), true);
        l__RadialFXController__11:PlayFX("Red");
        task.wait(1);
        v133 = false;
    end;
    while true do
        local v138 = math.floor(l__NewOffer__31 * (l__BidOddModule__7.CostMultiplier - 1));
        local v139 = string.format("Ask for more <font color=\"#FF4444\">[COST: %s]</font>", l__NumberUtils__8.Abbreviate(v138) .. "¢");
        local v140 = { v133 and string.format("Deal [SELL: %s]", l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢") or string.format("Deal <font color=\"#FFFF00\">[SELL: %s]</font>", l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢"), v139 };
        local v141 = nil;
        local v142;
        if os.clock() < u6 then
            table.insert(v140, "<font color=\"#00FF00\">Skip Cooldown 3R$</font>");
            v142 = #v140;
        else
            v142 = nil;
        end;
        if v130 then
            local l__format__32 = string.format;
            local v143 = l__NumberUtils__8.Abbreviate(v131) .. "¢";
            table.insert(v140, l__format__32("Daily Deal [SELL: %s]", v143));
            v141 = #v140;
        end;
        table.insert(v140, "Nevermind");
        local v144 = {};
        if v133 then
            v144[1] = {
                before = "Deal ",
                after = "",
                colored = "[SELL: " .. (l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢") .. "]"
            };
        end;
        if v130 and v141 then
            v144[v141] = {
                before = "Daily Deal ",
                after = "",
                colored = "[SELL: " .. (l__NumberUtils__8.Abbreviate(v131) .. "¢") .. "]"
            };
        end;
        if next(v144) == nil then
            v144 = nil;
        end;
        local v145, v146 = u92(p128, v140, 2, u6, v144, v142);
        if v146 == "__COOLDOWN__" then
            local v147 = u6 - os.clock();
            local v148 = math.max(0, v147);
            l__NotificationController__27:CreateNotification(`Please wait {math.ceil(v148)}s`, false, 2);
        elseif v142 and v145 == v142 then
            if u19() then
                u6 = 0;
            end;
            task.wait(0.3);
        else
            if v146 == "__DISMISSED__" then
                task.wait(0.2);
                return;
            end;
            if v145 ~= 2 then
                if v145 == 1 then
                    if v133 and p128.Character then
                        l__TopText__3.RainbowPlayerResponse(p128.Character, "Deal ", "[SELL: " .. (l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢") .. "]", "", true);
                    end;
                    task.wait(0.5);
                    local v149, v150 = u100(p128);
                    if v149 then
                        local l__Tool__33 = v149.Tool;
                        task.wait(0.25);
                        l__TopText__3.NpcText(l__Steven__1, "Let me get your payment...", true);
                        task.wait(0.5);
                        local v151 = l__Networking__6.NPCS.SellFruit:Fire(v149.FruitId);
                        if v151 and v151.Success then
                            if v133 then
                                l__Networking__6.NPCS.LegendaryFx:Fire();
                                l__Rainbow__22.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                                l__Rainbow__22.TimePosition = 0;
                                l__Rainbow__22.Playing = true;
                                local v152 = {
                                    { "Pleasure doing business! Here\'s ", "." },
                                    { "Sold! ", ", all yours." },
                                    { "Done deal. ", " coming your way!" }
                                };
                                local v153 = v152[math.random(#v152)];
                                u5:Play(0.2, 10, 1);
                                l__TopText__3.NpcCountUp(l__Steven__1, {
                                    Rainbow = true,
                                    ShouldDisappear = true,
                                    TextBefore = v153[1],
                                    TextAfter = v153[2],
                                    FinalAmount = v151.SellPrice,
                                    Format = u24
                                });
                            else
                                l__Normal__21.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                                l__Normal__21.TimePosition = 0;
                                l__Normal__21.Playing = true;
                                local v154 = {
                                    { "Pleasure doing business! Here\'s ", "." },
                                    { "Sold! ", ", all yours." },
                                    { "Done deal. ", " coming your way!" }
                                };
                                local v155 = v154[math.random(#v154)];
                                u5:Play(0.2, 10, 1);
                                l__TopText__3.NpcCountUp(l__Steven__1, {
                                    Color = "#00FF00",
                                    ShouldDisappear = true,
                                    TextBefore = v155[1],
                                    TextAfter = v155[2],
                                    FinalAmount = v151.SellPrice,
                                    Format = u24
                                });
                            end;
                            if l__Tool__33 and l__Tool__33.Parent then
                                l__Tool__33:Destroy();
                            end;
                        elseif v151 and v151.Reason == "Favorited" then
                            l__TopText__3.NpcText(l__Steven__1, "You cannot sell favorited fruit!", true);
                        else
                            l__TopText__3.NpcText(l__Steven__1, "Something went wrong.. try again.", true);
                        end;
                        task.wait(1);
                        return;
                    else
                        l__TopText__3.NpcText(l__Steven__1, v150, true);
                        task.wait(1);
                        return;
                    end;
                elseif v130 and v145 == v141 then
                    task.wait(0.5);
                    local v156, v157 = u100(p128);
                    if v156 then
                        local l__Tool__34 = v156.Tool;
                        task.wait(0.25);
                        l__TopText__3.NpcText(l__Steven__1, "Daily deal! Let me get your payment...", true);
                        task.wait(0.5);
                        local v158 = l__Networking__6.NPCS.UseDailyDealSingle:Fire(v156.FruitId);
                        if v158 and v158.Success then
                            u5:Play(0.2, 10, 1);
                            l__Rainbow__22.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                            l__Rainbow__22.TimePosition = 0;
                            l__Rainbow__22.Playing = true;
                            l__TopText__3.NpcCountUp(l__Steven__1, {
                                TextBefore = "DAILY DEAL! Here\'s ",
                                TextAfter = "!",
                                Rainbow = true,
                                ShouldDisappear = false,
                                FinalAmount = v158.SellPrice,
                                Format = u24
                            });
                            if l__Tool__34 and l__Tool__34.Parent then
                                l__Tool__34:Destroy();
                            end;
                        elseif v158 and v158.Reason == "NotAvailable" then
                            l__TopText__3.NpcText(l__Steven__1, "That deal expired.. sorry!", true);
                        elseif v158 and v158.Reason == "Favorited" then
                            l__TopText__3.NpcText(l__Steven__1, "You cannot sell favorited fruit!", true);
                        else
                            l__TopText__3.NpcText(l__Steven__1, "Something went wrong.. try again.", true);
                        end;
                        task.wait(1);
                        return;
                    else
                        l__TopText__3.NpcText(l__Steven__1, v157, true);
                        task.wait(1);
                        return;
                    end;
                else
                    task.wait(0.5);
                    return;
                end;
            end;
            task.wait(0.5);
            l__TopText__3.NpcText(l__Steven__1, "Let me reconsider...", true);
            task.wait(0.5);
            local v159, v160 = u100(p128);
            if not v159 then
                l__TopText__3.NpcText(l__Steven__1, v160, true);
                task.wait(1);
                return;
            end;
            local v161 = l__Networking__6.NPCS.AskBid:Fire(v159.FruitId);
            if v161 and v161.Success then
                l__NewOffer__31 = v161.NewOffer;
                u6 = os.clock() + l__BidOddModule__7.BID_COOLDOWN;
                if v161.Won then
                    u2:Play(0.2, 10, 1);
                    if v161.Multiplier == 20 then
                        local v162 = {
                            { "LEGENDARY " .. string.upper(p128.DisplayName) .. "! I offer you... ", "!" }
                        };
                        l__Accept__23.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__Accept__23.TimePosition = 0;
                        l__Accept__23.Playing = true;
                        local v163 = v162[math.random(#v162)];
                        l__TopText__3.RainbowNpcText(l__Steven__1, v163[1], l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢", v163[2], true);
                        l__RadialFXController__11:PlayFX("Rainbow");
                        task.wait(1);
                        v133 = true;
                    else
                        local v164 = { "Actually, I can do <font color=\'#00FF00\'>%s</font>!", "On second thought.. <font color=\'#00FF00\'>%s</font>!", "You drive a hard bargain. <font color=\'#00FF00\'>%s</font>." };
                        l__Accept__23.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__Accept__23.TimePosition = 0;
                        l__Accept__23.Playing = true;
                        l__TopText__3.NpcText(l__Steven__1, v164[math.random(#v164)]:format(l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢"), true);
                        l__RadialFXController__11:PlayFX("Green");
                        task.wait(1);
                        v133 = false;
                    end;
                else
                    local v165 = { "Sorry, <font color=\'#FFFF00\'>%s</font> is the best I can do.", "I thought about it.. <font color=\'#FFFF00\'>%s</font>. Can\'t go higher.", "No luck. Still <font color=\'#FFFF00\'>%s</font>." };
                    l__Decline__24.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    l__Decline__24.TimePosition = 0;
                    l__Decline__24.Playing = true;
                    u4:Play(0.2, 10, 1);
                    l__TopText__3.NpcText(l__Steven__1, v165[math.random(#v165)]:format(l__NumberUtils__8.Abbreviate(l__NewOffer__31) .. "¢"), true);
                    l__RadialFXController__11:PlayFX("Red");
                    task.wait(1);
                    v133 = false;
                end;
            else
                if v161 and v161.Reason == "Cooldown" then
                    l__TopText__3.NpcText(l__Steven__1, string.format("Slow down! Ask me again in %d seconds.", v161.Remaining), true);
                    u6 = os.clock() + v161.Remaining;
                elseif v161 and v161.Reason == "NoMoney" then
                    l__TopText__3.NpcText(l__Steven__1, "You can\'t afford my appraisal fee!", true);
                elseif v161 and v161.Reason == "Favorited" then
                    l__TopText__3.NpcText(l__Steven__1, "You cannot bargain favorited fruit!", true);
                else
                    l__TopText__3.NpcText(l__Steven__1, "I can\'t do that right now.", true);
                end;
                task.wait(1);
            end;
        end;
    end;
end;
return function() --[[ Line: 1082 ]]
    -- upvalues: l__ABTests__12 (copy), l__RunService__9 (copy), u1 (copy), l__ProximityPrompt__2 (copy), l__Steven__1 (copy), l__Networking__6 (copy), l__TopText__3 (copy), l__HarvestedFruitHandleController__10 (copy), u5 (copy), l__Normal__21 (copy), u24 (copy), u100 (copy), l__BidOddModule__7 (copy), l__NumberUtils__8 (copy), u44 (copy), u127 (copy), u166 (copy), l__PetData__18 (copy)
    local l__LocalPlayer__35 = game.Players.LocalPlayer;
    local v167 = l__ABTests__12.GetAttributeAsync(l__LocalPlayer__35, "Sell.Bargain.Enabled", true);
    local v168 = type(v167) ~= "boolean" and true or v167;
    local u169 = l__RunService__9:IsStudio() and true or v168;
    local u170 = {};
    local function v173() --[[ Line: 1093 ]]
        -- upvalues: u169 (ref), l__LocalPlayer__35 (copy), u170 (copy)
        local v171 = u169;
        local v172 = l__LocalPlayer__35:GetAttribute("BargainABOverride");
        if type(v172) == "boolean" then
            v171 = v172;
        end;
        table.clear(u170);
        table.insert(u170, "Sell Inventory!");
        table.insert(u170, "Sell This!");
        table.insert(u170, "How much is this worth?");
        if v171 then
            table.insert(u170, "Bargain!");
        end;
        table.insert(u170, "Nevermind");
    end;
    local v174 = u169;
    local v175 = l__LocalPlayer__35:GetAttribute("BargainABOverride");
    if type(v175) ~= "boolean" then
        v175 = v174;
    end;
    table.clear(u170);
    table.insert(u170, "Sell Inventory!");
    table.insert(u170, "Sell This!");
    table.insert(u170, "How much is this worth?");
    if v175 then
        table.insert(u170, "Bargain!");
    end;
    table.insert(u170, "Nevermind");
    l__LocalPlayer__35:GetAttributeChangedSignal("BargainABOverride"):Connect(v173);
    u1:DoDialogue({
        ExitLine = "Goodbye!",
        ProximityPrompt = l__ProximityPrompt__2,
        SpeakingNPC = l__Steven__1,
        PromptList = u170,
        OperationMap = {
            ["Sell Inventory!"] = function() --[[ Line: 1122 ]]
                -- upvalues: l__Networking__6 (ref), l__TopText__3 (ref), l__Steven__1 (ref), l__HarvestedFruitHandleController__10 (ref), u5 (ref), l__Normal__21 (ref), u24 (ref)
                local _ = game.Players.LocalPlayer;
                local v176 = l__Networking__6.NPCS.PreviewSellAll:Fire();
                if v176 and (v176.FruitCount or 0) > 100 then
                    l__TopText__3.NpcText(l__Steven__1, "Calculating...", true);
                    task.wait(0.5);
                end;
                if v176 and (v176.FruitCount or 0) > 0 then
                    task.wait(0.25);
                    l__TopText__3.NpcText(l__Steven__1, "Let me get your payment...", true);
                    task.wait(0.5);
                    local v177 = l__Networking__6.NPCS.SellAll:Fire();
                    if v177 and v177.Success then
                        l__HarvestedFruitHandleController__10:DisconnectAllFruitTools();
                        u5:Play(0.2, 10, 1);
                        l__Normal__21.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        l__Normal__21.TimePosition = 0;
                        l__Normal__21.Playing = true;
                        l__TopText__3.NpcCountUp(l__Steven__1, {
                            TextBefore = "Here\'s ",
                            Color = "#00FF00",
                            ShouldDisappear = false,
                            TextAfter = string.format(" for %d items!", v177.SoldCount),
                            FinalAmount = v177.SellPrice,
                            Format = u24
                        });
                        task.wait(1);
                    else
                        l__TopText__3.NpcText(l__Steven__1, "Something went wrong.. try again.", true);
                        task.wait(1);
                    end;
                else
                    l__TopText__3.NpcText(l__Steven__1, "You don\'t have anything to sell!", true);
                    task.wait(1);
                end;
            end,
            ["Sell This!"] = function() --[[ Line: 1165 ]]
                -- upvalues: u100 (ref), l__TopText__3 (ref), l__Steven__1 (ref), l__Networking__6 (ref), u5 (ref), l__Normal__21 (ref), u24 (ref)
                task.wait(0.5);
                local v178, v179 = u100(game.Players.LocalPlayer);
                if v178 then
                    if v178 == "Pet" then
                        local l__Tool__36 = v179.Tool;
                        local v180 = l__Networking__6.NPCS.SellPet:Fire(v179.PetID);
                        if v180 and v180.Success then
                            u5:Play(0.2, 10, 1);
                            l__Normal__21.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                            l__Normal__21.TimePosition = 0;
                            l__Normal__21.Playing = true;
                            l__TopText__3.NpcCountUp(l__Steven__1, {
                                TextBefore = "Here\'s ",
                                TextAfter = "!",
                                Color = "#00FF00",
                                ShouldDisappear = false,
                                FinalAmount = v180.SellPrice,
                                Format = u24
                            });
                            if l__Tool__36 and l__Tool__36.Parent then
                                l__Tool__36:Destroy();
                            end;
                        else
                            l__TopText__3.NpcText(l__Steven__1, "Something went wrong.. try again.", true);
                        end;
                        task.wait(1);
                    else
                        local l__Tool__37 = v178.Tool;
                        local v181 = l__Networking__6.NPCS.SellFruit:Fire(v178.FruitId);
                        if v181 and v181.Success then
                            u5:Play(0.2, 10, 1);
                            l__Normal__21.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                            l__Normal__21.TimePosition = 0;
                            l__Normal__21.Playing = true;
                            l__TopText__3.NpcCountUp(l__Steven__1, {
                                TextBefore = "Here\'s ",
                                TextAfter = "!",
                                Color = "#00FF00",
                                ShouldDisappear = false,
                                FinalAmount = v181.SellPrice,
                                Format = u24
                            });
                            if l__Tool__37 and l__Tool__37.Parent then
                                l__Tool__37:Destroy();
                            end;
                        elseif v181 and v181.Reason == "Favorited" then
                            l__TopText__3.NpcText(l__Steven__1, "You cannot sell favorited fruit!", true);
                        else
                            l__TopText__3.NpcText(l__Steven__1, "Something went wrong.. try again.", true);
                        end;
                        task.wait(1);
                    end;
                else
                    l__TopText__3.NpcText(l__Steven__1, v179, true);
                    task.wait(1);
                end;
            end,
            ["Bargain!"] = function() --[[ Line: 1229 ]]
                -- upvalues: l__Networking__6 (ref), l__BidOddModule__7 (ref), u100 (ref), l__TopText__3 (ref), l__Steven__1 (ref), l__NumberUtils__8 (ref), u44 (ref), u127 (ref), u166 (ref)
                task.wait(0.5);
                local l__LocalPlayer__38 = game.Players.LocalPlayer;
                local v182 = l__Networking__6.NPCS.PreviewSellAll:Fire();
                local v183;
                if v182 then
                    v183 = (v182.FruitCount or 0) > 0;
                else
                    v183 = v182;
                end;
                local v184 = v183 and (v182.TotalValue or 0) or 0;
                local v185 = math.floor(v184 * (l__BidOddModule__7.CostMultiplier - 1));
                local v186 = u100(l__LocalPlayer__38);
                local v187 = v186 ~= nil;
                local v188;
                if v187 then
                    local v189 = l__Networking__6.NPCS.GetFruitBid:Fire(v186.FruitId);
                    v188 = v186.BaseValue;
                    if v189 and v189.BidPrice > 0 then
                        v188 = v189.CurrentOffer;
                    end;
                else
                    v188 = 0;
                end;
                local v190 = math.floor(v188 * (l__BidOddModule__7.CostMultiplier - 1));
                if v183 or v187 then
                    l__TopText__3.NpcText(l__Steven__1, "What would you like to bargain over?", true);
                    task.wait(0.1);
                    local v191 = {};
                    local v192 = nil;
                    local v193;
                    if v183 then
                        local l__format__39 = string.format;
                        local v194 = l__NumberUtils__8.Abbreviate(v185) .. "¢";
                        table.insert(v191, l__format__39("Bargain Inventory <font color=\"#FF4444\">[COST: %s]</font>", v194));
                        v193 = #v191;
                    else
                        v193 = nil;
                    end;
                    if v187 then
                        local l__format__40 = string.format;
                        local v195 = l__NumberUtils__8.Abbreviate(v190) .. "¢";
                        table.insert(v191, l__format__40("Bargain This <font color=\"#FF4444\">[COST: %s]</font>", v195));
                        v192 = #v191;
                    end;
                    table.insert(v191, "Nevermind");
                    local _ = #v191;
                    local v196, v197 = u44(l__LocalPlayer__38, v191);
                    if v197 == "__DISMISSED__" then
                        task.wait(0.2);
                    elseif v193 and v196 == v193 then
                        u127(l__LocalPlayer__38, v182, v184);
                    elseif v192 and v196 == v192 then
                        u166(l__LocalPlayer__38, v186, v188);
                    else
                        task.wait(0.5);
                    end;
                else
                    l__TopText__3.NpcText(l__Steven__1, "You don\'t have anything to bargain with!", true);
                    task.wait(1);
                end;
            end,
            ["How much is this worth?"] = function() --[[ Line: 1301 ]]
                -- upvalues: l__TopText__3 (ref), l__Steven__1 (ref), u100 (ref), l__PetData__18 (ref), l__NumberUtils__8 (ref), l__Networking__6 (ref)
                task.wait(0.5);
                l__TopText__3.NpcText(l__Steven__1, "Let me take a look...", true);
                task.wait(1);
                local v198, v199 = u100(game.Players.LocalPlayer);
                if v198 then
                    if v198 == "Pet" then
                        local v200 = l__PetData__18[v199.PetName].BasePrice * 0.5;
                        local v201 = {
                            "I\'ll give you <font color=\'#FFFF00\'>%s</font> for that",
                            "I\'d value it at <font color=\'#FFFF00\'>%s</font>",
                            "Best I can do is <font color=\'#FFFF00\'>%s</font>",
                            "I could do <font color=\'#FFFF00\'>%s</font>",
                            "That is worth about <font color=\'#FFFF00\'>%s</font>",
                            "You\'re looking at about <font color=\'#FFFF00\'>%s</font> for that",
                            "I\'d pay no more than <font color=\'#FFFF00\'>%s</font>",
                            "Very cute, I\'d give you <font color=\'#FFFF00\'>%s</font>"
                        };
                        l__TopText__3.NpcText(l__Steven__1, v201[math.random(#v201)]:format(l__NumberUtils__8.Abbreviate(v200) .. "¢"), true);
                        task.wait(1);
                    else
                        local v202 = l__Networking__6.NPCS.GetFruitBid:Fire(v198.FruitId);
                        local l__BaseValue__41 = v198.BaseValue;
                        if v202 and v202.BidPrice > 0 then
                            l__BaseValue__41 = v202.CurrentOffer;
                        end;
                        local v203 = {
                            "I\'ll give you <font color=\'#FFFF00\'>%s</font> for that",
                            "I\'d value it at <font color=\'#FFFF00\'>%s</font>",
                            "Best I can do is <font color=\'#FFFF00\'>%s</font>",
                            "I could do <font color=\'#FFFF00\'>%s</font>",
                            "That is worth about <font color=\'#FFFF00\'>%s</font>",
                            "You\'re looking at about <font color=\'#FFFF00\'>%s</font> for that",
                            "I\'d pay no more than <font color=\'#FFFF00\'>%s</font>"
                        };
                        l__TopText__3.NpcText(l__Steven__1, v203[math.random(#v203)]:format(l__NumberUtils__8.Abbreviate(l__BaseValue__41) .. "¢"), true);
                        task.wait(1);
                    end;
                else
                    l__TopText__3.NpcText(l__Steven__1, v199, true);
                    task.wait(1);
                end;
            end,
            Nevermind = function() --[[ Line: 1356 ]]
                task.wait(0.5);
            end
        },
        IntroLines = { "Got anything to sell?" }
    });
end;