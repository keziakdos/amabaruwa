# Amabaruwa — Design system

Document de référence visuelle et ergonomique pour l'application Android
Amabaruwa. Il s'appuie sur l'audit du site https://www.inzirayakristu.com
effectué le 2026-10-30 et sur les contraintes d'`AGENTS.md`.

Aucune ressource n'est inventée : les fichiers cités ont été observés et
récupérés depuis le site source.

---

## 1. Sources et constats d'audit

- Le site est un WordPress avec thème Avada (version CSS 3.16.2).
- La page d'accueil publique est titrée « Murisanga - Inzira ya Kristu ».
- La navigation du site comporte : Murisanga, Nyirikwandika, Amabaruwa,
  Audio, Bene BUDAMA, Kudutumaho.
- Les lettres publiées vont de « Ibaruwa ya 1 » à « Ibaruwa ya cyenda »
  (9 lettres) ; les PDF publics observés vont de `Ibaruwa-1.pdf` à
  `Ibaruwa-9.pdf`, plus `Ibanze-Iriburiro-Ibikubiyemo.pdf`.
- Les pages Audio observées ne couvrent que l'introduction et les lettres 1
  à 4, tandis que la médiathèque contient des MP3 découpés par chapitres
  (`ibaruwa-ya-3-igice-cya-1.mp3`, etc.). **La correspondance exacte
  audio ↔ lettre est ambiguë et ne doit pas être devinée** (voir phase 5).
- Bannière officielle observée : `Kristu-aragaruste-2-scaled.jpg`
  (2560 × 1237), texte intégré « Kristu / Aragarutse / Arivugira ukuri kwe
  mu mabaruwa 9 n'inyandiko 16 ».
- Logo observé : `Logo-Inzirayakristu.jpg` (950 × 390), portant
  « BeneBUDAMA / AmabaruwaYaKristu ». Ce n'est pas un logo « Amabaruwa »
  isolé : son usage comme icône d'application demande validation.
- Favicon observé : `cropped-Logo-Inzirayakristu-1-192x192.jpg`.
- Le pied de page des lettres affiche :
  « KRISTU ARAGARUTSE — Arivugira ukuri kwe. AMABARUWA YA KRISTU —
  Urubuga rebero kuli murandasi : www.christsway.co.za ».
- Le site utilise Raleway / Open Sans. **L'application utilise Lato**,
  conformément à `AGENTS.md`, avec licence OFL embarquée.

Ressources intégrées au dépôt :

- `assets/images/brand/kristu-aragarutse-banner.jpg`
- `assets/images/brand/bene-budama-logo.jpg`
- `assets/fonts/Lato-{Light,Regular,Bold,Black}.ttf` + `OFL.txt`

---

## 2. Palette

| Rôle | Couleur | Usage |
| --- | --- | --- |
| Jaune solaire | `#FFC52E` | Accent principal, boutons primaires, en-tête |
| Jaune doré | `#FFB21F` | Dégradés, bordures d'accent |
| Jaune lumineux | `#FFE66D` | Halos, surbrillances douces |
| Blanc | `#FFFFFF` | Fond de lecture |
| Gris très clair | `#F4F4F4` | Fonds de cartes secondaires, séparateurs |
| Bleu nuit | `#25364A` | Texte principal, texte sur jaune |
| Texte secondaire | `#667085` | Métadonnées, légendes |
| Gris décoratif | `#9B9B9B` | Icônes désactivées uniquement |

### Contrastes calculés (WCAG 2.1)

| Combinaison | Ratio | Verdict |
| --- | --- | --- |
| `#25364A` sur `#FFFFFF` | 12,32:1 | AAA |
| `#FFC52E` sur `#25364A` | 7,79:1 | AAA |
| `#25364A` sur `#FFE66D` | 9,85:1 | AAA |
| `#25364A` sur `#F4F4F4` | 11,20:1 | AAA |
| `#667085` sur `#FFFFFF` | 4,97:1 | AA |
| `#667085` sur `#F4F4F4` | 4,52:1 | AA (limite) |
| `#9B9B9B` sur `#FFFFFF` | 2,78:1 | **Interdit pour du texte** |
| `#FFFFFF` sur `#FFC52E` | 1,58:1 | **Interdit** |
| `#FFFFFF` sur `#FFB21F` | 1,80:1 | **Interdit** |

