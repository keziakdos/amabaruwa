```markdown
# Mission OpenCode — Construire et déployer Amabaruwa

Lis intégralement AGENTS.md à la racine avant toute action.

Nous construisons réellement l'écosystème Amabaruwa depuis WSL2 Ubuntu :
backend PocketBase sur mon VPS, import depuis mon site WordPress,
application Flutter Android en kinyarwanda et compilation GitHub Actions.

Ne te limite pas à proposer du code : inspecte le dépôt, implémente,
teste et déploie dans le périmètre autorisé.

Respecte les phases ci-dessous. Travaille de manière autonome pour les
opérations ordinaires et les créations dédiées au projet.

Fais une pause uniquement si :
- une authentification ou un secret est nécessaire ;
- une validation éditoriale, de licence ou de signature est indispensable ;
- un conflit, un écrasement ou une opération destructive est envisagé ;
- une modification pourrait toucher les autres services ;
- un contrôle essentiel échoue sans solution sûre.

Ne demande jamais de coller un secret dans la conversation.
Utilise le terminal interactif ou un fichier local protégé.

Si une phase est bloquée, documente le blocage et poursuis les tâches
indépendantes réalisables sans risque. Ne contourne pas un prérequis de sécurité.

## PHASE 1 — Inspection du dépôt et vérifications en lecture seule

1. Lire AGENTS.md.
2. Inspecter les fichiers, git status, la branche et les remotes.
3. Vérifier que le dépôt correspond à :
   https://github.com/keziakdos/amabaruwa.git
4. Tester l'accès Git en lecture.
5. Examiner les moyens d'authentification disponibles sans révéler de secrets.
   Ne pas prétendre que git ls-remote prouve le droit d'écriture.
6. Tester SSH avec :
   trading@148.230.124.5
7. Sur le VPS, vérifier :
   - identité et droits ;
   - architecture CPU et version OS ;
   - Docker et Compose ;
   - sockets TCP ;
   - conteneurs actifs et arrêtés, réseaux et bindings ;
   - disponibilité du port 8095 ;
   - Nginx et configuration effective pertinente ;
   - DNS A/AAAA de amabaruwa.rwazap.com ;
   - Certbot ;
   - espace disque et ressources disponibles.
8. Établir un état initial des services existants.
9. Relever l'avertissement Nginx préexistant sans le corriger.
10. Créer docs/progress.md avec les constats et le plan.

Si 8095 est encore libre, retenir :
127.0.0.1:8095:8090.

Sinon, proposer un autre port vérifié et demander validation.
Ne jamais libérer le port en arrêtant un service.

## PHASE 2 — Audit du site et base graphique

1. Consulter https://www.inzirayakristu.com si le réseau le permet.
2. Identifier les ressources graphiques réutilisables, titres, logo éventuel,
   structure des lettres et liens de médias.
3. S'appuyer sur l'identité décrite dans AGENTS.md :
   jaune solaire, or, blanc, bleu nuit, Lato et composition éditoriale.
4. Ne pas prétendre avoir vu une image qui n'est pas disponible dans le dépôt.
5. Créer docs/design-system.md :
   - palette et contrastes ;
   - typographie ;
   - espacements ;
   - composants ;
   - navigation ;
   - adaptation téléphone/tablette.
6. Préparer une maquette ou un prototype des écrans :
   - accueil ;
   - bibliothèque ;
   - lecture ;
   - lecteur audio ;
   - téléchargements.
7. Les données de démonstration doivent être explicitement fictives et
   séparées de la production. Ne pas inventer de citations religieuses.
8. Continuer avec la direction déjà approuvée sans demander une nouvelle
   validation pour chaque détail mineur.

## PHASE 3 — Backend reproductible

1. Choisir une version stable précise de PocketBase.
2. Documenter la version, sa provenance et les commandes compatibles.
3. Créer dans backend/ :
   - Dockerfile ;
   - compose.yaml ;
   - .env.example ;
   - migrations ;
   - configuration Nginx modèle.
4. Prévoir un projet Compose nommé amabaruwa.
5. Configurer :
   - écoute PocketBase 0.0.0.0:8090 dans le conteneur ;
   - publication 127.0.0.1:${AMABARUWA_PORT}:8090 ;
   - volume persistant ;
   - --dir explicite ;
   - chemin de migrations explicite ;
   - restart policy ;
   - healthcheck ;
   - logs bornés.
6. Créer les deux collections par migrations versionnées.
7. Définir les règles de lecture et d'écriture.
8. Tester sur une base isolée :
   - application des migrations ;
   - santé de l'API ;
   - lecture des contenus publiés ;
   - refus des écritures anonymes ;
   - comportement des brouillons et fichiers.
9. Ne pas utiliser une base de production comme environnement de test.

## PHASE 4 — Déploiement VPS, Nginx et certificat

Cette phase autorise la création des ressources dédiées à Amabaruwa,
pas la modification des autres projets.

1. Créer /opt/amabaruwa-pb avec des permissions adaptées.
2. Transférer uniquement les fichiers nécessaires au backend.
3. Installer les secrets par une méthode protégée, sans les afficher.
4. Revérifier le port.
5. Valider la configuration Compose.
6. Construire et démarrer uniquement le projet amabaruwa.
7. Vérifier la santé via 127.0.0.1:8095.
8. Créer le compte superuser avec la commande adaptée à la version retenue.
   Ne pas laisser le mot de passe dans l'historique ou les logs.
9. Inspecter les éventuelles configurations existantes pour le domaine.
10. Créer un vhost HTTP dédié et un répertoire de challenge ACME.
11. Exécuter nginx -t puis recharger Nginx.
12. Vérifier le DNS et l'accessibilité du challenge.
13. Générer le certificat amabaruwa.rwazap.com avec Certbot existant,
    de préférence via certonly --webroot, sans arrêter Nginx.
14. Ne pas modifier les certificats des autres domaines.
15. Ajouter HTTPS et redirection HTTP, avec client_max_body_size 200M.
16. Tester et recharger Nginx.
17. Vérifier :
    - certificat ;
    - API HTTPS ;
    - headers proxy ;
    - accès aux médias ;
    - protection de l'administration ;
    - renouvellement du certificat et rechargement associé.
18. Comparer l'état des autres services à l'état initial.
19. Documenter déploiement et retour arrière.

Le certificat n'existe pas encore : sa création fait partie de cette phase,
ce n'est pas un prérequis à fournir par le propriétaire.

## PHASE 5 — Inventaire et import

1. Créer scripts_migration/sync_inzira.py.
2. Créer un environnement Python et verrouiller les dépendances retenues.
3. Implémenter les modes :
   - inventaire ;
   - dry-run ;
   - import pilote ;
   - import complet ;
   - synchronisation.
4. Inspecter l'API WordPress posts/pages/media avec pagination.
5. Compléter avec le parsing HTML lorsque nécessaire.
6. Produire un inventaire :
   - lettre et numéro ;
   - titre ;
   - texte ;
   - PDF ;
   - audio ;
   - langue ;
   - source ;
   - taille connue ;
   - éléments manquants ou ambigus.
7. Estimer l'occupation disque avant le téléchargement massif.
8. Ne pas deviner les correspondances texte/PDF/audio en cas d'ambiguïté.
9. Importer d'abord une lettre complète dans l'instance cible.
10. Vérifier texte, fichiers, attribution et lecture API.
11. Relancer le pilote pour vérifier l'absence de doublons.
12. Importer les éléments non ambigus et produire un rapport des autres.
13. Pour le Mot du jour :
    - importer les publications existantes si elles sont identifiables ;
    - sinon proposer des citations exactes en brouillon ;
    - ne pas publier de sélection éditoriale inventée sans validation.
14. Exclure de Git les fichiers temporaires et données privées.

## PHASE 6 — Application Flutter

1. Initialiser Flutter Android à la racine si nécessaire, sans écraser
   AGENTS.md, PROMPT.md, backend/ ou les autres fichiers existants.
2. Utiliser le package Android com.rwazap.amabaruwa.
3. Épingler la version Flutter retenue et documenter la compatibilité Android.
4. Configurer les dépendances définies dans AGENTS.md.
5. Implémenter le thème solaire, les polices embarquées et les composants.
6. Mettre en place la localisation kinyarwanda.
7. Créer :
   - modèles ;
   - base Drift et migrations locales ;
   - repositories ;
   - client PocketBase ;
   - synchronisation ;
   - services de téléchargement ;
   - lecteur audio partagé.
8. Implémenter :
   - accueil avec Mot du jour ;
   - bibliothèque et recherche locale ;
   - lecture et progression ;
   - favoris ;
   - PDF intégré ;
   - lecteur audio complet et mini-lecteur ;
   - téléchargements ;
   - réglages ;
   - attribution au site.
9. Charger les données locales avant les appels réseau.
10. Prévoir tous les états hors ligne, vides et d'erreur.
11. Vérifier les fichiers avant de les marquer disponibles.
12. Configurer correctement les permissions et services Android.
13. Aucun secret administratif dans Flutter.
14. Base URL de production :
    https://amabaruwa.rwazap.com
    La rendre configurable pour les tests sans embarquer de secret.
15. Ne pas ajouter de compte, publicité, analytics ou notifications sans besoin.
16. Ne pas intégrer de contenu fictif dans la production.

## PHASE 7 — Tests

Créer et exécuter des tests pour :
- parsing et modèles ;
- repositories et cache ;
- migrations locales ;
- sélection du Mot du jour selon Africa/Kigali ;
- synchronisation et déduplication ;
- téléchargement interrompu ;
- fichier incomplet ;
- progression et favoris ;
- widgets principaux ;
- premier lancement sans réseau ;
- affichage avec une grande taille de texte.

Exécuter :
- format ;
- flutter analyze ;
- flutter test.

Vérifier si possible sur Android :
- streaming ;
- audio local ;
- écran verrouillé ;
- interruption audio ;
- PDF ;
- mode avion après téléchargement ;
- relance de l'application et reprise de position.

Si aucun appareil ou émulateur n'est disponible, fournir une checklist
de tests physiques. Ne pas déclarer ces tests réalisés.

Tester également une sauvegarde cohérente et une restauration backend
dans un environnement isolé, sans toucher à la production.

## PHASE 8 — GitHub Actions et builds

1. Créer .github/workflows/android-build.yml.
2. PR :
   - dépendances ;
   - format ;
   - analyse ;
   - tests.
3. Push main :
   - mêmes contrôles ;
   - APK installable de test ;
   - upload des artefacts.
4. Tag v* ou lancement manuel :
   - contrôles ;
   - APK release signé ;
   - AAB release signé ;
   - upload des artefacts.
5. Épingler Flutter, choisir Java compatible et documenter les versions.
6. Prévoir des signatures stables et distinctes pour test et publication.
7. Ne jamais créer silencieusement une identité de signature de production.
8. Si les secrets manquent :
   - expliquer comment les configurer ;
   - ne pas présenter un artefact debug comme une release Play Store ;
   - permettre un APK debug clairement identifié si utile aux premiers tests.
9. Ajouter cache, concurrence et durée de conservation raisonnable.
10. Ne pas déployer automatiquement le VPS depuis ce workflow.
11. Documenter comment télécharger l'APK depuis l'onglet Actions.

## PHASE 9 — Documentation, commit et livraison

1. Compléter README.md :
   - fonctionnement ;
   - installation WSL ;
   - commandes locales ;
   - configuration ;
   - compilation ;
   - installation APK.
2. Compléter :
   - docs/deployment.md ;
   - docs/backup-restore.md ;
   - docs/content-import.md ;
   - docs/design-system.md ;
   - docs/progress.md.
3. Ajouter les licences et attributions nécessaires.
4. Inspecter le diff, les fichiers stagés et les exclusions Git.
5. Vérifier l'absence de secrets, médias lourds et données de production.
6. Créer des commits cohérents.
7. Pousser vers la branche prévue, sans force-push et sans contourner
   une protection de branche. Utiliser une PR si nécessaire.
8. Vérifier le statut GitHub Actions si l'accès est disponible.
9. Ne pas annoncer une compilation réussie avant confirmation.
10. Fournir un rapport final :
    - fichiers et fonctionnalités créés ;
    - versions utilisées ;
    - URL backend ;
    - port retenu ;
    - état du certificat ;
    - nombre de contenus importés ;
    - tests exécutés et résultats ;
    - lien vers le workflow et artefacts si disponibles ;
    - blocages et tâches restantes ;
    - procédure de retour arrière.

Commence maintenant par la PHASE 1.
Ne crée aucune ressource sur le VPS avant les contrôles en lecture seule.
```