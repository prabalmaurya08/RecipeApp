import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:recipe_app/core/error/exception.dart';
import 'package:recipe_app/features/profile/data/model/profile_model.dart';

class ProfileRemotesource {
  // final http.Client httpClient;
  final Dio dio;

  ProfileRemotesource(this.dio);
  Future<Either<Failure, ProfileModel>> getProfile(String id) async {
    try {
      final response = await dio.get(
        ('https://jsonplaceholder.typicode.com/users/$id'),
      );

      if (response.statusCode == 200) {
        return Right(ProfileModel.fromJson(response.data));
      } else {
        throw Left('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
