import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/firebase_user_repository.dart';

// События аутентификации
part 'authentication_event.dart';

// Состояния аутентификации
part 'authentication_state.dart';

// Блок аутентификации
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseUserRepository userRepository; // Репозиторий пользователей
  late final StreamSubscription<UserModel?> _userSubscription; // Подписка на изменения пользователя

  // Конструктор блока аутентификации
  AuthenticationBloc({required this.userRepository}) : super(AuthenticationState.unknown()) {
    // Подписка на поток изменений пользователя из репозитория
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user)); // Добавляем событие при изменении пользователя
    });

    // Обработка события изменения пользователя
    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthenticationState.authenticated(event.user!)); // Пользователь аутентифицирован
      } else {
        emit(const AuthenticationState.unauthenticated()); // Пользователь не аутентифицирован
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel(); // Отмена подписки при закрытии блока
    return super.close();
  }
}