import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/profile/dependancy.dart' as di;
import 'package:recipe_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app/features/profile/presentation/pages/profile_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependancy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Wrap MaterialApp with BlocProvider AND RETURN IT
      create: (context) => di.sl<ProfileBloc>()..add(LoadProfile('1')),
      child: MaterialApp(title: 'Profile App', home: ProfileHome(userId: '1')),
    );
  }
}
