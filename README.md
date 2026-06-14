<p align="center">
  <h1 align="center">🌿 GAG Hub</h1>
  <p align="center"><b>Grow A Garden — All-in-One Automation Suite</b></p>
  <p align="center">
    <img src="https://img.shields.io/badge/version-1.0.0-blue?style=flat-square" alt="version">
    <img src="https://img.shields.io/badge/modules-15-green?style=flat-square" alt="modules">
    <img src="https://img.shields.io/badge/file-single-ff69b4?style=flat-square" alt="single-file">
    <img src="https://img.shields.io/badge/UI-Rayfield-purple?style=flat-square" alt="rayfield">
  </p>
</p>

---

## ⚡ Quick Start

Paste di executor:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/ahmadlagi889-commits/tempek-gag2/main/hub.lua"))()
```

---

## 🎯 Features (15 Modules)

### 🌾 Farming

| Module | Description |
|--------|-------------|
| **Auto Harvest** | Collect semua fruit yang ripe di garden |
| **Auto Sell** | Sell ke NPC, configurable mode (all/threshold) |
| **Auto Water** | Water tanaman, skip fully grown, support watering can filter |
| **Auto Plant** | Plant seed ke empty plots, grid-based, filter mutasi Gold/Rainbow |
| **Auto Center Plot** | One-shot teleport ke center soil saat script load |

### 🛒 Shop

| Module | Description |
|--------|-------------|
| **Restock Sniper** | Monitor seed restock, auto buy target seed langka |
| **Gear Buyer** | Auto buy gear dari shop |
| **Inventory Optimizer** | Auto-favorite high-value, promote, drop junk |
| **Auto Hatch Pet** | Auto hatch egg, filter berdasarkan rarity |

### 🌙 Events

| Module | Description |
|--------|-------------|
| **Mutation Tracker** | Monitor mutation, alert high-value (Gold, Rainbow, Starstruck) |
| **Weather Bot** | Track weather cycle, Bloodmoon/Rainbow alert |
| **Seed Pack Claimer** | Auto scan & claim seed pack spawn di map |
| **Wild Pet Catch** | Auto catch wild pet, filter rarity |
| **Steal Bot** | Night-only, teleport ke high-value fruit → fire prompt → tp base |

### 🖥 System

| Module | Description |
|--------|-------------|
| **Anti-AFK** | Prevent kick + auto rejoin |
| **Auto Join Server** | Join target server by JobId |

---

## 🎮 UI

Rayfield UI dengan 5 tab:

| Tab | Content |
|-----|---------|
| 🌿 **Farming** | Toggle harvest/sell/water/plant, intervals, config |
| 🛒 **Shop** | Restock sniper, gear buyer, inventory, pets |
| ⚡ **Events** | Mutation, weather, seed pack, pet catch, steal, center |
| 🌐 **Server** | JobId, copy server, quick join, auto join |
| 📊 **Status** | Live stats per module, controls |

---

## 🧬 Steal Bot Flow

```
Night detected
  → Scan semua garden (skip plot sendiri)
  → Check garden lock (owner inside plot = locked, skip)
  → Filter: HoldDuration == 0, Enabled, not Collected
  → Sort by value DESC
  → Teleport ke fruit → fireproximityprompt → teleport ke base
  → Repeat sampai max attempts atau sunrise
```

**Config:** Min Value 100–10,000 | Max/Night 5–100 | Interval 0.5–5s

---

## 🌱 Auto Plant Flow

```
Backpack scan
  → Filter: MainCategory == "Seed"
  → Skip mutated: SeedTool = "Gold" / "Rainbow" (bare atau prefix)
  → Equip seed → Generate grid dari PlantArea
  → Plant ke semua empty spots → Unequip
```

---

## 🔧 Console API

```lua
_G.GAGHub.toggle("AutoHarvest")     -- toggle module
_G.GAGHub.status()                   -- print semua status
_G.GAGHub.enableAll()                -- start semua module
_G.GAGHub.disableAll()               -- stop semua module
_G.GAGHub.stats("StealBot")          -- detail stats module
_G.GAGHub.refreshNetwork()           -- refresh remote cache
```

---

## ⚙️ Config

Edit di awal `hub.lua` atau via UI:

```lua
Config.Features     -- default on/off per module
Config.Timings      -- interval per module (detik)
Config.Restock      -- target seeds, blacklist
Config.Steal        -- min value, max attempts, prefer mutations
Config.Plant        -- grid spacing, plant order, blacklist mutated
Config.Water        -- watering can filter, water fully grown
Config.Mutation     -- alert list, price multipliers
Config.PetCatch     -- min rarity, auto return
```

---

## 🏗 Architecture

```
hub.lua (~4500 baris, single file, no dependency)
├── Networking    — auto-discover remotes, cache, retry, fire/invoke/on
├── Utils         — garden/player/inventory/value helpers
├── AntiAFK       — prevent kick + auto rejoin
├── 15 Modules    — masing-masing: start()/stop()/getStats()
├── Rayfield UI   — 5 tabs, toggles, sliders, dropdowns
└── Console API   — _G.GAGHub
```

**Remote resolution:** 3 metode — `require()` → `getgc()` → `Packet pre-require`

---

## 🔄 Hot Reload

```lua
-- Edit hub.lua di GitHub, push, lalu re-execute:
loadstring(game:HttpGet("https://raw.githubusercontent.com/ahmadlagi889-commits/tempek-gag2/main/hub.lua"))()
```

---

## 📋 Versioning

Semantic Versioning (`MAJOR.MINOR.PATCH`):

| Type | When |
|------|------|
| **MAJOR** | Breaking changes, rewrite besar |
| **MINOR** | Fitur baru, module baru |
| **PATCH** | Bug fix, tuning, adjust kecil |

---

<p align="center">
  <b>Made for Grow A Garden</b><br>
  <sub>Single file. No dependency. Paste & play.</sub>
</p>

---

## 👤 Credits

**Developer:** Brave
