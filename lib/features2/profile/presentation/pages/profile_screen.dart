import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';
import 'package:kedis/features2/profile/data/models/user_model.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';
import 'package:kedis/features2/profile/presentation/bloc/bloc/user_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  final String userId;

  ProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    if (userId.isEmpty) {
      return Center(child: Text('User ID is empty'));
    }

    return BlocProvider(
      create:
          (context) =>
              UserBloc(context.read<GetUserUseCase>())
                ..add(LoadUserEvent(userId)),
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoadedState) {
              final user = state.user;
              return Stack(
                children: [
                  _buildBackgroundContainer(MediaQuery.of(context).size.height),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 150),
                        CircleAvatar(
                          radius: 64,
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: Color(0xFF004D40),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Column(
                          children: [
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
                          ],
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
                              _buildSectionTitle("Данные о Студенте"),
                              _buildInfoRow("ФИО:", "${user.fullName}"),
                              _buildInfoRow("Группа:", "${user.group}"),
                              _buildInfoRow("Профессия:", "${user.profession}"),
                              const SizedBox(height: 20),
                              _buildSectionTitle("Персональные данные"),
                              _buildInfoRow("Email:", "${user.emailUser}"),
                              _buildInfoRow("Телефон:", "${user.phone}"),
                              const SizedBox(height: 20),
                              _buildSectionTitle("Личные данные"),
                              _buildInfoRow("Логин:", "${user.email}"),
                              _buildInfoRow("Пароль:", "${user.password}"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding : const EdgeInsets.symmetric(horizontal :20),
                          child:
                            MyButtonWidget(text:'Выйти из учетной записи', pressed:( ) {},),
                        ),
                        const SizedBox(height :10),
                        Padding(
                          padding : const EdgeInsets.symmetric(horizontal :20),
                          child :
                            MyButtonWidget(text:'Изменить пароль', pressed:( ) {},),
                        ),
                        const SizedBox(height: 150),
                      ],
                    ),
                  ),
                ],
              );

            } else if (state is UserErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildBackgroundContainer(double height) {
    return Container(
      height: height * 0.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00796B), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ), // Vertical spacing between rows
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(value, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
