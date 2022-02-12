import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/user_model.dart';
import '../../../../../../../core/repository/auth_repository.dart';
import '../../../../../../../core/repository/global_repositor.dart';
import '../../../../../../../core/utils/locator_get_it.dart';
import '../bloc/profile_bloc.dart';

part 'profileform_state.dart';

class ProfileformCubit extends Cubit<ProfileformState> {
  ProfileformCubit() : super(ProfileformInitial());
  final User _user = getIt<GlobalRepository>().user!;
  final _authRepo = getIt<AuthRepository>();

  late TextEditingController nameController =
      TextEditingController(text: _user.name);
  late TextEditingController surnameController =
      TextEditingController(text: _user.surname);
  late TextEditingController mailController =
      TextEditingController(text: _user.mail);
  final formKey = GlobalKey<FormState>();

  bool get _checkField {
    // Eğer hiç bir alanı değiştirmemişse false dönecek
    if (nameController.text.trim() == _user.name &&
        surnameController.text.trim() == _user.surname &&
        mailController.text.trim() == _user.mail) {
      return false;
    } else {
      return true;
    }
  }

  onFieldChanged(String? value) {
    if (_checkField) {
      emit(ProfileformButtonActive());
    } else {
      emit(ProfileformButtonPassive());
    }
  }

  update() async {
    if (formKey.currentState!.validate() && _checkField) {
      emit(ProfileformLoading());
      bool _result = await _authRepo.updateUserData(
          uid: _user.uid ?? "",
          mail: mailController.text.trim(),
          name: nameController.text.trim(),
          surname: surnameController.text.trim());
      if (_result) {
        _getUpdatedUser();
        emit(ProfileformCompleted());
      } else {
        emit(ProfileformError(errorMessage: _authRepo.errorMessage));
      }
    }
  }

  Future<void> _getUpdatedUser() async {
    getIt<ProfileBloc>().add(GetProfileUpdatedValues());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    surnameController.dispose();
    mailController.dispose();
    return super.close();
  }
}
