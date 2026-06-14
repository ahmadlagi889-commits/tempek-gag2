-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(p1, p2, _) --[[ Name: InitPlant, Line 6 ]]
        local v3 = Random.new(p2);
        local v4 = {};
        for _, v5 in p1:GetDescendants() do
            if v5:IsA("BasePart") then
                local v6 = tostring(v5.Color);
                if not v4[v6] then
                    local v7, v8, v9 = v5.Color:ToHSV();
                    local v10 = (v7 + v3:NextNumber(-0.05, 0.05)) % 1;
                    local v11 = v8 + v3:NextNumber(-0.15, 0.15);
                    local v12 = math.clamp(v11, 0, 1);
                    local v13 = v9 + v3:NextNumber(-0.15, 0.15);
                    local v14 = math.clamp(v13, 0, 1);
                    v4[v6] = Color3.fromHSV(v10, v12, v14);
                end;
                v5.Color = v4[v6];
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u15) --[[ Name: BeginPlantGrowth, Line 27 ]]
        local l__PrimaryPart__1 = u15.PrimaryPart;
        local u16 = {};
        for _, v17 in u15:GetDescendants() do
            local v18 = tonumber(v17.Name);
            if v17:IsA("BasePart") and v18 then
                local v19 = v17:GetAttribute("OG_Transparency");
                if v19 == nil then
                    v19 = v17.Transparency;
                end;
                local v20 = v17.Material == Enum.Material.Neon and 0.5 or v19;
                v17:SetAttribute("OG_Transparency", v20);
                local v21 = {};
                for _, v22 in v17:GetChildren() do
                    if v22:IsA("Texture") or v22:IsA("Decal") then
                        table.insert(v21, {
                            instance = v22,
                            originalTransparency = v22.Transparency
                        });
                        v22.Transparency = 1;
                    end;
                end;
                local v23 = {
                    v17,
                    v17.Size,
                    l__PrimaryPart__1.CFrame:ToObjectSpace(v17.CFrame),
                    v18,
                    v20,
                    v21
                };
                table.insert(u16, v23);
                v17.CanCollide = false;
                v17.Transparency = 1;
            end;
        end;
        local function v35() --[[ Line: 65 ]]
            -- upvalues: u15 (copy), u16 (copy), l__PrimaryPart__1 (copy)
            local v24 = u15:GetAttribute("Age") or 0;
            u15:GetAttribute("MaxAge");
            for _, v25 in u16 do
                local v26 = v25[1];
                local v27 = v25[2];
                local v28 = v25[3];
                local v29 = v25[4];
                local v30 = v25[5];
                local v31 = v25[6];
                local v32 = math.min(v24 - v29, 1);
                if v32 > 0 then
                    v26.Size = Vector3.new(v27.X, v27.Y * v32, v27.Z);
                    v26.CFrame = l__PrimaryPart__1.CFrame * v28 * CFrame.new(0, (v26.Size.Y - v27.Y) / 2, 0);
                    v26.Transparency = v30;
                    v26.CanCollide = true;
                    for _, v33 in v31 do
                        v33.instance.Transparency = v33.originalTransparency;
                    end;
                else
                    v26.Transparency = 1;
                    v26.CanCollide = false;
                    for _, v34 in v31 do
                        v34.instance.Transparency = 1;
                    end;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u15:GetAttribute("playedSfx") and u15:GetAttribute("MaxAge") <= v24)) then
                u15:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u15:GetAttributeChangedSignal("Age"):Connect(v35);
        v35();
    end,
    Extras = {}
};