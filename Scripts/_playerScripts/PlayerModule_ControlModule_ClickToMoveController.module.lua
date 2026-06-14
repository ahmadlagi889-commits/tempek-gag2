-- Decompiled with Potassium's decompiler.

local v1, v2 = pcall(function() --[[ Line: 10 ]]
    return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding");
end);
local u3 = v1 and v2;
local v4, v5 = pcall(function() --[[ Line: 14 ]]
    return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2");
end);
local u6 = v4 and v5;
local l__UserInputService__1 = game:GetService("UserInputService");
local l__PathfindingService__2 = game:GetService("PathfindingService");
local l__Players__3 = game:GetService("Players");
game:GetService("Debris");
local l__StarterGui__4 = game:GetService("StarterGui");
local l__Workspace__5 = game:GetService("Workspace");
local l__CollectionService__6 = game:GetService("CollectionService");
local l__GuiService__7 = game:GetService("GuiService");
local l__CommonUtils__8 = script.Parent.Parent:WaitForChild("CommonUtils");
local u7 = require(l__CommonUtils__8:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2");
local u8 = true;
local u9 = true;
local u10 = false;
local u11 = 1;
local u12 = 8;
local u13 = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true
};
local l__LocalPlayer__9 = l__Players__3.LocalPlayer;
local l__ClickToMoveDisplay__10 = require(script.Parent:WaitForChild("ClickToMoveDisplay"));
local u14 = RaycastParams.new();
u14.FilterType = Enum.RaycastFilterType.Exclude;
local u15 = {};
if not u7 then
    local function u18(p16) --[[ Line: 65 ]]
        -- upvalues: u18 (copy)
        if p16 then
            local v17 = p16:FindFirstChildOfClass("Humanoid");
            if v17 then
                return p16, v17;
            else
                return u18(p16.Parent);
            end;
        end;
    end;
    u15.FindCharacterAncestor = u18;
    local function u29(p19, p20, p21) --[[ Line: 77 ]]
        -- upvalues: l__Workspace__5 (copy), u18 (copy), u29 (copy)
        local v22 = p21 or {};
        local v23, v24, v25, v26 = l__Workspace__5:FindPartOnRayWithIgnoreList(p19, v22);
        if not v23 then
            return nil, nil;
        end;
        if p20 and v23.CanCollide == false then
            local v27;
            if v23 then
                v27 = v23:FindFirstChildOfClass("Humanoid");
                if not v27 then
                    local v28;
                    v28, v27 = u18(v23.Parent);
                end;
            else
                v27 = nil;
            end;
            if v27 == nil then
                table.insert(v22, v23);
                return u29(p19, p20, v22);
            end;
        end;
        return v23, v24, v25, v26;
    end;
    u15.Raycast = u29;
