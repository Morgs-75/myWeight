create extension if not exists "pgcrypto";

create table if not exists public.weight_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null,
  weight numeric not null,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists weight_entries_user_date
  on public.weight_entries (user_id, date);

create table if not exists public.weight_goals (
  user_id uuid primary key references auth.users(id) on delete cascade,
  goal_weight numeric not null,
  goal_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.user_settings (
  user_id uuid primary key references auth.users(id) on delete cascade,
  unit text not null default 'lb'
);

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  timezone text,
  height_cm numeric,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.weight_entries enable row level security;
alter table public.weight_goals enable row level security;
alter table public.user_settings enable row level security;
alter table public.profiles enable row level security;

create policy "Users can access own entries"
  on public.weight_entries
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "Users can access own goals"
  on public.weight_goals
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "Users can access own settings"
  on public.user_settings
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "Users can access own profile"
  on public.profiles
  for all
  using (auth.uid() = id)
  with check (auth.uid() = id);
