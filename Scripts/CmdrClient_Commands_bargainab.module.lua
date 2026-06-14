-- Decompiled with Potassium's decompiler.

return {
    Name = "bargainab",
    Description = "Force-enables/disables the A/B-gated Bargain option at Steven (the daily deal lives inside it)",
    Group = "DefaultAdmin",
    Aliases = { "bargainab", "setbargain" },
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "The player(s) to override"
        },
        {
            Type = "boolean",
            Name = "Enabled",
            Description = "true = show Bargain!, false = hide it"
        }
    }
};