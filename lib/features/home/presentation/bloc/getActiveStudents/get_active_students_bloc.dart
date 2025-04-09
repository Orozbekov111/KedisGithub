import 'package:bloc/bloc.dart';
import 'package:kedis/features/home/domain/entities/user_entity.dart';
import 'package:kedis/features/home/domain/usecases/get_active_students_usercase.dart';

part 'get_active_students_event.dart';
part 'get_active_students_state.dart';

class GetActiveStudentsBloc
    extends Bloc<GetActiveStudentsEvent, ActiveStudentsState> {
  final GetActiveStudentsUserCase getActiveStudentsUserCase;
  GetActiveStudentsBloc({required this.getActiveStudentsUserCase})
    : super(ActiveStudentsInitialState()) {
    on<LoadActiveStudentsEvent>(_onLoadActiveStudents);
  }

  Future<void> _onLoadActiveStudents(
    LoadActiveStudentsEvent event,
    Emitter<ActiveStudentsState> emit,
  ) async {
    emit(ActiveStudentsLoadingState());
    try {
      final activeStudents = await getActiveStudentsUserCase.execute();
      if (activeStudents.isEmpty) {
        emit(ActiveStudentsEmptyState());
      } else {
        emit(ActiveStudentsLoadedState(activeStudents));
      }
    } catch (e) {
      emit(ActiveStudentsErrorState(e.toString()));
    }
  }
}
