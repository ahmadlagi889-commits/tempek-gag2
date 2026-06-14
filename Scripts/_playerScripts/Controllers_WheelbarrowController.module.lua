-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__NotificationController__2 = require(l__LocalPlayer__1.PlayerScripts.Controllers.NotificationController);
local u2 = {};
local function u10(u3) --[[ Line: 51 ]]
    -- upvalues: u2 (copy), l__LocalPlayer__1 (copy), l__NotificationController__2 (copy)
    local v4;
    if u3:IsA("Tool") then
        v4 = u3:GetAttribute("Wheelbarrow") ~= nil and true or u3.Name == "Wheelbarrow";
    else
        v4 = false;
    end;
    if v4 then
        if u2[u3] then
        else
            u2[u3] = true;
            u3.Equipped:Connect(function() --[[ Line: 44 ]]
                -- upvalues: u3 (copy), l__LocalPlayer__1 (ref), l__NotificationController__2 (ref)
                local v5 = u3;
                local v6 = l__LocalPlayer__1:GetAttribute("Friends");
                local v7;
                if type(v6) == "number" then
                    v7 = v6 > 0;
                else
                    v7 = false;
                end;
                if v7 then
                else
                    local l__Parent__3 = v5.Parent;
                    if l__Parent__3 then
                        if not l__Parent__3:IsA("Model") then
                            return;
                        end;
                        local v8 = l__Parent__3:FindFirstChildOfClass("Humanoid");
                        if v8 then
                            v8:UnequipTools();
                        end;
                        l__NotificationController__2:CreateNotification("Friend in Server Required!");
                    end;
                end;
            end);
            u3.AncestryChanged:Connect(function(_, p9) --[[ Line: 57 ]]
                -- upvalues: u2 (ref), u3 (copy)
                if p9 == nil then
                    u2[u3] = nil;
                end;
            end);
        end;
    end;
end;
function v1.Init(_) --[[ Line: 71 ]] end;
function v1.Start(_) --[[ Line: 74 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u10 (copy)
    local l__Backpack__4 = l__LocalPlayer__1:WaitForChild("Backpack");
    l__Backpack__4.ChildAdded:Connect(u10);
    for _, v11 in l__Backpack__4:GetChildren() do
        u10(v11);
    end;
    local function v14(p12) --[[ Line: 80 ]]
        -- upvalues: u10 (ref)
        p12.ChildAdded:Connect(u10);
        for _, v13 in p12:GetChildren() do
            u10(v13);
        end;
    end;
    if l__LocalPlayer__1.Character then
        local l__Character__5 = l__LocalPlayer__1.Character;
        l__Character__5.ChildAdded:Connect(u10);
        for _, v15 in l__Character__5:GetChildren() do
            u10(v15);
        end;
    end;
    l__LocalPlayer__1.CharacterAdded:Connect(v14);
end;
return v1;