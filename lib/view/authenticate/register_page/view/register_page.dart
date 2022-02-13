import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/core/components/appbar/transparent_app_bar.dart';

import '../viewmodel/cubit/register_cubit.dart';
import 'register_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const RegisterBody(),
      ),
    );
  }
}
