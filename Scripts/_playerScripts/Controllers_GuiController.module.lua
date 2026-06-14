-- Decompiled with Potassium's decompiler.

({}).StartOrder = 3;
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__Lighting__4 = game:GetService("Lighting");
local l__FieldOfViewController__5 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController);
local l__PlayerGui__6 = l__Players__1.LocalPlayer:WaitForChild("PlayerGui");
local l__Signal__7 = require(l__ReplicatedStorage__2.ClientModules.Signal);
local u1 = {};
local u2 = {
    "TeleportButtons",
    "GrowingList",
    "PetList",
    "BackpackGui",
    "HUD",
    "MushroomUI"
};
local l__Blur__8 = l__Lighting__4.Blur;
local _ = workspace.CurrentCamera;
local u3 = l__Signal__7.new();
local u4 = l__Signal__7.new();
local u5 = l__Signal__7.new();
return {
    _Locked = false,
    Gui = nil,
    GuiFocusedSignal = u4,
    GuiUnfocusedSignal = u3,
    GuiHiddenSignal = u5,
    Unlock = function(p6) --[[ Name: Unlock, Line 99 ]]
        p6._Locked = false;
    end,
    Lock = function(p7) --[[ Name: Lock, Line 106 ]]
        p7._Locked = true;
    end,
    IsOpen = function(p8, p9) --[[ Name: IsOpen, Line 113 ]]
        -- upvalues: l__PlayerGui__6 (copy)
        local v10 = l__PlayerGui__6:FindFirstChild(p9);
        if v10 then
            return p8.Gui == v10 and true or v10.Enabled;
        else
            return false;
        end;
    end,
    Close = function(p11, p12) --[[ Name: Close, Line 130 ]]
        -- upvalues: u2 (copy), l__PlayerGui__6 (copy), u3 (copy), l__TweenService__3 (copy), l__Blur__8 (copy), l__FieldOfViewController__5 (copy)
        if p12 then
            p11._Locked = false;
        elseif p11._Locked then
            return;
        end;
        local l__Gui__9 = p11.Gui;
        if l__Gui__9 then
            l__Gui__9.Enabled = false;
            p11.Gui = nil;
            for _, v13 in u2 do
                local v14 = l__PlayerGui__6:FindFirstChild(v13);
                if v14 and v14.Name ~= "TouchGui" then
                    v14.Enabled = true;
                end;
            end;
            u3:Fire(l__Gui__9);
            l__TweenService__3:Create(l__Blur__8, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            l__FieldOfViewController__5:SetBaseFOV(70);
        end;
    end,
    Open = function(p15, p16, p17, p18) --[[ Name: Open, Line 153 ]]
        -- upvalues: l__PlayerGui__6 (copy), u2 (copy), u4 (copy), l__TweenService__3 (copy), l__Blur__8 (copy), l__FieldOfViewController__5 (copy)
        if p17 then
            p15._Locked = false;
        elseif p15._Locked then
            return;
        end;
        local v19 = l__PlayerGui__6:FindFirstChild(p16);
        if v19 then
            if v19:IsA("ScreenGui") then
                if p15.Gui then
                    p15:Close(p17);
                end;
                p15.Gui = v19;
                if p15.Gui then
                    p15.Gui.Enabled = true;
                end;
                local v20 = p18 or nil;
                for _, v21 in u2 do
                    if not (v20 and table.find(v20, v21)) then
                        local v22 = l__PlayerGui__6:FindFirstChild(v21);
                        if v22 and v22.Name ~= "TouchGui" then
                            v22.Enabled = false;
                        end;
                    end;
                end;
                u4:Fire(v19);
                l__TweenService__3:Create(l__Blur__8, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = 20
                }):Play();
                l__FieldOfViewController__5:SetBaseFOV(60);
            end;
        end;
    end,
    Hook = function(_, p23, ...) --[[ Name: Hook, Line 191 ]]
        -- upvalues: u1 (copy)
        local v24 = u1[p23];
        if v24 then
            return v24.new(...);
        end;
    end,
    SetHUDVisibility = function(_, p25) --[[ Name: SetHUDVisibility, Line 203 ]]
        -- upvalues: u5 (copy)
        u5:Fire(p25);
    end,
    SnapshotHudStates = function(_) --[[ Name: SnapshotHudStates, Line 210 ]]
        -- upvalues: u2 (copy), l__PlayerGui__6 (copy)
        local v26 = {};
        for _, v27 in u2 do
            local v28 = l__PlayerGui__6:FindFirstChild(v27);
            if v28 then
                v26[v27] = v28.Enabled;
            end;
        end;
        return v26;
    end,
    RestoreHudStates = function(_, p29) --[[ Name: RestoreHudStates, Line 224 ]]
        -- upvalues: l__PlayerGui__6 (copy)
        if p29 then
            for v30, v31 in p29 do
                local v32 = l__PlayerGui__6:FindFirstChild(v30);
                if v32 and v32.Name ~= "TouchGui" then
                    v32.Enabled = v31;
                end;
            end;
        end;
    end,
    Init = function(_) --[[ Name: Init, Line 237 ]] end,
    Start = function(_) --[[ Name: Start, Line 241 ]]
        -- upvalues: u1 (copy)
        for _, u33 in script:WaitForChild("Components"):GetChildren() do
            if u33:IsA("ModuleScript") then
                local v34, _ = pcall(function() --[[ Line: 247 ]]
                    -- upvalues: u33 (copy)
                    return require(u33);
                end);
                if v34 then
                    u1[u33.Name] = require(u33);
                end;
            end;
        end;
    end
};