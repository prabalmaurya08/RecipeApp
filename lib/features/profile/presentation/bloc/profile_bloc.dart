import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/profile/domain/entities/profile.dart';
import 'package:recipe_app/features/profile/domain/usecases/profile_usercase.dart';
// Import Failure

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsercase profileUsercase;
  ProfileBloc(this.profileUsercase) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final result = await profileUsercase.execute(event.id);
        result.fold(
          (failure) => emit(
            ProfileErrorState(_mapFailureToString(failure)),
          ), // Emit error state
          (success) => emit(ProfileLoadedState(success)), // Emit loaded state
        );
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error: ${(failure as ServerFailure).message}';
      case NetworkFailure:
        return 'Network Error: ${(failure as NetworkFailure).message}';
      case GeneralFailure:
        return 'General Error: ${(failure as GeneralFailure).message}';
      default:
        return 'Unexpected Error.';
    }
  }
}
