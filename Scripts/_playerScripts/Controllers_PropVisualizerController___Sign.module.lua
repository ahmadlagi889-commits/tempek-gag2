-- Decompiled with Potassium's decompiler.

local l__Networking__1 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"));
local l__Players__2 = game:GetService("Players");
game:GetService("RunService");
local l__SmartProximityPrompt__3 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("SmartProximityPrompt"));
local u1 = require("../GuiController");
local l__NotificationController__4 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__SignChangeTextMenu__5 = l__Players__2.LocalPlayer.PlayerGui:WaitForChild("SignChangeTextMenu");
local u2 = 0;
return function(u3) --[[ Line: 12 ]]
    -- upvalues: l__Players__2 (copy), l__SmartProximityPrompt__3 (copy), u1 (copy), l__SignChangeTextMenu__5 (copy), u2 (ref), l__NotificationController__4 (copy), l__Networking__1 (copy)
    local v4;
    repeat
        v4 = game:GetService("Players"):GetPlayerByUserId(u3:GetAttribute("UserId"));
    until v4 and u3:IsDescendantOf(workspace);
    local v5 = v4.UserId == l__Players__2.LocalPlayer.UserId and u3:FindFirstChild("Primary");
    if v5 then
        local v6 = Instance.new("ProximityPrompt");
        v6.Name = "ChangeSignTextPrompt";
        v6.ActionText = "Change Text";
        v6.ObjectText = "Sign";
        v6.HoldDuration = 0;
        v6.RequiresLineOfSight = false;
        v6.MaxActivationDistance = 10;
        v6.Parent = v5;
        if v6 and v6:IsA("ProximityPrompt") then
            l__SmartProximityPrompt__3.AttachToModel(v6, u3, {
                PartName = "ChangeSignTextPrompt",
                MaxActivationDistance = 10,
                TrackDistance = 24,
                SurfaceOffset = 0.75,
                FollowSpeed = 18
            });
            v6.Triggered:Connect(function() --[[ Line: 38 ]]
                -- upvalues: u1 (ref), l__SignChangeTextMenu__5 (ref), u3 (copy)
                u1:Open("SignChangeTextMenu");
                l__SignChangeTextMenu__5.Frame.Input.Text = u3:GetAttribute("ExtraData");
                l__SignChangeTextMenu__5.Frame.Input:CaptureFocus();
                l__SignChangeTextMenu__5:SetAttribute("CurrentId", u3:GetAttribute("PropId"));
                l__SignChangeTextMenu__5.Frame.CharCount.Text = `{#u3:GetAttribute("ExtraData")}/100`;
            end);
            l__SignChangeTextMenu__5.Frame.Input:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 46 ]]
                -- upvalues: l__SignChangeTextMenu__5 (ref), u3 (copy)
                l__SignChangeTextMenu__5.Frame.CharCount.Text = `{#l__SignChangeTextMenu__5.Frame.Input.Text}/100`;
                if u3:GetAttribute("PropId") == l__SignChangeTextMenu__5:GetAttribute("CurrentId") then
                    local v7 = u3:FindFirstChild("TextLabel", true);
                    if not v7 then
                        return;
                    end;
                    v7.Text = l__SignChangeTextMenu__5.Frame.Input.Text;
                end;
            end);
            l__SignChangeTextMenu__5.Frame.Input.FocusLost:Connect(function() --[[ Line: 55 ]]
                -- upvalues: u3 (copy), l__SignChangeTextMenu__5 (ref), u2 (ref), u1 (ref), l__NotificationController__4 (ref), l__Networking__1 (ref)
                if u3:GetAttribute("PropId") == l__SignChangeTextMenu__5:GetAttribute("CurrentId") then
                    l__SignChangeTextMenu__5:SetAttribute("CurrentId", nil);
                    local v8 = os.clock();
                    local v9 = 5 - (v8 - u2);
                    if v9 > 0 then
                        u1:Close("SignChangeTextMenu");
                        l__NotificationController__4:CreateNotification((`Please wait {math.ceil(v9)}s before changing sign text.`));
                    else
                        u2 = v8;
                        l__Networking__1.Prop.SetPropExtraData:Fire(u3:GetAttribute("PropId"), l__SignChangeTextMenu__5.Frame.Input.Text);
                        u1:Close("SignChangeTextMenu");
                    end;
                end;
            end);
        end;
    end;
    local function v12() --[[ Line: 75 ]]
        -- upvalues: u3 (copy)
        local v10 = u3:GetAttribute("ExtraData") or "";
        local v11 = u3:FindFirstChild("TextLabel", true);
        if v11 then
            v11.Text = v10;
        end;
    end;
    local v13 = u3:GetAttribute("ExtraData") or "";
    local v14 = u3:FindFirstChild("TextLabel", true);
    if v14 then
        v14.Text = v13;
    end;
    u3:GetAttributeChangedSignal("ExtraData"):Connect(v12);
end;