end;
local u30 = {};
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = nil;
local function u43(p35) --[[ Line: 127 ]]
    -- upvalues: u32 (ref), u33 (ref), u34 (ref), u31 (ref), l__LocalPlayer__9 (copy), l__CollectionService__6 (copy)
    if p35 == u32 then
    else
        if u33 then
            u33:Disconnect();
            u33 = nil;
        end;
        if u34 then
            u34:Disconnect();
            u34 = nil;
        end;
        u32 = p35;
        local v36 = {};
        local v37 = l__LocalPlayer__9;
        if v37 then
            v37 = l__LocalPlayer__9.Character;
        end;
        v36[1] = v37;
        u31 = v36;
        if u32 ~= nil then
            local v38 = l__CollectionService__6:GetTagged(u32);
            for _, v39 in ipairs(v38) do
                table.insert(u31, v39);
            end;
            u33 = l__CollectionService__6:GetInstanceAddedSignal(u32):Connect(function(p40) --[[ Line: 147 ]]
                -- upvalues: u31 (ref)
                table.insert(u31, p40);
            end);
            u34 = l__CollectionService__6:GetInstanceRemovedSignal(u32):Connect(function(p41) --[[ Line: 151 ]]
                -- upvalues: u31 (ref)
                for v42 = 1, #u31 do
                    if u31[v42] == p41 then
                        u31[v42] = u31[#u31];
                        table.remove(u31);
                        return;
                    end;
                end;
            end);
        end;
    end;
end;
local function u61(p44) --[[ Line: 179 ]]
    if p44 == nil or p44.PrimaryPart == nil then
    else
        assert(p44, "");
        assert(p44.PrimaryPart, "");
        local v45 = p44.PrimaryPart.CFrame:Inverse();
        local v46 = Vector3.new(inf, inf, inf);
        local v47 = Vector3.new(-inf, -inf, -inf);
        for _, v48 in pairs(p44:GetDescendants()) do
            if v48:IsA("BasePart") and v48.CanCollide then
                local v49 = v45 * v48.CFrame;
                local v50 = Vector3.new(v48.Size.X / 2, v48.Size.Y / 2, v48.Size.Z / 2);
                local v51 = {
                    Vector3.new(v50.X, v50.Y, v50.Z),
                    Vector3.new(v50.X, v50.Y, -v50.Z),
                    Vector3.new(v50.X, -v50.Y, v50.Z),
                    Vector3.new(v50.X, -v50.Y, -v50.Z),
                    Vector3.new(-v50.X, v50.Y, v50.Z),
                    Vector3.new(-v50.X, v50.Y, -v50.Z),
                    Vector3.new(-v50.X, -v50.Y, v50.Z),
                    (Vector3.new(-v50.X, -v50.Y, -v50.Z))
                };
                for _, v52 in ipairs(v51) do
                    local v53 = v49 * v52;
                    local v54 = math.min(v46.X, v53.X);
                    local v55 = math.min(v46.Y, v53.Y);
                    local v56 = math.min(v46.Z, v53.Z);
                    v46 = Vector3.new(v54, v55, v56);
                    local v57 = math.max(v47.X, v53.X);
                    local v58 = math.max(v47.Y, v53.Y);
                    local v59 = math.max(v47.Z, v53.Z);
                    v47 = Vector3.new(v57, v58, v59);
                end;
            end;
        end;
        local v60 = v47 - v46;
        if v60.X < 0 or (v60.Y < 0 or v60.Z < 0) then
            return nil;
        else
            return v60;
        end;
    end;
end;
local function u118(p62, p63, p64) --[[ Line: 214 ]]
    -- upvalues: u10 (ref), l__LocalPlayer__9 (copy), u30 (copy), u11 (ref), u3 (copy), u61 (copy), u6 (copy), l__PathfindingService__2 (copy), u8 (ref), l__ClickToMoveDisplay__10 (copy), u12 (ref), u7 (copy), u14 (copy), u31 (ref), l__Workspace__5 (copy)
    local u65 = {};
    local v66;
    if p64 == nil then
        v66 = u10;
        p64 = true;
    else
        v66 = p64;
    end;
    u65.Cancelled = false;
    u65.Started = false;
    u65.Finished = Instance.new("BindableEvent");
    u65.PathFailed = Instance.new("BindableEvent");
    u65.PathComputing = false;
    u65.PathComputed = false;
    u65.OriginalTargetPoint = p62;
    u65.TargetPoint = p62;
    u65.TargetSurfaceNormal = p63;
    u65.DiedConn = nil;
    u65.SeatedConn = nil;
    u65.BlockedConn = nil;
    u65.TeleportedConn = nil;
    u65.CurrentPoint = 0;
    u65.HumanoidOffsetFromPath = Vector3.new(0, 0, 0);
    u65.CurrentWaypointPosition = nil;
    u65.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
    u65.CurrentWaypointPlaneDistance = 0;
    u65.CurrentWaypointNeedsJump = false;
    u65.CurrentHumanoidPosition = Vector3.new(0, 0, 0);
    u65.CurrentHumanoidVelocity = 0;
    u65.NextActionMoveDirection = Vector3.new(0, 0, 0);
    u65.NextActionJump = false;
    u65.Timeout = 0;
    local v67 = l__LocalPlayer__9;
    local v68;
    if v67 then
        v68 = v67.Character;
    else
        v68 = v67;
    end;
    local v69;
    if v68 then
        v69 = u30[v67];
        if not v69 or v69.Parent ~= v68 then
            u30[v67] = nil;
            v69 = v68:FindFirstChildOfClass("Humanoid");
            if v69 then
                u30[v67] = v69;
            end;
        end;
    else
        v69 = nil;
    end;
    u65.Humanoid = v69;
    u65.OriginPoint = nil;
    u65.AgentCanFollowPath = false;
    u65.DirectPath = false;
    u65.DirectPathRiseFirst = false;
    u65.stopTraverseFunc = nil;
    u65.setPointFunc = nil;
    u65.pointList = nil;
    local l__Humanoid__11 = u65.Humanoid;
    if l__Humanoid__11 then
        l__Humanoid__11 = u65.Humanoid.RootPart;
    end;
    if l__Humanoid__11 then
        u65.OriginPoint = l__Humanoid__11.CFrame.Position;
        local v70 = 2;
        local v71 = 5;
        local v72 = true;
        local l__SeatPart__12 = u65.Humanoid.SeatPart;
        if l__SeatPart__12 and l__SeatPart__12:IsA("VehicleSeat") then
            local v73 = l__SeatPart__12:FindFirstAncestorOfClass("Model");
            if v73 then
                local l__PrimaryPart__13 = v73.PrimaryPart;
                v73.PrimaryPart = l__SeatPart__12;
                if p64 then
                    local v74 = v73:GetExtentsSize();
                    v70 = u11 * 0.5 * math.sqrt(v74.X * v74.X + v74.Z * v74.Z);
                    v71 = u11 * v74.Y;
                    u65.AgentCanFollowPath = true;
                    u65.DirectPath = p64;
                    v72 = false;
                end;
                v73.PrimaryPart = l__PrimaryPart__13;
            end;
        else
            local v75 = nil;
            if u3 then
                local v76 = l__LocalPlayer__9;
                if v76 then
                    v76 = l__LocalPlayer__9.Character;
                end;
                if v76 ~= nil then
                    v75 = u61(v76);
                end;
            end;
            if v75 == nil then
                local v77 = l__LocalPlayer__9;
                if v77 then
                    v77 = l__LocalPlayer__9.Character;
                end;
                v75 = v77:GetExtentsSize();
            end;
            assert(v75, "");
            v70 = u11 * 0.5 * math.sqrt(v75.X * v75.X + v75.Z * v75.Z);
            v71 = u11 * v75.Y;
            v72 = u65.Humanoid.JumpPower > 0;
            u65.AgentCanFollowPath = true;
            u65.DirectPath = v66;
            u65.DirectPathRiseFirst = u65.Humanoid.Sit;
        end;
        if u6 then
            u65.pathResult = l__PathfindingService__2:CreatePath({
                AgentCanClimb = true,
                AgentRadius = v70,
                AgentHeight = v71,
                AgentCanJump = v72
            });
        else
            u65.pathResult = l__PathfindingService__2:CreatePath({
                AgentRadius = v70,
                AgentHeight = v71,
                AgentCanJump = v72
            });
        end;
    end;
    function u65.Cleanup(_) --[[ Line: 332 ]]
        -- upvalues: u65 (copy)
        if u65.stopTraverseFunc then
            u65.stopTraverseFunc();
            u65.stopTraverseFunc = nil;
        end;
        if u65.BlockedConn then
            u65.BlockedConn:Disconnect();
            u65.BlockedConn = nil;
        end;
        if u65.DiedConn then
            u65.DiedConn:Disconnect();
            u65.DiedConn = nil;
        end;
        if u65.SeatedConn then
            u65.SeatedConn:Disconnect();
            u65.SeatedConn = nil;
        end;
        if u65.TeleportedConn then
            u65.TeleportedConn:Disconnect();
            u65.TeleportedConn = nil;
        end;
        u65.Started = false;
    end;
    function u65.Cancel(_) --[[ Line: 361 ]]
        -- upvalues: u65 (copy)
        u65.Cancelled = true;
        u65:Cleanup();
    end;
    function u65.IsActive(_) --[[ Line: 366 ]]
        -- upvalues: u65 (copy)
        local v78 = u65.AgentCanFollowPath and u65.Started;
        if v78 then
            v78 = not u65.Cancelled;
        end;
        return v78;
    end;
    function u65.OnPathInterrupted(_) --[[ Line: 370 ]]
        -- upvalues: u65 (copy)
        u65.Cancelled = true;
        u65:OnPointReached(false);
    end;
    function u65.ComputePath(_) --[[ Line: 376 ]]
        -- upvalues: u65 (copy)
        if u65.OriginPoint then
            if u65.PathComputed or u65.PathComputing then
                return;
            end;
            u65.PathComputing = true;
            if u65.AgentCanFollowPath then
                if u65.DirectPath then
                    u65.pointList = { PathWaypoint.new(u65.OriginPoint, Enum.PathWaypointAction.Walk), PathWaypoint.new(u65.TargetPoint, u65.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk) };
                    u65.PathComputed = true;
                else
                    u65.pathResult:ComputeAsync(u65.OriginPoint, u65.TargetPoint);
                    u65.pointList = u65.pathResult:GetWaypoints();
                    u65.BlockedConn = u65.pathResult.Blocked:Connect(function(p79) --[[ Line: 390 ]]
                        -- upvalues: u65 (ref)
                        u65:OnPathBlocked(p79);
                    end);
                    u65.PathComputed = u65.pathResult.Status == Enum.PathStatus.Success;
                end;
            end;
            u65.PathComputing = false;
        end;
    end;
    function u65.IsValidPath(_) --[[ Line: 398 ]]
        -- upvalues: u65 (copy)
        u65:ComputePath();
        local l__PathComputed__14 = u65.PathComputed;
        if l__PathComputed__14 then
            l__PathComputed__14 = u65.AgentCanFollowPath;
        end;
        return l__PathComputed__14;
    end;
    u65.Recomputing = false;
    function u65.OnPathBlocked(_, p80) --[[ Line: 404 ]]
        -- upvalues: u65 (copy), u8 (ref), l__ClickToMoveDisplay__10 (ref)
        if u65.CurrentPoint <= p80 and not u65.Recomputing then
            u65.Recomputing = true;
            if u65.stopTraverseFunc then
                u65.stopTraverseFunc();
                u65.stopTraverseFunc = nil;
            end;
            u65.OriginPoint = u65.Humanoid.RootPart.CFrame.p;
            u65.pathResult:ComputeAsync(u65.OriginPoint, u65.TargetPoint);
            u65.pointList = u65.pathResult:GetWaypoints();
            if #u65.pointList > 0 then
                u65.HumanoidOffsetFromPath = u65.pointList[1].Position - u65.OriginPoint;
            end;
            u65.PathComputed = u65.pathResult.Status == Enum.PathStatus.Success;
            if u8 then
                local v81 = u65;
                local v82 = u65;
                local v83, v84 = l__ClickToMoveDisplay__10.CreatePathDisplay(u65.pointList);
                v81.stopTraverseFunc = v83;
                v82.setPointFunc = v84;
            end;
            if u65.PathComputed then
                u65.CurrentPoint = 1;
                u65:OnPointReached(true);
            else
                u65.PathFailed:Fire();
                u65:Cleanup();
            end;
            u65.Recomputing = false;
        end;
    end;
    function u65.OnRenderStepped(_, p85) --[[ Line: 440 ]]
        -- upvalues: u65 (copy), u12 (ref)
        if u65.Started and not u65.Cancelled then
            u65.Timeout = u65.Timeout + p85;
            if u12 < u65.Timeout then
                u65:OnPointReached(false);
                return;
            end;
            u65.CurrentHumanoidPosition = u65.Humanoid.RootPart.Position + u65.HumanoidOffsetFromPath;
            u65.CurrentHumanoidVelocity = u65.Humanoid.RootPart.Velocity;
            while u65.Started and u65:IsCurrentWaypointReached() do
                u65:OnPointReached(true);
            end;
            if u65.Started then
                u65.NextActionMoveDirection = u65.CurrentWaypointPosition - u65.CurrentHumanoidPosition;
                if u65.NextActionMoveDirection.Magnitude > 1e-6 then
                    u65.NextActionMoveDirection = u65.NextActionMoveDirection.Unit;
                else
                    u65.NextActionMoveDirection = Vector3.new(0, 0, 0);
                end;
                if u65.CurrentWaypointNeedsJump then
                    u65.NextActionJump = true;
                    u65.CurrentWaypointNeedsJump = false;
                    return;
                end;
                u65.NextActionJump = false;
            end;
        end;
    end;
    function u65.IsCurrentWaypointReached(_) --[[ Line: 478 ]]
        -- upvalues: u65 (copy)
        local v86;
        if u65.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) then
            v86 = true;
        else
            local v87 = u65.CurrentWaypointPlaneNormal:Dot(u65.CurrentHumanoidPosition) - u65.CurrentWaypointPlaneDistance;
            local v88 = 0.0625 * -u65.CurrentWaypointPlaneNormal:Dot(u65.CurrentHumanoidVelocity);
            v86 = v87 < math.max(1, v88);
        end;
        if v86 then
            u65.CurrentWaypointPosition = nil;
            u65.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
            u65.CurrentWaypointPlaneDistance = 0;
        end;
        return v86;
    end;
    function u65.OnPointReached(_, p89) --[[ Line: 504 ]]
        -- upvalues: u65 (copy)
        if p89 and not u65.Cancelled then
            if u65.setPointFunc then
                u65.setPointFunc(u65.CurrentPoint);
            end;
            local v90 = u65.CurrentPoint + 1;
            if #u65.pointList < v90 then
                if u65.stopTraverseFunc then
                    u65.stopTraverseFunc();
                end;
                u65.Finished:Fire();
                u65:Cleanup();
            else
                local v91 = u65.pointList[u65.CurrentPoint];
                local v92 = u65.pointList[v90];
                local v93 = u65.Humanoid:GetState();
                if (v93 == Enum.HumanoidStateType.FallingDown or v93 == Enum.HumanoidStateType.Freefall) and true or v93 == Enum.HumanoidStateType.Jumping then
                    local v94 = v92.Action == Enum.PathWaypointAction.Jump;
                    if not v94 and u65.CurrentPoint > 1 then
                        local v95 = v91.Position - u65.pointList[u65.CurrentPoint - 1].Position;
                        local v96 = v92.Position - v91.Position;
                        v94 = Vector2.new(v95.x, v95.z).Unit:Dot(Vector2.new(v96.x, v96.z).Unit) < 0.996;
                    end;
                    if v94 then
                        u65.Humanoid.FreeFalling:Wait();
                        wait(0.1);
                    end;
                end;
                u65:MoveToNextWayPoint(v91, v92, v90);
            end;
        else
            u65.PathFailed:Fire();
            u65:Cleanup();
        end;
    end;
    function u65.MoveToNextWayPoint(_, p97, p98, p99) --[[ Line: 567 ]]
        -- upvalues: u65 (copy), u6 (ref)
        u65.CurrentWaypointPlaneNormal = p97.Position - p98.Position;
        if not u6 or p98.Label ~= "Climb" then
            u65.CurrentWaypointPlaneNormal = Vector3.new(u65.CurrentWaypointPlaneNormal.X, 0, u65.CurrentWaypointPlaneNormal.Z);
        end;
        if u65.CurrentWaypointPlaneNormal.Magnitude > 1e-6 then
            u65.CurrentWaypointPlaneNormal = u65.CurrentWaypointPlaneNormal.Unit;
            u65.CurrentWaypointPlaneDistance = u65.CurrentWaypointPlaneNormal:Dot(p98.Position);
        else
            u65.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
            u65.CurrentWaypointPlaneDistance = 0;
        end;
        u65.CurrentWaypointNeedsJump = p98.Action == Enum.PathWaypointAction.Jump;
        u65.CurrentWaypointPosition = p98.Position;
        u65.CurrentPoint = p99;
        u65.Timeout = 0;
    end;
    function u65.Start(_, p100) --[[ Line: 599 ]]
        -- upvalues: u65 (copy), l__ClickToMoveDisplay__10 (ref), u8 (ref)
        if u65.AgentCanFollowPath then
            if u65.Started then
            else
                u65.Started = true;
                l__ClickToMoveDisplay__10.CancelFailureAnimation();
                if u8 and (p100 == nil or p100) then
                    local v101 = u65;
                    local v102 = u65;
                    local v103, v104 = l__ClickToMoveDisplay__10.CreatePathDisplay(u65.pointList, u65.OriginalTargetPoint);
                    v101.stopTraverseFunc = v103;
                    v102.setPointFunc = v104;
                end;
                if #u65.pointList > 0 then
                    u65.HumanoidOffsetFromPath = Vector3.new(0, u65.pointList[1].Position.Y - u65.OriginPoint.Y, 0);
                    u65.CurrentHumanoidPosition = u65.Humanoid.RootPart.Position + u65.HumanoidOffsetFromPath;
                    u65.CurrentHumanoidVelocity = u65.Humanoid.RootPart.Velocity;
                    u65.SeatedConn = u65.Humanoid.Seated:Connect(function(_, _) --[[ Line: 626 ]]
                        -- upvalues: u65 (ref)
                        u65:OnPathInterrupted();
                    end);
                    u65.DiedConn = u65.Humanoid.Died:Connect(function() --[[ Line: 627 ]]
                        -- upvalues: u65 (ref)
                        u65:OnPathInterrupted();
                    end);
                    u65.TeleportedConn = u65.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function() --[[ Line: 628 ]]
                        -- upvalues: u65 (ref)
                        u65:OnPathInterrupted();
                    end);
                    u65.CurrentPoint = 1;
                    u65:OnPointReached(true);
                else
                    u65.PathFailed:Fire();
                    if u65.stopTraverseFunc then
                        u65.stopTraverseFunc();
                    end;
                end;
            end;
        else
            u65.PathFailed:Fire();
        end;
    end;
    local v105 = u65.TargetPoint + u65.TargetSurfaceNormal * 1.5;
    if u7 then
        local v106 = u14;
        local v107;
        if u31 then
            v107 = u31;
        else
            u31 = {};
            assert(u31, "");
            local v108 = u31;
            local v109 = l__LocalPlayer__9;
            if v109 then
                v109 = l__LocalPlayer__9.Character;
            end;
            table.insert(v108, v109);
            v107 = u31;
        end;
        v106.FilterDescendantsInstances = v107;
        local v110 = l__Workspace__5:Raycast(v105, Vector3.new(-0, -50, -0), u14);
        if v110 then
            u65.TargetPoint = v110.Position;
        end;
    else
        local v111 = Ray.new(v105, Vector3.new(0, -50, 0));
        local v112 = l__Workspace__5;
        local v113;
        if u31 then
            v113 = u31;
        else
            u31 = {};
            assert(u31, "");
            local v114 = u31;
            local v115 = l__LocalPlayer__9;
            if v115 then
                v115 = l__LocalPlayer__9.Character;
            end;
            table.insert(v114, v115);
            v113 = u31;
        end;
        local v116, v117 = v112:FindPartOnRayWithIgnoreList(v111, v113);
        if v116 then
            u65.TargetPoint = v117;
        end;
    end;
    u65:ComputePath();
    return u65;
