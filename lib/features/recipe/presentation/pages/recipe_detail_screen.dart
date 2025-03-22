// features/recipe/presentation/pages/recipe_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/dependancy/dependancy_injection.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/presentation/bloc/recipe_bloc.dart';

class RecipeDetailScreen extends StatefulWidget {
  final int recipeId;

  const RecipeDetailScreen({required this.recipeId});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create:
            (context) =>
                sl<RecipeBloc>()..add(GetRecipeDetailEvent(widget.recipeId)),
        child: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecipeDetailLoaded) {
              return _buildRecipeDetails(context, state.recipe);
            } else if (state is RecipeErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Initial state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildRecipeDetails(BuildContext context, Recipe recipe) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 350.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'recipe-${recipe.id}',
                child:
                    recipe.image != null
                        ? Image.network(
                          recipe.image!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                        : Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title ?? 'No Title',
                      style: theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            '${recipe.readyInMinutes ?? 'N/A'} mins',
                            style: theme.textTheme.bodyMedium,
                          ),
                          backgroundColor: Colors.orange[100],
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(
                            '${recipe.servings ?? 'N/A'} servings',
                            style: theme.textTheme.bodyMedium,
                          ),
                          backgroundColor: Colors.green[100],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (recipe.extendedIngredients != null &&
                        recipe.extendedIngredients!.isNotEmpty)
                      ExpansionTile(
                        title: Text(
                          'Ingredients',
                          style: theme.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children:
                            recipe.extendedIngredients!.map((ingredient) {
                              return ListTile(
                                title: Text(
                                  '- ${ingredient.original}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                leading: const Icon(
                                  Icons.check_box_outline_blank,
                                ),
                              );
                            }).toList(),
                      ),
                    const SizedBox(height: 16),
                    if (recipe.analyzedInstructions != null &&
                        recipe.analyzedInstructions!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Instructions',
                            style: theme.textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...recipe.analyzedInstructions!.map((instruction) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  instruction.steps.map((step) {
                                    return ListTile(
                                      leading: Text(
                                        '${step.number}.',
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      title: Text(
                                        step.step,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    );
                                  }).toList(),
                            );
                          }).toList(),
                        ],
                      ),
                    const SizedBox(height: 16),
                    if (recipe.sourceName != null)
                      Text(
                        'Source: ${recipe.sourceName ?? 'N/A'}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    if (recipe.sourceUrl != null)
                      Text(
                        'Source URL: ${recipe.sourceUrl ?? 'N/A'}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    if (recipe.aggregateLikes != null)
                      Text(
                        'Likes: ${recipe.aggregateLikes}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    if (recipe.vegetarian != null)
                      Text(
                        'Vegetarian: ${recipe.vegetarian! ? "Yes" : "No"}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    if (recipe.vegan != null)
                      Text(
                        'Vegan: ${recipe.vegan! ? "Yes" : "No"}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    if (recipe.dairyFree != null)
                      Text(
                        'Dairy Free: ${recipe.dairyFree! ? "Yes" : "No"}',
                        style: theme.textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
