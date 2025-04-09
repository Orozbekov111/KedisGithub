import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';
import 'package:kedis/core/widgets/my_show_dialog_widget.dart';
import 'package:kedis/core/widgets/my_textfield_widget.dart';
import 'package:kedis/features/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/usecases/menu_create_user_usecase.dart';
import 'package:kedis/features/menu/create_and_update_user/presentation/bloc/UserCreate/user_create_bloc.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginUserController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final groupController = TextEditingController();
  final professionController = TextEditingController();
  final phoneController = TextEditingController();
  final emailUserController = TextEditingController();
  final roleController = TextEditingController();
  final codeController = TextEditingController();

  @override
  void dispose() {
    loginUserController.dispose();
    passwordController.dispose();
    nameController.dispose();
    groupController.dispose();
    professionController.dispose();
    phoneController.dispose();
    emailUserController.dispose();
    roleController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void _clearFields() {
    loginUserController.clear();
    passwordController.clear();
    nameController.clear();
    groupController.clear();
    professionController.clear();
    phoneController.clear();
    emailUserController.clear();
    roleController.clear();
    codeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: MyAppBarWidget(nameAppBar: 'Создание пользователя'),
      ),
      body: BlocProvider(
        create:
            (context) => UserCreateBloc(
              createUser: context.read<MenuCreateUserUsecase>(),
            ),
        child: BlocConsumer<UserCreateBloc, UserCreateState>(
          listener: (context, state) {
            if (state is UserCreateError) {
              MyShowDialogWidget(
                context,
                title: 'Ошибка',
                content: '${state.error}',
                isSuccess: false,
              );
            } else if (state is UserCreateSuccess) {
              MyShowDialogWidget(
                context,
                title: 'Успех',
                content: 'Данные пользователя успешно обновлены',
                isSuccess: true,
              );
              _clearFields();
            }
          },
          builder: (context, createUserState) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextFieldWidget(
                      controller: loginUserController,
                      hintText: 'Придумайте логин',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail),
                      validator: (val) {
                        if (val!.isEmpty) return 'Заполните это поле';
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                          return 'Введите корректный email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    MyTextFieldWidget(
                      controller: passwordController,
                      hintText: 'Придумайте пароль',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.lock),
                      validator: (val) {
                        if (val!.length <= 6) return 'Не меньше 6 символов';
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    MyTextFieldWidget(
                      controller: nameController,
                      hintText: 'Ф.И.О',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person),
                      validator:
                          (val) => val!.isEmpty ? 'Заполните это поле' : null,
                    ),
                    const SizedBox(height: 10),
                    MyTextFieldWidget(
                      controller: groupController,
                      hintText: 'Группа',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.group),
                      validator:
                          (val) => val!.isEmpty ? 'Заполните это поле' : null,
                    ),
                    const SizedBox(height: 10),
                    MyTextFieldWidget(
                      controller: professionController,
                      hintText: 'Профессия',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.work),
                      validator:
                          (val) => val!.isEmpty ? 'Заполните это поле' : null,
                    ),
                    const SizedBox(height: 10),
                    MyTextFieldWidget(
                      controller: phoneController,
                      hintText: 'Номер телефона',
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone),
                      validator:
                          (val) => val!.isEmpty ? 'Заполните это поле' : null,
                    ),
                    const SizedBox(height: 10),
                    MyTextFieldWidget(
                      controller: emailUserController,
                      hintText: 'Электронная почта',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail_outline),
                      validator: (val) {
                        if (val!.isEmpty) return 'Заполните это поле';
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                          return 'Введите корректный email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: 'student',
                        items:
                            ['active', 'top', 'expulsion', 'student']
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category == 'top'
                                          ? 'Лучшие студенты'
                                          : category == 'expulsion'
                                          ? 'Студенты на отчисление'
                                          : category == 'student'
                                          ? 'Простой студент'
                                          : 'Активные студенты',
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          codeController.text = value!;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Категория студентов',
                          prefixIcon: Icon(Icons.group),
                        ),
                        validator:
                            (val) => val == null ? 'Выберите категорию' : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: 'user',
                        items:
                            ['user', 'admin', 'teacher']
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(
                                      role == 'admin'
                                          ? 'Администратор'
                                          : role == 'teacher'
                                          ? 'Преподаватель'
                                          : 'Студент',
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) => roleController.text = value!,
                        decoration: const InputDecoration(
                          labelText: 'Роль пользователя',
                          prefixIcon: Icon(Icons.perm_identity),
                        ),
                        validator:
                            (val) => val == null ? 'Выберите роль' : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyButtonWidget(
                      text: 'Создать пользователя',
                      pressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final newUser = MenuUserModel(
                            id: '',
                            email: loginUserController.text.trim(),
                            password: passwordController.text.trim(),
                            fullName: nameController.text.trim(),
                            emailUser: emailUserController.text.trim(),
                            group: groupController.text.trim(),
                            profession: professionController.text.trim(),
                            phone: phoneController.text.trim(),
                            specialty: professionController.text.trim(),
                            role: roleController.text.trim().toLowerCase(),
                            code: codeController.text.trim(),
                          );

                          context.read<UserCreateBloc>().add(
                            CreateUserEvent(newUser),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
