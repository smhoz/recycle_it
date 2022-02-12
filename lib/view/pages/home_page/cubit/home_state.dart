part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState(
    this.component, [
    this.index = 0,
  ]);
  final int index;
  final Widget component;
  @override
  List<Object> get props => [index];
}

class BottomInitial extends HomeState {
  const BottomInitial(Widget component) : super(component);
}

class HomeChanged extends HomeState {
  const HomeChanged(Widget component, int index) : super(component, index);
}
