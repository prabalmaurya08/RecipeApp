// core/dependency_injection/injection_container.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/core/utils/app_secret.dart';
import 'package:recipe_app/features/recipe/data/remotesource/recipe_remote_datasource.dart';
import 'package:recipe_app/features/recipe/data/repositoryImpl/recipe_repository_impl.dart';
import 'package:recipe_app/features/recipe/domain/repository/recipe_repository.dart';
import 'package:recipe_app/features/recipe/domain/usecase/get_recipe_detail_usecase.dart';
import 'package:recipe_app/features/recipe/domain/usecase/recipe_list_usecase.dart';
import 'package:recipe_app/features/recipe/domain/usecase/trending_recipe_usecase.dart';
import 'package:recipe_app/features/recipe/presentation/bloc/recipe_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    // Bloc
    sl.registerFactory(
      () => RecipeBloc(
        getTrendingRecipeUsecase: sl(),
        getRecipeDetailUsecase: sl(),
        recipeListUsecase: sl(),
      ),
    );

    // Use Cases
    sl.registerLazySingleton(
      () => GetTrendingRecipeUsecase(recipeRepository: sl()),
    );

    sl.registerLazySingleton(
      () => GetRecipeDetailUsecase(recipeRepository: sl()),
    );

    sl.registerLazySingleton(() => RecipeListUsecase(recipeRepository: sl()));

    // Repository
    sl.registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(sl()),
    );

    // Remote Data Source
    sl.registerLazySingleton<RecipeRemoteDatasource>(
      () => RecipeRemoteDatasourceImpl(sl()),
    );

    // External Dependencies
    sl.registerLazySingleton(
      () => Dio(
        BaseOptions(
          baseUrl: AppSecret.baseUrl, // Add your base URL
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      ),
    );
  } catch (e) {
    print('Error initializing dependencies: $e');
    // Handle the error appropriately (e.g., show an error message)
  }
}
