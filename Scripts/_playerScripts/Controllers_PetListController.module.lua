-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__PetData__4 = require(l__ReplicatedStorage__2.SharedData.PetData);
local l__PetTypes__5 = require(l__ReplicatedStorage__2.SharedData.PetTypes);
local l__PetSlotPrices__6 = require(l__ReplicatedStorage__2.SharedData.PetSlotPrices);
local l__AnimatedGradient__7 = require(l__ReplicatedStorage__2.SharedModules.AnimatedGradient);
local l__Gradients__8 = l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("RarityData"):WaitForChild("Gradients");
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__GuiController__10 = require(l__LocalPlayer__9:WaitForChild("PlayerScripts"):WaitForChild("Controllers"):WaitForChild("GuiController"));
local u1 = {
    Common = Color3.fromRGB(180, 180, 180),
    Uncommon = Color3.fromRGB(60, 200, 70),
    Rare = Color3.fromRGB(60, 130, 255),
    Epic = Color3.fromRGB(160, 60, 220),
    Legendary = Color3.fromRGB(255, 215, 0),
    Mythic = Color3.fromRGB(220, 40, 40)
};
local u2 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(140, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 200))
});
local u3 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) });
local l__Common__11 = u1.Common;
local v4 = {
    StartOrder = 4
};
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = 0;
local function u19(p13, p14) --[[ Line: 138 ]]
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), l__Common__11 (copy)
    local v15 = u1[p14];
    if v15 then
        p13.TextColor3 = v15;
    elseif p14 == "Super" or p14 == "Secret" then
        p13.TextColor3 = Color3.new(1, 1, 1);
        for _, v16 in p13:GetChildren() do
            if v16:IsA("UIGradient") then
                v16:Destroy();
            end;
        end;
        local v17 = Instance.new("UIGradient");
        local v18;
        if p14 == "Super" then
            v18 = u2;
        else
            v18 = u3;
        end;
        v17.Color = v18;
        v17.Parent = p13;
    else
        p13.TextColor3 = l__Common__11;
    end;
end;
local function u24(p20, p21) --[[ Line: 173 ]]
    -- upvalues: u19 (copy)
    local v22 = p21 == "Super" and true or p21 == "Secret";
    if p20:IsA("TextLabel") and not v22 then
        u19(p20, p21);
    end;
    for _, v23 in p20:GetChildren() do
        if v23:IsA("TextLabel") then
            u19(v23, p21);
        end;
    end;
end;
local function u28(p25) --[[ Line: 187 ]]
    -- upvalues: l__AnimatedGradient__7 (copy), u2 (copy)
    p25.TextColor3 = Color3.new(1, 1, 1);
    for _, v26 in p25:GetChildren() do
        if v26:IsA("UIGradient") then
            l__AnimatedGradient__7:Remove(v26);
            v26:Destroy();
        end;
    end;
    local v27 = Instance.new("UIGradient");
    v27.Color = u2;
    v27.Parent = p25;
    l__AnimatedGradient__7:Add(v27);
end;
local function u31(p29) --[[ Line: 205 ]]
    -- upvalues: u28 (copy)
    for _, v30 in p29:GetChildren() do
        if v30:IsA("TextLabel") then
            u28(v30);
        end;
    end;
end;
local function u35(p32, p33) --[[ Line: 213 ]]
    if p32:IsA("TextLabel") then
        p32.Text = p33;
    end;
    for _, v34 in p32:GetChildren() do
        if v34:IsA("TextLabel") then
            v34.Text = p33;
        end;
    end;
