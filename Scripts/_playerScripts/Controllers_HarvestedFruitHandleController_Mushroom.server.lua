-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__Parent__2 = script.Parent;
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local u1 = false;
l__Parent__2.CanCollide = false;
l__Parent__2.Touched:Connect(function(p2) --[[ Line: 9 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u1 (ref)
    local l__Character__4 = l__LocalPlayer__3.Character;
    if l__Character__4 then
        if p2:IsDescendantOf(l__Character__4) then
            local v3 = l__Character__4:FindFirstChild("HumanoidRootPart");
            if v3 then
                if v3.AssemblyLinearVelocity.Y < 0 then
                elseif u1 then
                else
                    u1 = true;
                    v3.AssemblyLinearVelocity = Vector3.new(0, 80, 0);
                    task.wait(0.25);
                    u1 = false;
                end;
            end;
        end;
    end;
end);