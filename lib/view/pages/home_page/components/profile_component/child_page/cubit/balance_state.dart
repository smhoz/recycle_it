part of 'balance_cubit.dart';

abstract class BalanceState extends Equatable {
  const BalanceState([this.value = 20]);
  final int value;
  @override
  List<Object> get props => [];
}

class BalanceInitial extends BalanceState {}

class BalanceChanged extends BalanceState {
  const BalanceChanged(int value) : super(value);
}
