-- Decompiled with Potassium's decompiler.

local function v1() --[[ Line: 10 ]]
    local l__Parent__1 = script.Parent.Parent.Parent;
    local l__Offset__2 = l__Parent__1.Size.X.Offset;
    local l__Offset__3 = l__Parent__1.Size.Y.Offset;
    if #script.Parent.Parent.ActionText.Text > 0 and #script.Parent.Parent.ObjectText.Text > 0 then
        script.Parent.Size = UDim2.new(0, l__Offset__2 * 1.56, 0, l__Offset__3 * 2.53);
        script.Parent.Image = "rbxassetid://80621645904046";
    else
        script.Parent.Size = UDim2.new(0, l__Offset__2 * 1.67, 0, l__Offset__3 * 1.67);
        script.Parent.Image = "rbxassetid://130991436152844";
    end;
end;
v1();
script.Parent.Parent.Parent:GetPropertyChangedSignal("Size"):Connect(v1);