part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final Profile profile;
  ProfileLoadedState(this.profile);
  @override
  List<Object> get props => [profile];
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message);
  @override
  List<Object> get props => [message];
}
