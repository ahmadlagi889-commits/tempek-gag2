-- Decompiled with Potassium's decompiler.

local l__MarketplaceService__1 = game:GetService("MarketplaceService");
local l__Cache__2 = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache);
local l__Asserts__3 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local v1 = l__Asserts__3.TablePermissive({
    PurchaseId = l__Asserts__3.String,
    PlayerId = l__Asserts__3.Integer,
    ProductId = l__Asserts__3.Integer,
    PlaceIdWherePurchased = l__Asserts__3.Integer,
    CurrencySpent = l__Asserts__3.IntegerNonNegative,
    CurrencyType = l__Asserts__3.AnyOf(l__Asserts__3.Enum(Enum.CurrencyType), l__Asserts__3.String),
    ProductPurchaseChannel = l__Asserts__3.Enum(Enum.ProductPurchaseChannel)
});
local u2 = l__Asserts__3.Table({
    AssetId = l__Asserts__3.Integer,
    InfoType = l__Asserts__3.Enum(Enum.InfoType)
});
local u5 = l__Cache__2.new({
    Callback = function(p3) --[[ Name: Callback, Line 160 ]]
        -- upvalues: l__MarketplaceService__1 (copy)
        return l__MarketplaceService__1:GetProductInfo(p3.AssetId, p3.InfoType);
    end,
    AssertKey = function(p4) --[[ Name: AssertKey, Line 163 ]]
        -- upvalues: u2 (copy)
        u2(p4);
        return `{p4.AssetId},{p4.InfoType.Value}`;
    end
});
return table.freeze({
    AssertReceiptInfo = v1,
    GetInfoAsync = function(p6, p7, p8) --[[ Name: GetInfoAsync, Line 173 ]]
        -- upvalues: l__Asserts__3 (copy), u5 (copy)
        l__Asserts__3.Integer(p6);
        l__Asserts__3.Enum(Enum.InfoType)(p7);
        l__Asserts__3.Optional(l__Asserts__3.Boolean)(p8);
        local v9 = {
            AssetId = p6,
            InfoType = p7
        };
        if p8 then
            return u5:Get(v9);
        else
            return u5:GetAsync(v9);
        end;
    end
});