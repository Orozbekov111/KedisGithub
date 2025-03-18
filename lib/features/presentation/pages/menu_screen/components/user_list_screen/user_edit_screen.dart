import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/user_model.dart';
import '../../../../../data/repositories/firebase_user_repository.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/show_dialog.dart';
import '../../../widgets/textfield.dart';

class UserEditScreen extends StatefulWidget {
  final UserModel user;

  UserEditScreen({required this.user});

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final TextEditingController loginUserController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController groupController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailUserController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginUserController.text = widget.user.email;
    passwordController.text = widget.user.password;
    nameController.text = widget.user.fullName;
    groupController.text = widget.user.group;
    professionController.text = widget.user.profession;
    phoneController.text = widget.user.phone;
    emailUserController.text = widget.user.emailUser;
    roleController.text = widget.user.role;
    specialtyController.text = widget.user.specialty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Редактирование',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              MyTextField(
                controller: loginUserController,
                hintText: 'Нельзя изменять логин',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(CupertinoIcons.mail_solid),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Заполните это поле';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                    // Пример регулярного выражения для email
                    return 'Заполните email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Нельзя изменять пароль',
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.lock),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Заполните это поле';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: nameController,
                hintText: 'Можете изменить Ф.И.О',
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(CupertinoIcons.person_fill),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Заполните это поле';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: groupController,
                hintText: 'Можете изменить группу',
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.supervisor_account),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: professionController,
                hintText: 'Можете изменить Профессию',
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.contacts),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Заполните это поле';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: phoneController,
                hintText: 'Можете изменить номер телефона',
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.phone_paused),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Заполните это поле';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: emailUserController,
                hintText: 'Можете изменить электронная почту',
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.mail),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Заполните это поле';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: roleController,
                hintText: 'Можете изменить Роль',
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Заполните это поле';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: specialtyController,
                hintText: 'Активности',
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                text: 'Сохранить изменения',
                pressed: () {
                  _updateUserData();
                },
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateUserData() async {
    final userRepository = Provider.of<FirebaseUserRepository>(context, listen: false);

    UserModel updatedUser = widget.user.copyWith(
        email: loginUserController.text,
        password: passwordController.text,
        fullName: nameController.text,
        group: groupController.text,
        profession: professionController.text,
        phone: phoneController.text,
        emailUser: emailUserController.text,
        role: roleController.text,
        specialty: specialtyController.text);

    try {
      await userRepository.setUserData(updatedUser);
      ShowDialog(context, title: 'Успех', content: 'Данные изменены');
    } catch (e) {
                ShowDialog(context, title: '', content: 'Ошибка при обновлении данных');

    }
  }
}
