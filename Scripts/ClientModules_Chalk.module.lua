-- Decompiled with Potassium's decompiler.

local u1 = {
    FONT_COLOR_RGB = {
        Start = "<font color=\"rgb(%s,%s,%s)\">",
        End = "</font>"
    },
    FONT_COLOR_HEX = {
        Start = "<font color=\"#%s\">",
        End = "</font>"
    },
    FONT_SIZE = {
        Start = "<font size=\"%d\">",
        End = "</font>"
    },
    FONT_FACE = {
        Start = "<font face=\"%s\">",
        End = "</font>"
    },
    FONT_FAMILY = {
        Start = "<font family=\"%s\">",
        End = "</font>"
    },
    FONT_WEIGHT = {
        Start = "<font weight=\"%s\">",
        End = "</font>"
    },
    FONT_TRANSPARENCY = {
        Start = "<font transparency=\"%s\">",
        End = "</font>"
    },
    STROKE = {
        Start = "<stroke color=\"#%s\" joins=\"%s\" thickness=\"%s\" transparency=\"%s\">",
        End = "</stroke>"
    },
    BOLD = {
        Start = "<b>",
        End = "</b>"
    },
    ITALIC = {
        Start = "<i>",
        End = "</i>"
    },
    UNDERLINE = {
        Start = "<u>",
        End = "</u>"
    },
    STRIKETHROUGH = {
        Start = "<s>",
        End = "</s>"
    },
    UPPERCASE = {
        Start = "<uppercase>",
        End = "</uppercase>"
    },
    SMALLCAPS = {
        Start = "<smallcaps>",
        End = "</smallcaps>"
    }
};
local u2 = {};
local u3 = {};
u3.__index = u3;
local u4 = {};
local u5 = "FONT_SIZE";
function u4.size(p6) --[[ Line: 93 ]]
    -- upvalues: u1 (copy), u5 (copy)
    local u7 = u1[u5].Start:format(p6);
    return function(p8) --[[ Line: 96 ]]
        -- upvalues: u7 (copy), u1 (ref), u5 (ref)
        return `{u7}{p8}{u1[u5].End}`;
    end;
end;
local u9 = "FONT_FACE";
function u4.face(p10) --[[ Line: 93 ]]
    -- upvalues: u1 (copy), u9 (copy)
    local u11 = u1[u9].Start:format(p10);
    return function(p12) --[[ Line: 96 ]]
        -- upvalues: u11 (copy), u1 (ref), u9 (ref)
        return `{u11}{p12}{u1[u9].End}`;
    end;
end;
local u13 = "FONT_FAMILY";
function u4.family(p14) --[[ Line: 93 ]]
    -- upvalues: u1 (copy), u13 (copy)
    local u15 = u1[u13].Start:format(p14);
    return function(p16) --[[ Line: 96 ]]
        -- upvalues: u15 (copy), u1 (ref), u13 (ref)
        return `{u15}{p16}{u1[u13].End}`;
    end;
end;
local u17 = "FONT_WEIGHT";
function u4.weight(p18) --[[ Line: 93 ]]
    -- upvalues: u1 (copy), u17 (copy)
    local u19 = u1[u17].Start:format(p18);
    return function(p20) --[[ Line: 96 ]]
        -- upvalues: u19 (copy), u1 (ref), u17 (ref)
        return `{u19}{p20}{u1[u17].End}`;
    end;
end;
local u21 = "FONT_TRANSPARENCY";
function u4.transparency(p22) --[[ Line: 93 ]]
    -- upvalues: u1 (copy), u21 (copy)
    local u23 = u1[u21].Start:format(p22);
    return function(p24) --[[ Line: 96 ]]
        -- upvalues: u23 (copy), u1 (ref), u21 (ref)
        return `{u23}{p24}{u1[u21].End}`;
    end;
end;
function u4.stroke(p25) --[[ Line: 135 ]]
    -- upvalues: u1 (copy)
    local v26 = `#{p25.Color:ToHex()}`;
    local u27 = u1.STROKE.Start:format(v26, p25.Joins or "Round", p25.Thickness or 1, p25.Transparency or 0);
    return function(p28) --[[ Line: 145 ]]
        -- upvalues: u27 (copy), u1 (ref)
        return `{u27}{p28}{u1.STROKE.End}`;
    end;
