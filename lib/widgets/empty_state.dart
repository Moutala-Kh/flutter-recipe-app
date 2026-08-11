import 'package:flutter/material.dart';

/// Message affiché quand une liste est vide (aucun résultat de
/// recherche, aucun favori...). Réutilisable sur plusieurs écrans.
class EmptyState extends StatelessWidget {
  final IconData icone;
  final String message;

  const EmptyState({super.key, required this.icone, required this.message});

  @override
  Widget build(BuildContext context) {
    final couleur = Theme.of(context).colorScheme.outline;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 56, color: couleur),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: couleur),
            ),
          ],
        ),
      ),
    );
  }
}
