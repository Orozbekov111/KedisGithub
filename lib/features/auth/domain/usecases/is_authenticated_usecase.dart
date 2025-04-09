import 'package:kedis/features/auth/domain/repositories/auth_repository.dart';

class IsAuthenticatedUsecase {
  final AuthRepository authRepository;

  IsAuthenticatedUsecase({required this.authRepository});

  Future<bool> execute() async {
    return await authRepository.isAuthenticated();
  }
}
