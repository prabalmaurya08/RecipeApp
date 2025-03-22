import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getTrendingRecipe();
  Future<Either<Failure, List<Recipe>>> searchRecipe(String query);
  Future<Either<Failure, Recipe>> getRecipeDetail(int id);
}
