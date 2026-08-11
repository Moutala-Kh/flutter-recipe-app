import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/main_scaffold.dart';
import '../widgets/recette_card.dart';

/// Écran listant uniquement les recettes marquées comme favorites.
class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoris = context.watch<AppState>().favoris;

    return MainScaffold(
      currentIndex: 1,
      title: 'Mes favoris',
      body: favoris.isEmpty
          ? const EmptyState(
              icone: Icons.favorite_border,
              message:
                  'Vous n\'avez pas encore de favoris.\nTouchez le cœur sur '
                  'une recette pour l\'ajouter ici.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favoris.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) => RecetteCard(
                recette: favoris[index],
                onTap: () => context.push('/recette/${favoris[index].id}'),
                onToggleFavori: () =>
                    context.read<AppState>().toggleFavori(favoris[index].id),
              ),
            ),
    );
  }
}
