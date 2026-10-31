# Amabaruwa

Application Android en kinyarwanda pour lire et écouter les **Lettres du
Christ**, consulter leurs PDF, découvrir un **Mot du jour** et télécharger les
contenus pour un usage hors ligne.

- Application : `com.rwazap.amabaruwa`
- Backend : https://amabaruwa.rwazap.com (PocketBase 0.40.6)
- Source éditoriale : https://www.inzirayakristu.com
- Flutter : **3.47.9** stable · Dart 3.13.7 · Java 17 · Android SDK 36

L'identité visuelle reprend la charte solaire du site : jaune solaire, or,
blanc et bleu nuit, avec la police Lato embarquée.

---

## 1. Structure

```text
lib/
  app/            application, routeur, shell, providers
  core/           config, thème, base Drift, réseau, audio, téléchargements
  features/       home, letters, daily_word, downloads, settings, player
  l10n/           libellés kinyarwanda (ARB)
  shared/         widgets communs
assets/           polices Lato et images de marque
backend/          PocketBase, migrations, Nginx, scripts de déploiement
scripts_migration/ import inzirayakristu.com
docs/             design, déploiement, import, sauvegarde, progression
test/             tests unitaires et widgets
```

Architecture : les widgets ne parlent ni à PocketBase ni aux fichiers. Les
données passent par les repositories, la base Drift locale est la source
d'affichage, puis la synchronisation met à jour la base en arrière-plan.

---

## 2. Prérequis WSL2 Ubuntu

```bash
sudo apt update
sudo apt install -y curl git xz-utils
```

Installer Java 17, Flutter 3.47.9 et les outils Android :

```bash
# Java 17 (Temurin)
mkdir -p ~/.local/jdk17
curl -L -o /tmp/jdk17.tar.gz \
  'https://api.adoptium.net/v3/binary/latest/17/ga/linux/x64/jdk/hotspot/normal/eclipse'
tar -xzf /tmp/jdk17.tar.gz -C ~/.local/jdk17 --strip-components=1

# Flutter 3.47.9
curl -L -o /tmp/flutter.tar.xz \
  https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.47.9-stable.tar.xz
tar -xf /tmp/flutter.tar.xz -C ~/.local

# Android command-line tools + SDK
mkdir -p ~/Android/Sdk/cmdline-tools
curl -L -o /tmp/cmdline-tools.zip \
  https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
python3 -c "import zipfile; zipfile.ZipFile('/tmp/cmdline-tools.zip').extractall('/tmp/cmdline')"
mv /tmp/cmdline/cmdline-tools ~/Android/Sdk/cmdline-tools/latest
chmod +x ~/Android/Sdk/cmdline-tools/latest/bin/*
~/Android/Sdk/cmdline-tools/latest/bin/sdkmanager --sdk_root="$HOME/Android/Sdk" \
  "platform-tools" "platforms;android-36" "build-tools;36.1.0"
```

Variables à ajouter à `~/.bashrc` :

```bash
export JAVA_HOME="$HOME/.local/jdk17"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$HOME/.local/flutter/bin:$PATH"
```

Vérification :

```bash
flutter doctor
```

---

## 3. Commandes locales

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build
flutter analyze
flutter test
dart format lib test
```

Lancer l'application avec une cible locale :

```bash
flutter run --dart-define=PB_URL=http://127.0.0.1:8095
```

La valeur par défaut est `https://amabaruwa.rwazap.com`. Aucun secret
d'administration n'est embarqué dans l'application.

---

## 4. Compilation Android

```bash
flutter build apk --debug
flutter build apk --release
flutter build appbundle --release
```

APK debug : `build/app/outputs/flutter-apk/app-debug.apk`.

Versions documentées :

- `versionName` : `1.0.0` (`version` dans `pubspec.yaml`)
- `versionCode` : `1` (suffixe `+1` dans `pubspec.yaml`)
- `minSdk` : 24 · `compileSdk` : 36 · `targetSdk` : 36
- Java/Kotlin : 17

Signature de publication : `android/key.properties` + keystore, jamais
versionnés. Sans ces fichiers, un build release reste signé en debug et ne
doit pas être présenté comme un artefact Play Store.

Installation sur un téléphone connecté :

```bash
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

---

## 5. Backend

Voir `backend/README.md` et `docs/deployment.md`.

```bash
cd backend
cp .env.example .env
docker compose up -d --build
curl http://127.0.0.1:8095/api/health
```

Migrations appliquées automatiquement au démarrage. Le port n'est publié que
sur `127.0.0.1`. Nginx assure le TLS et le proxy public.

---

## 6. Import des contenus

Voir `docs/content-import.md`.

```bash
cd scripts_migration
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
.venv/bin/python sync_inzira.py inventory
.venv/bin/python sync_inzira.py dry-run
```

Modes : `inventory`, `dry-run`, `pilot`, `full`, `sync`.
Identifiants PocketBase via `PB_ADMIN_EMAIL` + `PB_ADMIN_PASSWORD` ou
`PB_ADMIN_PASSWORD_FILE` (mode 600).

---

## 7. Tests

```bash
flutter analyze
flutter test
```

Les tests couvrent : jour éditorial Africa/Kigali, sélection du Mot du jour,
modèles et texte, intégrité des fichiers téléchargés, persistance
favoris/progression, reprise d'un téléchargement interrompu et premier
lancement hors ligne avec grande taille de texte.

Les tests physiques Android (streaming, audio local, écran verrouillé, PDF,
mode avion) restent à exécuter sur un appareil ; voir
`docs/progress.md`.

---

## 8. GitHub Actions

Workflow : `.github/workflows/android-build.yml`.

- Pull request : format, analyse, tests.
- Push `main` : mêmes contrôles + APK debug installable.
- Tag `v*` ou lancement manuel : APK/AAB release signés si les secrets
  `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`,
  `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD` sont configurés ; sinon un APK
  debug de repli est publié avec un avertissement explicite.

Téléchargement : onglet **Actions** → exécution → **Artifacts**.

---

## 9. Attribution et licence

Textes, PDF et audios : **inzirayakristu.com**, utilisés avec l'autorisation
du propriétaire. Police Lato sous licence OFL (`assets/fonts/OFL.txt`).

Ne pas réutiliser les contenus sans respecter cette attribution.
