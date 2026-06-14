-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__SoundService__2 = game:GetService("SoundService");
local l__TweenService__3 = game:GetService("TweenService");
local l__WeatherValues__4 = l__ReplicatedStorage__1:WaitForChild("WeatherValues");
local l__SharedModules__5 = l__ReplicatedStorage__1:WaitForChild("SharedModules");
local l__WeatherData__6 = require(l__SharedModules__5:WaitForChild("WeatherData"));
local l__MusicTracks__7 = l__SoundService__2:WaitForChild("MusicTracks");
local l__Day__8 = l__MusicTracks__7:WaitForChild("Day");
local u1 = {};
local function u2(...) --[[ Line: 18 ]] end;
local v3 = {
    StartOrder = 2
};
for _, v4 in l__WeatherData__6.Data do
    u1[v4.Name] = v4.AlwaysOn == true;
end;
local u5 = Random.new();
local u6 = setmetatable({}, {
    __mode = "k"
});
local u7 = l__Day__8;
local u8 = nil;
local u9 = {};
local u10 = 0;
local u11 = nil;
local u12 = nil;
local u13 = 0;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = false;
local function u23(p20) --[[ Line: 51 ]]
    -- upvalues: u6 (copy)
    local v21 = {};
    for _, v22 in p20:GetChildren() do
        if v22:IsA("Sound") and v22.SoundId ~= "" then
            table.insert(v21, v22);
            if u6[v22] == nil then
                u6[v22] = v22.Volume;
            end;
        end;
    end;
    return v21;
end;
local function u29(p24) --[[ Line: 64 ]]
    -- upvalues: u5 (copy)
    for v25 = #p24, 2, -1 do
        local v26 = u5:NextInteger(1, v25);
        local v27 = p24[v26];
        local v28 = p24[v25];
        p24[v25] = v27;
        p24[v26] = v28;
    end;
