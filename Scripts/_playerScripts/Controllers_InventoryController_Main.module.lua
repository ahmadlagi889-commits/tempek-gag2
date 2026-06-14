-- Decompiled with Potassium's decompiler.

local u1 = {
    OpenClose = nil,
    IsOpen = false,
    StateChanged = Instance.new("BindableEvent")
};
local l__SideBar__1 = script.SideBar;
MushroomData = require(game.ReplicatedStorage.SharedModules.MushroomData);
GnomeData = require(game.ReplicatedStorage.SharedModules.GnomeData);
RaccoonData = require(game.ReplicatedStorage.SharedModules.RaccoonData);
CrateData = require(game.ReplicatedStorage.SharedModules.CrateData);
SeedPackData = require(game.ReplicatedStorage.SharedModules.SeedPackData);
EggData = require(game.ReplicatedStorage.SharedModules.EggData);
TeleporterData = require(game.ReplicatedStorage.SharedModules.TeleporterData);
PowerHoseData = require(game.ReplicatedStorage.SharedModules.PowerHoseData);
MutationData = require(game.ReplicatedStorage.SharedModules.MutationData);
WeightFormat = require(game.ReplicatedStorage.SharedModules.WeightFormat);
PetData = require(game.ReplicatedStorage.SharedData.PetData);
u1.ModuleName = "Backpack";
u1.KeepVRTopbarOpen = true;
u1.VRIsExclusive = true;
u1.VRClosesNonExclusive = true;
ImageData = game.ReplicatedStorage.SharedModules.SeedData;
FruitImages = ImageData.FruitImages;
PlantImages = ImageData.PlantImages;
SeedImages = ImageData.SeedImages;
BuildIMG = "rbxassetid://123856554248782";
ICON_SIZE = 60;
FONT_SIZE = script:GetAttribute("TextSize");
ICON_BUFFER = 5;
BACKGROUND_FADE = script:GetAttribute("BackgroundTransparency");
BACKGROUND_COLOR = script:GetAttribute("BackgroundColor");
VR_FADE_TIME = 1;
VR_PANEL_RESOLUTION = 100;
SLOT_DRAGGABLE_COLOR = script:GetAttribute("DraggableColor");
SLOT_EQUIP_COLOR = script:GetAttribute("EquippedColor");
SLOT_EQUIP_THICKNESS = 3;
SLOT_FADE_LOCKED = script:GetAttribute("SlotLockedTransparency");
SLOT_BORDER_COLOR = script:GetAttribute("BorderColor");
TOOLTIP_BUFFER = 24;
TOOLTIP_HEIGHT = 24;
TOOLTIP_OFFSET = -28;
ARROW_HOTKEY = { Enum.KeyCode.Backquote, Enum.KeyCode.DPadUp };
HOTBAR_SLOTS_FULL = script:GetAttribute("FullSlots");
HOTBAR_SLOTS_VR = script:GetAttribute("EmptySlots");
HOTBAR_SLOTS_MINI = 5;
HOTBAR_SLOTS_WIDTH_CUTOFF = 1024;
HOTBAR_OFFSET_FROMBOTTOM = -30;
INVENTORY_ROWS_FULL = 4;
INVENTORY_ROWS_VR = 3;
INVENTORY_ROWS_MINI = 2;
INVENTORY_HEADER_SIZE = 40;
INVENTORY_ARROWS_BUFFER_VR = 40;
local v2 = script:GetAttribute("SearchBoxColor");
local v3 = script:GetAttribute("SearchBoxTransparency");
local l__Api__2 = script:WaitForChild("Api");
l__Api__2.Parent = game.ReplicatedStorage;
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Networking__4 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__FruitProxyUtil__5 = require(l__ReplicatedStorage__3.SharedModules.FruitProxyUtil);
local l__AnimatedGradient__6 = require(l__ReplicatedStorage__3.SharedModules.AnimatedGradient);
local u4 = true;
local u5 = false;
local l__Value__7 = Enum.KeyCode.Zero.Value;
local l__Value__8 = Enum.KeyCode.Backspace.Value;
local u6 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
};
local l__UserInputService__9 = game:GetService("UserInputService");
local l__Players__10 = game:GetService("Players");
game:GetService("ReplicatedStorage");
local l__StarterGui__11 = game:GetService("StarterGui");
local l__GuiService__12 = game:GetService("GuiService");
local v7 = Instance.new("ScreenGui", l__Players__10.LocalPlayer.PlayerGui);
v7.DisplayOrder = 120;
v7.IgnoreGuiInset = true;
v7.ResetOnSpawn = false;
v7.Name = "BackpackGui";
local l__ContextActionService__13 = game:GetService("ContextActionService");
local l__ProximityPromptService__14 = game:GetService("ProximityPromptService");
local l__RunService__15 = game:GetService("RunService");
local l__VRService__16 = game:GetService("VRService");
local l__Utility__17 = require(script.Utility);
require(script.GameTranslator);
local l__topbarplus__18 = require(game:GetService("ReplicatedStorage").ClientModules.topbarplus);
require(game.ReplicatedStorage.SharedModules.SeedData);
local l__SprinklerData__19 = require(game.ReplicatedStorage.SharedModules.SprinklerData);
local l__RakeData__20 = require(game.ReplicatedStorage.SharedModules.RakeData);
local l__WateringcanData__21 = require(game.ReplicatedStorage.SharedModules.WateringcanData);
local l__ShovelData__22 = require(game.ReplicatedStorage.SharedModules.ShovelData);
local l__TrowelData__23 = require(game.ReplicatedStorage.SharedModules.TrowelData);
local l__BuildData__24 = require(game.ReplicatedStorage.SharedModules.BuildData);
local l__CrowbarData__25 = require(game.ReplicatedStorage.SharedModules.CrowbarData);
local l__IMG__26 = l__ShovelData__22.Data.IMG;
local l__IMG__27 = l__TrowelData__23.Data.IMG;
local l__IMG__28 = l__BuildData__24.Data.IMG;
local l__IMG__29 = l__CrowbarData__25.Data.IMG;
local u8 = l__GuiService__12:IsTenFootInterface();
if u8 then
    ICON_SIZE = 100;
    FONT_SIZE = 24;
end;
local u9 = false;
local u10 = false;
local l__TouchEnabled__30 = l__UserInputService__9.TouchEnabled;
if l__TouchEnabled__30 then
    l__TouchEnabled__30 = not l__UserInputService__9.KeyboardEnabled;
end;
local l__LocalPlayer__31 = l__Players__10.LocalPlayer;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = l__LocalPlayer__31.Character or l__LocalPlayer__31.CharacterAdded:Wait();
local u19 = u18:FindFirstChildOfClass("Humanoid");
local l__Backpack__32 = l__LocalPlayer__31:WaitForChild("Backpack");
local u20 = l__topbarplus__18.new();
u20:setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "deselected");
u20:setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "selected");
u20:bindToggleKey(ARROW_HOTKEY[1], ARROW_HOTKEY[2]);
u20:setName("InventoryIcon");
u20:setImageScale(1.12);
u20:setOrder(0);
u20:setCaption("Toggle the backpack.");
u20.deselectWhenOtherIconSelected = false;
local u21 = l__topbarplus__18.new();
u21:setImage("rbxassetid://125872769879713", "deselected");
u21:setImage("rbxassetid://125872769879713", "selected");
u21:setName("ShopIcon");
u21:bindToggleKey(Enum.KeyCode.P);
u21:setImageScale(1.12);
u21:setOrder(1);
u21:setCaption("Open the shop.");
u21:setEnabled(true);
u21.deselectWhenOtherIconSelected = false;
local u22 = l__topbarplus__18.new();
u22:setImage("rbxassetid://96480124490680", "deselected");
u22:setImage("rbxassetid://96480124490680", "selected");
u22:setName("SettingIcon");
u22:bindToggleKey(Enum.KeyCode.L);
u22:setImageScale(1.12);
u22:setOrder(1);
u22:setCaption("Open the settings.");
u22:setEnabled(true);
u22.deselectWhenOtherIconSelected = false;
local u23 = l__topbarplus__18.new();
u23:setImage(l__IMG__28, "deselected");
u23:setImage(l__IMG__28, "selected");
u23:setName("BuildIcon");
u23:bindToggleKey(Enum.KeyCode.B);
u23:setImageScale(1.12);
u23:setOrder(2);
u23:setCaption("Equip build tool.");
u23:setEnabled(false);
u23.deselectWhenOtherIconSelected = false;
local u24 = {};
local u25 = nil;
local u26 = {};
local u27 = {};
local u28 = {};
local u29 = 0;
local u30 = false;
local u31 = false;
local u32 = false;
local u33 = false;
local u34 = {};
local u35 = {};
local u36 = false;
local u37 = 0;
local l__VREnabled__33 = l__VRService__16.VREnabled;
local u38 = l__VREnabled__33 and HOTBAR_SLOTS_VR or (u10 and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL);
local u39 = l__VREnabled__33 and INVENTORY_ROWS_VR or (u10 and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL);
local u40 = nil;
local u41 = "All";
local u42 = nil;
local u43 = nil;
local u44 = nil;
local u45 = nil;
local function u49(p46) --[[ Line: 270 ]]
    -- upvalues: l__FruitProxyUtil__5 (copy), l__Networking__4 (copy)
    local l__Tool__34 = p46.Tool;
    if l__Tool__34 and l__FruitProxyUtil__5.IsFruitInstance(l__Tool__34) then
        local u47 = l__Tool__34:GetAttribute("Id");
        if u47 then
            local u48 = l__Tool__34:GetAttribute("IsFavorite") ~= true;
            l__Tool__34:SetAttribute("IsFavorite", u48 and true or nil);
            task.spawn(function() --[[ Line: 277 ]]
                -- upvalues: l__Networking__4 (ref), u47 (copy), u48 (copy)
                l__Networking__4.Backpack.SetFruitFavorite:Fire(u47, u48);
            end);
        end;
    end;
end;
local u50 = nil;
local u51 = false;
local u52 = false;
local u53 = true;
function GetToolKey(p54)
    -- upvalues: l__FruitProxyUtil__5 (copy)
    if p54 then
        if p54:IsA("Tool") or l__FruitProxyUtil__5.IsFruitProxy(p54) then
            if p54:GetAttribute("SeedTool") then
                return "Seed:" .. p54:GetAttribute("SeedTool");
            elseif p54:GetAttribute("Fruit") then
                local v55 = "Fruit:" .. p54:GetAttribute("Fruit");
                local v56 = p54:GetAttribute("Mutation");
                if v56 then
                    v55 = v55 .. ":" .. v56;
                end;
                local v57 = p54:GetAttribute("Weight");
                if v57 then
                    local v58 = math.floor(v57 * 1000);
                    v55 = v55 .. ":" .. tostring(v58);
                end;
                return v55;
            elseif p54:GetAttribute("Sprinkler") then
                return "Sprinkler:" .. p54:GetAttribute("Sprinkler");
            elseif p54:GetAttribute("Rake") then
                return "Rake:" .. p54:GetAttribute("Rake");
            elseif p54:GetAttribute("WateringCan") then
                return "WateringCan:" .. p54:GetAttribute("WateringCan");
            elseif p54:GetAttribute("Shovel") then
                return "Shovel:" .. p54:GetAttribute("Shovel");
            elseif p54:GetAttribute("Trowel") then
                return "Trowel:" .. p54:GetAttribute("Trowel");
            elseif p54:GetAttribute("Crowbar") then
                return "Crowbar:" .. p54:GetAttribute("Crowbar");
            elseif p54:GetAttribute("Build") then
                return "Build:" .. p54:GetAttribute("Build");
            elseif p54:GetAttribute("Mushroom") then
                return "Mushroom:" .. p54:GetAttribute("Mushroom");
            elseif p54:GetAttribute("Gnome") then
                return "Gnome:" .. p54:GetAttribute("Gnome");
            elseif p54:GetAttribute("SeedPack") then
                return "SeedPack:" .. p54:GetAttribute("SeedPack");
            elseif p54:GetAttribute("Egg") then
                return "Egg:" .. p54:GetAttribute("Egg");
            elseif p54:GetAttribute("Crate") then
                return "Crate:" .. p54:GetAttribute("Crate");
            elseif p54:GetAttribute("Teleporter") then
                return "Teleporter:" .. p54:GetAttribute("Teleporter");
            elseif p54:GetAttribute("PowerHose") then
                return "PowerHose:" .. p54:GetAttribute("PowerHose");
            elseif p54:GetAttribute("Wheelbarrow") then
                return "Wheelbarrow:" .. p54:GetAttribute("Wheelbarrow");
            elseif p54:GetAttribute("Ladder") then
                return "Ladder:" .. p54:GetAttribute("Ladder");
            elseif p54:GetAttribute("FreezeRay") then
                return "FreezeRay:" .. p54:GetAttribute("FreezeRay");
            elseif p54:GetAttribute("Flashbang") then
                return "Flashbang:" .. p54:GetAttribute("Flashbang");
            elseif p54:GetAttribute("Bird") then
                return "Bird:" .. p54:GetAttribute("Bird");
            else
                return "Name:" .. p54.Name;
            end;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
local function u78() --[[ Line: 383 ]]
    -- upvalues: u50 (ref), u51 (ref), u38 (ref), u24 (ref), u25 (ref), u42 (ref), u43 (ref), u16 (ref), l__FruitProxyUtil__5 (copy), u44 (ref), u45 (ref)
    if not u50 or u51 then
        return;
    end;
    local v59 = 0;
    for _ in pairs(u50) do
        v59 = v59 + 1;
    end;
    if v59 == 0 then
        u51 = true;
        return;
    end;
    u51 = true;
    local v60 = {};
    for v61 = 1, u38 do
        local v62 = u24[v61];
        if v62 and v62.Tool then
            table.insert(v60, v62.Tool);
            v62:Clear();
        end;
    end;
    local v63 = {};
    for v64 = #u24, u38 + 1, -1 do
        local v65 = u24[v64];
        if v65 and v65.Tool then
            table.insert(v63, v65.Tool);
            v65:Clear();
            v65:Delete();
        end;
    end;
    local v66 = {};
    for _, v67 in v60 do
        table.insert(v66, v67);
    end;
    for _, v68 in v63 do
        table.insert(v66, v68);
    end;
    local v69 = {};
    for v70, v71 in pairs(u50) do
        local v72 = tonumber(v70);
        if v72 and (v72 >= 1 and v72 <= u38) then
            for _, v73 in v66 do
                if not v69[v73] and GetToolKey(v73) == v71 then
                    u24[v72]:Fill(v73);
                    v69[v73] = true;
                    break;
                end;
            end;
        end;
    end;
    for _, v74 in v66 do
        if not v69[v74] then
            u25 = u42();
            (u25 or u43(u16)):Fill(v74);
            v69[v74] = true;
        end;
    end;
    for v75 = 1, u38 do
        local v76 = u24[v75];
        if v76 and (v76.Tool and l__FruitProxyUtil__5.IsFruitProxy(v76.Tool)) then
            local v77 = v76.Tool:GetAttribute("Id");
            if v77 then
                l__FruitProxyUtil__5.Pending.Slots[v77] = v75;
                l__FruitProxyUtil__5.RequestPromote(v77);
            end;
        end;
    end;
    u25 = u42();
    u44();
    u45();
