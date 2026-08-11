import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/favori_button.dart';

/// Écran détail d'une recette.
///
/// [id] est passé par GoRouter via le paramètre de route `/recette/:id`
/// (voir router/app_router.dart) — c'est l'illustration du passage de
/// paramètres entre écrans demandé par l'énoncé.
class DetailRecetteScreen extends StatelessWidget {
  final String id;

  const DetailRecetteScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final recette = appState.getById(id);

    if (recette == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recette introuvable')),
        body: const Center(child: Text('Cette recette n\'existe plus.')),
      );
    }

    final largeurMax = MediaQuery.of(context).size.width >= 600 ? 700.0 : double.infinity;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            actions: [
              FavoriButton(
                estFavori: recette.favori,
                onPressed: () =>
                    context.read<AppState>().toggleFavori(recette.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recette.titre),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primaryContainer,
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.restaurant,
                      size: 72,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: largeurMax),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: Text(recette.categorie)),
                          Chip(label: Text(recette.difficulte)),
                          Chip(
                            avatar: const Icon(Icons.timer_outlined, size: 18),
                            label: Text('${recette.tempsPreparation} min'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Description',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(recette.description),
                      const SizedBox(height: 24),
                      Text('Ingrédients',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            children: [
                              for (final ingredient in recette.ingredients)
                                ListTile(
                                  leading: const Icon(Icons.check_circle_outline),
                                  title: Text(ingredient),
                                  dense: true,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