end;
function u4.color(...) --[[ Line: 149 ]]
    -- upvalues: u1 (copy)
    local v29 = { ... };
    local v30 = v29[1];
    local v31;
    if typeof(v30) == "string" then
        local v32 = v30:gsub("#", "");
        v31 = string.match(v32, "^%x%x%x%x%x%x$");
    else
        v31 = nil;
    end;
    local v33 = typeof(v29[1]) == "Color3";
    local v34 = v29[1];
    local v35 = v33 and v34 and v34 or Color3.fromRGB(v34, v29[2], v29[3]);
    local u36 = v31 and u1.FONT_COLOR_HEX.Start:format(v34:gsub("#", "")) or u1.FONT_COLOR_RGB.Start:format(math.floor(v35.R * 255), math.floor(v35.G * 255), (math.floor(v35.B * 255)));
    return function(p37) --[[ Line: 163 ]]
        -- upvalues: u36 (copy), u1 (ref)
        return `{u36}{p37}{u1.FONT_COLOR_RGB.End}`;
    end;
end;
local u38 = "BOLD";
function u2.bold(p39) --[[ Line: 103 ]]
    -- upvalues: u1 (copy), u38 (copy)
    local v40 = u1[u38];
    return `{v40.Start}{p39}{v40.End}`;
end;
local u41 = "ITALIC";
function u2.italic(p42) --[[ Line: 103 ]]
    -- upvalues: u1 (copy), u41 (copy)
    local v43 = u1[u41];
    return `{v43.Start}{p42}{v43.End}`;
end;
local u44 = "UNDERLINE";
function u2.underline(p45) --[[ Line: 103 ]]
    -- upvalues: u1 (copy), u44 (copy)
    local v46 = u1[u44];
    return `{v46.Start}{p45}{v46.End}`;
end;
local u47 = "STRIKETHROUGH";
function u2.strikethrough(p48) --[[ Line: 103 ]]
    -- upvalues: u1 (copy), u47 (copy)
    local v49 = u1[u47];
    return `{v49.Start}{p48}{v49.End}`;
end;
local u50 = "UPPERCASE";
function u2.uppercase(p51) --[[ Line: 103 ]]
    -- upvalues: u1 (copy), u50 (copy)
    local v52 = u1[u50];
    return `{v52.Start}{p51}{v52.End}`;
end;
local u53 = "SMALLCAPS";
function u2.smallcaps(p54) --[[ Line: 103 ]]
    -- upvalues: u1 (copy), u53 (copy)
    local v55 = u1[u53];
    return `{v55.Start}{p54}{v55.End}`;
end;
local u56 = Color3.fromRGB(255, 255, 255);
function u2.white(p57) --[[ Line: 110 ]]
    -- upvalues: u56 (copy), u1 (copy)
    local v58 = math.floor(u56.r * 255);
    local v59 = math.floor(u56.g * 255);
    local v60 = math.floor(u56.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v58, v59, v60)}{p57}{u1.FONT_COLOR_RGB.End}`;
end;
local u61 = Color3.fromRGB(0, 0, 0);
function u2.black(p62) --[[ Line: 110 ]]
    -- upvalues: u61 (copy), u1 (copy)
    local v63 = math.floor(u61.r * 255);
    local v64 = math.floor(u61.g * 255);
    local v65 = math.floor(u61.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v63, v64, v65)}{p62}{u1.FONT_COLOR_RGB.End}`;
end;
local u66 = Color3.fromRGB(255, 0, 0);
function u2.red(p67) --[[ Line: 110 ]]
    -- upvalues: u66 (copy), u1 (copy)
    local v68 = math.floor(u66.r * 255);
    local v69 = math.floor(u66.g * 255);
    local v70 = math.floor(u66.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v68, v69, v70)}{p67}{u1.FONT_COLOR_RGB.End}`;
end;
local u71 = Color3.fromRGB(153, 51, 0);
function u2.brown(p72) --[[ Line: 110 ]]
    -- upvalues: u71 (copy), u1 (copy)
    local v73 = math.floor(u71.r * 255);
    local v74 = math.floor(u71.g * 255);
    local v75 = math.floor(u71.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v73, v74, v75)}{p72}{u1.FONT_COLOR_RGB.End}`;
