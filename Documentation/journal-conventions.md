# Journal de bord — Skills Agentic RF

Même format que le Chapitre 5 du Livre 2 : le symptôme tel qu'il est apparu, l'hypothèse d'abord crue, la cause réelle, la correction, la leçon. Rien n'est lissé après coup.

## Skill : auditer-conformite-conventions

### Décision 1 — La contradiction des accents

**Constat.** Avant d'écrire la première règle du corps, l'exploration du projet réel (comme au Chapitre 3.1) révèle une contradiction : la règle du skill `creer-tests-rf-de-user-story` interdit tout accent dans un nom de Keyword. Mais les Keywords déjà présents dans le projet, écrits avant ce skill, en contiennent partout — `La Page Clients Devrait Être Affichée`, `Créer Un Nouveau Client`, `Sélectionner La Région`.

**Le problème posé.** Un audit qui applique la règle mot pour mot signalerait la moitié du projet existant comme non conforme, dès le premier passage — inutilisable en pratique, et contraire à la façon dont un vrai linter doit s'introduire dans un projet mature.

**La décision.** Adopter le principe du cliquet (ratchet), déjà connu des linters (ESLint, Pylint, SonarQube) sur du code legacy : interdire que la dette augmente, sans exiger qu'elle disparaisse d'un coup. Concrètement, ancrer la règle sur le tag `v0.3.0-skill-generation` — le point où la convention "jamais d'accent dans les Keywords" est officiellement entrée en vigueur dans le projet :

- Code ajouté après ce tag → violation bloquante
- Code déjà présent avant ce tag, jamais retouché depuis → dette historique, signalée, non bloquante

Mécanisme technique validé avant d'écrire la règle en langage naturel :
```
git diff v0.3.0-skill-generation..HEAD -- <fichier>
```

**Pourquoi ça compte au-delà de ce cas précis.** Le même mécanisme s'appliquera le jour où un mot-clé Robot Framework existant devient deprecated : plusieurs fichiers crieraient d'un coup sans ce principe. Le cliquet permet une migration progressive plutôt qu'un mur de violations qui décourage l'équipe.

### Incident 1 — Le skill de génération a lui-même violé sa propre règle

**Symptôme.** Le Test A de `auditer-conformite-conventions`, lancé sur `Resources/clients_res.resource`, signale une violation bloquante : le Keyword `Le Compteur De Clients Devrait Être Visible` contient un accent (`Être`).

**Hypothèse qu'on aurait pu avoir.** Que l'audit se trompe, ou détecte une fausse positive sur de la dette historique mal classée.

**Cause réelle.** Ce Keyword a été généré par `creer-tests-rf-de-user-story` lui-même, aujourd'hui, après le tag `v0.3.0-skill-generation` — donc du code neuf, pas de la dette. Le skill de génération contient bien la règle "jamais d'accent dans les Keywords" dans son propre corps, mais ne l'a pas appliquée à la lettre lors de cette génération précise.

**Correction.** Renommage en `Le Compteur De Clients Devrait Etre Visible` (sans accent), dans `Resources/clients_res.resource` (définition) et `Tests/clients_tests.robot` (appel). Vérifié par dry-run, puis par exécution réelle : 11/11 tests toujours verts après correction.

**Leçon.** Un skill qui applique une règle correctement neuf fois sur dix n'est pas fiable pour autant — exactement l'esprit du Chapitre 5 du Livre 2 : l'exécution réelle révèle ce que la lecture du SKILL.md ne révèle pas. `auditer-conformite-conventions` fait ici office de filet de sécurité pour `creer-tests-rf-de-user-story`, pas seulement pour du code écrit à la main.

### Décision 2 — BuiltIn n'est pas une librairie externe

**Constat.** Le Test B de `auditer-conformite-conventions`, invoqué explicitement sur `Tests/clients_tests.robot`, devait vérifier la règle "aucun appel direct à un mot-clé de librairie externe" — jusque-là jamais confrontée au vrai projet.

**Le jugement rendu par l'agent.** Les nouvelles lignes ajoutées (section "Compteur clients") appellent `Get Time`, `Evaluate`, `Set Variable` — tous des mots-clés BuiltIn, toujours disponibles nativement en Robot Framework, distincts d'une librairie externe comme SeleniumLibrary. L'agent n'a pas tranché sur une interprétation personnelle de la règle : il a justifié sa décision par un précédent déjà présent dans le projet — le test `Ajouter Un Nouveau Client Valide`, écrit avant le tag, utilise déjà ces mêmes mots-clés BuiltIn de la même façon.

**Pourquoi c'est notable.** C'est la méthode "vérifier contre le concret" du Chapitre 3.1, appliquée cette fois par l'agent lui-même en cours d'audit, pas seulement par moi en amont pendant la construction du skill.

## Questions laissées ouvertes

- Les 4 règles restantes du skill (nommage de fichiers, un-resource-par-fonctionnalité, tags, variables en majuscules) n'ont pas encore été confrontées au projet réel — seules les règles "accents" et "mots-clés bas niveau" ont été validées par Test A / Test B à ce stade.
- Le mécanisme du cliquet a été validé sur deux règles distinctes (accents, mots-clés bas niveau) — reste à voir s'il tient aussi bien sur des règles plus structurelles (ex. un-resource-par-fonctionnalité), où la notion de "ligne ajoutée après le tag" est moins nette qu'un simple nom de Keyword.