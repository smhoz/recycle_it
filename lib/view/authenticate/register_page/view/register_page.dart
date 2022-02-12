import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/view/authenticate/register_page/view/register_body.dart';

import '../viewmodel/cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const SafeArea(child: RegisterBody()),
      ),
    );
  }
}
