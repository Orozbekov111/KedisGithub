import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kedis/features2/home/domain/entities/user_entity.dart';
import 'package:kedis/features2/home/domain/usecases/get_current_user_usecase.dart';
import 'package:kedis/features2/home/domain/usecases/get_users_by_group_usecase.dart';

part 'get_users_by_group_event.dart';
part 'get_users_by_group_state.dart';

class GroupUsersBloc extends Bloc<GroupUsersEvent, GroupUsersState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetUsersByGroupUseCase getUsersByGroupUseCase;
  String? currentUserGroup;

  GroupUsersBloc({
    required this.getCurrentUserUseCase,
    required this.getUsersByGroupUseCase,
  }) : super(GroupUsersInitialState()) {
    on<LoadGroupUsersEvent>(_onLoadGroupUsers);
    add(LoadGroupUsersEvent());
  }

  Future<void> _onLoadGroupUsers(
    LoadGroupUsersEvent event,
    Emitter<GroupUsersState> emit,
  ) async {
    emit(GroupUsersLoadingState());
    try {
      final currentUser = await getCurrentUserUseCase.execute();
      currentUserGroup = currentUser.group;

      final allUsers = await getUsersByGroupUseCase.execute(currentUser.group);

      // Фильтруем только пользователей из той же группы
      final sameGroupUsers =
          allUsers.where((user) => user.group == currentUserGroup).toList();

      emit(
        GroupUsersLoadedState(
          users: sameGroupUsers,
          groupName: currentUser.group,
        ),
      );
    } catch (e) {
      emit(GroupUsersErrorState(e.toString()));
    }
  }
}