end;
local function u82(p79, p80) --[[ Line: 468 ]]
    if p80 == "All" then
        return true;
    else
        local v81 = p79:GetAttribute("MainCategory");
        if p80 == "Seeds" then
            return v81 == "Seed" and true or p79:GetAttribute("SeedTool") ~= nil;
        elseif p80 == "Fruits" then
            return v81 == "Fruit" and true or p79:GetAttribute("Fruit") ~= nil;
        elseif p80 == "Pets" then
            return v81 == "Pet" and true or p79:GetAttribute("Pet") ~= nil;
        else
            return p80 ~= "Gears" and true or ((v81 == "Gear" or v81 == "Egg") and true or ((p79:GetAttribute("Egg") ~= nil or (p79:GetAttribute("Sprinkler") ~= nil or (p79:GetAttribute("WateringCan") ~= nil or (p79:GetAttribute("Shovel") ~= nil or (p79:GetAttribute("Trowel") ~= nil or (p79:GetAttribute("Crowbar") ~= nil or (p79:GetAttribute("Build") ~= nil or (p79:GetAttribute("Mushroom") ~= nil or (p79:GetAttribute("Gnome") ~= nil or (p79:GetAttribute("Crate") ~= nil or (p79:GetAttribute("Teleporter") ~= nil or (p79:GetAttribute("PowerHose") ~= nil or (p79:GetAttribute("Wheelbarrow") ~= nil or (p79:GetAttribute("Ladder") ~= nil or (p79:GetAttribute("FreezeRay") ~= nil or (p79:GetAttribute("Rake") ~= nil or p79:GetAttribute("Flashbang") ~= nil)))))))))))))))) and true or p79:GetAttribute("Bird") ~= nil));
        end;
    end;
end;
local function u86(p83, p84) --[[ Line: 528 ]]
    local v85 = Instance.new(p83);
    v85.Name = p84;
    v85.BackgroundColor3 = Color3.new(0, 0, 0);
    v85.BackgroundTransparency = 1;
    v85.BorderColor3 = Color3.new(0, 0, 0);
    v85.BorderSizePixel = 0;
    v85.Size = UDim2.new(1, 0, 1, 0);
    if p83:match("Text") then
        v85.TextColor3 = Color3.new(1, 1, 1);
        v85.Text = "";
        v85.FontFace = script:GetAttribute("LabelFont");
        v85.TextSize = FONT_SIZE;
        v85.TextWrapped = true;
        if p83 == "TextButton" then
            v85.FontFace = script:GetAttribute("SlotFont");
        end;
    end;
    return v85;
end;
u42 = function() --[[ Line: 550 ]]
    -- upvalues: u38 (ref), u24 (ref)
    for v87 = 1, u38 do
        local v88 = u24[v87];
        if not v88.Tool then
            return v88;
        end;
    end;
    return nil;
end;
local function u91() --[[ Line: 575 ]]
    -- upvalues: l__Backpack__32 (ref), u18 (ref)
    if l__Backpack__32 then
        for _, v89 in l__Backpack__32:GetChildren() do
            if v89:IsA("Tool") and v89:GetAttribute("Build") then
                return v89;
            end;
        end;
    end;
    if u18 then
        for _, v90 in u18:GetChildren() do
            if v90:IsA("Tool") and v90:GetAttribute("Build") then
                return v90;
            end;
        end;
    end;
    return nil;
end;
local function u93() --[[ Line: 595 ]]
    -- upvalues: u18 (ref)
    if not u18 then
        return false;
    end;
    for _, v92 in u18:GetChildren() do
        if v92:IsA("Tool") and v92:GetAttribute("Build") then
            return true;
        end;
    end;
    return false;
end;
local function u97() --[[ Line: 607 ]]
    -- upvalues: u91 (copy), u23 (copy), u5 (ref), u10 (ref), u93 (copy)
    local v94 = u91();
    local v95 = u23;
    local v96;
    if v94 == nil then
        v96 = false;
    else
        v96 = not u5;
        if v96 then
            v96 = not u10;
        end;
    end;
    v95:setEnabled(v96);
    if v94 then
        if u93() then
            u23:select();
            return;
        end;
        u23:deselect();
    end;
end;
u23.selected:Connect(function() --[[ Line: 623 ]]
    -- upvalues: u91 (copy), u93 (copy), u19 (ref), u18 (ref)
    local v98 = u91();
    if v98 and not u93() then
        if u19 then
            u19:UnequipTools();
        end;
        v98.Parent = u18;
    end;
end);
u23.deselected:Connect(function() --[[ Line: 633 ]]
    -- upvalues: u93 (copy), u19 (ref)
    if u93() and u19 then
        u19:UnequipTools();
    end;
end);
task.spawn(function() --[[ Line: 641 ]]
    -- upvalues: u21 (copy), u22 (copy), u13 (ref), u1 (copy), u5 (ref), u23 (copy), u97 (ref)
    local l__LocalPlayer__35 = game.Players.LocalPlayer;
    repeat
        task.wait();
    until l__LocalPlayer__35:HasTag("ControllersStarted");
    local l__GuiController__36 = require(l__LocalPlayer__35.PlayerScripts:WaitForChild("Controllers"):WaitForChild("GuiController"));
    u21.selected:Connect(function() --[[ Line: 647 ]]
        -- upvalues: l__GuiController__36 (copy)
        if l__GuiController__36:IsOpen("RobuxShop") then
            l__GuiController__36:Close("RobuxShop");
        else
            l__GuiController__36:Open("RobuxShop", nil, { "HUD" });
        end;
    end);
    u21.deselected:Connect(function() --[[ Line: 655 ]]
        -- upvalues: l__GuiController__36 (copy)
        if l__GuiController__36:IsOpen("RobuxShop") then
            l__GuiController__36:Close("RobuxShop");
        else
            l__GuiController__36:Open("RobuxShop", nil, { "HUD" });
        end;
    end);
    u22.selected:Connect(function() --[[ Line: 663 ]]
        -- upvalues: l__GuiController__36 (copy)
        if l__GuiController__36:IsOpen("Settings") then
            l__GuiController__36:Close("Settings");
        else
            l__GuiController__36:Open("Settings", nil, { "HUD" });
        end;
    end);
    u22.deselected:Connect(function() --[[ Line: 671 ]]
        -- upvalues: l__GuiController__36 (copy)
        if l__GuiController__36:IsOpen("Settings") then
            l__GuiController__36:Close("Settings");
        else
            l__GuiController__36:Open("Settings", nil, { "HUD" });
        end;
    end);
    l__GuiController__36.GuiFocusedSignal:Connect(function() --[[ Line: 679 ]]
        -- upvalues: u13 (ref), u1 (ref), u5 (ref), u21 (ref), u22 (ref), u23 (ref)
        if u13 and u13.Visible then
            u1.OpenClose();
        end;
        u5 = true;
        u21:setEnabled(false);
        u22:setEnabled(false);
        u23:setEnabled(false);
    end);
    l__GuiController__36.GuiUnfocusedSignal:Connect(function() --[[ Line: 690 ]]
        -- upvalues: u5 (ref), u21 (ref), u22 (ref), u97 (ref)
        u5 = false;
        u21:setEnabled(true);
        u22:setEnabled(true);
        u97();
    end);
end);
u44 = function() --[[ Line: 699 ]]
    -- upvalues: u13 (ref), u38 (ref), u29 (ref), u24 (ref)
    local l__Visible__37 = u13.Visible;
    local v99 = l__Visible__37 and u38 or u29;
    local _ = v99 >= 1;
    local v100 = 0;
    for v101 = 1, u38 do
        local v102 = u24[v101];
        if v102.Tool or l__Visible__37 then
            v100 = v100 + 1;
            v102:Readjust(v100, v99);
            v102.Frame.Visible = true;
        else
            v102.Frame.Visible = false;
        end;
    end;
end;
local u103 = 0;
local function u106() --[[ Line: 725 ]]
    -- upvalues: u15 (ref), u103 (ref)
    local v104 = math.floor(u15.AbsoluteSize.X / (ICON_SIZE + ICON_BUFFER));
    local v105 = math.ceil(u103 / (v104 < 1 and 1 or v104)) * (ICON_SIZE + ICON_BUFFER) + ICON_BUFFER;
    u15.CanvasSize = UDim2.new(0, 0, 0, v105);
end;
u45 = function() --[[ Line: 734 ]]
    -- upvalues: u1 (copy), u33 (ref), u38 (ref), u24 (ref), u82 (copy), u41 (ref), u103 (ref), u106 (ref)
    local l___ApplySearch__38 = u1._ApplySearch;
    if u33 and l___ApplySearch__38 then
        l___ApplySearch__38();
    else
        local v107 = 0;
        for v108 = u38 + 1, #u24 do
            local v109 = u24[v108];
            v109.Frame.LayoutOrder = v109.Index;
            local v110;
            if v109.Tool == nil then
                v110 = false;
            else
                v110 = u82(v109.Tool, u41);
            end;
            v109.Frame.Visible = v110;
            if v110 then
                v107 = v107 + 1;
            end;
        end;
        u103 = v107;
        u106();
    end;
end;
local u111 = false;
local u112 = u97;
local u113 = false;
u97 = function() --[[ Line: 782 ]]
    -- upvalues: u113 (ref), u112 (copy)
    if u113 then
    else
        u113 = true;
        task.defer(function() --[[ Line: 785 ]]
            -- upvalues: u113 (ref), u112 (ref)
            u113 = false;
            u112();
        end);
    end;
end;
local u114 = u44;
local u115 = false;
u44 = function() --[[ Line: 793 ]]
    -- upvalues: u115 (ref), u114 (copy)
    if u115 then
    else
        u115 = true;
        task.defer(function() --[[ Line: 796 ]]
            -- upvalues: u115 (ref), u114 (ref)
            u115 = false;
            u114();
        end);
    end;
end;
local u116 = u106;
local u117 = false;
u106 = function() --[[ Line: 804 ]]
    -- upvalues: u117 (ref), u116 (copy)
    if u117 then
    else
        u117 = true;
        task.defer(function() --[[ Line: 807 ]]
            -- upvalues: u117 (ref), u116 (ref)
            u117 = false;
            u116();
        end);
    end;
