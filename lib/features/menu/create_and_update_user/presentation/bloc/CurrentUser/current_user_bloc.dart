import 'package:bloc/bloc.dart';
import 'package:kedis/features/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/usecases/menu_get_current_user_usecase.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final MenuGetCurrentUserUsecase getCurrentUser;

  CurrentUserBloc({required this.getCurrentUser}) : super(CurrentUserInitial()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  Future<void> _onGetCurrentUser(
    GetCurrentUserEvent event,
    Emitter<CurrentUserState> emit,
  ) async {
    emit(CurrentUserLoading());
    try {
      final user = await getCurrentUser();
      emit(CurrentUserSuccess(user));
    } catch (e) {
      emit(CurrentUserError('Ошибка загрузки пользователя: ${e.toString()}'));
    }
  }
}