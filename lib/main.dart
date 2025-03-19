// lib/main.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kedis/core/router/app_router.dart';
import 'package:kedis/core/router/app_router.gr.dart';
import 'package:kedis/features2/auth/data/datasources/auth_remote_data_source.dart';
import 'package:kedis/features2/auth/data/repositories/auth_repository_impl.dart';
import 'package:kedis/features2/auth/domain/repositories/auth_repository.dart';
import 'package:kedis/features2/auth/domain/usecases/login_usecase.dart';
import 'package:kedis/features2/auth/domain/usecases/logout_usecase.dart';
// import 'package:kedis/features2/auth/domain/usecases/logout_usecase.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_bloc.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_event.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_state.dart';
import 'package:kedis/features2/profile/domain/repositoies_impl/user_repo_impl.dart';
import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';
import 'package:provider/provider.dart';

import 'features2/profile/data/datasources/firebase_user_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  // runApp(MainApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = AppRouter(); // Создаем экземпляр AppRouter

    return MultiProvider(
      providers: [
        // Регистрируем зависимости для аутентификации
        Provider<AuthRemoteDataSource>(
          create:
              (_) => AuthRemoteDataSource(firebaseAuth: FirebaseAuth.instance),
        ),
        Provider<AuthRepository>(
          create:
              (context) => AuthRepositoryImpl(
                remoteDataSource: context.read<AuthRemoteDataSource>(),
              ),
        ),
        Provider<LoginUseCase>(
          create:
              (context) =>
                  LoginUseCase(repository: context.read<AuthRepository>()),
        ),
        Provider<LogoutUseCase>(
          create:
              (context) =>
                  LogoutUseCase(repository: context.read<AuthRepository>()),
        ),
        BlocProvider<AuthBloc>(
          create:
              (context) => AuthBloc(
                loginUseCase: context.read<LoginUseCase>(),
                logoutUseCase: context.read<LogoutUseCase>(),
                authRepository: context.read<AuthRepository>(),
              )..add(CheckAuthEvent()),
        ),

        // Регистрируем зависимости для профиля пользователя
        Provider<FirebaseUserDataSource>(
          create: (_) => FirebaseUserDataSource(),
        ),
        
        Provider<UserRepository>(
          create:
              (context) => UserRepositoryImpl(
                dataSource: context.read<FirebaseUserDataSource>(),
              ), // Передаем dataSource
        ),
        Provider<GetUserUseCase>(
          create: (context) => GetUserUseCase(context.read<UserRepository>()),
        ),
        
      ],
      child: MaterialApp.router(
        routerConfig: router.config(), // Используем routerConfig
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                // Переход на главный экран после успешной аутентификации
                router.replace(const MainRoute());
              } else {
                // Переход на экран входа, если пользователь не аутентифицирован
                router.replace(const LoginRoute());
              }
            },
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// BlocProvider(
        //   create:
        //       (context) =>
        //           UserBloc(context.read<GetUserUseCase>())
        //             ..add(LoadUserEvent(userId)),
        // ),


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final router = AppRouter();
//     return BlocProvider(
//       create: (context) => sl<AuthBloc>()..add(CheckAuthEvent()),
//       child: MaterialApp.router(
//         routerConfig: router.config(),
//         home: BlocBuilder<AuthBloc, AuthState>(
//           builder: (context, state) {
//             if (state is AuthAuthenticated) {
//               return HomeScreen(user: state.user);
//             } else {
//               return LoginScreen();
//             }
//           },
//         ),
//       ),
//       ),
//     );
//   }
// }