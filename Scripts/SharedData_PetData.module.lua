-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__PetSizes__2 = require(l__ReplicatedStorage__1.SharedData.PetSizes);
local l__PetTypes__3 = require(l__ReplicatedStorage__1.SharedData.PetTypes);
local l__GearImages__4 = l__ReplicatedStorage__1:WaitForChild("SharedModules"):WaitForChild("GearImages");
local u1 = {};
local v2 = {
    DisplayName = "Raccoon",
    Rarity = "Super",
    SpawnChance = 0.24,
    BasePrice = 5000000,
    Offset = Vector3.new(0, 2.5, 0)
};
local v3 = l__GearImages__4:FindFirstChild("Raccoon");
v2.Image = not (v3 and v3:IsA("StringValue")) and "" or v3.Value;
function v2.Description(p4, p5) --[[ Line: 46 ]]
    -- upvalues: l__PetSizes__2 (copy), l__PetTypes__3 (copy)
    local v6 = l__PetSizes__2.Normalize(p4);
    local v7 = v6 == "Huge" and 100 or (v6 == "Big" and 50 or 25);
    if p5 == l__PetTypes__3.Rainbow then
        v7 = v7 + 10;
    end;
    return `Sneaks out at <b>night</b> to <font color="#ff0000">steal</font> fruit from empty gardens and <font color="#55ff55">raises your steal limit by +{v7}</font>`;
