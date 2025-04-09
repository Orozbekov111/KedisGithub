part of 'user_create_bloc.dart';

abstract class UserCreateEvent {}

class CreateUserEvent extends UserCreateEvent {
  final MenuUserModel user;
  CreateUserEvent(this.user);
}