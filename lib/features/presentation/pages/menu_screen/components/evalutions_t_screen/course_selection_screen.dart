
import 'package:flutter/material.dart';

import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import 'subject_creation_screen.dart';

class CourseSelectionScreen extends StatelessWidget {
  final String groupName;

  const CourseSelectionScreen({required this.groupName});

  void navigateToSubjectCreation(BuildContext context, String course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectCreationScreen(
          course: course,
          groupName: groupName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBarWidget(
          nameAppBar: 'Выберите курс',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$groupName',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ButtonWidget(
                text: '1 курс',
                pressed: () => navigateToSubjectCreation(context, 'Первый курс')),
            ButtonWidget(
                text: '2 курс',
                pressed: () => navigateToSubjectCreation(context, 'Второй курс')),
            ButtonWidget(
                text: '3 курс',
                pressed: () => navigateToSubjectCreation(context, 'Третий курс')),
          ],
        ),
      ),
    );
  }
}