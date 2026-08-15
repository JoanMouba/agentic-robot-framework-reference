--- 
name: creer-tests-rf-de-user-story 
description: génère des tests Robot Framework automatisés à partir d'une user story ayant au moins un critère d'acceptation. Insère les tests dans un fichier .robot existant ou crée un nouveau si absent. 
---
## Couverture 
chaque critère d'acceptation doit être couvert par au moins un test
## Nommage fichiers 
les fichiers sont nommés avec un suffixe _tests, exemple clients_tests.robot et un fichier correspondant de resource est créé si non existant, exemple clients_res.resource, jamais d'accents dans les noms de fichiers
## Un seul fichier resource
un seul fichier .resource par fonctionnalité, contenant à la fois les Variables (locators) et les Keywords personnalisés — créé s'il n'existe pas déjà
## Interdits dans le .robot de tests  
aucune Variable de locator, aucune définition de Keyword personnalisé, aucun appel direct à un mot-clé de librairie externe (SeleniumLibrary) — uniquement des appels à des Keywords composés
## Accents  
jamais dans les Keywords ; tolérés partout ailleurs (titres de Test Case, Documentation)
## Tags 
réutiliser les tags existants du projet si pertinents, en créer de nouveaux sinon ; au moins un tag doit identifier la fonctionnalité
## Variables 
les variables de la section *** Variables ***  sont en majuscules et ne contiennent jamais d'accents, exemple ${TITRE_PAGE_CLIENTS}
## Popups natives du navigateur
quand une confirmation est une popup native du navigateur (window.confirm/alert/prompt, ex. onsubmit="return confirm(...)"), ce n'est pas un élément du DOM : ne jamais lui créer de locator XPath/CSS. La gérer via l'API Alert de SeleniumLibrary (Handle Alert, action=ACCEPT pour confirmer, action=DISMISS pour annuler), encapsulée dans un Keyword composé du fichier resource, jamais appelée nue dans le .robot de tests
## Tests destructifs sur environnement partagé
un test qui modifie l'état global de façon large et difficile à isoler (ex. suppression de toutes les données d'une liste) doit recevoir un tag dédié qui l'exclut des exécutions et de la vérification de non-régression par défaut (ex. tag "destructif"), et documenter en [Documentation] la portée de son impact ainsi que la condition qui le rend sûr à relancer