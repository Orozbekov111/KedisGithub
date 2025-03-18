import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../data/repositories/firebase_user_repository.dart';

// Определяем события для аутентификации
part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// BLoC для управления состоянием входа пользователя
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseUserRepository _userRepository; // Репозиторий пользователей

  SignInBloc({required FirebaseUserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    // Обрабатываем событие входа
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess()); // Устанавливаем состояние процесса входа
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess()); // Успешный вход
      } catch (e) {
        log('Ошибка при входе: ${e.toString()}');
        emit(SignInFailure(message: e.toString())); // Ошибка входа
      }
    });

    // Обрабатываем событие выхода
    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
      emit(SignInInitial()); // Возвращаемся к начальному состоянию после выхода
    });
  }
}