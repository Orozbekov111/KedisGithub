import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/show_dialog.dart';
import '../../widgets/textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool obscurePassword = true;

  Future<void> _changePassword() async {
    User? user = _auth.currentUser;

    if (user == null) {
      ShowDialog(context, title: "Ошибка", content: "Пользователь не найден.");
      return;
    }

    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;

    try {
      // Повторная аутентификация пользователя
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Изменение пароля
      await user.updatePassword(newPassword);

      // Обновление данных в Firestore (например, можно обновить поле "lastUpdated")
      await _firestore.collection('users').doc(user.uid).update({
        'password': newPassword,
      });

      ShowDialog(context, title: "Успех", content: "Пароль успешно изменён");
    } catch (e) {
      ShowDialog(context, title: "Ошибка", content:  "1) В новом пароле не должно быть меньше 6 цифр \n2) Проверьте правильно ли вы указали текущий пароль");
    }
  }




  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0), // Высота AppBar
          child: AppBarWidget(nameAppBar: 'Изменение пароля',),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyTextField(
              controller: _currentPasswordController,
              hintText: 'Текущий пароль',
              
              obscureText: obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              
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
              child: ButtonWidget(
                text: 'Изменить пароль',
                pressed: _changePassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}