# ============================================================
# TESTS CLIENTS — Epignosis CRM Demo
# Epignosis Center — Formateur Robot Framework Accrédité
# www.epignosis.center · contact@epignosis.center
# ============================================================

*** Settings ***
Documentation       Tests de la page clients et du formulaire d'ajout.
...                 URL clients   : https://epignosis-crm-demo.onrender.com/customers
...                 URL nouveau   : https://epignosis-crm-demo.onrender.com/new-customer
...                 Prérequis     : être connecté en tant qu'admin.

Library             SeleniumLibrary
Resource            ../Resources/commun.resource
Resource            ../Resources/connexion_res.resource
Resource            ../Resources/clients_res.resource
Variables           ../Config/variables.py

Suite Setup         Connexion Et Navigation Vers Clients
Suite Teardown      Fermer Le Navigateur CRM
Test Teardown       Capturer Screenshot Si Echec

Test Tags           clients


*** Keywords ***
Connexion Et Navigation Vers Clients
    [Documentation]    Setup de suite : connexion admin puis navigation vers la page clients.
    Ouvrir Le Navigateur CRM
    Se Connecter Au CRM
    La Connexion Devrait Réussir
    Aller Sur La Page Clients


*** Test Cases ***

# ── Affichage de la liste ─────────────────────────────────────

La Page Clients Devrait S'Afficher Après Connexion
    [Documentation]    La page clients est accessible après connexion admin.
    [Tags]    smoke    affichage
    La Page Clients Devrait Être Affichée

Le Titre De La Page Clients Devrait Être Correct
    [Documentation]    Le titre "Nos Clients Satisfaits" est bien affiché.
    [Tags]    smoke    affichage
    La Page Devrait Afficher    Nos Clients Satisfaits

Le Tableau Des Clients Devrait Être Visible
    [Documentation]    Le tableau avec colonnes #, Prénom, Nom, Email... est présent.
    [Tags]    smoke    affichage
    Le Tableau Clients Devrait Être Visible
    La Page Devrait Afficher    Prénom
    La Page Devrait Afficher    Région

Le Bouton Nouveau Client Devrait Être Visible
    [Documentation]    Le bouton "+ Nouveau Client" est présent sur la page.
    [Tags]    affichage
    [Setup]    Aller Sur La Page Clients
    Element Should Be Visible    ${BOUTON_NOUVEAU_CLIENT}

# ── Formulaire nouveau client ─────────────────────────────────

Le Formulaire Nouveau Client Devrait S'Afficher
    [Documentation]    Le formulaire "Ajouter un Client" s'ouvre correctement.
    [Tags]    smoke    formulaire
    [Setup]    Aller Sur La Page Clients
    Aller Sur Le Formulaire Nouveau Client
    La Page Devrait Afficher     ${TITRE_NOUVEAU_CLIENT}
    L'URL Devrait Contenir       new-customer
    Element Should Be Visible    ${CHAMP_EMAIL_CLIENT}
    Element Should Be Visible    ${CHAMP_PRENOM}
    Element Should Be Visible    ${CHAMP_NOM}
    Element Should Be Visible    ${CHAMP_VILLE}
    Element Should Be Visible    ${SELECT_REGION}

Ajouter Un Nouveau Client Valide
    [Documentation]    Un client peut être créé avec toutes les données valides.
    [Tags]    smoke    ajout
    [Setup]    Aller Sur La Page Clients
    ${timestamp}=    Get Time    epoch
    ${email_test}=    Set Variable    test.rf.${timestamp}@epignosis.center
    Créer Un Nouveau Client
    ...    email=${email_test}
    ...    prenom=Laura
    ...    nom=Martin
    ...    ville=Paris
    ...    region=IDF
    ...    genre=Femme
    La Page Devrait Afficher    ${MSG_SUCCES_AJOUT}

Soumettre Le Formulaire Vide Devrait Afficher Une Erreur
    [Documentation]    Soumettre le formulaire vide déclenche le message d'erreur.
    [Tags]    formulaire    negatif    champs-vides
    [Setup]    Aller Sur La Page Clients
    Aller Sur Le Formulaire Nouveau Client
    Cliquer Sur Enregistrer Le Client
    L'Erreur Champs Obligatoires Devrait Être Affichée

Soumettre Sans Email Devrait Afficher Une Erreur
    [Documentation]    Soumettre le formulaire sans email déclenche le message d'erreur.
    [Tags]    formulaire    negatif    champs-vides
    [Setup]    Aller Sur La Page Clients
    Aller Sur Le Formulaire Nouveau Client
    Saisir Le Prénom Du Client    Laura
    Saisir Le Nom Du Client       Martin
    Saisir La Ville Du Client     Paris
    Sélectionner La Région        IDF
    Sélectionner Le Genre Femme
    Cliquer Sur Enregistrer Le Client
    L'Erreur Champs Obligatoires Devrait Être Affichée

# ── Navigation ────────────────────────────────────────────────

Le Bouton Annuler Devrait Retourner À La Liste
    [Documentation]    Cliquer sur Annuler depuis le formulaire retourne à /customers.
    [Tags]    navigation
    [Setup]    Aller Sur La Page Clients
    Aller Sur Le Formulaire Nouveau Client
    Wait Until Element Is Visible    ${BOUTON_ANNULER}    timeout=${TIMEOUT}
    Click Element                    ${BOUTON_ANNULER}
    La Page Clients Devrait Être Affichée
