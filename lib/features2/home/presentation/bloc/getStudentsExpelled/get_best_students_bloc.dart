import 'package:bloc/bloc.dart';
import 'package:kedis/features2/home/domain/entities/user_entity.dart';
import 'package:kedis/features2/home/domain/usecases/get_student_expelled_usecase.dart';

part 'get_best_students_event.dart';
part 'get_best_students_state.dart';

class GetStudentsExpelledBloc
    extends Bloc<GetStudentsExpelledEvent, GetStudentsExpelledState> {
  GetStudentsExpelledUsecase getStudentsExpelledUsecase;

  GetStudentsExpelledBloc({required this.getStudentsExpelledUsecase})
    : super(GetStudentsExpelledInitialState()) {
    on<LoadStudentsExpelledEvent>(_onLoadBestStudents);
  }

  Future<void> _onLoadBestStudents(
    LoadStudentsExpelledEvent event,
    Emitter<GetStudentsExpelledState> emit,
  ) async {
    emit(GetStudentsExpelledLoadingState());
    try {
      final studentExpelled = await getStudentsExpelledUsecase.execute();
      if (studentExpelled.isEmpty) {
        emit(GetStudentsExpelledEmptyState());
      } else {
        emit(
          GetStudentsExpelledLoadedState(studentExpelled.cast<UserEntity>()),
        );
      }
    } catch (e) {
      emit(GetStudentsExpelledErrorState(e.toString()));
    }
  }
}