end;
local function u121(p119) --[[ Line: 669 ]]
    if p119 ~= nil then
        for _, v120 in pairs(p119:GetChildren()) do
            if v120:IsA("Tool") then
                return v120;
            end;
        end;
    end;
end;
local u122 = nil;
local u123 = nil;
local u124 = nil;
local function u133(p125, u126, u127, u128, u129) --[[ Line: 702 ]]
    -- upvalues: u122 (ref), u123 (ref), u124 (ref), u121 (copy), u9 (ref), l__ClickToMoveDisplay__10 (copy)
    if u122 then
        if u122 then
            u122:Cancel();
            u122 = nil;
        end;
        if u123 then
            u123:Disconnect();
            u123 = nil;
        end;
        if u124 then
            u124:Disconnect();
            u124 = nil;
        end;
    end;
    u122 = p125;
    p125:Start(u129);
    u123 = p125.Finished.Event:Connect(function() --[[ Line: 709 ]]
        -- upvalues: u122 (ref), u123 (ref), u124 (ref), u127 (copy), u121 (ref), u128 (copy)
        if u122 then
            u122:Cancel();
            u122 = nil;
        end;
        if u123 then
            u123:Disconnect();
            u123 = nil;
        end;
        if u124 then
            u124:Disconnect();
            u124 = nil;
        end;
        local v130 = u127 and u121(u128);
        if v130 then
            v130:Activate();
        end;
    end);
    u124 = p125.PathFailed.Event:Connect(function() --[[ Line: 718 ]]
        -- upvalues: u122 (ref), u123 (ref), u124 (ref), u129 (copy), u9 (ref), l__ClickToMoveDisplay__10 (ref), u126 (copy)
        if u122 then
            u122:Cancel();
            u122 = nil;
        end;
        if u123 then
            u123:Disconnect();
            u123 = nil;
        end;
        if u124 then
            u124:Disconnect();
            u124 = nil;
        end;
        if u129 == nil or u129 then
            local v131 = u9;
            if v131 then
                local v132 = u122;
                if v132 then
                    v132 = u122:IsActive();
                end;
                v131 = not v132;
            end;
            if v131 then
                l__ClickToMoveDisplay__10.PlayFailureAnimation();
            end;
            l__ClickToMoveDisplay__10.DisplayFailureWaypoint(u126);
        end;
    end);
