import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/features/time/domain/entities/view_lesson_entity.dart';
import 'package:kedis/features/time/domain/usecases/get_schedule_usecase.dart';
import 'package:kedis/features/time/presentation/bloc/view_schedule_bloc.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _days.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getDayName(int index) {
    const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days[index];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ViewScheduleBloc(getScheduleUsecase: context.read<GetScheduleUsecase>())
                ..add(ViewLoadScheduleEvent()),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: MyAppBarWidget(nameAppBar: 'Расписание'),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                labelStyle: const TextStyle(fontSize: 16),
                labelColor: Colors.green,
                indicatorColor: Colors.green,
                controller: _tabController,
                tabs: List.generate(
                  7,
                  (index) => Tab(text: _getDayName(index)),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ViewScheduleBloc, ViewScheduleState>(
                builder: (context, state) {
                  if (state is ViewScheduleInitial ||
                      state is VievScheduleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ViewScheduleError) {
                    return Center(child: Text(state.message));
                  } else if (state is ViewScheduleLoaded) {
                    return TabBarView(
                      controller: _tabController,
                      children:
                          _days
                              .map(
                                (day) => _buildDaySchedule(
                                  day,
                                  state.schedule.dayLessons[day] ?? [],
                                ),
                              )
                              .toList(),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySchedule(String day, List<ViewLessonEntity> lessons) {
    if (lessons.isEmpty) {
      return const Center(
        child: Text('Нет занятий на этот день', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: lessons.length,
      itemBuilder: (context, index) => _buildLessonCard(lessons[index]),
    );
  }

  Widget _buildLessonCard(ViewLessonEntity lesson) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const SizedBox(height: 10), _buildLessonTile(lesson)],
        ),
      ),
    );
  }

  Widget _buildLessonTile(ViewLessonEntity lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00796B), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.8), blurRadius: 5),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: const Icon(Icons.book, color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' ${lesson.subject}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              '  Учитель: ${lesson.teacherName}',
              style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Text(
              '  Время: ${lesson.time}',
              style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Text(
              '  Аудитория: ${lesson.classroom}',
              style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
