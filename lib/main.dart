// lib/main.dart
import 'package:auto_route/src/route/page_route_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kedis/core/router/app_router.dart';
import 'package:kedis/core/router/app_router.gr.dart';
import 'package:kedis/features/presentation/app.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_bloc.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_event.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_state.dart';
import 'package:kedis/features2/auth/presentation/pages/auth_screen.dart';
import 'package:kedis/features2/home/presentation/pages/home_screen.dart';
import 'package:kedis/core/services/injection_container.dart';
import 'package:kedis/features2/home/presentation/pages/main_screen.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';
import 'package:kedis/features2/profile/presentation/bloc/bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init(); // Инициализация зависимостей
  // runApp(MainApp());
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = AppRouter(); // Создаем экземпляр AppRouter

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(CheckAuthEvent()),
        ),
        // BlocProvider(
        //   create:
        //       (context) =>
        //           UserBloc(context.read<GetUserUseCase>())
        //             ..add(LoadUserEvent(userId)),
        // ),
      ],
      child: MaterialApp.router(
        routerConfig: router.config(), // Используем routerConfig
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                router.replace(const MainRoute());
              } else {
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