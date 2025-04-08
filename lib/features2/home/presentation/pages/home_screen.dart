import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/core/widgets/my_button_widget.dart';
import 'package:kedis/features2/home/domain/usecases/get_student_expelled_usecase.dart';
import 'package:kedis/features2/home/presentation/bloc/getActiveStudents/get_active_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getBestStudents/get_best_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getStudentsExpelled/get_best_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getTeachers/get_teachers_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getUserByGroup/get_users_by_group_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/visitWebsite/visit_website_bloc.dart';
import 'package:kedis/features2/home/presentation/compotent/screens/users_list_screen.dart';
import 'package:kedis/features2/home/presentation/compotent/widgets/user_type.dart';

@RoutePage()
class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VisitWebsiteBloc()),
        BlocProvider(
          create:
              (context) => GetStudentsExpelledBloc(
                getStudentsExpelledUsecase:
                    context.read<GetStudentsExpelledUsecase>(),
              ),
        ),
      ],
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: MyAppBarWidget(nameAppBar: 'Главная меню'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                MyButtonWidget(
                  text: 'Моя группа',
                  pressed: () {
                    context.read<GroupUsersBloc>().add(LoadGroupUsersEvent());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const UsersListScreen(
                              title: 'Моя группа',
                              userType: UserType.myGroup,
                            ),
                      ),
                    );
                  },
                ),
                MyButtonWidget(
                  text: 'Преподаватели',
                  pressed: () {
                    context.read<TeachersBloc>().add(LoadTeachersEvent());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const UsersListScreen(
                              title: 'Преподаватели',
                              userType: UserType.teachers,
                            ),
                      ),
                    );
                  },
                ),
                MyButtonWidget(
                  text: 'Активные студенты',
                  pressed: () {
                    context.read<GetActiveStudentsBloc>().add(
                      LoadActiveStudentsEvent(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const UsersListScreen(
                              title: 'Активные студенты',
                              userType: UserType.activeStudents,
                            ),
                      ),
                    );
                  },
                ),
                MyButtonWidget(
                  text: 'Лучшие студенты',
                  pressed: () {
                    context.read<GetBestStudentsBloc>().add(
                      LoadBestStudentsEvent(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const UsersListScreen(
                              title: 'Лучшие студенты',
                              userType: UserType.bestStudents,
                            ),
                      ),
                    );
                  },
                ),
                MyButtonWidget(
                  text: 'Студенты на отчисление',
                  pressed: () {
                    context.read<GetStudentsExpelledBloc>().add(
                      LoadStudentsExpelledEvent(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const UsersListScreen(
                              title: 'Студенты на отчисление',
                              userType: UserType.studentExpelled,
                            ),
                      ),
                    );
                  },
                ),
                MyButtonWidget(
                  text: 'Основной сайт',
                  pressed: () {
                    context.read<VisitWebsiteBloc>().add(
                      LaunchWebsiteEvent('https://kedis.kg/'),
                    );
                  },
                ),
                const SizedBox(height: 162),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
