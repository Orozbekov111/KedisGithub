part of 'get_best_students_bloc.dart';

abstract class GetBestStudentsState{}

class GetBestStudentsInitialState extends GetBestStudentsState {}

class GetBestStudentsLoadingState extends GetBestStudentsState {}

class GetBestStudentsLoadedState extends GetBestStudentsState {
  final List<UserEntity> bestStudents;

  GetBestStudentsLoadedState(this.bestStudents);
}

class GetBestStudentsEmptyState extends GetBestStudentsState {}

class GetBestStudentsErrorState extends GetBestStudentsState {
  final String message;

  GetBestStudentsErrorState(this.message);
}