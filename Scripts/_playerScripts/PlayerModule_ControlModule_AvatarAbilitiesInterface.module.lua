-- Decompiled with Potassium's decompiler.

local l__CommonUtils__1 = script.Parent.Parent:WaitForChild("CommonUtils");
if require(l__CommonUtils__1:WaitForChild("FlagUtil")).getUserFlag("UserAllowAbilityControls") then
    local l__Players__2 = game:GetService("Players");
    local v1 = {};
    local u2 = nil;
    local u3 = nil;
    local u4 = Instance.new("BindableEvent");
    local u5 = nil;
    local u6 = false;
    local function u8(p7) --[[ Line: 16 ]]
        -- upvalues: u2 (ref), u3 (ref), u5 (ref), u4 (copy)
        u2 = nil;
        u3 = nil;
        if u5 then
            u5:Disconnect();
            u5 = nil;
        end;
        if p7 then
            u2 = p7:FindFirstChild("AbilityManagerActor");
            u3 = p7:FindFirstChildOfClass("Humanoid");
            while not u3 do
                p7.ChildAdded:wait();
                u3 = p7:FindFirstChildOfClass("Humanoid");
            end;
            u4:Fire();
            u5 = u3:GetPropertyChangedSignal("EvaluateStateMachine"):Connect(function() --[[ Line: 33 ]]
                -- upvalues: u4 (ref)
                u4:Fire();
            end);
        end;
    end;
    function v1.isEnabled() --[[ Line: 54 ]]
        -- upvalues: u6 (ref), l__Players__2 (copy), u8 (copy), u2 (ref), u3 (ref)
        if not u6 then
            u6 = true;
            local l__LocalPlayer__3 = l__Players__2.LocalPlayer;
            if l__LocalPlayer__3 then
                l__LocalPlayer__3.characterAdded:Connect(u8);
                if l__LocalPlayer__3.Character then
                    u8(l__LocalPlayer__3.Character);
                end;
            end;
        end;
        local v9;
        if u2 == nil then
            v9 = false;
        else
            v9 = u3;
            if v9 then
                v9 = not u3.EvaluateStateMachine;
            end;
        end;
        return v9;
    end;
    function v1.GetEnabledChangedSignal() --[[ Line: 59 ]]
        -- upvalues: u6 (ref), l__Players__2 (copy), u8 (copy), u4 (copy)
        if not u6 then
            u6 = true;
            local l__LocalPlayer__4 = l__Players__2.LocalPlayer;
            if l__LocalPlayer__4 then
                l__LocalPlayer__4.characterAdded:Connect(u8);
                if l__LocalPlayer__4.Character then
                    u8(l__LocalPlayer__4.Character);
                end;
            end;
        end;
        return u4.Event;
    end;
    return v1;
end;