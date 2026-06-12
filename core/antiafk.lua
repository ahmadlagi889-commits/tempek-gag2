--[[
    GAG Hub - Anti-AFK + Auto Rejoin
    Keeps the player active and handles disconnections.
]]

local AntiAfk = {}

local Players    = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local GuiService  = game:GetService("GuiService")
local RS          = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer

Antiafk._running = false
AntiAfk._thread  = nil
AntiAfk._rejoinThread = nil
AntiAfk._stats   = { actions = 0, rejoins = 0, lastAction = 0 }

---------------------------------------------------------------
-- ANTI-AFK
---------------------------------------------------------------

function AntiAfk.start(config)
    if AntiAfk._running then return end
    AntiAfk._running = true

    local interval = config.Timings.AntiAfkInterval or 60

    AntiAfk._thread = task.spawn(function()
        while AntiAfk._running do
            -- Method 1: VirtualUser click (most reliable)
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)

            -- Method 2: Simulate movement
            pcall(function()
                local humanoid = LP.Character
                    and LP.Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid then
                    humanoid.Jump = true
                end
            end)

            -- Method 3: Fire game's anti-AFK remote if available
            pcall(function()
                local Net = require(
                    RS:WaitForChild("SharedModules"):WaitForChild("Networking")
                )
                if Net.AntiAfk and Net.AntiAfk.RequestHop then
                    -- Only fire if idle long enough (game tracks this)
                end
            end)

            AntiAfk._stats.actions += 1
            AntiAfk._stats.lastAction = os.time()
            task.wait(interval)
        end
    end)

    -- Also handle the idle kicked event
    LP.Idled:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)

    print("[GAG Hub] Anti-AFK started (interval: " .. interval .. "s)")
end

function AntiAfk.stop()
    AntiAfk._running = false
    if AntiAfk._thread then
        task.cancel(AntiAfk._thread)
        AntiAfk._thread = nil
    end
end

---------------------------------------------------------------
-- AUTO-REJOIN
---------------------------------------------------------------

function AntiAfk.startAutoRejoin(config)
    if AntiAfk._rejoinThread then return end

    local delay = config.Timings.RejoinDelay or 5

    -- Handle disconnection
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay
        .ChildAdded:Connect(function(child)
            if child.Name == "ErrorPrompt" or child.Name == "TeleportPrompt" then
                AntiAfk._stats.rejoins += 1
                task.wait(delay)
                pcall(function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(
                        game.PlaceId,
                        game.JobId,
                        LP
                    )
                end)
            end
        end)

    -- Handle kick messages
    game:GetService("GuiService").ErrorMessageChanged:Connect(function()
        AntiAfk._stats.rejoins += 1
        task.wait(delay)
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
        end)
    end)

    -- Handle character death (auto-respawn)
    LP.CharacterAdded:Connect(function(char)
        local humanoid = char:WaitForChild("Humanoid", 10)
        if humanoid then
            humanoid.Died:Connect(function()
                task.wait(3)
                pcall(function()
                    LP:LoadCharacter()
                end)
            end)
        end
    end)

    print("[GAG Hub] Auto-Rejoin enabled")
end

function AntiAfk.getStats()
    return AntiAfk._stats
end

return AntiAfk
