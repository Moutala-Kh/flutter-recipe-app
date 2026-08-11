import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/main_scaffold.dart';

/// Écran des paramètres : bascule entre thème clair et sombre, et
/// quelques informations sur l'application.
class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final estSombre = appState.themeMode == ThemeMode.dark;

    return MainScaffold(
      currentIndex: 2,
      title: 'Paramètres',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              secondary: Icon(estSombre ? Icons.dark_mode : Icons.light_mode),
              title: const Text('Thème sombre'),
              subtitle: const Text('Basculer entre thème clair et sombre'),
              value: estSombre,
              onChanged: (_) => context.read<AppState>().toggleTheme(),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Mes Recettes'),
              subtitle: const Text(
                'Application de gestion de recettes — projet de '
                'certification Flutter (navigation multi-écrans).',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
