// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/domain/repository/recipe_repository.dart';

class GetTrendingRecipeUsecase {
  final RecipeRepository recipeRepository;
  GetTrendingRecipeUsecase({required this.recipeRepository});

  Future<Either<Failure, List<Recipe>>> execute() async {
    return await recipeRepository.getTrendingRecipe();
  }
}