end;
function OnTap(p134, p135, p136)
    -- upvalues: l__Workspace__5 (copy), l__LocalPlayer__9 (copy), u30 (copy), u7 (copy), u31 (ref), u14 (copy), l__StarterGui__4 (copy), l__Players__3 (copy), u122 (ref), u123 (ref), u124 (ref), u118 (copy), u133 (copy), u9 (ref), l__ClickToMoveDisplay__10 (copy), u15 (copy), u121 (copy)
    local l__CurrentCamera__15 = l__Workspace__5.CurrentCamera;
    local l__Character__16 = l__LocalPlayer__9.Character;
    local v137 = l__LocalPlayer__9;
    local v138;
    if v137 then
        v138 = v137.Character;
    else
        v138 = v137;
    end;
    local v139;
    if v138 then
        v139 = u30[v137];
        if not v139 or v139.Parent ~= v138 then
            u30[v137] = nil;
            v139 = v138:FindFirstChildOfClass("Humanoid");
            if v139 then
                u30[v137] = v139;
            end;
        end;
    else
        v139 = nil;
    end;
    local v140;
    if v139 == nil then
        v140 = false;
    else
        v140 = v139.Health > 0;
    end;
    if not v140 then
        return;
    end;
    if #p134 ~= 1 and not p135 then
        local v141 = #p134 >= 2 and (l__CurrentCamera__15 and u121(l__Character__16));
        if v141 then
            v141:Activate();
        end;
        return;
    end;
    if not l__CurrentCamera__15 then
        return;
    end;
    local v142 = l__CurrentCamera__15:ScreenPointToRay(p134[1].X, p134[1].Y);
    if not u7 then
        local v143 = Ray.new(v142.Origin, v142.Direction * 1000);
        local l__Raycast__17 = u15.Raycast;
        local v144 = true;
        local v145;
        if u31 then
            v145 = u31;
        else
            u31 = {};
            assert(u31, "");
            local v146 = u31;
            local v147 = l__LocalPlayer__9;
            if v147 then
                v147 = l__LocalPlayer__9.Character;
            end;
            table.insert(v146, v147);
            v145 = u31;
        end;
        local v148, v149, v150 = l__Raycast__17(v143, v144, v145);
        local v151, v152 = u15.FindCharacterAncestor(v148);
        if p136 and (v152 and (l__StarterGui__4:GetCore("AvatarContextMenuEnabled") and l__Players__3:GetPlayerFromCharacter(v152.Parent))) then
            if u122 then
                u122:Cancel();
                u122 = nil;
            end;
            if u123 then
                u123:Disconnect();
                u123 = nil;
            end;
            if u124 then
                u124:Disconnect();
                u124 = nil;
            end;
            return;
        end;
        if p135 then
            v151 = nil;
        else
            p135 = v149;
        end;
        if p135 and l__Character__16 then
            if u122 then
                u122:Cancel();
                u122 = nil;
            end;
            if u123 then
                u123:Disconnect();
                u123 = nil;
            end;
            if u124 then
                u124:Disconnect();
                u124 = nil;
            end;
            local v153 = u118(p135, v150);
            if v153:IsValidPath() then
                u133(v153, p135, v151, l__Character__16);
                return;
            else
                v153:Cleanup();
                if u122 and u122:IsActive() then
                    u122:Cancel();
                end;
                if u9 then
                    l__ClickToMoveDisplay__10.PlayFailureAnimation();
                end;
                l__ClickToMoveDisplay__10.DisplayFailureWaypoint(p135);
                return;
            end;
        end;
        return;
    end;
    local v154 = nil;
    local v155 = nil;
    local v156;
    if u31 then
        v156 = u31;
    else
        u31 = {};
        assert(u31, "");
        local v157 = u31;
        local v158 = l__LocalPlayer__9;
        if v158 then
            v158 = l__LocalPlayer__9.Character;
        end;
        table.insert(v157, v158);
        v156 = u31;
    end;
    if not v156 then
        v156 = {};
    end;
    while true do
        local v159 = true;
        u14.FilterDescendantsInstances = v156;
        local v160 = l__Workspace__5:Raycast(v142.Origin, v142.Direction * 1000, u14);
        local v161, v162;
        if v160 then
            local l__Instance__18 = v160.Instance;
            if not l__Instance__18.CanCollide then
                local v163;
                while true do
                    v154 = l__Instance__18:FindFirstChildOfClass("Humanoid");
                    v163 = l__Instance__18.Parent;
                    if v154 or not v163 then
                        break;
                    end;
                    l__Instance__18 = v163;
                end;
                if v154 or not v163 then
                    v155 = l__Instance__18;
                else
                    table.insert(v156, v163);
                    v159 = false;
                    v155 = nil;
                end;
                if v159 then
                    if p136 and (v154 and (l__StarterGui__4:GetCore("AvatarContextMenuEnabled") and l__Players__3:GetPlayerFromCharacter(v154.Parent))) then
                        if u122 then
                            u122:Cancel();
                            u122 = nil;
                        end;
                        if u123 then
                            u123:Disconnect();
                            u123 = nil;
                        end;
                        if u124 then
                            u124:Disconnect();
                            u124 = nil;
                        end;
                        return;
                    elseif v160 and l__Character__16 then
                        v161 = v160.Position;
                        if p135 then
                            v155 = nil;
                        else
                            p135 = v161;
                        end;
                        if u122 then
                            u122:Cancel();
                            u122 = nil;
                        end;
                        if u123 then
                            u123:Disconnect();
                            u123 = nil;
                        end;
                        if u124 then
                            u124:Disconnect();
                            u124 = nil;
                        end;
                        v162 = u118(p135, v160.Normal);
                        if v162:IsValidPath() then
                            u133(v162, p135, v155, l__Character__16);
                            return;
                        else
                            v162:Cleanup();
                            if u122 and u122:IsActive() then
                                u122:Cancel();
                            end;
                            if u9 then
                                l__ClickToMoveDisplay__10.PlayFailureAnimation();
                            end;
                            l__ClickToMoveDisplay__10.DisplayFailureWaypoint(p135);
                            return;
                        end;
                    else
                        return;
                    end;
                end;
            end;
        end;
        if v159 then
            if p136 and (v154 and (l__StarterGui__4:GetCore("AvatarContextMenuEnabled") and l__Players__3:GetPlayerFromCharacter(v154.Parent))) then
                if u122 then
                    u122:Cancel();
                    u122 = nil;
                end;
                if u123 then
                    u123:Disconnect();
                    u123 = nil;
                end;
                if u124 then
                    u124:Disconnect();
                    u124 = nil;
                end;
                return;
            elseif v160 and l__Character__16 then
                v161 = v160.Position;
                if p135 then
                    v155 = nil;
                else
                    p135 = v161;
                end;
                if u122 then
                    u122:Cancel();
                    u122 = nil;
                end;
                if u123 then
                    u123:Disconnect();
                    u123 = nil;
                end;
                if u124 then
                    u124:Disconnect();
                    u124 = nil;
                end;
                v162 = u118(p135, v160.Normal);
                if v162:IsValidPath() then
                    u133(v162, p135, v155, l__Character__16);
                    return;
                else
                    v162:Cleanup();
                    if u122 and u122:IsActive() then
                        u122:Cancel();
                    end;
                    if u9 then
                        l__ClickToMoveDisplay__10.PlayFailureAnimation();
                    end;
                    l__ClickToMoveDisplay__10.DisplayFailureWaypoint(p135);
                    return;
                end;
            else
                return;
            end;
        end;
    end;
