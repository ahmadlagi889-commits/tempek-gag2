-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__SfxController__1 = require(script.Parent.SfxController);
local l__CollectionService__2 = game:GetService("CollectionService");
local u2 = {};
local function u4(p3) --[[ Line: 9 ]]
    -- upvalues: u2 (copy), l__SfxController__1 (copy)
    if u2[p3] then
    elseif p3:IsA("GuiButton") then
        u2[p3] = true;
        p3.Activated:Connect(function() --[[ Line: 19 ]]
            -- upvalues: l__SfxController__1 (ref)
            l__SfxController__1:PlaySFX("Click");
        end);
    end;
end;
function v1.Init(_) --[[ Line: 24 ]] end;
function v1.Start(_) --[[ Line: 27 ]]
    -- upvalues: l__CollectionService__2 (copy), u2 (copy), l__SfxController__1 (copy), u4 (copy)
    for _, v5 in l__CollectionService__2:GetTagged("ClickSFX") do
        if not u2[v5] then
            if v5:IsA("GuiButton") then
                u2[v5] = true;
                v5.Activated:Connect(function() --[[ Line: 19 ]]
                    -- upvalues: l__SfxController__1 (ref)
                    l__SfxController__1:PlaySFX("Click");
                end);
            end;
        end;
    end;
    l__CollectionService__2:GetInstanceAddedSignal("ClickSFX"):Connect(u4);
end;
return v1;