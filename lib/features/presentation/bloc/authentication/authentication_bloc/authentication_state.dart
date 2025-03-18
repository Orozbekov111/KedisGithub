part of 'authentication_bloc.dart';

// Статус аутентификации
enum AuthenticationStatus { authenticated, unauthenticated, unknown }

// Состояние аутентификации
class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel? user; // Изменяем тип на UserModel?

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(UserModel user)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
        );

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user]; // Добавляем статус и пользователя в список свойств для сравнения
}