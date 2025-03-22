import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:recipe_app/features/profile/data/remotesource/profile_remotesource.dart';
import 'package:recipe_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:recipe_app/features/profile/domain/repository/profile_repository.dart';
import 'package:recipe_app/features/profile/domain/usecases/profile_usercase.dart';
import 'package:recipe_app/features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependancy() async {
  //register bloc
  sl.registerFactory(() => ProfileBloc(sl()));

  //register usecase

  sl.registerLazySingleton(() => ProfileUsercase(sl()));

  //register repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  //resgiter remote data soruce
  sl.registerLazySingleton(() => ProfileRemotesource(sl()));

  //register external dependancy

  sl.registerLazySingleton(() => Dio());
}