end;
local function u59(p36, p37, p38) --[[ Line: 238 ]]
    -- upvalues: u8 (ref), l__PetData__4 (copy), l__GuiController__10 (copy), l__PetTypes__5 (copy), l__AnimatedGradient__7 (copy), l__Gradients__8 (copy), u2 (copy)
    if u8 then
        local v39 = l__PetData__4[p36] or {};
        local v40 = l__PetData__4.GetImage(p36, p37);
        local v41 = v39.Rarity or "Common";
        local v42 = l__PetData__4.GetDescription(p36, p37, p38);
        local v43 = u8:FindFirstChild("MainFrame");
        if v43 then
            v43 = v43:FindFirstChild("Content");
        end;
        if v43 then
            v43 = v43:FindFirstChild("Info");
        end;
        if v43 then
            local v44 = v43:FindFirstChild("ImageDisplay");
            if v44 then
                v44 = v44:FindFirstChild("PetImage");
            end;
            if v44 and v44:IsA("ImageLabel") then
                v44.Image = v40;
                if p38 == l__PetTypes__5.Rainbow then
                    l__AnimatedGradient__7:AddRainbowColor(v44, "ImageColor3");
                else
                    l__AnimatedGradient__7:Remove(v44);
                end;
            end;
            local v45 = l__PetData__4.GetDisplayName(p36, p37);
            local v46 = v43:FindFirstChild("PetName");
            if v46 and v46:IsA("TextLabel") then
                v46.Text = v45;
                local v47 = v46:FindFirstChild("TextLabel");
                if v47 and v47:IsA("TextLabel") then
                    v47.Text = v45;
                end;
            end;
            local v48 = v43:FindFirstChild("Description");
            if v48 and v48:IsA("TextLabel") then
                v48.Text = v42;
            end;
            local v49 = v43:FindFirstChild("Rarity");
            if v49 then
                for _, v50 in v49:GetChildren() do
                    if v50:IsA("UIGradient") then
                        v50:Destroy();
                    end;
                end;
                local v51 = l__Gradients__8:FindFirstChild(v41);
                if v51 then
                    v51:Clone().Parent = v49;
                end;
                local v52 = v49:FindFirstChild("Rarity_Text");
                if v52 and v52:IsA("TextLabel") then
                    v52.Text = v41;
                    local v53 = v52:FindFirstChild("TextLabel");
                    if v53 and v53:IsA("TextLabel") then
                        v53.Text = v41;
                    end;
                end;
            end;
            local v54 = v43:FindFirstChild("PetType");
            if v54 and v54:IsA("Frame") then
                local v55 = l__PetTypes__5.GetDisplayText(p38);
                local v56 = v54:FindFirstChildOfClass("UIGradient");
                if v55 then
                    v54.Visible = true;
                    local v57 = v54:FindFirstChild("PetType_Text");
                    if v57 and v57:IsA("TextLabel") then
                        v57.Text = v55;
                        local v58 = v57:FindFirstChild("TextLabel");
                        if v58 and v58:IsA("TextLabel") then
                            v58.Text = v55;
                        end;
                    end;
                    if v56 then
                        v56.Color = u2;
                        l__AnimatedGradient__7:Add(v56);
                    end;
                else
                    v54.Visible = false;
                    if v56 then
                        l__AnimatedGradient__7:Remove(v56);
                    end;
                end;
            end;
            l__GuiController__10:Open("PetInfo");
        else
            l__GuiController__10:Open("PetInfo");
        end;
    end;
end;
function v4.ShowPetInfo(_, p60, p61, p62) --[[ Line: 352 ]]
    -- upvalues: u59 (copy)
    u59(p60, p61, p62);
