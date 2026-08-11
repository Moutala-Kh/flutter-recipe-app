import 'package:flutter/material.dart';

import '../models/recette.dart';
import 'favori_button.dart';

/// Carte affichant le résumé d'une [Recette].
///
/// Utilisée à la fois dans la liste (mobile), la grille (tablette) et
/// l'écran des favoris — c'est le principal exemple de widget
/// réutilisable du projet. Ne reçoit que des données déjà prêtes
/// (aucune donnée en dur ici).
class RecetteCard extends StatelessWidget {
  final Recette recette;
  final VoidCallback onTap;
  final VoidCallback onToggleFavori;

  const RecetteCard({
    super.key,
    required this.recette,
    required this.onTap,
    required this.onToggleFavori,
  });

  IconData get _iconeCategorie {
    switch (recette.categorie) {
      case 'Entrée':
        return Icons.eco_outlined;
      case 'Dessert':
        return Icons.icecream_outlined;
      case 'Plat':
      default:
        return Icons.restaurant_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final couleur = Theme.of(context).colorScheme.primaryContainer;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: couleur,
                child: Icon(_iconeCategorie,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recette.titre,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      children: [
                        Chip(
                          label: Text(recette.difficulte),
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        Chip(
                          label: Text('${recette.tempsPreparation} min'),
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FavoriButton(
                estFavori: recette.favori,
                onPressed: onToggleFavori,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