end;
local function u38(p30, p31) --[[ Line: 71 ]]
    -- upvalues: u9 (ref), u23 (copy), u10 (ref), u29 (copy), u2 (copy)
    u9 = u23(p30);
    u10 = 0;
    u29(u9);
    u2("rebuildPlaylist for folder:", p30.Name, "| track count:", #u9);
    for v32, v33 in u9 do
        u2("  playlist[" .. v32 .. "]:", v33.Name);
    end;
    if p31 and (#u9 > 1 and u9[1] == p31) then
        local v34 = u9;
        local v35 = u9;
        local v36 = u9[2];
        local v37 = u9[1];
        v34[1] = v36;
        v35[2] = v37;
        u2("  swapped first track to avoid repeat:", p31.Name);
    end;
end;
local function u41(p39) --[[ Line: 87 ]]
    -- upvalues: u2 (copy), u7 (ref), u10 (ref), u9 (ref), u38 (copy), u11 (ref)
    u2("nextTrackFromFolder:", p39.Name, "| currentFolder:", u7.Name, "| playlistIndex:", u10, "| #playlist:", #u9);
    if p39 ~= u7 then
        u2("  folder changed from", u7.Name, "-> rebuilding playlist");
        u38(p39, u11);
    end;
    if #u9 == 0 then
        u2("  playlist empty, rebuilding");
        u38(p39, u11);
    end;
    if #u9 == 0 then
        u2("  playlist STILL empty after rebuild, returning nil");
        return nil;
    end;
    u10 = u10 + 1;
    if u10 > #u9 then
        u2("  playlistIndex overflowed, reshuffling");
        u38(p39, u11);
        u10 = 1;
    end;
    local v40 = u9[u10];
    u11 = v40;
    u2("  chose track:", v40.Name, "from folder:", p39.Name, "| index:", u10);
    return v40;
end;
local function u42() --[[ Line: 118 ]]
    -- upvalues: u14 (ref), u2 (copy), u15 (ref), u16 (ref), u17 (ref)
    if u14 then
        u2("cancelTweens: cancelling fadeInTween");
        u14:Cancel();
        u14 = nil;
    end;
    if u15 then
        u2("cancelTweens: cancelling fadeOutTween");
        u15:Cancel();
        u15 = nil;
    end;
    if u16 then
        u2("cancelTweens: killing orphaned fadingOutSound:", u16.Name, "| IsPlaying:", u16.IsPlaying);
        u16:Stop();
        u16.TimePosition = 0;
        u16.Volume = u17 or u16.Volume;
        u16 = nil;
        u17 = nil;
    end;
end;
local function u47(p43, p44, p45) --[[ Line: 148 ]]
    -- upvalues: l__TweenService__3 (copy)
    local v46 = l__TweenService__3:Create(p43, TweenInfo.new(p45, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Volume = p44
    });
    v46:Play();
    return v46;
end;
local function u52(p48) --[[ Line: 158 ]]
    -- upvalues: l__MusicTracks__7 (copy), u2 (copy), u6 (copy)
    local v49 = p48 and (p48.Name or "nil") or "nil";
    for _, v50 in l__MusicTracks__7:GetChildren() do
        if v50:IsA("Folder") then
            for _, v51 in v50:GetChildren() do
                if v51:IsA("Sound") and (v51 ~= p48 and v51.IsPlaying) then
                    u2("stopAllExcept: STOPPING orphan:", v51.Name, "in folder:", v50.Name, "(keeping:", v49, ")");
                    v51:Stop();
                    v51.TimePosition = 0;
                    v51.Volume = u6[v51] or v51.Volume;
                end;
            end;
        end;
    end;
end;
function v3._CrossFadeTo(u53, u54) --[[ Line: 174 ]]
    -- upvalues: u13 (ref), u8 (ref), u2 (copy), u42 (copy), u12 (ref), u6 (copy), u14 (ref), u47 (copy), u52 (copy), u16 (ref), u17 (ref), u15 (ref), l__MusicTracks__7 (copy)
    u13 = u13 + 1;
    local u55 = u13;
    local v56 = u54 and (u54.Name or "nil") or "nil";
    local v57 = u54 and u54.Parent and (u54.Parent.Name or "nil") or "nil";
    local v58 = u8 and u8.Name or "nil";
    local v59 = u8 and (u8.Parent and u8.Parent.Name) or "nil";
    u2("=== _CrossFadeTo ===");
    u2("  transitionId:", u55);
    u2("  prev:", v58, "(folder:", v59, ")");
    u2("  next:", v56, "(folder:", v57, ")");
    u42();
    if u12 then
        u2("disconnectEnded: disconnecting previous Ended connection");
        u12:Disconnect();
        u12 = nil;
    end;
    local u60 = u8;
    if u60 and (u54 and u60 == u54) then
        u2("  same-sound restart:", u60.Name);
        local v61 = u6[u60] or u60.Volume;
        u6[u60] = v61;
        u60:Stop();
        u60.Looped = false;
        u60.TimePosition = 0;
        u60.Volume = 0;
        u60:Play();
        u14 = u47(u60, v61, 2.25);
        u8 = u60;
        u52(u60);
        u12 = u60.Ended:Connect(function() --[[ Line: 209 ]]
            -- upvalues: u2 (ref), u60 (copy), u55 (copy), u13 (ref), u53 (copy)
            u2("  Ended fired (same-sound) for:", u60.Name, "| myId:", u55, "| transitionId:", u13);
            if u13 == u55 then
                u53:_PlayNext();
            else
                u2("  STALE transitionId, ignoring Ended");
            end;
        end);
    else
        if u60 then
            u2("  fading OUT:", u60.Name);
            local u62 = u6[u60] or u60.Volume;
            u16 = u60;
            u17 = u62;
            u15 = u47(u60, 0, 2.25);
            u15.Completed:Connect(function(p63) --[[ Line: 229 ]]
                -- upvalues: u2 (ref), u60 (copy), u55 (copy), u13 (ref), u62 (copy), u16 (ref), u17 (ref)
                u2("  fadeOut Completed for:", u60.Name, "| state:", tostring(p63), "| myId:", u55, "| transitionId:", u13);
                if u13 == u55 then
                    if p63 == Enum.PlaybackState.Completed then
                        u60:Stop();
                        u60.TimePosition = 0;
                        u60.Volume = u62;
                        u2("  fadeOut cleanup done for:", u60.Name);
                        if u16 == u60 then
                            u16 = nil;
                            u17 = nil;
                        end;
                    else
                        u2("  fadeOut was NOT completed (cancelled?), ignoring");
                    end;
                else
                    u2("  STALE transitionId on fadeOut Completed, ignoring");
                end;
            end);
        end;
        if u54 then
            local v64 = u6[u54] or u54.Volume;
            u6[u54] = v64;
            u2("  fading IN:", u54.Name, "| baseVol:", v64);
            u54.Looped = false;
            u54.TimePosition = 0;
            u54.Volume = 0;
            u54:Play();
            u14 = u47(u54, v64, 2.25);
            u8 = u54;
            for _, v65 in l__MusicTracks__7:GetChildren() do
                if v65:IsA("Folder") then
                    for _, v66 in v65:GetChildren() do
                        if v66:IsA("Sound") and (v66 ~= u54 and (v66 ~= u60 and v66.IsPlaying)) then
                            u2("  SAFETY SWEEP: stopping leaked sound:", v66.Name, "in folder:", v65.Name);
                            v66:Stop();
                            v66.TimePosition = 0;
                            v66.Volume = u6[v66] or v66.Volume;
                        end;
                    end;
                end;
            end;
            u12 = u54.Ended:Connect(function() --[[ Line: 285 ]]
                -- upvalues: u2 (ref), u54 (copy), u55 (copy), u13 (ref), u53 (copy)
                u2("  Ended fired for:", u54.Name, "| myId:", u55, "| transitionId:", u13);
                if u13 == u55 then
                    u53:_PlayNext();
                else
                    u2("  STALE transitionId, ignoring Ended");
                end;
            end);
        else
            u2("  no nextSound, clearing currentSound");
            u8 = nil;
        end;
    end;
end;
function v3._ResolveWeatherValuesName(_) --[[ Line: 295 ]]
    -- upvalues: u2 (copy), l__WeatherData__6 (copy), l__WeatherValues__4 (copy), u1 (copy)
    u2("_ResolveWeatherValuesName checking WeatherData.Data...");
    for _, v67 in l__WeatherData__6.Data do
        if v67.AlwaysOn ~= true then
            local v68 = l__WeatherValues__4:FindFirstChild(v67.Name);
            if v68 and v68:IsA("Folder") then
                local v69 = v68:FindFirstChild("Playing");
                if v69 and v69:IsA("BoolValue") then
                    u2("  WeatherData entry:", v67.Name, "| Playing:", v69.Value);
                    if v69.Value then
                        u2("  >>> ACTIVE weather from WeatherData:", v67.Name);
                        return v67.Name;
                    end;
                end;
            end;
        end;
    end;
    u2("  checking loose WeatherValues folders...");
    for _, v70 in l__WeatherValues__4:GetChildren() do
        if v70:IsA("Folder") then
            local v71 = v70:FindFirstChild("Playing");
            if v71 and v71:IsA("BoolValue") then
                u2("  loose folder:", v70.Name, "| Playing:", v71.Value, "| AlwaysOn:", u1[v70.Name] or false);
                if v71.Value and not u1[v70.Name] then
                    u2("  >>> ACTIVE weather from loose folder:", v70.Name);
                    return v70.Name;
                end;
            end;
        end;
    end;
    u2("  no active weather found");
    return nil;
end;
function v3._ResolveTargetFolder(p72) --[[ Line: 331 ]]
    -- upvalues: u2 (copy), l__MusicTracks__7 (copy), u23 (copy), u18 (ref), l__Day__8 (copy)
    u2("--- _ResolveTargetFolder ---");
    local v73 = p72:_ResolveWeatherValuesName();
    if v73 then
        local v74 = l__MusicTracks__7:FindFirstChild(v73);
        if v74 and v74:IsA("Folder") then
            local v75 = #u23(v74);
            u2("  weatherValues folder:", v73, "| playable tracks:", v75);
            if v75 > 0 then
                u2("  >>> using WeatherValues folder:", v73);
                return v74;
            end;
        else
            u2("  WARNING: WeatherValues says", v73, "but no matching MusicTracks folder found!");
        end;
    end;
    if u18 then
        u2("  timeCycleWeatherName:", u18);
        local v76 = l__MusicTracks__7:FindFirstChild(u18);
        if v76 and v76:IsA("Folder") then
            local v77 = #u23(v76);
            u2("  timeCycle folder:", u18, "| playable tracks:", v77);
            if v77 > 0 then
                u2("  >>> using TimeCycle folder:", u18);
                return v76;
            end;
        else
            u2("  WARNING: timeCycle says", u18, "but no matching MusicTracks folder found!");
        end;
    else
        u2("  timeCycleWeatherName is nil");
    end;
    u2("  >>> falling back to Day folder");
    return l__Day__8;
end;
function v3._SetFolder(p78, p79) --[[ Line: 373 ]]
    -- upvalues: u2 (copy), u7 (ref), u8 (ref), u38 (copy), u11 (ref), u41 (copy)
    u2("_SetFolder:", p79.Name, "| currentFolder:", u7.Name, "| currentSound:", u8 and u8.Name or "nil");
    if p79 == u7 and u8 then
        u2("  same folder & has currentSound, skipping");
    else
        if p79 ~= u7 then
            u2("  folder CHANGED:", u7.Name, "->", p79.Name);
            u7 = p79;
            u38(p79, u11);
        end;
        p78:_CrossFadeTo((u41(p79)));
    end;
end;
function v3._PlayNext(p80) --[[ Line: 391 ]]
    -- upvalues: u2 (copy), u7 (ref), u41 (copy)
    u2("=== _PlayNext ===");
    local v81 = p80:_ResolveTargetFolder();
    u2("  resolved folder:", v81.Name, "| currentFolder:", u7.Name);
    if v81 == u7 then
        p80:_CrossFadeTo((u41(u7)));
    else
        u2("  folder changed during _PlayNext, calling _SetFolder");
        p80:_SetFolder(v81);
    end;
end;
function v3._Refresh(p82) --[[ Line: 406 ]]
    -- upvalues: u2 (copy), l__MusicTracks__7 (copy)
    u2("=== _Refresh ===");
    for _, v83 in l__MusicTracks__7:GetChildren() do
        if v83:IsA("Folder") then
            for _, v84 in v83:GetChildren() do
                if v84:IsA("Sound") and v84.IsPlaying then
                    u2("  CURRENTLY PLAYING:", v84.Name, "in", v83.Name, "| vol:", string.format("%.3f", v84.Volume));
                end;
            end;
        end;
    end;
    p82:_SetFolder((p82:_ResolveTargetFolder()));
end;
function v3._QueueRefresh(u85) --[[ Line: 423 ]]
    -- upvalues: u2 (copy), u19 (ref)
    u2("_QueueRefresh called | already queued:", u19);
    if u19 then
    else
        u19 = true;
        task.defer(function() --[[ Line: 430 ]]
            -- upvalues: u2 (ref), u19 (ref), u85 (copy)
            u2("_QueueRefresh deferred fire");
            u19 = false;
            u85:_Refresh();
        end);
    end;
end;
function v3._HookWeatherFolder(u86, u87) --[[ Line: 437 ]]
    -- upvalues: u2 (copy)
    local u88 = u87:FindFirstChild("Playing");
    if u88 and u88:IsA("BoolValue") then
        u2("Hooking weather folder:", u87.Name);
        u88.Changed:Connect(function() --[[ Line: 444 ]]
            -- upvalues: u2 (ref), u87 (copy), u88 (copy), u86 (copy)
            u2("Playing.Changed on weather folder:", u87.Name, "| new value:", u88.Value);
            u86:_QueueRefresh();
        end);
    end;
end;
function v3.SetActiveWeather(p89, p90) --[[ Line: 450 ]]
    -- upvalues: u2 (copy), u18 (ref)
    u2("=== SetActiveWeather:", tostring(p90), "| previous timeCycle:", tostring(u18), "===");
    u18 = p90;
    p89:_QueueRefresh();
end;
function v3.Init(_) --[[ Line: 456 ]] end;
function v3.Start(u91) --[[ Line: 458 ]]
    -- upvalues: u2 (copy), l__WeatherValues__4 (copy), l__MusicTracks__7 (copy)
    u2("=== MusicController:Start ===");
    for _, v92 in l__WeatherValues__4:GetChildren() do
        if v92:IsA("Folder") then
            u91:_HookWeatherFolder(v92);
        end;
    end;
    l__WeatherValues__4.ChildAdded:Connect(function(p93) --[[ Line: 467 ]]
        -- upvalues: u2 (ref), u91 (copy)
        if p93:IsA("Folder") then
            u2("WeatherValues.ChildAdded:", p93.Name);
            u91:_HookWeatherFolder(p93);
            u91:_QueueRefresh();
        end;
    end);
    l__MusicTracks__7.ChildAdded:Connect(function(p94) --[[ Line: 475 ]]
        -- upvalues: u2 (ref), u91 (copy)
        u2("MusicTracks.ChildAdded:", p94.Name);
        u91:_QueueRefresh();
    end);
    l__MusicTracks__7.ChildRemoved:Connect(function(p95) --[[ Line: 479 ]]
        -- upvalues: u2 (ref), u91 (copy)
        u2("MusicTracks.ChildRemoved:", p95.Name);
        u91:_QueueRefresh();
    end);
end;
return v3;