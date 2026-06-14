-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = l__ReplicatedStorage__2.Assets:FindFirstChild("Meshes/BeanStalkMesh");
local function u3() --[[ Line: 13 ]]
    local v2 = Instance.new("Part");
    v2.Anchored = true;
    v2.CanCollide = false;
    v2.Massless = true;
    v2.BackSurface = Enum.SurfaceType.Studs;
    v2.BottomSurface = Enum.SurfaceType.Studs;
    v2.FrontSurface = Enum.SurfaceType.Studs;
    v2.LeftSurface = Enum.SurfaceType.Studs;
    v2.RightSurface = Enum.SurfaceType.Studs;
    v2.Size = Vector3.new(2, 1, 4);
    return v2;
end;
local function u9(u4) --[[ Line: 39 ]]
    local v5 = u4:GetAttribute("BeanstalkSize");
    local v6 = typeof(v5) ~= "number" and 0.6 or v5;
    local v7 = typeof(v6) ~= "number" and 0.6 or v6;
    local u8 = math.clamp(v7, 0.05, 1) * 2.4;
    local _, _ = pcall(function() --[[ Line: 43 ]]
        -- upvalues: u4 (copy), u8 (copy)
        u4:ScaleTo(u8);
    end);
end;
local function u20(u10) --[[ Line: 50 ]]
    local v11 = u10.PrimaryPart or u10:FindFirstChild("Base");
    if v11 then
        if v11:FindFirstChild("GuildBeanstalkLabel") then
        else
            local u12 = Instance.new("BillboardGui");
            u12.Name = "GuildBeanstalkLabel";
            u12.Size = UDim2.fromOffset(300, 80);
            u12.StudsOffsetWorldSpace = Vector3.new(0, 50, 0);
            u12.AlwaysOnTop = true;
            u12.LightInfluence = 0;
            u12.MaxDistance = 250;
            local v13 = Instance.new("Frame");
            v13.Size = UDim2.fromScale(1, 1);
            v13.BackgroundColor3 = Color3.fromRGB(20, 25, 35);
            v13.BackgroundTransparency = 0.25;
            v13.BorderSizePixel = 0;
            v13.Parent = u12;
            local v14 = Instance.new("UICorner");
            v14.CornerRadius = UDim.new(0, 8);
            v14.Parent = v13;
            local v15 = Instance.new("UIStroke");
            v15.Color = Color3.fromRGB(110, 231, 167);
            v15.Thickness = 1.5;
            v15.Parent = v13;
            local u16 = Instance.new("TextLabel");
            u16.Name = "Title";
            u16.BackgroundTransparency = 1;
            u16.Size = UDim2.fromScale(1, 1);
            u16.Font = Enum.Font.GothamBold;
            u16.TextColor3 = Color3.fromRGB(230, 237, 243);
            u16.TextScaled = true;
            u16.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            u16.TextStrokeTransparency = 0.5;
            u16.Text = "";
            u16.Parent = v13;
            u12.Parent = v11;
            local function v19() --[[ Line: 95 ]]
                -- upvalues: u10 (copy), u16 (copy), u12 (copy)
                local v17 = u10:GetAttribute("GuildTag");
                local v18 = u10:GetAttribute("GuildName");
                if typeof(v17) == "string" and (v17 ~= "" and (typeof(v18) == "string" and v18 ~= "")) then
                    u16.Text = `[{v17}] {v18}`;
                    u12.Enabled = true;
                elseif typeof(v18) == "string" and v18 ~= "" then
                    u16.Text = v18;
                    u12.Enabled = true;
                else
                    u12.Enabled = false;
                end;
            end;
            v19();
            u10:GetAttributeChangedSignal("GuildTag"):Connect(v19);
            u10:GetAttributeChangedSignal("GuildName"):Connect(v19);
        end;
    end;
