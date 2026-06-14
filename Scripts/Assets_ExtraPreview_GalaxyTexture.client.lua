-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__RunService__2 = game:GetService("RunService");
local l__Workspace__3 = game:GetService("Workspace");
local u1 = {};
local function v3(p2) --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    if p2:IsA("Texture") then
        local l__Parent__4 = p2.Parent;
        if l__Parent__4 and l__Parent__4:IsA("BasePart") then
            u1[p2] = {
                driftU = 0,
                driftV = 0,
                part = l__Parent__4
            };
        end;
    end;
end;
local function v5(p4) --[[ Line: 33 ]]
    -- upvalues: u1 (copy)
    if p4:IsA("Texture") then
        u1[p4] = nil;
    end;
end;
for _, v6 in l__CollectionService__1:GetTagged("GalaxyTexture") do
    v3(v6);
end;
l__CollectionService__1:GetInstanceAddedSignal("GalaxyTexture"):Connect(v3);
l__CollectionService__1:GetInstanceRemovedSignal("GalaxyTexture"):Connect(v5);
local u7 = 0;
l__RunService__2.RenderStepped:Connect(function(p8) --[[ Line: 60 ]]
    -- upvalues: u7 (ref), l__Workspace__3 (copy), u1 (copy)
    u7 = u7 + p8;
    if u7 < 0.05 then
    else
        local v9 = u7;
        u7 = 0;
        local l__CurrentCamera__5 = l__Workspace__3.CurrentCamera;
        if l__CurrentCamera__5 then
            local l__Position__6 = l__CurrentCamera__5.CFrame.Position;
            for v10, v11 in u1 do
                local l__part__7 = v11.part;
                local v12 = l__Position__6 - l__part__7.Position;
                if v12.Magnitude >= 0.0001 then
                    local v13 = l__part__7.CFrame:VectorToObjectSpace(v12.Unit);
                    local l__Face__8 = v10.Face;
                    local v14, v15;
                    if l__Face__8 == Enum.NormalId.Top or l__Face__8 == Enum.NormalId.Bottom then
                        v14 = v13.X;
                        v15 = v13.Z;
                    elseif l__Face__8 == Enum.NormalId.Right or l__Face__8 == Enum.NormalId.Left then
                        v14 = v13.Z;
                        v15 = v13.Y;
                    else
                        v14 = v13.X;
                        v15 = v13.Y;
                    end;
                    v11.driftU = v11.driftU + v9 * 0.05;
                    v11.driftV = v11.driftV + v9 * 0.25;
                    v10.OffsetStudsU = v14 * 2 + v11.driftU;
                    v10.OffsetStudsV = v15 * 2 + v11.driftV;
                end;
            end;
        end;
    end;
end);