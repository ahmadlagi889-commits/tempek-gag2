-- Decompiled with Potassium's decompiler.

game:GetService("LocalizationService");
local l__UserInputService__1 = game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("TextService");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__GuiService__3 = game:GetService("GuiService");
local l__Players__4 = game:GetService("Players");
local u1 = script;
local l__Reference__5 = require(u1.Reference);
local v2 = l__Reference__5.getObject();
local v3;
if v2 then
    v3 = v2.Value;
else
    v3 = v2;
end;
if v3 and v3 ~= u1 then
    return require(v3);
end;
if not v2 then
    l__Reference__5.addToReplicatedStorage();
end;
local l__GoodSignal__6 = require(u1.Packages.GoodSignal);
local l__Janitor__7 = require(u1.Packages.Janitor);
local l__Utility__8 = require(u1.Utility);
require(u1.Attribute);
local l__Themes__9 = require(u1.Features.Themes);
local l__Gamepad__10 = require(u1.Features.Gamepad);
local l__Overflow__11 = require(u1.Features.Overflow);
local u4 = {};
u4.__index = u4;
local l__LocalPlayer__12 = l__Players__4.LocalPlayer;
local l__Themes__13 = u1.Features.Themes;
local l__PlayerGui__14 = l__LocalPlayer__12:WaitForChild("PlayerGui");
local u5 = {};
local u6 = l__GoodSignal__6.new();
local l__Elements__15 = u1.Elements;
local u7 = 0;
if l__GuiService__3.TopbarInset.Height == 0 then
    l__GuiService__3:GetPropertyChangedSignal("TopbarInset"):Wait();
end;
u4.baseDisplayOrderChanged = l__GoodSignal__6.new();
u4.baseDisplayOrder = 10;
u4.baseTheme = require(l__Themes__13.Default);
u4.isOldTopbar = l__GuiService__3.TopbarInset.Height == 36;
u4.iconsDictionary = u5;
u4.container = require(l__Elements__15.Container)(u4);
u4.topbarEnabled = true;
u4.iconAdded = l__GoodSignal__6.new();
u4.iconRemoved = l__GoodSignal__6.new();
u4.iconChanged = l__GoodSignal__6.new();
function u4.getIcons() --[[ Line: 112 ]]
    -- upvalues: u4 (copy)
    return u4.iconsDictionary;
end;
function u4.getIconByUID(p8) --[[ Line: 116 ]]
    -- upvalues: u4 (copy)
    local v9 = u4.iconsDictionary[p8];
    if v9 then
        return v9;
    end;
end;
function u4.getIcon(p10) --[[ Line: 123 ]]
    -- upvalues: u4 (copy), u5 (copy)
    local v11 = u4.getIconByUID(p10);
    if v11 then
        return v11;
    end;
    for _, v12 in pairs(u5) do
        if v12.name == p10 then
            return v12;
        end;
    end;
end;
function u4.setTopbarEnabled(p13, p14) --[[ Line: 135 ]]
    -- upvalues: u4 (copy)
    if typeof(p13) ~= "boolean" then
        p13 = u4.topbarEnabled;
    end;
    if not p14 then
        u4.topbarEnabled = p13;
    end;
    for _, v15 in pairs(u4.container) do
        v15.Enabled = p13;
    end;
end;
function u4.modifyBaseTheme(p16) --[[ Line: 147 ]]
    -- upvalues: l__Themes__9 (copy), u4 (copy), u5 (copy)
    local v17 = l__Themes__9.getModifications(p16);
    for _, v18 in pairs(v17) do
        for _, v19 in pairs(u4.baseTheme) do
            l__Themes__9.merge(v19, v18);
        end;
    end;
    for _, v20 in pairs(u5) do
        v20:setTheme(u4.baseTheme);
    end;
end;
function u4.setDisplayOrder(p21) --[[ Line: 159 ]]
    -- upvalues: u4 (copy)
    u4.baseDisplayOrder = p21;
    u4.baseDisplayOrderChanged:Fire(p21);
end;
task.defer(l__Gamepad__10.start, u4);
task.defer(l__Overflow__11.start, u4);
for _, v22 in pairs(u4.container) do
    v22.Parent = l__PlayerGui__14;
end;
if u4.isOldTopbar then
    u4.modifyBaseTheme(require(l__Themes__13.Classic));
