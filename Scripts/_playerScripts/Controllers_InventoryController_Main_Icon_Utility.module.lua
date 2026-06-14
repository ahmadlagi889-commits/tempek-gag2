-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
function u1.createStagger(p2, u3, u4) --[[ Line: 13 ]]
    local u5 = false;
    local u6 = false;
    local u7 = (not p2 or p2 == 0) and 0.01 or p2;
    local function u9(...) --[[ Line: 29 ]]
        -- upvalues: u5 (ref), u6 (ref), u4 (copy), u7 (ref), u3 (copy), u9 (copy)
        if u5 then
            u6 = true;
        else
            local u8 = table.pack(...);
            u5 = true;
            u6 = false;
            task.spawn(function() --[[ Line: 37 ]]
                -- upvalues: u4 (ref), u7 (ref), u3 (ref), u8 (copy)
                if u4 then
                    task.wait(u7);
                end;
                u3(table.unpack(u8));
            end);
            task.delay(u7, function() --[[ Line: 43 ]]
                -- upvalues: u5 (ref), u6 (ref), u9 (ref), u8 (copy)
                u5 = false;
                if u6 then
                    u9(table.unpack(u8));
                end;
            end);
        end;
    end;
    return u9;
end;
function u1.round(p10) --[[ Line: 55 ]]
    return math.floor(p10 + 0.5);
