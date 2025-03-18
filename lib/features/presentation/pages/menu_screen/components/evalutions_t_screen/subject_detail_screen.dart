import 'package:flutter/material.dart';
import '../../../../../data/models/subjects_model.dart';
import '../../../../../data/repositories/GroupRepository.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/show_dialog.dart';
import '../../../widgets/textfield.dart';

class SubjectDetailScreen extends StatefulWidget {
  final String userId;
  final String course;
  final String groupName;
  final String subjectName;

  const SubjectDetailScreen(
      {required this.userId,
      required this.course,
      required this.groupName,
      required this.subjectName});

  @override
  _SubjectDetailScreenState createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  // Controllers for grade inputs
  final GroupRepository _groupRepository = GroupRepository();
  final TextEditingController _trk1Controller = TextEditingController();
  final TextEditingController _trk2Controller = TextEditingController();
  final TextEditingController _prk1Controller = TextEditingController();
  final TextEditingController _prk2Controller = TextEditingController();
  final TextEditingController _irkController = TextEditingController();
  final TextEditingController _irdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadGrades(); // Загружаем оценки при инициализации
  }

  void loadGrades() async {
    try {
      SubjectsModel? subject = await _groupRepository.getSubjects(
          widget.userId, widget.course, widget.subjectName);
      if (subject != null && subject.gradesUser.isNotEmpty) {
        // Заполняем контроллеры значениями из базы данных
        _trk1Controller.text = subject.gradesUser[0].trk1.toString();
        _trk2Controller.text = subject.gradesUser[0].trk2.toString();
        _prk1Controller.text = subject.gradesUser[0].prk1.toString();
        _prk2Controller.text = subject.gradesUser[0].prk2.toString();
        _irkController.text = subject.gradesUser[0].irk.toString();
        _irdController.text = subject.gradesUser[0].ird.toString();
      } else {
        // Если нет оценок, оставляем поля пустыми
        _trk1Controller.clear();
        _trk2Controller.clear();
        _prk1Controller.clear();
        _prk2Controller.clear();
        _irkController.clear();
        _irdController.clear();
      }
    } catch (e) {
      ShowDialog(context, title: '', content: 'Ошибка при загрузке оценок');
    }
  }

  void saveGrades() async {
    // Собираем ввод из текстовых полей
    if (_trk1Controller.text.isEmpty ||
        _trk2Controller.text.isEmpty ||
        _prk1Controller.text.isEmpty ||
        _prk2Controller.text.isEmpty ||
        _irkController.text.isEmpty ||
        _irdController.text.isEmpty) {
      ShowDialog(context, title: '', content: 'Пожалуйста, заполните все поля если оценок нет поставьте 0(ноль)');

      return;
    }

    GradesModel grades = GradesModel(
      trk1: int.tryParse(_trk1Controller.text) ?? 0,
      trk2: int.tryParse(_trk2Controller.text) ?? 0,
      prk1: int.tryParse(_prk1Controller.text) ?? 0,
      prk2: int.tryParse(_prk2Controller.text) ?? 0,
      irk: int.tryParse(_irkController.text) ?? 0,
      ird: int.tryParse(_irdController.text) ?? 0,
    );

    try {
      await _groupRepository.saveGrades(widget.userId, grades, widget.course,
          widget.groupName, widget.subjectName);
      ShowDialog(context, title: '', content: 'Оценки сохранены!');

      // Перезагружаем оценки после сохранения
      loadGrades();
    } catch (e) {
          ShowDialog(context, title: '', content: 'Ошибка при сохранении оценок');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Поставьте оценки', // Заголовок AppBar
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildInfoRow('Предмет:', '${widget.subjectName}'),
              const SizedBox(height: 10),
              _buildInfoRow('Курс:', '${widget.course}'),
              const SizedBox(height: 10),
              _buildInfoRow('Группа:', '${widget.groupName}'),
              const SizedBox(height: 30),

              // Input fields for grades
              MyTextField(
                controller: _trk1Controller,
                hintText: '1 сем. 1 модуль',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.event_available_outlined),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _prk1Controller,
                hintText: '1 сем. 2 модуль',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.event_available_outlined),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _trk2Controller,
                hintText: '1 сем. Итоговый',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.event_available_outlined),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _prk2Controller,
                hintText: '2 сем. 1 модуль',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.event_available_outlined),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _irkController,
                hintText: '2 сем. 2 модуль',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.event_available_outlined),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _irdController,
                hintText: '2 сем. Итоговый',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.event_available_outlined),
              ),

              const SizedBox(height: 20),

              ButtonWidget(text: 'Сохранить оценки', pressed: saveGrades),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8, horizontal: 10), // Vertical spacing between rows
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Flexible(
            child: Text(value,
                style: const TextStyle(color: Colors.black54, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