end;
function u4.new() --[[ Line: 179 ]]
    -- upvalues: u4 (copy), l__Janitor__7 (copy), l__Utility__8 (copy), u5 (copy), l__GoodSignal__6 (copy), u1 (copy), l__Elements__15 (copy), u7 (ref), l__UserInputService__1 (copy), u6 (copy), l__StarterGui__2 (copy)
    local u23 = {};
    setmetatable(u23, u4);
    local v24 = l__Janitor__7.new();
    u23.janitor = v24;
    u23.themesJanitor = v24:add(l__Janitor__7.new());
    u23.singleClickJanitor = v24:add(l__Janitor__7.new());
    u23.captionJanitor = v24:add(l__Janitor__7.new());
    u23.joinJanitor = v24:add(l__Janitor__7.new());
    u23.menuJanitor = v24:add(l__Janitor__7.new());
    u23.dropdownJanitor = v24:add(l__Janitor__7.new());
    local u25 = l__Utility__8.generateUID();
    u5[u25] = u23;
    v24:add(function() --[[ Line: 196 ]]
        -- upvalues: u5 (ref), u25 (copy)
        u5[u25] = nil;
    end);
    u23.selected = v24:add(l__GoodSignal__6.new());
    u23.deselected = v24:add(l__GoodSignal__6.new());
    u23.toggled = v24:add(l__GoodSignal__6.new());
    u23.viewingStarted = v24:add(l__GoodSignal__6.new());
    u23.viewingEnded = v24:add(l__GoodSignal__6.new());
    u23.stateChanged = v24:add(l__GoodSignal__6.new());
    u23.notified = v24:add(l__GoodSignal__6.new());
    u23.noticeStarted = v24:add(l__GoodSignal__6.new());
    u23.noticeChanged = v24:add(l__GoodSignal__6.new());
    u23.endNotices = v24:add(l__GoodSignal__6.new());
    u23.toggleKeyAdded = v24:add(l__GoodSignal__6.new());
    u23.fakeToggleKeyChanged = v24:add(l__GoodSignal__6.new());
    u23.alignmentChanged = v24:add(l__GoodSignal__6.new());
    u23.updateSize = v24:add(l__GoodSignal__6.new());
    u23.resizingComplete = v24:add(l__GoodSignal__6.new());
    u23.joinedParent = v24:add(l__GoodSignal__6.new());
    u23.menuSet = v24:add(l__GoodSignal__6.new());
    u23.dropdownSet = v24:add(l__GoodSignal__6.new());
    u23.updateMenu = v24:add(l__GoodSignal__6.new());
    u23.startMenuUpdate = v24:add(l__GoodSignal__6.new());
    u23.childThemeModified = v24:add(l__GoodSignal__6.new());
    u23.indicatorSet = v24:add(l__GoodSignal__6.new());
    u23.dropdownChildAdded = v24:add(l__GoodSignal__6.new());
    u23.menuChildAdded = v24:add(l__GoodSignal__6.new());
    u23.iconModule = u1;
    u23.UID = u25;
    u23.isEnabled = true;
    u23.isSelected = false;
    u23.isViewing = false;
    u23.joinedFrame = false;
    u23.parentIconUID = false;
    u23.deselectWhenOtherIconSelected = true;
    u23.totalNotices = 0;
    u23.activeState = "Deselected";
    u23.alignment = "";
    u23.originalAlignment = "";
    u23.appliedTheme = {};
    u23.appearance = {};
    u23.cachedInstances = {};
    u23.cachedNamesToInstances = {};
    u23.cachedCollectives = {};
    u23.bindedToggleKeys = {};
    u23.customBehaviours = {};
    u23.toggleItems = {};
    u23.bindedEvents = {};
    u23.notices = {};
    u23.menuIcons = {};
    u23.dropdownIcons = {};
    u23.childIconsDict = {};
    u23.isOldTopbar = u4.isOldTopbar;
    u23.creationTime = os.clock();
    u23.widget = v24:add(require(l__Elements__15.Widget)(u23, u4));
    u23:setAlignment();
    u7 = u7 + 1;
    u23:setOrder(u7);
    u23:setTheme(u4.baseTheme);
    local v26 = u23:getInstance("ClickRegion");
    local u27 = false;
    local u28 = false;
    v26.MouseButton1Click:Connect(function() --[[ Line: 283 ]]
        -- upvalues: u27 (ref), u28 (ref), u23 (copy)
        if u27 then
        else
            u28 = true;
            task.delay(0.01, function() --[[ Line: 288 ]]
                -- upvalues: u28 (ref)
                u28 = false;
            end);
            if u23.locked then
            elseif u23.isSelected then
                u23:deselect("User", u23);
            else
                u23:select("User", u23);
            end;
        end;
    end);
    v26.TouchTap:Connect(function() --[[ Line: 293 ]]
        -- upvalues: u28 (ref), u27 (ref), u23 (copy)
        if u28 then
        else
            u27 = true;
            task.delay(0.01, function() --[[ Line: 300 ]]
                -- upvalues: u27 (ref)
                u27 = false;
            end);
            if u23.locked then
            elseif u23.isSelected then
                u23:deselect("User", u23);
            else
                u23:select("User", u23);
            end;
        end;
    end);
    v24:add(l__UserInputService__1.InputBegan:Connect(function(p29, p30) --[[ Line: 307 ]]
        -- upvalues: u23 (copy)
        if u23.locked then
        else
            if u23.bindedToggleKeys[p29.KeyCode] and not p30 then
                if u23.locked then
                    return;
                end;
                if u23.isSelected then
                    u23:deselect("User", u23);
                    return;
                end;
                u23:select("User", u23);
            end;
        end;
    end));
    local function v31() --[[ Line: 329 ]]
        -- upvalues: u23 (copy)
        if u23.locked then
        else
            u23.isViewing = false;
            u23.viewingEnded:Fire(true);
            u23:setState(nil, "User", u23);
        end;
    end;
    u23.joinedParent:Connect(function() --[[ Line: 337 ]]
        -- upvalues: u23 (copy)
        if u23.isViewing then
            if u23.locked then
                return;
            end;
            u23.isViewing = false;
            u23.viewingEnded:Fire(true);
            u23:setState(nil, "User", u23);
        end;
    end);
    v26.MouseEnter:Connect(function() --[[ Line: 342 ]]
        -- upvalues: l__UserInputService__1 (ref), u23 (copy)
        local v32 = not l__UserInputService__1.KeyboardEnabled;
        if u23.locked then
        else
            u23.isViewing = true;
            u23.viewingStarted:Fire(true);
            if not v32 then
                u23:setState("Viewing", "User", u23);
            end;
        end;
    end);
    local u33 = 0;
    v24:add(l__UserInputService__1.TouchEnded:Connect(v31));
    v26.MouseLeave:Connect(v31);
    v26.SelectionGained:Connect(function(p34) --[[ Name: viewingStarted, Line 319 ]]
        -- upvalues: u23 (copy)
        if u23.locked then
        else
            u23.isViewing = true;
            u23.viewingStarted:Fire(true);
            if not p34 then
                u23:setState("Viewing", "User", u23);
            end;
        end;
    end);
    v26.SelectionLost:Connect(v31);
    v26.MouseButton1Down:Connect(function() --[[ Line: 351 ]]
        -- upvalues: u23 (copy), l__UserInputService__1 (ref), u33 (ref)
        if not u23.locked and l__UserInputService__1.TouchEnabled then
            u33 = u33 + 1;
            local u35 = u33;
            task.delay(0.2, function() --[[ Line: 355 ]]
                -- upvalues: u35 (copy), u33 (ref), u23 (ref)
                if u35 == u33 then
                    if u23.locked then
                        return;
                    end;
                    u23.isViewing = true;
                    u23.viewingStarted:Fire(true);
                    u23:setState("Viewing", "User", u23);
                end;
            end);
        end;
    end);
    v26.MouseButton1Up:Connect(function() --[[ Line: 362 ]]
        -- upvalues: u33 (ref)
        u33 = u33 + 1;
    end);
    local u36 = u23:getInstance("IconOverlay");
    u23.viewingStarted:Connect(function() --[[ Line: 368 ]]
        -- upvalues: u36 (copy), u23 (copy)
        u36.Visible = not u23.overlayDisabled;
    end);
    u23.viewingEnded:Connect(function() --[[ Line: 371 ]]
        -- upvalues: u36 (copy)
        u36.Visible = false;
    end);
    v24:add(u6:Connect(function(p37) --[[ Line: 376 ]]
        -- upvalues: u23 (copy)
        if p37 ~= u23 and (u23.deselectWhenOtherIconSelected and p37.deselectWhenOtherIconSelected) then
            u23:deselect("AutoDeselect", p37);
        end;
    end));
    local v38 = debug.info(2, "s");
    local v39 = string.split(v38, ".");
    local v40 = game;
    local v41 = nil;
    for _, v42 in pairs(v39) do
        v40 = v40:FindFirstChild(v42);
        if not v40 then
            break;
        end;
        if v40:IsA("ScreenGui") then
            v41 = v40;
        end;
    end;
    if v40 and (v41 and v41.ResetOnSpawn == true) then
        l__Utility__8.localPlayerRespawned(function() --[[ Line: 401 ]]
            -- upvalues: u23 (copy)
            u23:destroy();
        end);
    end;
    u23:getInstance("NoticeLabel");
    u23.toggled:Connect(function(p43) --[[ Line: 408 ]]
        -- upvalues: u23 (copy), u4 (ref)
        u23.noticeChanged:Fire(u23.totalNotices);
        for v44, _ in pairs(u23.childIconsDict) do
            local v45 = u4.getIconByUID(v44);
            v45.noticeChanged:Fire(v45.totalNotices);
            if not p43 and v45.isSelected then
                for _, _ in pairs(v45.childIconsDict) do
                    v45:deselect("HideParentFeature", u23);
                end;
            end;
        end;
    end);
    u23.selected:Connect(function() --[[ Line: 431 ]]
        -- upvalues: u23 (copy), l__StarterGui__2 (ref)
        if #u23.dropdownIcons > 0 then
            if l__StarterGui__2:GetCore("ChatActive") and u23.alignment ~= "Right" then
                u23.chatWasPreviouslyActive = true;
                l__StarterGui__2:SetCore("ChatActive", false);
            end;
            if l__StarterGui__2:GetCoreGuiEnabled("PlayerList") and u23.alignment ~= "Left" then
                u23.playerlistWasPreviouslyActive = true;
                l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            end;
        end;
    end);
    u23.deselected:Connect(function() --[[ Line: 444 ]]
        -- upvalues: u23 (copy), l__StarterGui__2 (ref)
        if u23.chatWasPreviouslyActive then
            u23.chatWasPreviouslyActive = nil;
            l__StarterGui__2:SetCore("ChatActive", true);
        end;
        if u23.playerlistWasPreviouslyActive then
            u23.playerlistWasPreviouslyActive = nil;
            l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
        end;
    end);
    task.delay(0.1, function() --[[ Line: 459 ]]
        -- upvalues: u23 (copy)
        if u23.activeState == "Deselected" then
            u23.stateChanged:Fire("Deselected");
            u23:refresh();
        end;
    end);
    u4.iconAdded:Fire(u23);
    return u23;
