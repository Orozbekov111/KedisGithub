import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/core/router/app_router.dart';
import 'package:kedis/core/router/app_router.gr.dart';
import 'package:kedis/features2/auth/data/datasources/firebase_auth_remote_data_source.dart';
import 'package:kedis/features2/auth/data/repositories/auth_repository_impl.dart';
import 'package:kedis/features2/auth/domain/repositories/auth_repository.dart';
import 'package:kedis/features2/auth/domain/usecases/is_authenticated_usecase.dart';
import 'package:kedis/features2/auth/domain/usecases/login_usecase.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_bloc.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_event.dart';
import 'package:kedis/features2/auth/presentation/bloc/auth_state.dart';
import 'package:kedis/features2/home/data/datasources/firebase_data_source.dart';
import 'package:kedis/features2/home/data/repositories/repository_impl.dart';
import 'package:kedis/features2/home/domain/repositories/get_users_repository.dart';
import 'package:kedis/features2/home/domain/usecases/get_active_students_usercase.dart';
import 'package:kedis/features2/home/domain/usecases/get_best_students_usecase.dart';
import 'package:kedis/features2/home/domain/usecases/get_current_user_usecase.dart';
import 'package:kedis/features2/home/domain/usecases/get_student_expelled_usecase.dart';
import 'package:kedis/features2/home/domain/usecases/get_teachers_usecase.dart';
import 'package:kedis/features2/home/domain/usecases/get_users_by_group_usecase.dart';
import 'package:kedis/features2/home/presentation/bloc/getActiveStudents/get_active_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getBestStudents/get_best_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getStudentsExpelled/get_best_students_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getTeachers/get_teachers_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/getUserByGroup/get_users_by_group_bloc.dart';
import 'package:kedis/features2/home/presentation/bloc/visitWebsite/visit_website_bloc.dart';
import 'package:kedis/features2/menu/create_a_schedule/data/datasources/create_schedule_firebase_data_source.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/repositories/create_schedule_repository.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/usecases/add_schedule_usecase.dart';
import 'package:kedis/features2/menu/create_a_schedule/domain/usecases/create_group_usecase.dart';
import 'package:kedis/features2/menu/create_a_schedule/presentation/bloc/group/group_bloc.dart';
import 'package:kedis/features2/menu/create_a_schedule/presentation/bloc/schedulle/schedule_bloc.dart';
import 'package:kedis/features2/menu/create_and_update_user/data/datasources/menu_firebase_user_data_source.dart';
import 'package:kedis/features2/menu/create_and_update_user/data/repositories_impl/menu_user_repository_impl.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/repositories/menu_user_repository.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_create_user_usecase.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_delete_user_usecase.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_get_all_users_usecase.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_get_current_user_usecase.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/usecases/menu_update_user_usecase.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/bloc/CurrentUser/current_user_bloc.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/bloc/UseManagement/user_management_block.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/bloc/UserCreate/user_create_bloc.dart';
import 'package:kedis/features2/profile/data/repositoies_impl/user_repo_impl.dart';
import 'package:kedis/features2/profile/domain/repositories/user_repository.dart';
import 'package:kedis/features2/profile/domain/usecases/change_password_usecase.dart';
import 'package:kedis/features2/profile/domain/usecases/get_user_usecase.dart';
import 'package:kedis/features2/profile/domain/usecases/sign_out_usecase.dart';
import 'package:kedis/features2/profile/presentation/bloc/bloc/user_bloc.dart';
import 'package:kedis/features2/time/data/datasourses/view_schedule_remote_data_source.dart';
import 'package:kedis/features2/time/data/repositories_impl/view_schedule_repository_impl.dart';
import 'package:kedis/features2/time/domain/repositories/view_schedule_repository.dart';
import 'package:kedis/features2/time/presentation/bloc/bloc/view_schedule_bloc.dart';
import 'package:kedis/features2/time/presentation/bloc/bloc/view_schedule_event.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features2/menu/create_a_schedule/data/repositories_impl/create_schedule_repository_impl.dart';
import 'features2/profile/data/datasources/firebase_user_data_source.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = AppRouter();

    return MultiBlocProvider(
      providers: [
        // Регистрируем зависимости для аутентификации
        Provider<FirebaseAuthRemoteDataSource>(
          create: (_) => FirebaseAuthRemoteDataSource(),
        ),
        Provider<AuthRepository>(
          create:
              (context) => AuthRepositoryImpl(
                remoteDataSource: context.read<FirebaseAuthRemoteDataSource>(),
              ),
        ),
        Provider<LoginUseCase>(
          create:
              (context) =>
                  LoginUseCase(repository: context.read<AuthRepository>()),
        ),
        Provider<IsAuthenticatedUsecase>(
          create:
              (context) => IsAuthenticatedUsecase(
                authRepository: context.read<AuthRepository>(),
              ),
        ),

        BlocProvider<AuthBloc>(
          create:
              (context) => AuthBloc(
                loginUseCase: context.read<LoginUseCase>(),
                isAuthenticatedUsecase: context.read<IsAuthenticatedUsecase>(),
              )..add(CheckAuthEvent()),
        ),

        // Регистрируем зависимости для профиля пользователя
        Provider<FirebaseUserDataSource>(
          create: (_) => FirebaseUserDataSource(),
        ),
        Provider<UserRepository>(
          create:
              (context) => UserRepositoryImpl(
                dataSource: context.read<FirebaseUserDataSource>(),
              ),
        ),
        Provider<GetUserUseCase>(
          create: (context) => GetUserUseCase(context.read<UserRepository>()),
        ),
        Provider<SignOutUseCase>(
          create: (context) => SignOutUseCase(context.read<UserRepository>()),
        ),
        Provider<ChangePasswordUseCase>(
          create:
              (context) =>
                  ChangePasswordUseCase(context.read<UserRepository>()),
        ),
        BlocProvider<UserBloc>(
          create:
              (context) => UserBloc(
                getUserUseCase: context.read<GetUserUseCase>(),
                signOutUseCase: context.read<SignOutUseCase>(),
                changePasswordUseCase: context.read<ChangePasswordUseCase>(),
              ),
        ),



        // Регистрируем зависимости для домашнего экрана
        Provider<FirebaseGetDataSource>(create: (_) => FirebaseGetDataSource()),
        Provider<GetUsersRepository>(
          create:
              (context) => GetRepositoryImpl(
                dataSource: context.read<FirebaseGetDataSource>(),
              ),
        ),
        // Для получения своей группы
        Provider<GetCurrentUserUseCase>(
          create:
              (context) =>
                  GetCurrentUserUseCase(context.read<GetUsersRepository>()),
        ),

        Provider<GetUsersByGroupUseCase>(
          create:
              (context) =>
                  GetUsersByGroupUseCase(context.read<GetUsersRepository>()),
        ),

        BlocProvider<GroupUsersBloc>(
          create:
              (context) => GroupUsersBloc(
                getCurrentUserUseCase: context.read<GetCurrentUserUseCase>(),
                getUsersByGroupUseCase: context.read<GetUsersByGroupUseCase>(),
              ),
        ),

        // Для получения преподавателей
        Provider<GetTeachersUseCase>(
          create:
              (context) =>
                  GetTeachersUseCase(context.read<GetUsersRepository>()),
        ),
        BlocProvider<TeachersBloc>(
          create:
              (context) => TeachersBloc(
                getTeachersUseCase: context.read<GetTeachersUseCase>(),
              ),
        ),

        // Для получения активных студентов
        Provider<GetActiveStudentsUserCase>(
          create:
              (context) =>
                  GetActiveStudentsUserCase(context.read<GetUsersRepository>()),
        ),

        BlocProvider(
          create:
              (context) => GetActiveStudentsBloc(
                getActiveStudentsUserCase:
                    context.read<GetActiveStudentsUserCase>(),
              ),
        ),

        // Для получения лучших студентов
        Provider<GetBestStudentsUsecase>(
          create:
              (context) =>
                  GetBestStudentsUsecase(context.read<GetUsersRepository>()),
        ),

        BlocProvider(
          create:
              (context) => GetBestStudentsBloc(
                getBestStudentsUsecase: context.read<GetBestStudentsUsecase>(),
              ),
        ),

        // Для получения студентов на отчисление
        Provider<GetStudentsExpelledUsecase>(
          create:
              (context) => GetStudentsExpelledUsecase(
                context.read<GetUsersRepository>(),
              ),
        ),

        BlocProvider(
          create:
              (context) => GetStudentsExpelledBloc(
                getStudentsExpelledUsecase:
                    context.read<GetStudentsExpelledUsecase>(),
              ),
        ),

        // Для перехода на сайт
        BlocProvider(create: (context) => VisitWebsiteBloc()),

        // Для создания нового пользователя
        Provider<MenuFirebaseUserDataSource>(
          create: (_) => MenuFirebaseUserDataSource(),
        ),
        Provider<MenuUserRepository>(
          create:
              (context) => MenuUserRepositoryImpl(
                context.read<MenuFirebaseUserDataSource>(),
              ),
        ),
        Provider<MenuGetCurrentUserUsecase>(
          create:
              (context) =>
                  MenuGetCurrentUserUsecase(context.read<MenuUserRepository>()),
        ),
        Provider<MenuCreateUserUsecase>(
          create:
              (context) =>
                  MenuCreateUserUsecase(context.read<MenuUserRepository>()),
        ),

        // Блок для получения текущего пользователя
        BlocProvider(
          create:
              (context) => CurrentUserBloc(
                getCurrentUser: context.read<MenuGetCurrentUserUsecase>(),
              )..add(GetCurrentUserEvent()), // Загружаем пользователя сразу
        ),
        // Блок для создания пользователя
        BlocProvider(
          create:
              (context) => UserCreateBloc(
                createUser: context.read<MenuCreateUserUsecase>(),
              ),
        ),

        // Блок для изменения пользователя
        BlocProvider(
          create:
              (context) => UserManagementBloc(
                getAllUsers: MenuGetAllUsersUsecase(
                  MenuUserRepositoryImpl(MenuFirebaseUserDataSource()),
                ),
                updateUser: MenuUpdateUserUsecase(
                  MenuUserRepositoryImpl(MenuFirebaseUserDataSource()),
                ),
                deleteUser: MenuDeleteUserUsecase(
                  MenuUserRepositoryImpl(MenuFirebaseUserDataSource()),
                ),
              )..add(LoadUsersEvent()),
        ),// Блок для создания расписания
// Data Sources
Provider<CreateScheduleFirebaseDataSource>(
  create: (_) => CreateScheduleFirebaseDataSource(),
),

// Repositories
Provider<CreateScheduleRepository>(
  create: (context) => CreateScheduleRepositoryImpl(
    firestoreDataSource: context.read<CreateScheduleFirebaseDataSource>(),
  ),
),

// Use Cases
Provider<AddScheduleUsecase>(
  create: (context) => AddScheduleUsecase(
   context.read<CreateScheduleRepository>(),
  ),
),

Provider<CreateGroupUsecase>(
  create: (context) => CreateGroupUsecase(
   context.read<CreateScheduleRepository>(),
  ),
),


// BLoCs
BlocProvider<GroupBloc>(
  create: (context) => GroupBloc(
    createGroup: context.read<CreateGroupUsecase>(),
  ),
),

BlocProvider<ScheduleBloc>(
  create: (context) => ScheduleBloc(
    addSchedule: context.read<AddScheduleUsecase>(),
    groupId: 'default',
    dayOfWeek: 'monday',
  ),
),

 // Блок для просмотра расписания
        Provider<ViewScheduleRemoteDataSource>(
          create: (_) => ViewScheduleRemoteDataSource(),
        ),
        Provider<ViewScheduleRepositoryImpl>(
          create:
              (context) => ViewScheduleRepositoryImpl(
                context.read<ViewScheduleRemoteDataSource>(),
              ),
        ),

        // BlocProvider(
        //   create:
        //       (context) =>
        //           ViewScheduleBloc(context.read<ViewScheduleRepositoryImpl>())
        //             ..add(ViewLoadScheduleEvent()),
        // ),
        BlocProvider(
  create: (context) => ViewScheduleBloc(
    repository: context.read<ViewScheduleRepositoryImpl>(),
    firestore: FirebaseFirestore.instance,
  )..add(ViewLoadScheduleEvent(),),),
      ],
      child: MaterialApp.router(
        routerConfig: router.config(), // Используем routerConfig
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                // Переход на главный экран после успешной аутентификации
                router.replace(const MainRoute());
              } else {
                // Переход на экран входа, если пользователь не аутентифицирован
                router.replace(const LoginRoute());
              }
            },
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