end;
local u118 = {};
local u119 = false;
local u120 = nil;
local function u133(p121) --[[ Line: 818 ]]
    -- upvalues: u118 (copy), u119 (ref), u24 (ref), u38 (ref), u103 (ref), u120 (ref), u17 (ref), u111 (ref), u106 (ref), l__RunService__15 (copy)
    p121.Frame.Visible = false;
    table.insert(u118, p121);
    if not u119 then
        u119 = true;
        task.defer(function() --[[ Line: 823 ]]
            -- upvalues: u119 (ref), u118 (ref), u24 (ref), u38 (ref), u103 (ref), u120 (ref), u17 (ref), u111 (ref), u106 (ref), l__RunService__15 (ref)
            u119 = false;
            local v122 = {};
            for _, v123 in u118 do
                v122[v123] = true;
            end;
            table.clear(u118);
            local u124 = {};
            local v125 = 1;
            local v126 = 0;
            for v127 = 1, #u24 do
                local v128 = u24[v127];
                if v122[v128] then
                    table.insert(u124, v128.Frame);
                else
                    v128.Index = v125;
                    v128.Frame.Name = v125;
                    v128.Frame.LayoutOrder = v125;
                    u24[v125] = v128;
                    if u38 < v125 and v128.Frame.Visible then
                        v126 = v126 + 1;
                    end;
                    v125 = v125 + 1;
                end;
            end;
            for v129 = v125, #u24 do
                u24[v129] = nil;
            end;
            u103 = v126;
            if u120 and u17 then
                u17.Parent = u120;
                u120 = nil;
            end;
            u111 = false;
            u106();
            task.spawn(function() --[[ Line: 862 ]]
                -- upvalues: u124 (copy), l__RunService__15 (ref)
                for v130 = 1, #u124, 50 do
                    local v131 = math.min(v130 + 50 - 1, #u124);
                    for v132 = v130, v131 do
                        u124[v132]:Destroy();
                    end;
                    if v131 < #u124 then
                        l__RunService__15.Heartbeat:Wait();
                    end;
                end;
            end);
        end);
    end;
end;
local u134 = false;
local function u135() --[[ Line: 878 ]]
    -- upvalues: u134 (ref), u17 (ref), u111 (ref), u120 (ref), u119 (ref)
    if u134 then
    elseif u17 and u17.Parent then
        u134 = true;
        u111 = true;
        u120 = u17.Parent;
        u17.Parent = nil;
        task.defer(function() --[[ Line: 885 ]]
            -- upvalues: u134 (ref), u119 (ref), u120 (ref), u17 (ref), u111 (ref)
            u134 = false;
            if not u119 and (u120 and u17) then
                u17.Parent = u120;
                u120 = nil;
                u111 = false;
            end;
        end);
    end;
end;
local function u142() --[[ Line: 896 ]]
    -- upvalues: u12 (ref), u38 (ref), l__TouchEnabled__30 (copy), u13 (ref), u39 (ref), l__VREnabled__33 (copy), u15 (ref), u44 (ref), u45 (ref)
    u12.Size = UDim2.new(0, ICON_BUFFER + u38 * (ICON_SIZE + ICON_BUFFER), 0, ICON_BUFFER + ICON_SIZE + ICON_BUFFER);
    local v136 = u12;
    local l__new__39 = UDim2.new;
    local v137 = 0.5;
    local v138 = -u12.Size.X.Offset / 2;
    local v139 = 1;
    local v140 = -u12.Size.Y.Offset;
    local v141;
    if l__TouchEnabled__30 then
        local l__ViewportSize__40 = game.Workspace.Camera.ViewportSize;
        v141 = math.max(l__ViewportSize__40.X, l__ViewportSize__40.Y) >= 1000 and 18 or 0;
    else
        v141 = 0;
    end;
    v136.Position = l__new__39(v137, v138, v139, v140 - v141);
    u13.Size = UDim2.new(0, u12.Size.X.Offset, 0, u12.Size.Y.Offset * u39 + INVENTORY_HEADER_SIZE + (l__VREnabled__33 and 2 * INVENTORY_ARROWS_BUFFER_VR or 0));
    u13.Position = UDim2.new(0.5, -u13.Size.X.Offset / 2, 1, u12.Position.Y.Offset - u13.Size.Y.Offset);
    u15.Size = UDim2.new(1, u15.ScrollBarThickness + 1, 1, -INVENTORY_HEADER_SIZE - (l__VREnabled__33 and 2 * INVENTORY_ARROWS_BUFFER_VR or 0));
    u15.Position = UDim2.new(0, 0, 0, INVENTORY_HEADER_SIZE + (l__VREnabled__33 and INVENTORY_ARROWS_BUFFER_VR or 0));
    u44();
    u45();
end;
local u143 = nil;
local function u145(p144) --[[ Line: 982 ]]
    if p144 >= 1000000000 then
        return `x{math.floor(p144 / 100000000) / 10}B`;
    elseif p144 >= 1000000 then
        return `x{math.floor(p144 / 100000) / 10}M`;
    elseif p144 >= 1000 then
        return `x{math.floor(p144 / 100) / 10}K`;
    else
        return `x{p144}`;
    end;
end;
u43 = function(p146, p147) --[[ Line: 994 ]]
    -- upvalues: u24 (ref), l__VRService__16 (copy), u12 (ref), u145 (copy), l__SprinklerData__19 (copy), l__RakeData__20 (copy), l__WateringcanData__21 (copy), l__IMG__26 (copy), l__IMG__27 (copy), l__IMG__29 (copy), l__IMG__28 (copy), l__FruitProxyUtil__5 (copy), l__AnimatedGradient__6 (copy), u38 (ref), u13 (ref), l__UserInputService__9 (copy), u29 (ref), u31 (ref), u9 (ref), l__ContextActionService__13 (copy), u26 (ref), u25 (ref), u42 (ref), u97 (ref), u53 (ref), u52 (ref), l__Networking__4 (copy), u18 (ref), u40 (ref), u86 (copy), u106 (ref), u44 (ref), u111 (ref), l__LocalPlayer__31 (ref), l__Backpack__32 (ref), u143 (ref), u19 (ref), l__RunService__15 (copy), u49 (copy), u43 (ref), u16 (ref), u33 (ref), u45 (ref), u27 (ref), l__Value__7 (copy), u28 (copy), u20 (copy), u15 (ref), u103 (ref)
    local v148 = p147 or #u24 + 1;
    local u149 = {
        Tool = nil,
        Index = v148,
        Frame = nil
    };
    local u150 = nil;
    local u151 = nil;
    local u152 = nil;
    local u153 = nil;
    local u154 = nil;
    local u155 = nil;
    local u156 = nil;
    local u157 = nil;
    local u158 = "";
    local u159 = nil;
    local u160 = nil;
    local u161 = nil;
    local u162 = nil;
    local function u163() --[[ Line: 1030 ]]
        -- upvalues: l__VRService__16 (ref), u150 (ref)
        local _ = l__VRService__16.VREnabled;
        u150.SelectionImageObject = nil;
        u150.BackgroundTransparency = u150.Draggable and 0 or SLOT_FADE_LOCKED;
        u150.BackgroundColor3 = u150.Draggable and SLOT_DRAGGABLE_COLOR or BACKGROUND_COLOR;
    end;
    function u149.Readjust(_, p164, p165) --[[ Line: 1057 ]]
        -- upvalues: u12 (ref), u150 (ref)
        u150.Position = UDim2.new(0, u12.Size.X.Offset / 2 - ICON_SIZE / 2 + (ICON_BUFFER + ICON_SIZE) * (p164 - (p165 / 2 + 0.5)), 0, ICON_BUFFER);
    end;
    function u149.Fill(p166, u167) --[[ Line: 1065 ]]
        -- upvalues: u153 (ref), u154 (ref), u152 (ref), u158 (ref), u145 (ref), l__SprinklerData__19 (ref), l__RakeData__20 (ref), l__WateringcanData__21 (ref), l__IMG__26 (ref), l__IMG__27 (ref), l__IMG__29 (ref), l__IMG__28 (ref), u161 (ref), u159 (ref), u160 (ref), u150 (ref), l__FruitProxyUtil__5 (ref), l__AnimatedGradient__6 (ref), u155 (ref), u156 (ref), u38 (ref), u13 (ref), l__UserInputService__9 (ref), u29 (ref), u31 (ref), u9 (ref), l__ContextActionService__13 (ref), u26 (ref), u25 (ref), u42 (ref), u97 (ref), u53 (ref), u52 (ref), u24 (ref), l__Networking__4 (ref)
        if u167 then
            p166.Tool = u167;
            local function u237() --[[ Line: 1072 ]]
                -- upvalues: u167 (copy), u153 (ref), u154 (ref), u152 (ref), u158 (ref), u145 (ref), l__SprinklerData__19 (ref), l__RakeData__20 (ref), l__WateringcanData__21 (ref), l__IMG__26 (ref), l__IMG__27 (ref), l__IMG__29 (ref), l__IMG__28 (ref), u161 (ref), u159 (ref), u160 (ref), u150 (ref), l__FruitProxyUtil__5 (ref)
                local v168 = u167:GetAttribute("SeedTool");
                local v169 = u167:GetAttribute("Sprinkler");
                local v170 = u167:GetAttribute("Rake");
                local v171 = u167:GetAttribute("WateringCan");
                local v172 = u167:GetAttribute("Fruit");
                local v173 = u167:GetAttribute("Count");
                local v174 = u167:GetAttribute("Weight");
                local function v175() --[[ Line: 1081 ]]
                    -- upvalues: u153 (ref)
                    u153.FontFace = Font.new(script:GetAttribute("LabelFont").Family, Enum.FontWeight.Bold);
                    u153.TextSize = 10;
                    u153.Size = UDim2.new(1, -4, 0, 24);
                    u153.Position = UDim2.new(0, 2, 1, -26);
                    u153.TextYAlignment = Enum.TextYAlignment.Bottom;
                    u153.TextWrapped = true;
                    u153.Visible = true;
                end;
                if v172 then
                    local v176 = FruitImages:FindFirstChild(v172) or PlantImages:FindFirstChild(v172);
                    u152.Image = v176 and v176.Value or (u167:IsA("Tool") and u167.TextureId or "");
                    local v177 = u167:GetAttribute("Mutation");
                    u153.Text = v172;
                    if v177 and v177 ~= "" then
                        u158 = v172 .. " " .. v177;
                    else
                        u158 = v172;
                    end;
                    u153.FontFace = Font.new(script:GetAttribute("LabelFont").Family, Enum.FontWeight.Bold);
                    u153.TextSize = 10;
                    u153.Size = UDim2.new(1, -4, 0, 16);
                    u153.Position = UDim2.new(0, 2, 1, -26);
                    u153.TextYAlignment = Enum.TextYAlignment.Top;
                    u153.TextWrapped = true;
                    u153.Visible = true;
                    local v178 = u153:FindFirstChildOfClass("UIGradient");
                    if v178 then
                        v178:Destroy();
                    end;
                    if v177 then
                        local v179 = MutationData.GetMutation(v177);
                        if v179 and v179.Gradient then
                            v179.Gradient:Clone().Parent = u153;
                        end;
                    end;
                    u154.Text = WeightFormat.FormatGrams(v174);
                    u154.Size = UDim2.new(1, -4, 0, 16);
                    u154.Position = UDim2.new(0, 2, 1, -18);
                    u154.TextXAlignment = Enum.TextXAlignment.Center;
                    u154.Visible = v174 ~= nil;
                elseif v168 and v173 then
                    local v180 = u167:GetAttribute("Count");
                    local v181 = SeedImages:FindFirstChild(v168);
                    u152.Image = v181 and v181.Value or u167.TextureId;
                    local v182 = string.lower(v168);
                    if string.sub(v182, -5) == " seed" or v182 == "seed" then
                        u153.Text = v168;
                    else
                        u153.Text = v168 .. " Seed";
                    end;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Text = u145(v180);
                    u154.Visible = true;
                elseif v169 and v173 then
                    local v183 = nil;
                    for _, v184 in l__SprinklerData__19 do
                        if v184.SprinklerName == v169 then
                            v183 = v184;
                            break;
                        end;
                    end;
                    u152.Image = v183 and v183.Image or u167.TextureId;
                    u153.Text = v169;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Text = u145(v173);
                    u154.Visible = true;
                elseif v170 and v173 then
                    local v185 = nil;
                    for _, v186 in l__RakeData__20 do
                        if v186.RakeName == v170 then
                            v185 = v186;
                            break;
                        end;
                    end;
                    u152.Image = v185 and v185.Image or u167.TextureId;
                    u153.Text = v170;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Text = u145(v173);
                    u154.Visible = true;
                elseif v171 and v173 then
                    local v187 = nil;
                    for _, v188 in l__WateringcanData__21 do
                        if v188.Name == v171 then
                            v187 = v188;
                            break;
                        end;
                    end;
                    u152.Image = v187 and v187.Image or u167.TextureId;
                    u153.Text = v171;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Text = u145(v173);
                    u154.Visible = true;
                elseif u167:GetAttribute("Shovel") then
                    local v189 = u167:GetAttribute("Shovel");
                    u152.Image = l__IMG__26;
                    u153.Text = v189;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("Trowel") then
                    local v190 = u167:GetAttribute("Trowel");
                    u152.Image = l__IMG__27;
                    u153.Text = v190;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                    u154.Text = u145(v173);
                    u154.Visible = true;
                elseif u167:GetAttribute("Crowbar") then
                    u167:GetAttribute("Crowbar");
                    u152.Image = l__IMG__29;
                    u153.Text = "Door Crowbar";
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                    u154.Text = u145(v173);
                    u154.Visible = true;
                elseif u167:GetAttribute("Build") then
                    local v191 = u167:GetAttribute("Build");
                    u152.Image = l__IMG__28;
                    u153.Text = v191;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("EmptyPot") then
                    local v192 = u167:GetAttribute("EmptyPot");
                    local v193 = u167:GetAttribute("Count");
                    u152.Image = u167.TextureId;
                    u153.Text = v192;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v193 and v193 > 0 then
                        u154.Text = u145(v193);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                elseif u167:GetAttribute("Mushroom") then
                    local v194 = u167:GetAttribute("Mushroom");
                    local v195 = u167:GetAttribute("Count");
                    local v196 = nil;
                    for _, v197 in MushroomData.Data do
                        if v197.Name == v194 then
                            v196 = v197;
                            break;
                        end;
                    end;
                    u152.Image = v196 and v196.IMG or u167.TextureId;
                    u153.Text = v194;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v195 and v195 > 0 then
                        u154.Text = u145(v195);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                    if u161 and v196 then
                        u161.Text = v196.Description;
                        local v198 = u161.TextBounds.X + TOOLTIP_BUFFER;
                        u161.Size = UDim2.new(0, v198, 0, TOOLTIP_HEIGHT);
                        u161.Position = UDim2.new(0.5, -v198 / 2, 0, TOOLTIP_OFFSET);
                    end;
                elseif u167:GetAttribute("Gnome") then
                    local v199 = u167:GetAttribute("Gnome");
                    local v200 = u167:GetAttribute("Count");
                    local v201 = nil;
                    for _, v202 in GnomeData.Data do
                        if v202.Name == v199 then
                            v201 = v202;
                            break;
                        end;
                    end;
                    u152.Image = v201 and v201.IMG or u167.TextureId;
                    u153.Text = v199;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v200 and v200 > 0 then
                        u154.Text = u145(v200);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                    if u161 and v201 then
                        u161.Text = v201.Description;
                        local v203 = u161.TextBounds.X + TOOLTIP_BUFFER;
                        u161.Size = UDim2.new(0, v203, 0, TOOLTIP_HEIGHT);
                        u161.Position = UDim2.new(0.5, -v203 / 2, 0, TOOLTIP_OFFSET);
                    end;
                elseif u167:GetAttribute("Raccoon") then
                    local v204 = u167:GetAttribute("Raccoon");
                    local v205 = u167:GetAttribute("Count");
                    local v206 = nil;
                    for _, v207 in RaccoonData.Data do
                        if v207.Name == v204 then
                            v206 = v207;
                            break;
                        end;
                    end;
                    u152.Image = v206 and v206.IMG or u167.TextureId;
                    u153.Text = v204;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v205 and v205 > 0 then
                        u154.Text = u145(v205);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                    if u161 and v206 then
                        u161.Text = v206.Description;
                        local v208 = u161.TextBounds.X + TOOLTIP_BUFFER;
                        u161.Size = UDim2.new(0, v208, 0, TOOLTIP_HEIGHT);
                        u161.Position = UDim2.new(0.5, -v208 / 2, 0, TOOLTIP_OFFSET);
                    end;
                elseif u167:GetAttribute("Wheelbarrow") then
                    local v209 = u167:GetAttribute("Wheelbarrow");
                    u167:GetAttribute("Count");
                    u152.Image = u167.TextureId;
                    u153.Text = v209;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("Ladder") then
                    local v210 = u167:GetAttribute("Ladder");
                    u167:GetAttribute("Count");
                    u152.Image = u167.TextureId;
                    u153.Text = v210;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("FreezeRay") then
                    u167:GetAttribute("FreezeRay");
                    u152.Image = u167.TextureId;
                    u153.Text = "Freeze Ray";
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("Lantern") then
                    u167:GetAttribute("Lantern");
                    u152.Image = u167.TextureId;
                    u153.Text = "Lantern";
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("Sign") then
                    u167:GetAttribute("Sign");
                    u152.Image = u167.TextureId;
                    u153.Text = "Sign";
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("SeedPack") then
                    local v211 = u167:GetAttribute("SeedPack");
                    local v212 = u167:GetAttribute("Count");
                    local v213 = SeedPackData.GetData(v211);
                    u152.Image = v213 and v213.IMG or u167.TextureId;
                    local v214 = string.lower(v211);
                    if string.sub(v214, -5) == " pack" or v214 == "pack" then
                        u153.Text = v211;
                    else
                        u153.Text = v211 .. " Seed Pack";
                    end;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v212 and v212 > 0 then
                        u154.Text = u145(v212);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                elseif u167:GetAttribute("Egg") then
                    local v215 = u167:GetAttribute("Egg");
                    local v216 = u167:GetAttribute("Count");
                    local v217 = EggData.GetData(v215);
                    u152.Image = v217 and v217.IMG or u167.TextureId;
                    u153.Text = v215;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v216 and v216 > 0 then
                        u154.Text = u145(v216);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                elseif u167:GetAttribute("Crate") then
                    local v218 = u167:GetAttribute("Crate");
                    local v219 = u167:GetAttribute("Count");
                    local v220 = CrateData.GetData(v218);
                    u152.Image = v220 and v220.IMG or u167.TextureId;
                    u153.Text = v218;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v219 and v219 > 0 then
                        u154.Text = u145(v219);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                elseif u167:GetAttribute("Teleporter") then
                    local v221 = u167:GetAttribute("Teleporter");
                    local v222 = u167:GetAttribute("Count");
                    local v223 = nil;
                    for _, v224 in TeleporterData do
                        if v224.TeleporterName == v221 then
                            v223 = v224;
                            break;
                        end;
                    end;
                    u152.Image = v223 and v223.Image or u167.TextureId;
                    u153.Text = v221;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v222 and v222 > 0 then
                        u154.Text = u145(v222);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                elseif u167:GetAttribute("PowerHose") then
                    local v225 = u167:GetAttribute("PowerHose");
                    u167:GetAttribute("Count");
                    for _, v226 in PowerHoseData do
                        if v226.Name == v225 then
                            break;
                        end;
                    end;
                    u152.Image = u167.TextureId;
                    u153.Text = "Power Hose";
                    u158 = "Power Hose";
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("VineWrapper") then
                    local v227 = u167:GetAttribute("VineWrapper");
                    u152.Image = u167.TextureId;
                    u153.Text = v227;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                elseif u167:GetAttribute("Flashbang") then
                    local v228 = u167:GetAttribute("Flashbang");
                    local v229 = u167:GetAttribute("Count");
                    u152.Image = u167.TextureId;
                    u153.Text = v228;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v229 and v229 > 0 then
                        u154.Text = u145(v229);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                elseif u167:GetAttribute("Bird") then
                    local v230 = u167:GetAttribute("Bird");
                    local v231 = u167:GetAttribute("Count");
                    u152.Image = "rbxassetid://80206395781273";
                    u153.Text = v230;
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    if v231 and v231 > 0 then
                        u154.Text = u145(v231);
                        u154.Visible = true;
                    else
                        u154.Visible = false;
                    end;
                elseif u167:GetAttribute("Pet") then
                    local v232 = u167:GetAttribute("Pet");
                    if u167:IsA("Tool") and u167.TextureId ~= "" then
                        u152.Image = u167.TextureId;
                    end;
                    u153.Text = PetData.GetDisplayName(v232, u167:GetAttribute("PetSize"));
                    u158 = u153.Text;
                    v175();
                    u154.Size = UDim2.new(0, 30, 0, 20);
                    u154.Position = UDim2.new(1, -32, 0, 2);
                    u154.TextXAlignment = Enum.TextXAlignment.Right;
                    u154.Visible = false;
                else
                    local v233 = not u167:IsA("Tool") and "" or u167.TextureId;
                    u152.Image = v233;
                    if u167.Name == "Rainbow Carpet" then
                        u152.Image = v233;
                        u153.Text = "Carpet";
                        u158 = "Rainbow Carpet";
                        v175();
                        u154.Size = UDim2.new(0, 30, 0, 20);
                        u154.Position = UDim2.new(1, -32, 0, 2);
                        u154.TextXAlignment = Enum.TextXAlignment.Right;
                        u154.Visible = false;
                    else
                        u153.Visible = v233 == "";
                        u153.Text = u167.Name;
                        u158 = u153.Text;
                        u153.Size = UDim2.new(1, -2, 1, -2);
                        u153.Position = UDim2.new(0, 1, 0, 1);
                        u153.TextYAlignment = Enum.TextYAlignment.Center;
                        u153.TextSize = FONT_SIZE;
                        u154.Size = UDim2.new(0, 30, 0, 20);
                        u154.Position = UDim2.new(1, -32, 0, 2);
                        u154.TextXAlignment = Enum.TextXAlignment.Right;
                        u154.Visible = false;
                    end;
                end;
                local v234 = u167:GetAttribute("CooldownEnd");
                if v234 and os.clock() < v234 then
                    u159(v234);
                else
                    u160();
                end;
                local l__FavIcon__41 = u150.FavIcon;
                local v235 = l__FruitProxyUtil__5.IsFruitInstance(u167);
                if v235 then
                    v235 = u167:GetAttribute("IsFavorite") == true;
                end;
                l__FavIcon__41.Visible = v235;
                if u161 and u167:IsA("Tool") then
                    u161.Text = u167.ToolTip;
                    local v236 = u161.TextBounds.X + TOOLTIP_BUFFER;
                    u161.Size = UDim2.new(0, v236, 0, TOOLTIP_HEIGHT);
                    u161.Position = UDim2.new(0.5, -v236 / 2, 0, TOOLTIP_OFFSET);
                end;
            end;
            u237();
            if u167:GetAttribute("Pet") and u167:GetAttribute("PetType") == "Rainbow" then
                l__AnimatedGradient__6:AddRainbowColor(u152, "ImageColor3");
            else
                l__AnimatedGradient__6:Remove(u152);
            end;
            if u155 then
                u155:disconnect();
                u155 = nil;
            end;
            if u156 then
                u156:Disconnect();
                u156 = nil;
            end;
            if u167:IsA("Tool") then
                u155 = u167.Changed:connect(function(p238) --[[ Line: 1682 ]]
                    -- upvalues: u237 (copy)
                    if p238 == "TextureId" or (p238 == "Name" or p238 == "ToolTip") then
                        u237();
                    end;
                end);
            else
                u155 = u167:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 1688 ]]
                    -- upvalues: u237 (copy)
                    u237();
                end);
            end;
            u156 = u167.AttributeChanged:Connect(function(p239) --[[ Line: 1693 ]]
                -- upvalues: u237 (copy), u167 (copy), u159 (ref), u160 (ref)
                if p239 == "Count" or (p239 == "Seed" or (p239 == "Sprinkler" or (p239 == "Build" or (p239 == "Fruit" or (p239 == "Weight" or (p239 == "Mushroom" or (p239 == "Mutation" or (p239 == "Teleporter" or (p239 == "SeedPack" or (p239 == "Egg" or (p239 == "Wheelbarrow" or (p239 == "EmptyPot" or (p239 == "Flashbang" or (p239 == "Bird" or p239 == "IsFavorite")))))))))))))) then
                    u237();
                else
                    if p239 == "CooldownEnd" then
                        local v240 = u167:GetAttribute("CooldownEnd");
                        if v240 and os.clock() < v240 then
                            u159(v240);
                            return;
                        end;
                        u160();
                    end;
                end;
            end);
            local v241 = p166.Index <= u38;
            if (not v241 or u13.Visible) and not l__UserInputService__9.VREnabled then
                u150.Draggable = true;
            end;
            p166:UpdateEquipView();
            if v241 then
                u29 = u29 + 1;
                if u31 and (u29 >= 1 and not u9) then
                    u9 = true;
                    l__ContextActionService__13:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
                end;
            end;
            u26[u167] = p166;
            u25 = u42();
            u97();
            if u53 then
            elseif u52 then
            else
                u52 = true;
                task.delay(1, function() --[[ Line: 353 ]]
                    -- upvalues: u53 (ref), u52 (ref), u38 (ref), u24 (ref), l__Networking__4 (ref)
                    if u53 then
                        u52 = false;
                    else
                        local v242 = {};
                        local v243 = 0;
                        for v244 = 1, u38 do
                            local v245 = u24[v244];
                            if v245 and v245.Tool then
                                local v246 = GetToolKey(v245.Tool);
                                if v246 then
                                    v242[v244] = v246;
                                    v243 = v243 + 1;
                                end;
                            end;
                        end;
                        if v243 == 0 then
                            u52 = false;
                        else
                            l__Networking__4.Backpack.SaveLayout:Fire(v242);
                            u52 = false;
                        end;
                    end;
                end);
            end;
        else
            return p166:Clear();
        end;
    end;
    function u149.Clear(p247) --[[ Line: 1736 ]]
        -- upvalues: u155 (ref), u156 (ref), l__AnimatedGradient__6 (ref), u152 (ref), u153 (ref), u158 (ref), u154 (ref), u161 (ref), u150 (ref), u38 (ref), u29 (ref), u9 (ref), l__ContextActionService__13 (ref), u26 (ref), u160 (ref), u25 (ref), u42 (ref), u97 (ref), u53 (ref), u52 (ref), u24 (ref), l__Networking__4 (ref)
        if p247.Tool then
            if u155 then
                u155:disconnect();
                u155 = nil;
            end;
            if u156 then
                u156:Disconnect();
                u156 = nil;
            end;
            l__AnimatedGradient__6:Remove(u152);
            u152.Image = "";
            u153.Text = "";
            u158 = "";
            local v248 = u153:FindFirstChildOfClass("UIGradient");
            if v248 then
                v248:Destroy();
            end;
            u154.Text = "";
            u154.Visible = false;
            if u161 then
                u161.Text = "";
                u161.Visible = false;
            end;
            u150.Draggable = false;
            u150.FavIcon.Visible = false;
            p247:UpdateEquipView(true);
            if p247.Index <= u38 then
                u29 = u29 - 1;
                if u29 < 1 then
                    u9 = false;
                    l__ContextActionService__13:UnbindAction("RBXHotbarEquip");
                end;
            end;
            u26[p247.Tool] = nil;
            u160();
            p247.Tool = nil;
            u25 = u42();
            u97();
            if u53 then
            elseif u52 then
            else
                u52 = true;
                task.delay(1, function() --[[ Line: 353 ]]
                    -- upvalues: u53 (ref), u52 (ref), u38 (ref), u24 (ref), l__Networking__4 (ref)
                    if u53 then
                        u52 = false;
                    else
                        local v249 = {};
                        local v250 = 0;
                        for v251 = 1, u38 do
                            local v252 = u24[v251];
                            if v252 and v252.Tool then
                                local v253 = GetToolKey(v252.Tool);
                                if v253 then
                                    v249[v251] = v253;
                                    v250 = v250 + 1;
                                end;
                            end;
                        end;
                        if v250 == 0 then
                            u52 = false;
                        else
                            l__Networking__4.Backpack.SaveLayout:Fire(v249);
                            u52 = false;
                        end;
                    end;
                end);
            end;
        end;
    end;
    function u149.UpdateEquipView(p254, p255) --[[ Line: 1786 ]]
        -- upvalues: u18 (ref), u40 (ref), u149 (copy), u157 (ref), u86 (ref), u150 (ref), u163 (copy), u97 (ref)
        if not p255 then
            local l__Tool__42 = p254.Tool;
            if l__Tool__42 then
                l__Tool__42 = l__Tool__42.Parent == u18;
            end;
            if l__Tool__42 then
                u40 = u149;
                if not u157 then
                    u157 = u86("Frame", "Equipped");
                    u157.ZIndex = u150.ZIndex;
                    local v256 = Instance.new("UICorner");
                    v256.CornerRadius = script:GetAttribute("CornerRadius");
                    v256.Parent = u157;
                    local v257 = SLOT_EQUIP_THICKNESS;
                    local v258 = Instance.new("UIStroke");
                    v258.Color = SLOT_EQUIP_COLOR;
                    v258.Thickness = v257;
                    v258.Parent = u157;
                end;
                u157.Parent = u150;
                u163();
                u97();
                return;
            end;
        end;
        if u157 then
            u157.Parent = nil;
        end;
        u163();
        u97();
    end;
    function u149.IsEquipped(p259) --[[ Line: 1814 ]]
        -- upvalues: u18 (ref)
        local l__Tool__43 = p259.Tool;
        if l__Tool__43 then
            l__Tool__43 = l__Tool__43.Parent == u18;
        end;
        return l__Tool__43;
    end;
    function u149.Delete(p260) --[[ Line: 1818 ]]
        -- upvalues: u150 (ref), u24 (ref), u106 (ref)
        u150:Destroy();
        table.remove(u24, p260.Index);
        for v261 = p260.Index, #u24 do
            u24[v261]:SlideBack();
        end;
        u106();
    end;
    function u149.Swap(p262, p263) --[[ Line: 1830 ]]
        -- upvalues: u38 (ref), l__FruitProxyUtil__5 (ref), u53 (ref), u52 (ref), u24 (ref), l__Networking__4 (ref), u44 (ref)
        local l__Tool__44 = p262.Tool;
        local l__Tool__45 = p263.Tool;
        local l__Index__46 = p262.Index;
        local l__Index__47 = p263.Index;
        local v264 = l__Index__46 <= u38;
        local v265 = l__Index__47 <= u38;
        p262:Clear();
        if l__Tool__45 then
            p263:Clear();
            p262:Fill(l__Tool__45);
        end;
        if l__Tool__44 then
            p263:Fill(l__Tool__44);
        else
            p263:Clear();
        end;
        local v266 = l__Tool__44 and (l__FruitProxyUtil__5.IsFruitProxy(l__Tool__44) and v265) and l__Tool__44:GetAttribute("Id");
        if v266 then
            l__FruitProxyUtil__5.Pending.Slots[v266] = l__Index__47;
            l__FruitProxyUtil__5.RequestPromote(v266);
        end;
        local v267 = l__Tool__45 and (l__FruitProxyUtil__5.IsFruitProxy(l__Tool__45) and v264) and l__Tool__45:GetAttribute("Id");
        if v267 then
            l__FruitProxyUtil__5.Pending.Slots[v267] = l__Index__46;
            l__FruitProxyUtil__5.RequestPromote(v267);
        end;
        local v268 = l__Tool__44 and (l__FruitProxyUtil__5.IsFruitTool(l__Tool__44) and (not v265 and v264)) and l__Tool__44:GetAttribute("Id");
        if v268 then
            l__FruitProxyUtil__5.Pending.Slots[v268] = l__Index__47;
            l__FruitProxyUtil__5.RequestDemote(v268);
        end;
        local v269 = l__Tool__45 and l__FruitProxyUtil__5.IsFruitTool(l__Tool__45) and (not v264 and (v265 and l__Tool__45:GetAttribute("Id")));
        if v269 then
            l__FruitProxyUtil__5.Pending.Slots[v269] = l__Index__46;
            l__FruitProxyUtil__5.RequestDemote(v269);
        end;
        if not (u53 or u52) then
            u52 = true;
            task.delay(1, function() --[[ Line: 353 ]]
                -- upvalues: u53 (ref), u52 (ref), u38 (ref), u24 (ref), l__Networking__4 (ref)
                if u53 then
                    u52 = false;
                else
                    local v270 = {};
                    local v271 = 0;
                    for v272 = 1, u38 do
                        local v273 = u24[v272];
                        if v273 and v273.Tool then
                            local v274 = GetToolKey(v273.Tool);
                            if v274 then
                                v270[v272] = v274;
                                v271 = v271 + 1;
                            end;
                        end;
                    end;
                    if v271 == 0 then
                        u52 = false;
                    else
                        l__Networking__4.Backpack.SaveLayout:Fire(v270);
                        u52 = false;
                    end;
                end;
            end);
        end;
        u44();
    end;
    function u149.SlideBack(p275) --[[ Line: 1881 ]]
        -- upvalues: u111 (ref), u150 (ref)
        p275.Index = p275.Index - 1;
        if not u111 then
            u150.Name = p275.Index;
            u150.LayoutOrder = p275.Index;
        end;
    end;
    function u149.TurnNumber(_, p276) --[[ Line: 1889 ]]
        -- upvalues: u162 (ref)
        if u162 then
            u162.Visible = p276;
        end;
    end;
    function u149.SetClickability(p277, p278) --[[ Line: 1895 ]]
        -- upvalues: l__UserInputService__9 (ref), u150 (ref), u163 (copy)
        if p277.Tool then
            if l__UserInputService__9.VREnabled then
                u150.Draggable = false;
            else
                u150.Draggable = not p278;
            end;
            u163();
        end;
    end;
    function u149.CheckTerms(p279, p280) --[[ Line: 1906 ]]
        -- upvalues: u158 (ref), u161 (ref)
        local v281 = 0;
        local l__Tool__48 = p279.Tool;
        local v282;
        if l__Tool__48 then
            v282 = v281;
            for v283 in pairs(p280) do
                local v284 = v283:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1");
                local _, v285 = u158:lower():gsub(v284, "");
                v281 = v282 + v285;
                if l__Tool__48:IsA("Tool") then
                    local _, v286 = (u161 and u161.Text or ""):lower():gsub(v284, "");
                    v281 = v281 + v286;
                    v282 = v281;
                else
                    v282 = v281;
                end;
            end;
        else
            v282 = v281;
        end;
        return v282;
    end;
    function u149.Select(p287) --[[ Line: 1935 ]]
        -- upvalues: l__LocalPlayer__31 (ref), u149 (copy), l__FruitProxyUtil__5 (ref), u18 (ref), l__Backpack__32 (ref), u143 (ref), u19 (ref), l__RunService__15 (ref)
        if l__LocalPlayer__31:GetAttribute("LoadingScreenActive") then
        elseif l__LocalPlayer__31:GetAttribute("IsStealingFruit") or l__LocalPlayer__31:GetAttribute("CarryingStolenFruit") then
        else
            local l__Tool__49 = u149.Tool;
            if l__Tool__49 then
                if l__FruitProxyUtil__5.IsFruitProxy(l__Tool__49) then
                    local v288 = l__Tool__49:GetAttribute("Id");
                    if v288 then
                        if u18 then
                            for _, v289 in u18:GetChildren() do
                                if v289:IsA("Tool") then
                                    v289.Parent = l__Backpack__32;
                                end;
                            end;
                        end;
                        l__FruitProxyUtil__5.Pending.Slots[v288] = p287.Index;
                        l__FruitProxyUtil__5.Pending.Equip = v288;
                        l__FruitProxyUtil__5.RequestPromote(v288);
                    end;
                    return;
                end;
                local v290;
                if l__Tool__49 then
                    v290 = l__Tool__49.Parent == u18;
                else
                    v290 = l__Tool__49;
                end;
                if v290 then
                    u143 = nil;
                    if u19 then
                        u19:UnequipTools();
                    end;
                elseif l__Tool__49.Parent == l__Backpack__32 then
                    u143 = nil;
                    if u19 then
                        u19:UnequipTools();
                    end;
                    local v291 = l__Tool__49:GetAttribute("ToolDescendants");
                    if type(v291) ~= "number" and true or v291 <= #l__Tool__49:GetDescendants() then
                        l__Tool__49.Parent = u18;
                        return;
                    end;
                    u143 = l__Tool__49;
                    task.spawn(function() --[[ Line: 957 ]]
                        -- upvalues: u143 (ref), l__Tool__49 (copy), l__RunService__15 (ref), l__Backpack__32 (ref), u18 (ref), u19 (ref)
                        local v292 = os.clock() + 1;
                        while u143 == l__Tool__49 do
                            local v293 = l__Tool__49;
                            local v294 = v293:GetAttribute("ToolDescendants");
                            if type(v294) ~= "number" and true or v294 <= #v293:GetDescendants() or os.clock() >= v292 then
                                break;
                            end;
                            l__RunService__15.Heartbeat:Wait();
                        end;
                        if u143 == l__Tool__49 then
                            u143 = nil;
                            if l__Tool__49.Parent == l__Backpack__32 and (u18 and u18.Parent) then
                                u143 = nil;
                                if u19 then
                                    u19:UnequipTools();
                                end;
                                l__Tool__49.Parent = u18;
                            end;
                        end;
                    end);
                end;
            end;
        end;
    end;
    u150 = u86("TextButton", v148);
    local u295 = Instance.new("UIStroke");
    u295.Parent = u150;
    local v296 = Instance.new("UICorner");
    v296.CornerRadius = script:GetAttribute("CornerRadius");
    v296.Parent = u150;
    u295.Thickness = 0;
    u150.BackgroundColor3 = BACKGROUND_COLOR;
    u295.Color = SLOT_BORDER_COLOR;
    u150.Text = "";
    u150.AutoButtonColor = false;
    u150.BorderSizePixel = 0;
    u150.Size = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE);
    u150.Active = true;
    u150.Draggable = false;
    u150.BackgroundTransparency = SLOT_FADE_LOCKED;
    u150.MouseButton1Click:connect(function() --[[ Line: 1983 ]]
        -- upvalues: u149 (copy)
        changeSlot(u149);
    end);
    u150.MouseButton2Click:Connect(function() --[[ Line: 1984 ]]
        -- upvalues: u49 (ref), u149 (copy)
        u49(u149);
    end);
    local u297 = nil;
    local u298 = nil;
    local u299 = nil;
    local function v300() --[[ Line: 1994 ]]
        -- upvalues: u299 (ref), u297 (ref), u298 (ref)
        if u299 then
            task.cancel(u299);
            u299 = nil;
        end;
        u297 = nil;
        u298 = nil;
    end;
    u150.InputBegan:Connect(function(p301) --[[ Line: 2003 ]]
        -- upvalues: u299 (ref), u297 (ref), u298 (ref), u49 (ref), u149 (copy)
        if p301.UserInputType == Enum.UserInputType.Touch then
            if u299 then
                task.cancel(u299);
                u299 = nil;
            end;
            u297 = nil;
            u298 = nil;
            u297 = os.clock();
            u298 = p301.Position;
            u299 = task.delay(1, function() --[[ Line: 2008 ]]
                -- upvalues: u297 (ref), u49 (ref), u149 (ref), u299 (ref), u298 (ref)
                if u297 and os.clock() - u297 >= 1 then
                    u49(u149);
                end;
                u299 = nil;
                u297 = nil;
                u298 = nil;
            end);
        end;
    end);
    u150.InputChanged:Connect(function(p302) --[[ Line: 2018 ]]
        -- upvalues: u298 (ref), u299 (ref), u297 (ref)
        if p302.UserInputType == Enum.UserInputType.Touch then
            if u298 and (p302.Position - u298).Magnitude > 8 then
                if u299 then
                    task.cancel(u299);
                    u299 = nil;
                end;
                u297 = nil;
                u298 = nil;
            end;
        end;
    end);
    u150.InputEnded:Connect(function(p303) --[[ Line: 2025 ]]
        -- upvalues: u299 (ref), u297 (ref), u298 (ref)
        if p303.UserInputType == Enum.UserInputType.Touch then
            if u299 then
                task.cancel(u299);
                u299 = nil;
            end;
            u297 = nil;
            u298 = nil;
        end;
    end);
    u150.DragBegin:Connect(v300);
    u149.Frame = u150;
    local v304 = u86("Frame", "SelectionObjectClipper");
    v304.Visible = false;
    v304.Parent = u150;
    local v305 = u86("ImageLabel", "Selector");
    v305.Size = UDim2.new(1, 0, 1, 0);
    v305.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
    v305.ScaleType = Enum.ScaleType.Slice;
    v305.SliceCenter = Rect.new(12, 12, 52, 52);
    v305.Parent = v304;
    u152 = u86("ImageLabel", "Icon");
    u152.Size = UDim2.new(0.8, 0, 0.8, 0);
    u152.Position = UDim2.new(0.1, 0, 0.1, 0);
    u152.Parent = u150;
    u154 = u86("TextLabel", "ToolCount");
    u154.Size = UDim2.new(0, 30, 0, 20);
    u154.Position = UDim2.new(1, -32, 0, 2);
    u154.TextXAlignment = Enum.TextXAlignment.Right;
    u154.FontFace = script:GetAttribute("SlotFont");
    u154.TextSize = 14;
    u154.TextScaled = true;
    local v306 = Instance.new("UITextSizeConstraint");
    v306.MaxTextSize = 14;
    v306.Parent = u154;
    u154.Visible = false;
    u154.Parent = u150;
    local u307 = u86("Frame", "CooldownOverlay");
    u307.BackgroundColor3 = Color3.new(0, 0, 0);
    u307.BackgroundTransparency = 0.3;
    u307.Size = UDim2.new(1, 0, 1, 0);
    u307.ZIndex = 5;
    u307.Visible = false;
    u307.Parent = u150;
    local v308 = Instance.new("UICorner");
    v308.CornerRadius = script:GetAttribute("CornerRadius");
    v308.Parent = u307;
    local u309 = u86("TextLabel", "CooldownText");
    u309.Size = UDim2.new(1, 0, 1, 0);
    u309.TextSize = 22;
    u309.FontFace = script:GetAttribute("ToolTipFont");
    u309.TextColor3 = Color3.new(1, 1, 1);
    u309.ZIndex = 6;
    u309.Parent = u307;
    local u310 = nil;
    u160 = function() --[[ Line: 2093 ]]
        -- upvalues: u307 (copy), u309 (copy), u310 (ref)
        u307.Visible = false;
        u309.Text = "";
        if u310 then
            u310:Disconnect();
            u310 = nil;
        end;
    end;
    u159 = function(u311) --[[ Line: 2102 ]]
        -- upvalues: u160 (ref), u307 (copy), u310 (ref), l__RunService__15 (ref), u309 (copy)
        u160();
        u307.Visible = true;
        u310 = l__RunService__15.Heartbeat:Connect(function() --[[ Line: 2105 ]]
            -- upvalues: u311 (copy), u160 (ref), u309 (ref)
            local v312 = u311 - os.clock();
            if v312 <= 0 then
                u160();
            else
                u309.Text = math.ceil(v312) .. "s";
            end;
        end);
    end;
    local v313 = u86("ImageLabel", "FavIcon");
    v313.Size = UDim2.new(0.3, 0, 0.3, 0);
    v313.AnchorPoint = Vector2.new(1, 0);
    v313.Position = UDim2.new(1, -2, 0, 2);
    v313.Parent = u150;
    v313.Visible = false;
    v313.Image = "rbxassetid://102498784369651";
    v313.BackgroundTransparency = 1;
    v313.ZIndex = 10;
    u153 = u86("TextLabel", "ToolName");
    u153.Size = UDim2.new(1, -2, 1, -2);
    u153.Position = UDim2.new(0, 1, 0, 1);
    u153.Parent = u150;
    u149.Frame.LayoutOrder = u149.Index;
    if v148 <= u38 then
        u161 = u86("TextLabel", "ToolTip");
        u161.ZIndex = 2;
        u161.FontFace = script:GetAttribute("ToolTipFont");
        u161.TextWrapped = false;
        u161.TextYAlignment = Enum.TextYAlignment.Center;
        u161.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4);
        u161.BackgroundTransparency = 0;
        u161.Visible = false;
        u161.Parent = u150;
        local v314 = Instance.new("UICorner");
        v314.CornerRadius = script:GetAttribute("CornerRadius");
        v314.Parent = u161;
        u150.MouseEnter:connect(function() --[[ Line: 2145 ]]
            -- upvalues: u161 (ref)
            if u161.Text ~= "" then
                u161.Visible = true;
            end;
        end);
        u150.MouseLeave:connect(function() --[[ Line: 2150 ]]
            -- upvalues: u161 (ref)
            u161.Visible = false;
        end);
        function u149.MoveToInventory(p315) --[[ Line: 2152 ]]
            -- upvalues: u149 (copy), u38 (ref), l__FruitProxyUtil__5 (ref), u43 (ref), u16 (ref), u18 (ref), u143 (ref), u19 (ref), u33 (ref), u13 (ref), u45 (ref), u44 (ref), u53 (ref), u52 (ref), u24 (ref), l__Networking__4 (ref)
            if u149.Index <= u38 then
                local l__Tool__50 = u149.Tool;
                local v316;
                if l__Tool__50 then
                    v316 = l__FruitProxyUtil__5.IsFruitTool(l__Tool__50);
                else
                    v316 = l__Tool__50;
                end;
                p315:Clear();
                local v317 = u43(u16);
                v317:Fill(l__Tool__50);
                if v316 then
                    local v318 = l__Tool__50:GetAttribute("Id");
                    if v318 then
                        l__FruitProxyUtil__5.Pending.Slots[v318] = v317.Index;
                        l__FruitProxyUtil__5.RequestDemote(v318);
                    end;
                else
                    if l__Tool__50 then
                        l__Tool__50 = l__Tool__50.Parent == u18;
                    end;
                    if l__Tool__50 then
                        u143 = nil;
                        if u19 then
                            u19:UnequipTools();
                        end;
                    end;
                end;
                if u33 then
                    v317.Frame.Visible = false;
                    v317.Frame.Parent = u13;
                end;
                u45();
                u44();
                if u53 then
                    return;
                end;
                if u52 then
                    return;
                end;
                u52 = true;
                task.delay(1, function() --[[ Line: 353 ]]
                    -- upvalues: u53 (ref), u52 (ref), u38 (ref), u24 (ref), l__Networking__4 (ref)
                    if u53 then
                        u52 = false;
                    else
                        local v319 = {};
                        local v320 = 0;
                        for v321 = 1, u38 do
                            local v322 = u24[v321];
                            if v322 and v322.Tool then
                                local v323 = GetToolKey(v322.Tool);
                                if v323 then
                                    v319[v321] = v323;
                                    v320 = v320 + 1;
                                end;
                            end;
                        end;
                        if v320 == 0 then
                            u52 = false;
                        else
                            l__Networking__4.Backpack.SaveLayout:Fire(v319);
                            u52 = false;
                        end;
                    end;
                end);
            end;
        end;
        if v148 < 10 or v148 == u38 then
            local v324 = v148 < 10 and (v148 or 0) or 0;
            u162 = u86("TextLabel", "Number");
            u162.Text = v324;
            u162.Size = UDim2.new(0, 15, 0, 15);
            u162.Visible = false;
            u162.Parent = u150;
            u27[l__Value__7 + v324] = u149.Select;
        end;
    end;
    local l__Position__51 = u150.Position;
    local u325 = 0;
    local u326 = nil;
    u150.DragBegin:connect(function(p327) --[[ Line: 2197 ]]
        -- upvalues: u28 (ref), u150 (ref), l__Position__51 (ref), u295 (copy), u20 (ref), u152 (ref), u153 (ref), u154 (ref), u162 (ref), u157 (ref), u326 (ref), u16 (ref), u13 (ref), u151 (ref), u86 (ref)
        u28[u150] = true;
        l__Position__51 = p327;
        u295.Thickness = 2;
        u20:lock();
        u150.ZIndex = 2;
        u152.ZIndex = 2;
        u153.ZIndex = 2;
        u154.ZIndex = 2;
        u150.Parent.ZIndex = 2;
        if u162 then
            u162.ZIndex = 2;
        end;
        if u157 then
            u157.ZIndex = 2;
            for _, v328 in pairs(u157:GetChildren()) do
                if not (v328:IsA("UICorner") or v328:IsA("UIStroke")) then
                    v328.ZIndex = 2;
                end;
            end;
        end;
        u326 = u150.Parent;
        if u326 == u16 then
            local _ = u150.AbsolutePosition;
            local v329 = UDim2.new(0, u150.AbsolutePosition.X - u13.AbsolutePosition.X, 0, u150.AbsolutePosition.Y - u13.AbsolutePosition.Y);
            u150.Parent = u13;
            u150.Position = v329;
            u151 = u86("Frame", "FakeSlot");
            u151.LayoutOrder = u150.LayoutOrder;
            u151.Size = u150.Size;
            u151.BackgroundTransparency = 1;
            u151.Parent = u16;
        end;
    end);
    u150.DragStopped:connect(function(p330, p331) --[[ Line: 2238 ]]
        -- upvalues: u151 (ref), u150 (ref), l__Position__51 (ref), u326 (ref), u295 (copy), u20 (ref), u152 (ref), u153 (ref), u154 (ref), u162 (ref), u157 (ref), u28 (ref), u149 (copy), u13 (ref), u38 (ref), u325 (ref), u25 (ref), u12 (ref), u24 (ref), u18 (ref), u143 (ref), u19 (ref), u45 (ref), u53 (ref), u52 (ref), l__Networking__4 (ref)
        if u151 then
            u151:Destroy();
        end;
        local v332 = tick();
        u150.Position = l__Position__51;
        u150.Parent = u326;
        u295.Thickness = 0;
        u20:unlock();
        u150.ZIndex = 1;
        u152.ZIndex = 1;
        u153.ZIndex = 1;
        u154.ZIndex = 1;
        u326.ZIndex = 1;
        if u162 then
            u162.ZIndex = 1;
        end;
        if u157 then
            u157.ZIndex = 1;
            for _, v333 in pairs(u157:GetChildren()) do
                if not (v333:IsA("UICorner") or v333:IsA("UIStroke")) then
                    v333.ZIndex = 1;
                end;
            end;
        end;
        u28[u150] = nil;
        if u149.Tool then
            local v334 = u13;
            local l__AbsolutePosition__52 = v334.AbsolutePosition;
            local l__AbsoluteSize__53 = v334.AbsoluteSize;
            local v335;
            if l__AbsolutePosition__52.X < p330 and (p330 <= l__AbsolutePosition__52.X + l__AbsoluteSize__53.X and l__AbsolutePosition__52.Y < p331) then
                v335 = p331 <= l__AbsolutePosition__52.Y + l__AbsoluteSize__53.Y;
            else
                v335 = false;
            end;
            if v335 then
                if u149.Index <= u38 then
                    u149:MoveToInventory();
                end;
                if u38 < u149.Index and v332 - u325 < 0.5 then
                    if u25 then
                        local l__Tool__54 = u149.Tool;
                        u149:Clear();
                        u25:Fill(l__Tool__54);
                        u149:Delete();
                        v332 = 0;
                    else
                        v332 = 0;
                    end;
                end;
            else
                local v336 = u12;
                local l__AbsolutePosition__55 = v336.AbsolutePosition;
                local l__AbsoluteSize__56 = v336.AbsoluteSize;
                local v337;
                if l__AbsolutePosition__55.X < p330 and (p330 <= l__AbsolutePosition__55.X + l__AbsoluteSize__56.X and l__AbsolutePosition__55.Y < p331) then
                    v337 = p331 <= l__AbsolutePosition__55.Y + l__AbsoluteSize__56.Y;
                else
                    v337 = false;
                end;
                if v337 then
                    local v338 = { (1 / 0), nil };
                    for v339 = 1, u38 do
                        local v340 = u24[v339];
                        local l__Frame__57 = v340.Frame;
                        local v341 = Vector2.new(p330, p331);
                        local l__magnitude__58 = (l__Frame__57.AbsolutePosition + l__Frame__57.AbsoluteSize / 2 - v341).magnitude;
                        if l__magnitude__58 < v338[1] then
                            v338 = { l__magnitude__58, v340 };
                        end;
                    end;
                    local v342 = v338[2];
                    if v342 ~= u149 then
                        u149:Swap(v342);
                        if u38 < u149.Index then
                            local l__Tool__59 = u149.Tool;
                            if l__Tool__59 then
                                if l__Tool__59 then
                                    l__Tool__59 = l__Tool__59.Parent == u18;
                                end;
                                if l__Tool__59 then
                                    u143 = nil;
                                    if u19 then
                                        u19:UnequipTools();
                                    end;
                                end;
                                u45();
                            else
                                u149:Delete();
                            end;
                        end;
                    end;
                elseif u149.Index <= u38 then
                    u149:MoveToInventory();
                end;
            end;
            if not (u53 or u52) then
                u52 = true;
                task.delay(1, function() --[[ Line: 353 ]]
                    -- upvalues: u53 (ref), u52 (ref), u38 (ref), u24 (ref), l__Networking__4 (ref)
                    if u53 then
                        u52 = false;
                    else
                        local v343 = {};
                        local v344 = 0;
                        for v345 = 1, u38 do
                            local v346 = u24[v345];
                            if v346 and v346.Tool then
                                local v347 = GetToolKey(v346.Tool);
                                if v347 then
                                    v343[v345] = v347;
                                    v344 = v344 + 1;
                                end;
                            end;
                        end;
                        if v344 == 0 then
                            u52 = false;
                        else
                            l__Networking__4.Backpack.SaveLayout:Fire(v343);
                            u52 = false;
                        end;
                    end;
                end);
            end;
            u325 = v332;
        end;
    end);
    u150.Parent = p146;
    u24[v148] = u149;
    if u38 < v148 then
        local v348 = math.floor(u15.AbsoluteSize.X / (ICON_SIZE + ICON_BUFFER));
        local v349 = math.ceil(u103 / (v348 < 1 and 1 or v348)) * (ICON_SIZE + ICON_BUFFER) + ICON_BUFFER;
        u15.CanvasSize = UDim2.new(0, 0, 0, v349);
        if u13.Visible and not u33 then
            u15.CanvasPosition = Vector2.new(0, (math.max(0, u15.CanvasSize.Y.Offset - u15.AbsoluteSize.Y)));
        end;
    end;
    return u149;
