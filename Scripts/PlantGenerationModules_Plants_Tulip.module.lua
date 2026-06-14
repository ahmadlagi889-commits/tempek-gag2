-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25,
        BaseWeight = 0.5
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 8 ]]
        local u4 = Random.new(p2);
        local l__Base__1 = u1.Base;
        local _ = script.Stud_Part;
        local u5 = p3 or 1;
        local u6 = nil;
        local u7 = Vector3.new(0.18, 0.6, 0.18) * u5;
        local u8 = {
            Color3.fromRGB(203, 28, 28),
            Color3.fromRGB(244, 243, 239),
            Color3.fromRGB(255, 204, 51),
            Color3.fromRGB(230, 89, 23),
            Color3.fromRGB(232, 98, 123),
            Color3.fromRGB(182, 38, 208)
        };
        local function v31(p9, p10, _) --[[ Line: 29 ]]
            -- upvalues: u8 (copy), u4 (copy), u7 (copy), u6 (ref), l__Base__1 (copy), u1 (copy), u5 (ref)
            local v11 = u8[u4:NextInteger(1, #u8)];
            for v12 = 1, p10 do
                local v13 = script.Stud_Part:Clone();
                local l__X__2 = u7.X;
                local v14 = u7.Y + u4:NextNumber(-0.15, 0.15);
                local l__Angles__3 = CFrame.Angles;
                local v15 = u4:NextNumber(-15, 15);
                local v16 = math.rad(v15);
                local v17 = u4:NextNumber(-15, 15);
                local v18 = math.rad(v17);
                local v19 = u4:NextNumber(-15, 15);
                local v20 = l__Angles__3(v16, v18, (math.rad(v19)));
                local l__new__4 = CFrame.new;
                local l__Position__5 = p9.Position;
                local v21 = u4:NextNumber(-15, 15);
                local v22 = u4:NextNumber(-15, 15);
                l__new__4(l__Position__5 + Vector3.new(v21, v22, u4:NextNumber(-15, 15)));
                v13.Color = Color3.fromRGB(37, 121, 50);
                v13.Size = Vector3.new(l__X__2, v14, l__X__2);
                if u6 and u6 ~= l__Base__1 then
                    p9 = u6:GetPivot();
                    v13.CFrame = p9 * CFrame.new(0, u6.Size.Y / 2.05, 0) * v20 * CFrame.new(0, v14 / 2.05, 0);
                else
                    v13.CFrame = p9 * v20 * CFrame.new(0, v14 / 2.05, 0);
                end;
                v13.Name = v12;
                v13.Parent = u1;
                if v12 == p10 then
                    local v23 = script.Top:Clone();
                    v23:ScaleTo(0.6 * u5);
                    local v24 = v13:GetPivot() * CFrame.new(0, v13.Size.Y / 2, 0);
                    local l__Angles__6 = CFrame.Angles;
                    local v25 = u4:NextInteger(-15, 15);
                    local v26 = math.rad(v25);
                    local v27 = u4:NextInteger(-15, 15);
                    local v28 = math.rad(v27);
                    local v29 = u4:NextInteger(-15, 15);
                    v23:PivotTo(v24 * l__Angles__6(v26, v28, (math.rad(v29))));
                    for _, v30 in v23:GetChildren() do
                        v30.Color = v11;
                        v30.Name = tonumber(v30.Name) + v12;
                        v30.Parent = u1;
                    end;
                    v23:Destroy();
                end;
                u6 = v13;
            end;
            u6 = nil;
        end;
        local v32 = math.clamp(1000 - u5 ^ 5, 10, 100000);
        local v33 = u5;
        local v34 = 1;
        while u4:NextInteger(1, v32) == 1 and v34 < 40 do
            v34 = v34 + 1;
        end;
        for v35 = 1, v34 do
            local v36 = u4:NextInteger(2, 3);
            while u4:NextInteger(1, 7) == 1 and v36 < 65 do
                v36 = v36 + 1;
            end;
            if v34 > 1 then
                local v37 = l__Base__1:GetPivot();
                v31(v37 * CFrame.Angles(0, (v35 - 1) / v34 * 3.141592653589793 * 2, 0) * CFrame.Angles(-0.3839724354387525, 0, 0), v36, v37);
            else
                v31(l__Base__1:GetPivot(), v36, l__Base__1:GetPivot());
            end;
        end;
        local v38 = 1;
        while u4:NextInteger(1, 5) == 1 and v38 < 65 do
            v38 = v38 + 1;
        end;
        for _ = 1, v38 do
            local v39 = u1.Wedge:Clone();
            v39:ScaleTo(v33);
            local v40 = u1:GetPivot();
            local l__Angles__7 = CFrame.Angles;
            local v41 = u4:NextInteger(-20, 20);
            local v42 = math.rad(v41);
            local v43 = u4:NextInteger(0, 360);
            local v44 = math.rad(v43);
            local v45 = u4:NextInteger(-20, 20);
            v39:PivotTo(v40 * l__Angles__7(v42, v44, (math.rad(v45))));
            v39["1"].Parent = u1;
            v39:Destroy();
        end;
        u1.Wedge:Destroy();
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u46) --[[ Name: BeginPlantGrowth, Line 121 ]]
        local l__PrimaryPart__8 = u46.PrimaryPart;
        local u47 = {};
        for _, v48 in u46:GetDescendants() do
            local v49 = tonumber(v48.Name);
            if v48:IsA("BasePart") and v49 then
                local v50 = {
                    v48,
                    v48.Size,
                    l__PrimaryPart__8.CFrame:ToObjectSpace(v48.CFrame),
                    v49
                };
                table.insert(u47, v50);
                v48.CanCollide = false;
                v48.Transparency = 1;
            end;
        end;
        local function v60() --[[ Line: 139 ]]
            -- upvalues: u46 (copy), u47 (copy), l__PrimaryPart__8 (copy)
            local v51 = u46:GetAttribute("Age") or 0;
            local v52 = u46:GetAttribute("MaxAge") or 1;
            local v53 = v51 / v52;
            for _, v54 in u47 do
                local v55 = v54[1];
                local v56 = v54[2];
                local v57 = v54[3];
                local v58 = math.min((v53 - v54[4] / v52) * v52, 1);
                if v58 > 0 then
                    v55.Size = Vector3.new(v56.X, v56.Y * v58, v56.Z);
                    v55.CFrame = l__PrimaryPart__8.CFrame * v57 * CFrame.new(0, (v55.Size.Y - v56.Y) / 2, 0);
                    v55.Transparency = v55:GetAttribute("OG_Transparency") or 0;
                    v55.CanCollide = true;
                    if v55:FindFirstChild("Decal") and v58 >= 1 then
                        for _, v59 in v55:GetChildren() do
                            if v59:IsA("Decal") then
                                v59.Transparency = 0.4;
                            end;
                        end;
                    end;
                else
                    v55.Transparency = 1;
                    v55.CanCollide = false;
                end;
            end;
        end;
        u46:GetAttributeChangedSignal("Age"):Connect(v60);
        v60();
    end
};