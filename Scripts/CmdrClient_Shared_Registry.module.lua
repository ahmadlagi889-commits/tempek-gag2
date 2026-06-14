-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Util__2 = require(script.Parent.Util);
local u16 = {
    Cmdr = nil,
    TypeMethods = l__Util__2.MakeDictionary({
        "Transform",
        "Validate",
        "Autocomplete",
        "Parse",
        "DisplayName",
        "Listable",
        "ValidateOnce",
        "Prefixes",
        "Default",
        "ArgumentOperatorAliases"
    }),
    CommandMethods = l__Util__2.MakeDictionary({
        "Name",
        "Aliases",
        "AutoExec",
        "Description",
        "Args",
        "Run",
        "ClientRun",
        "Data",
        "Group"
    }),
    CommandArgProps = l__Util__2.MakeDictionary({
        "Name",
        "Type",
        "Description",
        "Optional",
        "Default"
    }),
    Types = {},
    TypeAliases = {},
    Commands = {},
    CommandsArray = {},
    Hooks = {
        BeforeRun = {},
        AfterRun = {}
    },
    Stores = setmetatable({}, {
        __index = function(p1, p2) --[[ Name: __index, Line 20 ]]
            p1[p2] = {};
            return p1[p2];
        end
    }),
    AutoExecBuffer = {},
    RegisterType = function(p3, p4, p5) --[[ Name: RegisterType, Line 30 ]]
        if not p4 or typeof(p4) ~= "string" then
            error("Invalid type name provided: nil");
        end;
        if not p4:find("^[%d%l]%w*$") then
            error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p4));
        end;
        for v6 in pairs(p5) do
            if p3.TypeMethods[v6] == nil then
                error("Unknown key/method in type \"" .. p4 .. "\": " .. v6);
            end;
        end;
        if p3.Types[p4] ~= nil then
            error(("Type \"%s\" has already been registered."):format(p4));
        end;
        p5.Name = p4;
        p5.DisplayName = p5.DisplayName or p4;
        p3.Types[p4] = p5;
        if p5.Prefixes then
            p3:RegisterTypePrefix(p4, p5.Prefixes);
        end;
    end,
    RegisterTypePrefix = function(p7, p8, p9) --[[ Name: RegisterTypePrefix, Line 59 ]]
        if not p7.TypeAliases[p8] then
            p7.TypeAliases[p8] = p8;
        end;
        p7.TypeAliases[p8] = ("%s %s"):format(p7.TypeAliases[p8], p9);
    end,
    RegisterTypeAlias = function(p10, p11, p12) --[[ Name: RegisterTypeAlias, Line 67 ]]
        assert(p10.TypeAliases[p11] == nil, ("Type alias %s already exists!"):format(p12));
        p10.TypeAliases[p11] = p12;
    end,
    RegisterTypesIn = function(p13, p14) --[[ Name: RegisterTypesIn, Line 73 ]]
        for _, v15 in pairs(p14:GetChildren()) do
            if v15:IsA("ModuleScript") then
                v15.Parent = p13.Cmdr.ReplicatedRoot.Types;
                require(v15)(p13);
            else
                p13:RegisterTypesIn(v15);
            end;
        end;
    end
};
u16.RegisterHooksIn = u16.RegisterTypesIn;
function u16.RegisterCommandObject(p17, p18, _) --[[ Line: 90 ]]
    -- upvalues: l__RunService__1 (copy)
    for v19 in pairs(p18) do
        if p17.CommandMethods[v19] == nil then
            error("Unknown key/method in command " .. (p18.Name or "unknown command") .. ": " .. v19);
        end;
    end;
    if p18.Args then
        for v20, v21 in pairs(p18.Args) do
            if type(v21) == "table" then
                for v22 in pairs(v21) do
                    if p17.CommandArgProps[v22] == nil then
                        error(("Unknown property in command \"%s\" argument #%d: %s"):format(p18.Name or "unknown", v20, v22));
                    end;
                end;
            end;
        end;
    end;
    if p18.AutoExec and l__RunService__1:IsClient() then
        table.insert(p17.AutoExecBuffer, p18.AutoExec);
        p17:FlushAutoExecBufferDeferred();
    end;
    local v23 = p17.Commands[p18.Name:lower()];
    if v23 and v23.Aliases then
        for _, v24 in pairs(v23.Aliases) do
            p17.Commands[v24:lower()] = nil;
        end;
    elseif not v23 then
        table.insert(p17.CommandsArray, p18);
    end;
    p17.Commands[p18.Name:lower()] = p18;
    if p18.Aliases then
        for _, v25 in pairs(p18.Aliases) do
            p17.Commands[v25:lower()] = p18;
        end;
    end;
