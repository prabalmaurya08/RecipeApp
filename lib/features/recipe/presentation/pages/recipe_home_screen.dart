// features/recipe/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:recipe_app/features/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_app/features/recipe/presentation/widgets/recipe_list.dart';

import 'package:recipe_app/features/recipe/presentation/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RecipeBloc>(context).add(GetTrendingRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe App')),
      body: Column(
        children: [
          SearchBarWidget(),
          Text(
            "Trending Recipes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                if (state is RecipeLoadingState || state is RecipeInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RecipeLoadedState) {
                  return RecipeListWidget(recipes: state.recipes);
                } else if (state is RecipeErrorState) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('Initial state'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
