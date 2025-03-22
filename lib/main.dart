import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:recipe_app/core/dependancy/dependancy_injection.dart' as di;
import 'package:recipe_app/features/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_app/features/recipe/presentation/pages/recipe_home_screen.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => di.sl<RecipeBloc>(),
        child: HomePage(),
      ),
    );
  }
}
