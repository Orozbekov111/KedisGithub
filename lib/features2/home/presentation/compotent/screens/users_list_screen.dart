import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/features2/home/domain/entities/user_entity.dart';
import 'package:kedis/features2/home/presentation/bloc/getActiveStudents/get_active_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getBestStudents/get_best_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getStudentsExpelled/get_best_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getTeachers/get_teachers_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getUserByGroup/get_users_by_group_bloc.dart';
import 'package:kedis/features2/home/presentation/compotent/widgets/my_error_widget.dart';
import 'package:kedis/core/widgets/my_user_card_widget.dart';
import 'package:kedis/features2/home/presentation/compotent/widgets/user_type.dart';

class UsersListScreen extends StatelessWidget {
  final String title;
  final UserType userType;

  const UsersListScreen({
    super.key,
    required this.title,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),

        child: MyAppBarWidget(
          nameAppBar: title,
          icon: IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed:
                () => context.read<GroupUsersBloc>().add(LoadGroupUsersEvent()),
          ),
        ),
      ),
      body: _buildContentByUserType(context),
    );
  }

  Widget _buildContentByUserType(BuildContext context) {
    switch (userType) {
      case UserType.myGroup:
        return BlocBuilder<GroupUsersBloc, GroupUsersState>(
          builder: (context, state) => _handleGroupState(context, state),
        );
      case UserType.teachers:
        return BlocBuilder<TeachersBloc, TeachersState>(
          builder: (context, state) => _handleTeachersState(context, state),
        );
      case UserType.activeStudents:
        return BlocBuilder<GetActiveStudentsBloc, ActiveStudentsState>(
          builder: (context, state) => _handleActiveStudents(context, state),
        );
      case UserType.bestStudents:
        return BlocBuilder<GetBestStudentsBloc, GetBestStudentsState>(
          builder: (context, state) => _handleBestStudents(context, state),
        );
      case UserType.studentExpelled:
        return BlocBuilder<GetStudentsExpelledBloc, GetStudentsExpelledState>(
          builder: (context, state) => _handleStudentsExpelled(context, state),
        );
    }
  }

  Widget _handleGroupState(BuildContext context, GroupUsersState state) {
    if (state is GroupUsersLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is GroupUsersErrorState) {
      return MyErrorWidget(message: state.message);
    }
    if (state is GroupUsersLoadedState) {
      return _GroupContent(users: state.users);
    }
    // Добавляем обработку начального состояния
    return const Center(child: CircularProgressIndicator());
  }

  Widget _handleTeachersState(BuildContext context, TeachersState state) {
    if (state is TeachersLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is TeachersErrorState) {
      return MyErrorWidget(message: state.message);
    }
    if (state is TeachersLoadedState) {
      return _GroupContent(users: state.teachers);
    }
    // Добавляем обработку начального состояния
    return const Center(child: CircularProgressIndicator());
  }

  Widget _handleActiveStudents(
    BuildContext context,
    ActiveStudentsState state,
  ) {
    if (state is ActiveStudentsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is ActiveStudentsErrorState) {
      return MyErrorWidget(message: state.message);
    }
    if (state is ActiveStudentsLoadedState) {
      return _GroupContent(users: state.activeStudents);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _handleBestStudents(BuildContext context, GetBestStudentsState state) {
    if (state is GetBestStudentsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is GetBestStudentsErrorState) {
      return MyErrorWidget(message: state.message);
    }
    if (state is GetBestStudentsLoadedState) {
      return _GroupContent(users: state.bestStudents);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _handleStudentsExpelled(
    BuildContext context,
    GetStudentsExpelledState state,
  ) {
    if (state is GetStudentsExpelledLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is GetStudentsExpelledErrorState) {
      return MyErrorWidget(message: state.message);
    }
    if (state is GetStudentsExpelledLoadedState) {
      return _GroupContent(users: state.studentsExpelled);
    }
    return const Center(child: CircularProgressIndicator());
  }
}

class _GroupContent extends StatelessWidget {
  final List<UserEntity> users;

  const _GroupContent({required this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: users.length,
            itemBuilder:
                (context, index) => MyUserCardWidget(user: users[index]),
          ),
        ),
      ],
    );
  }
}
