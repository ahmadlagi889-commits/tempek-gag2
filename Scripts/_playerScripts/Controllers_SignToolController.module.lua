-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__SignToolChangeTextMenu__2 = l__LocalPlayer__1:WaitForChild("PlayerGui"):WaitForChild("SignToolChangeTextMenu");
local l__Networking__3 = require(game.ReplicatedStorage.SharedModules.Networking);
local u2 = require("./GuiController");
local l__NotificationController__4 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local u3 = false;
local u4 = 0;
local function u7() --[[ Line: 16 ]]
    -- upvalues: u3 (ref), l__LocalPlayer__1 (copy), u2 (copy), l__SignToolChangeTextMenu__2 (copy)
    if u3 then
    else
        u3 = true;
        local v5 = l__LocalPlayer__1:FindFirstChild("SignText");
        local v6 = v5 and v5.Value or "";
        u2:Open("SignToolChangeTextMenu");
        l__SignToolChangeTextMenu__2.Frame.Input.Text = v6;
        l__SignToolChangeTextMenu__2.Frame.Input:CaptureFocus();
        l__SignToolChangeTextMenu__2.Frame.CharCount.Text = `{#v6}/{100}`;
    end;
end;
local function u10() --[[ Line: 29 ]]
    -- upvalues: u3 (ref), u4 (ref), u2 (copy), l__NotificationController__4 (copy), l__SignToolChangeTextMenu__2 (copy), l__Networking__3 (copy)
    if u3 then
        u3 = false;
        local v8 = os.clock();
        local v9 = 5 - (v8 - u4);
        if v9 > 0 then
            u2:Close("SignToolChangeTextMenu");
            l__NotificationController__4:CreateNotification((`Please wait {math.ceil(v9)}s before changing sign text.`));
        else
            u4 = v8;
            local l__Text__5 = l__SignToolChangeTextMenu__2.Frame.Input.Text;
            if #l__Text__5 > 100 then
                l__Text__5 = string.sub(l__Text__5, 1, 100);
            end;
            l__Networking__3.SignTool.SetSignText:Fire(l__Text__5);
            u2:Close("SignToolChangeTextMenu");
        end;
    end;
end;
function v1.Init(_) --[[ Line: 51 ]] end;
function v1.Start(_) --[[ Line: 54 ]]
    -- upvalues: l__SignToolChangeTextMenu__2 (copy), u10 (copy), l__LocalPlayer__1 (copy), u7 (copy)
    l__SignToolChangeTextMenu__2.Frame.Input:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 55 ]]
        -- upvalues: l__SignToolChangeTextMenu__2 (ref)
        local l__Text__6 = l__SignToolChangeTextMenu__2.Frame.Input.Text;
        if #l__Text__6 > 100 then
            l__SignToolChangeTextMenu__2.Frame.Input.Text = string.sub(l__Text__6, 1, 100);
        else
            l__SignToolChangeTextMenu__2.Frame.CharCount.Text = `{#l__Text__6}/{100}`;
        end;
    end);
    l__SignToolChangeTextMenu__2.Frame.Input.FocusLost:Connect(function() --[[ Line: 64 ]]
        -- upvalues: u10 (ref)
        u10();
    end);
    local u11 = l__LocalPlayer__1.Character or l__LocalPlayer__1.CharacterAdded:Wait();
    local function u13(p12) --[[ Line: 71 ]]
        -- upvalues: u7 (ref)
        if p12:IsA("Tool") then
            if p12:GetAttribute("Sign") then
                p12.Activated:Connect(function() --[[ Line: 75 ]]
                    -- upvalues: u7 (ref)
                    u7();
                end);
            end;
        end;
    end;
    u11.ChildAdded:Connect(u13);
    for _, v14 in u11:GetChildren() do
        u13(v14);
    end;
    l__LocalPlayer__1.CharacterAdded:Connect(function(p15) --[[ Line: 83 ]]
        -- upvalues: u11 (ref), u13 (copy)
        u11 = p15;
        u11.ChildAdded:Connect(u13);
    end);
end;
return v1;