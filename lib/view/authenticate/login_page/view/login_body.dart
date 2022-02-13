import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/components/button/custom_rounded_button.dart';
import '../../../../core/components/text/input_field.dart';

import '../../../../core/commons/_print_message.dart';
import '../../../../core/commons/_validators.dart';
import '../../../../core/consts/navigation_const.dart';
import '../../../../core/view_model/bloc/auth_bloc.dart';
import '../viewmodel/cubit/login_cubit.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginpageCubit = context.read<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => current is LoginError,
      listener: (context, state) {
        if (state is LoginError) {
          PrintMessage.showFailed(context, state.errorMessage);
        }
      },
      child: form(_loginpageCubit),
    );
  }

  Form form(LoginCubit _loginpageCubit) {
    return Form(
      key: _loginpageCubit.formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _body(_loginpageCubit),
            _SignInButton(
              loginpageCubit: _loginpageCubit,
            ),
            _signUpButton()
          ],
        ),
      ),
    );
  }

  Column _signUpButton() {
    return Column(
      children: [
        const Text.rich(TextSpan(text: "Bir hesabın yok mu ?")),
        _SignUpButton(),
      ],
    );
  }

  Column _body(LoginCubit _loginpageCubit) {
    return Column(
      children: [
        InputField(
          icon: const Icon(Icons.email_outlined),
          title: "Email",
          validator: Validators.mailValidator,
          controller: _loginpageCubit.mailController,
        ),
        InputField(
          isPassword: true,
          validator: Validators.passwordValidator,
          icon: const Icon(Icons.password),
          title: "Şifre",
          controller: _loginpageCubit.passwordController,
        ),
      ],
    );
  }
}

class _SignInButton extends StatelessWidget {
  final LoginCubit loginpageCubit;

  const _SignInButton({
    Key? key,
    required this.loginpageCubit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return CustomRoundedButton(
              onTap: state
                      is LoginCompleted // Giriş başarılıysa buton pasife düşecek.
                  ? null
                  : () =>
                      loginpageCubit.formKey.currentState!.validate() == true
                          ? loginpageCubit
                              .signIn()
                              .then((value) => context
                                  .read<AuthBloc>()
                                  .add(AuthTryGetCurrentUser()))
                              .then((value) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            })
                          : null,
              title: "Giriş Yap");
        }
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () =>
            context.router.navigateNamed(RouteConsts.REGISTER_PAGE),
        child: Text(
          "Kayıt Ol",
          style: context.textTheme.bodyLarge!
              .copyWith(color: context.themeColor.primary),
        ));
  }
}
