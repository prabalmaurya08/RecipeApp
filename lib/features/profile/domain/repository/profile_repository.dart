import 'package:recipe_app/features/profile/domain/entities/profile.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exception.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile(String id);
}