end;
local l__Keyboard__19 = require(script.Parent:WaitForChild("Keyboard"));
local u164 = setmetatable({}, l__Keyboard__19);
u164.__index = u164;
function u164.new(p165) --[[ Line: 861 ]]
    -- upvalues: l__Keyboard__19 (copy), u164 (copy)
    local v166 = l__Keyboard__19.new(p165);
    local v167 = setmetatable(v166, u164);
    v167.fingerTouches = {};
    v167.numUnsunkTouches = 0;
    v167.mouse2DownTime = tick();
    v167.mouse2DownPos = Vector2.new();
    v167.mouse2UpTime = tick();
    v167.keyboardMoveVector = Vector3.new(0, 0, 0);
    v167.tapConn = nil;
    v167.inputBeganConn = nil;
    v167.inputChangedConn = nil;
    v167.inputEndedConn = nil;
    v167.humanoidDiedConn = nil;
    v167.characterChildAddedConn = nil;
    v167.onCharacterAddedConn = nil;
    v167.characterChildRemovedConn = nil;
    v167.renderSteppedConn = nil;
    v167.menuOpenedConnection = nil;
    v167.preferredInputChangedConnection = nil;
    v167.running = false;
    v167.wasdEnabled = false;
    return v167;
end;
function u164.DisconnectEvents(p168) --[[ Line: 892 ]]
    local l__tapConn__20 = p168.tapConn;
    if l__tapConn__20 then
        l__tapConn__20:Disconnect();
    end;
    local l__inputBeganConn__21 = p168.inputBeganConn;
    if l__inputBeganConn__21 then
        l__inputBeganConn__21:Disconnect();
    end;
    local l__inputChangedConn__22 = p168.inputChangedConn;
    if l__inputChangedConn__22 then
        l__inputChangedConn__22:Disconnect();
    end;
    local l__inputEndedConn__23 = p168.inputEndedConn;
    if l__inputEndedConn__23 then
        l__inputEndedConn__23:Disconnect();
    end;
    local l__humanoidDiedConn__24 = p168.humanoidDiedConn;
    if l__humanoidDiedConn__24 then
        l__humanoidDiedConn__24:Disconnect();
    end;
    local l__characterChildAddedConn__25 = p168.characterChildAddedConn;
    if l__characterChildAddedConn__25 then
        l__characterChildAddedConn__25:Disconnect();
    end;
    local l__onCharacterAddedConn__26 = p168.onCharacterAddedConn;
    if l__onCharacterAddedConn__26 then
        l__onCharacterAddedConn__26:Disconnect();
    end;
    local l__renderSteppedConn__27 = p168.renderSteppedConn;
    if l__renderSteppedConn__27 then
        l__renderSteppedConn__27:Disconnect();
    end;
    local l__characterChildRemovedConn__28 = p168.characterChildRemovedConn;
    if l__characterChildRemovedConn__28 then
        l__characterChildRemovedConn__28:Disconnect();
    end;
    local l__menuOpenedConnection__29 = p168.menuOpenedConnection;
    if l__menuOpenedConnection__29 then
        l__menuOpenedConnection__29:Disconnect();
    end;
    local l__preferredInputChangedConnection__30 = p168.preferredInputChangedConnection;
    if l__preferredInputChangedConnection__30 then
        l__preferredInputChangedConnection__30:Disconnect();
    end;
