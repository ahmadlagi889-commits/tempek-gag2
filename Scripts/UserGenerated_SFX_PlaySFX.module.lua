-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) --[[ Name: PlaySFX, Line 20 ]]
    local u4 = Instance.new("Attachment");
    u4.CFrame = p1.CFrame:ToObjectSpace(p2);
    p3.Parent = u4;
    u4.Parent = p1;
    p3.Ended:Connect(function() --[[ Line: 25 ]]
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
    p3:Play();
end;