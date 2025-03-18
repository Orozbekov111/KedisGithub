part of 'sign_in_bloc.dart';

// Абстрактный класс состояний входа
@immutable
abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

/// Начальное состояние BLoC
class SignInInitial extends SignInState {}

/// Состояние успешного входа
class SignInSuccess extends SignInState {}

/// Состояние неудачного входа
class SignInFailure extends SignInState {
  final String? message; // Сообщение об ошибке

  const SignInFailure({this.message});

  @override
  List<Object> get props => [message ?? '']; // Свойства для сравнения (пустая строка по умолчанию)
}

/// Состояние процесса входа
class SignInProcess extends SignInState {}