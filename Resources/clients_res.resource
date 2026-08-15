# ============================================================
# RESSOURCE CLIENTS — Page Object Model : /customers & /new-customer
# Epignosis Center — Formateur Robot Framework Accrédité
# www.epignosis.center · contact@epignosis.center
# ============================================================

*** Settings ***
Library     SeleniumLibrary
Resource    commun.resource
Resource    connexion_res.resource
Variables   ../Config/variables.py


*** Variables ***
# ── Localisateurs — Page Clients (/customers) ────────────────
${TITRE_PAGE_CLIENTS}       Nos Clients Satisfaits
${BOUTON_NOUVEAU_CLIENT}    //a[contains(text(),'Nouveau Client')] | //button[contains(text(),'Nouveau Client')]
${TABLEAU_CLIENTS}          //table
${LIGNES_CLIENTS}           //table//tbody//tr
${COMPTEUR_CLIENTS}         //p[contains(text(),'client(s) enregistré')]

# ── Localisateurs — Formulaire nouveau client (/new-customer) ─
${TITRE_NOUVEAU_CLIENT}     Ajouter un Client
${CHAMP_EMAIL_CLIENT}       //input[@name="EmailAddress" or @id="EmailAddress"]
${CHAMP_PRENOM}             //input[@name="FirstName" or @id="FirstName"]
${CHAMP_NOM}                //input[@name="LastName" or @id="LastName"]
${CHAMP_VILLE}              //input[@name="City" or @id="City"]
${SELECT_REGION}            //select[@name="StateOrRegion" or @id="StateOrRegion"]
${RADIO_FEMME}              //input[@type="radio" and @name="gender" and @value="female"]
${RADIO_HOMME}              //input[@type="radio" and @name="gender" and @value="male"]
${CHECKBOX_PROMOS}          //input[@type="checkbox" and @name="subscribe" or @type="checkbox" and @id="subscribe"]
${BOUTON_ENREGISTRER}       //button[contains(text(),'Enregistrer le Client')]
${BOUTON_ANNULER}           //button[normalize-space()="Annuler"] | //a[normalize-space()="Annuler"]

# ── Messages ──────────────────────────────────────────────────
${MSG_ERREUR_CHAMPS}        Tous les champs obligatoires doivent être remplis.
${MSG_SUCCES_AJOUT}         Succès – Nouveau Client Ajouté


*** Keywords ***
# ── Navigation ───────────────────────────────────────────────
Aller Sur La Page Clients
    [Documentation]    Navigue vers la page liste des clients.
    Go To                        ${URL_CLIENTS}
    Wait Until Page Contains     ${TITRE_PAGE_CLIENTS}    timeout=${TIMEOUT}

Aller Sur Le Formulaire Nouveau Client
    [Documentation]    Clique sur le bouton + Nouveau Client.
    Wait Until Element Is Visible    ${BOUTON_NOUVEAU_CLIENT}    timeout=${TIMEOUT}
    Click Element                    ${BOUTON_NOUVEAU_CLIENT}
    Wait Until Page Contains         ${TITRE_NOUVEAU_CLIENT}    timeout=${TIMEOUT}

# ── Vérifications page clients ───────────────────────────────
La Page Clients Devrait Être Affichée
    [Documentation]    Vérifie que la page clients est bien chargée.
    Page Should Contain          ${TITRE_PAGE_CLIENTS}
    L'URL Devrait Contenir       customers

Le Tableau Clients Devrait Être Visible
    [Documentation]    Vérifie que le tableau de clients est présent.
    Wait Until Element Is Visible    ${TABLEAU_CLIENTS}    timeout=${TIMEOUT}
    Element Should Be Visible        ${TABLEAU_CLIENTS}

Obtenir Le Nombre De Clients
    [Documentation]    Retourne le nombre de lignes dans le tableau clients.
    Wait Until Element Is Visible    ${TABLEAU_CLIENTS}    timeout=${TIMEOUT}
    ${nb}=    Get Element Count    ${LIGNES_CLIENTS}
    RETURN    ${nb}

