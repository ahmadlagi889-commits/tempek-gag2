-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__Players__3 = game:GetService("Players");
local v1 = {};
local u2 = {};
local u3 = {};
local u4 = 0;
local u5 = false;
local function u47(p6, p7) --[[ Line: 53 ]]
    -- upvalues: u3 (copy), u2 (copy), l__Players__3 (copy)
    if p6.Parent then
        debug.profilebegin("Controllers/InverseKinematicsController/Update");
        local l__basePart__4 = p7.basePart;
        local l__topPart__5 = p7.topPart;
        local l__chain__6 = p7.chain;
        local l__attachmentData__7 = p7.attachmentData;
        local l__baseData__8 = p7.baseData;
        local l__topJawData__9 = p7.topJawData;
        local l__bottomJawData__10 = p7.bottomJawData;
        local l__topJawPivot__11 = p7.topJawPivot;
        local l__bottomJawPivot__12 = p7.bottomJawPivot;
        local l__jawValue__13 = p7.jawValue;
        local l__lungeValue__14 = p7.lungeValue;
        local v8 = os.clock();
        local l__Value__15 = l__lungeValue__14.Value;
        local v9 = math.sin(v8 * 1.5) * 0.03 + math.sin(v8 * 3.1) * 0.01;
        local l__Position__16 = l__basePart__4.Position;
        debug.profilebegin("Controllers/InverseKinematicsController/Update/scanPlayers");
        local v10 = (1 / 0);
        local v11 = nil;
        for _, v12 in l__Players__3:GetPlayers() do
            local v13 = p6 and p6.Parent;
            if v13 then
                v13 = p6.Parent.Parent;
            end;
            local v14;
            if v13 then
                v14 = v13:GetAttribute("Owner");
            else
                v14 = nil;
            end;
            local v15;
            if v14 then
                v15 = v12.Name == v14 and true or tostring(v12.UserId) == v14;
            else
                v15 = false;
            end;
            if not v15 then
                local l__Character__17 = v12.Character;
                if l__Character__17 then
                    local v16 = l__Character__17:FindFirstChild("HumanoidRootPart");
                    if v16 then
                        local l__Magnitude__18 = (v16.Position - l__Position__16).Magnitude;
                        if l__Magnitude__18 < v10 then
                            v11 = v16;
                            v10 = l__Magnitude__18;
                        end;
                    end;
                end;
            end;
        end;
        debug.profileend();
        if v11 and v10 <= 15 then
            local v17 = v11.Position - l__Position__16;
            local v18 = Vector3.new(v17.X, 0, v17.Z);
            if v18.Magnitude > 0.1 then
                local v19 = math.atan2(-v18.X, -v18.Z);
                local _, v20, _ = l__basePart__4.CFrame:ToEulerAnglesYXZ();
                local v21 = v20 + ((v19 - v20 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * 0.08;
                l__basePart__4.CFrame = CFrame.new(l__Position__16) * CFrame.Angles(0, v21, 0);
            end;
        elseif p6:FindFirstChildOfClass("Highlight") == nil then
            local _, v22, _ = l__basePart__4.CFrame:ToEulerAnglesYXZ();
            local v23 = (p7.originalBaseAngle - v22 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
            if math.abs(v23) > 0.001 then
                local v24 = v22 + v23 * 0.05;
                l__basePart__4.CFrame = CFrame.new(l__Position__16) * CFrame.Angles(0, v24, 0);
            end;
        end;
        debug.profilebegin("Controllers/InverseKinematicsController/Update/computeSwayChain");
        local v25 = { l__basePart__4.CFrame };
        local l__CFrame__19 = l__basePart__4.CFrame;
        for v26, v27 in l__chain__6 do
            l__CFrame__19 = l__CFrame__19 * v27.restOffset * CFrame.Angles(v9, 0, 0);
            v25[v26 + 1] = l__CFrame__19;
        end;
        debug.profileend();
        local l__Position__20 = (v25[#v25] * CFrame.new(0, l__chain__6[#l__chain__6].part.Size.Y / 2, 0)).Position;
        local v28 = Vector3.new(0, 1, 0);
        local v29 = 0;
        local v30 = p6:GetAttribute("LungeTarget");
        if l__Value__15 > 0.001 and v30 then
            local l__Position__21 = l__basePart__4.Position;
            local v31 = l__Position__20 - l__Position__21;
            local v32 = v30 - l__Position__21;
            if v31.Magnitude > 0.01 and v32.Magnitude > 0.01 then
                local l__Unit__22 = v31.Unit;
                local l__Unit__23 = v32.Unit;
                local v33 = l__Unit__22:Cross(l__Unit__23);
                if v33.Magnitude > 0.0001 then
                    v28 = v33.Unit;
                    local v34 = l__Unit__22:Dot(l__Unit__23);
                    local v35 = math.clamp(v34, -1, 1);
                    v29 = math.acos(v35) * l__Value__15 / #l__chain__6;
                end;
            end;
        end;
        debug.profilebegin("Controllers/InverseKinematicsController/Update/rebuildChain");
        local l__CFrame__24 = l__basePart__4.CFrame;
        local v36 = CFrame.fromAxisAngle(v28, v29);
        for _, v37 in l__chain__6 do
            l__CFrame__24 = l__CFrame__24 * v37.restOffset * CFrame.Angles(v9, 0, 0);
            if v29 > 0.0001 then
                local l__Position__25 = l__CFrame__24.Position;
                local v38 = v36 * (l__CFrame__24 - l__CFrame__24.Position);
                l__CFrame__24 = CFrame.new(l__Position__25) * v38;
            end;
            v37.part.CFrame = l__CFrame__24;
        end;
        debug.profileend();
        debug.profilebegin("Controllers/InverseKinematicsController/Update/updateAttachments");
        for _, v39 in l__attachmentData__7 do
            v39.part.CFrame = v39.parent.CFrame * v39.offset;
        end;
        debug.profileend();
        debug.profilebegin("Controllers/InverseKinematicsController/Update/updateHeadBase");
        for _, v40 in l__baseData__8 do
            v40.part.CFrame = l__topPart__5.CFrame * v40.offset;
        end;
        debug.profileend();
        local v41 = l__jawValue__13.Value * 0.45;
        if l__topJawPivot__11 then
            local v42 = l__topPart__5.CFrame * l__topJawPivot__11 * CFrame.Angles(0, 0, v41);
            for _, v43 in l__topJawData__9 do
                v43.part.CFrame = v42 * v43.offset;
            end;
        end;
        if l__bottomJawPivot__12 then
            local v44 = l__topPart__5.CFrame * l__bottomJawPivot__12 * CFrame.Angles(0, 0, -v41);
            for _, v45 in l__bottomJawData__10 do
                v45.part.CFrame = v44 * v45.offset;
            end;
        end;
        debug.profileend();
    else
        local v46 = u3[p6];
        if v46 then
            u3[p6] = nil;
            u2[p6] = nil;
            if v46.jawValue then
                v46.jawValue:Destroy();
            end;
            if v46.lungeValue then
                v46.lungeValue:Destroy();
            end;
        end;
    end;
end;
function v1.Init(_) --[[ Line: 243 ]]
    -- upvalues: u5 (ref), l__RunService__1 (copy), u4 (ref), u3 (copy), u47 (copy)
    if u5 then
    else
        u5 = true;
        l__RunService__1.Heartbeat:Connect(function(p48) --[[ Line: 230 ]]
            -- upvalues: u4 (ref), u3 (ref), u47 (ref)
            u4 = u4 + p48;
            if u4 < 0.15 then
            else
                u4 = 0;
                debug.profilebegin("Controllers/InverseKinematicsController/SharedHeartbeat");
                for v49, v50 in u3 do
                    u47(v49, v50);
                end;
                debug.profileend();
            end;
        end);
    end;
end;
function v1.SetupPlant(_, p51) --[[ Line: 247 ]]
    -- upvalues: u2 (copy), u3 (copy), u5 (ref), l__RunService__1 (copy), u4 (ref), u47 (copy)
    local u52 = {};
    local v53 = {};
    for _, v54 in p51:GetChildren() do
        local v55 = tonumber(v54.Name);
        if v55 then
            if v54:IsA("Part") then
                table.insert(u52, {
                    part = v54,
                    index = v55
                });
            elseif v54:IsA("BasePart") then
                if not v53[v55] then
                    v53[v55] = {};
                end;
                table.insert(v53[v55], v54);
            end;
        end;
    end;
    table.sort(u52, function(p56, p57) --[[ Line: 265 ]]
        return p56.index < p57.index;
    end);
    if #u52 < 2 then
        return;
    end;
    local u58 = {};
    for _, v59 in u52 do
        u58[v59.index] = v59.part;
    end;
    local l__part__26 = u52[#u52].part;
    local function v63(p60) --[[ Line: 276 ]]
        -- upvalues: u58 (copy), u52 (copy), l__part__26 (copy)
        if u58[p60] then
            return u58[p60];
        else
            local v61 = nil;
            for _, v62 in u52 do
                if v62.index <= p60 and (not v61 or v62.index > v61.index) then
                    v61 = v62;
                end;
            end;
            if v61 then
                return v61.part;
            else
                return l__part__26;
            end;
        end;
    end;
    local v64 = {};
    for v65, v66 in v53 do
        local v67 = v63(v65);
        for _, v68 in v66 do
            local v69 = {
                part = v68,
                parent = v67,
                offset = v67.CFrame:ToObjectSpace(v68.CFrame)
            };
            table.insert(v64, v69);
        end;
    end;
    local v70 = p51:FindFirstChild("PlantModel");
    local v71 = {};
    local v72 = {};
    local v73 = {};
    local v74 = nil;
    local v75 = nil;
    if v70 and v70:IsA("Model") then
        local v76 = v70:FindFirstChild("Base");
        local v77 = v70:FindFirstChild("TopJaw");
        local v78 = v70:FindFirstChild("BottomJaw");
        if v76 then
            for _, v79 in v76:GetDescendants() do
                if v79:IsA("BasePart") then
                    local v80 = {
                        part = v79,
                        offset = l__part__26.CFrame:ToObjectSpace(v79.CFrame)
                    };
                    table.insert(v71, v80);
                end;
            end;
        end;
        if v77 then
            v74 = l__part__26.CFrame:ToObjectSpace(v77:GetPivot());
            for _, v81 in v77:GetDescendants() do
                if v81:IsA("BasePart") then
                    local v82 = {
                        part = v81,
                        offset = v77:GetPivot():ToObjectSpace(v81.CFrame)
                    };
                    table.insert(v72, v82);
                end;
            end;
        end;
        if v78 then
            v75 = l__part__26.CFrame:ToObjectSpace(v78:GetPivot());
            for _, v83 in v78:GetDescendants() do
                if v83:IsA("BasePart") then
                    local v84 = {
                        part = v83,
                        offset = v78:GetPivot():ToObjectSpace(v83.CFrame)
                    };
                    table.insert(v73, v84);
                end;
            end;
        end;
        for _, v85 in v70:GetDescendants() do
            if v85:IsA("BasePart") then
                local l__Parent__27 = v85.Parent;
                local v86 = false;
                while l__Parent__27 and l__Parent__27 ~= v70 do
                    if l__Parent__27.Name == "Base" or (l__Parent__27.Name == "TopJaw" or l__Parent__27.Name == "BottomJaw") then
                        v86 = true;
                        break;
                    end;
                    l__Parent__27 = l__Parent__27.Parent;
                end;
                if not v86 then
                    local v87 = {
                        part = v85,
                        offset = l__part__26.CFrame:ToObjectSpace(v85.CFrame)
                    };
                    table.insert(v71, v87);
                end;
            end;
        end;
    end;
    local l__part__28 = u52[1].part;
    local v88 = {};
    for v89 = 2, #u52 do
        local l__part__29 = u52[v89].part;
        local v90 = {
            part = l__part__29,
            restOffset = u52[v89 - 1].part.CFrame:ToObjectSpace(l__part__29.CFrame)
        };
        table.insert(v88, v90);
    end;
    local v91 = Instance.new("NumberValue");
    v91.Value = 0;
    v91.Name = "JawValue";
    v91.Parent = p51;
    local v92 = Instance.new("NumberValue");
    v92.Value = 0;
    v92.Name = "LungeValue";
    v92.Parent = p51;
    u2[p51] = {
        basePart = l__part__28
    };
    local _, v93, _ = l__part__28.CFrame:ToEulerAnglesYXZ();
    local u94 = {
        basePart = l__part__28,
        topPart = l__part__26,
        chain = v88,
        attachmentData = v64,
        baseData = v71,
        topJawData = v72,
        bottomJawData = v73,
        topJawPivot = v74,
        bottomJawPivot = v75,
        jawValue = v91,
        lungeValue = v92,
        originalBaseAngle = v93
    };
    p51.ChildRemoved:Connect(function(p95) --[[ Line: 418 ]]
        -- upvalues: l__part__28 (copy), u94 (copy)
        if p95:IsA("Highlight") then
            local _, v96, _ = l__part__28.CFrame:ToEulerAnglesYXZ();
            u94.originalBaseAngle = v96;
        end;
    end);
    u3[p51] = u94;
    if u5 then
    else
        u5 = true;
        l__RunService__1.Heartbeat:Connect(function(p97) --[[ Line: 230 ]]
            -- upvalues: u4 (ref), u3 (ref), u47 (ref)
            u4 = u4 + p97;
            if u4 < 0.15 then
            else
                u4 = 0;
                debug.profilebegin("Controllers/InverseKinematicsController/SharedHeartbeat");
                for v98, v99 in u3 do
                    u47(v98, v99);
                end;
                debug.profileend();
            end;
        end);
    end;
end;
function v1.GetBasePart(_, p100) --[[ Line: 432 ]]
    -- upvalues: u2 (copy)
    local v101 = u2[p100];
    return v101 and v101.basePart or nil;
end;
function v1.OpenMouth(_, p102) --[[ Line: 437 ]]
    -- upvalues: l__TweenService__2 (copy)
    local v103 = p102:FindFirstChild("JawValue");
    if v103 then
        l__TweenService__2:Create(v103, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
    end;
end;
function v1.CloseMouth(_, p104) --[[ Line: 443 ]]
    -- upvalues: l__TweenService__2 (copy)
    local v105 = p104:FindFirstChild("JawValue");
    if v105 then
        l__TweenService__2:Create(v105, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Value = -0.25
        }):Play();
    end;
end;
function v1.LungeAt(_, p106, p107) --[[ Line: 449 ]]
    -- upvalues: l__TweenService__2 (copy)
    p106:SetAttribute("LungeTarget", p107);
    local v108 = p106:FindFirstChild("LungeValue");
    if v108 then
        l__TweenService__2:Create(v108, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
    end;
end;
function v1.ReturnToRest(_, p109) --[[ Line: 456 ]]
    -- upvalues: l__TweenService__2 (copy)
    local v110 = p109:FindFirstChild("LungeValue");
    if v110 then
        l__TweenService__2:Create(v110, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Value = 0
        }):Play();
    end;
end;
return v1;