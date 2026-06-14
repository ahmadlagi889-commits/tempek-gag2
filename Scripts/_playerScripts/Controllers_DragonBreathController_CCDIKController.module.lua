-- Decompiled with Potassium's decompiler.

local l__Debris__1 = game:GetService("Debris");
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__VectorUtil__4 = require(script.VectorUtil);
local l__Maid__5 = require(script.Maid);
local function u5(p1, p2, p3) --[[ Line: 10 ]]
    local v4 = p1:Dot(p2);
    if v4 > 0.99999 then
        return CFrame.new();
    elseif v4 < -0.99999 then
        return CFrame.fromAxisAngle(p3, 3.141592653589793);
    else
        return CFrame.fromAxisAngle(p1:Cross(p2), math.acos(v4) * 0.8);
    end;
end;
local l__new__6 = CFrame.new;
local l__lookAt__7 = CFrame.lookAt;
Vector3.new();
local v6 = Instance.new("Motor6D");
local _ = {
    [Instance.new("Motor6D")] = {
        ConstraintType = "Hinge",
        UpperAngle = 45,
        LowerAngle = -45,
        AxisAttachment = nil,
        JointAttachment = nil
    },
    [v6] = {
        ConstraintType = "BallSocketConstraint",
        UpperAngle = 45,
        TwistLimitsEnabled = false,
        TwistUpperAngle = 45,
        TwistLowerAngle = -45,
        AxisAttachment = nil,
        JointAttachment = nil
    }
};
local u7 = {};
u7.__index = u7;
function u7.new(p8, p9) --[[ Line: 66 ]]
    -- upvalues: u7 (copy), l__Maid__5 (copy)
    local v10 = setmetatable({}, u7);
    v10.Maid = l__Maid__5.new();
    v10.Motor6DTable = p8;
    v10.Constraints = p9;
    local v11, v12 = v10:SetupJoints();
    v10.JointInfo = v11;
    v10.JointAxisInfo = v12;
    v10.EndEffector = p8[#p8].Part1:FindFirstChild("EndEffector");
    if not v10.EndEffector then
        local v13 = Instance.new("Attachment");
        v13.Name = "EndEffector";
        v13.Parent = p8[#p8].Part1;
        v10.EndEffector = v13;
        v10.Maid:GiveTask(v13);
    end;
    v10.DebugMode = false;
    v10.LerpMode = true;
    v10.LerpAlpha = 0.9;
    v10.ConstantLerpSpeed = true;
    v10.AngularSpeed = 1.5707963267948966;
    v10.FootOrientationSystem = false;
    v10.FootRaycastParams = RaycastParams.new();
    v10.RaycastLengthDown = 50;
    v10._RayResultTable = {};
    v10.UseLastMotor = false;
    return v10;
end;
function u7.SetupJoints(p14) --[[ Line: 106 ]]
    local v15 = {};
    local v16 = {};
    for _, v17 in pairs(p14.Motor6DTable) do
        local v18 = Instance.new("Attachment");
        v18.CFrame = v17.C0;
        v18.Name = "JointPosition";
        v18.Parent = v17.Part0;
        v15[v17] = v18;
        p14.Maid:GiveTask(v18);
        if p14.Constraints then
            local v19 = p14.Constraints[v17];
            if v19 then
                if v19.AxisAttachment then
                    if typeof(v19.AxisAttachment) == "string" then
                        v19.AxisAttachment = v17.Part0:FindFirstChild(v19.AxisAttachment .. "AxisAttachment");
                    end;
                else
                    v19.AxisAttachment = v17.Part0:FindFirstChild(v17.Part0.Name .. "AxisAttachment");
                end;
                if v19.JointAttachment then
                    if typeof(v19.JointAttachment) == "string" then
                        v19.JointAttachment = v17.Part1:FindFirstChild(v19.JointAttachment .. "JointAttachment");
                    end;
                else
                    v19.JointAttachment = v17.Part1:FindFirstChild(v17.Part0.Name .. "JointAttachment");
                end;
            end;
        end;
    end;
    return v15, v16;
end;
function u7.GetConstraints(p20) --[[ Line: 150 ]]
    if not p20.Constraints then
        p20.Constraints = {};
    end;
    for _, v21 in pairs(p20.Motor6DTable) do
        local l__Part0__8 = v21.Part0;
        local v22 = l__Part0__8:FindFirstChildWhichIsA("HingeConstraint");
        local v23 = l__Part0__8:FindFirstChildWhichIsA("BallSocketConstraint");
        if v22 then
            p20.Constraints[v21] = {
                ConstraintType = "Hinge",
                UpperAngle = v22.UpperAngle,
                LowerAngle = v22.LowerAngle,
                AxisAttachment = v22.Attachment0,
                JointAttachment = v22.Attachment1
            };
        elseif v23 then
            p20.Constraints[v21] = {
                ConstraintType = "BallSocketConstraint",
                UpperAngle = v23.UpperAngle,
                TwistLimitsEnabled = v23.TwistLimitsEnabled,
                TwistUpperAngle = v23.TwistUpperAngle,
                TwistLowerAngle = v23.TwistLowerAngle,
                AxisAttachment = v23.Attachment0,
                JointAttachment = v23.Attachment1
            };
        end;
    end;
end;
function u7.GetConstraintsFromMotor(p24, p25, p26) --[[ Line: 183 ]]
    if not p24.Constraints then
        p24.Constraints = {};
    end;
    local v27 = p25.Part0:FindFirstChild(p26);
    if v27:IsA("HingeConstraint") then
        p24.Constraints[p25] = {
            ConstraintType = "Hinge",
            UpperAngle = v27.UpperAngle,
            LowerAngle = v27.LowerAngle,
            AxisAttachment = v27.Attachment0,
            JointAttachment = v27.Attachment1
        };
    else
        if v27:IsA("BallSocketConstraint") then
            p24.Constraints[p25] = {
                ConstraintType = "BallSocketConstraint",
                UpperAngle = v27.UpperAngle,
                TwistLimitsEnabled = v27.TwistLimitsEnabled,
                TwistUpperAngle = v27.TwistUpperAngle,
                TwistLowerAngle = v27.TwistLowerAngle,
                AxisAttachment = v27.Attachment0,
                JointAttachment = v27.Attachment1
            };
        end;
    end;
end;
function u7._CCDIKIterateFoot(p28, p29) --[[ Line: 211 ]]
    -- upvalues: l__new__6 (copy)
    local l__Constraints__9 = p28.Constraints;
    local l__Motor6DTable__10 = p28.Motor6DTable;
    local v30 = l__Motor6DTable__10[#l__Motor6DTable__10];
    v30.C0 = v30.C0 * v30.Transform;
    p28:OrientFootMotorToFloor(v30, p29);
    v30.Transform = l__new__6();
    local v31 = l__Constraints__9 and l__Constraints__9[v30];
    if v31 then
        if v31.ConstraintType == "Hinge" then
            p28:RotateToHingeAxis(v30, v31);
        end;
        if v31.ConstraintType == "BallSocketConstraint" then
            p28:RotateToBallSocketConstraintAxis(v30, v31);
        end;
    end;
end;
function u7._CCDIKIterateStep(p32, p33, p34) --[[ Line: 233 ]]
    -- upvalues: l__new__6 (copy)
    local l__Constraints__11 = p32.Constraints;
    for v35 = #p32.Motor6DTable - 1 + (p32.UseLastMotor and 1 or 0), 1, -1 do
        local v36 = p32.Motor6DTable[v35];
        v36.C0 = v36.C0 * v36.Transform;
        p32:RotateFromEffectorToGoal(v36, p33, p34);
        v36.Transform = l__new__6();
        if l__Constraints__11 then
            local v37 = l__Constraints__11[v36];
            if v37 then
                if v37.ConstraintType == "Hinge" then
                    p32:RotateToHingeAxis(v36, v37);
                end;
                if v37.ConstraintType == "BallSocketConstraint" then
                    p32:RotateToBallSocketConstraintAxis(v36, v37);
                end;
            end;
        end;
    end;
end;
function u7.CCDIKIterateOnce(p38, p39, _, p40) --[[ Line: 257 ]]
    local _ = p38.EndEffector.WorldPosition - p39;
    p38:_CCDIKIterateStep(p39, p40);
    if p38.FootOrientationSystem then
        p38:_CCDIKIterateFoot(p40);
    end;
end;
function u7.CCDIKIterateOnceDebug(p41, p42, _, p43) --[[ Line: 269 ]]
    p41:_CCDIKIterateStep(p42, p43);
end;
function u7.CCDIKIterateUntil(p44, p45, p46, p47, p48) --[[ Line: 281 ]]
    local v49 = p44.EndEffector.WorldPosition - p45;
    local v50 = p46 or 1;
    local v51 = 0;
    local v52 = p47 or 10;
    while v50 < v49.Magnitude and v51 <= v52 do
        v51 = v51 + 1;
        p44:_CCDIKIterateStep(p45, p48);
        if p44.FootOrientationSystem then
            p44:_CCDIKIterateFoot(p48);
        end;
    end;
end;
function u7.rotateJointFromTo(p53, p54, p55, p56) --[[ Line: 319 ]]
    -- upvalues: u5 (copy)
    local v57 = u5(p54, p55, p56);
    local l__CFrame__12 = p53.Part1.CFrame;
    local l__C1__13 = p53.C1;
    local l__C0__14 = p53.C0;
    local v58 = v57 * l__CFrame__12;
    local v59 = l__C0__14 * l__C1__13:Inverse() * l__CFrame__12:Inverse() * v58 * l__C1__13;
    p53.C0 = v59 - v59.Position + l__C0__14.Position;
end;
local u60 = TweenInfo.new(0.1);
function u7.rotateJointFromToTween(p61, p62, p63, p64) --[[ Line: 324 ]]
    -- upvalues: u5 (copy), l__TweenService__3 (copy), u60 (copy)
    local v65 = u5(p62, p63, p64);
    local l__CFrame__15 = p61.Part1.CFrame;
    local l__C1__16 = p61.C1;
    local l__C0__17 = p61.C0;
    local v66 = v65 * l__CFrame__15;
    local v67 = l__C0__17 * l__C1__16:Inverse() * l__CFrame__15:Inverse() * v66 * l__C1__16;
    local v68 = l__TweenService__3:Create(p61, u60, {
        C0 = v67 - v67.Position + l__C0__17.Position
    });
    v68:Play();
    v68.Completed:Wait();
end;
function u7.rotateJointFromToWithLerp(p69, p70, p71, p72, p73, p74) --[[ Line: 332 ]]
    -- upvalues: u5 (copy), l__VectorUtil__4 (copy)
    local v75 = u5(p71, p72, p73);
    local l__CFrame__18 = p70.Part1.CFrame;
    local l__C1__19 = p70.C1;
    local l__C0__20 = p70.C0;
    local v76 = v75 * l__CFrame__18;
    local v77 = l__C0__20 * l__C1__19:Inverse() * l__CFrame__18:Inverse() * v76 * l__C1__19;
    local v78 = v77 - v77.Position + l__C0__20.Position;
    local l__LerpAlpha__21 = p69.LerpAlpha;
    local l__C0__22 = p70.C0;
    if p74 and p69.ConstantLerpSpeed then
        local v79 = l__VectorUtil__4.AngleBetween(l__C0__22.LookVector, v78.LookVector);
        l__LerpAlpha__21 = math.min(p74 * (p69.AngularSpeed / v79), 1);
    end;
    p70.C0 = l__C0__22:Lerp(v78, l__LerpAlpha__21);
end;
function u7.RotateFromEffectorToGoal(p80, p81, p82, p83) --[[ Line: 347 ]]
    local l__CFrame__23 = p81.Part0.CFrame;
    local l__WorldPosition__24 = p80.JointInfo[p81].WorldPosition;
    local l__WorldPosition__25 = p80.EndEffector.WorldPosition;
    local l__Unit__26 = (l__WorldPosition__25 - l__WorldPosition__24).Unit;
    local l__Unit__27 = (p82 - l__WorldPosition__24).Unit;
    if p80.DebugMode then
        p80.VisualizeVector(l__WorldPosition__24, l__WorldPosition__25 - l__WorldPosition__24, BrickColor.Blue());
        p80.VisualizeVector(l__WorldPosition__24, p82 - l__WorldPosition__24, BrickColor.Red());
        p80.rotateJointFromToTween(p81, l__Unit__26, l__Unit__27, l__CFrame__23.UpVector);
    elseif p80.LerpMode == true then
        p80:rotateJointFromToWithLerp(p81, l__Unit__26, l__Unit__27, l__CFrame__23.RightVector, p83);
    else
        p80.rotateJointFromTo(p81, l__Unit__26, l__Unit__27, l__CFrame__23.RightVector);
    end;
end;
function u7.RotateToHingeAxis(p84, p85, p86) --[[ Line: 379 ]]
    local l__CFrame__28 = p85.Part0.CFrame;
    local l__AxisAttachment__29 = p86.AxisAttachment;
    local l__JointAttachment__30 = p86.JointAttachment;
    p84.rotateJointFromTo(p85, l__JointAttachment__30.WorldAxis, l__AxisAttachment__29.WorldAxis, l__CFrame__28.RightVector);
    local l__WorldCFrame__31 = l__AxisAttachment__29.WorldCFrame;
    local l__WorldCFrame__32 = l__JointAttachment__30.WorldCFrame;
    local v87 = p86.UpperAngle or 180;
    local v88 = p86.LowerAngle or -180;
    local v89, _, _ = l__WorldCFrame__31:ToObjectSpace(l__WorldCFrame__32):ToEulerAnglesXYZ();
    local v90 = math.deg(v89);
    local v91 = math.clamp(v90, v88, v87);
    local v92 = math.rad(v91);
    local v93 = l__WorldCFrame__31:ToWorldSpace((CFrame.fromEulerAnglesXYZ(v92, 0, 0))) * l__JointAttachment__30.CFrame:Inverse();
    local l__CFrame__33 = p85.Part1.CFrame;
    local l__C1__34 = p85.C1;
    local l__C0__35 = p85.C0;
    local v94 = l__C0__35 * l__C1__34:Inverse() * l__CFrame__33:Inverse() * v93 * l__C1__34;
    p85.C0 = v94 - v94.Position + l__C0__35.Position;
end;
local function u102(p95, p96) --[[ Line: 421 ]]
    local v97, v98 = p95:ToAxisAngle();
    local v99 = math.cos(v98 / 2);
    local v100 = (math.sin(v98 / 2) * v97):Dot(p96) * p96;
    local v101 = CFrame.new(p95.x, p95.y, p95.z, v100.x, v100.y, v100.z, v99);
    return v101:Inverse() * p95, v101;
end;
function u7.RotateToBallSocketConstraintAxis(p103, p104, p105) --[[ Line: 429 ]]
    -- upvalues: l__VectorUtil__4 (copy), u102 (copy)
    local l__CFrame__36 = p104.Part0.CFrame;
    local l__AxisAttachment__37 = p105.AxisAttachment;
    local l__JointAttachment__38 = p105.JointAttachment;
    local l__WorldAxis__39 = l__AxisAttachment__37.WorldAxis;
    local l__WorldAxis__40 = l__JointAttachment__38.WorldAxis;
    local v106 = l__VectorUtil__4.AngleBetween(l__WorldAxis__40, l__WorldAxis__39);
    local v107 = math.rad(p105.UpperAngle) or 0.7853981633974483;
    if v107 < v106 then
        local v108 = l__WorldAxis__40:Cross(l__WorldAxis__39);
        local v109 = CFrame.fromAxisAngle(v108, v106 - v107):VectorToWorldSpace(l__WorldAxis__40);
        p103.rotateJointFromTo(p104, l__WorldAxis__40, v109, l__CFrame__36.RightVector);
    end;
    if p105.TwistLimitsEnabled then
        local l__WorldCFrame__41 = l__AxisAttachment__37.WorldCFrame;
        local l__WorldCFrame__42 = l__JointAttachment__38.WorldCFrame;
        local l__WorldAxis__43 = l__AxisAttachment__37.WorldAxis;
        local v110, v111 = u102(l__WorldCFrame__41:ToObjectSpace(l__WorldCFrame__42), l__WorldAxis__43);
        local v112, v113 = v111:ToAxisAngle();
        local v114 = v112:Dot(l__WorldAxis__43);
        local v115 = math.sign(v114);
        local v116 = v115 * v112;
        local v117 = math.deg(v115 * v113);
        local l__TwistUpperAngle__44 = p105.TwistUpperAngle;
        local l__TwistLowerAngle__45 = p105.TwistLowerAngle;
        local v118 = false;
        if l__TwistUpperAngle__44 < v117 then
            v117 = l__TwistUpperAngle__44;
        elseif v117 < l__TwistLowerAngle__45 then
            v117 = l__TwistLowerAngle__45;
        else
            v118 = true;
        end;
        if not v118 then
            local v119 = math.rad(v117);
            local v120 = l__WorldCFrame__41 * (CFrame.fromAxisAngle(v116, v119) * v110) * l__JointAttachment__38.CFrame:Inverse();
            local l__CFrame__46 = p104.Part1.CFrame;
            local l__C1__47 = p104.C1;
            local l__C0__48 = p104.C0;
            local v121 = l__C0__48 * l__C1__47:Inverse() * l__CFrame__46:Inverse() * v120 * l__C1__47;
            p104.C0 = v121 - v121.Position + l__C0__48.Position;
        end;
    end;
end;
function u7.SetupFoot(p122, p123, p124) --[[ Line: 481 ]]
    local l__Motor6DTable__49 = p122.Motor6DTable;
    local l__Part1__50 = l__Motor6DTable__49[#l__Motor6DTable__49].Part1;
    local v125 = {};
    for v126, v127 in pairs(p123) do
        v125[v126] = l__Part1__50:FindFirstChild(v127);
    end;
    p122.FootAttachmentTable = v125;
    p122.FootRaycastParams = p124;
    p122.FootOrientationSystem = true;
end;
function u7.OrientFootMotorToFloor(p128, p129, p130) --[[ Line: 493 ]]
    local l__FootAttachmentTable__51 = p128.FootAttachmentTable;
    local l__RaycastLengthDown__52 = p128.RaycastLengthDown;
    local l___RayResultTable__53 = p128._RayResultTable;
    local l__FootRaycastParams__54 = p128.FootRaycastParams;
    for v131 = 1, 3 do
        local v132 = l__FootAttachmentTable__51[v131];
        l___RayResultTable__53[v131] = workspace:Raycast(v132.WorldPosition, -v132.WorldCFrame.UpVector * l__RaycastLengthDown__52, l__FootRaycastParams__54);
    end;
    local v133 = l___RayResultTable__53[1] and l___RayResultTable__53[2];
    if v133 then
        v133 = l___RayResultTable__53[3];
    end;
    local v134 = v133 == nil;
    local l__WorldCFrame__55 = p128.EndEffector.WorldCFrame;
    local v135 = v134 and l__WorldCFrame__55.UpVector or (l___RayResultTable__53[2].Position - l___RayResultTable__53[1].Position):Cross(l___RayResultTable__53[3].Position - l___RayResultTable__53[1].Position).Unit;
    local l__UpVector__56 = l__WorldCFrame__55.UpVector;
    if v134 == false then
        p128:rotateJointFromToWithLerp(p129, l__UpVector__56, v135, l__WorldCFrame__55.UpVector, p130);
    end;
    local l__Constraints__57 = p128.Constraints;
    local v136 = l__Constraints__57 and l__Constraints__57[p129];
    if v136 then
        if v136.ConstraintType == "Hinge" then
            p128:RotateToHingeAxis(p129, v136);
        end;
        if v136.ConstraintType == "BallSocketConstraint" then
            p128:RotateToBallSocketConstraintAxis(p129, v136);
        end;
    end;
end;
function u7.InitDragDebug(u137) --[[ Line: 529 ]]
    -- upvalues: l__RunService__2 (copy)
    local l__Part1__58 = u137.Motor6DTable[#u137.Motor6DTable].Part1;
    u137.LerpMode = false;
    local u138 = Instance.new("Part");
    u138.CanCollide = false;
    u138.Anchored = true;
    u138.Size = Vector3.new(1, 1, 1);
    u138.BrickColor = BrickColor.random();
    u138.Position = l__Part1__58.Position;
    u138.Name = "DragMe!: " .. l__Part1__58.Name;
    u138.Parent = workspace;
    l__RunService__2.Heartbeat:Connect(function() --[[ Line: 540 ]]
        -- upvalues: u137 (copy), u138 (copy)
        u137:CCDIKIterateOnce(u138.Position);
    end);
end;
function u7.InitTweenDragDebug(u139) --[[ Line: 544 ]]
    -- upvalues: l__lookAt__7 (copy)
    local l__Part1__59 = u139.Motor6DTable[#u139.Motor6DTable].Part1;
    u139.DebugMode = true;
    for v140 = 1, #u139.Motor6DTable - 1 do
        local v141 = u139.Motor6DTable[v140];
        local v142 = u139.Motor6DTable[v140 + 1];
        local l__WorldPosition__60 = u139.JointInfo[v141].WorldPosition;
        local v143 = u139.JointInfo[v142].WorldPosition - l__WorldPosition__60;
        local v144 = Instance.new("WedgePart");
        v144.Size = Vector3.new(0.1, 0.1, v143.Magnitude);
        v144.CFrame = l__lookAt__7(l__WorldPosition__60, l__WorldPosition__60 + v143) * CFrame.new(0, 0, -v143.Magnitude / 2);
        v144.CanCollide = false;
        local v145 = Instance.new("WeldConstraint");
        v145.Part0 = v144;
        v145.Part1 = v142.Parent;
        v145.Parent = v142.Parent;
        v144.Parent = workspace;
        v144.Name = "I am a limb vector";
    end;
    for _, v146 in pairs(u139.Motor6DTable) do
        v146.Part1.Transparency = 0.75;
        v146.Part0.Transparency = 0.75;
    end;
    local u147 = Instance.new("Part");
    u147.CanCollide = false;
    u147.Anchored = true;
    u147.Size = Vector3.new(1, 1, 1);
    u147.BrickColor = BrickColor.random();
    u147.Position = l__Part1__59.Position;
    u147.Name = "DragMe!: " .. l__Part1__59.Name;
    u147.Parent = workspace;
    spawn(function() --[[ Line: 578 ]]
        -- upvalues: u139 (copy), u147 (copy)
        while true do
            wait();
            u139:CCDIKIterateOnceDebug(u147.Position);
        end;
    end);
end;
function commandBarSetupJoints(p148)
    local v149 = p148:GetDescendants();
    for _, v150 in pairs(v149) do
        if v150:IsA("Motor6D") then
            local l__Name__61 = v150.Part0.Name;
            local v151 = Instance.new("Attachment");
            v151.CFrame = v150.C0;
            v151.Name = l__Name__61 .. "AxisAttachment";
            v151.Parent = v150.Part0;
            local v152 = Instance.new("Attachment");
            v152.CFrame = v150.C1;
            v152.Name = l__Name__61 .. "JointAttachment";
            v152.Parent = v150.Part1;
        end;
    end;
end;
function commandBarSetupRigAttachments(p153)
    local v154 = p153:GetDescendants();
    for _, v155 in pairs(v154) do
        if v155:IsA("Motor6D") then
            local l__Name__62 = v155.Name;
            local v156 = Instance.new("Attachment");
            v156.CFrame = v155.C0;
            v156.Name = l__Name__62 .. "RigAttachment";
            v156.Parent = v155.Part0;
            local v157 = Instance.new("Attachment");
            v157.CFrame = v155.C1;
            v157.Name = l__Name__62 .. "RigAttachment";
            v157.Parent = v155.Part1;
        end;
    end;
end;
function u7.VisualizeVector(p158, p159, p160) --[[ Line: 629 ]]
    -- upvalues: l__lookAt__7 (copy), l__Debris__1 (copy)
    local v161 = Instance.new("WedgePart");
    v161.Size = Vector3.new(0.1, 0.1, p159.Magnitude);
    v161.CFrame = l__lookAt__7(p158, p158 + p159) * CFrame.new(0, 0, -p159.Magnitude / 2);
    v161.Anchored = true;
    v161.CanCollide = false;
    v161.BrickColor = p160 or BrickColor.random();
    v161.Parent = workspace;
    l__Debris__1:AddItem(v161, 0.75);
end;
function u7.Destroy(p162) --[[ Line: 642 ]]
    p162.Maid:DoCleaning();
end;
return u7;