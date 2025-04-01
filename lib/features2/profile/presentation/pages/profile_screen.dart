import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/router/app_router.gr.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';
import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';
import 'package:kedis/features2/profile/presentation/bloc/bloc/user_bloc.dart';
import 'package:kedis/features2/profile/presentation/component/build_info_row_widget.dart';
import 'package:kedis/features2/profile/presentation/component/build_section_title_widget.dart';
import 'package:kedis/features2/profile/presentation/component/change_password_screen.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    userBloc.add(
      LoadUserEvent(userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
    );
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSignedOutState) {
            // Перенаправление на экран входа после выхода
            context.router.replace(const LoginRoute());
          } else if (state is UserPasswordChangedState) {
            // Уведомление об успешном изменении пароля
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Пароль успешно изменен')),
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoadedState) {
              final user = state.user;
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF00796B), Color(0xFF004D40)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 150),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: Color(0xFF004D40),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          '${user.fullName}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          user.role,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                          ),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(blurRadius: 10, color: Colors.black26),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSectionTitle("Данные о Студенте"),
                              buildInfoRow("ФИО:", "${user.fullName}"),
                              buildInfoRow("Группа:", "${user.group}"),
                              buildInfoRow("Профессия:", "${user.profession}"),
                              const SizedBox(height: 20),
                              buildSectionTitle("Персональные данные"),
                              buildInfoRow("Email:", "${user.emailUser}"),
                              buildInfoRow("Телефон:", "${user.phone}"),
                              const SizedBox(height: 20),
                              buildSectionTitle("Личные данные"),
                              buildInfoRow("Логин:", "${user.email}"),
                              buildInfoRow("Пароль:", "${user.password}"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        MyButtonWidget(
                          text: 'Выйти из учетной записи',
                          pressed: () {
                            context.read<UserBloc>().add(SignOutEvent());
                          },
                        ),
                        MyButtonWidget(
                          text: 'Изменить пароль',
                          pressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder:
                                    (BuildContext context) =>
                                        ChangePasswordScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 150),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is UserErrorState) {
              return Center(child: Text('Ошибка: ${state.message}'));
            } else {
              return const Center(child: Text('Нет данных'));
            }
          },
        ),
      ),
    );
  }
}
