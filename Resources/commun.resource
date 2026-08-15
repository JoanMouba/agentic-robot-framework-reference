# ============================================================
# RESSOURCE COMMUNE — Mots-clés partagés
# Epignosis Center — Formateur Robot Framework Accrédité
# www.epignosis.center · contact@epignosis.center
# ============================================================

*** Settings ***
Library     SeleniumLibrary
Variables   ../Config/variables.py


*** Keywords ***
Ouvrir Le Navigateur CRM
    [Documentation]    Ouvre le navigateur et navigue vers la page de connexion.
    Set Selenium Timeout    ${TIMEOUT}
    Set Selenium Speed      ${VITESSE}
    Open Browser            ${URL_CONNEXION}    ${NAVIGATEUR}
    Maximize Browser Window
    Wait Until Page Contains    Connexion    timeout=${TIMEOUT}

Fermer Le Navigateur CRM
    [Documentation]    Ferme le navigateur proprement.
    Close Browser

Capturer Screenshot Si Echec
    [Documentation]    Capture un screenshot en cas d'échec du test.
    Run Keyword If Test Failed
    ...    Capture Page Screenshot
    ...    EMBED

La Page Devrait Afficher
    [Documentation]    Vérifie qu'un texte est présent sur la page.
    [Arguments]    ${texte}
    Wait Until Page Contains    ${texte}    timeout=${TIMEOUT}
    Page Should Contain         ${texte}

La Page Ne Devrait Pas Afficher
    [Documentation]    Vérifie qu'un texte est absent de la page.
    [Arguments]    ${texte}
    Page Should Not Contain    ${texte}

L'URL Devrait Contenir
    [Documentation]    Vérifie que l'URL courante contient le chemin attendu.
    [Arguments]    ${chemin}
    Wait Until Location Contains    ${chemin}    timeout=${TIMEOUT}
