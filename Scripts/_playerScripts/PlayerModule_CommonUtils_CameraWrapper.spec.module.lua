-- Decompiled with Potassium's decompiler.

local l__CorePackages__1 = game:GetService("CorePackages");
local l__JestGlobals__2 = require(l__CorePackages__1.Packages.Dev.JestGlobals);
local l__describe__3 = l__JestGlobals__2.describe;
local l__expect__4 = l__JestGlobals__2.expect;
local l__it__5 = l__JestGlobals__2.it;
local l__waitForEvents__6 = require(l__CorePackages__1.Workspace.Packages.TestUtils).DeferredLuaHelpers.waitForEvents;
local l__CameraWrapper__7 = require(script.Parent.CameraWrapper);
l__describe__3("CameraWrapper", function() --[[ Line: 12 ]]
    -- upvalues: l__it__5 (copy), l__CameraWrapper__7 (copy), l__expect__4 (copy), l__waitForEvents__6 (copy)
    l__it__5("should instantiate", function() --[[ Line: 13 ]]
        -- upvalues: l__CameraWrapper__7 (ref), l__expect__4 (ref)
        l__expect__4((l__CameraWrapper__7.new())).never.toBeNil();
    end);
    l__it__5("should return updated camera", function() --[[ Line: 19 ]]
        -- upvalues: l__CameraWrapper__7 (ref), l__expect__4 (ref), l__waitForEvents__6 (ref)
        local v1 = l__CameraWrapper__7.new();
        v1:Enable();
        local v2 = Instance.new("Camera");
        v2.Parent = game.Workspace;
        l__expect__4(v1:getCamera()).toBe(game.Workspace.CurrentCamera);
        l__expect__4(v1:getCamera()).never.toBe(v2);
        game.Workspace.CurrentCamera = v2;
        l__waitForEvents__6();
        l__expect__4(v1:getCamera()).toBe(game.Workspace.CurrentCamera);
        l__expect__4(v1:getCamera()).toBe(v2);
    end);
end);