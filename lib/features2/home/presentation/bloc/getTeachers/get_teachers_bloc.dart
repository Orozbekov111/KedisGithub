import 'package:bloc/bloc.dart';
import 'package:kedis/features2/home/domain/entities/user_entity.dart';
import 'package:kedis/features2/home/domain/usecases/get_teachers_usecase.dart';

part 'get_teachers_event.dart';
part 'get_teachers_state.dart';


class TeachersBloc extends Bloc<TeachersEvent, TeachersState> {
  final GetTeachersUseCase getTeachersUseCase;

  TeachersBloc({required this.getTeachersUseCase}) : super(TeachersInitialState()) {
    on<LoadTeachersEvent>(_onLoadTeachers);
  }

  Future<void> _onLoadTeachers(
    LoadTeachersEvent event,
    Emitter<TeachersState> emit,
  ) async {
    emit(TeachersLoadingState());
    try {
      final teachers = await getTeachersUseCase.execute();
      if (teachers.isEmpty) {
        emit(TeachersEmptyState());
      } else {
        emit(TeachersLoadedState(teachers));
      }
    } catch (e) {
      emit(TeachersErrorState(e.toString()));
    }
  }
}