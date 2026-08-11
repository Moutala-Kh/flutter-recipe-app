import 'package:go_router/go_router.dart';

import '../screens/detail_recette_screen.dart';
import '../screens/favoris_screen.dart';
import '../screens/formulaire_recette_screen.dart';
import '../screens/liste_recettes_screen.dart';
import '../screens/parametres_screen.dart';

/// Déclare toutes les routes nommées de l'application.
///
/// `/recette/:id` illustre le passage de paramètre entre écrans : GoRouter
/// extrait `id` de l'URL et le transmet à [DetailRecetteScreen].
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'accueil',
      builder: (context, state) => const ListeRecettesScreen(),
    ),
    GoRoute(
      path: '/recette/:id',
      name: 'detail',
      builder: (context, state) => DetailRecetteScreen(
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/ajouter',
      name: 'ajouter',
      builder: (context, state) => const FormulaireRecetteScreen(),
    ),
    GoRoute(
      path: '/favoris',
      name: 'favoris',
      builder: (context, state) => const FavorisScreen(),
    ),
    GoRoute(
      path: '/parametres',
      name: 'parametres',
      builder: (context, state) => const ParametresScreen(),
    ),
  ],
);
