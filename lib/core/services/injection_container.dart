// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedis/features2/auth/data/datasources/auth_remote_data_source.dart';
import 'package:kedis/features2/auth/data/repositories/auth_repository_impl.dart';
import 'package:kedis/features2/auth/domain/repositories/auth_repository.dart';
import 'package:kedis/features2/auth/domain/usecases/login_usecase.dart';
import 'package:kedis/features2/auth/domain/usecases/logout_usecase.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_bloc.dart';
import 'package:kedis/features2/profile/data/datasources/firebase_user_data_source.dart';
import 'package:kedis/features2/profile/domain/repositoies_impl/user_repo_impl.dart';
import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';
import 'package:kedis/features2/profile/presentation/bloc/bloc/user_bloc.dart';

final getIt = GetIt.instance;

void init() {
  // BLoC
  getIt.registerFactory(() => AuthBloc(
        loginUseCase: getIt(),
        logoutUseCase: getIt(),
        authRepository: getIt(),
      ));

  // UseCases
  getIt.registerLazySingleton(() => LoginUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(repository: getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(firebaseAuth: getIt()),
  );

  // External
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
}


void setupDependencies() {
  // Data Sources
  getIt.registerSingleton<FirebaseUserDataSource>(FirebaseUserDataSource());

  // Repositories
  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(getIt<FirebaseUserDataSource>()),
  );

  // Use Cases
  getIt.registerSingleton<GetUserUseCase>(
    GetUserUseCase(getIt<UserRepository>()),
  );

  // Bloc
  getIt.registerFactory<UserBloc>(
    () => UserBloc(getIt<GetUserUseCase>()),
  );
}