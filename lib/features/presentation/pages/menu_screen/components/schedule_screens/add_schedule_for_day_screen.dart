import 'package:flutter/material.dart';

import '../../../../../data/models/group_model.dart';
import '../../../../../data/repositories/schedule_manager_repositories.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/show_dialog.dart';
import '../../../widgets/textfield.dart';

class AddScheduleForDayScreen extends StatefulWidget {
  final String groupId;
  final String dayOfWeek;

  AddScheduleForDayScreen({required this.groupId, required this.dayOfWeek});

  @override
  _AddScheduleForDayScreenState createState() =>
      _AddScheduleForDayScreenState();
}

class _AddScheduleForDayScreenState extends State<AddScheduleForDayScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _teacherNameController = TextEditingController();
  final TextEditingController _classroomController = TextEditingController();

  final List<Lesson> _lessons = [];

  void _addLesson() {
    String subject = _subjectController.text;
    String time = _timeController.text;
    String teacherName = _teacherNameController.text;
    String classroom = _classroomController.text;

    if (subject.isNotEmpty &&
        time.isNotEmpty &&
        teacherName.isNotEmpty &&
        classroom.isNotEmpty) {
      Lesson lesson = Lesson(
        subject: subject,
        time: time,
        teacherName: teacherName,
        classroom: classroom,
      );

      setState(() {
        _lessons.add(lesson);
      });

      // Очистка полей ввода после добавления урока
      _subjectController.clear();
      _timeController.clear();
      _teacherNameController.clear();
      _classroomController.clear();
    } else {
      ShowDialog(context, title: '', content: 'Пожалуйста, заполните все поля');
    }
  }

  void _saveSchedule() async {
    if (_lessons.isNotEmpty) {
      await ScheduleManager()
          .addSchedule(widget.groupId, widget.dayOfWeek, _lessons);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Расписание для ${widget.dayOfWeek} добавлено')));

      Navigator.pop(context); // Возврат на предыдущий экран
    } else {
      ShowDialog(context, title: '', content: 'Пожалуйста, добавьте хотя бы один урок');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Расписание для ${widget.dayOfWeek}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            MyTextField(
              controller: _subjectController,
              hintText: 'Название предмета',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.lock),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Название предмета';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _timeController,
              hintText: 'Время урока',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.lock),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Заполните это поле';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _teacherNameController,
              hintText: 'Имя преподавателя',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.lock),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Заполните это поле';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _classroomController,
              hintText: 'Кабинет',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.lock),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Заполните это поле';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            ButtonWidget(text: 'Добавить урок', pressed: _addLesson),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: _lessons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_lessons[index].subject),
                    subtitle: Text(
                        '${_lessons[index].time} - ${_lessons[index].teacherName} (${_lessons[index].classroom})'),
                  );
                },
              ),
            ),
            ButtonWidget(text: 'Сохранить расписание', pressed: _saveSchedule),
          ],
        ),
      ),
    );
  }
}
