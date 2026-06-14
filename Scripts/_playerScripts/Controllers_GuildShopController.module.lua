-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__GuildShop__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GuildShop");
local l__Content__2 = l__GuildShop__1:WaitForChild("MainFrame"):WaitForChild("Content");
local l__CurrentFrame__3 = l__Content__2:WaitForChild("CurrentFrame");
local l__PayoutFrame__4 = l__Content__2:WaitForChild("PayoutFrame");
local l__Prizes__5 = l__PayoutFrame__4:WaitForChild("Prizes");
local l__TemplateFrame__6 = l__Prizes__5:WaitForChild("TemplateFrame");
local l__Prizes__7 = l__CurrentFrame__3:WaitForChild("Prizes");
local l__TemplateFrame__8 = l__Prizes__7:WaitForChild("TemplateFrame");
local l__ReplicatedStorage__9 = game.ReplicatedStorage;
local l__SeedPackData__10 = require(l__ReplicatedStorage__9.SharedModules.SeedPackData);
local l__GearShopData__11 = require(l__ReplicatedStorage__9.SharedModules.GearShopData);
local l__EggData__12 = require(l__ReplicatedStorage__9.SharedModules.EggData);
local l__SeedData__13 = require(l__ReplicatedStorage__9.SharedModules.SeedData);
local l__Gradients__14 = l__ReplicatedStorage__9.SharedModules.RarityData.Gradients;
local l__RefreshIn__15 = l__PayoutFrame__4:WaitForChild("RefreshIn");
local l__RefreshIn__16 = l__CurrentFrame__3:WaitForChild("RefreshIn");
local function u6(p2) --[[ Line: 41 ]]
    local v3 = tonumber(p2);
    if not v3 then
        return tostring(p2);
    end;
    local v4 = {
        "",
        "K",
        "M",
        "B",
        "T"
    };
    local v5 = 1;
    while math.abs(v3) >= 1000 and v5 < #v4 do
        v3 = v3 / 1000;
        v5 = v5 + 1;
    end;
    return string.format("%.3f", v3):gsub("%.?0+$", "") .. v4[v5];
end;
local u7 = 0;
local u8 = false;
function ToggleUpdate(u9)
    -- upvalues: u7 (ref), u8 (ref), u1 (copy)
    task.spawn(function() --[[ Line: 64 ]]
        -- upvalues: u7 (ref), u9 (copy), u8 (ref), u1 (ref)
        u7 = u7 + 1;
        if u9 == true and u8 == false then
            u8 = true;
            local v10 = u7;
            while v10 == u7 do
                u1:SetProjectedTimer();
                u1:SetThisWeekTimer();
                task.wait(0.5);
            end;
        end;
        u8 = u9;
    end);
end;
function u1.Init(_) --[[ Line: 82 ]]
    -- upvalues: u1 (copy), l__GuildShop__1 (copy)
    u1:SetProjectedPayoutFrame({
        {
            Name = "Jump Mushroom",
            Cost = 20
        },
        {
            Name = "Uncommon Seed Pack",
            Cost = 80
        },
        {
            Name = "Legendary Sprinkler",
            Cost = 500
        },
        {
            Name = "Epic Egg",
            Cost = 2000
        },
        {
            Name = "Super Seed Pack",
            Cost = 4000
        }
    }, 2, 1200);
    u1:SetLastWeekFrame({
        {
            Name = "Jump Mushroom",
            Cost = 20
        },
        {
            Name = "Uncommon Seed Pack",
            Cost = 80
        },
        {
            Name = "Legendary Sprinkler",
            Cost = 500
        },
        {
            Name = "Epic Egg",
            Cost = 2000
        },
        {
            Name = "Super Seed Pack",
            Cost = 4000
        }
    }, 1, 1200);
    if l__GuildShop__1.Enabled == true then
        ToggleUpdate(true);
    end;
    l__GuildShop__1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 138 ]]
        -- upvalues: l__GuildShop__1 (ref)
        if l__GuildShop__1.Enabled == true then
            ToggleUpdate(true);
        else
            ToggleUpdate(false);
        end;
    end);
