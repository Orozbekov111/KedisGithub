import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';
import 'package:kedis/features2/profile/presentation/bloc/bloc/user_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  final String userId;

  ProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(context.read<GetUserUseCase>())..add(LoadUserEvent(userId)),
      child: Scaffold(
        appBar: AppBar(title: Text('User Details')),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoadedState) {
              final user = state.user;
              return Column(
                children: [
                  Text('Full Name: ${user.fullName}'),
                  Text('Email: ${user.email}'),
                  Text('Phone: ${user.phone}'),
                  // Другие поля пользователя
                ],
              );
            } else if (state is UserErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}