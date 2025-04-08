part of 'get_active_students_bloc.dart';

abstract class ActiveStudentsState {}

class ActiveStudentsInitialState extends ActiveStudentsState {}

class ActiveStudentsLoadingState extends ActiveStudentsState {}

class ActiveStudentsLoadedState extends ActiveStudentsState {
  final List<UserEntity> activeStudents;
  ActiveStudentsLoadedState(this.activeStudents);
}

class ActiveStudentsEmptyState extends ActiveStudentsState {}

class ActiveStudentsErrorState extends ActiveStudentsState {
  final String message;

  ActiveStudentsErrorState(this.message);
}
