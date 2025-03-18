import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authentication/authentication_bloc/authentication_bloc.dart';
import 'bloc/authentication/sign_in_bloc/sign_in_bloc.dart';
import 'pages/authentication/sign_in_screen.dart';
import 'pages/home.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kedis',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository),
                ),
                // BlocProvider(
                //   create: (context) => UpdateUserInfoBloc(
                //       firebaseUserRepository:
                //           context.read<AuthenticationBloc>().userRepository),
                // ),
                // BlocProvider(
                //     create: (context) => MyUserBloc(
                //         myUserRepository:
                //             context.read<AuthenticationBloc>().userRepository)
                //       ..add(GetMyUser(
                //           myUserId: context
                //               .read<AuthenticationBloc>()
                //               .state
                //               .user!
                //               .uid)))
              ],
              child: Home(),
            );
          } else {
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                userRepository:
                    context.read<AuthenticationBloc>().userRepository,
              ),
              child: const Home(),
            );
          }
        },
      ),
    );
  }
}
