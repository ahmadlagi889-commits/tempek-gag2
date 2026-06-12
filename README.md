# GAG Hub - Grow A Garden Automation

All-in-one automation suite. Single file, single loadstring.

## Quick Start

Paste di executor:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/ahmadlagi889-commits/tempek-gag2/main/hub.lua"))()
```

## Features

| Module | Description |
|--------|-------------|
| AutoHarvest | Auto collect semua fruit di garden |
| AutoSell | Auto sell ke NPC, threshold-based |
| AutoWater | Auto water tanaman + sprinkler |
| AutoPlant | Auto plant seed di empty plots |
| RestockSniper | Monitor restock timer, snipe seed langka |
| MutationTracker | Monitor mutation, alert high-value |
| WeatherBot | Monitor weather cycle, Bloodmoon/Rainbow alert |
| StealBot | Steal dari garden player lain (night only) |
| InventoryOptimizer | Auto-favorite, promote, drop item |

## Console API

```lua
_G.GAGHub.toggle("AutoHarvest")    -- toggle module
_G.GAGHub.status()                  -- print status
_G.GAGHub.enableAll()               -- start semua
_G.GAGHub.disableAll()              -- stop semua
_G.GAGHub.stats("AutoHarvest")     -- detail stats
```

## Config

Edit config di awal `hub.lua`:
- `Config.Features` — default on/off per module
- `Config.Timings` — interval per module (detik)
- `Config.Restock.TargetSeeds` — seed target untuk restock sniper
- `Config.Steal.MinFruitValue` — minimum value untuk steal
- `Config.Mutation.AlertMutations` — mutation yang trigger alert

## Architecture

Single file (`hub.lua`), ~2600 baris. Semua module inlined:
- **Networking** — auto-discover remote events, retry, cache
- **Utils** — garden/player/inventory helpers
- **Anti-AFK** — prevent kick + auto rejoin
- **9 Feature Modules** — masing-masing punya `start()`/`stop()`/`getStats()`

## Hot Reload

Edit `hub.lua` di GitHub, push. Di game:
```lua
-- Re-execute loadstring untuk reload
loadstring(game:HttpGet("https://raw.githubusercontent.com/ahmadlagi889-commits/tempek-gag2/main/hub.lua"))()
```

## UI

Rayfield UI auto-load. Toggle per module, status refresh, enable/disable all.