end;
function u4.setName(p46, p47) --[[ Line: 475 ]]
    p46.widget.Name = p47;
    p46.name = p47;
    return p46;
end;
function u4.setState(p48, p49, p50, p51) --[[ Line: 481 ]]
    -- upvalues: l__Utility__8 (copy), u6 (copy)
    local v52 = l__Utility__8.formatStateName(p49 or (p48.isSelected and "Selected" or "Deselected"));
    if p48.activeState == v52 then
    else
        local l__isSelected__16 = p48.isSelected;
        p48.activeState = v52;
        if v52 == "Deselected" then
            p48.isSelected = false;
            if l__isSelected__16 then
                p48.toggled:Fire(false, p50, p51);
                p48.deselected:Fire(p50, p51);
            end;
            p48:_setToggleItemsVisible(false, p50, p51);
        elseif v52 == "Selected" then
            p48.isSelected = true;
            if not l__isSelected__16 then
                p48.toggled:Fire(true, p50, p51);
                p48.selected:Fire(p50, p51);
                u6:Fire(p48, p50, p51);
            end;
            p48:_setToggleItemsVisible(true, p50, p51);
        end;
        p48.stateChanged:Fire(v52, p50, p51);
    end;
end;
function u4.getInstance(u53, u54) --[[ Line: 514 ]]
    -- upvalues: l__Themes__9 (copy)
    local v55 = u53.cachedNamesToInstances[u54];
    if v55 then
        return v55;
    end;
    local function u59(u56, u57) --[[ Line: 522 ]]
        -- upvalues: u53 (copy)
        if not u53.cachedInstances[u57] then
            local v58 = u57:GetAttribute("Collective");
            if v58 then
                v58 = u53.cachedCollectives[v58];
            end;
            if v58 then
                table.insert(v58, u57);
            end;
            u53.cachedNamesToInstances[u56] = u57;
            u53.cachedInstances[u57] = true;
            u57.Destroying:Once(function() --[[ Line: 532 ]]
                -- upvalues: u53 (ref), u56 (copy), u57 (copy)
                u53.cachedNamesToInstances[u56] = nil;
                u53.cachedInstances[u57] = nil;
            end);
        end;
    end;
    local l__widget__17 = u53.widget;
    u59("Widget", l__widget__17);
    if u54 == "Widget" then
        return l__widget__17;
    end;
    local u60 = nil;
    local function u65(p61) --[[ Line: 545 ]]
        -- upvalues: u53 (copy), l__Themes__9 (ref), u65 (copy), u59 (copy), u54 (copy), u60 (ref)
        for _, v62 in pairs(p61:GetChildren()) do
            local v63 = v62:GetAttribute("WidgetUID");
            if not v63 or v63 == u53.UID then
                local v64 = l__Themes__9.getRealInstance(v62) or v62;
                u65(v64);
                if v64:IsA("GuiBase") or (v64:IsA("UIBase") or v64:IsA("ValueBase")) then
                    local l__Name__18 = v64.Name;
                    u59(l__Name__18, v64);
                    if l__Name__18 == u54 then
                        u60 = v64;
                    end;
                end;
            end;
        end;
    end;
    u65(l__widget__17);
    return u60;
