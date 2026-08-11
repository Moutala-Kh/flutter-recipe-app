import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/recettes_repository.dart';
import '../providers/app_state.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/empty_state.dart';
import '../widgets/main_scaffold.dart';
import '../widgets/recette_card.dart';

/// Écran d'accueil : liste de toutes les recettes, avec recherche par
/// titre et filtre par catégorie. Affiche une [ListView] sur mobile et
/// une [GridView] sur tablette (largeur > 600), ce qui satisfait
/// l'exigence de responsivité.
class ListeRecettesScreen extends StatelessWidget {
  const ListeRecettesScreen({super.key});

  static const double _seuilTablette = 600;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final recettes = appState.recettesFiltrees;

    return MainScaffold(
      currentIndex: 0,
      title: 'Mes recettes',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/ajouter'),
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Rechercher une recette...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (valeur) => context.read<AppState>().setRecherche(valeur),
            ),
          ),
          CategoryFilterBar(
            categories: RecettesRepository.categories,
            selection: appState.filtreCategorie,
            onSelectionChanged: (categorie) =>
                context.read<AppState>().setFiltreCategorie(categorie),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: recettes.isEmpty
                ? const EmptyState(
                    icone: Icons.search_off,
                    message: 'Aucune recette ne correspond à votre recherche.',
                  )
                : LayoutBuilder(
                    builder: (context, contraintes) {
                      final estTablette = contraintes.maxWidth >= _seuilTablette;
                      if (estTablette) {
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 110,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: recettes.length,
                          itemBuilder: (context, index) => RecetteCard(
                            recette: recettes[index],
                            onTap: () =>
                                context.push('/recette/${recettes[index].id}'),
                            onToggleFavori: () => context
                                .read<AppState>()
                                .toggleFavori(recettes[index].id),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: recettes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) => RecetteCard(
                          recette: recettes[index],
                          onTap: () =>
                              context.push('/recette/${recettes[index].id}'),
                          onToggleFavori: () => context
                              .read<AppState>()
                              .toggleFavori(recettes[index].id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
