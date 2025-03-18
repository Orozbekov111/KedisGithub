import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/firebase_user_repository.dart';
import '../../bloc/authentication/sign_up_bloc/sign_up_bloc.dart';
import 'components/evalutions_t_screen/groups_screen.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/show_dialog.dart';
import 'components/schedule_screens/create_group_screen.dart';
import 'components/create_user_screen.dart';
import 'components/user_list_screen/user_list_screen.dart';

// Класс для хранения информации о текущем пользователе
class UserSession {
  static UserModel? currentUser; // Текущий пользователь
}
class MenuScreen extends StatelessWidget {
  final FirebaseUserRepository firebaseUserRepository = FirebaseUserRepository();

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initializeCurrentUser(); // Инициализация текущего пользователя

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBarWidget(nameAppBar: 'Меню администраций'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: _buildMenuItems(context),
          ),
        ),
      ),
    );
  }

  void _initializeCurrentUser() async {
    UserSession.currentUser = await firebaseUserRepository.getCurrentUser();
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    return [
      _createMenuItem(
        title: 'Создание новых пользователей',
        icon: Icons.school,
        onTap: () => _navigateToSignUp(context),
      ),
      _createMenuItem(
        title: 'Изменение данных пользователей',
        icon: Icons.edit,
        onTap: () => _navigateToScreen(context, UserListScreen()),
      ),
      _createMenuItem(
        title: 'Создание расписания',
        icon: Icons.schedule,
        onTap: () => _navigateToScreen(context, CreateGroupScreen()),
      ),
      _createMenuItem(
        title: 'Поставить оценки',
        icon: Icons.event_available_rounded,
        onTap: () => _navigateToGrades(context),
      ),
    ];
  }

  Widget _createMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MenuItem(
      title: title,
      icon: icon,
      onTap: onTap,
    );
  }

  void _navigateToSignUp(BuildContext context) {
    // if (UserSession.currentUser?.role == "Админ") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => BlocProvider(
    //         create: (context) => SignUpBloc(userRepository: context.read<FirebaseUserRepository>()),
    //         child: const CreateUserScreen(),
    //       ),
    //     ),
    //   ).catchError((error) {
    //     _showErrorSnackBar(context);
    //   });
    // } else {
    //   _showAccessDeniedDialog(context);
    // }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignUpBloc(userRepository: context.read<FirebaseUserRepository>()),
            child: const CreateUserScreen(),
          ),
        ),
      ).catchError((error) {
        _showErrorSnackBar(context);
      });
  }

  void _navigateToGrades(BuildContext context) {
    if (UserSession.currentUser?.role == "Админ" || UserSession.currentUser?.role == "Преподаватель") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GroupsScreen()),
      ).catchError((error) {
        _showErrorSnackBar(context);
      });
    } else {
      _showAccessDeniedDialog(context);
    }
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    if (UserSession.currentUser?.role == "Админ") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ).catchError((error) {
        _showErrorSnackBar(context);
      });
    } else {
      _showAccessDeniedDialog(context);
    }
  }

  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ошибка при переходе на экран')));
  }

  void _showAccessDeniedDialog(BuildContext context) {
    ShowDialog(
      context,
      title: 'Ошибка входа',
      content: 'У вас недостаточно прав для входа',
    );
  }
}

class MenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  double _height = 100; // Начальная высота

  void _toggleHeight() {
    setState(() {
      _height = (_height == 100) ? 150 : 100; // Переключаем высоту
    });

    // Вызываем onTap после изменения высоты для навигации
    Future.delayed(const Duration(milliseconds: 300), widget.onTap);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleHeight,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _height,
        child: Card(
          elevation: 9,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.5, color: const Color(0xFF00796B)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 50, color: const Color(0xFF00796B)),
                const SizedBox(height: 10),
                Text(
                  widget.title,
                  style: const TextStyle(
                      color: Color(0xFF00796B),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
