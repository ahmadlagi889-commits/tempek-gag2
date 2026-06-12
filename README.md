# GAG Hub — Grow A Garden Automation Suite

Modular automation hub for Roblox Grow A Garden.
Loads dynamically from GitHub — update files di repo, script otomatis ambil versi terbaru.

## One-Liner (paste di executor)

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/USERNAME/REPO/main/rblx/gag2/hub/hub.lua"))()
```

Ganti `USERNAME` dan `REPO` sesuai GitHub kamu.

---

## Setup GitHub Repo

### 1. Buat Repository

```
GitHub → New Repository → nama bebas (contoh: gag-hub)
Visibility: Public (biar raw URL bisa diakses)
```

### 2. Upload Files

Struktur folder di repo:

```
repo/
└── rblx/
    └── gag2/
        └── hub/
            ├── hub.lua                 ← entry point
            ├── loader.lua              ← one-liner reference
            ├── config.lua              ← config reference
            ├── README.md
            ├── core/
            │   ├── networking.lua      ← remote wrapper
            │   ├── utils.lua           ← helper functions
            │   ├── antiafk.lua         ← anti-AFK
            │   └── remotes_reference.lua ← all 150+ remotes
            └── modules/
                ├── harvest.lua         ← auto harvest
                ├── sell.lua            ← auto sell
                ├── water.lua           ← auto water
                ├── plant.lua           ← auto plant
                ├── restock.lua         ← restock sniper
                ├── mutation.lua        ← mutation tracker
                ├── weather.lua         ← weather bot
                ├── steal.lua           ← steal bot
                └── inventory.lua       ← inventory optimizer
```

### 3. Edit hub.lua

Di baris atas `hub.lua`, ganti:

```lua
local GITHUB_USER   = "YOUR_USERNAME"     -- ← username GitHub kamu
local GITHUB_REPO   = "YOUR_REPO"         -- ← nama repo
local GITHUB_BRANCH = "main"              -- ← branch (default: main)
local GITHUB_FOLDER = "rblx/gag2/hub"     -- ← path folder di repo
```

### 4. Commit & Push

```bash
git add .
git commit -m "initial GAG hub"
git push origin main
```

### 5. Test URL

Buka di browser:
```
https://raw.githubusercontent.com/USERNAME/REPO/main/rblx/gag2/hub/hub.lua
```
Harus muncul isi `hub.lua` (bukan 404 page).

### 6. Inject di Executor

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/USERNAME/REPO/main/rblx/gag2/hub/hub.lua"))()
```

---

## Cara Kerja Dynamic Loading

```
Executor
  │
  └─ loadstring → fetch hub.lua dari GitHub
                    │
                    ├─ httpLoad("core/networking.lua")  ← fetch dari GitHub
                    ├─ httpLoad("core/utils.lua")        ← fetch dari GitHub
                    ├─ httpLoad("modules/harvest.lua")   ← fetch dari GitHub
                    ├─ httpLoad("modules/sell.lua")      ← fetch dari GitHub
                    └─ ... semua module load on-demand
```

- `hub.lua` di-fetch sekali, lalu fetch semua module
- Setiap module di-cache (tidak fetch ulang)
- Kalau module gagal load, module lain tetap jalan
- `fullReload()` re-download semua module dari GitHub

---

## Modules

| Module | Remote(s) | Description |
|--------|-----------|-------------|
| **AutoHarvest** | `Garden.CollectFruit` | Auto-collect ripe fruits (3 methods) |
| **AutoSell** | `NPCS.SellAll` | Auto-sell semua ke Steven NPC |
| **AutoWater** | `WateringCan.UseWateringCan` | Auto-water tanaman |
| **AutoPlant** | `Plant.PlantSeed` | Auto-plant seed priority |
| **RestockSniper** | Shop remotes | Auto-beli seed langka saat restock |
| **MutationTracker** | `Garden.PlantMutationUpdated` | Alert mutation langka |
| **WeatherBot** | `WeatherEffects.*` | Track & alert weather events |
| **StealBot** | StealPrompt | Auto-steal saat malam |
| **InventoryOptimizer** | `Backpack.*` | Auto-favorite/promote/drop |
| **AntiAfk** | VirtualUser | Prevent kick (always on) |

