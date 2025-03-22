// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/domain/repository/recipe_repository.dart';

class GetRecipeDetailUsecase {
  final RecipeRepository recipeRepository;
  GetRecipeDetailUsecase({required this.recipeRepository});
  Future<Either<Failure, Recipe>> execute(int id) async {
    return await recipeRepository.getRecipeDetail(id);
  }
}
