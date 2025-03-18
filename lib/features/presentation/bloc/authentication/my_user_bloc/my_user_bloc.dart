// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:kedisss/features/data/repositories/firebase_user_repository.dart';
// import 'package:meta/meta.dart';

// import '../../../../data/models/user_model.dart';

// // События для MyUserBloc
// part 'my_user_event.dart';

// // Состояния для MyUserBloc
// part 'my_user_state.dart';

// // Блок для управления состоянием пользователя
// class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
//   final FirebaseUserRepository _userRepository; // Репозиторий пользователей

//   // Конструктор MyUserBloc
//   MyUserBloc({required FirebaseUserRepository myUserRepository})
//       : _userRepository = myUserRepository,
//         super(const MyUserState.loading()) {
//     // Обработка события получения пользователя
//     on<GetMyUser>((event, emit) async {
//       emit(const MyUserState.loading()); // Устанавливаем состояние загрузки
//       try {
//         // Получаем пользователя из репозитория
//         UserModel myUser = await _userRepository.getMyUser(event.myUserId);
//         emit(MyUserState.success(myUser)); // Успешное получение пользователя
//       } catch (e) {
//         log('Ошибка при получении пользователя: ${e.toString()}');
//         emit(const MyUserState.failure()); // Ошибка при получении пользователя
//       }
//     });
//   }
// }