end;
function u4.getCollective(p66, p67) --[[ Line: 575 ]]
    local v68 = p66.cachedCollectives[p67];
    if v68 then
        return v68;
    end;
    local v69 = {};
    for v70, _ in pairs(p66.cachedInstances) do
        if v70:GetAttribute("Collective") == p67 then
            table.insert(v69, v70);
        end;
    end;
    p66.cachedCollectives[p67] = v69;
    return v69;
end;
function u4.getInstanceOrCollective(p71, p72) --[[ Line: 596 ]]
    local v73 = {};
    local v74 = p71:getInstance(p72);
    if v74 then
        table.insert(v73, v74);
    end;
    if #v73 == 0 then
        v73 = p71:getCollective(p72);
    end;
    return v73;
end;
function u4.getStateGroup(p75, p76) --[[ Line: 610 ]]
    local v77 = p76 or p75.activeState;
    local v78 = p75.appearance[v77];
    if not v78 then
        v78 = {};
        p75.appearance[v77] = v78;
    end;
    return v78;
end;
function u4.refreshAppearance(p79, p80, p81) --[[ Line: 620 ]]
    -- upvalues: l__Themes__9 (copy)
    l__Themes__9.refresh(p79, p80, p81);
    return p79;
end;
function u4.refresh(p82) --[[ Line: 625 ]]
    p82:refreshAppearance(p82.widget);
    p82.updateSize:Fire();
    return p82;
