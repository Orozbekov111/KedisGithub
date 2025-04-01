import 'package:bloc/bloc.dart';
import 'package:kedis/features2/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_create_user_usecase.dart';

part 'user_create_event.dart';
part 'user_create_state.dart';

class UserCreateBloc extends Bloc<UserCreateEvent, UserCreateState> {
  final MenuCreateUserUsecase createUser;

  UserCreateBloc({required this.createUser}) : super(UserCreateInitial()) {
    on<CreateUserEvent>(_onCreateUser);
  }

  Future<void> _onCreateUser(
    CreateUserEvent event,
    Emitter<UserCreateState> emit,
  ) async {
    emit(UserCreateLoading());
    try {
      await createUser(event.user);
      emit(UserCreateSuccess());
    } catch (e) {
      emit(UserCreateError('Ошибка создания пользователя: ${e.toString()}'));
    }
  }
}