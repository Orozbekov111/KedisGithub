import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';
import 'package:kedis/core/widgets/my_confirmation_dialog_widget.dart';
import 'package:kedis/core/widgets/my_show_dialog_widget.dart';
import 'package:kedis/core/widgets/my_textfield_widget.dart';
import 'package:kedis/features/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/entities/menu_user_entity.dart';
import 'package:kedis/features/menu/create_and_update_user/presentation/bloc/UseManagement/user_management_block.dart';

class UserProfileScreen extends StatefulWidget {
  final MenuUserEntity user;

  const UserProfileScreen({required this.user, Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _emailUserController;
  late TextEditingController _phoneController;
  late TextEditingController _groupController;
  late TextEditingController _professionController;
  late TextEditingController _specialtyController;
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late TextEditingController _codeController;
  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.fullName);
    _emailController = TextEditingController(text: widget.user.email);
    _emailUserController = TextEditingController(text: widget.user.emailUser);
    _phoneController = TextEditingController(text: widget.user.phone);
    _groupController = TextEditingController(text: widget.user.group);
    _professionController = TextEditingController(text: widget.user.profession);
    _specialtyController = TextEditingController(text: widget.user.specialty);
    _loginController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
    _codeController = TextEditingController(text: widget.user.code);
    _selectedRole = widget.user.role;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _emailUserController.dispose();
    _phoneController.dispose();
    _groupController.dispose();
    _professionController.dispose();
    _specialtyController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: MyAppBarWidget(nameAppBar: widget.user.fullName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: widget.user.picture?.isNotEmpty == true
                    ? NetworkImage(widget.user.picture!)
                    : null,
                child: widget.user.picture?.isEmpty ?? true
                    ? Text(widget.user.fullName.substring(0, 1).toUpperCase())
                    : null,
              ),
              const SizedBox(height: 20),

              MyTextFieldWidget(
                controller: _nameController,
                hintText: 'ФИО',
                obscureText: false,
                keyboardType: TextInputType.name,
                validator: (val) => val!.isEmpty ? 'Обязательное поле' : null,
              ),
              const SizedBox(height: 12),

              MyTextFieldWidget(
                controller: _emailController,
                hintText: 'Email (для входа)',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val!.isEmpty) return 'Обязательное поле';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                    return 'Некорректный email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              MyTextFieldWidget(
                controller: _emailUserController,
                hintText: 'Контактный email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              MyTextFieldWidget(
                controller: _phoneController,
                hintText: 'Телефон',
                obscureText: false,
                keyboardType: TextInputType.phone,
                validator: (val) => val!.isEmpty ? 'Обязательное поле' : null,
              ),
              const SizedBox(height: 12),

              MyTextFieldWidget(
                controller: _groupController,
                hintText: 'Группа',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 12),

              MyTextFieldWidget(
                controller: _professionController,
                hintText: 'Профессия',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 12),

              MyTextFieldWidget(
                controller: _specialtyController,
                hintText: 'Специальность',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 12),

              MyTextFieldWidget(
                controller: _passwordController,
                hintText: 'Пароль',
                obscureText: false,
                keyboardType: TextInputType.text,
                validator: (val) => val!.isEmpty ? 'Обязательное поле' : null,
              ),
              const SizedBox(height: 16),

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
                      [
                            'active',
                            'top',
                            'expulsion',
                            'student',
                          ] // Добавлен 'regular'
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category == 'top'
                                    ? 'Лучшие студенты'
                                    : category == 'expulsion'
                                    ? 'Студенты на отчисление'
                                    : category == 'student'
                                    ? 'Простой студент' // Новый вариант
                                    : 'Активные студенты',
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    _codeController.text = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Категория студентов',
                    prefixIcon: Icon(Icons.group),
                  ),
                  validator: (val) => val == null ? 'Выберите категорию' : null,
                ),
              ),
              const SizedBox(height: 16),
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
    value: ['user', 'admin', 'teacher'].contains(widget.user.role) 
        ? widget.user.role 
        : 'user', // Значение по умолчанию, если роль не совпадает
    items: ['user', 'admin', 'teacher'].map((role) {
      return DropdownMenuItem<String>(
        value: role,
        child: Text(
          role == 'admin'
              ? 'Администратор'
              : role == 'teacher'
                  ? 'Преподаватель'
                  : 'Студент',
        ),
      );
    }).toList(),
    onChanged: (String? newValue) {
      setState(() {
        _selectedRole = newValue ?? 'user';
      });
    },
    decoration: const InputDecoration(
      labelText: 'Роль пользователя',
      border: InputBorder.none,
    ),
  ),
),

              const SizedBox(height: 16),
              
             
                  MyButtonWidget(
                    text: 'Сохранить',
                    pressed: _saveChanges,
                  ),
                  MyButtonWidget(
                    text: 'Удалить',
                    pressed: _confirmDelete,
                  ),
                
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() async {
  if (_formKey.currentState!.validate()) {
    final updatedUser = MenuUserModel(
      id: widget.user.id,
      email: _emailController.text,
      password: _passwordController.text,
      fullName: _nameController.text,
      emailUser: _emailUserController.text,
      group: _groupController.text,
      profession: _professionController.text,
      phone: _phoneController.text,
      specialty: _specialtyController.text,
      role: _selectedRole,
      code: _codeController.text,
      picture: widget.user.picture,
    );

    try {
      context.read<UserManagementBloc>().add(UpdateUserEvent(updatedUser));
      
      await MyShowDialogWidget(
        context,
        title: 'Успех',
        content: 'Данные пользователя успешно обновлены',
        isSuccess: true,
      );
      
      if (mounted) Navigator.pop(context);
    } catch (e) {
      await MyShowDialogWidget(
        context,
        title: 'Ошибка',
        content: 'Не удалось обновить данные пользователя: ${e.toString()}',
        isSuccess: false,
      );
    }
  }
}

  void _confirmDelete() {
  showDialog(
    context: context,
    builder: (context) => MyConfirmationDialogWidget(
      title: 'Подтверждение удаления',
      message: 'Вы уверены, что хотите удалить этого пользователя?',
      confirmButtonText: 'Удалить',
      onConfirm: () {
        context.read<UserManagementBloc>().add(DeleteUserEvent(widget.user.id));
        Navigator.pop(context); // Дополнительный pop для возврата к списку
      },
    ),
  );
}
}