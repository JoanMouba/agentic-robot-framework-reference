---
name: auditer-conformite-conventions
description: vérifie qu'un fichier .robot ou .resource respecte les conventions du projet. À utiliser lors d'une revue de code ou avant de fusionner de nouveaux tests.
license: MIT
metadata:
  epignosis-center:
    version: 1.0.0
    author: Joan Mouba
    tags: [AgentAISkills]
    homepage: https://epignosiscenter.podia.com
    related_skills: [creer-tests-rf-de-user-story]
---

# Auditer-Conformite-Conventions

Vérifie qu'un fichier .robot ou .resource respecte les conventions de nommage, de structure et de documentation du projet.

## Accents

Les Keywords ne contiennent jamais d'accent. Les titres de Test Case et les [Documentation] tolèrent les accents sans restriction.

Pour distinguer code nouveau et dette historique, compare contre le tag `v0.3.0-skill-generation` — le point où cette règle est entrée en vigueur :

    git diff v0.3.0-skill-generation..HEAD -- <fichier>

- Ligne ajoutée (préfixe `+`) avec un Keyword accentué → violation bloquante.
- Ligne déjà présente avant le tag, jamais retouchée depuis → dette existante, à signaler dans le rapport, jamais bloquante.
- Fichier inexistant avant le tag → toutes ses lignes sont neuves, aucune dette possible.

## Mots-clés bas niveau interdits dans les fichiers de tests

Un fichier `.robot` de tests n'appelle que des Keywords composés — jamais de mot-clé de librairie externe (`Click Element`, `Wait Until Element Is Visible`, etc.) ni de locator brut. Ces appels vivent uniquement dans les `.resource`.

Même mécanisme de cliquet que ci-dessus : violation bloquante si ajoutée après `v0.3.0-skill-generation`, dette signalée sinon. `Tests/clients_tests.robot` contient déjà des violations antérieures au tag (import direct de `SeleniumLibrary`, appels bruts à `Element Should Be Visible`) — à traiter comme dette connue, pas comme échec du premier audit.

## Nommage des fichiers

Aucun accent, espace, ou caractère spécial (`$ % & §`) dans un nom de fichier `.robot` ou `.resource`.

## Un fichier .resource par fonctionnalité

Chaque `.resource` correspond à une fonctionnalité unique et contient à la fois ses locators (`*** Variables ***`) et ses Keywords.

## Tags 

Chaque Test Case porte au moins un tag lié à la fonctionnalité testée, en réutilisant un tag existant du projet si pertinent plutôt qu'en créer un nouveau systématiquement.

## Variables 

Les variables de `*** Variables ***` sont en majuscules, sans accent (ex. `${NOM_VARIABLE}`).