end;
local function u83(u63) --[[ Line: 366 ]]
    -- upvalues: u5 (ref), u6 (ref), u10 (copy), l__PetData__4 (copy), l__PetTypes__5 (copy), l__AnimatedGradient__7 (copy), u35 (copy), u31 (copy), u24 (copy), u12 (ref), u11 (copy), l__LocalPlayer__9 (copy), l__PetSlotPrices__6 (copy), u7 (ref), u9 (copy), l__Networking__3 (copy), u59 (copy)
    if u5 and u6 then
        if u10[u63.Id] then
        else
            local v64 = l__PetData__4[u63.Name] or {};
            local v65 = l__PetData__4.GetImage(u63.Name, u63.Size);
            local v66 = v64.Rarity or "Common";
            local v67 = u5:Clone();
            v67.Name = `PetEntry_{u63.Id}`;
            v67.Visible = true;
            local v68 = v67:FindFirstChild("Main_Frame");
            if v68 then
                local v69 = u63.Type == l__PetTypes__5.Rainbow;
                local v70 = v68:FindFirstChild("PetImage");
                if v70 and v70:IsA("ImageLabel") then
                    v70.Image = v65;
                    if v69 then
                        l__AnimatedGradient__7:AddRainbowColor(v70, "ImageColor3");
                    end;
                end;
                local v71 = v68:FindFirstChild("TextLabel");
                if v71 then
                    u35(v71, l__PetData__4.GetDisplayName(u63.Name, u63.Size));
                    if v69 then
                        u31(v71);
                    else
                        u24(v71, v66);
                    end;
                end;
                local v72 = v68:FindFirstChild("Unequip");
                if v72 and v72:IsA("GuiButton") then
                    v72.Activated:Connect(function() --[[ Line: 409 ]]
                        -- upvalues: u63 (copy), u10 (ref), u12 (ref), u11 (ref), l__LocalPlayer__9 (ref), l__PetSlotPrices__6 (ref), u7 (ref), u9 (ref), l__Networking__3 (ref)
                        local l__Id__12 = u63.Id;
                        local v73 = u10[l__Id__12];
                        if v73 then
                            u10[l__Id__12] = nil;
                            v73:Destroy();
                            local v74 = 0;
                            for _ in u10 do
                                v74 = v74 + 1;
                            end;
                            u12 = v74;
                            if #u11 ~= 0 then
                                local v75 = l__LocalPlayer__9:GetAttribute("MaxEquippedPets");
                                local v76 = `{u12}/{type(v75) == "number" and (v75 > 0 and math.floor(v75)) or l__PetSlotPrices__6.BaseMax} Active`;
                                for _, v77 in u11 do
                                    v77.Text = v76;
                                end;
                            end;
                            if u7 then
                                u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
                            end;
                        end;
                        l__Networking__3.Pets.RequestUnequip:Fire(u63.Id);
                    end);
                end;
                local v78 = v68:FindFirstChild("InfoFrame");
                if v78 then
                    v78 = v78:FindFirstChild("InfoButton");
                end;
                if v78 and v78:IsA("GuiButton") then
                    v78.Activated:Connect(function() --[[ Line: 425 ]]
                        -- upvalues: u59 (ref), u63 (copy)
                        u59(u63.Name, u63.Size, u63.Type);
                    end);
                end;
                v67.Parent = u6;
                u10[u63.Id] = v67;
                local v79 = 0;
                for _ in u10 do
                    v79 = v79 + 1;
                end;
                u12 = v79;
                if #u11 ~= 0 then
                    local v80 = l__LocalPlayer__9:GetAttribute("MaxEquippedPets");
                    local v81 = `{u12}/{type(v80) == "number" and (v80 > 0 and math.floor(v80)) or l__PetSlotPrices__6.BaseMax} Active`;
                    for _, v82 in u11 do
                        v82.Text = v81;
                    end;
                end;
                if u7 then
                    u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
                end;
            else
                v67:Destroy();
            end;
        end;
    end;
end;
local function u92(p84) --[[ Line: 436 ]]
    -- upvalues: u10 (copy), u12 (ref), u11 (copy), l__LocalPlayer__9 (copy), l__PetSlotPrices__6 (copy), u7 (ref), u9 (copy), u83 (copy)
    for v85 in u10 do
        local v86 = u10[v85];
        if v86 then
            u10[v85] = nil;
            v86:Destroy();
            local v87 = 0;
            for _ in u10 do
                v87 = v87 + 1;
            end;
            u12 = v87;
            if #u11 ~= 0 then
                local v88 = l__LocalPlayer__9:GetAttribute("MaxEquippedPets");
                local v89 = `{u12}/{type(v88) == "number" and (v88 > 0 and math.floor(v88)) or l__PetSlotPrices__6.BaseMax} Active`;
                for _, v90 in u11 do
                    v90.Text = v89;
                end;
            end;
            if u7 then
                u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
            end;
        end;
    end;
    if type(p84) == "table" then
        for _, v91 in p84 do
            if type(v91) == "table" and type(v91.Id) == "string" then
                u83(v91);
            end;
        end;
    end;
