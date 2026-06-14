-- Decompiled with Potassium's decompiler.

return {
    Name = "resetdailydeal",
    Description = "Resets a player\'s Steven daily deal cooldown so the 5x sell is available again",
    Group = "DefaultAdmin",
    Aliases = { "resetdailydeal", "cleardailydeal" },
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "The player(s) whose daily deal should be reset"
        }
    }
};