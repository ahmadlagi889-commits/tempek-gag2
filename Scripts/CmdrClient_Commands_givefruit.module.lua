-- Decompiled with Potassium's decompiler.

return {
    Name = "givefruit",
    Description = "Gives a harvested fruit to a player\'s inventory",
    Group = "DefaultAdmin",
    Aliases = { "givefruit", "givecrop" },
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "The player(s) to give the fruit to"
        },
        {
            Type = "fruitName",
            Name = "FruitName",
            Description = "The name of the fruit"
        },
        {
            Type = "number",
            Name = "Weight",
            Description = "The weight of the fruit in grams (default uses base weight)",
            Optional = true
        },
        {
            Type = "mutationName",
            Name = "Mutation",
            Description = "The mutation to apply (default None)",
            Optional = true
        },
        {
            Type = "positiveInteger",
            Name = "Seed",
            Description = "RNG seed for fruit appearance (default random)",
            Optional = true
        }
    }
};