end;
v2.NeededWeather = {};
v2.NeededTimeCycle = {};
u1.Raccoon = v2;
local v8 = {
    DisplayName = "Monkey",
    Rarity = "Mythic",
    SpawnChance = 0.2,
    BasePrice = 1000000,
    Offset = Vector3.new(0, 2.5, 0)
};
local v9 = l__GearImages__4:FindFirstChild("Monkey");
v8.Image = not (v9 and v9:IsA("StringValue")) and "" or v9.Value;
function v8.Description(p10, p11) --[[ Line: 70 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v12 = l__PetTypes__3.GetBoostMultiplier(p11) * l__PetSizes__2.GetBoostMultiplier(p10);
    if v12 <= 1 then
        return "Swings around your <b>garden</b> and occasionally <font color=\"#55ff55\">picks ripe fruit</font> and brings it straight to you";
    end;
    local v13 = string.format("%.2f", v12);
    return `Swings around your <b>garden</b> and <font color="#55ff55">picks ripe fruit <b>x{string.gsub(v13, "%.?0+$", "")}</b> as often</font> and brings it straight to you`;
end;
v8.NeededWeather = {};
v8.NeededTimeCycle = {};
u1.Monkey = v8;
local v14 = {
    DisplayName = "Robin",
    Rarity = "Legendary",
    SpawnChance = 2.86,
    BasePrice = 75000,
    Offset = Vector3.new(0, 5, 0)
};
local v15 = l__GearImages__4:FindFirstChild("Robin");
v14.Image = not (v15 and v15:IsA("StringValue")) and "" or v15.Value;
function v14.Description(p16, p17) --[[ Line: 88 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v18 = l__PetTypes__3.GetBoostMultiplier(p17) * l__PetSizes__2.GetBoostMultiplier(p16);
    if v18 <= 1 then
        return "Flies around your <b>garden</b> eating ripe fruit and sometimes <font color=\"#55ff55\">drops seeds</font>";
    end;
    local v19 = string.format("%.2f", v18);
    return `Flies around your <b>garden</b> eating ripe fruit and <font color="#55ff55">drops seeds <b>x{string.gsub(v19, "%.?0+$", "")}</b> as often</font>`;
end;
v14.NeededWeather = {};
v14.NeededTimeCycle = {};
u1.Robin = v14;
local v20 = {
    DisplayName = "Frog",
    Rarity = "Common",
    SpawnChance = 11.9,
    BasePrice = 10000,
    Offset = Vector3.new(0, 2, 0)
};
local v21 = l__GearImages__4:FindFirstChild("Frog");
v20.Image = not (v21 and v21:IsA("StringValue")) and "" or v21.Value;
function v20.Description(p22, p23) --[[ Line: 106 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v24 = l__PetTypes__3.GetBoostMultiplier(p23) * l__PetSizes__2.GetBoostMultiplier(p22) * 5;
    local v25 = string.format("%.2f", v24);
    return `Hops around your <b>garden</b> and <font color="#55ff55">boosts your jump height by +{string.gsub(v25, "%.?0+$", "")}</font>`;
end;
v20.NeededWeather = {};
v20.NeededTimeCycle = {};
u1.Frog = v20;
local v26 = {
    DisplayName = "Bunny",
    Rarity = "Common",
    SpawnChance = 11.9,
    BasePrice = 20000,
    Offset = Vector3.new(0, 2, 0)
};
local v27 = l__GearImages__4:FindFirstChild("Bunny");
v26.Image = not (v27 and v27:IsA("StringValue")) and "" or v27.Value;
function v26.Description(p28, p29) --[[ Line: 121 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v30 = l__PetTypes__3.GetBoostMultiplier(p29) * l__PetSizes__2.GetBoostMultiplier(p28) * 5;
    local v31 = string.format("%.2f", v30);
    return `Hops around your <b>garden</b> and <font color="#55ff55">boosts your walk speed by +{string.gsub(v31, "%.?0+$", "")}</font>`;
end;
v26.NeededWeather = {};
v26.NeededTimeCycle = {};
u1.Bunny = v26;
local v32 = {
    DisplayName = "Deer",
    Rarity = "Rare",
    SpawnChance = 4.29,
    BasePrice = 50000,
    Offset = Vector3.new(0, 3, 0)
};
local v33 = l__GearImages__4:FindFirstChild("Deer");
v32.Image = not (v33 and v33:IsA("StringValue")) and "" or v33.Value;
function v32.Description(p34, p35) --[[ Line: 136 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v36 = l__PetTypes__3.GetBoostMultiplier(p35) * l__PetSizes__2.GetBoostMultiplier(p34) * 10;
    local v37 = string.format("%.2f", v36);
    return `Trots around your <b>garden</b> and helps plants <font color="#55ff55">grow {string.gsub(v37, "%.?0+$", "")}% faster</font>`;
end;
v32.NeededWeather = {};
v32.NeededTimeCycle = {};
u1.Deer = v32;
local v38 = {
    DisplayName = "Owl",
    Rarity = "Uncommon",
    SpawnChance = 7.14,
    BasePrice = 25000,
    Offset = Vector3.new(0, 5, 0)
};
local v39 = l__GearImages__4:FindFirstChild("Owl");
v38.Image = not (v39 and v39:IsA("StringValue")) and "" or v39.Value;
function v38.Description(p40, p41) --[[ Line: 151 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v42 = l__PetTypes__3.GetBoostMultiplier(p41) * l__PetSizes__2.GetBoostMultiplier(p40) * 12.5;
    local v43 = string.format("%.2f", v42);
    return `<font color="#55ff55">Extends your view distance by {string.gsub(v43, "%.?0+$", "")}%</font> at night and <font color="#ffaa00">hoots loudly</font> when a rare pet spawns`;
end;
v38.NeededWeather = {};
v38.NeededTimeCycle = {};
u1.Owl = v38;
local v44 = {
    DisplayName = "Bee",
    Rarity = "Legendary",
    Description = "Patrols your <b>garden</b> and <font color=\"#ff8800\">swarms intruders</font> to defend your fruit",
    SpawnChance = 2.38,
    BasePrice = 1000000,
    Offset = Vector3.new(0, 5, 0)
};
local v45 = l__GearImages__4:FindFirstChild("Bee");
v44.Image = not (v45 and v45:IsA("StringValue")) and "" or v45.Value;
v44.NeededWeather = {};
v44.NeededTimeCycle = {};
u1.Bee = v44;
local v46 = {
    DisplayName = "Unicorn",
    Rarity = "Mythic",
    SpawnChance = 0.71,
    BasePrice = 4000000,
    Offset = Vector3.new(0, 3, 0)
};
local v47 = l__GearImages__4:FindFirstChild("Unicorn");
v46.Image = not (v47 and v47:IsA("StringValue")) and "" or v47.Value;
function v46.Description(p48, p49) --[[ Line: 178 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v50 = l__PetTypes__3.GetBoostMultiplier(p49) * l__PetSizes__2.GetBoostMultiplier(p48) + 1;
    local v51 = "Trots around your <b>garden</b> and %*";
    local v52;
    if v50 == 2 then
        v52 = "<b>doubles</b> the chance for plants and fruit to turn <font color=\"#ff66ff\">Rainbow</font>";
    else
        local v53 = string.format("%.2f", v50);
        v52 = `<b>multiplies</b> the chance for plants and fruit to turn <font color="#ff66ff">Rainbow</font> by <b>x{string.gsub(v53, "%.?0+$", "")}</b>`;
    end;
    return v51:format(v52);
end;
v46.NeededWeather = {};
v46.NeededTimeCycle = {};
u1.Unicorn = v46;
local v54 = {
    DisplayName = "Black Dragon",
    Rarity = "Super",
    SpawnChance = 0,
    BasePrice = 1000000,
    Offset = Vector3.new(0, 5, 0)
};
local v55 = l__GearImages__4:FindFirstChild("Black Dragon");
v54.Image = not (v55 and v55:IsA("StringValue")) and "" or v55.Value;
function v54.Description(p56, p57) --[[ Line: 193 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v58 = l__PetTypes__3.GetBoostMultiplier(p57) * l__PetSizes__2.GetBoostMultiplier(p56);
    if v58 <= 1 then
        return "Flies around your <b>garden</b> and <font color=\"#ff4400\">breathes fire</font> on intruders, setting them ablaze";
    end;
    local v59 = string.format("%.2f", v58);
    return `Flies around your <b>garden</b> and <font color="#ff4400">breathes fire</font> on intruders, <font color="#ff4400">burning them <b>x{string.gsub(v59, "%.?0+$", "")}</b> as hard</font>`;
end;
v54.NeededWeather = {};
v54.NeededTimeCycle = {};
u1.BlackDragon = v54;
local v60 = {
    DisplayName = "Ice Serpent",
    Rarity = "Super",
    SpawnChance = 0,
    BasePrice = 20000000,
    Offset = Vector3.new(0, 5, 0)
};
local v61 = l__GearImages__4:FindFirstChild("Ice Serpent");
v60.Image = not (v61 and v61:IsA("StringValue")) and "" or v61.Value;
function v60.Description(p62, p63) --[[ Line: 211 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v64 = l__PetTypes__3.GetBoostMultiplier(p63) * l__PetSizes__2.GetBoostMultiplier(p62);
    if v64 <= 1 then
        return "Flies around your <b>garden</b> and <font color=\"#66ccff\">breathes frost</font> on intruders, freezing them solid";
    end;
    local v65 = string.format("%.2f", v64);
    return `Flies around your <b>garden</b> and <font color="#66ccff">breathes frost</font> on intruders, <font color="#66ccff">freezing them <b>x{string.gsub(v65, "%.?0+$", "")}</b> as hard</font>`;
end;
v60.NeededWeather = {};
v60.NeededTimeCycle = {};
u1.IceSerpent = v60;
local v66 = {
    DisplayName = "Golden Dragonfly",
    Rarity = "Mythic",
    SpawnChance = 0.6,
    BasePrice = 3000000,
    Offset = Vector3.new(0, 5, 0)
};
local v67 = l__GearImages__4:FindFirstChild("Golden Dragonfly");
v66.Image = not (v67 and v67:IsA("StringValue")) and "" or v67.Value;
function v66.Description(p68, p69) --[[ Line: 229 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    local v70 = l__PetTypes__3.GetBoostMultiplier(p69) * l__PetSizes__2.GetBoostMultiplier(p68) + 1;
    local v71 = "Flies around your <b>garden</b> and %*";
    local v72;
    if v70 == 2 then
        v72 = "<b>doubles</b> the chance for plants and fruit to turn <font color=\"#ffd700\">Gold</font>";
    else
        local v73 = string.format("%.2f", v70);
        v72 = `<b>multiplies</b> the chance for plants and fruit to turn <font color="#ffd700">Gold</font> by <b>x{string.gsub(v73, "%.?0+$", "")}</b>`;
    end;
    return v71:format(v72);
end;
v66.NeededWeather = {};
v66.NeededTimeCycle = {};
u1.GoldenDragonfly = v66;
function u1.GetImage(p74, p75) --[[ Line: 245 ]]
    -- upvalues: u1 (copy), l__PetSizes__2 (copy), l__GearImages__4 (copy)
    local v76 = u1[p74];
    if type(v76) ~= "table" then
        return "";
    end;
    local v77 = l__PetSizes__2.Normalize(p75);
    if v77 then
        local v78 = l__GearImages__4:FindFirstChild((`{v77} {u1.GetSpeciesDisplayName(p74)}`));
        local v79 = not (v78 and v78:IsA("StringValue")) and "" or v78.Value;
        if v79 ~= "" then
            return v79;
        end;
    end;
    local l__Image__5 = v76.Image;
    return type(l__Image__5) ~= "string" and "" or l__Image__5;
end;
function u1.GetSpeciesDisplayName(p80) --[[ Line: 274 ]]
    -- upvalues: u1 (copy)
    local v81 = u1[p80];
    if type(v81) == "table" and type(v81.DisplayName) == "string" then
        return v81.DisplayName;
    else
        return string.gsub(p80, "(%l)(%u)", "%1 %2");
    end;
end;
function u1.GetDisplayName(p82, p83) --[[ Line: 285 ]]
    -- upvalues: l__PetSizes__2 (copy), u1 (copy)
    return l__PetSizes__2.DisplayName(u1.GetSpeciesDisplayName(p82), p83);
end;
function u1.GetVariantBoost(p84, p85) --[[ Line: 291 ]]
    -- upvalues: l__PetTypes__3 (copy), l__PetSizes__2 (copy)
    return l__PetTypes__3.GetBoostMultiplier(p85) * l__PetSizes__2.GetBoostMultiplier(p84);
end;
function u1.GetDescription(p86, p87, p88) --[[ Line: 297 ]]
    -- upvalues: u1 (copy)
    local v89 = u1[p86];
    if type(v89) == "table" then
        local l__Description__6 = v89.Description;
        if type(l__Description__6) == "function" then
            return l__Description__6(p87, p88);
        else
            return type(l__Description__6) ~= "string" and "" or l__Description__6;
        end;
    else
        return "";
    end;
end;
return u1;