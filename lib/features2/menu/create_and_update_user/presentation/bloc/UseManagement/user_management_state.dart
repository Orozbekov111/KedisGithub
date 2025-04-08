// user_management_state.dart
part of 'user_management_block.dart';

abstract class UserManagementState {}

class UserManagementInitial extends UserManagementState {}

class UserManagementLoading extends UserManagementState {}

class UserManagementLoaded extends UserManagementState {
  final List<MenuUserModel> users;

  UserManagementLoaded({required this.users});
}

class UserManagementError extends UserManagementState {
  final String message;

  UserManagementError({required this.message});
}



