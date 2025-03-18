import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../data/repositories/firebase_user_repository.dart';
import 'app_view.dart';
import 'bloc/authentication/authentication_bloc/authentication_bloc.dart';

class MainApp extends StatelessWidget {
  final FirebaseUserRepository userRepository = FirebaseUserRepository();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providing UserRepository
        Provider<FirebaseUserRepository>(
          create: (_) => userRepository,
        ),
        // Providing AuthenticationBloc
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(userRepository: userRepository),
        ),
      ],
      child: MyAppView(),
    );
  }
}