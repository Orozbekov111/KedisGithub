// lib/features/auth/presentation/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';
import 'package:kedis/features2/auth/domain/entities/user_entity.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_bloc.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_event.dart';
import 'package:kedis/features2/auth/presentation/pages/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity user;

  HomeScreen({required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    Center(child: Text('Главная', style: TextStyle(fontSize: 24))),
    Center(child: Text('Поиск', style: TextStyle(fontSize: 24))),
    Center(child: Text('Избранное', style: TextStyle(fontSize: 24))),
    Center(child: Text('Профиль', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: MyAppBarWidget(nameAppBar: 'Главная меню'),
      ),
      // body: Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         const SizedBox(height: 10),
      //         MyButtonWidget(text: 'Моя группа', pressed: () {}),
      //         MyButtonWidget(text: 'Преподаватели', pressed: () {}),
      //         MyButtonWidget(text: 'Лучшие студенты', pressed: () {}),
      //         MyButtonWidget(text: 'Активисты', pressed: () {}),
      //         MyButtonWidget(text: 'Студ. совет', pressed: () {}),
      //         MyButtonWidget(text: 'Ст. на отчисление', pressed: () {}),
      //         MyButtonWidget(text: 'Новости', pressed: () {}),
      //         MyButtonWidget(text: 'Библиотека', pressed: () {}),
      //         MyButtonWidget(text: 'Наш сайт', pressed: () {}),
      //         const SizedBox(height: 162),
      //       ],
      //     ),
      //   ),
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00796B), Color(0xFF004D40)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ), // Закругленные углы
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white, // Цвет выбранной вкладки
            unselectedItemColor: Colors.grey[500], // Цвет невыбранной вкладки
            selectedFontSize: 0, // Скрываем подпись
            unselectedFontSize: 0, // Скрываем подпись
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.home,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.time_circle,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.category,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.document,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.profile,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Профиль')),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           Text('ID: ${user.id}'),
  //           Text('Email: ${user.email}'),
  //           Text('Имя: ${user.fullName}'),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () {
  //               context.read<AuthBloc>().add(LogoutEvent());
  //               Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => LoginScreen()),
  //               );
  //             },
  //             child: Text('Выйти'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
