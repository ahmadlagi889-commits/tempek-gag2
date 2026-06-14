-- Decompiled with Potassium's decompiler.

task.defer(function() --[[ Line: 21 ]]
    game:GetService("RunService");
    local l__VERSION__1 = require(script.Parent.VERSION);
    l__VERSION__1.getAppVersion();
    l__VERSION__1.getLatestVersion();
    local _ = not l__VERSION__1.isUpToDate();
end);
return {};