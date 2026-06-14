-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local u1 = {};
local u2 = {
    Common = Color3.fromRGB(170, 170, 170),
    Uncommon = Color3.fromRGB(40, 200, 40),
    Rare = Color3.fromRGB(60, 130, 240),
    Epic = Color3.fromRGB(170, 80, 230),
    Legendary = Color3.fromRGB(245, 200, 60),
    Mythic = Color3.fromRGB(220, 50, 50)
};
local u3 = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 200, 0),
    Color3.fromRGB(0, 100, 255),
    Color3.fromRGB(180, 0, 220)
};
local function u7(p4, p5, p6) --[[ Line: 26 ]]
    return Color3.new(p4.R + (p5.R - p4.R) * p6, p4.G + (p5.G - p4.G) * p6, p4.B + (p5.B - p4.B) * p6);
end;
local function u12(p8) --[[ Line: 30 ]]
    -- upvalues: u3 (copy), u7 (copy)
    local v9 = #u3;
    local v10 = p8 % 1 * v9;
    local v11 = math.floor(v10);
    return u7(u3[v11 + 1], u3[(v11 + 1) % v9 + 1], v10 - v11);
end;
local function u15(p13) --[[ Line: 40 ]]
    -- upvalues: u7 (copy)
    local v14;
    if p13 < 0.5 then
        v14 = p13 * 2;
    else
        v14 = (1 - p13) * 2;
    end;
    return u7(Color3.new(1, 1, 1), Color3.new(0, 0, 0), v14);
end;
local function u19(p16, u17) --[[ Line: 45 ]]
    for _, u18 in p16 do
        if u18 and u18.Parent then
            pcall(function() --[[ Line: 48 ]]
                -- upvalues: u18 (copy), u17 (copy)
                u18.TextColor3 = u17;
            end);
            pcall(function() --[[ Line: 49 ]]
                -- upvalues: u18 (copy), u17 (copy)
                u18.TextStrokeColor3 = u17;
            end);
            pcall(function() --[[ Line: 50 ]]
                -- upvalues: u18 (copy), u17 (copy)
                u18.ImageColor3 = u17;
            end);
        end;
    end;
end;
function u1.GetStaticColor(p20) --[[ Line: 54 ]]
    -- upvalues: u2 (copy), u12 (copy), u15 (copy)
    if u2[p20] then
        return u2[p20];
    elseif p20 == "Super" then
        return u12(0);
    elseif p20 == "Secret" then
        return u15(0);
    else
        return Color3.new(1, 1, 1);
    end;
end;
function u1.RichText(p21, p22) --[[ Line: 65 ]]
    -- upvalues: u3 (copy), u1 (copy)
    if type(p21) ~= "string" or p21 == "" then
        return p21;
    end;
    if p22 == "Super" then
        local v23 = math.max(1, #p21 - 1);
        local v24 = {};
        for v25 = 1, #p21 do
            local v26 = (v25 - 1) / v23;
            local v27 = #u3;
            local v28 = v26 % 1 * v27;
            local v29 = math.floor(v28);
            local v30 = v28 - v29;
            local v31 = u3[v29 + 1];
            local v32 = u3[(v29 + 1) % v27 + 1];
            local v33 = Color3.new(v31.R + (v32.R - v31.R) * v30, v31.G + (v32.G - v31.G) * v30, v31.B + (v32.B - v31.B) * v30);
            local v34 = string.format("#%02X%02X%02X", math.floor(v33.R * 255 + 0.5), math.floor(v33.G * 255 + 0.5), (math.floor(v33.B * 255 + 0.5)));
            local l__format__2 = string.format;
            local v35 = string.sub(p21, v25, v25);
            table.insert(v24, l__format__2("<font color=\"%s\">%s</font>", v34, v35));
        end;
        return table.concat(v24);
    end;
    if p22 ~= "Secret" then
        local l__format__3 = string.format;
        local v36 = u1.GetStaticColor(p22);
        return l__format__3("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v36.R * 255 + 0.5), math.floor(v36.G * 255 + 0.5), (math.floor(v36.B * 255 + 0.5))), p21);
    end;
    local v37 = Color3.fromRGB(240, 240, 240);
    local v38 = Color3.fromRGB(40, 40, 40);
    local v39 = {};
    for v40 = 1, #p21 do
        local v41;
        if v40 % 2 == 1 then
            v41 = v37;
        else
            v41 = v38;
        end;
        local v42 = string.format("#%02X%02X%02X", math.floor(v41.R * 255 + 0.5), math.floor(v41.G * 255 + 0.5), (math.floor(v41.B * 255 + 0.5)));
        local l__format__4 = string.format;
        local v43 = string.sub(p21, v40, v40);
        table.insert(v39, l__format__4("<font color=\"%s\">%s</font>", v42, v43));
    end;
    return table.concat(v39);
end;
function u1.ApplyToLabels(u44, p45) --[[ Line: 92 ]]
    -- upvalues: l__RunService__1 (copy), u19 (copy), u12 (copy), u15 (copy), u1 (copy)
    if #u44 == 0 then
        return function() --[[ Line: 93 ]] end;
    end;
    if p45 == "Super" then
        local u46 = os.clock();
        local u47 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 97 ]]
            -- upvalues: u46 (copy), u19 (ref), u44 (copy), u12 (ref)
            u19(u44, u12((os.clock() - u46) % 3 / 3));
        end);
        return function() --[[ Line: 101 ]]
            -- upvalues: u47 (copy)
            if u47 then
                u47:Disconnect();
            end;
        end;
    end;
    if p45 ~= "Secret" then
        u19(u44, u1.GetStaticColor(p45));
        return function() --[[ Line: 115 ]] end;
    end;
    local u48 = os.clock();
    local u49 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 106 ]]
        -- upvalues: u48 (copy), u19 (ref), u44 (copy), u15 (ref)
        u19(u44, u15((os.clock() - u48) % 1.5 / 1.5));
    end);
    return function() --[[ Line: 110 ]]
        -- upvalues: u49 (copy)
        if u49 then
            u49:Disconnect();
        end;
    end;
end;
return u1;