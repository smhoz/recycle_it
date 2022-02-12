import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/core/components/button/custom_rounded_button.dart';
import 'package:hackathon_app/core/components/text/input_field.dart';

import '../../../widgets/_print_message.dart';
import '../../../widgets/_validators.dart';
import '../viewmodel/cubit/register_cubit.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registerpageCubit = context.read<RegisterCubit>();
    return Center(
      child: Form(
        key: _registerpageCubit.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(
              flex: 2,
            ),
            InputField(
                icon: const Icon(Icons.person),
                title: "Ad",
                controller: _registerpageCubit.nameController),
            InputField(
                icon: const Icon(Icons.person),
                title: "Soyad",
                controller: _registerpageCubit.surnameController),
            InputField(
                icon: const Icon(Icons.mail),
                title: "Email",
                validator: Validators.mailValidator,
                controller: _registerpageCubit.mailController),
            InputField(
                icon: const Icon(Icons.password),
                title: "Şifre",
                validator: Validators.passwordValidator,
                isPassword: true,
                controller: _registerpageCubit.passwordController),
            InputField(
                icon: const Icon(Icons.password),
                title: "Confirm Password",
                isPassword: true,
                validator: _registerpageCubit.confirmPasswordValidator,
                controller: _registerpageCubit.confirmPassowrdController),
            const Spacer(
              flex: 1,
            ),
            const _SubmitButton(),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registerpageCubit = context.read<RegisterCubit>();
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          PrintMessage.showFailed(context, state.errorMessage);
        } else {
          PrintMessage.showSucces(context);
        }
      },
      child: CustomRoundedButton(
          onTap: () => _registerpageCubit.formKey.currentState!.validate()
              ? _registerpageCubit.submit()
              : null,
          title: "Kayıt Ol"),
    );
  }
}
