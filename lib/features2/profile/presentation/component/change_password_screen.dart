import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_show_dialog_widget.dart';
import 'package:kedis/core/widgets/my_textfield_widget.dart';
import 'package:kedis/features2/profile/presentation/bloc/bloc/user_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UserBloc>().add(
            ChangePasswordEvent(
              currentPassword: _currentPasswordController.text,
              newPassword: _newPasswordController.text,
            ),
          );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserPasswordChangedState) {
          MyShowDialogWidget(
            context,
            title: "Успех",
            content: state.message,
            
          );
          context.read<UserBloc>().add(SignOutEvent());
        }
        if (state is UserErrorState) {
          MyShowDialogWidget(
            context,
            title: "Ошибка",
            content: state.message,
          );
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: MyAppBarWidget(nameAppBar: 'Изменение пароля'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextFieldWidget(
                  controller: _currentPasswordController,
                  hintText: 'Текущий пароль',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock),
                  validator: (val) => val?.isEmpty ?? true 
                      ? 'Заполните это поле' 
                      : null,
                ),
                const SizedBox(height: 10),
                MyTextFieldWidget(
                  controller: _newPasswordController,
                  hintText: 'Новый пароль (не менее 6 символов)',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Заполните это поле';
                    } else if (val.length < 6) {
                      return 'Пароль должен содержать не менее 6 символов';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return ButtonWidget(
                        text: 'Изменить пароль',
                        pressed: () => _submitForm(context),
                        isLoading: state is UserLoadingState,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback pressed;
  final bool isLoading; // Добавляем параметр isLoading

  const ButtonWidget({
    required this.text,
    required this.pressed,
    required this.isLoading, // Обязательный параметр
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : pressed, // Блокируем кнопку при загрузке
      child: isLoading
          ? const CircularProgressIndicator() // Показываем индикатор загрузки
          : Text(text),
    );
  }
}
