import 'package:auto_route/auto_route.dart';
import 'package:kedis/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(
      page: MainRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoutes.page),
        AutoRoute(page: TimeRoute.page),
        AutoRoute(page: MenuRoute.page),
        AutoRoute(page: EvalutionRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
  ];
}
