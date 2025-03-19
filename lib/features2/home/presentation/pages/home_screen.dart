import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';



@RoutePage()
class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: MyAppBarWidget(nameAppBar: 'Главная меню'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              MyButtonWidget(text: 'Моя группа', pressed: () {}),
              MyButtonWidget(text: 'Преподаватели', pressed: () {}),
              MyButtonWidget(text: 'Лучшие студенты', pressed: () {}),
              MyButtonWidget(text: 'Активисты', pressed: () {}),
              MyButtonWidget(text: 'Студ. совет', pressed: () {}),
              MyButtonWidget(text: 'Ст. на отчисление', pressed: () {}),
              MyButtonWidget(text: 'Новости', pressed: () {}),
              MyButtonWidget(text: 'Библиотека', pressed: () {}),
              MyButtonWidget(text: 'Наш сайт', pressed: () {}),
              const SizedBox(height: 162),
            ],
          ),
        ),
      ),
    );
  }
}