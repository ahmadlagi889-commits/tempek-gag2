-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Bindable__2 = require(l__ReplicatedStorage__1.UserGenerated.Concurrency.Bindable);
local l__DeepFreeze__3 = require(game.ReplicatedStorage.UserGenerated.Collections.DeepFreeze);
local l__Lock__4 = require(game.ReplicatedStorage.UserGenerated.Concurrency.Lock);
local l__Asserts__5 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local v10 = {
    RemoveUsedAt = function(_, _) --[[ Name: RemoveUsedAt, Line 89 ]] end,
    InsertUsedAt = function(_, _) --[[ Name: InsertUsedAt, Line 93 ]] end,
    SetUsedAt = function(p1, p2, p3) --[[ Name: SetUsedAt, Line 97 ]]
        p1:RemoveUsedAt(p2);
        p2.UsedAt = p3;
        p1:InsertUsedAt(p2);
    end,
    Get = function(p4, p5) --[[ Name: Get, Line 109 ]]
        local v6 = p4.AssertKey(p5);
        local v7 = p4.Cache[v6];
        if not v7 then
            return nil;
        end;
        local v8 = os.clock();
        local l__RetrievedAt__6 = v7.RetrievedAt;
        local v9;
        if l__RetrievedAt__6 then
            v9 = v8 - l__RetrievedAt__6;
        else
            v9 = nil;
        end;
        if not v9 or p4.MaxAge <= v9 and not p4.ReturnStale then
            return nil;
        end;
        p4:SetUsedAt(v7, v8);
        return v7.Value;
    end
};
function AsyncCallback(p11, p12, p13, p14)
    -- upvalues: l__DeepFreeze__3 (copy)
    local l__RetrievedAt__7 = p12.RetrievedAt;
    local v15;
    if l__RetrievedAt__7 then
        v15 = p14 - l__RetrievedAt__7;
    else
        v15 = nil;
    end;
    if v15 and v15 < p11.MaxAge then
        return p12.Value;
    else
        local l__AttemptedAt__8 = p12.AttemptedAt;
        if (not l__AttemptedAt__8 and (1 / 0) or p14 - l__AttemptedAt__8) < p11.FailureRetryDelay then
            if p11.ReturnStale then
                return p12.Value;
            else
                return nil;
            end;
        else
            p12.AttemptedAt = p14;
            local v16, v17 = pcall(p11.Callback, p13);
            local v18 = os.clock();
            p12.AttemptedAt = v18;
            p11:SetUsedAt(p12, v18);
            if v16 then
                if p11.Freeze then
                    v17 = l__DeepFreeze__3(v17);
                end;
                p12.Value = v17;
                p12.RetrievedAt = v18;
                p11.Updated:Fire(p13);
                return v17;
            elseif p11.ReturnStale then
                return p12.Value;
            else
                return nil;
            end;
        end;
    end;
end;
function v10.GetAsync(p19, p20) --[[ Line: 156 ]]
    -- upvalues: l__Lock__4 (copy)
    local v21 = os.clock();
    local v22 = p19.AssertKey(p20);
    local v23 = p19.Cache[v22];
    if v23 then
        p19:SetUsedAt(v23, v21);
    else
        v23 = {
            Lock = l__Lock__4.new(),
            UsedAt = v21
        };
        p19.Cache[v22] = v23;
        p19:InsertUsedAt(v23);
    end;
    return v23.Lock:Call(AsyncCallback, p19, v23, p20, v21);
end;
function v10.Delete(p24, p25) --[[ Line: 174 ]]
    local v26 = p24.AssertKey(p25);
    if p24.Cache[v26] then
        p24.Cache[v26] = nil;
        p24.Deleted:Fire(p25);
    end;
end;
local u27 = table.freeze({
    __index = table.freeze(v10)
});
local u28 = l__Asserts__5.Table({
    Callback = l__Asserts__5.Function,
    AssertKey = l__Asserts__5.Function,
    MaxAge = l__Asserts__5.Optional(l__Asserts__5.NonNegative),
    FailureRetryDelay = l__Asserts__5.Optional(l__Asserts__5.NonNegative),
    ReturnStale = l__Asserts__5.Optional(l__Asserts__5.Boolean),
    Freeze = l__Asserts__5.Optional(l__Asserts__5.Boolean)
});
return table.freeze({
    new = function(p29) --[[ Name: new, Line 210 ]]
        -- upvalues: u28 (copy), l__Bindable__2 (copy), u27 (copy)
        u28(p29);
        local v30 = {
            Updated = l__Bindable__2.new(),
            Deleted = l__Bindable__2.new(),
            Callback = p29.Callback,
            AssertKey = p29.AssertKey,
            MaxAge = p29.MaxAge or (1 / 0),
            FailureRetryDelay = p29.FailureRetryDelay or 300,
            ReturnStale = p29.ReturnStale == nil and true or p29.ReturnStale,
            Freeze = p29.Freeze == nil and true or p29.Freeze,
            Cache = {}
        };
        local v31 = setmetatable(v30, u27);
        table.freeze(v31);
        return v31;
    end
});