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
              return _buildRecipeList(state.recipes);
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

  Widget _buildRecipeList(List<Recipe> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        print(recipe.imageUrl);
        return ListTile(
          leading: Image.network(recipe.imageUrl),

          title: Text(recipe.title),
          // Add other recipe details as needed
        );
      },
    );
  }
}