end;
function u164.OnTouchBegan(p169, p170, p171) --[[ Line: 906 ]]
    if p169.fingerTouches[p170] == nil and not p171 then
        p169.numUnsunkTouches = p169.numUnsunkTouches + 1;
    end;
    p169.fingerTouches[p170] = p171;
end;
function u164.OnTouchChanged(p172, p173, p174) --[[ Line: 913 ]]
    if p172.fingerTouches[p173] == nil then
        p172.fingerTouches[p173] = p174;
        if not p174 then
            p172.numUnsunkTouches = p172.numUnsunkTouches + 1;
        end;
    end;
end;
function u164.OnTouchEnded(p175, p176, _) --[[ Line: 922 ]]
    if p175.fingerTouches[p176] ~= nil and p175.fingerTouches[p176] == false then
        p175.numUnsunkTouches = p175.numUnsunkTouches - 1;
    end;
    p175.fingerTouches[p176] = nil;
end;
function u164.OnPreferredInputChanged(_) --[[ Line: 929 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__UserInputService__1 (copy)
    local l__Character__31 = l__LocalPlayer__9.Character;
    if l__Character__31 then
        local v177 = l__UserInputService__1.PreferredInput == Enum.PreferredInput.Touch;
        for _, v178 in pairs(l__Character__31:GetChildren()) do
            if v178:IsA("Tool") then
                v178.ManualActivationOnly = v177;
            end;
        end;
    end;
end;
function u164.OnCharacterAdded(u179, p180) --[[ Line: 941 ]]
    -- upvalues: l__UserInputService__1 (copy), u13 (copy), u122 (ref), u123 (ref), u124 (ref), l__ClickToMoveDisplay__10 (copy), l__GuiService__7 (copy)
    u179:DisconnectEvents();
    u179.inputBeganConn = l__UserInputService__1.InputBegan:Connect(function(p181, p182) --[[ Line: 944 ]]
        -- upvalues: u179 (copy), u13 (ref), u122 (ref), u123 (ref), u124 (ref), l__ClickToMoveDisplay__10 (ref)
        if p181.UserInputType == Enum.UserInputType.Touch then
            u179:OnTouchBegan(p181, p182);
        end;
        if u179.wasdEnabled and (p182 == false and (p181.UserInputType == Enum.UserInputType.Keyboard and u13[p181.KeyCode])) then
            if u122 then
                u122:Cancel();
                u122 = nil;
            end;
            if u123 then
                u123:Disconnect();
                u123 = nil;
            end;
            if u124 then
                u124:Disconnect();
                u124 = nil;
            end;
            l__ClickToMoveDisplay__10.CancelFailureAnimation();
        end;
        if p181.UserInputType == Enum.UserInputType.MouseButton2 then
            u179.mouse2DownTime = tick();
            u179.mouse2DownPos = p181.Position;
        end;
    end);
    u179.inputChangedConn = l__UserInputService__1.InputChanged:Connect(function(p183, p184) --[[ Line: 961 ]]
        -- upvalues: u179 (copy)
        if p183.UserInputType == Enum.UserInputType.Touch then
            u179:OnTouchChanged(p183, p184);
        end;
    end);
    u179.inputEndedConn = l__UserInputService__1.InputEnded:Connect(function(p185, p186) --[[ Line: 967 ]]
        -- upvalues: u179 (copy), u122 (ref)
        if p185.UserInputType == Enum.UserInputType.Touch then
            u179:OnTouchEnded(p185, p186);
        end;
        if p185.UserInputType == Enum.UserInputType.MouseButton2 then
            u179.mouse2UpTime = tick();
            local l__Position__32 = p185.Position;
            if u179.mouse2UpTime - u179.mouse2DownTime < 0.25 and ((l__Position__32 - u179.mouse2DownPos).magnitude < 5 and (u122 or u179.keyboardMoveVector.Magnitude <= 0)) then
                OnTap({ l__Position__32 });
            end;
        end;
    end);
    u179.tapConn = l__UserInputService__1.TouchTap:Connect(function(p187, p188) --[[ Line: 984 ]]
        if not p188 then
            OnTap(p187, nil, true);
        end;
    end);
    u179.menuOpenedConnection = l__GuiService__7.MenuOpened:Connect(function() --[[ Line: 990 ]]
        -- upvalues: u122 (ref), u123 (ref), u124 (ref)
        if u122 then
            u122:Cancel();
            u122 = nil;
        end;
        if u123 then
            u123:Disconnect();
            u123 = nil;
        end;
        if u124 then
            u124:Disconnect();
            u124 = nil;
        end;
    end);
    local function u190(p189) --[[ Line: 994 ]]
        -- upvalues: l__UserInputService__1 (ref), u179 (copy)
        if l__UserInputService__1.PreferredInput == Enum.PreferredInput.Touch and p189:IsA("Tool") then
            p189.ManualActivationOnly = true;
        end;
        if p189:IsA("Humanoid") then
            local l__humanoidDiedConn__33 = u179.humanoidDiedConn;
            if l__humanoidDiedConn__33 then
                l__humanoidDiedConn__33:Disconnect();
            end;
            u179.humanoidDiedConn = p189.Died:Connect(function() --[[ Line: 1002 ]] end);
        end;
    end;
    u179.characterChildAddedConn = p180.ChildAdded:Connect(function(p191) --[[ Line: 1010 ]]
        -- upvalues: u190 (copy)
        u190(p191);
    end);
    u179.characterChildRemovedConn = p180.ChildRemoved:Connect(function(p192) --[[ Line: 1013 ]]
        -- upvalues: l__UserInputService__1 (ref)
        if l__UserInputService__1.PreferredInput == Enum.PreferredInput.Touch and p192:IsA("Tool") then
            p192.ManualActivationOnly = false;
        end;
    end);
    for _, v193 in pairs(p180:GetChildren()) do
        u190(v193);
    end;
    u179.preferredInputChangedConnection = l__UserInputService__1:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 1024 ]]
        -- upvalues: u179 (copy)
        u179:OnPreferredInputChanged();
    end);