end;
function OnChildAdded(u350)
    -- upvalues: l__FruitProxyUtil__5 (copy), u18 (ref), u19 (ref), u135 (ref), u37 (ref), u30 (ref), u26 (ref), l__LocalPlayer__31 (ref), u25 (ref), u43 (ref), u16 (ref), u24 (ref), l__Backpack__32 (ref), u44 (ref), u97 (ref), l__RunService__15 (copy), u38 (ref), u13 (ref), u1 (copy), u33 (ref), u82 (copy), u41 (ref), u103 (ref), u106 (ref), u53 (ref)
    local v351 = u350:IsA("Tool");
    local v352 = l__FruitProxyUtil__5.IsFruitProxy(u350);
    if v351 or v352 then
        u135();
        if u350.Parent == u18 then
            u37 = tick();
        end;
        if not u30 and (u350.Parent == u18 and not u26[u350]) then
            local v353 = l__LocalPlayer__31:FindFirstChild("StarterGear");
            if v353 and v353:FindFirstChild(u350.Name) then
                u30 = true;
                for v354 = (u25 or u43(u16)).Index, 1, -1 do
                    local v355 = u24[v354];
                    local v356 = v354 - 1;
                    if v356 > 0 then
                        u24[v356]:Swap(v355);
                    else
                        v355:Fill(u350);
                    end;
                end;
                for _, v357 in pairs(u18:GetChildren()) do
                    if v357:IsA("Tool") and v357 ~= u350 then
                        v357.Parent = l__Backpack__32;
                    end;
                end;
                u44();
                return;
            end;
        end;
        local v358 = u350:GetAttribute("Id");
        local v359;
        if v358 then
            v359 = l__FruitProxyUtil__5.Pending.Slots[v358];
        else
            v359 = v358;
        end;
        if v359 then
            if v351 and u26[u350] then
                u26[u350]:UpdateEquipView();
                u97();
            else
                l__FruitProxyUtil__5.Pending.Slots[v358] = nil;
                local v360 = u24[v359];
                if v360 then
                    if v360.Tool then
                        v360:Clear();
                    end;
                    v360:Fill(u350);
                end;
                if l__FruitProxyUtil__5.Pending.Equip == v358 and v351 then
                    l__FruitProxyUtil__5.Pending.Equip = nil;
                    task.spawn(function() --[[ Line: 2412 ]]
                        -- upvalues: l__RunService__15 (ref), u350 (copy), l__Backpack__32 (ref), u18 (ref)
                        l__RunService__15.Heartbeat:Wait();
                        if u350 and (u350.Parent == l__Backpack__32 and u18) then
                            for _, v361 in u18:GetChildren() do
                                if v361:IsA("Tool") then
                                    v361.Parent = l__Backpack__32;
                                end;
                            end;
                            u350.Parent = u18;
                        end;
                    end);
                end;
                u97();
            end;
        else
            local v362 = u26[u350];
            if v362 then
                v362:UpdateEquipView();
            else
                local v363 = u25 or u43(u16);
                v363:Fill(u350);
                if v363.Index <= u38 and not u13.Visible then
                    u44();
                end;
                if u38 < v363.Index then
                    local l___ApplySearch__60 = u1._ApplySearch;
                    if u33 and l___ApplySearch__60 then
                        l___ApplySearch__60();
                    else
                        v363.Frame.LayoutOrder = v363.Index;
                        local v364;
                        if v363.Tool == nil then
                            v364 = false;
                        else
                            v364 = u82(v363.Tool, u41);
                        end;
                        v363.Frame.Visible = v364;
                        if v364 then
                            u103 = u103 + 1;
                        end;
                        u106();
                    end;
                end;
                local v365 = not u53 and (v363.Index <= u38 and (v352 and u350:GetAttribute("Id")));
                if v365 then
                    l__FruitProxyUtil__5.Pending.Slots[v365] = v363.Index;
                    l__FruitProxyUtil__5.RequestPromote(v365);
                end;
            end;
            u97();
        end;
    else
        if u350:IsA("Humanoid") and u350.Parent == u18 then
            u19 = u350;
        end;
    end;
