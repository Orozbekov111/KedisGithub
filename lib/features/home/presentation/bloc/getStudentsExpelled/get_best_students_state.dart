part of 'get_best_students_bloc.dart';

abstract class GetStudentsExpelledState {}

class GetStudentsExpelledInitialState extends GetStudentsExpelledState {}

class GetStudentsExpelledLoadingState extends GetStudentsExpelledState {}

class GetStudentsExpelledLoadedState extends GetStudentsExpelledState {
  final List<UserEntity> studentsExpelled;

  GetStudentsExpelledLoadedState(this.studentsExpelled);
}

class GetStudentsExpelledEmptyState extends GetStudentsExpelledState {}

class GetStudentsExpelledErrorState extends GetStudentsExpelledState {
  final String message;

  GetStudentsExpelledErrorState(this.message);
}
