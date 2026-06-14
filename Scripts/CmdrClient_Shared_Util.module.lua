-- Decompiled with Potassium's decompiler.

local l__TextService__1 = game:GetService("TextService");
local u26 = {
    MakeDictionary = function(p1) --[[ Name: MakeDictionary, Line 6 ]]
        local v2 = {};
        for v3 = 1, #p1 do
            v2[p1[v3]] = true;
        end;
        return v2;
    end,
    DictionaryKeys = function(p4) --[[ Name: DictionaryKeys, Line 17 ]]
        local v5 = {};
        for v6 in pairs(p4) do
            table.insert(v5, v6);
        end;
        return v5;
    end,
    MakeFuzzyFinder = function(p7) --[[ Name: MakeFuzzyFinder, Line 42 ]]
        local u8 = nil;
        local u9 = {};
        if typeof(p7) == "Enum" then
            p7 = p7:GetEnumItems();
        end;
        if typeof(p7) == "Instance" then
            u9 = p7:GetChildren();
            u8 = {};
            for v10 = 1, #u9 do
                u8[v10] = u9[v10].Name;
            end;
        elseif typeof(p7) == "table" then
            if typeof(p7[1]) == "Instance" or (typeof(p7[1]) == "EnumItem" or typeof(p7[1]) == "table" and typeof(p7[1].Name) == "string") then
                u8 = {};
                u9 = p7;
                for v11 = 1, #p7 do
                    u8[v11] = u9[v11].Name;
                    p7 = u9;
                    u9 = p7;
                end;
            elseif type(p7[1]) == "string" then
                u8 = p7;
            elseif p7[1] == nil then
                u8 = {};
            else
                error("MakeFuzzyFinder only accepts tables of instances or strings.");
            end;
        else
            error("MakeFuzzyFinder only accepts a table, Enum, or Instance.");
        end;
        return function(p12, p13) --[[ Line: 70 ]]
            -- upvalues: u8 (ref), u9 (ref)
            local v14 = {};
            for v15, v16 in pairs(u8) do
                local v17;
                if u9 then
                    v17 = u9[v15] or v16;
                else
                    v17 = v16;
                end;
                if v16:lower() == p12:lower() then
                    if p13 then
                        return v17;
                    end;
                    table.insert(v14, 1, v17);
                elseif v16:lower():find(p12:lower(), 1, true) then
                    v14[#v14 + 1] = v17;
                end;
            end;
            if p13 then
                return v14[1];
            else
                return v14;
            end;
        end;
    end,
    GetNames = function(p18) --[[ Name: GetNames, Line 98 ]]
        local v19 = {};
        for v20 = 1, #p18 do
            v19[v20] = p18[v20].Name or tostring(p18[v20]);
        end;
        return v19;
    end,
    SplitStringSimple = function(p21, p22) --[[ Name: SplitStringSimple, Line 109 ]]
        local v23 = {};
        local v24 = 1;
        for v25 in string.gmatch(p21, "([^" .. (p22 == nil and "%s" or p22) .. "]+)") do
            v23[v24] = v25;
            v24 = v24 + 1;
        end;
        return v23;
    end
};
local function u28(p27) --[[ Line: 122 ]]
    return utf8.char((tonumber(p27, 16)));
end;
function u26.ParseEscapeSequences(p29) --[[ Line: 127 ]]
    -- upvalues: u28 (copy)
    return p29:gsub("\\(.)", {
        t = "\t",
        n = "\n"
    }):gsub("\\u(%x%x%x%x)", u28):gsub("\\x(%x%x)", u28);
end;
function u26.EncodeEscapedOperator(p30, p31) --[[ Line: 136 ]]
    local v32 = p31:sub(1, 1);
    local v33 = p31:gsub(".", "%%%1");
    return p30:gsub("(" .. ("%" .. v32) .. "+)(" .. v33 .. ")", function(p34, p35) --[[ Line: 141 ]]
        return (p34:sub(1, #p34 - 1) .. p35):gsub(".", function(p36) --[[ Line: 142 ]]
            return "\\u" .. string.format("%04x", string.byte(p36), 16);
        end);
    end);
end;
local u37 = { "&&", "||", ";" };
function u26.EncodeEscapedOperators(p38) --[[ Line: 149 ]]
    -- upvalues: u37 (copy), u26 (copy)
    for _, v39 in ipairs(u37) do
        p38 = u26.EncodeEscapedOperator(p38, v39);
    end;
    return p38;
end;
function u26.SplitString(p40, p41) --[[ Line: 177 ]]
    -- upvalues: u26 (copy)
    local v42 = nil;
    local v43 = nil;
    local v44 = {};
    local v45 = p41 or (1 / 0);
    for v46 in p40:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"):gmatch("[^ ]+") do
        local v47 = u26.ParseEscapeSequences(v46);
        local v48 = v47:match("^([\'\"])");
        local v49 = v47:match("([\'\"])$");
        local v50 = v47:match("(\\*)[\'\"]$");
        if v48 and not (v42 or v49) then
            v42 = v48;
            v43 = v47;
        elseif v43 and (v49 == v42 and #v50 % 2 == 0) then
            v47 = v43 .. " " .. v47;
            v43 = nil;
            v42 = nil;
        elseif v43 then
            v43 = v43 .. " " .. v47;
        end;
        if not v43 then
            v44[#v44 + (v45 < #v44 and 0 or 1)] = v47:gsub("^([\'\"])", ""):gsub("([\'\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
        end;
    end;
    if v43 then
        v44[#v44 + (v45 < #v44 and 0 or 1)] = v43:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
    end;
    return v44;
end;
function u26.MashExcessArguments(p51, p52) --[[ Line: 209 ]]
    local v53 = {};
    for v54 = 1, #p51 do
        if p52 < v54 then
            v53[p52] = ("%s %s"):format(v53[p52] or "", p51[v54]);
        else
            v53[v54] = p51[v54];
        end;
    end;
    return v53;
end;
function u26.TrimString(p55) --[[ Line: 222 ]]
    local _, v56 = string.find(p55, "^%s*");
    return v56 == #p55 and "" or string.match(p55, ".*%S", v56 + 1);
end;
function u26.GetTextSize(p57, p58, p59) --[[ Line: 229 ]]
    -- upvalues: l__TextService__1 (copy)
    return l__TextService__1:GetTextSize(p57, p58.TextSize, p58.Font, p59 or Vector2.new(p58.AbsoluteSize.X, 0));
end;
function u26.MakeEnumType(u60, p61) --[[ Line: 234 ]]
    -- upvalues: u26 (copy)
    local u62 = u26.MakeFuzzyFinder(p61);
    return {
        Validate = function(p63) --[[ Name: Validate, Line 237 ]]
            -- upvalues: u62 (copy), u60 (copy)
            return u62(p63, true) ~= nil, ("Value %q is not a valid %s."):format(p63, u60);
        end,
        Autocomplete = function(p64) --[[ Name: Autocomplete, Line 240 ]]
            -- upvalues: u62 (copy), u26 (ref)
            local v65 = u62(p64);
            if type(v65[1]) ~= "string" then
                v65 = u26.GetNames(v65) or v65;
            end;
            return v65;
        end,
        Parse = function(p66) --[[ Name: Parse, Line 244 ]]
            -- upvalues: u62 (copy)
            return u62(p66, true);
        end
    };
end;
function u26.ParsePrefixedUnionType(p67, p68) --[[ Line: 251 ]]
    -- upvalues: u26 (copy)
    local v69 = u26.SplitStringSimple(p67);
    local v70 = {};
    for v71 = 1, #v69, 2 do
        v70[#v70 + 1] = {
            prefix = v69[v71 - 1] or "",
            type = v69[v71]
        };
    end;
    table.sort(v70, function(p72, p73) --[[ Line: 265 ]]
        return #p72.prefix > #p73.prefix;
    end);
    for v74 = 1, #v70 do
        local v75 = v70[v74];
        if p68:sub(1, #v75.prefix) == v75.prefix then
            return v75.type, p68:sub(#v75.prefix + 1), v75.prefix;
        end;
    end;
end;
function u26.MakeListableType(u76, p77) --[[ Line: 280 ]]
    local v78 = {
        Listable = true,
        Transform = u76.Transform,
        Validate = u76.Validate,
        ValidateOnce = u76.ValidateOnce,
        Autocomplete = u76.Autocomplete,
        Default = u76.Default,
        ArgumentOperatorAliases = u76.ArgumentOperatorAliases,
        Parse = function(...) --[[ Name: Parse, Line 289 ]]
            -- upvalues: u76 (copy)
            return { u76.Parse(...) };
        end
    };
    if p77 then
        for v79, v80 in pairs(p77) do
            v78[v79] = v80;
        end;
    end;
    return v78;
end;
function u26.RunCommandString(p81, p82) --[[ Line: 311 ]]
    -- upvalues: u26 (copy)
    local v83 = u26.ParseEscapeSequences(p82);
    local v84 = u26.EncodeEscapedOperators(v83):split("&&");
    local v85 = "";
    for v86, v87 in ipairs(v84) do
        local v88 = v85:gsub("%$", "\\x24"):gsub("%%", "%%%%");
        local v89 = "||";
        if v85:find("%s") then
            v88 = ("%q"):format(v88) or v88;
        end;
        local v90 = v87:gsub(v89, v88);
        local v91 = u26.RunEmbeddedCommands(p81, v90);
        v85 = tostring(p81:EvaluateAndRun(v91));
        if v86 == #v84 then
            return v85;
        end;
    end;
end;
function u26.RunEmbeddedCommands(p92, p93) --[[ Line: 338 ]]
    -- upvalues: u26 (copy)
    local v94 = p93:gsub("\\%$", "___!CMDR_DOLLAR!___");
    local v95 = {};
    for v96 in v94:gmatch("$(%b{})") do
        local v97 = v96:sub(2, #v96 - 1);
        local v98;
        if v97:match("^{.+}$") then
            v97 = v97:sub(2, #v97 - 1);
            v98 = false;
        else
            v98 = true;
        end;
        v95[v96] = u26.RunCommandString(p92, v97);
        if v98 and (v95[v96]:find("%s") or v95[v96] == "") then
            v95[v96] = string.format("%q", v95[v96]);
        end;
    end;
    return v94:gsub("$(%b{})", v95):gsub("___!CMDR_DOLLAR!___", "$");
end;
function u26.SubstituteArgs(p99, p100) --[[ Line: 366 ]]
    local v101 = p99:gsub("\\%$", "___!CMDR_DOLLAR!___");
    if type(p100) == "table" then
        for v102 = 1, #p100 do
            local v103 = tostring(v102);
            p100[v103] = p100[v102];
            if p100[v103]:find("%s") then
                p100[v103] = string.format("%q", p100[v103]);
            end;
        end;
    end;
    return v101:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", p100):gsub("___!CMDR_DOLLAR!___", "$");
end;
function u26.MakeAliasCommand(p104, p105) --[[ Line: 383 ]]
    -- upvalues: u26 (copy)
    local v106, v107 = unpack(p104:split("|"));
    local u108 = u26.EncodeEscapedOperators(p105);
    local v109 = {};
    local v110 = {};
    for v111 in u108:gmatch("$(%d+)") do
        if v109[v111] == nil then
            v109[v111] = true;
            local v112 = u108:match((`${v111}(%b\{})`));
            local v113, v114, v115;
            if v112 then
                local v116 = v112:sub(2, #v112 - 1);
                v113, v114, v115 = unpack(v116:split("|"));
            else
                v113 = nil;
                v114 = nil;
                v115 = nil;
            end;
            local v117;
            if v113 then
                v117 = v113:match("%?$") and true or false;
            else
                v117 = v113;
            end;
            local v118 = not v113 and "string" or v113:match("^%w+");
            local v119 = v114 or `Argument {v111}`;
            table.insert(v110, {
                Type = v118,
                Name = v119,
                Description = v115 or "",
                Optional = v117
            });
        end;
    end;
    return {
        Group = "UserAlias",
        Name = v106,
        Aliases = {},
        Description = `<Alias> {v107 or u108}`,
        Args = v110,
        Run = function(p120) --[[ Name: Run, Line 422 ]]
            -- upvalues: u26 (ref), u108 (ref)
            return u26.RunCommandString(p120.Dispatcher, u26.SubstituteArgs(u108, p120.RawArguments));
        end
    };
end;
function u26.MakeSequenceType(p121) --[[ Line: 429 ]]
    -- upvalues: u26 (copy)
    local u122 = p121 or {};
    assert(u122.Parse ~= nil and true or u122.Constructor ~= nil, "MakeSequenceType: Must provide one of: Constructor, Parse");
    u122.TransformEach = u122.TransformEach or function(...) --[[ Line: 434 ]]
        return ...;
    end;
    u122.ValidateEach = u122.ValidateEach or function() --[[ Line: 438 ]]
        return true;
    end;
    return {
        Prefixes = u122.Prefixes,
        Transform = function(p123) --[[ Name: Transform, Line 445 ]]
            -- upvalues: u26 (ref), u122 (ref)
            return u26.Map(u26.SplitPrioritizedDelimeter(p123, { ",", "%s" }), function(p124) --[[ Line: 446 ]]
                -- upvalues: u122 (ref)
                return u122.TransformEach(p124);
            end);
        end,
        Validate = function(p125) --[[ Name: Validate, Line 451 ]]
            -- upvalues: u122 (ref)
            if u122.Length and #p125 > u122.Length then
                return false, ("Maximum of %d values allowed in sequence"):format(u122.Length);
            end;
            for v126 = 1, u122.Length or #p125 do
                local v127, v128 = u122.ValidateEach(p125[v126], v126);
                if not v127 then
                    return false, v128;
                end;
            end;
            return true;
        end,
        Parse = u122.Parse or function(p129) --[[ Line: 467 ]]
            -- upvalues: u122 (ref)
            return u122.Constructor(unpack(p129));
        end
    };
end;
function u26.SplitPrioritizedDelimeter(p130, p131) --[[ Line: 475 ]]
    -- upvalues: u26 (copy)
    for v132, v133 in ipairs(p131) do
        if p130:find(v133) or v132 == #p131 then
            return u26.SplitStringSimple(p130, v133);
        end;
    end;
end;
function u26.Map(p134, p135) --[[ Line: 484 ]]
    local v136 = {};
    for v137, v138 in ipairs(p134) do
        v136[v137] = p135(v138, v137);
    end;
    return v136;
end;
function u26.Each(p139, ...) --[[ Line: 495 ]]
    local v140 = {};
    for v141, v142 in ipairs({ ... }) do
        v140[v141] = p139(v142);
    end;
    return unpack(v140);
end;
function u26.EmulateTabstops(p143, p144) --[[ Line: 504 ]]
    local v145 = #p143;
    local v146 = table.create(v145);
    local v147 = 0;
    for v148 = 1, v145 do
        local v149 = string.sub(p143, v148, v148);
        if v149 == "\t" then
            local v150 = p144 - v147 % p144;
            table.insert(v146, string.rep(" ", v150));
            v147 = v147 + v150;
        else
            table.insert(v146, v149);
            if v149 == "\n" then
                v147 = 0;
            elseif v149 ~= "\r" then
                v147 = v147 + 1;
            end;
        end;
    end;
    return table.concat(v146);
end;
function u26.Mutex() --[[ Line: 526 ]]
    local u151 = {};
    local u152 = false;
    return function() --[[ Line: 530 ]]
        -- upvalues: u152 (ref), u151 (copy)
        if u152 then
            table.insert(u151, coroutine.running());
            coroutine.yield();
        else
            u152 = true;
        end;
        return function() --[[ Line: 538 ]]
            -- upvalues: u151 (ref), u152 (ref)
            if #u151 > 0 then
                coroutine.resume(table.remove(u151, 1));
            else
                u152 = false;
            end;
        end;
    end;
end;
return u26;