part of 'authentication_bloc.dart';

// Абстрактный класс событий аутентификации
@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Событие изменения пользователя
class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final UserModel? user; // Изменяем тип на UserModel?

  @override
  List<Object> get props => [user ?? UserModel(email: '', password: '', id: '', fullName: '', emailUser: '', group: '', profession: '', phone: '', specialty: '', role: '', code: '')]; 
}