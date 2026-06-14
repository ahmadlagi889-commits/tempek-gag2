-- Decompiled with Potassium's decompiler.

local l__PropImages__1 = script.Parent.PropImages;
local v1 = {
    Data = {}
};
for _, v2 in game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Props"):GetChildren() do
    local l__Data__2 = v1.Data;
    local v3 = {
        PropName = v2.Name
    };
    local v4 = l__PropImages__1:FindFirstChild(v2.Name);
    v3.IMG = v4 and v4.Value or "";
    v3.ExtraDataFilter = v2:GetAttribute("ExtraDataFilter") == true;
    table.insert(l__Data__2, v3);
end;
return v1;