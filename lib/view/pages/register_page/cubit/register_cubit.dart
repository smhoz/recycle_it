import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/core/repository/auth_repository.dart';

import '../../../../core/utils/locator_get_it.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final _authRepository = getIt<AuthRepository>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final mailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassowrdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    emit(RegisterLoading());
    bool _result = await _authRepository.signUp(
        name: nameController.text,
        surname: surnameController.text,
        mail: mailController.text,
        password: passwordController.text);
    if (_result) {
      emit(RegisterCompleted());
    } else {
      emit(RegisterError(errorMessage: _authRepository.errorMessage));
    }
  }

  String? confirmPasswordValidator(String? value) {
    if (value != null && value.isEmpty) {
      return 'Empty field';
    } else if (value != passwordController.text) {
      return 'Not matched';
    } else {
      return null;
    }
  }
}
