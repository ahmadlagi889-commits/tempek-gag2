-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local u2 = l__LocalPlayer__3:GetMouse();
local l__Tooltip__4 = l__LocalPlayer__3:WaitForChild("PlayerGui"):WaitForChild("Tooltip"):WaitForChild("Tooltip");
local u3 = nil;
local u4 = false;
local l__SeedData__5 = require(game.ReplicatedStorage.SharedModules.SeedData);
local l__SellValueData__6 = require(game.ReplicatedStorage.SharedModules.SellValueData);
local l__NumberUtils__7 = require(game.ReplicatedStorage.SharedModules.NumberUtils);
local l__WeatherData__8 = require(game.ReplicatedStorage.SharedModules.WeatherData);
local u5 = nil;
local l__HoverSFX__9 = game.SoundService.SFX.HoverSFX;
local function u7(p6) --[[ Line: 18 ]]
    while p6 do
        if p6:IsA("GuiObject") and not p6.Visible then
            return false;
        end;
        if p6:IsA("ScreenGui") and not p6.Enabled then
            return false;
        end;
        p6 = p6.Parent;
    end;
    return true;
end;
function Update(p8)
    -- upvalues: u5 (ref), l__HoverSFX__9 (copy), l__Tooltip__4 (copy), l__SeedData__5 (copy), l__SellValueData__6 (copy), l__NumberUtils__7 (copy)
    if u5 == p8 then
        return;
    end;
    l__HoverSFX__9.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l__HoverSFX__9.TimePosition = 0;
    l__HoverSFX__9.Playing = true;
    u5 = p8;
    l__Tooltip__4.AnchorPoint = Vector2.new(0, 0);
    for _, v9 in pairs(l__SeedData__5) do
        if v9.SeedName == p8 then
            SeedSpec = v9;
            break;
        end;
    end;
    if SeedSpec then
        l__Tooltip__4.ItemImage.Vector.Image = SeedSpec.FruitImage.Value;
        l__Tooltip__4.Rarity.Text = SeedSpec.Rarity;
        l__Tooltip__4.Rarity.TextColor3 = Color3.new(1, 1, 1);
        l__Tooltip__4.ItemName.TextColor3 = Color3.new(1, 1, 1);
        l__Tooltip__4.Price.RichText = false;
        for _, v10 in pairs(l__Tooltip__4.Rarity:GetChildren()) do
            if v10:IsA("UIGradient") then
                v10:Destroy();
                break;
            end;
        end;
        local v11 = game.ReplicatedStorage.SharedModules.RarityData.Gradients:FindFirstChild(SeedSpec.Rarity):Clone();
        if v11 then
            v11.Parent = l__Tooltip__4.Rarity;
        else
            v11:Destroy();
        end;
        l__Tooltip__4.Price.Text = "Base: " .. l__NumberUtils__7.Abbreviate(l__SellValueData__6[p8]) .. "¢";
        l__Tooltip__4.ItemName.Text = p8;
    end;
end;
function UpdateWeather(p12)
    -- upvalues: u5 (ref), l__HoverSFX__9 (copy), l__Tooltip__4 (copy), l__WeatherData__8 (copy)
    if u5 ~= p12 then
        l__HoverSFX__9.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l__HoverSFX__9.TimePosition = 0;
        l__HoverSFX__9.Playing = true;
        u5 = p12;
        l__Tooltip__4.AnchorPoint = Vector2.new(1, 0);
    end;
    local v13 = p12:FindFirstChild("Time");
    local v14 = p12:FindFirstChild("Weather");
    local v15 = p12:FindFirstChild("Vector");
    if v13 and v13:IsA("TextLabel") then
        l__Tooltip__4.Rarity.Text = v13.Text;
        l__Tooltip__4.Rarity.TextColor3 = v13.TextColor3;
    end;
    for _, v16 in l__Tooltip__4.Rarity:GetChildren() do
        if v16:IsA("UIGradient") then
            v16:Destroy();
            break;
        end;
    end;
    if v14 and v14:IsA("TextLabel") then
        l__Tooltip__4.ItemName.Text = v14.Text;
        l__Tooltip__4.ItemName.TextColor3 = v14.TextColor3;
    end;
    if v15 and v15:IsA("ImageLabel") then
        l__Tooltip__4.ItemImage.Vector.Image = v15.Image;
    end;
    local v17 = v14 and v14.Text or "";
    local v18 = "";
    for _, v19 in l__WeatherData__8.Data do
        if v19.Name == v17 then
            v18 = v19.Description;
            break;
        end;
    end;
    l__Tooltip__4.Price.RichText = true;
    l__Tooltip__4.Price.Text = v18;
    l__Tooltip__4.Price.TextColor3 = Color3.new(1, 1, 1);
