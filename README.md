# Mes Recettes: Application Flutter multi-écrans

Application Flutter de gestion de recettes de cuisine, avec navigation multi-écrans, recherche, favoris et thème clair/sombre.

## Fonctionnalités

- Liste des recettes avec **recherche** par titre et **filtre** par catégorie
- Écran détail avec **passage de paramètre** (id de la recette dans l'URL)
- Formulaire d'ajout avec **validation** sur 5 champs
- Gestion des **favoris**
- **Thème clair/sombre**, basculable dans les paramètres
- Interface **responsive** : liste sur mobile, grille sur tablette

## Choix techniques (correspondance avec les exigences)

| Exigence | Où c'est fait |
|---|---|
| ≥ 4 écrans | `ListeRecettesScreen`, `DetailRecetteScreen`, `FormulaireRecetteScreen`, `FavorisScreen`, `ParametresScreen` (5 écrans) |
| Navigation GoRouter, routes nommées | `lib/router/app_router.dart` |
| Liste avec recherche/filtre | `ListeRecettesScreen` (`TextField` + `CategoryFilterBar`) |
| Détail avec passage de paramètre | route `/recette/:id` → `DetailRecetteScreen(id: ...)` |
| Formulaire, validation ≥ 3 champs | `FormulaireRecetteScreen` (titre, temps, catégorie, difficulté, description, ingrédients) |
| Thème clair/sombre | `lib/theme/app_theme.dart` + bascule dans `ParametresScreen` |
| ≥ 8 widgets différents | `ListView`, `GridView`, `Stack`, `Card`, `Chip`/`FilterChip`, `TextFormField`, `DropdownButtonFormField`, `NavigationBar`, `SliverAppBar`, `SwitchListTile`, `FloatingActionButton`, `CircleAvatar` |
| ≥ 3 widgets réutilisables dans `widgets/` | `RecetteCard`, `FavoriButton`, `CategoryFilterBar`, `EmptyState`, `MainScaffold` (5 widgets) |
| Responsive mobile/tablette | `LayoutBuilder` dans `ListeRecettesScreen` (liste ↔ grille selon largeur), largeur max contrainte dans `DetailRecetteScreen` |
| Pas de données en dur dans les widgets | Séparation stricte : `models/` (structure), `data/` (données de départ), `providers/` (état) — les widgets ne reçoivent que des objets déjà construits |

## Structure du projet

```
lib/
├── main.dart                        # point d'entrée
├── models/
│   └── recette.dart                 # structure de données
├── data/
│   └── recettes_repository.dart     # données de départ (aucune donnée en dur dans les widgets)
├── providers/
│   └── app_state.dart               # état global (ChangeNotifier) : recettes, recherche, favoris, thème
├── theme/
│   └── app_theme.dart               # thèmes clair et sombre
├── router/
│   └── app_router.dart              # routes GoRouter
├── screens/
│   ├── liste_recettes_screen.dart
│   ├── detail_recette_screen.dart
│   ├── formulaire_recette_screen.dart
│   ├── favoris_screen.dart
│   └── parametres_screen.dart
└── widgets/
    ├── recette_card.dart
    ├── favori_button.dart
    ├── category_filter_bar.dart
    ├── empty_state.dart
    └── main_scaffold.dart
```

## Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (canal stable)
- Un émulateur Android, un simulateur iOS, ou Chrome (le projet fonctionne aussi sur le web)

Vérifier l'installation :

```bash
flutter doctor
```

## Installation et lancement

```bash
git clone <url-de-votre-depot>
cd recipe_app
flutter pub get
flutter run
```

Pour tester le mode responsive, lancez sur un appareil/émulateur tablette, ou redimensionnez la fenêtre si vous lancez sur `flutter run -d chrome` / `flutter run -d macos` (desktop).

## Captures d'écran

Voir le dossier [`screenshots/`](./screenshots) — à compléter après le premier lancement (voir instructions dans ce dossier).

## Licence

Projet réalisé à des fins pédagogiques (certification Flutter).
