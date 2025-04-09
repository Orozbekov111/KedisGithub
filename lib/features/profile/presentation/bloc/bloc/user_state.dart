part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserEntity user;

  UserLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}



class UserSignedOutState extends UserState {}


class UserPasswordChangedState extends UserState {
  final String message;
  UserPasswordChangedState({required this.message});
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}