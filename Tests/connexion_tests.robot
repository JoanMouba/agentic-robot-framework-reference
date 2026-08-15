# ============================================================
# TESTS CONNEXION — Epignosis CRM Demo
# Epignosis Center — Formateur Robot Framework Accrédité
# www.epignosis.center · contact@epignosis.center
# ============================================================

*** Settings ***
Documentation       Tests de la page de connexion.
...                 URL : https://epignosis-crm-demo.onrender.com/signin
...                 Identifiants valides : admin@fakeemail.com / SecretSauce!25

Library             SeleniumLibrary
Resource            ../Resources/commun.resource
Resource            ../Resources/connexion_res.resource
Variables           ../Config/variables.py

Suite Setup         Ouvrir Le Navigateur CRM
Suite Teardown      Fermer Le Navigateur CRM
Test Setup          Aller Sur La Page De Connexion
Test Teardown       Capturer Screenshot Si Echec

Test Tags           connexion


*** Test Cases ***

# ── Connexion réussie ─────────────────────────────────────────

Connexion Valide Avec Admin
    [Documentation]    Un utilisateur admin peut se connecter avec des identifiants valides.
    ...                Vérifie la redirection vers /customers et le titre "Nos Clients Satisfaits".
    [Tags]    smoke    connexion-valide
    Se Connecter Au CRM    ${EMAIL_VALIDE}    ${MDP_VALIDE}
    La Connexion Devrait Réussir
    La Page Devrait Afficher    Nos Clients Satisfaits

# ── Connexion échouée ─────────────────────────────────────────

Connexion Avec Email Invalide
    [Documentation]    Un email incorrect est rejeté — message d'erreur affiché.
    [Tags]    connexion-invalide    negatif
    Se Connecter Au CRM    ${EMAIL_INVALIDE}    ${MDP_VALIDE}
    La Connexion Devrait Échouer

Connexion Avec Mot De Passe Invalide
    [Documentation]    Un mot de passe incorrect est rejeté.
    [Tags]    connexion-invalide    negatif
    Se Connecter Au CRM    ${EMAIL_VALIDE}    ${MDP_INVALIDE}
    La Connexion Devrait Échouer

Connexion Avec Email Et Mot De Passe Invalides
    [Documentation]    Des identifiants totalement incorrects sont rejetés.
    [Tags]    connexion-invalide    negatif
    Se Connecter Au CRM    ${EMAIL_INVALIDE}    ${MDP_INVALIDE}
    La Connexion Devrait Échouer

Connexion Avec Email Vide
    [Documentation]    Le champ email vide est rejeté.
    [Tags]    connexion-invalide    negatif    champs-vides
    Se Connecter Au CRM    ${EMPTY}    ${MDP_VALIDE}
    La Connexion Devrait Échouer

Connexion Avec Mot De Passe Vide
    [Documentation]    Le champ mot de passe vide est rejeté.
    [Tags]    connexion-invalide    negatif    champs-vides
    Se Connecter Au CRM    ${EMAIL_VALIDE}    ${EMPTY}
    La Connexion Devrait Échouer

Connexion Avec Les Deux Champs Vides
    [Documentation]    Les deux champs vides sont rejetés.
    [Tags]    connexion-invalide    negatif    champs-vides
    Cliquer Sur Connexion
    La Connexion Devrait Échouer

# ── Interface ─────────────────────────────────────────────────

La Page De Connexion Devrait Être Accessible
    [Documentation]    La page de connexion se charge correctement avec tous ses éléments.
    [Tags]    smoke    interface
    La Page De Connexion Devrait Être Chargée

Le Titre De La Page Devrait Être Correct
    [Documentation]    Le titre du navigateur est "Epignosis CRM Demo".
    [Tags]    interface
    Title Should Be    Epignosis CRM Demo
