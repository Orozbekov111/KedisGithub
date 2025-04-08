part of 'get_teachers_bloc.dart';

abstract class TeachersState {}

class TeachersInitialState extends TeachersState {}

class TeachersLoadingState extends TeachersState {}

class TeachersLoadedState extends TeachersState {
  final List<UserEntity> teachers;
  TeachersLoadedState(this.teachers);
}

class TeachersEmptyState extends TeachersState {}

class TeachersErrorState extends TeachersState {
  final String message;
  TeachersErrorState(this.message);
}
