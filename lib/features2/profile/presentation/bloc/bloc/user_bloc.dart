import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedis/features2/profile/domain/entities/user_entity.dart';
import 'package:kedis/features2/profile/domain/usecases/change_password_usecase.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';
import 'package:kedis/features2/profile/domain/usecases/sign_out_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;
  final SignOutUseCase signOutUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  UserBloc({
    required this.getUserUseCase,
    required this.signOutUseCase,
    required this.changePasswordUseCase,
  }) : super(UserInitialState()) {
    on<LoadUserEvent>(_onLoadUser);
    on<SignOutEvent>(_onSignOut);
    on<ChangePasswordEvent>(_onChangePassword);
  }

  Future<void> _onLoadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final user = await getUserUseCase.execute(event.userId);
      emit(UserLoadedState(user));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<UserState> emit) async {
    try {
      await signOutUseCase.execute();
      emit(UserSignedOutState());
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> _onChangePassword(ChangePasswordEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      await changePasswordUseCase.execute(event.newPassword, event.currentPassword);
      emit(UserPasswordChangedState(message: 'Пароль успешно изменён'));
    } on FirebaseAuthException catch (e) {
      String message = 'Ошибка изменения пароля';
      if (e.code == 'wrong-password') {
        message = 'Неверный текущий пароль';
      } else if (e.code == 'weak-password') {
        message = 'Пароль должен быть не менее 6 символов';
      }
      emit(UserErrorState(message));
    } catch (e) {
      emit(UserErrorState('Произошла ошибка: ${e.toString()}'));
    }
  }
}