-- Store affirmative policy consent and require it for all public form inserts.
alter table public.contact_inquiries
  add column if not exists consent_given boolean not null default false,
  add column if not exists consent_policy_version text,
  add column if not exists consented_at timestamptz not null default now();

alter table public.contact_inquiries
  alter column consent_policy_version set default '2026-10-13';

update public.contact_inquiries
set consent_policy_version = '2026-10-13'
where consent_policy_version is null;

alter table public.contact_inquiries
  alter column consent_policy_version set not null;

drop policy if exists "Public can submit contact enquiries" on public.contact_inquiries;
create policy "Public can submit contact enquiries"
  on public.contact_inquiries
  for insert to anon
  with check (consent_given is true);
