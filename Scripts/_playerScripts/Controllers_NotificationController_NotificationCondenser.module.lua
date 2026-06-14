-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.ClientModules.Chalk);
return {
    Rules = {
        YourShopRestock = {
            Key = "YourShopRestock",
            Pattern = "^Your ([%w ]+ Shop) stock has restocked!$",
            Suffix = "stock has restocked!",
            PluralSuffix = "stocks have restocked!"
        }
    },
    GetCondenseKey = function(p1, p2) --[[ Name: GetCondenseKey, Line 52 ]]
        local v3 = p2:gsub("<.->", "");
        for _, v4 in pairs(p1.Rules) do
            local v5 = v3:match(v4.Pattern);
            if v5 then
                local _ = v4.Suffix;
                local v6 = p2:match("^.*(<font.-</font>)%s+.*$");
                local v7 = v6 or p2;
                local v8 = v7:match("^%s*<font[^>]-color=\"([^\"]+)\"[^>]*>.*</font>%s*$") or v7:match("^%s*<font[^>]-color=([^%s>]+)[^>]*>.*</font>%s*$");
                if not v6 then
                    local v9 = p2:match("^%s*<font[^>]-color=\"([^\"]+)\"[^>]*>.*</font>%s*$") or p2:match("^%s*<font[^>]-color=([^%s>]+)[^>]*>.*</font>%s*$");
                    if v9 then
                        v6 = `<font color="{v9}">{v5}</font>`;
                    else
                        v6 = v5;
                    end;
                end;
                return {
                    Rule = v4,
                    Variant = {
                        Plain = v5,
                        Rich = v6,
                        Color = v8
                    }
                };
            end;
        end;
        return nil;
    end,
    BuildCondensedText = function(_, p10, p11, p12) --[[ Name: BuildCondensedText, Line 86 ]]
        table.sort(p10, function(p13, p14) --[[ Line: 87 ]]
            return p13.Plain < p14.Plain;
        end);
        local v15 = true;
        local v16;
        if #p10 > 0 then
            v16 = p10[1].Color;
            for v17 = 2, #p10 do
                if p10[v17].Color ~= v16 then
                    v15 = false;
                    break;
                end;
            end;
        else
            v15 = false;
            v16 = nil;
        end;
        local v18;
        if #p10 == 1 then
            v18 = p10[1].Rich .. " " .. p11;
        elseif #p10 == 2 then
            v18 = p10[1].Rich .. " and " .. p10[2].Rich .. " " .. p12;
        else
            local v19 = {};
            for v20 = 1, #p10 - 1 do
                table.insert(v19, p10[v20].Rich);
            end;
            v18 = table.concat(v19, ", ") .. " and " .. p10[#p10].Rich .. " " .. p12;
        end;
        if v15 and v16 then
            v18 = `<font color="{v16}">{v18}</font>`;
        end;
        return v18;
    end
};