import 'package:flutter/material.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/entities/lesson_entity.dart';

class LessonList extends StatelessWidget {
  final List<lessonEntity> lessons;

  const LessonList({Key? key, required this.lessons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return const Center(child: Text('No lessons added yet'));
    }

    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return ListTile(
          title: Text(lesson.subject),
          subtitle: Text('${lesson.time} - ${lesson.teacherName} (${lesson.classroom})'),
        );
      },
    );
  }
}