end;
function v4.Start(_) --[[ Line: 451 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u7 (ref), u8 (ref), l__GuiController__10 (copy), u6 (ref), u5 (ref), u11 (copy), l__PetSlotPrices__6 (copy), l__Networking__3 (copy), u12 (ref), u83 (copy), u10 (copy), u9 (copy), u92 (copy)
    local l__PlayerGui__13 = l__LocalPlayer__9:WaitForChild("PlayerGui");
    local l__PetList__14 = l__PlayerGui__13:WaitForChild("PetList", 30);
    if not l__PetList__14 then
        return;
    end;
    if l__PetList__14:IsA("ScreenGui") then
        u7 = l__PetList__14;
        u7.Enabled = false;
    end;
    local l__PetInfo__15 = l__PlayerGui__13:WaitForChild("PetInfo", 10);
    if l__PetInfo__15 and l__PetInfo__15:IsA("ScreenGui") then
        u8 = l__PetInfo__15;
        u8.Enabled = false;
        local v93 = l__PetInfo__15:FindFirstChild("MainFrame");
        if v93 then
            v93 = v93:FindFirstChild("Header");
        end;
        if v93 then
            v93 = v93:FindFirstChild("ExitButton");
        end;
        if v93 and v93:IsA("GuiButton") then
            v93.Activated:Connect(function() --[[ Line: 482 ]]
                -- upvalues: l__GuiController__10 (ref)
                l__GuiController__10:Close();
            end);
        end;
    end;
    local l__Frame__16 = l__PetList__14:WaitForChild("Frame", 10);
    local v94;
    if l__Frame__16 then
        v94 = l__Frame__16:WaitForChild("Notepad", 10);
    else
        v94 = l__Frame__16;
    end;
    local v95;
    if v94 then
        v95 = v94:WaitForChild("ScrollingFrame", 10);
    else
        v95 = v94;
    end;
    local v96;
    if v95 then
        v96 = v95:WaitForChild("Template", 10);
    else
        v96 = v95;
    end;
    if not (l__Frame__16 and (v94 and (v95 and v96))) then
        return;
    end;
    if not v96:IsA("GuiObject") then
        return;
    end;
    u6 = v95;
    u5 = v96;
    v96.Visible = false;
    local v97 = l__Frame__16:FindFirstChild("Header");
    if v97 then
        v97 = v97:FindFirstChild("TextLabel");
    end;
    if v97 and v97:IsA("TextLabel") then
        table.insert(u11, v97);
        for _, v98 in v97:GetChildren() do
            if v98:IsA("TextLabel") then
                table.insert(u11, v98);
            end;
        end;
    end;
    local u99 = {};
    local function u106() --[[ Line: 527 ]]
        -- upvalues: l__LocalPlayer__9 (ref), l__PetSlotPrices__6 (ref), u99 (copy)
        local v100 = l__LocalPlayer__9:GetAttribute("MaxEquippedPets");
        local v101;
        if type(v100) == "number" and v100 > 0 then
            v101 = math.floor(v100);
        else
            v101 = l__PetSlotPrices__6.BaseMax;
        end;
        local v102 = l__PetSlotPrices__6.GetNextPrice(v101);
        local v103 = not v102 and "MAX" or l__PetSlotPrices__6.AbbreviatePrice(v102);
        if v103 == "MAX" then
            for _, v104 in u99 do
                v104.Text = "MAX SLOTS";
            end;
        else
            for _, v105 in u99 do
                v105.Text = "+1 MAX [" .. tostring(v103) .. "¢]";
            end;
        end;
    end;
    local v107 = l__Frame__16:FindFirstChild("MaxSlot", true) or l__Frame__16:FindFirstChild("HeaderMaxSlot", true) or (l__PetList__14:FindFirstChild("MaxSlot", true) or l__PetList__14:FindFirstChild("HeaderMaxSlot", true));
    local v108 = nil;
    if v107 then
        if v107:IsA("GuiButton") then
            v108 = v107;
        else
            for _, v109 in v107:GetDescendants() do
                if v109:IsA("GuiButton") then
                    v108 = v109;
                    break;
                end;
            end;
        end;
    end;
    if v107 then
        local v110 = v107:FindFirstChild("Purchase");
        if v110 then
            for _, v111 in v110:GetDescendants() do
                if v111:IsA("TextLabel") then
                    table.insert(u99, v111);
                end;
            end;
            local _ = #u99 == 0;
        end;
        if v108 then
            v108.Activated:Connect(function() --[[ Line: 595 ]]
                -- upvalues: l__Networking__3 (ref)
                l__Networking__3.Pets.RequestPurchasePetSlot:Fire();
            end);
        end;
    end;
    l__LocalPlayer__9:GetAttributeChangedSignal("MaxEquippedPets"):Connect(function() --[[ Line: 602 ]]
        -- upvalues: u11 (ref), l__LocalPlayer__9 (ref), l__PetSlotPrices__6 (ref), u12 (ref), u106 (copy)
        if #u11 ~= 0 then
            local v112 = l__LocalPlayer__9:GetAttribute("MaxEquippedPets");
            local v113 = `{u12}/{type(v112) == "number" and (v112 > 0 and math.floor(v112)) or l__PetSlotPrices__6.BaseMax} Active`;
            for _, v114 in u11 do
                v114.Text = v113;
            end;
        end;
        u106();
    end);
    if #u11 ~= 0 then
        local v115 = l__LocalPlayer__9:GetAttribute("MaxEquippedPets");
        local v116 = `{u12}/{type(v115) == "number" and (v115 > 0 and math.floor(v115)) or l__PetSlotPrices__6.BaseMax} Active`;
        for _, v117 in u11 do
            v117.Text = v116;
        end;
    end;
    u106();
    l__Networking__3.Pets.PetEquipped.OnClientEvent:Connect(function(p118, p119) --[[ Line: 614 ]]
        -- upvalues: u83 (ref)
        if type(p118) == "string" then
            if type(p119) == "table" then
                p119.Id = p119.Id or p118;
                p119.Name = p119.Name or "Pet";
                u83(p119);
            end;
        end;
    end);
    l__Networking__3.Pets.PetUnequipped.OnClientEvent:Connect(function(p120) --[[ Line: 624 ]]
        -- upvalues: u10 (ref), u12 (ref), u11 (ref), l__LocalPlayer__9 (ref), l__PetSlotPrices__6 (ref), u7 (ref), u9 (ref)
        if type(p120) == "string" then
            local v121 = u10[p120];
            if v121 then
                u10[p120] = nil;
                v121:Destroy();
                local v122 = 0;
                for _ in u10 do
                    v122 = v122 + 1;
                end;
                u12 = v122;
                if #u11 ~= 0 then
                    local v123 = l__LocalPlayer__9:GetAttribute("MaxEquippedPets");
                    local v124 = `{u12}/{type(v123) == "number" and (v123 > 0 and math.floor(v123)) or l__PetSlotPrices__6.BaseMax} Active`;
                    for _, v125 in u11 do
                        v125.Text = v124;
                    end;
                end;
                if not u7 then
                    return;
                end;
                u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
            end;
        end;
    end);
    local function u137(p126) --[[ Line: 648 ]]
        -- upvalues: u9 (ref), u7 (ref), u10 (ref)
        for _, u127 in p126:GetChildren() do
            if u127:IsA("Tool") then
                local function v129() --[[ Line: 630 ]]
                    -- upvalues: u127 (copy), u9 (ref), u7 (ref), u10 (ref)
                    local v128 = u127:GetAttribute("PetId");
                    if type(v128) == "string" and v128 ~= "" then
                        u9[v128] = true;
                        if not u7 then
                            return;
                        end;
                        u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
                    end;
                end;
                local v130 = u127:GetAttribute("PetId");
                if type(v130) == "string" and v130 ~= "" then
                    u9[v130] = true;
                    if u7 then
                        u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
                    end;
                end;
                u127:GetAttributeChangedSignal("PetId"):Connect(v129);
            end;
        end;
        p126.ChildAdded:Connect(function(u131) --[[ Line: 652 ]]
            -- upvalues: u9 (ref), u7 (ref), u10 (ref)
            if u131:IsA("Tool") then
                local function v133() --[[ Line: 630 ]]
                    -- upvalues: u131 (copy), u9 (ref), u7 (ref), u10 (ref)
                    local v132 = u131:GetAttribute("PetId");
                    if type(v132) == "string" and v132 ~= "" then
                        u9[v132] = true;
                        if not u7 then
                            return;
                        end;
                        u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
                    end;
                end;
                local v134 = u131:GetAttribute("PetId");
                if type(v134) == "string" and v134 ~= "" then
                    u9[v134] = true;
                    if u7 then
                        u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
                    end;
                end;
                u131:GetAttributeChangedSignal("PetId"):Connect(v133);
            end;
        end);
        p126.ChildRemoved:Connect(function(p135) --[[ Line: 655 ]]
            -- upvalues: u9 (ref), u7 (ref), u10 (ref)
            if p135:IsA("Tool") then
                local v136 = p135:GetAttribute("PetId");
                if type(v136) == "string" then
                    if v136 == "" then
                        return;
                    end;
                    u9[v136] = nil;
                    if not u7 then
                        return;
                    end;
                    u7.Enabled = next(u10) ~= nil and true or next(u9) ~= nil;
                end;
            end;
        end);
    end;
    task.spawn(function() --[[ Line: 660 ]]
        -- upvalues: l__LocalPlayer__9 (ref), u137 (copy)
        local l__Backpack__17 = l__LocalPlayer__9:WaitForChild("Backpack", 30);
        if l__Backpack__17 then
            u137(l__Backpack__17);
        end;
    end);
    local function v139(p138) --[[ Line: 665 ]]
        -- upvalues: u137 (copy)
        u137(p138);
    end;
    if l__LocalPlayer__9.Character then
        u137(l__LocalPlayer__9.Character);
    end;
    l__LocalPlayer__9.CharacterAdded:Connect(v139);
    task.spawn(function() --[[ Line: 676 ]]
        -- upvalues: l__Networking__3 (ref), u92 (ref)
        local v140, v141 = pcall(function() --[[ Line: 677 ]]
            -- upvalues: l__Networking__3 (ref)
            return l__Networking__3.Pets.GetEquippedPets:Fire();
        end);
        if v140 and type(v141) == "table" then
            u92(v141);
        end;
    end);
end;
return v4;