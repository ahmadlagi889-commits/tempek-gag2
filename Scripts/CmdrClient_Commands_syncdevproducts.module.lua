-- Decompiled with Potassium's decompiler.

return {
    Name = "syncdevproducts",
    Description = "Sync developer products to Roblox via Open Cloud and store mapping in DataStore",
    Group = "DefaultAdmin",
    Aliases = { "syncdevproducts" },
    Args = {
        {
            Type = "string",
            Name = "PlaceId",
            Description = "Place id, \"dev\", or \"prod\" — must be in the universe this server is running in (cross-universe sync is not allowed)"
        }
    }
};