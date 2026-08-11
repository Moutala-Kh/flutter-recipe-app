import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<AppState>().themeMode;

    return MaterialApp.router(
      title: 'Mes Recettes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.clair,
      darkTheme: AppTheme.sombre,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
