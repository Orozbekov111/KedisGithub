part of 'get_users_by_group_bloc.dart';

abstract class GroupUsersState {}

class GroupUsersInitialState extends GroupUsersState {}

class GroupUsersLoadingState extends GroupUsersState {}

class GroupUsersLoadedState extends GroupUsersState {
  final List<UserEntity> users;
  final String groupName;

  GroupUsersLoadedState({required this.users, required this.groupName});
}

class GroupUsersErrorState extends GroupUsersState {
  final String message;

  GroupUsersErrorState(this.message);
}
