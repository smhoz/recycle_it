import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/view/pages/register_page/register_body.dart';

import 'cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const RegisterBody(),
      ),
    );
  }
}
