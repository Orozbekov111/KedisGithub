import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authentication/sign_up_bloc/sign_up_bloc.dart';
import '../../../../data/models/user_model.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/show_dialog.dart';
import '../../widgets/textfield.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}
class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailUserController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final groupController = TextEditingController();
  final professionController = TextEditingController();
  final phoneController = TextEditingController();
  final specialtyController = TextEditingController();
  final loginUserController = TextEditingController();
  final roleController = TextEditingController();

  bool signUpRequired = false; // Состояние для отслеживания процесса регистрации

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          // Navigator.pop(context); // Закрыть диалоговое окно
          ShowDialog(context, title: 'Успех', content: 'Регистрация прошла успешно!');
          setState(() {
            signUpRequired = false; // Сброс состояния загрузки
          });
          Navigator.pushReplacementNamed(context, '/home'); // Переход на главный экран
        } else if (state is SignUpFailure) {
          // Navigator.pop(context); // Закрыть диалоговое окно
          ShowDialog(context, title: 'Ошибка', content: 'Такой пользователь уже существует');
          setState(() {
            signUpRequired = false;
          });
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBarWidget(
            nameAppBar: 'Создайте студента',
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    MyTextField(
                      controller: loginUserController,
                      hintText: 'Придумайте логин',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(CupertinoIcons.mail_solid),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Заполните это поле';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                          return 'Заполните email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Придумайте пароль',
                      obscureText: true, // Изменено на true для скрытия пароля
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.lock),
                      validator: (val) {
                        if (val!.length <= 6 ) {
                          return 'Не меньше 6 символов';
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: nameController,
                      hintText: 'Ф.И.О',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(CupertinoIcons.person_fill),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: groupController,
                      hintText: 'Группа',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.supervisor_account),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: professionController,
                      hintText: 'Профессия',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.contacts),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: phoneController,
                      hintText: 'Номер телефона',
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_paused),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: emailUserController,
                      hintText: 'Электронная почта',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: roleController,
                      hintText: 'Студент или Преподаватель или Админ',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.mail),
                    ),
                    const SizedBox(height: 50),
                    signUpRequired
                        ? CircularProgressIndicator() // Показать индикатор загрузки
                        : ButtonWidget(
                            text: 'Зарегистрировать',
                            pressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  signUpRequired = true; // Устанавливаем состояние загрузки
                                });


                                UserModel myUser = UserModel(
                                  id:'',
                                  code:'',
                                  email : loginUserController.text,
                                  fullName : nameController.text,
                                  group : groupController.text,
                                  profession : professionController.text,
                                  password : passwordController.text,
                                  phone : phoneController.text,
                                  specialty : specialtyController.text,
                                  role : roleController.text,
                                  emailUser : emailUserController.text
                                );

                                context.read<SignUpBloc>().add(SignUpRequired(myUser, passwordController.text));
                              }
                            },
                          ),
                    const SizedBox(height :150)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