end;
function u4.updateParent(p83) --[[ Line: 631 ]]
    -- upvalues: u4 (copy)
    local v84 = u4.getIconByUID(p83.parentIconUID);
    if v84 then
        v84.updateSize:Fire();
    end;
end;
function u4.setBehaviour(p85, p86, p87, p88, p89) --[[ Line: 638 ]]
    p85.customBehaviours[p86 .. "-" .. p87] = p88;
    if p89 then
        local v90 = p85:getInstanceOrCollective(p86);
        for _, v91 in pairs(v90) do
            p85:refreshAppearance(v91, p87);
        end;
    end;
end;
function u4.modifyTheme(p92, p93, p94) --[[ Line: 651 ]]
    -- upvalues: l__Themes__9 (copy)
    return p92, l__Themes__9.modify(p92, p93, p94);
end;
function u4.modifyChildTheme(p95, p96, p97) --[[ Line: 656 ]]
    -- upvalues: u4 (copy)
    p95.childModifications = p96;
    p95.childModificationsUID = p97;
    for v98, _ in pairs(p95.childIconsDict) do
        u4.getIconByUID(v98):modifyTheme(p96, p97);
    end;
    p95.childThemeModified:Fire();
    return p95;
end;
function u4.removeModification(p99, p100) --[[ Line: 669 ]]
    -- upvalues: l__Themes__9 (copy)
    l__Themes__9.remove(p99, p100);
    return p99;
end;
function u4.removeModificationWith(p101, p102, p103, p104) --[[ Line: 674 ]]
    -- upvalues: l__Themes__9 (copy)
    l__Themes__9.removeWith(p101, p102, p103, p104);
    return p101;
end;
function u4.setTheme(p105, p106) --[[ Line: 679 ]]
    -- upvalues: l__Themes__9 (copy)
    l__Themes__9.set(p105, p106);
    return p105;
end;
function u4.setEnabled(p107, p108) --[[ Line: 684 ]]
    p107.isEnabled = p108;
    p107.widget.Visible = p108;
    p107:updateParent();
    return p107;
end;
function u4.select(p109, p110, p111) --[[ Line: 691 ]]
    p109:setState("Selected", p110, p111);
    return p109;
