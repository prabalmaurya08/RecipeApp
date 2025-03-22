import 'package:dio/dio.dart';
import 'package:recipe_app/core/error/exception.dart';

import 'package:recipe_app/core/utils/app_secret.dart';
import 'package:recipe_app/features/recipe/data/model/recipe_model.dart';

abstract class RecipeRemoteDatasource {
  Future<List<RecipeModel>> getTrendingRecipe();
  Future<List<RecipeModel>> searchRecipe(String query);
  Future<RecipeModel> getRecipeDetail(int id);
}

class RecipeRemoteDatasourceImpl extends RecipeRemoteDatasource {
  final Dio dio;
  RecipeRemoteDatasourceImpl(this.dio);
  @override
  Future<RecipeModel> getRecipeDetail(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<RecipeModel>> getTrendingRecipe() async {
    try {
      final response = await dio.get(
        '${AppSecret.baseUrl}/recipes/complexSearch',
        queryParameters: {
          'apiKey': AppSecret.apiKey,
          'sort': 'popularity',
          'number': 10,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> result = response.data['results'];
        return result.map((json) => RecipeModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          'Failed to get trending recipes: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException('Server error: ${e.response?.statusCode}');
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      throw GeneralException('General error: ${e.toString()}');
    }
  }

  @override
  Future<List<RecipeModel>> searchRecipe(String query) async {
    try {
      final response = await dio.get(
        '${AppSecret.baseUrl}/recipes/complexSearch',
        queryParameters: {
          'query': query,
          'apiKey': AppSecret.apiKey,
          'number': 10,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => RecipeModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          'Failed to search recipes: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException('Server error: ${e.response?.statusCode}');
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      throw GeneralException('General error: ${e.toString()}');
    }
  }
}
