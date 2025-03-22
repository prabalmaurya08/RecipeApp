// features/recipe/presentation/widgets/recipe_list_widget.dart

import 'package:flutter/material.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/presentation/widgets/recipe_card.dart';

class RecipeListWidget extends StatelessWidget {
  final List<Recipe> recipes;

  const RecipeListWidget({required this.recipes});

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return Center(
        child: Text('No recipes found.', style: TextStyle(fontSize: 16)),
      );
    }

    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeCardWidget(recipe: recipes[index]);
      },
    );
  }
}
