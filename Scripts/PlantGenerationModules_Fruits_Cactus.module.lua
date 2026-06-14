-- Decompiled with Potassium's decompiler.

local l__Stud_Part__1 = script.Stud_Part;
return {
    GrowData = {
        GrowRate = 0.0119,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(u1, p2, u3) --[[ Name: InitFruit, Line 11 ]]
        -- upvalues: l__Stud_Part__1 (copy)
        local u4 = Random.new(p2);
        local l__PrimaryPart__2 = u1.PrimaryPart;
        local u5 = l__Stud_Part__1:Clone();
        u5.Anchored = true;
        u5.Parent = u1;
        local v6 = Color3.new(0, 0.666667, 0);
        if u4:NextInteger(1, 100) == 1 then
            v6 = Color3.new(0.458824, 0, 0);
        end;
        u5.Color = v6;
        u5.CFrame = l__PrimaryPart__2.CFrame;
        local v7 = 2 * u3;
        local l__Size__3 = u5.Size;
        local u8 = {};
        u5.Size = Vector3.new(v7, v7, v7);
        u5.CFrame = u5.CFrame * CFrame.new(0, (u5.Size.Y - l__Size__3.Y) / 2, 0);
        u5.Name = "1";
        local l__Spike__4 = script.Spike;
        local function v21(p9, p10) --[[ Line: 45 ]]
            -- upvalues: u4 (copy), u3 (copy), u5 (copy), l__Spike__4 (copy), u1 (copy), u8 (copy)
            for _ = 1, u4:NextInteger(1, 3) ~= 1 and 1 or u4:NextInteger(2, 3) do
                local v11 = u4:NextInteger(20, 40) * 0.01 * u3;
                if u4:NextInteger(1, 3) == 1 then
                    v11 = v11 * 1.5;
                    if u4:NextInteger(1, 3) == 1 then
                        v11 = v11 * 1.25;
                    end;
                end;
                local v12 = u5.Size.Y / 2;
                local v13;
                if p9 == "X" then
                    v13 = u5.Size.Z / 2;
                else
                    v13 = u5.Size.X / 2;
                end;
                local v14 = v12 - v11;
                local v15 = v13 - v11;
                local v16 = (u4:NextNumber() * 2 - 1) * v14;
                local v17 = (u4:NextNumber() * 2 - 1) * v15;
                local v18 = l__Spike__4:Clone();
                local v19, v20;
                if p9 == "X" then
                    v19 = u5.CFrame * CFrame.new(p10 * u5.Size.X / 2, 0, 0) * CFrame.new(0, v16, v17);
                    v20 = CFrame.Angles(0, 0, (math.rad(-90 * p10)));
                else
                    v19 = u5.CFrame * CFrame.new(0, 0, p10 * u5.Size.Z / 2) * CFrame.new(v17, v16, 0);
                    v20 = CFrame.Angles(0, math.rad(-90 * p10), (math.rad(90 * p10)));
                    if p10 == 1 then
                        v20 = v20 * CFrame.Angles(3.141592653589793, 0, 0);
                    end;
                end;
                v18.Size = Vector3.new(v11, v11 * 0.8, v11);
                v18.CFrame = v19 * v20 * CFrame.new(0, v18.Size.Y / 2, 0);
                v18.Parent = u1;
                table.insert(u8, v18);
            end;
        end;
        v21("X", 1);
        v21("X", -1);
        v21("Z", 1);
        v21("Z", -1);
        local v22 = l__Stud_Part__1:Clone();
        v22.Parent = u1;
        v22.Color = Color3.fromHSV(u4:NextInteger(100, 160) * 0.001, 1, 1);
        v22.Size = Vector3.new(1 * u3, v22.Size.Y * 0.05, 1 * u3);
        v22.CFrame = u5.CFrame * CFrame.new(0, u5.Size.Y / 2 + v22.Size.Y / 2, 0);
        v22.Name = "2";
        local v23 = {
            {
                offset = CFrame.new(v22.Size.X / 2, 0, 0),
                preRot = CFrame.Angles(0, 1.5707963267948966, 0),
                tilt = CFrame.Angles(0.7853981633974483, 0, 0)
            },
            {
                offset = CFrame.new(-v22.Size.X / 2, 0, 0),
                preRot = CFrame.Angles(0, 1.5707963267948966, 0),
                tilt = CFrame.Angles(-0.7853981633974483, 0, 0)
            },
            {
                offset = CFrame.new(0, 0, -v22.Size.Z / 2),
                preRot = CFrame.new(),
                tilt = CFrame.Angles(-0.7853981633974483, 0, 0)
            },
            {
                offset = CFrame.new(0, 0, v22.Size.Z / 2),
                preRot = CFrame.new(),
                tilt = CFrame.Angles(0.7853981633974483, 0, 0)
            }
        };
        local v24 = Vector3.new(v22.Size.X, v22.Size.X, v22.Size.Y * 2);
        local v25 = {};
        for _, v26 in v23 do
            local v27 = v22:Clone();
            v27.Color = Color3.new(1, 0, 0);
            v27.Size = v24;
            v27.CFrame = v22.CFrame * v26.offset;
            v27.Parent = u1;
            v27.CFrame = v27.CFrame * v26.preRot;
            v27.CFrame = v27.CFrame * v26.tilt;
            v27.CFrame = v27.CFrame * CFrame.new(0, v24.Y / 2, 0);
            v27.Name = "3";
            table.insert(v25, v27);
        end;
        for _, v28 in u8 do
            v28.Color = Color3.new(0.27451, 0.27451, 0.27451);
            v28.Name = "4";
        end;
        for _, v29 in u1:GetChildren() do
            if v29:IsA("BasePart") then
                v29.CanCollide = false;
                v29.CanQuery = true;
            end;
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u30) --[[ Name: BeginFruitGrowth, Line 166 ]]
        local l__PrimaryPart__5 = u30.PrimaryPart;
        local u31 = {};
        for _, v32 in u30:GetDescendants() do
            local v33 = tonumber(v32.Name);
            if (v32:IsA("BasePart") or v32:IsA("UnionOperation")) and v33 then
                local v34 = not v32:GetAttribute("DontShow");
                local v35 = {
                    part = v32,
                    maxSize = v32.Size,
                    centerOffset = l__PrimaryPart__5.CFrame:ToObjectSpace(v32.CFrame),
                    partAge = v33
                };
                table.insert(u31, v35);
                v32.CanCollide = false;
                if v34 then
                    v32.Transparency = 1;
                end;
            end;
        end;
        local function v41() --[[ Line: 189 ]]
            -- upvalues: u30 (copy), u31 (copy), l__PrimaryPart__5 (copy)
            local v36 = u30:GetAttribute("Age") or 0;
            local v37 = u30:GetAttribute("MaxAge") or 1;
            local v38 = v36 / v37;
            for _, v39 in u31 do
                if not v39.part:GetAttribute("DontShow") then
                    local v40 = math.clamp((v38 - (v39.partAge - 1) / v37) * v37, 0, 1);
                    if v40 > 0 then
                        v39.part.Size = v39.maxSize * v40;
                        v39.part.CFrame = l__PrimaryPart__5.CFrame * v39.centerOffset;
                        v39.part.Transparency = v39.part:GetAttribute("OG_Transparency") or 0;
                        v39.part.CanCollide = true;
                    else
                        v39.part.Transparency = 1;
                        v39.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u30:GetAttributeChangedSignal("Age"):Connect(v41);
        v41();
    end,
    OnFullyGrown = function(p42) --[[ Name: OnFullyGrown, Line 218 ]]
        local v43 = p42:GetAttribute("CorePartName");
        if v43 then
            local v44 = p42:FindFirstChild(v43);
            local v45 = v44 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v45 then
                local v46 = v45:Clone();
                v46.Name = "ProximityPrompt";
                v46.Parent = v44;
            end;
        end;
        p42:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Cactus",
        Harvestable = true
    }
};