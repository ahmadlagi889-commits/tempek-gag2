-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__LocalPlayer__1 = game.Players.LocalPlayer;
game:GetService("TweenService");
local l__Gardens__2 = workspace:WaitForChild("Gardens");
local l__Networking__3 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"));
local l__ExpansionPrices__4 = require(game.ReplicatedStorage.SharedData.ExpansionPrices);
local l__GardenFlags__5 = require(game.ReplicatedStorage.SharedModules.Flags.GardenFlags);
local l__NumberUtils__6 = require(game.ReplicatedStorage.SharedModules.NumberUtils);
local l__PlayerStateClient__7 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("PlayerStateClient"));
local l__Controllers__8 = game.StarterPlayer.StarterPlayerScripts.Controllers;
local l__FlashbangVFXController__9 = require(l__Controllers__8.FlashbangVFXController);
require(l__Controllers__8.NotificationController);
local u2 = require("./SfxController");
function v1.Init(_) --[[ Line: 15 ]] end;
local u3 = {};
local u4 = {};
local v5 = nil;
local l__Night__10 = game.ReplicatedStorage.Night;
local l__NotificationController__11 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local u6 = require(game.ReplicatedStorage.SharedModules.Environment).placeType == "FirstSession";
local u7 = {};
local u8 = v5;
local function u12(p9) --[[ Line: 81 ]]
    -- upvalues: l__Night__10 (copy), u6 (copy), l__LocalPlayer__1 (copy), l__NotificationController__11 (copy)
    local v10 = p9.Adornee.Parent.Parent:GetAttribute("Owner");
    if v10 == nil then
    else
        local v11 = game.Players:FindFirstChild(v10);
        if l__Night__10.Value == false then
            p9.PlayerFrame.Unlocked.Visible = false;
            p9.PlayerFrame.fade.Visible = false;
            p9.PlayerFrame.toptext.Visible = false;
        elseif v11:GetAttribute("IsInOwnGarden") == true then
            if p9.PlayerFrame.Unlocked.Visible == true and (u6 and v11 == l__LocalPlayer__1) then
                l__NotificationController__11:CreateNotification("Garden Locked!🔒");
            end;
            p9.PlayerFrame.Unlocked.Visible = false;
            p9.PlayerFrame.fade.Visible = false;
            p9.PlayerFrame.toptext.Visible = false;
        else
            if p9.PlayerFrame.Unlocked.Visible == false and (u6 and v11 == l__LocalPlayer__1) then
                l__NotificationController__11:CreateNotification("Garden Unlocked!🔓");
            end;
            p9.PlayerFrame.Unlocked.Visible = true;
            p9.PlayerFrame.fade.Visible = true;
            p9.PlayerFrame.toptext.Visible = true;
        end;
    end;
end;
local function u16(p13, p14) --[[ Line: 52 ]]
    for _, v15 in p13:GetDescendants() do
        if v15:IsA("BasePart") then
            v15.Transparency = p14 and 0 or 1;
            v15.CanCollide = p14;
        elseif v15:IsA("Decal") then
            v15.Transparency = p14 and 0 or 1;
        elseif v15:IsA("SurfaceGui") or v15:IsA("BillboardGui") then
            v15.Enabled = p14;
        end;
    end;
end;
local function u20(p17) --[[ Line: 37 ]]
    local v18 = p17:FindFirstChild("SurfaceGui");
    if v18 and (v18:IsA("BillboardGui") or v18:IsA("SurfaceGui")) then
        return v18;
    end;
    for _, v19 in p17:GetChildren() do
        if v19:IsA("BillboardGui") or v19:IsA("SurfaceGui") then
            return v19;
        end;
    end;
    return nil;
end;
for _, v21 in pairs(u7) do
    u12(v21);
end;
l__Night__10:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 117 ]]
    -- upvalues: u7 (copy), u12 (copy)
    for _, v22 in pairs(u7) do
        u12(v22);
    end;
