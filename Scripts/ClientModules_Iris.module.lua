-- Decompiled with Potassium's decompiler.

require(script.Types);
local u1 = {};
local u2 = require(script.Internal)(u1);
u1.Disabled = false;
u1.Args = {};
u1.Events = {};
function u1.Init(p3, u4, p5) --[[ Line: 73 ]]
    -- upvalues: u2 (copy), u1 (copy)
    assert(u2._shutdown == false, "Iris.Init() cannot be called once shutdown.");
    assert(u2._started == false and true or p5 == true, "Iris.Init() can only be called once.");
    if u2._started then
        return u1;
    end;
    if p3 == nil then
        p3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
    end;
    if u4 == nil then
        u4 = game:GetService("RunService").Heartbeat;
    end;
    u2.parentInstance = p3;
    u2._started = true;
    u2._generateRootInstance();
    u2._generateSelectionImageObject();
    for _, v6 in u2._initFunctions do
        v6();
    end;
    task.spawn(function() --[[ Line: 100 ]]
        -- upvalues: u4 (ref), u2 (ref)
        if typeof(u4) == "function" then
            while u2._started do
                local v7 = u4();
                u2._cycle(v7);
            end;
        elseif u4 ~= nil and u4 ~= false then
            u2._eventConnection = u4:Connect(function(...) --[[ Line: 107 ]]
                -- upvalues: u2 (ref)
                u2._cycle(...);
            end);
        end;
    end);
    return u1;
end;
function u1.Shutdown() --[[ Line: 122 ]]
    -- upvalues: u2 (copy)
    u2._started = false;
    u2._shutdown = true;
    if u2._eventConnection then
        u2._eventConnection:Disconnect();
    end;
    u2._eventConnection = nil;
    if u2._rootWidget then
        if u2._rootWidget.Instance then
            u2._widgets.Root.Discard(u2._rootWidget);
        end;
        u2._rootInstance = nil;
    end;
    if u2.SelectionImageObject then
        u2.SelectionImageObject:Destroy();
    end;
    for _, v8 in u2._connections do
        v8:Disconnect();
    end;
end;
function u1.Connect(_, p9) --[[ Line: 159 ]]
    -- upvalues: u2 (copy)
    if u2._started == false then
        warn("Iris:Connect() was called before calling Iris.Init(); always initialise Iris first.");
    end;
    local u10 = #u2._connectedFunctions + 1;
    u2._connectedFunctions[u10] = p9;
    return function() --[[ Line: 165 ]]
        -- upvalues: u2 (ref), u10 (copy)
        u2._connectedFunctions[u10] = nil;
    end;
end;
function u1.Append(p11) --[[ Line: 180 ]]
    -- upvalues: u2 (copy)
    local v12 = u2._GetParentWidget();
    local v13;
    if u2._config.Parent then
        v13 = u2._config.Parent;
    else
        v13 = u2._widgets[v12.type].ChildAdded(v12, {
            type = "userInstance"
        });
    end;
    p11.Parent = v13;
end;
function u1.End() --[[ Line: 218 ]]
    -- upvalues: u2 (copy)
    if u2._stackIndex == 1 then
        error("Too many calls to Iris.End().", 2);
    end;
    u2._IDStack[u2._stackIndex] = nil;
    local v14 = u2;
    v14._stackIndex = v14._stackIndex - 1;
end;
function u1.ForceRefresh() --[[ Line: 243 ]]
    -- upvalues: u2 (copy)
    u2._globalRefreshRequested = true;
end;
function u1.UpdateGlobalConfig(p15) --[[ Line: 265 ]]
    -- upvalues: u2 (copy), u1 (copy)
    for v16, v17 in p15 do
        u2._rootConfig[v16] = v17;
    end;
    u1.ForceRefresh();
