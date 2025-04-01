import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features2/time/domain/entities/view_schedule_entity.dart';
import 'package:kedis/features2/time/domain/entities/view_user_entity.dart';
import 'package:kedis/features2/time/presentation/bloc/bloc/view_schedule_bloc.dart';
import 'package:kedis/features2/time/presentation/bloc/bloc/view_schedule_event.dart';
import 'package:kedis/features2/time/presentation/bloc/bloc/view_schedule_state.dart';

@RoutePage()
class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: TextButton(onPressed: () =>Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const SchedulePage(),
    ),
  ), child: Text('data')),);
  }
}

class ScheduleDayView extends StatelessWidget {
  final DaySchedule daySchedule;

  const ScheduleDayView({
    Key? key,
    required this.daySchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (daySchedule.lessons.isEmpty) {
      return const Center(
        child: Text(
          'Нет занятий',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: daySchedule.lessons.length,
      itemBuilder: (context, index) {
        final lesson = daySchedule.lessons[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.subject,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Время: ${lesson.time}'),
                Text('Преподаватель: ${lesson.teacher}'),
                Text('Аудитория: ${lesson.classroom}'),
              ],
            ),
          ),
        );
      },
    );
  }
}



class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расписание'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<ViewScheduleBloc>().add(ViewLoadScheduleEvent()),
          ),
        ],
      ),
      body: BlocBuilder<ViewScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserHasNoGroup) {
            return const Center(child: Text('Вы не состоите в группе'));
          } else if (state is ScheduleLoaded) {
            return ScheduleView(
              user: state.user,
              schedule: state.schedule,
            );
          } else if (state is ScheduleError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Загрузите расписание'));
        },
      ),
    );
  }
}

class ScheduleView extends StatefulWidget {
  final AppUser user;
  final Schedule schedule;

  const ScheduleView({
    Key? key,
    required this.user,
    required this.schedule,
  }) : super(key: key);

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];
  final List<String> _shortDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildGroupHeader(),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _shortDays.map((day) => Tab(text: day)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _days.map((fullDay) {
              // Try different variations of day names
              final dayKey = fullDay.toLowerCase();
              final daySchedule = widget.schedule.days[dayKey] ?? 
                                widget.schedule.days[dayKey.substring(0, 3)] ??
                                DaySchedule(dayName: fullDay, lessons: []);

              return ScheduleDayView(daySchedule: daySchedule);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Группа: ${widget.schedule.groupName}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Роль: ${widget.user.role}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}