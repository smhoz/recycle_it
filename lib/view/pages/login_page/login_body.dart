import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/view/pages/login_page/cubit/login_cubit.dart';
import 'package:hackathon_app/view/widgets/_custom_text_field.dart';
import 'package:hackathon_app/view/widgets/_print_message.dart';

import '../../../core/consts/navigation_const.dart';
import '../../../core/view_model/bloc/auth_bloc.dart';
import '../../widgets/_validators.dart';
import '../../widgets/_widget_const.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  final _transparentDivider = WC.tpDivider;
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
      child: WC.paddingAll(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _Head(),
                _transparentDivider,
                CustomTextFormField(
                  customValidator: Validators.mailValidator,
                  controller: _loginpageCubit.mailController,
                ),
                _transparentDivider,
                CustomTextFormField(
                  obscureText: true,
                  customValidator: Validators.passwordValidator,
                  controller: _loginpageCubit.passwordController,
                ),
                _transparentDivider,
                _SignInButton(
                  loginpageCubit: _loginpageCubit,
                ),
                _transparentDivider,
                _SignUpButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Head extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FlutterLogo(size: 72),
        Text(
          "Login",
          style: Theme.of(context).textTheme.headline5,
        )
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
          return ElevatedButton(
              onPressed: state
                      is LoginCompleted // Giriş başarılıysa buton pasife düşecek.
                  ? null
                  : () => loginpageCubit.formKey.currentState!.validate() ==
                          true
                      ? loginpageCubit.signIn().then((value) =>
                          context.read<AuthBloc>().add(AuthTryGetCurrentUser()))
                      : null,
              child: const Text("Sıgn In"));
        }
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () =>
            context.router.navigateNamed(RouteConsts.REGISTER_PAGE),
        child: const Text("Sıgn Up"));
  }
}
