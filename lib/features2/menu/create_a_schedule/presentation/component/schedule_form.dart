import 'package:flutter/material.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/entities/lesson_entity.dart';

class ScheduleForm extends StatefulWidget {
  final Function(lessonEntity) onLessonAdded;

  const ScheduleForm({Key? key, required this.onLessonAdded}) : super(key: key);

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _timeController = TextEditingController();
  final _teacherController = TextEditingController();
  final _classroomController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _timeController.dispose();
    _teacherController.dispose();
    _classroomController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final lesson = lessonEntity(
        subject: _subjectController.text,
        time: _timeController.text,
        teacherName: _teacherController.text,
        classroom: _classroomController.text,
      );

      widget.onLessonAdded(lesson);

      _subjectController.clear();
      _timeController.clear();
      _teacherController.clear();
      _classroomController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _subjectController,
            decoration: const InputDecoration(labelText: 'Subject'),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter subject' : null,
          ),
          TextFormField(
            controller: _timeController,
            decoration: const InputDecoration(labelText: 'Time'),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter time' : null,
          ),
          TextFormField(
            controller: _teacherController,
            decoration: const InputDecoration(labelText: 'Teacher'),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter teacher' : null,
          ),
          TextFormField(
            controller: _classroomController,
            decoration: const InputDecoration(labelText: 'Classroom'),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter classroom' : null,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Add Lesson'),
          ),
        ],
      ),
    );
  }
}