// part of 'my_user_bloc.dart';

// // Абстрактный класс событий для управления пользователем
// @immutable
// abstract class MyUserEvent extends Equatable {
//   const MyUserEvent();

//   @override
//   List<Object> get props => [];
// }

// // Событие получения данных пользователя
// class GetMyUser extends MyUserEvent {
//   final String myUserId;

//   const GetMyUser({required this.myUserId});

//   @override
//   List<Object> get props => [myUserId]; // Добавляем myUserId в список свойств для сравнения
// }