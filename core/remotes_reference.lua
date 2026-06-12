--[[
    GAG Hub - Remote Events Reference
    All known remotes from decompiled GAG client scripts.
    Use this to update Net.fire() calls when game patches.
    
    Format: Category.RemoteName -- description
    Updated: 2026-06-13
]]

return {
    -------------------------------------------------------
    -- GARDEN SYSTEM
    -------------------------------------------------------
    Garden = {
        -- Client → Server (Fire)
        CollectFruit    = "Garden.CollectFruit",      -- (plantId, fruitId)
        PotPlant        = "Garden.PotPlant",           -- (seedName)
        RequestGardens  = "Garden.RequestGardens",     -- ()
        RequestGrowAllData       = "Garden.RequestGrowAllData",
        RequestOfflineGrowthData = "Garden.RequestOfflineGrowthData",

        -- Server → Client (OnClientEvent)
        SyncAllGardens          = "Garden.SyncAllGardens",
        PlantAdded              = "Garden.PlantAdded",           -- (plantId, data, plotId)
        PlantRemoved            = "Garden.PlantRemoved",         -- (plantId, plotId)
        PlantGrowthUpdated      = "Garden.PlantGrowthUpdated",   -- (plantId, growth, size, mutation)
        PlantAgeSync            = "Garden.PlantAgeSync",         -- (plantId, age)
        PlantMutationUpdated    = "Garden.PlantMutationUpdated", -- (plantId, mutation)
        FruitAdded              = "Garden.FruitAdded",           -- (plantId, fruitId, fruitName, data)
        FruitRemoved            = "Garden.FruitRemoved",
        FruitGrowthUpdated      = "Garden.FruitGrowthUpdated",
        FruitAgeSync            = "Garden.FruitAgeSync",
        FruitMutationUpdated    = "Garden.FruitMutationUpdated",
        FruitOvertimeGrowthUpdated = "Garden.FruitOvertimeGrowthUpdated",
        SprinklerAdded          = "Garden.SprinklerAdded",
        SprinklerRemoved        = "Garden.SprinklerRemoved",
        RakeAdded               = "Garden.RakeAdded",
        RakeRemoved             = "Garden.RakeRemoved",
        PlantPotted             = "Garden.PlantPotted",
        PlantReviveProgressUpdated = "Garden.PlantReviveProgressUpdated",
        GrowAllStarting         = "Garden.GrowAllStarting",
        GrowAllComplete         = "Garden.GrowAllComplete",
        GrowAllStartingForObserver = "Garden.GrowAllStartingForObserver",
        GrowAllCompleteForObserver = "Garden.GrowAllCompleteForObserver",
        PlantLifecycleUpdated   = "Garden.PlantLifecycleUpdated",
    },

    -------------------------------------------------------
    -- SELLING (NPCS)
    -------------------------------------------------------
    NPCS = {
        SellAll           = "NPCS.SellAll",
        SellFruit         = "NPCS.SellFruit",         -- (fruitName)
        SellPet           = "NPCS.SellPet",
        UseDailyDealAll   = "NPCS.UseDailyDealAll",
        UseDailyDealSingle = "NPCS.UseDailyDealSingle",
    },

    -------------------------------------------------------
    -- EGGS
    -------------------------------------------------------
    Egg = {
        OpenEgg           = "Egg.OpenEgg",            -- (eggName)
        ConfirmEgg        = "Egg.ConfirmEgg",          -- (eggName, petName, rarity)
        ReplicateOpenEgg  = "Egg.ReplicateOpenEgg",   -- (player, eggName, petName, rarity, pos, str1, str2)
    },

    -------------------------------------------------------
    -- SEED PACKS
    -------------------------------------------------------
    SeedPack = {
        OpenSeedPack          = "SeedPack.OpenSeedPack",
        ClickPack             = "SeedPack.ClickPack",
        ConfirmSeedPack       = "SeedPack.ConfirmSeedPack",
        ReplicateOpenSeedPack = "SeedPack.ReplicateOpenSeedPack",
    },

    -------------------------------------------------------
    -- CRATES
    -------------------------------------------------------
    Crate = {
        OpenCrate           = "Crate.OpenCrate",
        ReplicateOpenCrate  = "Crate.ReplicateOpenCrate",
    },

    -------------------------------------------------------
    -- PLANTING
    -------------------------------------------------------
    Plant = {
        PlantSeed = "Plant.PlantSeed",  -- (seedName, position)
        PlantFx   = "Plant.PlantFx",
    },

    -------------------------------------------------------
    -- BACKPACK / INVENTORY
    -------------------------------------------------------
    Backpack = {
        GetLayout         = "Backpack.GetLayout",
        SaveLayout        = "Backpack.SaveLayout",
        PromoteFruit      = "Backpack.PromoteFruit",      -- (fruitName)
        DemoteFruit       = "Backpack.DemoteFruit",        -- (fruitName)
        SetFruitFavorite  = "Backpack.SetFruitFavorite",   -- (fruitName, bool)
    },

    -------------------------------------------------------
    -- DROPPED ITEMS
    -------------------------------------------------------
    DroppedItem = {
        RequestDrop  = "DroppedItem.RequestDrop",  -- (itemName, amount)
        PickupFx     = "DroppedItem.PickupFx",
    },

    -------------------------------------------------------
    -- GIFTING
    -------------------------------------------------------
    Gifting = {
        Send = "Gifting.Send",  -- (userId, itemType, itemUuid)
    },

    -------------------------------------------------------
    -- TOOLS
    -------------------------------------------------------
    WateringCan = {
        UseWateringCan = "WateringCan.UseWateringCan",  -- (position)
        WateringCanFx  = "WateringCan.WateringCanFx",
    },

    Trowel = {
        MovePlant    = "Trowel.MovePlant",
        MoveRejected = "Trowel.MoveRejected",
    },

    FreezeRay = {
        Fire      = "FreezeRay.Fire",
        FreezeFx  = "FreezeRay.FreezeFx",
    },

    PowerHose = {
        Activate     = "PowerHose.Activate",
        KnockbackFx  = "PowerHose.KnockbackFx",
    },

    VineWrapper = {
        Activate         = "VineWrapper.Activate",
        AssignTarget     = "VineWrapper.AssignTarget",
        SendVisual       = "VineWrapper.SendVisual",
        WrapCharacter    = "VineWrapper.WrapCharacter",
        UnwrapCharacter  = "VineWrapper.UnwrapCharacter",
    },

    Flashbang = {
        Detonate   = "Flashbang.Detonate",
        Flashbang  = "Flashbang.Flashbang",
    },

    Crowbar = {
        SwingCrowbar = "Crowbar.SwingCrowbar",
        PryDoor      = "Crowbar.PryDoor",
        HitPlayer    = "Crowbar.HitPlayer",
        DoorForced   = "Crowbar.DoorForced",
    },

    -------------------------------------------------------
    -- PLACEMENT
    -------------------------------------------------------
    Place = {
        PlaceSprinkler  = "Place.PlaceSprinkler",
        PlaceBird       = "Place.PlaceBird",
        PlaceLadder     = "Place.PlaceLadder",
        PlaceRake       = "Place.PlaceRake",
        PlaceGnome      = "Place.PlaceGnome",
        PlaceTeleporter = "Place.UseTeleporter",
        RakeActivated   = "Place.RakeActivated",
        TeleportedBack  = "Place.TeleportedBack",
    },

    Prop = {
        PlaceProp        = "Prop.PlaceProp",
        SetPropExtraData = "Prop.SetPropExtraData",
        PropPlaced       = "Prop.PropPlaced",
        PropRemoved      = "Prop.PropRemoved",
        PropExtraDataUpdated = "Prop.PropExtraDataUpdated",
    },

    PotPlacement = {
        PlacePottedPlant  = "PotPlacement.PlacePottedPlant",
        PickUpPottedPlant = "PotPlacement.PickUpPottedPlant",
        PottedPlantPlaced = "PotPlacement.PottedPlantPlaced",
    },

    -------------------------------------------------------
    -- PETS
    -------------------------------------------------------
    Pets = {
        GetEquippedPets       = "Pets.GetEquippedPets",
        PetEquipped           = "Pets.PetEquipped",
        PetUnequipped         = "Pets.PetUnequipped",
        RequestEquipByName    = "Pets.RequestEquipByName",
        RequestUnequip        = "Pets.RequestUnequip",
        RequestUnequipByName  = "Pets.RequestUnequipByName",
        RequestPurchasePetSlot = "Pets.RequestPurchasePetSlot",
        RequestToggleFollower = "Pets.RequestToggleFollower",
        FrogJump              = "Pets.FrogJump",
        SnapPetsBroadcast     = "Pets.SnapPetsBroadcast",
        WildPetTame           = "Pets.WildPetTame",
        WildPetCollected      = "Pets.WildPetCollected",
        WildPetTameResult     = "Pets.WildPetTameResult",
    },

    -------------------------------------------------------
    -- GUILD
    -------------------------------------------------------
    Guild = {
        CreateGuild            = "Guild.CreateGuild",
        EditGuild              = "Guild.EditGuild",
        Leave                  = "Guild.Leave",
        Kick                   = "Guild.Kick",
        Invite                 = "Guild.Invite",
        Promote                = "Guild.Promote",
        Demote                 = "Guild.Demote",
        GetMyGuild             = "Guild.GetMyGuild",
        GetGuildById           = "Guild.GetGuildById",
        GetLeaderboard         = "Guild.GetLeaderboard",
        GetCompetition         = "Guild.GetCompetition",
        GetOnlineMembers       = "Guild.GetOnlineMembers",
        CheckCreateAvailability = "Guild.CheckCreateAvailability",
        TickUpdate             = "Guild.TickUpdate",
    },

    -------------------------------------------------------
    -- WEATHER
    -------------------------------------------------------
    WeatherEffects = {
        BloodmoonBeam     = "WeatherEffects.BloodmoonBeam",
        RainbowStart      = "WeatherEffects.RainbowStart",
        RainbowEnd        = "WeatherEffects.RainbowEnd",
        GoldMoonStrike    = "WeatherEffects.GoldMoonStrike",
        RainbowMoonStrike = "WeatherEffects.RainbowMoonStrike",
        BlizzardStart     = "WeatherEffects.BlizzardStart",
        BlizzardEnd       = "WeatherEffects.BlizzardEnd",
        BlizzardBeam      = "WeatherEffects.BlizzardBeam",
        ShootingStar      = "WeatherEffects.ShootingStar",
        ChainPull         = "WeatherEffects.ChainPull",
        Reticule          = "WeatherEffects.Reticule",
    },

    WeatherMachine = {
        PlayerEntered = "WeatherMachine.PlayerEntered",
        PlayerExited  = "WeatherMachine.PlayerExited",
    },

    -------------------------------------------------------
    -- ANTI-AFK
    -------------------------------------------------------
    AntiAfk = {
        RequestHop = "AntiAfk.RequestHop",
    },

    -------------------------------------------------------
    -- MAILBOX
    -------------------------------------------------------
    Mailbox = {
        OpenInbox = "Mailbox.OpenInbox",
        Updated   = "Mailbox.Updated",
    },

    -------------------------------------------------------
    -- EXCLUSIVE SHOP
    -------------------------------------------------------
    ExclusiveShop = {
        DealUpdate = "ExclusiveShop.DealUpdate",
    },

    -------------------------------------------------------
    -- DEV PRODUCTS / PURCHASES
    -------------------------------------------------------
    DevProducts = {
        SetGiftTarget       = "DevProducts.SetGiftTarget",
        PurchaseWithTokens  = "DevProducts.PurchaseWithTokens",
        GamepassPurchased   = "DevProducts.GamepassPurchased",
        InstantGrant        = "DevProducts.InstantGrant",
        InstantGrantGamepass = "DevProducts.InstantGrantGamepass",
    },

    -------------------------------------------------------
    -- MISC
    -------------------------------------------------------
    ShecklePop = {
        SheckleCollect = "ShecklePop.SheckleCollect",
        PlayerDeath    = "ShecklePop.PlayerDeath",
    },

    ReturnNearestFruit = {
        ReturnNearestFruit = "ReturnNearestFruit.ReturnNearestFruit",
    },

    ObjectPositionService = {
        CreateServerValue = "ObjectPositionService.CreateServerValue",
    },

    Actions = {
        ExpandGarden = "Actions.ExpandGarden",
    },

    Mushrooms = {
        PlayFX          = "Mushrooms.PlayFX",
        SetInvisibility = "Mushrooms.SetInvisiblity",
    },

    -- Gear shop equip state
    GearShop = {
        GearEquipState       = "GearShop.GearEquipState",
        RequestEquippableState = "GearShop.RequestEquippableState",
    },

    -- Bears, bees, birds, etc.
    BearTrap = {
        BearTrap = "BearTrap.BearTrap",
        Closed   = "BearTrap.Closed",
        Reset    = "BearTrap.Reset",
    },

    Bee = {
        Sting = "Bee.Sting",
    },

    Bird = {
        Positions   = "Bird.Positions",
        FruitEaten  = "Bird.FruitEaten",
        SeedDropped = "Bird.SeedDropped",
    },

    BlackDragon = {
        BreathStart = "BlackDragon.BreathStart",
        Ignite      = "BlackDragon.Ignite",
    },

    IceSerpent = {
        BreathStart = "IceSerpent.BreathStart",
    },

    -- Seats / fun items
    FakeSeat = {
        RequestState = "FakeSeat.RequestState",
        SeatChanged  = "FakeSeat.SeatChanged",
        Sit          = "FakeSeat.Sit",
        Unsit        = "FakeSeat.Unsit",
    },

    Seesaw = {
        RequestState = "Seesaw.RequestState",
        SeatChanged  = "Seesaw.SeatChanged",
        Sit          = "Seesaw.Sit",
        Unsit        = "Seesaw.Unsit",
    },

    Carpet = {
        Activated     = "Carpet.Activated",
        Equip         = "Carpet.Equip",
        Unequip       = "Carpet.Unequip",
        PlayAnimation = "Carpet.PlayAnimation",
        StopAnimation = "Carpet.StopAnimation",
    },

    -- Sign
    SignTool = {
        SetSignText = "SignTool.SetSignText",
    },

    -- Raccoon
    Raccoon = {
        RaccoonWalkToPoint = "Raccoon.RaccoonWalkToPoint",
    },

    -- Tutorial
    Tutorial = {
        Ready = "Tutorial.Ready",
        Start = "Tutorial.Start",
    },

    -- Flash
    Flash = {
        Flash = "Flash.Flash",
    },

    -- Flytrap
    FlytrapService = {
        Chomp = "FlytrapService.Chomp",
    },

    -- Spring
    Spring = {
        SpringFire   = "Spring.SpringFire",
        SpringReload = "Spring.SpringReload",
    },

    -- SFX
    SFX = {
        OwlHoot = "SFX.OwlHoot",
    },

    -- PlayCutscene
    PlayCutscene = {
        OnClientEvent = "PlayCutscene.OnClientEvent",
    },

    -- Notification
    Notification = {
        OnClientEvent = "Notification.OnClientEvent",
    },

    -- HelperRequest
    HelperRequest = {
        OnClientEvent = "HelperRequest.OnClientEvent",
    },

    -- SeedPackSpawn
    SeedPackSpawn = {
        FX      = "SeedPackSpawn.FX",
        Claimed = "SeedPackSpawn.Claimed",
    },

    -- Ragdoll
    Ragdoll = {
        Enable        = "Ragdoll.Enable",
        Disable       = "Ragdoll.Disable",
        EnableForRig  = "Ragdoll.EnableForRig",
        DisableForRig = "Ragdoll.DisableForRig",
        StartRagdoll  = "Ragdoll.StartRagdoll",
        StopRagdoll   = "Ragdoll.StopRagdoll",
    },
}
