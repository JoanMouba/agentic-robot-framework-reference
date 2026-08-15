# ============================================================
# CONFIGURATION — Epignosis CRM Demo
# Epignosis Center — Formateur Robot Framework Accrédité
# www.epignosis.center · contact@epignosis.center
# ============================================================

# ── Application ─────────────────────────────────────────────
URL_BASE            = "https://epignosis-crm-demo.onrender.com"
URL_ACCUEIL         = f"{URL_BASE}"
URL_CONNEXION       = f"{URL_BASE}/signin"
URL_CLIENTS         = f"{URL_BASE}/customers"
URL_NOUVEAU_CLIENT  = f"{URL_BASE}/new-customer"

# ── Navigateur ───────────────────────────────────────────────
# Options : chrome | firefox | edge
NAVIGATEUR          = "chrome"

# ── Identifiants de test ─────────────────────────────────────
EMAIL_VALIDE        = "admin@fakeemail.com"
MDP_VALIDE          = "SecretSauce!25"

EMAIL_INVALIDE      = "mauvais@email.com"
MDP_INVALIDE        = "MauvaisMotDePasse"

# ── Données de test — Nouveau client ─────────────────────────
CLIENT_PRENOM       = "Laura"
CLIENT_NOM          = "Martin"
CLIENT_EMAIL        = "laura.martin@test.fr"
CLIENT_VILLE        = "Paris"
CLIENT_REGION       = "IDF"

# ── Timeouts ─────────────────────────────────────────────────
TIMEOUT             = "10s"
VITESSE             = "0.3s"
