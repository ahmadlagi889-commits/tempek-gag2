-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__ContentProvider__2 = game:GetService("ContentProvider");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local u2 = {};
local function u5(u3) --[[ Line: 22 ]]
    -- upvalues: u2 (copy), l__ContentProvider__2 (copy)
    if u2[u3] then
    else
        u2[u3] = true;
        u3.AncestryChanged:Connect(function() --[[ Line: 26 ]]
            -- upvalues: u3 (copy), u2 (ref)
            if not u3:IsDescendantOf(game) then
                u2[u3] = nil;
            end;
        end);
        task.spawn(function() --[[ Line: 34 ]]
            -- upvalues: u3 (copy), l__ContentProvider__2 (ref)
            task.wait();
            local u4 = u3:GetDescendants();
            if #u4 == 0 then
            else
                local _, _ = pcall(function() --[[ Line: 45 ]]
                    -- upvalues: l__ContentProvider__2 (ref), u4 (copy)
                    l__ContentProvider__2:PreloadAsync(u4);
                end);
            end;
        end);
    end;
end;
local function u7(p6) --[[ Line: 53 ]]
    -- upvalues: u5 (copy)
    if p6:IsA("Tool") then
        u5(p6);
    end;
end;
function v1.Init(_) --[[ Line: 66 ]] end;
function v1.Start(_) --[[ Line: 68 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u5 (copy), u7 (copy)
    local l__Backpack__4 = l__LocalPlayer__3:WaitForChild("Backpack");
    for _, v8 in l__Backpack__4:GetChildren() do
        if v8:IsA("Tool") then
            u5(v8);
        end;
    end;
    l__Backpack__4.ChildAdded:Connect(u7);
    local function v11(p9) --[[ Line: 72 ]]
        -- upvalues: u5 (ref), u7 (ref)
        for _, v10 in p9:GetChildren() do
            if v10:IsA("Tool") then
                u5(v10);
            end;
        end;
        p9.ChildAdded:Connect(u7);
    end;
    if l__LocalPlayer__3.Character then
        local l__Character__5 = l__LocalPlayer__3.Character;
        for _, v12 in l__Character__5:GetChildren() do
            if v12:IsA("Tool") then
                u5(v12);
            end;
        end;
        l__Character__5.ChildAdded:Connect(u7);
    end;
    l__LocalPlayer__3.CharacterAdded:Connect(v11);
end;
return v1;