
// Состояния регистрации
part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

/// Начальное состояние BLoC
class SignUpInitial extends SignUpState {}

/// Состояние успешной регистрации
class SignUpSuccess extends SignUpState {}

/// Состояние неудачной регистрации
class SignUpFailure extends SignUpState {
  final String? message; // Сообщение об ошибке

  const SignUpFailure({this.message});

  @override
  List<Object> get props => [message ?? '']; // Свойства для сравнения (пустая строка по умолчанию)
}

/// Состояние процесса регистрации
class SignUpProcess extends SignUpState {}