end;
function u16.RegisterCommand(p26, p27, p28, p29) --[[ Line: 135 ]]
    -- upvalues: l__RunService__1 (copy)
    local v30 = require(p27);
    local v31 = typeof(v30) == "table";
    local v32 = `Invalid return value from command script "{p27.Name}" (CommandDefinition expected, got {typeof(v30)})`;
    assert(v31, v32);
    if p28 then
        local v33 = l__RunService__1:IsServer();
        assert(v33, "The commandServerScript parameter is not valid for client usage.");
        v30.Run = require(p28);
    end;
    if p29 and not p29(v30) then
    else
        p26:RegisterCommandObject(v30);
        p27.Parent = p26.Cmdr.ReplicatedRoot.Commands;
    end;
end;
function u16.RegisterCommandsIn(p34, p35, p36) --[[ Line: 157 ]]
    local v37 = {};
    local v38 = {};
    for _, v39 in pairs(p35:GetChildren()) do
        if v39:IsA("ModuleScript") then
            if v39.Name:find("Server") then
                v37[v39] = true;
            else
                local v40 = p35:FindFirstChild(v39.Name .. "Server");
                if v40 then
                    v38[v40] = true;
                end;
                p34:RegisterCommand(v39, v40, p36);
            end;
        else
            p34:RegisterCommandsIn(v39, p36);
        end;
    end;
    for v41 in pairs(v37) do
        local _ = v38[v41];
    end;
end;
function u16.RegisterDefaultCommands(p42, u43) --[[ Line: 186 ]]
    -- upvalues: l__RunService__1 (copy), l__Util__2 (copy)
    local v44 = l__RunService__1:IsServer();
    assert(v44, "RegisterDefaultCommands cannot be called from the client.");
    local v45 = type(u43) == "table";
    if v45 then
        u43 = l__Util__2.MakeDictionary(u43);
    end;
    p42:RegisterCommandsIn(p42.Cmdr.DefaultCommandsFolder, v45 and function(p46) --[[ Line: 195 ]]
        -- upvalues: u43 (ref)
        return u43[p46.Group] or false;
    end or u43);
end;
function u16.GetCommand(p47, p48) --[[ Line: 201 ]]
    return p47.Commands[(p48 or ""):lower()];
end;
function u16.GetCommands(p49) --[[ Line: 207 ]]
    return p49.CommandsArray;
end;
function u16.GetCommandNames(p50) --[[ Line: 212 ]]
    local v51 = {};
    for _, v52 in pairs(p50.CommandsArray) do
        table.insert(v51, v52.Name);
    end;
    return v51;
end;
u16.GetCommandsAsStrings = u16.GetCommandNames;
function u16.GetTypeNames(p53) --[[ Line: 225 ]]
    local v54 = {};
    for v55 in pairs(p53.Types) do
        table.insert(v54, v55);
    end;
    return v54;
end;
function u16.GetType(p56, p57) --[[ Line: 237 ]]
    return p56.Types[p57];
end;
function u16.GetTypeName(p58, p59) --[[ Line: 242 ]]
    return p58.TypeAliases[p59] or p59;
end;
function u16.RegisterHook(p60, p61, p62, p63) --[[ Line: 247 ]]
    if not p60.Hooks[p61] then
        error(("Invalid hook name: %q"):format(p61), 2);
    end;
    table.insert(p60.Hooks[p61], {
        callback = p62,
        priority = p63 or 0
    });
    table.sort(p60.Hooks[p61], function(p64, p65) --[[ Line: 253 ]]
        return p64.priority < p65.priority;
    end);
end;
u16.AddHook = u16.RegisterHook;
function u16.GetStore(p66, p67) --[[ Line: 261 ]]
    return p66.Stores[p67];
end;
function u16.FlushAutoExecBufferDeferred(u68) --[[ Line: 266 ]]
    -- upvalues: l__RunService__1 (copy)
    if u68.AutoExecFlushConnection then
    else
        u68.AutoExecFlushConnection = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 271 ]]
            -- upvalues: u68 (copy)
            u68.AutoExecFlushConnection:Disconnect();
            u68.AutoExecFlushConnection = nil;
            u68:FlushAutoExecBuffer();
        end);
    end;
end;
function u16.FlushAutoExecBuffer(p69) --[[ Line: 279 ]]
    for _, v70 in ipairs(p69.AutoExecBuffer) do
        for _, v71 in ipairs(v70) do
            p69.Cmdr.Dispatcher:EvaluateAndRun(v71);
        end;
    end;
    p69.AutoExecBuffer = {};
end;
return function(p72) --[[ Line: 289 ]]
    -- upvalues: u16 (copy)
    u16.Cmdr = p72;
    return u16;
end;