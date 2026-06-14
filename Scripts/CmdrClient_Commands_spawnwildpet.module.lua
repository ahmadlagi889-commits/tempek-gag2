-- Decompiled with Potassium's decompiler.

return {
    Name = "spawnwildpet",
    Description = "Spawn a wild pet of the given species at a random valid spot inside workspace.Map.PetSpawn (or near you with `here`). For testing the SpawnPetService taming flow without waiting for the natural spawn loop.",
    Group = "DefaultAdmin",
    Aliases = { "spawnwildpet", "spawnpet" },
    Args = {
        {
            Type = "string",
            Name = "PetName",
            Description = "Pet species key from PetData (e.g. Raccoon)"
        },
        {
            Type = "positiveInteger",
            Name = "Count",
            Description = "How many to spawn (default 1)",
            Optional = true
        }
    }
};