-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__TweenService__2 = game:GetService("TweenService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local function u7(p4, p5, p6) --[[ Line: 38 ]]
    -- upvalues: l__TweenService__2 (copy)
    l__TweenService__2:Create(p4, TweenInfo.new(p6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Transparency = p5
    }):Play();
end;
local function u11(p8, p9) --[[ Line: 43 ]]
    -- upvalues: u7 (copy)
    for _, v10 in p8:GetDescendants() do
        if v10:IsA("BasePart") then
            if p9.Originals[v10] == nil then
                p9.Originals[v10] = v10.Transparency;
            end;
            u7(v10, 1, 0);
        end;
    end;
end;
local function u15(p12) --[[ Line: 52 ]]
    -- upvalues: u7 (copy)
    for v13, v14 in p12.Originals do
        if v13.Parent then
            u7(v13, v14, 0);
        end;
    end;
end;
local function u21(u16, p17) --[[ Line: 70 ]]
    -- upvalues: u2 (copy), u21 (copy), u15 (copy)
    local v18 = u2[u16];
    if v18 then
        if v18.ReleaseTask then
            v18.ReleaseTask = nil;
        end;
        v18.ReleaseTask = task.delay(p17 - os.clock(), function() --[[ Line: 80 ]]
            -- upvalues: u16 (copy), u21 (ref), u2 (ref), u15 (ref)
            local v19 = u16:GetAttribute("CooldownEnd");
            if typeof(v19) == "number" and os.clock() < v19 then
                u21(u16, v19);
            else
                local v20 = u2[u16];
                if v20 then
                    if not v20.Active then
                        return;
                    end;
                    v20.Active = false;
                    if v20.ReleaseTask then
                        v20.ReleaseTask = nil;
                    end;
                    u15(v20);
                end;
            end;
        end);
    end;
end;
local function u37(u22) --[[ Line: 111 ]]
    -- upvalues: u2 (copy), u11 (copy), u21 (copy), u15 (copy), u7 (copy)
    local v23 = u2[u22];
    if v23 then
        return v23;
    end;
    local u24 = {
        Active = false,
        Originals = {}
    };
    u2[u22] = u24;
    u24.AttributeConn = u22:GetAttributeChangedSignal("CooldownEnd"):Connect(function() --[[ Line: 121 ]]
        -- upvalues: u22 (copy), u2 (ref), u11 (ref), u21 (ref), u15 (ref)
        local v25 = u22:GetAttribute("CooldownEnd");
        local v26;
        if typeof(v25) == "number" and os.clock() < v25 then
            v26 = true;
        else
            v26 = false;
            v25 = nil;
        end;
        if v26 and v25 then
            local v27 = u22;
            local v28 = u2[v27];
            if v28 then
                u11(v27, v28);
                v28.Active = true;
                u21(v27, v25);
            end;
        else
            local v29 = u2[u22];
            if v29 then
                if not v29.Active then
                    return;
                end;
                v29.Active = false;
                if v29.ReleaseTask then
                    v29.ReleaseTask = nil;
                end;
                u15(v29);
            end;
        end;
    end);
    u24.DescendantConn = u22.DescendantAdded:Connect(function(p30) --[[ Line: 131 ]]
        -- upvalues: u24 (copy), u7 (ref)
        if u24.Active then
            if p30:IsA("BasePart") then
                local v31 = u24;
                if v31.Originals[p30] == nil then
                    v31.Originals[p30] = p30.Transparency;
                end;
                u7(p30, 1, 0);
            end;
        end;
    end);
    u24.AncestryConn = u22.AncestryChanged:Connect(function() --[[ Line: 138 ]]
        -- upvalues: u22 (copy), u2 (ref)
        if not u22:IsDescendantOf(game) then
            local v32 = u22;
            local v33 = u2[v32];
            if not v33 then
                return;
            end;
            if v33.AttributeConn then
                v33.AttributeConn:Disconnect();
            end;
            if v33.DescendantConn then
                v33.DescendantConn:Disconnect();
            end;
            if v33.AncestryConn then
                v33.AncestryConn:Disconnect();
            end;
            v33.ReleaseTask = nil;
            u2[v32] = nil;
        end;
    end);
    local v34 = u22:GetAttribute("CooldownEnd");
    local v35;
    if typeof(v34) == "number" and os.clock() < v34 then
        v35 = true;
    else
        v35 = false;
        v34 = nil;
    end;
    if v35 and v34 then
        local v36 = u2[u22];
        if not v36 then
            return u24;
        end;
        u11(u22, v36);
        v36.Active = true;
        u21(u22, v34);
    end;
    return u24;
end;
local function u40(u38) --[[ Line: 154 ]]
    -- upvalues: u37 (copy), u3 (copy)
    if u38:IsA("Tool") then
        if u38:GetAttribute("Flashbang") then
            u37(u38);
            if not u3[u38] then
                u3[u38] = u38.Activated:Connect(function() --[[ Line: 161 ]]
                    -- upvalues: u38 (copy)
                    local v39 = u38:GetAttribute("CooldownEnd");
                    if typeof(v39) == "number" and os.clock() < v39 then
                    else
                        u38:SetAttribute("CooldownEnd", os.clock() + 15);
                    end;
                end);
            end;
        end;
    end;
end;
local function u44(p41) --[[ Line: 170 ]]
    -- upvalues: u40 (copy)
    for _, v42 in p41:GetChildren() do
        if v42:IsA("Tool") then
            u40(v42);
        end;
    end;
    p41.ChildAdded:Connect(function(p43) --[[ Line: 176 ]]
        -- upvalues: u40 (ref)
        if p43:IsA("Tool") then
            u40(p43);
        end;
    end);
end;
function v1.Init(_) --[[ Line: 183 ]] end;
function v1.Start(_) --[[ Line: 185 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u44 (copy)
    u44((l__LocalPlayer__3:WaitForChild("Backpack")));
    if l__LocalPlayer__3.Character then
        u44(l__LocalPlayer__3.Character);
    end;
    l__LocalPlayer__3.CharacterAdded:Connect(function(p45) --[[ Line: 192 ]]
        -- upvalues: u44 (ref)
        u44(p45);
    end);
end;
return v1;