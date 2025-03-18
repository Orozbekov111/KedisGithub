// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedis/features2/auth/data/datasources/auth_remote_data_source.dart';
import 'package:kedis/features2/auth/data/repositories/auth_repository_impl.dart';
import 'package:kedis/features2/auth/domain/repositories/auth_repository.dart';
import 'package:kedis/features2/auth/domain/usecases/login_usecase.dart';
import 'package:kedis/features2/auth/domain/usecases/logout_usecase.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void init() {
  // BLoC
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl(),
        logoutUseCase: sl(),
        authRepository: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(firebaseAuth: sl()),
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}