### Règles

- Les boutons jaunes portent **toujours** du texte `#25364A`.
- Jamais de texte blanc sur jaune ou or.
- `#9B9B9B` réservé aux icônes décoratives/désactivées, jamais aux petits
  textes essentiels sur blanc.
- Les longs textes restent sur fond blanc ou `#F4F4F4`, jamais sur la
  bannière ou un dégradé.
- Dégradés dorés limités à l'en-tête, aux accents et aux états actifs.

---

## 3. Typographie

Police : **Lato** (OFL), embarquée dans `assets/fonts`.

| Style | Graisse | Taille (sp) | Interligne | Usage |
| --- | --- | --- | --- | --- |
| Display | Light | 30–34 | 1,2 | Titre d'accueil, bannière |
| H1 | Regular | 26 | 1,3 | Titre de lettre |
| H2 | Bold | 20 | 1,35 | Sections |
| H3 | Bold | 17 | 1,4 | Sous-sections |
| Corps | Regular | 18–20 | 1,55–1,7 | Lecture des lettres |
| Corps compact | Regular | 15 | 1,5 | Listes, métadonnées |
| Légende | Regular | 13 | 1,45 | Attribution, dates |
| Bouton | Bold | 15 | 1,2 | Actions |

Règles :

- La finesse (Light) est réservée aux grands titres, jamais aux paragraphes.
- Taille de lecture réglable (4 crans : 16, 18, 20, 22 sp) et respect de la
  taille système via `MediaQuery.textScaler`.
- Texte aligné à gauche, jamais justifié.
- Interligne de lecture entre 1,55 et 1,7.
- Aucune majuscule forcée sur de longs libellés kinyarwanda.

---

## 4. Espacements et formes

- Grille de base : 4 dp ; pas principaux : 8, 12, 16, 24, 32, 48.
- Marges d'écran : 20 dp sur téléphone, 32 dp sur tablette.
- Largeur de lecture maximale : 680 dp, colonne centrée sur tablette.
- Rayons : 12 dp (champs, petits blocs), 16 dp (cartes), 24 dp (feuilles).
- Ombres discrètes : `0 2 8 rgba(37,54,74,0.08)`.
- Zones tactiles : minimum 48 × 48 dp.
- Séparateurs : 1 dp `#F4F4F4` ou `#E7E9EE`.
- Aucun effet de verre derrière du texte.

---

## 5. Composants

### En-tête
- Dégradé `#FFC52E → #FFB21F` sur une bande limitée (80–96 dp).
- Titre bleu nuit, icône réglages à droite.
- Sur l'accueil : bannière officielle dans un cadre `16 dp`, avec voile
  blanc dégradé bas pour la lisibilité du titre, jamais sur le texte long.

### Carte « Ijambo ry'uyu munsi »
- Fond blanc, bordure `#F4F4F4`, rayon 16 dp.
- Libellé de section, citation (texte exact), référence, date éditoriale.
- Actions : partager ; écouter **uniquement** si un extrait audio réel existe.
- Si le mot du jour est absent : afficher le dernier contenu avec sa date,
  sans le présenter comme celui du jour.

### Carte de lettre
- Numéro dans une pastille jaune, titre bleu nuit, résumé court.
- Indicateurs distincts : texte disponible, PDF hors ligne, audio hors ligne.
- Progression linéaire fine, favori accessible par icône étiquetée.

