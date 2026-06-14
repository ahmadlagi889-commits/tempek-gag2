-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TeleportService__2 = game:GetService("TeleportService");
local l__Players__3 = game:GetService("Players");
local l__Util__4 = require(script.Parent.Util);
local l__Command__5 = require(script.Parent.Command);
local u1 = false;
local u48 = {
    Cmdr = nil,
    Registry = nil,
    Evaluate = function(p2, p3, p4, p5, p6) --[[ Name: Evaluate, Line 21 ]]
        -- upvalues: l__RunService__1 (copy), l__Players__3 (copy), l__Util__4 (copy), l__Command__5 (copy)
        if l__RunService__1:IsClient() == true and p4 ~= l__Players__3.LocalPlayer then
            error("Can\'t evaluate a command that isn\'t sent by the local player.");
        end;
        local v7 = l__Util__4.SplitString(p3);
        local v8 = table.remove(v7, 1);
        local v9 = p2.Registry:GetCommand(v8);
        if v9 then
            local v10 = l__Util__4.MashExcessArguments(v7, #v9.Args);
            local v11 = l__Command__5.new({
                Dispatcher = p2,
                Text = p3,
                CommandObject = v9,
                Alias = v8,
                Executor = p4,
                Arguments = v10,
                Data = p6
            });
            local v12, v13 = v11:Parse(p5);
            if v12 then
                return v11;
            else
                return false, v13;
            end;
        else
            return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(v8)));
        end;
    end,
    EvaluateAndRun = function(p14, p15, p16, p17) --[[ Name: EvaluateAndRun, Line 58 ]]
        -- upvalues: l__Players__3 (copy), l__RunService__1 (copy)
        local v18 = p16 or l__Players__3.LocalPlayer;
        local v19 = p17 or {};
        if l__RunService__1:IsClient() and v19.IsHuman then
            p14:PushHistory(p15);
        end;
        local u20, v21 = p14:Evaluate(p15, v18, nil, v19.Data);
        if not u20 then
            return v21;
        end;
        local v25, v26 = xpcall(function() --[[ Line: 72 ]]
            -- upvalues: u20 (copy)
            local v22, v23 = u20:Validate(true);
            return v22 and (u20:Run() or "Command executed.") or v23;
        end, function(p24) --[[ Line: 80 ]]
            return debug.traceback((tostring(p24)));
        end);
        return v25 and v26 and v26 or "An error occurred while running this command. Check the console for more information.";
    end,
    Send = function(p27, p28, p29) --[[ Name: Send, Line 91 ]]
        -- upvalues: l__RunService__1 (copy)
        if l__RunService__1:IsClient() == false then
            error("Dispatcher:Send can only be called from the client.");
        end;
        return p27.Cmdr.RemoteFunction:InvokeServer(p28, {
            Data = p29
        });
    end,
    Run = function(p30, ...) --[[ Name: Run, Line 103 ]]
        -- upvalues: l__Players__3 (copy)
        if not l__Players__3.LocalPlayer then
            error("Dispatcher:Run can only be called from the client.");
        end;
        local v31 = { ... };
        local v32 = v31[1];
        for v33 = 2, #v31 do
            v32 = v32 .. " " .. tostring(v31[v33]);
        end;
        local v34, v35 = p30:Evaluate(v32, l__Players__3.LocalPlayer);
        if not v34 then
            error(v35);
        end;
        local v36, v37 = v34:Validate(true);
        if not v36 then
            error(v37);
        end;
        return v34:Run();
    end,
    RunHooks = function(p38, p39, p40, ...) --[[ Name: RunHooks, Line 131 ]]
        -- upvalues: l__RunService__1 (copy), u1 (ref)
        if not p38.Registry.Hooks[p39] then
            error(("Invalid hook name: %q"):format(p39), 2);
        end;
        if p39 == "BeforeRun" and (#p38.Registry.Hooks[p39] == 0 and (p40.Group ~= "DefaultUtil" and (p40.Group ~= "UserAlias" and p40:HasImplementation()))) then
            if not l__RunService__1:IsStudio() then
                return "Command blocked for security as no BeforeRun hook is configured.";
            end;
            if u1 == false then
                p40:Reply((l__RunService__1:IsServer() and "<Server>" or "<Client>") .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26));
                u1 = true;
            end;
        end;
        for _, v41 in ipairs(p38.Registry.Hooks[p39]) do
            local v42 = v41.callback(p40, ...);
            if v42 ~= nil then
                return tostring(v42);
            end;
        end;
    end,
    PushHistory = function(p43, p44) --[[ Name: PushHistory, Line 163 ]]
        -- upvalues: l__RunService__1 (copy), l__Util__4 (copy), l__TeleportService__2 (copy)
        local v45 = l__RunService__1:IsClient();
        assert(v45, "PushHistory may only be used from the client.");
        local v46 = p43:GetHistory();
        if l__Util__4.TrimString(p44) == "" or p44 == v46[#v46] then
        else
            v46[#v46 + 1] = p44;
            l__TeleportService__2:SetTeleportSetting("CmdrCommandHistory", v46);
        end;
    end,
    GetHistory = function(_) --[[ Name: GetHistory, Line 178 ]]
        -- upvalues: l__RunService__1 (copy), l__TeleportService__2 (copy)
        local v47 = l__RunService__1:IsClient();
        assert(v47, "GetHistory may only be used from the client.");
        return l__TeleportService__2:GetTeleportSetting("CmdrCommandHistory") or {};
    end
};
return function(p49) --[[ Line: 184 ]]
    -- upvalues: u48 (copy)
    u48.Cmdr = p49;
    u48.Registry = p49.Registry;
    return u48;
end;