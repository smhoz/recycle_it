import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/core/components/sizedbox/page_sized_box.dart';
import 'package:hackathon_app/view/home/_product/widgets/home/title_with_child.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/navigation/navigation_manager.gr.dart';
import '../../../../core/components/button/custom_rounded_button.dart';
import '../../../../core/components/text/input_field.dart';

import '../../../../core/commons/_print_message.dart';
import '../../../../core/commons/_validators.dart';
import '../viewmodel/cubit/register_cubit.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registerpageCubit = context.read<RegisterCubit>();
    return HeaderTitleWithChild(
      title: "Sign Up",
      child: Form(
        key: _registerpageCubit.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_inputFields(context, _registerpageCubit), _signInButton()],
        ),
      ),
    );
  }

  Widget _inputFields(BuildContext context, RegisterCubit _registerpageCubit) {
    return Column(
      children: [
        const PageSizedBox.normalHeightSizedBox(),
        InputField(icon: const Icon(Icons.person), title: "Name", controller: _registerpageCubit.nameController),
        InputField(icon: const Icon(Icons.person), title: "Surname", controller: _registerpageCubit.surnameController),
        InputField(icon: const Icon(Icons.mail), title: "Email", validator: Validators.mailValidator, controller: _registerpageCubit.mailController),
        InputField(
            icon: const Icon(Icons.password),
            title: "Password",
            validator: Validators.passwordValidator,
            isPassword: true,
            controller: _registerpageCubit.passwordController),
        InputField(
            icon: const Icon(Icons.password),
            title: "Confirm Password",
            isPassword: true,
            validator: _registerpageCubit.confirmPasswordValidator,
            controller: _registerpageCubit.confirmPassowrdController),
        const _SubmitButton(),
      ],
    );
  }

  Column _signInButton() {
    return Column(
      children: [
        const Text.rich(TextSpan(text: "Already have an account?")),
        _SignInButton(),
      ],
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => context.router.pop(),
        child: Text(
          "Sign In",
          style: context.textTheme.bodyLarge?.copyWith(color: context.themeColor.primary),
        ));
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registerpageCubit = context.read<RegisterCubit>();
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) => current is RegisterError || current is RegisterCompleted,
      listener: (context, state) async {
        if (state is RegisterError) {
          PrintMessage.showFailed(context, message: state.errorMessage);
        } else {
          PrintMessage.showSucces(context);
          context.router.replace(const AuthControllerRoute());
        }
      },
      child: CustomRoundedButton(
          onTap: () => _registerpageCubit.formKey.currentState!.validate() ? _registerpageCubit.submit() : null, title: "Sign Up"),
    );
  }
}
