// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';
import 'package:kedis/core/widgets/my_textfield_widget.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_bloc.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_event.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_state.dart';
import 'package:kedis/features2/home/presentation/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool signInRequired = false;
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Переход на экран профиля после успешной аутентификации
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(user: state.user),
              ),
            );
          } else if (state is AuthLoading) {
            setState(() {
              signInRequired = true; // Включение режима загрузки
            });
          } else if (state is AuthError) {
            setState(() {
              signInRequired = false; // Отключение режима загрузки
              _errorMsg = state.message; // Установка сообщения об ошибке
            });
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Добро пожаловать!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                MyTextFieldWidget(
                  controller: _emailController,
                  hintText: 'логин',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid),
                  errorMsg: _errorMsg,
                ),
                const SizedBox(height: 10),
                MyTextFieldWidget(
                  controller: _passwordController,
                  hintText: 'пароль',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  errorMsg: _errorMsg,

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                        iconPassword =
                            obscurePassword
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill;
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                ),

                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    // Если состояние загрузки, показываем индикатор
                    if (state is AuthLoading) {
                      return CircularProgressIndicator(); // Индикатор загрузки
                    }

                    // Иначе показываем кнопку "Войти"

                    return MyButtonWidget(
                      text: 'Войти',
                      pressed: () {
                        context.read<AuthBloc>().add(
                          LoginEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
