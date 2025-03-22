import 'package:flutter/material.dart';

import 'package:recipe_app/core/dependancy/dependancy_injection.dart' as di;

import 'package:recipe_app/features/recipe/presentation/pages/trending_recipe_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trending Recipes App',
      home: TrendingRecipeScreen(),
    );
  }
}
