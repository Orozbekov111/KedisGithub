import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/button_widget.dart';
import 'screens/activists_screen.dart';
import 'screens/all_teacher_screen.dart';
import 'screens/best_students_screen.dart';
import 'screens/deduction_screen.dart';
import 'screens/link_screens/library_screen.dart';
import 'screens/my_group.screen.dart';
import 'screens/link_screens/news_screen.dart';
import 'screens/student_council_screen.dart';
import 'screens/link_screens/website_kedis_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0), // Высота AppBar
          child: AppBarWidget(
            nameAppBar: 'Главная меню',
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ButtonWidget(
                  text: 'Моя группа',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyGroupScreen()));
                  },
                ),
                ButtonWidget(
                  text: 'Преподаватели',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllTeacherScreen()));
                  },
                ),
                ButtonWidget(
                  text: 'Лучшие студенты',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BestStudentsScreen()));
                  },
                ),
                ButtonWidget(
                  text: 'Активисты',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ActivistsScreen()));
                  },
                ),
                ButtonWidget(
                  text: 'Студ. совет',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentCouncilScreen()));
                  },
                ),
                ButtonWidget(
                  text: 'Ст. на отчисление',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeductionScreen()));
                  },
                ),
                ButtonWidget(
                  text: 'Новости',
                  pressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const NewsScreen()));
                  },
                ),
                ButtonWidget(
                  text: 'Библиотека',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LibraryScreen()));
                  },
                ),
                ButtonWidget(
                  text: 'Наш сайт',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WebsiteKedisScreen()));
                  },
                ),
                const SizedBox(height: 162),
              ],
            ),
          ),
        ));
  }
}
