import 'package:flutter/material.dart';
import 'package:kedis/features/menu/create_a_schedule/presentation/pages/add_schedule_page.dart';

class SelectDayPage extends StatelessWidget {
  final String groupId;

  const SelectDayPage({Key? key, required this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Day')),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(daysOfWeek[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AddSchedulePage(
                          groupId: groupId,
                          dayOfWeek: daysOfWeek[index],
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
