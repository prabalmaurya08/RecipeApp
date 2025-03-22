import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/profile/dependancy.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/presentation/bloc/recipe_bloc.dart';

class TrendingRecipeScreen extends StatelessWidget {
  const TrendingRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trending Recipes')),
      body: BlocProvider(
        create: (context) => sl<RecipeBloc>()..add(GetTrendingRecipesEvent()),
        child: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RecipeLoadedState) {
              return _buildRecipeCardList(state.recipes);
            } else if (state is RecipeErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Initial state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildRecipeCardList(List<Recipe> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return _buildRecipeCard(recipes[index]);
      },
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigate to recipe detail page
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  recipe.image != null
                      ? Image.network(
                        recipe.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.error),
                        loadingBuilder: (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                            ),
                          );
                        },
                      )
                      : Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    height: 150,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.title ?? 'No Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Add other recipe details here
          ],
        ),
      ),
    );
  }
}
