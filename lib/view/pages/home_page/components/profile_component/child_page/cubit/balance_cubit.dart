import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceInitial());

  final balanceController = TextEditingController(text: '20');

  int balanceValue = 20;
  void balanceIncrement() {
    balanceValue += 5;
    balanceController.text = balanceValue.toString();
    emit(BalanceChanged(balanceValue));
  }

  void balanceDecrement() {
    if (balanceValue >= 5) {
      balanceValue -= 5;
      balanceController.text = balanceValue.toString();
      emit(BalanceChanged(balanceValue));
    }
  }

  final cardNumberController = TextEditingController();
  final expireDateController = TextEditingController();
  final cvvController = TextEditingController();
  final cardHoldersNameController = TextEditingController();
}
