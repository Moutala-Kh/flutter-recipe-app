import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Structure commune (AppBar + BottomNavigationBar) partagée par les
/// trois écrans principaux (Recettes, Favoris, Paramètres).
///
/// Centraliser cette structure évite de dupliquer la barre de
/// navigation dans chaque écran et garde la navigation cohérente.
class MainScaffold extends StatelessWidget {
  final int currentIndex;
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  const MainScaffold({
    super.key,
    required this.currentIndex,
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/favoris');
        break;
      case 2:
        context.go('/parametres');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onTap(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Recettes',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
