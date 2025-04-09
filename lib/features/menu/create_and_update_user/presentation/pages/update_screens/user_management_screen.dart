import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/entities/menu_user_entity.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/usecases/menu_delete_user_usecase.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/usecases/menu_get_all_users_usecase.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/usecases/menu_update_user_usecase.dart';
import 'package:kedis/features/menu/create_and_update_user/presentation/bloc/UseManagement/user_management_block.dart';
import 'package:kedis/features/menu/create_and_update_user/presentation/component/my_user_card.dart';
import 'package:kedis/features/menu/create_and_update_user/presentation/pages/update_screens/user_profile_screen.dart';

// class UserManagementScreen extends StatelessWidget {
//   const UserManagementScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<UserManagementBloc>(
//       create:
//           (context) => UserManagementBloc(
//             getAllUsers: context.read<MenuGetAllUsersUsecase>(),
//             updateUser: context.read<MenuUpdateUserUsecase>(),
//             deleteUser: context.read<MenuDeleteUserUsecase>(),
//           )..add(LoadUsersEvent()),
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(70.0),
//           child: MyAppBarWidget(
//             nameAppBar: 'Управление пользователями',
//             icon: IconButton(
//               icon: const Icon(Icons.refresh),
//               color: Colors.white,
//               onPressed:
//                   () =>
//                       context.read<UserManagementBloc>().add(LoadUsersEvent()),
//             ),
//           ),
//         ),
//         body: BlocConsumer<UserManagementBloc, UserManagementState>(
//           listener: (context, state) {
//             if (state is UserManagementError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             } else if (state is UserManagementLoaded) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Действие выполнено успешно'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is UserManagementLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UserManagementError) {
//               return Center(
//                 child: Text(
//                   state.message,
//                   style: const TextStyle(color: Colors.red, fontSize: 16),
//                 ),
//               );
//             } else if (state is UserManagementLoaded) {
//               return _buildUserList(context, state.users);
//             }
//             return const Center(
//               child: Text('Загрузка данных...', style: TextStyle(fontSize: 16)),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildUserList(BuildContext context, List<MenuUserEntity> users) {
//     if (users.isEmpty) {
//       return const Center(
//         child: Text('Нет пользователей', style: TextStyle(fontSize: 16)),
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: () async {
//         context.read<UserManagementBloc>().add(LoadUsersEvent());
//       },
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return MyUserCard(
//             user: user,
//             onTap: () {
//               // В месте, где вы создаете UserProfileScreen:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (context) => BlocProvider.value(
//                         value: context.read<UserManagementBloc>(),
//                         child: UserProfileScreen(
//                           user: user,
//                           userManagementBloc:
//                               context
//                                   .read<
//                                     UserManagementBloc
//                                   >(), // Теперь не нужно передавать
//                         ),
//                       ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: MyAppBarWidget(
          nameAppBar: 'Управление пользователями',
          
        ),
      ),
      body: BlocBuilder<UserManagementBloc, UserManagementState>(
        builder: (context, state) {
          if (state is UserManagementLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserManagementError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is UserManagementLoaded) {
            return _buildUserList(context, state.users);
          }
          return const Center(
            child: Text('Загрузка данных...', style: TextStyle(fontSize: 16)),
          );
        },
      ),
    );
  }
  

  Widget _buildUserList(BuildContext context, List<MenuUserEntity> users) {
    if (users.isEmpty) {
      return const Center(
        child: Text('Нет пользователей', style: TextStyle(fontSize: 16)),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserManagementBloc>().add(LoadUsersEvent());
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return MyUserCard(
            user: user,
            onTap: () => _navigateToUserProfile(context, user),
          );
        },
      ),
    );
  }

  void _navigateToUserProfile(BuildContext context, MenuUserEntity user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<UserManagementBloc>(),
          child: UserProfileScreen(user: user),
        ),
      ),
    );
  }
}