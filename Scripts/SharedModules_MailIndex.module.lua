-- Decompiled with Potassium's decompiler.

local l__MemoryStoreService__1 = game:GetService("MemoryStoreService");
local l__RunService__2 = game:GetService("RunService");
local u1 = nil;
local v2, v3 = pcall(function() --[[ Line: 21 ]]
    -- upvalues: l__MemoryStoreService__1 (copy)
    return l__MemoryStoreService__1:GetHashMap("MailIndex_v1");
end);
if v2 then
    u1 = v3;
else
    warn((`[MailIndex] GetHashMap failed; mail index disabled for this server: {v3}`));
end;
local function u12(u4, u5) --[[ Line: 40 ]]
    -- upvalues: u1 (ref), l__RunService__2 (copy)
    if not u1 then
        return false;
    end;
    if l__RunService__2:IsStudio() then
        return true;
    end;
    local u6 = os.time();
    local v10, v11 = pcall(function() --[[ Line: 49 ]]
        -- upvalues: u1 (ref), u4 (copy), u5 (copy), u6 (copy)
        u1:UpdateAsync(tostring(u4), function(p7) --[[ Line: 50 ]]
            -- upvalues: u5 (ref), u6 (ref)
            local v8 = p7 or {
                C = 0,
                T = 0,
                V = 0
            };
            local v9 = (v8.C or 0) + u5;
            v8.C = v9 < 0 and 0 or v9;
            if u5 > 0 then
                v8.T = u6;
            end;
            v8.V = (v8.V or 0) + 1;
            return v8;
        end, 1209600);
    end);
    if v10 then
        return true;
    end;
    warn((`[MailIndex] UpdateAsync failed for user {u4} (delta {u5}): {v11}`));
    return false;
end;
return table.freeze({
    Increment = function(p13, p14) --[[ Name: Increment, Line 70 ]]
        -- upvalues: u12 (copy)
        if typeof(p13) == "number" and p13 > 0 then
            if typeof(p14) == "number" and p14 > 0 then
                return u12(p13, (math.floor(p14)));
            else
                return false;
            end;
        else
            return false;
        end;
    end,
    Decrement = function(p15, p16) --[[ Name: Decrement, Line 76 ]]
        -- upvalues: u12 (copy)
        if typeof(p15) == "number" and p15 > 0 then
            if typeof(p16) == "number" and p16 > 0 then
                return u12(p15, -math.floor(p16));
            else
                return false;
            end;
        else
            return false;
        end;
    end,
    Get = function(u17) --[[ Name: Get, Line 82 ]]
        -- upvalues: u1 (ref), l__RunService__2 (copy)
        if not u1 then
            return nil;
        end;
        if typeof(u17) ~= "number" or u17 <= 0 then
            return nil;
        end;
        if l__RunService__2:IsStudio() then
            return nil;
        end;
        local u18 = nil;
        local v19, v20 = pcall(function() --[[ Line: 88 ]]
            -- upvalues: u18 (ref), u1 (ref), u17 (copy)
            u18 = u1:GetAsync((tostring(u17)));
        end);
        if v19 then
            return u18;
        end;
        warn((`[MailIndex] GetAsync failed for user {u17}: {v20}`));
        return nil;
    end
});