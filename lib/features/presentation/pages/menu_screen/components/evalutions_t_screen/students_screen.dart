

import 'package:flutter/material.dart';

import '../../../../../data/models/user_model.dart';
import '../../../../../data/repositories/firebase_user_repository.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/card_user_widget.dart';
import 'subject_detail_screen.dart';

class StudentsScreen extends StatefulWidget {
  final String groupName; // Название группы
  final String course; // Название курса
  final String subjectName; // Название предмета

  StudentsScreen({
    required this.groupName,
    required this.course,
    required this.subjectName,
  });

  @override
  State<StudentsScreen> createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<StudentsScreen> {
  late FirebaseUserRepository
      firebaseUserRepository; // Репозиторий для работы с пользователями
  List<UserModel> students = []; // Список студентов

  @override
  void initState() {
    super.initState();
    firebaseUserRepository =
        FirebaseUserRepository(); // Инициализация репозитория
    getStudentsByGroup().then((value) {
      setState(() {
        students = value; // Обновляем состояние с полученными студентами
      });
    });
  }

  // Метод для получения студентов по группе
  Future<List<UserModel>> getStudentsByGroup() async {
    try {
      return await firebaseUserRepository
          .getStudentsByGroupRep(widget.groupName);
    } catch (e) {
      throw Exception('Не удалось получить Вашу группу: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Студенты', // Заголовок AppBar
        ),
      ),
      body: students.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Показать индикатор загрузки, если список пустой
          : ListView.builder(
              itemCount: students.length, // Количество студентов в списке
              itemBuilder: (context, index) {
                UserModel student =
                    students[index]; // Получаем студента по индексу
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectDetailScreen(
                          userId: student
                              .id, // Передаем ID студента на экран деталей предмета
                          course: widget.course,
                          groupName: widget.groupName,
                          subjectName: widget.subjectName,
                        ),
                      ),
                    );
                  },
                  child: CardUserWidget(
                    user:
                        student, // Передаем объект студента в карточку пользователя
                    title: student.fullName, // Полное имя студента
                    subtitle: student.group, // Группа студента
                  ),
                );
              },
            ),
    );
  }
}



