-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
return function(u1) --[[ Line: 3 ]]
    local u2 = {
        _version = " 2.5.1 ",
        _started = false,
        _shutdown = false,
        _cycleTick = 0,
        _deltaTime = 0,
        _globalRefreshRequested = false,
        _refreshCounter = 0,
        _refreshLevel = 1,
        _refreshStack = table.create(16),
        _widgets = {},
        _stackIndex = 1,
        _rootInstance = nil
    };
    u2._rootWidget = {
        ID = "R",
        type = "Root",
        ZIndex = 0,
        ZOffset = 0,
        Instance = u2._rootInstance
    };
    u2._lastWidget = u2._rootWidget;
    u2._rootConfig = {};
    u2._config = u2._rootConfig;
    u2._IDStack = { "R" };
    u2._usedIDs = {};
    u2._pushedIds = {};
    u2._newID = false;
    u2._nextWidgetId = nil;
    u2._states = {};
    u2._postCycleCallbacks = {};
    u2._connectedFunctions = {};
    u2._connections = {};
    u2._initFunctions = {};
    u2._fullErrorTracebacks = game:GetService("RunService"):IsStudio();
    u2._cycleCoroutine = coroutine.create(function() --[[ Line: 73 ]]
        -- upvalues: u2 (copy)
        while u2._started do
            for _, v3 in u2._connectedFunctions do
                debug.profilebegin("Iris/Connection");
                local v4, v5 = pcall(v3);
                debug.profileend();
                if not v4 then
                    u2._stackIndex = 1;
                    coroutine.yield(false, v5);
                end;
            end;
            coroutine.yield(true);
        end;
    end);
    local v6 = {};
    v6.__index = v6;
    function v6.get(p7) --[[ Line: 131 ]]
        return p7.value;
    end;
    function v6.set(p8, p9, p10) --[[ Line: 144 ]]
        -- upvalues: u1 (copy), u2 (copy)
        if p9 == p8.value and p10 ~= true then
            return p8.value;
        end;
        p8.value = p9;
        p8.lastChangeTick = u1.Internal._cycleTick;
        for _, v11 in p8.ConnectedWidgets do
            if v11.lastCycleTick ~= -1 then
                u2._widgets[v11.type].UpdateState(v11);
            end;
        end;
        for _, v12 in p8.ConnectedFunctions do
            v12(p9);
        end;
        return p8.value;
    end;
    function v6.onChange(u13, p14) --[[ Line: 176 ]]
        local u15 = #u13.ConnectedFunctions + 1;
        u13.ConnectedFunctions[u15] = p14;
        return function() --[[ Line: 179 ]]
            -- upvalues: u13 (copy), u15 (copy)
            u13.ConnectedFunctions[u15] = nil;
        end;
    end;
    function v6.changed(p16) --[[ Line: 191 ]]
        -- upvalues: u2 (copy)
        return p16.lastChangeTick + 1 == u2._cycleTick;
    end;
    u2.StateClass = v6;
    function u2._cycle(p17) --[[ Line: 209 ]]
        -- upvalues: u1 (copy), u2 (copy)
        if u1.Disabled then
        else
            u2._rootWidget.lastCycleTick = u2._cycleTick;
            if u2._rootInstance == nil or u2._rootInstance.Parent == nil then
                u1.ForceRefresh();
            end;
            for _, v18 in u2._lastVDOM do
                if v18.lastCycleTick ~= u2._cycleTick and v18.lastCycleTick ~= -1 then
                    u2._DiscardWidget(v18);
                end;
            end;
            setmetatable(u2._lastVDOM, {
                __mode = "kv"
            });
            u2._lastVDOM = u2._VDOM;
            u2._VDOM = u2._generateEmptyVDOM();
            task.spawn(function() --[[ Line: 235 ]]
                -- upvalues: u2 (ref)
                for _, v19 in u2._postCycleCallbacks do
                    v19();
                end;
            end);
            if u2._globalRefreshRequested then
                u2._generateSelectionImageObject();
                u2._globalRefreshRequested = false;
                for _, v20 in u2._lastVDOM do
                    u2._DiscardWidget(v20);
                end;
                u2._generateRootInstance();
                u2._lastVDOM = u2._generateEmptyVDOM();
            end;
            local v21 = u2;
            v21._cycleTick = v21._cycleTick + 1;
            u2._deltaTime = p17;
            table.clear(u2._usedIDs);
            if (u2.parentInstance:IsA("GuiBase2d") or u2.parentInstance:IsA("BasePlayerGui")) == false then
                error("The Iris parent instance will not display any GUIs.");
            end;
            if u2._fullErrorTracebacks then
                for _, v22 in u2._connectedFunctions do
                    v22();
                end;
            else
                local v23 = coroutine.status(u2._cycleCoroutine);
                if v23 == "suspended" then
                    local _, v24, v25 = coroutine.resume(u2._cycleCoroutine);
                    if v24 == false then
                        error(v25, 0);
                    end;
                elseif v23 == "running" then
                    error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.");
                else
                    error("unrecoverable state");
                end;
            end;
            if u2._stackIndex ~= 1 then
                u2._stackIndex = 1;
                error("Too few calls to Iris.End().", 0);
            end;
            if #u2._pushedIds ~= 0 then
                error("Too few calls to Iris.PopId().", 0);
            end;
        end;
    end;
    function u2._NoOp() --[[ Line: 322 ]] end;
    function u2.WidgetConstructor(p26, p27) --[[ Line: 336 ]]
        -- upvalues: u2 (copy), u1 (copy)
        local v28 = {
            All = {
                Required = {
                    "Generate",
                    "Discard",
                    "Update",
                    "Args",
                    "Events",
                    "hasChildren",
                    "hasState"
                },
                Optional = {}
            },
            IfState = {
                Required = { "GenerateState", "UpdateState" },
                Optional = {}
            },
            IfChildren = {
                Required = { "ChildAdded" },
                Optional = { "ChildDiscarded" }
            }
        };
        local v29 = {};
        for _, v30 in v28.All.Required do
            local v31 = p27[v30] ~= nil;
            local v32 = `field {v30} is missing from widget {p26}, it is required for all widgets`;
            assert(v31, v32);
            v29[v30] = p27[v30];
        end;
        for _, v33 in v28.All.Optional do
            if p27[v33] == nil then
                v29[v33] = u2._NoOp;
            else
                v29[v33] = p27[v33];
            end;
        end;
        if p27.hasState then
            for _, v34 in v28.IfState.Required do
                local v35 = p27[v34] ~= nil;
                local v36 = `field {v34} is missing from widget {p26}, it is required for all widgets with state`;
                assert(v35, v36);
                v29[v34] = p27[v34];
            end;
            for _, v37 in v28.IfState.Optional do
                if p27[v37] == nil then
                    v29[v37] = u2._NoOp;
                else
                    v29[v37] = p27[v37];
                end;
            end;
        end;
        if p27.hasChildren then
            for _, v38 in v28.IfChildren.Required do
                local v39 = p27[v38] ~= nil;
                local v40 = `field {v38} is missing from widget {p26}, it is required for all widgets with children`;
                assert(v39, v40);
                v29[v38] = p27[v38];
            end;
            for _, v41 in v28.IfChildren.Optional do
                if p27[v41] == nil then
                    v29[v41] = u2._NoOp;
                else
                    v29[v41] = p27[v41];
                end;
            end;
        end;
        u2._widgets[p26] = v29;
        u1.Args[p26] = v29.Args;
        local v42 = {};
        for v43, v44 in v29.Args do
            v42[v44] = v43;
        end;
        v29.ArgNames = v42;
        for u45, _ in v29.Events do
            if u1.Events[u45] == nil then
                u1.Events[u45] = function() --[[ Line: 427 ]]
                    -- upvalues: u2 (ref), u45 (copy)
                    return u2._EventCall(u2._lastWidget, u45);
                end;
            end;
        end;
    end;
    function u2._Insert(p46, p47, p48) --[[ Line: 445 ]]
        -- upvalues: u2 (copy)
        local v49 = u2._getID(3);
        local v50 = u2._widgets[p46];
        if u2._VDOM[v49] then
            return u2._ContinueWidget(v49, p46);
        end;
        local v51 = {};
        if p47 ~= nil then
            for v52, v53 in type(p47) ~= "table" and { p47 } or p47 do
                local v54 = v52 > 0;
                local v55 = `Widget Arguments must be a positive number, not {v52} of type {typeof(v52)} for {v53}.`;
                assert(v54, v55);
                v51[v50.ArgNames[v52]] = v53;
            end;
        end;
        table.freeze(v51);
        local v56 = u2._lastVDOM[v49];
        if v56 and (p46 == v56.type and u2._refreshCounter > 0) then
            u2._DiscardWidget(v56);
            v56 = nil;
        end;
        if v56 == nil then
            v56 = u2._GenNewWidget(p46, v51, p48, v49);
        end;
        local l__parentWidget__1 = v56.parentWidget;
        if v56.type ~= "Window" and v56.type ~= "Tooltip" then
            if v56.ZIndex ~= l__parentWidget__1.ZOffset then
                l__parentWidget__1.ZUpdate = true;
            end;
            if l__parentWidget__1.ZUpdate then
                v56.ZIndex = l__parentWidget__1.ZOffset;
                if v56.Instance then
                    v56.Instance.ZIndex = v56.ZIndex;
                    v56.Instance.LayoutOrder = v56.ZIndex;
                end;
            end;
        end;
        if l__parentWidget__1.type == "Table" then
            l__parentWidget__1._rowCycles[l__parentWidget__1._rowIndex] = u2._cycleTick;
        end;
        if u2._deepCompare(v56.providedArguments, v51) == false then
            v56.arguments = u2._deepCopy(v51);
            v56.providedArguments = v51;
            v50.Update(v56);
        end;
        v56.lastCycleTick = u2._cycleTick;
        l__parentWidget__1.ZOffset = l__parentWidget__1.ZOffset + 1;
        if v50.hasChildren then
            v56.ZOffset = 0;
            v56.ZUpdate = false;
            local v57 = u2;
            v57._stackIndex = v57._stackIndex + 1;
            u2._IDStack[u2._stackIndex] = v56.ID;
        end;
        u2._VDOM[v49] = v56;
        u2._lastWidget = v56;
        return v56;
    end;
    function u2._GenNewWidget(p58, p59, p60, p61) --[[ Line: 546 ]]
        -- upvalues: u2 (copy)
        local v62 = u2._VDOM[u2._IDStack[u2._stackIndex]];
        local v63 = u2._widgets[p58];
        local u64 = {};
        setmetatable(u64, u64);
        u64.ID = p61;
        u64.type = p58;
        u64.parentWidget = v62;
        u64.trackedEvents = {};
        u64.ZIndex = v62.ZOffset;
        u64.Instance = v63.Generate(u64);
        local l__parentWidget__2 = u64.parentWidget;
        if u2._config.Parent then
            u64.Instance.Parent = u2._config.Parent;
        else
            u64.Instance.Parent = u2._widgets[l__parentWidget__2.type].ChildAdded(l__parentWidget__2, u64);
        end;
        u64.providedArguments = p59;
        u64.arguments = u2._deepCopy(p59);
        v63.Update(u64);
        local v65;
        if v63.hasState then
            if p60 then
                for v66, v67 in p60 do
                    if type(v67) ~= "table" or getmetatable(v67) ~= u2.StateClass then
                        p60[v66] = u2._widgetState(u64, v66, v67);
                    end;
                    p60[v66].lastChangeTick = u2._cycleTick;
                end;
                u64.state = p60;
                for _, v68 in p60 do
                    v68.ConnectedWidgets[u64.ID] = u64;
                end;
            else
                u64.state = {};
            end;
            v63.GenerateState(u64);
            v63.UpdateState(u64);
            u64.stateMT = {};
            setmetatable(u64.state, u64.stateMT);
            u64.__index = u64.state;
            v65 = u64.stateMT;
        else
            v65 = u64;
        end;
        function v65.__index(_, u69) --[[ Line: 612 ]]
            -- upvalues: u2 (ref), u64 (copy)
            return function() --[[ Line: 613 ]]
                -- upvalues: u2 (ref), u64 (ref), u69 (copy)
                return u2._EventCall(u64, u69);
            end;
        end;
        return u64;
    end;
    function u2._ContinueWidget(p70, p71) --[[ Line: 631 ]]
        -- upvalues: u2 (copy)
        local v72 = u2._widgets[p71];
        local v73 = u2._VDOM[p70];
        if v72.hasChildren then
            local v74 = u2;
            v74._stackIndex = v74._stackIndex + 1;
            u2._IDStack[u2._stackIndex] = v73.ID;
        end;
        u2._lastWidget = v73;
        return v73;
    end;
    function u2._DiscardWidget(p75) --[[ Line: 654 ]]
        -- upvalues: u2 (copy)
        local l__parentWidget__3 = p75.parentWidget;
        if l__parentWidget__3 then
            u2._widgets[l__parentWidget__3.type].ChildDiscarded(l__parentWidget__3, p75);
        end;
        u2._widgets[p75.type].Discard(p75);
        p75.lastCycleTick = -1;
    end;
    function u2._widgetState(p76, p77, p78) --[[ Line: 679 ]]
        -- upvalues: u2 (copy)
        local v79 = p76.ID .. p77;
        if u2._states[v79] then
            u2._states[v79].ConnectedWidgets[p76.ID] = p76;
            u2._states[v79].lastChangeTick = u2._cycleTick;
            return u2._states[v79];
        end;
        local v80 = {
            ID = v79,
            value = p78,
            lastChangeTick = u2._cycleTick,
            ConnectedWidgets = {
                [p76.ID] = p76
            },
            ConnectedFunctions = {}
        };
        setmetatable(v80, u2.StateClass);
        u2._states[v79] = v80;
        return v80;
    end;
    function u2._EventCall(p81, p82) --[[ Line: 709 ]]
        -- upvalues: u2 (copy)
        local v83 = u2._widgets[p81.type].Events[p82];
        local v84 = v83 ~= nil;
        local v85 = `widget {p81.type} has no event of name {p82}`;
        assert(v84, v85);
        if p81.trackedEvents[p82] == nil then
            v83.Init(p81);
            p81.trackedEvents[p82] = true;
        end;
        return v83.Get(p81);
    end;
    function u2._GetParentWidget() --[[ Line: 728 ]]
        -- upvalues: u2 (copy)
        return u2._VDOM[u2._IDStack[u2._stackIndex]];
    end;
    function u2._generateEmptyVDOM() --[[ Line: 742 ]]
        -- upvalues: u2 (copy)
        return {
            R = u2._rootWidget
        };
    end;
    function u2._generateRootInstance() --[[ Line: 755 ]]
        -- upvalues: u2 (copy)
        u2._rootInstance = u2._widgets.Root.Generate(u2._widgets.Root);
        u2._rootInstance.Parent = u2.parentInstance;
        u2._rootWidget.Instance = u2._rootInstance;
    end;
    function u2._generateSelectionImageObject() --[[ Line: 769 ]]
        -- upvalues: u2 (copy)
        if u2.SelectionImageObject then
            u2.SelectionImageObject:Destroy();
        end;
        local v86 = Instance.new("Frame");
        v86.Position = UDim2.fromOffset(-1, -1);
        v86.Size = UDim2.new(1, 2, 1, 2);
        v86.BackgroundColor3 = u2._config.SelectionImageObjectColor;
        v86.BackgroundTransparency = u2._config.SelectionImageObjectTransparency;
        v86.BorderSizePixel = 0;
        u2._utility.UIStroke(v86, 1, u2._config.SelectionImageObjectBorderColor, u2._config.SelectionImageObjectBorderTransparency);
        u2._utility.UICorner(v86, 2);
        u2.SelectionImageObject = v86;
    end;
    function u2._getID(p87) --[[ Line: 799 ]]
        -- upvalues: u2 (copy)
        if u2._nextWidgetId then
            local l___nextWidgetId__4 = u2._nextWidgetId;
            u2._nextWidgetId = nil;
            return l___nextWidgetId__4;
        end;
        local v88 = 1 + (p87 or 1);
        local v89 = debug.info(v88, "l");
        local v90 = "";
        while v89 ~= -1 and v89 ~= nil do
            v90 = v90 .. "+" .. v89;
            v88 = v88 + 1;
            v89 = debug.info(v88, "l");
        end;
        local v91 = u2._usedIDs[v90];
        local v92;
        if v91 then
            local l___usedIDs__5 = u2._usedIDs;
            l___usedIDs__5[v90] = l___usedIDs__5[v90] + 1;
            v92 = v91 + 1;
        else
            u2._usedIDs[v90] = 1;
            v92 = 1;
        end;
        if #u2._pushedIds == 0 then
            return v90 .. ":" .. v92;
        end;
        if not u2._newID then
            return v90 .. ":" .. v92 .. ":" .. table.concat(u2._pushedIds, "\\");
        end;
        u2._newID = false;
        return v90 .. "::" .. table.concat(u2._pushedIds, "\\");
    end;
    function u2._deepCompare(p93, p94) --[[ Line: 846 ]]
        -- upvalues: u2 (copy)
        for v95, v96 in p93 do
            local v97 = p94[v95];
            if type(v96) == "table" then
                if not v97 or type(v97) ~= "table" then
                    return false;
                end;
                if u2._deepCompare(v96, v97) == false then
                    return false;
                end;
            elseif type(v96) ~= type(v97) or v96 ~= v97 then
                return false;
            end;
        end;
        return true;
    end;
    function u2._deepCopy(p98) --[[ Line: 877 ]]
        -- upvalues: u2 (copy)
        local v99 = table.clone(p98);
        for v100, v101 in p98 do
            if type(v101) == "table" then
                v99[v100] = u2._deepCopy(v101);
            end;
        end;
        return v99;
    end;
    u2._lastVDOM = u2._generateEmptyVDOM();
    u2._VDOM = u2._generateEmptyVDOM();
    u1.Internal = u2;
    u1._config = u2._config;
    return u2;
end;