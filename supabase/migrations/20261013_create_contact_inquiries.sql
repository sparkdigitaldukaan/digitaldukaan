-- Adds private inquiry storage for the public contact form.
-- Visitors may insert valid inquiries, but cannot select, update or delete rows.
create table if not exists public.contact_inquiries (
  id uuid primary key default gen_random_uuid(),
  customer_name text not null check (char_length(btrim(customer_name)) between 1 and 80),
  business_name text not null check (char_length(btrim(business_name)) between 1 and 100),
  phone text not null check (phone ~ '^[+()0-9 .-]{7,25}$'),
  email text check (email is null or (char_length(email) <= 120 and email ~* '^[^@[:space:]]+@[^@[:space:]]+[.][^@[:space:]]+$')),
  service_required text not null check (char_length(btrim(service_required)) between 1 and 100),
  project_description text not null check (char_length(btrim(project_description)) between 10 and 1000),
  created_at timestamptz not null default now()
);

alter table public.contact_inquiries enable row level security;
revoke all on public.contact_inquiries from anon, authenticated;
grant insert on public.contact_inquiries to anon;
drop policy if exists "Public can submit contact enquiries" on public.contact_inquiries;
create policy "Public can submit contact enquiries"
  on public.contact_inquiries for insert to anon with check (true);
