import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/view/pages/splash_page/cubit/splash_cubit.dart';

import '../../../core/consts/navigation_const.dart';
import '../../../core/view_model/bloc/auth_bloc.dart';
import '../login_page/login_page.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      buildWhen: (previous, current) => current != previous,
      builder: (context, state) {
        if (state is SplashInitial) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const AuthController();
        }
      },
    );
  }
}

class AuthController extends StatelessWidget {
  const AuthController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state is AuthUnauthenticated) {
              return const LoginPage();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              context.router.replaceNamed(RouteConsts.HOME_PAGE);
            }
          }),
    );
  }
}
