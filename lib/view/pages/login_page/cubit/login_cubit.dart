import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/repository/auth_repository.dart';
import '../../../../core/utils/locator_get_it.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final AuthRepository _authRepository = getIt<AuthRepository>();

  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    emit(LoginLoading());
    bool _result = await _authRepository.signIn(
        mail: mailController.text, password: passwordController.text);
    if (_result) {
      emit(LoginCompleted());
    } else {
      emit(LoginError(errorMessage: _authRepository.errorMessage));
    }
  }

  @override
  Future<void> close() {
    mailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
