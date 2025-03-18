
// События регистрации
part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

/// Событие для запроса регистрации
class SignUpRequired extends SignUpEvent {
  final UserModel user; // Изменяем тип на UserModel
  final String password; // Пароль пользователя

  const SignUpRequired(this.user, this.password);

  @override
  List<Object> get props => [user, password]; // Свойства для сравнения
}