end;
function u1.PushConfig(p18) --[[ Line: 290 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v19 = u1.State(-1);
    if v19.value == -1 then
        v19:set(p18);
    elseif u2._deepCompare(v19:get(), p18) == false then
        v19:set(p18);
        u2._refreshStack[u2._refreshLevel] = true;
        local v20 = u2;
        v20._refreshCounter = v20._refreshCounter + 1;
    end;
    local v21 = u2;
    v21._refreshLevel = v21._refreshLevel + 1;
    u2._config = setmetatable(p18, {
        __index = u2._config
    });
end;
function u1.PopConfig() --[[ Line: 318 ]]
    -- upvalues: u2 (copy)
    local v22 = u2;
    v22._refreshLevel = v22._refreshLevel - 1;
    if u2._refreshStack[u2._refreshLevel] == true then
        local v23 = u2;
        v23._refreshCounter = v23._refreshCounter - 1;
        u2._refreshStack[u2._refreshLevel] = nil;
    end;
    u2._config = getmetatable(u2._config).__index;
end;
u1.TemplateConfig = require(script.config);
u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
u1.UpdateGlobalConfig(u1.TemplateConfig.utilityDefault);
u2._globalRefreshRequested = false;
function u1.PushId(p24) --[[ Line: 354 ]]
    -- upvalues: u2 (copy)
    local v25 = typeof(p24) == "string";
    assert(v25, "The ID argument to Iris.PushId() to be a string.");
    u2._newID = true;
    table.insert(u2._pushedIds, p24);
end;
function u1.PopId() --[[ Line: 367 ]]
    -- upvalues: u2 (copy)
    if #u2._pushedIds == 0 then
    else
        table.remove(u2._pushedIds);
    end;
end;
function u1.SetNextWidgetID(p26) --[[ Line: 397 ]]
    -- upvalues: u2 (copy)
    u2._nextWidgetId = p26;
end;
function u1.State(p27) --[[ Line: 439 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v28 = u2._getID(2);
    if u2._states[v28] then
        return u2._states[v28];
    end;
    local v29 = {
        ID = v28,
        value = p27,
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(v29, u2.StateClass);
    u2._states[v28] = v29;
    return v29;
end;
function u1.WeakState(p30) --[[ Line: 465 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v31 = u2._getID(2);
    if u2._states[v31] then
        if next(u2._states[v31].ConnectedWidgets) ~= nil then
            return u2._states[v31];
        end;
        u2._states[v31] = nil;
    end;
    local v32 = {
        ID = v31,
        value = p30,
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(v32, u2.StateClass);
    u2._states[v31] = v32;
    return v32;
end;
function u1.VariableState(p33, p34) --[[ Line: 524 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v35 = u2._getID(2);
    local v36 = u2._states[v35];
    if v36 then
        if p33 ~= v36.value then
            v36:set(p33);
        end;
        return v36;
    end;
    local v37 = {
        ID = v35,
        value = p33,
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(v37, u2.StateClass);
    u2._states[v35] = v37;
    v37:onChange(p34);
    return v37;
end;
function u1.TableState(u38, u39, u40) --[[ Line: 604 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v41 = u38[u39];
    local v42 = u2._getID(2);
    local v43 = u2._states[v42];
    if v43 then
        if v41 ~= v43.value then
            v43:set(v41);
        end;
        return v43;
    end;
    local u44 = {
        ID = v42,
        value = v41,
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u44, u2.StateClass);
    u2._states[v42] = u44;
    u44:onChange(function() --[[ Line: 628 ]]
        -- upvalues: u40 (copy), u44 (copy), u38 (copy), u39 (copy)
        if u40 == nil then
            u38[u39] = u44.value;
        elseif u40(u44.value) then
            u38[u39] = u44.value;
        end;
    end);
    return u44;
end;
function u1.ComputedState(p45, u46) --[[ Line: 657 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v47 = u2._getID(2);
    if u2._states[v47] then
        return u2._states[v47];
    end;
    local u48 = {
        ID = v47,
        value = u46(p45.value),
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u48, u2.StateClass);
    u2._states[v47] = u48;
    p45:onChange(function(p49) --[[ Line: 673 ]]
        -- upvalues: u48 (copy), u46 (copy)
        u48:set(u46(p49));
    end);
    return u48;
end;
u1.ShowDemoWindow = require(script.demoWindow)(u1);
require(script.widgets)(u2);
require(script.API)(u1);
return u1;