import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/entities/menu_user_entity.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/bloc/UseManagement/user_management_block.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/component/my_user_card.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/pages/update_screens/user_profile_screen.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: MyAppBarWidget(
          nameAppBar: 'Главная меню',
          icon: IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed:
                () => context.read<UserManagementBloc>().add(LoadUsersEvent()),
          ),
        ),
      ),
      body: BlocConsumer<UserManagementBloc, UserManagementState>(
        listener: (context, state) {
          if (state is UserManagementError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is UserManagementLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Действие выполнено успешно')),
            );
          }
        },
        builder: (context, state) {
          if (state is UserManagementLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserManagementError) {
            return Center(child: Text(state.message));
          } else if (state is UserManagementLoaded) {
            return _buildUserList(context, state.users);
          }
          return const Center(child: Text('Загрузка данных...'));
        },
      ),
    );
  }

 
Widget _buildUserList(BuildContext context, List<MenuUserEntity> users) {
  if (users.isEmpty) {
    return const Center(child: Text('Нет пользователей'));
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: users.length,
    itemBuilder: (context, index) {
      final user = users[index];
      return MyUserCard(
        user: user, 
        onTap: () {  // Now passing a proper callback function
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfileScreen(user: user),
            ),
          );
        },
      );
    },
  );
}
}
