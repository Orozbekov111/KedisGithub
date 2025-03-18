
import 'package:flutter/material.dart';

import '../../../../../data/models/group_model.dart';
import '../../../../../data/repositories/schedule_manager_repositories.dart';

class ViewScheduleScreen extends StatefulWidget {
  final String groupId;

  ViewScheduleScreen({required this.groupId});

  @override
  _ViewScheduleScreenState createState() => _ViewScheduleScreenState();
}

class _ViewScheduleScreenState extends State<ViewScheduleScreen> {
  late Future<List<ScheduleModel>?> _scheduleFuture;

  @override
  void initState() {
    super.initState();
    _scheduleFuture = ScheduleManager().getSchedule(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Расписание')),
      body: FutureBuilder<List<ScheduleModel>?>(
        future: _scheduleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка при загрузке расписания'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Расписание не найдено'));
          }

          final schedules = snapshot.data!;
          return ListView.builder(
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              return ExpansionTile(
                title: Text(schedule.dayOfWeek),
                children: schedule.lessons
                    .map((lesson) => ListTile(
                          title: Text(lesson.subject),
                          subtitle: Text(
                              '${lesson.time} - ${lesson.teacherName} (${lesson.classroom})'),
                        ))
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}