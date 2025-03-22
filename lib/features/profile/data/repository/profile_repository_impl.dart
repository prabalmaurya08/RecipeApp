import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/profile/data/model/profile_model.dart';
import 'package:recipe_app/features/profile/data/remotesource/profile_remotesource.dart';

import 'package:recipe_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemotesource profileRemotesource;
  ProfileRepositoryImpl(this.profileRemotesource);
  @override
  Future<Either<Failure, ProfileModel>> getProfile(String id) async {
    final result = await profileRemotesource.getProfile(id);
    return result.fold((failure) => Left(failure), (sucess) => Right(sucess));
  }
}
