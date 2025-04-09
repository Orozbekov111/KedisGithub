part of 'user_create_bloc.dart';

abstract class UserCreateState {}

class UserCreateInitial extends UserCreateState {}
class UserCreateLoading extends UserCreateState {}
class UserCreateSuccess extends UserCreateState {}
class UserCreateError extends UserCreateState {
  final String error;
  UserCreateError(this.error);
}