import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';
import 'package:kedis/features2/menu/create_a_schedule/presentation/pages/create_group_page.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_get_current_user_usecase.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/bloc/CurrentUser/current_user_bloc.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/pages/create_user_screen.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/pages/update_screens/user_management_screen.dart';

@RoutePage()

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _checkPermissionAndNavigate(BuildContext context, {required String requiredRole, required Widget screen}) {
    final currentUserState = context.read<CurrentUserBloc>().state;
    
    if (currentUserState is CurrentUserSuccess) {
      final user = currentUserState.user;
      
      if (user.role == 'admin' || user.role == requiredRole) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      } else {
        _showAccessDeniedDialog(context);
      }
    } else {
      context.read<CurrentUserBloc>().add(GetCurrentUserEvent());
    }
  }

  void _showAccessDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Доступ запрещен'),
        content: const Text('У вас недостаточно прав для этого действия'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentUserBloc(
        getCurrentUser: context.read<MenuGetCurrentUserUsecase>(),
      )..add(GetCurrentUserEvent()),
      child: Builder(
        builder: (innerContext) {
          return BlocListener<CurrentUserBloc, CurrentUserState>(
            listener: (context, state) {
              if (state is CurrentUserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(70.0),
                child: MyAppBarWidget(nameAppBar: 'Главная меню'),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      MyButtonWidget(
                        text: 'Создать пользователя',
                        pressed: () => _checkPermissionAndNavigate(
                          innerContext, // Используем innerContext
                          requiredRole: 'admin',
                          screen: const CreateUserScreen(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      MyButtonWidget(
                        text: 'Редактировать пользователя',
                        pressed: () => _checkPermissionAndNavigate(
                          innerContext,
                          requiredRole: 'admin',
                          screen: const UserManagementScreen(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      MyButtonWidget(
                        text: 'Создать расписание',
                        pressed: () => _checkPermissionAndNavigate(
                          innerContext,
                          requiredRole: 'teacher',
                          screen: const CreateGroupPage(),
                        ),
                      ),
                      const SizedBox(height: 162),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}