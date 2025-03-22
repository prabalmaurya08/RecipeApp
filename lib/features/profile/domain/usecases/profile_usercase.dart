import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/profile/domain/entities/profile.dart';
import 'package:recipe_app/features/profile/domain/repository/profile_repository.dart';

class ProfileUsercase {
  final ProfileRepository profileRepository;
  ProfileUsercase(this.profileRepository);

  Future<Either<Failure, Profile>> execute(String id) async {
    return await profileRepository.getProfile(id);
  }
}
