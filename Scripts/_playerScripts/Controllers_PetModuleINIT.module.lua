-- Decompiled with Potassium's decompiler.

return {
    Init = function(_) --[[ Name: Init, Line 3 ]]
        for _, v1 in pairs(script.Parent.PetVisualController.ClientPetControllers:GetChildren()) do
            require(v1):Init();
        end;
    end
};