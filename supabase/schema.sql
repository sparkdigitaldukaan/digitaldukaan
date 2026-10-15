-- Digital Dukaan initial Supabase schema and public catalogue seed.
-- Safe for a new project: this creates tables only when they do not exist.
-- Public visitors may read published business/catalogue content. No public writes.

create table if not exists public.business_settings (
  id boolean primary key default true check (id),
  business_name text not null,
  tagline text not null,
  whatsapp_number text not null,
  suggested_email text not null,
  discount_percent integer not null default 0 check (discount_percent between 0 and 100),
  discount_scope text not null default 'first trial',
  offer_ends_at date,
  updated_at timestamptz not null default now()
);

create table if not exists public.social_links (
  platform text primary key,
  url text not null default '',
  is_published boolean not null default true
);

create table if not exists public.services (
  id text primary key,
  title text not null,
  price_inr numeric(10,2) not null default 0 check (price_inr >= 0),
  description text not null,
  whatsapp_message text not null,
  sort_order integer not null default 0,
  is_published boolean not null default true
);

create table if not exists public.pricing_packages (
  id text primary key,
  name text not null,
  price_inr numeric(10,2) not null check (price_inr >= 0),
  description text not null,
  features text[] not null default '{}',
  sort_order integer not null default 0,
  is_published boolean not null default true
);

create table if not exists public.portfolio_projects (
  id text primary key,
  title text not null,
  category text not null,
  description text not null default '',
  image_url text,
  is_demo boolean not null default true,
  is_published boolean not null default false,
  sort_order integer not null default 0
);

-- Contact details are private: visitors may submit, but only project admins may read them.
create table if not exists public.contact_inquiries (
  id uuid primary key default gen_random_uuid(),
  customer_name text not null check (char_length(btrim(customer_name)) between 1 and 80),
  business_name text not null check (char_length(btrim(business_name)) between 1 and 100),
  phone text not null check (phone ~ '^[+()0-9 .-]{7,25}$'),
  email text check (email is null or (char_length(email) <= 120 and email ~* '^[^@[:space:]]+@[^@[:space:]]+[.][^@[:space:]]+$')),
  service_required text not null check (char_length(btrim(service_required)) between 1 and 100),
  project_description text not null check (char_length(btrim(project_description)) between 10 and 1000),
  consent_given boolean not null check (consent_given is true),
  consent_policy_version text not null,
  consented_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table public.business_settings enable row level security;
alter table public.social_links enable row level security;
alter table public.services enable row level security;
alter table public.pricing_packages enable row level security;
alter table public.portfolio_projects enable row level security;
alter table public.contact_inquiries enable row level security;

drop policy if exists "Public can read business settings" on public.business_settings;
create policy "Public can read business settings" on public.business_settings for select to anon, authenticated using (true);
drop policy if exists "Public can read published social links" on public.social_links;
create policy "Public can read published social links" on public.social_links for select to anon, authenticated using (is_published);
drop policy if exists "Public can read published services" on public.services;
create policy "Public can read published services" on public.services for select to anon, authenticated using (is_published);
drop policy if exists "Public can read published packages" on public.pricing_packages;
create policy "Public can read published packages" on public.pricing_packages for select to anon, authenticated using (is_published);
drop policy if exists "Public can read published portfolio" on public.portfolio_projects;
create policy "Public can read published portfolio" on public.portfolio_projects for select to anon, authenticated using (is_published);
revoke all on public.contact_inquiries from anon, authenticated;
grant insert on public.contact_inquiries to anon;
drop policy if exists "Public can submit contact enquiries" on public.contact_inquiries;
create policy "Public can submit contact enquiries" on public.contact_inquiries for insert to anon with check (consent_given is true);

insert into public.business_settings (id, business_name, tagline, whatsapp_number, suggested_email, discount_percent, discount_scope, offer_ends_at)
values (true, 'Digital Dukaan', 'Helping Small Businesses Grow Online', '918858918190', 'spark.digitaldukaan@gmail.com', 50, 'first trial', null)
on conflict (id) do update set business_name=excluded.business_name, tagline=excluded.tagline, whatsapp_number=excluded.whatsapp_number, suggested_email=excluded.suggested_email, discount_percent=excluded.discount_percent, discount_scope=excluded.discount_scope, offer_ends_at=excluded.offer_ends_at, updated_at=now();

insert into public.social_links (platform, url) values ('instagram', ''), ('facebook', '')
on conflict (platform) do update set url=excluded.url;

insert into public.services (id, title, price_inr, description, whatsapp_message, sort_order) values
('promotional-poster-design', 'Promotional poster design', 199, 'Clear, eye-catching artwork for offers, launches and everyday promotions.', 'Hello Digital Dukaan! I want to enquire about poster design services. Please share pricing and details.', 1),
('instagram-facebook-post-design', 'Instagram & Facebook post design', 249, 'On-brand post designs sized for your social channels.', 'Hello Digital Dukaan! I want social media post designs. Please share pricing and details.', 2),
('social-media-content-creation', 'Social media content creation', 799, 'A practical set of post ideas and captions to help you stay active online.', 'Hello Digital Dukaan! I need social media content creation. Please share available packages.', 3),
('whatsapp-business-setup', 'WhatsApp Business setup', 299, 'Get your business profile, greeting and quick replies organised.', 'Hello Digital Dukaan! I need help setting up WhatsApp Business. Please share details.', 4),
('product-catalogue-creation', 'Product catalogue creation', 499, 'A tidy digital catalogue customers can browse and enquire about.', 'Hello Digital Dukaan! I want a product catalogue for my business. Please share pricing and details.', 5),
('google-business-profile-setup', 'Google Business Profile setup', 499, 'Help preparing your business profile and key information for local discovery.', 'Hello Digital Dukaan! I need help with Google Business Profile setup. Please share details.', 6),
('basic-business-website', 'Basic business website', 2499, 'A responsive one-page home for your business with contact and WhatsApp links.', 'Hello Digital Dukaan! I want a website for my business. Please contact me with pricing and details.', 7),
('landing-page-development', 'Landing page development', 1499, 'A focused page for a service, campaign or special offer.', 'Hello Digital Dukaan! I need a landing page for my business. Please share pricing and details.', 8),
('festival-offer-advertisements', 'Festival & offer advertisements', 199, 'Seasonal campaign creatives to announce offers and events.', 'Hello Digital Dukaan! I need a festival or offer advertisement. Please share pricing and details.', 9),
('custom-digital-services', 'Custom digital services', 0, 'Tell us what your small business needs and we can discuss a suitable solution.', 'Hello Digital Dukaan! I have a custom digital service request. Please get in touch.', 10)
on conflict (id) do update set title=excluded.title, price_inr=excluded.price_inr, description=excluded.description, whatsapp_message=excluded.whatsapp_message, sort_order=excluded.sort_order;

insert into public.pricing_packages (id, name, price_inr, description, features, sort_order) values
('starter', 'Starter', 499, 'A simple start for your next promotion.', array['3 promotional designs', 'Basic customer enquiry support', 'WhatsApp ordering link'], 1),
('growth', 'Growth', 1499, 'A consistent presence for growing businesses.', array['8 social media designs', 'Basic content planning', 'Business profile assistance'], 2),
('website-launch', 'Website Launch', 2499, 'A clear online home for your business.', array['Basic one-page website', 'Mobile-responsive design', 'WhatsApp enquiry integration'], 3)
on conflict (id) do update set name=excluded.name, price_inr=excluded.price_inr, description=excluded.description, features=excluded.features, sort_order=excluded.sort_order;