---

## Console API

```lua
-- Toggle
_G.GAGHub.toggle("AutoHarvest")
_G.GAGHub.toggle("AutoSell")
_G.GAGHub.toggle("AutoWater")
_G.GAGHub.toggle("AutoPlant")
_G.GAGHub.toggle("RestockSniper")
_G.GAGHub.toggle("MutationTracker")
_G.GAGHub.toggle("WeatherBot")
_G.GAGHub.toggle("StealBot")
_G.GAGHub.toggle("InventoryOptimizer")

-- Batch
_G.GAGHub.enableAll()
_G.GAGHub.disableAll()

-- Status & debug
_G.GAGHub.status()
_G.GAGHub.stats("AutoHarvest")

-- Hot reload (re-download single module dari GitHub)
_G.GAGHub.hotReload("AutoHarvest")

-- Full reload (re-download semua dari GitHub)
_G.GAGHub.fullReload()

-- Test remote
_G.GAGHub.netTest("Garden.CollectFruit", "plant1", "")

-- List known remotes
_G.GAGHub.listRemotes()

-- Refresh networking cache (setelah game update)
_G.GAGHub.Net._module = nil
_G.GAGHub.Net._cache = {}
_G.GAGHub.Net._resolve()
```

---

## Update Workflow

### Push update ke GitHub

```bash
# Edit module di lokal
vim modules/harvest.lua

# Commit & push
git add -A && git commit -m "fix harvest" && git push
```

### Di-game, hot reload

```lua
-- Re-download single module
_G.GAGHub.hotReload("AutoHarvest")

-- Atau re-download semua
_G.GAGHub.fullReload()
```

Tidak perlu re-inject! Module otomatis ambil versi terbaru dari GitHub.

---

## Adding New Module

1. Buat file `modules/mymodule.lua`:

```lua
local MyModule = {}
local _running, _thread = false, nil
local _stats = { count = 0 }

function MyModule.start(config, Net, Utils)
    if _running then return end
    _running = true
    _thread = task.spawn(function()
        while _running do
            -- Your logic here
            _stats.count += 1
            task.wait(5)
        end
    end)
end

function MyModule.stop()
    _running = false
end

function MyModule.getStats()
    return _stats
end

return MyModule
```

2. Tambah di `hub.lua`:
```lua
loadModule("MyModule", "modules/mymodule.lua")
```

3. Tambah toggle di UI section.

4. Push ke GitHub.

---

## Sell Value Reference

| Plant | Value | Plant | Value |
|-------|-------|-------|-------|
| Carrot | 5 | Grape | 45 |
| Strawberry | 3 | Mango | 90 |
| Blueberry | 5 | Coconut | 60 |
| Tomato | 9 | Cherry | 350 |
| Apple | 12 | Pomegranate | 900 |
| Cactus | 40 | Dragon Fruit | 150 |
| Pineapple | 30 | Mushroom | **13,000** |
| Corn | 34 | Moon Bloom | **9,000** |
| Banana | 35 | Lotus | 6,500 |
| Tulip | 60 | Sunflower | 1,750 |
| Bamboo | 800 | Venus Fly Trap | 3,000 |
| Romanesco | 1,500 | Dragon's Breath | 3,400 |
| Beanstalk | 2,000 | Ghost Pepper | 2,500 |

## Mutation Multipliers

| Mutation | ×Value | Rarity |
|----------|--------|--------|
| Gold | ×20 | Uncommon |
| Frozen | ×10 | Rare |
| Electric | ×12 | Rare |
| Bloodlit | ×5 | Event |
| Chained | ×8 | Event |
| Rainbow | ×50 | Very Rare |
| Starstruck | ×100 | Legendary |
