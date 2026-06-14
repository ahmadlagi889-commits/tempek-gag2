-- Decompiled with Potassium's decompiler.

local l__GearImages__1 = script.Parent.GearImages;
local v1 = {};
local v2 = {};
local v3 = {
    ItemName = "Common Watering Can",
    ItemType = "Watering Can",
    RestockChance = 90,
    Cost = 2000,
    Rarity = "Common",
    RestockValues = NumberRange.new(2, 5)
};
local v4 = l__GearImages__1:FindFirstChild("Common Watering Can");
v3.IMG = v4 and v4.Value or "";
local v5 = {
    ItemName = "Common Sprinkler",
    ItemType = "Common Sprinkler",
    RestockChance = 50,
    Cost = 3000,
    Rarity = "Common",
    RestockValues = NumberRange.new(1, 2)
};
local v6 = l__GearImages__1:FindFirstChild("Common Sprinkler");
v5.IMG = v6 and v6.Value or "";
local v7 = {
    ItemName = "Sign",
    ItemType = "Sign",
    Cost = 4000,
    PriceInRobux = 49,
    EquippableGear = true,
    Rarity = "Common"
};
local v8 = l__GearImages__1:FindFirstChild("Sign");
v7.IMG = v8 and v8.Value or "";
local v9 = {
    ItemName = "Lantern",
    ItemType = "Lantern",
    Cost = 12000,
    PriceInRobux = 99,
    EquippableGear = true,
    Rarity = "Rare"
};
local v10 = l__GearImages__1:FindFirstChild("Lantern");
v9.IMG = v10 and v10.Value or "";
local v11 = {
    ItemName = "Uncommon Sprinkler",
    ItemType = "Uncommon Sprinkler",
    RestockChance = 35,
    Cost = 10000,
    Rarity = "Uncommon",
    RestockValues = NumberRange.new(1, 2)
};
local v12 = l__GearImages__1:FindFirstChild("Uncommon Sprinkler");
v11.IMG = v12 and v12.Value or "";
local v13 = {
    ItemName = "Rare Sprinkler",
    ItemType = "Rare Sprinkler",
    RestockChance = 25,
    Cost = 50000,
    Rarity = "Rare",
    RestockValues = NumberRange.new(1, 2)
};
local v14 = l__GearImages__1:FindFirstChild("Rare Sprinkler");
v13.IMG = v14 and v14.Value or "";
local v15 = {
    ItemName = "Legendary Sprinkler",
    ItemType = "Legendary Sprinkler",
    RestockChance = 4,
    Cost = 100000,
    Rarity = "Legendary",
    RestockValues = NumberRange.new(1, 2)
};
local v16 = l__GearImages__1:FindFirstChild("Legendary Sprinkler");
v15.IMG = v16 and v16.Value or "";
local v17 = {
    ItemName = "Super Sprinkler",
    ItemType = "Super Sprinkler",
    RestockChance = 1.2,
    Cost = 300000,
    Rarity = "Super",
    RestockValues = NumberRange.new(1, 2)
};
local v18 = l__GearImages__1:FindFirstChild("Super Sprinkler");
v17.IMG = v18 and v18.Value or "";
local v19 = {
    ItemName = "Trowel",
    ItemType = "Trowel",
    RestockChance = 28,
    Cost = 1000,
    Rarity = "Rare",
    RestockValues = NumberRange.new(2, 3)
};
local v20 = l__GearImages__1:FindFirstChild("Trowel");
v19.IMG = v20 and v20.Value or "";
local v21 = {
    ItemName = "Speed Mushroom",
    ItemType = "Mushroom",
    RestockChance = 22,
    Cost = 1500,
    Rarity = "Rare",
    RestockValues = NumberRange.new(1, 5)
};
local v22 = l__GearImages__1:FindFirstChild("Speed Mushroom");
v21.IMG = v22 and v22.Value or "";
local v23 = {
    ItemName = "Jump Mushroom",
    ItemType = "Mushroom",
    RestockChance = 24,
    Cost = 1800,
    Rarity = "Rare",
    RestockValues = NumberRange.new(1, 4)
};
local v24 = l__GearImages__1:FindFirstChild("Jump Mushroom");
v23.IMG = v24 and v24.Value or "";
local v25 = {
    ItemName = "Gnome",
    ItemType = "Gnome",
    RestockChance = 8,
    Cost = 50000,
    Rarity = "Epic",
    RestockValues = NumberRange.new(2, 5)
};
local v26 = l__GearImages__1:FindFirstChild("Gnome");
v25.IMG = v26 and v26.Value or "";
local v27 = {
    ItemName = "Shrink Mushroom",
    ItemType = "Mushroom",
    RestockChance = 10,
    Cost = 4500,
    Rarity = "Epic",
    RestockValues = NumberRange.new(1, 3)
};
local v28 = l__GearImages__1:FindFirstChild("Shrink Mushroom");
v27.IMG = v28 and v28.Value or "";
local v29 = {
    ItemName = "Supersize Mushroom",
    ItemType = "Mushroom",
    RestockChance = 10,
    Cost = 4500,
    Rarity = "Epic",
    RestockValues = NumberRange.new(1, 3)
};
local v30 = l__GearImages__1:FindFirstChild("Supersize Mushroom");
v29.IMG = v30 and v30.Value or "";
local v31 = {
    ItemName = "Invisibility Mushroom",
    ItemType = "Mushroom",
    RestockChance = 4,
    Cost = 18000,
    Rarity = "Legendary",
    RestockValues = NumberRange.new(1, 2)
};
local v32 = l__GearImages__1:FindFirstChild("Invisibility Mushroom");
v31.IMG = v32 and v32.Value or "";
v2[1], v2[2], v2[3], v2[4], v2[5], v2[6], v2[7], v2[8], v2[9], v2[10], v2[11], v2[12], v2[13], v2[14], v2[15], v2[16] = v3, v5, v7, v9, {
    ItemName = "Wheelbarrow",
    ItemType = "Wheelbarrow",
    Cost = 500000,
    PriceInRobux = 129,
    EquippableGear = true,
    Rarity = "Legendary",
    IMG = "rbxassetid://125296794878681"
}, v11, v13, v15, v17, v19, v21, v23, v25, v27, v29, v31;
local v33 = {
    ItemName = "Teleporter",
    ItemType = "Teleporter",
    RestockChance = 3,
    Cost = 18000,
    Rarity = "Legendary",
    RestockValues = NumberRange.new(1, 3)
};
local v34 = l__GearImages__1:FindFirstChild("Teleporter");
v33.IMG = v34 and v34.Value or "";
local v35 = {
    ItemName = "Super Watering Can",
    ItemType = "Watering Can",
    RestockChance = 2,
    Cost = 250000,
    Rarity = "Super",
    RestockValues = NumberRange.new(1, 2)
};
local v36 = l__GearImages__1:FindFirstChild("Super Watering Can");
v35.IMG = v36 and v36.Value or "";
local v37 = {
    ItemName = "Basic Pot",
    ItemType = "EmptyPot",
    RestockChance = 7,
    Cost = 60000,
    Rarity = "Epic",
    RestockValues = NumberRange.new(1, 3)
};
local v38 = l__GearImages__1:FindFirstChild("Basic Pot");
v37.IMG = v38 and v38.Value or "";
v2[17], v2[18], v2[19], v2[20] = v33, v35, v37, {
    ItemName = "Flashbang",
    ItemType = "Flashbang",
    RestockChance = 7,
    Cost = 8000,
    Rarity = "Epic",
    IMG = "rbxassetid://137760243645491",
    RestockValues = NumberRange.new(4, 7)
};
v1.Data = v2;
return v1;