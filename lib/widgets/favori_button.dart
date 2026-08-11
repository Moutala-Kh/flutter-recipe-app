import 'package:flutter/material.dart';

/// Bouton "cœur" réutilisable pour marquer/démarquer une recette comme
/// favorite. Ne connaît rien du modèle [Recette] : il reçoit juste un
/// booléen et un callback, ce qui le rend utilisable ailleurs.
class FavoriButton extends StatelessWidget {
  final bool estFavori;
  final VoidCallback onPressed;

  const FavoriButton({
    super.key,
    required this.estFavori,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        estFavori ? Icons.favorite : Icons.favorite_border,
        color: estFavori ? Colors.redAccent : null,
      ),
      tooltip: estFavori ? 'Retirer des favoris' : 'Ajouter aux favoris',
    );
  }
}
