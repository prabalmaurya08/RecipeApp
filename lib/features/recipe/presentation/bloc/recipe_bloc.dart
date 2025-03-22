// features/recipe/presentation/bloc/recipe_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/domain/usecase/get_recipe_detail_usecase.dart';
import 'package:recipe_app/features/recipe/domain/usecase/recipe_list_usecase.dart';
import 'package:recipe_app/features/recipe/domain/usecase/trending_recipe_usecase.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetTrendingRecipeUsecase getTrendingRecipeUsecase;
  final RecipeListUsecase recipeListUsecase;
  final GetRecipeDetailUsecase getRecipeDetailUsecase;
  RecipeBloc({
    required this.getTrendingRecipeUsecase,
    required this.getRecipeDetailUsecase,
    required this.recipeListUsecase,
  }) : super(RecipeInitial()) {
    //use initial state name
    on<GetTrendingRecipesEvent>((event, emit) async {
      emit(RecipeLoadingState()); // Loading state
      final result = await getTrendingRecipeUsecase.execute();
      result.fold(
        (failure) => emit(RecipeErrorState(_mapFailureToString(failure))),
        (recipes) => emit(RecipeLoadedState(recipes)),
      );
    });

    on<GetRecipeDetailEvent>((event, emit) async {
      emit(RecipeLoadingState()); // Loading state
      final result = await getRecipeDetailUsecase.execute(event.id);
      result.fold(
        (failure) => emit(RecipeErrorState(_mapFailureToString(failure))),

        (recipes) {
          print('Recipe Details: $recipes');
          emit(RecipeDetailLoaded(recipes));
        },
      );
    });

    on<GetRecipeListEvent>((event, emit) async {
      emit(RecipeLoadingState()); // Loading state
      final result = await recipeListUsecase.execute(event.query);
      result.fold(
        (failure) => emit(RecipeErrorState(_mapFailureToString(failure))),
        (recipes) => emit(RecipeLoadedState(recipes)),
      );
    });
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error: ${failure.message}';
      case NetworkFailure:
        return 'Network Error: ${failure.message}';
      case GeneralFailure:
        return 'General Error: ${failure.message}';
      default:
        return 'Unexpected Error.';
    }
  }
}
