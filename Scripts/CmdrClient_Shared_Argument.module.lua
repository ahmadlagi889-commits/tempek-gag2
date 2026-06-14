-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Util);
local function u3(p1) --[[ Line: 3 ]]
    for _, v2 in ipairs({
        "%.",
        "%?",
        "%*",
        "%*%*"
    }) do
        p1 = p1:gsub("\\" .. v2, v2:gsub("%%", ""));
    end;
    return p1;
end;
local u4 = {};
u4.__index = u4;
function u4.new(p5, p6, p7) --[[ Line: 15 ]]
    -- upvalues: l__Util__1 (copy), u4 (copy)
    local v8 = {
        Type = nil,
        Prefix = "",
        TextSegmentInProgress = "",
        RawSegmentsAreAutocomplete = false,
        Command = p5,
        Name = p6.Name,
        Object = p6
    };
    local v9;
    if p6.Default == nil then
        v9 = p6.Optional ~= true;
    else
        v9 = false;
    end;
    v8.Required = v9;
    v8.Executor = p5.Executor;
    v8.RawValue = p7;
    v8.RawSegments = {};
    v8.TransformedValues = {};
    if type(p6.Type) == "table" then
        v8.Type = p6.Type;
    else
        local v10, v11, v12 = l__Util__1.ParsePrefixedUnionType(p5.Cmdr.Registry:GetTypeName(p6.Type), p7);
        v8.Type = p5.Dispatcher.Registry:GetType(v10);
        v8.RawValue = v11;
        v8.Prefix = v12;
        if v8.Type == nil then
            error(string.format("%s has an unregistered type %q", v8.Name or "<none>", v10 or "<none>"));
        end;
    end;
    setmetatable(v8, u4);
    v8:Transform();
    return v8;
end;
function u4.GetDefaultAutocomplete(p13) --[[ Line: 55 ]]
    if not p13.Type.Autocomplete then
        return {};
    end;
    local v14, v15 = p13.Type.Autocomplete(p13:TransformSegment(""));
    return v14, v15 or {};
end;
function u4.Transform(p16) --[[ Line: 67 ]]
    -- upvalues: u3 (copy), l__Util__1 (copy)
    if #p16.TransformedValues == 0 then
        local l__RawValue__2 = p16.RawValue;
        if p16.Type.ArgumentOperatorAliases then
            l__RawValue__2 = p16.Type.ArgumentOperatorAliases[l__RawValue__2] or l__RawValue__2;
        end;
        if l__RawValue__2 == "." and p16.Type.Default then
            l__RawValue__2 = p16.Type.Default(p16.Executor) or "";
            p16.RawSegmentsAreAutocomplete = true;
        end;
        if l__RawValue__2 == "?" and p16.Type.Autocomplete then
            local v17, v18 = p16:GetDefaultAutocomplete();
            if not v18.IsPartial and #v17 > 0 then
                l__RawValue__2 = v17[math.random(1, #v17)];
                p16.RawSegmentsAreAutocomplete = true;
            end;
        end;
        if p16.Type.Listable and #p16.RawValue > 0 then
            local v19 = l__RawValue__2:match("^%?(%d+)$");
            if v19 then
                local v20 = tonumber(v19);
                if v20 and v20 > 0 then
                    local v21 = {};
                    local v22, v23 = p16:GetDefaultAutocomplete();
                    if not v23.IsPartial and #v22 > 0 then
                        for _ = 1, math.min(v20, #v22) do
                            table.insert(v21, table.remove(v22, math.random(1, #v22)));
                        end;
                        l__RawValue__2 = table.concat(v21, ",");
                        p16.RawSegmentsAreAutocomplete = true;
                    end;
                end;
            elseif l__RawValue__2 == "*" or l__RawValue__2 == "**" then
                local v24, v25 = p16:GetDefaultAutocomplete();
                if not v25.IsPartial and #v24 > 0 then
                    if l__RawValue__2 == "**" and p16.Type.Default then
                        local v26 = p16.Type.Default(p16.Executor) or "";
                        for v27, v28 in ipairs(v24) do
                            if v28 == v26 then
                                table.remove(v24, v27);
                            end;
                        end;
                    end;
                    l__RawValue__2 = table.concat(v24, ",");
                    p16.RawSegmentsAreAutocomplete = true;
                end;
            end;
            local v29 = u3(l__RawValue__2);
            local v30 = l__Util__1.SplitStringSimple(v29, ",");
            local v31 = #v30 == 0 and { "" } or v30;
            if v29:sub(#v29, #v29) == "," then
                v31[#v31 + 1] = "";
            end;
            for v32, v33 in ipairs(v31) do
                p16.RawSegments[v32] = v33;
                p16.TransformedValues[v32] = { p16:TransformSegment(v33) };
            end;
            p16.TextSegmentInProgress = v31[#v31];
        else
            local v34 = u3(l__RawValue__2);
            p16.RawSegments[1] = u3(v34);
            p16.TransformedValues[1] = { p16:TransformSegment(v34) };
            p16.TextSegmentInProgress = p16.RawValue;
        end;
    end;
end;
function u4.TransformSegment(p35, p36) --[[ Line: 159 ]]
    if p35.Type.Transform then
        return p35.Type.Transform(p36, p35.Executor);
    else
        return p36;
    end;
end;
function u4.GetTransformedValue(p37, p38) --[[ Line: 168 ]]
    return unpack(p37.TransformedValues[p38]);
end;
function u4.Validate(p39, p40) --[[ Line: 173 ]]
    if p39.RawValue == nil or #p39.RawValue == 0 and p39.Required == false then
        return true;
    end;
    if p39.Required and (p39.RawSegments[1] == nil or #p39.RawSegments[1] == 0) then
        return false, "This argument is required.";
    end;
    if not (p39.Type.Validate or p39.Type.ValidateOnce) then
        return true;
    end;
    for v41 = 1, #p39.TransformedValues do
        if p39.Type.Validate then
            local v42, v43 = p39.Type.Validate(p39:GetTransformedValue(v41));
            if not v42 then
                return v42, v43 or "Invalid value";
            end;
        end;
        if p40 and p39.Type.ValidateOnce then
            local v44, v45 = p39.Type.ValidateOnce(p39:GetTransformedValue(v41));
            if not v44 then
                return v44, v45;
            end;
        end;
    end;
    return true;
end;
function u4.GetAutocomplete(p46) --[[ Line: 208 ]]
    return not p46.Type.Autocomplete and {} or p46.Type.Autocomplete(p46:GetTransformedValue(#p46.TransformedValues));
end;
function u4.ParseValue(p47, p48) --[[ Line: 216 ]]
    if p47.Type.Parse then
        return p47.Type.Parse(p47:GetTransformedValue(p48));
    else
        return p47:GetTransformedValue(p48);
    end;
end;
function u4.GetValue(p49) --[[ Line: 225 ]]
    if #p49.RawValue == 0 and (not p49.Required and p49.Object.Default ~= nil) then
        return p49.Object.Default;
    end;
    if not p49.Type.Listable then
        return p49:ParseValue(1);
    end;
    local v50 = {};
    for v51 = 1, #p49.TransformedValues do
        local v52 = p49:ParseValue(v51);
        if type(v52) ~= "table" then
            error(("Listable types must return a table from Parse (%s)"):format(p49.Type.Name));
        end;
        for _, v53 in pairs(v52) do
            v50[v53] = true;
        end;
    end;
    local v54 = {};
    for v55 in pairs(v50) do
        v54[#v54 + 1] = v55;
    end;
    return v54;
end;
return u4;