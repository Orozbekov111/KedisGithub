part of 'current_user_bloc.dart';

abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}
class CurrentUserLoading extends CurrentUserState {}
class CurrentUserSuccess extends CurrentUserState {
  final MenuUserModel user;
  CurrentUserSuccess(this.user);
}
class CurrentUserError extends CurrentUserState {
  final String error;
  CurrentUserError(this.error);
}