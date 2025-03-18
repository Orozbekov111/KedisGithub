import 'package:flutter/material.dart';
import '../../../../../data/models/subjects_model.dart';
import '../../../../../data/repositories/GroupRepository.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/show_dialog.dart';
import '../../../widgets/textfield.dart';
import 'students_screen.dart';

class SubjectCreationScreen extends StatefulWidget {
  final String course;
  final String groupName;

  const SubjectCreationScreen({required this.course, required this.groupName});

  @override
  _SubjectCreationScreenState createState() => _SubjectCreationScreenState();
}

class _SubjectCreationScreenState extends State<SubjectCreationScreen> {
  final GroupRepository _groupRepository = GroupRepository();
  final TextEditingController _subjectNameController = TextEditingController();

  List<SubjectsModel> subjects = [];

  @override
  void initState() {
    super.initState();
    loadSubjects();
  }

  void loadSubjects() async {
    try {
      List<SubjectsModel> loadedSubjects = await _groupRepository
          .getAllSubjectsForCourseAndGroup(widget.course, widget.groupName);

      // Filter out duplicates based on subject name
      Set<String> uniqueSubjectNames = {};
      subjects = loadedSubjects.where((subject) {
        if (!uniqueSubjectNames.contains(subject.subjectName.toLowerCase())) {
          uniqueSubjectNames.add(subject.subjectName.toLowerCase());
          return true; // Keep this subject
        }
        return false; // Skip this subject (duplicate)
      }).toList();

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка при загрузке предметов')));
    }
  }

  bool _isCreatingSubject = false;

  void createSubject() async {
    if (_isCreatingSubject)
      return; // Если уже создается предмет, ничего не делаем
    _isCreatingSubject = true;

    String subjectName = _subjectNameController.text.trim();
    if (subjectName.isEmpty) {
      ShowDialog(context,
          title: '', content: 'Введите название предмета');

      _isCreatingSubject = false;
      return;
    }

    // Проверяем на уникальность названия предмета в рамках курса и группы
    if (subjects.any((subject) =>
        subject.subjectName.toLowerCase() == subjectName.toLowerCase() &&
        subject.course == widget.course)) {
      ShowDialog(context,
          title: '', content: 'Этот предмет уже существует');
      _isCreatingSubject = false;

      return;
    }

    SubjectsModel subject = SubjectsModel(
      course: widget.course,
      group: widget.groupName,
      userId: '', // Замените на реальный userId
      subjectName: subjectName,
      gradesUser: [],
    );

    try {
      await _groupRepository.saveSubject(subject);

      ShowDialog(context, title: 'Успех', content: 'Предмет создан');
    } catch (e) {
      ShowDialog(context,
          title: 'Ошибка', content: 'Ошибка при созданий предмет создан');
    }

    _subjectNameController.clear();
    _isCreatingSubject = false; // Сбрасываем флаг после завершения операции
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBarWidget(
          nameAppBar: 'Предметы',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            MyTextField(
              controller: _subjectNameController,
              hintText: 'Название предмета',
              obscureText: false,
              keyboardType: TextInputType.text,
              prefixIcon: const Icon(Icons.book),
            ),
            const SizedBox(height: 10),
            ButtonWidget(text: 'Создать предмет', pressed: createSubject),
            const SizedBox(height: 20),
            const Text(
              'Выберите предмет',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: subjects.isEmpty
                  ? const Center(child: Text("Нет доступных предметов."))
                  : ListView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        return ButtonWidget(
                          text: '${subjects[index].subjectName}',
                          pressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentsScreen(
                                  subjectName: subjects[index].subjectName,
                                  groupName: widget.groupName,
                                  course: widget.course,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
