# Robot Framework — Web Testing Starter Project
### Epignosis CRM Demo · SeleniumLibrary · Robot Framework Version 7

---

**Epignosis Center** · Formateur Robot Framework Accrédité  
www.epignosis.center · contact@epignosis.center

---

## À propos de ce projet

Ce projet est un template de démarrage pour les tests Web avec Robot Framework Version 7
et SeleniumLibrary. Il suit l'architecture **Page Object Model (POM)** et utilise
l'application de démonstration **Epignosis CRM Demo** comme cible de tests.

Conçu pour les testeurs manuels qui débutent l'automatisation et les équipes
qui veulent une base de projet propre et structurée.

---

## Structure du projet

```
EpignosisCRM_WebTesting_Starter/
│
├── Tests/
│   ├── connexion_tests.robot     # 8 tests — page de connexion (/signin)
│   └── clients_tests.robot       # 8 tests — page clients (/customers)
│
├── Resources/
│   ├── commun.resource           # Mots-clés communs (open/close browser)
│   ├── connexion_res.resource    # POM — Page de connexion
│   └── clients_res.resource      # POM — Page clients + formulaire
│
├── Config/
│   └── variables.py              # URL, identifiants, navigateur, timeouts
│
├── Results/                      # Généré automatiquement à l'exécution
│
├── requirements.txt              # Dépendances Python
└── README.md                     # Ce fichier
```

---

## Prérequis

### 1. Python 3.9+
Vérifiez votre version :
```bash
python --version
```

### 2. Mettre à jour pip (recommandé)
```bash
python -m pip install --upgrade pip
```

### 3. Installer les dépendances
```bash
pip install -r requirements.txt
```

> `webdriver-manager` est inclus dans `requirements.txt` et gère automatiquement
> le téléchargement du bon ChromeDriver pour votre version de Chrome.

### 4. Utiliser webdriver-manager (optionnel mais recommandé)

Si vous souhaitez gérer le WebDriver automatiquement dans vos scripts Python :
```python
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
```

Pour Robot Framework avec SeleniumLibrary, ChromeDriver doit être dans votre PATH.
La méthode la plus simple :
```bash
# Option A — ChromeDriver via webdriver-manager (en ligne de commande)
python -c "from webdriver_manager.chrome import ChromeDriverManager; print(ChromeDriverManager().install())"

# Option B — Téléchargement manuel
# https://chromedriver.chromium.org/downloads
```

---

## Application testée

| Élément        | Valeur                                          |
|----------------|-------------------------------------------------|
| URL accueil    | https://epignosis-crm-demo.onrender.com         |
| Page connexion | /signin                                         |
| Page clients   | /customers                                      |
| Nouveau client | /new-customer                                   |
| Email de test  | admin@fakeemail.com                             |
| Mot de passe   | SecretSauce!25                                  |

> ⚠️ L'application est hébergée sur Render (plan gratuit).
> Le premier chargement peut prendre 30–60 secondes si elle est en veille.
> Augmentez `TIMEOUT` dans `Config/variables.py` si nécessaire.

---

## Lancer les tests

### Tous les tests
```bash
robot --outputdir Results/ Tests/
```

### Tests de connexion uniquement
```bash
robot --outputdir Results/ Tests/connexion_tests.robot
```

### Tests clients uniquement
```bash
robot --outputdir Results/ Tests/clients_tests.robot
```

### Tests smoke uniquement (validation rapide)
```bash
robot --include smoke --outputdir Results/ Tests/
```

### Tests négatifs uniquement
```bash
robot --include negatif --outputdir Results/ Tests/
```

### Changer le navigateur
```bash
robot --variable NAVIGATEUR:firefox --outputdir Results/ Tests/
robot --variable NAVIGATEUR:edge    --outputdir Results/ Tests/
```

---

## Consulter les rapports

Après exécution, ouvrir dans le navigateur :

```
Results/report.html   → Rapport de synthèse
Results/log.html      → Log détaillé de chaque étape
```

---

## Architecture Page Object Model (POM)

Ce projet suit le pattern POM : chaque page a son propre fichier ressource.

```
Page Web          →    Fichier ressource
/signin           →    Resources/connexion_res.resource
/customers        →    Resources/clients_res.resource
/new-customer     →    Resources/clients_res.resource
```

**Avantages :**
- Si un localisateur change, vous ne modifiez qu'un seul fichier
- Les tests restent lisibles et indépendants de l'implémentation
- Les mots-clés sont réutilisables entre les tests

---

## Tags disponibles

| Tag                  | Description                              |
|----------------------|------------------------------------------|
| `smoke`              | Tests de validation rapide               |
| `connexion`          | Tous les tests de connexion              |
| `clients`            | Tous les tests de la page clients        |
| `connexion-valide`   | Tests de connexion réussie               |
| `connexion-invalide` | Tests de connexion échouée               |
| `negatif`            | Tests avec données invalides             |
| `champs-vides`       | Tests avec champs vides                  |
| `affichage`          | Tests d'interface                        |
| `formulaire`         | Tests du formulaire nouveau client       |
| `navigation`         | Tests de navigation entre pages          |
| `ajout`              | Tests d'ajout de client                  |

---

## Personnaliser pour votre projet

### Changer l'application cible
Modifier `Config/variables.py` :
```python
URL_BASE     = "https://votre-application.com"
EMAIL_VALIDE = "votre@email.com"
MDP_VALIDE   = "VotreMotDePasse"
```

### Ajouter une nouvelle page
1. Créer `Resources/ma_page_res.resource`
2. Définir les localisateurs dans `*** Variables ***`
3. Écrire les mots-clés dans `*** Keywords ***`
4. Créer `Tests/ma_page_tests.robot`
5. Importer : `Resource    ../Resources/ma_page_res.resource`

---

## Dépannage fréquent

| Problème                        | Solution                                                    |
|---------------------------------|-------------------------------------------------------------|
| `WebDriverException`            | Mettre à jour ChromeDriver ou utiliser webdriver-manager    |
| `ElementNotVisibleException`    | Augmenter `TIMEOUT` dans `Config/variables.py`              |
| `NoSuchElementException`        | Vérifier les localisateurs dans le fichier ressource        |
| Page lente à charger            | App Render en veille — attendre 60s et relancer             |
| Tests instables                 | Augmenter `VITESSE` dans `Config/variables.py` (ex: `0.5s`) |
| pip obsolète                    | `python -m pip install --upgrade pip`                       |

---

## Prochaine étape

Ce template est la base. Pour aller plus loin avec Epignosis Center :

- **Mémo Syntaxe RF Version 7** — Référence complète en 2 pages
- **Pack 50 Prompts IA** — Prompts Claude & ChatGPT pour RF
- **Formation Robot Framework Fondations** — epignosiscenter.podia.com

---

*Epignosis Center — Transformer vos équipes QA en Experts Robot Framework*  
*www.epignosis.center · contact@epignosis.center*
