import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features2/auth/domain/entities/user_entity.dart';
import 'package:kedis/features2/auth/domain/repositories/auth_repository.dart';
import 'package:kedis/features2/auth/domain/usecases/login_usecase.dart';
import 'package:kedis/features2/auth/domain/usecases/logout_usecase.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_event.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<CheckAuthEvent>(_onCheckAuthEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(event.email, event.password);
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: 'Неправильно введенные данные'));
    }
  }

  Future<void> _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    await logoutUseCase();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckAuthEvent(CheckAuthEvent event, Emitter<AuthState> emit) async {
    final isAuthenticated = await authRepository.isAuthenticated();
    if (isAuthenticated) {
      final user = UserEntity(
        id: FirebaseAuth.instance.currentUser!.uid,
        email: FirebaseAuth.instance.currentUser!.email ?? '',
        fullName: FirebaseAuth.instance.currentUser!.displayName ?? 'Unknown',
      );
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}