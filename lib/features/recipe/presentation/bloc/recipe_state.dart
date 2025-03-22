// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoadingState extends RecipeState {}

class RecipeLoadedState extends RecipeState {
  final List<Recipe> recipes;

  const RecipeLoadedState(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeDetailLoaded extends RecipeState {
  final Recipe recipe;

  const RecipeDetailLoaded(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class RecipeErrorState extends RecipeState {
  final String message;

  const RecipeErrorState(this.message);

  @override
  List<Object> get props => [message];
}
