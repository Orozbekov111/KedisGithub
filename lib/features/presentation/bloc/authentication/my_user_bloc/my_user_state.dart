// part of 'my_user_bloc.dart';

// // Статус состояния пользователя
// enum MyUserStatus { success, loading, failure }

// // Состояние для управления пользователем
// class MyUserState extends Equatable {
//   final MyUserStatus status; // Текущий статус состояния
//   final UserModel? user; // Данные пользователя

//   const MyUserState._({
//     this.status = MyUserStatus.loading,
//     this.user,
//   });

//   const MyUserState.loading() : this._(); // Состояние загрузки

//   const MyUserState.success(UserModel user) 
//       : this._(status: MyUserStatus.success, user: user); // Успешное состояние с данными пользователя

//   const MyUserState.failure() : this._(status: MyUserStatus.failure); // Ошибка состояния

//   @override
//   List<Object?> get props => [status, user]; // Добавляем статус и пользователя в список свойств для сравнения
// }