-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local u1 = {
    Color3.fromRGB(241, 131, 255),
    Color3.fromRGB(193, 131, 255),
    Color3.fromRGB(152, 121, 255),
    Color3.fromRGB(133, 141, 255),
    Color3.fromRGB(112, 162, 255)
};
local u2 = {};
local function u10(p3) --[[ Line: 39 ]]
    local v4 = {};
    for _, v5 in p3:GetDescendants() do
        if v5:IsA("BasePart") then
            local v6 = v5:GetAttribute("HornIndex");
            if typeof(v6) == "number" and (v6 >= 1 and v6 <= 7) then
                local v7, v8, v9 = Color3.toHSV(v5.Color);
                table.insert(v4, {
                    Instance = v5,
                    OrigHue = v7,
                    Sat = v8,
                    Val = v9
                });
            end;
        end;
    end;
    return v4;
end;
local function u15(p11, p12) --[[ Line: 57 ]]
    local v13 = p11.StartOffset - p12 * 0.5;
    for _, v14 in p11.HornParts do
        v14.Instance.Color = Color3.fromHSV((v14.OrigHue + v13) % 1, v14.Sat, v14.Val);
    end;
end;
local function u19(p16) --[[ Line: 66 ]]
    local v17 = {};
    for _, v18 in p16:GetDescendants() do
        if v18:IsA("BasePart") and v18:GetAttribute("UnicornHair") ~= nil then
            table.insert(v17, v18);
        end;
    end;
    return v17;
end;
local function u28(p20, p21) --[[ Line: 76 ]]
    -- upvalues: u1 (copy)
    if #p20.HairParts == 0 then
    else
        local v22 = #u1;
        local v23 = (p21 * 0.3333333333333333 + p20.StartOffset) * v22;
        local v24 = math.floor(v23);
        local v25 = v24 % v22;
        local v26 = u1[v25 + 1]:Lerp(u1[(v25 + 1) % v22 + 1], v23 - v24);
        for _, v27 in p20.HairParts do
            v27.Color = v26;
        end;
    end;
end;
local function u31(u29) --[[ Line: 96 ]]
    -- upvalues: u2 (copy), u10 (copy), u19 (copy)
    if u2[u29] then
    else
        u2[u29] = {
            Model = u29,
            StartOffset = math.random(),
            HornParts = u10(u29),
            HairParts = u19(u29)
        };
        u29.AncestryChanged:Connect(function(_, p30) --[[ Line: 107 ]]
            -- upvalues: u29 (copy), u2 (ref)
            if p30 == nil then
                u2[u29] = nil;
            end;
        end);
    end;
end;
local function u33(p32) --[[ Line: 112 ]]
    -- upvalues: u31 (copy)
    if p32:IsA("Model") then
        if p32.Name == "Unicorn" then
            u31(p32);
        end;
    end;
end;
return {
    StartOrder = 7,
    Init = function(_) --[[ Name: Init, Line 122 ]] end,
    Start = function(_) --[[ Name: Start, Line 124 ]]
        -- upvalues: u31 (copy), u33 (copy), l__RunService__1 (copy), u2 (copy), u15 (copy), u28 (copy)
        local l___PetVisualClient__2 = workspace:WaitForChild("_PetVisualClient", 30);
        if l___PetVisualClient__2 then
            local l__Models__3 = l___PetVisualClient__2:WaitForChild("Models", 30);
            if l__Models__3 then
                for _, v34 in l__Models__3:GetChildren() do
                    if v34:IsA("Model") then
                        if v34.Name == "Unicorn" then
                            u31(v34);
                        end;
                    end;
                end;
                l__Models__3.ChildAdded:Connect(u33);
                l__RunService__1:BindToRenderStep("UnicornVisual", Enum.RenderPriority.Camera.Value + 2, function() --[[ Line: 135 ]]
                    -- upvalues: u2 (ref), u15 (ref), u28 (ref)
                    local v35 = os.clock();
                    for _, v36 in u2 do
                        u15(v36, v35);
                        u28(v36, v35);
                    end;
                end);
            end;
        end;
    end
};