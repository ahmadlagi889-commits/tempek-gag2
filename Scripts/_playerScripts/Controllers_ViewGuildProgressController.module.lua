-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__PetData__4 = require(l__ReplicatedStorage__2.SharedData.PetData);
local l__PetSizes__5 = require(l__ReplicatedStorage__2.SharedData.PetSizes);
local l__PetTypes__6 = require(l__ReplicatedStorage__2.SharedData.PetTypes);
local l__AnimatedGradient__7 = require(l__ReplicatedStorage__2.SharedModules.AnimatedGradient);
local l__LocalPlayer__8 = l__Players__1.LocalPlayer;
local l__PlayerGui__9 = l__LocalPlayer__8:WaitForChild("PlayerGui");
local l__GuiController__10 = require(l__LocalPlayer__8.PlayerScripts.Controllers.GuiController);
local l__MailboxItemCatalog__11 = require(l__LocalPlayer__8.PlayerScripts.Controllers.MailboxController.MailboxItemCatalog);
local v1 = {
    StartOrder = 9
};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = {};
local u11 = nil;
local u12 = false;
local u13 = "ViewGuildPage";
local function u16(p14) --[[ Line: 55 ]]
    if p14 >= 1000 then
        local v15 = string.format("%.1f", p14 / 1000);
        if v15:sub(-2) == ".0" then
            return v15:sub(1, -3) .. "K";
        else
            return v15 .. "K";
        end;
    else
        return tostring(p14);
    end;
end;
local function u22(p17) --[[ Line: 69 ]]
    -- upvalues: u16 (copy)
    local v18 = tonumber(p17);
    if v18 then
        return v18, v18, "#" .. u16(v18);
    else
        local v19, v20 = string.match(p17, "^(%d+)%-(%d+)$");
        if v19 and v20 then
            return tonumber(v19), tonumber(v20), "#" .. u16((tonumber(v19))) .. "-" .. u16((tonumber(v20)));
        else
            local v21 = string.match(p17, "^(%d+)%-$");
            if v21 then
                return tonumber(v21), (1 / 0), "#" .. u16((tonumber(v21))) .. "+";
            else
                return (1 / 0), (1 / 0), p17;
            end;
        end;
    end;
end;
local function u27(p23) --[[ Line: 84 ]]
    -- upvalues: l__PetSizes__5 (copy), l__PetTypes__6 (copy), l__PetData__4 (copy)
    local l__item__12 = p23.item;
    if typeof(l__item__12) ~= "string" or l__item__12 == "" then
        return "", "";
    end;
    local v24 = l__PetSizes__5.Normalize(p23.size);
    local v25;
    if l__PetTypes__6.IsValid(p23.type) then
        v25 = p23.type;
    else
        v25 = nil;
    end;
    local v26 = {};
    if v24 then
        table.insert(v26, v24);
    end;
    if v25 then
        table.insert(v26, v25);
    end;
    table.insert(v26, l__PetData__4.GetSpeciesDisplayName(l__item__12));
    return table.concat(v26, " "), l__PetData__4.GetImage(l__item__12, v24);
end;
local function u34(p28) --[[ Line: 100 ]]
    -- upvalues: u27 (copy), l__MailboxItemCatalog__11 (copy)
    if typeof(p28) ~= "table" then
        return nil;
    end;
    if typeof(p28.display) == "string" and p28.display ~= "" then
        return p28.display;
    end;
    local l__item__13 = p28.item;
    if typeof(l__item__13) ~= "string" or l__item__13 == "" then
        return nil;
    end;
    local v29 = tonumber(p28.count) or 1;
    if p28.category == "Pets" then
        local v30 = u27(p28);
        if v30 ~= "" then
            return string.format("%dx %s", v29, v30);
        end;
    end;
    local v31 = typeof(p28.category) ~= "string" and "" or p28.category;
    local v32, v33 = pcall(l__MailboxItemCatalog__11.Resolve, v31, l__item__13, p28);
    if v32 and typeof(v33) == "string" then
        if v33 == "" then
            v33 = l__item__13;
        end;
    else
        v33 = l__item__13;
    end;
    return string.format("%dx %s", v29, v33);
end;
local function u40(p35) --[[ Line: 121 ]]
    -- upvalues: u27 (copy), l__MailboxItemCatalog__11 (copy)
    if typeof(p35) ~= "table" then
        return "";
    end;
    local l__item__14 = p35.item;
    if typeof(l__item__14) ~= "string" or l__item__14 == "" then
        return "";
    end;
    if p35.category == "Pets" then
        local _, v36 = u27(p35);
        return v36;
    end;
    local v37 = typeof(p35.category) ~= "string" and "" or p35.category;
    local v38, _, v39 = pcall(l__MailboxItemCatalog__11.Resolve, v37, l__item__14, p35);
    return (not v38 or typeof(v39) ~= "string") and "" or v39;
