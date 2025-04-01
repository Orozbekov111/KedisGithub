// user_management_event.dart
part of 'user_management_block.dart';

abstract class UserManagementEvent {}

class LoadUsersEvent extends UserManagementEvent {}

class UpdateUserEvent extends UserManagementEvent {
  final MenuUserModel user;

  UpdateUserEvent(this.user);
}

class DeleteUserEvent extends UserManagementEvent {
  final String userId;

  DeleteUserEvent(this.userId);
}