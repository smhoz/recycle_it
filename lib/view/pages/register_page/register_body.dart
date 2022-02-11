import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/_custom_text_field.dart';
import '../../widgets/_print_message.dart';
import '../../widgets/_validators.dart';
import '../../widgets/_widget_const.dart';
import 'cubit/register_cubit.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registerpageCubit = context.read<RegisterCubit>();
    return Center(
      child: Form(
        key: _registerpageCubit.formKey,
        child: WC.paddingAll(
          child: Column(
            children: [
              CustomTextFormField(
                  labelText: "Name",
                  controller: _registerpageCubit.nameController),
              CustomTextFormField(
                  labelText: "Surname",
                  controller: _registerpageCubit.surnameController),
              CustomTextFormField(
                  labelText: "Mail",
                  customValidator: Validators.mailValidator,
                  controller: _registerpageCubit.mailController),
              CustomTextFormField(
                  labelText: "Password",
                  customValidator: Validators.passwordValidator,
                  obscureText: true,
                  controller: _registerpageCubit.passwordController),
              CustomTextFormField(
                  labelText: "Confirm Password",
                  obscureText: true,
                  customValidator: _registerpageCubit.confirmPasswordValidator,
                  controller: _registerpageCubit.confirmPassowrdController),
              const _SubmitButton()
            ],
          ),
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
        }else {
          PrintMessage.showSucces(context);
        }
      },
      child: ElevatedButton(
          onPressed: () => _registerpageCubit.formKey.currentState!.validate()
              ? _registerpageCubit.submit()
              : null,
          child: const Text("Submit")),
    );
  }
}
