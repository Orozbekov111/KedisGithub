import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/firebase_user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

/// BLoC для управления состоянием регистрации пользователя
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseUserRepository _userRepository; // Репозиторий пользователей

  SignUpBloc({required FirebaseUserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    // Обрабатываем событие регистрации
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess()); // Устанавливаем состояние процесса регистрации
      try {
        // Валидация данных
        if (event.user.email.isEmpty || event.password.isEmpty) {
          emit(SignUpFailure(message: 'Email и пароль не могут быть пустыми'));
          return;
        }

        // Регистрация нового пользователя
        UserModel user = await _userRepository.signUp(event.user, event.password);
        
        // Сохранение данных пользователя в Firestore
        await _userRepository.setUserData(user);
        
        emit(SignUpSuccess()); // Успешная регистрация
      } catch (e) {
        emit(SignUpFailure(message: e.toString())); // Ошибка регистрации
      }
    });
  }
}