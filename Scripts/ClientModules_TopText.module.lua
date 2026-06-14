-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__SoundService__3 = game:GetService("SoundService");
local l__Debris__4 = game:GetService("Debris");
local l__NpcUIs__5 = l__ReplicatedStorage__1.Assets.NpcUIs;
local l__Talk_UI__6 = l__NpcUIs__5.Talk_UI;
local l__Response_UI__7 = l__NpcUIs__5.Response_UI;
local l__Option_UI__8 = l__NpcUIs__5.Option_UI;
local l__responseText__9 = l__SoundService__3.SFX.responseText;
local u2 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local u3 = nil;
local u4 = nil;
local function u6(p5) --[[ Line: 34 ]]
    return p5:gsub("<.->", "");
end;
local function u14(p7, p8, p9) --[[ Line: 38 ]]
    -- upvalues: l__SoundService__3 (copy), l__responseText__9 (copy)
    local v10 = p7.Text:gsub("<.->", "");
    local v11 = utf8.len(v10) or 0;
    p7.MaxVisibleGraphemes = 0;
    local v12;
    if p8 then
        v12 = p9 and l__SoundService__3.NPC_SFX:FindFirstChild(p9) or l__SoundService__3.NPC_SFX.NPC_Text;
    else
        v12 = nil;
    end;
    if p8 and v12 then
        while v11 >= 1 do
            task.wait();
            if v12.TimePosition > 0.07 or not v12.Playing then
                v12.TimePosition = 0;
                v12.Playing = true;
                v12.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
            end;
            v11 = v11 - 1;
            p7.MaxVisibleGraphemes = p7.MaxVisibleGraphemes + 1;
        end;
    else
        local v13 = v11;
        while v11 >= 1 do
            task.wait();
            if math.floor(v11 / 3) * 3 == v11 or v11 == v13 then
                l__responseText__9.TimePosition = 0;
                l__responseText__9.Playing = true;
                l__responseText__9.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
            end;
            v11 = v11 - 1;
            p7.MaxVisibleGraphemes = p7.MaxVisibleGraphemes + 1;
        end;
    end;
end;
local function u22(p15, p16, p17) --[[ Line: 75 ]]
    if p17 then
        for _, v18 in p15:GetDescendants() do
            if v18:IsA("LocalScript") or v18:IsA("Script") then
                v18:Destroy();
            end;
        end;
        for _, v19 in p16:GetDescendants() do
            if v19:IsA("LocalScript") or v19:IsA("Script") then
                for _, v20 in p15:GetDescendants() do
                    if v20.Name == v19.Parent.Name then
                        local v21 = v19:Clone();
                        v21.Parent = v20;
                        v21.Enabled = true;
                    end;
                end;
            end;
        end;
    end;
end;
local function u32(p23, p24) --[[ Line: 99 ]]
    local v25 = utf8.len(p23) or 1;
    local v26 = 0;
    local v27 = {};
    for _, v28 in utf8.codes(p23) do
        v26 = v26 + 1;
        local v29 = utf8.char(v28);
        local v30 = Color3.fromHSV((p24 * 1.2 + (v26 - 1) / v25 * 0.6) % 1, 1, 1);
        local v31 = string.format("#%02X%02X%02X", math.floor(v30.R * 255), math.floor(v30.G * 255), (math.floor(v30.B * 255)));
        table.insert(v27, string.format("<font color=\"%s\">%s</font>", v31, v29));
    end;
    return table.concat(v27);
end;
function v1.NpcText(p33, p34, p35) --[[ Line: 118 ]]
    -- upvalues: u3 (ref), l__Talk_UI__6 (copy), u14 (copy), u22 (copy)
    if u3 then
        u3();
        u3 = nil;
    end;
    local v36 = p33.Head:FindFirstChild(l__Talk_UI__6.Name);
    if v36 then
        u22(v36, l__Talk_UI__6, p35);
        v36.TextLabel.Text = p34;
        u14(v36.TextLabel, true, p33.Name);
        return v36;
    end;
    local v37 = l__Talk_UI__6:Clone();
    v37.Parent = p33.Head;
    v37.TextLabel.Text = p34;
    u14(v37.TextLabel, true, p33.Name);
    if p35 then
        for _, v38 in v37:GetDescendants() do
            if v38:IsA("LocalScript") or v38:IsA("Script") then
                v38.Enabled = true;
            end;
        end;
    end;
    return v37;