end;
local function u51(p41, p42, p43) --[[ Line: 169 ]]
    -- upvalues: u34 (copy), l__AnimatedGradient__7 (copy), u40 (copy), l__PetTypes__6 (copy)
    local v44 = p41:FindFirstChild("Place");
    if v44 and (v44:IsA("TextLabel") and v44) then
        v44.Text = p42;
        local v45 = v44:FindFirstChild("TextLabel");
        if v45 and v45:IsA("TextLabel") then
            v45.Text = p42;
        end;
    end;
    local v46 = p41:FindFirstChild("RewardName");
    if v46 and v46:IsA("TextLabel") then
        local v47 = u34(p43) or "";
        if v46 then
            v46.Text = v47;
            local v48 = v46:FindFirstChild("TextLabel");
            if v48 and v48:IsA("TextLabel") then
                v48.Text = v47;
            end;
        end;
    end;
    local v49 = p41:FindFirstChild("RewardDisplay");
    if v49 then
        v49 = v49:FindFirstChild("Image");
    end;
    if not (v49 and v49:IsA("ImageLabel")) then
        v49 = nil;
    end;
    if v49 then
        l__AnimatedGradient__7:Remove(v49);
        v49.Image = u40(p43);
        local v50;
        if typeof(p43) == "table" and p43.category == "Pets" then
            v50 = p43.type == l__PetTypes__6.Rainbow;
        else
            v50 = false;
        end;
        if v50 then
            l__AnimatedGradient__7:AddRainbowColor(v49, "ImageColor3");
        end;
    end;
    p41.Visible = true;
end;
local function u77(p52) --[[ Line: 201 ]]
    -- upvalues: u10 (copy), u6 (ref), l__AnimatedGradient__7 (copy), u7 (ref), u8 (ref), u9 (ref), u5 (ref), u22 (copy), u34 (copy), u51 (copy)
    for _, v53 in u10 do
        v53:Destroy();
    end;
    table.clear(u10);
    local v54 = u6;
    if v54 then
        local v55 = v54:FindFirstChild("RewardDisplay");
        if v55 then
            v55 = v55:FindFirstChild("Image");
        end;
        if not (v55 and v55:IsA("ImageLabel")) then
            v55 = nil;
        end;
        if v55 then
            l__AnimatedGradient__7:Remove(v55);
        end;
        v54.Visible = false;
    end;
    local v56 = u7;
    if v56 then
        local v57 = v56:FindFirstChild("RewardDisplay");
        if v57 then
            v57 = v57:FindFirstChild("Image");
        end;
        if not (v57 and v57:IsA("ImageLabel")) then
            v57 = nil;
        end;
        if v57 then
            l__AnimatedGradient__7:Remove(v57);
        end;
        v56.Visible = false;
    end;
    local v58 = u8;
    if v58 then
        local v59 = v58:FindFirstChild("RewardDisplay");
        if v59 then
            v59 = v59:FindFirstChild("Image");
        end;
        if not (v59 and v59:IsA("ImageLabel")) then
            v59 = nil;
        end;
        if v59 then
            l__AnimatedGradient__7:Remove(v59);
        end;
        v58.Visible = false;
    end;
    if u9 then
        u9.Visible = false;
    end;
    if not u5 or typeof(p52) ~= "table" then
        return;
    end;
    local v60 = {};
    for v61 in p52 do
        if typeof(v61) == "string" then
            table.insert(v60, v61);
        end;
    end;
    table.sort(v60, function(p62, p63) --[[ Line: 213 ]]
        -- upvalues: u22 (ref)
        local v64, v65 = u22(p62);
        local v66, v67 = u22(p63);
        if v64 == v66 then
            if v65 == v67 then
                return p62 < p63;
            else
                return v65 < v67;
            end;
        else
            return v64 < v66;
        end;
    end);
    local v68 = 0;
    for _, v69 in v60 do
        local v70 = p52[v69];
        local v71, v72, v73, v74, v76;
        if typeof(v70) == "table" then
            for _, v76 in v70 do
                if u34(v76) then
                    if v76 then
                        v68 = v68 + 1;
                        v71, v72, v73 = u22(v69);
                        if v68 == 1 and u6 then
                            u6.LayoutOrder = 1;
                            u51(u6, v73, v76);
                        elseif v68 == 2 and u7 then
                            u7.LayoutOrder = 2;
                            u51(u7, v73, v76);
                        elseif v68 == 3 and u8 then
                            u8.LayoutOrder = 3;
                            u51(u8, v73, v76);
                        elseif v68 >= 4 and u9 then
                            v74 = u9:Clone();
                            v74.Name = "RewardClone" .. tostring(v68);
                            v74.LayoutOrder = v68;
                            v74.Parent = u5;
                            table.insert(u10, v74);
                            u51(v74, v73, v76);
                        end;
                    end;
                end;
            end;
            v76 = nil;
        else
            v76 = nil;
        end;
        if v76 then
            v68 = v68 + 1;
            v71, v72, v73 = u22(v69);
            if v68 == 1 and u6 then
                u6.LayoutOrder = 1;
                u51(u6, v73, v76);
            elseif v68 == 2 and u7 then
                u7.LayoutOrder = 2;
                u51(u7, v73, v76);
            elseif v68 == 3 and u8 then
                u8.LayoutOrder = 3;
                u51(u8, v73, v76);
            elseif v68 >= 4 and u9 then
                v74 = u9:Clone();
                v74.Name = "RewardClone" .. tostring(v68);
                v74.LayoutOrder = v68;
                v74.Parent = u5;
                table.insert(u10, v74);
                u51(v74, v73, v76);
            end;
        end;
    end;
