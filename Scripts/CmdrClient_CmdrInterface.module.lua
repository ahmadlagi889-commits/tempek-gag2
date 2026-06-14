-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
return function(u1) --[[ Line: 6 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    local l__Util__2 = u1.Util;
    local l__Window__3 = require(script:WaitForChild("Window"));
    l__Window__3.Cmdr = u1;
    local u2 = require(script:WaitForChild("AutoComplete"))(u1);
    l__Window__3.AutoComplete = u2;
    function l__Window__3.ProcessEntry(p3) --[[ Line: 17 ]]
        -- upvalues: l__Util__2 (copy), l__Window__3 (copy), u1 (copy), l__LocalPlayer__1 (ref)
        local v4 = l__Util__2.TrimString(p3);
        if #v4 == 0 then
        else
            l__Window__3:AddLine(l__Window__3:GetLabel() .. " " .. v4, Color3.fromRGB(255, 223, 93));
            l__Window__3:AddLine(u1.Dispatcher:EvaluateAndRun(v4, l__LocalPlayer__1, {
                IsHuman = true
            }));
        end;
    end;
    function l__Window__3.OnTextChanged(p5) --[[ Line: 30 ]]
        -- upvalues: u1 (copy), l__LocalPlayer__1 (ref), l__Util__2 (copy), l__Window__3 (copy), u2 (copy)
        local v6 = u1.Dispatcher:Evaluate(p5, l__LocalPlayer__1, true);
        local v7 = l__Util__2.SplitString(p5);
        local v8 = table.remove(v7, 1);
        local v9;
        if v6 then
            v7 = l__Util__2.MashExcessArguments(v7, #v6.Object.Args);
            if #v7 == #v6.Object.Args then
                v9 = true;
            else
                v9 = false;
            end;
        else
            v9 = false;
        end;
        local v10;
        if v8 then
            v10 = #v7 > 0;
        else
            v10 = v8;
        end;
        if p5:sub(#p5, #p5):match("%s") and not v9 then
            v7[#v7 + 1] = "";
            v10 = true;
        end;
        if v6 and v10 then
            local v11, v12 = v6:Validate();
            l__Window__3:SetIsValidInput(v11, ("Validation errors: %s"):format(v12 or ""));
            local v13 = {};
            local v14 = v6:GetArgument(#v7);
            if v14 then
                local l__TextSegmentInProgress__4 = v14.TextSegmentInProgress;
                local v15 = false;
                if v14.RawSegmentsAreAutocomplete then
                    for v16, v17 in ipairs(v14.RawSegments) do
                        v13[v16] = { v17, v17 };
                    end;
                else
                    local v18, v19 = v14:GetAutocomplete();
                    v15 = (v19 or {}).IsPartial or false;
                    for v20, v21 in pairs(v18) do
                        v13[v20] = { l__TextSegmentInProgress__4, v21 };
                    end;
                end;
                local v22;
                if #l__TextSegmentInProgress__4 > 0 then
                    v22, v12 = v14:Validate();
                else
                    v22 = true;
                end;
                if not v9 and v22 then
                    l__Window__3:HideInvalidState();
                end;
                local v23 = u2;
                local v24 = {};
                if v9 then
                    v9 = #p5 - #l__TextSegmentInProgress__4 + (p5:sub(#p5, #p5):match("%s") and -1 or 0);
                end;
                v24.at = v9;
                v24.prefix = #v14.RawSegments == 1 and (v14.Prefix or "") or "";
                local v25;
                if #v6.Arguments == #v6.ArgumentDefinitions then
                    v25 = #l__TextSegmentInProgress__4 > 0;
                else
                    v25 = false;
                end;
                v24.isLast = v25;
                v24.numArgs = #v7;
                v24.command = v6;
                v24.arg = v14;
                v24.name = v14.Name .. (v14.Required and "" or "?");
                v24.type = v14.Type.DisplayName;
                v24.description = v22 == false and v12 and v12 or v14.Object.Description;
                v24.invalid = not v22;
                v24.isPartial = v15;
                return v23:Show(v13, v24);
            end;
        elseif v8 and #v7 == 0 then
            l__Window__3:SetIsValidInput(true);
            local v26 = u1.Registry:GetCommand(v8);
            local v27 = nil;
            if v26 then
                v27 = {
                    v26.Name,
                    v26.Name,
                    options = {
                        name = v26.Name,
                        description = v26.Description
                    }
                };
                local l__Args__5 = v26.Args;
                if l__Args__5 then
                    l__Args__5 = v26.Args[1];
                end;
                if type(l__Args__5) == "function" then
                    l__Args__5 = l__Args__5(v6);
                end;
                if l__Args__5 and (not l__Args__5.Optional and l__Args__5.Default == nil) then
                    l__Window__3:SetIsValidInput(false, "This command has required arguments.");
                    l__Window__3:HideInvalidState();
                end;
            else
                l__Window__3:SetIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(v8));
            end;
            local v28 = { v27 };
            for _, v29 in pairs(u1.Registry:GetCommandNames()) do
                if v8:lower() == v29:lower():sub(1, #v8) and (v27 == nil or v27[1] ~= v8) then
                    local v30 = u1.Registry:GetCommand(v29);
                    v28[#v28 + 1] = {
                        v8,
                        v29,
                        options = {
                            name = v30.Name,
                            description = v30.Description
                        }
                    };
                end;
            end;
            return u2:Show(v28);
        end;
        l__Window__3:SetIsValidInput(false, "Use the help command to see all available commands.");
        u2:Hide();
    end;
    l__Window__3:UpdateLabel();
    l__Window__3:UpdateWindowHeight();
    return {
        Window = l__Window__3,
        AutoComplete = u2
    };
end;