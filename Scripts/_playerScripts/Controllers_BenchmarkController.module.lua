-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__Stats__4 = game:GetService("Stats");
local l__BenchmarkPackets__5 = require(l__ReplicatedStorage__2.SharedModules.BenchmarkPackets);
local u1 = false;
local function u21() --[[ Line: 53 ]]
    -- upvalues: l__Stats__4 (copy)
    local v2 = {};
    local v3, v4 = pcall(function() --[[ Line: 55 ]]
        -- upvalues: l__Stats__4 (ref)
        return l__Stats__4.SceneDrawcallCount;
    end);
    v2.Drawcalls = (not v3 or type(v4) ~= "number") and 0 or v4;
    local v5, v6 = pcall(function() --[[ Line: 56 ]]
        -- upvalues: l__Stats__4 (ref)
        return l__Stats__4.SceneTriangleCount;
    end);
    v2.Triangles = (not v5 or type(v6) ~= "number") and 0 or v6;
    local v7, v8 = pcall(function() --[[ Line: 57 ]]
        -- upvalues: l__Stats__4 (ref)
        return l__Stats__4.InstanceCount;
    end);
    v2.InstanceCount = (not v7 or type(v8) ~= "number") and 0 or v8;
    local v9, v10 = pcall(function() --[[ Line: 58 ]]
        -- upvalues: l__Stats__4 (ref)
        return l__Stats__4:GetTotalMemoryUsageMb();
    end);
    v2.MemoryMb = (not v9 or type(v10) ~= "number") and 0 or v10;
    local v11, v12 = pcall(function() --[[ Line: 59 ]]
        return workspace:GetRealPhysicsFPS();
    end);
    v2.PhysicsFps = (not v11 or type(v12) ~= "number") and 0 or v12;
    local v13, v14 = pcall(function() --[[ Line: 60 ]]
        return workspace:GetNumAwakeParts();
    end);
    v2.AwakeParts = (not v13 or type(v14) ~= "number") and 0 or v14;
    local v15, v16 = pcall(function() --[[ Line: 61 ]]
        -- upvalues: l__Stats__4 (ref)
        return l__Stats__4.HeartbeatTime * 1000;
    end);
    v2.HeartbeatMs = (not v15 or type(v16) ~= "number") and 0 or v16;
    local v17, v18 = pcall(function() --[[ Line: 62 ]]
        -- upvalues: l__Stats__4 (ref)
        return l__Stats__4.RenderCPUFrameTime;
    end);
    v2.RenderCpuMs = (not v17 or type(v18) ~= "number") and 0 or v18;
    local v19, v20 = pcall(function() --[[ Line: 63 ]]
        -- upvalues: l__Stats__4 (ref)
        return l__Stats__4.RenderGPUFrameTime;
    end);
    v2.RenderGpuMs = (not v19 or type(v20) ~= "number") and 0 or v20;
    return v2;
