// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/domain/repository/recipe_repository.dart';

class RecipeListUsecase {
  final RecipeRepository recipeRepository;
  RecipeListUsecase({required this.recipeRepository});

  Future<Either<Failure, List<Recipe>>> execute(String query) async {
    return await recipeRepository.searchRecipe(query);
  }
}