end;
function u1.reverseTable(p11) --[[ Line: 60 ]]
    for v12 = 1, math.floor(#p11 / 2) do
        local v13 = #p11 - v12 + 1;
        local v14 = p11[v13];
        local v15 = p11[v12];
        p11[v12] = v14;
        p11[v13] = v15;
    end;
end;
function u1.copyTable(p16) --[[ Line: 67 ]]
    -- upvalues: u1 (copy)
    local v17 = type(p16) == "table";
    assert(v17, "First argument must be a table");
    local v18 = table.create(#p16);
    for v19, v20 in pairs(p16) do
        if type(v20) == "table" then
            v18[v19] = u1.copyTable(v20);
        else
            v18[v19] = v20;
        end;
    end;
    return v18;
end;
local u21 = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "<",
    ">",
    "?",
    "@",
    "{",
    "}",
    "[",
    "]",
    "!",
    "(",
    ")",
    "=",
    "+",
    "~",
    "#"
};
function u1.generateUID(p22) --[[ Line: 82 ]]
    -- upvalues: u21 (copy)
    local v23 = u21;
    local v24 = #v23;
    local v25 = "";
    for _ = 1, p22 or 8 do
        v25 = v25 .. v23[math.random(1, v24)];
    end;
    return v25;
end;
local u26 = {};
function u1.setVisible(u27, p28, p29) --[[ Line: 95 ]]
    -- upvalues: u26 (copy)
    local v30 = u26[u27];
    if not v30 then
        v30 = {};
        u26[u27] = v30;
        u27.Destroying:Once(function() --[[ Line: 104 ]]
            -- upvalues: u26 (ref), u27 (copy)
            u26[u27] = nil;
        end);
    end;
    if p28 then
        v30[p29] = nil;
    else
        v30[p29] = true;
    end;
    if p28 then
        for _, _ in pairs(v30) do
            p28 = false;
            break;
        end;
    end;
    u27.Visible = p28;
end;
function u1.formatStateName(p31) --[[ Line: 123 ]]
    return string.upper((string.sub(p31, 1, 1))) .. string.lower((string.sub(p31, 2)));
end;
function u1.localPlayerRespawned(p32) --[[ Line: 127 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    l__LocalPlayer__1.CharacterRemoving:Connect(p32);
end;
function u1.getClippedContainer(p33) --[[ Line: 137 ]]
    local v34 = p33:FindFirstChild("ClippedContainer");
    if not v34 then
        v34 = Instance.new("Folder");
        v34.Name = "ClippedContainer";
        v34.Parent = p33;
    end;
    return v34;
end;
local l__Janitor__2 = require(script.Parent.Packages.Janitor);
local l__GuiService__3 = game:GetService("GuiService");
function u1.clipOutside(u35, u36) --[[ Line: 151 ]]
    -- upvalues: l__Janitor__2 (copy), u1 (copy), l__GuiService__3 (copy)
    local u37 = u35.janitor:add(l__Janitor__2.new());
    u36.Destroying:Once(function() --[[ Line: 153 ]]
        -- upvalues: u37 (copy)
        u37:Destroy();
    end);
    u35.janitor:add(u36);
    local l__Parent__4 = u36.Parent;
    local u38 = u37:add(Instance.new("Frame"));
    u38:SetAttribute("IsAClippedClone", true);
    u38.Name = u36.Name;
    u38.AnchorPoint = u36.AnchorPoint;
    u38.Size = u36.Size;
    u38.Position = u36.Position;
    u38.BackgroundTransparency = 1;
    u38.LayoutOrder = u36.LayoutOrder;
    u38.Parent = l__Parent__4;
    local v39 = Instance.new("ObjectValue");
    v39.Name = "OriginalInstance";
    v39.Value = u36;
    v39.Parent = u38;
    local v40 = v39:Clone();
    u36:SetAttribute("HasAClippedClone", true);
    v40.Name = "ClippedClone";
    v40.Value = u38;
    v40.Parent = u36;
    local u41 = nil;
    local function v43() --[[ Line: 181 ]]
        -- upvalues: l__Parent__4 (copy), u41 (ref), u36 (copy), u1 (ref)
        local v42 = l__Parent__4:FindFirstAncestorWhichIsA("ScreenGui");
        if not string.match(v42.Name, "Clipped") then
            v42 = v42.Parent[v42.Name .. "Clipped"];
        end;
        u41 = v42;
        u36.AnchorPoint = Vector2.new(0, 0);
        u36.Parent = u1.getClippedContainer(u41);
    end;
    u37:add(u35.alignmentChanged:Connect(v43));
    v43();
    local u44 = u41;
    for _, v45 in pairs(u36:GetChildren()) do
        if v45:IsA("UIAspectRatioConstraint") then
            v45:Clone().Parent = u38;
        end;
    end;
    local l__widget__5 = u35.widget;
    local u46 = false;
    local u47 = u36:GetAttribute("IgnoreVisibilityUpdater");
    local function v48() --[[ Line: 203 ]]
        -- upvalues: u47 (copy), l__widget__5 (copy), u46 (ref), u1 (ref), u36 (copy)
        if u47 then
        else
            local l__Visible__6 = l__widget__5.Visible;
            if u46 then
                l__Visible__6 = false;
            end;
            u1.setVisible(u36, l__Visible__6, "ClipHandler");
        end;
    end;
    u37:add(l__widget__5:GetPropertyChangedSignal("Visible"):Connect(v48));
    local u49 = nil;
    local l__iconModule__7 = require(u35.iconModule);
    local function u56() --[[ Line: 218 ]]
        -- upvalues: u35 (copy), u36 (copy), l__iconModule__7 (copy), u46 (ref), u47 (copy), l__widget__5 (copy), u1 (ref), u49 (ref), u56 (copy), u37 (copy)
        task.defer(function() --[[ Line: 220 ]]
            -- upvalues: u35 (ref), u36 (ref), l__iconModule__7 (ref), u46 (ref), u47 (ref), l__widget__5 (ref), u1 (ref), u49 (ref), u56 (ref), u37 (ref)
            local v50 = nil;
            local l__UID__8 = u35.UID;
            local v51;
            if u36:GetAttribute("ClipToJoinedParent") then
                v51 = l__UID__8;
                for _ = 1, 10 do
                    local v52 = l__iconModule__7.getIconByUID(l__UID__8);
                    if not v52 then
                        break;
                    end;
                    local l__joinedFrame__9 = v52.joinedFrame;
                    l__UID__8 = v52.parentIconUID;
                    if not l__joinedFrame__9 then
                        break;
                    end;
                    v50 = l__joinedFrame__9;
                end;
            else
                v51 = l__UID__8;
            end;
            if v50 then
                local l__AbsolutePosition__10 = u36.AbsolutePosition;
                local v53 = u36.AbsoluteSize / 2;
                local l__AbsolutePosition__11 = v50.AbsolutePosition;
                local l__AbsoluteSize__12 = v50.AbsoluteSize;
                local v54 = l__AbsolutePosition__10 + v53;
                local v55 = v54.X < l__AbsolutePosition__11.X or (v54.X > l__AbsolutePosition__11.X + l__AbsoluteSize__12.X or (v54.Y < l__AbsolutePosition__11.Y or v54.Y > l__AbsolutePosition__11.Y + l__AbsoluteSize__12.Y));
                if v55 ~= u46 then
                    u46 = v55;
                    if not u47 then
                        local l__Visible__13 = l__widget__5.Visible;
                        if u46 then
                            l__Visible__13 = false;
                        end;
                        u1.setVisible(u36, l__Visible__13, "ClipHandler");
                    end;
                end;
                if v50:IsA("ScrollingFrame") and u49 ~= v50 then
                    u49 = v50;
                    u37:add(v50:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() --[[ Line: 262 ]]
                        -- upvalues: u56 (ref)
                        u56();
                    end), "Disconnect", "TrackUtilityScroller-" .. v51);
                end;
            else
                u46 = false;
                if u47 then
                else
                    local l__Visible__14 = l__widget__5.Visible;
                    if u46 then
                        l__Visible__14 = false;
                    end;
                    u1.setVisible(u36, l__Visible__14, "ClipHandler");
                end;
            end;
        end);
    end;
    local l__CurrentCamera__15 = workspace.CurrentCamera;
    local u57 = u36:GetAttribute("AdditionalOffsetX") or 0;
    local function v73(u58) --[[ Line: 272 ]]
        -- upvalues: u38 (copy), l__CurrentCamera__15 (copy), u36 (copy), l__GuiService__3 (ref), u44 (ref), u35 (copy), u57 (copy), l__iconModule__7 (copy), u46 (ref), u47 (copy), l__widget__5 (copy), u1 (ref), u49 (ref), u56 (copy), u37 (copy)
        local u59 = "Absolute" .. u58;
        local function v70() --[[ Line: 274 ]]
            -- upvalues: u38 (ref), u59 (copy), u58 (copy), l__CurrentCamera__15 (ref), u36 (ref), l__GuiService__3 (ref), u44 (ref), u35 (ref), u57 (ref), l__iconModule__7 (ref), u46 (ref), u47 (ref), l__widget__5 (ref), u1 (ref), u49 (ref), u56 (ref), u37 (ref)
            local v60 = u38[u59];
            local v61 = UDim2.fromOffset(v60.X, v60.Y);
            if u58 == "Position" then
                local v62 = l__CurrentCamera__15.ViewportSize.X - u36.AbsoluteSize.X - 4;
                local l__Offset__16 = v61.X.Offset;
                if l__Offset__16 < 4 then
                    v62 = 4;
                elseif v62 >= l__Offset__16 then
                    v62 = l__Offset__16;
                end;
                local v63 = UDim2.fromOffset(v62, v61.Y.Offset);
                local l__TopbarInset__17 = l__GuiService__3.TopbarInset;
                local l__X__18 = workspace.CurrentCamera.ViewportSize.X;
                local l__X__19 = u44.AbsoluteSize.X;
                local l__X__20 = u44.AbsolutePosition.X;
                local _ = l__X__20 - l__TopbarInset__17.Min.X;
                if not u35.isOldTopbar then
                    l__X__20 = l__X__18 - l__X__19 - 0;
                end;
                v61 = v63 + UDim2.fromOffset(-(l__X__20 - u57), l__TopbarInset__17.Height);
                task.defer(function() --[[ Line: 220 ]]
                    -- upvalues: u35 (ref), u36 (ref), l__iconModule__7 (ref), u46 (ref), u47 (ref), l__widget__5 (ref), u1 (ref), u49 (ref), u56 (ref), u37 (ref)
                    local v64 = nil;
                    local l__UID__21 = u35.UID;
                    local v65;
                    if u36:GetAttribute("ClipToJoinedParent") then
                        v65 = l__UID__21;
                        for _ = 1, 10 do
                            local v66 = l__iconModule__7.getIconByUID(l__UID__21);
                            if not v66 then
                                break;
                            end;
                            local l__joinedFrame__22 = v66.joinedFrame;
                            l__UID__21 = v66.parentIconUID;
                            if not l__joinedFrame__22 then
                                break;
                            end;
                            v64 = l__joinedFrame__22;
                        end;
                    else
                        v65 = l__UID__21;
                    end;
                    if v64 then
                        local l__AbsolutePosition__23 = u36.AbsolutePosition;
                        local v67 = u36.AbsoluteSize / 2;
                        local l__AbsolutePosition__24 = v64.AbsolutePosition;
                        local l__AbsoluteSize__25 = v64.AbsoluteSize;
                        local v68 = l__AbsolutePosition__23 + v67;
                        local v69 = v68.X < l__AbsolutePosition__24.X or (v68.X > l__AbsolutePosition__24.X + l__AbsoluteSize__25.X or (v68.Y < l__AbsolutePosition__24.Y or v68.Y > l__AbsolutePosition__24.Y + l__AbsoluteSize__25.Y));
                        if v69 ~= u46 then
                            u46 = v69;
                            if not u47 then
                                local l__Visible__26 = l__widget__5.Visible;
                                if u46 then
                                    l__Visible__26 = false;
                                end;
                                u1.setVisible(u36, l__Visible__26, "ClipHandler");
                            end;
                        end;
                        if v64:IsA("ScrollingFrame") and u49 ~= v64 then
                            u49 = v64;
                            u37:add(v64:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() --[[ Line: 262 ]]
                                -- upvalues: u56 (ref)
                                u56();
                            end), "Disconnect", "TrackUtilityScroller-" .. v65);
                        end;
                    else
                        u46 = false;
                        if u47 then
                        else
                            local l__Visible__27 = l__widget__5.Visible;
                            if u46 then
                                l__Visible__27 = false;
                            end;
                            u1.setVisible(u36, l__Visible__27, "ClipHandler");
                        end;
                    end;
                end);
            end;
            u36[u58] = v61;
        end;
        local v71 = u1.createStagger(0.01, v70);
        u37:add(u38:GetPropertyChangedSignal(u59):Connect(v71));
        local v72 = u1.createStagger(0.5, v70, true);
        u37:add(u38:GetPropertyChangedSignal(u59):Connect(v72));
    end;
    task.delay(0.1, u56);
    task.defer(function() --[[ Line: 220 ]]
        -- upvalues: u35 (copy), u36 (copy), l__iconModule__7 (copy), u46 (ref), u47 (copy), l__widget__5 (copy), u1 (ref), u49 (ref), u56 (copy), u37 (copy)
        local v74 = nil;
        local l__UID__28 = u35.UID;
        local v75;
        if u36:GetAttribute("ClipToJoinedParent") then
            v75 = l__UID__28;
            for _ = 1, 10 do
                local v76 = l__iconModule__7.getIconByUID(l__UID__28);
                if not v76 then
                    break;
                end;
                local l__joinedFrame__29 = v76.joinedFrame;
                l__UID__28 = v76.parentIconUID;
                if not l__joinedFrame__29 then
                    break;
                end;
                v74 = l__joinedFrame__29;
            end;
        else
            v75 = l__UID__28;
        end;
        if v74 then
            local l__AbsolutePosition__30 = u36.AbsolutePosition;
            local v77 = u36.AbsoluteSize / 2;
            local l__AbsolutePosition__31 = v74.AbsolutePosition;
            local l__AbsoluteSize__32 = v74.AbsoluteSize;
            local v78 = l__AbsolutePosition__30 + v77;
            local v79 = v78.X < l__AbsolutePosition__31.X or (v78.X > l__AbsolutePosition__31.X + l__AbsoluteSize__32.X or (v78.Y < l__AbsolutePosition__31.Y or v78.Y > l__AbsolutePosition__31.Y + l__AbsoluteSize__32.Y));
            if v79 ~= u46 then
                u46 = v79;
                if not u47 then
                    local l__Visible__33 = l__widget__5.Visible;
                    if u46 then
                        l__Visible__33 = false;
                    end;
                    u1.setVisible(u36, l__Visible__33, "ClipHandler");
                end;
            end;
            if v74:IsA("ScrollingFrame") and u49 ~= v74 then
                u49 = v74;
                u37:add(v74:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() --[[ Line: 262 ]]
                    -- upvalues: u56 (ref)
                    u56();
                end), "Disconnect", "TrackUtilityScroller-" .. v75);
            end;
        else
            u46 = false;
            if u47 then
            else
                local l__Visible__34 = l__widget__5.Visible;
                if u46 then
                    l__Visible__34 = false;
                end;
                u1.setVisible(u36, l__Visible__34, "ClipHandler");
            end;
        end;
    end);
    if not u47 then
        local l__Visible__35 = l__widget__5.Visible;
        if u46 then
            l__Visible__35 = false;
        end;
        u1.setVisible(u36, l__Visible__35, "ClipHandler");
    end;
    v73("Position");
    u37:add(u36:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 333 ]] end));
    if u36:GetAttribute("TrackCloneSize") then
        v73("Size");
    else
        u37:add(u36:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 342 ]]
            -- upvalues: u36 (copy), u38 (copy)
            local l__AbsoluteSize__36 = u36.AbsoluteSize;
            u38.Size = UDim2.fromOffset(l__AbsoluteSize__36.X, l__AbsoluteSize__36.Y);
        end));
    end;
    return u38;
