part of 'sign_in_bloc.dart';

// Абстрактный класс событий входа
abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

/// Событие для запроса входа
class SignInRequired extends SignInEvent {
  final String email; // Электронная почта пользователя
  final String password; // Пароль пользователя

  const SignInRequired(this.email, this.password);

  @override
  List<Object> get props => [email, password]; // Свойства для сравнения
}

/// Событие для запроса выхода
class SignOutRequired extends SignInEvent {
  const SignOutRequired();
}