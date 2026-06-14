-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 1,
        BaseWeight = 500,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        local v4 = Random.new(p2):NextInteger(2, 3) * p3;
        local v5 = Instance.new("Part");
        v5.Anchored = true;
        v5.CanCollide = false;
        v5.Size = Vector3.new(v4, v4, v4);
        v5.Name = "1";
        v5.CFrame = p1.PrimaryPart.CFrame * CFrame.new(0, p1.PrimaryPart.Size.Y / 2 + v5.Size.Y / 2, 0);
        v5.Parent = p1;
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u6) --[[ Name: BeginFruitGrowth, Line 23 ]]
        local l__PrimaryPart__1 = u6.PrimaryPart;
        local u7 = {};
        for _, v8 in u6:GetDescendants() do
            local v9 = tonumber(v8.Name);
            if v8:IsA("BasePart") and v9 then
                local v10 = {
                    v8,
                    v8.Size,
                    l__PrimaryPart__1.CFrame:ToObjectSpace(v8.CFrame),
                    v9
                };
                table.insert(u7, v10);
                v8.CanCollide = false;
                v8.Transparency = 1;
            end;
        end;
        local function v17() --[[ Line: 41 ]]
            -- upvalues: u6 (copy), u7 (copy), l__PrimaryPart__1 (copy)
            local v11 = u6:GetAttribute("Age") or 0;
            for _, v12 in u7 do
                local v13 = v12[1];
                local v14 = v12[2];
                local v15 = v12[3];
                local v16 = math.min(v11 - v12[4], 1);
                if v16 > 0 then
                    v13.Size = Vector3.new(v14.X, v14.Y * v16, v14.Z);
                    v13.CFrame = l__PrimaryPart__1.CFrame * v15 * CFrame.new(0, (v13.Size.Y - v14.Y) / 2, 0);
                    v13.Transparency = v13:GetAttribute("OG_Transparency") or 0;
                    v13.CanCollide = true;
                    if v13.Name == "4" then
                        v13.CFrame = l__PrimaryPart__1.CFrame * v15;
                    end;
                else
                    v13.Transparency = 1;
                    v13.CanCollide = false;
                end;
            end;
        end;
        u6:GetAttributeChangedSignal("Age"):Connect(v17);
        v17();
    end,
    Extras = {}
};