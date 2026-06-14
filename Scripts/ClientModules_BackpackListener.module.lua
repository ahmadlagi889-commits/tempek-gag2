-- Decompiled with Potassium's decompiler.

local u1 = {};
game:GetService("Players").PlayerRemoving:Connect(function(p2) --[[ Line: 110 ]]
    -- upvalues: u1 (copy)
    local v3 = u1[p2];
    if v3 then
        for _, v4 in v3 do
            if v4.Connection then
                v4.Connection:Disconnect();
                v4.Connection = nil;
            end;
            if v4.BackpackChangedConn then
                v4.BackpackChangedConn:Disconnect();
                v4.BackpackChangedConn = nil;
            end;
        end;
        u1[p2] = nil;
    end;
end);
return {
    bind = function(u5, u6) --[[ Name: bind, Line 78 ]]
        -- upvalues: u1 (copy)
        if u5 and u6 then
            local v7 = u1[u5];
            if not v7 then
                v7 = {};
                u1[u5] = v7;
            end;
            if v7[u6] then
            else
                local u8 = {
                    Connection = nil,
                    BackpackChangedConn = nil
                };
                v7[u6] = u8;
                if u8.Connection then
                    u8.Connection:Disconnect();
                    u8.Connection = nil;
                end;
                local v9 = u5:FindFirstChildOfClass("Backpack");
                if v9 then
                    u8.Connection = v9.ChildAdded:Connect(u6);
                end;
                u8.BackpackChangedConn = u5.ChildAdded:Connect(function(p10) --[[ Line: 69 ]]
                    -- upvalues: u5 (copy), u6 (copy), u8 (copy)
                    if p10:IsA("Backpack") then
                        local v11 = u5;
                        local v12 = u6;
                        local v13 = u8;
                        if v13.Connection then
                            v13.Connection:Disconnect();
                            v13.Connection = nil;
                        end;
                        local v14 = v11:FindFirstChildOfClass("Backpack");
                        if not v14 then
                            return;
                        end;
                        v13.Connection = v14.ChildAdded:Connect(v12);
                    end;
                end);
            end;
        end;
    end,
    unbind = function(p15, p16) --[[ Name: unbind, Line 98 ]]
        -- upvalues: u1 (copy)
        local v17 = u1[p15];
        if v17 then
            local v18 = v17[p16];
            if v18 then
                if v18.Connection then
                    v18.Connection:Disconnect();
                    v18.Connection = nil;
                end;
                if v18.BackpackChangedConn then
                    v18.BackpackChangedConn:Disconnect();
                    v18.BackpackChangedConn = nil;
                end;
                v17[p16] = nil;
                if next(v17) == nil then
                    u1[p15] = nil;
                end;
            end;
        end;
    end
};