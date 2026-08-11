import 'package:flutter/material.dart';

import '../data/recettes_repository.dart';
import '../models/recette.dart';

/// État global de l'application, exposé via `provider`.
///
/// Centralise :
/// - la liste des recettes (source unique de vérité, pas de duplication
///   de données dans les écrans),
/// - la recherche et le filtre de catégorie en cours,
/// - le thème clair/sombre choisi par l'utilisateur.
///
/// Les écrans lisent cet état avec `context.watch<AppState>()` et le
/// modifient avec `context.read<AppState>()`, sans jamais manipuler les
/// données directement.
class AppState extends ChangeNotifier {
  final List<Recette> _recettes = RecettesRepository.donneesInitiales();

  String _recherche = '';
  String? _filtreCategorie;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  String get recherche => _recherche;
  String? get filtreCategorie => _filtreCategorie;

  /// Toutes les recettes, non filtrées.
  List<Recette> get toutesLesRecettes => List.unmodifiable(_recettes);

  /// Recettes filtrées par la recherche texte et la catégorie active.
  List<Recette> get recettesFiltrees {
    return _recettes.where((r) {
      final correspondRecherche = _recherche.isEmpty ||
          r.titre.toLowerCase().contains(_recherche.toLowerCase());
      final correspondCategorie =
          _filtreCategorie == null || r.categorie == _filtreCategorie;
      return correspondRecherche && correspondCategorie;
    }).toList();
  }

  /// Recettes marquées comme favorites.
  List<Recette> get favoris => _recettes.where((r) => r.favori).toList();

  Recette? getById(String id) {
    try {
      return _recettes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  void setRecherche(String valeur) {
    _recherche = valeur;
    notifyListeners();
  }

  void setFiltreCategorie(String? categorie) {
    _filtreCategorie = categorie;
    notifyListeners();
  }

  void toggleFavori(String id) {
    final recette = getById(id);
    if (recette == null) return;
    recette.favori = !recette.favori;
    notifyListeners();
  }

  void ajouterRecette(Recette recette) {
    _recettes.insert(0, recette);
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
