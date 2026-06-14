-- Decompiled with Potassium's decompiler.

return function() --[[ Line: 1 ]]
    local l__Parent__1 = require(script.Parent);
    describe("Trove", function() --[[ Line: 4 ]]
        -- upvalues: l__Parent__1 (copy)
        local u1 = nil;
        beforeEach(function() --[[ Line: 7 ]]
            -- upvalues: u1 (ref), l__Parent__1 (ref)
            u1 = l__Parent__1.new();
        end);
        afterEach(function() --[[ Line: 11 ]]
            -- upvalues: u1 (ref)
            if u1 then
                u1:Destroy();
                u1 = nil;
            end;
        end);
        it("should add and clean up roblox instance", function() --[[ Line: 18 ]]
            -- upvalues: u1 (ref)
            local v2 = Instance.new("Part");
            v2.Parent = workspace;
            u1:Add(v2);
            u1:Destroy();
            expect(v2.Parent).to.equal(nil);
        end);
        it("should add and clean up roblox connection", function() --[[ Line: 26 ]]
            -- upvalues: u1 (ref)
            local v3 = workspace.Changed:Connect(function() --[[ Line: 27 ]] end);
            u1:Add(v3);
            u1:Destroy();
            expect(v3.Connected).to.equal(false);
        end);
        it("should add and clean up a table with a destroy method", function() --[[ Line: 33 ]]
            -- upvalues: u1 (ref)
            local v5 = {
                Destroyed = false,
                Destroy = function(p4) --[[ Name: Destroy, Line 35 ]]
                    p4.Destroyed = true;
                end
            };
            u1:Add(v5);
            u1:Destroy();
            expect(v5.Destroyed).to.equal(true);
        end);
        it("should add and clean up a table with a disconnect method", function() --[[ Line: 43 ]]
            -- upvalues: u1 (ref)
            local v7 = {
                Connected = true,
                Disconnect = function(p6) --[[ Name: Disconnect, Line 45 ]]
                    p6.Connected = false;
                end
            };
            u1:Add(v7);
            u1:Destroy();
            expect(v7.Connected).to.equal(false);
        end);
        it("should add and clean up a function", function() --[[ Line: 53 ]]
            -- upvalues: u1 (ref)
            local u8 = false;
            u1:Add(function() --[[ Line: 55 ]]
                -- upvalues: u8 (ref)
                u8 = true;
            end);
            u1:Destroy();
            expect(u8).to.equal(true);
        end);
        it("should allow a custom cleanup method", function() --[[ Line: 62 ]]
            -- upvalues: u1 (ref)
            local v10 = {
                Cleaned = false,
                Cleanup = function(p9) --[[ Name: Cleanup, Line 64 ]]
                    p9.Cleaned = true;
                end
            };
            u1:Add(v10, "Cleanup");
            u1:Destroy();
            expect(v10.Cleaned).to.equal(true);
        end);
        it("should return the object passed to add", function() --[[ Line: 72 ]]
            -- upvalues: u1 (ref)
            local v11 = Instance.new("Part");
            local v12 = u1:Add(v11);
            expect(v11).to.equal(v12);
            u1:Destroy();
        end);
        it("should fail to add object without proper cleanup method", function() --[[ Line: 79 ]]
            -- upvalues: u1 (ref)
            local u13 = {};
            expect(function() --[[ Line: 81 ]]
                -- upvalues: u1 (ref), u13 (copy)
                u1:Add(u13);
            end).to.throw();
        end);
        it("should construct an object and add it", function() --[[ Line: 86 ]]
            -- upvalues: u1 (ref)
            local u14 = {};
            u14.__index = u14;
            function u14.new(p15) --[[ Line: 89 ]]
                -- upvalues: u14 (copy)
                local v16 = setmetatable({}, u14);
                v16._msg = p15;
                v16._destroyed = false;
                return v16;
            end;
            function u14.Destroy(p17) --[[ Line: 95 ]]
                p17._destroyed = true;
            end;
            local v18 = u1:Construct(u14, "abc");
            expect((typeof(v18))).to.equal("table");
            expect((getmetatable(v18))).to.equal(u14);
            expect(v18._msg).to.equal("abc");
            expect(v18._destroyed).to.equal(false);
            u1:Destroy();
            expect(v18._destroyed).to.equal(true);
        end);
        it("should connect to a signal", function() --[[ Line: 108 ]]
            -- upvalues: u1 (ref)
            local v19 = u1:Connect(workspace.Changed, function() --[[ Line: 109 ]] end);
            expect((typeof(v19))).to.equal("RBXScriptConnection");
            expect(v19.Connected).to.equal(true);
            u1:Destroy();
            expect(v19.Connected).to.equal(false);
        end);
        it("should remove an object", function() --[[ Line: 116 ]]
            -- upvalues: u1 (ref)
            local v20 = u1:Connect(workspace.Changed, function() --[[ Line: 117 ]] end);
            expect(u1:Remove(v20)).to.equal(true);
            expect(v20.Connected).to.equal(false);
        end);
        it("should not remove an object not in the trove", function() --[[ Line: 122 ]]
            -- upvalues: u1 (ref)
            local v21 = workspace.Changed:Connect(function() --[[ Line: 123 ]] end);
            expect(u1:Remove(v21)).to.equal(false);
            expect(v21.Connected).to.equal(true);
            v21:Disconnect();
        end);
        it("should attach to instance", function() --[[ Line: 129 ]]
            -- upvalues: u1 (ref)
            local v22 = Instance.new("Part");
            v22.Parent = workspace;
            local v23 = u1:AttachToInstance(v22);
            expect(v23.Connected).to.equal(true);
            v22:Destroy();
            expect(v23.Connected).to.equal(false);
        end);
        it("should fail to attach to instance not in hierarchy", function() --[[ Line: 138 ]]
            -- upvalues: u1 (ref)
            local u24 = Instance.new("Part");
            expect(function() --[[ Line: 140 ]]
                -- upvalues: u1 (ref), u24 (copy)
                u1:AttachToInstance(u24);
            end).to.throw();
        end);
        it("should extend itself", function() --[[ Line: 145 ]]
            -- upvalues: u1 (ref), l__Parent__1 (ref)
            local v25 = u1:Extend();
            local u26 = false;
            v25:Add(function() --[[ Line: 148 ]]
                -- upvalues: u26 (ref)
                u26 = true;
            end);
            expect(v25).to.be.a("table");
            expect((getmetatable(v25))).to.equal(l__Parent__1);
            u1:Clean();
            expect(u26).to.equal(true);
        end);
        it("should clone an instance", function() --[[ Line: 157 ]]
            -- upvalues: u1 (ref)
            local v27 = u1:Construct(Instance.new, "Part");
            v27.Name = "TroveCloneTest";
            local v28 = u1:Clone(v27);
            expect((typeof(v28))).to.equal("Instance");
            expect(v28).to.never.equal(v27);
            expect(v28.Name).to.equal("TroveCloneTest");
            expect(v27.Name).to.equal(v28.Name);
        end);
        it("should clean up a thread", function() --[[ Line: 168 ]]
            -- upvalues: u1 (ref)
            local v29 = coroutine.create(function() --[[ Line: 169 ]] end);
            u1:Add(v29);
            expect(coroutine.status(v29)).to.equal("suspended");
            u1:Clean();
            expect(coroutine.status(v29)).to.equal("dead");
        end);
        it("should not allow objects added during cleanup", function() --[[ Line: 176 ]]
            -- upvalues: u1 (ref)
            expect(function() --[[ Line: 177 ]]
                -- upvalues: u1 (ref)
                u1:Add(function() --[[ Line: 178 ]]
                    -- upvalues: u1 (ref)
                    u1:Add(function() --[[ Line: 179 ]] end);
                end);
                u1:Clean();
            end).to.throw();
        end);
        it("should not allow objects to be removed during cleanup", function() --[[ Line: 185 ]]
            -- upvalues: u1 (ref)
            expect(function() --[[ Line: 186 ]]
                -- upvalues: u1 (ref)
                local function u30() --[[ Line: 187 ]] end;
                u1:Add(u30);
                u1:Add(function() --[[ Line: 189 ]]
                    -- upvalues: u1 (ref), u30 (copy)
                    u1:Remove(u30);
                end);
                u1:Clean();
            end).to.throw();
        end);
    end);
end;