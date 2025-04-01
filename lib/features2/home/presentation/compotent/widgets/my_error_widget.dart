import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getTeachers/get_teachers_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getUserByGroup/get_users_by_group_bloc.dart';

class MyErrorWidget extends StatelessWidget {
  final String message;

  const MyErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            'Ошибка: $message',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (context.read<GroupUsersBloc>().state is GroupUsersErrorState) {
                context.read<GroupUsersBloc>().add(LoadGroupUsersEvent());
              } else if (context.read<TeachersBloc>().state is TeachersErrorState) {
                context.read<TeachersBloc>().add(LoadTeachersEvent());
              }
            },
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}



