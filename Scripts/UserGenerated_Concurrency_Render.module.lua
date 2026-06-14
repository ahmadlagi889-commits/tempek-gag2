-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Logging__3 = require(l__ReplicatedStorage__1.UserGenerated.Logging);
local l__Asserts__4 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local u6 = table.freeze({
    __index = table.freeze({
        Disconnect = function(p1) --[[ Name: Disconnect, Line 53 ]]
            p1.Connection:Disconnect();
            p1:OnDisconnected();
        end,
        OnDisconnected = function(p2) --[[ Name: OnDisconnected, Line 58 ]]
            if p2.Vars.Disconnected then
            else
                p2.Vars.Disconnected = true;
                for _, v3 in ipairs(p2.Callbacks) do
                    task.spawn(v3);
                end;
                table.clear(p2.Callbacks);
            end;
        end,
        Then = function(p4, p5) --[[ Name: Then, Line 69 ]]
            -- upvalues: l__Asserts__4 (copy)
            l__Asserts__4.Function(p5);
            if p4.Vars.Disconnected then
                task.spawn(p5);
            else
                table.insert(p4.Callbacks, p5);
            end;
        end
    })
});
function new(u7, u8)
    -- upvalues: l__Asserts__4 (copy), u6 (copy), l__RunService__2 (copy), l__Logging__3 (copy)
    l__Asserts__4.FiniteNonNegative(u7);
    l__Asserts__4.Function(u8);
    local u9 = setmetatable({
        Connection = nil,
        Callbacks = {},
        Vars = {
            Disconnected = false
        }
    }, u6);
    local u10 = 0;
    local u11 = nil;
    u11 = l__RunService__2.RenderStepped:Connect(function(p12) --[[ Line: 99 ]]
        -- upvalues: u10 (ref), u7 (copy), u11 (ref), u8 (copy), l__Logging__3 (ref), u9 (copy)
        local v13 = false;
        local v14 = u10;
        u10 = u10 + p12;
        if u7 <= u10 then
            u10 = u7;
            u11:Disconnect();
            v13 = true;
        end;
        local v15, v16 = pcall(u8, u7 <= u10 and 1 or u10 / u7, u10, u10 - v14);
        if not v15 then
            l__Logging__3.Warn("RenderError", v16);
        end;
        if not v15 or v16 ~= nil then
            u11:Disconnect();
            v13 = true;
        end;
        if v13 then
            u9:OnDisconnected();
        end;
    end);
    u9.Connection = u11;
    table.freeze(u9);
    return u9;
end;
return new;