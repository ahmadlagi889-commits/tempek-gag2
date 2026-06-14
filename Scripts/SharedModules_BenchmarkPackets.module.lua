-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Packet__2 = require(l__ReplicatedStorage__1.SharedModules.Packet);
return {
    Start = l__Packet__2("BenchmarkStart", l__Packet__2.String, l__Packet__2.NumberF64, l__Packet__2.NumberF64),
    Result = l__Packet__2("BenchmarkResult", l__Packet__2.String, l__Packet__2.Any)
};