end;
local function u95(p78) --[[ Line: 247 ]]
    -- upvalues: u3 (ref), u4 (ref), u77 (copy)
    if typeof(p78) == "table" then
        local l__phase__15 = p78.phase;
        if l__phase__15 == "running" and typeof(p78.config) == "table" then
            local l__config__16 = p78.config;
            local v79 = u3;
            local v80 = typeof(l__config__16.displayName) ~= "string" and "Competition" or l__config__16.displayName;
            if v79 then
                v79.Text = v80;
                local v81 = v79:FindFirstChild("TextLabel");
                if v81 and v81:IsA("TextLabel") then
                    v81.Text = v80;
                end;
            end;
            if u4 then
                local v82 = {};
                if typeof(l__config__16.description) == "table" then
                    for _, v83 in l__config__16.description do
                        if typeof(v83) == "string" and v83 ~= "" then
                            table.insert(v82, v83);
                        end;
                    end;
                end;
                local v84 = u4;
                local v85 = #v82 <= 0 and "Score points for your guild while the competition is live!" or table.concat(v82, "\n");
                if v84 then
                    v84.Text = v85;
                    local v86 = v84:FindFirstChild("TextLabel");
                    if v86 and v86:IsA("TextLabel") then
                        v86.Text = v85;
                    end;
                end;
            end;
            u77(l__config__16.rewards);
        elseif l__phase__15 == "pending" then
            local v87 = u3;
            if v87 then
                v87.Text = "Competition Starting Soon";
                local v88 = v87:FindFirstChild("TextLabel");
                if v88 and v88:IsA("TextLabel") then
                    v88.Text = "Competition Starting Soon";
                end;
            end;
            local v89 = u4 and u4;
            if v89 then
                v89.Text = "A new guild competition is about to begin. Check back when it starts!";
                local v90 = v89:FindFirstChild("TextLabel");
                if v90 and v90:IsA("TextLabel") then
                    v90.Text = "A new guild competition is about to begin. Check back when it starts!";
                end;
            end;
            u77(nil);
        else
            local v91 = u3;
            if v91 then
                v91.Text = "No Active Competition";
                local v92 = v91:FindFirstChild("TextLabel");
                if v92 and v92:IsA("TextLabel") then
                    v92.Text = "No Active Competition";
                end;
            end;
            local v93 = u4 and u4;
            if v93 then
                v93.Text = "There is no guild competition running right now.";
                local v94 = v93:FindFirstChild("TextLabel");
                if v94 and v94:IsA("TextLabel") then
                    v94.Text = "There is no guild competition running right now.";
                end;
            end;
            u77(nil);
        end;
    end;
