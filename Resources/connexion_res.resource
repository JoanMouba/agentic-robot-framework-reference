# ============================================================
# RESSOURCE CONNEXION — Page Object Model : /signin
# Epignosis Center — Formateur Robot Framework Accrédité
# www.epignosis.center · contact@epignosis.center
# ============================================================

*** Settings ***
Library     SeleniumLibrary
Resource    commun.resource
Variables   ../Config/variables.py


*** Variables ***
# ── Localisateurs — Page Connexion (/signin) ─────────────────
${CHAMP_EMAIL}          //input[@type="email" or @placeholder="votre@email.com"]
${CHAMP_MDP}            //input[@type='password']
${BOUTON_CONNEXION}     //button[contains(text(),'Connexion')] | //input[@type='submit']
${CHECKBOX_SOUVENIR}    //input[@type='checkbox']

# ── Textes attendus ───────────────────────────────────────────
${TITRE_CONNEXION}      Connexion
${MSG_ERREUR_LOGIN}     Invalid
${TITRE_ACCUEIL}        Les Clients Sont Notre Priorité


*** Keywords ***
Aller Sur La Page De Connexion
    [Documentation]    Navigue vers la page de connexion du CRM.
    Go To                        ${URL_CONNEXION}
    Wait Until Page Contains     ${TITRE_CONNEXION}    timeout=${TIMEOUT}

Saisir L'Email
    [Documentation]    Saisit l'adresse email dans le champ correspondant.
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${CHAMP_EMAIL}    timeout=${TIMEOUT}
    Clear Element Text               ${CHAMP_EMAIL}
    Input Text                       ${CHAMP_EMAIL}    ${email}

Saisir Le Mot De Passe
    [Documentation]    Saisit le mot de passe dans le champ correspondant.
    [Arguments]    ${mdp}
    Wait Until Element Is Visible    ${CHAMP_MDP}    timeout=${TIMEOUT}
    Clear Element Text               ${CHAMP_MDP}
    Input Text                       ${CHAMP_MDP}    ${mdp}

Cliquer Sur Connexion
    [Documentation]    Clique sur le bouton Connexion.
    Wait Until Element Is Visible    ${BOUTON_CONNEXION}    timeout=${TIMEOUT}
    Click Button                     ${BOUTON_CONNEXION}

Se Connecter Au CRM
    [Documentation]    Connexion complète avec email et mot de passe.
    [Arguments]    ${email}=${EMAIL_VALIDE}    ${mdp}=${MDP_VALIDE}
    Saisir L'Email              ${email}
    Saisir Le Mot De Passe      ${mdp}
    Cliquer Sur Connexion

La Connexion Devrait Réussir
    [Documentation]    Vérifie que la connexion a abouti → redirection vers /customers.
    L'URL Devrait Contenir       customers
    La Page Devrait Afficher     Nos Clients Satisfaits

La Connexion Devrait Échouer
    [Documentation]    Vérifie que la connexion a échoué → message d'erreur affiché.
    Page Should Contain    ${MSG_ERREUR_LOGIN}

La Page De Connexion Devrait Être Chargée
    [Documentation]    Vérifie que la page de connexion est correctement affichée.
    Page Should Contain              ${TITRE_CONNEXION}
    Element Should Be Visible        ${CHAMP_EMAIL}
    Element Should Be Visible        ${CHAMP_MDP}
    Element Should Be Visible        ${BOUTON_CONNEXION}
