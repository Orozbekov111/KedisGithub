import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/usecases/add_schedule_usecase.dart';
import 'package:kedis/features2/menu/create_a_schedule/presentation/bloc/schedulle/schedule_bloc.dart';
import 'package:kedis/features2/menu/create_a_schedule/presentation/component/lesson_list.dart';
import 'package:kedis/features2/menu/create_a_schedule/presentation/component/save_schedule_button.dart';
import 'package:kedis/features2/menu/create_a_schedule/presentation/component/schedule_form.dart';

class AddSchedulePage extends StatelessWidget {
  final String groupId;
  final String dayOfWeek;

  const AddSchedulePage({
    Key? key,
    required this.groupId,
    required this.dayOfWeek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => CreateScheduleBloc(
            addSchedule: context.read<AddScheduleUsecase>(),
            groupId: groupId,
            dayOfWeek: dayOfWeek,
          ),
      child: Scaffold(
        appBar: AppBar(title: Text('Schedule for $dayOfWeek')),
        body: const _AddSchedulePageContent(),
      ),
    );
  }
}

class _AddSchedulePageContent extends StatelessWidget {
  const _AddSchedulePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateScheduleBloc>().state;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ScheduleForm(
            onLessonAdded: (lesson) {
              context.read<CreateScheduleBloc>().add(AddLessonEvent(lesson));
            },
          ),
          const SizedBox(height: 20),
          Expanded(child: LessonList(lessons: state.lessons)),
          SaveScheduleButton(
            groupId: state.groupId,
            dayOfWeek: state.dayOfWeek,
          ),
        ],
      ),
    );
  }
}
