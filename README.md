# 🚀 SpaceGenes+

**Explore Beyond. Learn Beyond.**

A next-generation interactive space-learning platform for the explorers of tomorrow —
part **future space academy**, part **mission control**, part **interactive planetarium**,
part **AI tutor**, part **space simulator**.

> SPACE. INTELLIGENCE. EXPLORATION.

---

## ✨ What's Inside

| Module | Description |
|---|---|
| 🛰️ **Mission Control** | Futuristic dashboard — level, XP, streak, badges, knowledge score, next objectives |
| 🪐 **Interactive Solar System** | Animated orbital map, 8 planets + Sun, full data dossiers, *Dive Deeper* learning modules |
| 🌌 **Deep Space** | Black holes, neutron stars, supernovae, nebulae, exoplanets, dark matter & more |
| 🎯 **Training Missions** | 4 interactive scenario missions with XP, badges and knowledge debriefs |
| 🎓 **Learning Academy** | 11 modules across 5 ranks: Cadet → Explorer → Navigator → Scientist → Mission Specialist |
| 🔬 **Space Simulator** | Orbital motion lab, escape-velocity lab, solar-system scale strip, moon-phase explorer |
| 🤖 **ASTRA — AI Guide** | "Your intelligent guide to the universe" — live AI with offline knowledge-brain fallback |
| ⚡ **Challenges** | 5 timed quizzes incl. the 12-question Grand Challenge |
| 🏆 **Achievements** | 15 badges to unlock |
| 🌍 **Global Leaderboard** | Supabase-powered worldwide explorer rankings — podium, medals, live XP standings |
| 🧭 **Future Explorer** | Interest-driven educational career-path recommendations (aerospace engineer → mission specialist) |
| 🔴 **MISSION TO MARS** | The signature simulation: spacecraft → launch window → fuel budget → deep-space emergencies → landing → surface science → full mission report |

## 🤖 ASTRA — AI Integration

ASTRA is architected for real AI with graceful degradation:

1. **Live AI** — calls [OpenRouter](https://openrouter.ai) (`/api/v1/chat/completions`) with a space-tutor system prompt
2. **Auto-retry** — on rate-limits (429/503) she tries backup models automatically
3. **Offline brain** — a curated knowledge base of ~25 space topics answers instantly if the network or key is unavailable

To enable live AI on this deployment: open **Settings → ASTRA API key** and paste your
OpenRouter key (`sk-or-v1-...`). It is stored only in *your* browser's localStorage.
(The repo copy ships with no embedded key — never commit API keys.)

Swapping providers later = one `fetch` call in `astraThink()`.

## ☁️ Cloud Progress Sync (Supabase)

Explorer progress (XP, badges, missions, academy) persists to **localStorage** and
optionally syncs to **Supabase**:

1. Create a project at [supabase.com](https://supabase.com)
2. Run `supabase-setup.sql` in the SQL Editor — creates `explorer_progress` **and** the `leaderboard` table (+ sample explorers), with demo RLS policies
3. Put your project URL + anon key in `CONFIG` at the top of `index.html`

The sync dot in the top bar shows status: 🟢 cloud active · ⚪ offline/local · 🟡 table missing.

> ⚠️ Demo policies allow anonymous sync (no accounts). For production, add Supabase Auth
> and scope policies with `auth.uid() = explorer_id`.

## 🎮 The Signature Moment — Mission to Mars

A complete, replayable Mars expedition where every decision matters:

**Select spacecraft → Choose launch window (Hohmann / fast transfer / Venus slingshot) →
Allocate fuel & power budget → Survive randomized deep-space emergencies →
Pick an entry-descent-landing profile → Deploy surface science within your power budget →
MISSION COMPLETE report** (score, grade S–D, every decision logged, knowledge gained, XP, badge).

Fail states included — running out of fuel or hull integrity triggers an educational debrief. 😉

## 🛠️ Tech

- **Zero dependencies.** One `index.html` — HTML + CSS + vanilla JS (~240 KB)
- Canvas starfield with parallax, glassmorphism UI, holographic HUD elements
- Works offline as a single file — open it anywhere, even from a USB stick
- Progress in localStorage; optional Supabase cloud sync
- All content is original and fact-checked (planets, missions incl. ISRO's Chandrayaan-3 & Mangalyaan, astrophysics modules)

## 🚀 Run It

```bash
# Option 1 — just open it
open index.html        # (or double-click it)

# Option 2 — serve it
npx serve .            # or python3 -m http.server
```

## 🔐 Security Notes

- This public copy contains **no embedded secrets**
- Supabase **anon key** is safe to expose publicly (that's its design, with RLS)
- Your OpenRouter key stays in your browser's localStorage only
- Rotate any key that was ever committed to a repo

---

Built for the next generation of explorers, scientists, engineers — and the people who will
someday look back at Earth from orbit. **The ultimate goal: a student stops seeing space as
a textbook chapter — and starts seeing themselves exploring it.** 🌌