end;
function OnChildRemoved(p366)
    -- upvalues: l__FruitProxyUtil__5 (copy), u135 (ref), u37 (ref), u18 (ref), l__Backpack__32 (ref), u26 (ref), u38 (ref), u29 (ref), u133 (ref), u13 (ref), u44 (ref), u97 (ref)
    if p366:IsA("Tool") or l__FruitProxyUtil__5.IsFruitProxy(p366) then
        u135();
        u37 = tick();
        local l__Parent__61 = p366.Parent;
        if l__Parent__61 == u18 or l__Parent__61 == l__Backpack__32 then
        else
            local v367 = p366:GetAttribute("Id");
            if v367 and l__FruitProxyUtil__5.Pending.Slots[v367] then
                local v368 = u26[p366];
                if v368 then
                    if v368.Index <= u38 then
                        u29 = u29 - 1;
                    end;
                    u26[p366] = nil;
                    v368.Tool = nil;
                end;
            else
                local v369 = u26[p366];
                if v369 then
                    if u38 < v369.Index then
                        u26[p366] = nil;
                        v369.Tool = nil;
                        u133(v369);
                    else
                        v369:Clear();
                        if not u13.Visible then
                            u44();
                        end;
                    end;
                end;
                u97();
            end;
        end;
    end;
