// home_page.dart
import 'package:flutter/material.dart';
import 'package:recipe_finder/presentation/widgets/search_bar.dart';
import 'package:recipe_finder/presentation/widgets/trending_recipes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 20),
            const TrendingRecipes(),
          ],
        ),
      ),
    );
  }
}
