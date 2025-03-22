import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/domain/usecase/trending_recipe_usecase.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetTrendingRecipeUsecase getTrendingRecipeUsecase;
  RecipeBloc({required this.getTrendingRecipeUsecase})
    : super(RecipeInitial()) {
    on<GetTrendingRecipesEvent>((event, emit) async {
      final result = await getTrendingRecipeUsecase.execute();
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
