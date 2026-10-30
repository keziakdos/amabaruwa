```
## 1. Mission

Construire et déployer Amabaruwa, une application Android en kinyarwanda
permettant de lire et écouter les Lettres du Christ, consulter leurs PDF,
découvrir un Mot du jour et télécharger les contenus pour une utilisation
hors ligne.

L'application doit préserver l'identité visuelle de :
https://www.inzirayakristu.com

Elle doit être moderne, lumineuse, paisible, accessible et fiable sur des
téléphones Android modestes. Ne pas créer une interface générique sans
rapport avec le site.

Communication avec le propriétaire : français.
Interface utilisateur et contenus : kinyarwanda.
Identifiants techniques du code : cohérents et de préférence en anglais.

## 2. Environnement et faits vérifiés

- Développement : WSL2 Ubuntu sous Windows 11.
- Dépôt : https://github.com/keziakdos/amabaruwa.git
- Application Android : com.rwazap.amabaruwa
- VPS : 148.230.124.5, Ubuntu 24.04 déclaré.
- Connexion SSH : trading@148.230.124.5
- Utilisateur trading : membre des groupes sudo et docker.
- Répertoire backend : /opt/amabaruwa-pb
- Domaine backend : https://amabaruwa.rwazap.com
- DNS A observé : 148.230.124.5
- Aucun AAAA ou CNAME observé lors de l'audit.
- Nginx est installé sur l'hôte et écoute sur 80 et 443.
- Certbot est installé.
- Aucun certificat Amabaruwa n'existait lors de l'audit.
- Docker Compose est disponible.
- Environ 33 Go de disque étaient disponibles lors de l'audit.
- Le port TCP 8095 était libre lors de l'audit.
- Aucun conteneur existant ne réservait ce port.

Ces observations ne remplacent pas les vérifications au moment d'exécuter.

Services existants à préserver :
- rwaresto-app : 127.0.0.1:3107
- rwatrade_app : 127.0.0.1:5005
- rwazap_news_app : 127.0.0.1:8001
- n8n : port 5678
- coach-app : 127.0.0.1:8005
- n8n-new : conteneur arrêté, binding 127.0.0.1:5679

Un avertissement Nginx préexistant concerne :
protocol options redefined for [::]:443
dans /etc/nginx/sites-enabled/rwaresto.rwazap.com.conf:26

Le test nginx -t réussissait malgré cet avertissement.
Ne pas corriger ce site dans le cadre du projet Amabaruwa.

## 3. Règles impératives de sécurité

- Utiliser trading pour SSH, pas root.
- Employer sudo uniquement pour les opérations qui le nécessitent.
- Ne jamais arrêter, supprimer, recréer ou mettre à jour un autre service.
- Ne jamais lancer docker system prune, docker volume prune ou un nettoyage global.
- Ne jamais modifier globalement les permissions de /opt.
- Ne jamais écraser /etc/nginx/nginx.conf ou le vhost par défaut.
- Ne jamais supprimer ou modifier les certificats des autres domaines.
- Ne pas redémarrer Nginx : tester puis recharger sa configuration.
- Ne pas modifier les règles globales du pare-feu sans validation explicite.
- Ne jamais désactiver la vérification des clés SSH.
- Ne pas demander de mot de passe dans les fichiers ou messages.
- Ne jamais afficher de secrets dans les logs, commandes documentées ou rapports.
- Ne jamais embarquer de compte superuser PocketBase dans Flutter.
- Ne jamais commiter .env, clés privées, keystores ou données de production.
- Ne pas exposer les sauvegardes ou pb_data via Nginx.
- L'accès au groupe docker est privilégié : ne l'utiliser que pour le projet.
- Si une commande échoue, comprendre la cause avant de continuer.
- Ne pas prétendre qu'un test a réussi sans l'avoir exécuté.

Les créations dédiées à Amabaruwa sont autorisées dans le périmètre du plan.
Demander validation en cas de conflit, écrasement, destruction, changement
hors périmètre, secret manquant ou choix juridique non résolu.

## 4. Architecture du dépôt

Conserver Flutter à la racine, sans écraser les fichiers existants.

Structure cible :

- AGENTS.md
- PROMPT.md
- README.md
- lib/
  - app/
  - core/
    - config/
    - theme/
    - database/
    - network/
  - l10n/
  - features/
    - home/
    - letters/
    - daily_word/
    - downloads/
    - audio/
    - settings/
  - shared/
    - widgets/
- assets/
  - fonts/
  - images/
- test/
- integration_test/
- backend/
  - Dockerfile
  - compose.yaml
  - .env.example
  - pb_migrations/
  - nginx/
- scripts_migration/
- docs/
  - design-system.md
  - deployment.md
  - backup-restore.md
  - content-import.md
  - progress.md
- .github/workflows/android-build.yml

Dans les features, séparer modèles, accès aux données, logique et présentation.
Les widgets ne doivent pas appeler directement PocketBase ou gérer les fichiers.

## 5. Design system

### Identité

La référence visuelle fournie montre :
- une colonne centrale blanche ;
- un environnement jaune solaire et doré ;
- une bannière lumineuse ;
- des titres fins bleu nuit ;
- une composition éditoriale aérée ;
- une séparation discrète évoquant des nuages.

Textes de la bannière fournie :
- KRISTU ARAGARUTSE
- Arivugira ukuri kwe.
- AMABARUWA YA KRISTU

Préserver les formulations originales, après vérification à la source.

Ne pas inventer de logo ou ajouter des symboles religieux génériques.
Réutiliser les ressources originales disponibles et autorisées.
Si une ressource manque, utiliser une solution typographique sobre et signaler
le manque, sans présenter une approximation comme le logo officiel.

### Palette

- Jaune solaire : #FFC52E
- Jaune doré : #FFB21F
- Jaune lumineux : #FFE66D
- Blanc : #FFFFFF
- Gris très clair : #F4F4F4
- Bleu nuit : #25364A
- Texte secondaire proposé : #667085
- Gris décoratif / désactivé : #9B9B9B

Vérifier les contrastes réels.
Ne pas utiliser #9B9B9B pour de petits textes essentiels sur blanc.
Les boutons jaunes utilisent du texte bleu nuit, pas blanc.
Ne pas placer les longs textes sur des images ou dégradés.

### Typographie

Choix principal : Lato, embarquée dans assets/fonts avec sa licence.
Roboto peut servir d'alternative documentée si nécessaire.

- Titres de présentation : Light ou Regular.
- Titres de section : Regular ou Medium.
- Corps de lecture : Regular, 18 à 20 sp par défaut.
- Interligne de lecture : environ 1,55 à 1,7.
- Taille du texte réglable.
- Respecter les paramètres de taille de texte du système.

La finesse est réservée aux titres, pas aux longs paragraphes.

### Ergonomie

- Material 3 personnalisé, pas un thème violet par défaut.
- Fond clair et lecture sur blanc par défaut.
- Dégradés dorés limités à l'en-tête et aux accents.
- Coins modérément arrondis : environ 12 à 16 dp.
- Ombres discrètes.
- Zones tactiles d'au moins 48 dp.
- Animations légères et réduction des animations respectée.
- Icônes cohérentes avec labels et sémantique d'accessibilité.
- Aucun effet de verre derrière le texte.
- Mise en page adaptée aux petits écrans et tablettes.
- Sur tablette, colonne de lecture centrée à largeur limitée.
- Texte aligné à gauche, non justifié.
- Thème sombre accessible sans retarder les fonctionnalités essentielles.

Ne pas recopier les grandes marges jaunes du site sur un petit écran.
Adapter l'identité au mobile plutôt que reproduire une page Web miniature.

## 6. Langue

- Interface exclusivement en kinyarwanda.
- Centraliser les libellés dans des fichiers ARB.
- Ne pas disperser les textes dans les widgets.
- Vérifier le support effectif de la locale rw dans Flutter et les packages.
- Ajouter les localisations nécessaires pour les composants non couverts.
- Aucun message technique brut, français ou anglais dans l'interface finale.
- Faire relire les traductions incertaines ; les identifier dans la documentation.
- Ne pas reformuler automatiquement les textes religieux.
- Préserver paragraphes, références, titres et ponctuation.
- Référence éditoriale des dates : Africa/Kigali.

## 7. Stack Flutter

Utiliser des versions stables compatibles, choisies et documentées au démarrage.
Versionner pubspec.lock.

Dépendances proposées :
- flutter_riverpod : état et injection.
- go_router : navigation.
- pocketbase : client backend.
- dio : réseau et téléchargements.
- drift et dépendances SQLite compatibles : base locale structurée.
- shared_preferences : préférences uniquement.
- path_provider : répertoires privés de l'application.
- just_audio et just_audio_background : lecteur audio unique.
- share_plus : partage natif.
- flutter_html ou équivalent maintenu : rendu HTML nettoyé.
- intl et système de localisation Flutter.

PDF :
- Vérifier d'abord l'éligibilité et les conditions de licence de
  syncfusion_flutter_pdfviewer.
- Ne pas présumer qu'une licence gratuite s'applique.
- Si la licence n'est pas confirmée, évaluer une alternative maintenue
  telle que pdfrx, avec vérification de sa licence et de sa compatibilité.
- Documenter le choix.

Ne pas imposer minSdk 21 si les versions retenues nécessitent davantage.
Fixer minSdk, compileSdk, targetSdk, Java et Gradle selon leurs compatibilités
et les exigences de publication applicables au moment du développement.

## 8. Fonctionnalités de l'application

### Navigation

Trois destinations principales :
- Accueil.
- Lettres.
- Téléchargements.

Tous les libellés visibles doivent être traduits en kinyarwanda.

Réglages accessibles depuis l'en-tête.
Mini-lecteur persistant au-dessus de la navigation lorsqu'un audio est chargé.

### Accueil

- Bannière lumineuse inspirée du site.
- Carte "Ijambo ry’uyu munsi".
- Citation exacte et référence.
- Partage.
- Écoute uniquement lorsqu'un extrait audio réel existe.
- Reprendre la dernière lecture.
- Reprendre l'écoute.
- Accès à la bibliothèque.

### Bibliothèque

- Liste éditoriale des lettres avec numéro et titre.
- Recherche locale.
- Favoris locaux.
- Progression de lecture et d'écoute.
- Indicateurs distincts pour texte, PDF et audio hors ligne.
- États chargement, vide, erreur et hors ligne.

### Détail d'une lettre

- Lecture du texte comme mode principal.
- Taille de police réglable.
- Position de lecture persistante.
- Lecture PDF intégrée.
- Lecture audio.
- Téléchargement PDF, audio ou pack complet.
- Attribution et lien vers la source.

### Audio

- Lecture streaming ou fichier local vérifié.
- Un seul lecteur partagé entre les écrans.
- Play/pause, recherche, avance/recul de 15 secondes.
- Vitesse de lecture.
- Reprise de position.
- Minuterie d'arrêt.
- Gestion des interruptions et du débranchement des écouteurs.
- Notification et commandes sur écran verrouillé.
- Configuration Android complète selon les packages retenus.

Permissions et services Android :
- INTERNET.
- WAKE_LOCK si requis.
- FOREGROUND_SERVICE.
- FOREGROUND_SERVICE_MEDIA_PLAYBACK.
- Autres déclarations ou permissions uniquement si nécessaires selon
  les versions Android et le comportement réel du package.

Ne pas demander d'accès global au stockage pour les fichiers privés.

### Téléchargements

- Progression, annulation et nouvelle tentative.
- Gestion de l'espace insuffisant.
- Téléchargements vers des fichiers temporaires .part.
- Vérification de taille et d'empreinte lorsqu'elle est disponible.
- Renommage final uniquement après validation.
- Persistance des états.
- Suppression contrôlée sans supprimer le texte.
- Déduplication des téléchargements.
- Concurrence limitée.
- Reprise HTTP uniquement si le serveur la supporte correctement.

Ne pas considérer File.exists() comme une preuve d'intégrité.
Utiliser les API de fichiers asynchrones.

La première version ne garantit pas des téléchargements après fermeture
ou arrêt forcé de l'application. Ne pas promettre ce comportement sans
implémentation Android dédiée et tests.

### Compte utilisateur

Aucun compte utilisateur dans la première version.
Favoris, réglages et progression restent locaux.

## 9. Offline-first

- La base SQLite locale est la source de lecture de l'interface.
- Afficher les données locales en premier.
- Synchroniser ensuite en arrière-plan et mettre à jour transactionnellement.
- shared_preferences ne stocke pas la bibliothèque complète.
- Conserver la progression et les favoris lors des synchronisations.
- Gérer les modifications et suppressions de contenus de manière explicite.
- Ne pas supprimer les fichiers utilisateurs sans règle documentée.
- Prévoir un message clair au premier lancement sans Internet.
- Ne pas prétendre disposer de contenu hors ligne avant son premier import local.
- En l'absence de Mot du jour actuel, afficher honnêtement le dernier contenu
  disponible avec sa date, et non comme s'il s'agissait de celui du jour.

## 10. Backend PocketBase

### Déploiement

- Projet Compose : amabaruwa.
- Répertoire : /opt/amabaruwa-pb.
- Port préféré : 8095.
- Variable dédiée : AMABARUWA_PORT.
- Binding hôte : 127.0.0.1:${AMABARUWA_PORT}:8090.
- PocketBase écoute dans le conteneur sur 0.0.0.0:8090.
- Répertoire des données explicitement configuré avec --dir=/pb_data.
- Montage persistant ./pb_data:/pb_data.
- Montage des migrations en lecture seule avec chemin explicitement configuré.
- Commandes adaptées à la version exacte retenue.

Construire une image à partir d'une version officielle épinglée.
Vérifier architecture CPU et intégrité du téléchargement.
Ne pas utiliser un tag latest non maîtrisé.
Ne pas ajouter de dépendance à une image communautaire non auditée.

Prévoir :
- restart policy ;
- healthcheck fonctionnel avec les outils réellement présents ;
- rotation des logs ;
- utilisateur non-root et permissions adaptées lorsque possible ;
- absence de mode privilégié et de montage du socket Docker.

### Contrôle du port

Avant chaque premier lancement :
- inspecter ss -ltnp ;
- inspecter docker ps -a ;
- inspecter les bindings des conteneurs.

Si 8095 est occupé :
- ne pas arrêter le service concerné ;
- proposer un port libre ;
- faire valider le changement ;
- mettre à jour Compose, Nginx et la documentation ensemble.

### Nginx et TLS

- Nouveau vhost dédié à amabaruwa.rwazap.com.
- Proxy vers http://127.0.0.1:${AMABARUWA_PORT}.
- Ne pas publier 80 ou 443 depuis le conteneur.
- client_max_body_size 200M dans ce vhost uniquement.
- Transmettre correctement Host et les en-têtes de proxy.
- Configurer les proxies de confiance PocketBase selon la version choisie.
- PocketBase utilise SSE, pas WebSocket, pour son temps réel.
- Si le temps réel est utilisé : route adaptée, buffering désactivé et
  délais appropriés. Il n'est pas nécessaire à la première version.
- Préserver le téléchargement et les requêtes Range pour les médias.

Procédure TLS :
1. Vérifier DNS, ports et configuration effective.
2. Créer un vhost HTTP dédié sans références à un certificat inexistant.
3. Tester puis recharger Nginx.
4. Utiliser Certbot existant, de préférence certonly avec challenge webroot.
5. Ne pas arrêter Nginx pour un challenge standalone.
6. Obtenir uniquement le certificat du domaine Amabaruwa.
7. Ajouter HTTPS puis redirection HTTP vers HTTPS en conservant le challenge.
8. Tester et recharger.
9. Vérifier le renouvellement et le rechargement après renouvellement.

Ne pas réutiliser arbitrairement l'adresse e-mail d'un autre compte ACME.
Demander une adresse ou confirmation si nécessaire.

Protéger l'interface d'administration publique ; privilégier un accès local
via tunnel SSH pour l'administration. Le blocage de l'interface /_/ ne
remplace pas la protection des API et des identifiants.

### Sécurité des données

- Lecture anonyme des seuls contenus publiés.
- Création, modification et suppression interdites aux clients anonymes.
- Règles PocketBase explicites et testées.
- Champs de fichiers publics uniquement pour des contenus réellement publics.
- Un filtre de publication des records ne doit pas être considéré comme
  une protection suffisante des fichiers de brouillons.
- Ne pas téléverser de contenus confidentiels sans règles de fichiers adaptées.
- Aucun superuser dans l'application.
- Secrets utilisés uniquement côté administration/import.

Créer les collections par migrations versionnées, rejouables sur une base neuve.

## 11. Collections

Adapter les types et API à la version PocketBase épinglée.

### lettres

- numero : nombre entier positif.
- slug : texte.
- langue : texte, valeur rw.
- titre : texte.
- contenu_html : texte ou editor nettoyé.
- statut : brouillon ou publie.
- pdf_file : fichier unique, PDF, maximum 50 MiB.
- audio_file : fichier unique, MP3, maximum 100 MiB.
- url_origine : URL.
- source_key : texte stable et unique pour l'import.
- source_modified_at : date optionnelle.
- pdf_size_bytes : nombre optionnel.
- audio_size_bytes : nombre optionnel.
- pdf_sha256 : texte optionnel.
- audio_sha256 : texte optionnel.
- audio_duration_seconds : nombre optionnel.

Prévoir les index nécessaires, dont unicité de source_key et de
(numero, langue) pour les lettres numérotées.
Ne pas classer artificiellement d'autres documents comme des lettres.

### mots_du_jour

- date_locale : texte YYYY-MM-DD, jour éditorial Africa/Kigali.
- langue : texte, valeur rw.
- titre : texte.
- citation : texte exact.
- reference_source : texte.
- lettre_liee : relation optionnelle vers lettres.
- audio_extrait : fichier optionnel.
- statut : brouillon ou publie.
- source_key : texte stable et unique.

Unicité de (date_locale, langue).
Toute relation exposée doit pointer vers un contenu publiable.

Ne pas présenter l'audio complet d'une lettre comme un extrait audio.
Ne pas inventer de citation, de référence ou de calendrier éditorial.

## 12. Import des contenus

Source : https://www.inzirayakristu.com

Le propriétaire déclare posséder les droits des textes, PDF et audios,
ainsi que les droits de republication Android, d'hébergement et de
téléchargement hors ligne.

Attribution à conserver : inzirayakristu.com.

Créer scripts_migration/sync_inzira.py et ses dépendances verrouillées.

Fonctions attendues :
- mode inventaire ;
- mode dry-run ;
- import pilote ;
- import complet ;
- synchronisation idempotente ;
- rapport des erreurs et éléments ignorés.

Explorer selon disponibilité :
- API WordPress posts, pages et media ;
- pagination et contenus embarqués ;
- HTML public pour les liens codés en dur.

Mesures obligatoires :
- timeouts ;
- reprises limitées avec backoff ;
- débit raisonnable ;
- validation des URL, redirections et domaines de médias ;
- refus des destinations locales/privées non autorisées ;
- contrôle MIME, taille et nom des fichiers ;
- empreintes pour éviter les doublons ;
- nettoyage du HTML sans réécriture du texte ;
- aucun script ou contenu actif dans le rendu mobile ;
- conservation de la provenance ;
- secrets hors des arguments et logs exposés ;
- fichiers temporaires exclus de Git.

Ne pas contourner une authentification ou une restriction d'accès.
Ne pas télécharger tout le site sans inventaire préalable.

Pour les mots du jour :
- privilégier les publications existantes clairement identifiées ;
- sinon préparer des extraits exacts et référencés en brouillon ;
- demander validation éditoriale avant publication ;
- utiliser des fixtures de démonstration uniquement en environnement de test.

## 13. Sauvegardes et maintenance

Documenter :
- sauvegarde cohérente de la base et des fichiers ;
- rétention ;
- export hors VPS ;
- test de restauration en environnement isolé ;
- procédure de mise à jour ;
- procédure de retour arrière compatible avec les migrations.

Ne pas copier simplement une base SQLite active sans méthode cohérente.
Un volume persistant n'est pas une sauvegarde.
Une sauvegarde sur le même VPS n'est pas une protection contre sa perte.

Ne jamais restaurer une sauvegarde sur la production pour "tester".

## 14. GitHub Actions et signature

Workflow unique :
.github/workflows/android-build.yml

Déclencheurs :
- pull_request : analyse et tests, sans secrets de publication ;
- push sur main : analyse, tests et APK de test ;
- workflow_dispatch ou tag v* : APK/AAB de publication signés.

Épingler Flutter et choisir Java compatible avec Gradle/AGP.
Java 17 est le choix initial, à confirmer selon les versions retenues.

Exécuter au minimum :
- flutter pub get ;
- vérification du format ;
- flutter analyze ;
- flutter test ;
- build Android approprié.

Utiliser actions/upload-artifact@v4 si toujours pris en charge,
sinon une version compatible documentée.

Signature :
- APK de test installable avec identité de signature stable.
- Keystore de test distinct du keystore de publication.
- Secrets stockés dans GitHub Secrets, jamais dans Git.
- Si la signature stable manque, ne pas inventer de clé de production :
  signaler le blocage et, si utile, fournir un APK debug clairement nommé.
- Ne pas présenter un AAB signé avec une clé debug comme prêt pour le Store.
- Publication : construire APK release et AAB release avec la vraie configuration.
- Documenter versionCode et versionName.
- Ne pas publier automatiquement sur Google Play.

Limiter les permissions du workflow et la conservation des artefacts.
Ne pas ajouter le déploiement automatique VPS à chaque push dans cette version.

## 15. Git et suivi

- Inspecter git status et le contenu existant avant de générer des fichiers.
- Ne pas écraser des modifications utilisateur.
- Ne pas force-push.
- Ne pas remplacer une configuration d'authentification fonctionnelle.
- Tester la lecture du dépôt sans prétendre que cela prouve le droit d'écriture.
- Vérifier les fichiers stagés et rechercher les secrets avant commit.
- Exclure données, caches, médias temporaires, sauvegardes et keystores.
- Versionner les migrations, configurations exemples, tests et documentation.
- Mettre à jour docs/progress.md après chaque phase.
- Consigner décisions, commandes exécutées, tests et blocages sans secrets.

## 16. Critères de livraison

Ne pas déclarer le projet terminé avant d'avoir vérifié :

- API accessible en HTTPS.
- Port PocketBase publié uniquement sur loopback.
- Lecture publique limitée aux contenus publiés.
- Écriture anonyme refusée.
- Données persistantes après recréation du conteneur du projet.
- Sauvegarde et restauration isolée testées ou blocage explicite.
- Import rejouable sans doublons.
- Aucun secret dans Git ou Flutter.
- Application entièrement localisée, avec incertitudes linguistiques signalées.
- Charte solaire respectée.
- Texte et fichiers disponibles hors ligne après synchronisation/téléchargement.
- Premier lancement hors ligne géré.
- Téléchargement interrompu non marqué comme terminé.
- PDF affiché dans l'application.
- Lecture audio locale et streaming.
- Reprise de lecture et d'écoute.
- Analyse et tests réussis.
- APK téléchargeable depuis GitHub Actions.
- Tests physiques Android documentés ; ne pas les déclarer exécutés sans appareil.
- Services existants préservés.
```