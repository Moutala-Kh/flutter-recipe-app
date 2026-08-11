import 'package:flutter/material.dart';

/// Barre horizontale de filtres par catégorie (FilterChip).
///
/// Réutilisable : reçoit la liste des catégories, la sélection
/// actuelle et un callback — ne connaît rien de [Recette] ni de
/// [AppState].
class CategoryFilterBar extends StatelessWidget {
  final List<String> categories;
  final String? selection;
  final ValueChanged<String?> onSelectionChanged;

  const CategoryFilterBar({
    super.key,
    required this.categories,
    required this.selection,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('Toutes'),
              selected: selection == null,
              onSelected: (_) => onSelectionChanged(null),
            ),
          ),
          for (final categorie in categories)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(categorie),
                selected: selection == categorie,
                onSelected: (_) => onSelectionChanged(categorie),
              ),
            ),
        ],
      ),
    );
  }
}
