
import 'package:flutter/material.dart';

import '../../../widgets/app_bar_widget.dart';
import 'add_schedule_for_day_screen.dart';

class SelectDayScreen extends StatelessWidget {
  final String groupName;

  SelectDayScreen({required this.groupName});

  @override
  Widget build(BuildContext context) {
    final List<String> daysOfWeek = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Выберите день недели',
        ),
      ),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00796B),
                      Color(0xFF004D40)
                    ], // Градиентный фон
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text(
                  daysOfWeek[index],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onTap: () {
                  // Переход на экран добавления расписания для выбранного дня
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddScheduleForDayScreen(
                        groupId: groupName,
                        dayOfWeek: daysOfWeek[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}






