-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Eggs__2 = l__ReplicatedStorage__1:WaitForChild("Assets"):WaitForChild("Eggs");
local l__FastFlags__3 = require(l__ReplicatedStorage__1.UserGenerated.FastFlags);
local l__Asserts__4 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local l__PetData__5 = require(l__ReplicatedStorage__1.SharedData.PetData);
local u1 = l__FastFlags__3.Replicated("Game.Eggs.RainbowChanceMultiplier", l__Asserts__4.FiniteNonNegative, 1);
local u2 = l__FastFlags__3.Replicated("Game.Eggs.BigChanceMultiplier", l__Asserts__4.FiniteNonNegative, 1);
local u3 = l__FastFlags__3.Replicated("Game.Eggs.HugeChanceMultiplier", l__Asserts__4.FiniteNonNegative, 1);
local u4 = l__FastFlags__3.Replicated("Game.Eggs.PetWeightMultipliers", l__Asserts__4.Map(l__Asserts__4.String, l__Asserts__4.FiniteNonNegative), {});
local u5 = l__FastFlags__3.Replicated("Game.Eggs.SpeciesWeightMultipliers", l__Asserts__4.Map(l__Asserts__4.String, l__Asserts__4.FiniteNonNegative), {});
local function u10(p6) --[[ Line: 26 ]]
    -- upvalues: l__PetData__5 (copy), u4 (copy), u5 (copy), u3 (copy), u2 (copy)
    local v7 = l__PetData__5[p6.PetName];
    local v8 = (not v7 or type(v7.Rarity) ~= "string") and "Common" or v7.Rarity;
    local v9 = (u4:Get()[v8] or 1) * (u5:Get()[p6.PetName] or 1);
    if p6.Huge then
        return v9 * u3:Get();
    end;
    if p6.Big then
        v9 = v9 * u2:Get();
    end;
    return v9;
end;
local u11 = {
    Data = {
        {
            EggName = "Common Egg",
            Rarity = "Common",
            IMG = "rbxassetid://126687482540593",
            RainbowChance = 0.5,
            Model = l__Eggs__2:WaitForChild("Common Egg"),
            Pets = {
                {
                    PetName = "Frog",
                    Chance = 30
                },
                {
                    PetName = "Bunny",
                    Chance = 30
                },
                {
                    PetName = "Deer",
                    Chance = 20
                },
                {
                    PetName = "Robin",
                    Chance = 4.5
                },
                {
                    PetName = "Bee",
                    Chance = 4.5
                },
                {
                    PetName = "Unicorn",
                    Chance = 0.3
                },
                {
                    PetName = "Golden Dragonfly",
                    Chance = 0.3
                },
                {
                    PetName = "Raccoon",
                    Chance = 0.2
                },
                {
                    PetName = "Frog",
                    Big = true,
                    Chance = 0.6
                },
                {
                    PetName = "Bunny",
                    Big = true,
                    Chance = 0.6
                },
                {
                    PetName = "Deer",
                    Big = true,
                    Chance = 0.4
                },
                {
                    PetName = "Robin",
                    Big = true,
                    Chance = 0.09
                },
                {
                    PetName = "Bee",
                    Big = true,
                    Chance = 0.09
                },
                {
                    PetName = "Unicorn",
                    Big = true,
                    Chance = 0.006
                },
                {
                    PetName = "Golden Dragonfly",
                    Big = true,
                    Chance = 0.006
                },
                {
                    PetName = "Raccoon",
                    Big = true,
                    Chance = 0.004
                },
                {
                    PetName = "Frog",
                    Huge = true,
                    Chance = 0.03
                },
                {
                    PetName = "Bunny",
                    Huge = true,
                    Chance = 0.03
                },
                {
                    PetName = "Deer",
                    Huge = true,
                    Chance = 0.02
                },
                {
                    PetName = "Robin",
                    Huge = true,
                    Chance = 0.0045
                },
                {
                    PetName = "Bee",
                    Huge = true,
                    Chance = 0.0045
                },
                {
                    PetName = "Unicorn",
                    Huge = true,
                    Chance = 0.0003
                },
                {
                    PetName = "Golden Dragonfly",
                    Huge = true,
                    Chance = 0.0003
                },
                {
                    PetName = "Raccoon",
                    Huge = true,
                    Chance = 0.0002
                }
            }
        },
        {
            EggName = "Test Egg",
            Rarity = "Common",
            IMG = "rbxassetid://126687482540593",
            RainbowChance = 0.5,
            Model = l__Eggs__2:WaitForChild("Common Egg"),
            Pets = {
                {
                    PetName = "Frog",
                    Chance = 10
                },
                {
                    PetName = "Frog",
                    Chance = 10,
                    Big = true
                },
                {
                    PetName = "Frog",
                    Chance = 10,
                    Huge = true
                }
            }
        },
        {
            EggName = "Epic Egg",
            Rarity = "Epic",
            IMG = "rbxassetid://126687482540593",
            RainbowChance = 5,
            Model = l__Eggs__2:WaitForChild("Epic Egg"),
            Pets = {
                {
                    PetName = "Deer",
                    Chance = 60
                },
                {
                    PetName = "Unicorn",
                    Chance = 30
                },
                {
                    PetName = "Bee",
                    Chance = 9
                },
                {
                    PetName = "Bee",
                    Big = true,
                    Chance = 1
                }
            }
        }
    }
};
function u11.GetData(p12) --[[ Line: 139 ]]
    -- upvalues: u11 (copy)
    for _, v13 in u11.Data do
        if v13.EggName == p12 then
            return v13;
        end;
    end;
    return nil;
end;
function u11.GetRandomPet(p14) --[[ Line: 150 ]]
    -- upvalues: u11 (copy), u10 (copy)
    local v15 = u11.GetData(p14);
    if not v15 then
        return nil;
    end;
    if not v15.Pets or #v15.Pets == 0 then
        return nil;
    end;
    local v16 = 0;
    for _, v17 in v15.Pets do
        v16 = v16 + v17.Chance * u10(v17);
    end;
    if v16 <= 0 then
        return v15.Pets[#v15.Pets];
    end;
    local v18 = math.random() * v16;
    local v19 = 0;
    for _, v20 in v15.Pets do
        v19 = v19 + v20.Chance * u10(v20);
        if v18 <= v19 then
            return v20;
        end;
    end;
    return v15.Pets[#v15.Pets];
end;
function u11.RollRainbow(p21) --[[ Line: 177 ]]
    -- upvalues: u11 (copy), u1 (copy)
    local v22 = u11.GetData(p21);
    local v23 = (v22 and v22.RainbowChance or 0) * u1:Get();
    if v23 <= 0 then
        return false;
    else
        return math.random() * 100 < v23;
    end;
end;
function u11.Roll(p24) --[[ Line: 185 ]]
    -- upvalues: u11 (copy)
    local v25 = u11.GetRandomPet(p24);
    if not v25 then
        return nil;
    end;
    local v26 = v25.Huge and "Huge" or (v25.Big and "Big" or nil);
    local v27 = u11.RollRainbow(p24) and "Rainbow" or nil;
    return {
        PetName = v25.PetName,
        Size = v26,
        Type = v27
    };
end;
return u11;