end;
function u164.Start(p194) --[[ Line: 1029 ]]
    p194:Enable(true);
end;
function u164.Stop(p195) --[[ Line: 1033 ]]
    p195:Enable(false);
end;
function u164.CleanupPath(_) --[[ Line: 1037 ]]
    -- upvalues: u122 (ref), u123 (ref), u124 (ref)
    if u122 then
        u122:Cancel();
        u122 = nil;
    end;
    if u123 then
        u123:Disconnect();
        u123 = nil;
    end;
    if u124 then
        u124:Disconnect();
        u124 = nil;
    end;
end;
function u164.Enable(u196, p197, p198, p199) --[[ Line: 1041 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u122 (ref), u123 (ref), u124 (ref), l__UserInputService__1 (copy), l__Keyboard__19 (copy)
    if p197 then
        if not u196.running then
            if l__LocalPlayer__9.Character then
                u196:OnCharacterAdded(l__LocalPlayer__9.Character);
            end;
            u196.onCharacterAddedConn = l__LocalPlayer__9.CharacterAdded:Connect(function(p200) --[[ Line: 1047 ]]
                -- upvalues: u196 (copy)
                u196:OnCharacterAdded(p200);
            end);
            u196.running = true;
        end;
        u196.touchJumpController = p199;
        if u196.touchJumpController then
            u196.touchJumpController:Enable(u196.jumpEnabled);
        end;
    else
        if u196.running then
            u196:DisconnectEvents();
            if u122 then
                u122:Cancel();
                u122 = nil;
            end;
            if u123 then
                u123:Disconnect();
                u123 = nil;
            end;
            if u124 then
                u124:Disconnect();
                u124 = nil;
            end;
            if l__UserInputService__1.PreferredInput == Enum.PreferredInput.Touch then
                local l__Character__34 = l__LocalPlayer__9.Character;
                if l__Character__34 then
                    for _, v201 in pairs(l__Character__34:GetChildren()) do
                        if v201:IsA("Tool") then
                            v201.ManualActivationOnly = false;
                        end;
                    end;
                end;
            end;
            u196.running = false;
        end;
        if u196.touchJumpController and not u196.jumpEnabled then
            u196.touchJumpController:Enable(true);
        end;
        u196.touchJumpController = nil;
    end;
    l__Keyboard__19.Enable(u196, p197);
    u196.wasdEnabled = p197 and p198 and p198 or false;
    u196.enabled = p197;
end;
function u164.OnRenderStepped(p202, p203) --[[ Line: 1086 ]]
    -- upvalues: u122 (ref)
    p202.isJumping = false;
    if u122 then
        u122:OnRenderStepped(p203);
        if u122 then
            p202.moveVector = u122.NextActionMoveDirection;
            p202.moveVectorIsCameraRelative = false;
            if u122.NextActionJump then
                p202.isJumping = true;
            end;
        else
            p202.moveVector = p202.keyboardMoveVector;
            p202.moveVectorIsCameraRelative = true;
        end;
    else
        p202.moveVector = p202.keyboardMoveVector;
        p202.moveVectorIsCameraRelative = true;
    end;
    if p202.jumpRequested then
        p202.isJumping = true;
    end;
end;
function u164.UpdateMovement(p204, p205) --[[ Line: 1121 ]]
    if p205 == Enum.UserInputState.Cancel then
        p204.keyboardMoveVector = Vector3.new(0, 0, 0);
    else
        if p204.wasdEnabled then
            p204.keyboardMoveVector = Vector3.new(p204.leftValue + p204.rightValue, 0, p204.forwardValue + p204.backwardValue);
        end;
    end;
end;
function u164.UpdateJump(_) --[[ Line: 1130 ]] end;
function u164.SetShowPath(_, p206) --[[ Line: 1135 ]]
    -- upvalues: u8 (ref)
    u8 = p206;
end;
function u164.GetShowPath(_) --[[ Line: 1139 ]]
    -- upvalues: u8 (ref)
    return u8;
end;
function u164.SetWaypointTexture(_, p207) --[[ Line: 1143 ]]
    -- upvalues: l__ClickToMoveDisplay__10 (copy)
    l__ClickToMoveDisplay__10.SetWaypointTexture(p207);
end;
function u164.GetWaypointTexture(_) --[[ Line: 1147 ]]
    -- upvalues: l__ClickToMoveDisplay__10 (copy)
    return l__ClickToMoveDisplay__10.GetWaypointTexture();
end;
function u164.SetWaypointRadius(_, p208) --[[ Line: 1151 ]]
    -- upvalues: l__ClickToMoveDisplay__10 (copy)
    l__ClickToMoveDisplay__10.SetWaypointRadius(p208);
end;
function u164.GetWaypointRadius(_) --[[ Line: 1155 ]]
    -- upvalues: l__ClickToMoveDisplay__10 (copy)
    return l__ClickToMoveDisplay__10.GetWaypointRadius();
end;
function u164.SetEndWaypointTexture(_, p209) --[[ Line: 1159 ]]
    -- upvalues: l__ClickToMoveDisplay__10 (copy)
    l__ClickToMoveDisplay__10.SetEndWaypointTexture(p209);
end;
function u164.GetEndWaypointTexture(_) --[[ Line: 1163 ]]
    -- upvalues: l__ClickToMoveDisplay__10 (copy)
    return l__ClickToMoveDisplay__10.GetEndWaypointTexture();
end;
function u164.SetWaypointsAlwaysOnTop(_, p210) --[[ Line: 1167 ]]
    -- upvalues: l__ClickToMoveDisplay__10 (copy)
    l__ClickToMoveDisplay__10.SetWaypointsAlwaysOnTop(p210);
end;
function u164.GetWaypointsAlwaysOnTop(_) --[[ Line: 1171 ]]
    -- upvalues: l__ClickToMoveDisplay__10 (copy)
    return l__ClickToMoveDisplay__10.GetWaypointsAlwaysOnTop();
end;
function u164.SetFailureAnimationEnabled(_, p211) --[[ Line: 1175 ]]
    -- upvalues: u9 (ref)
    u9 = p211;
end;
function u164.GetFailureAnimationEnabled(_) --[[ Line: 1179 ]]
    -- upvalues: u9 (ref)
    return u9;
end;
function u164.SetIgnoredPartsTag(_, p212) --[[ Line: 1183 ]]
    -- upvalues: u43 (copy)
    u43(p212);
end;
function u164.GetIgnoredPartsTag(_) --[[ Line: 1187 ]]
    -- upvalues: u32 (ref)
    return u32;
end;
function u164.SetUseDirectPath(_, p213) --[[ Line: 1191 ]]
    -- upvalues: u10 (ref)
    u10 = p213;
end;
function u164.GetUseDirectPath(_) --[[ Line: 1195 ]]
    -- upvalues: u10 (ref)
    return u10;
end;
function u164.SetAgentSizeIncreaseFactor(_, p214) --[[ Line: 1199 ]]
    -- upvalues: u11 (ref)
    u11 = p214 / 100 + 1;
end;
function u164.GetAgentSizeIncreaseFactor(_) --[[ Line: 1203 ]]
    -- upvalues: u11 (ref)
    return (u11 - 1) * 100;
end;
function u164.SetUnreachableWaypointTimeout(_, p215) --[[ Line: 1207 ]]
    -- upvalues: u12 (ref)
    u12 = p215;
end;
function u164.GetUnreachableWaypointTimeout(_) --[[ Line: 1211 ]]
    -- upvalues: u12 (ref)
    return u12;
end;
function u164.SetUserJumpEnabled(p216, p217) --[[ Line: 1215 ]]
    p216.jumpEnabled = p217;
    if p216.touchJumpController then
        p216.touchJumpController:Enable(p217);
    end;
end;
function u164.GetUserJumpEnabled(p218) --[[ Line: 1222 ]]
    return p218.jumpEnabled;
end;
function u164.MoveTo(_, p219, p220, p221) --[[ Line: 1226 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u118 (copy), u133 (copy)
    local l__Character__35 = l__LocalPlayer__9.Character;
    if l__Character__35 == nil then
        return false;
    end;
    local v222 = u118(p219, Vector3.new(0, 1, 0), p221);
    if not (v222 and v222:IsValidPath()) then
        return false;
    end;
    u133(v222, p219, nil, l__Character__35, p220);
    return true;
end;
return u164;