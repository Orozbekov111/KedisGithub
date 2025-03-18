// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kedis/features/presentation/app.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_bloc.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_event.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_state.dart';
import 'package:kedis/features2/auth/presentation/pages/auth_screen.dart';
import 'package:kedis/features2/home/presentation/pages/home_screen.dart';
import 'package:kedis/core/services/injection_container.dart';

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
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(CheckAuthEvent()),
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return HomeScreen(user: state.user);
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}