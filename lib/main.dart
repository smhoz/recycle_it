import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'core/navigation/navigation_manager.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        initialRoutes: [const SplashRoute()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