end;
function OnCharacterAdded(p370)
    -- upvalues: u53 (ref), l__FruitProxyUtil__5 (copy), u24 (ref), u38 (ref), u103 (ref), u35 (ref), u18 (ref), l__Backpack__32 (ref), l__LocalPlayer__31 (ref), u44 (ref), u97 (ref), u51 (ref), l__Networking__4 (copy), u50 (ref), u78 (copy)
    u53 = true;
    table.clear(l__FruitProxyUtil__5.Pending.Slots);
    l__FruitProxyUtil__5.Pending.Equip = nil;
    for v371 = #u24, 1, -1 do
        local v372 = u24[v371];
        if v372.Tool then
            v372:Clear();
        end;
        if u38 < v371 then
            v372:Delete();
        end;
    end;
    u103 = 0;
    for _, v373 in pairs(u35) do
        v373:Disconnect();
    end;
    u35 = {};
    u18 = p370;
    table.insert(u35, p370.ChildRemoved:Connect(OnChildRemoved));
    table.insert(u35, p370.ChildAdded:Connect(OnChildAdded));
    for _, v374 in pairs(p370:GetChildren()) do
        OnChildAdded(v374);
    end;
    l__Backpack__32 = l__LocalPlayer__31:WaitForChild("Backpack");
    table.insert(u35, l__Backpack__32.ChildRemoved:Connect(OnChildRemoved));
    table.insert(u35, l__Backpack__32.ChildAdded:Connect(OnChildAdded));
    for _, v375 in pairs(l__Backpack__32:GetChildren()) do
        OnChildAdded(v375);
    end;
    u44();
    u97();
    task.defer(function() --[[ Line: 2540 ]]
        -- upvalues: u51 (ref), l__Networking__4 (ref), u50 (ref), u78 (ref), u53 (ref)
        if u51 then
            if u50 then
                u51 = false;
                u78();
            end;
        else
            local v376, v377 = pcall(function() --[[ Line: 2543 ]]
                -- upvalues: l__Networking__4 (ref)
                return l__Networking__4.Backpack.GetLayout:Fire();
            end);
            if v376 and (v377 and typeof(v377) == "table") then
                local v378 = 0;
                for _ in pairs(v377) do
                    v378 = v378 + 1;
                end;
                if v378 > 0 then
                    u50 = v377;
                    u78();
                else
                    u51 = true;
                end;
            else
                u51 = true;
            end;
        end;
        u53 = false;
    end);
end;
function OnInputBegan(p379, p380)
    -- upvalues: u32 (ref), u31 (ref), l__Value__8 (copy), u27 (ref), u13 (ref), u20 (copy)
    if p380 == false then
        local v381 = p379.UserInputType == Enum.UserInputType.Keyboard and (not u32 and (u31 or p379.KeyCode.Value == l__Value__8)) and u27[p379.KeyCode.Value];
        if v381 then
            v381(p380);
        end;
        local l__UserInputType__62 = p379.UserInputType;
        if (l__UserInputType__62 == Enum.UserInputType.MouseButton1 or l__UserInputType__62 == Enum.UserInputType.Touch) and u13.Visible then
            u20:deselect();
        end;
    end;
end;
local function v384(p382) --[[ Line: 2590 ]]
    -- upvalues: l__UserInputService__9 (copy), u38 (ref), u24 (ref)
    if p382 == "KeyboardEnabled" or p382 == "VREnabled" then
        local l__KeyboardEnabled__63 = l__UserInputService__9.KeyboardEnabled;
        if l__KeyboardEnabled__63 then
            l__KeyboardEnabled__63 = not l__UserInputService__9.VREnabled;
        end;
        for v383 = 1, u38 do
            u24[v383]:TurnNumber(l__KeyboardEnabled__63);
        end;
    end;
end;
local u385 = nil;
local u386 = nil;
local function u387() --[[ Line: 2602 ]] end;
local _ = Vector2.new(0, 0);
function unbindAllGamepadEquipActions()
    -- upvalues: l__ContextActionService__13 (copy)
    l__ContextActionService__13:UnbindAction("RBXBackpackHasGamepadFocus");
    l__ContextActionService__13:UnbindAction("RBXCloseInventory");
