import 'package:auto_route/auto_route.dart';
import 'package:hackathon_app/view/pages/splash_page/splash_body.dart';

import '../../view/pages/home_page/view/home_page.dart';
import '../../view/pages/login_page/login_page.dart';
import '../../view/pages/register_page/register_page.dart';
import '../../view/pages/splash_page/splash_page.dart';
import '../consts/navigation_const.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, path: RouteConsts.SPLASH_PAGE),
    AutoRoute(page: LoginPage, path: RouteConsts.LOGIN_PAGE),
    AutoRoute(page: HomePage, path: RouteConsts.HOME_PAGE),
    AutoRoute(page: RegisterPage, path: RouteConsts.REGISTER_PAGE),
    AutoRoute(
        page: AuthController,
        path: RouteConsts.AUTH_CONTROLLER,
        name: RouteConsts.AUTH_CONTROLLER_ROUTE),
  ],
)
class $AppRouter {}
