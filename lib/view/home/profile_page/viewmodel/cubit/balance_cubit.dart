import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/network/user_service.dart';
import '../../../../../core/repository/global_repositor.dart';
import '../../../../../core/utils/locator_get_it.dart';
import '../bloc/profile_bloc.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceInitial());

  final balanceController = TextEditingController(text: '20');

  int balanceValue = 20;
  void balanceIncrement() {
    balanceValue += 5;
    balanceController.text = balanceValue.toString();
  }

  void balanceDecrement() {
    if (balanceValue >= 5) {
      balanceValue -= 5;
      balanceController.text = balanceValue.toString();
    }
  }

  final cardNumberController = TextEditingController();
  final expireDateController = TextEditingController();
  final cvvController = TextEditingController();
  final cardHoldersNameController = TextEditingController();

  Future<bool> balanceUpdate() async {
    final _userDBService = UserService();
    final _user = getIt<GlobalRepository>().user;
    double _newBalance = balanceValue + double.parse(_user?.balance ?? "");
    bool _result = await _userDBService.updateBalance(
      uid: _user?.uid ?? "",
      balance: _newBalance.toString(),
    );
    _getUpdatedUser();
    return _result;
  }

  _getUpdatedUser() {
    getIt<ProfileBloc>().add(GetProfileUpdatedValues());
  }
}
