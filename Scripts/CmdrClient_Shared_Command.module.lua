-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Players__2 = game:GetService("Players");
local l__Argument__3 = require(script.Parent.Argument);
local u1 = l__RunService__1:IsServer();
local u2 = {};
u2.__index = u2;
function u2.new(p3) --[[ Line: 12 ]]
    -- upvalues: u2 (copy)
    local v4 = {
        Response = nil,
        Dispatcher = p3.Dispatcher,
        Cmdr = p3.Dispatcher.Cmdr,
        Name = p3.CommandObject.Name,
        RawText = p3.Text,
        Object = p3.CommandObject,
        Group = p3.CommandObject.Group,
        State = {},
        Aliases = p3.CommandObject.Aliases,
        Alias = p3.Alias,
        Description = p3.CommandObject.Description,
        Executor = p3.Executor,
        ArgumentDefinitions = p3.CommandObject.Args,
        RawArguments = p3.Arguments,
        Arguments = {},
        Data = p3.Data
    };
    setmetatable(v4, u2);
    return v4;
end;
function u2.Parse(p5, p6) --[[ Line: 40 ]]
    -- upvalues: l__Argument__3 (copy)
    local v7 = false;
    for v8, v10 in ipairs(p5.ArgumentDefinitions) do
        if type(v10) == "function" then
            local v10 = v10(p5);
            if v10 == nil then
                break;
            end;
        end;
        local v11;
        if v10.Default == nil then
            v11 = v10.Optional ~= true;
        else
            v11 = false;
        end;
        if v11 and v7 then
            error(("Command %q: Required arguments cannot occur after optional arguments."):format(p5.Name));
        else
            v7 = not v11 and true or v7;
        end;
        if p5.RawArguments[v8] == nil and (v11 and p6 ~= true) then
            return false, ("Required argument #%d %s is missing."):format(v8, v10.Name);
        end;
        if p5.RawArguments[v8] or p6 then
            p5.Arguments[v8] = l__Argument__3.new(p5, v10, p5.RawArguments[v8] or "");
        end;
    end;
    return true;
end;
function u2.Validate(p12, p13) --[[ Line: 72 ]]
    p12._Validated = true;
    local v14 = "";
    local v15 = true;
    for v16, v17 in pairs(p12.Arguments) do
        local v18, v19 = v17:Validate(p13);
        if not v18 then
            v14 = ("%s; #%d %s: %s"):format(v14, v16, v17.Name, v19 or "error");
            v15 = false;
        end;
    end;
    return v15, v14:sub(3);
end;
function u2.GetLastArgument(p20) --[[ Line: 91 ]]
    for v21 = #p20.Arguments, 1, -1 do
        if p20.Arguments[v21].RawValue then
            return p20.Arguments[v21];
        end;
    end;
end;
function u2.GatherArgumentValues(p22) --[[ Line: 100 ]]
    local v23 = {};
    for v24 = 1, #p22.ArgumentDefinitions do
        local v25 = p22.Arguments[v24];
        if v25 then
            v23[v24] = v25:GetValue();
        elseif type(p22.ArgumentDefinitions[v24]) == "table" then
            v23[v24] = p22.ArgumentDefinitions[v24].Default;
        end;
    end;
    return v23, #p22.ArgumentDefinitions;
end;
function u2.Run(p26) --[[ Line: 117 ]]
    -- upvalues: u1 (copy)
    if p26._Validated == nil then
        error("Must validate a command before running.");
    end;
    local v27 = p26.Dispatcher:RunHooks("BeforeRun", p26);
    if v27 then
        return v27;
    end;
    if not u1 and (p26.Object.Data and p26.Data == nil) then
        local v28, v29 = p26:GatherArgumentValues();
        p26.Data = p26.Object.Data(p26, unpack(v28, 1, v29));
    end;
    if not u1 and p26.Object.ClientRun then
        local v30, v31 = p26:GatherArgumentValues();
        p26.Response = p26.Object.ClientRun(p26, unpack(v30, 1, v31));
    end;
    if p26.Response == nil then
        if p26.Object.Run then
            local v32, v33 = p26:GatherArgumentValues();
            p26.Response = p26.Object.Run(p26, unpack(v32, 1, v33));
        elseif u1 then
            local _ = p26.Object.ClientRun;
            p26.Response = "No implementation.";
        else
            p26.Response = p26.Dispatcher:Send(p26.RawText, p26.Data);
        end;
    end;
    return p26.Dispatcher:RunHooks("AfterRun", p26) or p26.Response;
end;
function u2.GetArgument(p34, p35) --[[ Line: 162 ]]
    return p34.Arguments[p35];
end;
function u2.GetData(p36) --[[ Line: 170 ]]
    -- upvalues: u1 (copy)
    if p36.Data then
        return p36.Data;
    end;
    if p36.Object.Data and not u1 then
        p36.Data = p36.Object.Data(p36);
    end;
    return p36.Data;
end;
function u2.SendEvent(p37, p38, p39, ...) --[[ Line: 183 ]]
    -- upvalues: u1 (copy), l__Players__2 (copy)
    local v40 = typeof(p38) == "Instance";
    assert(v40, "Argument #1 must be a Player");
    local v41 = p38:IsA("Player");
    assert(v41, "Argument #1 must be a Player");
    local v42 = type(p39) == "string";
    assert(v42, "Argument #2 must be a string");
    if u1 then
        p37.Dispatcher.Cmdr.RemoteEvent:FireClient(p38, p39, ...);
    else
        if p37.Dispatcher.Cmdr.Events[p39] then
            assert(p38 == l__Players__2.LocalPlayer, "Event messages can only be sent to the local player on the client.");
            p37.Dispatcher.Cmdr.Events[p39](...);
        end;
    end;
end;
function u2.BroadcastEvent(p43, ...) --[[ Line: 197 ]]
    -- upvalues: u1 (copy)
    if not u1 then
        error("Can\'t broadcast event messages from the client.", 2);
    end;
    p43.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...);
end;
function u2.Reply(p44, ...) --[[ Line: 206 ]]
    return p44:SendEvent(p44.Executor, "AddLine", ...);
end;
function u2.GetStore(p45, ...) --[[ Line: 211 ]]
    return p45.Dispatcher.Cmdr.Registry:GetStore(...);
end;
function u2.HasImplementation(p46) --[[ Line: 216 ]]
    -- upvalues: l__RunService__1 (copy)
    return (l__RunService__1:IsClient() and p46.Object.ClientRun or p46.Object.Run) and true or false;
end;
return u2;