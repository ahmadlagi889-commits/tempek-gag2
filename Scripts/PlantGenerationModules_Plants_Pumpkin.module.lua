-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25,
        BaseWeight = 5
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 7 ]]
        Random.new(p2);
        local l__Base__1 = p1.Base;
        local v4 = 3 * (p3 or 1);
        local v5 = script.Main:Clone();
        v5.Size = Vector3.new(v4, v4, v4);
        v5.CFrame = l__Base__1.CFrame * CFrame.new(0, -l__Base__1.Size.Y / 2 + v5.Size.Y / 2, 0) * CFrame.Angles(0, 0, 1.5707963267948966);
        v5.Parent = p1;
        local v6 = v4 * 0.15;
        local v7 = v6 * 1.2;
        local v8 = v5.CFrame * CFrame.new(0, v5.Size.Y / 2, 0);
        local v9 = {};
        local v10 = { v8 };
        local v11 = 1;
        for _ = 1, 8 do
            local v12 = v8 * CFrame.Angles(0, 0, 0.20943951023931956);
            local v13 = v12 * CFrame.new(0, v7 / 2, 0);
            local v14 = script.Stem:Clone();
            v14.Size = Vector3.new(v6, v7, v6);
            v14.CFrame = v13;
            v14:SetAttribute("GrowUp", true);
            v14.Parent = p1;
            table.insert(v9, v14);
            v8 = v12 * CFrame.new(0, v7, 0);
            table.insert(v10, v8);
        end;
        for v15 = #v9, 1, -1 do
            v9[v15].Name = tostring(v11);
            v11 = v11 + 1;
        end;
        local v16 = v4 * 0.25;
        local v17 = v4 * 0.03;
        local v18 = { 1, -1, 1 };
        local v19 = { 25, -20, 30 };
        for v20, v21 in ipairs({ 3, 5, 7 }) do
            if v10[v21] then
                local v22 = v18[v20];
                local v23 = v19[v20];
                local v24 = v16 * (1 - (v20 - 1) * 0.15);
                local v25 = script.Stem:Clone();
                v25.Size = Vector3.new(v24, v17, v24);
                v25.CFrame = v10[v21] * CFrame.new(v24 * 0.5 * v22, 0, v17 * 2) * CFrame.Angles(math.rad(v23), 0, (math.rad(v23 * v22)));
                v25:SetAttribute("GrowUp", true);
                v25.Name = tostring(v11);
                v25.Parent = p1;
                v11 = v11 + 1;
            end;
        end;
        local v26 = v4 * 0.07;
        local v27 = v6 * 0.95;
        local v28 = {};
        for v29 = 0, 28 do
            local v30 = v29 / 28;
            local v31 = v5.CFrame * CFrame.new(0, v5.Size.Y / 2, 0);
            local v32 = v30 * 8;
            for _ = 1, math.floor(v32) do
                v31 = v31 * CFrame.Angles(0, 0, 0.20943951023931956) * CFrame.new(0, v7, 0);
            end;
            local v33 = v32 - math.floor(v32);
            local v34 = v31 * CFrame.Angles(0, 0, v33 * 0.20943951023931956) * CFrame.new(0, v7 * v33, 0);
            local v35 = v30 * 3.141592653589793 * 2 * 1.5;
            local v36 = math.cos(v35) * v27;
            local v37 = math.sin(v35) * v27;
            local v38 = v34 * CFrame.new(v36, 0, v37);
            table.insert(v28, v38);
        end;
        for v39 = 1, #v28 - 1 do
            local l__Position__2 = v28[v39].Position;
            local l__Position__3 = v28[v39 + 1].Position;
            local l__Unit__4 = (l__Position__3 - l__Position__2).Unit;
            local l__Magnitude__5 = (l__Position__3 - l__Position__2).Magnitude;
            local v40 = CFrame.lookAt(l__Position__2, l__Position__2 + l__Unit__4) * CFrame.Angles(-1.5707963267948966, 0, 0);
            local v41 = script.Stem:Clone();
            v41.Size = Vector3.new(v26, l__Magnitude__5, v26);
            v41.CFrame = v40 * CFrame.new(0, l__Magnitude__5 / 2, 0);
            v41:SetAttribute("GrowUp", true);
            v41.Name = tostring(v11);
            v41.Parent = p1;
            v11 = v11 + 1;
        end;
        v5.Name = tostring(v11);
        v5.CFrame = v5.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u42) --[[ Name: BeginPlantGrowth, Line 126 ]]
        local l__PrimaryPart__6 = u42.PrimaryPart;
        local u43 = {};
        for _, v44 in u42:GetDescendants() do
            local v45 = tonumber(v44.Name);
            if v44:IsA("BasePart") and v45 then
                local v46 = {
                    v44,
                    v44.Size,
                    l__PrimaryPart__6.CFrame:ToObjectSpace(v44.CFrame),
                    v45
                };
                table.insert(u43, v46);
                v44.CanCollide = false;
                v44.Transparency = 1;
            end;
        end;
        local function v57() --[[ Line: 142 ]]
            -- upvalues: u42 (copy), u43 (copy), l__PrimaryPart__6 (copy)
            local v47 = u42:GetAttribute("Age") or 0;
            local v48 = u42:GetAttribute("MaxAge") or 1;
            local v49 = v47 / v48;
            for _, v50 in u43 do
                local v51 = v50[1];
                local v52 = v50[2];
                local v53 = v50[3];
                local v54 = math.min((v49 - v50[4] / v48) * v48, 1);
                if v54 > 0 then
                    v51.Size = Vector3.new(v52.X, v52.Y * v54, v52.Z);
                    local v55;
                    if v51:GetAttribute("GrowUp") then
                        v55 = (v52.Y - v51.Size.Y) / 2;
                    else
                        v55 = (v51.Size.Y - v52.Y) / 2;
                    end;
                    v51.CFrame = l__PrimaryPart__6.CFrame * v53 * CFrame.new(0, v55, 0);
                    v51.Transparency = v51:GetAttribute("OG_Transparency") or 0;
                    v51.CanCollide = true;
                    if v51:FindFirstChild("Decal") and v54 >= 1 then
                        for _, v56 in v51:GetChildren() do
                            if v56:IsA("Decal") then
                                v56.Transparency = 0.4;
                            end;
                        end;
                    end;
                else
                    v51.Transparency = 1;
                    v51.CanCollide = false;
                end;
            end;
        end;
        u42:GetAttributeChangedSignal("Age"):Connect(v57);
        v57();
    end
};