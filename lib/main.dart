import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/core/init/notifier/provider_list.dart';
import 'package:provider/provider.dart';

import 'core/init/theme/app_theme.dart';
import 'core/navigation/navigation_manager.gr.dart';

void main() {
  runApp(MultiProvider(
    providers: ProviderList.instance.providerItems,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.instance.theme,
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        initialRoutes: [const SplashRoute()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
