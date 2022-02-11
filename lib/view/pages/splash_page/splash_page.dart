import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/view/pages/splash_page/cubit/splash_cubit.dart';
import 'package:hackathon_app/view/pages/splash_page/splash_body.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (ctx) => SplashCubit(),
        child: const SplashBody(),
      ),
    );
  }
}