end;
function changeToolFunc(_, p388, u389)
    -- upvalues: u385 (ref), u386 (ref), l__UserInputService__9 (copy), u143 (ref), u19 (ref), u38 (ref), u24 (ref), u40 (ref)
    if p388 == Enum.UserInputState.Begin then
        if u385 and (u385.KeyCode == Enum.KeyCode.ButtonR1 and u389.KeyCode == Enum.KeyCode.ButtonL1 or u385.KeyCode == Enum.KeyCode.ButtonL1 and u389.KeyCode == Enum.KeyCode.ButtonR1) and (tick() - u386 <= 0.06 and l__UserInputService__9:IsGamepadButtonDown(u389.UserInputType, u385.KeyCode)) then
            u143 = nil;
            if u19 then
                u19:UnequipTools();
            end;
            u385 = u389;
            u386 = tick();
        else
            u385 = u389;
            u386 = tick();
            task.delay(0.06, function() --[[ Line: 2705 ]]
                -- upvalues: u385 (ref), u389 (copy), u38 (ref), u24 (ref), u143 (ref), u19 (ref), u40 (ref)
                if u385 == u389 then
                    local v390 = u389.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1;
                    for v391 = 1, u38 do
                        if u24[v391]:IsEquipped() then
                            local v392 = v390 + v391;
                            local v393 = false;
                            if u38 < v392 then
                                v392 = 1;
                                v393 = true;
                            elseif v392 < 1 then
                                v392 = u38;
                                v393 = true;
                            end;
                            local v394 = v392;
                            while not u24[v392].Tool do
                                v392 = v392 + v390;
                                if v392 == v394 then
                                    return;
                                end;
                                if u38 < v392 then
                                    v392 = 1;
                                    v393 = true;
                                elseif v392 < 1 then
                                    v392 = u38;
                                    v393 = true;
                                end;
                            end;
                            if v393 then
                                u143 = nil;
                                if u19 then
                                    u19:UnequipTools();
                                end;
                                u40 = nil;
                                return;
                            else
                                u24[v392]:Select();
                                return;
                            end;
                        end;
                    end;
                    if u40 and u40.Tool then
                        u40:Select();
                    else
                        for v395 = v390 == -1 and (u38 or 1) or 1, v390 == -1 and 1 or u38, v390 do
                            if u24[v395].Tool then
                                u24[v395]:Select();
                                return;
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end;
end;
function getGamepadSwapSlot()
    -- upvalues: u24 (ref)
    for v396 = 1, #u24 do
        if u24[v396].Frame:WaitForChild("UIStroke").Thickness > 0 then
            return u24[v396];
        end;
    end;
end;
function changeSlot(u397)
    -- upvalues: l__VRService__16 (copy), u13 (ref), l__GuiService__12 (copy), u14 (ref), u38 (ref)
    if u397.Frame == l__GuiService__12.SelectedObject and (not l__VRService__16.VREnabled or u13.Visible) then
        local v398 = getGamepadSwapSlot();
        if not v398 then
            local l__Size__64 = u397.Frame.Size;
            local l__Position__65 = u397.Frame.Position;
            u397.Frame:TweenSizeAndPosition(l__Size__64 + UDim2.new(0, 10, 0, 10), l__Position__65 - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() --[[ Line: 2805 ]]
                -- upvalues: u397 (copy), l__Size__64 (copy), l__Position__65 (copy)
                u397.Frame:TweenSizeAndPosition(l__Size__64, l__Position__65, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true);
            end);
            u397.Frame:WaitForChild("UIStroke").Thickness = 3;
            u14.SelectionImageObject.Visible = true;
            return;
        end;
        v398.Frame:WaitForChild("UIStroke").Thickness = 0;
        if v398 ~= u397 then
            u397:Swap(v398);
            u14.SelectionImageObject.Visible = false;
            if u38 < u397.Index and not u397.Tool then
                if l__GuiService__12.SelectedObject == u397.Frame then
                    l__GuiService__12.SelectedObject = v398.Frame;
                end;
                u397:Delete();
            end;
            if u38 < v398.Index and not v398.Tool then
                if l__GuiService__12.SelectedObject == v398.Frame then
                    l__GuiService__12.SelectedObject = u397.Frame;
                end;
                v398:Delete();
            end;
        end;
    else
        u397:Select();
        u14.SelectionImageObject.Visible = false;
    end;
end;
function vrMoveSlotToInventory()
    -- upvalues: l__VRService__16 (copy), u14 (ref)
    if l__VRService__16.VREnabled then
        local v399 = getGamepadSwapSlot();
        if v399 and v399.Tool then
            v399:WaitForChild("UIStroke").Thickness = 0;
            v399:MoveToInventory();
            u14.SelectionImageObject.Visible = false;
        end;
    end;
end;
function enableGamepadInventoryControl()
    -- upvalues: u13 (ref), u20 (copy), l__ContextActionService__13 (copy), u387 (copy), l__UserInputService__9 (copy), l__GuiService__12 (copy), u12 (ref)
    local function v402(_, p400, _) --[[ Line: 2829 ]]
        -- upvalues: u13 (ref), u20 (ref)
        if p400 == Enum.UserInputState.Begin then
            if getGamepadSwapSlot() then
                local v401 = getGamepadSwapSlot();
                if v401 then
                    v401:WaitForChild("UIStroke").Thickness = 0;
                end;
            elseif u13.Visible then
                u20:deselect();
            end;
        end;
    end;
    l__ContextActionService__13:BindAction("RBXBackpackHasGamepadFocus", u387, false, Enum.UserInputType.Gamepad1);
    l__ContextActionService__13:BindAction("RBXCloseInventory", v402, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart);
    if not l__UserInputService__9.VREnabled then
        l__GuiService__12.SelectedObject = u12:FindFirstChild("1");
    end;
end;
function disableGamepadInventoryControl()
    -- upvalues: u38 (ref), u24 (ref), l__GuiService__12 (copy), u11 (ref)
    unbindAllGamepadEquipActions();
    for v403 = 1, u38 do
        local v404 = u24[v403];
        if v404 and v404.Frame then
            v404.Frame:WaitForChild("UIStroke").Thickness = 0;
        end;
    end;
    if l__GuiService__12.SelectedObject and l__GuiService__12.SelectedObject:IsDescendantOf(u11) then
        l__GuiService__12.SelectedObject = nil;
    end;
end;
function gamepadDisconnected()
    -- upvalues: u36 (ref)
    u36 = false;
    disableGamepadInventoryControl();
end;
function gamepadConnected()
    -- upvalues: u36 (ref), l__GuiService__12 (copy), u11 (ref), u29 (ref), u31 (ref), u9 (ref), l__ContextActionService__13 (copy), u13 (ref)
    u36 = true;
    l__GuiService__12:AddSelectionParent("RBXBackpackSelection", u11);
    if u29 >= 1 and (u31 and (not u9 or l__ContextActionService__13:GetAllBoundActionInfo().RBXHotbarEquip == nil)) then
        u9 = true;
        l__ContextActionService__13:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;
    if u13.Visible then
        enableGamepadInventoryControl();
    end;
end;
local function u411(p405) --[[ Line: 2908 ]]
    -- upvalues: u5 (ref), l__StarterGui__11 (copy), u20 (copy), l__GuiService__12 (copy), u31 (ref), u11 (ref), u34 (copy), u38 (ref), u24 (ref), u9 (ref), l__ContextActionService__13 (copy)
    if u5 then
        p405 = false;
    end;
    if p405 then
        p405 = l__StarterGui__11:GetCore("TopbarEnabled");
    end;
    local v406 = u20;
    local v407;
    if p405 then
        v407 = not l__GuiService__12.MenuIsOpen;
    else
        v407 = p405;
    end;
    v406:setEnabled(v407);
    u31 = p405;
    u11.Visible = p405;
    for _, _ in pairs(u34) do

    end;
    if p405 then
        local v408 = false;
        for v409 = 1, u38 do
            local v410 = u24[v409];
            if v410 and v410.Tool then
                v408 = true;
                break;
            end;
        end;
        if v408 then
            if u31 then
                if u9 and l__ContextActionService__13:GetAllBoundActionInfo().RBXHotbarEquip ~= nil then
                else
                    u9 = true;
                    l__ContextActionService__13:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
                end;
            end;
        end;
    else
        disableGamepadInventoryControl();
        u9 = false;
        l__ContextActionService__13:UnbindAction("RBXHotbarEquip");
    end;
end;
local function v417(p412, p413) --[[ Line: 2947 ]]
    -- upvalues: u86 (copy)
    local v414 = u86("ImageButton", p412);
    v414.Size = UDim2.new(0, 40, 0, 40);
    v414.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png";
    local v415 = u86("ImageLabel", "Icon");
    v415.Size = UDim2.new(0.5, 0, 0.5, 0);
    v415.Position = UDim2.new(0.25, 0, 0.25, 0);
    v415.Image = p413;
    v415.Parent = v414;
    local v416 = u86("ImageLabel", "Selection");
    v416.Size = UDim2.new(0.9, 0, 0.9, 0);
    v416.Position = UDim2.new(0.05, 0, 0.05, 0);
    v416.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png";
    v414.SelectionImageObject = v416;
    return v414, v415, v416;
end;
local v418 = u86("Frame", "Backpack");
v418.Visible = false;
v418.Parent = v7;
local u419 = u86("Frame", "Hotbar");
u419.Parent = v418;
local u420 = u106;
local u421 = u103;
local u422 = u44;
local v423 = v418;
local u424 = u45;
local u425 = u41;
for v426 = 1, u38 do
    local v427 = u43(u419, v426);
    v427.Frame.Visible = false;
    if not u25 then
        u25 = v427;
    end;
end;
u20.selected:Connect(function() --[[ Line: 2987 ]]
    -- upvalues: l__GuiService__12 (copy), u1 (copy)
    if not l__GuiService__12.MenuIsOpen then
        u1.OpenClose();
    end;
end);
u20.deselected:Connect(function() --[[ Line: 2992 ]]
    -- upvalues: u13 (ref), u1 (copy)
    if u13.Visible then
        u1.OpenClose();
    end;
end);
LeftBumperButton = u86("ImageLabel", "LeftBumper");
LeftBumperButton.Size = UDim2.new(0, 40, 0, 40);
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2);
RightBumperButton = u86("ImageLabel", "RightBumper");
RightBumperButton.Size = UDim2.new(0, 40, 0, 40);
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2);
local u428 = u86("Frame", "Inventory");
local v429 = Instance.new("UICorner");
v429.CornerRadius = script:GetAttribute("CornerRadius");
v429.Parent = u428;
u428.BackgroundTransparency = BACKGROUND_FADE;
u428.BackgroundColor3 = BACKGROUND_COLOR;
u428.Active = true;
u428.Visible = false;
u428.Parent = v423;
local v430 = u86("TextButton", "VRInventorySelector");
v430.Position = UDim2.new(0, 0, 0, 0);
v430.Size = UDim2.new(1, 0, 1, 0);
v430.BackgroundTransparency = 1;
v430.Text = "";
v430.Parent = u428;
local v431 = u86("ImageLabel", "Selector");
v431.Size = UDim2.new(1, 0, 1, 0);
v431.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
v431.ScaleType = Enum.ScaleType.Slice;
v431.SliceCenter = Rect.new(12, 12, 52, 52);
v431.Visible = false;
v430.SelectionImageObject = v431;
v430.MouseButton1Click:Connect(function() --[[ Line: 3032 ]]
    vrMoveSlotToInventory();
end);
local u432 = u86("ScrollingFrame", "ScrollingFrame");
u432.Selectable = false;
u432.CanvasSize = UDim2.new(0, 0, 0, 0);
u432.Parent = u428;
local u433 = u86("Frame", "UIGridFrame");
u433.Selectable = false;
u433.Size = UDim2.new(1, -(ICON_BUFFER * 2), 1, 0);
u433.Position = UDim2.new(0, ICON_BUFFER, 0, 0);
u433.Parent = u432;
local v434 = Instance.new("UIGridLayout");
v434.SortOrder = Enum.SortOrder.LayoutOrder;
v434.CellSize = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE);
v434.CellPadding = UDim2.new(0, ICON_BUFFER, 0, ICON_BUFFER);
v434.Parent = u433;
local u435 = l__SideBar__1:Clone();
u435.Parent = u428;
local u436 = script.FruitInventory:Clone();
u436.Parent = u428;
local u437 = u436;
local function v438() --[[ Line: 3067 ]]
    -- upvalues: l__LocalPlayer__31 (ref), u436 (copy)
    u436.Text = `{l__LocalPlayer__31:GetAttribute("FruitCount") or 0}/{l__LocalPlayer__31:GetAttribute("MaxFruitCapacity") or 100} Fruits`;
end;
v438();
l__LocalPlayer__31:GetAttributeChangedSignal("FruitCount"):Connect(v438);
l__LocalPlayer__31:GetAttributeChangedSignal("MaxFruitCapacity"):Connect(v438);
local function u442(p439) --[[ Line: 3078 ]]
    -- upvalues: u425 (ref), u435 (copy), u437 (ref), u424 (ref), u432 (ref)
    u425 = p439;
    u435.Gears.SelectedStroke.Enabled = p439 == "Gears";
    u435.Seeds.SelectedStroke.Enabled = p439 == "Seeds";
    u435.Fruits.SelectedStroke.Enabled = p439 == "Fruits";
    u435.All.SelectedStroke.Enabled = p439 == "All";
    local v440 = u435:FindFirstChild("Pets");
    local v441 = v440 and v440:FindFirstChild("SelectedStroke");
    if v441 then
        v441.Enabled = p439 == "Pets";
    end;
    if u437 then
        u437.Visible = p439 == "All" and true or p439 == "Fruits";
    end;
    u424();
    u432.CanvasPosition = Vector2.new(0, 0);
end;
u435.Gears.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 3104 ]]
    -- upvalues: u442 (ref)
    u442("Gears");
end);
u435.Seeds.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 3105 ]]
    -- upvalues: u442 (ref)
    u442("Seeds");
end);
u435.Fruits.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 3106 ]]
    -- upvalues: u442 (ref)
    u442("Fruits");
end);
u435.All.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 3107 ]]
    -- upvalues: u442 (ref)
    u442("All");
end);
local v443 = u435:FindFirstChild("Pets");
if v443 then
    v443 = v443:FindFirstChild("ImageButton");
end;
if v443 and v443:IsA("GuiButton") then
    v443.MouseButton1Click:Connect(function() --[[ Line: 3114 ]]
        -- upvalues: u442 (ref)
        u442("Pets");
    end);
