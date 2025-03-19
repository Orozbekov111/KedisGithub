import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kedis/features2/profile/domain/entities/user_entity.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

// BLoC для управления состоянием пользователя
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;

  UserBloc(this.getUserUseCase) : super(UserInitialState()) {
    on<LoadUserEvent>(_onLoadUser);
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

}