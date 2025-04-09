import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kedis/features/menu/create_a_schedule/domain/usecases/create_group_usecase.dart';

part 'group_event.dart';
part 'group_state.dart';

class CreateGroupBloc extends Bloc<GroupEvent, GroupState> {
  final CreateGroupUsecase createGroup;

  CreateGroupBloc({required this.createGroup}) : super(GroupInitial()) {
    on<CreateGroupEvent>(_onCreateGroup);
  }

  Future<void> _onCreateGroup(
    CreateGroupEvent event,
    Emitter<GroupState> emit,
  ) async {
    emit(GroupLoading());
    try {
      final groupId = DateTime.now().millisecondsSinceEpoch.toString();
      await createGroup(groupId, event.groupName);
      emit(GroupCreated(groupId));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }
}
