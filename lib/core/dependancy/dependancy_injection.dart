import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/features/recipe/data/remotesource/recipe_remote_datasource.dart';
import 'package:recipe_app/features/recipe/data/repositoryImpl/recipe_repository_impl.dart';
import 'package:recipe_app/features/recipe/domain/repository/recipe_repository.dart';
import 'package:recipe_app/features/recipe/domain/usecase/trending_recipe_usecase.dart';
import 'package:recipe_app/features/recipe/presentation/bloc/recipe_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc

  sl.registerFactory(() => RecipeBloc(getTrendingRecipeUsecase: sl()));

  //use case

  sl.registerLazySingleton(
    () => GetTrendingRecipeUsecase(recipeRepository: sl()),
  );

  //repo

  sl.registerLazySingleton<RecipeRepository>(() => RecipeRepositoryImpl(sl()));

  //source
  sl.registerLazySingleton<RecipeRemoteDatasource>(
    () => RecipeRemoteDatasourceImpl(sl()),
  );

  // External dependencies
  sl.registerLazySingleton(() => Dio());
}