end;
function u4.deselect(p112, p113, p114) --[[ Line: 696 ]]
    p112:setState("Deselected", p113, p114);
    return p112;
end;
function u4.notify(p115, p116, p117) --[[ Line: 701 ]]
    -- upvalues: l__Elements__15 (copy), u4 (copy)
    if not p115.notice then
        p115.notice = require(l__Elements__15.Notice)(p115, u4);
    end;
    p115.noticeStarted:Fire(p116, p117);
    return p115;
end;
function u4.clearNotices(p118) --[[ Line: 715 ]]
    p118.endNotices:Fire();
    return p118;
end;
function u4.disableOverlay(p119, p120) --[[ Line: 720 ]]
    p119.overlayDisabled = p120;
    return p119;
end;
u4.disableStateOverlay = u4.disableOverlay;
function u4.setImage(p121, p122, p123) --[[ Line: 726 ]]
    p121:modifyTheme({
        "IconImage",
        "Image",
        p122,
        p123
    });
    return p121;
end;
function u4.setLabel(p124, p125, p126) --[[ Line: 731 ]]
    p124:modifyTheme({
        "IconLabel",
        "Text",
        p125,
        p126
    });
    return p124;
end;
function u4.setOrder(p127, p128, p129) --[[ Line: 736 ]]
    p127:modifyTheme({
        "Widget",
        "LayoutOrder",
        p128,
        p129
    });
    return p127;
end;
function u4.setCornerRadius(p130, p131, p132) --[[ Line: 741 ]]
    p130:modifyTheme({
        "IconCorners",
        "CornerRadius",
        p131,
        p132
    });
    return p130;
end;
function u4.align(p133, p134, p135) --[[ Line: 746 ]]
    -- upvalues: u4 (copy)
    local v136 = tostring(p134):lower();
    local v137 = (v136 == "mid" or v136 == "centre") and "center" or v136;
    local v138 = v137 ~= "left" and (v137 ~= "center" and v137 ~= "right") and "left" or v137;
    local v139 = v138 == "center" and u4.container.TopbarCentered or u4.container.TopbarStandard;
    local l__Holders__19 = v139.Holders;
    local v140 = string.upper((string.sub(v138, 1, 1))) .. string.sub(v138, 2);
    if not p135 then
        p133.originalAlignment = v140;
    end;
    local l__joinedFrame__20 = p133.joinedFrame;
    local v141 = l__Holders__19[v140];
    p133.screenGui = v139;
    p133.alignmentHolder = v141;
    if not p133.isDestroyed then
        p133.widget.Parent = l__joinedFrame__20 or v141;
    end;
    p133.alignment = v140;
    p133.alignmentChanged:Fire(v140);
    u4.iconChanged:Fire(p133);
    return p133;
end;
u4.setAlignment = u4.align;
function u4.setLeft(p142) --[[ Line: 775 ]]
    p142:setAlignment("Left");
    return p142;
end;
function u4.setMid(p143) --[[ Line: 780 ]]
    p143:setAlignment("Center");
    return p143;
end;
function u4.setRight(p144) --[[ Line: 785 ]]
    p144:setAlignment("Right");
    return p144;
end;
function u4.setWidth(p145, p146, p147) --[[ Line: 790 ]]
    p145:modifyTheme({
        "Widget",
        "Size",
        UDim2.fromOffset(p146, p145.widget.Size.Y.Offset),
        p147
    });
    p145:modifyTheme({
        "Widget",
        "DesiredWidth",
        p146,
        p147
    });
    return p145;
end;
function u4.setImageScale(p148, p149, p150) --[[ Line: 800 ]]
    p148:modifyTheme({
        "IconImageScale",
        "Value",
        p149,
        p150
    });
    return p148;
end;
function u4.setImageRatio(p151, p152, p153) --[[ Line: 805 ]]
    p151:modifyTheme({
        "IconImageRatio",
        "AspectRatio",
        p152,
        p153
    });
    return p151;
end;
function u4.setTextSize(p154, p155, p156) --[[ Line: 810 ]]
    p154:modifyTheme({
        "IconLabel",
        "TextSize",
        p155,
        p156
    });
    return p154;
end;
function u4.setTextFont(p157, p158, p159, p160, p161) --[[ Line: 815 ]]
    local v162 = p159 or Enum.FontWeight.Regular;
    local v163 = p160 or Enum.FontStyle.Normal;
    local v164 = nil;
    local v165 = typeof(p158);
    if v165 == "number" then
        v164 = Font.fromId(p158, v162, v163);
    elseif v165 == "EnumItem" then
        v164 = Font.fromEnum(p158);
    elseif v165 == "string" and not p158:match("rbxasset") then
        v164 = Font.fromName(p158, v162, v163);
    end;
    p157:modifyTheme({
        "IconLabel",
        "FontFace",
        v164 or Font.new(p158, v162, v163),
        p161
    });
    return p157;