end;
function u1.joinFeature(u80, u81, u82, p83) --[[ Line: 351 ]]
    local l__joinJanitor__37 = u80.joinJanitor;
    l__joinJanitor__37:clean();
    if p83 then
        u80.parentIconUID = u81.UID;
        u80.joinedFrame = p83;
        l__joinJanitor__37:add(u81.alignmentChanged:Connect(function() --[[ Name: updateAlignent, Line 362 ]]
            -- upvalues: u81 (copy), u80 (copy)
            local l__alignment__38 = u81.alignment;
            u80:setAlignment(l__alignment__38 == "Center" and "Left" or l__alignment__38, true);
        end));
        local l__alignment__39 = u81.alignment;
        u80:setAlignment(l__alignment__39 == "Center" and "Left" or l__alignment__39, true);
        u80:modifyTheme({ "IconButton", "BackgroundTransparency", 1 }, "JoinModification");
        u80:modifyTheme({ "ClickRegion", "Active", false }, "JoinModification");
        if u81.childModifications then
            task.defer(function() --[[ Line: 377 ]]
                -- upvalues: u80 (copy), u81 (copy)
                u80:modifyTheme(u81.childModifications, u81.childModificationsUID);
            end);
        end;
        local u84 = u80:getInstance("ClickRegion");
        local function v85() --[[ Line: 383 ]]
            -- upvalues: u84 (copy), u81 (copy)
            u84.Selectable = u81.isSelected;
        end;
        l__joinJanitor__37:add(u81.toggled:Connect(v85));
        task.defer(v85);
        l__joinJanitor__37:add(function() --[[ Line: 388 ]]
            -- upvalues: u84 (copy)
            u84.Selectable = true;
        end);
        local l__UID__40 = u80.UID;
        table.insert(u82, l__UID__40);
        u81:autoDeselect(false);
        u81.childIconsDict[l__UID__40] = true;
        if not u81.isEnabled then
            u81:setEnabled(true);
        end;
        u80.joinedParent:Fire(u81);
        l__joinJanitor__37:add(function() --[[ Line: 406 ]]
            -- upvalues: u80 (copy), u82 (copy), l__UID__40 (copy), u81 (copy)
            if not u80.joinedFrame then
                return;
            end;
            for v86, v87 in pairs(u82) do
                if v87 == l__UID__40 then
                    table.remove(u82, v86);
                    break;
                end;
            end;
            local v88 = require(u80.iconModule).getIconByUID(u80.parentIconUID);
            if v88 then
                u80:setAlignment(u80.originalAlignment);
                u80.parentIconUID = false;
                u80.joinedFrame = false;
                u80:setBehaviour("IconButton", "BackgroundTransparency", nil, true);
                u80:removeModification("JoinModification");
                local v89 = true;
                local l__childIconsDict__41 = v88.childIconsDict;
                l__childIconsDict__41[l__UID__40] = nil;
                for _, _ in pairs(l__childIconsDict__41) do
                    v89 = false;
                    break;
                end;
                if v89 and not v88.isAnOverflow then
                    v88:setEnabled(false);
                end;
                local l__alignment__42 = u81.alignment;
                u80:setAlignment(l__alignment__42 == "Center" and "Left" or l__alignment__42, true);
            end;
        end);
    else
        u80:leave();
    end;
end;
return u1;