end;
local function u16(p11) --[[ Line: 154 ]]
    local v12 = math.floor(p11 / 86400);
    local v13 = math.floor(p11 % 86400 / 3600);
    local v14 = math.floor(p11 % 3600 / 60);
    local v15 = p11 % 60;
    if v12 > 0 then
        return string.format("%dd %dh", v12, v13);
    elseif v13 > 0 then
        return string.format("%dh %dm", v13, v14);
    else
        return string.format("%dm %ds", v14, v15);
    end;
end;
local function u22(p17) --[[ Line: 169 ]]
    local v18 = p17 or 0;
    local v19 = os.time();
    local v20 = os.date("!*t", v19 + -18000);
    local v21 = (6 - v20.wday) % 7 * 86400 + (50400 - (v20.hour * 3600 + v20.min * 60 + v20.sec));
    if v21 <= 0 then
        v21 = v21 + 604800;
    end;
    return v21 + v18 * 7 * 86400;
end;
function u1.SetProjectedTimer(_) --[[ Line: 185 ]]
    -- upvalues: l__RefreshIn__15 (copy), u16 (copy), u22 (copy)
    l__RefreshIn__15.Timer.Text = "Opens in: " .. u16((u22(0)));
end;
function u1.SetThisWeekTimer(_) --[[ Line: 189 ]]
    -- upvalues: l__RefreshIn__16 (copy), u16 (copy), u22 (copy)
    l__RefreshIn__16.Timer.Text = "Expires in: " .. u16((u22(0)));
end;
function u1.SetProjectedPayoutFrame(_, p23, p24, p25) --[[ Line: 193 ]]
    -- upvalues: l__Prizes__5 (copy), l__PayoutFrame__4 (copy), u6 (copy), l__GearShopData__11 (copy), l__SeedPackData__10 (copy), l__EggData__12 (copy), l__SeedData__13 (copy), l__TemplateFrame__6 (copy), l__Gradients__14 (copy)
    for _, v26 in pairs(l__Prizes__5:GetChildren()) do
        if v26:IsA("Frame") and v26.Name ~= "TemplateFrame" then
            v26:Destroy();
        end;
    end;
    if p25 then
        l__PayoutFrame__4.BeanstalkFrame.Amount.Text = u6(p25);
        l__PayoutFrame__4.BeanstalkFrame.Amount.TextLabel.Text = l__PayoutFrame__4.BeanstalkFrame.Amount.Text;
    end;
    for _, v27 in pairs(p23) do
        local v28 = nil;
        local v29 = nil;
        for _, v30 in pairs(l__GearShopData__11.Data) do
            if v30.ItemName == v27.Name then
                v28 = v30.IMG.Value;
                v29 = v30.Rarity;
                break;
            end;
        end;
        if v28 == nil and string.find(v27.Name, "Seed Pack") then
            local v31 = l__SeedPackData__10.GetData(v27.Name);
            v28 = v31.IMG;
            v29 = v31.Rarity;
        end;
        if v28 == nil then
            local v32 = l__EggData__12.GetData(v27.Name);
            if v32 then
                v28 = v32.IMG;
                v29 = v32.Rarity;
            end;
        end;
        if v28 == nil then
            for _, v33 in pairs(l__SeedData__13) do
                if v33.SeedName == v27 then
                    v28 = v33.SeedImage.Value;
                    v29 = v33.Rarity;
                    break;
                end;
            end;
        end;
        if v28 == nil then
            for _, v34 in pairs(game.ReplicatedStorage.SharedModules:GetDescendants()) do
                if v34.Name == v27.Name and v34:IsA("StringValue") then
                    v28 = v34.Value;
                    break;
                end;
            end;
        end;
        if v28 == nil then
            for _, v35 in pairs(game.ReplicatedStorage.SharedModules.GuildCrateData.GuildCrateImages:GetChildren()) do
                if v35.Name == v27.Name then
                    v28 = v35.Value;
                end;
            end;
        end;
        if v28 ~= nil then
            local _ = v29 == nil;
        end;
        local v36 = l__TemplateFrame__6:Clone();
        if v28 then
            v36.Vector.Image = v28;
        end;
        local v37 = u6(v27.Cost);
        v36.BuyButton.HolderFrame.TextLabel.TextLabel.Text = v37 .. "¢";
        v36.BuyButton.HolderFrame.TextLabel.Text = u6(v27.Cost) .. "¢";
        v36.LayoutOrder = tonumber(v27.Cost);
        local v38 = l__Gradients__14:FindFirstChild(v29);
        if v38 then
            local v39 = v38:Clone();
            v39.Parent = v36;
            if v38.Name == "Super" or v38.Name == "Secret" then
                v39:AddTag("InfiniteGradient");
            end;
        end;
        v36.Parent = l__Prizes__5;
        v36.Visible = true;
    end;
    l__PayoutFrame__4.Description.Text = "Week " .. tostring(p24);