end;
function u4.bindToggleItem(p166, p167) --[[ Line: 836 ]]
    if not (p167:IsA("GuiObject") or p167:IsA("LayerCollector")) then
        error("Toggle item must be a GuiObject or LayerCollector!");
    end;
    p166.toggleItems[p167] = true;
    p166:_updateSelectionInstances();
    return p166;
end;
function u4.unbindToggleItem(p168, p169) --[[ Line: 845 ]]
    p168.toggleItems[p169] = nil;
    p168:_updateSelectionInstances();
    return p168;
end;
function u4._updateSelectionInstances(p170) --[[ Line: 851 ]]
    for v171, _ in pairs(p170.toggleItems) do
        local v172 = {};
        for _, v173 in pairs(v171:GetDescendants()) do
            if (v173:IsA("TextButton") or v173:IsA("ImageButton")) and v173.Active then
                table.insert(v172, v173);
            end;
        end;
        p170.toggleItems[v171] = v172;
    end;
end;
function u4._setToggleItemsVisible(p174, p175, _, p176) --[[ Line: 865 ]]
    for v177, _ in pairs(p174.toggleItems) do
        if not p176 or (p176 == p174 or p176.toggleItems[v177] == nil) then
            v177[v177:IsA("LayerCollector") and "Enabled" or "Visible"] = p175;
        end;
    end;
end;
function u4.bindEvent(u178, p179, u180) --[[ Line: 877 ]]
    local v181 = u178[p179];
    local v182;
    if v181 then
        if typeof(v181) == "table" then
            v182 = v181.Connect;
        else
            v182 = false;
        end;
    else
        v182 = v181;
    end;
    assert(v182, "argument[1] must be a valid topbarplus icon event name!");
    local v183 = typeof(u180) == "function";
    assert(v183, "argument[2] must be a function!");
    u178.bindedEvents[p179] = v181:Connect(function(...) --[[ Line: 881 ]]
        -- upvalues: u180 (copy), u178 (copy)
        u180(u178, ...);
    end);
    return u178;
end;
function u4.unbindEvent(p184, p185) --[[ Line: 887 ]]
    local v186 = p184.bindedEvents[p185];
    if v186 then
        v186:Disconnect();
        p184.bindedEvents[p185] = nil;
    end;
    return p184;
end;
function u4.bindToggleKey(p187, p188) --[[ Line: 896 ]]
    local v189 = typeof(p188) == "EnumItem";
    assert(v189, "argument[1] must be a KeyCode EnumItem!");
    p187.bindedToggleKeys[p188] = true;
    p187.toggleKeyAdded:Fire(p188);
    p187:setCaption("_hotkey_");
    return p187;
end;
function u4.unbindToggleKey(p190, p191) --[[ Line: 904 ]]
    local v192 = typeof(p191) == "EnumItem";
    assert(v192, "argument[1] must be a KeyCode EnumItem!");
    p190.bindedToggleKeys[p191] = nil;
    return p190;
end;
function u4.call(u193, u194, ...) --[[ Line: 910 ]]
    local u195 = table.pack(...);
    task.spawn(function() --[[ Line: 912 ]]
        -- upvalues: u194 (copy), u193 (copy), u195 (copy)
        u194(u193, table.unpack(u195));
    end);
    return u193;
end;
function u4.addToJanitor(p196, p197) --[[ Line: 918 ]]
    p196.janitor:add(p197);
    return p196;
end;
function u4.lock(p198) --[[ Line: 923 ]]
    p198:getInstance("ClickRegion").Visible = false;
    p198.locked = true;
    return p198;
end;
function u4.unlock(p199) --[[ Line: 931 ]]
    p199:getInstance("ClickRegion").Visible = true;
    p199.locked = false;
    return p199;
end;
function u4.debounce(p200, p201) --[[ Line: 938 ]]
    p200:lock();
    task.wait(p201);
    p200:unlock();
    return p200;
end;
function u4.autoDeselect(p202, p203) --[[ Line: 945 ]]
    p202.deselectWhenOtherIconSelected = p203 == nil and true or p203;
    return p202;
