// Central business settings. Each service/package `price` is its original listed INR price.
// The UI calculates active discounts from discountPercent; offerEndsAt is optional (YYYY-MM-DD).
window.DIGITAL_DUKAAN = {
  businessName: "Digital Dukaan",
  tagline: "Helping Small Businesses Grow Online",
  founder: "Spark Sharma",
  team: [
    { name: "Spark Sharma", designation: "Founder & CEO", photo: "assets/spark-sharma-founder.webp" },
    { name: "Rony Shaw", designation: "Co-Founder", photo: "assets/rony-shaw.webp" }
  ],
  whatsapp: "918858918190",
  suggestedEmail: "spark.digitaldukaan@gmail.com",
  // This publishable key is safe for browser use when table access is protected by RLS.
  supabase: {
    url: "https://genqilpvwsenkjwdtvsj.supabase.co",
    publishableKey: "sb_publishable_6KdZ8QOYB0yNrZOGf_2rMQ_0sGHxyab"
  },
  discountPercent: 50,
  discountScope: "first trial",
  offerEndsAt: null,
  socialLinks: { instagram: "", facebook: "" },
  services: [
    { title: "Promotional poster design", price: 199, description: "Clear, eye-catching artwork for offers, launches and everyday promotions.", message: "Hello Digital Dukaan! I want to enquire about poster design services. Please share pricing and details." },
    { title: "Instagram & Facebook post design", price: 249, description: "On-brand post designs sized for your social channels.", message: "Hello Digital Dukaan! I want social media post designs. Please share pricing and details." },
    { title: "Social media content creation", price: 799, description: "A practical set of post ideas and captions to help you stay active online.", message: "Hello Digital Dukaan! I need social media content creation. Please share available packages." },
    { title: "WhatsApp Business setup", price: 299, description: "Get your business profile, greeting and quick replies organised.", message: "Hello Digital Dukaan! I need help setting up WhatsApp Business. Please share details." },
    { title: "Product catalogue creation", price: 499, description: "A tidy digital catalogue customers can browse and enquire about.", message: "Hello Digital Dukaan! I want a product catalogue for my business. Please share pricing and details." },
    { title: "Google Business Profile setup", price: 499, description: "Help preparing your business profile and key information for local discovery.", message: "Hello Digital Dukaan! I need help with Google Business Profile setup. Please share details." },
    { title: "Basic business website", price: 2499, description: "A responsive one-page home for your business with contact and WhatsApp links.", message: "Hello Digital Dukaan! I want a website for my business. Please contact me with pricing and details." },
    { title: "Landing page development", price: 1499, description: "A focused page for a service, campaign or special offer.", message: "Hello Digital Dukaan! I need a landing page for my business. Please share pricing and details." },
    { title: "Festival & offer advertisements", price: 199, description: "Seasonal campaign creatives to announce offers and events.", message: "Hello Digital Dukaan! I need a festival or offer advertisement. Please share pricing and details." },
    { title: "Custom digital services", price: 0, description: "Tell us what your small business needs and we can discuss a suitable solution.", message: "Hello Digital Dukaan! I have a custom digital service request. Please get in touch." }
  ],
  packages: [
    { name: "Starter", price: 499, description: "A simple start for your next promotion.", items: ["3 promotional designs", "Basic customer enquiry support", "WhatsApp ordering link"] },
    { name: "Growth", price: 1499, description: "A consistent presence for growing businesses.", items: ["8 social media designs", "Basic content planning", "Business profile assistance"] },
    { name: "Website Launch", price: 2499, description: "A clear online home for your business.", items: ["Basic one-page website", "Mobile-responsive design", "WhatsApp enquiry integration"] }
  ]
};