end;
function u1.SetLastWeekFrame(_, p40, p41, p42) --[[ Line: 321 ]]
    -- upvalues: l__Prizes__7 (copy), l__CurrentFrame__3 (copy), u6 (copy), l__GearShopData__11 (copy), l__SeedPackData__10 (copy), l__EggData__12 (copy), l__SeedData__13 (copy), l__TemplateFrame__8 (copy), l__Gradients__14 (copy)
    for _, v43 in pairs(l__Prizes__7:GetChildren()) do
        if v43:IsA("Frame") and v43.Name ~= "TemplateFrame" then
            v43:Destroy();
        end;
    end;
    if p42 then
        l__CurrentFrame__3.BeanstalkFrame.Amount.Text = u6(p42);
        l__CurrentFrame__3.BeanstalkFrame.Amount.TextLabel.Text = l__CurrentFrame__3.BeanstalkFrame.Amount.Text;
    end;
    for _, v44 in pairs(p40) do
        local v45 = nil;
        local v46 = nil;
        for _, v47 in pairs(l__GearShopData__11.Data) do
            if v47.ItemName == v44.Name then
                v45 = v47.IMG.Value;
                v46 = v47.Rarity;
                break;
            end;
        end;
        if v45 == nil and string.find(v44.Name, "Seed Pack") then
            local v48 = l__SeedPackData__10.GetData(v44.Name);
            v45 = v48.IMG;
            v46 = v48.Rarity;
        end;
        if v45 == nil then
            local v49 = l__EggData__12.GetData(v44.Name);
            if v49 then
                v45 = v49.IMG;
                v46 = v49.Rarity;
            end;
        end;
        if v45 == nil then
            for _, v50 in pairs(l__SeedData__13) do
                if v50.SeedName == v44 then
                    v45 = v50.SeedImage.Value;
                    v46 = v50.Rarity;
                    break;
                end;
            end;
        end;
        if v45 == nil then
            for _, v51 in pairs(game.ReplicatedStorage.SharedModules:GetDescendants()) do
                if v51.Name == v44.Name and v51:IsA("StringValue") then
                    v45 = v51.Value;
                    break;
                end;
            end;
        end;
        if v45 == nil then
            for _, v52 in pairs(game.ReplicatedStorage.SharedModules.GuildCrateData.GuildCrateImages:GetChildren()) do
                if v52.Name == v44.Name then
                    v45 = v52.Value;
                end;
            end;
        end;
        if v45 ~= nil then
            local _ = v46 == nil;
        end;
        local v53 = l__TemplateFrame__8:Clone();
        if v45 then
            v53.Vector.Image = v45;
        end;
        local v54 = u6(v44.Cost);
        v53.BuyButton.HolderFrame.TextLabel.TextLabel.Text = v54 .. "¢";
        v53.BuyButton.HolderFrame.TextLabel.Text = u6(v44.Cost) .. "¢";
        v53.LayoutOrder = tonumber(v44.Cost);
        local v55 = l__Gradients__14:FindFirstChild(v46);
        if v55 then
            local v56 = v55:Clone();
            v56.Parent = v53;
            if v55.Name == "Super" or v55.Name == "Secret" then
                v56:AddTag("InfiniteGradient");
            end;
        end;
        v53.Parent = l__Prizes__7;
        v53.Visible = true;
    end;
    l__CurrentFrame__3.Description.Text = "Week " .. tostring(p41);
end;
return u1;