-- Decompiled with Potassium's decompiler.

return {
    Name = "dailydealtime",
    Description = "Shows whether Steven\'s daily deal is available and the time remaining until it resets",
    Group = "DefaultAdmin",
    Aliases = { "dailydealtime", "checkdailydeal", "dailydealstatus" },
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "The player(s) to check"
        }
    }
};