end;
function u4.oneClick(u204, p205) --[[ Line: 955 ]]
    local l__singleClickJanitor__21 = u204.singleClickJanitor;
    l__singleClickJanitor__21:clean();
    if p205 or p205 == nil then
        l__singleClickJanitor__21:add(u204.selected:Connect(function() --[[ Line: 961 ]]
            -- upvalues: u204 (copy)
            u204:deselect("OneClick", u204);
        end));
    end;
    u204.oneClickEnabled = true;
    return u204;
end;
function u4.setCaption(p206, p207) --[[ Line: 969 ]]
    -- upvalues: l__Elements__15 (copy)
    if p207 == "_hotkey_" and p206.captionText then
        return p206;
    end;
    local l__captionJanitor__22 = p206.captionJanitor;
    p206.captionJanitor:clean();
    if not p207 or p207 == "" then
        p206.caption = nil;
        p206.captionText = nil;
        return p206;
    end;
    local v208 = l__captionJanitor__22:add(require(l__Elements__15.Caption)(p206));
    v208:SetAttribute("CaptionText", p207);
    p206.caption = v208;
    p206.captionText = p207;
    return p206;
end;
function u4.setCaptionHint(p209, p210) --[[ Line: 987 ]]
    local v211 = typeof(p210) == "EnumItem";
    assert(v211, "argument[1] must be a KeyCode EnumItem!");
    p209.fakeToggleKey = p210;
    p209.fakeToggleKeyChanged:Fire(p210);
    p209:setCaption("_hotkey_");
    return p209;
end;
function u4.leave(p212) --[[ Line: 995 ]]
    p212.joinJanitor:clean();
    return p212;
end;
function u4.joinMenu(p213, p214) --[[ Line: 1001 ]]
    -- upvalues: l__Utility__8 (copy)
    l__Utility__8.joinFeature(p213, p214, p214.menuIcons, p214:getInstance("Menu"));
    p214.menuChildAdded:Fire(p213);
    return p213;
end;
function u4.setMenu(p215, p216) --[[ Line: 1007 ]]
    p215.menuSet:Fire(p216);
    return p215;
end;
function u4.setFrozenMenu(p217, p218) --[[ Line: 1012 ]]
    p217:freezeMenu(p218);
    p217:setMenu(p218);
end;
function u4.freezeMenu(u219) --[[ Line: 1017 ]]
    u219:select("FrozenMenu", u219);
    u219:bindEvent("deselected", function(p220) --[[ Line: 1021 ]]
        -- upvalues: u219 (copy)
        p220:select("FrozenMenu", u219);
    end);
    u219:modifyTheme({ "IconSpot", "Visible", false });
end;
function u4.joinDropdown(p221, p222) --[[ Line: 1027 ]]
    -- upvalues: l__Utility__8 (copy)
    p222:getDropdown();
    l__Utility__8.joinFeature(p221, p222, p222.dropdownIcons, p222:getInstance("DropdownScroller"));
    p222.dropdownChildAdded:Fire(p221);
    return p221;
end;
function u4.getDropdown(p223) --[[ Line: 1034 ]]
    -- upvalues: l__Elements__15 (copy)
    local l__dropdown__23 = p223.dropdown;
    if not l__dropdown__23 then
        l__dropdown__23 = require(l__Elements__15.Dropdown)(p223);
        p223.dropdown = l__dropdown__23;
        p223:clipOutside(l__dropdown__23);
    end;
    return l__dropdown__23;
end;
function u4.setDropdown(p224, p225) --[[ Line: 1044 ]]
    p224:getDropdown();
    p224.dropdownSet:Fire(p225);
    return p224;
end;
function u4.clipOutside(p226, p227) --[[ Line: 1050 ]]
    -- upvalues: l__Utility__8 (copy)
    local v228 = l__Utility__8.clipOutside(p226, p227);
    p226:refreshAppearance(p227);
    return p226, v228;
end;
function u4.setIndicator(p229, p230) --[[ Line: 1061 ]]
    -- upvalues: l__Elements__15 (copy), u4 (copy)
    if not p229.indicator then
        p229.indicator = p229.janitor:add(require(l__Elements__15.Indicator)(p229, u4));
    end;
    p229.indicatorSet:Fire(p230);
end;
function u4.destroy(p231) --[[ Line: 1076 ]]
    -- upvalues: u4 (copy)
    if p231.isDestroyed then
    else
        p231:clearNotices();
        if p231.parentIconUID then
            p231:leave();
        end;
        p231.isDestroyed = true;
        p231.janitor:clean();
        u4.iconRemoved:Fire(p231);
    end;
end;
u4.Destroy = u4.destroy;
return u4;