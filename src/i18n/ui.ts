export const languages = {
  en: 'English',
  de: 'Deutsch',
};

export const defaultLang = 'en';

export const ui = {
  en: {
    'nav.home': 'Home',
    'nav.services': 'Services',
    'nav.who': 'Who are We?',
    'nav.contact': 'Contact',
    'nav.impressum': 'Legal Notice',
    'hero.tagline': 'Enterprise Salesforce. Intelligent Automation. Agentic AI.',
    'hero.sub': 'We architect mission-critical digital systems — Salesforce Cloud, n8n Workflow Engines, and stateful AI agents — engineered for 100% data ownership and zero vendor lock-in.',
    'hero.cta.primary': 'Book a Strategy Call',
    'hero.cta.secondary': 'Explore Services',
    'services.title': 'Our Three Core Pillars',
    'contact.title': 'Start a Project',
    'contact.name': 'Full Name',
    'contact.email': 'Business Email',
    'contact.company': 'Company',
    'contact.message': 'Describe your requirement',
    'contact.submit': 'Send Message',
    'footer.rights': '© 2026 NexaForce Digital. All rights reserved.',
    'footer.impressum': 'Legal Notice',
    'footer.privacy': 'Privacy Policy',
    'footer.terms': 'Terms of Use',
    'footer.disclaimer': 'Disclaimer',
  },
  de: {
    'nav.home': 'Startseite',
    'nav.services': 'Leistungen',
    'nav.who': 'Wer sind wir?',
    'nav.contact': 'Kontakt',
    'nav.impressum': 'Impressum',
    'hero.tagline': 'Enterprise Salesforce. Intelligente Automatisierung. Agentische KI.',
    'hero.sub': 'Wir entwickeln unternehmenskritische digitale Systeme — Salesforce Cloud, n8n Workflow-Engines und zustandsbehaftete KI-Agenten — konzipiert für 100 % Dateneigentum und ohne Vendor Lock-in.',
    'hero.cta.primary': 'Strategiegespräch buchen',
    'hero.cta.secondary': 'Leistungen entdecken',
    'services.title': 'Unsere drei Kernbereiche',
    'contact.title': 'Projekt starten',
    'contact.name': 'Vollständiger Name',
    'contact.email': 'Geschäftliche E-Mail',
    'contact.company': 'Unternehmen',
    'contact.message': 'Beschreiben Sie Ihr Anliegen',
    'contact.submit': 'Nachricht senden',
    'footer.rights': '© 2026 NexaForce Digital. Alle Rechte vorbehalten.',
    'footer.impressum': 'Impressum',
    'footer.privacy': 'Datenschutzerklärung',
    'footer.terms': 'Nutzungsbedingungen',
    'footer.disclaimer': 'Haftungsausschluss',
  },
} as const;

export type Lang = keyof typeof ui;

export function getLangFromUrl(url: URL): Lang {
  const [, lang] = url.pathname.split('/');
  if (lang in ui) return lang as Lang;
  return defaultLang;
}

export function useTranslations(lang: Lang) {
  return function t(key: keyof (typeof ui)[typeof defaultLang]) {
    return ui[lang][key] || ui[defaultLang][key];
  };
}