end;
local function u107(p96) --[[ Line: 287 ]]
    -- upvalues: u3 (ref), u11 (ref), u4 (ref), u6 (ref), u5 (ref), u7 (ref), u8 (ref), u9 (ref)
    local v97 = p96:FindFirstChild("GuildProgress");
    if v97 then
        local v98 = v97:FindFirstChild("Header");
        if v98 then
            local v99 = v98:FindFirstChild("TextLabel");
            if v99 and v99:IsA("TextLabel") then
                u3 = v99;
            end;
            local v100 = v98:FindFirstChild("ExitButton");
            if v100 and v100:IsA("GuiButton") then
                u11 = v100;
            end;
        end;
        local v101 = v97:FindFirstChild("Content");
        if v101 then
            local v102 = v101:FindFirstChild("Info");
            if v102 then
                v102 = v102:FindFirstChild("Description");
            end;
            if v102 and v102:IsA("TextLabel") then
                u4 = v102;
            end;
            local v103 = v101:FindFirstChild("1", true);
            if v103 and v103:IsA("ImageButton") then
                u6 = v103;
                local l__Parent__17 = v103.Parent;
                if l__Parent__17 and l__Parent__17:IsA("ScrollingFrame") then
                    u5 = l__Parent__17;
                    local v104 = l__Parent__17:FindFirstChild("2");
                    if v104 and v104:IsA("ImageButton") then
                        u7 = v104;
                    end;
                    local v105 = l__Parent__17:FindFirstChild("3");
                    if v105 and v105:IsA("ImageButton") then
                        u8 = v105;
                    end;
                    local v106 = l__Parent__17:FindFirstChild("4");
                    if v106 and v106:IsA("ImageButton") then
                        u9 = v106;
                        v106.Visible = false;
                    end;
                end;
            end;
        end;
    end;
end;
function v1.SetReturnGui(_, p108) --[[ Line: 340 ]]
    -- upvalues: u13 (ref)
    u13 = (typeof(p108) ~= "string" or p108 == "") and "ViewGuildPage" or p108;
end;
function v1.SetNoReturn(_) --[[ Line: 348 ]]
    -- upvalues: u13 (ref)
    u13 = nil;
end;
function v1.SetTargetGuildId(_, _) --[[ Line: 352 ]] end;
function v1.Init(_) --[[ Line: 354 ]] end;
function v1.Start(_) --[[ Line: 356 ]]
    -- upvalues: l__PlayerGui__9 (copy), u2 (ref), u107 (copy), u11 (ref), u13 (ref), l__GuiController__10 (copy), u12 (ref), u5 (ref), l__Networking__3 (copy), u95 (copy)
    task.spawn(function() --[[ Line: 357 ]]
        -- upvalues: l__PlayerGui__9 (ref), u2 (ref), u107 (ref), u11 (ref), u13 (ref), l__GuiController__10 (ref), u12 (ref), u5 (ref), l__Networking__3 (ref), u95 (ref)
        local l__ViewGuildProgress__18 = l__PlayerGui__9:WaitForChild("ViewGuildProgress", 30);
        if l__ViewGuildProgress__18 and l__ViewGuildProgress__18:IsA("ScreenGui") then
            u2 = l__ViewGuildProgress__18;
            l__ViewGuildProgress__18.Enabled = false;
            u107(l__ViewGuildProgress__18);
            if u11 then
                u11.MouseButton1Click:Connect(function() --[[ Line: 328 ]]
                    -- upvalues: u13 (ref), l__GuiController__10 (ref)
                    if u13 then
                        l__GuiController__10:Open(u13, nil, { "HUD" });
                    end;
                    if l__GuiController__10:IsOpen("ViewGuildProgress") then
                        l__GuiController__10:Close();
                    end;
                end);
            end;
            l__GuiController__10.GuiFocusedSignal:Connect(function(p109) --[[ Line: 364 ]]
                -- upvalues: l__ViewGuildProgress__18 (copy), u12 (ref), u5 (ref), l__Networking__3 (ref), u95 (ref)
                if p109 == l__ViewGuildProgress__18 then
                    u12 = true;
                    if u5 then
                        u5.CanvasPosition = Vector2.zero;
                    end;
                    task.spawn(function() --[[ Line: 277 ]]
                        -- upvalues: l__Networking__3 (ref), u12 (ref), u95 (ref)
                        local v110, v111 = pcall(function() --[[ Line: 278 ]]
                            -- upvalues: l__Networking__3 (ref)
                            return l__Networking__3.Guild.GetCompetition:Fire();
                        end);
                        if v110 and u12 then
                            u95(v111);
                        end;
                    end);
                end;
            end);
            l__GuiController__10.GuiUnfocusedSignal:Connect(function(p112) --[[ Line: 371 ]]
                -- upvalues: l__ViewGuildProgress__18 (copy), u12 (ref), u13 (ref)
                if p112 == l__ViewGuildProgress__18 then
                    u12 = false;
                    u13 = "ViewGuildPage";
                end;
            end);
        end;
    end);
end;
return v1;