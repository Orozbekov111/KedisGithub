import 'package:flutter/material.dart';
import '../../../data/models/group_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/firebase_user_repository.dart';
import '../../../data/repositories/schedule_manager_repositories.dart';

import '../widgets/app_bar_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late ScheduleManager scheduleManager;
  List<ScheduleModel> schedules = [];
  bool isLoading = true;
  late TabController _tabController;
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    scheduleManager = ScheduleManager();
    _tabController = TabController(length: 7, vsync: this);
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    try {
      currentUser = await FirebaseUserRepository().user.first;
      if (currentUser != null) {
        await _loadSchedules();
      } else {
        _showSnackBar('Пожалуйста, войдите в систему');
      }
    } catch (e) {
      _showSnackBar('Ошибка при загрузке пользователя: $e');
    }
  }

  Future<void> _loadSchedules() async {
    try {
      schedules =
          await scheduleManager.getScheduleByGroupName(currentUser!.group);
    } catch (e) {
      _showSnackBar('Ошибка при загрузке расписания: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Расписание',
        ),
      ),
      body: Column(
        children: [
          // Place the TabBar separately from the AppBar
          Container(
            color: Colors.white,
            child: TabBar(
              labelStyle: const TextStyle(fontSize: 16),
              labelColor: Colors.green,
              indicatorColor: Colors.green,
              controller: _tabController,
              tabs: List.generate(7, (index) => Tab(text: _getDayName(index))),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: List.generate(
                        7, (index) => _buildScheduleForDay(index)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleForDay(int dayIndex) {
    final daySchedules = schedules
        .where((schedule) => schedule.dayOfWeek == _getDayName(dayIndex))
        .toList();

    if (daySchedules.isEmpty) {
      return const Center(
          child:
              Text('Нет занятий на этот день', style: TextStyle(fontSize: 18)));
    }

    return ListView.builder(
      itemCount: daySchedules.length,
      itemBuilder: (context, index) => _buildScheduleCard(daySchedules[index]),
    );
  }

  Widget _buildScheduleCard(ScheduleModel schedule) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(schedule.dayOfWeek,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 45,color: Color.fromARGB(255, 2, 106, 88))),
            ),
            const SizedBox(height: 10),
            ...schedule.lessons
                .map((lesson) => _buildLessonTile(lesson))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonTile(Lesson lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00796B), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.8), blurRadius: 5)
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: const Icon(Icons.book, color: Colors.white),
        title: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Выравнивание по левому краю
          children: [
            Text(' ${lesson.subject}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Выравнивание по левому краю
          children: [
            const SizedBox(height: 10,),
            Text('  Учитель: ${lesson.teacherName}',
                style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w600, fontSize: 14)),
            Text('  Время: ${lesson.time}', style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w600, fontSize: 14)),
            Text('  Аудитория: ${lesson.classroom}',
                style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  String _getDayName(int index) {
    const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days[index];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}