end;
function v1.TrackUI(_, u20) --[[ Line: 121 ]]
    -- upvalues: u3 (ref), u4 (ref), u5 (ref)
    u20.MouseEnter:Connect(function() --[[ Line: 122 ]]
        -- upvalues: u3 (ref), u20 (copy), u4 (ref)
        u3 = u20;
        u4 = true;
    end);
    u20.MouseLeave:Connect(function() --[[ Line: 126 ]]
        -- upvalues: u3 (ref), u20 (copy), u4 (ref), u5 (ref)
        if u3 == u20 then
            u4 = false;
            u3 = nil;
            u5 = nil;
        end;
    end);
    local function v21() --[[ Line: 134 ]]
        -- upvalues: u20 (copy), u3 (ref), u4 (ref)
        if not u20:GetAttribute("SeedToolTip") and (not u20:GetAttribute("WeatherToolTip") and u3 == u20) then
            u4 = false;
            u3 = nil;
        end;
    end;
    u20:GetAttributeChangedSignal("SeedToolTip"):Connect(v21);
    u20:GetAttributeChangedSignal("WeatherToolTip"):Connect(v21);
    u20.Destroying:Connect(function() --[[ Line: 145 ]]
        -- upvalues: u3 (ref), u20 (copy), u4 (ref)
        if u3 == u20 then
            u4 = false;
            u3 = nil;
        end;
    end);
end;
function v1.Start(u22) --[[ Line: 153 ]]
    -- upvalues: l__LocalPlayer__3 (copy), l__Tooltip__4 (copy), l__RunService__2 (copy), u4 (ref), u3 (ref), u7 (copy), u5 (ref), u2 (copy)
    local l__PlayerGui__10 = l__LocalPlayer__3.PlayerGui;
    for _, v23 in l__PlayerGui__10:GetDescendants() do
        local v24 = v23:IsA("GuiObject");
        if v24 then
            v24 = v23:GetAttribute("SeedToolTip") or v23:GetAttribute("WeatherToolTip");
        end;
        if v24 then
            u22:TrackUI(v23);
        end;
    end;
    l__PlayerGui__10.DescendantAdded:Connect(function(p25) --[[ Line: 166 ]]
        -- upvalues: u22 (copy)
        local v26 = p25:IsA("GuiObject");
        if v26 then
            v26 = p25:GetAttribute("SeedToolTip") or p25:GetAttribute("WeatherToolTip");
        end;
        if v26 then
            u22:TrackUI(p25);
        end;
    end);
    l__Tooltip__4.Visible = false;
    l__RunService__2.Heartbeat:Connect(function() --[[ Line: 173 ]]
        -- upvalues: u4 (ref), u3 (ref), u7 (ref), l__Tooltip__4 (ref), u5 (ref), u2 (ref)
        if u4 and u3 then
            if u7(u3) then
                if u3:GetAttribute("WeatherToolTip") then
                    UpdateWeather(u3);
                else
                    local v27 = u3:GetAttribute("SeedToolTip") or "";
                    Update(v27);
                end;
                l__Tooltip__4.Position = UDim2.new(0, u2.X, 0, u2.Y - l__Tooltip__4.AbsoluteSize.Y - 8);
                l__Tooltip__4.Visible = true;
            else
                l__Tooltip__4.Visible = false;
                u4 = false;
                u3 = nil;
                u5 = nil;
            end;
        else
            l__Tooltip__4.Visible = false;
        end;
    end);
end;
function v1.Init(_) --[[ Line: 198 ]] end;
return v1;