end;
local function u100(p22, p23, p24, p25, p26, p27) --[[ Line: 98 ]]
    table.sort(p24);
    local v28 = #p24;
    local v29;
    if v28 == 0 then
        v29 = 0;
    else
        local v30 = 0;
        for _, v31 in p24 do
            v30 = v30 + v31;
        end;
        v29 = v30 / v28;
    end;
    local v32 = v29 <= 0 and 0 or 1 / v29;
    local v33 = #p24 <= 0 and 0 or p24[#p24];
    local v34 = v33 <= 0 and 0 or 1 / v33;
    local v35 = #p24;
    local v36;
    if v35 == 0 then
        v36 = 0;
    else
        local v37 = math.ceil(v35 * 0.5);
        v36 = p24[math.clamp(v37, 1, v35)];
    end;
    local v38 = v36 * 1000;
    local v39 = #p24;
    local v40;
    if v39 == 0 then
        v40 = 0;
    else
        local v41 = math.ceil(v39 * 0.99);
        v40 = p24[math.clamp(v41, 1, v39)];
    end;
    local v42 = v40 * 1000;
    local v43 = #p24;
    local v44;
    if v43 == 0 then
        v44 = 0;
    else
        local v45 = math.floor(v43 * 0.01);
        local v46 = math.max(1, v45);
        local v47 = 0;
        for v48 = v43 - v46 + 1, v43 do
            v47 = v47 + p24[v48];
        end;
        local v49 = v47 / v46;
        if v49 <= 0 then
            v44 = 0;
        else
            v44 = 1 / v49;
        end;
    end;
    local v50 = {};
    local v51 = {};
    local v52 = {};
    local v53 = {};
    local v54 = {};
    local v55 = {};
    local v56 = {};
    local v57 = {};
    local v58 = {};
    for _, v59 in p25 do
        table.insert(v52, v59.Drawcalls);
        table.insert(v53, v59.Triangles);
        table.insert(v54, v59.InstanceCount);
        table.insert(v55, v59.MemoryMb);
        table.insert(v56, v59.PhysicsFps);
        table.insert(v57, v59.AwakeParts);
        table.insert(v58, v59.HeartbeatMs);
        table.insert(v50, v59.RenderCpuMs);
        table.insert(v51, v59.RenderGpuMs);
    end;
    local v60;
    if #v54 > 0 then
        v60 = v54[#v54];
    else
        v60 = p26;
    end;
    local v61;
    if #v55 > 0 then
        v61 = v55[#v55];
    else
        v61 = p27;
    end;
    local v62 = math.max(50, 1000 / p23 * 1.5);
    local v63 = {
        Scenario = p22,
        TargetFps = p23,
        Verdict = p23 <= v32 and v42 <= v62 and "PASS" or "FAIL",
        Frames = #p24,
        AvgFps = v32,
        MinFps = v34,
        OnePercentLowFps = v44,
        P50FrameMs = v38,
        P99FrameMs = v42,
        P99BudgetMs = v62
    };
    local v64 = #v52;
    local v65;
    if v64 == 0 then
        v65 = 0;
    else
        local v66 = 0;
        for _, v67 in v52 do
            v66 = v66 + v67;
        end;
        v65 = v66 / v64;
    end;
    v63.AvgDrawcalls = v65;
    local v68 = #v53;
    local v69;
    if v68 == 0 then
        v69 = 0;
    else
        local v70 = 0;
        for _, v71 in v53 do
            v70 = v70 + v71;
        end;
        v69 = v70 / v68;
    end;
    v63.AvgTriangles = v69;
    local v72 = #v54;
    local v73;
    if v72 == 0 then
        v73 = 0;
    else
        local v74 = 0;
        for _, v75 in v54 do
            v74 = v74 + v75;
        end;
        v73 = v74 / v72;
    end;
    v63.AvgInstanceCount = v73;
    v63.InstanceDelta = v60 - p26;
    local v76 = #v55;
    local v77;
    if v76 == 0 then
        v77 = 0;
    else
        local v78 = 0;
        for _, v79 in v55 do
            v78 = v78 + v79;
        end;
        v77 = v78 / v76;
    end;
    v63.AvgMemoryMb = v77;
    v63.MemoryDeltaMb = v61 - p27;
    local v80 = #v56;
    local v81;
    if v80 == 0 then
        v81 = 0;
    else
        local v82 = 0;
        for _, v83 in v56 do
            v82 = v82 + v83;
        end;
        v81 = v82 / v80;
    end;
    v63.AvgPhysicsFps = v81;
    local v84 = #v57;
    local v85;
    if v84 == 0 then
        v85 = 0;
    else
        local v86 = 0;
        for _, v87 in v57 do
            v86 = v86 + v87;
        end;
        v85 = v86 / v84;
    end;
    v63.AvgAwakeParts = v85;
    local v88 = #v58;
    local v89;
    if v88 == 0 then
        v89 = 0;
    else
        local v90 = 0;
        for _, v91 in v58 do
            v90 = v90 + v91;
        end;
        v89 = v90 / v88;
    end;
    v63.AvgHeartbeatMs = v89;
    local v92 = #v50;
    local v93;
    if v92 == 0 then
        v93 = 0;
    else
        local v94 = 0;
        for _, v95 in v50 do
            v94 = v94 + v95;
        end;
        v93 = v94 / v92;
    end;
    v63.AvgRenderCpuMs = v93;
    local v96 = #v51;
    local v97;
    if v96 == 0 then
        v97 = 0;
    else
        local v98 = 0;
        for _, v99 in v51 do
            v98 = v98 + v99;
        end;
        v97 = v98 / v96;
    end;
    v63.AvgRenderGpuMs = v97;
    return v63;
end;
local function u106(p101) --[[ Line: 165 ]]
    local u102 = "?";
    pcall(function() --[[ Line: 167 ]]
        -- upvalues: u102 (ref)
        local l__SavedQualityLevel__6 = UserSettings().GameSettings.SavedQualityLevel;
        u102 = tostring(l__SavedQualityLevel__6);
    end);
    local v103 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.zero;
    local v104 = {
        "========================================",
        string.format("  BENCHMARK [%s]  %s", p101.Scenario, p101.Verdict),
        "----------------------------------------",
        string.format("  Quality:%s  Viewport:%dx%d  Frames:%d", u102, v103.X, v103.Y, p101.Frames),
        string.format("  Avg FPS:        %.1f  (target %d)", p101.AvgFps, p101.TargetFps),
        string.format("  1%% low FPS:     %.1f", p101.OnePercentLowFps),
        string.format("  Min FPS:        %.1f", p101.MinFps),
        string.format("  Frame p50:      %.1f ms", p101.P50FrameMs),
        string.format("  Frame p99:      %.1f ms  (budget %.0f)", p101.P99FrameMs, p101.P99BudgetMs),
        string.format("  Heartbeat:      %.2f ms", p101.AvgHeartbeatMs),
        string.format("  Render CPU/GPU: %.1f / %.1f ms", p101.AvgRenderCpuMs, p101.AvgRenderGpuMs),
        string.format("  Draw calls:     %d", (math.floor(p101.AvgDrawcalls))),
        string.format("  Triangles:      %d", (math.floor(p101.AvgTriangles))),
        string.format("  Instances:      %d  (%+d)", math.floor(p101.AvgInstanceCount), (math.floor(p101.InstanceDelta))),
        string.format("  Memory:         %.0f MB  (%+.0f)", p101.AvgMemoryMb, p101.MemoryDeltaMb),
        string.format("  Physics FPS:    %.0f  Awake parts: %d", p101.AvgPhysicsFps, (math.floor(p101.AvgAwakeParts))),
        "========================================"
    };
    local v105 = table.concat(v104, "\n");
    if p101.Verdict == "FAIL" then
        warn(v105);
    else
        print(v105);
    end;
end;
local function u127(u107, p108, u109) --[[ Line: 200 ]]
    -- upvalues: u1 (ref), l__Stats__4 (copy), u21 (copy), l__RunService__3 (copy), u100 (copy), u106 (copy), l__BenchmarkPackets__5 (copy)
    if u1 then
        warn("[BenchmarkController] a benchmark is already running; ignoring new request");
    else
        u1 = true;
        local v110, v111 = pcall(function() --[[ Line: 207 ]]
            -- upvalues: l__Stats__4 (ref)
            return l__Stats__4.InstanceCount;
        end);
        local u112 = (not v110 or type(v111) ~= "number") and 0 or v111;
        local v113, v114 = pcall(function() --[[ Line: 208 ]]
            -- upvalues: l__Stats__4 (ref)
            return l__Stats__4:GetTotalMemoryUsageMb();
        end);
        local u115 = (not v113 or type(v114) ~= "number") and 0 or v114;
        local u116 = {};
        local u117 = { (u21()) };
        local u118 = 0;
        print(string.format("[BenchmarkController] sampling %q for %ds (target %d FPS)...", u107, p108, u109));
        local u119 = os.clock() + p108;
        local u120 = nil;
        u120 = l__RunService__3.RenderStepped:Connect(function(p121) --[[ Line: 218 ]]
            -- upvalues: u116 (copy), u118 (ref), u117 (copy), u21 (ref), u119 (copy), u120 (ref), u100 (ref), u107 (copy), u109 (copy), u112 (copy), u115 (copy), u106 (ref), l__BenchmarkPackets__5 (ref), u1 (ref)
            table.insert(u116, p121);
            u118 = u118 + p121;
            if u118 >= 0.5 then
                u118 = 0;
                local v122 = u117;
                local v123 = u21();
                table.insert(v122, v123);
            end;
            if u119 <= os.clock() then
                u120:Disconnect();
                local v124 = u117;
                local v125 = u21();
                table.insert(v124, v125);
                local u126 = u100(u107, u109, u116, u117, u112, u115);
                u106(u126);
                pcall(function() --[[ Line: 230 ]]
                    -- upvalues: l__BenchmarkPackets__5 (ref), u107 (ref), u126 (copy)
                    l__BenchmarkPackets__5.Result:Fire(u107, u126);
                end);
                u1 = false;
            end;
        end);
    end;
end;
return {
    Init = function(_) --[[ Name: Init, Line 241 ]]
        -- upvalues: l__RunService__3 (copy), l__Players__1 (copy), l__BenchmarkPackets__5 (copy), u127 (copy)
        if l__RunService__3:IsServer() then
        elseif l__Players__1.LocalPlayer then
            l__BenchmarkPackets__5.Start.OnClientEvent:Connect(function(p128, p129, p130) --[[ Line: 245 ]]
                -- upvalues: u127 (ref)
                u127(p128, p129, p130);
            end);
        end;
    end
};