end;
u442("All");
local u444 = v417("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u444.Size = UDim2.new(0, 34, 0, 34);
u444.Position = UDim2.new(0.5, -u444.Size.X.Offset / 2, 0, INVENTORY_HEADER_SIZE + 3);
u444.Icon.Position = u444.Icon.Position - UDim2.new(0, 0, 0, 2);
u444.MouseButton1Click:Connect(function() --[[ Line: 3125 ]]
    -- upvalues: u432 (ref)
    local v445 = u432;
    local l__new__66 = Vector2.new;
    local l__X__67 = u432.CanvasPosition.X;
    local v446 = u432.CanvasSize.Y.Offset - u432.AbsoluteWindowSize.Y;
    local v447 = math.max(0, u432.CanvasPosition.Y - (ICON_BUFFER + ICON_SIZE));
    v445.CanvasPosition = l__new__66(l__X__67, (math.min(v446, v447)));
end);
local u448 = v417("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u448.Rotation = 180;
u448.Icon.Position = u448.Icon.Position - UDim2.new(0, 0, 0, 2);
u448.Size = UDim2.new(0, 34, 0, 34);
u448.Position = UDim2.new(0.5, -u448.Size.X.Offset / 2, 1, -u448.Size.Y.Offset - 3);
u448.MouseButton1Click:Connect(function() --[[ Line: 3136 ]]
    -- upvalues: u432 (ref)
    local v449 = u432;
    local l__new__68 = Vector2.new;
    local l__X__69 = u432.CanvasPosition.X;
    local v450 = u432.CanvasSize.Y.Offset - u432.AbsoluteWindowSize.Y;
    local v451 = math.max(0, u432.CanvasPosition.Y + (ICON_BUFFER + ICON_SIZE));
    v449.CanvasPosition = l__new__68(l__X__69, (math.min(v450, v451)));
end);
u432.Changed:Connect(function(p452) --[[ Line: 3142 ]]
    -- upvalues: u432 (ref), u444 (ref), u448 (ref)
    if p452 == "AbsoluteWindowSize" or (p452 == "CanvasPosition" or p452 == "CanvasSize") then
        local v453 = u432.CanvasPosition.Y ~= 0;
        local v454 = u432.CanvasPosition.Y < u432.CanvasSize.Y.Offset - u432.AbsoluteWindowSize.Y;
        u444.Visible = v453;
        u448.Visible = v454;
    end;
end);
u142();
local u455 = l__Utility__17:Create("Frame")({
    Name = "GamepadHintsFrame",
    BackgroundTransparency = 1,
    Visible = false,
    Size = UDim2.new(0, u419.Size.X.Offset, 0, u8 and 95 or 60),
    Parent = v423
});
local u456 = {};
local function v461(p457, p458) --[[ Line: 3165 ]]
    -- upvalues: l__Utility__17 (copy), u455 (copy), u8 (copy), l__UserInputService__9 (copy), u456 (copy)
    local v459 = l__Utility__17:Create("Frame")({
        Name = "HintFrame",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, -5),
        Position = UDim2.new(0, 0, 0, 0),
        Parent = u455
    });
    u456[l__Utility__17:Create("ImageLabel")({
        Name = "HintImage",
        BackgroundTransparency = 1,
        Size = u8 and UDim2.new(0, 90, 0, 90) or UDim2.new(0, 60, 0, 60),
        Image = l__UserInputService__9:GetImageForKeyCode(p457),
        Parent = v459
    })] = p457;
    local v460 = l__Utility__17:Create("TextLabel")({
        Name = "HintText",
        BackgroundTransparency = 1,
        TextWrapped = true,
        Position = UDim2.new(0, u8 and 100 or 70, 0, 0),
        Size = UDim2.new(1, -(u8 and 100 or 70), 1, 0),
        Font = Enum.Font.SourceSansBold,
        FontSize = u8 and Enum.FontSize.Size36 or Enum.FontSize.Size24,
        Text = p458,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = v459
    });
    Instance.new("UITextSizeConstraint", v460).MaxTextSize = v460.TextSize;
end;
local function u467() --[[ Line: 3210 ]]
    -- upvalues: u455 (copy), u419 (ref), u8 (copy), u428 (ref)
    u455.Size = UDim2.new(u419.Size.X.Scale, u419.Size.X.Offset, 0, u8 and 95 or 60);
    u455.Position = UDim2.new(u419.Position.X.Scale, u419.Position.X.Offset, u428.Position.Y.Scale, u428.Position.Y.Offset - u455.Size.Y.Offset);
    local v462 = u455:GetChildren();
    local v463 = 0;
    for v464 = 1, #v462 do
        v462[v464].Size = UDim2.new(1, 0, 1, -5);
        v462[v464].Position = UDim2.new(0, 0, 0, 0);
        v463 = v463 + (v462[v464].HintText.Position.X.Offset + v462[v464].HintText.TextBounds.X);
    end;
    local v465 = (u455.AbsoluteSize.X - v463) / (#v462 - 1);
    for v466 = 1, #v462 do
        v462[v466].Position = v466 == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v462[v466 - 1].Position.X.Offset + v462[v466 - 1].Size.X.Offset + v465, 0, 0);
        v462[v466].Size = UDim2.new(0, v462[v466].HintText.Position.X.Offset + v462[v466].HintText.TextBounds.X, 1, -5);
    end;
end;
v461(Enum.KeyCode.ButtonX, "Remove From Hotbar");
v461(Enum.KeyCode.ButtonA, "Select/Swap");
v461(Enum.KeyCode.ButtonB, "Close Backpack");
local u468 = u86("Frame", "Search");
local v469 = Instance.new("UICorner");
v469.CornerRadius = script:GetAttribute("CornerRadius");
v469.Parent = u468;
u468.BackgroundColor3 = v2;
u468.BackgroundTransparency = v3;
u468.Size = UDim2.new(0, 190, 0, INVENTORY_HEADER_SIZE - 10);
u468.Position = UDim2.new(1, -u468.Size.X.Offset - 5, 0, 5);
u468.Parent = u428;
local u470 = u86("TextBox", "TextBox");
u470.PlaceholderText = "Search";
u470.ClearTextOnFocus = false;
u470.FontSize = Enum.FontSize.Size24;
u470.TextXAlignment = Enum.TextXAlignment.Left;
local v471 = Instance.new("UIPadding");
v471.Parent = u470;
v471.PaddingLeft = UDim.new(0, 8);
u470.Size = u468.Size - UDim2.fromOffset(0, 0);
u470.Position = UDim2.new(0, 0, 0, 0);
u470.Parent = u468;
local u472 = u86("TextButton", "X");
local v473 = Instance.new("UICorner");
v473.CornerRadius = script:GetAttribute("CornerRadius");
v473.Parent = u472;
u472.Text = "X";
u472.ZIndex = 10;
u472.TextColor3 = Color3.new(1, 1, 1);
u472.FontSize = Enum.FontSize.Size24;
u472.TextYAlignment = Enum.TextYAlignment.Bottom;
u472.BackgroundTransparency = 1;
u472.Size = UDim2.new(0, u468.Size.Y.Offset - 10, 0, u468.Size.Y.Offset - 10);
u472.Position = UDim2.new(1, -u472.Size.X.Offset - 10, 0.5, -u472.Size.Y.Offset / 2);
u472.Visible = false;
u472.BorderSizePixel = 0;
u472.Parent = u468;
local function u485() --[[ Line: 3273 ]]
    -- upvalues: u470 (copy), u38 (ref), u24 (ref), u428 (ref), u33 (ref), u433 (ref), u421 (ref), u432 (ref), u420 (ref), u472 (copy)
    local v474 = {};
    for v475 in u470.Text:gmatch("%S+") do
        v474[v475:lower()] = true;
    end;
    local v476 = {};
    for v477 = u38 + 1, #u24 do
        local v478 = u24[v477];
        local v479 = { v478, (v478:CheckTerms(v474)) };
        table.insert(v476, v479);
        v478.Frame.Visible = false;
        v478.Frame.Parent = u428;
    end;
    table.sort(v476, function(p480, p481) --[[ Line: 3288 ]]
        return p480[2] > p481[2];
    end);
    u33 = true;
    local v482 = 0;
    for _, v483 in ipairs(v476) do
        local v484 = v483[1];
        if v483[2] > 0 then
            v484.Frame.Visible = true;
            v484.Frame.Parent = u433;
            v484.Frame.LayoutOrder = u38 + v482;
            v482 = v482 + 1;
        end;
    end;
    u421 = v482;
    u432.CanvasPosition = Vector2.new(0, 0);
    u420();
    u472.ZIndex = 3;
end;
u1._ApplySearch = u485;
local function u489() --[[ Line: 3314 ]]
    -- upvalues: u472 (copy), u33 (ref), u38 (ref), u24 (ref), u433 (ref), u421 (ref), u420 (ref)
    if u472.ZIndex > 0 then
        u33 = false;
        local v486 = 0;
        for v487 = u38 + 1, #u24 do
            local v488 = u24[v487];
            v488.Frame.LayoutOrder = v488.Index;
            v488.Frame.Parent = u433;
            v488.Frame.Visible = true;
            v486 = v486 + 1;
        end;
        u421 = v486;
        u472.ZIndex = 0;
    end;
    u420();
end;
u472.MouseButton1Click:Connect(function() --[[ Name: reset, Line 3331 ]]
    -- upvalues: u489 (copy), u470 (copy)
    u489();
    u470.Text = "";
end);
u470.Changed:Connect(function(p490) --[[ Name: onChanged, Line 3336 ]]
    -- upvalues: u470 (copy), u489 (copy), u485 (copy), u472 (copy)
    if p490 == "Text" then
        local l__Text__70 = u470.Text;
        if l__Text__70 == "" then
            u489();
        elseif l__Text__70 ~= "Search" then
            u485();
        end;
        local v491 = u472;
        local v492;
        if l__Text__70 == "" then
            v492 = false;
        else
            v492 = l__Text__70 ~= "Search";
        end;
        v491.Visible = v492;
    end;
end);
u470.FocusLost:Connect(function(p493) --[[ Name: focusLost, Line 3348 ]]
    -- upvalues: u485 (copy)
    if p493 then
        u485();
    end;
end);
u1.StateChanged.Event:Connect(function(p494) --[[ Line: 3358 ]]
    -- upvalues: u489 (copy), u470 (copy), u428 (ref), u20 (copy)
    if not p494 then
        u489();
        u470.Text = "";
        if not u428.Visible then
            u20:deselect();
        end;
    end;
end);
u27[Enum.KeyCode.Escape.Value] = function(p495) --[[ Line: 3367 ]]
    -- upvalues: u489 (copy), u470 (copy), u428 (ref), u20 (copy)
    if p495 then
        u489();
        u470.Text = "";
    else
        if u428.Visible then
            u20:deselect();
        end;
    end;
end;
l__UserInputService__9.LastInputTypeChanged:Connect(function(p496) --[[ Name: detectGamepad, Line 3375 ]]
    -- upvalues: l__UserInputService__9 (copy), u468 (copy)
    if p496 == Enum.UserInputType.Gamepad1 and not l__UserInputService__9.VREnabled then
        u468.Visible = false;
    else
        u468.Visible = true;
    end;
end);
l__GuiService__12.MenuOpened:Connect(function() --[[ Line: 3385 ]]
    -- upvalues: u428 (ref), u20 (copy)
    if u428.Visible then
        u20:deselect();
    end;
end);
local u497 = false;
local function u500(_, p498, _) --[[ Line: 3398 ]]
    -- upvalues: l__GuiService__12 (copy), u38 (ref), u24 (ref)
    if p498 == Enum.UserInputState.Begin then
        if l__GuiService__12.SelectedObject then
            for v499 = 1, u38 do
                if u24[v499].Frame == l__GuiService__12.SelectedObject and u24[v499].Tool then
                    u24[v499]:MoveToInventory();
                    return;
                end;
            end;
        end;
    end;
end;
local function u503(_, p501) --[[ Line: 3410 ]]
    -- upvalues: l__GuiService__12 (copy), u24 (ref), u49 (copy)
    if p501 == Enum.UserInputState.Begin then
        local l__SelectedObject__71 = l__GuiService__12.SelectedObject;
        if l__SelectedObject__71 then
            for _, v502 in u24 do
                if v502.Frame == l__SelectedObject__71 and v502.Tool then
                    u49(v502);
                    return;
                end;
            end;
        end;
    end;
end;
local function v507() --[[ Line: 3422 ]]
    -- upvalues: u28 (copy), u428 (ref), u442 (ref), u422 (ref), u419 (ref), u38 (ref), u24 (ref), u36 (ref), u6 (copy), l__UserInputService__9 (copy), u456 (copy), u467 (copy), u455 (copy), l__ContextActionService__13 (copy), u500 (copy), u503 (copy), l__ProximityPromptService__14 (copy), u497 (ref), u1 (copy)
    if not next(u28) then
        u428.Visible = not u428.Visible;
        local l__Visible__72 = u428.Visible;
        if l__Visible__72 then
            u442("All");
        end;
        u422();
        u419.Active = not u419.Active;
        for v504 = 1, u38 do
            u24[v504]:SetClickability(not l__Visible__72);
        end;
    end;
    if u428.Visible then
        if u36 then
            if u6[l__UserInputService__9:GetLastInputType()] then
                for v505, v506 in u456 do
                    v505.Image = l__UserInputService__9:GetImageForKeyCode(v506);
                end;
                u467();
                u455.Visible = not l__UserInputService__9.VREnabled;
            end;
            enableGamepadInventoryControl();
        end;
    else
        if u36 then
            u455.Visible = false;
        end;
        disableGamepadInventoryControl();
    end;
    if u428.Visible then
        l__ContextActionService__13:BindAction("RBXRemoveSlot", u500, false, Enum.KeyCode.ButtonX);
        l__ContextActionService__13:BindAction("RBXFavoriteFruit", u503, false, Enum.KeyCode.ButtonY);
        if u36 and (u6[l__UserInputService__9:GetLastInputType()] and l__ProximityPromptService__14.Enabled) then
            l__ProximityPromptService__14.Enabled = false;
            u497 = true;
        end;
    else
        l__ContextActionService__13:UnbindAction("RBXRemoveSlot");
        l__ContextActionService__13:UnbindAction("RBXFavoriteFruit");
        if u497 then
            u497 = false;
            l__ProximityPromptService__14.Enabled = true;
        end;
    end;
    u1.IsOpen = u428.Visible;
    u1.StateChanged:Fire(u428.Visible);
end;
l__StarterGui__11:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
u1.OpenClose = v507;
while not l__LocalPlayer__31 do
    wait();
    l__LocalPlayer__31 = l__Players__10.LocalPlayer;
end;
l__LocalPlayer__31.CharacterAdded:Connect(OnCharacterAdded);
if l__LocalPlayer__31.Character then
    OnCharacterAdded(l__LocalPlayer__31.Character);
end;
l__UserInputService__9.InputBegan:Connect(OnInputBegan);
l__UserInputService__9.TextBoxFocused:Connect(function() --[[ Line: 3497 ]]
    -- upvalues: u32 (ref)
    u32 = true;
end);
l__UserInputService__9.TextBoxFocusReleased:Connect(function() --[[ Line: 3498 ]]
    -- upvalues: u32 (ref)
    u32 = false;
end);
l__UserInputService__9.Changed:Connect(v384);
v384("KeyboardEnabled");
if l__UserInputService__9:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
    gamepadConnected();
end;
l__UserInputService__9.GamepadConnected:Connect(function(p508) --[[ Line: 3511 ]]
    if p508 == Enum.UserInputType.Gamepad1 then
        gamepadConnected();
    end;
end);
l__UserInputService__9.GamepadDisconnected:Connect(function(p509) --[[ Line: 3516 ]]
    if p509 == Enum.UserInputType.Gamepad1 then
        gamepadDisconnected();
    end;
end);
function u1.SetBackpackEnabled(_, p510) --[[ Line: 3523 ]]
    -- upvalues: u4 (ref)
    u4 = p510;
end;
function u1.IsOpened(_) --[[ Line: 3527 ]]
    -- upvalues: u1 (copy)
    return u1.IsOpen;
end;
function u1.GetBackpackEnabled(_) --[[ Line: 3531 ]]
    -- upvalues: u4 (ref)
    return u4;
end;
function u1.GetStateChangedEvent(_) --[[ Line: 3535 ]]
    -- upvalues: l__Backpack__32 (ref)
    return l__Backpack__32.StateChanged;
end;
l__RunService__15.Heartbeat:Connect(function() --[[ Line: 3539 ]]
    -- upvalues: u411 (copy), u4 (ref)
    u411(u4);
end);
l__LocalPlayer__31:GetAttributeChangedSignal("LoadingScreenActive"):Connect(function() --[[ Line: 3547 ]]
    -- upvalues: l__LocalPlayer__31 (ref), u9 (ref), l__ContextActionService__13 (copy), u411 (copy), u4 (ref)
    if l__LocalPlayer__31:GetAttribute("LoadingScreenActive") then
    else
        disableGamepadInventoryControl();
        u9 = false;
        l__ContextActionService__13:UnbindAction("RBXHotbarEquip");
        u411(u4);
    end;
end);
l__Api__2.Event:Connect(function(p511, p512) --[[ Line: 3555 ]]
    -- upvalues: u1 (copy)
    if p511 == "SetBackpackEnabled" then
        u1:SetBackpackEnabled(p512);
    else
        if p511 == "SetInventoryOpen" then
            if type(p512) == "boolean" and p512 == true then
                u1.IsOpen = true;
                return;
            end;
            if type(p512) == "boolean" then
                u1.IsOpen = false;
            end;
        elseif p511 == "ToggleBackpack" then
            u1.OpenClose();
        end;
    end;
end);
local u514 = (function() --[[ Name: UpdateIsPhone, Line 3569 ]]
    -- upvalues: l__UserInputService__9 (copy)
    local v513;
    if game.Workspace.Camera.ViewportSize.X < 1000 then
        v513 = true;
    else
        v513 = l__UserInputService__9.TouchEnabled;
        if v513 then
            v513 = not l__UserInputService__9.KeyboardEnabled;
        end;
    end;
    return v513;
end)();
local v515 = l__VREnabled__33 and HOTBAR_SLOTS_VR or (u514 and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL);
u39 = l__VREnabled__33 and INVENTORY_ROWS_VR or (u514 and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL);
local u516;
if v515 == u38 then
    u516 = v515;
else
    u53 = true;
    local v517 = {};
    for v518 = 1, #u24 do
        local v519 = u24[v518];
        if v519 and v519.Tool then
            table.insert(v517, v519.Tool);
            v519:Clear();
        end;
    end;
    for v520 = #u24, 1, -1 do
        u24[v520].Frame:Destroy();
    end;
    u24 = {};
    u26 = {};
    u29 = 0;
    u25 = nil;
    u516 = v515;
    for v521 = 1, u516 do
        local v522 = u43(u419, v521);
        v522.Frame.Visible = false;
        if not u25 then
            u25 = v522;
        end;
    end;
    for _, v523 in ipairs(v517) do
        u25 = u42();
        (u25 or u43(u433)):Fill(v523);
    end;
    u25 = u42();
    for v524 = 1, u516 do
        if v524 < 10 then
            u27[l__Value__7 + v524] = u24[v524].Select;
        elseif v524 == u516 then
            u27[l__Value__7] = u24[v524].Select;
        end;
    end;
    u53 = false;
end;
v384("KeyboardEnabled");
u142();
game.Workspace.Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 3632 ]]
    -- upvalues: u514 (ref), l__UserInputService__9 (copy), l__VREnabled__33 (copy), u39 (ref), u516 (ref), u142 (copy), u53 (ref), u24 (ref), u26 (ref), u29 (ref), u25 (ref), u43 (ref), u419 (ref), u50 (ref), u42 (ref), u433 (ref), u27 (ref), l__Value__7 (copy), u52 (ref), l__Networking__4 (copy)
    local v525 = u514;
    local v526;
    if game.Workspace.Camera.ViewportSize.X < 1000 then
        v526 = true;
    else
        v526 = l__UserInputService__9.TouchEnabled;
        if v526 then
            v526 = not l__UserInputService__9.KeyboardEnabled;
        end;
    end;
    u514 = v526;
    if v525 ~= u514 then
        local v527 = l__VREnabled__33 and HOTBAR_SLOTS_VR or (u514 and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL);
        u39 = l__VREnabled__33 and INVENTORY_ROWS_VR or (u514 and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL);
        if v527 == u516 then
            u142();
            return;
        end;
        u53 = true;
        local v528 = {};
        for v529 = 1, #u24 do
            local v530 = u24[v529];
            if v530 and v530.Tool then
                table.insert(v528, v530.Tool);
                v530:Clear();
            end;
        end;
        for v531 = #u24, 1, -1 do
            u24[v531].Frame:Destroy();
        end;
        u24 = {};
        u26 = {};
        u29 = 0;
        u25 = nil;
        u516 = v527;
        for v532 = 1, u516 do
            local v533 = u43(u419, v532);
            v533.Frame.Visible = false;
            if not u25 then
                u25 = v533;
            end;
        end;
        if u50 then
            local v534 = {};
            for v535, v536 in pairs(u50) do
                local v537 = tonumber(v535);
                if v537 and (v537 >= 1 and v537 <= u516) then
                    for _, v538 in ipairs(v528) do
                        if not v534[v538] and GetToolKey(v538) == v536 then
                            u24[v537]:Fill(v538);
                            v534[v538] = true;
                            break;
                        end;
                    end;
                end;
            end;
            for _, v539 in ipairs(v528) do
                if not v534[v539] then
                    u25 = u42();
                    (u25 or u43(u433)):Fill(v539);
                    v534[v539] = true;
                end;
            end;
        else
            for _, v540 in ipairs(v528) do
                u25 = u42();
                (u25 or u43(u433)):Fill(v540);
            end;
        end;
        u25 = u42();
        u142();
        u27 = {};
        u27[Enum.KeyCode.Escape.Value] = u27[Enum.KeyCode.Escape.Value];
        for v541 = 1, u516 do
            if v541 < 10 then
                u27[l__Value__7 + v541] = u24[v541].Select;
            elseif v541 == u516 then
                u27[l__Value__7] = u24[v541].Select;
            end;
        end;
        local l__KeyboardEnabled__73 = l__UserInputService__9.KeyboardEnabled;
        if l__KeyboardEnabled__73 then
            l__KeyboardEnabled__73 = not l__UserInputService__9.VREnabled;
        end;
        for v542 = 1, u516 do
            u24[v542]:TurnNumber(l__KeyboardEnabled__73);
        end;
        u53 = false;
        if u53 then
            return;
        end;
        if u52 then
            return;
        end;
        u52 = true;
        task.delay(1, function() --[[ Line: 353 ]]
            -- upvalues: u53 (ref), u52 (ref), u516 (ref), u24 (ref), l__Networking__4 (ref)
            if u53 then
                u52 = false;
            else
                local v543 = {};
                local v544 = 0;
                for v545 = 1, u516 do
                    local v546 = u24[v545];
                    if v546 and v546.Tool then
                        local v547 = GetToolKey(v546.Tool);
                        if v547 then
                            v543[v545] = v547;
                            v544 = v544 + 1;
                        end;
                    end;
                end;
                if v544 == 0 then
                    u52 = false;
                else
                    l__Networking__4.Backpack.SaveLayout:Fire(v543);
                    u52 = false;
                end;
            end;
        end);
    end;
end);
return u1;