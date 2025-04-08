// user_management_block.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features2/menu/create_and_update_user/data/models/menu_user_model.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_get_all_users_usecase.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_update_user_usecase.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_delete_user_usecase.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

class UserManagementBloc extends Bloc<UserManagementEvent, UserManagementState> {
  final MenuGetAllUsersUsecase _getAllUsers;
  final MenuUpdateUserUsecase _updateUser;
  final MenuDeleteUserUsecase _deleteUser;

  UserManagementBloc({
    required MenuGetAllUsersUsecase getAllUsers,
    required MenuUpdateUserUsecase updateUser,
    required MenuDeleteUserUsecase deleteUser,
  })  : _getAllUsers = getAllUsers,
        _updateUser = updateUser,
        _deleteUser = deleteUser,
        super(UserManagementInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<UpdateUserEvent>(_onUpdateUser);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  Future<void> _onLoadUsers(
    LoadUsersEvent event,
    Emitter<UserManagementState> emit,
  ) async {
    emit(UserManagementLoading());
    try {
      final users = await _getAllUsers();
      emit(UserManagementLoaded(users: users));
    } catch (e) {
      emit(UserManagementError(message: e.toString()));
    }
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<UserManagementState> emit,
  ) async {
    emit(UserManagementLoading());
    try {
      await _updateUser(event.user);
      final users = await _getAllUsers();
      emit(UserManagementLoaded(users: users));
    } catch (e) {
      emit(UserManagementError(message: e.toString()));
    }
  }

  Future<void> _onDeleteUser(
    DeleteUserEvent event,
    Emitter<UserManagementState> emit,
  ) async {
    emit(UserManagementLoading());
    try {
      await _deleteUser(event.userId);
      final users = await _getAllUsers();
      emit(UserManagementLoaded(users: users));
    } catch (e) {
      emit(UserManagementError(message: e.toString()));
    }
  }
}