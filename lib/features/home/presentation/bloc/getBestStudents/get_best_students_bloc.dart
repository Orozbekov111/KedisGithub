import 'package:bloc/bloc.dart';
import 'package:kedis/features/home/domain/entities/user_entity.dart';
import 'package:kedis/features/home/domain/usecases/get_best_students_usecase.dart';

part 'get_best_students_event.dart';
part 'get_best_students_state.dart';

class GetBestStudentsBloc
    extends Bloc<GetBestStudentsEvent, GetBestStudentsState> {
  GetBestStudentsUsecase getBestStudentsUsecase;

  GetBestStudentsBloc({required this.getBestStudentsUsecase})
    : super(GetBestStudentsInitialState()) {
    on<LoadBestStudentsEvent>(_onLoadBestStudents);
  }

  Future<void> _onLoadBestStudents(
    LoadBestStudentsEvent event,
    Emitter<GetBestStudentsState> emit,
  ) async {
    emit(GetBestStudentsLoadingState());
    try {
      final bestStudents = await getBestStudentsUsecase.execute();
      if (bestStudents.isEmpty) {
        emit(GetBestStudentsEmptyState());
      } else {
        emit(GetBestStudentsLoadedState(bestStudents.cast<UserEntity>()));
      }
    } catch (e) {
      emit(GetBestStudentsErrorState(e.toString()));
    }
  }
}
