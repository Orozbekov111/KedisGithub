import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features2/menu/create_a_schedule/presentation/bloc/schedulle/schedule_bloc.dart';

class SaveScheduleButton extends StatelessWidget {
  final String groupId;
  final String dayOfWeek;

  const SaveScheduleButton({
    Key? key,
    required this.groupId,
    required this.dayOfWeek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateScheduleBloc, CreateScheduleState>(
      listener: (context, state) {
        if (state is ScheduleSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<CreateScheduleBloc>().add(
              SaveScheduleEvent(groupId, dayOfWeek),
            );
          },
          child: const Text('Save Schedule'),
        );
      },
    );
  }
}
