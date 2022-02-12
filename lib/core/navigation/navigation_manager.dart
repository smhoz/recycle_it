import 'package:auto_route/auto_route.dart';

import '../../view/authenticate/login_page/view/login_page.dart';
import '../../view/authenticate/register_page/view/register_page.dart';
import '../../view/home/home_page/view/home_page.dart';
import '../../view/home/profile_page/view/wallet_page.dart';
import '../../view/home/splash_page/view/splash_body.dart';
import '../../view/home/splash_page/view/splash_page.dart';
import '../consts/navigation_const.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, path: RouteConsts.SPLASH_PAGE),
    AutoRoute(page: LoginPage, path: RouteConsts.LOGIN_PAGE),
    AutoRoute(page: HomePage, path: RouteConsts.HOME_PAGE),
    AutoRoute(page: RegisterPage, path: RouteConsts.REGISTER_PAGE),
    AutoRoute(page: WalletPage, path: RouteConsts.WALLET_PAGE),
    AutoRoute(
        page: AuthController,
        path: RouteConsts.AUTH_CONTROLLER,
        name: RouteConsts.AUTH_CONTROLLER_ROUTE),
  ],
)
class $AppRouter {}
