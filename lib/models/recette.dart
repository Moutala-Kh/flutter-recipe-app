/// Représente une recette de cuisine.
///
/// C'est le seul endroit où la "forme" d'une recette est définie.
/// Aucun widget ne doit construire ses propres données : tout passe
/// par des instances de [Recette] fournies via [AppState].
class Recette {
  final String id;
  final String titre;
  final String categorie; // Entrée, Plat, Dessert
  final String difficulte; // Facile, Moyen, Difficile
  final int tempsPreparation; // en minutes
  final String description;
  final List<String> ingredients;
  bool favori;

  Recette({
    required this.id,
    required this.titre,
    required this.categorie,
    required this.difficulte,
    required this.tempsPreparation,
    required this.description,
    required this.ingredients,
    this.favori = false,
  });
}
