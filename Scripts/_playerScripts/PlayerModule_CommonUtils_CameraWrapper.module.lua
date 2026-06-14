-- Decompiled with Potassium's decompiler.

local l__ConnectionUtil__1 = require(script.Parent.ConnectionUtil);
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 39 ]]
    -- upvalues: l__ConnectionUtil__1 (copy), u1 (copy)
    local v2 = {
        _enabled = false,
        _camera = game.Workspace.CurrentCamera,
        _callbacks = {},
        _connectionUtil = l__ConnectionUtil__1.new()
    };
    return setmetatable(v2, u1);
end;
function u1._connectCallbacks(p3) --[[ Line: 52 ]]
    p3._camera = game.Workspace.CurrentCamera;
    if p3._camera then
        for v4, v5 in p3._callbacks do
            p3._connectionUtil:trackConnection(v4, p3._camera:GetPropertyChangedSignal(v4):Connect(v5));
            v5();
        end;
    end;
end;
function u1.Enable(u6) --[[ Line: 65 ]]
    if u6._enabled then
    else
        u6._enabled = true;
        u6._cameraChangedConnection = game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 72 ]]
            -- upvalues: u6 (copy)
            u6:_connectCallbacks();
        end);
        u6:_connectCallbacks();
    end;
end;
function u1.Disable(p7) --[[ Line: 79 ]]
    if p7._enabled then
        p7._enabled = false;
        if p7._cameraChangedConnection then
            p7._cameraChangedConnection:Disconnect();
            p7._cameraChangedConnection = nil;
        end;
        p7._connectionUtil:disconnectAll();
    end;
end;
function u1.Connect(p8, p9, p10) --[[ Line: 94 ]]
    p8._callbacks[p9] = p10;
    if p8._camera then
        p8._connectionUtil:trackConnection(p9, p8._camera:GetPropertyChangedSignal(p9):Connect(p10));
    end;
end;
function u1.Disconnect(p11, p12) --[[ Line: 104 ]]
    p11._connectionUtil:disconnect(p12);
    p11._callbacks[p12] = nil;
end;
function u1.getCamera(p13) --[[ Line: 110 ]]
    return p13._camera;
end;
return u1;