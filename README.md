# Digital Dukaan website

A responsive, zero-budget static website for Digital Dukaan. It uses plain HTML, CSS and JavaScript; no build step, backend, paid API or contact-form service is required.

## Run locally

Open `index.html` in a browser. The Google Fonts import is optional; the site uses system fallbacks if fonts cannot be reached.

## Edit business details and prices

Edit `config.js`:

- `whatsapp`: digits only, international country code first (India: `91`), no plus sign or spaces.
- `suggestedEmail`: update after the mailbox has been created and tested. The site labels this address as suggested/unverified.
- `founder`, `team`, `businessName`, `tagline`, `socialLinks`: central business details. Team member names, roles and image paths are configured in `team`. The footer adds social links only when valid HTTPS URLs are configured; no accounts are currently listed.
- `discountPercent`: discount applied automatically to every service/package with a non-zero `price`. It is currently set to 50.
- `discountScope`: the offer description shown beside the discounted price; currently `first trial`. The static website cannot verify customer history, so the WhatsApp enquiry asks the owner to confirm eligibility.
- `offerEndsAt`: optional `YYYY-MM-DD` end date. Leave it `null` for no stated end date. When configured, the UI shows the date and disables the promotion after it passes.
- `services`: service descriptions, original listed prices in INR, and per-service prefilled WhatsApp messages. Use `0` for a custom quote; custom quotes do not receive a percentage discount.
- `packages`: original package prices, summaries and inclusions. Prices remain in config at their original values; the UI calculates the discount and savings.

The About section and Team cards use optimized WebP profile photographs. Their image paths are set in `config.js` under `team`; the About section founder photo uses `assets/spark-sharma-founder.webp`. The supplied PNGs are retained as source copies. The projects area intentionally contains no samples until real work is approved for display.

## WhatsApp and contact form

WhatsApp links open `wa.me` with a URL-encoded draft. Service cards have specific enquiry text. The form requires the visitor to check the consent box, and links to the Privacy Policy and Terms & Conditions text. It validates required fields, phone format, email format when supplied, and project-description length, then opens WhatsApp with the entered details. The visitor must review and send the message; the site does not send it or report a successful WhatsApp delivery. Popup blocking may require allowing the site to open a new tab. The policy text is a starter disclosure for the owner to review and adapt before launch; it is not a legal opinion.

The email links use `mailto:` with the configured suggested address. A mail link only opens the visitor's chosen email app and does not confirm delivery or mailbox availability.

## Publish for free

### GitHub Pages

1. Create a GitHub repository and add `index.html`, `styles.css`, `script.js`, `config.js`, this README and the complete `assets/` folder.
2. In the repository, open **Settings → Pages**.
3. Select deployment from the `main` branch and the root folder, then save.
4. Wait for the Pages URL shown in Settings and open it on a phone and desktop.

### Netlify

Create a new site from the repository and use the repository root as the publish directory. There is no build command. Netlify's free plan details can change; check its current plan before relying on limits.

Static hosting does not process forms itself. The contact form writes to Supabase directly through its Data API, then opens a WhatsApp draft as a visitor-controlled handoff. The database save is separate from WhatsApp delivery. A custom domain, paid hosting, third-party services and advertising may add costs. Review the host's current limits and terms before publishing.

## Supabase database

The initial schema and seed data are in `supabase/schema.sql`. It creates the public business content tables and enables row-level security. Anonymous visitors can read published business settings, team, social links, services, packages and portfolio entries. The `contact_inquiries` table accepts form inserts only with `consent_given = true`, and has no public read, update or delete access; project admins can review entries in the Supabase Table Editor. Consent version and timestamp are stored with each enquiry. The form collects name, business name, phone, optional email, service and project description after the visitor agrees to the policy and terms. Avoid entering sensitive details. The browser's publishable key is public by design; never use a secret/service-role key in the website.

For a new project, open the target Supabase project's SQL Editor, paste `supabase/schema.sql`, and run it. For an existing project with the inquiry table, run `supabase/migrations/20261013_enforce_inquiry_consent.sql` to add consent columns and require affirmative consent for new public inserts. This migration preserves existing rows and does not drop tables or data. The contact form submits an inquiry insert and opens a WhatsApp draft in parallel. A successful form acceptance does not mean WhatsApp sent the message: the visitor must press Send in WhatsApp. Buttons that open WhatsApp directly do not create inquiry rows because the site does not receive the visitor identity from a `wa.me` link. Capturing messages actually received by WhatsApp requires a WhatsApp Business Platform webhook. The display catalogue remains driven by `config.js`.

## Before launch

- Confirm the WhatsApp number is correct and can receive enquiries.
- Create and test the suggested email mailbox, or change/remove it.
- Confirm service scope, package prices and any external costs with customers before accepting work.
- Confirm the supplied profile photos are the intended photos for Spark and Rony.
- Replace demonstration portfolio concepts with real work only when you have permission; keep examples clearly labelled.
- Open WhatsApp buttons and complete a test enquiry yourself to verify the message wording and number. Opening a draft does not send it.