end;
function v1.RainbowNpcText(p39, u40, u41, u42, p43) --[[ Line: 153 ]]
    -- upvalues: u3 (ref), l__Talk_UI__6 (copy), u14 (copy), u22 (copy), u32 (copy)
    if u3 then
        u3();
        u3 = nil;
    end;
    local v44 = p39.Head:FindFirstChild(l__Talk_UI__6.Name);
    local v45 = u40 .. "<font color=\"#FFFFFF\">" .. u41 .. "</font>" .. u42;
    local u46;
    if v44 then
        u22(v44, l__Talk_UI__6, p43);
        u46 = v44;
        u46.TextLabel.Text = v45;
        u14(u46.TextLabel, true, p39.Name);
    else
        u46 = l__Talk_UI__6:Clone();
        u46.Parent = p39.Head;
        u46.TextLabel.Text = v45;
        u14(u46.TextLabel, true, p39.Name);
        if p43 then
            for _, v47 in u46:GetDescendants() do
                if v47:IsA("LocalScript") or v47:IsA("Script") then
                    v47.Enabled = true;
                end;
            end;
        end;
    end;
    local u48 = true;
    local function u49() --[[ Line: 186 ]]
        -- upvalues: u48 (ref)
        u48 = false;
    end;
    u3 = u49;
    task.spawn(function() --[[ Line: 191 ]]
        -- upvalues: u48 (ref), u46 (ref), u40 (copy), u32 (ref), u41 (copy), u42 (copy), u3 (ref), u49 (copy)
        local v50 = 0;
        while u48 do
            v50 = v50 + task.wait(0.04);
            if not u48 then
                break;
            end;
            if not (u46 and u46.Parent) then
                u48 = false;
                break;
            end;
            u46.TextLabel.Text = u40 .. u32(u41, v50) .. u42;
        end;
        if u3 == u49 then
            u3 = nil;
        end;
    end);
    return u49;
end;
function v1.NpcCountUp(p51, p52) --[[ Line: 267 ]]
    -- upvalues: u3 (ref), l__Talk_UI__6 (copy), u22 (copy), l__SoundService__3 (copy), u6 (copy), u32 (copy)
    if u3 then
        u3();
        u3 = nil;
    end;
    local l__TextBefore__10 = p52.TextBefore;
    local l__TextAfter__11 = p52.TextAfter;
    local l__FinalAmount__12 = p52.FinalAmount;
    local l__Format__13 = p52.Format;
    local l__Color__14 = p52.Color;
    local v53 = p52.Rainbow == true;
    local v54 = p52.Duration or 0.7;
    local v55 = p52.ShouldDisappear or false;
    local u56 = l__Format__13(0);
    local v57;
    if v53 then
        v57 = l__TextBefore__10 .. "<font color=\"#FFFFFF\">" .. u56 .. "</font>" .. l__TextAfter__11;
    else
        local v58;
        if l__Color__14 then
            v58 = string.format("<font color=\"%s\">%s</font>", l__Color__14, u56);
        else
            v58 = u56;
        end;
        v57 = l__TextBefore__10 .. v58 .. l__TextAfter__11;
    end;
    local v59 = p51.Head:FindFirstChild(l__Talk_UI__6.Name);
    local u60;
    if v59 then
        u22(v59, l__Talk_UI__6, v55);
        u60 = v59;
        u60.TextLabel.Text = v57;
    else
        u60 = l__Talk_UI__6:Clone();
        u60.Parent = p51.Head;
        u60.TextLabel.Text = v57;
        if v55 then
            for _, v61 in u60:GetDescendants() do
                if v61:IsA("LocalScript") or v61:IsA("Script") then
                    v61.Enabled = true;
                end;
            end;
        end;
    end;
    local l__TextLabel__15 = u60.TextLabel;
    local l__Name__16 = p51.Name;
    l__TextLabel__15.MaxVisibleGraphemes = 0;
    local u62 = l__Name__16 and l__SoundService__3.NPC_SFX:FindFirstChild(l__Name__16) or l__SoundService__3.NPC_SFX.NPC_Text;
    task.spawn(function() --[[ Line: 231 ]]
        -- upvalues: l__TextLabel__15 (copy), u6 (ref), u62 (copy)
        local v63 = 0;
        while l__TextLabel__15 and l__TextLabel__15.Parent do
            if (utf8.len(u6(l__TextLabel__15.Text)) or 0) <= v63 then
                l__TextLabel__15.MaxVisibleGraphemes = -1;
                return;
            end;
            v63 = v63 + 1;
            l__TextLabel__15.MaxVisibleGraphemes = v63;
            if u62 and (u62.TimePosition > 0.07 or not u62.Playing) then
                u62.TimePosition = 0;
                u62.Playing = true;
                u62.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
            end;
            task.wait();
        end;
    end);
    if not v53 then
        local v64 = 0;
        while v64 < v54 do
            if not (u60 and u60.Parent) then
                return;
            end;
            local v65 = math.clamp(v64 / v54, 0, 1);
            local v66 = math.lerp(0, l__FinalAmount__12, v65);
            local v67 = math.round(v66);
            local l__TextLabel__17 = u60.TextLabel;
            local v68 = l__Format__13(v67);
            if l__Color__14 then
                v68 = string.format("<font color=\"%s\">%s</font>", l__Color__14, v68);
            end;
            l__TextLabel__17.Text = l__TextBefore__10 .. v68 .. l__TextAfter__11;
            v64 = v64 + task.wait();
        end;
        if u60 and u60.Parent then
            local l__TextLabel__18 = u60.TextLabel;
            local v69 = l__Format__13(l__FinalAmount__12);
            if l__Color__14 then
                v69 = string.format("<font color=\"%s\">%s</font>", l__Color__14, v69);
            end;
            l__TextLabel__18.Text = l__TextBefore__10 .. v69 .. l__TextAfter__11;
        end;
        return;
    end;
    local u70 = true;
    local function u71() --[[ Line: 334 ]]
        -- upvalues: u70 (ref)
        u70 = false;
    end;
    u3 = u71;
    local v72 = 0;
    local u73 = 0;
    while v72 < v54 do
        if not (u70 and (u60 and u60.Parent)) then
            u70 = false;
            break;
        end;
        local v74 = math.clamp(v72 / v54, 0, 1);
        local v75 = math.lerp(0, l__FinalAmount__12, v74);
        u56 = l__Format__13((math.round(v75)));
        u60.TextLabel.Text = l__TextBefore__10 .. u32(u56, u73) .. l__TextAfter__11;
        local v76 = task.wait();
        v72 = v72 + v76;
        u73 = u73 + v76;
    end;
    if u70 then
        u56 = l__Format__13(l__FinalAmount__12);
    end;
    task.spawn(function() --[[ Line: 359 ]]
        -- upvalues: u70 (ref), u73 (ref), u60 (ref), l__TextBefore__10 (copy), u32 (ref), u56 (ref), l__TextAfter__11 (copy), u3 (ref), u71 (copy)
        while u70 do
            u73 = u73 + task.wait(0.04);
            if not u70 then
                break;
            end;
            if not (u60 and u60.Parent) then
                u70 = false;
                break;
            end;
            u60.TextLabel.Text = l__TextBefore__10 .. u32(u56, u73) .. l__TextAfter__11;
        end;
        if u3 == u71 then
            u3 = nil;
        end;
    end);
