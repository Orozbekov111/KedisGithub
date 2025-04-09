import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features/auth/domain/entities/user_entity.dart';
import 'package:kedis/features/auth/domain/usecases/is_authenticated_usecase.dart';
import 'package:kedis/features/auth/domain/usecases/login_usecase.dart';
import 'package:kedis/features/auth/presentation/bloc/auth_event.dart';
import 'package:kedis/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  final IsAuthenticatedUsecase isAuthenticatedUsecase;

  AuthBloc({required this.loginUseCase, required this.isAuthenticatedUsecase})
    : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);

    on<CheckAuthEvent>(_onCheckAuthEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(event.email, event.password);
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: 'Неправильно введенные данные'));
    }
  }

  Future<void> _onCheckAuthEvent(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    final isAuthenticated = await isAuthenticatedUsecase.execute();
    if (isAuthenticated) {
      final user = UserEntity(
        id: FirebaseAuth.instance.currentUser!.uid,
        email: FirebaseAuth.instance.currentUser!.email ?? '',
        // fullName: FirebaseAuth.instance.currentUser!.displayName ?? 'Unknown',
      );
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
