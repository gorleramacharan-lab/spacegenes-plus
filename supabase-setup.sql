-- ============================================================
-- SPACEGENES+ · Supabase Cloud Progress Sync — SETUP
-- ============================================================
-- Run this ONCE in your Supabase project:
--   Dashboard → SQL Editor → New query → paste → Run
--
-- What it does:
--   1. Creates the explorer_progress table (one row per device/explorer)
--   2. Enables Row Level Security
--   3. Adds demo-safe anon policies (read/insert/update)
--
-- The app stores your API key nowhere — it talks to Supabase
-- directly from the browser with the anon key (public by design).
-- ============================================================

create table if not exists public.explorer_progress (
  explorer_id uuid primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.explorer_progress enable row level security;

-- Demo policies: any visitor can sync their own progress row.
-- (Anonymous demo mode — no accounts. For production, replace with
--  Supabase Auth policies: auth.uid() = explorer_id)
drop policy if exists "sg_anon_select" on public.explorer_progress;
create policy "sg_anon_select" on public.explorer_progress
  for select to anon using (true);

drop policy if exists "sg_anon_insert" on public.explorer_progress;
create policy "sg_anon_insert" on public.explorer_progress
  for insert to anon with check (true);

drop policy if exists "sg_anon_update" on public.explorer_progress;
create policy "sg_anon_update" on public.explorer_progress
  for update to anon using (true) with check (true);

-- Helpful index for the "latest row" lookup the app performs
create index if not exists idx_explorer_updated
  on public.explorer_progress (updated_at desc);

-- Done! Open SpaceGenes+ — the sync dot in the top bar
-- should turn green (CLOUD SYNC ACTIVE).
