// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:recipe_app/core/error/exception.dart';

import 'package:recipe_app/features/recipe/data/remotesource/recipe_remote_datasource.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDatasource recipeRemoteDatasource;
  RecipeRepositoryImpl(this.recipeRemoteDatasource);
  @override
  Future<Either<Failure, Recipe>> getRecipeDetail(int id) async {
    try {
      final model = await recipeRemoteDatasource.getRecipeDetail(id);
      print('API Response: $model');
      final response = Recipe(
        id: model.id,
        title: model.title,
        image: model.image,
        servings: model.servings,
        readyInMinutes: model.readyInMinutes,
        extendedIngredients: model.extendedIngredients,

        analyzedInstructions: model.analyzedInstructions,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getTrendingRecipe() async {
    try {
      final models = await recipeRemoteDatasource.getTrendingRecipe();
      final recipes =
          models
              .map(
                (model) => Recipe(
                  id: model.id,
                  title: model.title,
                  image: model.image,
                  // Map other properties from RecipeModel to Recipe
                ),
              )
              .toList();
      return Right(recipes);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> searchRecipe(String query) async {
    try {
      final models = await recipeRemoteDatasource.searchRecipe(query);
      final recipe =
          models
              .map(
                (model) => Recipe(
                  id: model.id,
                  title: model.title,
                  image: model.image,
                ),
              )
              .toList();
      return Right(recipe);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(e.message));
    }
  }
}
