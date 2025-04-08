// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:kedis/features2/auth/presentation/pages/auth_screen.dart'
    as _i3;
import 'package:kedis/features2/evalution/presentation/pages/evalution_screen.dart'
    as _i1;
import 'package:kedis/features2/home/presentation/pages/home_screen.dart'
    as _i2;
import 'package:kedis/features2/main_screen.dart'
    as _i4;
import 'package:kedis/features2/menu/menu_screen.dart'
    as _i5;
import 'package:kedis/features2/profile/presentation/pages/profile_screen.dart'
    as _i6;
import 'package:kedis/features2/time/presentation/pages/schedule_screen.dart'
    as _i7;

/// generated route for
/// [_i1.EvalutionScreen]
class EvalutionRoute extends _i8.PageRouteInfo<void> {
  const EvalutionRoute({List<_i8.PageRouteInfo>? children})
    : super(EvalutionRoute.name, initialChildren: children);

  static const String name = 'EvalutionRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.EvalutionScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreens]
class HomeRoutes extends _i8.PageRouteInfo<void> {
  const HomeRoutes({List<_i8.PageRouteInfo>? children})
    : super(HomeRoutes.name, initialChildren: children);

  static const String name = 'HomeRoutes';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreens();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.MenuScreen]
class MenuRoute extends _i8.PageRouteInfo<void> {
  const MenuRoute({List<_i8.PageRouteInfo>? children})
    : super(MenuRoute.name, initialChildren: children);

  static const String name = 'MenuRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.MenuScreen();
    },
  );
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i6.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i7.ScheduleScreen]
class ScheduleRoute extends _i8.PageRouteInfo<void> {
  const ScheduleRoute({List<_i8.PageRouteInfo>? children})
    : super(ScheduleRoute.name, initialChildren: children);

  static const String name = 'TimeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.ScheduleScreen();
    },
  );
}
