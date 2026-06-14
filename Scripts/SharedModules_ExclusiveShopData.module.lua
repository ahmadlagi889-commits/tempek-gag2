-- Decompiled with Potassium's decompiler.

local l__GearShopData__1 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GearShopData"));
local l__SeedPackData__2 = require(game.ReplicatedStorage.SharedModules.SeedPackData);
local v1 = {};
local v2 = {};
for _, v3 in l__GearShopData__1.Data do
    v1[v3.ItemName] = v3.IMG;
end;
local v4 = {};
for _, v5 in l__SeedPackData__2.Data do
    v4[v5.PackName] = v5.IMG;
end;
v2.Data = {
    Secret = {
        RestockChance = 0.7,
        RestockTime = 10,
        GarenteedStock = 0,
        MaximumStock = 10,
        Items = {
            {
                ID = "Super Watering Can ExclusiveGear",
                ItemName = "Super Watering Can",
                ItemType = "Watering Can",
                ItemRestockChance = 100,
                PriceInRobux = 129,
                Giftable = true,
                Image = v1["Super Watering Can"],
                RestockAmounts = {
                    {
                        Amount = 1,
                        Chance = 50
                    },
                    {
                        Amount = 2,
                        Chance = 23
                    },
                    {
                        Amount = 3,
                        Chance = 2
                    }
                }
            },
            {
                ID = "Common Seed Pack ExclusiveGear",
                ItemName = "Common Seed Pack",
                ItemType = "Seed Pack",
                ItemRestockChance = 100,
                PriceInRobux = 129,
                Giftable = true,
                Image = v4["Common Seed Pack"],
                RestockAmounts = {
                    {
                        Amount = 1,
                        Chance = 50
                    },
                    {
                        Amount = 2,
                        Chance = 23
                    },
                    {
                        Amount = 3,
                        Chance = 2
                    }
                }
            }
        },
        RestockAmounts = {
            {
                Chance = 75,
                Amount = 1
            },
            {
                Chance = 23,
                Amount = 2
            },
            {
                Chance = 2,
                Amount = 3
            }
        }
    },
    Super = {
        RestockChance = 2.1,
        RestockTime = 30,
        GarenteedStock = 0,
        MaximumStock = 10,
        Items = {
            {
                ID = "Teleporter ExclusiveGear",
                ItemName = "Teleporter",
                ItemType = "Teleporter",
                ItemRestockChance = 100,
                PriceInRobux = 79,
                Giftable = true,
                Image = v1.Teleporter,
                RestockAmounts = {
                    {
                        Amount = 1,
                        Chance = 50
                    },
                    {
                        Amount = 2,
                        Chance = 23
                    },
                    {
                        Amount = 3,
                        Chance = 2
                    }
                }
            }
        }
    },
    Exotic = {
        RestockChance = 60,
        RestockTime = 300,
        GarenteedStock = 3,
        MaximumStock = 10,
        Items = {
            {
                ID = "Jump Mushroom ExclusiveGear",
                ItemName = "Jump Mushroom",
                ItemType = "Jump Mushroom",
                ItemRestockChance = 100,
                PriceInRobux = 29,
                Giftable = true,
                Image = v1["Jump Mushroom"],
                RestockAmounts = {
                    {
                        Amount = 1,
                        Chance = 50
                    },
                    {
                        Amount = 2,
                        Chance = 23
                    },
                    {
                        Amount = 3,
                        Chance = 2
                    }
                }
            }
        }
    }
};
return v2;