end);
function v1.Start(_) --[[ Line: 123 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u7 (copy), u12 (copy), u3 (copy), u4 (copy), u8 (ref), l__Gardens__2 (copy), u16 (copy), u20 (copy), l__PlayerStateClient__7 (copy), l__ExpansionPrices__4 (copy), l__GardenFlags__5 (copy), l__NumberUtils__6 (copy), u2 (copy), l__FlashbangVFXController__9 (copy), l__Networking__3 (copy), l__NotificationController__11 (copy)
    local function u35(p23) --[[ Line: 124 ]]
        -- upvalues: l__LocalPlayer__1 (ref), u7 (ref), u12 (ref), u3 (ref)
        local u24 = p23.Signs.Garden:FindFirstChild("SurfaceGui", true);
        if u24 then
            local u25 = p23:GetAttribute("Owner") or "";
            local v26 = p23:GetAttribute("OwnerUserId");
            local u27 = game.Players:FindFirstChild(u25);
            if not u27 and typeof(v26) == "number" then
                u27 = game.Players:GetPlayerByUserId(v26);
            end;
            local l__Parent__12 = u24.Parent;
            local l__Part__13 = l__Parent__12.Parent.Part;
            local u28 = l__LocalPlayer__1.PlayerGui:FindFirstChild(p23.Name) or script.BillboardGui:Clone();
            u28.ResetOnSpawn = false;
            u28.Parent = l__LocalPlayer__1.PlayerGui;
            u28.Adornee = p23.Visual.PRIM;
            u28.Name = p23.Name;
            u24.Enabled = true;
            l__Parent__12.Transparency = 0;
            l__Parent__12.CanCollide = true;
            l__Part__13.Transparency = 0;
            l__Part__13.CanCollide = true;
            u28.Enabled = true;
            table.insert(u7, u28);
            if typeof(v26) == "number" then
                u27:GetAttributeChangedSignal("IsInOwnGarden"):Connect(function() --[[ Line: 152 ]]
                    -- upvalues: u12 (ref), u28 (copy)
                    u12(u28);
                end);
            end;
            u12(u28);
            if typeof(v26) == "number" then
                if u27 then
                    u25 = u27.DisplayName or u25;
                end;
                local function v34() --[[ Line: 173 ]]
                    -- upvalues: u27 (ref), u24 (copy), u28 (copy), u25 (copy), l__LocalPlayer__1 (ref)
                    local v29 = u27;
                    if v29 then
                        v29 = u27:GetAttribute("GuildTag");
                    end;
                    local v30 = u27;
                    if v30 then
                        v30 = u27:GetAttribute("GuildTagColor");
                    end;
                    local v31 = u27;
                    if v31 then
                        v31 = u27:GetAttribute("GuildColor");
                    end;
                    local v32 = false;
                    if typeof(v30) == "string" and v30 ~= "" then
                        v31 = v30;
                        v32 = true;
                    elseif typeof(v31) == "string" and v31 ~= "" then
                        v32 = true;
                    else
                        v31 = "#FFFFFF";
                    end;
                    local v33 = (typeof(v29) ~= "string" or v29 == "") and "" or `<font color="{v31}">[{v29}]</font> `;
                    if v32 then
                        u24.Player.TextLabel.RichText = true;
                    else
                        u24.Player.TextLabel.RichText = false;
                    end;
                    u28.PlayerFrame.Title.RichText = true;
                    u24.Player.TextLabel.Text = `{v33}{u25}'s Garden`;
                    u28.PlayerFrame.Title.Text = u27 == l__LocalPlayer__1 and `{v33}Your Garden` or `{v33}{u25}'s Garden`;
                end;
                v34();
                u24.ImageLabel.Image = `rbxthumb://type=AvatarHeadShot&id={v26}&w=150&h=150`;
                u24.ImageLabel.Visible = true;
                u28.PlayerFrame.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={v26}&w=420&h=420`;
                if u27 then
                    u27:GetAttributeChangedSignal("GuildTag"):Connect(v34);
                    u27:GetAttributeChangedSignal("GuildColor"):Connect(v34);
                    u27:GetAttributeChangedSignal("GuildTagColor"):Connect(v34);
                end;
                if u3[p23.Name] then
                    u3[p23.Name]:Disconnect();
                end;
            else
                u24.Player.TextLabel.Text = "Empty Garden";
                u24.ImageLabel.Image = "";
                u24.ImageLabel.Visible = false;
                u28.PlayerFrame.Title.Text = "Empty Garden";
                u28.PlayerFrame.Headshot.Image = "";
                u28.Enabled = false;
                if u3[p23.Name] then
                    u3[p23.Name]:Disconnect();
                    u3[p23.Name] = nil;
                end;
            end;
        end;
    end;
    local u36 = false;
    local function v67() --[[ Line: 230 ]]
        -- upvalues: u4 (ref), u8 (ref), l__LocalPlayer__1 (ref), l__Gardens__2 (ref), u36 (ref), u35 (copy), u16 (ref), u20 (ref), l__PlayerStateClient__7 (ref), l__ExpansionPrices__4 (ref), l__GardenFlags__5 (ref), l__NumberUtils__6 (ref), u2 (ref), l__FlashbangVFXController__9 (ref), l__Networking__3 (ref), l__NotificationController__11 (ref)
        for _, v37 in u4 do
            v37:Disconnect();
        end;
        table.clear(u4);
        if u8 then
            u8:Destroy();
            u8 = nil;
        end;
        local v38 = l__LocalPlayer__1:GetAttribute("PlotId");
        for _, u39 in l__Gardens__2:GetChildren() do
            if not u36 then
                u35(u39);
                u39:GetAttributeChangedSignal("Owner"):Connect(function() --[[ Line: 237 ]]
                    -- upvalues: u35 (ref), u39 (copy)
                    u35(u39);
                end);
                u39:GetAttributeChangedSignal("OwnerUserId"):Connect(function() --[[ Line: 240 ]]
                    -- upvalues: u35 (ref), u39 (copy)
                    u35(u39);
                end);
            end;
            local v40;
            if v38 then
                v40 = u39.Name == `Plot{v38}`;
            else
                v40 = v38;
            end;
            local v41 = u39:FindFirstChild("Signs");
            if v41 then
                v41 = v41:FindFirstChild("Expand");
            end;
            if v41 then
                u16(v41, v40 == true);
            end;
            if v41 then
                v41 = v41:FindFirstChild("CorePart");
            end;
            local v42;
            if v41 then
                v42 = u20(v41);
            else
                v42 = v41;
            end;
            if v40 then
                if workspace:GetAttribute("SkillPointsOn") == true then
                    local l__SkillData__14 = l__LocalPlayer__1:WaitForChild("SkillData", 5);
                    local u43;
                    if l__SkillData__14 then
                        u43 = l__SkillData__14:WaitForChild("SkillPoints", 5);
                    else
                        u43 = l__SkillData__14;
                    end;
                    local u44;
                    if l__SkillData__14 then
                        u44 = l__SkillData__14:WaitForChild("BaseSpeed", 5);
                    else
                        u44 = l__SkillData__14;
                    end;
                    local u45;
                    if l__SkillData__14 then
                        u45 = l__SkillData__14:WaitForChild("BaseJump", 5);
                    else
                        u45 = l__SkillData__14;
                    end;
                    local u46;
                    if l__SkillData__14 then
                        u46 = l__SkillData__14:WaitForChild("ShovelPower", 5);
                    else
                        u46 = l__SkillData__14;
                    end;
                    if l__SkillData__14 then
                        l__SkillData__14 = l__SkillData__14:WaitForChild("MaxBackpack", 5);
                    end;
                    if u43 and (u44 and (u45 and (u46 and l__SkillData__14))) then
                        local l__BillboardGui__15 = u39.Signs.Garden.CorePart.Notification.BillboardGui;
                        local l__Notification__16 = l__BillboardGui__15.Notification;
                        local function v48() --[[ Line: 269 ]]
                            -- upvalues: u43 (copy), u44 (copy), u45 (copy), u46 (copy), l__SkillData__14 (copy), l__BillboardGui__15 (copy), l__Notification__16 (copy)
                            local v47 = u43.Value >= math.min(u44.Value, u45.Value, u46.Value, l__SkillData__14.Value);
                            l__BillboardGui__15.Enabled = v47;
                            l__Notification__16.Visible = v47;
                        end;
                        local v49 = u43.Value >= math.min(u44.Value, u45.Value, u46.Value, l__SkillData__14.Value);
                        l__BillboardGui__15.Enabled = v49;
                        l__Notification__16.Visible = v49;
                        u43.Changed:Connect(v48);
                        u44.Changed:Connect(v48);
                        u45.Changed:Connect(v48);
                        u46.Changed:Connect(v48);
                        l__SkillData__14.Changed:Connect(v48);
                    end;
                else
                    local v50 = u39.Signs.Garden.CorePart:FindFirstChild("Notification");
                    if v50 then
                        v50 = v50:FindFirstChildWhichIsA("BillboardGui");
                    end;
                    if v50 then
                        v50.Enabled = false;
                        local v51 = v50:FindFirstChild("Notification");
                        if v51 and v51:IsA("GuiObject") then
                            v51.Visible = false;
                        end;
                    end;
                end;
                if v41 and v42 then
                    local v52 = v42:Clone();
                    v42:Destroy();
                    v52.Name = "ExpandSignGui";
                    v52.ResetOnSpawn = false;
                    v52.Parent = l__LocalPlayer__1.PlayerGui;
                    v52.Adornee = v41;
                    v52.Enabled = true;
                    u8 = v52;
                    local u53 = v52:FindFirstChild("TextButton", true);
                    local u54 = v52:FindFirstChild("TextLabel", true);
                    if u53 and (u53:IsA("GuiButton") and (u54 and u54:IsA("TextLabel"))) then
                        local u55 = l__PlayerStateClient__7:WaitForLocalReplica(30);
                        local l__Sheckles__17 = l__LocalPlayer__1:WaitForChild("leaderstats"):WaitForChild("Sheckles");
                        local u56 = true;
                        local function v62() --[[ Line: 320 ]]
                            -- upvalues: u55 (copy), l__ExpansionPrices__4 (ref), l__GardenFlags__5 (ref), u53 (copy), l__Sheckles__17 (copy), u54 (copy), l__NumberUtils__6 (ref)
                            local v57 = u55 and (u55.Data.OwnedExpansions or 1) or 1;
                            local v58 = l__ExpansionPrices__4[v57 + 1];
                            if v58 then
                                local v59 = l__GardenFlags__5.ExpansionPriceOverrides:Get()[tostring(v57 + 1)] or v58.Price;
                                u53.Active = true;
                                local v60 = u53;
                                local v61;
                                if v59 <= l__Sheckles__17.Value then
                                    v61 = Color3.new(0, 0.666667, 0);
                                else
                                    v61 = Color3.new(1, 0, 0);
                                end;
                                v60.BackgroundColor3 = v61;
                                u54.Text = l__NumberUtils__6.Abbreviate(v59) .. "¢";
                            else
                                u53.Active = false;
                                u53.BackgroundColor3 = Color3.new(1, 0, 0);
                                u54.Text = "MAX";
                            end;
                        end;
                        table.insert(u4, u53.Activated:Connect(function() --[[ Line: 338 ]]
                            -- upvalues: l__LocalPlayer__1 (ref), u56 (ref), u55 (copy), l__ExpansionPrices__4 (ref), l__GardenFlags__5 (ref), l__Sheckles__17 (copy), u2 (ref), l__FlashbangVFXController__9 (ref), l__Networking__3 (ref), l__NotificationController__11 (ref)
                            if l__LocalPlayer__1:GetAttribute("LoadingScreenActive") then
                            elseif l__LocalPlayer__1:GetAttribute("IsStealingFruit") or l__LocalPlayer__1:GetAttribute("CarryingStolenFruit") then
                            elseif u56 then
                                local v63 = u55 and (u55.Data.OwnedExpansions or 1) or 1;
                                local v64 = l__ExpansionPrices__4[v63 + 1];
                                if v64 then
                                    if (l__GardenFlags__5.ExpansionPriceOverrides:Get()[tostring(v63 + 1)] or v64.Price) <= l__Sheckles__17.Value then
                                        u56 = false;
                                        u2:PlaySFX("Purchase");
                                        l__FlashbangVFXController__9:Flash(0.5);
                                        task.spawn(function() --[[ Line: 353 ]]
                                            -- upvalues: l__Networking__3 (ref), u56 (ref)
                                            task.wait(0.5);
                                            l__Networking__3.Actions.ExpandGarden:Fire();
                                            u56 = true;
                                        end);
                                    else
                                        u2:PlaySFX("Failed");
                                        l__NotificationController__11:CreateNotification("You can\'t afford this!");
                                    end;
                                end;
                            end;
                        end));
                        local v65 = u4;
                        local v66 = l__Sheckles__17:GetPropertyChangedSignal("Value");
                        table.insert(v65, v66:Connect(v62));
                        table.insert(u4, l__GardenFlags__5.ExpansionPriceOverrides.Changed:Connect(v62));
                        table.insert(u4, l__GardenFlags__5.ExpansionPriceOverrides.Loaded:Connect(v62));
                        if u55 then
                            table.insert(u4, u55:OnSet({ "OwnedExpansions" }, v62));
                        end;
                        v62();
                    end;
                end;
            end;
        end;
        u36 = true;
    end;
    v67();
    l__LocalPlayer__1:GetAttributeChangedSignal("PlotId"):Connect(v67);
end;
return v1;