end;
v1.BuildRainbowText = u32;
function v1.RainbowPlayerResponse(p77, u78, u79, u80, p81) --[[ Line: 380 ]]
    -- upvalues: u4 (ref), l__Talk_UI__6 (copy), l__Response_UI__7 (copy), u14 (copy), u22 (copy), u32 (copy)
    if u4 then
        u4();
        u4 = nil;
    end;
    local v82 = p77:FindFirstChild("Head");
    if not v82 then
        return nil;
    end;
    local v83 = v82:FindFirstChild(l__Talk_UI__6.Name);
    local v84 = u78 .. "<font color=\"#FFFFFF\">" .. u79 .. "</font>" .. u80;
    local u85;
    if v83 then
        u22(v83, l__Response_UI__7, p81);
        u85 = v83;
        u85.TextLabel.Text = v84;
        u14(u85.TextLabel, false);
    else
        u85 = l__Response_UI__7:Clone();
        u85.Parent = v82;
        u85.TextLabel.Text = v84;
        u14(u85.TextLabel, false);
        if p81 then
            for _, v86 in u85:GetDescendants() do
                if v86:IsA("LocalScript") or v86:IsA("Script") then
                    v86.Enabled = true;
                end;
            end;
        end;
    end;
    local u87 = true;
    local function u88() --[[ Line: 415 ]]
        -- upvalues: u87 (ref)
        u87 = false;
    end;
    u4 = u88;
    task.spawn(function() --[[ Line: 420 ]]
        -- upvalues: u87 (ref), u85 (ref), u78 (copy), u32 (ref), u79 (copy), u80 (copy), u4 (ref), u88 (copy)
        local v89 = 0;
        while u87 do
            v89 = v89 + task.wait(0.04);
            if not u87 then
                break;
            end;
            if not (u85 and u85.Parent) then
                u87 = false;
                break;
            end;
            u85.TextLabel.Text = u78 .. u32(u79, v89) .. u80;
        end;
        if u4 == u88 then
            u4 = nil;
        end;
    end);
    return u88;
