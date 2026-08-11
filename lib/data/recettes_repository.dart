import '../models/recette.dart';

/// Fournit les données initiales de l'application.
///
/// Aucune donnée n'est écrite en dur dans les widgets : ils reçoivent
/// toujours des [Recette] via [AppState], qui lui-même s'appuie sur ce
/// dépôt au démarrage.
class RecettesRepository {
  static List<Recette> donneesInitiales() => [
        Recette(
          id: '1',
          titre: 'Salade César',
          categorie: 'Entrée',
          difficulte: 'Facile',
          tempsPreparation: 15,
          description:
              'Une salade fraîche et croquante, parfaite en entrée légère '
              'ou en repas rapide. La sauce maison fait toute la différence.',
          ingredients: [
            'Laitue romaine',
            'Parmesan',
            'Croûtons',
            'Sauce César',
            'Poulet grillé (optionnel)',
          ],
        ),
        Recette(
          id: '2',
          titre: 'Velouté de courge',
          categorie: 'Entrée',
          difficulte: 'Facile',
          tempsPreparation: 30,
          description:
              'Un velouté onctueux et réconfortant, idéal pour les soirées '
              'fraîches. Se prépare facilement à l\'avance.',
          ingredients: ['Courge butternut', 'Oignon', 'Bouillon de légumes', 'Crème'],
        ),
        Recette(
          id: '3',
          titre: 'Pâtes à la carbonara',
          categorie: 'Plat',
          difficulte: 'Moyen',
          tempsPreparation: 25,
          description:
              'La vraie recette italienne, sans crème : juste des œufs, '
              'du parmesan et du guanciale pour un résultat crémeux et riche.',
          ingredients: ['Spaghetti', 'Guanciale', 'Œufs', 'Parmesan', 'Poivre noir'],
        ),
        Recette(
          id: '4',
          titre: 'Poulet rôti aux herbes',
          categorie: 'Plat',
          difficulte: 'Moyen',
          tempsPreparation: 90,
          description:
              'Un classique familial : un poulet doré, parfumé aux herbes '
              'de Provence, avec une peau croustillante à souhait.',
          ingredients: ['Poulet entier', 'Herbes de Provence', 'Ail', 'Beurre', 'Citron'],
        ),
        Recette(
          id: '5',
          titre: 'Risotto aux champignons',
          categorie: 'Plat',
          difficulte: 'Difficile',
          tempsPreparation: 45,
          description:
              'Un risotto crémeux qui demande de la patience et du remuage '
              'constant, mais le résultat en vaut largement l\'effort.',
          ingredients: ['Riz arborio', 'Champignons', 'Bouillon', 'Vin blanc', 'Parmesan'],
        ),
        Recette(
          id: '6',
          titre: 'Tarte au citron meringuée',
          categorie: 'Dessert',
          difficulte: 'Difficile',
          tempsPreparation: 75,
          description:
              'L\'équilibre parfait entre l\'acidité du citron et la douceur '
              'de la meringue, sur une pâte sablée croustillante.',
          ingredients: ['Pâte sablée', 'Citrons', 'Œufs', 'Sucre', 'Beurre'],
        ),
        Recette(
          id: '7',
          titre: 'Fondant au chocolat',
          categorie: 'Dessert',
          difficulte: 'Facile',
          tempsPreparation: 20,
          description:
              'Un cœur coulant garanti si vous respectez bien le temps de '
              'cuisson. Simple, rapide, et toujours un succès.',
          ingredients: ['Chocolat noir', 'Beurre', 'Œufs', 'Sucre', 'Farine'],
        ),
        Recette(
          id: '8',
          titre: 'Mousse au chocolat',
          categorie: 'Dessert',
          difficulte: 'Facile',
          tempsPreparation: 20,
          description:
              'Une mousse légère et aérienne avec seulement deux '
              'ingrédients principaux : chocolat et œufs.',
          ingredients: ['Chocolat noir', 'Œufs', 'Une pincée de sel'],
        ),
      ];

  /// Liste des catégories disponibles, utilisée pour les filtres et le
  /// formulaire d'ajout — à un seul endroit, pour éviter les fautes de
  /// frappe dispersées dans le code.
  static const List<String> categories = ['Entrée', 'Plat', 'Dessert'];

  static const List<String> niveaux = ['Facile', 'Moyen', 'Difficile'];
}