# ── Formulaire nouveau client ────────────────────────────────
Saisir L'Email Du Client
    [Documentation]    Saisit l'adresse email dans le formulaire.
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${CHAMP_EMAIL_CLIENT}    timeout=${TIMEOUT}
    Input Text    ${CHAMP_EMAIL_CLIENT}    ${email}

Saisir Le Prénom Du Client
    [Documentation]    Saisit le prénom dans le formulaire.
    [Arguments]    ${prenom}
    Wait Until Element Is Visible    ${CHAMP_PRENOM}    timeout=${TIMEOUT}
    Input Text    ${CHAMP_PRENOM}    ${prenom}

Saisir Le Nom Du Client
    [Documentation]    Saisit le nom dans le formulaire.
    [Arguments]    ${nom}
    Wait Until Element Is Visible    ${CHAMP_NOM}    timeout=${TIMEOUT}
    Input Text    ${CHAMP_NOM}    ${nom}

Saisir La Ville Du Client
    [Documentation]    Saisit la ville dans le formulaire.
    [Arguments]    ${ville}
    Wait Until Element Is Visible    ${CHAMP_VILLE}    timeout=${TIMEOUT}
    Input Text    ${CHAMP_VILLE}    ${ville}

Sélectionner La Région
    [Documentation]    Sélectionne une région dans le menu déroulant.
    [Arguments]    ${region}
    Wait Until Element Is Visible    ${SELECT_REGION}    timeout=${TIMEOUT}
    Select From List By Value        ${SELECT_REGION}    ${region}

Sélectionner Le Genre Femme
    [Documentation]    Sélectionne le radio bouton Femme.
    Wait Until Element Is Visible    (//input[@type='radio'])[1]    timeout=${TIMEOUT}
    Click Element                    (//input[@type='radio'])[1]

Sélectionner Le Genre Homme
    [Documentation]    Sélectionne le radio bouton Homme.
    Wait Until Element Is Visible    (//input[@type='radio'])[2]    timeout=${TIMEOUT}
    Click Element                    (//input[@type='radio'])[2]

Cocher Les Promotions
    [Documentation]    Coche la case "Souhaite recevoir les promotions".
    Wait Until Element Is Visible    ${CHECKBOX_PROMOS}    timeout=${TIMEOUT}
    Select Checkbox                  ${CHECKBOX_PROMOS}

Cliquer Sur Enregistrer Le Client
    [Documentation]    Clique sur le bouton Enregistrer le Client.
    Wait Until Element Is Visible    ${BOUTON_ENREGISTRER}    timeout=${TIMEOUT}
    Click Button                     ${BOUTON_ENREGISTRER}

Remplir Le Formulaire Client Complet
    [Documentation]    Remplit tous les champs obligatoires du formulaire.
    [Arguments]    ${email}    ${prenom}    ${nom}    ${ville}    ${region}    ${genre}=Femme
    Saisir L'Email Du Client       ${email}
    Saisir Le Prénom Du Client     ${prenom}
    Saisir Le Nom Du Client        ${nom}
    Saisir La Ville Du Client      ${ville}
    Sélectionner La Région         ${region}
    IF    '${genre}' == 'Femme'
        Sélectionner Le Genre Femme
    ELSE
        Sélectionner Le Genre Homme
    END

Créer Un Nouveau Client
    [Documentation]    Flux complet de création d'un client valide.
    [Arguments]    ${email}    ${prenom}    ${nom}    ${ville}    ${region}    ${genre}=Femme
    Aller Sur Le Formulaire Nouveau Client
    Remplir Le Formulaire Client Complet
    ...    ${email}    ${prenom}    ${nom}    ${ville}    ${region}    ${genre}
    Cliquer Sur Enregistrer Le Client
    Wait Until Page Contains    ${MSG_SUCCES_AJOUT}    timeout=${TIMEOUT}

L'Erreur Champs Obligatoires Devrait Être Affichée
    [Documentation]    Vérifie le message d'erreur champs obligatoires.
    Wait Until Page Contains    ${MSG_ERREUR_CHAMPS}    timeout=${TIMEOUT}
    Page Should Contain         ${MSG_ERREUR_CHAMPS}
