-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3, _) --[[ Line: 1 ]]
    local v4 = Instance.new("Attachment");
    v4.Position = Vector3.new(0, p2, 0);
    v4.Parent = p1;
    local v5 = Instance.new("Attachment");
    v5.Position = Vector3.new(0, -p2, 0);
    v5.Parent = p1;
    local v6 = Instance.new("Trail");
    v6.FaceCamera = true;
    v6.LightInfluence = 0;
    v6.LightEmission = 1;
    v6.Lifetime = 0.55;
    v6.Attachment0 = v4;
    v6.Attachment1 = v5;
    v6.Brightness = 2;
    v6.Color = ColorSequence.new(p3 or Color3.fromRGB(255, 220, 24));
    v6.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0) });
    v6.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.1, 0),
        NumberSequenceKeypoint.new(0.9, 0),
        NumberSequenceKeypoint.new(1, 1)
    });
    v6.Parent = p1;
    return v6;
end;