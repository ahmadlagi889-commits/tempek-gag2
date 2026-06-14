-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 4
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__GardenSyncController__3 = require(script.Parent.GardenSyncController);
local l__PlacementGrid__4 = require(l__ReplicatedStorage__2.ClientModules.PlacementGrid);
local l__FakeSeat__5 = require(script.FakeSeat);
local _ = l__Players__1.LocalPlayer;
local l__Gardens__6 = workspace:WaitForChild("Gardens");
local l__Props__7 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Props");
local u2 = {};
local u3 = { "Teleport Pad", "Big Teleport Pad", "Huge Teleport Pad" };
function v1.Init(_) --[[ Line: 18 ]] end;
function v1.Start(u4) --[[ Line: 21 ]]
    -- upvalues: l__GardenSyncController__3 (copy)
    l__GardenSyncController__3:OnPropAdded(function(p5, p6, p7) --[[ Line: 22 ]]
        -- upvalues: u4 (copy)
        u4:SpawnPropFromData(p5, p6, p7);
    end);
    l__GardenSyncController__3:OnPropRemoved(function(p8, p9) --[[ Line: 26 ]]
        -- upvalues: u4 (copy)
        u4:RemovePropById(p8, p9);
    end);
    l__GardenSyncController__3:OnPropExtraDataUpdated(function(p10, p11, p12) --[[ Line: 30 ]]
        -- upvalues: u4 (copy)
        u4:UpdatePropExtraData(p10, p11, p12);
    end);
end;
function v1.GetPlayerPlot(_, p13) --[[ Line: 35 ]]
    -- upvalues: l__Players__1 (copy), l__Gardens__6 (copy)
    local v14 = l__Players__1:GetPlayerByUserId(p13);
    if v14 then
        local v15 = v14:GetAttribute("PlotId");
        if v15 then
            return l__Gardens__6:FindFirstChild("Plot" .. v15);
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.GetSpawnPoint(p16, p17) --[[ Line: 45 ]]
    local v18 = p16:GetPlayerPlot(p17);
    if v18 then
        return v18:FindFirstChild("SpawnPoint");
    else
        return nil;
    end;
end;
function v1.GetPropsFolder(p19, p20) --[[ Line: 52 ]]
    local v21 = p19:GetPlayerPlot(p20);
    if not v21 then
        return nil;
    end;
    local v22 = v21:FindFirstChild("Props");
    if not v22 then
        v22 = Instance.new("Folder");
        v22.Name = "Props";
        v22.Parent = v21;
    end;
    return v22;
end;
function v1.SpawnPropFromData(p23, p24, p25, p26) --[[ Line: 66 ]]
    -- upvalues: u2 (copy), l__Props__7 (copy), u3 (copy), l__PlacementGrid__4 (copy), l__FakeSeat__5 (copy)
    local v27 = `{p24}_{p25}`;
    if u2[v27] then
        p23:RemovePropById(p24, p25);
    end;
    local v28 = p23:GetSpawnPoint(p24);
    if v28 then
        local v29 = p23:GetPropsFolder(p24);
        if v29 then
            local l__PropName__8 = p26.PropName;
            if l__PropName__8 then
                local v30 = l__Props__7:FindFirstChild(l__PropName__8);
                if v30 then
                    local v31 = v30:Clone();
                    v31.Name = p25;
                    v31:SetAttribute("PropId", p25);
                    v31:SetAttribute("UserId", p24);
                    v31:SetAttribute("PropName", l__PropName__8);
                    v31:SetAttribute("ExtraData", p26.ExtraData or "");
                    if v31:IsA("Model") then
                        for _, v32 in v31:GetDescendants() do
                            if v32:IsA("BasePart") then
                                v32.Anchored = true;
                                if v32.Transparency >= 0.9 and not table.find(u3, l__PropName__8) then
                                    v32.CanQuery = false;
                                end;
                            end;
                        end;
                        if v31.PrimaryPart then
                            v31.PrimaryPart.CanCollide = false;
                        end;
                    elseif v31:IsA("BasePart") then
                        v31.Anchored = true;
                        if v31.Transparency >= 0.9 and not table.find(u3, l__PropName__8) then
                            v31.CanQuery = false;
                        end;
                    end;
                    v31.Parent = v29;
                    local v33 = Vector3.new(p26.Positions.PosX, p26.Positions.PosY, p26.Positions.PosZ);
                    local v34 = p26.Positions.Rotation or 0;
                    local v35 = v28.CFrame:PointToWorldSpace(v33);
                    local v36;
                    if p26.V == 2 then
                        local v37 = l__PlacementGrid__4.GetGardenRotationY(v28);
                        v36 = l__PlacementGrid__4.PositionModel(v31, v35, v37, v34);
                    else
                        local v38 = CFrame.new(Vector3.new(0, 0, 0)) * CFrame.Angles(0, math.rad(v34), 0);
                        local _, v39, _ = v28.CFrame:ToWorldSpace(v38):ToEulerAnglesYXZ();
                        v36 = CFrame.new(v35) * CFrame.Angles(0, v39, 0);
                    end;
                    if v31:IsA("Model") then
                        v31:PivotTo(v36);
                    elseif v31:IsA("BasePart") then
                        v31.CFrame = v36;
                    end;
                    u2[v27] = v31;
                    local v40 = script:FindFirstChild(l__PropName__8, true);
                    if v40 then
                        local _, _ = pcall(require(v40), v31);
                    end;
                    local _, _ = pcall(l__FakeSeat__5, v31);
                end;
            end;
        end;
    end;
end;
function v1.UpdatePropExtraData(p41, p42, p43, p44) --[[ Line: 159 ]]
    local v45 = p41:GetSpawnedProp(p42, p43);
    if v45 then
        v45:SetAttribute("ExtraData", p44 or "1");
    end;
end;
function v1.RemovePropById(_, p46, p47) --[[ Line: 166 ]]
    -- upvalues: u2 (copy)
    local v48 = `{p46}_{p47}`;
    local v49 = u2[v48];
    if v49 then
        v49:Destroy();
        u2[v48] = nil;
    end;
end;
function v1.GetSpawnedProp(_, p50, p51) --[[ Line: 176 ]]
    -- upvalues: u2 (copy)
    return u2[`{p50}_{p51}`];
end;
function v1.GetAllSpawnedProps(_) --[[ Line: 181 ]]
    -- upvalues: u2 (copy)
    return u2;
end;
return v1;