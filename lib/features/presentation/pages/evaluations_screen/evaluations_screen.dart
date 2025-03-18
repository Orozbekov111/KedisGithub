import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/models/subjects_model.dart';
import '../widgets/app_bar_widget.dart';

// // Функция для получения UID текущего аутентифицированного пользователя
Future<String?> getCurrentUserUid() async {
  User? firebaseUser =
      FirebaseAuth.instance.currentUser; // Получаем текущего пользователя
  return firebaseUser?.uid; // Возвращаем UID или null
}

class GradesScreen extends StatefulWidget {
  const GradesScreen({Key? key}) : super(key: key);

  @override
  _GradesScreenState createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  String? selectedCourse;
  String? selectedSubject;
  List<SubjectsModel> subjectsList = [];
  List<String> coursesList = [];
  List<String> subjectsNamesList = [];
  List<GradesModel> gradesList = [];
  bool isLoading = false;

  void fetchSubjects() async {
    setState(() {
      isLoading = true;
    });
    try {
      String? uid = await getCurrentUserUid();
      if (uid != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('subjects')
            .where('userId', isEqualTo: uid)
            .get();
        subjectsList = snapshot.docs
            .map((doc) =>
                SubjectsModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        Set<String> coursesSet =
            subjectsList.map((subject) => subject.course).toSet();
        coursesList = coursesSet.toList();
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchSubjectNames(String course) {
    subjectsNamesList.clear();
    List<SubjectsModel> filteredSubjects =
        subjectsList.where((subject) => subject.course == course).toList();
    subjectsNamesList =
        filteredSubjects.map((subject) => subject.subjectName).toList();

    // Reset selectedSubject when course changes
    setState(() {
      selectedSubject = null; // Reset selected subject
    });
  }

  void fetchGrades(String subjectName) {
    gradesList.clear(); // Clear previous grades
    for (var subject in subjectsList) {
      if (subject.subjectName == subjectName) {
        if (subject.gradesUser.isNotEmpty) {
          gradesList.addAll(
              subject.gradesUser); // Add all grades for the selected subject
        }
        break;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBarWidget(
          nameAppBar: 'Оценки',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLoading)
                Center(child: CircularProgressIndicator())
              else ...[
                if (coursesList.isNotEmpty) ...[
                  // Dropdown for Courses
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26, // Shadow color
                          blurRadius: 8.0, // Shadow blur radius
                          offset: Offset(0, 4), // Shadow offset
                        ),
                      ],
                    ),
                    child: DropdownButton<String>(
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('Выберите курс',
                            style: TextStyle(color: Colors.grey)),
                      ),
                      value: selectedCourse,
                      onChanged: (value) {
                        setState(() {
                          selectedCourse = value;
                          fetchSubjectNames(value!);
                          selectedSubject =
                              null; // Reset selected subject when course changes
                        });
                      },
                      items: coursesList.map((course) {
                        return DropdownMenuItem(
                          value: course,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            child: Text(course,
                                style: TextStyle(
                                    fontSize: 16.0)), // Custom text style
                          ),
                        );
                      }).toList(),
                      isExpanded: true, // Make dropdown take full width
                      underline: SizedBox(), // Remove underline
                    ),
                  ),
                ],
                SizedBox(height: 16.0),
                if (subjectsNamesList.isNotEmpty && selectedCourse != null) ...[
                  // Dropdown for Subjects
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26, // Shadow color
                          blurRadius: 8.0, // Shadow blur radius
                          offset: Offset(0, 4), // Shadow offset
                        ),
                      ],
                    ),
                    child: DropdownButton<String>(
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('Выберите предмет',
                            style: TextStyle(color: Colors.grey)),
                      ),
                      value: selectedSubject,
                      onChanged: (value) {
                        setState(() {
                          selectedSubject = value;
                          fetchGrades(value!);
                        });
                      },
                      items: subjectsNamesList.map((subjectName) {
                        return DropdownMenuItem(
                          value: subjectName,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            child: Text(subjectName,
                                style: TextStyle(
                                    fontSize: 16.0)), // Custom text style
                          ),
                        );
                      }).toList(),
                      isExpanded: true, // Make dropdown take full width
                      underline: SizedBox(), // Remove underline
                    ),
                  ),
                ],
              ],
              SizedBox(height: 16.0),
              if (gradesList.isNotEmpty && selectedSubject != null) ...[
                SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: gradesList.length,
                    itemBuilder: (context, index) {
                      GradesModel grade = gradesList[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF00796B),
                              Color(0xFF004D40),
                            ], // Градиентный фон
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Ваши оценки',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Цвет заголовка
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              _evaluationsRow(
                                  'Первый модуль', grade.trk1.toString()),
                              _evaluationsRow(
                                  'Второй модуль', grade.prk1.toString()),
                              _evaluationsRow('Итог. семестра',
                                  grade.trk2.toString()),
                              _evaluationsRow(
                                  'Первый модуль', grade.prk2.toString()),
                              _evaluationsRow(
                                  'Второй модуль', grade.irk.toString()),
                              _evaluationsRow('Итог. семестра',
                                  grade.ird.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  

Widget _evaluationsRow(String modul, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), // Закругленные углы
                            border: Border.all(width: 1.0,color: Colors.white)

              
            ),
            alignment: Alignment.center, // Центрирование текста
            child: Text(
              modul,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Цвет текста
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Container(
            height: 50,
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), // Закругленные углы
              border: Border.all(width: 1.0,color: Colors.white)
            ),
            alignment: Alignment.center, // Центрирование текста
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Цвет текста
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}
