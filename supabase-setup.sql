-- ============================================================
-- SPACEGENES+ · Supabase Cloud Setup (Progress Sync + Leaderboard)
-- ============================================================
-- Run this ONCE in your Supabase project:
--   Dashboard → SQL Editor → New query → paste → Run
--
-- Creates:
--   1. explorer_progress — per-device progress sync (XP, badges…)
--   2. leaderboard      — global explorer rankings (public read)
--   3. Sample explorers — so the board looks alive (removable)
--
-- The app uses only the ANON key from the browser (public by
-- design). RLS is enabled on both tables.
-- ============================================================

-- ---------- TABLE 1: PROGRESS SYNC ----------
create table if not exists public.explorer_progress (
  explorer_id uuid primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.explorer_progress enable row level security;

drop policy if exists "sg_anon_select" on public.explorer_progress;
create policy "sg_anon_select" on public.explorer_progress
  for select to anon using (true);

drop policy if exists "sg_anon_insert" on public.explorer_progress;
create policy "sg_anon_insert" on public.explorer_progress
  for insert to anon with check (true);

drop policy if exists "sg_anon_update" on public.explorer_progress;
create policy "sg_anon_update" on public.explorer_progress
  for update to anon using (true) with check (true);

create index if not exists idx_explorer_updated
  on public.explorer_progress (updated_at desc);

-- ---------- TABLE 2: GLOBAL LEADERBOARD ----------
create table if not exists public.leaderboard (
  explorer_id uuid primary key,
  name text not null default 'Explorer',
  xp integer not null default 0,
  level integer not null default 1,
  rank text not null default 'CADET',
  badges integer not null default 0,
  mars_best integer not null default 0,
  seeded boolean not null default false,
  updated_at timestamptz not null default now()
);

alter table public.leaderboard enable row level security;

drop policy if exists "sg_lb_select" on public.leaderboard;
create policy "sg_lb_select" on public.leaderboard
  for select to anon using (true);

drop policy if exists "sg_lb_insert" on public.leaderboard;
create policy "sg_lb_insert" on public.leaderboard
  for insert to anon with check (true);

drop policy if exists "sg_lb_update" on public.leaderboard;
create policy "sg_lb_update" on public.leaderboard
  for update to anon using (true) with check (true);

create index if not exists idx_leaderboard_xp
  on public.leaderboard (xp desc);

-- ---------- SAMPLE EXPLORERS (demo seed) ----------
insert into public.leaderboard (explorer_id, name, xp, level, rank, badges, mars_best, seeded) values
  (gen_random_uuid(), 'NebulaNova',   1420, 6, 'NAVIGATOR',    9, 1618, true),
  (gen_random_uuid(), 'OrionPilot',    980, 5, 'EXPLORER',     7, 1420, true),
  (gen_random_uuid(), 'ISROdreamer',   720, 4, 'EXPLORER',     6, 1255, true),
  (gen_random_uuid(), 'StellarSage',   410, 3, 'EXPLORER',     4,  980, true),
  (gen_random_uuid(), 'CadetKiran',    160, 2, 'CADET',        2,  720, true)
on conflict (explorer_id) do nothing;

-- To remove the sample explorers later:
--   delete from public.leaderboard where seeded = true;

-- ✅ Done! Open SpaceGenes+ — the sync dot turns green and
--    the Leaderboard page comes alive with the explorers above.
