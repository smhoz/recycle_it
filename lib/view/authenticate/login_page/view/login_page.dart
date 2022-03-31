import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';

import '../viewmodel/cubit/login_cubit.dart';
import 'login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeColor.primary,
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: const SafeArea(child: LoginBody()),
      ),
    );
  }
}
