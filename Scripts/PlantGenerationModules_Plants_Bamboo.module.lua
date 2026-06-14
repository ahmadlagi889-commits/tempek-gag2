-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25,
        BaseWeight = 5
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 13 ]]
        local v4 = Random.new(p2);
        local l__Base__1 = p1.Base;
        local v5 = p3 or 1;
        local l__Stud_Part__2 = script.Stud_Part;
        local v6 = v4:NextInteger(7, 11) + v5 ^ 2;
        local v7 = math.round(v6);
        local v8 = math.round(v5 * 0.5 + 0.5);
        local v9 = v5 > 3 and v4:NextInteger(1, 3) == 1 and 2 or v8;
        local l__Size__3 = l__Base__1.Size;
        local v10 = l__Base__1.CFrame * CFrame.new(0, -l__Base__1.Size.Y / 2, 0);
        local v11 = Color3.new(0, 0.666667, 0);
        local v12 = Color3.new(0, 0.392157, 0);
        local v13 = 0;
        local v14 = true;
        local v15 = 0;
        for _ = 1, v7 do
            v13 = v13 + 1;
            local v16;
            if v14 == true then
                v16 = l__Stud_Part__2:Clone();
                v16.Size = Vector3.new(v9, 3, v9);
                v16.CFrame = v10 * CFrame.new(0, v16.Size.Y / 2 + l__Size__3.Y / 2, 0);
                v16.Name = tostring(v13);
                v16.Color = v11;
                v16:SetAttribute("NoCanCollide", true);
                v16.Parent = p1;
            else
                v16 = l__Stud_Part__2:Clone();
                v16.Size = Vector3.new(v9 + 0.25, 0.5, v9 + 0.25);
                v16.CFrame = v10 * CFrame.new(0, v16.Size.Y / 2 + l__Size__3.Y / 2, 0);
                v16.Name = tostring(v13);
                v16.Color = v12;
                v16:SetAttribute("NoCanCollide", true);
                v16.Parent = p1;
            end;
            v15 = v15 + v16.Size.Y;
            v10 = v16.CFrame;
            l__Size__3 = v16.Size;
            v14 = not v14;
        end;
        local v17 = v15;
        local v18 = 0;
        while v15 > 0 do
            v18 = v18 + 1;
            v15 = v15 - 1;
            local v19 = l__Stud_Part__2:Clone();
            v19.Size = Vector3.new(0.5, v9 + 0.5, v9 + 0.5);
            v19.Shape = Enum.PartType.Cylinder;
            local v20 = v18 * 1 - 0.75;
            v19.CFrame = l__Base__1.CFrame * CFrame.new(0, v20, 0);
            v19.CFrame = v19.CFrame * CFrame.Angles(0, 0, 1.5707963267948966);
            v19.Name = tostring(v13 * (v20 / v17));
            v19.Transparency = 1;
            v19:SetAttribute("OG_Transparency", 1);
            v19:SetAttribute("ClimbRung", true);
            v19.Parent = p1;
        end;
        local v21 = l__Stud_Part__2:Clone();
        v21.Name = "CollisionBlock";
        v21.Size = Vector3.new(v9 + 0.25, v17, v9 + 0.25);
        v21.CFrame = l__Base__1.CFrame * CFrame.new(0, v17 / 2, 0);
        v21.Transparency = 1;
        v21:SetAttribute("OG_Transparency", 1);
        v21:SetAttribute("IsCollisionBlock", true);
        v21:SetAttribute("MaxHeight", v17);
        v21.Parent = p1;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u22) --[[ Name: BeginPlantGrowth, Line 97 ]]
        local l__LocalPlayer__4 = game.Players.LocalPlayer;
        local u23;
        if l__LocalPlayer__4 then
            u23 = u22:GetAttribute("UserId") == l__LocalPlayer__4.UserId;
        else
            u23 = false;
        end;
        local l__PrimaryPart__5 = u22.PrimaryPart;
        local l__CollisionBlock__6 = u22:WaitForChild("CollisionBlock");
        local u24 = l__CollisionBlock__6:GetAttribute("MaxHeight");
        l__CollisionBlock__6.CanCollide = false;
        l__CollisionBlock__6.Transparency = 1;
        local u25 = {};
        for _, v26 in u22:GetDescendants() do
            local v27 = tonumber(v26.Name);
            if v26:IsA("BasePart") and v27 then
                local v28 = {
                    v26,
                    v26.Size,
                    l__PrimaryPart__5.CFrame:ToObjectSpace(v26.CFrame),
                    v27
                };
                table.insert(u25, v28);
                v26.CanCollide = false;
                v26.Transparency = 1;
            end;
        end;
        local function v39() --[[ Line: 121 ]]
            -- upvalues: u22 (copy), u25 (copy), l__PrimaryPart__5 (copy), u23 (copy), u24 (copy), l__CollisionBlock__6 (copy)
            local v29 = u22:GetAttribute("Age") or 0;
            local v30 = u22:GetAttribute("MaxAge") or 1;
            local v31 = v29 / v30;
            for _, v32 in u25 do
                local v33 = v32[1];
                local v34 = v32[2];
                local v35 = v32[3];
                local v36 = math.min((v31 - v32[4] / v30) * v30, 1);
                if v36 > 0 then
                    v33.Size = Vector3.new(v34.X, v34.Y * v36, v34.Z);
                    v33.CFrame = l__PrimaryPart__5.CFrame * v35 * CFrame.new(0, (v33.Size.Y - v34.Y) / 2, 0);
                    v33.Transparency = v33:GetAttribute("OG_Transparency") or 0;
                    if v33:GetAttribute("ClimbRung") then
                        v33.CanCollide = u23;
                    end;
                    if v33:FindFirstChild("Decal") and v36 >= 1 then
                        for _, v37 in v33:GetChildren() do
                            if v37:IsA("Decal") then
                                v37.Transparency = 0.4;
                            end;
                        end;
                    end;
                else
                    v33.Transparency = 1;
                    v33.CanCollide = false;
                end;
            end;
            local v38 = u24 * v31;
            if v38 > 0 then
                l__CollisionBlock__6.Size = Vector3.new(l__CollisionBlock__6.Size.X, v38, l__CollisionBlock__6.Size.Z);
                l__CollisionBlock__6.CFrame = l__PrimaryPart__5.CFrame * CFrame.new(0, v38 / 2, 0);
                l__CollisionBlock__6.CanCollide = not u23;
            else
                l__CollisionBlock__6.CanCollide = false;
            end;
        end;
        u22:GetAttributeChangedSignal("Age"):Connect(v39);
        v39();
    end
};