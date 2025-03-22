part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class GetTrendingRecipesEvent extends RecipeEvent {}

class GetRecipeListEvent extends RecipeEvent {
  final String query;
  const GetRecipeListEvent(this.query);
  @override
  List<Object> get props => [query];
}

class GetRecipeDetailEvent extends RecipeEvent {
  final int id;

  const GetRecipeDetailEvent(this.id);
  @override
  List<Object> get props => [id];
}
