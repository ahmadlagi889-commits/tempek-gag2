-- Decompiled with Potassium's decompiler.

local l__CommonUtils__1 = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(l__CommonUtils__1:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2");
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Exclude;
local u3 = {
    spacing = 8,
    image = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
    imageSize = Vector2.new(2, 2)
};
local u4 = Instance.new("Model");
u4.Name = "PathDisplayPoints";
local v5 = Instance.new("Part");
v5.Anchored = true;
v5.CanCollide = false;
v5.Transparency = 1;
v5.Name = "PathDisplayAdornee";
v5.CFrame = CFrame.new(0, 0, 0);
v5.Parent = u4;
local u6 = 30;
local u7 = {};
local u8 = {};
local u9 = {};
for v10 = 1, u6 do
    local v11 = Instance.new("ImageHandleAdornment");
    v11.Archivable = false;
    v11.Adornee = v5;
    v11.Image = u3.image;
    v11.Size = u3.imageSize;
    u7[v10] = v11;
end;
local function u21(p12, _) --[[ Line: 57 ]]
    -- upvalues: u6 (ref), u7 (copy), u1 (copy), u2 (copy), u4 (copy)
    if u6 == 0 then
        return nil;
    else
        local v13 = u7[1];
        if v13 then
            local v14 = u7;
            local v15 = u6;
            u7[1] = u7[u6];
            v14[v15] = nil;
            u6 = u6 - 1;
        else
            v13 = nil;
        end;
        if u1 then
            u2.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
            local v16 = workspace:Raycast(p12 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0), u2);
            if not v16 then
                return nil;
            end;
            v13.CFrame = CFrame.lookAlong(v16.Position, v16.Normal);
            v13.Parent = u4;
            return v13;
        else
            local v17 = Ray.new(p12 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0));
            local v18, v19, v20 = workspace:FindPartOnRayWithIgnoreList(v17, { game.Players.LocalPlayer.Character, workspace.CurrentCamera });
            if not v18 then
                return nil;
            end;
            v13.CFrame = CFrame.new(v19, v19 + v20);
            v13.Parent = u4;
            return v13;
        end;
    end;
end;
function u3.setCurrentPoints(p22) --[[ Line: 89 ]]
    -- upvalues: u8 (ref)
    if typeof(p22) == "table" then
        u8 = p22;
    else
        u8 = {};
    end;
end;
function u3.clearRenderedPath() --[[ Line: 97 ]]
    -- upvalues: u9 (ref), u6 (ref), u7 (copy), u4 (copy)
    for _, v23 in ipairs(u9) do
        v23.Parent = nil;
        u6 = u6 + 1;
        u7[u6] = v23;
    end;
    u9 = {};
    u4.Parent = nil;
end;
function u3.renderPath() --[[ Line: 106 ]]
    -- upvalues: u3 (copy), u8 (ref), u9 (ref), u21 (copy), u4 (copy)
    u3.clearRenderedPath();
    if u8 and #u8 ~= 0 then
        local v24 = #u8;
        u9[1] = u21(u8[v24], true);
        if u9[1] then
            local v25 = 0;
            while true do
                local v26 = u8[v24];
                local v27 = u8[v24 - 1];
                if v24 < 2 then
                    break;
                end;
                local v28 = v27 - v26;
                local l__magnitude__2 = v28.magnitude;
                if l__magnitude__2 < v25 then
                    v25 = v25 - l__magnitude__2;
                    v24 = v24 - 1;
                else
                    local v29 = u21(v26 + v28.unit * v25, false);
                    if v29 then
                        u9[#u9 + 1] = v29;
                    end;
                    v25 = v25 + u3.spacing;
                end;
            end;
            u4.Parent = workspace.CurrentCamera;
        end;
    end;
end;
return u3;