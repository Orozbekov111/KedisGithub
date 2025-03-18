import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication/sign_in_bloc/sign_in_bloc.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signInRequired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            setState(() {
              signInRequired = false;
              _errorMsg = null; // Сброс сообщения об ошибке при успешном входе
            });
          } else if (state is SignInProcess) {
            setState(() {
              signInRequired = true;
            });
          } else if (state is SignInFailure) {
            setState(() {
              signInRequired = false;
              _errorMsg = 'Неправильно введенные данные';
            });
          }
        },
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildWelcomeText(),
                  const SizedBox(height: 20),
                  _buildEmailField(),
                  const SizedBox(height: 10),
                  _buildPasswordField(),
                  const SizedBox(height: 20),
                  _buildSignInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'Добро пожаловать!',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEmailField() {
    return MyTextField(
      controller: emailController,
      hintText: 'логин',
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(CupertinoIcons.mail_solid),
      errorMsg: _errorMsg,
      validator: (val) => val!.isEmpty ? 'Пожалуйста, заполните это поле' : null,
    );
  }

  Widget _buildPasswordField() {
    return MyTextField(
      controller: passwordController,
      hintText: 'пароль',
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const Icon(CupertinoIcons.lock_fill),
      errorMsg: _errorMsg,
      validator: (val) => val!.isEmpty ? 'Пожалуйста, заполните это поле' : null,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscurePassword = !obscurePassword;
            iconPassword = obscurePassword ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill;
          });
        },
        icon: Icon(iconPassword),
      ),
    );
  }

  Widget _buildSignInButton() {
    return signInRequired
        ? const CircularProgressIndicator()
        : ButtonWidget(
            text: 'Войти',
            pressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<SignInBloc>().add(SignInRequired(emailController.text, passwordController.text));
              }
            },
          );
  }
}