end;
function v1.ShowChoices(p90, p91) --[[ Line: 439 ]]
    -- upvalues: l__Option_UI__8 (copy), l__TweenService__2 (copy), l__Debris__4 (copy)
    local v92 = {};
    local v93 = p90.PlayerGui:FindFirstChild("Billboard_UI");
    if not v93 then
        return v92;
    end;
    for v94, v95 in ipairs(p91) do
        local v96 = l__Option_UI__8:Clone();
        v96.Parent = v93.Objects;
        v96.Frame.Frame.Text_Element.Text = "[\"" .. v95 .. "\"]";
        v96.Frame.Frame.TextLabel.Text = "#" .. tostring(v94);
        local l__UIPadding__19 = v96.Frame.Frame.Text_Element.UIPadding;
        local v97 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        l__UIPadding__19.PaddingLeft = UDim.new(string.len(v95) * 0.001 + 0.04, 0);
        local v98 = l__TweenService__2:Create(l__UIPadding__19, v97, {
            PaddingLeft = UDim.new(0, 0)
        });
        v98:Play();
        l__Debris__4:AddItem(v98, v97.Time);
        table.insert(v92, v96);
        v96.Frame.Frame.Text_Element:SetAttribute("Text", v95);
        task.wait(0.075);
    end;
    return v92;
end;
function v1.TakeAwayResponses(p99, _) --[[ Line: 470 ]]
    -- upvalues: l__TweenService__2 (copy), u2 (copy), l__Debris__4 (copy)
    for _, v100 in p99.Head:GetChildren() do
        if v100:IsA("BillboardGui") and (v100.Name == "Response_UI" or v100.Name == "Talk_UI") then
            for _, v101 in v100:GetChildren() do
                if v101:IsA("TextLabel") then
                    l__TweenService__2:Create(v101, u2, {
                        TextTransparency = 1
                    }):Play();
                elseif v101:IsA("ImageLabel") then
                    l__TweenService__2:Create(v101, u2, {
                        ImageTransparency = 1
                    }):Play();
                end;
            end;
            l__Debris__4:AddItem(v100, u2.Time);
        end;
    end;
end;
function v1.ConnectChoiceKeyboard(_, _) --[[ Line: 493 ]]
    return function() --[[ Line: 497 ]] end;
end;
function v1.RemovePlayerSideFrame(p102) --[[ Line: 500 ]]
    local v103 = p102.PlayerGui:FindFirstChild("Billboard_UI");
    if v103 then
        for _, v104 in v103.Objects:GetChildren() do
            if v104.Name ~= "UIListLayout" then
                v104:Destroy();
            end;
        end;
    end;
end;
function v1.ShowResponse(p105, p106, p107) --[[ Line: 512 ]]
    -- upvalues: l__Talk_UI__6 (copy), u14 (copy), u22 (copy)
    local v108 = p105.Head:FindFirstChild(l__Talk_UI__6.Name);
    if v108 then
        u22(v108, l__Talk_UI__6, p107);
        v108.TextLabel.Text = p106;
        u14(v108.TextLabel, true);
        return v108;
    end;
    local v109 = l__Talk_UI__6:Clone();
    v109.Parent = p105.Head;
    v109.TextLabel.Text = p106;
    u14(v109.TextLabel, true);
    if p107 then
        for _, v110 in v109:GetDescendants() do
            if v110:IsA("LocalScript") or v110:IsA("Script") then
                v110.Enabled = true;
            end;
        end;
    end;
    return v109;
end;
function v1.PlayerResponse(p111, p112, p113) --[[ Line: 538 ]]
    -- upvalues: u4 (ref), l__Talk_UI__6 (copy), l__Response_UI__7 (copy), u14 (copy), u22 (copy)
    if not p112 then
        return nil;
    end;
    if u4 then
        u4();
        u4 = nil;
    end;
    local v114 = p111.Head:FindFirstChild(l__Talk_UI__6.Name);
    if v114 then
        u22(v114, l__Response_UI__7, p113);
        v114.TextLabel.Text = p112;
        u14(v114.TextLabel, false);
        return v114;
    end;
    local v115 = l__Response_UI__7:Clone();
    v115.Parent = p111.Head;
    v115.TextLabel.Text = p112;
    u14(v115.TextLabel, false);
    if p113 then
        for _, v116 in v115:GetDescendants() do
            if v116:IsA("LocalScript") or v116:IsA("Script") then
                v116.Enabled = true;
            end;
        end;
    end;
    return v115;
end;
return v1;