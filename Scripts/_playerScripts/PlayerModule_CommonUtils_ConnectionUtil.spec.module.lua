-- Decompiled with Potassium's decompiler.

local l__CorePackages__1 = game:GetService("CorePackages");
local l__JestGlobals__2 = require(l__CorePackages__1.Packages.Dev.JestGlobals);
local l__describe__3 = l__JestGlobals__2.describe;
local l__expect__4 = l__JestGlobals__2.expect;
local l__it__5 = l__JestGlobals__2.it;
local l__Signal__6 = require(l__CorePackages__1.Workspace.Packages.AppCommonLib).Signal;
local l__ConnectionUtil__7 = require(script.Parent.ConnectionUtil);
l__describe__3("ConnectionUtil", function() --[[ Line: 13 ]]
    -- upvalues: l__it__5 (copy), l__ConnectionUtil__7 (copy), l__expect__4 (copy), l__Signal__6 (copy)
    l__it__5("should instantiate", function() --[[ Line: 14 ]]
        -- upvalues: l__ConnectionUtil__7 (ref), l__expect__4 (ref)
        l__expect__4((l__ConnectionUtil__7.new())).never.toBeNil();
    end);
    l__it__5("should track a connection", function() --[[ Line: 20 ]]
        -- upvalues: l__ConnectionUtil__7 (ref), l__Signal__6 (ref), l__expect__4 (ref)
        local v1 = l__ConnectionUtil__7.new();
        local v2 = l__Signal__6.new();
        local u3 = "";
        v1:trackConnection("Signal", v2:Connect(function(p4) --[[ Line: 27 ]]
            -- upvalues: u3 (ref)
            u3 = p4;
        end));
        v2:fire("Testing");
        l__expect__4(u3).toBe("Testing");
    end);
    l__it__5("should disconnect from signal", function() --[[ Line: 36 ]]
        -- upvalues: l__ConnectionUtil__7 (ref), l__Signal__6 (ref), l__expect__4 (ref)
        local v5 = l__ConnectionUtil__7.new();
        local v6 = l__Signal__6.new();
        local u7 = "";
        v5:trackConnection("Signal", v6:Connect(function(p8) --[[ Line: 43 ]]
            -- upvalues: u7 (ref)
            u7 = p8;
        end));
        v5:disconnect("Signal");
        v6:fire("Testing");
        l__expect__4(u7).toBe("");
    end);
    l__it__5("should disconnect from all", function() --[[ Line: 53 ]]
        -- upvalues: l__ConnectionUtil__7 (ref), l__Signal__6 (ref), l__expect__4 (ref)
        local v9 = l__ConnectionUtil__7.new();
        local v10 = l__Signal__6.new();
        local v11 = l__Signal__6.new();
        local v12 = l__Signal__6.new();
        local u13 = "";
        local u14 = "";
        local u15 = "";
        v9:trackConnection("Signal", v10:Connect(function(p16) --[[ Line: 65 ]]
            -- upvalues: u13 (ref)
            u13 = p16;
        end));
        v9:trackConnection("Signal1", v11:Connect(function(p17) --[[ Line: 71 ]]
            -- upvalues: u14 (ref)
            u14 = p17;
        end));
        v9:trackConnection("Signal2", v12:Connect(function(p18) --[[ Line: 77 ]]
            -- upvalues: u15 (ref)
            u15 = p18;
        end));
        v9:disconnectAll();
        v10:fire("TestingPrimary");
        v10:fire("TestingSecondary");
        v10:fire("TestingTertiary");
        l__expect__4(u13).toBe("");
        l__expect__4(u14).toBe("");
        l__expect__4(u15).toBe("");
    end);
    l__it__5("should call manual disconnect", function() --[[ Line: 92 ]]
        -- upvalues: l__ConnectionUtil__7 (ref), l__expect__4 (ref)
        local v19 = l__ConnectionUtil__7.new();
        local u20 = "";
        v19:trackBoundFunction("Manual", function() --[[ Line: 96 ]]
            -- upvalues: u20 (ref)
            u20 = "Disconnected";
        end);
        v19:disconnect("Manual");
        l__expect__4(u20).toBe("Disconnected");
    end);
end);