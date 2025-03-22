part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String id;
  LoadProfile(this.id);
  @override
  List<Object> get props => [id];
}