end;
local u76 = Color3.fromRGB(255, 153, 0);
function u2.orange(p77) --[[ Line: 110 ]]
    -- upvalues: u76 (copy), u1 (copy)
    local v78 = math.floor(u76.r * 255);
    local v79 = math.floor(u76.g * 255);
    local v80 = math.floor(u76.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v78, v79, v80)}{p77}{u1.FONT_COLOR_RGB.End}`;
end;
local u81 = Color3.fromRGB(255, 255, 0);
function u2.yellow(p82) --[[ Line: 110 ]]
    -- upvalues: u81 (copy), u1 (copy)
    local v83 = math.floor(u81.r * 255);
    local v84 = math.floor(u81.g * 255);
    local v85 = math.floor(u81.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v83, v84, v85)}{p82}{u1.FONT_COLOR_RGB.End}`;
end;
local u86 = Color3.fromRGB(153, 255, 0);
function u2.lime(p87) --[[ Line: 110 ]]
    -- upvalues: u86 (copy), u1 (copy)
    local v88 = math.floor(u86.r * 255);
    local v89 = math.floor(u86.g * 255);
    local v90 = math.floor(u86.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v88, v89, v90)}{p87}{u1.FONT_COLOR_RGB.End}`;
end;
local u91 = Color3.fromRGB(0, 255, 0);
function u2.green(p92) --[[ Line: 110 ]]
    -- upvalues: u91 (copy), u1 (copy)
    local v93 = math.floor(u91.r * 255);
    local v94 = math.floor(u91.g * 255);
    local v95 = math.floor(u91.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v93, v94, v95)}{p92}{u1.FONT_COLOR_RGB.End}`;
end;
local u96 = Color3.fromRGB(0, 0, 255);
function u2.blue(p97) --[[ Line: 110 ]]
    -- upvalues: u96 (copy), u1 (copy)
    local v98 = math.floor(u96.r * 255);
    local v99 = math.floor(u96.g * 255);
    local v100 = math.floor(u96.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v98, v99, v100)}{p97}{u1.FONT_COLOR_RGB.End}`;
end;
local u101 = Color3.fromRGB(102, 0, 153);
function u2.purple(p102) --[[ Line: 110 ]]
    -- upvalues: u101 (copy), u1 (copy)
    local v103 = math.floor(u101.r * 255);
    local v104 = math.floor(u101.g * 255);
    local v105 = math.floor(u101.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v103, v104, v105)}{p102}{u1.FONT_COLOR_RGB.End}`;
end;
local u106 = Color3.fromRGB(255, 0, 255);
function u2.pink(p107) --[[ Line: 110 ]]
    -- upvalues: u106 (copy), u1 (copy)
    local v108 = math.floor(u106.r * 255);
    local v109 = math.floor(u106.g * 255);
    local v110 = math.floor(u106.b * 255);
    return `{u1.FONT_COLOR_RGB.Start:format(v108, v109, v110)}{p107}{u1.FONT_COLOR_RGB.End}`;
end;
function u3.new(p111) --[[ Line: 188 ]]
    -- upvalues: u4 (copy), u2 (copy)
    local v112 = {};
    local v113 = {};
    local u114 = {};
    v112.Formatters = u114;
    local u115 = nil;
    local u116 = nil;
    function v113.__call(_, ...) --[[ Line: 196 ]]
        -- upvalues: u115 (ref), u114 (copy)
        local v117 = { ... };
        if u115 then
            local v118 = u115;
            u115 = nil;
            return v118(unpack(v117));
        else
            local v119 = {};
            for _, v122 in v117 do
                for _, v121 in u114 do
                    local v122 = v121(v122);
                end;
                table.insert(v119, v122);
            end;
            return unpack(v119);
        end;
    end;
    function v113.__index(p123, p124) --[[ Line: 220 ]]
        -- upvalues: u4 (ref), u115 (ref), u114 (copy), u116 (ref), u2 (ref)
        local u125 = u4[p124];
        if u125 then
            u115 = function(...) --[[ Line: 224 ]]
                -- upvalues: u125 (copy), u114 (ref), u116 (ref)
                local v126 = u125(...);
                table.insert(u114, v126);
                return u116;
            end;
            return u116;
        else
            table.insert(u114, u2[p124]);
            return p123;
        end;
    end;
    v113:__index(p111);
    u116 = setmetatable(v112, v113);
    return u116;
end;
return setmetatable({}, {
    __index = function(_, p127) --[[ Name: __index, Line 249 ]]
        -- upvalues: u3 (copy)
        return u3.new(p127);
    end,
    __newindex = function() --[[ Name: __newindex, Line 252 ]]
        return error("Chalk is READONLY");
    end
});