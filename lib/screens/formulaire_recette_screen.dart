import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/recettes_repository.dart';
import '../models/recette.dart';
import '../providers/app_state.dart';

/// Formulaire d'ajout d'une nouvelle recette.
///
/// Valide 5 champs (titre, temps de préparation, catégorie, difficulté,
/// description) — largement au-dessus des 3 exigés — avant d'envoyer
/// la nouvelle [Recette] à [AppState].
class FormulaireRecetteScreen extends StatefulWidget {
  const FormulaireRecetteScreen({super.key});

  @override
  State<FormulaireRecetteScreen> createState() =>
      _FormulaireRecetteScreenState();
}

class _FormulaireRecetteScreenState extends State<FormulaireRecetteScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titreController = TextEditingController();
  final _tempsController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();

  String _categorie = RecettesRepository.categories.first;
  String _difficulte = RecettesRepository.niveaux.first;

  @override
  void dispose() {
    _titreController.dispose();
    _tempsController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  String? _validerTitre(String? valeur) {
    if (valeur == null || valeur.trim().isEmpty) {
      return 'Le titre est obligatoire.';
    }
    if (valeur.trim().length < 3) {
      return 'Le titre doit contenir au moins 3 caractères.';
    }
    return null;
  }

  String? _validerTemps(String? valeur) {
    if (valeur == null || valeur.trim().isEmpty) {
      return 'Le temps de préparation est obligatoire.';
    }
    final nombre = int.tryParse(valeur.trim());
    if (nombre == null || nombre <= 0) {
      return 'Entrez un nombre de minutes valide (> 0).';
    }
    return null;
  }

  String? _validerDescription(String? valeur) {
    if (valeur == null || valeur.trim().isEmpty) {
      return 'La description est obligatoire.';
    }
    if (valeur.trim().length < 10) {
      return 'Ajoutez une description un peu plus détaillée (10 caractères min).';
    }
    return null;
  }

  String? _validerIngredients(String? valeur) {
    if (valeur == null || valeur.trim().isEmpty) {
      return 'Indiquez au moins un ingrédient.';
    }
    return null;
  }

  void _soumettre() {
    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientsController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final nouvelleRecette = Recette(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      titre: _titreController.text.trim(),
      categorie: _categorie,
      difficulte: _difficulte,
      tempsPreparation: int.parse(_tempsController.text.trim()),
      description: _descriptionController.text.trim(),
      ingredients: ingredients,
    );

    context.read<AppState>().ajouterRecette(nouvelleRecette);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${nouvelleRecette.titre}" a été ajoutée.')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle recette')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titreController,
              decoration: const InputDecoration(labelText: 'Titre'),
              validator: _validerTitre,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _categorie,
                    decoration: const InputDecoration(labelText: 'Catégorie'),
                    items: [
                      for (final categorie in RecettesRepository.categories)
                        DropdownMenuItem(
                            value: categorie, child: Text(categorie)),
                    ],
                    onChanged: (valeur) =>
                        setState(() => _categorie = valeur!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _difficulte,
                    decoration: const InputDecoration(labelText: 'Difficulté'),
                    items: [
                      for (final niveau in RecettesRepository.niveaux)
                        DropdownMenuItem(value: niveau, child: Text(niveau)),
                    ],
                    onChanged: (valeur) =>
                        setState(() => _difficulte = valeur!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tempsController,
              decoration: const InputDecoration(
                labelText: 'Temps de préparation (minutes)',
              ),
              keyboardType: TextInputType.number,
              validator: _validerTemps,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: _validerDescription,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Ingrédients (séparés par des virgules)',
                hintText: 'Ex : Farine, Œufs, Sucre',
              ),
              maxLines: 2,
              validator: _validerIngredients,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _soumettre,
              icon: const Icon(Icons.check),
              label: const Text('Enregistrer la recette'),
            ),
          ],
        ),
      ),
    );
  }
}