end;
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u21, p22, p23) --[[ Name: InitPlant, Line 127 ]]
        -- upvalues: u1 (copy), u3 (copy), l__CollectionService__1 (copy), u9 (copy), u20 (copy)
        local v24 = p23 or 1;
        local v25 = Random.new(p22);
        local l__FruitSpawnLocations__3 = u21.FruitSpawnLocations;
        local l__Base__4 = u21.Base;
        local v26 = v24 * 3 * v25:NextInteger(7, 14) * 0.1;
        local v27 = v24 * 2 * v25:NextInteger(7, 14) * 0.1;
        local v28 = v24 * v25:NextInteger(7, 14) * 0.1;
        local v29 = math.clamp(v28, 1, (1 / 0));
        local v30 = math.sqrt(v29) * 30;
        local u31 = 0;
        while v25:NextInteger(1, 10) == 1 do
            v30 = v30 + 5;
        end;
        local v32 = 3 * v25:NextInteger(7, 14) * 0.1;
        local v33 = l__Base__4.CFrame * CFrame.new(0, -l__Base__4.Size.Y / 2, 0);
        local v34 = 3 * v25:NextInteger(7, 14) * 0.1 * v24;
        local v35 = v25:NextInteger(950, 995) * 0.001;
        local v36 = 0;
        local v37 = {};
        for v38 = 1, v30 do
            u31 = u31 + 1;
            v26 = v26 * v35;
            v27 = v27 * v35;
            local v39 = v38 * 0.1 % 2;
            local v40 = v39 <= 1 and v39 and v39 or 2 - v39;
            v36 = v36 + 10;
            local v41 = math.rad(v36);
            local v42 = CFrame.new(math.cos(v41) * v34, 0, math.sin(v41) * v34);
            local v43 = u1:Clone();
            v43.Size = Vector3.new(v26 * 2, v27 * 1.25, v26 * 2);
            v43.Color = Color3.fromHSV(0.24500000000000002 + v40 * 0.025, 0.5 + v40 * 0.175, 0.5 + v40 * 0.25);
            v43.CFrame = v33 * v42 * CFrame.new(0, v43.Size.Y / 2, 0);
            v43.Name = tostring(u31);
            v43.Parent = u21;
            if u31 % 2 == 0 then
                table.insert(v37, v43);
            end;
            local v44 = v33 * CFrame.new(0, v27, 0);
            local v45 = v40 * 2;
            local v46 = v40 * 2;
            v33 = v44 * CFrame.Angles(math.rad(-1 + v45), math.rad(v32), (math.rad(-1 + v46)));
        end;
        local function v50(p47) --[[ Line: 185 ]]
            -- upvalues: u31 (ref), u3 (ref), u21 (copy), l__CollectionService__1 (ref)
            u31 = u31 + 1;
            local v48 = u3();
            v48.Shape = Enum.PartType.Wedge;
            v48.Size = Vector3.new(p47.Size.Z, p47.Size.Y * 0.5, p47.Size.X / 2);
            v48.CFrame = p47.CFrame * CFrame.new(-p47.Size.X / 4, -(p47.Size.Y / 2 + v48.Size.Y / 2), 0);
            v48.CFrame = v48.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
            v48.CFrame = v48.CFrame * CFrame.Angles(0, 0, 3.141592653589793);
            v48.Color = p47.Color;
            v48.Name = tostring(u31);
            v48.Parent = u21;
            l__CollectionService__1:AddTag(v48, "DetailPart");
            local v49 = u3();
            v49.Shape = Enum.PartType.Wedge;
            v49.Size = Vector3.new(p47.Size.Z, p47.Size.Y * 0.5, p47.Size.X / 2);
            v49.CFrame = p47.CFrame * CFrame.new(p47.Size.X / 4, -(p47.Size.Y / 2 + v49.Size.Y / 2), 0);
            v49.CFrame = v49.CFrame * CFrame.Angles(0, -1.5707963267948966, 0);
            v49.CFrame = v49.CFrame * CFrame.Angles(0, 0, 3.141592653589793);
            v49.Color = p47.Color;
            v49.Name = tostring(u31);
            v49.Parent = u21;
            l__CollectionService__1:AddTag(v49, "DetailPart");
        end;
        for v51 = #v37, 1, -1 do
            local v52 = v37[v51];
            local v53 = u31 + 1;
            local v54 = v52.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
            local l__Angles__5 = CFrame.Angles;
            local v55 = v25:NextInteger(-180, 180);
            local v56 = v54 * l__Angles__5(0, 0, (math.rad(v55)));
            local l__Angles__6 = CFrame.Angles;
            local v57 = -v25:NextInteger(30, 45);
            local v58 = v56 * l__Angles__6(math.rad(v57), 0, 0);
            local l__Magnitude__7 = v52.Size.Magnitude;
            local v59 = u3();
            v59.Color = v52.Color;
            local v60 = 1 * (l__Magnitude__7 * 0.2);
            local v61 = v25:NextInteger(17, 21) * 0.1 * (l__Magnitude__7 * 0.34);
            v59.Size = Vector3.new(v60, v61, 2);
            v59.CFrame = v58 * CFrame.new(0, v59.Size.Y / 2, 0);
            v59.Name = tostring(v53);
            v59.Parent = u21;
            v53 = v53 + 1;
            local v62 = v25:NextInteger(27, 30) * 0.1;
            local v63 = u3();
            v63.Color = v52.Color;
            v63.Size = Vector3.new(v62 * (l__Magnitude__7 * 0.2), v62 * (l__Magnitude__7 * 0.2), 2);
            v63.CFrame = v59.CFrame * CFrame.new(0, v59.Size.Y / 2 + v63.Size.Y / 2, 0) * CFrame.Angles(3.141592653589793, 0, 0);
            v63.Name = tostring(v53);
            v63.Parent = u21;
            l__CollectionService__1:AddTag(v63, "DetailPart");
            v50(v63);
            v63.CFrame = v63.CFrame * CFrame.Angles(3.141592653589793, 0, 0);
            local v64 = u3();
            v64.Transparency = 1;
            v64.Size = Vector3.new(0.1, 0.1, 0.1);
            v64.CFrame = CFrame.new((v63.CFrame * CFrame.new(0, 0, v63.Size.Z / 2)).Position) * CFrame.Angles(-1.5707963267948966, 0, 0);
            v64.Orientation = Vector3.new(v64.Orientation.X, -v59.Orientation.Y, v64.Orientation.Z);
            v64.Parent = l__FruitSpawnLocations__3;
            v64.Name = "FruitSpawn";
            u31 = v53;
        end;
        u9(u21);
        u21:GetAttributeChangedSignal("BeanstalkSize"):Connect(function() --[[ Line: 115 ]]
            -- upvalues: u9 (ref), u21 (copy)
            u9(u21);
        end);
        u20(u21);
        u21:AddTag("InitializationComplete");
        u21:AddTag("MagicBeanstalk");
    end,
    BeginPlantGrowth = function(u65) --[[ Name: BeginPlantGrowth, Line 265 ]]
        local l__PrimaryPart__8 = u65.PrimaryPart;
        local u66 = {};
        for _, v67 in u65:GetDescendants() do
            local v68 = tonumber(v67.Name);
            if v67:IsA("BasePart") and v68 then
                local v69 = {
                    v67,
                    v67.Size,
                    l__PrimaryPart__8.CFrame:ToObjectSpace(v67.CFrame),
                    v68
                };
                table.insert(u66, v69);
                v67.CanCollide = false;
                v67.Transparency = 1;
            end;
        end;
        local function v76() --[[ Line: 281 ]]
            -- upvalues: u65 (copy), u66 (copy), l__PrimaryPart__8 (copy)
            local v70 = u65:GetAttribute("Age") or 0;
            for _, v71 in u66 do
                local v72 = v71[1];
                local v73 = v71[2];
                local v74 = v71[3];
                local v75 = math.min(v70 - v71[4], 1);
                if v75 > 0 then
                    v72.Size = Vector3.new(v73.X, v73.Y * v75, v73.Z);
                    v72.CFrame = l__PrimaryPart__8.CFrame * v74 * CFrame.new(0, (v72.Size.Y - v73.Y) / 2, 0);
                    v72.Transparency = v72:GetAttribute("OG_Transparency") or 0;
                    v72.CanCollide = true;
                else
                    v72.Transparency = 1;
                    v72.CanCollide = false;
                end;
            end;
        end;
        u65:GetAttributeChangedSignal("Age"):Connect(v76);
        v76();
    end,
    Extras = {}
};