### Boutons
- Primaire : fond `#FFC52E`, texte `#25364A`, rayon 12 dp, hauteur 48 dp.
- Secondaire : contour `#25364A` sur blanc.
- Discret : texte bleu nuit, sans fond.
- États `hover`/`focus`/`pressed` visibles, désactivation à 40 % d'opacité
  avec libellé conservé.

### Champs
- Fond blanc ou `#F4F4F4`, contour 1 dp, focus jaune doré 2 dp.
- Placeholder `#667085`, jamais `#9B9B9B` pour une information utile.

### Mini-lecteur
- Persistant au-dessus de la barre de navigation.
- Hauteur 64 dp, fond blanc, ombre haute.
- Titre sur une ligne, bouton lecture/pause 48 dp, progression fine.
- Ouvre le lecteur complet au toucher.

### États
- Chargement : squelettes gris clair, sans spinner plein écran.
- Vide : illustration typographique sobre + message kinyarwanda + action.
- Erreur : message clair, action « Ongera ugerageze ».
- Hors ligne : bandeau discret, contenu local conservé.

---

## 6. Navigation

Trois destinations principales, barre inférieure Material 3 :

1. **Aha mba** (Accueil) — icône maison.
2. **Amabaruwa** (Lettres) — icône livre.
3. **Ibikururwa** (Téléchargements) — icône téléchargement.

- Libellés visibles en kinyarwanda uniquement.
- Réglages accessibles depuis l'en-tête.
- Mini-lecteur persistant au-dessus de la barre lorsqu'un audio est chargé.
- Un seul lecteur audio partagé entre les écrans.

Traductions à faire relire (incertitude signalée) : « Aha mba »,
« Ibikururwa » ; alternatives documentées à valider par un locuteur.

---

## 7. Adaptation téléphone / tablette

- Mobile-first à partir de 320 dp.
- Téléphone : une colonne, marges 20 dp, barre inférieure.
- Tablette (≥ 600 dp) : rail de navigation latéral, contenu centré,
  colonne de lecture limitée à 680 dp.
- Paysage : la bannière d'accueil est réduite, jamais le texte de lecture.
- Grandes tailles de texte : les titres passent sur plusieurs lignes,
  les actions s'empilent, aucun débordement horizontal.

---

## 8. Mouvement et accessibilité

- Transitions 150–250 ms, courbes douces.
- Respect de `MediaQuery.disableAnimations` / réduction des animations.
- Sémantique explicite sur toutes les icônes (labels kinyarwanda).
- Focus clavier visible sur tablette et en mode desktop.
- Thème sombre : fond `#141B24`, surfaces `#1E2A38`, texte `#F4F6F8`,
  accent `#FFC52E`, contraste vérifié ; il ne bloque aucune fonctionnalité.
- Aucune information portée uniquement par la couleur.

---

## 9. Données de démonstration

- Les maquettes et fixtures utilisent des données **explicitement fictives**,
  préfixées « Urugero » ou « Fictif », et ne citent aucun texte religieux
  inventé.
- Ces données restent dans `docs/prototype/` et les tests ; elles ne partent
  jamais en production.
- Toute citation réelle doit provenir du site source, sans reformulation.

---

## 10. Points ouverts

1. **Logo / icône d'application** : le seul logo officiel observé est
   « BeneBUDAMA / AmabaruwaYaKristu ». Valider son usage comme icône, ou
   retenir une solution typographique sobre « Amabaruwa ».
2. **Variantes de la bannière** : l'image « Kristu / Aragarutse » diffère du
   bloc texte observé sur les pages de lettres
   (« KRISTU ARAGARUTSE / Arivugira ukuri kwe. / AMABARUWA YA KRISTU »).
   La version mobile doit préserver la formulation exacte de la page lettre.
3. **Correspondance audio ↔ lettre** : ambiguë (MP3 par chapitres) ; à
   résoudre en phase 5 avec inventaire et validation.
4. **Traductions kinyarwanda** de l'interface : à faire relire.
5. **Licence des images** : le propriétaire déclare détenir les droits ;
   conserver l'attribution `inzirayakristu.com`.
